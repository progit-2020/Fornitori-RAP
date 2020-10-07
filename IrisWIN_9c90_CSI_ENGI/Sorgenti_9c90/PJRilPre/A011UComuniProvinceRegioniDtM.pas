unit A011UComuniProvinceRegioniDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, OracleData, Oracle, A011UEntiLocaliMW,
  A000UCostanti, A000USessione,A000UInterfaccia, C180FUNZIONIGENERALI, R004UGestStoricoDtM, Variants;

type
  TA011FComuniProvinceRegioniDtM = class(TR004FGestStoricoDtM)
    T480: TOracleDataSet;
    T480D_REGIONE: TStringField;
    T480D_PROVINCIA: TStringField;
    T480CODICE: TStringField;
    T480CITTA: TStringField;
    T480CAP: TStringField;
    T480PROVINCIA: TStringField;
    T481: TOracleDataSet;
    T481COD_PROVINCIA: TStringField;
    T481DESCRIZIONE: TStringField;
    T481COD_REGIONE: TStringField;
    D480: TDataSource;
    D481: TDataSource;
    T481D_REGIONE: TStringField;
    T482: TOracleDataSet;
    D482: TDataSource;
    T480COD_REGIONE: TStringField;
    T480CODCATASTALE: TStringField;
    T482COD_REGIONE: TStringField;
    T482DESCRIZIONE: TStringField;
    T482COD_IRPEF: TStringField;
    T482FISCALE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure T480CODCATASTALEValidate(Sender: TField);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    { Public declarations }
    A011FEntiLocaliMW:TA011FEntiLocaliMW;
    procedure InizializzaDButton;
  end;

var
  A011FComuniProvinceRegioniDtM: TA011FComuniProvinceRegioniDtM;

implementation

uses A011UComuniProvinceRegioni;

{$R *.DFM}


procedure TA011FComuniProvinceRegioniDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A011FEntiLocaliMW:=TA011FEntiLocaliMW.Create(Self);
  A011FComuniProvinceRegioni.dcbxCodProvincia.ListSource:=A011FEntiLocaliMW.dsrT481;
  T480.FieldByName('D_PROVINCIA').LookupDataSet:=A011FEntiLocaliMW.selT481;
  T480.FieldByName('COD_REGIONE').LookupDataSet:=A011FEntiLocaliMW.selT481;
  T480.FieldByName('D_REGIONE').LookupDataSet:=A011FEntiLocaliMW.selT481;
  A011FComuniProvinceRegioni.dcbxCodRegione.ListSource:=A011FEntiLocaliMW.dsrT482;
  T481.FieldByName('D_REGIONE').LookupDataSet:=A011FEntiLocaliMW.selT482;
  A011FComuniProvinceRegioni.rgpTipoSelezione.ItemIndex:=0;
  T481.Open;
  T482.Open;
end;

procedure TA011FComuniProvinceRegioniDtM.InizializzaDButton;
//Procedure di inizializzazione del DButton attivo per ricostruzione query di controllo chiave primaria
var TabellaAttiva: TOracleDataSet;
begin
  TabellaAttiva:=T480;
  case A011FComuniProvinceRegioni.pgcmain.ActivePageIndex of
    0: TabellaAttiva:=T480;
    1: TabellaAttiva:=T481;
    2: TabellaAttiva:=T482;
  end;
  A011FEntiLocaliMW.selEnte:=TabellaAttiva;
  InizializzaDataSet(TabellaAttiva,[evBeforeEdit,
                           evBeforeInsert,
                           evBeforePostNoStorico,
                           evBeforeDelete,
                           evAfterDelete,
                           evAfterPost,
                           evOnTranslateMessage]);
end;

procedure TA011FComuniProvinceRegioniDtM.T480CODCATASTALEValidate(Sender: TField);
begin
  A011FEntiLocaliMW.ValidaCodiceCatastale;
end;

procedure TA011FComuniProvinceRegioniDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  if DataSet = T480 then
    A011FEntiLocaliMW.selEnteBeforePost('C')
  else if DataSet = T482 then
    A011FEntiLocaliMW.selEnteBeforePost('R');
  inherited;
end;

end.

