unit A148UProfiliImportazioneCertificatiINPSDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, R004UGestStoricoDTM, DB, OracleData,
  A148UProfiliImportazioneCertificatiINPSMW, A000UInterfaccia;

type
  TA148FProfiliImportazioneCertificatiINPSDtm = class(TR004FGestStoricoDtM)
    selT269: TOracleDataSet;
    selT269CODICE: TStringField;
    selT269FILTRO: TStringField;
    selT269CAUS_PROVVISORIA: TStringField;
    selT269CAUS_RICOVERO: TStringField;
    selT269CAUS_POSTRICOVERO: TStringField;
    selT269CAUS_SALVAVITA: TStringField;
    selT269CAUS_SERVIZIO: TStringField;
    selT269CAUS_INSERIMENTO: TStringField;
    selT269dCInserimento: TStringField;
    selT269dCProvvisoria: TStringField;
    selT269dCRicovero: TStringField;
    selT269dCPostRicovero: TStringField;
    selT269dCSalvaVita: TStringField;
    selT269dCServizio: TStringField;
    selT269POSTRICOVERO_AUTO: TStringField;
    selT269CAUS_PATGRAVI: TStringField;
    selT269dCPatGravi: TStringField;
    selT269CAUS_GRAVIDANZA: TStringField;
    selT269dCGravidanza: TStringField;
    selT269STATO_CAUSA_MALATTIA: TStringField;
    selT269SCausaMalattia: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT269BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    A148MW: TA148FProfiliImportazioneCertificatiINPSMW;
  public
    { Public declarations }
  end;

var
  A148FProfiliImportazioneCertificatiINPSDtm: TA148FProfiliImportazioneCertificatiINPSDtm;

implementation

{$R *.dfm}

procedure TA148FProfiliImportazioneCertificatiINPSDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A148MW:=TA148FProfiliImportazioneCertificatiINPSMW.Create(Self);
  with selT269.FieldByName('dCInserimento') do
  begin
    KeyFields:='CAUS_INSERIMENTO';
    LookupDataSet:=A148MW.selT265;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with selT269.FieldByName('dCProvvisoria') do
  begin
    KeyFields:='CAUS_PROVVISORIA';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with selT269.FieldByName('dCRicovero') do
  begin
    KeyFields:='CAUS_RICOVERO';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with selT269.FieldByName('dCPostRicovero') do
  begin
    KeyFields:='CAUS_POSTRICOVERO';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with selT269.FieldByName('dCSalvaVita') do
  begin
    KeyFields:='CAUS_SALVAVITA';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with selT269.FieldByName('dCServizio') do
  begin
    KeyFields:='CAUS_SERVIZIO';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
  end;
  with selT269.FieldByName('dCGravidanza') do
  begin
    KeyFields:='CAUS_GRAVIDANZA';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
    Visible:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
  end;
  with selT269.FieldByName('dCPatGravi') do
  begin
    KeyFields:='CAUS_PATGRAVI';
    LookupDataSet:=A148MW.selT265_All;
    LookupKeyFields:='CODICE';
    LookupResultField:='DESCRIZIONE';
    Visible:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
  end;
  with selT269.FieldByName('SCausaMalattia') do
  begin
    KeyFields:='STATO_CAUSA_MALATTIA';
    LookupDataSet:=A148MW.selI500;
    LookupKeyFields:='NOMECAMPO';
    LookupResultField:='NOMECAMPO';
    Visible:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
  end;
  InizializzaDataSet(selT269,[]);
  selT269.Open;
  A148MW.selT269MW:=selT269;
end;

procedure TA148FProfiliImportazioneCertificatiINPSDtm.selT269BeforePost(DataSet: TDataSet);
begin
  inherited;
  A148MW.selT290MWBeforePost;
end;

end.
