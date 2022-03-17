unit A114UEstrazioniStampeDtm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Oracle, OracleData, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, (*Midaslib,*) Crtl, DBClient, Variants;

type
  TA114FEstrazioniStampeDtm = class(TDataModule)
    SelT930: TOracleDataSet;
    SelT930CODICE_PAR: TStringField;
    SelT930CODICE_STAMPA: TStringField;
    SelT930TIPO_FILE: TStringField;
    SelT930NOME_FILE: TStringField;
    SelT930TITOLO: TStringField;
    QSelect: TOracleDataSet;
    SelT930TABELLA_GENERATA: TStringField;
    SelT931: TOracleDataSet;
    SelT931DATO: TStringField;
    SelT931POSIZIONE: TIntegerField;
    SelT931TIPO: TStringField;
    SelT931VARIAZIONI_MAX: TIntegerField;
    TabellaTemp: TClientDataSet;
    DSel930: TDataSource;
    SelT931CHIAVE: TStringField;
    SelT932: TOracleDataSet;
    DelT932: TOracleQuery;
    SelT932DATA: TDateTimeField;
    DSelect: TDataSource;
    D932: TDataSource;
    SelT932ID: TFloatField;
    SelT932OPERATORE: TStringField;
    SelT932MASCHERA: TStringField;
    SelT931VALORE_NULL: TStringField;
    SelT931FORMATO: TStringField;
    SelT930UTENTI_PRIVILEGI: TStringField;
    SelT931SOMMA_RICORRENZE: TStringField;
    SelT932DESCRIZIONE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SelT932DESCRIZIONEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A114FEstrazioniStampeDtm: TA114FEstrazioniStampeDtm;

implementation

{$R *.DFM}

procedure TA114FEstrazioniStampeDtm.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  //Parametri.Applicazione:='RILPRE';
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
  SelT930.Open;
end;

procedure TA114FEstrazioniStampeDtm.DataModuleDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
end;

procedure TA114FEstrazioniStampeDtm.SelT932DESCRIZIONEGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  Text:=SelT932DESCRIZIONE.AsString;
end;

end.
