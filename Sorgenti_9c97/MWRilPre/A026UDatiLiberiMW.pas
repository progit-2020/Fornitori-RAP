unit A026UDatiLiberiMW;

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData,
  A000UInterfaccia, R005UDataModuleMW, A099UUtilityDBMW;

type
  TA026FDatiLiberiMW = class(TR005FDataModuleMW)
    T430: TOracleDataSet;
    Q430: TOracleQuery;
    OperSQL: TOracleQuery;
    QIndx: TOracleDataSet;
    DropQ430_Appoggio: TOracleQuery;
    selT033B: TOracleDataSet;
    updT033: TOracleQuery;
    insT033: TOracleQuery;
    selT033C: TOracleDataSet;
    selT033D: TOracleDataSet;
    T030: TOracleDataSet;
    scrI501: TOracleQuery;
    scraI501: TOracleQuery;
    selCols: TOracleDataSet;
    insI010: TOracleQuery;
    updI010: TOracleQuery;
    delI010: TOracleQuery;
    selaCols: TOracleDataSet;
    insI501: TOracleQuery;
    selUserTriggers: TOracleDataSet;
    selUserTabPrivs: TOracleDataSet;
    selColsI501: TOracleDataSet;
    selColsDef: TOracleDataSet;
    CreateQ430_Appoggio: TOracleScript;
    CreaTriggerI501: TOracleQuery;
    selI091: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    A099FUtilityDBMW:TA099FUtilityDBMW;
    procedure CreaTabella(Campo:String);
    procedure CopiaDati(Campo:String);
    procedure RinominaTabella;
    function TipoDato(Tipo:String;Size:Word;Nome,Nullo:String):String;
    procedure InserisciCodiceDefault;
    function ColonneComuni(Old,New:String):String;
    procedure CopiaDatiI501(Sorg,Dest,Col:String);
    procedure CallScriviStatusBar(S:String);
  public
    { Public declarations }
    A026Decorrenza,A026NomePagina:String;
    DS:TDataSet;
    procedure CostruisciV430;
    procedure VerificaNomeCampoAnagrafico;
    function GetNomePagina:String;
    procedure EliminaDatoLibero;
    procedure InserisciDatoLibero;
    procedure ModificaTabellare(Campo,Tabella:String);
    procedure ModificaColonna(Campo:String; Lunghezza:Integer);
    procedure ModificaLungDesc;
    procedure ModificaPagina;
    function ModificaLinkStorico:boolean;
    procedure CreaTabellaI501(Tabella:String);
  end;

implementation

{$R *.dfm}

procedure TA026FDatiLiberiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT033D.Open;
  A099FUtilityDBMW:=TA099FUtilityDBMW.Create(nil);
end;

procedure TA026FDatiLiberiMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A099FUtilityDBMW);
end;

procedure TA026FDatiLiberiMW.CostruisciV430;
begin
  A099FUtilityDBMW.CostruisciV430;
end;

procedure TA026FDatiLiberiMW.EliminaDatoLibero;
begin
  try
    CallScriviStatusBar('Aggiornamento I500_DATILIBERI...');
    with OperSQL do
    begin
      //Aggiornamento dei progressivi dei dati liberi inseriti successivamente
      SQL.Clear;
      SQL.Add('UPDATE I500_DATILIBERI SET PROGRESSIVO = PROGRESSIVO - 1 WHERE PROGRESSIVO > ' + DS.FieldByName('PROGRESSIVO').AsString);
      Execute;
    end;
    //Eliminazione della tabella associata se il dato era tabellare
    if DS.FieldByName('TABELLA').AsString = 'S' then
      with OperSQL do
      begin
        CallScriviStatusBar('Eliminazione I501' + DS.FieldByName('NOMECAMPO').AsString + '...');
        SQL.Clear;
        if Parametri.VersioneOracle >= 10 then
          Sql.Add('DROP TABLE I501' + DS.FieldByName('NOMECAMPO').AsString + ' PURGE')
        else
          Sql.Add('DROP TABLE I501' + DS.FieldByName('NOMECAMPO').AsString);
        try
          Execute;
        except
        end;
      end;
    //Eliminazione dato su tabella ridefinizione campi anagrafici
    CallScriviStatusBar('Eliminazione Layout...');
    DelI010.SetVariable('NomeCampo','T430' + DS.FieldByName('NOMECAMPO').AsString);
    DelI010.Execute;
    DelI010.SetVariable('NomeCampo','T430D_' + DS.FieldByName('NOMECAMPO').AsString);
    DelI010.Execute;
    //Eliminazione dei campi dalle configurazioni di layout
    with OperSQL do
    begin
      SQL.Clear;
      SQL.Add('DELETE FROM T033_LAYOUT WHERE CAMPODB = ''' + DS.FieldByName('NOMECAMPO').AsString + '''');
      try
        Execute;
      except
      end;
    end;
    SessioneOracle.Commit;
    //Eliminazione della colonna in T430_Storico
    with OperSQL do
    try
      //La DROP COLUMN è possibile dalla 8.1 in poi
      SQL.Clear;
      SQL.Add('ALTER TABLE T430_STORICO DROP COLUMN ' + DS.FieldByName('NOMECAMPO').AsString);
      Execute;
    except
      //Gestione originale con la ricreazione della T430
      CreaTabella(UpperCase(DS.FieldByName('NOMECAMPO').AsString));
      CopiaDati(UpperCase(DS.FieldByName('NOMECAMPO').AsString));
      SessioneOracle.Commit;
      CallScriviStatusBar('Rinomina T430NEW in T430_STORICO...');
      RinominaTabella;
    end;
    if Parametri.VersioneOracle >= 10 then
      DropQ430_Appoggio.SQL.Text:='DROP TABLE T430_APPOGGIO PURGE'
    else
      DropQ430_Appoggio.SQL.Text:='DROP TABLE T430_APPOGGIO';
    DropQ430_Appoggio.Execute;
    CreateQ430_Appoggio.Execute;
  except
    //SessioneOracle.Rollback;
    CallScriviStatusBar('');
    raise;
  end;
end;

procedure TA026FDatiLiberiMW.CreaTabella(Campo:String);
{Crea tabella di appoggio senza colonna specificata}
var Attrib,Primary,OldIndx,CampiIndx,ValDef:String;
    i:Integer;
    Campi:TStringList;
    Unico:Boolean;
    procedure CreaIndice(Nome:String; Unico:Boolean; LCampi:String);
    begin
      with OperSQL do
        begin
        SQL.Clear;
        SQL.Add('DROP INDEX ' + Nome);
        try
          Execute;
        except
        end;
        SQL.Clear;
        SQL.Add('CREATE ');
        if Unico then
          SQL.Add('UNIQUE  ');
        SQL.Add('INDEX ' + OldIndx +' ON T430NEW (' + CampiIndx + ') NOPARALLEL TABLESPACE ' + Parametri.TSIndici);
        try
          Execute;
        except
        end;
        end;
    end;
begin
  Campi:=TStringList.Create;
  Campi.Clear;
  with T430 do
    begin
    Close;
    Open;
    while not Eof do
      begin
      if FieldByName('COLUMN_NAME').AsString <> Campo then
        begin
        if Campi.Count > 0 then Attrib:=','
        else Attrib:='';
        Attrib:=Attrib + TipoDato(FieldByName('DATA_TYPE').AsString,FieldByName('DATA_LENGTH').AsInteger,FieldByName('COLUMN_NAME').AsString,FieldByName('NULLABLE').AsString);
        Campi.Add(Attrib);
        end;
      Next;
      end;
    Close;
    end;
  //Costruisco la chiave primaria
  Primary:=',CONSTRAINT T430_PK PRIMARY KEY (PROGRESSIVO, DATADECORRENZA) USING INDEX TABLESPACE '+ Parametri.TSIndici + ' STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K)';
  with OperSQL do
    begin
    //Cancello T430NEW
    CallScriviStatusBar('Eliminazione T430NEW...');
    Sql.Clear;
    if Parametri.VersioneOracle >= 10 then
      Sql.Add('DROP TABLE T430NEW PURGE')
    else
      Sql.Add('DROP TABLE T430NEW');
    try
      Execute;
    except
    end;
    CallScriviStatusBar('Eliminazione indici di T430_STORICO...');
    //Cancello T430_PK come constraint
    Sql.Clear;
    Sql.Add('ALTER TABLE T430_STORICO DROP CONSTRAINT T430_PK');
    try
      Execute;
    except
    end;
    //Cancello T430_PK come indice
    Sql.Clear;
    Sql.Add('DROP INDEX T430_PK');
    try
      Execute;
    except
    end;
    //Creo T430NEW
    CallScriviStatusBar('Creazione T430NEW...');
    Sql.Clear;
    Sql.Add('CREATE TABLE T430NEW (');
    for i:=0 to Campi.Count - 1 do
      Sql.Add(Campi[i]);
    Sql.Add(Primary);
    Sql.Add(')');
    Sql.Add('TABLESPACE ' + Parametri.TSLavoro);
    Sql.Add('STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K) NOPARALLEL');
    Execute;
    end;
  OldIndx:='';
  CampiIndx:='';
  Unico:=False;
  with QIndx do
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
    end;
  if OldIndx <> '' then
    CreaIndice(OldIndx,Unico,CampiIndx);
  //Assegna valori di default letti da I010_CAMPIANAGRAFICI
  with selColsDef do
  begin
    Open;
    while not Eof do
    begin
      OperSQL.SQL.Clear;
      ValDef:=Trim(FieldByName('DATA_DEFAULT').AsString);
      if UpperCase(ValDef) = 'NULL' then
        ValDef:='';
      if (Copy(ValDef,1,1) = '''') and (Copy(ValDef,Length(ValDef),1) = '''') then
        ValDef:=Copy(ValDef,2,Length(ValDef) - 2);
      if ValDef <> '' then
      try
        OperSQL.SQL.Add(Format('ALTER TABLE T430NEW MODIFY %s DEFAULT ''%s''',[FieldByName('COLUMN_NAME').AsString,ValDef]));
        OperSQL.Execute;
      except
      end;
      Next;
    end;
    Close;
  end;
  Campi.Free;
end;

procedure TA026FDatiLiberiMW.CopiaDati(Campo:String);
{Copia dei dati da T430_Storico a T430New}
var S:String;
begin
  S:='';
  with T430 do
  begin
    Close;
    Open;
    while not Eof do
    begin
      if FieldByName('COLUMN_NAME').AsString <> Campo then
      begin
        if S <> '' then S:=S + ',';
        S:=S + FieldByName('COLUMN_NAME').AsString;
      end;
      Next;
    end;
  end;
  CallScriviStatusBar('Copia T430_STORICO in T430NEW...');
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO T430NEW SELECT');
    SQL.Add(S);
    SQL.Add('FROM T430_STORICO WHERE PROGRESSIVO = :PROGRESSIVO');
    DeclareVariable('PROGRESSIVO',otInteger);
  end;
  with TOracleDataSet.Create(nil) do
  try
    Session:=SessioneOracle;
    ReadBuffer:=5000;
    SQL.Add('SELECT DISTINCT PROGRESSIVO FROM T430_STORICO');
    Open;
    if Assigned(ResettaProgressBar) then ResettaProgressBar;
    if Assigned(MaxProgressBar) then MaxProgressBar(RecordCount);
    while not Eof do
    begin
      if Assigned(IncrementaProgressBar) then IncrementaProgressBar;
      OperSQL.SetVariable('PROGRESSIVO',Fields[0].AsInteger);
      OperSQL.Execute;
      SessioneOracle.Commit;
      Next;
    end;
  finally
    Free;
    OperSQL.DeleteVariables;
    if Assigned(ResettaProgressBar) then ResettaProgressBar;
  end;
end;

procedure TA026FDatiLIberiMW.RinominaTabella;
{Elimino T430_Storico e rinomino T430New in T430_Storico}
begin
  //Lettura triggers di T430
  try
    selUserTriggers.Close;
    selUserTriggers.Open;
  except
  end;
  //Lettura privilegi di T430
  try
    selUserTabPrivs.Close;
    selUserTabPrivs.Open;
  except
  end;
  with OperSQL do
  begin
    SQL.Clear;
    if Parametri.VersioneOracle >= 10 then
      SQL.Add('DROP TABLE T430_STORICO PURGE')
    else
      SQL.Add('DROP TABLE T430_STORICO');
    Execute;
    SQL.Clear;
    SQL.Add('RENAME T430NEW TO T430_STORICO');
    Execute;
  end;
  //Ricreazione triggers di T430
  with selUserTriggers do
  try
    while not Eof do
    begin
      OperSQL.SQL.Clear;
      OperSQL.SQL.Add('CREATE OR REPLACE TRIGGER ' + FieldByName('DESCRIPTION').AsString);
      if not FieldByName('WHEN_CLAUSE').IsNull then
        OperSQL.SQL.Add('WHEN ' + FieldByName('WHEN_CLAUSE').AsString);
      OperSQL.SQL.Add(FieldByName('TRIGGER_BODY').AsString);
      try
        OperSQL.Execute;
        if FieldByName('STATUS').AsString = 'DISABLED' then
        begin
          OperSQL.SQL.Clear;
          OperSQL.SQL.Add('ALTER TRIGGER ' + FieldByName('TRIGGER_NAME').AsString + ' DISABLE');
          OperSQL.Execute;
        end;
      except
      end;
      Next;
    end;
  except
  end;
  //Ricreazione grant di T430
  with selUserTabPrivs do
  try
    while not Eof do
    begin
      OperSQL.SQL.Clear;
      OperSQL.SQL.Add(FieldByName('PRIVILEGI').AsString);
      try
        OperSQL.Execute;
      except
      end;
      Next;
    end;
  except
  end;
end;

function TA026FDatiLiberiMW.TipoDato(Tipo:String;Size:Word;Nome,Nullo:String):String;
{Costruisco il campo in base al suo tipo}
begin
  if Tipo = 'VARCHAR2' then
    Result:=Nome + ' VARCHAR2 (' + IntToStr(Size) + ')'
  else if Tipo = 'NUMBER' then
    begin
    if (Nome = 'PROGRESSIVO') or (Nome = 'BADGE') then
      Result:=Nome + ' NUMBER (38)'
    else
      Result:=Nome + ' NUMBER';
    end
  else
    Result:=Nome + ' ' + Tipo;
  if Nullo = 'N' then
    Result:=Result + ' NOT NULL';
end;

procedure TA026FDatiLiberiMW.ModificaTabellare(Campo,Tabella:String);
{Aggiunta/Rimozione della tabella I501}
begin
  with OperSQL do
  begin
    if Tabella = 'S' then
      CreaTabellaI501('I501')
    else
    //Eliminazione tabella
    begin
      SQL.Clear;
      if Parametri.VersioneOracle >= 10 then
        SQL.Add('DROP TABLE I501' + Campo + ' PURGE')
      else
        SQL.Add('DROP TABLE I501' + Campo);
      try
        Execute;
      except
      end;
    end;
  end;
end;

procedure TA026FDatiLiberiMW.CreaTabellaI501(Tabella:String);
//Creazione tabella I502 o I501xxx con eventuali colonne aggiuntive: DECORRENZA,DECORRENZA_FINE,PROGRESSIVOQM,DEBITOGGQM,MACRO_CATEG_QM e LINK
var PK:String;
begin
  with OperSQL do
  begin
    //Se esiste già, la tabella viene prima cancellata
    Sql.Clear;
    if Parametri.VersioneOracle >= 10 then
      Sql.Add('DROP TABLE I501' + DS.FieldByName('NomeCampo').AsString + ' PURGE')
    else
      Sql.Add('DROP TABLE I501' + DS.FieldByName('NomeCampo').AsString);
    try
      Execute;
    except
    end;
    PK:='CODICE';
    SQL.Clear;
    SQL.Add('CREATE TABLE ' + Tabella + DS.FieldByName('NOMECAMPO').AsString);
    SQL.Add('(CODICE VARCHAR2('+ DS.FieldByName('LUNGHEZZA').AsString + ')');
    //Se il dato è storico creo la colonna DECORRENZA
    if DS.FieldByName('STORICO').AsString = 'S' then
    begin
      PK:=PK + ',DECORRENZA';
      SQL.Add(', DECORRENZA DATE');
      SQL.Add(', DECORRENZA_FINE DATE');
    end;
    SQL.Add(', DESCRIZIONE VARCHAR2(' + DS.FieldByName('LUNG_DESC').AsString + ')');
    //Imposto la Primary Key solo se sto creando la tabella definitiva I501
    if Tabella = 'I501' then
      SQL.Add(', CONSTRAINT I501' + DS.FieldByName('NOMECAMPO').AsString + '_PK PRIMARY KEY (' + PK + ') USING INDEX TABLESPACE ' + Parametri.TSIndici + ')')
    else
      SQL.Add(',)');
    SQL.Add('TABLESPACE ' + Parametri.TSLavoro);
    SQL.Add('STORAGE (PCTINCREASE 0 INITIAL 64K NEXT 64K) NOPARALLEL');
    Execute;
    //Se il dato è storico inserisco il codice di default obbligatorio * NON DEFINITO
    if DS.FieldByName('STORICO').AsString = 'S' then
    begin
      InserisciCodiceDefault;
      //Creo indice su CODICE,DECORRENZA,DECORRENZA_FINE
      SQL.Clear;
      SQL.Add(Format('create index %s on %s (CODICE,DECORRENZA,DECORRENZA_FINE) tablespace %s storage (initial 64K next 64K pctincrease 0)',[Copy(Tabella + DS.FieldByName('NOMECAMPO').AsString,1,26) + '_CDF',Tabella + DS.FieldByName('NOMECAMPO').AsString,Parametri.TSIndici]));
      try
        Execute;
      except
      end;
      //Creo il trigger per l'allineamento dei dati anagrafici
      CreaTriggerI501.SetVariable('NOME_TRIGGER',Tabella + DS.FieldByName('NOMECAMPO').AsString + '_AFTINSDEL');
      CreaTriggerI501.SetVariable('NOME_TABELLA',Tabella + DS.FieldByName('NOMECAMPO').AsString);
      CreaTriggerI501.SetVariable('NOME_CAMPO','''' + DS.FieldByName('NOMECAMPO').AsString + '''');
      CreaTriggerI501.SetVariable('OLD_CODICE',':OLD.CODICE');
      CreaTriggerI501.SetVariable('NEW_CODICE',':NEW.CODICE');
      try
        CreaTriggerI501.Execute;
      except
      end;
    end;
  end;
end;

procedure TA026FDatiLiberiMW.InserisciCodiceDefault;
//Inserisce il codice obbligatorio * NON DEFINITO per i dati storicizzati
var S:string;
begin
  S:=Copy('NON DEFINITO',1,DS.FieldByName('LUNG_DESC').AsInteger);
  with OperSQL do
  begin
    SQL.Clear;
    SQL.Add('INSERT INTO I501' + DS.FieldByName('NOMECAMPO').AsString);
    SQL.Add('(CODICE,DECORRENZA,DECORRENZA_FINE,DESCRIZIONE) VALUES');
    SQL.Add('(''*'',TO_DATE(''01/01/1900'',''dd/mm/yyyy''),TO_DATE(''31/12/3999'',''dd/mm/yyyy''),''' + S + ''')');
    try
      Execute;
    except;
    end;
(* Danilo 26/01/2009    SQL.Clear;
    SQL.Add('UPDATE T430_STORICO SET ' + DS.FieldByName('NOMECAMPO').AsString);
    SQL.Add(' = ''*'' WHERE ' + DS.FieldByName('NOMECAMPO').AsString + ' IS NULL');
    try
      Execute;
    except;
    end;*)
  end;
end;

procedure TA026FDatiLiberiMW.ModificaColonna(Campo:String; Lunghezza:Integer);
{Cambiamento di dimensione del dato libero}
var Annulla:Boolean;
begin
  Annulla:=False;
  with OperSQL do
  begin
    if DS.FieldByName('Lunghezza').medpOldValue > Lunghezza then
    begin
      Annulla:=True;
      SQL.Clear;
      SQL.Add(Format('UPDATE T430_STORICO SET %s = NULL',[Campo,Lunghezza]));
      Execute;
      SQL.Clear;
      SQL.Add(Format('DELETE FROM I501%s',[Campo,Lunghezza]));
      try
        Execute;
      except
      end;
    end;
    SQL.Clear;
    SQL.Add(Format('ALTER TABLE T430_STORICO MODIFY %s VARCHAR2(%d)',[Campo,Lunghezza]));
    Execute;
    if Parametri.VersioneOracle >= 10 then
      DropQ430_Appoggio.SQL.Text:='DROP TABLE T430_APPOGGIO PURGE'
    else
      DropQ430_Appoggio.SQL.Text:='DROP TABLE T430_APPOGGIO';
    DropQ430_Appoggio.Execute;
    CreateQ430_Appoggio.Execute;
    SQL.Clear;
    SQL.Add(Format('ALTER TABLE I501%s MODIFY CODICE VARCHAR2(%d)',[Campo,Lunghezza]));
    try
      Execute;
    except
    end;
    selColsI501.SQL.Clear;
    selColsI501.SQL.Add('SELECT DISTINCT');
    selColsI501.SQL.Add(Format('''UPDATE ''||TABLE_NAME||'' SET %s = NULL'' COMANDO1,',[Campo]));
    selColsI501.SQL.Add(Format('''ALTER TABLE ''||TABLE_NAME||'' MODIFY %s VARCHAR2(%d)'' COMANDO2',[Campo,Lunghezza]));
    selColsI501.SQL.Add(Format('FROM COLS WHERE SUBSTR(TABLE_NAME,1,4) = ''I501'' AND COLUMN_NAME = ''%s''',[Campo]));
    selColsI501.Close;
    selColsI501.Open;
    while not selColsI501.Eof do
    begin
      if Annulla then
      begin
        SQL.Clear;
        SQL.Add(selColsI501.FieldByName('COMANDO1').AsString);
        Execute;
      end;
      SQL.Clear;
      SQL.Add(selColsI501.FieldByName('COMANDO2').AsString);
      Execute;
      selColsI501.Next;
    end;
  end;
end;

procedure TA026FDatiLiberiMW.ModificaLungDesc;
//Modifica della lunghezza del campo descrizione per i dati tabellari
begin
  with OperSQL do
  begin
    if DS.FieldByName('LUNG_DESC').medpOldValue > DS.FieldByName('LUNG_DESC').Value then
    begin
      SQL.Clear;
      SQL.Add('UPDATE I501' + DS.FieldByName('NOMECAMPO').AsString + ' SET DESCRIZIONE = '''' ');
      try
        Execute;
      except
      end;
    end;
    SQL.Clear;
    SQL.Add('ALTER TABLE I501' + DS.FieldByName('NOMECAMPO').AsString + ' MODIFY DESCRIZIONE VARCHAR2(' + DS.FieldByName('LUNG_DESC').AsString + ')');
    try
      Execute;
    except
    end;
  end;
end;

function TA026FDatiLiberiMW.ModificaLinkStorico:Boolean;
//Modifico la condizione di dato storico S/N
var Col:String;
begin
  Result:=True;
  with OperSQL do
  begin
    if DS.FieldByName('Tabella').AsString = 'S' then
    begin
      //Se esiste già, la tabella viene prima cancellata
      Sql.Clear;
      if Parametri.VersioneOracle >= 10 then
        SQL.Add('DROP TABLE I502 PURGE')
      else
        Sql.Add('DROP TABLE I502');
      try
        Execute;
      except
      end;
      //Creo la tabella di appoggio I502
      Sql.Clear;
      SQL.Add('CREATE TABLE I502 NOPARALLEL TABLESPACE ' + Parametri.TSLavoro);
      SQL.Add(' AS SELECT * FROM I501' + DS.FieldByName('NomeCampo').AsString);
      try
        Execute;
      except
        on e: exception do
        begin
          raise Exception.Create('Errore di creazione I502' +
          #$A#$D + e.Message);
        end;
      end;
      //Se il dato è storico provo ad aggiungere la Decorrenza e la Decorrenza_Fine
      if DS.FieldByName('STORICO').AsString = 'S' then
      begin
        OperSql.Sql.Clear;
        OperSql.SQL.Add('ALTER TABLE I502 ADD DECORRENZA DATE DEFAULT TO_DATE(''' + A026Decorrenza + ''',''dd/mm/yyyy'')');
        try OperSql.Execute; except end;
        OperSql.Sql.Clear;
        OperSql.SQL.Add('ALTER TABLE I502 ADD DECORRENZA_FINE DATE DEFAULT TO_DATE(''31123999'',''DDMMYYYY'')');
        try OperSql.Execute; except end;
      end;
      //Verifico se è cambiata la storicizzazione del campo
      if DS.FieldByName('STORICO').medpOldValue <> DS.FieldByName('STORICO').Value then
      begin
        Col:=ColonneComuni('','');
        if DS.FieldByName('Storico').AsString = 'S' then
          //Dato storico aggiungo la data di decorrenza
          Col:=Col + ',DECORRENZA,DECORRENZA_FINE';
        //Cancello la tabella originale
        try
          Sql.Clear;
          if Parametri.VersioneOracle >= 10 then
            Sql.Add('DROP TABLE I501' + DS.FieldByName('NOMECAMPO').AsString + ' PURGE')
          else
            Sql.Add('DROP TABLE I501' + DS.FieldByName('NOMECAMPO').AsString);
        except
          on e: exception do
          begin
            raise Exception.Create('Cancellazione della tabella di origine fallita' +
            #$A#$D + e.Message);
          end;
        end;
        //Creo la tabella originale I501xxx con le modifiche
        try
          CreaTabellaI501('I501');
        except
          on e: exception do
          begin
            raise Exception.Create('Errore di creazione I501' +
            #$A#$D + e.Message);
          end;
        end;
        Q430.Sql.Clear;
(* Danilo 26/01/2009        if DS.FieldByName('STORICO').AsString = 'S' then
        begin
          Q430.Sql.Add('ALTER TABLE T430_STORICO MODIFY ' + DS.FieldByName('NOMECAMPO').AsString + ' DEFAULT ''*'' NOT NULL');
          //Aggiorno valore default ad '*' per il dato su tabella ridefinizione campi anagrafici
          UpdI010.SetVariable('NomeCampo','T430' + DS.FieldByName('NomeCampo').AsString);
          UpdI010.SetVariable('ValDefault','*');
        end
        else
        begin*)
          Q430.Sql.Add('ALTER TABLE T430_STORICO MODIFY ' + DS.FieldByName('NOMECAMPO').AsString + ' DEFAULT NULL NULL');
          //Aggiorno valore default a '' per il dato su tabella ridefinizione campi anagrafici
          UpdI010.SetVariable('NomeCampo','T430' + DS.FieldByName('NomeCampo').AsString);
          UpdI010.SetVariable('ValDefault','');
// Danilo 26/01/2009        end;
        try
          Q430.Execute;
          UpdI010.Execute;
        except
        end;
        //Copio i valori da I502 alla tabella originale
        try
          CopiaDatiI501('I502','I501' + DS.FieldByName('NOMECAMPO').AsString,Col);
        except
          on e: exception do
          begin
            raise Exception.Create('Copia dei dati da I502 a I501 fallita' +
            #$A#$D + e.Message);
          end;
        end;
      end;
    end;
    //Verifico se ci sono dati anagrafici che non hanno corrispondenza in tabella e nel
    //caso inserisco il record tabellare con eventuali colonne collegate valorizzate ad '*'
    if DS.FieldByName('STORICO').AsString = 'S' then
    begin
      insI501.SetVariable('NomeDato',DS.FieldByName('NOMECAMPO').AsString);
      insI501.SetVariable('NomeTabella','I501' + DS.FieldByName('NOMECAMPO').AsString);
      insI501.Execute;
    end;
(* Danilo 26/01/2009    //Forzo '*' in tutte le colonne di collegamenti di I501 del record di default con codice '*'
    selaCols.Close;
    selaCols.SetVariable('NomeTabella','I501' + DS.FieldByName('NOMECAMPO').AsString);
    selaCols.Open;
    while not selaCols.eof do
    begin
      SQL.Clear;
      SQL.Add('UPDATE I501' + DS.FieldByName('NOMECAMPO').AsString);
      SQL.Add('SET ' + selaCols.FieldByName('COLUMN_NAME').AsString + ' = ''*''');
      SQL.Add('WHERE CODICE = ''*'' OR ' + selaCols.FieldByName('COLUMN_NAME').AsString + ' IS NULL');
      Execute;
      selaCols.Next;
    end;*)
    //Cancello la tabella di comodo I502
    Sql.Clear;
    if Parametri.VersioneOracle >= 10 then
      Sql.Add('DROP TABLE I502 PURGE')
    else
      Sql.Add('DROP TABLE I502');
    try
      Execute;
    except
    end;
  end;
end;

function TA026FDatiLiberiMW.ColonneComuni(Old,New:String):String;
{Confronto Old e New contenenti le colonne separate da virgola e estraggo
le colonne comuni}
var LOld,LNew:TStringList;
    i:Integer;
begin
  Result:='CODICE,DESCRIZIONE';
  LOld:=TStringList.Create;
  LNew:=TStringList.Create;
  try
    LOld.CommaText:=Old;
    LNew.CommaText:=New;
    for i:=0 to LNew.Count - 1 do
      if LOld.IndexOf(LNew[i]) >= 0 then
       Result:=Result + ' ,' + LNew[i];
  finally
    LOld.Free;
    LNew.Free;
  end;
end;

procedure TA026FDatiLiberiMW.CopiaDatiI501(Sorg,Dest,Col:String);
{Copia dei dati da I501 a I502 o viceversa sulla base delle colonne comuni}
begin
  //Verifico se nella tabella origine c'era la data di decorrenza per estrarre il
  //record con max data di decorrenza a parità di codice
  selCols.SetVariable('TabSorg',Sorg);
  selCols.Close;
  selCols.Open;
  if (DS.FieldByname('Storico').AsString = 'S') and (Pos('DECORRENZA',Col) = 0) then
    //Dato storico aggiungo la data di decorrenza
    Col:=Col + ',DECORRENZA';
  if (DS.FieldByname('Storico').AsString = 'S') and (Pos('DECORRENZA_FINE',Col) = 0) then
    //Dato storico aggiungo la data di decorrenza_fine
    Col:=Col + ',DECORRENZA_FINE';
  //Se la tabella sorgente è quella di appoggio I502 e nella tabella destinazione I501 non
  //esiste la data di decorrenza e nella tabella origine c'era la data di decorrenza, nella
  //copia si estrae il record con max data di decorrenza a parità di codice
  if (Sorg = 'I502') and (Pos('DECORRENZA',Col) = 0) and (not selCols.Eof) then
  begin
    scrI501.SetVariable('TabSorg',Sorg);
    scrI501.SetVariable('Col',Col);
    scrI501.SetVariable('TabDest',Dest);
    scrI501.Execute;
  end
  else
  //Copio pari pari le colonne della tabella Sorg nella tabella Dest
  begin
    scraI501.SetVariable('TabSorg',Sorg);
    scraI501.SetVariable('Col',Col);
    scraI501.SetVariable('TabDest',Dest);
    scraI501.Execute;
  end;
  //Se la tabella destinazione è I502 e il dato è storico provo ad aggiungere e valorizzare la decorrenza
  if (Dest = 'I502') and (DS.FieldByName('STORICO').AsString = 'S') then
  begin
    OperSql.Sql.Clear;
    OperSql.SQL.Add('ALTER TABLE I502 ADD DECORRENZA DATE DEFAULT TO_DATE(''' + A026Decorrenza + ''',''dd/mm/yyyy'')');
    try OperSql.Execute; except end;
    OperSql.Sql.Clear;
    OperSql.SQL.Add('ALTER TABLE I502 ADD DECORRENZA_FINE DATE DEFAULT TO_DATE(''31123999'',''DDMMYYYY'')');
    try OperSql.Execute; except end;
  end;
end;

procedure TA026FDatiLiberiMW.ModificaPagina;
begin
  if A026NomePagina <> selT033B.FieldByName('NOMEPAGINA').AsString then
  begin
    //Modifica nome pagina su tutte le configurazioni
    updT033.SetVariable('NomePagina',A026NomePagina);
    updT033.SetVariable('CampoDb',DS.FieldByName('NomeCampo').AsString);
    try
      updT033.Execute;
    except
      raise;
    end;
  end;
end;

procedure TA026FDatiLiberiMW.InserisciDatoLibero;
var
  Lung:Byte;
  NDatiLiberi,Offset,Comodo: Integer;
begin
  //Inserimento dei dati
  try
    Lung:=DS.FieldByName('Lunghezza').AsInteger;
    Q430.Sql.Clear;
    if DS.FieldByName('Formato').AsString = 'S' then
(* Danilo 26/01/2009      if DS.FieldByName('STORICO').AsString = 'S' then
        Q430.Sql.Add(Format('ALTER TABLE T430_Storico ADD %s VARCHAR2(%d) DEFAULT ''*'' NOT NULL',[DS.FieldByName('NomeCampo').AsString,Lung]))
      else*)
        Q430.Sql.Add(Format('ALTER TABLE T430_Storico ADD %s VARCHAR2(%d)',[DS.FieldByName('NomeCampo').AsString,Lung]))
    else if DS.FieldByName('Formato').AsString = 'N' then
      Q430.Sql.Add(Format('ALTER TABLE T430_Storico ADD %s NUMBER',[DS.FieldByName('NomeCampo').AsString]))
    else
      Q430.Sql.Add(Format('ALTER TABLE T430_Storico ADD %s DATE',[DS.FieldByName('NomeCampo').AsString]));
    Q430.Execute;
    if Parametri.VersioneOracle >= 10 then
      DropQ430_Appoggio.SQL.Text:='DROP TABLE T430_APPOGGIO PURGE'
    else
      DropQ430_Appoggio.SQL.Text:='DROP TABLE T430_APPOGGIO';
    DropQ430_Appoggio.Execute;
    CreateQ430_Appoggio.Execute;
    {Assegno il progressivo = Numero Campi di T430 - 3}
    T430.Open;
    DS.FieldByName('Progressivo').AsInteger:=T430.RecordCount - 3;
    T430.Close;
    if DS.FieldByName('Tabella').AsString = 'S' then
      //Creo tabella I501+NomeCampo
      CreaTabellaI501('I501');
    //Inserimento nuovo dato su tabella ridefinizione campi anagrafici
    InsI010.SetVariable('NomeCampo','T430' + DS.FieldByName('NomeCampo').AsString);
    InsI010.SetVariable('NomeLogico','T430' + DS.FieldByName('NomeCampo').AsString);
(* Danilo 26/01/2009    if DS.FieldByName('STORICO').AsString = 'S' then
      InsI010.SetVariable('ValDefault','*')
    else*)
      InsI010.SetVariable('ValDefault','');
    InsI010.Execute;
    selT033C.Close;
    selT033C.SetVariable('NomePagina',A026NomePagina);
    selT033C.Open;
    NDatiLiberi:=selT033C.FieldByName('NDATILIBERI').AsInteger;
    Inc(NDatiLiberi);
    selT033D.First;
    while not selT033D.Eof do
    begin
      InsT033.SetVariable('Nome',selT033D.FieldByName('NOME').AsString);
      InsT033.SetVariable('Caption',DS.FieldByName('NomeCampo').AsString);
      InsT033.SetVariable('CampoDB',DS.FieldByName('NomeCampo').AsString);
      InsT033.SetVariable('Accesso','S');
      InsT033.SetVariable('NomePagina',A026NomePagina);
      if NDatiLiberi <= 8 then
      begin
        Offset:=0;
        Comodo:=(NDatiLiberi - Offset - 1) * 36 + 20;
        InsT033.SetVariable('Top',Comodo);
        Comodo:=8;
        InsT033.SetVariable('Lft',Comodo);
      end
      else if NDatiLiberi <= 16 then
      begin
        Offset:=8;
        Comodo:=(NDatiLiberi - Offset - 1) * 36 + 20;
        InsT033.SetVariable('Top',Comodo);
        Comodo:=300;
        InsT033.SetVariable('Lft',Comodo);
      end
      else
      begin
        //Nel caso il dato non ci stia nelle 2 colonne da otto lo posiziono
        //in centro pagina non visibile
        Comodo:=100;
        InsT033.SetVariable('Top',Comodo);
        Comodo:=150;
        InsT033.SetVariable('Lft',Comodo);
        InsT033.SetVariable('Accesso','N');
      end;
      InsT033.Execute;
      selT033D.Next;
    end;
    selT033B.Close;
    selT033C.Close;
    SessioneOracle.Commit;
  except
    on e: exception do
    begin
      SessioneOracle.Rollback;
      raise Exception.Create('L''inserimento del nuovo dato è fallito!' + #$A#$D + e.Message);
    end;
  end;
end;

function TA026FDatiLiberiMW.GetNomePagina:String;
begin
  selT033B.Close;
  selT033B.SetVariable('CampoDb',DS.FieldByName('NomeCampo').AsString);
  selT033B.Open;
  Result:=selT033B.FieldByName('NOMEPAGINA').AsString;
  selT033B.Close;
end;

procedure TA026FDatiLiberiMW.VerificaNomeCampoAnagrafico;
begin
  T030.Close;
  T030.SetVariable('Column_Name',DS.FieldByName('NomeCampo').AsString);
  try
    T030.Open;
    if T030.Fields[0].AsInteger > 0 then
      raise Exception.Create('Il nome deve essere diverso dai dati anagrafici già presenti: correggere!');
    T030.Close;
  finally
  end;
end;

procedure TA026FDatiLiberiMW.CallScriviStatusBar(S:String);
begin
  if Assigned(ScriviStatusBar) then
    ScriviStatusBar(S);
end;

end.
