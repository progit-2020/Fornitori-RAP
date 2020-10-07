unit A014UPlusOrarioDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, RegistrazioneLog, Oracle, OracleData,
  Variants;

type
  TA014FPlusOrarioDtM1 = class(TDataModule)
    D060: TDataSource;
    T061: TOracleDataSet;
    T061Anno: TFloatField;
    T061Codice: TStringField;
    T061TipoPO: TStringField;
    T061TipoDebito: TStringField;
    T061Ore1: TStringField;
    T061Ore2: TStringField;
    T061Ore3: TStringField;
    T061Ore4: TStringField;
    T061Ore5: TStringField;
    T061Ore6: TStringField;
    T061Ore7: TStringField;
    T061Ore8: TStringField;
    T061Ore9: TStringField;
    T061Ore10: TStringField;
    T061Ore11: TStringField;
    T061Ore12: TStringField;
    T061TipoGest1: TStringField;
    T061TipoGest2: TStringField;
    T061TipoGest3: TStringField;
    T061TipoGest4: TStringField;
    T061TipoGest5: TStringField;
    T061TipoGest6: TStringField;
    T061TipoGest7: TStringField;
    T061TipoGest8: TStringField;
    T061TipoGest9: TStringField;
    T061TipoGest10: TStringField;
    T061TipoGest11: TStringField;
    T061TipoGest12: TStringField;
    T061D_Codice: TStringField;
    T060: TOracleDataSet;
    T060CODICE: TStringField;
    T060DESCRIZIONE: TStringField;
    procedure T061NewRecord(DataSet: TDataSet);
    procedure BDET061Ore1Validate(Sender: TField);
    procedure A014FPlusOrarioDtM1Create(Sender: TObject);
    procedure A014FPlusOrarioDtM1Destroy(Sender: TObject);
    procedure T061BeforeDelete(DataSet: TDataSet);
    procedure T061AfterDelete(DataSet: TDataSet);
    procedure T061BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A014FPlusOrarioDtM1: TA014FPlusOrarioDtM1;

implementation

uses A014UPlusOrario;

{$R *.DFM}

procedure TA014FPlusOrarioDtM1.A014FPlusOrarioDtM1Create(Sender: TObject);
{Collego DButton alla tabella appropriata}
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
  T060.Open;
  T061.Open;
  A014FPlusOrario.DButton.DataSet:=T061;
end;

procedure TA014FPlusOrarioDtM1.T061NewRecord(DataSet: TDataSet);
{Inizializzazioni su nuovo record}
begin
  with T061 do
    begin
    FieldByName('TipoDebito').AsString:='M';
    FieldByName('TipoPO').AsString:='0';
    FieldByName('Ore1').AsString:='00.00';
    FieldByName('Ore2').AsString:='00.00';
    FieldByName('Ore3').AsString:='00.00';
    FieldByName('Ore4').AsString:='00.00';
    FieldByName('Ore5').AsString:='00.00';
    FieldByName('Ore6').AsString:='00.00';
    FieldByName('Ore7').AsString:='00.00';
    FieldByName('Ore8').AsString:='00.00';
    FieldByName('Ore9').AsString:='00.00';
    FieldByName('Ore10').AsString:='00.00';
    FieldByName('Ore11').AsString:='00.00';
    FieldByName('Ore12').AsString:='00.00';
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

procedure TA014FPlusOrarioDtM1.BDET061Ore1Validate(Sender: TField);
var Minuti:Byte;
{Controllo che i minuti siano minori di 60}
begin
   Minuti:=StrToInt(Copy(Sender.AsString,5,2));
   if Minuti > 59 then
     Raise Exception.Create('I minuti devono essere minori di 60!');
end;

procedure TA014FPlusOrarioDtM1.A014FPlusOrarioDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA014FPlusOrarioDtM1.T061BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C','T061_PLUSORAANNUO',Copy(Name,1,4),T061,True);
end;

procedure TA014FPlusOrarioDtM1.T061AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA014FPlusOrarioDtM1.T061BeforePost(DataSet: TDataSet);
begin
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T061_PLUSORAANNUO',Copy(Name,1,4),T061,True);
    dsEdit:RegistraLog.SettaProprieta('M','T061_PLUSORAANNUO',Copy(Name,1,4),T061,True);
  end;
end;

end.
