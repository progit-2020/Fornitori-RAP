unit B021UAssenzeDM;

interface

uses
  A000UCostanti, A000USessione, R014URestDM, C200UWebServicesTypes, B021UUtils,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} R600, C180FunzioniGenerali, B021UIrisRestSvcDM,
  SysUtils, Variants, Classes, Oracle;

type

  TAssenze = class(TPersistent)
  private
    FData: TDateTime;
    FCausaleCod: String;
    FCausaleDesc: String;
    FUMisura: String;
    FValenzaGiornaliera: Integer; // minuti
    FValCompPrec: real;
    FValCompCorr: real;
    FValCompTot: real;
    FValFruitoPrec: real;
    FValFruitoCorr: real;
    FValFruitoTot: real;
    FValResiduoPrec: real;
    FValResiduoCorr: real;
    FValResiduo: real;
    FValResiduoPrecGG: real;
    FValResiduoCorrGG: real;
    FValResiduoGG: real;
  end;

  TB021FAssenzeDM = class(TR014FRestDM)
  private
    Matricola,
    Causale: String;
    DataAss,
    DataNasFam: TDateTime;
    function GetAssenze(Matricola: String; Data: TDateTime; Causale: String; DataFamiliare: TDateTime = 0): TJSONObject;
  protected
    function ConvertJSON(PObj: TPersistent): TJSONObject; override;
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

implementation

{$R *.dfm}

function TB021FAssenzeDM.GetAssenze(Matricola: String; Data: TDateTime; Causale: String; DataFamiliare: TDateTime = 0): TJSONObject;
var
  Ass: TAssenze;
  R600DtM: TR600DtM1;
  G: TGiustificativo;
  Progressivo: Integer;
const
  NOME_PROC = 'GetAssenze';
begin
  Result:=nil;

  // verifica esistenza matricola
  selProg.SetVariable('MATRICOLA',Matricola);
  selProg.Execute;
  if selProg.RowCount = 0 then
    raise EC200InvalidParameter.Create('Matricola inesistente: ' + Matricola)
  else
    Progressivo:=selProg.FieldAsInteger(0);

  G.Inserimento:=False;
  G.Modo:='I';
  G.Causale:=Causale;

  Log(NOME_PROC,'R600DtM.Create');
  Ass:=TAssenze.Create;
  R600DtM:=TR600Dtm1.Create(SIW.SessioneOracle);
  try
    try
      // verifica esistenza causale
      if VarIsNull(R600DtM.Q265.Lookup('CODICE',Causale,'CODICE')) then
      begin
        raise EC200InvalidParameter.Create('Causale di assenza inesistente: ' + Causale);
      end;

      R600DtM.GetAssenze(Progressivo,Data,Data,DataNasFam,G,False);

      // imposta oggetto
      Ass.FData:=Data;
      Ass.FCausaleCod:=Causale;
      Ass.FCausaleDesc:=R600DtM.Q265.FieldByName('DESCRIZIONE').AsString;
      Ass.FUMisura:=R600DtM.UMisura;
      Ass.FValenzaGiornaliera:=R600DtM.ValenzaGiornaliera;
      Ass.FValCompPrec:=R600DtM.ValCompPrec;
      Ass.FValCompCorr:=R600DtM.ValCompCorr;
      Ass.FValCompTot:=R600DtM.ValCompTot;
      Ass.FValFruitoPrec:=R600DtM.ValFruitoPrec;
      Ass.FValFruitoCorr:=R600DtM.ValFruitoCorr;
      Ass.FValFruitoTot:=R600DtM.ValFruitoTot;
      Ass.FValResiduoPrec:=R600DtM.ValResiduoPrec;
      Ass.FValResiduoCorr:=R600DtM.ValResiduoCorr;
      Ass.FValResiduo:=R600DtM.ValResiduo;
      Ass.FValResiduoPrecGG:=R600DtM.ValResiduoPrecGG;
      Ass.FValResiduoCorrGG:=R600DtM.ValResiduoCorrGG;
      Ass.FValResiduoGG:=R600DtM.ValResiduoGG;

      Result:=ConvertJSON(Ass);
    except
      on E: Exception do
      begin
        raise EC200ExecutionError.Create('Errore durante estrazione dati assenza: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(R600DtM);
    FreeAndNil(Ass);
  end;
end;

function TB021FAssenzeDM.ConvertJSON(PObj: TPersistent): TJSONObject;
var
  Ass: TAssenze;
begin
  if not Assigned(PObj) then
  begin
    Result:=nil;
    Exit;
  end;

  Ass:=TAssenze(PObj);

  Result:=TJSONObject.Create;
  Result.AddPair('data',TJsonString.Create(ConvertiDateStr(Ass.FData)));
  Result.AddPair('causaleCod',TJsonString.Create(Ass.FCausaleCod));
  Result.AddPair('causaleDesc',TJsonString.Create(Ass.FCausaleDesc));
  Result.AddPair('uMisura',TJsonString.Create(Ass.FUMisura));
  Result.AddPair('valenzaGiornaliera',TJsonString.Create(R180MinutiOre(Ass.FValenzaGiornaliera)));
  Result.AddPair('valCompPrec',TJSONNumber.Create(Ass.FValCompPrec));
  Result.AddPair('valCompCorr',TJSONNumber.Create(Ass.FValCompCorr));
  Result.AddPair('valCompTot',TJSONNumber.Create(Ass.FValCompTot));
  Result.AddPair('valFruitoPrec',TJSONNumber.Create(Ass.FValFruitoPrec));
  Result.AddPair('valFruitoCorr',TJSONNumber.Create(Ass.FValFruitoCorr));
  Result.AddPair('valFruitoTot',TJSONNumber.Create(Ass.FValFruitoTot));
  Result.AddPair('valResiduoPrec',TJSONNumber.Create(Ass.FValResiduoPrec));
  Result.AddPair('valResiduoCorr',TJSONNumber.Create(Ass.FValResiduoCorr));
  Result.AddPair('valResiduo',TJSONNumber.Create(Ass.FValResiduo));
  Result.AddPair('valResiduoPrecGG',TJSONNumber.Create(Ass.FValResiduoPrecGG));
  Result.AddPair('valResiduoCorrGG',TJSONNumber.Create(Ass.FValResiduoCorrGG));
  Result.AddPair('valResiduoGG',TJSONNumber.Create(Ass.FValResiduoGG));
end;

function TB021FAssenzeDM.ControlloParametri(var RErrMsg: String): Boolean;
var
  DataFamStr: String;
begin
  RErrMsg:='';
  Result:=False;

  Matricola:=GetParam('matricola');
  Causale:=GetParam('causale');

  if not ConvertiStrDate(GetParam('data'),DataAss) then
  begin
    RErrMsg:='Parametro [data] non valido';
    Exit;
  end;

  DataFamStr:=GetParam('dataFamiliare');
  if DataFamStr = '' then
    DataNasFam:=0
  else if not ConvertiStrDateTime(DataFamStr,DataNasFam) then
  begin
    RErrMsg:='Parametro [dataFamiliare] non valido';
    Exit;
  end;

  Result:=True;
end;

function TB021FAssenzeDM.GetDato: TJSONObject;
begin
  Result:=GetAssenze(Matricola,DataAss,Causale,DataNasFam);
end;

end.
