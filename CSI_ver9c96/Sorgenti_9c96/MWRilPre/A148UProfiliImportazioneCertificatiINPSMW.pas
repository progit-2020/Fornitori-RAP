unit A148UProfiliImportazioneCertificatiINPSMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, R005UDataModuleMW, OracleData, Data.DB;

type
  TA148FProfiliImportazioneCertificatiINPSMW = class(TR005FDataModuleMW)
    selFiltroNull: TOracleDataSet;
    selT265: TOracleDataSet;
    selT265CODICE: TStringField;
    selT265_All: TOracleDataSet;
    selT265_AllCODICE: TStringField;
    selT265_AllDESCRIZIONE: TStringField;
    selT265DESCRIZIONE: TStringField;
    selI500: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selT269MW:TOracleDataSet;
    procedure selT290MWBeforePost;
  end;

var
  A148FProfiliImportazioneCertificatiINPSMW: TA148FProfiliImportazioneCertificatiINPSMW;

implementation

{$R *.dfm}

procedure TA148FProfiliImportazioneCertificatiINPSMW.DataModuleCreate(
  Sender: TObject);
begin
  inherited;
  selT265.Open;
  selT265_All.Open;
  selI500.Open;
end;

procedure TA148FProfiliImportazioneCertificatiINPSMW.selT290MWBeforePost;
begin
  if selT269MW.FieldByName('CAUS_INSERIMENTO').IsNull then
    raise Exception.Create('Cusale d''inserimento non valorizzata!');
  //Verifico che ci sia la presenza di un singolo filtro = null
  if ((selT269MW.State in [dsInsert]) and selT269MW.FieldByName('FILTRO').IsNull) or
     ((selT269MW.State in [dsEdit]) and (selT269MW.FieldByName('FILTRO').medpOldValue <> null) and
      (selT269MW.FieldByName('FILTRO').Value = null)) then
  begin
    selFiltroNull.Close;
    selFiltroNull.Open;
    if selFiltroNull.RecordCount > 0 then
      raise Exception.Create('Profilo generico senza filtro già inserito.');
  end;
end;

end.
