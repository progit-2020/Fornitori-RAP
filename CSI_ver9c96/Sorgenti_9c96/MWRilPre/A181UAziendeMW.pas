unit A181UAziendeMW;

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData, Math, StrUtils, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, R005UDataModuleMW,
  C180FunzioniGenerali, DBClient, C018UIterAutDM, Datasnap.Provider,
  medpSendMail, RegistrazioneLog;

type
  TA181FAziendeMW = class(TR005FDataModuleMW)
    Ins091: TOracleQuery;
    scrdelI090: TOracleQuery;
    scrupdI090: TOracleQuery;
    DBMondoedp: TOracleSession;
    scrI092: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  const
    NON_ASSEGNATO = 'Non assegnato';
  private
    function  GetI091Gruppo(CodI091:String):String;
  public
    GruppoFiltroI091:String;
    QI090:TOracleDataSet;
    QI091:TOracleDataSet;
    RegistraLogSecondario:TRegistraLog;
    procedure QI091AfterDelete;
    procedure QI091AfterPost;
    procedure QI091BeforeDelete;
    procedure QI091BeforePost;
    procedure QI091CalcFields;
    procedure QI091FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure JobArchiviazioneLOG;
    function Decod_Iter(InIter:String):String;
  end;

implementation

{$R *.dfm}

procedure TA181FAziendeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  RegistraLogSecondario:=TRegistraLog.Create(nil);
  RegistraLogSecondario.Session:=SessioneOracle;
end;

procedure TA181FAziendeMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(RegistraLogSecondario);
end;

procedure TA181FAziendeMW.JobArchiviazioneLOG;
var
  ScriptJob:TOracleQuery;
begin
  ScriptJob:=TOracleQuery.Create(nil);
  try
    try
      //Sessione Oracle dedicata all'utente MONDOEDP per la compilazione del job
      DBMondoedp.LogonDatabase:=Parametri.Database;
      A000LogonDBOracle(DBMondoedp);
      ScriptJob.Session:=DBMondoedp;
      ScriptJob.SQL.Add('select count(*) NUMREC');
      ScriptJob.SQL.Add('  from MONDOEDP.I091_DATIENTE I091');
      ScriptJob.SQL.Add(' where I091.TIPO = ''C28_CANCELLA_ANNO_LOG''');
      ScriptJob.SQL.Add('  and nvl(I091.DATO,''99'') <> ''99''');
      ScriptJob.Execute;
      if ScriptJob.FieldAsInteger('NUMREC') > 0 then
      begin
        ScriptJob.SQL.Clear;
        //Se il periodo di cancellazione è diverso da null o da 99 creo il job
        //e pianifico la schedulazione ogni mese alle 2 di notte
        ScriptJob.DeclareVariable('jobno',otInteger);
        ScriptJob.SQL.Add('declare');
        ScriptJob.SQL.Add(' IDJob integer;');
        ScriptJob.SQL.Add('begin');
        ScriptJob.SQL.Add('  IDJob:=-1;');
        //Cerco se è già presente il job
        ScriptJob.SQL.Add('  begin');
        ScriptJob.SQL.Add('    select nvl(J.JOB,99) into IDJob');
        ScriptJob.SQL.Add('      from USER_JOBS J');
        ScriptJob.SQL.Add('     where J.WHAT like (''%I000P_ELIMINAVECCHILOG%'');');
        ScriptJob.SQL.Add('  exception');
        ScriptJob.SQL.Add('    when NO_DATA_FOUND then');
        ScriptJob.SQL.Add('      IDJob:=-1;');
        ScriptJob.SQL.Add('  end;');
        //se non trovo il job lo creo
        ScriptJob.SQL.Add('  if IDJob < 0 then');
        ScriptJob.SQL.Add('    sys.dbms_job.submit (');
        ScriptJob.SQL.Add('    job => :jobno,');
        ScriptJob.SQL.Add('    what => ''declare');
        ScriptJob.SQL.Add('                ECCEZIONE varchar2(2000);');
        ScriptJob.SQL.Add('              cursor c1 is');
        ScriptJob.SQL.Add('                select I090.UTENTE, I090.AZIENDA');
        ScriptJob.SQL.Add('                  from I090_ENTI I090;');
        ScriptJob.SQL.Add('            begin');
        ScriptJob.SQL.Add('              for t1 in c1 loop');
        ScriptJob.SQL.Add('                begin');
        ScriptJob.SQL.Add('                  execute immediate ''''begin ''''||T1.UTENTE||''''.I000P_ELIMINAVECCHILOG; end;'''';');
        ScriptJob.SQL.Add('                exception');
        ScriptJob.SQL.Add('                  when OTHERS then');
        ScriptJob.SQL.Add('                    ECCEZIONE:=substr(SQLERRM,1,2000);');
        ScriptJob.SQL.Add('                    insert into MONDOEDP.I021_LOG_JOB (DATAORA, MESSAGGIO, AZIENDA, TIPO) values (sysdate, ECCEZIONE, T1.AZIENDA,''''I000P_ELIMINAVECCHILOG'''');');
        ScriptJob.SQL.Add('                end;');
        ScriptJob.SQL.Add('              end loop;');
        ScriptJob.SQL.Add('              end;'',');
        ScriptJob.SQL.Add('    next_date => TRUNC(SYSDATE) + 1 + (2/24) /*prima esecuzione alle 02.00*/,');
        ScriptJob.SQL.Add('    interval => ''add_MONTHS(TRUNC(SYSDATE) + 1 + (2/24),1)'') /*prossima esecuzione ogni mese alle 02.00*/;');
        ScriptJob.SQL.Add('    commit;');
        ScriptJob.SQL.Add('  else');
        //se lo trovo resetto la prossima data di esecuzione la notte
        ScriptJob.SQL.Add('    dbms_job.next_date(IDJob, trunc(SYSDATE) + 1 + (2/24));');
        ScriptJob.SQL.Add('    commit;');
        ScriptJob.SQL.Add('  end if;');
        ScriptJob.SQL.Add('end;');
        ScriptJob.Execute;
      end
      else
      begin
        //Se il periodo di cancellazione è uguale a null o a 99 cancello il job
        ScriptJob.SQL.Clear;
        ScriptJob.SQL.Add('declare');
        ScriptJob.SQL.Add('  IDJob integer;');
        ScriptJob.SQL.Add('begin');
        ScriptJob.SQL.Add('  IDJob:=-1;');
        ScriptJob.SQL.Add('  begin');
        ScriptJob.SQL.Add('    select J.JOB into IDJob');
        ScriptJob.SQL.Add('      from USER_JOBS J');
        ScriptJob.SQL.Add('     where J.WHAT like (''%I000P_ELIMINAVECCHILOG%'');');
        ScriptJob.SQL.Add('  exception');
        ScriptJob.SQL.Add('    when NO_DATA_FOUND then');
        ScriptJob.SQL.Add('      IDJob:=-1;');
        ScriptJob.SQL.Add('  end;');
        ScriptJob.SQL.Add('  if IDJob > 0 then');
        ScriptJob.SQL.Add('    dbms_job.remove(IDJob) /*rimuovo il job dopo averne identificato il l''id*/;');
        ScriptJob.SQL.Add('    commit;');
        ScriptJob.SQL.Add('  end if;');
        ScriptJob.SQL.Add('end;');
        ScriptJob.Execute;
      end;
    finally
      FreeAndNil(ScriptJob);
      DBMondoedp.LogOff;
    end;
  except
    on e:exception do
      R180MessageBox(e.message,ERRORE,'Archiviazione log');
  end;
end;

procedure TA181FAziendeMW.QI091AfterDelete;
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA181FAziendeMW.QI091AfterPost;
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA181FAziendeMW.QI091BeforeDelete;
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(QI091),NomeOwner,QI091,True);
  Abort;
end;

procedure TA181FAziendeMW.QI091BeforePost;
var i,j,TestInt:integer;
    TestString, ListaNumeri:String;
    TestDate:TDateTime;
begin
  //Verifica dei dati numerici della I091 Dati aziendali
  ListaNUmeri:='0123456789';
  i:=1;
  while (DatiEnte[i].Nome <> QI091.FieldByName('TIPO').AsString) do
    inc(i);
  if DatiEnte[i].Nome = QI091.FieldByName('TIPO').AsString then
  begin
    TestString:=QI091.FieldByName('DATO').AsString;
    if DatiEnte[i].Lista = 'NUMERICO' then
    begin
      for j:=1 to Length(TestString) do
        if pos(TestString[j], ListaNUmeri) <= 0 then
          raise Exception.Create('Impossibile inserire un valore non numerico!');
      if (DatiEnte[i].Nome = 'C37_NUM_COL_ALTRI_PROG')
      and (TestString <> '')
      and ((StrToInt(TestString) < 0) or (StrToInt(TestString) > 5)) then
        raise Exception.Create('Il valore da inserire deve essere compreso fra 0 e 5!');
    end
    else if DatiEnte[i].Lista = 'GIORNO_MESE' then
    begin
      if not TryStrToInt(TestString,TestInt) then
        raise Exception.Create('Il valore da inserire deve essere un intero compreso fra 1 e 31!');
      if (TestInt < 1) or (TestInt > 31) then
        raise Exception.Create('Il valore da inserire deve essere compreso fra 1 e 31!');
    end
    else if DatiEnte[i].Lista = 'DATA' then
    begin
      if not TryStrToDate(TestString,TestDate) then
        raise Exception.Create('Il valore da inserire deve essere una data valida nel formato dd/mm/yyyy!');

    end;
  end;
  if DatiEnte[i].Nome = 'C90_EMAIL_PASSWORD' then
    QI091.FieldByName('DATO').AsString:=R180Cripta(QI091.FieldByName('DATO').AsString,30011945);
  case QI091.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(QI091),NomeOwner,QI091,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(QI091),NomeOwner,QI091,True);
  end;
end;

procedure TA181FAziendeMW.QI091CalcFields;
{descrizione dei dati disponibili in Gestione Moduli}
begin
  QI091.FieldByName('D_Tipo').AsString:=A000DescDatiEnte(QI091.FieldByName('Tipo').AsString);
  if QI091.FieldByName('D_Tipo').AsString = '' then
    QI091.FieldByName('D_Tipo').AsString:=QI091.FieldByName('Tipo').AsString;
  QI091.FieldByName('GRUPPO').AsString:=GetI091Gruppo(QI091.FieldByName('TIPO').AsString);
end;

procedure TA181FAziendeMW.QI091FilterRecord(DataSet: TDataSet; var Accept: Boolean);
var i:Integer;
begin
  Accept:=True;
  if GruppoFiltroI091 = '' then
    exit;
  Accept:=False;
  if GruppoFiltroI091 <> NON_ASSEGNATO then
  begin
    for i:=Low(DatiEnte) to High(DatiEnte) do
      if (UpperCase(DatiEnte[i].Gruppo) = UpperCase(GruppoFiltroI091)) and
         (UpperCase(QI091.FieldByName('TIPO').AsString) = UpperCase(DatiEnte[i].Nome)) then
      begin
        Accept:=True;
        Break;
      end;
    end
  else
    if GetI091Gruppo(QI091.FieldByName('TIPO').AsString) = NON_ASSEGNATO then
      Accept:=True;
end;

function TA181FAziendeMW.Decod_Iter(InIter:String):String;
var i:Integer;
begin
  Result:='';
  if InIter = '' then
    Exit;
  i:=0;
  while (A000IterAutorizzativi[i].Cod <> InIter) and (i < High(A000IterAutorizzativi)) do
    inc(i);
  Result:=A000IterAutorizzativi[i].Desc;
end;

function TA181FAziendeMW.GetI091Gruppo(CodI091:String):String;
var i:Integer;
begin
  for i:=Low(DatiEnte) to High(DatiEnte) do
    if DatiEnte[i].Nome = CodI091 then
    begin
      Result:=DatiEnte[i].Gruppo;
      exit
    end;
  Result:=NON_ASSEGNATO;
end;

end.
