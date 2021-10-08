unit A181UAziendeMW;

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData, Math, StrUtils, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, R005UDataModuleMW,
  C180FunzioniGenerali, DBClient, C018UIterAutDM, Datasnap.Provider,
  medpSendMail, RegistrazioneLog;

type
  TA181FAziendeMW = class(TR005FDataModuleMW)
    selI097: TOracleDataSet;
    selI097AZIENDA: TStringField;
    selI097ITER: TStringField;
    selI097COD_ITER: TStringField;
    selI097NUM_CONDIZ: TIntegerField;
    selI097CONDIZ_VALIDITA: TStringField;
    selI097MESSAGGIO: TStringField;
    selI097BLOCCANTE: TStringField;
    selI094: TOracleDataSet;
    selI094AZIENDA: TStringField;
    selI094ITER: TStringField;
    selI094d_riepilogo: TStringField;
    selI094RIEPILOGO: TStringField;
    selI094STATO: TStringField;
    selI094EXPR_DATA: TStringField;
    cdsBloccoRiep: TClientDataSet;
    Ins091: TOracleQuery;
    scrdelI090: TOracleQuery;
    scrupdI090: TOracleQuery;
    DBMondoedp: TOracleSession;
    scrI092: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selI097BeforePost(DataSet: TDataSet);
    procedure selI097NewRecord(DataSet: TDataSet);
    procedure selI094NewRecord(DataSet: TDataSet);
    procedure selI094BeforePost(DataSet: TDataSet);
    procedure selI094ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
    procedure selI097ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
  const
    NON_ASSEGNATO = 'Non assegnato';
  private
    ModuloIterAutorizzativiIter:Boolean;
    procedure AbilitazioniColonneI096;
    procedure I093TestExprSQL;
    function  GetI091Gruppo(CodI091:String):String;
  public
    I093EnabledInsert:Boolean;
    GruppoFiltroI091:String;
    ModuloIterAutorizzativi:Boolean; // lasciata public perchè referenziata ancora in WA181
    QI090:TOracleDataSet;
    QI091:TOracleDataSet;
    selI093:TOracleDataSet;
    selI095:TOracleDataSet;
    selI096:TOracleDataSet;
    RegistraLogSecondario:TRegistraLog;
    procedure QI091AfterDelete;
    procedure QI091AfterPost;
    procedure QI091BeforeDelete;
    procedure QI091BeforePost;
    procedure QI091CalcFields;
    procedure QI091FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure OpenSelI093;
    procedure OpenSelI094;
    procedure OpenSelI095(Azienda:String = '');
    procedure OpenSelI097;
    procedure selI093BeforePost;
    procedure selI093BeforeDelete;
    procedure selI093AfterOpen;
    procedure selI093AfterScroll;
    procedure selI093BeforeInsert;
    procedure selI093CalcFields;
    procedure selI095AfterOpen;
    procedure selI095AfterScroll;
    procedure selI095BeforeDelete;
    procedure selI095BeforeInsert;
    procedure selI095BeforePost;
    procedure selI095CalcFields;
    procedure selI095NewRecord;
    procedure selI096BeforeDelete;
    procedure selI096BeforeInsert;
    procedure selI096BeforePost;
    procedure selI096NewRecord;
    procedure CaricaCdsBloccoRiep;
    procedure JobArchiviazioneLOG;
    procedure AggiornaI095_I096(Azienda:String = ''); // lasciata public perchè referenziata  al momento in QI090AfterPost
    function Decod_Iter(InIter:String):String;
  end;

implementation

{$R *.dfm}

procedure TA181FAziendeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  I093EnabledInsert:=False;
  ModuloIterAutorizzativi:=False;
  ModuloIterAutorizzativiIter:=False;
  CaricaCdsBloccoRiep;
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

procedure TA181FAziendeMW.OpenSelI093;
var
  i:integer;
  DtsEdited:Boolean;
begin
  try
    selI093.DisableControls;
    R180SetVariable(selI093,'AZIENDA','%');
    selI093.Open;
    with TOracleDataSet.Create(Self) do
    begin
      Session:=SessioneOracle;
      SQL.Add('SELECT I090.AZIENDA FROM MONDOEDP.I090_ENTI I090 ORDER BY I090.AZIENDA');
      Open;
      DtsEdited:=False;
      while not Eof do
      begin
        for i:=Low(A000IterAutorizzativi) to High(A000IterAutorizzativi) do
          if not selI093.SearchRecord('AZIENDA;ITER',VarArrayOf([FieldByName('AZIENDA').AsString,A000IterAutorizzativi[i].Cod]),[srFromBeginning]) then
          begin
            I093EnabledInsert:=True;
            selI093.ReadOnly:=False;
            selI093.Insert;
            selI093.FieldByName('AZIENDA').AsString:=FieldByName('AZIENDA').AsString;
            selI093.FieldByName('ITER').AsString:=A000IterAutorizzativi[i].Cod;
            selI093.FieldByName('REVOCABILE').AsString:='N';
            selI093.Post;
            DtsEdited:=True;
          end;
        Next;
      end;
      I093EnabledInsert:=False;
      if DtsEdited then
      begin
        SessioneOracle.ApplyUpdates([selI093],True);
        selI093.ReadOnly:=True;
      end;
      Close;
      Free;
    end;
    R180SetVariable(selI093,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
    selI093.Open;
  finally
    selI093.EnableControls;
  end;
end;

procedure TA181FAziendeMW.OpenSelI094;
begin
  R180SetVariable(selI094,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
  selI094.Open;
end;

procedure TA181FAziendeMW.OpenSelI095(Azienda:String = '');
begin
  R180SetVariable(selI095,'AZIENDA',Azienda);
  selI095.Open;
end;

procedure TA181FAziendeMW.OpenSelI097;
begin
  R180SetVariable(selI097,'AZIENDA',QI090.FieldByName('AZIENDA').AsString);
  selI097.Open;
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

procedure TA181FAziendeMW.selI093AfterOpen;
begin
  //ModuloIterAutorizzativi:=A000ModuloAbilitato(SessioneOracle,'ITER_AUTORIZZATIVI',QI090.FieldByName('AZIENDA').AsString);
end;

procedure TA181FAziendeMW.selI093AfterScroll;
var
  GestAllegati: Boolean;
begin
  //Sempre abilitato per l'iter delle missioni
  ModuloIterAutorizzativiIter:=ModuloIterAutorizzativi or (selI093.FieldByName('ITER').AsString = ITER_MISSIONI);
  // gestione allegati: al momento solo per missioni e giustificativi
  GestAllegati:=R180In(selI093.FieldByName('ITER').AsString,[ITER_MISSIONI,ITER_GIUSTIF]);

  // interrompe disegno interfaccia
  selI095.DisableControls;
  selI094.DisableControls;
  selI093.DisableControls;
  selI096.DisableControls;

  try
    // tabella delle strutture
    selI095.Filtered:=False;
    selI095.Filter:='ITER = ''' + selI093.FieldByName('ITER').AsString + '''';
    selI095.Filtered:=True;
    selI095.FieldByName('CONDIZIONE_ALLEGATI').ReadOnly:=not GestAllegati;
    selI095.FieldByName('ALLEGATI_MODIFICABILI').ReadOnly:=not GestAllegati;

    // tabella I094
    selI094.Filtered:=False;
    selI094.Filter:='ITER = ''' + selI093.FieldByName('ITER').AsString + '''';
    selI094.Filtered:=True;

    // tabella iter
    selI093.FieldByName('REVOCABILE').ReadOnly:=selI093.FieldByName('ITER').AsString <> ITER_GIUSTIF;

    // tabella livelli
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Visible:=selI095.FieldByName('ITER').AsString = ITER_GIUSTIF;
    selI096.FieldByName('FASE').Visible:=R180In(selI095.FieldByName('ITER').AsString,[ITER_MISSIONI, ITER_STRMESE]);
    selI096.FieldByName('ALLEGATI_VISIBILI').ReadOnly:=not GestAllegati;
    selI096.FieldByName('ALLEGATI_OBBLIGATORI').ReadOnly:=not GestAllegati;
    AbilitazioniColonneI096;
  finally
    // riattiva disegno interfaccia
    selI095.EnableControls;
    selI094.EnableControls;
    selI093.EnableControls;
    selI096.EnableControls;
  end;
end;

procedure TA181FAziendeMW.selI093BeforeDelete;
begin
  Abort;
end;

procedure TA181FAziendeMW.selI093BeforeInsert;
begin
  if not I093EnabledInsert then
    Abort;
end;

procedure TA181FAziendeMW.I093TestExprSQL;
var
  TabIter,MsgErrore,Oggetto,Corpo:String;
  C018DM:TC018FIterAutDM;
  procedure EseguiTestMail(OQ:TOracleQuery; Campo:String);
  var Sez,Dest:String;
  begin
    if Pos('OGGETTO',Campo) > 0 then
      Sez:='l''Oggetto'
    else
      Sez:=' Corpo';
    if Pos('RESP',Campo) > 0 then
      Dest:='l''Autorizzatore'

    else
      Dest:='il Richiedente';
    OQ.SetVariable('OGGETTO',IfThen(Pos('OGGETTO',Campo) > 0,selI093.FieldByName(Campo).AsString,'null'));
    OQ.SetVariable('CORPO',IfThen(Pos('CORPO',Campo) > 0,selI093.FieldByName(Campo).AsString,'null'));
    OQ.SetVariable('TABELLA',C018DM.TabellaIter);
    with FindVariables(UpperCase(selI093.FieldByName(Campo).AsString), False) do
    try
      if OQ.VariableIndex('OPERAZIONE') >= 0 then
        OQ.DeleteVariable('OPERAZIONE');
      if IndexOf('OPERAZIONE') >= 0 then
        OQ.DeclareVariable('OPERAZIONE',otString);
    finally
      Free;
    end;
    try
      OQ.Execute;
    except
      on e:exception do
        raise Exception.CreateFmt('Errore sul%s della mail per %s : %s %s',[Sez,Dest,#13#10,e.Message]);
    end;
  end;
begin
  //Creazione del C018 per utilizzare effettivamente le query contenute in: selMailPerRichiedente e selMailPerAutorizzatore
  C018DM:=TC018FIterAutDM.Create(nil);
  with C018DM do
  try
    Iter:=Self.selI093.FieldByName('ITER').AsString;
    //Verifica script del richiedente
    if not Self.selI093.FieldByName('MAIL_OGGETTO_DIP').IsNull then
      //Oggetto:=Self.selI093.FieldByName('MAIL_OGGETTO_DIP').AsString;
      EseguiTestMail(selMailPerRichiedente,'MAIL_OGGETTO_DIP');
    if not Self.selI093.FieldByName('MAIL_CORPO_DIP').IsNull then
      EseguiTestMail(selMailPerRichiedente,'MAIL_CORPO_DIP');

    //Verifica script dell'autorizzatore
    if not Self.selI093.FieldByName('MAIL_OGGETTO_RESP').IsNull then
      EseguiTestMail(selMailPerAutorizzatore,'MAIL_OGGETTO_RESP');
    if not Self.selI093.FieldByName('MAIL_CORPO_RESP').IsNull then
      EseguiTestMail(selMailPerAutorizzatore,'MAIL_CORPO_RESP');
  finally
    FreeAndNil(C018DM);
  end;

  if not selI093.FieldByName('EXPR_PERIODO_VISUAL').IsNull then
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    SQL.Text:=Format('select %s from DUAL',[selI093.FieldByName('EXPR_PERIODO_VISUAL').AsString]);
    try
      Execute;
      if FieldType(0) <> otDate then
        raise Exception.Create('L''espressione deve restituire come primo valore una data valida.');
      if (FieldCount > 1) and (FieldType(1) <> otDate) then
        raise Exception.Create('L''espressione deve restituire come secondo valore una data valida.');
    except
      on e:Exception do
        raise Exception.CreateFmt('Errore nel periodo di visualizzazione: %s %s',[#13#10,E.Message]);
    end;
  finally
    Free;
  end;
end;

procedure TA181FAziendeMW.selI093BeforePost;
begin
  I093TestExprSQL;
  if (selI093.FieldByName('REVOCABILE').AsString <> 'S') and
     (selI093.FieldByName('REVOCABILE').AsString <> 'N') then
    raise Exception.Create('I valori permessi nel campo "revocabile" sono S o N.');
end;

procedure TA181FAziendeMW.selI093CalcFields;
begin
  selI093.FieldByName('D_ITER').AsString:=Decod_Iter(selI093.FieldByName('ITER').AsString);
  selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:='(vuoto)';
  if selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger = 1 then
    selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:='(1 elemento)'
  else if selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger > 0 then
    selI093.FieldByName('C_CHKDATI_ITER_AUT').AsString:=Format('(%d elementi)',[selI093.FieldByName('CHKDATI_ITER_AUT').AsInteger]);
end;

procedure TA181FAziendeMW.selI094ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  case Action of
  'I':begin
        RegistraLogSecondario.SettaProprieta('I','I094_CHKDATI_ITER_AUT','A008',Sender,True);
        RegistraLogSecondario.RegistraOperazione;
      end;
  'U':begin
        RegistraLogSecondario.SettaProprieta('M','I094_CHKDATI_ITER_AUT','A008',Sender,True);
        RegistraLogSecondario.RegistraOperazione;
      end;
  'D':begin
        RegistraLogSecondario.SettaProprieta('C','I094_CHKDATI_ITER_AUT','A008',Sender,True);
        RegistraLogSecondario.RegistraOperazione;
      end;
  end;
end;

procedure TA181FAziendeMW.selI094BeforePost(DataSet: TDataSet);
begin
  if selI094.FieldByName('RIEPILOGO').IsNull then
    Raise Exception.Create('Impossibile inserire NULL nel campo riepilogo.');
  if (selI094.FieldByName('STATO').AsString <> 'C') and
     (selI094.FieldByName('STATO').AsString <> 'A') then
    Raise Exception.Create('I valori permessi nel campo "Stato" sono C o A.');
end;

procedure TA181FAziendeMW.selI094NewRecord(DataSet: TDataSet);
begin
  selI094.FieldByName('AZIENDA').AsString:=selI093.FieldByName('AZIENDA').AsString;
  selI094.FieldByName('ITER').AsString:=selI093.FieldByName('ITER').AsString;
end;

procedure TA181FAziendeMW.selI095AfterOpen;
begin
  selI095.FieldByName('COD_ITER').ReadOnly:=not ModuloIterAutorizzativiIter;
  selI095.FieldByName('DESCRIZIONE').ReadOnly:=not ModuloIterAutorizzativiIter;
  selI095.FieldByName('FILTRO_RICHIESTA').Visible:=ModuloIterAutorizzativiIter;
  selI095.FieldByName('MAX_LIV_AUTORIZZ_AUTOMATICA').Visible:=ModuloIterAutorizzativiIter;
end;

procedure TA181FAziendeMW.selI095AfterScroll;
begin
  // interrompe disegno interfaccia
  selI097.DisableControls;
  selI096.DisableControls;

  try
    // tabella I097
    selI097.Filtered:=False;
    selI097.Filter:='(ITER = ''' + selI095.FieldByName('ITER').AsString + ''') AND ' +
                    '(COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + ''')';
    selI097.Filtered:=True;

    // tabella dei livelli
    selI096.Filtered:=False;
    selI096.Filter:=selI097.Filter;
    selI096.Filtered:=True;
  finally
    // riattiva disegno interfaccia
    selI097.EnableControls;
    selI096.EnableControls;
  end;
end;

procedure TA181FAziendeMW.selI095BeforeDelete;
begin
  if not ModuloIterAutorizzativiIter then
    Abort;
  //Controlli per delete
  with TOracleDataSet.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('SELECT COUNT(*) AS NREC');
    SQL.Add('  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075, MONDOEDP.I096_LIVELLI_ITER_AUT I096');
    SQL.Add(' WHERE I096.AZIENDA = ''' + selI095.FieldByName('AZIENDA').AsString + '''');
    SQL.Add('   AND I096.ITER = ''' + selI095.FieldByName('ITER').AsString + '''');
    SQL.Add('   AND I096.COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + '''');
    SQL.Add('   AND NVL(I075.ACCESSO,''N'') <> ''N''');
    SQL.Add('   AND I096.AZIENDA = I075.AZIENDA(+)');
    SQL.Add('   AND I096.ITER = I075.ITER(+)');
    SQL.Add('   AND I096.COD_ITER = I075.COD_ITER(+)');
    SQL.Add('   AND I096.LIVELLO = I075.LIVELLO(+)');
    Open;
    if FieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + selI095.FieldByName('AZIENDA').AsString +
                             ', ' + selI095.FieldByName('ITER').AsString +
                             ', ' + selI095.FieldByName('COD_ITER').AsString + '" è utilizzato da un profilo dipendente.');
    end;

    Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(*) AS NREC FROM ' + QI090.FieldByName('UTENTE').AsString + '.T850_ITER_RICHIESTE T850');
    SQL.Add(' WHERE T850.ITER = ''' + selI095.FieldByName('ITER').AsString + '''');
    SQL.Add('  AND T850.COD_ITER = ''' + selI095.FieldByName('COD_ITER').AsString + '''');
    Open;
    if fieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + Parametri.Username +
                             ', ' + selI095.FieldByName('ITER').AsString +
                             ', ' + selI095.FieldByName('COD_ITER').AsString + '" è utilizzato da un profilo dipendente.');
    end;
    Close;
    Free;
  end;
end;

procedure TA181FAziendeMW.selI095BeforeInsert;
begin
  if not ModuloIterAutorizzativiIter then
    Abort;
end;

procedure TA181FAziendeMW.selI095BeforePost;
begin
  if selI095.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').IsNull then
    selI095.FieldByName('MAX_LIV_AUTORIZZ_AUTOMATICA').AsInteger:=-1;

  if selI095.FieldByName('MAX_LIV_NOTE_MODIFICABILI').IsNull then
    selI095.FieldByName('MAX_LIV_NOTE_MODIFICABILI').AsInteger:=0;

  if Trim(selI095.FieldByName('COD_ITER').AsString) = '' then
    raise Exception.Create('Indicare il codice della struttura');

  if not R180In(selI095.FieldByName('FILTRO_INTERFACCIA').AsString,['S','N']) then
    raise Exception.Create('''Filtrabile'' può valere S o N');

  if not R180In(selI095.FieldByName('ALLEGATI_MODIFICABILI').AsString,['S','N']) then
    raise Exception.Create('''Allegati modif.'' può valere S o N');
end;

procedure TA181FAziendeMW.selI095CalcFields;
begin
  selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:='(vuoto)';
  if selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger = 1 then
    selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:='(1 elemento)'
  else if selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger > 0 then
    selI095.FieldByName('C_VALIDITA_ITER_AUT').AsString:=Format('(%d elementi)',[selI095.FieldByName('VALIDITA_ITER_AUT').AsInteger]);
end;

procedure TA181FAziendeMW.selI095NewRecord;
begin
  selI095.FieldByName('AZIENDA').asString:=selI093.FieldByName('AZIENDA').asString;
  selI095.FieldByName('ITER').asString:=selI093.FieldByName('ITER').asString;
end;

procedure TA181FAziendeMW.selI096BeforeDelete;
begin
 if not ModuloIterAutorizzativiIter then
    Abort;
  with TOracleDataSet.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('SELECT COUNT(*) AS NREC');
    SQL.Add('  FROM MONDOEDP.I075_ITER_AUTORIZZATIVI I075');
    SQL.Add(' WHERE I075.AZIENDA = ''' + selI096.FieldByName('AZIENDA').AsString + '''');
    SQL.Add('   AND I075.ITER = ''' + selI096.FieldByName('ITER').AsString + '''');
    SQL.Add('   AND I075.COD_ITER = ''' + selI096.FieldByName('COD_ITER').AsString + '''');
    SQL.Add('   AND I075.LIVELLO = ''' + selI096.FieldByName('LIVELLO').AsString + '''');
    SQL.Add('   AND I075.ACCESSO <> ''N''');
    Open;
    if fieldByName('NREC').AsInteger > 0 then
    begin
      Close;
      Free;
      raise Exception.Create('Impossibile cancellare l''Iter "' + selI096.FieldByName('AZIENDA').AsString +
                             ', ' + selI096.FieldByName('ITER').AsString +
                             ', ' + selI096.FieldByName('COD_ITER').AsString +
                             ', ' + selI096.FieldByName('LIVELLO').AsString + '" è utilizzato da un profilo dipendente.');
    end;
  end;
  if selI096.FieldByName('LIVELLO').AsInteger = 1 then
    Abort;
end;

procedure TA181FAziendeMW.selI096BeforeInsert;
begin
  if not ModuloIterAutorizzativiIter then
  begin
    if selI096.FieldByName('ITER').AsString <> ITER_CARTELLINO then
      Raise Exception.Create('Impossibile inserire più di un livello per l''iter "' +
                             Decod_Iter(selI096.FieldByName('ITER').AsString) +
                             '", se il modulo Iter Autorizzativi è disabilitato.')
    else if selI096.RecordCount >= 2 then
      Raise Exception.Create('Impossibile inserire più di due livelli per l''iter "' +
                             Decod_Iter(selI096.FieldByName('ITER').AsString) +
                             '", se il modulo Iter Autorizzativi è disabilitato.');
  end;
end;

procedure TA181FAziendeMW.selI096BeforePost;
var
  ValPossibili:TArrString;
  i:Integer;
begin
  //Controlli campo OBBLIGATORIO I096
  if (selI096.State = dsEdit) and (selI096.FieldByName('LIVELLO').medpOldValue <> selI096.FieldByName('LIVELLO').Value) then
  begin
    selI096.FieldByName('LIVELLO').Value:=selI096.FieldByName('LIVELLO').medpOldValue;
    raise Exception.Create('Impossibile modificare!'#13#10'Livello è un campo chiave.');
  end;
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') and selI096.FieldByName('VALORI_POSSIBILI').IsNull then
    selI096.FieldByName('VALORI_POSSIBILI').AsString:='S';
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') then
  begin
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Clear;
    selI096.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').Clear;
  end;
  if selI096.FieldByName('OBBLIGATORIO').AsString = 'S' then
    selI096.FieldByName('AVVISO').AsString:='N';
  if not(R180CarattereDef(selI096.FieldByName('OBBLIGATORIO').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Obbligatorio" sono S o N.');
  if not(R180CarattereDef(selI096.FieldByName('DATI_MODIFICABILI').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Dati modificabili" sono S o N.');
  if (selI096.FieldByName('OBBLIGATORIO').AsString = 'N') and not(R180CarattereDef(selI096.FieldByName('AVVISO').AsString) in ['S','N']) then
    raise Exception.Create('I valori permessi nel campo "Avviso" sono S o N.');
  if selI096.FieldByName('AUTORIZZ_INTERMEDIA').IsNull and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'S,N') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'N,S') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'S') and
     (selI096.FieldByName('VALORI_POSSIBILI').AsString <> 'N') then
    raise Exception.Create('Se "Autorizz. intermedia" è nulla, "Valori possibili" può contenere solo S o N.');
  ValPossibili:=R180SplittaArray(selI096.FieldByName('VALORI_POSSIBILI').AsString,',');
  for i:=Low(ValPossibili) to High(ValPossibili) do
    if Length(ValPossibili[i]) > 1 then
      raise Exception.Create(ValPossibili[i] + ': più lungo di un carattere.');
  SetLength(ValPossibili,0);
  if selI096.FieldByName('ITER').AsString = ITER_GIUSTIF then
  begin
    if (not selI096.FieldByName('AUTORIZZ_INTERMEDIA').IsNull) and
       ((selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString = 'N') or
        (selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString <> StringReplace(StringReplace(selI096.FieldByName('VALORI_POSSIBILI').AsString,',N','',[]),'N,','',[]))) then
      raise Exception.Create('Il valore di "Autorizz. intermedia" può essere solo ' + StringReplace(StringReplace(selI096.FieldByName('VALORI_POSSIBILI').AsString,',N','',[]),'N,','',[]));
  end
  else
    selI096.FieldByName('AUTORIZZ_INTERMEDIA').Clear;
  if (selI096.FieldByName('INVIO_EMAIL').AsString <> 'N') and (selI096.FieldByName('INVIO_EMAIL').AsString <> 'A') and
     (selI096.FieldByName('INVIO_EMAIL').AsString <> 'R') and (selI096.FieldByName('INVIO_EMAIL').AsString <> 'E') then
    raise Exception.Create('Il valore del dato Invio e-mail non è consentito: "' + selI096.FieldByName('INVIO_EMAIL').AsString + '".');
  if (selI096.FieldByName('ALLEGATI_OBBLIGATORI').AsString <> 'S') and
     (selI096.FieldByName('ALLEGATI_OBBLIGATORI').AsString <> 'N') then
    raise Exception.Create(Format('I valori permessi nel campo "%s" sono S o N.',[selI096.FieldByName('ALLEGATI_OBBLIGATORI').DisplayLabel]));
  if (selI096.FieldByName('ALLEGATI_VISIBILI').AsString <> 'S') and
     (selI096.FieldByName('ALLEGATI_VISIBILI').AsString <> 'N') then
    raise Exception.Create(Format('I valori permessi nel campo "%s" sono S o N.',[selI096.FieldByName('ALLEGATI_VISIBILI').DisplayLabel]));
end;

procedure TA181FAziendeMW.selI096NewRecord;
begin
  selI096.FieldByName('AZIENDA').AsString:=selI095.FieldByName('AZIENDA').AsString;
  selI096.FieldByName('ITER').AsString:=selI095.FieldByName('ITER').AsString;
  selI096.FieldByName('COD_ITER').AsString:=selI095.FieldByName('COD_ITER').AsString;
  selI096.FieldByName('LIVELLO').AsInteger:=1;
  selI096.FieldByName('OBBLIGATORIO').AsString:='S';
  selI096.FieldByName('AVVISO').AsString:='N';
  selI096.FieldByName('VALORI_POSSIBILI').AsString:='S,N';
  selI096.FieldByName('DATI_MODIFICABILI').AsString:='N';
  selI096.FieldByName('AUTORIZZ_INTERMEDIA').AsString:='';
  selI096.FieldByName('INVIO_EMAIL').AsString:='N';
end;

procedure TA181FAziendeMW.selI097ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  case Action of
  'I':begin
        RegistraLogSecondario.SettaProprieta('I','I097_VALIDITA_ITER_AUT','A008',Sender,True);
        RegistraLogSecondario.RegistraOperazione;
      end;
  'U':begin
        RegistraLogSecondario.SettaProprieta('M','I097_VALIDITA_ITER_AUT','A008',Sender,True);
        RegistraLogSecondario.RegistraOperazione;
      end;
  'D':begin
        RegistraLogSecondario.SettaProprieta('C','I097_VALIDITA_ITER_AUT','A008',Sender,True);
        RegistraLogSecondario.RegistraOperazione;
      end;
  end;
end;

procedure TA181FAziendeMW.selI097BeforePost(DataSet: TDataSet);
begin
  inherited;
  if (selI097.FieldByName('BLOCCANTE').AsString <> 'S') and (selI097.FieldByName('BLOCCANTE').AsString <> 'N') then
  raise Exception.Create('I valori permessi nel campo "bloccante" sono S o N.');
end;

procedure TA181FAziendeMW.selI097NewRecord(DataSet: TDataSet);
begin
  inherited;
  selI097.FieldByName('AZIENDA').AsString:=selI095.FieldByName('AZIENDA').AsString;
  selI097.FieldByName('ITER').AsString:=selI095.FieldByName('ITER').AsString;
  selI097.FieldByName('COD_ITER').AsString:=selI095.FieldByName('COD_ITER').AsString;
  selI097.FieldByName('NUM_CONDIZ').AsInteger:=-1;
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

procedure TA181FAziendeMW.AggiornaI095_I096(Azienda:String = '');
{Aggiornamento iniziale delle funzioni disponibili}
var i:integer;
    TempSelI090:TOracleDataSet;
    TempModuloIterAutorizzativi:Boolean;
begin
  TempModuloIterAutorizzativi:=ModuloIterAutorizzativiIter;
  ModuloIterAutorizzativi:=True;
  TempSelI090:=TOracleDataSet.Create(Self);
  TempSelI090.Session:=SessioneOracle;
  TempSelI090.SQL.Add('SELECT I090.*');
  TempSelI090.SQL.Add('FROM MONDOEDP.I090_ENTI I090');
  if Azienda <> '' then
    TempSelI090.SQL.Add('WHERE I090.AZIENDA = ''' + Azienda + '''');
  TempSelI090.SQL.Add('ORDER BY AZIENDA');
  TempSelI090.Open;
  TempSelI090.First;
  selI095.Filtered:=False;
  while not TempSelI090.Eof do
  begin
    //selI095
    OpenSelI095(TempSelI090.FieldByName('AZIENDA').AsString);
    for i:=Low(A000IterAutorizzativi) to High(A000IterAutorizzativi) do
      if VarToStr(selI095.Lookup('ITER',A000IterAutorizzativi[i].Cod,'ITER')) = '' then
      begin
        selI095.Insert;
        selI095.FieldByName('AZIENDA').AsString:=TempSelI090.FieldByName('AZIENDA').AsString;
        selI095.FieldByName('ITER').AsString:=A000IterAutorizzativi[i].Cod;
        selI095.FieldByName('COD_ITER').AsString:='DEFAULT';
        selI095.Post;
      end;
    SessioneOracle.ApplyUpdates([selI095],True);
    if Azienda <> '' then
      Break;
    TempSelI090.Next;
  end;
  selI095.Filtered:=True;
  selI095.Refresh;
  //selI096
  with TOracleQuery.Create(Self) do
  begin
    Session:=SessioneOracle;
    SQL.Add('INSERT INTO MONDOEDP.I096_LIVELLI_ITER_AUT ');
    SQL.Add('(AZIENDA, ITER, COD_ITER, LIVELLO, OBBLIGATORIO, AVVISO, VALORI_POSSIBILI, DATI_MODIFICABILI, INVIO_EMAIL) ');
    SQL.Add('SELECT AZIENDA,ITER,COD_ITER,1,''S'',''N'',''S,N'',''N'',''N''');
    SQL.Add('FROM(SELECT AZIENDA,ITER,COD_ITER FROM MONDOEDP.I095_ITER_AUT MINUS ');
    SQL.Add('SELECT AZIENDA,ITER,COD_ITER FROM MONDOEDP.I096_LIVELLI_ITER_AUT)');
    Execute;
    Free;
  end;
  SessioneOracle.Commit;
  selI096.Refresh;
  TempSelI090.Close;
  FreeAndNil(TempSelI090);
  ModuloIterAutorizzativiIter:=TempModuloIterAutorizzativi;
end;

procedure TA181FAziendeMW.CaricaCdsBloccoRiep;
var i:integer;
begin
  for i:=0 to High(lstRiepiloghi) do
  begin
    cdsBloccoRiep.Insert;
    cdsBloccoRiep.FieldByName('CODICE').AsString:=Trim(Copy(lstRiepiloghi[i],1,6));
    cdsBloccoRiep.FieldByName('DESCRIZIONE').AsString:=Copy(lstRiepiloghi[i],1,Length(lstRiepiloghi[i]));
    cdsBloccoRiep.Post;
  end;
  cdsBloccoRiep.IndexDefs.Add('INDICE1','CODICE',[]);
  cdsBloccoRiep.IndexName:='INDICE1';
end;

procedure TA181FAziendeMW.AbilitazioniColonneI096;
var AbilitaI096:Boolean;
begin
  //Gestione abilitazioone colonne I096
  AbilitaI096:=ModuloIterAutorizzativi or (selI096.FieldByName('ITER').AsString = ITER_CARTELLINO);
  selI096.FieldByName('LIVELLO').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('DESC_LIVELLO').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('FASE').ReadOnly:=not AbilitaI096;
  selI096.FieldByName('OBBLIGATORIO').Visible:=AbilitaI096;
  selI096.FieldByName('AVVISO').Visible:=AbilitaI096;
  selI096.FieldByName('VALORI_POSSIBILI').Visible:=AbilitaI096;
  selI096.FieldByName('AUTORIZZ_INTERMEDIA').Visible:=AbilitaI096;
  selI096.FieldByName('SCRIPT_AUTORIZZ').Visible:=AbilitaI096;
  selI096.FieldByName('CONDIZ_AUTORIZZ_AUTOMATICA').Visible:=AbilitaI096;
  selI096.FieldByName('ALLEGATI_VISIBILI').Visible:=AbilitaI096;
  selI096.FieldByName('ALLEGATI_OBBLIGATORI').Visible:=AbilitaI096;
end;

end.
