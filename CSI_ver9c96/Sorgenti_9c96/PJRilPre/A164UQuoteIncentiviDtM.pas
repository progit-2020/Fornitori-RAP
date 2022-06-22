unit A164UQuoteIncentiviDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, DBCtrls, OracleData, Oracle, A000UInterfaccia, A000UCostanti, A000USessione,
  C180FunzioniGenerali, Grids, ExtCtrls, ComCtrls, DBGrids, Math, A164UQuoteIncentiviMW;

type
  TA164FQuoteIncentiviDtM = class(TR004FGestStoricoDtM)
    selT770: TOracleDataSet;
    selT770DATO1: TStringField;
    selT770DECORRENZA: TDateTimeField;
    selT770CODTIPOQUOTA: TStringField;
    selT770DATO2: TStringField;
    selT770DATO3: TStringField;
    dsrDato1: TDataSource;
    dsrDato2: TDataSource;
    dsrDato3: TDataSource;
    selT770D_TIPOQUOTA: TStringField;
    selT770D_DATO1: TStringField;
    selT770D_DATO2: TStringField;
    selT770D_DATO3: TStringField;
    selT770IMPORTO: TFloatField;
    selT770NUM_ORE: TStringField;
    selT770PERC_INDIVIDUALE: TFloatField;
    selT770PERC_STRUTTURALE: TFloatField;
    dsrT765: TDataSource;
    dsrT265: TDataSource;
    selT770PERCENTUALE: TFloatField;
    selT770CONSIDERA_SALDO: TStringField;
    selT770SOSPENDI_PT: TStringField;
    selT770CAUSALE: TStringField;
    selT770D_CAUSALE: TStringField;
    selT770PENALIZZAZIONE: TFloatField;
    selT770VALUT_STRUTTURALE: TFloatField;
    selT770DECORRENZA_FINE: TDateTimeField;
    selT770TIPO_STAMPAQUANT: TStringField;
    selT770TOTNETTO: TFloatField;
    selT770DESCTIPOQUOTA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selT770AfterScroll(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure selT770CalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT770PERCENTUALEValidate(Sender: TField);
  private
    { Private declarations }
  public
    A164FQuoteIncentiviMW: TA164FQuoteIncentiviMW;
  end;

var
  A164FQuoteIncentiviDtM: TA164FQuoteIncentiviDtM;

implementation

uses A164UQuoteIncentivi;

{$R *.dfm}

procedure TA164FQuoteIncentiviDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A164FQuoteIncentiviMW:=TA164FQuoteIncentiviMW.Create(Self);
  A164FQuoteIncentiviMW.selT770_Funzioni:=selT770;
  InterfacciaR004:=A164FQuoteIncentivi.InterfacciaR004;
  InizializzaDataSet(selT770,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;
  A164FQuoteIncentivi.DButton.DataSet:=selT770;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
  begin
    A164FQuoteIncentiviMW.CaricamentoDati(A164FQuoteIncentiviMW.selDato1,Parametri.CampiRiferimento.C7_Dato1,InterfacciaR004.DataLavoro);
    selT770.FieldByName('D_DATO1').LookupDataset:=A164FQuoteIncentiviMW.selDato1;
  end
  else
  begin
    selT770.FieldByName('D_DATO1').Free;
    A164FQuoteIncentivi.dlblDato1.DataSource:=nil;
  end;

  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
  begin
    A164FQuoteIncentiviMW.CaricamentoDati(A164FQuoteIncentiviMW.selDato2,Parametri.CampiRiferimento.C7_Dato2,InterfacciaR004.DataLavoro);
    selT770.FieldByName('D_DATO2').LookupDataset:=A164FQuoteIncentiviMW.selDato2;
  end
  else
  begin
    selT770.FieldByName('D_DATO2').Free;
    A164FQuoteIncentivi.dlblDato2.DataSource:=nil;
  end;
  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
  begin
    A164FQuoteIncentiviMW.CaricamentoDati(A164FQuoteIncentiviMW.selDato3,Parametri.CampiRiferimento.C7_Dato3,InterfacciaR004.DataLavoro);
    selT770.FieldByName('D_DATO3').LookupDataset:=A164FQuoteIncentiviMW.selDato3;
  end
  else
  begin
    selT770.FieldByName('D_DATO3').Free;
    A164FQuoteIncentivi.dlblDato3.DataSource:=nil;
  end;

  dsrDato1.Dataset:=A164FQuoteIncentiviMW.selDato1;
  dsrDato2.Dataset:=A164FQuoteIncentiviMW.selDato2;
  dsrDato3.Dataset:=A164FQuoteIncentiviMW.selDato3;

  A164FQuoteIncentiviMW.selT765.SetVariable('DECORRENZA',InterfacciaR004.DataLavoro);
  A164FQuoteIncentiviMW.selT765.Open;

  selT770.FieldByName('D_TIPOQUOTA').LookupDataset:=A164FQuoteIncentiviMW.selT765;
  dsrT765.DataSet:=A164FQuoteIncentiviMW.selT765;

  selT770.FieldByName('D_CAUSALE').LookupDataset:=A164FQuoteIncentiviMW.selT265;
  dsrT265.DataSet:=A164FQuoteIncentiviMW.selT265;
  selT770.Open;
end;

procedure TA164FQuoteIncentiviDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A164FQuoteIncentiviMW);
  inherited;
end;

procedure TA164FQuoteIncentiviDtM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A164FQuoteIncentivi.actRefresh.Execute;
end;

procedure TA164FQuoteIncentiviDtM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A164FQuoteIncentivi.actRefresh.Execute;
end;

procedure TA164FQuoteIncentiviDtM.BeforePost(DataSet: TDataSet);
var
  Msg: String;
begin
  inherited;
  Msg:=A164FQuoteIncentiviMW.SelT770BeforePost;
  if Msg <> '' then
    R180MessageBox(Msg,'INFORMA');
end;

procedure TA164FQuoteIncentiviDtM.selT770AfterScroll(DataSet: TDataSet);
begin
  A164FQuoteIncentiviMW.SelT770AfterScroll;

  inherited;
  A164FQuoteIncentivi.dcmbCodTipoQuotaCloseUp(A164FQuoteIncentivi.dcmbCodTipoQuota);
  A164FQuoteIncentivi.dcmbAssenzaCloseUp(A164FQuoteIncentivi.dcmbAssenza);
  A164FQuoteIncentivi.dcmbTipoStampa.Text:=A164FQuoteIncentivi.dcmbTipoStampa.Items[StrToIntDef(selT770.FieldByName('TIPO_STAMPAQUANT').AsString,0)];
end;

procedure TA164FQuoteIncentiviDtM.selT770CalcFields(DataSet: TDataSet);
begin
  inherited;
  A164FQuoteIncentiviMW.selT770CalcFields;
end;

procedure TA164FQuoteIncentiviDtM.selT770PERCENTUALEValidate(Sender: TField);
begin
  inherited;
  A164FQuoteIncentivi.lblImporto.Enabled:=selT770.FieldByName('PERCENTUALE').AsInteger = 100;
  A164FQuoteIncentivi.dedtImporto.Enabled:=selT770.FieldByName('PERCENTUALE').AsInteger = 100;
  if not A164FQuoteIncentivi.dedtImporto.Enabled then
    selT770.FieldByName('IMPORTO').AsInteger:=-1;
  if A164FQuoteIncentivi.dedtImporto.Enabled and (selT770.FieldByName('IMPORTO').AsInteger = -1) then
    selT770.FieldByName('IMPORTO').AsInteger:=0;
end;

end.

