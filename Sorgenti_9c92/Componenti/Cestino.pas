unit Cestino;

interface

uses
  System.Variants, DB, Oracle, OracleData, A000UInterfaccia, System.Classes, A000UCostanti,
  Vcl.StdCtrls, System.SysUtils, C180FunzioniGenerali;

type
  TCestino = class
  private
    SessionCestino:TOracleSession;
    distI025:TOracleDataSet;
    selI025:TOracleDataSet;
    procedure CreaSelI025;
    procedure CestinoAfterOpen(DataSet: TDataSet);
  public
    constructor Create(MySession:TOracleSession);
    destructor Destroy; override;
    function TestRipristino:Boolean;
    function Ripristino(ValoreNew:String = ''):string;
    function CancFisica:string;
    function Get_selI025:TOracleDataSet;
    function CodToDesc(InCod:string):string;
    function DescToCod(InDesc:string):string;
    function CancLogica(Tabella,ValoreOld:string):string;
    procedure ListaTabelle(LstTabelle:TStrings);
    procedure Seek_selI025(InTabella:variant);
    procedure CaricaCestino;
  end;

implementation

{--CESTINO--}

procedure TCestino.CestinoAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
  DataSet.FieldByName('CHIAVE').DisplayLabel:='Elemento';
  DataSet.FieldByName('UTENTE').DisplayLabel:='Utente';
  DataSet.FieldByName('DATA').DisplayLabel:='Data';
  for i:=0 to DataSet.FieldCount - 1 do
  begin
    if R180In(DataSet.Fields[i].FieldName,['CHIAVE','UTENTE']) then
      DataSet.Fields[i].DisplayWidth:=25
    else if R180In(DataSet.Fields[i].FieldName,['DATA']) then
      DataSet.Fields[i].DisplayWidth:=20
    else if R180In(DataSet.Fields[i].FieldName,['ID','TABELLA']) then
      DataSet.Fields[i].Visible:=False;
  end;
end;

procedure TCestino.CreaSelI025;
begin
  selI025:=TOracleDataSet.Create(nil);
  with selI025 do
  begin
    Session:=SessionCestino;
    SQL.Add('select I025.*, I025.ROWID');
    SQL.Add('  from I025_CESTINO I025');
    SQL.Add(' where I025.TABELLA = nvl(:TABELLA,I025.TABELLA)');
    SQL.Add('order by I025.TABELLA, I025.CHIAVE');
    DeclareVariable('TABELLA',otString);
    AfterOpen:=CestinoAfterOpen;
  end;
end;

constructor TCestino.Create(MySession:TOracleSession);
begin
  SessionCestino:=MySession;
  CreaSelI025;
  distI025:=TOracleDataSet.Create(nil);
  with distI025 do
  begin
    Session:=SessionCestino;
    SQL.Add('select distinct I025.TABELLA');
    SQL.Add('  from I025_CESTINO I025');
    SQL.Add(' order by I025.TABELLA');
  end;
end;

destructor TCestino.Destroy;
begin
  FreeAndNil(selI025);
  FreeAndNil(distI025);
  inherited;
end;

function TCestino.CancFisica:string;
begin
  with TOracleQuery.Create(nil) do
    try
      Session:=SessionCestino;
      SQL.Add('begin');
      SQL.Add('  :ESITO:=i025pck_cestino.CancFisica(:ID, :TABELLA);');
      SQL.Add('end;');
      DeclareVariable('ID',otString);
      DeclareVariable('TABELLA',otString);
      DeclareVariable('ESITO',otString);
      SetVariable('ID',selI025.FieldByName('ID').AsString);
      SetVariable('TABELLA',selI025.FieldByName('TABELLA').AsString);
      SetVariable('ESITO',null);
      Execute;
      Result:=VarToStr(GetVariable('ESITO'));
    finally
      Free;
    end;
end;

function TCestino.TestRipristino:Boolean;
begin
  Result:=False;
  if Not selI025.Active then
    Exit;
  with TOracleQuery.Create(nil) do
    try
      Session:=SessionCestino;
      SQL.Add('begin');
      SQL.Add('  :ESITO:=i025pck_cestino.CheckValore(:TABELLA,:VALORE);');
      SQL.Add('end;');
      DeclareVariable('TABELLA',otString);
      DeclareVariable('VALORE',otString);
      DeclareVariable('ESITO',otString);
      SetVariable('TABELLA',selI025.FieldByName('TABELLA').asString);
      SetVariable('VALORE',selI025.FieldByName('CHIAVE').asString);
      Execute;
      Result:=VarToStr(GetVariable('ESITO')) = 'S';
    finally
      Free;
    end;
end;

function TCestino.Ripristino(ValoreNew:String = ''):string;
begin
  with TOracleQuery.Create(nil) do
    try
      Session:=SessionCestino;
      SQL.Add('begin');
      SQL.Add('  :ESITO:=i025pck_cestino.ripristino(:ID,:TABELLA,:MYVALORE);');
      SQL.Add('end;');
      DeclareVariable('ID',otString);
      DeclareVariable('TABELLA',otString);
      DeclareVariable('MYVALORE',otString);
      DeclareVariable('ESITO',otString);
      SetVariable('ID',selI025.FieldByName('ID').AsString);
      SetVariable('TABELLA',selI025.FieldByName('TABELLA').AsString);
      SetVariable('MYVALORE',ValoreNew);
      SetVariable('ESITO',null);
      Execute;
      Result:=VarToStr(GetVariable('ESITO'));
    finally
      Free;
    end;
end;

function TCestino.Get_selI025:TOracleDataSet;
begin
  Result:=selI025;
end;

function TCestino.CodToDesc(InCod:string):string;
var
  i:integer;
begin
  Result:=InCod;
  i:=low(TabelleDizionario);
  while (TabelleDizionario[i].Tabella <> InCod) and
        (i < high(TabelleDizionario)) do
    inc(i);
  if TabelleDizionario[i].Tabella = InCod then
    Result:=TabelleDizionario[i].DescTabella;
end;

function TCestino.DescToCod(InDesc:string):string;
var
  i:integer;
begin
  Result:=InDesc;
  i:=low(TabelleDizionario);
  while (TabelleDizionario[i].DescTabella <> InDesc) and
        (i < high(TabelleDizionario)) do
    inc(i);
  if TabelleDizionario[i].DescTabella = InDesc then
    Result:=TabelleDizionario[i].Tabella;
end;

procedure TCestino.ListaTabelle(LstTabelle:TStrings);
begin
  distI025.Open;
  while Not distI025.Eof do
  begin
    LstTabelle.Add(CodToDesc(distI025.FieldByName('TABELLA').AsString));
    distI025.Next;
  end;
end;

function TCestino.CancLogica(Tabella,ValoreOld:string):string;
begin
  with TOracleQuery.Create(nil) do
    try
      Session:=SessionCestino;
      SQL.Add('begin :ESITO:=i025pck_cestino.CancLogica(:TABELLA,:VALOREOLD,:OPERATORE);');
      SQL.Add(' :NEWID:=i025pck_cestino.GetID; end;');
      DeclareVariable('ESITO',otString);
      DeclareVariable('TABELLA',otString);
      DeclareVariable('VALOREOLD',otString);
      DeclareVariable('OPERATORE',otString);
      DeclareVariable('NEWID',otString);
      SetVariable('TABELLA',Tabella);
      SetVariable('VALOREOLD',ValoreOld);
      SetVariable('OPERATORE',Parametri.Operatore);
      Execute;
      Result:=VarToStr(GetVariable('ESITO'));
      if Result.IsEmpty then
      begin
        SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) + 1);
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Tabella:=CodToDesc(Tabella);
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Codice:=VarToStr(GetVariable('NEWID'));
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Cestino:=True;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Abilitato:=False;
      end;
    finally;
      Free;
    end;
end;

procedure TCestino.Seek_selI025(InTabella:variant);
begin
  R180SetVariable(selI025,'TABELLA',InTabella);
  selI025.Open;
end;

procedure TCestino.CaricaCestino;
begin
  try
    Seek_selI025(null);
    while not selI025.Eof do
    begin
      SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) + 1);
      with Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)] do
      begin
        Tabella:=CodToDesc(selI025.FieldByName('TABELLA').AsString);
        Codice:=selI025.FieldByName('ID').AsString;
        Abilitato:=False;
        Cestino:=True;
      end;
      selI025.Next;
    end;
    selI025.Close;
  except
  end;
end;

end.
