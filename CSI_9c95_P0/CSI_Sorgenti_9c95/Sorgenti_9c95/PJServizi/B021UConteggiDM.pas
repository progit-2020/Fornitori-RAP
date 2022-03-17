unit B021UConteggiDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} R014URestDM, A000UCostanti, A000USessione, Rp502Pro, R500Lin,
  C200UWebServicesTypes, B021UUtils, C180FunzioniGenerali, B021UIrisRestSvcDM,
  SysUtils, StrUtils, Variants, Classes, Oracle;

type
  TConteggi = class(TPersistent)
  private
    FData: TDateTime;
    FAnomalia: String;
    FGGVuoto: String;
    FGGPresenza: String;
    FTotLav: Integer;
  end;

  TB021FConteggiDM = class(TR014FRestDM)
  private
    Matricola: String;
    Data: TDateTime;
    function GetConteggi(Matricola: String; DataRif: TDateTime): TJSONObject;
  protected
    function ConvertJSON(PObj: TPersistent): TJSONObject; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

function TB021FConteggiDM.GetConteggi(Matricola: String; DataRif: TDateTime): TJSONObject;
var
  Progressivo: Integer;
  R502ProDtM: TR502ProDtM1;
  Cont: TConteggi;
const
  NOME_PROC = 'GetConteggi';
begin
  // verifica esistenza matricola
  selProg.SetVariable('MATRICOLA',Matricola);
  selProg.Execute;
  if selProg.RowCount = 0 then
    raise EC200DataNotFoundError.Create(Format('Matricola %s inesistente',[Matricola]))
  else
    Progressivo:=selProg.FieldAsInteger(0);
  Log(NOME_PROC,Format('matricola %s presente su database',[Matricola]));

  A000SettaVariabiliAmbiente;
  Log(NOME_PROC,'eseguito A000SettaVariabiliAmbiente');

  R502ProDtM:=TR502ProDtM1.Create(SIW.SessioneOracle,True);
  Log(NOME_PROC,'creato oggetto R502ProDtM per conteggi giornalieri');
  Cont:=TConteggi.Create;
  try
    R502ProDtM.PeriodoConteggi(DataRif,DataRif);
    Log(NOME_PROC,Format('eseguito R502ProDtM.PeriodoConteggi(%s,%s)',[DateToStr(DataRif),DateToStr(DataRif)]));

    R502ProDtM.Conteggi('Cartolina',Progressivo,DataRif);
    Log(NOME_PROC,Format('eseguito R502ProDtM.Conteggi(''Cartolina'',%d,%s)',[Progressivo,DateToStr(DataRif)]));

    Cont:=TConteggi.Create;
    Cont.FData:=DataRif;
    if R502ProDtM.Blocca = 0 then
      Cont.FAnomalia:=''
    else
      Cont.FAnomalia:=R502ProDtM.DescAnomaliaBloccante;
    Cont.FGGVuoto:=IfThen(R502ProDtM.ggvuoto = 0,'N','S');
    Cont.FGGPresenza:=IfThen(R502ProDtM.ggpresenza = 0,'N','S');
    Cont.FTotLav:=R502ProDtM.totlav;

    Result:=ConvertJSON(Cont);
  finally
    FreeAndNil(R502ProDtM);
    FreeAndNil(Cont);
  end;
end;

function TB021FConteggiDM.ConvertJSON;
var
  Cont: TConteggi;
begin
  if not Assigned(PObj) then
  begin
    Result:=nil;
    Exit;
  end;

  Cont:=TConteggi(PObj);

  Result:=TJSONObject.Create;
  Result.AddPair('data',TJsonString.Create(ConvertiDateStr(Cont.FData)));
  Result.AddPair('anomalia',TJsonString.Create(Cont.FAnomalia));
  Result.AddPair('ggVuoto',TJsonString.Create(Cont.FGGVuoto));
  Result.AddPair('ggPresenza',TJsonString.Create(Cont.FGGPresenza));
  Result.AddPair('totLav',TJsonString.Create(R180MinutiOre(Cont.FTotLav)));
end;

function TB021FConteggiDM.ControlloParametri(var RErrMsg: String): Boolean;
begin
  RErrMsg:='';
  Result:=False;

  Matricola:=GetParam('matricola');

  if not ConvertiStrDate(GetParam('data'),Data) then
  begin
    RErrMsg:='Parametro [data] non valido';
    Exit;
  end;

  Result:=True;
end;

function TB021FConteggiDM.GetDato: TJSONObject;
begin
  Result:=GetConteggi(Matricola,Data);
end;

end.
