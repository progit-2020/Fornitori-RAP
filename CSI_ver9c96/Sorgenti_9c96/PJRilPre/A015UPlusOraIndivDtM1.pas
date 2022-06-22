unit A015UPlusOraIndivDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Oracle,
  C700USelezioneAnagrafe, Variants;

type
  TA015FPlusOraIndivDtM1 = class(TDataModule)
    T090: TOracleDataSet;
    T090Progressivo: TFloatField;
    T090Anno: TFloatField;
    T090TipoPO: TStringField;
    T090TipoDebito: TStringField;
    T090Ore1: TStringField;
    T090Ore2: TStringField;
    T090Ore3: TStringField;
    T090Ore4: TStringField;
    T090Ore5: TStringField;
    T090Ore6: TStringField;
    T090Ore7: TStringField;
    T090Ore8: TStringField;
    T090Ore9: TStringField;
    T090Ore10: TStringField;
    T090Ore11: TStringField;
    T090Ore12: TStringField;
    T090TipoGest1: TStringField;
    T090TipoGest2: TStringField;
    T090TipoGest3: TStringField;
    T090TipoGest4: TStringField;
    T090TipoGest5: TStringField;
    T090TipoGest6: TStringField;
    T090TipoGest7: TStringField;
    T090TipoGest8: TStringField;
    T090TipoGest9: TStringField;
    T090TipoGest10: TStringField;
    T090TipoGest11: TStringField;
    T090TipoGest12: TStringField;
    T090DESCRIZIONE: TStringField;
    procedure L005FPlusOraIndivDtM1Create(Sender: TObject);
    procedure BDET090Ore1Validate(Sender: TField);
    procedure T090PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure T090NewRecord(DataSet: TDataSet);
    procedure A015FPlusOraIndivDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A015FPlusOraIndivDtM1: TA015FPlusOraIndivDtM1;

implementation

uses A015UPlusOraIndiv, A000UMessaggi;

{$R *.DFM}

procedure TA015FPlusOraIndivDtM1.L005FPlusOraIndivDtM1Create(Sender: TObject);
{Progressivo dipendente}
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
  T090.Open;
  A015FPlusOraIndiv.DButton.DataSet:=T090;
end;

procedure TA015FPlusOraIndivDtM1.BDET090Ore1Validate(Sender: TField);
{Controllo input ore}
var Minuti:Byte;
begin
  if Sender.IsNull then exit;
  Minuti:=StrToInt(Copy(Sender.AsString,5,2));
  if Minuti > 59 then
    raise Exception.Create(A000MSG_ERR_MINUTI);
end;

procedure TA015FPlusOraIndivDtM1.T090PostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
{Duplicazione di chiave}
begin
  ShowMessage(Format(A000MSG_A015_MSG_FMT_PLUS_GIA_INSERITO,[T090.FieldByName('Anno').AsString]));
  Action:=daAbort;
end;

procedure TA015FPlusOraIndivDtM1.T090NewRecord(DataSet: TDataSet);
{Inizializzazioni nuovo record}
begin
  with T090 do
    begin
    FieldByName('Progressivo').AsInteger:=C700Progressivo;
    FieldByName('TipoDebito').AsString:='M';
    FieldByName('TipoPO').AsString:='0';
    FieldByName('TipoGest1').AsString:='0';
    FieldByName('TipoGest2').AsString:='0';
    FieldByName('TipoGest3').AsString:='0';
    FieldByName('TipoGest4').AsString:='0';
    FieldByName('TipoGest5').AsString:='0';
    FieldByName('TipoGest6').AsString:='0';
    FieldByName('TipoGest7').AsString:='0';
    FieldByName('TipoGest8').AsString:='0';
    FieldByName('TipoGest9').AsString:='0';
    FieldByName('TipoGest10').AsString:='0';
    FieldByName('TipoGest11').AsString:='0';
    FieldByName('TipoGest12').AsString:='0';
    end;
end;

procedure TA015FPlusOraIndivDtM1.A015FPlusOraIndivDtM1Destroy(
  Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

end.
