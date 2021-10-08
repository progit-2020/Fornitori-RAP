unit B021UControlliGeneraliDM;

interface

uses
  C200UWebServicesTypes, B021UUtils, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} R014URestDM, R600,
  C180FunzioniGenerali, SysUtils, Variants, Classes, Controls, Oracle;

type
  TControlli = class(TPersistent)
  private
    FInseribile: String;
    FAnomalia: String;
  end;

  TB021FControlliGeneraliDM = class(TR014FRestDM)
  private
    Matricola: String;
    Causale: String;
    Data: TDateTime;
    Dalle: String;
    Alle: String;
    function GetControlli(Matricola: String; Data: TDateTime; Causale, Dalle, Alle: String): TJSONObject;
  protected
    function ConvertJSON(PObj: TPersistent): TJSONObject; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

function TB021FControlliGeneraliDM.ConvertJSON(PObj: TPersistent): TJSONObject;
var
  Cont: TControlli;
begin
  if not Assigned(PObj) then
  begin
    Result:=nil;
    Exit;
  end;

  Cont:=TControlli(PObj);

  Result:=TJSONObject.Create;
  Result.AddPair('inseribile',TJSONString.Create(Cont.FInseribile));
  Result.AddPair('anomalia',TJSONString.Create(Cont.FAnomalia));
end;

function TB021FControlliGeneraliDM.ControlloParametri(var RErrMsg: String): Boolean;
begin
  RErrMsg:='';
  if (Operazione = OPER_READ) or (Operazione = OPER_DELETE) then
  begin
    Result:=False;

    Matricola:=GetParam('matricola');

    if not ConvertiStrDate(GetParam('data'),Data) then
    begin
      RErrMsg:='Parametro [data] non valido';
      Exit;
    end;

    Dalle:=GetParam('dalle');
    if Dalle <> '' then
    begin
      Dalle:=StringReplace(Dalle,':','.',[]);
      try
        R180OraValidate(Dalle);
      except
        on E: Exception do
        begin
          RErrMsg:=Format('Parametro [dalle] non valido: %s',[E.Message]);
          Exit;
        end;
      end;
    end;

    Alle:=GetParam('alle');
    if Alle <> '' then
    begin
      Alle:=StringReplace(Alle,':','.',[]);
      try
        R180OraValidate(Alle);
      except
        on E: Exception do
        begin
          RErrMsg:=Format('Parametro [alle] non valido: %s',[E.Message]);
          Exit;
        end;
      end;
    end;

    // controllo periodo
    if Dalle <> '' then
    begin
      if Alle = '' then
      begin
        RErrMsg:='Parametro Alle non specificato';
        Exit;
      end;
    end;

    Causale:=GetParam('causale');
  end;

  Result:=True;
end;

function TB021FControlliGeneraliDM.GetControlli(Matricola: String; Data: TDateTime; Causale, Dalle, Alle: String): TJSONObject;
var
  Progressivo: Integer;
  R600DtM1: TR600Dtm1;
  Res: TModalResult;
  Giustif: TGiustificativo;
  Cont: TControlli;
begin
  //Result:=nil;

  // verifica esistenza matricola
  selProg.SetVariable('MATRICOLA',Matricola);
  selProg.Execute;
  if selProg.RowCount = 0 then
    raise EC200DataNotFoundError.Create(Format('Matricola %s inesistente',[Matricola]))
  else
    Progressivo:=selProg.FieldAsInteger(0);

  // controllo inserimento giustificativo
  R600DtM1:=TR600Dtm1.Create(SIW.SessioneOracle);
  Cont:=TControlli.Create;
  try
    // prepara variabile Giustif
    Giustif.Inserimento:=True;
    if Dalle = '' then
    begin
      Giustif.Modo:='I';
      Giustif.DaOre:='  .  ';
      Giustif.AOre:='  .  ';
    end
    else
    begin
      Giustif.Modo:='D';
      Giustif.DaOre:=Dalle;
      Giustif.AOre:=Alle;
    end;
    Giustif.Causale:=Causale;

    // impostazione risultato
    Cont.FInseribile:='S';
    Cont.FAnomalia:='';

    Res:=R600DtM1.SettaConteggi(Progressivo,Data,Data,Giustif);
    if Res = mrAbort then
    begin
      Cont.FInseribile:='N';
      Cont.FAnomalia:='SettaConteggi abort';
    end
    else
    begin
      Res:=R600DtM1.ControlliGenerali(Data);
      case Res of
        mrIgnore:
        begin
          Cont.FInseribile:='N';
          Cont.FAnomalia:=R600DtM1.UltimaAnomalia;
        end;
        mrAbort:
        begin
          Cont.FInseribile:='N';
          Cont.FAnomalia:=R600DtM1.UltimaAnomalia;
        end;
      end;
    end;

    Result:=ConvertJSON(Cont);
  finally
    FreeAndNil(R600DtM1);
    FreeAndNil(Cont);
  end;
end;

function TB021FControlliGeneraliDM.GetDato: TJSONObject;
begin
  Result:=GetControlli(Matricola,Data,Causale,Dalle,Alle);
end;

end.
