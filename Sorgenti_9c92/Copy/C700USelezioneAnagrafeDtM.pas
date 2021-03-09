unit C700USelezioneAnagrafeDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  Db, Comctrls, CheckLst, OracleData, Oracle, Variants,
  USelI010;

type
  TC700FSelezioneAnagrafeDtM = class(TDataModule)
    dscAnagrafe: TDataSource;
    selAnagrafe: TOracleDataSet;
    selT003Nome: TOracleDataSet;
    delT003: TOracleQuery;
    insT003: TOracleQuery;
    selT003: TOracleDataSet;
    selDistinct: TOracleDataSet;
    selbT033: TOracleDataSet;
    procedure selAnagrafeAfterOpen(DataSet: TDataSet);
    procedure DataModule2Create(Sender: TObject);
    procedure selAnagrafeAfterScroll(DataSet: TDataSet);
    procedure CaricaTVAzienda(Completa:Boolean);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    QCols:TselI010;
    procedure ApplicaFiltroAnagrafe(lst:TStringList);
  public
    { Public declarations }
    C700Matricola:String;
    FElaborazioneInterrompibile:Boolean;
    procedure GetNomeSelezioni;
    procedure OpenSelAnagrafe;
  end;

var
  C700FSelezioneAnagrafeDtM: TC700FSelezioneAnagrafeDtM;

implementation

uses C700USelezioneAnagrafe;

{$R *.DFM}

procedure TC700FSelezioneAnagrafeDtM.DataModule2Create(Sender: TObject);
{Creo la lista di campi nella TreeView}
var i:Integer;
    S,HintUnnest:String;
begin
  QCols:=TselI010.Create(Self);
  QCols.Apri(C700FSelezioneAnagrafe.DataBase,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,DATA_TYPE,NOME_LOGICO,RICERCA','','RICERCA,NOME_LOGICO');
  //Inizializzazione struttura anagrafica se non uso C700 in A002
  if Parametri.ColonneStruttura.Count = 0 then
  begin
    Parametri.ColonneStruttura.Clear;
    Parametri.TipiStruttura.Clear;
    while not QCols.Eof do
    begin
      Parametri.ColonneStruttura.Add(Format('%s=%s',[QCols.FieldByName('NOME_LOGICO').AsString,QCols.FieldByName('NOME_CAMPO').AsString]));
      if QCols.FieldByName('DATA_TYPE').AsString = 'VARCHAR2' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftString)))
      else if QCols.FieldByName('DATA_TYPE').AsString = 'NUMBER' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftInteger)))
      else if QCols.FieldByName('DATA_TYPE').AsString = 'DATE' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftDateTime)));
      QCols.Next;
    end;
  end;
  with C700FSelezioneAnagrafe do
  begin
    selT003Nome.Session:=DataBase;
    selT003.Session:=DataBase;
    delT003.Session:=DataBase;
    insT003.Session:=DataBase;
    selbT033.Session:=DataBase;
    selbT033.SetVariable('NOME',Parametri.Layout);
    selbT033.Open;
    // se il layout non è presente tenta con "DEFAULT"
    // nota: l'azienda scelta potrebbe essere differente da quella del login iniziale
    if selbT033.RecordCount = 0 then
    begin
      selbT033.Close;
      selbT033.SetVariable('NOME','DEFAULT');
      selbT033.Open;
    end;
    //Alberto 04/09/2006: registrazione dei campi anagrafici non visibili da Layout per disabilitarli nelle altre funzioni (Generatore di stampe)
    Parametri.CampiAnagraficiNonVisibili:=',';
    QCols.First;
    while not QCols.Eof do
    begin
      S:=QCols.FieldByName('NOME_CAMPO').AsString;
      if Copy(S,1,6) = 'T430D_' then
        S:=Copy(S,7,Length(S))
      else if Copy(S,1,4) = 'T430' then
        S:=Copy(S,5,Length(S));
      if (Copy(S,1,4) <> 'P430') and
         (S <> 'PROGRESSIVO') and
         (S <> 'DATADECORRENZA') and
         (S <> 'DATAFINE') then
      begin
        if (S <> 'COMUNENAS') and (not selbT033.SearchRecord('CAMPODB',S,[srFromBeginning])) then
          Parametri.CampiAnagraficiNonVisibili:=Parametri.CampiAnagraficiNonVisibili + QCols.FieldByName('NOME_CAMPO').AsString + ',';
        if (S = 'COMUNENAS') and (not selbT033.SearchRecord('CAMPODB','CITTA',[srFromBeginning,srIgnoreCase])) then
          Parametri.CampiAnagraficiNonVisibili:=Parametri.CampiAnagraficiNonVisibili + QCols.FieldByName('NOME_CAMPO').AsString + ',';
      end;
      QCols.Next;
    end;
    if (Pos('T430D_TIPOCART',Parametri.CampiAnagraficiNonVisibili) > 0) and
       (Pos('T430PERSELASTICO',Parametri.CampiAnagraficiNonVisibili) = 0) then
      Parametri.CampiAnagraficiNonVisibili:=StringReplace(Parametri.CampiAnagraficiNonVisibili,',T430D_TIPOCART,',',',[]);
    GetNomeSelezioni;
    CaricaTVAzienda(False);
    selAnagrafe.Session:=DataBase;
    //selAnagrafePreview.Session:=DataBase;
    selDistinct.CloseAll;
    selDistinct.Session:=DataBase;
    //Creazione struttura della Query alla DataLavoro
    ListSQL.Text:=QVistaOracle;
    ListSQL.Insert(0,Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
    //Leggo le inbizioni
    ApplicaFiltroAnagrafe(ListSQL);
    (*
    with Parametri.Inibizioni do
      if Count > 0 then
        if Strings[0] <> '' then
        begin
          ListSQL.Add('AND');
          for i:=0 to Count - 1 do
            ListSQL.Add(Strings[i]);
        end;
    *)
    //Creazione struttura della Query da DataDal a DataLavoro
    ListSQLPeriodico.Clear;
    ListSQLPeriodico.Add(Format('SELECT %s %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,C700DatiSelezionati]));
    ListSQLPeriodico.Add(QVistaOracle);
    ListSQLPeriodico.Add('AND T030.PROGRESSIVO IN (');
    // utilizzo hint "unnest" - daniloc. 22.11.2010
    // nota: la distinct è stata rimossa dopo alcune verifiche statistiche sui tempi di esecuzione
    //ListSQLPeriodico.Add('  SELECT DISTINCT PROGRESSIVO FROM');
    HintUnnest:='/*+ HintT030V430 UNNEST */';
    ListSQLPeriodico.Add(Format('  SELECT %s PROGRESSIVO FROM',[HintUnnest]));
    // utilizzo hint "unnest".fine
    S:=StringReplace(QVistaOracle,':DATALAVORO BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                                  ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                                  [rfIgnoreCase]);
    {P430}
    if Parametri.V430 = 'P430' then
      S:=StringReplace(S,':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                         ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                         [rfIgnoreCase]);
    ListSQLPeriodico.Add(S);
    //Leggo le inibizioni
    ApplicaFiltroAnagrafe(ListSQLPeriodico);
    (*
    with Parametri.Inibizioni do
      if Count > 0 then
        if Strings[0] <> '' then
        begin
          ListSQLPeriodico.Add('AND');
          for i:=0 to Count - 1 do
            ListSQLPeriodico.Add(Strings[i]);
        end;
    *)
    ListSQLPeriodico.Add(':C700FILTRO)');
  end;
  QCols.Close;
  FElaborazioneInterrompibile:=False;
end;

procedure TC700FSelezioneAnagrafeDtM.ApplicaFiltroAnagrafe(lst:TStringList);
var i:Integer;
    FiltroAnagrafe:TStringList;
    FiltroT722,s:String;
  function EsisteCampo(Campo:String):Boolean;
  var i:Integer;
  begin
    Result:=False;
    for i:=0 to High (C700FSelezioneAnagrafe.SelezioneFull) do
      if UpperCase(C700FSelezioneAnagrafe.SelezioneFull[i].NomeCampo) = UpperCase(Campo) then
      begin
        Result:=True;
        Break;
      end;
  end;
begin
  FiltroAnagrafe:=TStringList.Create;
  FiltroAnagrafe.Text:=Parametri.Inibizioni.Text;

  (*NON PIU' UTILIZZATO?*)
  //.ini Alberto 21/11/2013: gestione del filtro modificato per la gestione degli eventi speciali per il Comune di Torino
  if (Trim(Parametri.Inibizioni.Text) <> '') and
     (Pos('T030.',UpperCase(Parametri.Inibizioni.Text)) = 0) and
     (Pos('MATRICOLA',UpperCase(Parametri.Inibizioni.Text)) = 0) and
     (Pos('COGNOME',UpperCase(Parametri.Inibizioni.Text)) = 0) and
     (Parametri.ModuloInstallato['TORINO_CSI']) and
     (Parametri.CodiceIntegrazione = 'TO')  and
     R180In(C700Chiamante,['A023','A025','A062','A077','A091','A152','A153']) and
     EsisteCampo('T430' + TORINO_COMUNE_STRUTT_EVENTI_STR) then
  begin
    FiltroT722:='  T430PROGRESSIVO in' + #13#10 +
                '    (select T724.PROGRESSIVO' + #13#10 +
                '     from T724_EVENTI_STR_INDIVIDUALI T724, T722_PERIODI_EVENTI_STR T722' + #13#10 +
                '     where T724.ID = T722.ID and T722.STATO = ''A''' + #13#10 +
                '     and exists (select ''x'' from T430_STORICO T430x' + #13#10 +
                '                 where T724.AL BETWEEN DATADECORRENZA and DATAFINE' + #13#10 +
                '                 and instr('',''||T724.SERVIZI||'','','',''||T430x.%s||'','') > 0' + #13#10 +
                '                 and (%s)' + #13#10 +
                '     ))' + #13#10;
    FiltroT722:=Format(FiltroT722,[TORINO_COMUNE_STRUTT_EVENTI_STR,StringReplace(Parametri.Inibizioni.Text,'V430.T430','T430x.',[rfReplaceAll,rfIgnoreCase])]);
    FiltroAnagrafe.Text:=Format('((%s) or %s)',[Parametri.Inibizioni.Text,FiltroT722]);
  end;
  //.fine
  (**)

  try
    with FiltroAnagrafe do
      if Count > 0 then
        if Strings[0] <> '' then
        begin
          lst.Add('AND');
          for i:=0 to Count - 1 do
            lst.Add(Strings[i]);
        end;
  finally
    FiltroAnagrafe.Free;
  end;
end;

procedure TC700FSelezioneAnagrafeDtM.CaricaTVAzienda(Completa:Boolean);
var j:Integer;
    P:PSelezione;
    S:String;
    SelezioneFullVuota:Boolean;
begin
  with C700FSelezioneAnagrafe do
  begin
    SelezioneFullVuota:=Length(SelezioneFull) = 0;
    PulisciListe;
    TVAzienda.OnChange:=nil;
    TVAzienda.Items.BeginUpdate;
    TVAzienda.Items.Clear;
    QCols.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    QCols.Open;
    QCols.First;
    while not QCols.Eof do
    begin
      if Completa or ((not QCols.FieldByName('RICERCA').IsNull) and (QCols.FieldByName('RICERCA').AsInteger >= 0)) then
      begin
        S:=QCols.FieldByName('NOME_CAMPO').AsString;
        if Copy(S,1,6) = 'T430D_' then
          S:=Copy(S,7,Length(S))
        else if Copy(S,1,4) = 'T430' then
          S:=Copy(S,5,Length(S));
        if (Copy(S,1,4) = 'P430') or (S = 'PROGRESSIVO') or
           ((selbT033.RecordCount = 0) or
            (selbT033.SearchRecord('CAMPODB',VarArrayOf([S]),[srFromBeginning]))) then
        begin
          TVAzienda.Items.Add(nil,QCols.FieldByName('NOME_LOGICO').AsString);
          New(P);
          j:=Componenti.Add(P);
          PSelezione(Componenti.Items[j]).DaValore:='';
          PSelezione(Componenti.Items[j]).AValore:='';
          PSelezione(Componenti.Items[j]).TotValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).SelValori:=TStringList.Create;
          PSelezione(Componenti.Items[j]).Esistente:=False;
        end;
      end;
      if SelezioneFullVuota then
      begin
        SetLength(SelezioneFull,Length(SelezioneFull) + 1);
        j:=High(SelezioneFull);
        SelezioneFull[j].NomeCampo:=QCols.FieldByName('NOME_CAMPO').AsString;
        SelezioneFull[j].NomeLogico:=QCols.FieldByName('NOME_LOGICO').AsString;
        SelezioneFull[j].Selezione.DaValore:='';
        SelezioneFull[j].Selezione.AValore:='';
        SelezioneFull[j].Selezione.TotValori:=TStringList.Create;
        SelezioneFull[j].Selezione.SelValori:=TStringList.Create;
        SelezioneFull[j].Selezione.Esistente:=False;
      end;
      QCols.Next;
    end;
    TVAzienda.Items.EndUpdate;
    TVAzienda.OnChange:=TVAziendaChange;
    if TVAzienda.Items.Count > 0 then
      TVAzienda.Selected:=TVAzienda.Items[0];
    QCols.Close;
  end;
end;

procedure TC700FSelezioneAnagrafeDtM.OpenSelAnagrafe;
begin
  with selAnagrafe do
  begin
    CloseAll;
    SQL.Assign(C700FSelezioneAnagrafe.ListSQL);
    C700FSelezioneAnagrafe.SQLCreato.Clear;
    if C700Progressivo >= 0 then
    begin
      SQL.Add('AND T030.PROGRESSIVO = ' + IntToStr(C700Progressivo));
      if C700FSelezioneAnagrafe.SQLCreato.Count > 0 then
        C700FSelezioneAnagrafe.SQLCreato.Add('AND');
      C700FSelezioneAnagrafe.SQLCreato.Add('T030.PROGRESSIVO = ' + IntToStr(C700Progressivo));
      C700FSelezioneAnagrafe.WhereSQL:=C700FSelezioneAnagrafe.SQLCreato.Text;
    end;
    if VariableIndex('C700DATADAL') >= 0 then
      DeleteVariable('C700DATADAL');
    if VariableIndex('C700FILTRO') >= 0 then
      DeleteVariable('C700FILTRO');
    SetVariable('DataLavoro',C700FSelezioneAnagrafe.DataLavoro);
    Open;
  end;
end;

procedure TC700FSelezioneAnagrafeDtM.GetNomeSelezioni;
begin
  with selT003Nome do
  begin
    Close;
    Open;
    C700FSelezioneAnagrafe.cmbSelezione.Items.Clear;
    while not Eof do
    begin
      C700FSelezioneAnagrafe.cmbSelezione.Items.Add(FieldByName('Nome').AsString);
      Next;
    end;
  end;
end;

procedure TC700FSelezioneAnagrafeDtM.selAnagrafeAfterScroll(DataSet: TDataSet);
begin
  C700Progressivo:=selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  if FElaborazioneInterrompibile then
    Application.ProcessMessages;
end;

procedure TC700FSelezioneAnagrafeDtM.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('SELEZIONI ANAGRAFICHE',DataSet.FieldByName('NOME').AsString);
end;

procedure TC700FSelezioneAnagrafeDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(QCols);
end;

procedure TC700FSelezioneAnagrafeDtM.selAnagrafeAfterOpen(DataSet: TDataSet);
begin
  if DataSet.FindField('T430BADGE') <> nil then
    DataSet.FieldByName('T430BADGE').DisplayLabel:='BADGE';
  if DataSet.FindField('T430INIZIO') <> nil then
    DataSet.FieldByName('T430INIZIO').DisplayLabel:='INIZIO';
  if DataSet.FindField('T430FINE') <> nil then
    DataSet.FieldByName('T430FINE').DisplayLabel:='FINE';
  if DataSet.FindField('COGNOME') <> nil then
    DataSet.FieldByName('COGNOME').DisplayWidth:=15;
  if DataSet.FindField('NOME') <> nil then
    DataSet.FieldByName('NOME').DisplayWidth:=15;
  if DataSet.FindField('T430INIZIO') <> nil then
    DataSet.FieldByName('T430INIZIO').DisplayWidth:=10;
  if DataSet.FindField('T430FINE') <> nil then
    DataSet.FieldByName('T430FINE').DisplayWidth:=10;
  if DataSet.RecordCount = 0 then
    //C700Progressivo:=-1;
    C700Progressivo:=0;
end;

end.
