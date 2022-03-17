unit A092UStampaStoricoDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle, StrUtils,
  (*Midaslib,*) Crtl, DBClient, Variants, A092UStampaStoricoMW;

type
  TA092FStampaStoricoDtM1 = class(TDataModule)
    Q430: TOracleDataSet;
    TabellaStampa: TClientDataSet;
    procedure A092FStampaStoricoDtM1Create(Sender: TObject);
    procedure A092FStampaStoricoDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    A092MW: TA092FStampaStoricoMW;
    procedure CreaTabellaStampa;
  end;

var
  A092FStampaStoricoDtM1: TA092FStampaStoricoDtM1;

implementation

uses  A092UStampaStorico;

{$R *.DFM}

procedure TA092FStampaStoricoDtM1.A092FStampaStoricoDtM1Create(Sender: TObject);
{Preparo le query Mensili}
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;

  //Parametri.Applicazione:='PAGHE'; //solo per test
  A092FStampaStorico.Stipendi:=UpperCase(Parametri.Applicazione) = 'PAGHE';
  A092MW:=TA092FStampaStoricoMW.Create(Self);
  A092MW.Inizializza(A092FStampaStorico.Stipendi);
end;

procedure TA092FStampaStoricoDtM1.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('CognomeNome',ftString,60,False);
  TabellaStampa.FieldDefs.Add('Progressivo',ftString,8,False);
  TabellaStampa.FieldDefs.Add('SeqCampo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('DataDecorrenza',ftDate,0,False);
  TabellaStampa.FieldDefs.Add('DataFine',ftString,10,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Campo',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Dato',ftString,40,False);
  TabellaStampa.FieldDefs.Add('Descrizione',ftString,100,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primary',('CognomeNome;Progressivo;SeqCampo;DataDecorrenza'),[ixUnique]);
  TabellaStampa.IndexDefs.Add('IdxData',('CognomeNome;Progressivo;DataDecorrenza;SeqCampo'),[ixUnique]);
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
  if A092FStampaStorico.rgpOrdinamento.ItemIndex = 1 then
    TabellaStampa.IndexName:='Primary'
  else
    TabellaStampa.IndexName:='IdxData';
end;

procedure TA092FStampaStoricoDtM1.A092FStampaStoricoDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
  TabellaStampa.Close;
end;

end.
