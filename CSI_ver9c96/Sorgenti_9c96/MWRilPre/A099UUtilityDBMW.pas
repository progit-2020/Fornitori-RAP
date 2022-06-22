unit A099UUtilityDBMW;

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData,
  A000UInterfaccia, A000UCostanti, A000USessione, R005UDataModuleMW,
  Math, StrUtils;

type
  TA099FUtilityDBMW = class(TR005FDataModuleMW)
    selTablespace: TOracleDataSet;
    selTablespaceTABLESPACE: TStringField;
    selTablespaceALLOCATO: TStringField;
    selTablespaceUSATO: TStringField;
    selTablespaceDISPONIBILE: TStringField;
    selTablespaceUSATO2: TStringField;
    selTablespaceDISPONIBILE2: TStringField;
    selUserObjects: TOracleDataSet;
    Script: TOracleScript;
    selInd: TOracleDataSet;
    selTabs: TOracleDataSet;
    selSortSegment: TOracleDataSet;
    selLogMsg: TOracleDataSet;
    selIndV430: TOracleDataSet;
    scrIndV430: TOracleScript;
    OperSQL: TOracleQuery;
    selColsP430: TOracleDataSet;
    selCOlsT430: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure PreparaIndiciV430Materializzata;
    procedure CreaIndiciV430Materializzata;
  public
    procedure CostruisciV430;
    procedure LoadLstTabelle(Index:Integer;List:TStrings);
    function ShrinkTable(Table:String):TStrings;
    function DeleteStatistics(Table:String): TStrings;
    function AnalyzeTable(Table:String): TStrings;
    function TableNoParallel(Table:String): TStrings;
    function AnalyzeColumns(Table:String): TStrings;
    function AnalyzeIndexes(Table:String): TStrings;
    function MoveTablespace(Table:String): TStrings;
    function RebuildIndexes(Table:String): TStringList;
    function IndexNoParallel(Table:String): TStringList;
    function GatherTableStats(Table:String): TStrings;
    function GatherSchemaStats: TStrings;
    function DeleteSchemaStats: TStrings;
    function RicompilaOggetto(Tipo,Oggetto:String;Debug,Interpreted,Native,Reuse:Boolean): TStrings;
  end;

implementation

{$R *.dfm}

procedure TA099FUtilityDBMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Script.Session:=SessioneOracle;
end;

function TA099FUtilityDBMW.ShrinkTable(Table:String):TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;
   Script.Lines.Add('ALTER TABLE ' + Table + ' ENABLE ROW MOVEMENT;');
   Script.Lines.Add('ALTER TABLE ' + Table + ' SHRINK SPACE CASCADE;');
   Script.Lines.Add('ALTER TABLE ' + Table + ' DISABLE ROW MOVEMENT;');
   Script.Execute;
   Result:=Script.Output;
end;

procedure TA099FUtilityDBMW.LoadLstTabelle(Index:Integer;List:TStrings);
begin
  List.Clear;

  with selTabs do
  begin
    Close;
    SQL.Clear;
    case Index of
      0:SQL.Add('SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME');
      1:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM IND ORDER BY TABLE_NAME');
      2:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM USER_CONSTRAINTS WHERE CONSTRAINT_TYPE = ''P'' ORDER BY TABLE_NAME');
      3:SQL.Add('SELECT TABLE_NAME FROM TABS WHERE TABLESPACE_NAME <> ''' + Parametri.TSLavoro + ''' ORDER BY TABLE_NAME');
      4:SQL.Add('SELECT DISTINCT TABLE_NAME FROM IND WHERE TABLESPACE_NAME <> ''' + Parametri.TSIndici + ''' ORDER BY TABLE_NAME');
    end;
    Open;
    while not Eof do
    begin
      List.Add(FieldByName('TABLE_NAME').AsString);
      Next;
    end;
  end;
end;

function TA099FUtilityDBMW.DeleteStatistics(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' DELETE STATISTICS;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.TableNoParallel(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ALTER TABLE ' + Table + ' NOPARALLEL;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.AnalyzeTable(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' COMPUTE  STATISTICS FOR TABLE;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.AnalyzeColumns(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' COMPUTE  STATISTICS FOR ALL COLUMNS;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.AnalyzeIndexes(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ANALYZE TABLE ' + Table + ' COMPUTE  STATISTICS FOR ALL INDEXES;');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.MoveTablespace(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add('ALTER TABLE ' + Table + ' MOVE TABLESPACE ' + Parametri.TSLavoro + ';');

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.RebuildIndexes(Table:String): TStringList;
begin
  Result:=TStringList.Create;
  with selInd do
  begin
    SetVariable('TABLE_NAME',Table);
    Close;
    Open;
    while not Eof do
    begin
      Script.Lines.Clear;
      Script.Output.Clear;
      Script.Lines.Add('ALTER INDEX ' + FieldByName('INDEX_NAME').AsString + ' REBUILD NOPARALLEL TABLESPACE ' + Parametri.TSIndici);
      Script.Execute;
      Result.AddStrings(Script.Output);
      Next;
    end;
  end
end;

function TA099FUtilityDBMW.IndexNoParallel(Table:String): TStringList;
begin
  Result:=TStringList.Create;
  with selInd do
  begin
    SetVariable('TABLE_NAME',Table);
    Close;
    Open;
    while not Eof do
    begin
      Script.Lines.Clear;
      Script.Output.Clear;
      Script.Lines.Add('ALTER INDEX ' + FieldByName('INDEX_NAME').AsString + ' NOPARALLEL');
      Script.Execute;
      Result.AddStrings(Script.Output);
      Next;
    end;
  end
end;

function TA099FUtilityDBMW.GatherTableStats(Table:String): TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add(Format('begin dbms_stats.gather_table_stats(ownname=>''%s'',tabname=>''%s'',cascade=>True); end;',[Parametri.Username,Table]));

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.GatherSchemaStats: TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add(Format('begin dbms_stats.gather_schema_stats(ownname=>''%s'',cascade=>True); end;',[Parametri.Username]));

   Script.Execute;
   Result:=Script.Output;
end;

function TA099FUtilityDBMW.DeleteSchemaStats: TStrings;
begin
   Script.Lines.Clear;
   Script.Output.Clear;

   Script.Lines.Add(Format('begin dbms_stats.delete_schema_stats(ownname=>''%s''); end;',[Parametri.Username]));

   Script.Execute;
   Result:=Script.Output;
end;


function TA099FUtilityDBMW.RicompilaOggetto(Tipo,Oggetto:String;Debug,Interpreted,Native,Reuse:Boolean): TStrings;
begin
  Script.Lines.Clear;
  Script.Output.Clear;
  Script.Lines.Add(Format('ALTER %s %s COMPILE%s%s%s%s;',[Trim(Tipo),Trim(Oggetto),IfThen(Debug,' DEBUG',''),IfThen(Native,' PLSQL_CODE_TYPE=NATIVE',''),IfThen(Interpreted,' PLSQL_CODE_TYPE=INTERPRETED',''),IfThen(Reuse,' REUSE SETTINGS','')]));
  Script.Execute;
  Result:=Script.Output;
end;

procedure TA099FUtilityDBMW.CostruisciV430;
var i,IDQ,IDCA,IDC,IDT,IDJ:SmallInt;
    Campo,CampoPos,Alias,AliasPos:String;
    NomeColonna,Tabella,Codice,Storico:String;
    (*Q430Campi,*)CampiAlias,Campi,Tabelle,Join:array of String;
    Suf:Char;
  function NonEsisteInArray(S:String; A:array of String):Boolean;
  var i:Integer;
  begin
    Result:=True;
    for i:=0 to High(A) do
     if Pos(S,A[i] + ',') > 0 then
     begin
       Result:=False;
       Break;
     end;
  end;
{Costruisco la frase SQL per costruire la vista dei dati storici sulla base della struttura di Q430}
begin
  IDCA:=0;
  IDC:=0;
  IDT:=0;
  IDQ:=0;
  IDJ:=0;
  //SetLength(Q430Campi,1);
  SetLength(CampiAlias,1);
  SetLength(Campi,1);
  SetLength(Tabelle,1);
  SetLength(Join,1);
  //Q430Campi[0]:='';
  CampiAlias[0]:='';
  Campi[0]:='';
  Tabelle[0]:='';
  Join[0]:='';
  selColsT430.Close;
  selColsT430.Open;
  //for i:=0 to Q430.FieldCount - 1 do
  while not selColsT430.Eof do
  begin
    NomeColonna:=selColsT430.FieldByName('COLUMN_NAME').AsString;
    A000GetTabella(NomeColonna,Tabella,Codice,Storico);
    if Tabella = '' then
    begin
      selColsT430.Next;
      Continue;
    end;

    if Length(CampiAlias[IDCA]) > 800 then
    begin
      Inc(IDCA);
      SetLength(CampiAlias,IDCA + 1);
    end;
    CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430' + NomeColonna;
    if Tabella <> 'T430_STORICO' then
    begin
      if NomeColonna = 'PERSELASTICO' then
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_TIPOCART'
      else
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_' + NomeColonna;
      // per il comune di residenza e di domicilio aggiunge anche la provincia
      if NomeColonna = 'COMUNE' then
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_PROVINCIA'
      else if NomeColonna = 'COMUNE_DOM_BASE' then
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430D_PROVINCIA_DOM_BASE';
    end;
    //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
    if (Parametri.V430 = 'P430') and (UpperCase(NomeColonna) = 'DATADECORRENZA') then
      Campo:='NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
    else if (Parametri.V430 = 'P430') and (UpperCase(NOmeColonna) = 'DATAFINE') then
      Campo:='NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
    else
      Campo:='T430.' + NomeColonna;
    //if Length(Q430Campi[IDQ]) > 800 then
    if Length(Campi[IDQ]) > 800 then
    begin
      Inc(IDQ);
      //SetLength(Q430Campi,IDQ + 1);
      SetLength(Campi,IDQ + 1);
    end;
    //Q430Campi[IDQ]:=Q430Campi[IDQ] + ',' + Campo; //View//
    Campi[IDQ]:=Campi[IDQ] + ',' + Campo; //View//
    if Tabella <> 'T430_STORICO' then
    begin
      //,Tabella.Campo
      Suf:='A';
      repeat
        Alias:=Tabella + Suf;  //Alias = Table.Name + A,B,C...
        if Tabella = 'T480_COMUNI' then
          Campo:=Alias + '.CITTA,' + Alias + '.PROVINCIA'
        else
          Campo:=Alias + '.DESCRIZIONE';
        Suf:=Succ(Suf);
        CampoPos:=',' + Campo + ',';
      until NonEsisteInArray(CampoPos,Campi);
      if Length(Campi[IDC]) > 800 then
      begin
        Inc(IDC);
        SetLength(Campi,IDC + 1);
      end;
      Campi[IDC]:=Campi[IDC] + ',' + Campo; //View//
      AliasPos:=' ' + Alias + ',';
      if NonEsisteInArray(AliasPos,Tabelle) then
      begin
        if Length(Tabelle[IDT]) > 780 then
        begin
          Inc(IDT);
          SetLength(Tabelle,IDT + 1);
        end;
        //FROM .... Tabella Alias
        Tabelle[IDT]:=Tabelle[IDT] + ',' + Tabella + ' ' + Alias;
        if Length(Join[IDJ]) > 800 then
        begin
          Inc(IDJ);
          SetLength(Join,IDJ + 1);
        end;
        //WHERE .... T430.Campo = Tabella.Campo(+) - Sintassi Oracle
        if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
        Join[IDJ]:=Join[IDJ] + 'T430.' + NomeColonna + '=' + Alias + '.' + Codice + '(+)';
        //Testo se il campo di T430 è tra quelli storici
        if Storico = 'S' then
          //Nel caso di dato libero storicizzato nella query della vista deve essere considerata anche la data di decorrenza
          Join[IDJ]:=Join[IDJ] + ' AND T430.DATAFINE BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
      end;
    end;
    selColsT430.Next;
  end;
  {P430} //Anagrafico stipendiale
  if Parametri.V430 = 'P430' then
  begin
    with selColsP430 do
    begin
      Open;
      while not Eof do
      begin
        if Length(CampiAlias[IDCA]) > 800 then
        begin
          inc(IDCA);
          SetLength(CampiAlias,IDCA + 1);
        end;
        if Length(Campi[IDC]) > 800 then
        begin
          inc(IDC);
          SetLength(Campi,IDC + 1);
        end;
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430' + FieldByName('COLUMN_NAME').AsString;
        //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
        if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA' then
          Campi[IDC]:=Campi[IDC] + ',NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
        else if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA_FINE' then
          Campi[IDC]:=Campi[IDC] + ',NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
        else
          Campi[IDC]:=Campi[IDC] + ',P430.' + FieldByName('COLUMN_NAME').AsString; //View//
        if FieldByName('TABELLA').AsString <> '' then
        begin
          Alias:=Copy(FieldByName('TABELLA').AsString,1,Pos('_',FieldByName('TABELLA').AsString) - 1);
          if Alias = '' then
            Alias:=FieldByName('TABELLA').AsString;
          CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430D_' + FieldByName('COLUMN_NAME').AsString;
          Campi[IDC]:=Campi[IDC] + ',' + Alias + '.DESCRIZIONE'; //View//
          if Alias = 'P010' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430ABI_BANCA,P430CAB_BANCA,P430AGENZIA_BANCA,P430IBAN';
            Campi[IDC]:=Campi[IDC] + ',P010.ABI,P010.CAB,P010.AGENZIA,LPAD(NVL(P010.COD_NAZIONE,'' ''),2,'' '')||''-''||' +
                                     'LPAD(NVL(P430.CIN_EUROPA,''0''),2,''0'')||''-''||LPAD(NVL(P430.CIN_ITALIA,''0''),1,''0'')||''-''||' +
                                     'LPAD(NVL(P010.ABI,''0''),5,''0'')||''-''||LPAD(NVL(P010.CAB,''0''),5,''0'')||''-''||LPAD(NVL(P430.CONTO_CORRENTE,''0''),12,''0'')';
          end
          else if Alias = 'P040' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430FRAZIONE_PARTTIME,P430PERC_PARTTIME';
            Campi[IDC]:=Campi[IDC] + ',NVL(P040.PERCENTUALE/100,1),NVL(P040.PERCENTUALE,100)'; //View//
          end
          else if Alias = 'P240' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430TFR';
            Campi[IDC]:=Campi[IDC] + ',NVL(P240.TFR,''N'')'; //View//
          end;
          if Length(Tabelle[IDT]) > 800 then
          begin
            inc(IDT);
            SetLength(Tabelle,IDT + 1);
          end;
          Tabelle[IDT]:=Tabelle[IDT] + ',' + FieldByName('TABELLA').AsString + ' ' + StringReplace(Alias,FieldByName('TABELLA').AsString,'',[]);
          if Length(Join[IDJ]) > 800 then
          begin
            Inc(IDJ);
            SetLength(Join,IDJ + 1);
          end;
          if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
          Join[IDJ]:=Join[IDJ] + 'P430.' + FieldByName('COLUMN_NAME').AsString + '=' + Alias + '.' + FieldByName('COLONNA_TABELLA').AsString + '(+)';
          if Alias = 'P240' then
            Join[IDJ]:=Join[IDJ] + ' AND P430.COD_CONTRATTO = P240.COD_CONTRATTO(+)';
          if FieldByName('DECORRENZA').AsString = 'S' then
            Join[IDJ]:=Join[IDJ] + ' AND P430.DECORRENZA BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
        end;
        Next;
      end;
      Close;
    end;
  {P430}end;
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('drop table V430_STORICO');
    try
      Execute;
    except
    end;
    //CREATE VIEW V430_STORICO (Col1,Col2,Col3,...)
    SQL.Clear;

    //AS SELECT T430.Col1, T430.Col2, T430.Col3, ...
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO_VIEW (')
    else
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO (');

    SQL.Add(Copy(CampiAlias[0],2,Length(CampiAlias[0])));
    for i:=1 to High(CampiAlias) do
      if CampiAlias[i] <> '' then
        SQL.Add(CampiAlias[i]);
    SQL.Add(')');

    SQL.Add('AS SELECT');
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('/*+ ordered */');
    (*
    SQL.Add(Copy(Q430Campi[0],2,Length(Q430Campi[0])));
    for i:=1 to High(Q430Campi) do
      if Q430Campi[i] <> '' then
        SQL.Add(Q430Campi[i]);
    *)
    // Tab1.Col1, Tab2.Col2, Tab3.Col3, ...
    SQL.Add(Copy(Campi[0],2,Length(Campi[0])));
    for i:=1 to High(Campi) do
      if Campi[i] <> '' then
        SQL.Add(Campi[i]);
    //FROM T430_STORICO T430 LEFT JOIN Tab1 Alias1 LEFT JOIN Tab2 Alias2 ...
    SQL.Add('FROM T430_Storico T430');
    {P430}if Parametri.V430 = 'P430' then SQL.Add(',P430_ANAGRAFICO P430');
    SQL.Add(Tabelle[0]);
    for i:=1 to High(Tabelle) do
      if Tabelle[i] <> '' then
        SQL.Add(Tabelle[i]);
    //WHERE
    SQL.Add('WHERE');
    SQL.Add(Join[0]);
    for i:=1 to High(Join) do
    begin
      if Join[i] <> '' then
        SQL.Add(Join[i]);
    end;
    {P430}if Parametri.V430 = 'P430' then
    begin
      SQL.Add('AND P430.PROGRESSIVO(+) = T430.PROGRESSIVO');
      SQL.Add('AND P430.DECORRENZA(+) <= T430.DATAFINE AND P430.DECORRENZA_FINE(+) >= T430.DATADECORRENZA');
    end;{P430}
    try
      Execute;
      if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      begin
        SQL.Clear;
        SQL.Add('drop view V430_STORICO');
        try
          Execute;
        except
        end;
        PreparaIndiciV430Materializzata;
        SQL.Clear;
        SQL.Add('drop table V430_STORICO');
        try
          Execute;
        except
        end;
        SQL.Clear;
        SQL.Add('create table V430_STORICO tablespace ' + IfThen(Parametri.TSAusiliario = '',Parametri.TSLavoro, Parametri.TSAusiliario) + ' as select * from V430_STORICO_VIEW');
        Execute;
        CreaIndiciV430Materializzata;
      end;
      SQL.Clear;
      SQL.Add('grant select on V430_STORICO to public');
      Execute;
    except
    end;
  end;
  (*
  A002FAnagrafeMW.selI500.Open;
  IDCA:=0;
  IDC:=0;
  IDT:=0;
  IDQ:=0;
  IDJ:=0;
  for i:=0 to High(Q430Campi) do
  begin
    Q430Campi[i]:='';
    CampiAlias[i]:='';
    Campi[i]:='';
    Tabelle[i]:='';
    Join[i]:='';
  end;
  for i:=0 to Q430.FieldCount - 1 do
    with Q430.Fields[i] do
    begin
      if (Lookup) and (Tag = 0) then Continue;
      if Length(CampiAlias[IDCA]) > 800 then Inc(IDCA);
      CampiAlias[IDCA]:=CampiAlias[IDCA] + ',T430' + FieldName;
      if (not Lookup) and (not Calculated) then
      begin
        //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
        if (Parametri.V430 = 'P430') and (UpperCase(FieldName) = 'DATADECORRENZA') then
          Campo:='NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
        else if (Parametri.V430 = 'P430') and (UpperCase(FieldName) = 'DATAFINE') then
          Campo:='NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
        else
          Campo:='T430.' + FieldName;
        if Length(Q430Campi[IDQ]) > 800 then Inc(IDQ);
        Q430Campi[IDQ]:=Q430Campi[IDQ] + ',' + Campo; //View//
        //Q430Campi[IDQ]:=Q430Campi[IDQ] + ',' + Campo + ' T430' + FieldName; //MatView//
      end;
      if Lookup then
      begin
        //,Tabella.Campo
        Suf:='A';
        repeat
          Alias:=LookupDataSet.Name + Suf;  //Alias = Table.Name + A,B,C...
          Campo:=Alias + '.' + LookupResultField;
          Suf:=Succ(Suf);
          CampoPos:=',' + Campo + ',';
        until NonEsisteInArray(CampoPos,Campi);
              {(Pos(CampoPos,Campi[0] + ',') = 0) and (Pos(CampoPos,Campi[1] + ',') = 0) and (Pos(CampoPos,Campi[2] + ',') = 0) and
              (Pos(CampoPos,Campi[3] + ',') = 0) and (Pos(CampoPos,Campi[4] + ',') = 0);}
        if Length(Campi[IDC]) > 800 then Inc(IDC);
        Campi[IDC]:=Campi[IDC] + ',' + Campo; //View//
        //Campi[IDC]:=Campi[IDC] + ',' + Campo + ' T430' + FieldName; //MatView//
        AliasPos:=' ' + Alias + ',';
        if NonEsisteInArray(AliasPos,Tabelle) then
           {(Pos(AliasPos,Tabelle[0] + ',') = 0) and (Pos(AliasPos,Tabelle[1] + ',') = 0) and
           (Pos(AliasPos,Tabelle[2] + ',') = 0) and (Pos(AliasPos,Tabelle[3] + ',') = 0) and (Pos(AliasPos,Tabelle[4] + ',') = 0) then}
        begin
          if Length(Tabelle[IDT]) > 780 then Inc(IDT);
          //FROM .... Tabella Alias
          Tabelle[IDT]:=Tabelle[IDT] + ',' + NomiTabelle[Tag] + ' ' + Alias;
          if Length(Join[IDJ]) > 800 then Inc(IDJ);
          //WHERE .... T430.Campo = Tabella.Campo(+) - Sintassi Oracle
          if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
          //Testo se il campo di T430 è tra quelli storici
          if A002FAnagrafeMW.selI500.SearchRecord('NOMECAMPO;STORICO',VarArrayOf([KeyFields,'S']),[srFromBeginning]) then
          begin
            //Nel caso di dato libero storicizzato nella query della vista deve essere considerata anche la data di decorrenza
            Join[IDJ]:=Join[IDJ] + 'T430.' + KeyFields + '=' + Alias + '.' + LookupKeyFields + '(+)';
            Join[IDJ]:=Join[IDJ] + ' AND T430.DATAFINE BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
            //Join[IDJ]:=Join[IDJ] + ' AND ' + Alias + '.DECORRENZA = (SELECT MAX(DECORRENZA) FROM I501' + UpperCase(KeyFields);
            //Join[IDJ]:=Join[IDJ] + ' WHERE ' + LookupKeyFields + ' = ' + Alias + '.' + LookupKeyFields + ' AND DECORRENZA <= T430.DATAFINE)';
          end
          else if (UpperCase(KeyFields) = 'PORARIO') or (UpperCase(KeyFields) = 'QUALIFICAMINIST') then
          begin
            //Nel caso di profilo orario nella query della vista deve essere considerata anche la data di decorrenza
            Join[IDJ]:=Join[IDJ] + 'T430.' + KeyFields + '=' + Alias + '.' + LookupKeyFields + '(+)';
            Join[IDJ]:=Join[IDJ] + ' AND T430.DATAFINE BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
          end
          else
            Join[IDJ]:=Join[IDJ] + 'T430.' + KeyFields + '=' + Alias + '.' + LookupKeyFields + '(+)';
        end;
      end;
    end;
  {P430} //Anagrafico stipendiale
  if Parametri.V430 = 'P430' then
  begin
    with selColsP430 do
    begin
      Open;
      while not Eof do
      begin
        if Length(CampiAlias[IDCA]) > 800 then inc(IDCA);
        if Length(Campi[IDC]) > 800 then inc(IDC);
        CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430' + FieldByName('COLUMN_NAME').AsString;
        //Alberto 21/12/2005: uniformazione delle decorrenze tra T430 e P430
        if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA' then
          Campi[IDC]:=Campi[IDC] + ',NVL(GREATEST(T430.DATADECORRENZA,P430.DECORRENZA),T430.DATADECORRENZA)'
        else if UpperCase(FieldByName('COLUMN_NAME').AsString) = 'DECORRENZA_FINE' then
          Campi[IDC]:=Campi[IDC] + ',NVL(LEAST(T430.DATAFINE,P430.DECORRENZA_FINE),T430.DATAFINE)'
        else
          Campi[IDC]:=Campi[IDC] + ',P430.' + FieldByName('COLUMN_NAME').AsString; //View//
          //Campi[IDC]:=Campi[IDC] + ' P430' + FieldByName('COLUMN_NAME').AsString; //MatView//
        if FieldByName('TABELLA').AsString <> '' then
        begin
          Alias:=Copy(FieldByName('TABELLA').AsString,1,Pos('_',FieldByName('TABELLA').AsString) - 1);
          if Alias = '' then
            Alias:=FieldByName('TABELLA').AsString;
          CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430D_' + FieldByName('COLUMN_NAME').AsString;
          Campi[IDC]:=Campi[IDC] + ',' + Alias + '.DESCRIZIONE'; //View//
          //Campi[IDC]:=Campi[IDC] + ' P430D_' + FieldByName('COLUMN_NAME').AsString; //MatView//
          if Alias = 'P010' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430ABI_BANCA,P430CAB_BANCA,P430AGENZIA_BANCA,P430IBAN';
            //{ //View//
            Campi[IDC]:=Campi[IDC] + ',P010.ABI,P010.CAB,P010.AGENZIA,LPAD(NVL(P010.COD_NAZIONE,'' ''),2,'' '')||''-''||' +
                                     'LPAD(NVL(P430.CIN_EUROPA,''0''),2,''0'')||''-''||LPAD(NVL(P430.CIN_ITALIA,''0''),1,''0'')||''-''||' +
                                     'LPAD(NVL(P010.ABI,''0''),5,''0'')||''-''||LPAD(NVL(P010.CAB,''0''),5,''0'')||''-''||LPAD(NVL(P430.CONTO_CORRENTE,''0''),12,''0'')';
            // }
            { //MatView//
            Campi[IDC]:=Campi[IDC] + ',P010.ABI P430ABI_BANCA,P010.CAB P430CAB_BANCA,P010.AGENZIA P430AGENZIA_BANCA,LPAD(NVL(P010.COD_NAZIONE,'' ''),2,'' '')||''-''||' +
                                     'LPAD(NVL(P430.CIN_EUROPA,''0''),2,''0'')||''-''||LPAD(NVL(P430.CIN_ITALIA,''0''),1,''0'')||''-''||' +
                                     'LPAD(NVL(P010.ABI,''0''),5,''0'')||''-''||LPAD(NVL(P010.CAB,''0''),5,''0'')||''-''||LPAD(NVL(P430.CONTO_CORRENTE,''0''),12,''0'') P430IBAN';
            }
          end
          else if Alias = 'P040' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430FRAZIONE_PARTTIME,P430PERC_PARTTIME';
            Campi[IDC]:=Campi[IDC] + ',NVL(P040.PERCENTUALE/100,1),NVL(P040.PERCENTUALE,100)'; //View//
            //Campi[IDC]:=Campi[IDC] + ',NVL(P040.PERCENTUALE/100,1) P430FRAZIONE_PARTTIME,NVL(P040.PERCENTUALE,100) P430PERC_PARTTIME'; //MatView//
          end
          else if Alias = 'P240' then
          begin
            CampiAlias[IDCA]:=CampiAlias[IDCA] + ',P430TFR';
            Campi[IDC]:=Campi[IDC] + ',NVL(P240.TFR,''N'')'; //View//
            //Campi[IDC]:=Campi[IDC] + ',NVL(P240.TFR,''N'') P430TFR'; //MatView//
          end;
          if Length(Tabelle[IDT]) > 800 then inc(IDT);
          Tabelle[IDT]:=Tabelle[IDT] + ',' + FieldByName('TABELLA').AsString + ' ' + StringReplace(Alias,FieldByName('TABELLA').AsString,'',[]);
          if Length(Join[IDJ]) > 800 then Inc(IDJ);
          if Length(Join[0]) > 0 then Join[IDJ]:=Join[IDJ] + ' AND ';
          Join[IDJ]:=Join[IDJ] + 'P430.' + FieldByName('COLUMN_NAME').AsString + '=' + Alias + '.' + FieldByName('COLONNA_TABELLA').AsString + '(+)';
          if Alias = 'P240' then
            Join[IDJ]:=Join[IDJ] + ' AND P430.COD_CONTRATTO = P240.COD_CONTRATTO(+)';
          if FieldByName('DECORRENZA').AsString = 'S' then
          begin
//            Join[IDJ]:=Join[IDJ] + ' AND P430.PROGRESSIVO = ' + Alias + '.PROGRESSIVO(+)';
//            Join[IDJ]:=Join[IDJ] + ' AND P430.DECORRENZA = ' + Alias + '.DECORRENZA(+)';
            Join[IDJ]:=Join[IDJ] + ' AND P430.DECORRENZA BETWEEN ' + Alias + '.DECORRENZA(+) AND ' + Alias + '.DECORRENZA_FINE(+)';
          end;
        end;
        Next;
      end;
      Close;
    end;
  {P430}end;
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('drop table V430_STORICO');
    try
      Execute;
    except
    end;
    //CREATE VIEW V430_STORICO (Col1,Col2,Col3,...)
    SQL.Clear;

    { //View//
    SQL.Add('CREATE OR REPLACE VIEW V430_STORICO (');
    SQL.Add(Copy(CampiAlias[0],2,Length(CampiAlias[0])));
    for i:=1 to High(Q430Campi) do
      if CampiAlias[i] <> '' then
        SQL.Add(CampiAlias[i]);
    SQL.Add(')');
    }

    //AS SELECT T430.Col1, T430.Col2, T430.Col3, ...
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO_VIEW (')
    else
      SQL.Add('CREATE OR REPLACE VIEW V430_STORICO (');

    SQL.Add(Copy(CampiAlias[0],2,Length(CampiAlias[0])));
    for i:=1 to High(Q430Campi) do
      if CampiAlias[i] <> '' then
        SQL.Add(CampiAlias[i]);
    SQL.Add(')');

    SQL.Add('AS SELECT');
    if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      SQL.Add('/*+ ordered */');
    SQL.Add(Copy(Q430Campi[0],2,Length(Q430Campi[0])));
    for i:=1 to High(Q430Campi) do
      if Q430Campi[i] <> '' then
        SQL.Add(Q430Campi[i]);
    // Tab1.Col1, Tab2.Col2, Tab3.Col3, ...
    SQL.Add(Campi[0]);
    for i:=1 to High(Q430Campi) do
      if Campi[i] <> '' then
        SQL.Add(Campi[i]);
    //FROM T430_STORICO T430 LEFT JOIN Tab1 Alias1 LEFT JOIN Tab2 Alias2 ...
    SQL.Add('FROM T430_Storico T430');
    {P430}if Parametri.V430 = 'P430' then SQL.Add(',P430_ANAGRAFICO P430');
    SQL.Add(Tabelle[0]);
    for i:=1 to High(Q430Campi) do
      if Tabelle[i] <> '' then
        SQL.Add(Tabelle[i]);
    //WHERE
    SQL.Add('WHERE');
    SQL.Add(Join[0]);
    for i:=1 to High(Q430Campi) do
    begin
      if Join[i] <> '' then
        SQL.Add(Join[i]);
    end;
    {P430}if Parametri.V430 = 'P430' then
    begin
      SQL.Add('AND P430.PROGRESSIVO(+) = T430.PROGRESSIVO');
      SQL.Add('AND P430.DECORRENZA(+) <= T430.DATAFINE AND P430.DECORRENZA_FINE(+) >= T430.DATADECORRENZA');
    end;{P430}
    try
      Execute;
      if Parametri.CampiRiferimento.C26_V430Materializzata = 'S' then
      begin
        SQL.Clear;
        SQL.Add('drop view V430_STORICO');
        try
          Execute;
        except
        end;
        PreparaIndiciV430Materializzata;
        SQL.Clear;
        SQL.Add('drop table V430_STORICO');
        try
          Execute;
        except
        end;
        SQL.Clear;
        SQL.Add('create table V430_STORICO tablespace ' + IfThen(Parametri.TSAusiliario = '',Parametri.TSLavoro, Parametri.TSAusiliario) + ' as select * from V430_STORICO_VIEW');
        Execute;
        CreaIndiciV430Materializzata;
      end;
      //SessioneOracle.Commit;
    except
    end;
  end;
  *)
end;

procedure TA099FUtilityDBMW.PreparaIndiciV430Materializzata;
var
  OldIndx, CampiIndx:String;
  Unico:Boolean;
  procedure CreaIndice(Nome:String; Unico:Boolean; LCampi:String);
  begin
    with scrIndV430 do
    begin
      Lines.Add('DROP INDEX ' + Nome + ';');
      Lines.Add('CREATE ');
      if Unico then
        Lines.Add('UNIQUE ');
      Lines.Add('INDEX ' + OldIndx + ' ON V430_STORICO (' + CampiIndx + ') NOPARALLEL TABLESPACE ' + Parametri.TSIndici + ';');
    end;
  end;
begin
  OldIndx:='';
  CampiIndx:='';
  Unico:=False;
  scrIndV430.Lines.Clear;
  with selIndV430 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      if OldIndx <> FieldByName('INDEX_NAME').AsString then
      begin
        if OldIndx <> '' then
          CreaIndice(OldIndx,Unico,CampiIndx);
        OldIndx:=FieldByName('INDEX_NAME').AsString;
        Unico:=FieldByName('UNIQUENESS').AsString = 'UNIQUE';
        CampiIndx:='';
      end;
      if CampiIndx <> '' then
        CampiIndx:=CampiIndx + ',';
      CampiIndx:=CampiIndx + FieldByName('COLUMN_NAME').AsString;
      Next;
    end;
    Close;
  end;
  if OldIndx <> '' then
    CreaIndice(OldIndx,Unico,CampiIndx);
end;

procedure TA099FUtilityDBMW.CreaIndiciV430Materializzata;
begin
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('create index V430_PROGRESSIVO on V430_STORICO (T430PROGRESSIVO) tablespace ' + Parametri.TSIndici);
    Execute;
  end;
  if scrIndV430.Lines.Count > 0  then
    scrIndV430.Execute;
end;

end.
