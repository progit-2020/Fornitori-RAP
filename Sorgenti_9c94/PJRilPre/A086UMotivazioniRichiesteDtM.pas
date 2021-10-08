unit A086UMotivazioniRichiesteDtM;

interface

uses
  A086UMotivazioniRichiesteMW, A000UMessaggi,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, Oracle,
  QueryPK;

type
  TA086FMotivazioniRichiesteDtM = class(TR004FGestStoricoDtM)
    selT106: TOracleDataSet;
    selT106TIPO: TStringField;
    selT106CODICE: TStringField;
    selT106DESCRIZIONE: TStringField;
    selT106CODICE_DEFAULT: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT106NewRecord(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  public
    A086MW: TA086FMotivazioniRichiesteMW;
  end;

var
  A086FMotivazioniRichiesteDtM: TA086FMotivazioniRichiesteDtM;

implementation

uses A086UMotivazioniRichieste;

{$R *.dfm}

procedure TA086FMotivazioniRichiesteDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT106,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selT106.Open;
  A086MW:=TA086FMotivazioniRichiesteMW.Create(Self);
  A086MW.selT106_Funzioni:=selT106;
end;

procedure TA086FMotivazioniRichiesteDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A086MW);
  inherited;
end;

procedure TA086FMotivazioniRichiesteDtM.selT106NewRecord(DataSet: TDataSet);
var
  Tipo: String;
begin
  Tipo:='';
  if A086FMotivazioniRichieste.cmbTipo.ItemIndex <> -1 then
    Tipo:=A086FMotivazioniRichieste.cmbTipo.Items[A086FMotivazioniRichieste.cmbTipo.ItemIndex];
  if Tipo = '' then
    raise Exception.Create(A000MSG_A086_ERR_TIPO);

  A086MW.SelT106NewRecord(Tipo);
  inherited;
end;

procedure TA086FMotivazioniRichiesteDtM.BeforeDelete(DataSet: TDataSet);
// controlli per cancellazione record
begin
  inherited;
  A086MW.SelT106BeforeDelete;
end;

procedure TA086FMotivazioniRichiesteDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  // codice not null
  if (selT106.FieldByName('CODICE').IsNull) or
     (selT106.FieldByName('CODICE').AsString.Trim = '') then
    raise Exception.Create('Il codice non può essere nullo!');
  inherited;
  A086MW.SelT106BeforePost;
end;

end.
