unit B021UDizionarioAssenzeDM;

interface

uses
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} A000UCostanti, A000USessione,
  R014URestDM, Oracle, DB, OracleData,
  SysUtils, Variants, Classes;

type
  {
  TCausale = class
  private
    FCodice: String;
    FDescrizione: String;
  end;

  TDizionarioAss = class
  private
    FMatricola: String;
    FCausali: array of TCausale;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddCausale(G: TCausale);
  end;
  }

  TB021FDizionarioAssenzeDM = class(TR014FRestDM)
    selSingolo: TOracleDataSet;
    selTutti: TOracleDataSet;
  private
    Matricola: String;
    function IsAssenzaAbilitata(const Codice: String): Boolean;
    function DizionarioAssenze(Matricola:String): TJSONObject;
  protected
    function ControlloParametri(var RErrMsg: String): Boolean; override;
  public
    function GetDato: TJSONObject; override;
  end;

const
  CAUS_ABILITATE: array [1..17] of String = (
    '40101',
    '40102',
    '40110',
    '60101',
    '60103',
    '65119',
    '70101',
    '70102',
    '70103',
    '70104',
    '98001',
    '98002',
    '98005',
    '99004',
    'AGG',
    'ASG',
    'MAL'
  );

implementation

{$R *.dfm}

{
constructor TDizionarioAss.Create;
begin
  inherited;
  SetLength(FCausali,0);
end;

destructor TDizionarioAss.Destroy;
begin
  SetLength(FCausali,0);
  inherited;
end;

procedure TDizionarioAss.AddCausale(G: TCausale);
begin
  SetLength(FCausali,Length(FCausali) + 1);
  FCausali[High(FCausali)]:=G;
end;
}

//**********************************************************

function TB021FDizionarioAssenzeDM.IsAssenzaAbilitata(const Codice: String): Boolean;
var
  i: Integer;
begin
  Result:=False;
  for i:=Low(CAUS_ABILITATE) to High(CAUS_ABILITATE) do
  begin
    if Codice = CAUS_ABILITATE[i] then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TB021FDizionarioAssenzeDM.DizionarioAssenze(Matricola:String): TJSONObject;
var
  //Mar: TJSONMarshal; // serializzatore
  //DizionarioAss: TDizionarioAss;
  //Caus: TCausale;
  Progressivo: Integer;
  ODS: TOracleDataset;
  hObj: TJSONObject;
  CausArr: TJSONArray;
begin
  if Matricola = '*' then
    // estrazione di tutte le causali
    ODS:=selTutti
  else
  begin
    // verifica esistenza matricola
    selProg.SetVariable('MATRICOLA',Matricola);
    selProg.Execute;
    if selProg.RowCount = 0 then
      raise Exception.Create(Format('Matricola %s inesistente',[Matricola]))
    else
      Progressivo:=selProg.FieldAsInteger(0);

    // estrazione delle causali fruibili dal progressivo indicato
    selSingolo.SetVariable('PROGRESSIVO',Progressivo);
    ODS:=selSingolo;
  end;

  ODS.Close;
  ODS.Open;
  {
  Mar:=TJSONMarshal.Create(TJSONConverter.Create);
  try
    // convertitore per array di causali
    Mar.RegisterConverter(TDizionarioAss,'FCausali',function(Data: TObject; Field: String): TListOfObjects
      var
        obj: TCausale;
        i: Integer;
      begin
        SetLength(Result,Length(TDizionarioAss(Data).FCausali));
        i:=Low(Result);
        for obj in TDizionarioAss(Data).FCausali do
        begin
          Result[i]:=obj;
          inc(i);
        end;
      end
    );
    DizionarioAss:=TDizionarioAss.Create;
    try
      DizionarioAss.FMatricola:=Matricola;
      while not ODS.Eof do
      begin
        Caus:=TCausale.Create;
        Caus.FCodice:=ODS.FieldByName('CODICE').AsString;
        Caus.FDescrizione:=ODS.FieldByName('DESCRIZIONE').AsString;

        DizionarioAss.AddCausale(Caus);
        ODS.Next;
      end;
      ODS.Close;
      Result:=TJSONObject(Mar.Marshal(DizionarioAss));
    finally
      FreeAndNil(DizionarioAss);
    end;
  finally
    FreeAndNil(Mar);
  end;
  }
  CausArr:=TJSONArray.Create;
  if ODS.RecordCount > 0 then
  begin
    while not ODS.Eof do
    begin
      hObj:=TJSONObject.Create;
      hObj.AddPair('codice',TJSONString.Create(ODS.FieldByName('CODICE').AsString));
      hObj.AddPair('descrizione',TJSONString.Create(ODS.FieldByName('DESCRIZIONE').AsString));
      if IsAssenzaAbilitata(ODS.FieldByName('CODICE').AsString) then
        hObj.AddPair('abilitata',TJSONTrue.Create)
      else
        hObj.AddPair('abilitata',TJSONFalse.Create);
      CausArr.Add(hObj);
      ODS.Next;
    end;
    ODS.Close;
  end;
  Result:=TJSONObject.Create(TJSONPair.Create('assenze',CausArr));
end;

function TB021FDizionarioAssenzeDM.ControlloParametri(var RErrMsg: String): Boolean;
begin
  RErrMsg:='';
  Matricola:=GetParam('matricola');
  Result:=True;
end;

function TB021FDizionarioAssenzeDM.GetDato: TJSONObject;
begin
  Result:=DizionarioAssenze(Matricola);
end;

end.
