unit A115UIterAutorizzativiDM;

interface

uses
  System.SysUtils,
  System.Classes,
  Datasnap.DBClient,
  Data.DB,
  DBGrids,
  OracleData,
  Oracle,
  Math,
  RegistrazioneLog,
  R004UGestStoricoDTM,
  C180FunzioniGenerali,
  A000UInterfaccia,
  A000USessione,
  A000UCostanti,
  A115UIterAutorizzativiMW;

type
  TA115FIterAutorizzativiDM = class(TR004FGestStoricoDtM)
    selI093: TOracleDataSet;
    selI093AZIENDA: TStringField;
    selI093D_iter: TStringField;
    selI093ITER: TStringField;
    selI093REVOCABILE: TStringField;
    selI093MAIL_OGGETTO_DIP: TStringField;
    selI093MAIL_CORPO_DIP: TStringField;
    selI093MAIL_OGGETTO_RESP: TStringField;
    selI093MAIL_CORPO_RESP: TStringField;
    selI093EXPR_PERIODO_VISUAL: TStringField;
    selI093CHKDATI_ITER_AUT: TFloatField;
    selI093C_CHKDATI_ITER_AUT: TStringField;
    dsrI093: TDataSource;
    selI095: TOracleDataSet;
    selI095AZIENDA: TStringField;
    selI095ITER: TStringField;
    selI095COD_ITER: TStringField;
    selI095DESCRIZIONE: TStringField;
    selI095FILTRO_RICHIESTA: TStringField;
    selI095CONDIZ_AUTORIZZ_AUTOMATICA: TStringField;
    selI095MAX_LIV_AUTORIZZ_AUTOMATICA: TIntegerField;
    selI095FILTRO_INTERFACCIA: TStringField;
    selI095VALIDITA_ITER_AUT2: TFloatField;
    selI095VALIDITA_ITER_AUT: TStringField;
    selI095MAX_LIV_NOTE_MODIFICABILI: TIntegerField;
    selI095CONDIZIONE_ALLEGATI: TStringField;
    selI095ALLEGATI_MODIFICABILI: TStringField;
    dsrI095: TDataSource;
    dsrI096: TDataSource;
    selI096: TOracleDataSet;
    selI096AZIENDA: TStringField;
    selI096ITER: TStringField;
    selI096COD_ITER: TStringField;
    selI096LIVELLO: TIntegerField;
    selI096DESC_LIVELLO: TStringField;
    selI096FASE: TIntegerField;
    selI096OBBLIGATORIO: TStringField;
    selI096AVVISO: TStringField;
    selI096VALORI_POSSIBILI: TStringField;
    selI096AUTORIZZ_INTERMEDIA: TStringField;
    selI096DATI_MODIFICABILI: TStringField;
    selI096INVIO_EMAIL: TStringField;
    selI096CONDIZ_AUTORIZZ_AUTOMATICA: TStringField;
    selI096SCRIPT_AUTORIZZ: TStringField;
    selI096ALLEGATI_OBBLIGATORI: TStringField;
    selI096ALLEGATI_VISIBILI: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selI093AfterScroll(DataSet: TDataSet);
    procedure selI093BeforeInsert(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selI093CalcFields(DataSet: TDataSet);
    procedure selI095AfterOpen(DataSet: TDataSet);
    procedure selI095AfterScroll(DataSet: TDataSet);
    procedure selI095BeforeDelete(DataSet: TDataSet);
    procedure selI095BeforeInsert(DataSet: TDataSet);
    procedure selI095BeforePost(DataSet: TDataSet);
    procedure selI095CalcFields(DataSet: TDataSet);
    procedure selI095NewRecord(DataSet: TDataSet);
    procedure selI095BeforeCancel(DataSet: TDataSet);
    procedure selI096BeforeDelete(DataSet: TDataSet);
    procedure selI096BeforeInsert(DataSet: TDataSet);
    procedure selI096BeforePost(DataSet: TDataSet);
    procedure selI096NewRecord(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selI095AfterPost(DataSet: TDataSet);
    procedure selI096AfterPost(DataSet: TDataSet);
  private
    RegistraLog:TRegistraLog;
    procedure NascondiDBGridColumns(var INDBGrid:TDBGrid);
  public
    A115MW:TA115FIterAutorizzativiMW;
    procedure OpenSelI096(Azienda:String);
    procedure InizializzaDataModulo(Azienda:String);
  end;

var
  A115FIterAutorizzativiDM: TA115FIterAutorizzativiDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses A115UIterAutorizzativi;

procedure TA115FIterAutorizzativiDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selI093,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  InterfacciaR004.NomeTabella:='MONDOEDP.I093_BASE_ITER_AUT';
  InterfacciaR004.AliasNomeTabella:='I093';
  A000GetChiavePrimaria(selI093.Session,InterfacciaR004.NomeTabella,InterfacciaR004.LChiavePrimaria);

  RegistraLog:=TRegistraLog.Create(nil);
  RegistraLog.Session:=SessioneOracle;

  InizializzaDataModulo(Parametri.Azienda);
end;

procedure TA115FIterAutorizzativiDM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  if A115MW <> nil then
    FreeAndNil(A115MW);
  if RegistraLog <> nil then
    FreeAndNil(RegistraLog);
end;

procedure TA115FIterAutorizzativiDM.InizializzaDataModulo(Azienda:String);
begin

  if Azienda = '' then
    Abort;

  if A115MW <> nil then
    FreeAndNil(A115MW);

  A115MW:=TA115FIterAutorizzativiMW.Create(nil);
  A115MW.selI093:=selI093;
  A115MW.selI095:=selI095;
  A115MW.selI096:=selI096;

  A115MW.AziendaCorrente:=Azienda;
  A115MW.RegistraLogSecondario:=RegistraLog;
  A115MW.ModuloIterAutorizzativi:=A000ModuloAbilitato(SessioneOracle,'ITER_AUTORIZZATIVI',
                                                      A115MW.AziendaCorrente);

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  // visibilità colonne allegati
  if A115FIterAutorizzativi <> nil then
  begin
    A115FIterAutorizzativi.dgrdselI095.Columns[8].Visible:=True;//A115MW.ModuloIterAutorizzativi;
    A115FIterAutorizzativi.dgrdselI095.Columns[9].Visible:=True;//A115MW.ModuloIterAutorizzativi;
    A115FIterAutorizzativi.dgrdselI096.Columns[11].Visible:=True;//A115MW.ModuloIterAutorizzativi;
    A115FIterAutorizzativi.dgrdselI096.Columns[12].Visible:=True;//A115MW.ModuloIterAutorizzativi;
  end;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

  selI093.OnApplyRecord:=A115MW.ApplyRecordRegistraLog;
  selI095.OnApplyRecord:=A115MW.ApplyRecordRegistraLog;
  selI096.OnApplyRecord:=A115MW.ApplyRecordRegistraLog;

  A115MW.AggiornaI093_I095_I096;
  A115MW.OpenSelI093;
end;

{ selI093 }

procedure TA115FIterAutorizzativiDM.selI093AfterScroll(DataSet: TDataSet);
begin
  A115MW.selI093AfterScroll;
  NascondiDBGridColumns(A115FIterAutorizzativi.dgrdselI096);
end;

procedure TA115FIterAutorizzativiDM.selI093BeforeInsert(DataSet: TDataSet);
begin
  A115MW.selI093BeforeInsert;
end;

procedure TA115FIterAutorizzativiDM.AfterPost(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([A115MW.selI094],True);
  inherited;
end;

procedure TA115FIterAutorizzativiDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A115MW.selI093BeforeDelete;
  A115MW.selI094.CancelUpdates;
end;

procedure TA115FIterAutorizzativiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A115MW.selI093BeforePost;
end;

procedure TA115FIterAutorizzativiDM.selI093CalcFields(DataSet: TDataSet);
begin
  A115MW.selI093CalcFields;
end;

{ selI095 }

procedure TA115FIterAutorizzativiDM.selI095AfterOpen(DataSet: TDataSet);
begin
  with A115FIterAutorizzativi do
    begin
    A115MW.selI095AfterOpen;
    NascondiDBGridColumns(dgrdSelI095);
    if selI095.FieldByName('COD_ITER').AsString = 'DEFAULT' then
      dgrdSelI095.Options:=dgrdSelI095.Options - [dgConfirmDelete]
    else
      dgrdSelI095.Options:=dgrdSelI095.Options + [dgConfirmDelete];
  end;
end;

procedure TA115FIterAutorizzativiDM.selI095AfterScroll(DataSet: TDataSet);
begin
  A115MW.selI095AfterScroll;
end;

procedure TA115FIterAutorizzativiDM.selI095BeforeCancel(DataSet: TDataSet);
begin
  A115MW.selI097.CancelUpdates;
end;

procedure TA115FIterAutorizzativiDM.selI095BeforeDelete(DataSet: TDataSet);
begin
  A115MW.selI095BeforeDelete;
end;

procedure TA115FIterAutorizzativiDM.selI095BeforeInsert(DataSet: TDataSet);
begin
  A115MW.selI095BeforeInsert;
end;

procedure TA115FIterAutorizzativiDM.selI095AfterPost(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([A115MW.selI097],True);
  A115MW.AggiornaI093_I095_I096;
  selI095AfterScroll(A115MW.selI095);
  A115MW.check_I095;
end;

procedure TA115FIterAutorizzativiDM.selI095BeforePost(DataSet: TDataSet);
begin
  A115MW.selI095BeforePost;
end;

procedure TA115FIterAutorizzativiDM.selI095CalcFields(DataSet: TDataSet);
begin
  A115MW.selI095CalcFields;
end;

procedure TA115FIterAutorizzativiDM.selI095NewRecord(DataSet: TDataSet);
begin
  A115MW.selI095NewRecord;
end;

{ selI096 }

procedure TA115FIterAutorizzativiDM.OpenSelI096(Azienda:String);
begin
  R180SetVariable(selI096,'AZIENDA',Azienda);
  selI096.Open;
  if Assigned(A115MW) then
    A115MW.AggiornaLivMax;
end;

procedure TA115FIterAutorizzativiDM.selI096AfterPost(DataSet: TDataSet);
begin
  A115MW.selI096AfterPost;
end;

procedure TA115FIterAutorizzativiDM.selI096BeforeDelete(DataSet: TDataSet);
begin
  A115MW.selI096BeforeDelete;
end;

procedure TA115FIterAutorizzativiDM.selI096BeforeInsert(DataSet: TDataSet);
begin
  A115MW.selI096BeforeInsert;
end;

procedure TA115FIterAutorizzativiDM.selI096BeforePost(DataSet: TDataSet);
begin
  A115MW.selI096BeforePost;
end;

procedure TA115FIterAutorizzativiDM.selI096NewRecord(DataSet: TDataSet);
begin
  A115MW.selI096NewRecord;
end;

{ Altro }

procedure TA115FIterAutorizzativiDM.NascondiDBGridColumns(var INDBGrid:TDBGrid);
var
  i:Integer;
begin
  for i:=0 to INDBGrid.Columns.Count - 1 do
    INDBGrid.Columns[i].Visible:=INDBGrid.Columns[i].Field.Visible;
end;

end.
