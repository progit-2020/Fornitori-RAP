unit S735UPunteggiFasceIncentiviMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, StrUtils;

type
  TS735FPunteggiFasceIncentiviMW = class(TR005FDataModuleMW)
    selSG735: TOracleDataSet;
    selT765: TOracleDataSet;
    selT765CODICE: TStringField;
    selT765DESCRIZIONE: TStringField;
    selT765TIPOQUOTA: TStringField;
    selT765DECORRENZA: TDateTimeField;
    selT765CAUSALE_ASSESTAMENTO: TStringField;
    selT765VP_INTERA: TStringField;
    selT765VP_PROPORZIONATA: TStringField;
    selT765VP_NETTA: TStringField;
    selT765VP_NETTARISP: TStringField;
    selT765VP_RISPARMIO: TStringField;
    selT765VP_NORISPARMIO: TStringField;
    selT765VP_QUANTITATIVA: TStringField;
    selT765ACCONTI: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Q735: TOracleDataSet;
    Tipo:String;
    procedure BeforePost;
  end;


implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TS735FPunteggiFasceIncentiviMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT765.Open;
end;

procedure TS735FPunteggiFasceIncentiviMW.BeforePost;
var
  S:String;
begin

  if Tipo <> '' then
    Q735.FieldByName('TIPOLOGIA').AsString:=Tipo;
  if Q735.FieldByName('DECORRENZA_FINE').IsNull then
    Q735.FieldByName('DECORRENZA_FINE').AsDateTime:=StrToDate('31/12/3999');
  if Q735.FieldByName('DECORRENZA_FINE').AsDateTime < Q735.FieldByName('DECORRENZA').AsDateTime then
    raise exception.create('Impostare correttamente le date di decorrenza e scadenza!');
  if (Q735.FieldByName('PUNTEGGIO_DA').AsFloat < 0) or (Q735.FieldByName('PUNTEGGIO_A').AsFloat < 0) then
    raise exception.create('I valori dei punteggi devono essere maggiori di 0!');
  if Q735.FieldByName('PUNTEGGIO_DA').AsFloat > Q735.FieldByName('PUNTEGGIO_A').AsFloat then
    raise exception.create('Impostare correttamente i punteggi!');

  with selSG735 do
  begin
    Close;
    SetVariable('TIPO',Q735.FieldByName('TIPOLOGIA').AsString);
    SetVariable('QUOTA',Q735.FieldByName('CODQUOTA').AsString);
    SetVariable('FLEX',Q735.FieldByName('FLESSIBILITA').AsString);
    SetVariable('DECORRENZA',Q735.FieldByName('DECORRENZA').AsDateTime);
    SetVariable('SCADENZA',Q735.FieldByName('DECORRENZA_FINE').AsDateTime);
    SetVariable('PUNTEGGIO_DA',Q735.FieldByName('PUNTEGGIO_DA').AsFloat);
    SetVariable('PUNTEGGIO_A',Q735.FieldByName('PUNTEGGIO_A').AsFloat);
    SetVariable('SG735ROWID',IfThen(Q735.State in [dsEdit],Q735.Rowid,''));
    Open;
    while not Eof do
    begin
      S:=S + IfThen(S <> '',#10#13,'') +
         'Decorrenza: ' + FieldByName('DECORRENZA').AsString +
         ' - Scadenza: ' + FieldByName('DECORRENZA_FINE').AsString +
         ' - Punteggio da: ' + FloatToStr(FieldByName('PUNTEGGIO_DA').AsFloat) +
         ' - Punteggio a: ' + FloatToStr(FieldByName('PUNTEGGIO_A').AsFloat) +
         ' - % incentivo: ' + FloatToStr(FieldByName('PERC').AsFloat) + '!';
      Next;
    end;
    if S <> '' then
      raise exception.create('I valori indicati intersecano ' + IfThen(RecordCount = 1,'il seguente scaglione:','i seguenti scaglioni:') + #10#13 + S);
  end;

  inherited;

end;

end.
