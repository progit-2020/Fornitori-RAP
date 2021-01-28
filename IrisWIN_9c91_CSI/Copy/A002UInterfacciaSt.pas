unit A002UInterfacciaSt;

interface
uses DB,Forms,SysUtils,Classes,Controls, A000UCostanti, A000USessione, A000UInterfaccia, Oracle, OracleData,
     C180FunzioniGenerali,C700USelezioneAnagrafe,C700USelezioneAnagrafeDtM,
     C001UFiltroTabelle,C001UFiltroTabelleDtm,C001UScegliCampi,C001StampaLib,R001UGestTab, Variants;

procedure SettaDBStampa(Sessione:TOracleSession);
procedure AssegnaQuery(DSource:TDataSource);
procedure GestisciStampaMista(DSource:TDataSource; Query:TOracleDataSet; Completa:Boolean; CampiQ2:TStringList);
procedure ParametriStampa(DataSource:TDataSource);
function TogliParametro(Testo:String;Value:TDateTime):String;
procedure CreaCampiPersistentiQuery2;
procedure SalvaCampiQuery2(Lista:TStringList);
procedure SalvaCampiQVista;
procedure AssegnaDisplayLabel;

//function CreaSqlInterBase(TestoQVista,TestoQuery2:String):String;
//function GetInnerJoinIB(Tabella1,Campo1,Tabella2,Campo2:String):String;
function CreaSqlOracle(TestoQVista,TestoQuery2:String):String;
function GetSelect(Testo:String):String;
function GetFrom(Testo:String):String;
function GetWhere(Testo:String):String;
function GetOrderBy(Testo:String):String;
function GetInnerJoinOracle(Tabella1,Campo1,Tabella2,Campo2:String):String;
function EliminaWhereSql(Testo,Condizione:String):String;
procedure DividiWhereSql(Testo:String; var Where,Order:String);

type RecApp = record
        FieldName:string;
        DisplayLabel:String;
     end;

var TipoDB:TDataBaseDrv;
    SelezioneSQL,FromSQL,WhereSQL,OrderSQL,TitoloR001:String;
    VettQuery2:array[1..500] of RecApp;
    VettQVista:array[1..500] of RecApp;
    NumCampiQVista:Integer;

implementation

procedure SettaDBStampa(Sessione:TOracleSession);
begin
  with C001FFiltroTabelleDTM do
  begin
    Query1.Session:=Sessione;
    Query2.Session:=Sessione;
    QDistinct.Session:=Sessione;
    Q900.Session:=Sessione;
    selT901.Session:=Sessione;
  end;
end;

// Sostituisco il parametro con il valore effettivo.
function TogliParametro(Testo:String; Value:TDateTime):String;
var Pos1:Integer;
    ValueStr,App: String;
begin
  ValueStr:=FormatDateTime('dd/mm/yyyy',Value);
  ValueStr:='''' + ValueStr + '''';
  with C001FFiltroTabelleDtM do
  begin
    App:=Testo;
    pos1:=pos(':DATALAVORO',uppercase(App));
    while(pos1 > 0) do
    begin
      Delete(App,pos1,11);
      Insert(ValueStr,App,pos1);
      pos1:=pos(':DATALAVORO',uppercase(App));
    end;
    Result:=App;
  end;
end;

procedure SalvaCampiQuery2(Lista:TStringList);
var i:Integer;
begin
  with C001FFiltroTabelleDtM do
  begin
    CreaCampiPersistentiQuery2;
    for i:=0 to Query2.FieldCount - 1 do
    begin
      VettQuery2[i+1].FieldName:=Query2.Fields[i].FieldName;
      if Lista.Count > i then
        VettQuery2[i+1].DisplayLabel:=Lista[i]
      else
        VettQuery2[i+1].DisplayLabel:='T1.' + Query2.Fields[i].FieldName;
    end;
  end;
end;

procedure SalvaCampiQVista;
var i:Integer;
begin
  with C700FSelezioneAnagrafeDtM do
  begin
    NumCampiQVista:=selAnagrafe.FieldDefs.Count;
    for I:=0 to selAnagrafe.FieldDefs.Count - 1 do
    begin
      VettQVista[I+1].FieldName:=selAnagrafe.FieldDefs[I].Name;
      VettQVista[I+1].DisplayLabel:=C700FSelezioneAnagrafe.PrefissoTabella(selAnagrafe.FieldDefs[I].Name);
    end;
  end;
end;

procedure ParametriStampa(DataSource:TDataSource);
{Assegnazione delle DisplayLabel,DisplayWidth e Visible}
var i:Word;
begin
  with C001FFiltroTabelleDTM do
    for i:=0 to DataSource.DataSet.FieldCount - 1 do
    begin
      Query2.Fields[i].DisplayLabel:=Query2.Fields[i].FieldName;
      Query2.Fields[i].DisplayWidth:=DataSource.DataSet.Fields[i].DisplayWidth;
      if (Query2.Fields[i].DataType=ftDateTime) then
        if (Query2.Fields[i] as TDateTimeField).DisplayFormat='' then
          Query2.Fields[i].DisplayWidth:=15;
      Query1.Fields[i].DisplayLabel:=DataSource.DataSet.Fields[i].DisplayLabel;
      Query1.Fields[i].Visible:=DataSource.DataSet.Fields[i].Visible;
    end;
end;

procedure CreaCampiPersistentiQuery2;
var I:Integer;
begin
  with C001FFiltroTabelleDtM do
  begin
    for I:=Query2.FieldCount - 1 downto 0 do
      Query2.Fields[I].Free;
    Query2.CloseAll;
    Query2.FieldDefs.Update;
    for I:=0 to Query2.FieldDefs.Count - 1 do
      Query2.FieldDefs[I].CreateField(Query2);
  end;
end;

procedure AssegnaQuery(DSource:TDataSource);
var AliasR001,TipoAlias:String;
    i:SmallInt;
begin
  try
  StampaAnagrafico:=True;
  C001FFiltroTabelleDTM.Query1.CloseAll;
  C001FFiltroTabelleDTM.Query2.CloseAll;
  C001FFiltroTabelleDTM.QDistinct.Close;
  //if (DSource.DataSet is TOracleDataSet) then
  AliasR001:=''; //Componenti DOA slegati dal BDE
  TipoAlias:='ORACLE';
  TipoDB:=dbOracle;
  //Carico la From_SQL da C700FSelezioneAnagrafe.ListSQL, contenente anche le inibizioni
  //fisse dell'operatore: leggo solo dalla 2° linea in poi
  FromSQL:='FROM ';
  with C700FSelezioneAnagrafe do
    for i:=1 to ListSQL.Count - 1 do
      FromSQL:=FromSQL + ListSQL[i] + ' ';
  if not C700FSelezioneAnagrafe.chkCessati.Checked then
    FromSQL:=FromSQL + ' AND EXISTS (SELECT ''X'' FROM T430_STORICO WHERE PROGRESSIVO = T430PROGRESSIVO AND :DataLavoro BETWEEN T430INIZIO AND NVL(T430FINE,:DataLavoro))';
  SettaDbStampa(SessioneOracle);
  //Carica la SELECT SQL su Query1 e Query2
  FromSQL:=TogliParametro(FromSql,C001FFiltroTabelle.DataLavoro);
  C001FFiltroTabelleDTM.Query2.SQL.Text:=TogliParametro(C700SelAnagrafe.SQL.Text,C001FFiltroTabelle.DataLavoro);
  WhereSql:=EliminaRitornoACapo(Trim(C700FSelezioneAnagrafe.WhereSql));
  DividiWhereSql(WhereSql,WhereSql,OrderSql);
  C001FFiltroTabelleDTM.Query2.DeleteVariables;
  CreaCampiPersistentiQuery2;
  C001FFiltroTabelleDTM.Query1.Sql.Assign(C001FFiltroTabelleDTM.Query2.SQL);
  //if not(C001FFiltroTabelle.Visible) then
  //begin
    Screen.Cursor:=crHourGlass;
    C001FFiltroTabelleDTM.Query1.Open;
    C001FFiltroTabelle.StatusBar.Panels[0].Text:=Format('%d Records',[C001FFiltroTabelleDTM.Query1.RecordCount]);
    Screen.Cursor:=crDefault;
  //end;
  ParametriStampa(C001FFiltroTabelleDTM.DataSource2);
  C001FFiltroTabelle.FROM_SQL:=FromSql;
  C001FFiltroTabelle.Where_Sql:=WhereSql;
  C001FFiltroTabelle.Order_Sql:=OrderSql;
  C001FFiltroTabelle.IntestazioneQR:=IntestazioneStampa;
  C001FFiltroTabelle.Caption:=C001FFiltroTabelle.Caption + TitoloR001;
  if not(C001FFiltroTabelle.Visible) then
    begin
      C001FFiltroTabelle.ShowModal;
      C001FFiltroTabelleDTM.Query1.CloseAll;
      C001FFiltroTabelleDTM.Query2.CloseAll;
      StampaAnagrafico:=False;
    end;
  finally
  end;
end;

procedure DividiWhereSql(Testo:String; var Where,Order:String);
var
  PosOrderBy: Integer;
begin
  Where:=Testo;
  PosOrderBy:=Pos('ORDER BY',UpperCase(Testo));
  if PosOrderBy > 0 then
    begin
      Order:=Copy(Testo,PosOrderBy,Length(Testo));
      Delete(Testo,PosOrderBy,Length(Testo) - PosOrderBy + 1);
      Where:=Trim(Testo);
    end
  else
    Order:='';
end;

// Funzione che restituisce il testo contenuto tra la clausola Select e la calusola From
function GetSelect(Testo:String):String;
var PosSelect,PosFrom:Word;
begin
  Result:='';
  PosSelect:=pos('SELECT',Uppercase(Testo));
  PosFrom:=pos('FROM ',Uppercase(Testo));
  if (PosSelect > 0)and(PosFrom > PosSelect) then
    Result:=copy(Testo,PosSelect+7,PosFrom-PosSelect-7);
end;

// Funzione che restituisce il testo contenuto tra la clausola From
// e la calusola Where (se presente, altrimenti fino alla fine del testo)
function GetFrom(Testo:String):String;
var PosFrom,PosWhere:Word;
begin
  Result:='';
  PosFrom:=pos('FROM ',Uppercase(Testo));
  PosWhere:=pos('WHERE',Uppercase(Testo));
  if PosFrom > 0 then
    begin
      if PosWhere > 0 then
        Result:=copy(Testo,PosFrom+5,PosWhere-PosFrom-5)
      else
        Result:=copy(Testo,PosFrom+5,Length(Testo)-PosFrom-5);
    end
end;

// Funzione che restituisce il testo contenuto tra la clausola Where
// e la calusola OrderBy (se presente,altrimenti fino alla fine del testo)
function GetWhere(Testo:String):String;
var PosWhere,PosOrderBy:Word;
begin
  Result:='';
  PosWhere:=pos('WHERE',Uppercase(Testo));
  PosOrderBy:=pos('ORDER BY',Uppercase(Testo));
  if PosWhere > 0 then
    begin
      if PosOrderBy > 0 then
        Result:=copy(Testo,PosWhere+6,PosOrderBy-PosWhere-6)
      else
        Result:=copy(Testo,PosWhere+6,Length(Testo)-PosWhere-6);
    end
end;

// Funzione che restituisce il testo contenuto dopo la clausola Order by
function GetOrderBy(Testo:String):String;
var PosOrderBy:Word;
begin
  Result:='';
  PosOrderBy:=pos('ORDER BY',Uppercase(Testo));
  if PosOrderBy > 0 then
    Result:=copy (Testo,PosOrderBy+8,Length(Testo)-PosOrderBy-8)
end;

// Crea la stringa per la Left Join in Oracle
function GetInnerJoinOracle(Tabella1,Campo1,Tabella2,Campo2:String):String;
begin
  Result:=Tabella1+'.'+Campo1+'='+Tabella2+'.'+Campo2;
end;

function CreaSqlOracle(TestoQVista,TestoQuery2:String):String;
var S:String;
begin
  TestoQVista:=EliminaRitornoACapo(TestoQVista);
  TestoQuery2:=EliminaRitornoACapo(TestoQuery2);
  // Parte SELECT
  Result:='SELECT ' + GetSelect(TestoQVista) + ',' + GetSelect(TestoQuery2);
  // Parte FROM
  Result:=Result + ' FROM ' + GetFrom(TestoQVista)+','+GetFrom(TestoQuery2);
  FromSql:='FROM ' + GetFrom(TestoQVista)+','+GetFrom(TestoQuery2);
  // Parte WHERE
  Result:=Result + ' WHERE ' + GetWhere(TestoQVista);
  FromSql:=FromSql + ' WHERE ' + GetWhere(TestoQVista);
  S:=GetWhere(TestoQuery2);
  if Trim(S) <> '' then
    begin
    Result:=Result + ' AND ' + S;
    FromSql:=FromSql + ' AND ' + S;
    end;
  // LEFT JOIN sul Progressivo
  Result:=Result + ' AND ' + GetInnerJoinOracle('T030','Progressivo','T1','Progressivo');
  FromSql:=FromSql + ' AND ' + GetInnerJoinOracle('T030','Progressivo','T1','Progressivo');
  //Result:=Result + ' AND T030.PROGRESSIVO = 0';
  //FromSql:=FromSql + ' AND T030.PROGRESSIVO = 0';
end;

procedure AssegnaDisplayLabel;
var I:Integer;
begin
  with C001FFiltroTabelleDtM do
  begin
    for I:=0 to Query2.FieldCount - 1 do
    if I <= NumCampiQVista - 1 then
      Query2.Fields[I].DisplayLabel:=VettQVista[I+1].DisplayLabel
    else
      Query2.Fields[I].DisplayLabel:=VettQuery2[I-NumCampiQVista+1].DisplayLabel
  end;
end;

// Elimina l' ultima parte della clausola where
function EliminaWhereSql(Testo,Condizione:String):String;
var Pos1:Integer;
begin
  Pos1:=pos(Condizione,Testo);
  if Pos1 <> 0 then
    Delete(Testo,Pos1,Length(Condizione));
  Result:=Testo;
end;

procedure GestisciStampaMista(DSource:TDataSource; Query:TOracleDataSet; Completa:Boolean; CampiQ2:TStringList);
var AliasR001,TipoAlias,App:String;
begin
  StampaAnagraficoMisto:=True;
  C001FFiltroTabelleDTM.Query1.CloseAll;
  C001FFiltroTabelleDTM.Query2.CloseAll;
  C001FFiltroTabelleDTM.QDistinct.Close;
  if (DSource.DataSet is TOracleDataSet) then
    AliasR001:=''; //Componenti DOA slegati dal BDE
  if AliasR001 = '' then
    TipoAlias:='ORACLE';
  if TipoAlias = 'ORACLE' then
    TipoDB:=dbOracle
  else if TipoAlias = 'INTERBASE' then
    TipoDB:=dbInterBase
  else if TipoAlias = 'STANDARD' then
    TipoDB:=dbStandard;
  SettaDbStampa(SessioneOracle);
  if Completa then
  begin
    SalvaCampiQuery2(CampiQ2);   //  Salvo le display Label solo se devo
    SalvaCampiQVista;            //  ricostruire la Query completa
    if TipoDB = dbOracle then
      App:=CreaSqlOracle(Query.SQL.Text,C001FFiltroTabelleDtM.Query2.Sql.Text)
    else
      App:='';
  end
  else
  begin
    if Pos('AND T030.PROGRESSIVO = 0',FromSQL) > 0 then
      Delete(FromSQL,Pos('AND T030.PROGRESSIVO = 0',FromSQL),Length('AND T030.PROGRESSIVO = 0'));
    App:=C001FFiltroTabelleDtM.Query2.Sql.Text;
    if Pos('AND T030.PROGRESSIVO = 0',App) > 0 then
      Delete(App,Pos('AND T030.PROGRESSIVO = 0',App),Length('AND T030.PROGRESSIVO = 0'));
    {
    if (WhereSql <> '') and (OrderSql <> '') then
      App:=EliminaWhereSql(App,' AND ' + WhereSql + ' ' + OrderSql)
    else if (WhereSql = '') and (OrderSql <> '') then
      App:=EliminaWhereSql(App,OrderSql)
    }
    // elimina la clausola "where" della c700
    if WhereSql <> '' then
    begin
      App:=EliminaWhereSql(App,' AND ' + WhereSql);
      FromSQL:=EliminaWhereSql(FromSQL,' AND ' + WhereSql);
    end;
    // elimina la clausola "order by"
    if OrderSql <> '' then
      App:=EliminaWhereSql(App,OrderSql);
  end;
  App:=TogliParametro(App,C001FFiltroTabelle.DataLavoro);
  WhereSQL:=EliminaRitornoACapo(Trim(C700FSelezioneAnagrafe.WhereSql));
  DividiWhereSql(WhereSql,WhereSql,OrderSql);
  if C700FSelezioneanagrafe.SingoloDipendente1.Checked then
    WhereSQL:=WhereSQL + ' AND T030.PROGRESSIVO = ' + IntToStr(C700Progressivo);
  // se è stata ricostruita la query completa, la clausola where è già presente e non deve essere aggiunta
  if not Completa then
  begin
    if WhereSql <> '' then
      App:=App + ' AND ' + WhereSql;
  end;
  if OrderSql <> '' then
    App:=App + ' ' + OrderSql;
  C001FFiltroTabelleDtM.Query2.Sql.Text:=App;
  CreaCampiPersistentiQuery2;
  C001FFiltroTabelleDTM.Query1.Sql.Assign(C001FFiltroTabelleDTM.Query2.SQL);
  if not(C001FFiltroTabelle.Visible) then     // daniloc
  begin
    Screen.Cursor:=crHourGlass;
    C001FFiltroTabelleDTM.Query1.Open;
    Screen.Cursor:=crDefault;
    C001FFiltroTabelle.StatusBar.Panels[0].Text:=Format('%d Records',[C001FFiltroTabelleDTM.Query1.RecordCount]);
  end;
  AssegnaDisplayLabel;
  C001FFiltroTabelle.FROM_SQL:=TogliParametro(FromSql,C001FFiltroTabelle.DataLavoro);
  C001FFiltroTabelle.Where_Sql:=WhereSql;
  C001FFiltroTabelle.Order_Sql:=OrderSql;
  C001FFiltroTabelle.IntestazioneQR:=IntestazioneStampa;
  C001FFiltroTabelle.Caption:=C001FFiltroTabelle.Caption + TitoloR001;
  if not(C001FFiltroTabelle.Visible) then
  begin
    C001FFiltroTabelle.ShowModal;
    C001FFiltroTabelleDTM.Query1.CloseAll;
    C001FFiltroTabelleDTM.Query2.CloseAll;
    StampaAnagraficoMisto:=False;
  end;
end;

end.
