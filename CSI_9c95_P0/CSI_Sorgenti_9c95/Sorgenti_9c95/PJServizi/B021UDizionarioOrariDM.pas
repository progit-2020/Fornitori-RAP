unit B021UDizionarioOrariDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione,
  R014URestDM, Oracle, DB, OracleData,
  SysUtils, Variants, Classes;

type
  TB021FDizionarioOrariDM = class(TR014FRestDM)
    selOrari: TOracleDataSet;
  private
    Matricola,Reparto: String;
    function DizionarioOrari(Matricola:String;Reparto:String): TJSONObject;
  protected
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

function TB021FDizionarioOrariDM.DizionarioOrari(Matricola:String;Reparto:String): TJSONObject;
var
  hObj: TJSONObject;
  OrariArr: TJSONArray;
  Filtro: String;
begin
  // filtro su reparto / matricola
  Filtro:='';
  if Reparto <> '*' then
    Filtro:=Format(' AND T430.REPARTO = ''%s''',[Reparto]);
  if Matricola <> '*' then
    Filtro:=Filtro + Format(' AND T030.MATRICOLA = ''%s''',[Matricola]);

  // apertura dataset
  selOrari.Close;
  selOrari.SetVariable('DATA',Date);
  selOrari.SetVariable('FILTRO',Filtro);
  selOrari.Open;

  OrariArr:=TJSONArray.Create;
  if selOrari.RecordCount > 0 then
  begin
    while not selOrari.Eof do
    begin
      hObj:=TJSONObject.Create;
      hObj.AddPair('reparto',TJSONString.Create(selOrari.FieldByName('REPARTO').AsString));
      hObj.AddPair('descrizione',TJSONString.Create(selOrari.FieldByName('DESCRIZIONE').AsString));
      hObj.AddPair('inizioTurno',TJSONString.Create(selOrari.FieldByName('INIZIO_TURNO').AsString));
      hObj.AddPair('fineTurno',TJSONString.Create(selOrari.FieldByName('FINE_TURNO').AsString));
      hObj.AddPair('durataTurno',TJSONString.Create(selOrari.FieldByName('DURATA_TURNO').AsString));
      hObj.AddPair('inizioPM',TJSONString.Create(selOrari.FieldByName('INIZIO_PM').AsString));
      hObj.AddPair('finePM',TJSONString.Create(selOrari.FieldByName('FINE_PM').AsString));
      hObj.AddPair('durataPM',TJSONString.Create(selOrari.FieldByName('DURATA_PM').AsString));
      OrariArr.Add(hObj);
      selOrari.Next;
    end;
    selOrari.Close;
  end;
  Result:=TJSONObject.Create(TJSONPair.Create('orari',OrariArr));
end;

function TB021FDizionarioOrariDM.ControlloParametri(var RErrMsg: String): Boolean;
begin
  RErrMsg:='';
  Result:=False;

  Matricola:=GetParam('matricola');
  Reparto:=GetParam('reparto');

  if Trim(Matricola) = '' then
  begin
    RErrMsg:='Parametro [matricola] non indicato';
    Exit;
  end;

  if Trim(Reparto) = '' then
  begin
    RErrMsg:='Parametro [reparto] non indicato';
    Exit;
  end;

  Result:=True;
end;

function TB021FDizionarioOrariDM.GetDato: TJSONObject;
begin
  Result:=DizionarioOrari(Matricola,Reparto);
end;

end.
