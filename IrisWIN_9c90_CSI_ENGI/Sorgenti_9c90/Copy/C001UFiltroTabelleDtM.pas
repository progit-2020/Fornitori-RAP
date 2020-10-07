unit C001UFiltroTabelleDTM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, OracleData, Variants, DBClient, A000UCostanti, A000UInterfaccia, Cestino;

type
  TC001FFiltroTabelleDTM = class(TDataModule)
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DSDistinct: TDataSource;
    D900: TDataSource;
    Query2: TOracleDataSet;
    Query1: TOracleDataSet;
    QDistinct: TOracleDataSet;
    Q900: TOracleDataSet;
    cdsLookup: TClientDataSet;
    cdsLookupLookupDa: TStringField;
    cdsLookupLookupA: TStringField;
    dsrLookup: TDataSource;
    cdsLookupLookupNumDa: TFloatField;
    cdsLookupLookupNumA: TFloatField;
    selT901: TOracleDataSet;
    procedure Query1AfterOpen(DataSet: TDataSet);
    procedure D900DataChange(Sender: TObject; Field: TField);
    procedure FilterCestino(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Query1BeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    C001Cestino:TCestino;
  public
    { Public declarations }
    Procedure Inizializzazione;
  end;

var
  C001FFiltroTabelleDTM: TC001FFiltroTabelleDTM;

implementation

uses C001UFiltroTabelle,C001USaveSettings,C001StampaLib;

{$R *.DFM}

procedure TC001FFiltroTabelleDTM.DataModuleCreate(Sender: TObject);
begin
  C001Cestino:=TCestino.Create(SessioneOracle);
end;

procedure TC001FFiltroTabelleDTM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(C001Cestino);
end;

procedure TC001FFiltroTabelleDTM.Inizializzazione;
var I:Integer;
begin
  NCampi:=Query1.FieldCount;
  DistruggiListaCampi;
  CreaListaCampi;
  C001FFiltroTabelle.Ordinamento:=False;
  for I:=0 to Query1.FieldCount-1 do
  begin
    RecCampi:=TRec_Campi.Create;
    RecCampi.Nome:=Query1.Fields[i].FieldName;
    RecCampi.Intestazione:=Query1.Fields[i].DisplayLabel;
    RecCampi.OldIntestazione:=Query1.Fields[i].DisplayLabel;
    RecCampi.Selezionato:=Query1.Fields[i].Visible;
    RecCampi.OldSelezionato:=Query1.Fields[i].Visible;
    RecCampi.Da:='';
    RecCampi.OldDa:='';
    RecCampi.A:='';
    RecCampi.OldA:='';
    RecCampi.Ordinato:=False;
    RecCampi.OldOrdinato:=False;
    RecCampi.Ascendente:=False;
    RecCampi.OldAscendente:=False;
    RecCampi.Posizione:=-1;
    RecCampi.OldPosizione:=-1;
    RecCampi.Gruppo:=False;
    RecCampi.OldGruppo:=False;
    RecCampi.NumBanda:=-1;
    ListaCampi.Add(RecCampi);
  end;
end;

procedure TC001FFiltroTabelleDTM.D900DataChange(Sender: TObject; Field: TField);
begin
  if Field = nil then
  begin
    C001FSaveForm.EdtNomeStampa.Text:=Q900.FieldByname('NomeStampa').Text;
    C001FSaveForm.EdtDescr.Text:=Q900.FieldByname('Descrizione').Text;
  end;
end;

procedure TC001FFiltroTabelleDTM.Query1AfterOpen(DataSet: TDataSet);
var i:Integer;
begin
  if not StampaAnagrafico then
    exit;
  for i:=0 to Query2.FieldCount - 1 do
    Query2.Fields[i].Visible:=pos(',' + Query2.Fields[i].FieldName + ',',',' + Parametri.CampiAnagraficiNonVisibili + ',') <= 0;
  for i:=0 to Query1.FieldCount - 1 do
    Query1.Fields[i].Visible:=pos(',' + Query1.Fields[i].FieldName + ',',',' + Parametri.CampiAnagraficiNonVisibili + ',') <= 0;
end;

procedure TC001FFiltroTabelleDTM.Query1BeforeOpen(DataSet: TDataSet);
var i:Integer;
begin
  C001Cestino.Get_selI025.Close;
  for i:=1 to High(TabelleDizionario) do
    if Pos(TabelleDizionario[i].Tabella,Query1.SQL.Text.ToUpper) > 0 then
    begin
      C001Cestino.Seek_selI025(TabelleDizionario[i].Tabella);
      Break;
    end;
end;

procedure TC001FFiltroTabelleDTM.FilterCestino(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=True;
  if C001Cestino.Get_selI025.Active and (DataSet.FindField('CODICE') <> nil) then
    Accept:=C001Cestino.Get_selI025.Lookup('ID',DataSet.FieldByName('CODICE').AsString,'ID') = null;
end;

end.

