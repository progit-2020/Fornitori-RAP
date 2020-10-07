unit A124UPermessiSindacaliMW;

interface

uses
  System.SysUtils, System.Classes, Variants, R005UDataModuleMW, Data.DB, OracleData,
  Oracle, Datasnap.DBClient, DatiBloccati, A000UInterfaccia, A004UGiustifAssPresMW,
  Rp502Pro, R500Lin, C180FunzioniGenerali, A000UMessaggi, StrUtils, System.UITypes, Math;

type
  T124Dlg = procedure(msg,Chiave:String) of object;

  TDatiColl = record
    Data:TDateTime;
    NumeroProt:String;
    DataProt:TDateTime;
    Dalle,
    Alle,
    Ore,
    TipoPermesso,
    AbbatteCompetenze,
    CodSindacato,
    CodOrganismo,
    Stato,
    ProtModifica:String;
    DataModifica:TDateTime;
  end;

  TA124FPermessiSindacaliMW = class(TR005FDataModuleMW)
    Q040: TOracleDataSet;
    Q100: TOracleDataSet;
    Q100PROGRESSIVO: TFloatField;
    Q100DATA: TDateTimeField;
    Q100ORA: TDateTimeField;
    Q100VERSO: TStringField;
    Q100FLAG: TStringField;
    Q100RILEVATORE: TStringField;
    Q100CAUSALE: TStringField;
    Q275: TOracleDataSet;
    Q305: TOracleDataSet;
    selAssenza: TOracleQuery;
    selPermessi: TOracleDataSet;
    insT040: TOracleQuery;
    selT240Filtro: TOracleDataSet;
    selV010: TOracleDataSet;
    cdsT248: TClientDataSet;
    cdsT248PROGRESSIVO: TIntegerField;
    cdsT248DATA: TDateField;
    cdsT248NUMERO_PROT: TStringField;
    cdsT248DATA_PROT: TDateField;
    cdsT248DALLE: TStringField;
    cdsT248ALLE: TStringField;
    cdsT248ORE: TStringField;
    cdsT248ABBATTE_COMPETENZE: TStringField;
    cdsT248COD_SINDACATO: TStringField;
    cdsT248COD_ORGANISMO: TStringField;
    cdsT248STATO: TStringField;
    cdsT248PROT_MODIFICA: TStringField;
    cdsT248DATA_MODIFICA: TDateField;
    cdsT248RSU: TStringField;
    cdsT248RAGGRUPPAMENTO: TStringField;
    cdsT248SINDACATI_RAGGRUPPATI: TStringField;
    cdsT248TIPO_PERMESSO: TStringField;
    cdsT248PROG_PERMESSO: TIntegerField;
    dsrT240C: TDataSource;
    selT240C: TOracleDataSet;
    selCompetenze: TOracleDataSet;
    selCompetenzeAREA_SINDACALE: TStringField;
    selCompetenzeTIPO: TStringField;
    selCompetenzeDECORRENZA: TDateTimeField;
    selCompetenzeSCADENZA: TDateTimeField;
    selCompetenzeCOMPETENZA: TStringField;
    selCompetenzeFRUITO: TStringField;
    selCompetenzeRESIDUO: TStringField;
    dsrCompetenze: TDataSource;
    selT245: TOracleDataSet;
    dsrT245: TDataSource;
    selT240: TOracleDataSet;
    dsrT240: TDataSource;
    selT248Canc: TOracleDataSet;
    selT247InsColl: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsT248AfterScroll(DataSet: TDataSet);
    procedure cdsT248NewRecord(DataSet: TDataSet);
    procedure selT240AfterOpen(DataSet: TDataSet);
    procedure selT240FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    {private}
    R502ProDtM1:TR502ProDtM1;
  public
    A004MW: TA004FGiustifAssPresMW;
    selT248: ToracleDataSet;
    DataSetInUso: TDataSet;
    AbbatteCompetenze, Nominativo: String;
    Azione,SuperoCompetResiduo:String;
    Compet, SelezioneCollettiva: boolean;
    Conta:Integer;
    ProceduraChiamante,OldProg:Integer;
    selDatiBloccati:TDatiBloccati;
    evtRichiesta:T124Dlg;
    DatiColl:TDatiColl;
    procedure SelAnagrafeOnFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT248AfterScroll;
    procedure selT248NewRecord;
    procedure selT248BeforeDelete(DataSet: TDataSet);
    procedure selT248BeforePostNoStorico(DataSet: TDataSet);
    procedure AggiornaSindacatiMC;
    procedure AggiornaSindacati;
    function AggiornaDescrizioni(Tipo,Codice:String;var TipoSind:String):String;
    procedure Competenze;
    procedure Controlli;
    procedure ControlloProgInterno;
    procedure validaOre(Sender: TField);
    procedure ValorizzNumOre;
    procedure RipristinaStatoModificato;
    procedure CopiaPermesso;
    procedure ImpostaFiltroPermessi(PermessiNonCancellati,AnnoCorrente:Boolean);
    procedure PreparaCancellazione;
    procedure PreparaCancellazioneCollettiva(Tipo:String);
    procedure CancellaPermesso;
    procedure ImpostaFiltroInserimentoCollettivo;
    procedure PreparaInserimento;
    procedure PreparaInserimentoCollettivo;
    procedure InserisciPermesso;
    procedure CercaDip(Prog:Integer);
  end;

implementation

{$R *.dfm}

procedure TA124FPermessiSindacaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A004MW:=TA004FGiustifAssPresMW.Create(nil);
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
  selT245.Open;

  with A004MW do
  begin
    chkNuovoPeriodo:=False;
    GestioneSingolaDM:=True;
    AnomalieInterattive:=False;
    EseguiCommit:=False;
    //Il Chiamante viene impostato nel DataModulo chiamante (A124/WA124)
    R600DtM1.AnomalieBloccanti:=True;
    R600DtM1.VisualizzaAnomalie:=False;
    R600DtM1.AnomalieNonBloccanti:='';
  end;
end;

procedure TA124FPermessiSindacaliMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A004MW);
  selDatiBloccati.Free;
end;

procedure TA124FPermessiSindacaliMW.cdsT248AfterScroll(DataSet: TDataSet);
begin
  inherited;
  AbbatteCompetenze:=cdsT248.FieldByName('ABBATTE_COMPETENZE').AsString;
  AggiornaSindacatiMC;
end;

procedure TA124FPermessiSindacaliMW.cdsT248NewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsT248.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
  cdsT248.FieldByName('DATA_PROT').AsDateTime:=Parametri.DataLavoro;
  cdsT248.FieldByName('DATA_MODIFICA').AsDateTime:=Parametri.DataLavoro;
  cdsT248.FieldByName('ABBATTE_COMPETENZE').AsString:='S';
  cdsT248.FieldByName('STATO').AsString:='O';
  cdsT248.FieldByName('TIPO_PERMESSO').AsString:='D';
  cdsT248.FieldByName('PROG_PERMESSO').AsInteger:=0;
  if selT240C.RecordCount = 1 then
    cdsT248.FieldByName('COD_SINDACATO').AsString:=selT240C.FieldByName('CODICE').AsString
  else
    cdsT248.FieldByName('COD_SINDACATO').AsString:='';
end;

procedure TA124FPermessiSindacaliMW.selT240AfterOpen(DataSet: TDataSet);
var
  SegnaLibro:TBookmark;
begin
  inherited;
  selT240.DisableControls;
  SegnaLibro:=selT240.GetBookmark;
  try { TODO : TEST IW 15 }
    selT240Filtro.SQL.Clear;
    selT240Filtro.SQL.Add('SELECT '' '' SINDACATO FROM DUAL WHERE :PROGRESSIVO = :PROGRESSIVO AND :DATA = :DATA');
    while not selT240.Eof do
    begin
      if (not selT240.FieldByName('FILTRO').IsNull) and
         ((selT240.FieldByName('RAGGRUPPAMENTO').AsString = 'S') or (selT240.FieldByName('RSU').AsString = 'S')) then
      begin
        selT240Filtro.SQL.Add('UNION');
        selT240Filtro.SQL.Add('SELECT ''' + selT240.FieldByName('CODICE').AsString + ''' FROM T030_ANAGRAFICO T030, T430_STORICO T430, P430_ANAGRAFICO P430');
        selT240Filtro.SQL.Add('WHERE T030.PROGRESSIVO = T430.PROGRESSIVO AND :PROGRESSIVO = T030.PROGRESSIVO AND :DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE AND');
        selT240Filtro.SQL.Add(selT240.FieldByName('FILTRO').AsString);
      end;
      selT240.Next;
    end;
    selT240.First;
    selT240.EnableControls;
    selT240.GotoBookmark(SegnaLibro);
  finally
    selT240.FreeBookmark(SegnaLibro);
  end;
  selT240Filtro.Close;
  selT240Filtro.SetVariable('PROGRESSIVO',ProgressivoC700);
  selT240Filtro.SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
  selT240Filtro.Open;
end;

procedure TA124FPermessiSindacaliMW.selT240FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=(selT240.FieldByName('RAGGRUPPAMENTO').AsString = 'N') or selT240.FieldByName('FILTRO').IsNull;
  if Accept then
    exit;
  Accept:=selT240Filtro.SearchRecord('SINDACATO',selT240.FieldByName('CODICE').AsString,[srFromBeginning]);
end;

procedure TA124FPermessiSindacaliMW.SelAnagrafeOnFilterRecord(DataSet:TDataSet;var Accept:Boolean);
begin
  Accept:=selT247InsColl.SearchRecord('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning])
end;

procedure TA124FPermessiSindacaliMW.selT248AfterScroll;
begin
  inherited;
  AbbatteCompetenze:=DataSetInUso.FieldByName('ABBATTE_COMPETENZE').AsString;
  if SelezioneCollettiva then
    AggiornaSindacatiMC
  else
  begin
    AggiornaSindacati;
    if Compet then
      Competenze;
  end;
end;

procedure TA124FPermessiSindacaliMW.selT248NewRecord;
begin
  inherited;
  selT248.FieldByName('PROGRESSIVO').AsInteger:=ProgressivoC700;
  selT248.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
  selT248.FieldByName('DATA_PROT').AsDateTime:=Parametri.DataLavoro;
  selT248.FieldByName('DATA_MODIFICA').AsDateTime:=Parametri.DataLavoro;
  selT248.FieldByName('PROG_PERMESSO').AsInteger:=0;
  if selT240.RecordCount = 1 then
    selT248.FieldByName('COD_SINDACATO').AsString:=selT240.FieldByName('CODICE').AsString
  else
    selT248.FieldByName('COD_SINDACATO').AsString:='';
  selT248.FieldByName('COD_ORGANISMO').AsString:='';
end;

procedure TA124FPermessiSindacaliMW.selT248BeforeDelete(DataSet: TDataSet);
var j:Integer;
begin
  inherited;
  // Giustificativi: controllo blocco cancellazione
  if selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').medpOldValue,R180InizioMese(DataSet.FieldByName('DATA').medpOldValue),'T040') then
    if SelezioneCollettiva then
    begin
      RegistraMsg.InserisciMessaggio('B',selDatiBloccati.MessaggioLog,'',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
      Abort;
    end
    else
      raise Exception.Create(selDatiBloccati.MessaggioLog);

  //Cancellazione su A004
  A004MW.R600DtM1.AnomalieBloccanti:=True;
  A004MW.R600DtM1.VisualizzaAnomalie:=False;
  A004MW.R600DtM1.AnomalieNonBloccanti:='';
  with A004MW do
  begin
    Var_Gestione:=0;
    Var_TipoGiust_Count:=4;
    Var_NumGG:=0;
    Var_Familiari:='';
    Var_TipoCaus:=1;
    if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'I' then
      Var_TipoGiust:=0
    else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'M' then
      Var_TipoGiust:=1
    else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'N' then
      Var_TipoGiust:=2
    else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'D' then
      Var_TipoGiust:=3;
    if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'N' then
      Var_DaOre:=VarToStr(DataSet.FieldByName('ORE').medpOldValue)
    else
      Var_DaOre:=VarToStr(DataSet.FieldByName('DALLE').medpOldValue);
    Var_AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
    Var_DaData:=DataSet.FieldByName('DATA').medpOldValue;
    Var_AData:=DataSet.FieldByName('DATA').medpOldValue;
    Var_Progressivo:=DataSet.FieldByName('PROGRESSIVO').medpOldValue;
    selAssenza.SetVariable('TIPO',DataSet.FieldByName('ABBATTE_COMPETENZE').medpOldValue);
    selAssenza.SetVariable('SINDACATO',DataSet.FieldByName('COD_SINDACATO').medpOldValue);
    selAssenza.SetVariable('DATA',DataSet.FieldByName('DATA').medpOldValue);
    selAssenza.Execute;
    Var_Causale:=VarToStr(selAssenza.Field('CAUSALE'));
    if Var_Causale <> '' then
    begin
      Q040.Close;
      Q040.SetVariable('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
      Q040.Open;
      Giustif.Causale:=Var_Causale;
      Giustif.Inserimento:=False;
      Giustif.Modo:=R180CarattereDef(VarToStr(DataSet.FieldByName('TIPO_PERMESSO').medpOldValue),1,#0);
      Giustif.DaOre:=Var_DaOre;
      Giustif.AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
      DataInizioOrig:=DataSet.FieldByName('DATA').medpOldValue;
      DataInizio:=DataSet.FieldByName('DATA').medpOldValue;
      DataFine:=DataSet.FieldByName('DATA').medpOldValue;
      try
        CancellaGiustif(False,False);
      except
        on E:Exception do
        begin
          if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + E.Message,Parametri.Azienda,Var_Progressivo);
            Abort;
          end
          else
            raise Exception.Create('Anomalia bloccante: ' + E.Message);
        end;
      end;
      for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
      begin
        if SelezioneCollettiva then
        begin
          RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j],Parametri.Azienda,Var_Progressivo);
          Abort;
        end
        else
          raise Exception.Create('Anomalia bloccante: ' + R600DtM1.ListAnomalie[j]);
      end;
      for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
        RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j],Parametri.Azienda,Var_Progressivo);
    end
    else if DataSet.FieldByName('COD_SINDACATO').medpOldValue <> '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_SINDACATO_NO_CAUS,[VarToStr(DataSet.FieldByName('COD_SINDACATO').medpOldValue)]),'',Var_Progressivo);
  end;
end;

procedure TA124FPermessiSindacaliMW.selT248BeforePostNoStorico(DataSet: TDataSet);
var j:Integer;
begin
  // Controllo competenze
  if (DataSet.FieldByName('ABBATTE_COMPETENZE').AsString = 'S') and
    (((DataSet.State = dsEdit) and (Azione = 'M')) or
     (DataSet.State = dsInsert)) then
  begin
    Competenze;
    with selCompetenze do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        if Trim(selCompetenze.FieldByName('RESIDUO').AsString) <> '' then
          if R180OreMinutiExt(DataSet.FieldByName('ORE').AsString) > R180OreMinutiExt(selCompetenze.FieldByName('RESIDUO').AsString) then
          begin
            if SelezioneCollettiva then
            begin
              SuperoCompetResiduo:=selCompetenze.FieldByName('RESIDUO').AsString;
              if not Compet then
                selCompetenze.Close;
              Abort;
            end
            else
              raise exception.Create(A000MSG_A124_ERR_COMP_SUPERATE);
          end;
        Next;
      end;
      EnableControls;
    end;
  end;
  if not Compet then
    selCompetenze.Close;
  // Valorizzazione stato
  if (DataSet.State = dsEdit) and
     (Trim(DataSet.FieldByName('PROT_MODIFICA').AsString) <> '') then
    if Azione = 'M' then
      DataSet.FieldByName('STATO').AsString:='M'
    else if Azione = 'C' then
      DataSet.FieldByName('STATO').AsString:='C';
  // Giustificativi: controllo blocco
  if selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataSet.FieldByName('DATA').AsDateTime),'T040') then
    if SelezioneCollettiva then
    begin
      RegistraMsg.InserisciMessaggio('B',selDatiBloccati.MessaggioLog,'',DataSet.FieldByName('PROGRESSIVO').AsInteger);
      Abort;
    end
    else
      raise exception.Create(selDatiBloccati.MessaggioLog);
  if DataSet.State <> dsInsert then
    if selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').medpOldValue,R180InizioMese(DataSet.FieldByName('DATA').medpOldValue),'T040') then
      if SelezioneCollettiva then
      begin
        RegistraMsg.InserisciMessaggio('B',selDatiBloccati.MessaggioLog,'',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
        Abort;
      end
      else
        raise exception.Create(selDatiBloccati.MessaggioLog);
  //Inserimento su A004
  with A004MW do
  begin
    Var_Gestione:=0;
    Var_TipoGiust_Count:=4;
    Var_NumGG:=0;
    Var_Familiari:='';
    Var_TipoCaus:=1;
    if DataSet.State <> dsInsert then //Cancella
    begin
      if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'I' then
        Var_TipoGiust:=0
      else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'M' then
        Var_TipoGiust:=1
      else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'N' then
        Var_TipoGiust:=2
      else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'D' then
        Var_TipoGiust:=3;
      if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'N' then
        Var_DaOre:=VarToStr(DataSet.FieldByName('ORE').medpOldValue)
      else
        Var_DaOre:=VarToStr(DataSet.FieldByName('DALLE').medpOldValue);
      Var_AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
      Var_DaData:=DataSet.FieldByName('DATA').medpOldValue;
      Var_AData:=DataSet.FieldByName('DATA').medpOldValue;
      Var_Progressivo:=DataSet.FieldByName('PROGRESSIVO').medpOldValue;
      selAssenza.SetVariable('TIPO',DataSet.FieldByName('ABBATTE_COMPETENZE').medpOldValue);
      selAssenza.SetVariable('SINDACATO',DataSet.FieldByName('COD_SINDACATO').medpOldValue);
      selAssenza.SetVariable('DATA',DataSet.FieldByName('DATA').medpOldValue);
      selAssenza.Execute;
      Var_Causale:=VarToStr(selAssenza.Field('CAUSALE'));
      if Var_Causale <> '' then
      begin
        Q040.Close;
        Q040.SetVariable('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
        Q040.Open;
        Giustif.Causale:=Var_Causale;
        Giustif.Inserimento:=False;
        Giustif.Modo:=R180CarattereDef(VarToStr(DataSet.FieldByName('TIPO_PERMESSO').medpOldValue),1,#0);
        Giustif.DaOre:=Var_DaOre;
        Giustif.AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
        DataInizioOrig:=DataSet.FieldByName('DATA').medpOldValue;
        DataInizio:=DataSet.FieldByName('DATA').medpOldValue;
        DataFine:=DataSet.FieldByName('DATA').medpOldValue;
        try
          CancellaGiustif(False,False);
        except
          on E:Exception do
          begin
            if SelezioneCollettiva then
            begin
              RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + E.Message,Parametri.Azienda,Var_Progressivo);
              Abort;
            end
            else
              raise exception.Create('Anomalia bloccante: ' + E.Message);
          end;
        end;
        for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
        begin
          if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j],Parametri.Azienda,Var_Progressivo);
            Abort;
          end
          else
            raise exception.Create('Anomalia bloccante: ' + R600DtM1.ListAnomalie[j]);
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j],Parametri.Azienda,Var_Progressivo);
      end
      else if DataSet.FieldByName('COD_SINDACATO').medpOldValue <> '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_SINDACATO_NO_CAUS,[VarToStr(DataSet.FieldByName('COD_SINDACATO').medpOldValue)]),'',Var_Progressivo);
    end;
    if DataSet.FieldByName('STATO').AsString <> 'C' then //Inserisci
    begin
      if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'I' then
        Var_TipoGiust:=0
      else if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'M' then
        Var_TipoGiust:=1
      else if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'N' then
        Var_TipoGiust:=2
      else if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'D' then
        Var_TipoGiust:=3;
      if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'N' then
        Var_DaOre:=DataSet.FieldByName('ORE').AsString
      else
        Var_DaOre:=DataSet.FieldByName('DALLE').AsString;
      Var_AOre:=DataSet.FieldByName('ALLE').AsString;
      Var_DaData:=DataSet.FieldByName('DATA').AsString;
      Var_AData:=DataSet.FieldByName('DATA').AsString;
      Var_Progressivo:=DataSet.FieldByName('PROGRESSIVO').AsInteger;
      selAssenza.SetVariable('TIPO',DataSet.FieldByName('ABBATTE_COMPETENZE').AsString);
      selAssenza.SetVariable('SINDACATO',DataSet.FieldByName('COD_SINDACATO').AsString);
      selAssenza.SetVariable('DATA',DataSet.FieldByName('DATA').AsDateTime);
      selAssenza.Execute;
      Var_Causale:='';
      if selAssenza.RowCount > 0 then
        Var_Causale:=VarToStr(selAssenza.Field('CAUSALE'));
      if Var_Causale <> '' then
      begin
        Q040.Close;
        Q040.SetVariable('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger);
        Q040.Open;
        Giustif.Causale:=Var_Causale;
        Giustif.Inserimento:=True;
        Giustif.Modo:=R180CarattereDef(DataSet.FieldByName('TIPO_PERMESSO').AsString,1,#0);
        Giustif.DaOre:=Var_DaOre;
        Giustif.AOre:=DataSet.FieldByName('ALLE').AsString;
        DataInizioOrig:=DataSet.FieldByName('DATA').AsDateTime;
        DataInizio:=DataSet.FieldByName('DATA').AsDateTime;
        DataFine:=DataSet.FieldByName('DATA').AsDateTime;
        try
          InserisciGiustif(False);
        except
          on E:Exception do
          begin
            if SelezioneCollettiva then
            begin
              RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + E.Message,Parametri.Azienda,Var_Progressivo);
              Abort;
            end
            else
              raise Exception.Create('Anomalia bloccante: ' + E.Message);
          end;
        end;
        for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
        begin
          if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j],Parametri.Azienda,Var_Progressivo);
            Abort;
          end
          else
            raise Exception.Create('Anomalia bloccante: ' + R600DtM1.ListAnomalie[j]);
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j],Parametri.Azienda,Var_Progressivo);
      end
      else if DataSet.FieldByName('COD_SINDACATO').AsString <> '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_SINDACATO_NO_CAUS,[DataSet.FieldByName('COD_SINDACATO').AsString]),'',Var_Progressivo);
    end;
  end;
end;

procedure TA124FPermessiSindacaliMW.AggiornaSindacatiMC;
begin
  selT240C.Close;
  selT240C.SetVariable('DATA',DataSetInUso.FieldByName('DATA').AsDateTime);
  selT240C.SetVariable('COMPETENZE',AbbatteCompetenze);
  selT240C.Open;
end;

procedure TA124FPermessiSindacaliMW.AggiornaSindacati;
begin
  selT240.Close;
  selT240.SetVariable('PROGRESSIVO',selT248.FieldByName('PROGRESSIVO').AsInteger);
  selT240.SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
  selT240.SetVariable('COMPETENZE',AbbatteCompetenze);
  selT240.Open;
end;

function TA124FPermessiSindacaliMW.AggiornaDescrizioni(Tipo,Codice:String;var TipoSind:String):String;
var DS:TOracleDataSet;
begin
  Result:='';
  TipoSind:='';//Variabile significativa solo quando si richiama con Tipo 'S'
  if Tipo = 'S' then
  begin
    if SelezioneCollettiva then
      DS:=selT240C
    else
      DS:=selT240;
    if Codice <> '' then
    begin
      if VarToStr(DS.Lookup('CODICE',Codice,'RSU')) = 'S' then
        TipoSind:='RSU'
      else if VarToStr(DS.Lookup('CODICE',Codice,'RAGGRUPPAMENTO')) = 'S' then
        TipoSind:='RAGGRUPPAMENTO'
      else
        TipoSind:='';
      Result:=VarToStr(DS.Lookup('CODICE',Codice,'DESCRIZIONE'));
    end
    else
    begin
      Result:='';
      TipoSind:='';
    end
  end
  else if Tipo = 'O' then
  begin
    DS:=selT245;
    if Codice <> '' then
      Result:=VarToStr(DS.Lookup('CODICE',Codice,'DESCRIZIONE'))
    else
      Result:='';
  end;
end;

procedure TA124FPermessiSindacaliMW.Competenze;
begin
  selCompetenze.Close;
  if selT248.State = dsEdit then //considero o meno il rowid per il controllo delle compet. in modif.
    selCompetenze.SetVariable('NUMRIGA','AND T248.ROWID (+) <> ''' + selT248.RowId + '''')
  else
    selCompetenze.SetVariable('NUMRIGA','');
  selCompetenze.SetVariable('CODICE',selT248.FieldByName('COD_SINDACATO').AsString);
  selCompetenze.SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
  selCompetenze.SetVariable('PROGRESSIVO',selT248.FieldByName('PROGRESSIVO').AsInteger);
  selCompetenze.Open;
end;

procedure TA124FPermessiSindacaliMW.Controlli;
begin
  if (Trim(DataSetInUso.FieldByName('DALLE').AsString) = '') and
    (Trim(DataSetInUso.FieldByName('ALLE').AsString) <> '') then
    raise exception.Create(A000MSG_A124_ERR_NO_DALLE);
  if (Trim(DataSetInUso.FieldByName('DALLE').AsString) <> '') and
    (Trim(DataSetInUso.FieldByName('ALLE').AsString) = '') then
    raise exception.Create(A000MSG_A124_ERR_NO_ALLE);
  if (DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'D') and
    ((Trim(DataSetInUso.FieldByName('DALLE').AsString) = '') or
     (Trim(DataSetInUso.FieldByName('ALLE').AsString) = '')) then
    raise exception.Create(A000MSG_A124_ERR_NO_DALLE_ALLE);
  if Trim(DataSetInUso.FieldByName('ORE').AsString) = '' then
    raise exception.Create(A000MSG_A124_ERR_NO_ORE);
  if Trim(DataSetInUso.FieldByName('COD_SINDACATO').AsString) = '' then
    raise exception.Create(A000MSG_A124_ERR_NO_SINDACATO);
  if Trim(DataSetInUso.FieldByName('COD_ORGANISMO').AsString) = '' then
    raise exception.Create(A000MSG_A124_ERR_NO_ORGANISMO);
  // Controllo protocollo modifica
  if not SelezioneCollettiva then
    if (selT248.FieldByName('STATO').AsString = 'M') and
       (Trim(selT248.FieldByName('PROT_MODIFICA').AsString) = '') then
      raise exception.Create(A000MSG_A124_ERR_NO_NUM_PROTOCOLLO);
end;

procedure TA124FPermessiSindacaliMW.ControlloProgInterno;
begin
  with selPermessi do
  begin
    Close;
    SetVariable('PROG',selT248.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
    SetVariable('ABBATTE',selT248.FieldByName('ABBATTE_COMPETENZE').AsString);
    SetVariable('SINDACATO',selT248.FieldByName('COD_SINDACATO').AsString);
    SetVariable('ORGANISMO',selT248.FieldByName('COD_ORGANISMO').AsString);
    SetVariable('STATO',selT248.FieldByName('STATO').AsString);
    Open;
    First;
    while not Eof do
    begin
      if (FieldByName('TIPO_PERMESSO').AsString = 'I') or
         (FieldByName('TIPO_PERMESSO').AsString = 'M') or
         (FieldByName('TIPO_PERMESSO').AsString = 'N') then
      begin
        if SelezioneCollettiva then
        begin
          RegistraMsg.InserisciMessaggio('A',Nominativo + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE,'',selT248.FieldByName('PROGRESSIVO').AsInteger);
          Abort;
        end
        else
          raise exception.Create(A000MSG_A124_ERR_INSERIMENTO + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE);
      end
      else if FieldByName('TIPO_PERMESSO').AsString = 'D' then
      begin
        if (selT248.FieldByName('TIPO_PERMESSO').AsString = 'I') or
           (selT248.FieldByName('TIPO_PERMESSO').AsString = 'M') or
           (selT248.FieldByName('TIPO_PERMESSO').AsString = 'N') then
        begin
          if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A',Nominativo + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE,'',selT248.FieldByName('PROGRESSIVO').AsInteger);
            Abort;
          end
          else
            raise exception.Create(A000MSG_A124_ERR_INSERIMENTO + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE);
        end
        else  //se permesso dalle-alle
        begin
          if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A',Nominativo + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE,'',selT248.FieldByName('PROGRESSIVO').AsInteger);
            Abort;
          end
          else if (R180OreMinutiExt(selT248.FieldByName('ALLE').AsString) >= R180OreMinutiExt(FieldByName('DALLE').AsString)) and
            (R180OreMinutiExt(selT248.FieldByName('DALLE').AsString) <= R180OreMinutiExt(FieldByName('ALLE').AsString)) then
            raise exception.Create(A000MSG_A124_ERR_INSERIMENTO + ': ' + A000MSG_A124_ERR_PERMESSO_INTERSECA)
          else
            selT248.FieldByName('PROG_PERMESSO').AsInteger:=FieldByName('PROG_PERMESSO').AsInteger + 1;
        end;
      end;
      Next;
    end;
  end;
  if selT248.FieldByName('PROG_PERMESSO').AsInteger > 0 then
    if Assigned(evtRichiesta) then
      evtRichiesta('Attenzione: ' + A000MSG_A124_ERR_PERMESSO_ESISTE + ' Continuare?','EsistePermesso');
end;

procedure TA124FPermessiSindacaliMW.validaOre(Sender: TField);
begin
  inherited;
  if (Sender.IsNull) or (Sender.AsString = '') then exit;
  R180OraValidate(Sender.AsString);
end;

procedure TA124FPermessiSindacaliMW.ValorizzNumOre;
var xx:Integer;
  Assenza:String;
  tgiustific_vuoto:t_tgiustificdipmese;
begin
  if DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'N' then Exit;
  //Valorizzazione Num.Ore in base a Tipo permesso
  if (DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'I') or  //Tipo permesso = Giorn. oppure 1/2 giorn.
     (DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'M') then
  begin
    if (SelezioneCollettiva) or (DataSetInUso.FieldByName('COD_SINDACATO').IsNull) then Exit;
    //Cerco assenza legata al sindacato
    Assenza:='';
    with selAssenza do
    begin
      SetVariable('TIPO',selT248.FieldByName('ABBATTE_COMPETENZE').AsString);
      SetVariable('SINDACATO',selT248.FieldByName('COD_SINDACATO').AsString);
      SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
      Execute;
      if RowsProcessed > 0 then
        Assenza:=VarToStr(Field(0));
    end;
    try
      R502ProDtM1:=TR502ProDtM1.Create(nil);
      with R502ProDtM1 do
      begin
        Chiamante:='Assenze';
        PeriodoConteggi(selT248.FieldByName('DATA').AsDateTime,selT248.FieldByName('DATA').AsDateTime);
        Blocca:=0;
        DataCon:=selT248.FieldByName('DATA').AsDateTime;
        for xx:=1 to MaxGiustif do m_tab_giustificativi[R180Giorno(DataCon),xx]:=tgiustific_vuoto;
        m_tab_giustificativi[R180Giorno(DataCon),1].tcausgius:=Assenza;
        if selT248.FieldByName('TIPO_PERMESSO').AsString = 'I' then
          m_tab_giustificativi[R180Giorno(DataCon),1].ttipogius:='I'
        else
          m_tab_giustificativi[R180Giorno(DataCon),1].ttipogius:='M';
        Conteggi('Assenze',selT248.FieldByName('PROGRESSIVO').AsInteger,selT248.FieldByName('DATA').AsDateTime);
        if Trim(Assenza) = '' then  //se sindacato senza assenza
        begin
          if R502ProDtM1.Blocca = 0 then  //se non ci sono anom.bloccanti --> DebitoGG
          begin
            if selT248.FieldByName('TIPO_PERMESSO').AsString = 'I' then
              selT248.FieldByName('ORE').AsString:=R180MinutiOre(DebitoGG)
            else
              selT248.FieldByName('ORE').AsString:=R180MinutiOre(Trunc(DebitoGG/2))
          end;
        end
        else
        begin  //se sindacato con assenza
          if R502ProDtM1.Blocca = 0 then  //se non ci sono anom.bloccanti --> Valenza gg. assenza
            selT248.FieldByName('ORE').AsString:=R180MinutiOre(triepgiusasse[1].tminvalasse);
        end;
      end;
    finally
      FreeAndNil(R502ProDtM1);
    end;
  end
  else if DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'D' then  //Tipo permesso = Dalle-Alle
  begin
    if (Trim(DataSetInUso.FieldByName('DALLE').AsString) <> '') and
       (Trim(DataSetInUso.FieldByName('ALLE').AsString) <> '') then
       if R180OreMinutiExt(DataSetInUso.FieldByName('ALLE').AsString) < R180OreMinutiExt(DataSetInUso.FieldByName('DALLE').AsString) then
         raise exception.Create(A000MSG_A124_ERR_ALLE_MAGGIORE_DALLE)
       else
         DataSetInUso.FieldByName('ORE').AsString:=R180MinutiOre(R180OreMinutiExt(DataSetInUso.FieldByName('ALLE').AsString) -
                                                      R180OreMinutiExt(DataSetInUso.FieldByName('DALLE').AsString));
  end;
end;

procedure TA124FPermessiSindacaliMW.RipristinaStatoModificato;
begin
  selT248.Edit;
  selT248.FieldByName('STATO').AsString:='M';
  selT248.Post;
  SessioneOracle.Commit;
end;

procedure TA124FPermessiSindacaliMW.CopiaPermesso;
var Progressivo:Integer;
  DataProt,DataMod:TDateTime;
  Prot,Dalle,Alle,Ore,Abbatte,ProtMod,Sindacato,Organismo,TipoPermesso:String;
begin
  if selT248.FieldByName('STATO').AsString = 'C' then
    raise exception.Create(Format(A000MSG_A124_ERR_FMT_PERM_CANCELLATO,['copiare']));
  Progressivo:=selT248.FieldByName('PROGRESSIVO').AsInteger;
  Prot:=selT248.FieldByName('NUMERO_PROT').AsString;
  DataProt:=selT248.FieldByName('DATA_PROT').AsDateTime;
  Dalle:=selT248.FieldByName('DALLE').AsString;
  Alle:=selT248.FieldByName('ALLE').AsString;
  Ore:=selT248.FieldByName('ORE').AsString;
  TipoPermesso:=selT248.FieldByName('TIPO_PERMESSO').AsString;
  Abbatte:=selT248.FieldByName('ABBATTE_COMPETENZE').AsString;
  Sindacato:=selT248.FieldByName('COD_SINDACATO').AsString;
  Organismo:=selT248.FieldByName('COD_ORGANISMO').AsString;
  DataMod:=StrToDate('30/12/1899');
  if selT248.FieldByName('STATO').AsString = 'M' then
  begin
    ProtMod:='';
    DataMod:=StrToDate('30/12/1899');
  end;
  selV010.Close;
  selV010.SetVariable('PROGRESSIVO',Progressivo);
  selV010.SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
  selV010.Open;
  selV010.First;
  selT248.OnNewRecord:=nil;
  selT248.Insert;
  selT248.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
  selT248.FieldByName('DATA').AsDateTime:=selV010.FieldByName('DATA').AsDateTime;
  selT248.FieldByName('NUMERO_PROT').AsString:=Prot;
  selT248.FieldByName('DATA_PROT').AsDateTime:=DataProt;
  selT248.FieldByName('DALLE').AsString:=Dalle;
  selT248.FieldByName('ALLE').AsString:=Alle;
  selT248.FieldByName('ORE').AsString:=Ore;
  selT248.FieldByName('TIPO_PERMESSO').AsString:=TipoPermesso;
  selT248.FieldByName('PROG_PERMESSO').AsInteger:=0;
  selT248.FieldByName('ABBATTE_COMPETENZE').AsString:=Abbatte;
  selT248.FieldByName('COD_SINDACATO').AsString:=Sindacato;
  selT248.FieldByName('COD_ORGANISMO').AsString:=Organismo;
  selT248.FieldByName('STATO').AsString:='O';
  selT248.FieldByName('PROT_MODIFICA').AsString:=ProtMod;
  selT248.FieldByName('DATA_MODIFICA').AsDateTime:=DataMod;
end;

procedure TA124FPermessiSindacaliMW.ImpostaFiltroPermessi(PermessiNonCancellati,AnnoCorrente:Boolean);
var Filtro:String;
begin
  Filtro:='';
  if PermessiNonCancellati then
    Filtro:='(STATO <> ''C'')';
  if PermessiNonCancellati and AnnoCorrente then
    Filtro:=Filtro + ' AND ';
  if AnnoCorrente then
    Filtro:=Filtro + '(DATA >= ' + FloatToStr(EncodeDate(R180Anno(selT248.FieldByName('DATA').AsDateTime),1,1)) + ') AND (DATA <= ' + FloatToStr(EncodeDate(R180Anno(selT248.FieldByName('DATA').AsDateTime),12,31)) + ')';
  selT248.Filter:=Filtro;
  selT248.Filtered:=selT248.Filter <> '';
end;

procedure TA124FPermessiSindacaliMW.PreparaCancellazione;//Usato solo in WIN
begin
  if SelezioneCollettiva then
  begin
    cdsT248.Close;
    cdsT248.CreateDataSet;
    cdsT248.Open;
    cdsT248.Insert;
  end
  else
    selT248.Edit;
end;

procedure TA124FPermessiSindacaliMW.PreparaCancellazioneCollettiva(Tipo:String);
var PosFrom,LungOrderBy:Integer;
    Filtro:String;
begin
  with selT248Canc do
  begin
    Close;
    SetVariable('DATA',DataSetInUso.FieldByName('DATA').AsDateTime);
    SetVariable('DALLE',DataSetInUso.FieldByName('DALLE').AsString);
    SetVariable('ALLE',DataSetInUso.FieldByName('ALLE').AsString);
    SetVariable('ORE',DataSetInUso.FieldByName('ORE').AsString);
    SetVariable('COD_SINDACATO',DataSetInUso.FieldByName('COD_SINDACATO').AsString);
    SetVariable('COD_ORGANISMO',DataSetInUso.FieldByName('COD_ORGANISMO').AsString);
    SetVariable('NUMERO_PROT',DataSetInUso.FieldByName('NUMERO_PROT').AsString);
    SetVariable('DATA_PROT',DataSetInUso.FieldByName('DATA_PROT').AsDateTime);
    SetVariable('ABBATTE',DataSetInUso.FieldByName('ABBATTE_COMPETENZE').AsString);
    SetVariable('TIPO',Tipo);
    SetVariable('PROT_MODIFICA',DataSetInUso.FieldByName('PROT_MODIFICA').AsString);
    SetVariable('DATA_MODIFICA',DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime);
    PosFrom:=Pos('FROM',SelAnagrafe.SQL.Text);
    LungOrderBy:=Pos('ORDER BY',SelAnagrafe.SQL.Text);
    if LungOrderBy <= 0  then
      LungOrderBy:=Length(SelAnagrafe.SQL.Text);
    Filtro:=' (SELECT PROGRESSIVO ' + Copy(SelAnagrafe.SQL.Text,PosFrom,LungOrderBy-PosFrom) + ')';
    Filtro:=StringReplace(UpperCase(Filtro),':DATALAVORO','TO_DATE(''' + DateToStr(Parametri.DataLavoro) + ''',''DD/MM/YYYY'')',[rfReplaceAll]);
    SetVariable('SELC700',Filtro);
    Open;
    if Assigned(evtRichiesta) then
      evtRichiesta(Format(IfThen(Tipo = 'C',A000MSG_A124_DLG_FMT_STATO_CANC_PERMESSO,A000MSG_A124_DLG_FMT_CANC_PERMESSO),[IntToStr(RecordCount)]),'CancellazioneCollettiva');
  end;
end;

procedure TA124FPermessiSindacaliMW.CancellaPermesso;
var Messaggio:String;
begin
  with selT248Canc do
    if VarToStr(GetVariable('TIPO')) = 'C' then
    begin
      Edit;
      FieldByName('STATO').AsString:='C';
      FieldByName('PROT_MODIFICA').AsString:=DataSetInUso.FieldByName('PROT_MODIFICA').AsString;
      FieldByName('DATA_MODIFICA').AsDateTime:=DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime;
      try
        Post;
        Conta:=Conta+1;
      except
        on E:exception do
          Messaggio:=E.Message;
      end;
      if Messaggio <> '' then
        RegistraMsg.InserisciMessaggio('A',Nominativo + ': Aggiornamento fallito - ' + Messaggio,'',FieldByName('PROGRESSIVO').AsInteger);
    end
    else if VarToStr(GetVariable('TIPO')) = 'E' then
    begin
      try
        Delete;
        Conta:=Conta + 1;
      except
        on E:exception do Messaggio:=E.Message;
      end;
      if Messaggio <> '' then
        RegistraMsg.InserisciMessaggio('A',Nominativo + ': Cancellazione fallita - ' + Messaggio,'',FieldByName('PROGRESSIVO').AsInteger);
    end;
end;

procedure TA124FPermessiSindacaliMW.ImpostaFiltroInserimentoCollettivo;
var nDip:Integer;
    Filtro:String;
begin
  Filtro:=VarToStr(selT240c.Lookup('CODICE',DatiColl.CodSindacato,'FILTRO'));//Necessario per Cloud che non si posiziona automaticamente sul selT240c
  selT247InsColl.Close;
  selT247InsColl.SetVariable('DATALAVORO',DatiColl.Data);
  selT247InsColl.SetVariable('FILTRO_T240',IfThen(Filtro <> '','AND ' + StringReplace(Filtro,'T430.','T430',[rfReplaceAll])));
  selT247InsColl.SetVariable('COD_SINDACATO',DatiColl.CodSindacato);
  selT247InsColl.SetVariable('ABBATTE_COMPETENZE',DatiColl.AbbatteCompetenze);
  selT247InsColl.Open;
  OldProg:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  SelAnagrafe.Filtered:=True;
  nDip:=SelAnagrafe.RecordCount;
  SelAnagrafe.Filtered:=False;
  CercaDip(OldProg);
  if Assigned(evtRichiesta) then
    evtRichiesta(Format(A000MSG_A124_DLG_FMT_INS_PERMESSO,[IntToStr(nDip)]),'InserimentoCollettivo');
end;

procedure TA124FPermessiSindacaliMW.PreparaInserimento;//Usato solo in WIN
begin
  if SelezioneCollettiva then
  begin
    cdsT248.Close;
    cdsT248.CreateDataSet;
    cdsT248.Open;
  end;
end;

procedure TA124FPermessiSindacaliMW.PreparaInserimentoCollettivo;
begin
  DatiColl.Data:=DataSetInUso.FieldByName('DATA').AsDateTime;
  DatiColl.NumeroProt:=DataSetInUso.FieldByName('NUMERO_PROT').AsString;
  DatiColl.DataProt:=DataSetInUso.FieldByName('DATA_PROT').AsDateTime;
  DatiColl.Dalle:=DataSetInUso.FieldByName('DALLE').AsString;
  DatiColl.Alle:=DataSetInUso.FieldByName('ALLE').AsString;
  DatiColl.Ore:=DataSetInUso.FieldByName('ORE').AsString;
  DatiColl.TipoPermesso:=DataSetInUso.FieldByName('TIPO_PERMESSO').AsString;
  DatiColl.AbbatteCompetenze:=DataSetInUso.FieldByName('ABBATTE_COMPETENZE').AsString;
  DatiColl.CodSindacato:=DataSetInUso.FieldByName('COD_SINDACATO').AsString;
  DatiColl.CodOrganismo:=DataSetInUso.FieldByName('COD_ORGANISMO').AsString;
  DatiColl.Stato:=DataSetInUso.FieldByName('STATO').AsString;
  DatiColl.ProtModifica:=DataSetInUso.FieldByName('PROT_MODIFICA').AsString;
  DatiColl.DataModifica:=DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime;
end;

procedure TA124FPermessiSindacaliMW.InserisciPermesso;
begin
  with selT248 do
  begin
  //Inserimento in tabella per il dip.corrente del permesso salvato sul ClientDataSet
    Insert;
    FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
    FieldByName('DATA').AsDateTime:=DatiColl.Data;
    FieldByName('NUMERO_PROT').AsString:=DatiColl.NumeroProt;
    FieldByName('DATA_PROT').AsDateTime:=DatiColl.DataProt;
    FieldByName('DALLE').AsString:=DatiColl.Dalle;
    FieldByName('ALLE').AsString:=DatiColl.Alle;
    FieldByName('ORE').AsString:=DatiColl.Ore;
    FieldByName('TIPO_PERMESSO').AsString:=DatiColl.TipoPermesso;
    FieldByName('PROG_PERMESSO').AsInteger:=0;
    FieldByName('ABBATTE_COMPETENZE').AsString:=DatiColl.AbbatteCompetenze;
    FieldByName('COD_SINDACATO').AsString:=DatiColl.CodSindacato;
    FieldByName('COD_ORGANISMO').AsString:=DatiColl.CodOrganismo;
    FieldByName('STATO').AsString:=DatiColl.Stato;
    FieldByName('PROT_MODIFICA').AsString:=DatiColl.ProtModifica;
    FieldByName('DATA_MODIFICA').AsDateTime:=DatiColl.DataModifica;
  end;
end;

procedure TA124FPermessiSindacaliMW.CercaDip(Prog:Integer);
begin
  if Prog <> SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger then
    SelAnagrafe.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]);
  Nominativo:=SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString;
end;

end.
