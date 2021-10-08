unit B021UTimbratureDM;

interface

uses
  System.SysUtils, System.Classes, R014URestDM, Oracle, Data.DB, OracleData,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} B021UIrisRestSvcDM, B021UUtils, C180FunzioniGenerali, Math;

type
  // classe per modellare ogni singola timbrature da esportare
  TTimbratura = class(TPersistent)
  private
    FMatricola: String;
    FBadge: Integer;
    FData: TDateTime;
    FOra: String;
    FVerso: String;
    FCausale: String;
    FRilevatore: String;
  end;

  // classe per modellare il risultato finale contenente l'array di timbrature
  TTimbrature = class(TPersistent)
  private
    FDataInizio,
    FDataFine: TDateTime;
    FTimbrature: array of TTimbratura;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddTimbratura(T: TTimbratura);
  end;

  TB021FTimbratureDM = class(TR014FRestDM)
    selVT100: TOracleDataSet;
  private
    Matricola: String;
    Inizio: TDateTime;
    Fine: TDateTime;
    function GetFiltroMatricole(PMatricole: String): String;
    function GetTimbrature(PMatricole: String; PInizio,PFine: TDateTime): TJSONObject;
  protected
    function ConvertJSON(PObj: TPersistent): TJSONObject; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

{ TTimbrature }

constructor TTimbrature.Create;
begin
  SetLength(FTimbrature,0);
end;

destructor TTimbrature.Destroy;
begin
  SetLength(FTimbrature,0);
  inherited;
end;

procedure TTimbrature.AddTimbratura(T: TTimbratura);
begin
  SetLength(FTimbrature,Length(FTimbrature) + 1);
  FTimbrature[High(FTimbrature)]:=T;
end;

//**********************************************************

function TB021FTimbratureDM.GetFiltroMatricole(PMatricole: String): String;
// estrae filtro SQL in base alle matricole indicate
// parametri:
//   PMatricole: String
//     valori ammessi:
//     *                           = tutte le anagrafiche dei turnisti
//     [matricola]                 = singola anagrafica
begin
  if PMatricole = '*' then
  begin
    // * = tutte le anagrafiche dei turnisti
    // il filtro è già operato sulla vista personalizzata USR_VT100_FIRLAB
    Result:='';
  end
  else
  begin
    // matricola singola
    Result:=Format('and    VT100.MATRICOLA = ''%s''',[PMatricole]);
  end;
end;

function TB021FTimbratureDM.ControlloParametri(var RErrMsg: String): Boolean;
var
  TempStr: String;
begin
  RErrMsg:='';

  if Operazione = 'R' then
  begin
    Result:=False;

    // controllo parametri get
    Matricola:=GetParam('matricola');

    TempStr:=GetParam('inizio');
    if not ConvertiStrDate(TempStr,Inizio) then
    begin
      RErrMsg:='Parametro data inizio non valido: ' + TempStr;
      Exit;
    end;

    TempStr:=GetParam('fine');
    if not ConvertiStrDate(TempStr,Fine) then
    begin
      RErrMsg:='Parametro data fine non valido: ' + TempStr;
      Exit;
    end;

    if Fine < Inizio then
    begin
      RErrMsg:='Parametro data fine (' + ConvertiDateStr(Fine) + ') precedente a parametro data inizio (' + ConvertiDateStr(Inizio) + ')';
      Exit;
    end;
  end;

  // controlli ok
  Result:=True;
end;

function TB021FTimbratureDM.GetTimbrature(PMatricole: String; PInizio, PFine: TDateTime): TJSONObject;
var
  ElencoTimb: TTimbrature;
  Timb: TTimbratura;
  BufferRec: Integer;
const
  NOME_PROC = 'GetTimbrature';
begin
  // apre il dataset delle timbrature
  selVT100.Close;
  selVT100.SetVariable('FILTRO_ANAG',GetFiltroMatricole(PMatricole));
  selVT100.SetVariable('INIZIO',PInizio);
  selVT100.SetVariable('FINE',PFine);
  // imposta readbuffer in base a numero giorni e a matricole (limite = 1000)
  BufferRec:=Trunc(PFine - PInizio) + 1;
  if PMatricole = '*' then
    BufferRec:=BufferRec * 500;
  selVT100.ReadBuffer:=Min(1000,BufferRec);
  try
    selVT100.Open;
    Log(NOME_PROC,Format('%d timbrature estratte',[selVT100.RecordCount]));
  except
    on E: Exception do
    begin
      Log(NOME_PROC,Format('errore durante l''estrazione delle timbrature: %s',[E.Message]));
      raise EB021InvalidStructure.Create(Format('Errore durante l''estrazione delle timbrature: %s',[E.Message]));
    end;
  end;

  // prepara l'oggetto Timbrature, che sarà poi convertito in json
  ElencoTimb:=TTimbrature.Create;
  try
    ElencoTimb.FDataInizio:=PInizio;
    ElencoTimb.FDataFine:=PFine;
    while not selVT100.Eof do
    begin
      // prepara oggetto timbratura da aggiungere all'array
      Timb:=TTimbratura.Create;
      Timb.FMatricola:=selVT100.FieldByName('MATRICOLA').AsString;
      Timb.FBadge:=selVT100.FieldByName('BADGE').AsInteger;
      Timb.FData:=selVT100.FieldByName('DATA').AsDateTime;
      Timb.FOra:=selVT100.FieldByName('ORA').AsString;
      Timb.FVerso:=selVT100.FieldByName('VERSO').AsString;
      Timb.FCausale:=selVT100.FieldByName('CAUSALE').AsString;
      Timb.FRilevatore:=selVT100.FieldByName('RILEVATORE').AsString;

      ElencoTimb.AddTimbratura(Timb);
      selVT100.Next;
    end;

    Result:=ConvertJSON(ElencoTimb);
  finally
    FreeAndNil(ElencoTimb);
  end;
end;

function TB021FTimbratureDM.ConvertJSON(PObj: TPersistent): TJSONObject;
var
  ElencoTimb: TTimbrature;
  TimbArr: TJSONArray;
  hObj: TJSONObject;
  Timb: TTimbratura;
  i: Integer;
begin
  if not Assigned(PObj) then
  begin
    Result:=nil;
    Exit;
  end;

  ElencoTimb:=(PObj as TTimbrature);

  Result:=TJSONObject.Create;
  Result.AddPair('start',TJSONString.Create(ConvertiDateStr(ElencoTimb.FDataInizio)));
  Result.AddPair('end',TJSONString.Create(ConvertiDateStr(ElencoTimb.FDataFine)));
  TimbArr:=TJSONArray.Create;
  for i:=0 to High(ElencoTimb.FTimbrature) do
  begin
    Timb:=ElencoTimb.FTimbrature[i];
    hObj:=TJSONObject.Create;
    hObj.AddPair('idEmployee',TJSONString.Create(Timb.FMatricola));
    hObj.AddPair('badgeEmployee',TJSONString.Create(Timb.FBadge.ToString));
    hObj.AddPair('timestamp',TJSONString.Create(ConvertiDateStr(Timb.FData) + ' ' + Timb.FOra));
    hObj.AddPair('terminal',TJSONString.Create(Timb.FRilevatore));
    hObj.AddPair('actionCode',TJSONString.Create(Timb.FVerso));

    TimbArr.Add(hObj);
  end;
  Result.AddPair('timeAttendanceList',TimbArr);
end;

function TB021FTimbratureDM.GetDato: TJSONObject;
begin
  Result:=GetTimbrature(Matricola,Inizio,Fine);
end;

end.
