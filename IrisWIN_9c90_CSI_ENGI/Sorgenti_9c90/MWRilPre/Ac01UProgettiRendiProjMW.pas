unit Ac01UProgettiRendiProjMW;

interface

uses
  System.SysUtils, System.Classes, System.Variants, R005UDataModuleMW, Oracle, Data.DB,
  OracleData, C180FunzioniGenerali, StrUtils, Datasnap.DBClient,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, A000USessione;

type
  T155AggRiep = procedure of object;

  TAc01FProgettiRendiProjMW = class(TR005FDataModuleMW)
    selT751: TOracleDataSet;
    selT751ID: TFloatField;
    selT751DESCRIZIONE: TStringField;
    dsrT751: TDataSource;
    selID_T750: TOracleQuery;
    selT752: TOracleDataSet;
    dsrV430: TDataSource;
    selbV430: TOracleDataSet;
    selbV430MATRICOLA: TStringField;
    selbV430COGNOME: TStringField;
    selbV430NOME: TStringField;
    selbV430PROGRESSIVO: TFloatField;
    dsrT752: TDataSource;
    selT752ORE_MAX: TStringField;
    selT752ID: TFloatField;
    selT755: TOracleDataSet;
    scrT753: TOracleQuery;
    cdsT753: TClientDataSet;
    selT753: TOracleDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField4: TStringField;
    StringField5: TStringField;
    dsrT753: TDataSource;
    selT752ID_T751: TFloatField;
    selT752DESCRIZIONE: TStringField;
    selT751ORE_MAX: TStringField;
    selT751ID_T750: TFloatField;
    selID_T751: TOracleQuery;
    selID_T752: TOracleQuery;
    selFruitoDip: TOracleDataSet;
    selT753ID_T752: TFloatField;
    selT752TOT_ORE_FRUITO: TStringField;
    selT752TOT_ORE_MAX: TStringField;
    selT751TOT_ORE_MAX: TStringField;
    selT751TOT_ORE_FRUITO: TStringField;
    selAssegTas: TOracleDataSet;
    selAssegAtt: TOracleDataSet;
    selAssegPro: TOracleDataSet;
    selT751CODICE: TStringField;
    selT752CODICE: TStringField;
    cdsRiep: TClientDataSet;
    insT752: TOracleQuery;
    insT751: TOracleQuery;
    selbT751: TOracleDataSet;
    selbT752: TOracleDataSet;
    insT753: TOracleQuery;
    selCauIncluse: TOracleDataSet;
    selbT750: TOracleDataSet;
    updCauIncluse: TOracleQuery;
    selT753FUNZIONE: TStringField;
    selT754: TOracleDataSet;
    selT754ID_T750: TFloatField;
    selT754PROGETTO: TStringField;
    selT754PROGRESSIVO: TIntegerField;
    selT754DIPENDENTE: TStringField;
    selT754SERVIZIO: TStringField;
    selT754FUNZIONE: TStringField;
    dsrT754: TDataSource;
    selT753SERVIZIO: TStringField;
    selT756: TOracleDataSet;
    selT756ID_T750: TFloatField;
    selT756PROGETTO: TStringField;
    dsrT756: TDataSource;
    selT756CODICE: TStringField;
    selT756DECORRENZA: TDateTimeField;
    selT756DECORRENZA_FINE: TDateTimeField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT751AfterScroll(DataSet: TDataSet);
    procedure selT751CalcFields(DataSet: TDataSet);
    procedure selT751NewRecord(DataSet: TDataSet);
    procedure selT751BeforePost(DataSet: TDataSet);
    procedure selT751AfterPost(DataSet: TDataSet);
    procedure selT751BeforeDelete(DataSet: TDataSet);
    procedure selT751AfterDelete(DataSet: TDataSet);
    procedure selT751ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selT752AfterScroll(DataSet: TDataSet);
    procedure selT752CalcFields(DataSet: TDataSet);
    procedure selT752NewRecord(DataSet: TDataSet);
    procedure selT752BeforePost(DataSet: TDataSet);
    procedure selT752AfterPost(DataSet: TDataSet);
    procedure selT752BeforeDelete(DataSet: TDataSet);
    procedure selT752AfterDelete(DataSet: TDataSet);
    procedure selT752ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selT753CalcFields(DataSet: TDataSet);
    procedure selT753NewRecord(DataSet: TDataSet);
    procedure selT753BeforePost(DataSet: TDataSet);
    procedure selT753AfterPost(DataSet: TDataSet);
    procedure selT753BeforeDelete(DataSet: TDataSet);
    procedure selT753AfterDelete(DataSet: TDataSet);
    procedure selT753ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selT754CalcFields(DataSet: TDataSet);
    procedure ORE_MAXValidate(Sender: TField);
    procedure selbT750FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT756CalcFields(DataSet: TDataSet);
    procedure selT756NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    AggiornaFD:Boolean;
    procedure AperturaDipendenti;
    procedure ControlliRichieste(Azione:String;Id_T750,Id_T751,Id_T752,Prog:Integer);
    procedure ControlliIntersezioneDate;
  public
    { Public declarations }
    selT750:TOracleDataSet;
    lstCod,lstCodPro,lstCodAtt,lstCodTas:TStringList;
    AggiornaRiepilogo: T155AggRiep;
    AggiornaColoreRiepilogo: T155AggRiep;
    procedure selT750AfterScroll;
    function OnFilterRecord(DataSet: TDataSet): Boolean;
    procedure selT750OnCalcFields;
    procedure selT750OnNewRecord;
    procedure selT750BeforePost1(Storicizzazione:Boolean);
    procedure selT750BeforePost2(Storicizzazione:Boolean);
    procedure selT750AfterPost;
    procedure selT750BeforeDelete;
    procedure OreValidate(Ore:String);
    procedure CaricaDettDip;
    procedure CaricaListaCod(ODS:TOracleDataSet);
    procedure ModificaRiepilogo(ODS:TOracleDataSet);
    procedure ControlloSuperamentoLimiti(ODS:TOracleDataSet);
    procedure RecuperaProgetti;
    procedure RiportaCausali;
    procedure RecuperaAttivita;
    procedure DuplicaTask;
    procedure RecuperaTask;
    procedure DuplicaDipendente;
    procedure CreaReportingPeriod;
    function ControllaReportingPeriod:String;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TAc01FProgettiRendiProjMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  cdsT753.CreateDataSet;
  cdsRiep.CreateDataSet;
  lstCod:=TStringList.Create;
  lstCodPro:=TStringList.Create;
  lstCodPro.StrictDelimiter:=True;
  lstCodAtt:=TStringList.Create;
  lstCodAtt.StrictDelimiter:=True;
  lstCodTas:=TStringList.Create;
  lstCodTas.StrictDelimiter:=True;
  selCauIncluse.Open;
end;

procedure TAc01FProgettiRendiProjMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(lstCod);
  FreeAndNil(lstCodPro);
  FreeAndNil(lstCodAtt);
  FreeAndNil(lstCodTas);
end;

procedure TAc01FProgettiRendiProjMW.selT750AfterScroll;
begin
  AperturaDipendenti;
  selT756.Close;
  selT756.SetVariable('ID',selT750.FieldByName('ID').AsInteger);
  selT756.Open;
  selT754.Close;
  selT754.SetVariable('ID',selT750.FieldByName('ID').AsInteger);
  selT754.Open;
  selT753.Close;
  selT753.SetVariable('ID',0);
  selT753.Open;
  selT752.Close;
  selT752.SetVariable('ID',0);
  selT752.Open;
  selT751.Close;
  selT751.SetVariable('ID',selT750.FieldByName('ID').AsInteger);
  selT751.Open;
  AggiornaRiepilogo;
end;

function TAc01FProgettiRendiProjMW.OnFilterRecord(DataSet: TDataSet): Boolean;
begin
  Result:=A000FiltroDizionario('PROGETTI RENDICONTABILI',DataSet.FieldByName('ID').AsString);
end;

procedure TAc01FProgettiRendiProjMW.selT750OnCalcFields;
begin
  selAssegPro.Close;
  selAssegPro.SetVariable('ID_T750',selT750.FieldByName('ID').AsInteger);
  selAssegPro.Open;
  selT750.FieldByName('TOT_ORE_MAX').AsString:=selAssegPro.FieldByName('ORE_ASSEG').AsString;
  selFruitoDip.Close;
  selFruitoDip.SetVariable('ID_T750',selT750.FieldByName('ID').AsInteger);
  selFruitoDip.SetVariable('ID_T751',0);
  selFruitoDip.SetVariable('ID_T752',0);
  selFruitoDip.Open;
  selT750.FieldByName('TOT_ORE_FRUITO').AsString:=selFruitoDip.FieldByName('ORE_FRUITO_DIP').AsString;
end;

procedure TAc01FProgettiRendiProjMW.selT750OnNewRecord;
begin
  selT750.FieldByName('DECORRENZA').AsDateTime:=EncodeDate(R180Anno(Parametri.DataLavoro),1,1);
  selT750.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(R180Anno(Parametri.DataLavoro),12,31);
  selT750.FieldByName('ORE_MAX').AsString:='00.00';
end;

procedure TAc01FProgettiRendiProjMW.selT750BeforePost1(Storicizzazione:Boolean);
begin
  if Trim(selT750.FieldByName('CODICE').AsString) = '' then
    raise exception.Create(A000MSG_Ac01_ERR_NO_COD_PROGETTO);
  if not selT750.FieldByName('CHIUSURA_DAL').IsNull
  or not selT750.FieldByName('CHIUSURA_AL').IsNull then
  begin
    if selT750.FieldByName('CHIUSURA_DAL').IsNull
    or selT750.FieldByName('CHIUSURA_AL').IsNull then
      raise exception.Create(A000MSG_Ac01_ERR_CHIUSURA_INCOMPLETA);
    if not Storicizzazione and
    (   (selT750.FieldByName('CHIUSURA_DAL').AsDateTime < selT750.FieldByName('DECORRENZA').AsDateTime)
     or (selT750.FieldByName('CHIUSURA_AL').AsDateTime > selT750.FieldByName('DECORRENZA_FINE').AsDateTime)) then
      raise exception.Create(A000MSG_Ac01_ERR_CHIUSURA_FUORI_VALIDITA);
  end;
  if Trim(selT750.FieldByName('ORE_MAX').AsString) = '' then
    selT750.FieldByName('ORE_MAX').AsString:='00.00';
  ControlloSuperamentoLimiti(selT750);
  if selT750.State = dsEdit then
    ControlliRichieste('M',selT750.FieldByName('ID').AsInteger,0,0,0);
end;

procedure TAc01FProgettiRendiProjMW.selT750BeforePost2(Storicizzazione:Boolean);
var Id:Integer;
begin
  AggiornaFD:=False;
  if (selT750.State in [dsInsert]) or Storicizzazione then
  begin
    AggiornaFD:=True;
    try
      selID_T750.Execute;
      Id:=selID_T750.Field(0);
    except
      raise exception.Create(A000MSG_Ac01_ERR_SEQUENZA_T750);
    end;
    selT750.FieldByName('ID').AsInteger:=Id;
  end
  else if (selT750.FieldByName('DECORRENZA').medpOldValue <> selT750.FieldByName('DECORRENZA').AsDateTime)
  or (selT750.FieldByName('DECORRENZA_FINE').medpOldValue <> selT750.FieldByName('DECORRENZA_FINE').AsDateTime) then
  begin
    scrT753.SetVariable('ID_T750',selT750.FieldByName('ID').AsInteger);
    scrT753.SetVariable('DECORRENZA',selT750.FieldByName('DECORRENZA').AsDateTime);
    scrT753.SetVariable('DECORRENZA_FINE',selT750.FieldByName('DECORRENZA_FINE').AsDateTime);
    scrT753.SetVariable('DECORRENZA_OLD',selT750.FieldByName('DECORRENZA').medpOldValue);
    scrT753.SetVariable('DECORRENZA_FINE_OLD',selT750.FieldByName('DECORRENZA_FINE').medpOldValue);
    scrT753.Execute;
    if StrToInt(VarToStr(scrT753.GetVariable('N_ERR'))) > 0 then
      raise exception.Create(A000MSG_Ac01_ERR_CONFLITTO_PERIODI);
    selT753.Refresh;
  end;
end;

procedure TAc01FProgettiRendiProjMW.selT750AfterPost;
begin
  CreaReportingPeriod;
  SessioneOracle.ApplyUpdates([selT756],True);
  if AggiornaFD then
    A000AggiornaFiltroDizionario('PROGETTI RENDICONTABILI','',selT750.FieldByName('ID').AsString);
end;

procedure TAc01FProgettiRendiProjMW.selT750BeforeDelete;
begin
  AggiornaFD:=False;
  ControlliRichieste('C',selT750.FieldByName('ID').AsInteger,0,0,0);
  inherited;
end;

procedure TAc01FProgettiRendiProjMW.selT751AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selT753.Close;
  selT753.SetVariable('ID',0);
  selT753.Open;
  selT752.Close;
  selT752.SetVariable('ID',selT751.FieldByName('ID').AsInteger);
  selT752.Open;
end;

procedure TAc01FProgettiRendiProjMW.selT751CalcFields(DataSet: TDataSet);
begin
  inherited;
  selAssegAtt.Close;
  selAssegAtt.SetVariable('ID_T751',selT751.FieldByName('ID').AsInteger);
  selAssegAtt.Open;
  selT751.FieldByName('TOT_ORE_MAX').AsString:=selAssegAtt.FieldByName('ORE_ASSEG').AsString;
  selFruitoDip.Close;
  selFruitoDip.SetVariable('ID_T750',0);
  selFruitoDip.SetVariable('ID_T751',selT751.FieldByName('ID').AsInteger);
  selFruitoDip.SetVariable('ID_T752',0);
  selFruitoDip.Open;
  selT751.FieldByName('TOT_ORE_FRUITO').AsString:=selFruitoDip.FieldByName('ORE_FRUITO_DIP').AsString;
end;

procedure TAc01FProgettiRendiProjMW.selT751NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT751.FieldByName('ID_T750').AsInteger:=selT750.FieldByName('ID').AsInteger;
  selT751.FieldByName('ORE_MAX').AsString:='00.00';
end;

procedure TAc01FProgettiRendiProjMW.selT751BeforePost(DataSet: TDataSet);
begin
  if Trim(selT751.FieldByName('CODICE').AsString) = '' then
    raise exception.Create(A000MSG_Ac01_ERR_NO_COD_ATTIVITA);
  if (   (selT751.State in [dsInsert])
      or (selT751.FieldByName('CODICE').AsString <> selT751.FieldByName('CODICE').medpOldValue))
  and (lstCod.IndexOf(selT751.FieldByName('CODICE').AsString) >= 0) then
    raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
  if Trim(selT751.FieldByName('ORE_MAX').AsString) = '' then
    selT751.FieldByName('ORE_MAX').AsString:='00.00';
  inherited;
end;

procedure TAc01FProgettiRendiProjMW.selT751AfterPost(DataSet: TDataSet);
begin
  inherited;
  ModificaRiepilogo(selT751);
  CaricaListaCod(selT751);
end;

procedure TAc01FProgettiRendiProjMW.selT751BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControlliRichieste('C',0,selT751.FieldByName('ID').AsInteger,0,0);
end;

procedure TAc01FProgettiRendiProjMW.selT751AfterDelete(DataSet: TDataSet);
begin
  inherited;
  ModificaRiepilogo(selT751);
  CaricaListaCod(selT751);
end;

procedure TAc01FProgettiRendiProjMW.selT751ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
var Id:Integer;
begin
  if Action = 'I' then
  begin
    ControlloSuperamentoLimiti(selT751);
    Applied:=True;
    try
      selID_T751.Execute;
      Id:=selID_T751.Field(0);
    except
      raise exception.Create(A000MSG_Ac01_ERR_SEQUENZA_T751);
    end;
    insT751.SetVariable('ID_T750',selT751.FieldByName('ID_T750').AsInteger);
    insT751.SetVariable('CODICE',selT751.FieldByName('CODICE').AsString);
    insT751.SetVariable('DESCRIZIONE',selT751.FieldByName('DESCRIZIONE').AsString);
    insT751.SetVariable('ORE_MAX',selT751.FieldByName('ORE_MAX').AsString);
    insT751.SetVariable('ID_T751',Id);
    insT751.Execute;
    insT752.SetVariable('CODICE',selT751.FieldByName('CODICE').AsString);
    insT752.SetVariable('DESCRIZIONE',selT751.FieldByName('DESCRIZIONE').AsString);
    insT752.SetVariable('ORE_MAX',selT751.FieldByName('ORE_MAX').AsString);
    insT752.SetVariable('ID_T751',Id);
    insT752.Execute;
  end
  else if Action = 'U' then
  begin
    ControlloSuperamentoLimiti(selT751);
  end
  else if Action = 'D' then
  begin
  end;
end;

procedure TAc01FProgettiRendiProjMW.selT752AfterScroll(DataSet: TDataSet);
begin
  inherited;
  selT753.Close;
  selT753.SetVariable('ID',selT752.FieldByName('ID').AsInteger);
  selT753.Open;
end;

procedure TAc01FProgettiRendiProjMW.selT752CalcFields(DataSet: TDataSet);
begin
  inherited;
  selAssegTas.Close;
  selAssegTas.SetVariable('ID_T752',selT752.FieldByName('ID').AsInteger);
  selAssegTas.Open;
  selT752.FieldByName('TOT_ORE_MAX').AsString:=selAssegTas.FieldByName('ORE_ASSEG').AsString;
  selFruitoDip.Close;
  selFruitoDip.SetVariable('ID_T750',0);
  selFruitoDip.SetVariable('ID_T751',0);
  selFruitoDip.SetVariable('ID_T752',selT752.FieldByName('ID').AsInteger);
  selFruitoDip.Open;
  selT752.FieldByName('TOT_ORE_FRUITO').AsString:=selFruitoDip.FieldByName('ORE_FRUITO_DIP').AsString;
end;

procedure TAc01FProgettiRendiProjMW.selT752NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT752.FieldByName('ID_T751').AsInteger:=selT751.FieldByName('ID').AsInteger;
  selT752.FieldByName('ORE_MAX').AsString:='00.00';
end;

procedure TAc01FProgettiRendiProjMW.selT752BeforePost(DataSet: TDataSet);
var Id:Integer;
begin
  if Trim(selT752.FieldByName('CODICE').AsString) = '' then
    raise exception.Create(A000MSG_Ac01_ERR_NO_COD_TASK);
  if (   (selT752.State in [dsInsert])
      or (selT752.FieldByName('CODICE').AsString <> selT752.FieldByName('CODICE').medpOldValue))
  and (lstCod.IndexOf(selT752.FieldByName('CODICE').AsString) >= 0) then
    raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
  if Trim(selT752.FieldByName('ORE_MAX').AsString) = '' then
    selT752.FieldByName('ORE_MAX').AsString:='00.00';
  inherited;
  if (selT752.State in [dsInsert]) then
  begin
    try
      selID_T752.Execute;
      Id:=selID_T752.Field(0);
    except
      raise exception.Create(A000MSG_Ac01_ERR_SEQUENZA_T752);
    end;
    selT752.FieldByName('ID').AsInteger:=Id;
  end;
end;

procedure TAc01FProgettiRendiProjMW.selT752AfterPost(DataSet: TDataSet);
begin
  inherited;
  ModificaRiepilogo(selT752);
  CaricaListaCod(selT752);
end;

procedure TAc01FProgettiRendiProjMW.selT752BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControlliRichieste('C',0,0,selT752.FieldByName('ID').AsInteger,0);
  if selT752.RecordCount = 1 then
    raise exception.Create(A000MSG_Ac01_ERR_DEL_TUTTI_TASK);
end;

procedure TAc01FProgettiRendiProjMW.selT752AfterDelete(DataSet: TDataSet);
begin
  ModificaRiepilogo(selT752);
  CaricaListaCod(selT752);
end;

procedure TAc01FProgettiRendiProjMW.selT752ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if (Action = 'I') or (Action = 'U') then
    ControlloSuperamentoLimiti(selT752);
end;

procedure TAc01FProgettiRendiProjMW.selT753CalcFields(DataSet: TDataSet);
begin
  selT753.FieldByName('SERVIZIO').AsString:=VarToStr(selT754.Lookup('PROGRESSIVO',selT753.FieldByName('PROGRESSIVO').AsInteger,'SERVIZIO'));
  selT753.FieldByName('FUNZIONE').AsString:=VarToStr(selT754.Lookup('PROGRESSIVO',selT753.FieldByName('PROGRESSIVO').AsInteger,'FUNZIONE'));
end;

procedure TAc01FProgettiRendiProjMW.selT753NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT753.FieldByName('ID_T752').AsInteger:=selT752.FieldByName('ID').AsInteger;
  selT753.FieldByName('DECORRENZA').AsDateTime:=selT750.FieldByName('DECORRENZA').AsDateTime;
  selT753.FieldByName('DECORRENZA_FINE').AsDateTime:=selT750.FieldByName('DECORRENZA_FINE').AsDateTime;
  selT753.FieldByName('ORE_MAX').AsString:='00.00';
  selT753.FieldByName('ORE_FRUITO').AsString:='00.00';
end;

procedure TAc01FProgettiRendiProjMW.selT753BeforePost(DataSet: TDataSet);
begin
  if selT753.FieldByName('PROGRESSIVO').IsNull then
    raise exception.Create(A000MSG_Ac01_ERR_NO_DIP);
  if selT753.FieldByName('DECORRENZA').IsNull then
    raise exception.Create(A000MSG_Ac01_ERR_NO_INIZIO);
  if selT753.FieldByName('DECORRENZA_FINE').IsNull then
    raise exception.Create(A000MSG_Ac01_ERR_NO_FINE);
  if selT753.FieldByName('DECORRENZA').AsDateTime > selT753.FieldByName('DECORRENZA_FINE').AsDateTime then
    raise exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  if (selT753.FieldByName('DECORRENZA').AsDateTime < selT750.FieldByName('DECORRENZA').AsDateTime)
  or (selT753.FieldByName('DECORRENZA_FINE').AsDateTime > selT750.FieldByName('DECORRENZA_FINE').AsDateTime) then
    raise exception.Create(A000MSG_Ac01_ERR_PERIODO_ESTERNO);
  ControlliIntersezioneDate;
  if selT753.State = dsEdit then
    ControlliRichieste('M',0,0,selT753.FieldByName('ID_T752').AsInteger,selT753.FieldByName('PROGRESSIVO').medpOldValue);
  inherited;
end;

procedure TAc01FProgettiRendiProjMW.selT753AfterPost(DataSet: TDataSet);
begin
  inherited;
  CaricaDettDip;
  ModificaRiepilogo(selT753);
end;

procedure TAc01FProgettiRendiProjMW.selT753BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControlliRichieste('C',0,0,selT753.FieldByName('ID_T752').AsInteger,selT753.FieldByName('PROGRESSIVO').medpOldValue);
end;

procedure TAc01FProgettiRendiProjMW.selT753AfterDelete(DataSet: TDataSet);
begin
  inherited;
  CaricaDettDip;
  ModificaRiepilogo(selT753);
end;

procedure TAc01FProgettiRendiProjMW.selT753ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  if (Action = 'I') or (Action = 'U') then
    ControlloSuperamentoLimiti(selT753);
end;

procedure TAc01FProgettiRendiProjMW.selT754CalcFields(DataSet: TDataSet);
begin
  inherited;
  selT754.FieldByName('PROGETTO').AsString:=Format('%-20s %-100s',[selT750.FieldByName('CODICE').AsString,selT750.FieldByName('DESCRIZIONE').AsString]);
  selT754.FieldByName('DIPENDENTE').AsString:=Format('%-8s %-30s %-30s',[VarToStr(selbV430.Lookup('PROGRESSIVO',selT754.FieldByName('PROGRESSIVO').AsInteger,'MATRICOLA')),
                                                                         VarToStr(selbV430.Lookup('PROGRESSIVO',selT754.FieldByName('PROGRESSIVO').AsInteger,'COGNOME')),
                                                                         VarToStr(selbV430.Lookup('PROGRESSIVO',selT754.FieldByName('PROGRESSIVO').AsInteger,'NOME'))]);
end;

procedure TAc01FProgettiRendiProjMW.selT756CalcFields(DataSet: TDataSet);
begin
  selT756.FieldByName('PROGETTO').AsString:=Format('%-20s %-100s',[selT750.FieldByName('CODICE').AsString,selT750.FieldByName('DESCRIZIONE').AsString]);
end;

procedure TAc01FProgettiRendiProjMW.selT756NewRecord(DataSet: TDataSet);
begin
  selT756.FieldByName('ID_T750').AsInteger:=selT750.FieldByName('ID').AsInteger;
end;

procedure TAc01FProgettiRendiProjMW.ORE_MAXValidate(Sender: TField);
begin
  inherited;
  OreValidate(Sender.AsString);
end;

procedure TAc01FProgettiRendiProjMW.OreValidate(Ore:String);
begin
  inherited;
  OreMinutiValidate(Ore);
end;

procedure TAc01FProgettiRendiProjMW.selbT750FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=OnFilterRecord(DataSet);
end;

procedure TAc01FProgettiRendiProjMW.AperturaDipendenti;
var s:String;
begin
  if (selT750.FieldByName('DECORRENZA').AsDateTime <> selbV430.GetVariable('C700DATADAL'))
  or (selT750.FieldByName('DECORRENZA_FINE').AsDateTime <> selbV430.GetVariable('DATALAVORO'))
  then
  begin
    selbV430.Close;
    S:=StringReplace(QVistaOracle,
                     ':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine',
                     ':DATALAVORO >= T430DATADECORRENZA AND :C700DATADAL <= T430DATAFINE',
                     [rfIgnoreCase]);
    S:=StringReplace(S,
                     ':DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                     ':DATALAVORO >= NVL(P430DECORRENZA,:DATALAVORO) AND :C700DATADAL <= NVL(P430DECORRENZA_FINE,:C700DATADAL)',
                     [rfIgnoreCase]);
    selbV430.SetVariable('QVISTAORACLE',S + #10#13 + QVistaInServizioPeriodica);
    selbV430.SetVariable('C700DATADAL',selT750.FieldByName('DECORRENZA').AsDateTime);
    selbV430.SetVariable('DATALAVORO',selT750.FieldByName('DECORRENZA_FINE').AsDateTime);
    selbV430.Open;
  end;
end;

procedure TAc01FProgettiRendiProjMW.ControlliRichieste(Azione:String;Id_T750,Id_T751,Id_T752,Prog:Integer);
var Tipo,Desc:String;
    DIni,DFin,DMin,DMax:TDateTime;
    NewProg:Integer;
    ODS:TOracleDataSet;
begin
  with selT755 do
  begin
    //Definisco il dataset di riferimento per prelevare le date
    if Prog > 0 then
      ODS:=selT753  //dipendenti
    else
      ODS:=selT750; //progetti
    //Definisco il periodo nel quale effettuare la ricerca
    if Azione = 'M' then //modifica
    begin
      DIni:=ODS.FieldByName('DECORRENZA').medpOldValue;
      DFin:=ODS.FieldByName('DECORRENZA_FINE').medpOldValue;
    end
    else                 //cancellazione
    begin
      DIni:=ODS.FieldByName('DECORRENZA').AsDateTime;
      DFin:=ODS.FieldByName('DECORRENZA_FINE').AsDateTime;
    end;
    //Cerco le richieste in base al livello di provenienza
    Close;
    SetVariable('ID_T750',Id_T750);//progetto
    SetVariable('ID_T751',Id_T751);//attività
    SetVariable('ID_T752',Id_T752);//task
    SetVariable('PROG',Prog);      //dipendente
    SetVariable('DINI',DIni);
    SetVariable('DFIN',DFin);
    Open;
    //Se non ci sono richieste, interrompo il controllo
    if FieldByName('D_MIN').IsNull then
      exit;
    //Altrimenti preparo il messaggio...
    Tipo:=IfThen(Prog > 0,'il dipendente',IfThen(Id_T750 > 0,'il progetto',IfThen(Id_T751 > 0,'l''attività','il task')));
    Desc:=IfThen(Prog > 0,selT753.FieldByName('COGNOME').AsString + ' ' + selT753.FieldByName('NOME').AsString + ' (' + selT753.FieldByName('MATRICOLA').AsString + ')',
          IfThen(Id_T750 > 0,selT750.FieldByName('CODICE').AsString + ' ' + selT750.FieldByName('DESCRIZIONE').AsString,
          IfThen(Id_T751 > 0,selT751.FieldByName('CODICE').AsString + ' ' + selT751.FieldByName('DESCRIZIONE').AsString,
                             selT752.FieldByName('CODICE').AsString + ' ' + selT752.FieldByName('DESCRIZIONE').AsString)));
    DMin:=FieldByName('D_MIN').AsDateTime;
    DMax:=FieldByName('D_MAX').AsDateTime;
    NewProg:=Prog;
    if selT753.Active and (Prog > 0) then
      NewProg:=selT753.FieldByName('PROGRESSIVO').AsInteger;
    //...ed effettuo il controllo
    if (Azione = 'C')      //cancellazione
    or (    (Azione = 'M') //modifica
        and (   (NewProg <> Prog)
             or (ODS.FieldByName('DECORRENZA').AsDateTime > DMin)
             or (ODS.FieldByName('DECORRENZA_FINE').AsDateTime < DMax))) then
      raise exception.Create(Format(A000MSG_Ac01_ERR_FMT_RICHIESTE,[Tipo,Desc,DateToStr(DMin),DateToStr(DMax)]));
  end;
end;

procedure TAc01FProgettiRendiProjMW.ControlliIntersezioneDate;
var sRowid:String;
begin
  if selT753.State = dsInsert then
    sRowid:='inserimento'
  else if selT753.Rowid <> '' then
    sRowid:=selT753.Rowid
  else
    sRowid:=VarToStr(selT753.FieldByName('PROGRESSIVO').medpOldValue) + '-' + VarToStr(selT753.FieldByName('DECORRENZA').medpOldValue);
  with cdsT753 do
  begin
    First;
    if not Locate('PROGRESSIVO',selT753.FieldByName('PROGRESSIVO').AsInteger,[]) then
      exit;
    while not Eof and (FieldByName('PROGRESSIVO').AsInteger = selT753.FieldByName('PROGRESSIVO').AsInteger) do
    begin
      if FieldByName('ROWID').AsString <> sRowid then
      begin
        if (    (selT753.FieldByName('DECORRENZA').AsDateTime >= FieldByName('DECORRENZA').AsDateTime)
            and (selT753.FieldByName('DECORRENZA').AsDateTime <= FieldByName('DECORRENZA_FINE').AsDateTime))
        or (    (selT753.FieldByName('DECORRENZA_FINE').AsDateTime >= FieldByName('DECORRENZA').AsDateTime)
            and (selT753.FieldByName('DECORRENZA_FINE').AsDateTime <= FieldByName('DECORRENZA_FINE').AsDateTime))
        or (    (selT753.FieldByName('DECORRENZA').AsDateTime < FieldByName('DECORRENZA').AsDateTime)
            and (selT753.FieldByName('DECORRENZA_FINE').AsDateTime > FieldByName('DECORRENZA_FINE').AsDateTime))
        then
          raise exception.Create(A000MSG_Ac01_ERR_PERIODI_INTERSECANTI);
      end;
      Next;
    end;
  end;
end;

procedure TAc01FProgettiRendiProjMW.CaricaDettDip;
var BM:TBookMark;
begin
  with selT753 do
  begin
    BM:=GetBookMark;
	{ TODO : TEST IW 15 }
	try
      cdsT753.EmptyDataSet;
      First;
      while not Eof do
      begin
        cdsT753.Append;
        if Rowid <> '' then
          cdsT753.FieldByName('ROWID').AsString:=Rowid
        else
          cdsT753.FieldByName('ROWID').AsString:=FieldByName('PROGRESSIVO').AsString + '-' + FieldByName('DECORRENZA').AsString;
        cdsT753.FieldByName('PROGRESSIVO').AsInteger:=FieldByName('PROGRESSIVO').AsInteger;
        cdsT753.FieldByName('DECORRENZA').AsDateTime:=FieldByName('DECORRENZA').AsDateTime;
        cdsT753.FieldByName('DECORRENZA_FINE').AsDateTime:=FieldByName('DECORRENZA_FINE').AsDateTime;
        cdsT753.Post;
        Next;
      end;
      GotoBookMark(BM);
	finally
      FreeBookMark(BM);
	end;
  end;
end;

procedure TAc01FProgettiRendiProjMW.CaricaListaCod(ODS:TOracleDataSet);
var BM:TBookMark;
begin
  lstCod.Clear;
  with ODS do
  begin
    BM:=GetBookMark;
    { TODO : TEST IW 15 }
	try
      DisableControls;
      AfterScroll:=nil;
      First;
      while not Eof do
      begin
        lstCod.Add(FieldByName('CODICE').AsString);
        Next;
      end;
      GotoBookMark(BM);
	finally
      FreeBookMark(BM);
	end;
    EnableControls;
    if ODS = selT751 then
      AfterScroll:=selT751AfterScroll
    else if ODS = selT752 then
      AfterScroll:=selT752AfterScroll;
  end;
end;

procedure TAc01FProgettiRendiProjMW.ModificaRiepilogo(ODS:TOracleDataSet);
var TotOreMax:String;
    BM:TBookMark;
begin
  with ODS do
  begin
    BM:=GetBookMark;
	{ TODO : TEST IW 15 }
    try
      DisableControls;
      AfterScroll:=nil;
      First;
      TotOreMax:='00.00';
      while not Eof do
      begin
        TotOreMax:=R180MinutiOre(R180OreMinuti(TotOreMax) + R180OreMinuti(FieldByName('ORE_MAX').AsString));
        Next;
      end;
      GotoBookMark(BM);
	finally
      FreeBookMark(BM);
	end;
    EnableControls;
    if ODS = selT751 then
      AfterScroll:=selT751AfterScroll
    else if ODS = selT752 then
      AfterScroll:=selT752AfterScroll;
  end;
  with cdsRiep do
  begin
    Edit;
    FieldByName('TOT_ORE_MAX').AsString:=TotOreMax;
    Post;
  end;
  AggiornaColoreRiepilogo;
end;

procedure TAc01FProgettiRendiProjMW.ControlloSuperamentoLimiti(ODS:TOracleDataSet);
begin
  if (ODS <> selT753)
  and (R180OreMinuti(ODS.FieldByName('TOT_ORE_MAX').AsString) > R180OreMinuti(ODS.FieldByName('ORE_MAX').AsString)) then
    raise exception.Create(A000MSG_Ac01_MSG_ORE_PREVISTE);
  if R180OreMinuti(cdsRiep.FieldByName('TOT_ORE_MAX').AsString) > R180OreMinuti(cdsRiep.FieldByName('ORE_MAX').AsString) then
    raise exception.Create(A000MSG_Ac01_MSG_ORE_ASSEGNATE);
end;

procedure TAc01FProgettiRendiProjMW.RecuperaProgetti;
begin
  //Recuperare tutti i progetti,
  //tranne quello corrente e quelli ai quali non si è abilitati
  selbT750.Close;
  selbT750.SetVariable('ID_T750',selT750.FieldByName('ID').AsInteger);
  selbT750.Filtered:=True;
  selbT750.Open;
  if selbT750.RecordCount = 0 then
    raise exception.Create(A000MSG_Ac01_ERR_RIPORTA_CAUSALI);
end;

procedure TAc01FProgettiRendiProjMW.RiportaCausali;
var i:Integer;
    CodPro:String;
    DecPro:TDateTime;
    BM:TBookMark;
begin
  //Riportare causali correnti in ogni progetto selezionato
  for i:=0 to lstCodPro.Count - 1 do
  begin
    CodPro:=Trim(Copy(lstCodPro[i],1,20));
    DecPro:=StrToDate(Trim(Copy(lstCodPro[i],22,10)));
    updCauIncluse.SetVariable('CODICE',CodPro);
    updCauIncluse.SetVariable('DECORRENZA',DecPro);
    updCauIncluse.SetVariable('CAUSALI',selT750.FieldByName('CAUASSPRES_INCLUSE').AsString);
    updCauIncluse.Execute;
  end;
  SessioneOracle.Commit;
  with selT750 do
  begin 
    BM:=GetBookMark;
	try { TODO : TEST IW 15 }
      Refresh;	  
      GotoBookMark(BM);
	finally
      FreeBookMark(BM);
	end;
  end;
end;

procedure TAc01FProgettiRendiProjMW.RecuperaAttivita;
begin
  //Recuperare tutte le attività del progetto,
  //tranne quella corrente e quelle che hanno già lo stesso codice del task corrente,
  //calcolando le ore inseribili, minori o uguali a quelle del task corrente
  selbT751.Close;
  selbT751.SetVariable('ID_T751',selT752.FieldByName('ID_T751').AsInteger);
  selbT751.SetVariable('CODICE',selT752.FieldByName('CODICE').AsString);
  selbT751.SetVariable('ORE_MAX',selT752.FieldByName('ORE_MAX').AsString);
  selbT751.Open;
  if selbT751.RecordCount = 0 then
    raise exception.Create(A000MSG_Ac01_ERR_DUPLICA_TASK);
end;

procedure TAc01FProgettiRendiProjMW.DuplicaTask;
var i:Integer;
begin
  //Duplicare task corrente in ogni attività selezionata
  for i:=0 to lstCodAtt.Count - 1 do
  begin
    insT752.SetVariable('CODICE',selT752.FieldByName('CODICE').AsString);
    insT752.SetVariable('DESCRIZIONE',selT752.FieldByName('DESCRIZIONE').AsString);
    selbT751.SearchRecord('CODICE',lstCodAtt[i],[srFromBeginning]);
    insT752.SetVariable('ORE_MAX',selbT751.FieldByName('ORE_INSERIBILI').AsString);
    insT752.SetVariable('ID_T751',selbT751.FieldByName('ID').AsInteger);
    insT752.Execute;
  end;
  SessioneOracle.Commit;
  selT751.RefreshRecord;
end;

procedure TAc01FProgettiRendiProjMW.RecuperaTask;
begin
  //Recuperare tutti i task di tutte le attività del progetto,
  //tranne il task corrente e quelli che hanno già lo stesso dipendente assegnato in un periodo intersecante,
  //calcolando le ore inseribili, minori o uguali a quelle dell'assegnazione corrente
  selbT752.Close;
  selbT752.SetVariable('ID_T752',selT753.FieldByName('ID_T752').AsInteger);
  selbT752.SetVariable('PROGRESSIVO',selT753.FieldByName('PROGRESSIVO').AsInteger);
  selbT752.SetVariable('DECORRENZA',selT753.FieldByName('DECORRENZA').AsDateTime);
  selbT752.SetVariable('DECORRENZA_FINE',selT753.FieldByName('DECORRENZA_FINE').AsDateTime);
  selbT752.SetVariable('ORE_MAX',selT753.FieldByName('ORE_MAX').AsString);
  selbT752.Open;
  if selbT752.RecordCount = 0 then
    raise exception.Create(A000MSG_Ac01_ERR_DUPLICA_DIPENDENTE);
end;

procedure TAc01FProgettiRendiProjMW.DuplicaDipendente;
var i:Integer;
    CAtt,CTas:String;
begin
  //Duplicare task corrente in ogni attività selezionata
  for i:=0 to lstCodTas.Count - 1 do
  begin
    insT753.SetVariable('PROGRESSIVO',selT753.FieldByName('PROGRESSIVO').AsInteger);
    insT753.SetVariable('DECORRENZA',selT753.FieldByName('DECORRENZA').AsDateTime);
    insT753.SetVariable('DECORRENZA_FINE',selT753.FieldByName('DECORRENZA_FINE').AsString);
    insT753.SetVariable('ORE_FRUITO','00.00');
    CAtt:=Trim(Copy(lstCodTas[i],1,10));
    CTas:=Trim(Copy(lstCodTas[i],11,10));
    selbT752.SearchRecord('C_ATT;C_TAS',VarArrayOf([CAtt,CTas]),[srFromBeginning]);
    insT753.SetVariable('ORE_MAX',selbT752.FieldByName('ORE_INSERIBILI').AsString);
    insT753.SetVariable('ID_T752',selbT752.FieldByName('ID_TAS').AsInteger);
    insT753.Execute;
  end;
  SessioneOracle.Commit;
  selT752.RefreshRecord;
end;

procedure TAc01FProgettiRendiProjMW.CreaReportingPeriod;
begin
  selT756.ReadOnly:=False;
  if selT756.RecordCount = 0 then
  begin
    selT756.Append;
    selT756.FieldByName('ID_T750').AsInteger:=selT750.FieldByName('ID').AsInteger;
    selT756.FieldByName('CODICE').AsString:='1';
    selT756.FieldByName('DECORRENZA').AsDateTime:=selT750.FieldByName('DECORRENZA').AsDateTime;
    selT756.FieldByName('DECORRENZA_FINE').AsDateTime:=selT750.FieldByName('DECORRENZA_FINE').AsDateTime;
    selT756.Post;
  end;
end;

function TAc01FProgettiRendiProjMW.ControllaReportingPeriod:String;
var OldDecFin:TDateTime;
begin
  Result:='';
  with selT756 do
  begin
    if not Active then
      exit;
    if RecordCount = 0 then
    begin
      Result:=A000MSG_Ac01_ERR_MANCA_REPORTING_PERIOD;
      exit;
    end;
    First;
    if FieldByName('DECORRENZA').AsDateTime <> selT750.FieldByName('DECORRENZA').AsDateTime then
    begin
      Result:=A000MSG_Ac01_ERR_INIZIO_REPORTING_PERIOD;
      exit;
    end;
    while not Eof do
    begin
      if Trim(FieldByName('CODICE').AsString) = '' then
      begin
        Result:=A000MSG_Ac01_ERR_NO_COD_REPORTING_PERIOD;
        exit;
      end;
      if FieldByName('DECORRENZA').IsNull or FieldByName('DECORRENZA_FINE').IsNull then
      begin
        Result:=A000MSG_Ac01_ERR_DATA_VUOTA;
        exit;
      end;
      if FieldByName('DECORRENZA_FINE').AsDateTime < FieldByName('DECORRENZA').AsDateTime then
      begin
        Result:=A000MSG_ERR_DATE_INVERTITE;
        exit;
      end;
      if (RecNo > 1)
      and (FieldByName('DECORRENZA').AsDateTime <> OldDecFin + 1) then
      begin
        Result:=A000MSG_Ac01_ERR_BUCHI_REPORTING_PERIOD;
        exit;
      end;
      OldDecFin:=FieldByName('DECORRENZA_FINE').AsDateTime;
      Next;
    end;
    if FieldByName('DECORRENZA_FINE').AsDateTime <> selT750.FieldByName('DECORRENZA_FINE').AsDateTime then
    begin
      Result:=A000MSG_Ac01_ERR_FINE_REPORTING_PERIOD;
      exit;
    end;
  end;
end;

end.
