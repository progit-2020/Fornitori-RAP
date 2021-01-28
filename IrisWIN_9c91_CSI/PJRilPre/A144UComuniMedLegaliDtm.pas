unit A144UComuniMedLegaliDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, A144UComuniMedLegaliMW, DB, OracleData, Oracle;

type
  TA144FComuniMedLegaliDtm = class(TR004FGestStoricoDtM)
    selT486: TOracleDataSet;
    selT486COD_COMUNE: TStringField;
    selT486MED_LEGALE: TStringField;
    selT486D_COMUNE: TStringField;
    selT486D_MEDLEGALE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT486MED_LEGALEChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    A144FComuniMedLegaliMW:TA144FComuniMedLegaliMW;
  end;

var
  A144FComuniMedLegaliDtm: TA144FComuniMedLegaliDtm;

implementation

uses A144UComuniMedLegali;

{$R *.dfm}

procedure TA144FComuniMedLegaliDtm.BeforePostNoStorico(DataSet: TDataSet);
begin
  A144FComuniMedLegaliMW.BeforePostNoStorico;
  inherited;
end;

procedure TA144FComuniMedLegaliDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT486,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);

  A144FComuniMedLegaliMW:=TA144FComuniMedLegaliMW.Create(Self);
  A144FComuniMedLegaliMW.selT486:=selT486;

  selT486.FieldByName('D_COMUNE').LookupDataSet:=A144FComuniMedLegaliMW.selT480;
  selT486.FieldByName('D_MED_LEGALE').LookupDataSet:=A144FComuniMedLegaliMW.selT485;

  selT486.Open;
end;

procedure TA144FComuniMedLegaliDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  selT486.Close;
end;

procedure TA144FComuniMedLegaliDtm.selT486MED_LEGALEChange(Sender: TField);
begin
  inherited;
  if selT486MED_LEGALE.AsString = '' then
    A144FComuniMedLegali.dlblMedLegale.Caption:='';
end;

end.
