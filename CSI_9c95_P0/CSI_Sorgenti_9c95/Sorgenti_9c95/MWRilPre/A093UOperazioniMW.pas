unit A093UOperazioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,
  Oracle;

type
  TA093FOperazioniMW = class(TR005FDataModuleMW)
    selI000_T040: TOracleDataSet;
    selI000_T100: TOracleDataSet;
    selI000_T040OPERATORE: TStringField;
    selI000_T040OPERAZIONE: TStringField;
    selI000_T040MASCHERA: TStringField;
    selI000_T040HOSTNAME: TStringField;
    selI000_T040HOSTIPADDRESS: TStringField;
    selI000_T100OPERATORE: TStringField;
    selI000_T100MASCHERA: TStringField;
    selI000_T100OPERAZIONE: TStringField;
    selI000_T100HOSTNAME: TStringField;
    selI000_T100HOSTIPADDRESS: TStringField;
    selI000_T040C_OPERAZIONE: TStringField;
    selI000_T100C_OPERAZIONE: TStringField;
    selI000_T100DATA: TDateTimeField;
    selI000_T040DATA: TDateTimeField;
    selI000Idx: TOracleQuery;
    procedure selI000_T040CalcFields(DataSet: TDataSet);
    procedure selI000_T100CalcFields(DataSet: TDataSet);
  public
    function EsisteIndiceI000: Boolean;
  end;

var
  A093FOperazioniMW: TA093FOperazioniMW;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TA093FOperazioniMW.EsisteIndiceI000: Boolean;
// verifica se esiste l'indice TABELLA + PROGRESSIVO sulla tabella I000
begin
  try
    selI000Idx.Execute;
    Result:=selI000Idx.FieldAsInteger(0) > 0;
  except
    Result:=False;
  end;
end;

procedure TA093FOperazioniMW.selI000_T040CalcFields(DataSet: TDataSet);
var
  LOperazione: String;
  LDescOperazione: String;
begin
  LOperazione:=DataSet.FieldByName('OPERAZIONE').AsString;
  if LOperazione = 'I' then
    LDescOperazione:='Inserimento'
  else if LOperazione = 'M' then
    LDescOperazione:='Modifica'
  else if LOperazione = 'C' then
    LDescOperazione:='Cancellazione';
  DataSet.FieldByName('C_OPERAZIONE').AsString:=LDescOperazione;
end;

procedure TA093FOperazioniMW.selI000_T100CalcFields(DataSet: TDataSet);
var
  LOperazione: String;
  LDescOperazione: String;
begin
  LOperazione:=DataSet.FieldByName('OPERAZIONE').AsString;
  if LOperazione = 'I' then
    LDescOperazione:='Inserimento'
  else if LOperazione = 'M' then
    LDescOperazione:='Modifica'
  else if LOperazione = 'C' then
    LDescOperazione:='Cancellazione';
  DataSet.FieldByName('C_OPERAZIONE').AsString:=LDescOperazione;
end;

end.
