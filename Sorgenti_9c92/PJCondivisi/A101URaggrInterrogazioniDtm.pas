unit A101URaggrInterrogazioniDtm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R004UGestStoricoDTM, Data.DB, OracleData,
  A101URaggrInterrogazioniMW, A000UInterfaccia, C180FunzioniGenerali, A000USessione,
  Oracle;

type
  TA101FRaggrInterrogazioniDtm = class(TR004FGestStoricoDtM)
    selT005: TOracleDataSet;
    selT005ID: TFloatField;
    selT005DESCRIZIONE: TStringField;
    selT006: TOracleDataSet;
    selT006ID: TFloatField;
    selT006COD_QUERY: TStringField;
    dsrT006: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT005AfterScroll(DataSet: TDataSet);
    procedure selT006BeforePost(DataSet: TDataSet);
    procedure selT006BeforeEdit(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet);
    procedure selT006BeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A101MW:TA101FRaggrInterrogazioniMW;
    procedure OpenSelT006(IDRaggr:integer);
  end;

var
  A101FRaggrInterrogazioniDtm: TA101FRaggrInterrogazioniDtm;

implementation

{$R *.dfm}

procedure TA101FRaggrInterrogazioniDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT005.Open;
  OpenSelT006(selT005.FieldByName('ID').AsInteger);
  A101MW:=TA101FRaggrInterrogazioniMW.Create(nil);
  InizializzaDataSet(selT005,[]);
end;

procedure TA101FRaggrInterrogazioniDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A101MW);
end;

procedure TA101FRaggrInterrogazioniDtm.OpenSelT006(IDRaggr:integer);
begin
  R180SetVariable(selT006,'ID_RAGGR',IDRaggr);
  selT006.Open;
end;

procedure TA101FRaggrInterrogazioniDtm.selT005AfterScroll(DataSet: TDataSet);
begin
  inherited;
  OpenSelT006(selT005.FieldByName('ID').AsInteger);
end;

procedure TA101FRaggrInterrogazioniDtm.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  //Incremento sequence T005 solo se è inserimento record
  if selT005.State in [dsInsert] then
    selT005.FieldByName('ID').AsInteger:=A101MW.GetSeqT005;
end;

procedure TA101FRaggrInterrogazioniDtm.selT006BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if not A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('COD_QUERY').AsString) then
    raise Exception.Create(Format('Impossibile cancellare l''interrogazione di servizio %s, operazione inibita da filtro dizionario.',[DataSet.FieldByName('COD_QUERY').AsString]));
end;

procedure TA101FRaggrInterrogazioniDtm.selT006BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if not A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('COD_QUERY').AsString) then
    raise Exception.Create(Format('Impossibile modificare l''interrogazione di servizio %s, operazione inibita da filtro dizionario.',[DataSet.FieldByName('COD_QUERY').AsString]));
end;

procedure TA101FRaggrInterrogazioniDtm.selT006BeforePost(DataSet: TDataSet);
begin
  inherited;
  selT006.FieldByName('ID').AsInteger:=selT005.FieldByName('ID').AsInteger;
end;

end.
