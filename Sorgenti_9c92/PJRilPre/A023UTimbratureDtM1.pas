unit A023UTimbratureDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Variants, DBClient, Oracle, OracleData, StrUtils, Math,
  A000UCostanti, A000USessione, A000UInterfaccia,
  C018UIterAutDM, C180FunzioniGenerali, C700USelezioneAnagrafe, RegistrazioneLog,
  A023UTimbratureMW;

type
  TA023FTimbratureDtM1 = class(TDataModule)
    dsrSG101: TDataSource;
    cdsGestMese: TClientDataSet;
    cdsGestMeseTIPO: TStringField;
    dscGestMese: TDataSource;
    cdsGestMeseDATA: TDateTimeField;
    selAssPres: TOracleDataSet;
    cdsGestMeseDESC_CAUSALE: TStringField;
    cdsGestMeseCAUSALE: TStringField;
    insT320: TOracleQuery;
    cdsGestMeseTOTLAV: TIntegerField;
    cdsGestMeseDEBITOGG: TIntegerField;
    cdsGestMeseSCOST: TIntegerField;
    cdsGestMeseC_DEBITOGG_H: TStringField;
    cdsGestMeseC_TOTLAV_H: TStringField;
    cdsGestMeseC_SCOST_H: TStringField;
    delT320: TOracleQuery;
    cdsGestMeseDALLE_ORIG: TIntegerField;
    cdsGestMeseALLE_ORIG: TIntegerField;
    cdsGestMeseDALLE_H: TStringField;
    cdsGestMeseALLE_H: TStringField;
    cdsGestMeseFLAG_RIGA: TStringField;
    cdsGestMeseCAUSALE_ORIG: TStringField;
    cdsGestMeseC_AUTORIZZATO: TStringField;
    cdsGestMeseC_ARROT_RIEPGG: TIntegerField;
    cdsGestMeseCAVALLO_MEZZANOTTE: TStringField;
    cdsGestMeseDATA_CONTEGGI: TDateTimeField;
    selI060DatiUtente: TOracleDataSet;
    cdsGestMeseDATA_ORIG: TDateTimeField;
    cdsGestMeseC_MODIFICATO: TStringField;
    cdsGestMeseFLAG_RIGA_SUBCOD: TIntegerField;
    selT370: TOracleDataSet;
    scrBloccaRiepT325: TOracleQuery;
    scrSbloccaRiepT325: TOracleQuery;
    dsrT722: TDataSource;
    cdsGestMeseID_EVENTO_STR: TIntegerField;
    cdsGestMeseSERVIZIO_ORIG: TStringField;
    cdsGestMeseSERVIZIO: TStringField;
    selT722: TOracleDataSet;
    selT722ID: TIntegerField;
    selT722CODICE: TStringField;
    selT722DESCRIZIONE: TStringField;
    selT722DAL: TDateTimeField;
    selT722AL: TDateTimeField;
    selT722ORE_INDIV: TStringField;
    selT722CAUSALE_STR: TStringField;
    selT722SERVIZI: TStringField;
    selT722DELEGATO: TStringField;
    selT722TIPO_LAVORO: TStringField;
    selT723: TOracleDataSet;
    dsrT723: TDataSource;
    selT723FILTRO_ANAGRAFE: TStringField;
    selT723ORE: TStringField;
    selT723ORE_CAUS: TStringField;
    selT722CAUSALE_STR_DOM: TStringField;
    selDistT722: TOracleDataSet;
    procedure A023FTimbratureDtM1Create(Sender: TObject);
    procedure A023FTimbratureDtM1Destroy(Sender: TObject);
    procedure selAssPresFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure cdsGestMeseAfterScroll(DataSet: TDataSet);
    procedure cdsGestMeseBeforeDelete(DataSet: TDataSet);
    procedure cdsGestMeseCalcFields(DataSet: TDataSet);
    procedure cdsGestMeseBeforeInsert(DataSet: TDataSet);
    procedure cdsGestMeseAfterPost(DataSet: TDataSet);
    procedure cdsGestMeseBeforePost(DataSet: TDataSet);
    procedure cdsGestMeseDALLE_HValidate(Sender: TField);
    procedure cdsGestMeseCAUSALEValidate(Sender: TField);
    procedure insT320BeforeQuery(Sender: TOracleQuery);
    procedure delT320BeforeQuery(Sender: TOracleQuery);
    procedure insT320AfterQuery(Sender: TOracleQuery);
    procedure delT320AfterQuery(Sender: TOracleQuery);
    procedure cdsGestMeseFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure cdsGestMeseDATAValidate(Sender: TField);
    procedure cdsGestMesePostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure cdsGestMeseBeforeEdit(DataSet: TDataSet);
  private
    ServiziEventiStr:String;
    function  CalcolaGiorno(GG:Integer):Integer;
    procedure GestMeseAbilitazioneCampi;
    procedure ValidaPeriodoGestMese(var Campo: TField);
    procedure Q100RILEVATOREChange(Sender: TField);
  public
    ElencoDLServizio: String;
    C018DM:TC018FIterAutDM;
    A023FTimbratureMW: TA023FTimbratureMW;
    function  GestMeseModifichePendenti: Boolean;
    procedure GetServiziEventiStr;
    procedure ImpostaPickListCausale;
    procedure ImpostaPickListServizio;
  end;

var
  A023FTimbratureDtM1: TA023FTimbratureDtM1;

implementation

uses A023UGestTimbra, A023UGestMese, A023UTimbrature;

{$R *.DFM}

procedure TA023FTimbratureDtM1.A023FTimbratureDtM1Create(Sender: TObject);
{Preparo le query Mensili}
var
  i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A023FTimbratureMW:=TA023FTimbratureMW.Create(Self);
  A023FTimbratureMW.OnRilevatoreChange:=Q100RILEVATOREChange;
  //A023FTimbratureMW.SelAnagrafe:=C700SelAnagrafe;
end;

procedure TA023FTimbratureDtM1.A023FTimbratureDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  FreeAndNil(A023FTimbratureMW);
end;

procedure TA023FTimbratureDtM1.GetServiziEventiStr;
begin
  ServiziEventiStr:='*';
  if Trim(Parametri.Inibizioni.Text) = '' then
    exit;
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Add(Format('select distinct %s from T030_ANAGRAFICO T030, V430_STORICO V430',['T430' + TORINO_COMUNE_STRUTT_EVENTI_STR]));
    SQL.Add('where T030.PROGRESSIVO = T430PROGRESSIVO');
    SQL.Add('and trunc(sysdate) between T430DATADECORRENZA and T430DATAFINE');
    SQL.Add('and trunc(sysdate) between T430INIZIO and nvl(T430FINE,sysdate)');
    SQL.Add(Format('and (%s)',[Parametri.Inibizioni.Text]));
    if Pos(':DATALAVORO',UpperCase(SQL.Text)) > 0 then
      DeclareAndSet('DATALAVORO',otDate,Parametri.DataLavoro);
    try
      Open;
      ServiziEventiStr:='';
      while not Eof do
      begin
        ServiziEventiStr:=ServiziEventiStr + IfThen(ServiziEventiStr <> '',',') + Fields[0].AsString;
        Next;
      end;
    except
    end;
  finally
    Free;
  end;
end;

function TA023FTimbratureDtM1.CalcolaGiorno(GG:Integer):Integer;
begin
  case GG of
   1..6:   Result:=1;
   7..12:  Result:=7;
   13..18: Result:=13;
   19..24: Result:=19;
   25..30: Result:=25;
  else
   Result:=31;
  end;
end;

procedure TA023FTimbratureDtM1.GestMeseAbilitazioneCampi;
{ Gestione dell'abilitazione (proprietà readonly) dei field del clientdataset }
var
  RigaBloccata,RigaDuplicata,CavalloMezzanotte,StatoNonIns: Boolean;
begin
  RigaBloccata:=cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'B';
  RigaDuplicata:=cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'D';
  CavalloMezzanotte:=cdsGestMese.FieldByName('CAVALLO_MEZZANOTTE').AsString = 'S';
  StatoNonIns:=(cdsGestMese.State <> dsInsert);

  // flag riga e tipo -> sempre disabilitati (eccetto ovviamente per l'inserimento)
  cdsGestMese.FieldByName('FLAG_RIGA').ReadOnly:=StatoNonIns;
  cdsGestMese.FieldByName('TIPO').ReadOnly:=StatoNonIns;

  // data -> abilitato solo se riga duplicata e timbrature a cavallo di mezzanotte
  cdsGestMese.FieldByName('DATA').ReadOnly:=(StatoNonIns) and (not(CavalloMezzanotte and RigaDuplicata));

  // orario e causale -> disabilitati solo se riga è bloccata
  cdsGestMese.FieldByName('DALLE_H').ReadOnly:=StatoNonIns and RigaBloccata;
  cdsGestMese.FieldByName('ALLE_H').ReadOnly:=StatoNonIns and RigaBloccata;
  cdsGestMese.FieldByName('CAUSALE').ReadOnly:=StatoNonIns and RigaBloccata;
end;

function TA023FTimbratureDtM1.GestMeseModifichePendenti: Boolean;
{ Restituisce True se sono presenti modifiche non ancora confermate
  sul dataset attualmente filtrato }
var
  BM: TBookmark;
begin
  Result:=False;

  // verifiche sul dataset
  if not cdsGestMese.Active then
    Exit;
  if cdsGestMese.RecordCount = 0 then
    Exit;

  cdsGestMese.DisableControls;
  BM:=cdsGestMese.GetBookmark;
  cdsGestMese.AfterScroll:=nil;

  // ciclo di controllo sul campo "C_MODIFICATO"
  cdsGestMese.First;
  while not cdsGestMese.Eof do
  begin
    Result:=cdsGestMese.FieldByName('C_MODIFICATO').AsString = 'S';
    if Result then
      Break;
    cdsGestMese.Next;
  end;

  if cdsGestMese.BookMarkValid(BM) then
    cdsGestMese.GotoBookmark(BM);

  cdsGestMese.EnableControls;
  cdsGestMese.AfterScroll:=cdsGestMeseAfterScroll;
  cdsGestMeseAfterScroll(nil);
end;

procedure TA023FTimbratureDtM1.ImpostaPickListCausale;
// nella form di gestione mensile imposta la picklist dei codici causale
var
  Index: Integer;
begin
  if A023FGestMese <> nil then
  begin
    Index:=R180GetColonnaDBGrid(A023FGestMese.dgrdGestMese,'CAUSALE');
    A023FGestMese.dgrdGestMese.Columns.Items[Index].PickList.BeginUpdate;
    if cdsGestMese.FieldByName('TIPO').AsString = 'GA' then
      A023FGestMese.dgrdGestMese.Columns.Items[Index].PickList.CommaText:=A023FGestMese.AssPickList
    else
    begin
      if (A023FGestMese.chkEventiStraordinari.Checked) and
         (selT722.Active) and
         (selT722.RecordCount > 0) then
        with A023FGestMese.dgrdGestMese.Columns.Items[Index].PickList do
        begin
          Clear;
          Add(selT722.FieldByName('CAUSALE_STR').AsString);
          if (selT722.FieldByName('CAUSALE_STR_DOM').AsString <> selT722.FieldByName('CAUSALE_STR').AsString) and
             (not selT722.FieldByName('CAUSALE_STR_DOM').IsNull) then
            Add(selT722.FieldByName('CAUSALE_STR_DOM').AsString);
        end
      else
        A023FGestMese.dgrdGestMese.Columns.Items[Index].PickList.CommaText:=A023FGestMese.PresPickList;
    end;
    A023FGestMese.dgrdGestMese.Columns.Items[Index].PickList.EndUpdate;
    selAssPres.Filtered:=False;
    selAssPres.Filtered:=True;
  end;
end;

procedure TA023FTimbratureDtM1.ImpostaPickListServizio;
// nella form di gestione mensile imposta la picklist per la colonna del dato libero "SERVIZIO"
var
  Causale: String;
  Index: Integer;
begin
  if A023FGestMese <> nil then
  begin
    Causale:=Trim(cdsGestMese.FieldByName('CAUSALE').AsString);
    Index:=R180GetColonnaDBGrid(A023FGestMese.dgrdGestMese,'SERVIZIO');
    // se la causale è indicata ed è uguale a quella del periodo di straordinario particolare
    // allora carica la picklist di valori
    if (Causale <> '') and
       (A023FGestMese.chkEventiStraordinari.Checked) and
       (selT722.Active) and
       (selT722.RecordCount > 0) and
       (R180In(Causale,[selT722.FieldByName('CAUSALE_STR').AsString,selT722.FieldByName('CAUSALE_STR_DOM').AsString])) then
    begin
      with A023FGestMese.dgrdGestMese.Columns.Items[Index].PickList do
      begin
        BeginUpdate;
        if ServiziEventiStr = '*' then
          CommaText:=selT722.FieldByName('SERVIZI').AsString
        else
          CommaText:=R180GetCsvIntersect(selT722.FieldByName('SERVIZI').AsString,ServiziEventiStr);
        EndUpdate;
      end;
    end
    else
    begin
      // pulisce la picklist
      A023FGestMese.dgrdGestMese.Columns.Items[Index].PickList.Clear;
    end;
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseAfterScroll(DataSet: TDataSet);
var
  Tipo,OrdinamentoNew,DescTipoRiga: String;
  YY,MM:Word;
  //Index:Integer;
begin
  // imposta le abilitazioni dei field del dataset
  GestMeseAbilitazioneCampi;

  // ordina le causali in base al tipo riga (presenza/assenza)
  Tipo:=cdsGestMese.FieldByName('TIPO').AsString;
  OrdinamentoNew:='ORDER BY ' + IfThen(Tipo = 'GA','1,2','1 DESC,2');
  if selAssPres.GetVariable('ORDINAMENTO') <> OrdinamentoNew then
  begin
    selAssPres.SetVariable('ORDINAMENTO',OrdinamentoNew);
    selAssPres.Refresh;
  end;

  // elaborazioni della unit di gestione cartellino mensile
  if A023FGestMese <> nil then
  begin
    // imposta la picklist dei codici di causale
    ImpostaPickListCausale;

    // TORINO_COMUNE - commessa 2012/046.ini
    // imposta la picklist del dato libero servizio
    ImpostaPickListServizio;
    // TORINO_COMUNE - commessa 2012/046.fine

    // abilita la duplicazione riga solo se la riga di partenza è originale e non bloccata
    A023FGestMese.actDuplica.Enabled:=cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'A';

    // salva la data attualmente selezionata
    if not cdsGestMese.FieldByName('DATA').IsNull then
      A023FGestMese.DataSelezionata:=cdsGestMese.FieldByName('DATA').AsDateTime;

    // visualizza info tipo riga
    if cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'A' then
      DescTipoRiga:='Automatica'
    else if cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'I' then
      DescTipoRiga:='Inserita manualmente'
    else if cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'B' then
      DescTipoRiga:='Bloccata [' + INFO_RIGA[cdsGestMese.FieldByName('FLAG_RIGA_SUBCOD').AsInteger] + ']'
    else if cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'D' then
      DescTipoRiga:='Duplicata manualmente';
    A023FGestMese.StatusBar1.Panels[1].Text:='Tipo riga: ' + DescTipoRiga;
    A023FGestMese.StatusBar1.Repaint;
  end;

  // elaborazioni sulla unit del cartellino interattivo
  if (A023FTimbrature <> nil) and (cdsGestMese.State = dsBrowse) then
  begin
    with A023FTimbrature do
    begin
      if not cdsGestMese.FieldByName('DATA').IsNull then
      begin
        DecodeDate(cdsGestMese.FieldByName('DATA').AsDateTime,YY,MM,Giorno);
        Giorno:=CalcolaGiorno(Giorno);
        EMese.Value:=MM;
        EAnno.Value:=YY;
        CaricaGriglie;
      end;
    end;
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseBeforeDelete(DataSet: TDataSet);
begin
  // impedisce cancellazione delle righe inserite automaticamente
  if (cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'A') or
     (cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'B') then
    Abort;

  if selT722.Active and (selT722.FieldByName('ID').Value <> selT723.GetVariable('ID')) then
    raise Exception.Create('Selezionare l''Evento Straordinario corrente (doppio click)');

  if R180MessageBox('Confermi la cancellazione della riga?',Domanda) <> mrYes then
    Abort;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseBeforeEdit(DataSet: TDataSet);
begin
  if selT722.Active and (selT722.FieldByName('ID').Value <> selT723.GetVariable('ID')) then
    raise Exception.Create('Selezionare l''Evento Straordinario corrente (doppio click)');
end;

procedure TA023FTimbratureDtM1.cdsGestMeseBeforeInsert(DataSet: TDataSet);
begin
  if not A023FGestMese.CanInsert then
    Abort;

  if selT722.Active and (selT722.FieldByName('ID').Value <> selT723.GetVariable('ID')) then
    raise Exception.Create('Selezionare l''Evento Straordinario corrente (doppio click)');
end;

procedure TA023FTimbratureDtM1.cdsGestMeseBeforePost(DataSet: TDataSet);
var
  Causale,Tipo,TipoCaus,TipoCausDesc,Servizio: String;
  T722Caus,T722CausDom:String;
  Found: Boolean;
  Campo: TField;
begin
  Campo:=nil;
  try
    // controlla il periodo orario
    ValidaPeriodoGestMese(Campo);

    // controlla la causale
    Campo:=cdsGestMese.FieldByName('CAUSALE');
    Causale:=cdsGestMese.FieldByName('CAUSALE').AsString;
    TipoCaus:=cdsGestMese.FieldByName('TIPO').AsString;
    TipoCausDesc:=IfThen(TipoCaus = 'GA','assenza','presenza');
    Servizio:=cdsGestMese.FieldByName('SERVIZIO').AsString;

    if Causale = '' then
    begin
      if Servizio <> '' then
        raise Exception.Create('Impossibile indicare il servizio se non si specifica la causale!');
    end
    else
    begin
      // causale indicata

      if (selT722.Active) and (A023FGestMese.chkEventiStraordinari.Checked) (*and (Causale = selT722.FieldByName('CAUSALE_STR').AsString)*) then
      begin
        T722Caus:=selT722.FieldByName('CAUSALE_STR').AsString;
        T722CausDom:=selT722.FieldByName('CAUSALE_STR_DOM').AsString;
        if T722CausDom = '' then
          T722CausDom:=T722Caus;

        A023FGestMese.R502ProDtM.Conteggi('Cartolina',A023FGestMese.Progressivo,cdsGestMese.FieldByName('DATA').AsDateTime);
        A023FGestMese.R502ProDtM.Q430.Filtered:=True;
        try
          if (A023FGestMese.R502ProDtM.Q430.FieldByName('TGestione').AsString = '1') then
          begin
             if (A023FGestMese.R502ProDtM.gglav = 'si') and (Causale <> T722Caus) then
              raise Exception.Create('Causale non consentita. Utilizzare ' + T722Caus);
             if (A023FGestMese.R502ProDtM.gglav = 'no') and (Causale <> T722CausDom) then
              raise Exception.Create('Causale non consentita. Utilizzare ' + T722CausDom);
          end
          else
          begin
            if (DayOfWeek(cdsGestMese.FieldByName('DATA').AsDateTime) <> 1) and
               (Causale <> T722Caus) then
              raise Exception.Create('Causale non consentita. Utilizzare ' + T722Caus);
            if (DayOfWeek(cdsGestMese.FieldByName('DATA').AsDateTime) = 1) and
               (Causale <> T722CausDom) then
              raise Exception.Create('Causale non consentita. Utilizzare ' + T722CausDom);
          end;
        finally
          A023FGestMese.R502ProDtM.Q430.Filtered:=False;
        end;
        if Servizio = '' then
          raise Exception.Create('Il Servizio è obbligatorio per gli eventi straordinari!');
        cdsGestMese.FieldByName('ID_EVENTO_STR').AsInteger:=selT722.FieldByName('ID').AsInteger;
      end;

      // causale non valida
      if TipoCaus = 'GA' then
        Found:=A023FTimbratureMW.Q265.SearchRecord('CODICE',Causale,[srFromBeginning])
      else
        Found:=A023FTimbratureMW.Q275.SearchRecord('CODICE',Causale,[srFromBeginning]);
      if not Found then
        raise Exception.Create('La causale di ' + IfThen(TipoCaus = 'GA','assenza','presenza') + ' indicata non esiste!');
      Tipo:=IfThen(TipoCaus = 'GA','A','P');
      if not selAssPres.SearchRecord('TIPO;CODICE',VarArrayOf([Tipo,Causale]),[srFromBeginning]) then
        raise Exception.Create('La causale di ' + IfThen(TipoCaus = 'GA','assenza','presenza') + ' indicata non è valida!');

      if Servizio <> '' then
        if R180CercaParolaIntera(Servizio,selT722.FieldByName('SERVIZI').AsString,',') <= 0 then
          raise Exception.Create('Il servizio indicato non è tra quelli disponibili!');
    end;
  except
    if Campo <> nil then
      try
        Campo.FocusControl;
      except
      end;
    raise;
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseAfterPost(DataSet: TDataSet);
var
  BM: TBookmark;
begin
  // ripristina abilitazioni campi dopo il post
  GestMeseAbilitazioneCampi;

  BM:=cdsGestMese.GetBookmark;
  { DONE : TEST IW 15 }
  try
    // se il dataset è filtrato -> riassegna la colorazione alla grid
    with cdsGestMese do
    begin
      if Filtered then
      begin
        DisableControls;
        AfterScroll:=nil;
        A023FGestMese.AssegnaColoriGrid;
        AfterScroll:=A023FTimbratureDtM1.cdsGestMeseAfterScroll;
        EnableControls;
      end;
    end;
    
    // ricalcola i totali ore per le causali presenti
    A023FGestMese.TotalizzaPeriodo;
    
    with cdsGestMese do
    begin
      if BM <> nil then
      begin
        if BookMarkValid(BM) then
          GotoBookmark(BM)
        else
          First;
      end;
    end;	  
  finally
    cdsGestMese.FreeBookmark(BM);
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseCalcFields(DataSet: TDataSet);
var
  DalleHStr, AlleHStr: String;
  DalleHMin,AlleHMin,DalleOrigMin,AlleOrigMin,Diff,Arr: Integer;
  DataModif,DalleModif,AlleModif,CausaleModif,ServizioModif,Changed: Boolean;
begin
  with cdsGestMese do
  begin
    // trasforma totale lavorato, debito giornaliero e scostamento in formato hh.mm
    FieldByName('C_TOTLAV_H').AsString:=R180MinutiOre(FieldByName('TOTLAV').AsInteger);
    FieldByName('C_DEBITOGG_H').AsString:=R180MinutiOre(FieldByName('DEBITOGG').AsInteger);
    FieldByName('C_SCOST_H').AsString:=R180MinutiOre(FieldByName('SCOST').AsInteger);

    // copia campi in variabili di appoggio
    DalleHStr:=FieldByName('DALLE_H').AsString;
    AlleHStr:=FieldByName('ALLE_H').AsString;
    DalleHMin:=R180OreMinutiExt(DalleHStr);
    AlleHMin:=R180OreMinutiExt(AlleHStr);
    DalleOrigMin:=FieldByName('DALLE_ORIG').AsInteger;
    AlleOrigMin:=FieldByName('ALLE_ORIG').AsInteger;

    // determina se la riga è stata modificata rispetto ai valori originali
    DataModif:=FieldByName('DATA').AsDateTime <> FieldByName('DATA_ORIG').AsDateTime;
    DalleModif:=DalleHMin <> DalleOrigMin;
    AlleModif:=AlleHMin <> AlleOrigMin;
    if FieldByName('CAVALLO_MEZZANOTTE').AsString = 'S' then
      AlleModif:=(AlleOrigMin - AlleHMin) <> 1440;
    CausaleModif:=(FieldByName('CAUSALE').AsString <> FieldByName('CAUSALE_ORIG').AsString);
    // TORINO_COMUNE - commessa 2012/046.ini
    ServizioModif:=(FieldByName('SERVIZIO').AsString <> FieldByName('SERVIZIO_ORIG').AsString);
    // TORINO_COMUNE - commessa 2012/046.fine
    Changed:=(FieldByName('FLAG_RIGA').AsString = 'I') or
             (DataModif or DalleModif or AlleModif or CausaleModif or ServizioModif);
    FieldByName('C_MODIFICATO').AsString:=IfThen(Changed,'S','N');

    // per le causali di straordinario determina l'arrotondamento giornaliero e la parte realmente autorizzata
    if (FieldByName('TIPO').AsString = 'GP') or
       (FieldByName('TIPO').AsString = 'P') and
       (Trim(FieldByName('CAUSALE').AsString) <> '') and
       (FieldByName('CAUSALE').AsString <> A023UGestMese.CAUSALE_MOS) then
    begin
      // estrae l'arrotondamento per la causale di presenza
      A023FTimbratureMW.Q275.SearchRecord('CODICE',FieldByName('CAUSALE').AsString,[srFromBeginning]);
      Arr:=R180OreMinutiExt(A023FTimbratureMW.Q275.FieldByName('ARROT_RIEPGG').AsString);
      FieldByName('C_ARROT_RIEPGG').AsInteger:=IfThen(Arr > 1,Arr,0);

      // corregge periodo dalle - alle
      if AlleHMin < DalleHMin then
        AlleHMin:=AlleHMin + 1440;

      // determina la parte realmente autorizzata
      Diff:=Trunc(R180Arrotonda(Max(AlleHMin - DalleHMin,0),FieldByName('C_ARROT_RIEPGG').AsInteger,'D'));
      FieldByName('C_AUTORIZZATO').AsString:=IfThen(Diff = 0,'',R180MinutiOre(AlleHMin - Diff) + ' - ' + FieldByName('ALLE_H').AsString);
    end
    else
    begin
      FieldByName('C_AUTORIZZATO').AsString:='';
      FieldByName('C_ARROT_RIEPGG').AsInteger:=0;
    end;
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseCAUSALEValidate(Sender: TField);
// controlla la causale indicata
var
  Causale,TipoCaus,Tipo: String;
  Found: Boolean;
begin
  // controlla la causale
  Causale:=cdsGestMese.FieldByName('CAUSALE').AsString;
  TipoCaus:=cdsGestMese.FieldByName('TIPO').AsString;
  if Causale <> '' then
  begin
    // causale non valida
    if TipoCaus = 'GA' then
      Found:=A023FTimbratureMW.Q265.SearchRecord('CODICE',Causale,[srFromBeginning])
    else
      Found:=A023FTimbratureMW.Q275.SearchRecord('CODICE',Causale,[srFromBeginning]);
    if not Found then
      raise Exception.Create('La causale di ' + IfThen(TipoCaus = 'GA','assenza','presenza') +
                             ' indicata non esiste!');
    Tipo:=IfThen(TipoCaus = 'GA','A','P');
    if not selAssPres.SearchRecord('TIPO;CODICE',VarArrayOf([Tipo,Causale]),[srFromBeginning]) then
    begin
      raise Exception.Create('La causale di ' + IfThen(TipoCaus = 'GA','assenza','presenza') + ' indicata non è valida!');
    end
    else if (Tipo = 'P') and (not selT722.Active) and
            selDistT722.SearchRecord('CODICE',Causale,[srFromBeginning]) then
    begin
      raise Exception.Create('La causale indicata è utilizzabile solo per gli Eventi Straordinari!');
    end;

    ImpostaPickListServizio; // TORINO_COMUNE - commessa 2012/046
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseDALLE_HValidate(Sender: TField);
// validazione periodo orario: dalle oppure alle
var Campo: TField;
begin
  Campo:=nil;
  try
    ValidaPeriodoGestMese(Campo);
  except
    if Campo = Sender then
      raise;
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMeseDATAValidate(Sender: TField);
var
  Data,DataOrig: TDateTime;
  OraInizioDefault: Integer;
begin
  // la data può essere una fra le seguenti due:
  // 1. DATA_ORIG
  // 2. DATA_ORIG + 1
  Data:=cdsGestMese.FieldByName('DATA').AsDateTime;
  DataOrig:=cdsGestMese.FieldByName('DATA_ORIG').AsDateTime;
  if (Data <> DataOrig) and (Data <> DataOrig + 1) then
    raise Exception.Create('La data indicata non è valida!');

  // gestione ora inizio default:
  // -> giorno originale:  dalle_orig
  // -> giorno successivo: 00.00
  OraInizioDefault:=IfThen(Data = DataOrig,cdsGestMese.FieldByName('DALLE_ORIG').AsInteger,0);

  // imposta l'ora inizio di default
  cdsGestMese.FieldByName('DALLE_H').OnValidate:=nil;
  cdsGestMese.FieldByName('DALLE_H').AsString:=R180MinutiOre(OraInizioDefault);
  cdsGestMese.FieldByName('DALLE_H').OnValidate:=cdsGestMeseDALLE_HValidate;
end;

procedure TA023FTimbratureDtM1.ValidaPeriodoGestMese(var Campo: TField);
var
  DalleOrig,AlleOrig,Dalle,Alle,LimInf,LimSup,Arrfruiz,MinFruiz: Integer;
  TimeCtrl: TDateTime;
  StringCtrl: String;
  CavalloMezzanotte,DataPosticipata: Boolean;
begin
  // dalle: controllo di validità del dato
  Campo:=cdsGestMese.FieldByName('DALLE_H');
  StringCtrl:=cdsGestMese.FieldByName('DALLE_H').AsString;
  if (Trim(StringCtrl) = '') or (Trim(StringCtrl) = '.') or (Trim(StringCtrl) = ':') then
    raise Exception.Create('Indicare l''ora iniziale!');
  //if not TryStrToTime(StringCtrl,TimeCtrl) then
  //  raise Exception.Create('L''ora iniziale non è valida.');
  try
    R180OraValidate(StringCtrl);
    TimeCtrl:=StrToTime(StringCtrl);
  except
    on E:Exception do
      raise Exception.Create('L''ora iniziale non è valida.' + #13#10 + E.Message);
  end;
  Dalle:=R180OreMinuti(TimeCtrl);

  // alle: controllo di validità del dato
  Campo:=cdsGestMese.FieldByName('ALLE_H');
  StringCtrl:=cdsGestMese.FieldByName('ALLE_H').AsString;
  if (Trim(StringCtrl) = '') or (Trim(StringCtrl) = '.') or (Trim(StringCtrl) = ':') then
    raise Exception.Create('Indicare l''ora finale!');
  //if not TryStrToTime(StringCtrl,TimeCtrl) then
  //  raise Exception.Create('L''ora finale non è valida.');
  try
    R180OraValidate(StringCtrl);
    TimeCtrl:=StrToTime(StringCtrl);
  except
    on E:Exception do
      raise Exception.Create('L''ora finale non è valida.' + #13#10 + E.Message);
  end;
  Alle:=R180OreMinuti(TimeCtrl);

  // variabili di appoggio
  CavalloMezzanotte:=cdsGestMese.FieldByName('CAVALLO_MEZZANOTTE').AsString = 'S';
  DataPosticipata:=cdsGestMese.FieldByName('DATA').AsDateTime <> cdsGestMese.FieldByName('DATA_ORIG').AsDateTime;
  DalleOrig:=cdsGestMese.FieldByName('DALLE_ORIG').AsInteger;
  AlleOrig:=cdsGestMese.FieldByName('ALLE_ORIG').AsInteger;

  // variazioni quando il periodo originale è a cavallo di mezzanotte
  if CavalloMezzanotte then
  begin
   if DataPosticipata then
   begin
     // la data è stata posticipata -> alleorig viene ridotto di 1440 minuti
     DalleOrig:=0;
     AlleOrig:=AlleOrig - 1440;
   end
   else
   begin
     // se periodo non è in sequenza prova a spostare ora fine di 24h
     if (Dalle > Alle) then
       Alle:=Alle + 1440;
   end;
  end;
  
  // dalle: controllo rispetto limiti
  //        se Data è quella originale -> compreso fra [DalleOrig .. AlleOrig - 1]
  Campo:=cdsGestMese.FieldByName('DALLE_H');
  LimInf:=DalleOrig;
  LimSup:=Min(1440,AlleOrig) - 1;
  ArrFruiz:=0;
  MinFruiz:=0;
  if (cdsGestMese.FieldByName('TIPO').AsString = 'GA') and (cdsGestMese.FieldByName('CAUSALE').AsString <> '') and A023FTimbratureMW.Q265.SearchRecord('CODICE',cdsGestMese.FieldByName('CAUSALE').AsString,[srFromBeginning]) then
  begin
    ArrFruiz:=IfThen(A023FTimbratureMW.Q265.FieldByName('FRUIZCOMPETENZE_ARR').AsString = 'N',A023FTimbratureMW.Q265.FieldByName('FRUIZ_ARR').AsInteger,0);
    MinFruiz:=A023FTimbratureMW.Q265.FieldByName('FRUIZ_MIN').AsInteger;
  end;
  if ((ArrFruiz > 1) and ((LimSup + 1 - LimInf) mod ArrFruiz <> 0)) or
     ((MinFruiz > 0) and (LimSup + 1 - LimInf < MinFruiz)) then
  begin
    if (Dalle >= LimSup + 1) or (Alle <= LimInf) then
      raise Exception.Create('Il periodo dalle/alle indicato deve intersecare il periodo ' +
                             R180MinutiOre(LimInf) + ' - ' + R180MinutiOre(LimSup + 1) + '.');
  end
  else
  begin
    if (Dalle < LimInf) or (Dalle > LimSup) then
      raise Exception.Create('L''ora iniziale deve essere compresa nel periodo ' +
                             R180MinutiOre(LimInf) + ' - ' + R180MinutiOre(LimSup) + '.' +
                             IfThen(cdsGestMese.FieldByName('CAUSALE').AsString = '',#13#10 + 'Eventualmente valorizzare la causale prima di impostare l''intervallo.',''));

    // alle: controllo rispetto limiti
    //         -> deve essere compreso fra [Max(Dalle,DalleOrig) + 1..AlleOrig]
    Campo:=cdsGestMese.FieldByName('ALLE_H');
    LimInf:=Max(Dalle,DalleOrig) + 1;
    LimSup:=AlleOrig;
    if (Alle < LimInf) or (Alle > LimSup) then
      raise Exception.Create('L''ora finale deve essere compresa nel periodo ' +
                             R180MinutiOre(LimInf) + ' - ' +
                             R180MinutiOre(IfThen(LimSup >= 1440,LimSup - 1440,LimSup)) + '.' +
                             IfThen(cdsGestMese.FieldByName('CAUSALE').AsString = '',#13#10 + 'Eventualmente valorizzare la causale prima di impostare l''intervallo.',''));
  end;
  // coerenza dalle - alle
  if Dalle > Alle then
    raise Exception.Create('Il periodo dalle/alle indicato non è valido!');
end;

procedure TA023FTimbratureDtM1.cdsGestMeseFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  Diff: Integer;
begin
  Accept:=True;
  // Gestione filtri
  // (in aggiunta al filtro impostato nella funzione A023FGestMese.ApplicaFiltri)
  try
    try
      if A023FGestMese.Filtro.SogliaDalleAlle > -1 then
      begin
        // filtro sul periodo dalle-alle
        Diff:=R180OreMinutiExt(cdsGestMese.FieldByName('ALLE_H').AsString) -
              R180OreMinutiExt(cdsGestMese.FieldByName('DALLE_H').AsString);
        // correzione per periodi a cavallo di mezzanotte
        if Diff < 0 then
          Diff:=Diff + 1440;
        Accept:=Diff > A023FGestMese.Filtro.SogliaDalleAlle;
      end;
    except
      Accept:=True;
    end;
  finally
    // filtro sulle righe di straordinario solo causalizzate
    if A023FGestMese.Filtro.SoloStraordCaus then
    begin
      if (cdsGestMese.FieldByName('TIPO').AsString = 'P') and
         ((cdsGestMese.FieldByName('CAUSALE').AsString = '') or
          (cdsGestMese.FieldByName('CAUSALE').AsString = A023UGestMese.CAUSALE_MOS)) then
        Accept:=False;
    end;
  end;
end;

procedure TA023FTimbratureDtM1.cdsGestMesePostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  if (cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'A') or
     (cdsGestMese.FieldByName('FLAG_RIGA').AsString = 'B') then
  begin
    // inserimento automatico: blocca il post senza dare segnalazioni
    Action:=daAbort;
  end
  else
  begin
    // inserimento manuale: se chiave duplicata segnala errore specifico
    Action:=daAbort;
    if (E.ClassName = 'EDBClient') then
    begin
      // errore specifico se chiave duplicata
      if (Pos('Key violation',E.Message) > 0) or
         (EDBClient(E).ErrorCode = 9729) then
      begin
        cdsGestMese.FieldByName('DALLE_H').FocusControl;
        R180MessageBox('Attenzione! Riga già presente in tabella!'#13#10 +
                       'Modificare il periodo oppure premere Esc per annullare l''inserimento.',INFORMA);
        Exit;
      end;
    end;
    R180MessageBox(E.Message + ' (' + E.ClassName + ')',INFORMA);
  end;
end;

procedure TA023FTimbratureDtM1.delT320BeforeQuery(Sender: TOracleQuery);
begin
  RegistraLog.SettaProprieta('C','T320_PIANLIBPROFESSIONE',Copy(Name,1,4),nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(delT320.GetVariable('PROGRESSIVO')),'');
  RegistraLog.InserisciDato('PERIODO',DateToStr(delT320.GetVariable('DATA_INIZIO')) + ' - ' + DateToStr(delT320.GetVariable('DATA_FINE')),'');
end;

procedure TA023FTimbratureDtM1.delT320AfterQuery(Sender: TOracleQuery);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA023FTimbratureDtM1.insT320BeforeQuery(Sender: TOracleQuery);
begin
  RegistraLog.SettaProprieta('I','T320_PIANLIBPROFESSIONE',Copy(Name,1,4),nil,True);
  RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(insT320.GetVariable('PROGRESSIVO')));
  RegistraLog.InserisciDato('DATA','',DateToStr(insT320.GetVariable('DATA')));
  RegistraLog.InserisciDato('DALLE','',insT320.GetVariable('DALLE'));
  RegistraLog.InserisciDato('ALLE','',insT320.GetVariable('ALLE'));
  RegistraLog.InserisciDato('CAUSALE','',insT320.GetVariable('CAUSALE'));
end;

procedure TA023FTimbratureDtM1.insT320AfterQuery(Sender: TOracleQuery);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA023FTimbratureDtM1.selAssPresFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if DataSet.FieldByName('TIPO').AsString = 'A' then
    Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
  else
  begin
    Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
    if Accept and selT722.Active then
      Accept:=R180In(DataSet.FieldByName('CODICE').AsString,[selT722.FieldByName('CAUSALE_STR').AsString,selT722.FieldByName('CAUSALE_STR_DOM').AsString]);
  end;
end;

procedure TA023FTimbratureDtM1.Q100RILEVATOREChange(Sender: TField);
begin
  if A023FTimbratureMW.Q361.SearchRecord('CODICE',A023FTimbratureMW.Q100.FieldByName('Rilevatore').AsString,[srFromBeginning]) then
    A023FGestTimbra.lblDescOrologio.Caption:=A023FTimbratureMW.Q361.FieldByName('DESCRIZIONE').AsString
  else
    A023FGestTimbra.lblDescOrologio.Caption:='';
end;

end.
