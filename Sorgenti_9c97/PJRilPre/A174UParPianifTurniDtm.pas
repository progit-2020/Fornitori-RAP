unit A174UParPianifTurniDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStoricoDTM, DB, OracleData, Oracle, DBClient,
  A000UInterfaccia, A174UParPianifTurniMW;

type
  TA174FParPianifTurniDtm = class(TR004FGestStoricoDtM)
    selT082: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT082BeforePost(DataSet: TDataSet);
    procedure selT082AfterInsert(DataSet: TDataSet);
    procedure selT082AfterScroll(DataSet: TDataSet);
  private
    {private declarations}
  public
    A174MW: TA174FParPianifTurniMW;
  end;

var
  A174FParPianifTurniDtm: TA174FParPianifTurniDtm;

implementation

uses A174UParPianifTurni;

{$R *.dfm}

procedure TA174FParPianifTurniDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT082,[]);
  A174MW:=TA174FParPianifTurniMW.Create(Self);
  A174MW.selT082:=selT082;
  selT082.Open;
end;

procedure TA174FParPianifTurniDtm.selT082AfterInsert(DataSet: TDataSet);
begin
  inherited;
  A174MW.AfterInsert;
end;

procedure TA174FParPianifTurniDtm.selT082AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A174MW.CaricaOrdinamento('ORD_VIS',A174FParPianifTurni.lstOrdinamento.Items);
  A174MW.CaricaOrdinamento('ORD_STAMPA',A174FParPianifTurni.lstOrdinamentoStampa.Items);
end;

procedure TA174FParPianifTurniDtm.selT082BeforePost(DataSet: TDataSet);
begin
  inherited;
  A174MW.BeforePost;
  selT082.FieldByName('ORD_VIS').AsString:=
  A174MW.SalvaOrdinamento(A174FParPianifTurni.lstOrdinamento.Items);
  selT082.FieldByName('ORD_STAMPA').AsString:=
  A174MW.SalvaOrdinamento(A174FParPianifTurni.lstOrdinamentoStampa.Items);
end;

end.
