unit A166UQuoteIndividualiDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, C180FunzioniGenerali,
  C700USelezioneAnagrafe,Math, A000UInterfaccia, QueryStorico,A166UQuoteIndividualiMW, A000UMessaggi;

type
  TA166FQuoteIndividualiDtM = class(TR004FGestStoricoDtM)
    selT775: TOracleDataSet;
    selT775PROGRESSIVO: TIntegerField;
    selT775DECORRENZA: TDateTimeField;
    selT775SCADENZA: TDateTimeField;
    selT775CODTIPOQUOTA: TStringField;
    selT775PENALIZZAZIONE: TFloatField;
    dsrT765: TDataSource;
    selT775SALTAPROVA: TStringField;
    selT775IMPORTO: TFloatField;
    selT775NUM_ORE: TStringField;
    selT775PERC_INDIVIDUALE: TFloatField;
    selT775PERC_STRUTTURALE: TFloatField;
    selT775CONSIDERA_SALDO: TStringField;
    selT775D_TIPOQUOTA: TStringField;
    selT775PERCENTUALE: TFloatField;
    selT775SOSPENDI_PT: TStringField;
    selT775SOSPENDI_QUOTE: TStringField;
    selT430: TOracleQuery;
    procedure selT775DECORRENZAValidate(Sender: TField);
    procedure DataModuleCreate(Sender: TObject);
    procedure selT775NewRecord(DataSet: TDataSet);
    procedure selT775BeforePost(DataSet: TDataSet);
    procedure selT775AfterScroll(DataSet: TDataSet);
    procedure selT775PERCENTUALEValidate(Sender: TField);
    procedure selT775AfterPost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  public
    { Public declarations }
    A166FQuoteIndividualiMW:TA166FQuoteIndividualiMW;
    procedure SettaProgressivo;
  end;

var
  A166FQuoteIndividualiDtM: TA166FQuoteIndividualiDtM;

implementation

uses A166UQuoteIndividuali;

{$R *.dfm}

procedure TA166FQuoteIndividualiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT775,[evAfterDelete,
                              evBeforeDelete]);
  A166FQuoteIndividuali.DButton.DataSet:=selT775;
  A166FQuoteIndividualiMW:=TA166FQuoteIndividualiMW.Create(Self);
  A166FQuoteIndividualiMW.selT775_Funzioni:=selT775;

  A166FQuoteIndividualiMW.selT765.SetVariable('DECORRENZA',InterfacciaR004.DataLavoro);
  A166FQuoteIndividualiMW.selT765.Open;

  selT775.FieldByName('D_TIPOQUOTA').LookupDataset:=A166FQuoteIndividualiMW.selT765;
  dsrT765.DataSet:=A166FQuoteIndividualiMW.selT765;

  selT775.Open;
end;

procedure TA166FQuoteIndividualiDtM.SettaProgressivo;
begin
  selT775.Close;
  selT775.SetVariable('Progressivo',C700Progressivo);
  selT775.Open;
end;

procedure TA166FQuoteIndividualiDtM.selT775NewRecord(DataSet: TDataSet);
begin
  inherited;
  A166FQuoteIndividualiMW.SelT775OnNewRecord;
end;

procedure TA166FQuoteIndividualiDtM.selT775PERCENTUALEValidate(Sender: TField);
begin
  inherited;
  A166FQuoteIndividuali.lblImporto.Enabled:=selT775.FieldByName('PERCENTUALE').AsFloat = 100;
  A166FQuoteIndividuali.dedtImporto.Enabled:=selT775.FieldByName('PERCENTUALE').AsFloat = 100;
  if not A166FQuoteIndividuali.dedtImporto.Enabled then
    selT775.FieldByName('IMPORTO').AsInteger:=-1;
  if A166FQuoteIndividuali.dedtImporto.Enabled and (selT775.FieldByName('IMPORTO').AsInteger = -1) then
  begin
    selT775.FieldByName('IMPORTO').AsInteger:=0;
    selT775DECORRENZAValidate(nil);
  end;
end;

procedure TA166FQuoteIndividualiDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A166FQuoteIndividualiMW);
end;

procedure TA166FQuoteIndividualiDtM.selT775AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.RegistraOperazione;
end;

procedure TA166FQuoteIndividualiDtM.selT775AfterScroll(DataSet: TDataSet);
begin
  A166FQuoteIndividualiMW.SelT775AfterScroll;
  inherited;
  A166FQuoteIndividuali.dcmbTipoQuotaCloseUp(nil);
end;

procedure TA166FQuoteIndividualiDtM.selT775BeforePost(DataSet: TDataSet);
var msg:String;
begin
//  inherited;
  if Trim(selT775.FieldByName('CODTIPOQUOTA').AsString) = '' then
    selT775.FieldByName('CODTIPOQUOTA').AsString:=' ';
  if selT775.FieldByName('SCADENZA').IsNull then
    selT775.FieldByName('SCADENZA').AsDateTime:=StrToDate('31/12/3999');
  if not A166FQuoteIndividuali.dedtImporto.Enabled then
    selT775.FieldByName('IMPORTO').AsInteger:=-1;
  //Controllo sulle chiavi primarie
  if QueryPK1.EsisteChiave('T775_QUOTEINDIVIDUALI',selT775.RowID,selT775.State,['PROGRESSIVO','DECORRENZA','CODTIPOQUOTA'],[IntToStr(selT775PROGRESSIVO.AsInteger),DateToStr(selT775DECORRENZA.AsDateTime),selT775CODTIPOQUOTA.AsString]) then
    raise Exception.Create('Chiave già esistente!');

  //Altri controlli
  if (selT775DECORRENZA.AsDateTime > selT775SCADENZA.AsDateTime) then
    raise Exception.Create(A000MSG_ERR_DECOR_SUP_SCAD);

  msg:=A166FQuoteIndividualiMW.MessaggioForzaDecorrenzaScadenza;
  if msg <> '' then
  begin
    if R180MessageBox(msg,'DOMANDA') = mrYes then
    begin
      selT775.FieldByName('DECORRENZA').AsDateTime:=R180InizioMese(selT775.FieldByName('DECORRENZA').AsDateTime);
      selT775.FieldByName('SCADENZA').AsDateTime:=R180FineMese(selT775.FieldByName('SCADENZA').AsDateTime);
    end;
  end;
  A166FQuoteIndividualiMW.ControlliBeforePost;

  //Registrazione operazioni
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA166FQuoteIndividualiDtM.selT775DECORRENZAValidate(Sender: TField);
begin
  inherited;
  A166FQuoteIndividualiMW.ImpostaDecorrenzaDatasetLookup;
  A166FQuoteIndividualiMW.ImpostaImportoPenalizzazione;
end;

end.
