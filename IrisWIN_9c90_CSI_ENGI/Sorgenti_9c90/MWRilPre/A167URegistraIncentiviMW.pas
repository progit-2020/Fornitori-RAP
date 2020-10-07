unit A167URegistraIncentiviMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Generics.Collections,
  Data.DB, OracleData, C180FunzioniGenerali, USelI010, A000UInterfaccia, Oracle;

type
  TTipoCalcolo = record
    Codice: String;
    Descrizione: String;
  end;

  TQuota = record
    Codice: String;
    Descrizione: String;
  end;

  TA167FRegistraIncentiviMW = class(TR005FDataModuleMW)
    selT765B: TOracleDataSet;
    selT765: TOracleDataSet;
    selSQL: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    selI010:TselI010;
    function isRegoleC: Boolean;
    procedure SettaDataQuote(Data: TDateTime);  //richiamata anche da B028
    function getElencoQuote(TipoQuota: String): TList<TQuota>;
    function getElencoTipoCalcolo(Data: TDateTime): TList<TTipoCalcolo>;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TA167FRegistraIncentiviMW }
procedure TA167FRegistraIncentiviMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selI010:=TselI010.Create(Self);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','','NOME_LOGICO');
end;

procedure TA167FRegistraIncentiviMW.SettaDataQuote(Data: TDateTime);
begin
  selT765.Close;
  selT765.SetVariable('DATA',R180FineMese(data));
  selT765.Open;
end;

function TA167FRegistraIncentiviMW.getElencoQuote(TipoQuota: String): TList<TQuota>;
var
  Quota: TQuota;
begin
  Result:=TList<TQuota>.Create;

  with selT765 do
  begin
    Filter:='TIPOQUOTA = ''' + TipoQuota + '''';
    Filtered:=True;
    First;
    while not Eof do
    begin
      Quota.Codice:=FieldByName('Codice').AsString;
      Quota.Descrizione:=Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]);
      Result.Add(Quota);
      Next;
    end;
    Filter:='';
    Filtered:=False;
  end;
end;

function TA167FRegistraIncentiviMW.getElencoTipoCalcolo(Data: TDateTime): TList<TTipoCalcolo>;
var
  TipoCalcolo: TTipoCalcolo;
begin
  Result:=TList<TTipoCalcolo>.Create;
  selT765B.Close;
  selT765B.SetVariable('DATA',R180FineMese(Data));
  selT765B.Open;
  selT765B.First;
  while not selT765B.Eof do
  begin
    if selT765B.FieldByName('TIPOQUOTA').AsString = 'A' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='A - Acconto mensile individuale proporzionato su assenze, registrato su ogni mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'S' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='S - Saldo mens.individuale non proporzionato su assenze, registrato su ogni mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'T' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='T - Saldo mens.individuale non proporzionato su assenze, registrato su ultimo mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'I' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='I - Saldo mens.individuale prop. su assenze, % valutazione e pesature, reg. su ultimo mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'V' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='V - Saldo mens.individuale valutativo con prop.totale (acconti+saldi), reg. su ultimo mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'C' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='C - Saldo annuale collettivo proporzionato su acconti, registrato su ultimo mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'D' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='D - Saldo annuale collettivo valutativo, registrato su ultimo mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'Q' then
    begin
      TipoCalcolo.Codice:=selT765B.FieldByName('TIPOQUOTA').AsString;
      TipoCalcolo.Descrizione:='Q - Quota quantitativa individuale, registrata su ultimo mese';
      Result.Add(TipoCalcolo);
    end
    else if selT765B.FieldByName('TIPOQUOTA').AsString = 'P' then
    begin
      TipoCalcolo.Codice:='P';
      TipoCalcolo.Descrizione:='P - Penalizzazione';
      Result.Add(TipoCalcolo);
      TipoCalcolo.Codice:='R';
      TipoCalcolo.Descrizione:='R - Rateizzazione, registrata con codice quota ''_''';
      Result.Add(TipoCalcolo);
    end;
    selT765B.Next;
  end;
end;

function TA167FRegistraIncentiviMW.isRegoleC: Boolean;
begin
  selSQL.SQL.Clear;
  selSQL.SQL.Add('SELECT COUNT(*) FROM T760_REGOLEINCENTIVI WHERE TIPO = ''C''');
  selSQL.Execute;
  Result:=selSQL.Field(0) > 0;
end;

procedure TA167FRegistraIncentiviMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selI010);
  inherited;
end;

end.
