unit A002UAnagrafeMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R005UDataModuleMW, Oracle, DB, OracleData,A000UCostanti, A000USessione,C180FunzioniGenerali,
  A000UInterfaccia, medpBackupOldValue;

type
  TSQLAppoggio = record
    Colonna:String;
    DecIni:TDateTime;
    OQ:TOracleQuery;
  end;

  TA002FAnagrafeMW = class(TR005FDataModuleMW)
    updP430: TOracleQuery;
    UpdT430_IndMat: TOracleQuery;
    GetNuovaMatricola: TOracleQuery;
    QBadgeLibero: TOracleDataSet;
    selT010: TOracleDataSet;
    dsrT010: TDataSource;
    selT220: TOracleDataSet;
    dsrT261: TDataSource;
    dsrT220: TDataSource;
    selT261: TOracleDataSet;
    selT025: TOracleDataSet;
    dsrT025: TDataSource;
    selCodFisc: TOracleDataSet;
    selT430_IntIndMat: TOracleDataSet;
    selI060: TOracleDataSet;
    selT600: TOracleDataSet;
    dsrT600: TDataSource;
    selI500: TOracleDataSet;
    selT485: TOracleDataSet;
    dsrT485: TDataSource;
    selT430_IntPRapp: TOracleDataSet;
    selT470: TOracleDataSet;
    dsrT470: TDataSource;
    selT460: TOracleDataSet;
    dsrT460: TDataSource;
    selT450: TOracleDataSet;
    dsrT450: TDataSource;
    selT270: TOracleDataSet;
    dsrT270: TDataSource;
    selT265: TOracleDataSet;
    dsrT265: TDataSource;
    selP430_count: TOracleDataSet;
    selT430_Decorrenze: TOracleDataSet;
    selT200: TOracleDataSet;
    dsrT200: TDataSource;
    selT163: TOracleDataSet;
    dsrT163: TDataSource;
    selT060: TOracleDataSet;
    dsrT060: TDataSource;
    selT035: TOracleDataSet;
    selVerificaBadge: TOracleDataSet;
    updFine: TOracleQuery;
    selT433: TOracleDataSet;
    selT433_count: TOracleDataSet;
    updT433: TOracleQuery;
    UpdT430Mat: TOracleQuery;
    scrT430: TOracleQuery;
    scrP430: TOracleQuery;
    selT430_InizioFine: TOracleDataSet;
    selT430_PeriodiInvertiti: TOracleDataSet;
    selT430_DatePeriodi: TOracleDataSet;
    selT033_campoDecode: TOracleDataSet;
    scrT030NoTrigger: TOracleQuery;
    selI030: TOracleDataSet;
    selI035: TOracleDataSet;
    selCOLS: TOracleDataSet;
    selI090_GruppoBadge: TOracleDataSet;
    procedure selT010AfterOpen(DataSet: TDataSet);
    procedure selT035AfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI030FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
  private
    (*Dataset su T030 e T430.
      IrisWIn e WebPJ li definiscono in modo leggermente diverso e non è possibile definirli in questa classe.
      Vengono impostati in fase di creazione e usati per le funzioni esposte dal MW
    *)
    FselT030_Funzioni: TOracleDataset;
    FselT430_Funzioni: TOracleDataset;
    VSQLAppoggio:array of TSQLAppoggio;
    function ControlloBadge(Dal,Al:TDateTime): TStringList;
    procedure CompletaSQLRelazione(var RelSQL:String);
  public
    selT430OldValues:TmedpBackupOldValue;
    function CountAnagraficheStipendiali(Progressivo: Integer; DataOld,DataNew: TDateTime) :Integer;
    function NuovoProgressivo:Integer;
    function VerificaCFCambiato(CodCatastale: String): String;
    function VerificaCFUsato: String;
    function VerificaIntersezionePeriodiIndMat: String;
    function VerificaIntersezionePeriodiRappIndMat: String;
    function VerificaBadge(Inserimento,Storicizza: Boolean; PrimaDecorrenza: TDateTime; StoriciPrec,StoriciSucc: Boolean): TStringList;
    function VerificaBadgeServizio: Boolean;
    function VerificaInizioRapportoInterseca(var sDate: String): Boolean;
    function VerificaPeriodiInvertiti(var sDate: String): Boolean;
    function VerificaDatePeriodi(var sDate: String): Boolean;
    procedure AggiornaDecorrenzaStipendiale (NewDate: TDateTime);
    procedure AggiornaPeriodoIndMat;
    procedure AggiornaFine(Storicizza: String);
    function VerificaCdCPercentualizzati(StoriciPrec,StoriciSucc: Boolean; PrimaDecorrenza:TDateTime; var DataDecMod:TDateTime;var Automatismo: Boolean): Boolean;
    function AggiornaPeriodiStorici :Boolean;
    procedure NoTrigger(Istante: TDateTime;Inserisci: String);
    function CreaSQLRelazione(bData: Boolean):String;
    function EseguiSQLRelazione(SqlRelazione: String): TOracleQuery;
    procedure RefreshVSQLAppoggio;
    function ImpostaValoreRelazione: Boolean;
    procedure FiltroDizionarioBeforePost(Campo,Dizionario,Caption:String);
    property selT030_Funzioni: TOracleDataset read FselT030_Funzioni write FselT030_Funzioni;
    property selT430_Funzioni: TOracleDataset read FselT430_Funzioni write FselT430_Funzioni;
  end;

implementation

{$R *.dfm}

procedure TA002FAnagrafeMW.AggiornaDecorrenzaStipendiale(NewDate: TDateTime);
begin
  //Aggiorno la minima data decorrenza stipendiale, in modo che la Allinea_Periodi_Storici non annulli la posticipazione
  updP430.SetVariable('DATA_NEW',R180InizioMese(NewDate));
  updP430.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  updP430.Execute;
end;

procedure TA002FAnagrafeMW.AggiornaFine(Storicizza: String);
begin
  if (FselT430_Funzioni.State = dsEdit) and (FselT430_Funzioni.FieldByName('FINE').AsDateTime <> FselT430_Funzioni.FieldByName('FINE').medpOldValue) then
    with updFine do
    begin
      ClearVariables;
      SetVariable('PROGRESSIVO',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('RIGAID',FselT430_Funzioni.RowID);
      SetVariable('STORICIZZA',Storicizza);
      SetVariable('INIZIO',FselT430_Funzioni.FieldByName('INIZIO').AsDateTime);
      if not FselT430_Funzioni.FieldByName('FINE').IsNull then
        SetVariable('FINE',FselT430_Funzioni.FieldByName('FINE').AsDateTime);
      Execute;
    end;
end;

procedure TA002FAnagrafeMW.AggiornaPeriodoIndMat;
begin
  UpdT430_IndMat.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  UpdT430_IndMat.SetVariable('INIZIO_IND_MAT_OLD',selT430OldValues.FieldByName('INIZIO_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('INIZIO_IND_MAT',FselT430_Funzioni.FieldByName('INIZIO_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('FINE_IND_MAT_OLD',selT430OldValues.FieldByName('FINE_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('FINE_IND_MAT',FselT430_Funzioni.FieldByName('FINE_IND_MAT').Value);
  UpdT430_IndMat.SetVariable('ROWID',FselT430_Funzioni.RowId);
  UpdT430_IndMat.Execute;
end;

function TA002FAnagrafeMW.AggiornaPeriodiStorici: Boolean;
//Compatta ed espande i periodi storici considerando anche gli storici dei dati liberi
begin
  scrT430.SetVariable('Progressivo',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  scrT430.Execute;
  Result:=True;

  //Segnalazione errore di dipendente occupato
  if  VarToStr(scrT430.GetVariable('Errore')) = 'OC' then
    Result:=False
  else
  begin
    scrP430.SetVariable('Progressivo',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    try
      scrP430.Execute;
    except
    end;
    //Segnalazione errore di dipendente occupato
    if VarToStr(scrP430.GetVariable('Errore')) = 'OC' then
      Result:=False;
  end;
end;

function TA002FAnagrafeMW.CountAnagraficheStipendiali(Progressivo: Integer; DataOld,DataNew: TDateTime): Integer;
begin
  with selP430_count do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA_OLD',DataOld);
    SetVariable('DATA_NEW',DataNew);
    Open;
    Result:=FieldByName('ANAGRAFICHE_STIPENDIALI').AsInteger;
  end;
end;


function TA002FAnagrafeMW.CreaSQLRelazione(bData: Boolean): String;
var
  SqlRelazione: String;
  OldColonna: String;
  OldDecorrenza: TDateTime;
begin
  with selI035 do
  begin
    SqlRelazione:='';
    if SearchRecord('COLONNA;DECORRENZA',VarArrayOf([selI030.FieldByName('COLONNA').AsString,selI030.FieldByName('DECORRENZA').AsDateTime]),[srFromBeginning]) then
    begin
      OldColonna:=FieldByName('COLONNA').AsString;
      OldDecorrenza:=FieldByName('DECORRENZA').AsDateTime;
      while not Eof do
      begin
        if (OldColonna = FieldByName('COLONNA').AsString) and
           (OldDecorrenza = FieldByName('DECORRENZA').AsDateTime) then
        begin
          SqlRelazione:=SqlRelazione + ' ' + FieldByName('RELAZIONE').AsString;
          if (bData) and (Pos('ORDER BY',FieldByName('RELAZIONE').AsString) = 0) then
            SqlRelazione:=SqlRelazione + ' AND :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE';
        end
        else
          Break;
        OldColonna:=FieldByName('COLONNA').AsString;
        OldDecorrenza:=FieldByName('DECORRENZA').AsDateTime;
        Next;
      end;
    end;
  end;
  if Trim(SqlRelazione) <> '' then
    CompletaSQLRelazione(SqlRelazione);

  Result:=SqlRelazione;
end;

procedure TA002FAnagrafeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT035.Open;
  selCOLS.Open;
  selT430OldValues:=TmedpBackupOldValue.Create(Self);
end;

procedure TA002FAnagrafeMW.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  selT035.Close;
  for i:=High(VSQLAppoggio) downto 0 do
    VSQLAppoggio[i].OQ.Free;
  SetLength(VSQLAppoggio,0);
inherited;
end;

function TA002FAnagrafeMW.EseguiSQLRelazione(SqlRelazione: String): TOracleQuery;
var
  TrovRel: Boolean;
  i: Integer;
  SqlOriginale: String;
begin
  TrovRel:=False;
  Result:=nil;
  for i:=0 to High(VSQLAppoggio) do
    if  (VSQLAppoggio[i].Colonna = selI030.FieldByName('COLONNA').AsString)
         and (VSQLAppoggio[i].DecIni  = selI030.FieldByName('DECORRENZA').AsDateTime) then
    begin
      TrovRel:=True;
      Break;
    end;
    if TrovRel then
    begin
      with VSQLAppoggio[i].OQ do
      begin
        if (Trim(SqlRelazione) <> Trim(Sql.Text)) then
        begin
          SqlOriginale:=Sql.Text;
          Sql.Text:=SqlRelazione;
          try
            Execute;
          except
            Sql.Text:=SqlOriginale;
            Execute;
          end;
        end;
        Result:=VSQLAppoggio[i].OQ;
      end;
    end;
end;

function TA002FAnagrafeMW.ImpostaValoreRelazione: Boolean;
var
  ValoreDefault,SqlRelazione: String;
  OQ: TOracleQuery;
begin
  Result:=False;
  if (selI030.FieldByName('TIPO').AsString = 'S')
     or (
       (selI030.FieldByName('TIPO').AsString = 'L')
       and (
         (FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString = '')
          or (FselT430_Funzioni.State in [dsInsert])
       )
     ) then
  begin
    SqlRelazione:=CreaSQLRelazione(False);
    if Trim(SqlRelazione) <> '' then
    begin
      //Cerco la relazione salvata
      OQ:=EseguiSQLRelazione(SqlRelazione);
      if OQ <>nil then
      begin
        Result:=True;
        if OQ.RowCount = 0 then
          FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=''
        else
          FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=OQ.FieldAsString(0);

        if FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString = '' then
          if (selCOLS.SearchRecord('TABLE_NAME;COLUMN_NAME',VarArrayOf([selI030.FieldByName('TABELLA').AsString,selI030.FieldByName('COLONNA').AsString]),[srFromBeginning]))
            and (selCOLS.FieldByName('NULLABLE').AsString = 'N') then
          begin
            ValoreDefault:=Trim(selCOLS.FieldByName('DATA_DEFAULT').AsString);
            if (Copy(ValoreDefault,1,1) = '''') and (Copy(ValoreDefault,Length(ValoreDefault),1) = '''') then
              ValoreDefault:=Copy(ValoreDefault,2,Length(ValoreDefault)-2);
            FselT430_Funzioni.FieldByName(selI030.FieldByName('COLONNA').AsString).AsString:=ValoreDefault;
          end;
      end;
    end;
  end;
end;

procedure TA002FAnagrafeMW.NoTrigger(Istante: TDateTime;Inserisci: String);
begin
  try
    scrT030NoTrigger.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('Progressivo').AsInteger);
    scrT030NoTrigger.SetVariable('ISTANTE',Istante);
    scrT030NoTrigger.SetVariable('INSERISCI',Inserisci);
    scrT030NoTrigger.Execute;
  except
  
  end;
end;

function TA002FAnagrafeMW.NuovoProgressivo: Integer;
begin
  with selT035 do
  begin
    Refresh;
    Edit;
    if FieldByName('Progressivo').IsNull then
      FieldByName('Progressivo').AsInteger:=1
    else
      FieldByName('Progressivo').AsInteger:=FieldByName('Progressivo').AsInteger + 1;
    Post;
    Result:=FieldByName('Progressivo').AsInteger;
  end;
end;

procedure TA002FAnagrafeMW.RefreshVSQLAppoggio;
var i:Integer;
begin
  selI030.First;
  for i:=High(VSQLAppoggio) downto 0 do
    VSQLAppoggio[i].OQ.Free;
  SetLength(VSQLAppoggio,0);
  while not selI030.Eof do
  begin
    SetLength(VSQLAppoggio,Length(VSQLAppoggio) + 1);
    i:=High(VSQLAppoggio);
    VSQLAppoggio[i].Colonna:=selI030.FieldByName('COLONNA').AsString;
    VSQLAppoggio[i].DecIni:=selI030.FieldByName('DECORRENZA').AsDateTime;
    VSQLAppoggio[i].OQ:=TOracleQuery.Create(nil);
    VSQLAppoggio[i].OQ.ReadBuffer:=1;
    VSQLAppoggio[i].OQ.Session:=SessioneOracle;
    selI030.Next;
  end;
  selI030.First;
end;

procedure TA002FAnagrafeMW.selI030FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if FselT430_Funzioni.Active then
    if FselT430_Funzioni.FieldByName('DATAFINE').IsNull then
      Accept:=selI030.FieldByName('DECORRENZA_FINE').AsDateTime = EncodeDate(3999,12,31)
    else
      Accept:=(selI030.FieldByName('DECORRENZA').AsDateTime <= FselT430_Funzioni.FieldByName('DATAFINE').AsDateTime) and
              (selI030.FieldByName('DECORRENZA_FINE').AsDateTime >= FselT430_Funzioni.FieldByName('DATAFINE').AsDateTime);
end;

procedure TA002FAnagrafeMW.selT010AfterOpen(DataSet: TDataSet);
begin
  DataSet.Fields[0].DisplayWidth:=Trunc(DataSet.Fields[0].Size * 1.5) + 1;
end;

procedure TA002FAnagrafeMW.selT035AfterOpen(DataSet: TDataSet);
begin
  inherited;
  if selT035.RecordCount = 0 then
    selT035.AppendRecord([0,0,0]);
end;

procedure TA002FAnagrafeMW.FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
   if DataSet = selT010 then
    Accept:=A000FiltroDizionario('CALENDARI',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT163 then
    Accept:=A000FiltroDizionario('PROFILI INDENNITA',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT220 then
    Accept:=A000FiltroDizionario('PROFILI ORARIO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT261 then
    Accept:=A000FiltroDizionario('PROFILI ASSENZA',DataSet.FieldByName('CODICE').AsString);
end;

//Controllo che il badge assegnato non sia già utilizzato da altri dipendenti
function TA002FAnagrafeMW.VerificaInizioRapportoInterseca(var sDate: String): Boolean;
begin
  Result:=True;
  with selT430_InizioFine do
  begin
    SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    Close;
    Open;
    if not FieldByName('INIZIO').IsNull then
    begin
      sDate:=DateToStr(FieldByName('INIZIO').AsDateTime);
      Result:=False;
    end;
    Close;
  end;
end;

function TA002FAnagrafeMW.VerificaPeriodiInvertiti(var sDate: String): Boolean;
begin
  Result:=True;
  with selT430_PeriodiInvertiti do
  begin
    SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    Close;
    Open;
    if not FieldByName('INIZIO').IsNull then
    begin
      Result:=False;
      sDate:=DateToStr(FieldByName('INIZIO').AsDateTime);
    end;
    Close;
  end;

end;

function TA002FAnagrafeMW.VerificaBadge(Inserimento,Storicizza: Boolean; PrimaDecorrenza: TDateTime; StoriciPrec,StoriciSucc: Boolean): TStringList;
var
  DataInizio,DataFine: TDateTime;
begin
  Result:=nil;
  with FselT430_Funzioni do
  begin
    if (Inserimento and not FieldByName('BADGE').IsNull) or
       (not Inserimento and
       ((selT430OldValues.FieldByName('BADGE').Value <> FieldByName('BADGE').Value) or
        (selT430OldValues.FieldByName('DATADECORRENZA').Value <> FieldByName('DATADECORRENZA').Value) or
        (selT430OldValues.FieldByName('INIZIO').Value <> FieldByName('INIZIO').Value) or
        (selT430OldValues.FieldByName('FINE').Value <> FieldByName('FINE').Value))) then
    begin
      if Inserimento then //Inserimento nuovo dipendente
      begin
        if not FieldByName('INIZIO').IsNull then
          DataInizio:=FieldByName('INIZIO').AsDateTime
        else
          DataInizio:=FieldByName('DATADECORRENZA').AsDateTime;
        DataFine:=EncodeDate(3999,12,31);
      end
      else if Storicizza then  //Storicizzazione dati di un dipendente
      begin
        if FieldByName('INIZIO').AsDateTime > FieldByName('DATADECORRENZA').AsDateTime then
          DataInizio:=FieldByName('INIZIO').AsDateTime
        else
          DataInizio:=FieldByName('DATADECORRENZA').AsDateTime;
        if StoriciPrec then
          DataInizio:=PrimaDecorrenza;
        if StoriciSucc then
          DataFine:=EncodeDate(3999,12,31)
        else
          DataFine:=FieldByName('DATAFINE').AsDateTime;
      end
      else  //Modifica dati di un dipendente
      begin
        if FieldByName('INIZIO').AsDateTime > FieldByName('DATADECORRENZA').AsDateTime then
          DataInizio:=FieldByName('INIZIO').AsDateTime
        else
          DataInizio:=FieldByName('DATADECORRENZA').AsDateTime;

        if StoriciSucc then
          DataFine:=EncodeDate(3999,12,31)
        else
          DataFine:=FieldByName('DataFine').AsDateTime;
      end;

      Result:=ControlloBadge(DataInizio,DataFine);
    end;
  end;
end;

function TA002FAnagrafeMW.VerificaBadgeServizio: Boolean;
begin
  //Controllo edizione badge <> 'BS' usata per i badge di servizio   //Lorena 31/08/2006
  Result:=True;
  with TStringList.Create do
  try
    Clear;
    CommaText:=FselT430_Funzioni.FieldByName('EDBADGE').AsString;
    if IndexOf('BS') <> -1 then
      Result:=False;
  finally
    Free;
  end;
end;

function TA002FAnagrafeMW.VerificaCdCPercentualizzati(StoriciPrec,StoriciSucc: Boolean; PrimaDecorrenza:TDateTime;var DataDecMod:TDateTime; var Automatismo: Boolean): Boolean;
var
  DataFinMod:TDateTime;
begin
  Result:=True;
  //Se è cambiato il valore del centro di costo
  if (Parametri.CampiRiferimento.C13_CdcPercentualizzati <> '')
  and (FselT430_Funzioni.FieldByName(Parametri.CampiRiferimento.C13_CdcPercentualizzati).Value <> selT430OldValues.FieldByName(Parametri.CampiRiferimento.C13_CdcPercentualizzati).Value) then
  begin
    //Inizializzo le variabili
    Automatismo:=False;
    DataDecMod:=FselT430_Funzioni.FieldByName('DATADECORRENZA').AsDateTime;
    if StoriciPrec then
      DataDecMod:=PrimaDecorrenza;
    DataFinMod:=FselT430_Funzioni.FieldByName('DATAFINE').AsDateTime;
    if StoriciSucc then
      DataFinMod:=EncodeDate(3999,12,31);
    //Estraggo le percentualizzazioni intersecate
    selT433.Close;
    selT433.SetVariable('PROGRESSIVO',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    selT433.SetVariable('DATADECORRENZA_MOD',DataDecMod);
    selT433.SetVariable('DATAFINE_MOD',DataFinMod);
    selT433.Open;
    //Se non interseco niente, esco
    if selT433.RecordCount = 0 then
      exit
    //Se interseco una sola percentualizzazione, verifico che non ce ne siano di successive
    else if selT433.RecordCount = 1 then
    begin
      selT433_count.Close;
      selT433_count.SetVariable('PROGRESSIVO',FselT430_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
      selT433_count.SetVariable('DECORRENZA',selT433.FieldByName('Decorrenza').AsDateTime);
      selT433_count.Open;
      Automatismo:=selT433_count.FieldByName('Successive').AsInteger = 0;
    end;
    Result:=False;
  end;

end;

procedure TA002FAnagrafeMW.CompletaSQLRelazione(var RelSQL: String);
var
  NewCampo,OldCampo:String;
begin
  RelSQL:=Trim(RelSQL);
  while Pos('<#>',RelSQL) <> 0 do
  begin
    OldCampo:=Copy(RelSQL,Pos('<#>',RelSQL)+3,Pos('<#>',Copy(RelSQL,Pos('<#>',RelSQL)+3))-1);
    if OldCampo = 'DECORRENZA' then
      NewCampo:='DATADECORRENZA'
    else if OldCampo = 'DECORRENZA_FINE' then
      NewCampo:='DATAFINE'
    else if OldCampo = ';' then
      NewCampo:=' UNION SELECT '
    else if OldCampo = 'W' then
      NewCampo:=' FROM DUAL WHERE '
    else if OldCampo = 'D' then
      NewCampo:=' FROM DUAL '
    else
      NewCampo:=OldCampo;
    if (OldCampo <> ';') and (OldCampo <> 'W') and (OldCampo <> 'D') then
      RelSQL:=StringReplace(RelSQL,'<#>'+OldCampo+'<#>',''''+ FselT430_Funzioni.FieldByName(NewCampo).AsString+'''',[rfReplaceAll,rfIgnoreCase])
    else
      RelSQL:=StringReplace(RelSQL,'<#>'+OldCampo+'<#>',NewCampo,[rfReplaceAll,rfIgnoreCase]);
  end;
  if Copy(RelSQL,Length(RelSQL)-13,14) = ' UNION SELECT ' then
    RelSQL:=Copy(RelSQL,1,Length(RelSQL)-14);
  if Length(RelSQL) > 0 then
  begin
    if Copy(RelSQL,1,6) <> 'SELECT' then
      RelSQL:='SELECT '+RelSQL;
    if Pos(' FROM ',RelSQL) = 0 then
      RelSQL:=RelSQL+' FROM DUAL';
  end;
  RelSQL:=Trim(RelSQL);
end;

function TA002FAnagrafeMW.ControlloBadge(Dal,Al:TDateTime):TStringList;
{Controllo se il Badge esiste anche per altri dipendenti e lo segnalo}
var D1,D2,sAzienda: String;
    iProgressivo: Integer;
begin
  Result:=nil;
  if FselT430_Funzioni.FieldByName('BADGE').IsNull then exit;
  //Cerco tutte le aziende che hanno il GruppoBadge corrente
  with selI090_GruppoBadge do
  begin
    Close;
    SetVariable('UTENTE',Parametri.Username);
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('GRUPPO',Parametri.GruppoBadge);
    Open;
  end;
  while not selI090_GruppoBadge.Eof do
  begin
    //Se cerco il badge sull'azienda corrente...
    if Parametri.Azienda = selI090_GruppoBadge.FieldByName('AZIENDA').AsString then
    begin
      sAzienda:='';
      iProgressivo:=FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger;
    end
    else //se cerco il badge su un'azienda diversa da quella corrente...
    begin
      sAzienda:='Azienda: ' + selI090_GruppoBadge.FieldByName('AZIENDA').AsString + '. ';
      iProgressivo:=0;
    end;
    with selVerificaBadge do
    begin
      Close;
      SetVariable('BADGE',FselT430_Funzioni.FieldByName('BADGE').AsInteger);
      SetVariable('PROGRESSIVO',iProgressivo);
      SetVariable('DAL',Dal);
      SetVariable('AL',Al);
      SetVariable('UTENTE',selI090_GruppoBadge.FieldByName('UTENTE').AsString);
      Open;
      if RecordCount > 0 then
      begin
        if Result = nil then
          Result:=TStringList.Create;
        //Ho trovato altre occorrenze di questo badge
        while not Eof do
        begin
          D1:=DateToStr(FieldByName('DATADECORRENZA').AsDateTime);
          if FormatDateTime('dd/mm/yyyy',FieldByName('DATAFINE').AsDateTime) = '31/12/3999' then
            D2:='Corrente'
          else
            D2:=DateToStr(FieldByName('DataFine').AsDateTime);
          Result.Add(sAzienda +
                     Format('%s %s %s (%s) dal %s al %s',
                            [FieldByName('TIPOBADGE').AsString,FieldByName('COGNOME').AsString,FieldByName('NOME').AsString,FieldByName('MATRICOLA').AsString,D1,D2]));
          Next;
        end;
      end;
    end;
    selI090_GruppoBadge.Next;
  end;
end;

function TA002FAnagrafeMW.VerificaCFCambiato(CodCatastale: String): String;
var
  CF: String;
begin
  Result:='';
  with FselT030_Funzioni do
  begin
    if (State = dsEdit) and
       (not FieldByName('CODFISCALE').IsNull) and
       ((FieldByName('COGNOME').medpOldValue <> FieldByName('COGNOME').Value) or
        (FieldByName('NOME').medpOldValue <> FieldByName('NOME').Value) or
        (FieldByName('SESSO').medpOldValue <> FieldByName('SESSO').Value) or
        (FieldByName('COMUNENAS').medpOldValue <> FieldByName('COMUNENAS').Value) or
        (FieldByName('DATANAS').medpOldValue <> FieldByName('DATANAS').Value)) then
    begin
      CF:=R180CalcoloCodiceFiscale(FieldByName('COGNOME').AsString,
                              FieldByName('NOME').AsString,
                              FieldByName('SESSO').AsString,
                              CodCatastale,
                              FieldByName('DATANAS').AsDateTime);
      if FieldByName('CODFISCALE').AsString <> CF then
        Result:=CF;
    end;
  end;
end;

function TA002FAnagrafeMW.VerificaCFUsato: String;
begin
  Result:='';
  if (FselT030_Funzioni.State in [dsInsert]) or
     (FselT030_Funzioni.FieldByName('CODFISCALE').medpOldValue <> FselT030_Funzioni.FieldByName('CODFISCALE').AsString) then
  begin
    selCodFisc.SetVariable('CODFISC',FselT030_Funzioni.FieldByName('CODFISCALE').AsString);
    selCodFisc.SetVariable('INIZIO',FselT430_Funzioni.FieldByName('INIZIO').Value);
    selCodFisc.SetVariable('FINE',FselT430_Funzioni.FieldByName('FINE').Value);
    selCodFisc.SetVariable('PROG',FselT030_Funzioni.FieldByName('PROGRESSIVO').Value);
    selCodFisc.Close;
    selCodFisc.Open;
    if selCodFisc.RecordCount > 0 then
    begin
      while Not selCodFisc.Eof do
      begin
        if Result <> '' then
          Result:=Result + #13#10;
        Result:=Result + selCodFisc.FieldByName('COGNOME').AsString + ' ' +
                   selCodFisc.FieldByName('NOME').AsString;
        selCodFisc.Next;
      end;
    end;
  end;
end;

function TA002FAnagrafeMW.VerificaDatePeriodi(var sDate: String): Boolean;
begin
  Result:=True;
  with selT430_DatePeriodi do
  begin
    SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
    Close;
    Open;
    if not FieldByName('INIZIO').IsNUll then
    begin
      Result:=False;
      sDate:='dal ' + FieldByName('INIZIO').AsString + ' al ' + FieldByName('FINE').AsString;
    end;
  end;

end;

{Controllo che non avvengano intersezioni tra periodi d'indennità maternità}

function TA002FAnagrafeMW.VerificaIntersezionePeriodiIndMat: String;
begin
  selT430_IntIndMat.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  selT430_IntIndMat.SetVariable('INIZIO_IND_MAT_OLD',selT430OldValues.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntIndMat.SetVariable('FINE_IND_MAT_OLD',selT430OldValues.FieldByName('FINE_IND_MAT').Value);
  selT430_IntIndMat.SetVariable('INIZIO_IND_MAT',FselT430_Funzioni.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntIndMat.SetVariable('FINE_IND_MAT',FselT430_Funzioni.FieldByName('FINE_IND_MAT').Value);
  selT430_IntIndMat.Close;
  selT430_IntIndMat.Open;
  Result:='';
  if selT430_IntIndMat.RecordCount > 0 then
    while Not (selT430_IntIndMat.Eof) do
    begin
      Result:=Result +
              selT430_IntIndMat.FieldByName('INIZIO_IND_MAT').AsString + ' - ' +
              selT430_IntIndMat.FieldByName('FINE_IND_MAT').AsString;
      selT430_IntIndMat.Next;
      if Not selT430_IntIndMat.Eof then
        Result:=Result + ',' + #13#10;
    end;
end;

{Controllo che non avvengano intersezioni tra periodi di rapporto e periodi di maturazione indennità maternità}
function TA002FAnagrafeMW.VerificaIntersezionePeriodiRappIndMat: String;
begin
  Result:='';
  selT430_IntPRapp.SetVariable('PROGRESSIVO',FselT030_Funzioni.FieldByName('PROGRESSIVO').AsInteger);
  selT430_IntPRapp.SetVariable('INIZIO_IND_MAT',FselT430_Funzioni.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('FINE_IND_MAT',FselT430_Funzioni.FieldByName('FINE_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('INIZIO_IND_MAT_OLD',selT430OldValues.FieldByName('INIZIO_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('FINE_IND_MAT_OLD',selT430OldValues.FieldByName('FINE_IND_MAT').Value);
  selT430_IntPRapp.SetVariable('INIZIO',FselT430_Funzioni.FieldByName('INIZIO').Value);
  selT430_IntPRapp.SetVariable('INIZIO_OLD',selT430OldValues.FieldByName('INIZIO').Value);
  selT430_IntPRapp.SetVariable('FINE',FselT430_Funzioni.FieldByName('FINE').Value);
  selT430_IntPRapp.SetVariable('FINE_OLD',selT430OldValues.FieldByName('FINE').Value);
  selT430_IntPRapp.Close;
  selT430_IntPRapp.Open;

  if selT430_IntPRapp.RecordCount > 0 then
   while Not (selT430_IntPRapp.Eof) do
    begin
      Result:=Result + selT430_IntPRapp.FieldByName('INIZIO').AsString + ' - ' +
              selT430_IntPRapp.FieldByName('FINE').AsString;
      selT430_IntPRapp.Next;
      if Not selT430_IntPRapp.Eof then
        Result:=Result + ',' + #13#10;
    end;
end;

procedure TA002FAnagrafeMW.FiltroDizionarioBeforePost(Campo,Dizionario,Caption:String);
begin
  with selT430_Funzioni do
    if (not FieldByName(Campo).IsNull) and
       (FieldByName(Campo).Value <> selT430OldValues.FieldByName(Campo).Value) and
       (not A000FiltroDizionario(Dizionario,FieldByName(Campo).Value)) then
    raise Exception.Create(Format('Codice %s non disponibile nel proprio filtro dizionario!',[Caption]));
end;

end.
