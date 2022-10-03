unit A023UTimbratureMW;

interface

uses
  Controls,
  C018UIterAutDM, C017UEMailDtM, A000UCostanti, R005UDataModuleMW,
  C180FunzioniGenerali, DatiBloccati, RegistrazioneLog, Math,
  DB, OracleData, Oracle,
  SysUtils, Variants, Classes, ComCtrls, StrUtils, R500Lin, Rp502Pro,
  A000USessione, R600, A000UMessaggi, W000UMessaggi, A023UAllTimbMW,
  DBClient, A000UGestioneTimbraGiustMW, medpBackupOldValue;

type
  TOnFieldChange = procedure(Sender: TField) of object;
  TGestGiustif = function:String of object;

  TConteggiGiorno = record
    OreLavorate: String;
    Scostamento: String;
    Debito: String;
    EscluseDaNorm: String;
    OrarioFontNero: Boolean;
    Orario: String;
    TurniFontNero: Boolean;
    Turni: String;
    TurniDaConteggio: Boolean;
    Repaint: Boolean;
    Blocca: Boolean;
  end;

  TControlloAssenza = record
    Progressivo:Integer;
    Data, DataNas: TDateTime;
    OldGiustif,NewGiustif: TGiustificativo;
  end;
  // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
  TTipoRilevatore = (trPresenza, trMensa);
  // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini

  TA023FTimbratureMW = class(TR005FDataModuleMW)
    selT100_T370: TOracleDataSet;
    selT105: TOracleDataSet;
    selT105PROGRESSIVO: TIntegerField;
    selT105NOMINATIVO: TStringField;
    selT105MATRICOLA: TStringField;
    selT105AUTORIZZAZIONE: TStringField;
    selT105OPERAZIONE: TStringField;
    selT105DATA: TDateTimeField;
    selT105VERSO: TStringField;
    selT105VERSO_ORIG: TStringField;
    selT105ORA: TStringField;
    selT105CAUSALE: TStringField;
    selT105CAUSALE_UTILE: TStringField;
    selT105CAUSALE_ORIG: TStringField;
    selT105RILEVATORE_RICH: TStringField;
    selT105NOTE1: TStringField;
    selT105NOMINATIVO_RESP: TStringField;
    selT105ELABORATO: TStringField;
    selT105COD_ITER: TStringField;
    selT105ID: TFloatField;
    insUpdT100_T370: TOracleQuery;
    updT100_T370: TOracleQuery;
    insT100_T370: TOracleQuery;
    delT100_T370: TOracleQuery;
    insT280: TOracleQuery;
    GetCalend: TOracleQuery;
    Q040: TOracleDataSet;
    Q080: TOracleDataSet;
    Q100: TOracleDataSet;
    Q100PROGRESSIVO: TFloatField;
    Q100DATA: TDateTimeField;
    Q100ORA: TDateTimeField;
    Q100VERSO: TStringField;
    Q100FLAG: TStringField;
    Q100RILEVATORE: TStringField;
    Q100CAUSALE: TStringField;
    D100: TDataSource;
    selT320: TOracleDataSet;
    Q265: TOracleDataSet;
    Q031_1: TOracleDataSet;
    D265: TDataSource;
    Q275: TOracleDataSet;
    D275: TDataSource;
    Q305: TOracleDataSet;
    Q361: TOracleDataSet;
    D361: TDataSource;
    D305: TDataSource;
    PeriodiAssenza: TOracleQuery;
    Q031: TOracleDataSet;
    Q101: TOracleDataSet;
    Q101PROGRESSIVO: TFloatField;
    Q101DATA: TDateTimeField;
    Q101LIVELLO: TFloatField;
    Q101ANOMALIA: TStringField;
    selT100: TOracleDataSet;
    FloatField1: TFloatField;
    DateTimeField1: TDateTimeField;
    DateTimeField2: TDateTimeField;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    Q101Delete: TOracleQuery;
    selT100Ripristino: TOracleDataSet;
    StringField6: TStringField;
    FloatField2: TFloatField;
    DateTimeField3: TDateTimeField;
    StringField5: TStringField;
    DateTimeField4: TDateTimeField;
    StringField7: TStringField;
    StringField8: TStringField;
    selT100RipristinoID_RICHIESTA: TFloatField;
    selT100RipristinoD_WEB: TStringField;
    dscT100Ripristino: TDataSource;
    cdsT100RiprSim: TClientDataSet;
    cdsT100RiprSimFLAG: TStringField;
    cdsT100RiprSimPROGRESSIVO: TFloatField;
    cdsT100RiprSimDATA: TDateTimeField;
    cdsT100RiprSimORA: TDateTimeField;
    cdsT100RiprSimVERSO: TStringField;
    cdsT100RiprSimRILEVATORE: TStringField;
    cdsT100RiprSimCAUSALE: TStringField;
    cdsT100RiprSimID_RICHIESTA: TFloatField;
    cdsT100RiprSimD_WEB: TStringField;
    cdsT100RiprSimFLAG_SIM: TStringField;
    cdsT100RiprSimVIS_SIM: TStringField;
    dscT100RiprSim: TDataSource;
    Q100Delete: TOracleQuery;
    Q100Update: TOracleQuery;
    EliminaTimbriDoppi: TOracleQuery;
    selT105RILEVATORE_ORIG: TStringField;
    selT361: TOracleDataSet;
    T230F_GETVALUE: TOracleQuery;
    procedure selT105CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure Q040AfterPost(DataSet: TDataSet);
    procedure Q040BeforeDelete(DataSet: TDataSet);
    procedure Q040PostError(DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
    procedure Q100ORAGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure Q100ORASetText(Sender: TField; const Text: string);
    procedure Q100RILEVATOREChange(Sender: TField);
    procedure Q100AfterDelete(DataSet: TDataSet);
    procedure Q100AfterPost(DataSet: TDataSet);
    procedure Q100BeforeDelete(DataSet: TDataSet);
    procedure Q100BeforePost(DataSet: TDataSet);
    procedure Q100NewRecord(DataSet: TDataSet);
    procedure Q265AfterOpen(DataSet: TDataSet);
    procedure Q265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Q275AfterOpen(DataSet: TDataSet);
    procedure Q275FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure Q305AfterOpen(DataSet: TDataSet);
    procedure selT100Ora(Sender: TField; const Text: string);
    procedure DateTimeField4SetText(Sender: TField; const Text: string);
    procedure Q361FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    AcquisizioneWebInCorso: Boolean;
    tmpLstAnomalieGiorno: TStringList;
    C018DM: TC018FIterAutDM;
    FOnRilevatoreChange : TOnFieldChange;
    m_tab_timbrature_vuoto:t_ttimbraturedipmese;
    m_tab_giustificativi_vuoto:t_tgiustificdipmese;
    Q100OldValues:TmedpBackupOldValue;
    procedure InviaEMail(Responsabile:Boolean; P:Integer; Testo:String);
    procedure AzzeraTabelle;
    procedure CreaUpdT040;
  public
    selT030:TOracleDataSet;
    UpdT040:TOracleQuery;
    selDatiBloccati: TDatiBloccati;
    MaxGiorni: Word;
    //ProgressBar: TProgressBar;
    R502ProDtM1: TR502ProDtM1;
    FPianif:Array[1..31] of Boolean;
    R600DtM1:TR600DtM1;
    getDataGestGiustif: TGestGiustif;
    getCausaleGestGiustif: TGestGiustif;
    Elaborato: String;
    A000FGestioneTimbraGiustMW: TA000FGestioneTimbraGiustMW;
    procedure OpenSelT030(Prog: Integer);
    procedure ValidaAssenza(DataDa, DataA: TDateTime; Prog: Integer; Caus: String);
    property OnRilevatoreChange : TOnFieldChange read FOnRilevatoreChange write FOnRilevatoreChange;
    procedure CaricaMese(Anno, Mese: Integer; bCalc: Boolean);
    function DescrizioneCausale(Causale: String): String;
    procedure selSG101FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure ImpostaProgressivoSG101;
    function  GetValStrT230(Causale,Nome:String; Data:TDateTime):String;
    function  VerificaCausaleTipoGiust(TipoCausale: Word; DataGiust: TDateTime;TipoGiust, Causale, CausOrig: String; bFamiliareSelezionato: Boolean; var DaOre,AOre: String): String;
    procedure CaricaTimbratureGiustificativi;
    procedure AllineamentoTimbrature(Giorno: TDateTime);
    function TestoTurno(Data: TDateTime): String;
    procedure AggDataControllo(Data: TDateTime);
    procedure SetProgOperAnomale;
    procedure CreaDataSetSimulazione;
    procedure SimulaRipristino(RipristinaOrig, CancManuali,CancIterWeb: boolean);
    procedure AggiornaTabella(DataInizio, DataFine: TDateTime; OperazioniSelezionate, RipristinaOrig, CancManuali, CancIterWeb: boolean);
    procedure EseguiRipristino(DataInizio, DataFine: TDateTime; RipristinaOrig,CancManuali, CancIterWeb: Boolean);
    function DatoBloccato(Data: TDateTime): Boolean;
    procedure AllineamentoTimbraturePeriodo(DataI, DataF: TDateTime);
    procedure EliminaTimbratureDoppie(Tutti: Boolean; Inizio, Fine: TDateTime);
    procedure ImpostaQ031;
    procedure InizializzaAcquisizioneWeb (PSingola: Boolean);
    procedure FinalizzaAcquisizioneWeb;
    function  AcquisizioneRichiesteAuto(lstId:String; var Msg:String; var NumScartate,NumRichieste:Integer):Boolean;
    procedure ImportaRichiesta;
    function TrovaAssenzeDaValidare(Giorno: Integer): String;
    function ConfermaModifica(TipoCausale: Integer; Data, NewDataNas,
      OldDataNas: TDateTime; OldGiustif, NewGiustif: TGiustificativo;
      TipoGiust: Char; ProgCausOrig: Integer; OldValidata: String;
      NumGiustificativo: Integer; var L133GGModif: Boolean): Boolean;
    function ControlloAssenze(Assenza: TControlloAssenza; var CausAss:String):Boolean;
    function ConteggiGiornalieri(Giorno: TDateTime): TConteggiGiorno;
    function getLstAnomalieConteggiGiornalieri: TStringList;
  end;

implementation

uses A000UInterfaccia;

{$R *.dfm}

procedure TA023FTimbratureMW.DataModuleCreate(Sender: TObject);
begin
 try
  inherited;
  MaxGiorni:=31;
  A000FGestioneTimbraGiustMW:=TA000FGestioneTimbraGiustMW.Create(Self);
  A000FGestioneTimbraGiustMW.QGiustificativi:=Q040;
  A000FGestioneTimbraGiustMW.QTimbrature:=Q100;

  tmpLstAnomalieGiorno:=TStringList.Create();
  selT030:=TOracleDataSet.Create(nil);
  selT030.Session:=SessioneOracle;
  CreaUpdT040;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='';
  R502ProDtM1:=TR502ProDtM1.Create(nil);
  R502ProDtM1.FiltroDizionarioAnomalie:=True;
  Q265.Open;
  Q275.Open;
  Q305.Open;
  Q361.Open;
  // dataset di supporto per lookup rilevatori
  selT361.Open;
  Q100OldValues:=TmedpBackupOldValue.Create(Q100,Q100);
 except
 end;
end;

procedure TA023FTimbratureMW.DataModuleDestroy(Sender: TObject);
begin
 try
  FreeAndNil(A000FGestioneTimbraGiustMW);
  FreeAndNil(SelT030);
  FreeAndNil(UpdT040);
  FreeAndNil(selDatiBloccati);
  FreeAndNil(R502ProDtM1);
  FreeAndNil(tmpLstAnomalieGiorno);
  FreeAndNil(Q100OldValues);
  inherited;
 except
 end;
end;

procedure TA023FTimbratureMW.CreaUpdT040;
begin
  UpdT040:=TOracleQuery.Create(nil);
  UpdT040.Session:=SessioneOracle;
  UpdT040.SQL.Add('UPDATE T040_GIUSTIFICATIVI T040');
  UpdT040.SQL.Add('SET T040.SCHEDA = ''V''');
  UpdT040.SQL.Add('WHERE T040.PROGRESSIVO = :PROG AND T040.DATA = :DATA AND T040.CAUSALE  = :CAUS');
  UpdT040.DeclareVariable('PROG',otInteger);
  UpdT040.DeclareVariable('DATA',otDate);
  UpdT040.DeclareVariable('CAUS',otString);
end;

procedure TA023FTimbratureMW.DateTimeField4SetText(Sender: TField;
  const Text: string);
begin
  {$I CampoOra}
end;

//############################################//
//###      IMPORTAZIONE TIMBRATURE WEB     ###//
//############################################//
procedure TA023FTimbratureMW.InviaEMail(Responsabile:Boolean; P:Integer; Testo:String);
var C017FEMailDtM:TC017FEMailDtM;
begin
  C017FEMailDtM:=TC017FEMailDtM.Create(nil);
  try
    C017FEMailDtM.InviaEMail(SessioneOracle,Responsabile,P,Testo,'',418);
  finally
    C017FEMailDtM.Free;
  end;
end;

procedure TA023FTimbratureMW.Q040AfterPost(DataSet: TDataSet);
begin
  inherited;
  RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  RegistraLog.RegistraOperazione;
end;

procedure TA023FTimbratureMW.Q040BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
  RegistraLog.RegistraOperazione;
end;

procedure TA023FTimbratureMW.Q040PostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
{Gestisco il progressivo dei giustificativi}
begin
  DataSet.FieldByName('ProgrCausale').AsInteger:=Q040.FieldByName('ProgrCausale').AsInteger + 1;
  Action:=daRetry;
end;

procedure TA023FTimbratureMW.Q100AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA023FTimbratureMW.Q100AfterPost(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA023FTimbratureMW.Q100BeforeDelete(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);
end;

procedure TA023FTimbratureMW.Q100BeforePost(DataSet: TDataSet);
var Op:String;
begin
  if DataSet.State = dsEdit then
    if Q100Flag.AsString = 'C' then
    begin
      Op:='C';
    end
    else
    begin
      Op:='M';
      //Timbratura Originale -> Manuale: Gestione OldValues quando il dataset è in inserimento ma deve loggare le modifiche rispetto al record precedente
      Q100OldValues.CreaStruttura;
      Q100OldValues.Aggiorna;
    end;
  if DataSet.State = dsInsert then
    if A000FGestioneTimbraGiustMW.StatoTimb = stInserimento then
      Op:='I'
    else
      Op:='M';
  RegistraLog.SettaProprieta(Op,R180Query2NomeTabella(DataSet),NomeOwner,DataSet,True);

  //Timbratura Originale -> Manuale: Al termine del log, resetto Q100OldValues
  if (DataSet.State = dsInsert) and (Op = 'M') then
    Q100OldValues.Reimposta;
end;

procedure TA023FTimbratureMW.Q100NewRecord(DataSet: TDataSet);
begin
  Q100.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  if A000FGestioneTimbraGiustMW.EU in ['E','U'] then
    //Inverto il verso rispetto alla precedente timbratura
  begin
    if A000FGestioneTimbraGiustMW.EU = 'E' then
      Q100.FieldByName('Verso').AsString:='U'
    else
      Q100.FieldByName('Verso').AsString:='E';
    end
  else
    Q100.FieldByName('Verso').AsString:='E';
  Q100.FieldByName('Flag').AsString:='I';
end;

procedure TA023FTimbratureMW.Q100ORAGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text:=IfThen(Sender.IsNull,'',FormatDateTime('hh:nn',Sender.AsDateTime));
end;

procedure TA023FTimbratureMW.Q100ORASetText(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TA023FTimbratureMW.Q100RILEVATOREChange(Sender: TField);
begin
  if Assigned(FOnRilevatoreChange) then
    FOnRilevatoreChange(Sender);
end;

procedure TA023FTimbratureMW.Q265AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA023FTimbratureMW.Q265FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString)
end;

procedure TA023FTimbratureMW.Q275AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA023FTimbratureMW.Q275FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CAUSALI PRESENZA',DataSet.FieldByName('CODICE').AsString);
end;

procedure TA023FTimbratureMW.Q305AfterOpen(DataSet: TDataSet);
begin
  DataSet.FieldByName('CODICE').DisplayWidth:=8;
end;

procedure TA023FTimbratureMW.Q361FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('OROLOGI DI TIMBRATURA',Q361.FieldByName('CODICE').AsString);
end;

function TA023FTimbratureMW.AcquisizioneRichiesteAuto(lstId:String; var Msg:String; var NumScartate,NumRichieste:Integer):Boolean;
begin
  Result:=True;
  Msg:='';
  if Parametri.CampiRiferimento.C90_W018AcquisizioneAuto <> 'S' then
    exit;
  // imposto un C700SelAnagrafe fittizio
  // e filtrando le richieste solo per ID
  // nota: il dataset viene ora filtrato in base al proprio filtro dizionario
  //       questa modifica non dovrebbe causare effetti collaterali per cui si mantiene
  //       il filtro del dataset
  selT105.Close;
  selT105.SetVariable('C700SELANAGRAFE','t030_anagrafico t030 where 1=1');
  selT105.SetVariable('FILTRO_RICHIESTE',Format('and t105.id in (%s)',[lstId]));
  selT105.SetVariable('FILTRO_MODALITA',null);
  selT105.SetVariable('FILTRO_PERIODO',null);
  selT105.Open;
  NumRichieste:=selT105.RecordCount;
  if NumRichieste = 0 then
  begin
    Result:=False;
    Msg:=A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE);
    Exit;
  end;

  // elaborazione massiva delle richieste
  NumScartate:=0;
  try
    try
      RegistraMsg.IniziaMessaggio('W018');
      InizializzaAcquisizioneWeb(False);
      while not selT105.Eof do
      begin
        ImportaRichiesta;
        if Elaborato = 'E' then
          Result:=False;
        selT105.Next;
      end;
      selT105.Refresh;
    finally
      FinalizzaAcquisizioneWeb;
    end;
  except
    on E:Exception do
    begin
      Result:=False;
      Msg:=E.Message;
    end;
  end;

  // messaggio di fine elaborazione
  if Result then
  begin
    // elaborazione ok / warning
    if Msg = '' then
      Msg:=A000TraduzioneStringhe(A000MSG_MSG_ELAB_OK)
    else
      Msg:=Format(A000TraduzioneStringhe(A000MSG_MSG_ELAB_WARNING),[Msg]);

    if NumScartate > 0 then
      Msg:=Msg + CRLF + A000TraduzioneStringhe(A000MSG_W018_MSG_RICH_GIA_IMPORTATE);
  end
  else
  begin
    // anomalie durante elaborazione
    Msg:=A000TraduzioneStringhe(A000MSG_MSG_ELAB_ERRORE) + CRLF +
         A000TraduzioneStringhe(A000MSG_W018_MSG_CONSULTA_NOTIFICHE_ELAB);
  end;
end;

procedure TA023FTimbratureMW.ImportaRichiesta;
// esegue l'importazione della richiesta
var
  TestoSql,LogMsg,Note,NomeResp,StrMsg:String;
  Progressivo, Id: Integer;
  Data: TDateTime;
  DataStr,Ora,Verso,Causale,Rilevatore,RilevatoreOrig,
  Autorizzazione,Operazione,OperazioneDesc,VersoOrig,
  CausaleOrig,Matricola,Nominativo,Responsabile,
  FunzioneRilevatore,FunzioneRilevatoreDesc,CausMensa: String;
  VersoModificato,CausaleModificata,FlagOrigInvariato,DatiBloccati,RilevatoreIndicato: Boolean;
  function ConvErrSQL(const InErr:String):String;
  begin
    Result:=InErr;
    if pos('ORA-00001:',InErr) > 0 then
      Result:='Timbratura già inserita.';
  end;
  procedure CommitRichiesta;
  begin
    try
      insT280.SetVariable('LOG',LogMsg);
      insT280.Execute;
      selT105.Refreshrecord;
      selT105.Edit;
      selT105.FieldByName('ELABORATO').AsString:=Elaborato;
      selT105.Post;
      SessioneOracle.Commit;

      if Parametri.CampiRiferimento.C90_EMailW018Uff = 'I' then
      begin
        //mail configurata sull'iter per il richiedente
        C018DM.MailPerRichiedente(C018DM.LivMaxAutNeg);
      end
      else if Parametri.CampiRiferimento.C90_EMailW018Uff = 'S' then
      begin
        //mail generica
        InviaEMail(False,Progressivo,Format('Elaborazione omessa timbratura: %s (%s)',[Nominativo, Matricola]));
      end;
    except
    end;
  end;
  procedure GestioneInserimento(const PTipoRilevatore: TTipoRilevatore);
  // inserimento della timbratura effettiva in base al tipo rilevatore (presenza / mensa)
  var
    LTabella: String;
  begin
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    if PTipoRilevatore = trPresenza then
    begin
      LTabella:='T100_TIMBRATURE';
    end
    else
    begin
      LTabella:='T370_TIMBMENSA';
    end;
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine

    // prepara inserimento timbratura
    with insT100_T370 do
    begin
      SetVariable('TABELLA',LTabella); // MONDOEDP - commessa MAN/02 SVILUPPO#112
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DATA',Data);
      SetVariable('ORA',Ora);
      SetVariable('VERSO',Verso);
      SetVariable('CAUSALE',Causale);
      SetVariable('RILEVATORE',Rilevatore);
      SetVariable('ID_RICHIESTA',Id);
    end;

    // log inserimento
    RegistraLog.SettaProprieta('I',LTabella,NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Progressivo));
    RegistraLog.InserisciDato('DATA','',DataStr);
    RegistraLog.InserisciDato('ORA','',Ora);
    RegistraLog.InserisciDato('VERSO','',Verso);
    RegistraLog.InserisciDato('CAUSALE','',Causale);
    RegistraLog.InserisciDato('RILEVATORE','',Rilevatore);
    RegistraLog.InserisciDato('ID_RICHIESTA','',Id.ToString);

    // inserimento timbratura
    try
      insT100_T370.Execute;
      StrMsg:='ESITO POSITIVO.'#13#10;
      RegistraMsg.InserisciMessaggio('I',StrMsg,'',Progressivo);
      LogMsg:=LogMsg + StrMsg;
      RegistraLog.RegistraOperazione{(False)};
      SessioneOracle.Commit;
    except
      on E:Exception do
      begin
        StrMsg:=Format('ESITO NEGATIVO: %s'#13#10,[ConvErrSQL(E.Message)]);
        RegistraMsg.InserisciMessaggio('A',StrMsg,'',Progressivo);
        LogMsg:=LogMsg + StrMsg;
        insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
        insT280.SetVariable('FLAG','1');
        Elaborato:='E';
      end;
    end;
  end;
  procedure GestioneModifica(const PTipoRilevatore: TTipoRilevatore);
  // modifica della timbratura effettiva in base al tipo rilevatore (presenza / mensa)
  var
    LTabella,LDescTipoRilevatore,FlagOrig: String;
    TimbraturaTrovata: Boolean;
  begin
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    if PTipoRilevatore = trPresenza then
    begin
      LTabella:='T100_TIMBRATURE';
      LDescTipoRilevatore:='presenza';
    end
    else
    begin
      LTabella:='T370_TIMBMENSA';
      LDescTipoRilevatore:='mensa';
    end;
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine

    // prepara modifica timbratura
    if not (VersoModificato or CausaleModificata) then
    begin
      insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
      StrMsg:=Format('ESITO NEGATIVO [%s]: Modifica non necessaria.'#13#10,[LDescTipoRilevatore]);
      RegistraMsg.InserisciMessaggio('I',StrMsg,'',Progressivo);
      LogMsg:=LogMsg + StrMsg;
      Elaborato:='E';
    end
    else
    begin
      // estrae il flag della timbratura originale da modificare (ne verifica contestualmente l'esistenza)
      with selT100_T370 do
      begin
        Close;
        SetVariable('TABELLA',LTabella); // MONDOEDP - commessa MAN/02 SVILUPPO#112
        SetVariable('PROGRESSIVO',Progressivo);
        SetVariable('DATA',Data);
        SetVariable('ORA',Ora);
        SetVariable('VERSO',VersoOrig);
        Open;
        TimbraturaTrovata:=RecordCount > 0;
        if RecordCount > 0 then
          FlagOrig:=FieldByName('FLAG').AsString;
      end;
      // verifica se la timbratura da modificare è stata trovata
      if TimbraturaTrovata then
      begin
        FlagOrigInvariato:=((not VersoModificato) or (Parametri.TimbOrig_Verso = 'S')) and
                           ((not CausaleModificata) or (Parametri.TimbOrig_Causale = 'S'));
        if (FlagOrig = 'I') or
           (FlagOrigInvariato) then
        begin
          // si tratta di timbratura manuale oppure
          // timbratura originale per cui il flag non sarà modificato
          // -> modifica diretta
          TestoSql:=Format('ID_RICHIESTA = %d',[Id]);
          if VersoModificato then
            TestoSql:=TestoSql + IfThen(TestoSql <> '',', ') + Format('VERSO =  ''%s''',[Verso]);
          if CausaleModificata then
            TestoSql:=TestoSql + IfThen(TestoSql <> '',', ') + Format('CAUSALE = ''%s''',[Causale]);
          if TestoSql <> '' then
            TestoSql:=' SET ' + TestoSql;

          // prepara aggiornamento timbratura
          with updT100_T370 do
          begin
            SetVariable('TABELLA',LTabella); // MONDOEDP - commessa MAN/02 SVILUPPO#112
            SetVariable('MODIFICHE',TestoSql);
            SetVariable('PROGRESSIVO',Progressivo);
            SetVariable('DATA',Data);
            SetVariable('ORA',Ora);
            SetVariable('VERSO_ORIG',VersoOrig);
            SetVariable('FLAG',FlagOrig);
          end;

          // log aggiornamento
          RegistraLog.SettaProprieta('M',LTabella,NomeOwner,nil,True);
          RegistraLog.InserisciDato('PROGRESSIVO',Progressivo.ToString,'');
          RegistraLog.InserisciDato('DATA',DataStr,'');
          RegistraLog.InserisciDato('ORA',Ora,'');
          RegistraLog.InserisciDato('VERSO',VersoOrig,IfThen(VersoModificato,Verso,''));
          RegistraLog.InserisciDato('CAUSALE',CausaleOrig,IfThen(CausaleModificata,Causale,''));
          RegistraLog.InserisciDato('FLAG',FlagOrig,'');
          RegistraLog.InserisciDato('ID_RICHIESTA','',Id.ToString); // commessa MAN/02 - SVILUPPO 92

          try
            if not (VersoModificato or CausaleModificata) then
              raise Exception.Create('Nessuna modifica prevista per la timbratura');
            updT100_T370.Execute;
            StrMsg:=Format('ESITO POSITIVO [%s].'#13#10,[LDescTipoRilevatore]);
            RegistraMsg.InserisciMessaggio('I',StrMsg,'',Progressivo);
            LogMsg:=LogMsg + StrMsg;
            RegistraLog.RegistraOperazione{(False)};
            SessioneOracle.Commit;
          except
            on E:Exception do
            begin
              StrMsg:=Format('ESITO NEGATIVO [%s]: %s.'#13#10,[LDescTipoRilevatore,ConvErrSQL(E.Message)]);
              RegistraMsg.InserisciMessaggio('A',StrMsg,'',Progressivo);
              LogMsg:=LogMsg + StrMsg;
              insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
              insT280.SetVariable('FLAG','1');
              Elaborato:='E';
            end;
          end;
        end
        else if FlagOrig = 'O' then
        begin
          // si tratta di timbratura originale
          // -> update flag + inserimento timbratura modificata

          // prepara aggiornamento + inserimento timbratura
          with insUpdT100_T370 do
          begin
            SetVariable('TABELLA',LTabella); // MONDOEDP - commessa MAN/02 SVILUPPO#112
            SetVariable('PROGRESSIVO',Progressivo);
            SetVariable('DATA',Data);
            SetVariable('ORA',Ora);
            SetVariable('VERSO',Verso);
            SetVariable('CAUSALE',Causale);
            SetVariable('VERSO_ORIG',VersoOrig);
            SetVariable('ID_RICHIESTA',Id); // commessa MAN/02 - SVILUPPO 92
          end;

          // esecuzione inserimento / update
          try
            insUpdT100_T370.Execute;

            // log modifica
            RegistraLog.SettaProprieta('M',LTabella,NomeOwner,nil,True);
            RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Progressivo),'');
            RegistraLog.InserisciDato('DATA',DataStr,'');
            RegistraLog.InserisciDato('ORA',Ora,'');
            RegistraLog.InserisciDato('VERSO',VersoOrig,'');
            RegistraLog.InserisciDato('CAUSALE',CausaleOrig,'');
            RegistraLog.InserisciDato('FLAG','O','M');
            RegistraLog.InserisciDato('ID_RICHIESTA','',Id.ToString); // commessa MAN/02 - SVILUPPO 92
            RegistraLog.RegistraOperazione{(False)};

            // log inserimento
            RegistraLog.SettaProprieta('I',LTabella,NomeOwner,nil,True);
            RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Progressivo));
            RegistraLog.InserisciDato('DATA','',DataStr);
            RegistraLog.InserisciDato('ORA','',Ora);
            RegistraLog.InserisciDato('VERSO','',Verso);
            RegistraLog.InserisciDato('CAUSALE','',Causale);
            RegistraLog.InserisciDato('FLAG','','I');
            RegistraLog.InserisciDato('ID_RICHIESTA','',Id.ToString); // commessa MAN/02 - SVILUPPO 92
            RegistraLog.RegistraOperazione{(False)};

            StrMsg:=Format('ESITO POSITIVO [%s].'#13#10,[LDescTipoRilevatore]);
            RegistraMsg.InserisciMessaggio('I',StrMsg,'',Progressivo);
            LogMsg:=LogMsg + StrMsg;
          except
            on E:Exception do
            begin
              StrMsg:=Format('ESITO NEGATIVO [%s]: %s.'#13#10,[LDescTipoRilevatore,ConvErrSQL(E.Message)]);
              RegistraMsg.InserisciMessaggio('A',StrMsg,'',Progressivo);
              LogMsg:=LogMsg + StrMsg;
              insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
              insT280.SetVariable('FLAG','1');
              //17/09/2013 rimozione rollback. Non usare con sessioni condivise
              //SessioneOracle.Rollback;
              Elaborato:='E';
            end;
          end;
        end;
      end
      else
      begin
        StrMsg:=Format('ESITO NEGATIVO [%s]: Timbratura da modificare non trovata.'#13#10,[LDescTipoRilevatore]);
        RegistraMsg.InserisciMessaggio('A',StrMsg,'',Progressivo);
        LogMsg:=LogMsg + StrMsg;
        insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
        Elaborato:='E';
      end;
    end;
  end;
  procedure GestioneCancellazione(const PTipoRilevatore: TTipoRilevatore);
  // cancellazione della timbratura effettiva in base al tipo rilevatore (presenza / mensa)
  var
    LTabella,LDescTipoRilevatore,FlagOrig: String;
    TimbraturaTrovata: Boolean;
  begin
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    if PTipoRilevatore = trPresenza then
    begin
      LTabella:='T100_TIMBRATURE';
      LDescTipoRilevatore:='presenza';
    end
    else
    begin
      LTabella:='T370_TIMBMENSA';
      LDescTipoRilevatore:='mensa';
    end;
    // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine

    // estrae il flag della timbratura da eliminare (ne verifica contestualmente l'esistenza)
    with selT100_T370 do
    begin
      Close;
      SetVariable('TABELLA',LTabella); // MONDOEDP - commessa MAN/02 SVILUPPO#112
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DATA',Data);
      SetVariable('ORA',Ora);
      SetVariable('VERSO',Verso);
      Open;
      TimbraturaTrovata:=RecordCount > 0;
      if RecordCount > 0 then
        FlagOrig:=FieldByName('FLAG').AsString;
    end;
    // verifica se la timbratura da cancellare è stata trovata
    if TimbraturaTrovata then
    begin
      if FlagOrig = 'I' then
      begin
        // timbratura manuale -> cancella direttamente
        with delT100_T370 do
        begin
          SetVariable('TABELLA',LTabella); // MONDOEDP - commessa MAN/02 SVILUPPO#112
          SetVariable('PROGRESSIVO',Progressivo);
          SetVariable('DATA',Data);
          SetVariable('ORA',Ora);
          SetVariable('VERSO',Verso);
          SetVariable('FLAG','I');
        end;

        // log
        RegistraLog.SettaProprieta('C',LTabella,NomeOwner,nil,True); // MONDOEDP - commessa MAN/02 SVILUPPO#112
        RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Progressivo),'');
        RegistraLog.InserisciDato('DATA',DataStr,'');
        RegistraLog.InserisciDato('ORA',Ora,'');
        RegistraLog.InserisciDato('VERSO',Verso,'');
        RegistraLog.InserisciDato('CAUSALE',Causale,'');
        RegistraLog.InserisciDato('FLAG','I','');

        // cancellazione timbratura
        try
          delT100_T370.Execute;
          StrMsg:=Format('ESITO POSITIVO [%s].'#13#10,[LDescTipoRilevatore]);
          RegistraMsg.InserisciMessaggio('I',StrMsg,'',Progressivo);
          LogMsg:=LogMsg + StrMsg;
          RegistraLog.RegistraOperazione{(False)};
          SessioneOracle.Commit;
        except
          on E:Exception do
          begin
            StrMsg:=Format('ESITO NEGATIVO [%s]: %s.'#13#10,[LDescTipoRilevatore,ConvErrSQL(E.Message)]);
            RegistraMsg.InserisciMessaggio('A',StrMsg,'',Progressivo);
            LogMsg:=LogMsg + StrMsg;
            insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
            insT280.SetVariable('FLAG','1');
            Elaborato:='E';
          end;
        end;
      end
      else if FlagOrig = 'O' then
      begin
        // timbratura originale -> imposta il flag C
        TestoSql:=Format(' SET FLAG = ''%s'', ID_RICHIESTA = %d',['C',Id]);

        with updT100_T370 do
        begin
          SetVariable('TABELLA',LTabella); // MONDOEDP - commessa MAN/02 SVILUPPO#112
          SetVariable('MODIFICHE',TestoSql);
          SetVariable('PROGRESSIVO',Progressivo);
          SetVariable('DATA',Data);
          SetVariable('ORA',Ora);
          SetVariable('VERSO_ORIG',Verso);
          SetVariable('FLAG','O');
        end;

        // log
        RegistraLog.SettaProprieta('M',LTabella,NomeOwner,nil,True); // MONDOEDP - commessa MAN/02 SVILUPPO#112
        RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Progressivo),'');
        RegistraLog.InserisciDato('DATA',DataStr,'');
        RegistraLog.InserisciDato('ORA',Ora,'');
        RegistraLog.InserisciDato('VERSO',Verso,'');
        RegistraLog.InserisciDato('CAUSALE',Causale,'');
        RegistraLog.InserisciDato('FLAG','O','C');
        RegistraLog.InserisciDato('ID_RICHIESTA','',Id.ToString);

        // aggiornamento flag
        try
          updT100_T370.Execute;
          StrMsg:=Format('ESITO POSITIVO [%s].'#13#10,[LDescTipoRilevatore]);
          RegistraMsg.InserisciMessaggio('I',StrMsg,'',Progressivo);
          LogMsg:=LogMsg + StrMsg;
          RegistraLog.RegistraOperazione{(False)};
          SessioneOracle.Commit;
        except
          on E:Exception do
          begin
            StrMsg:=Format('ESITO NEGATIVO [%s]: %s.'#13#10,[LDescTipoRilevatore,ConvErrSQL(E.Message)]);
            RegistraMsg.InserisciMessaggio('A',StrMsg,'',Progressivo);
            LogMsg:=LogMsg + StrMsg;
            insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
            insT280.SetVariable('FLAG','1');
            Elaborato:='E';
          end;
        end;
      end;
    end
    else
    begin
      // timbratura inesistente
      StrMsg:=Format('ESITO NEGATIVO [%s]: Timbratura da eliminare non trovata.'#13#10,[LDescTipoRilevatore]);
      RegistraMsg.InserisciMessaggio('A',StrMsg,'',Progressivo);
      LogMsg:=LogMsg + StrMsg;
      insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
      Elaborato:='E';
    end;
  end;
  function DecodificaFunzioneRilevatore(const PFunzione: String): String;
  // decodifica la funzione del rilevatore in base al codice
  begin
    if PFunzione = 'P' then
      Result:='presenza'
    else if PFunzione = 'M' then
      Result:='mensa'
    else if PFunzione = 'E' then
      Result:='presenza/mensa'
    else
      Result:=Format('[non valido: %s]',[PFunzione]);
  end;
begin
  Elaborato:='S';
  Note:='';

  // salva i dati del record in variabili di appoggio
  Id:=selT105.FieldByName('ID').AsInteger;
  Progressivo:=selT105.FieldByName('PROGRESSIVO').AsInteger;
  Matricola:=selT105.FieldByName('MATRICOLA').AsString;
  Nominativo:=selT105.FieldByName('NOMINATIVO').AsString;
  Data:=selT105.FieldByName('DATA').AsDateTime;
  DataStr:=selT105.FieldByName('DATA').AsString;
  Ora:=selT105.FieldByName('ORA').AsString;
  Verso:=selT105.FieldByName('VERSO').AsString;
  Causale:=selT105.FieldByName('CAUSALE_UTILE').AsString;
  Rilevatore:=selT105.FieldByName('RILEVATORE_RICH').AsString;
  Autorizzazione:=selT105.FieldByName('AUTORIZZAZIONE').AsString;
  Operazione:=selT105.FieldByName('OPERAZIONE').AsString;
  VersoOrig:=selT105.FieldByName('VERSO_ORIG').AsString;
  CausaleOrig:=selT105.FieldByName('CAUSALE_ORIG').AsString;
  // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
  // rilevatore originale per controlli timbrature presenza / mensa
  RilevatoreOrig:=selT105.FieldByName('RILEVATORE_ORIG').AsString;
  // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine
  Responsabile:=selT105.FieldByName('NOMINATIVO_RESP').AsString;
  if Operazione = 'I' then
    OperazioneDesc:='Inserimento'
  else if Operazione = 'M' then
    OperazioneDesc:='Modifica'
  else
    OperazioneDesc:='Cancellazione';
  VersoModificato:=(Operazione = 'M') and (Verso <> VersoOrig);
  CausaleModificata:=(Operazione = 'M') and (Causale <> CausaleOrig);
  // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
  // gestione delle timbrature di presenza e di mensa
  // se la funzione non è indicata -> timbrature di presenza
  // questa impostazione è valida solo per le richieste di inserimento
  FunzioneRilevatore:='';
  if selT361.SearchRecord('CODICE',IfThen(Operazione = 'I',Rilevatore,RilevatoreOrig),[srFromBeginning]) then
  begin
    FunzioneRilevatore:=selT361.FieldByName('FUNZIONE').AsString;
    CausMensa:=Trim(selT361.FieldByName('CAUSMENSA').AsString);
  end;
  RilevatoreIndicato:=FunzioneRilevatore <> '';
  if FunzioneRilevatore = '' then
    FunzioneRilevatore:='P'
  else if (FunzioneRilevatore = 'E') and
          (CausMensa <> '') and
          (Causale <> CausMensa) then
    FunzioneRilevatore:='P';
  FunzioneRilevatoreDesc:=DecodificaFunzioneRilevatore(FunzioneRilevatore);
  // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine

  // nominativo responsabile
  LogMsg:='Autorizzato da ' + selT105.FieldByName('NOMINATIVO_RESP').AsString;

  // note
  C018DM.CodIter:=selT105.FieldByName('COD_ITER').AsString;
  C018DM.Id:=Id;
  Note:=C018DM.LeggiNoteComplete(False);
  if Note <> '' then
    Note:=#13#10 + Note;

  insT280.SetVariable('TESTO',Copy(LogMsg + Note,1,2000));

  // informazioni richiesta di timbratura
  LogMsg:='Richiesta di ' + OperazioneDesc + #13#10 +
          ' Id: ' + Id.ToString + // commessa MAN/02 - SVILUPPO 92
          ' Data: ' + DataStr +
          ' Ora: ' + Ora +
          ' Verso: ' + IfThen(Operazione = 'M',VersoOrig,Verso) +
          ' Causale: ' + IfThen(Operazione = 'M',CausaleOrig,Causale) +
          IfThen(RilevatoreIndicato,
          ' Rilevatore: ' + IfThen(Operazione = 'I',Rilevatore,RilevatoreOrig) + ' (' + FunzioneRilevatoreDesc + ')');
  // informazioni per modifica timbratura
  if Operazione = 'M' then
  begin
    if VersoModificato then
      LogMsg:=LogMsg + ' Verso modificato: ' + Verso;
    if CausaleModificata then
      LogMsg:=LogMsg + ' Causale modificata: ' + Causale;
  end;
  RegistraMsg.InserisciMessaggio('I',StringReplace(LogMsg,#13#10,#13#10 + '  ',[rfReplaceAll]),'',Progressivo);
  RegistraMsg.InserisciMessaggio('I','  Autorizzato da: ' + Responsabile + NomeResp,'',Progressivo);
  if Note <> '' then
    RegistraMsg.InserisciMessaggio('I','  ' + StringReplace(Note,#13#10,#13#10 + '  ',[rfReplaceAll]),'',Progressivo);

  // log messaggi web
  insT280.SetVariable('PROGRESSIVO',Progressivo);
  insT280.SetVariable('DATA',Now);
  insT280.SetVariable('MITTENTE',Parametri.Operatore);
  insT280.SetVariable('FLAG','0');
  insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO POSITIVO - Caricamento timbrature richieste e autorizzate');

  LogMsg:=LogMsg + #13#10;

  // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
  // controllo dati bloccati in funzione del rilevatore
  // importante: al momento i rilevatori considerati possono avere funzione
  // - P (presenza)        -> riepiloghi T100
  // - E (presenza/mensa)  -> riepiloghi T100 + T370
  DatiBloccati:=False;
  if (FunzioneRilevatore = 'P') or
     (FunzioneRilevatore = 'E') then
    DatiBloccati:=selDatiBloccati.DatoBloccato(Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(Data),'T100');
  if not DatiBloccati then
  begin
    if (FunzioneRilevatore = 'M') or
       (FunzioneRilevatore = 'E') then
      DatiBloccati:=selDatiBloccati.DatoBloccato(Progressivo,SelDatiBloccati.MeseBloccoRiepiloghi(Data),'T370');
  end;
  if DatiBloccati then
  // MONDOEDP - commessa MAN/02 SVILUPPO#112.fine
  begin
    StrMsg:='ESITO NEGATIVO: Blocco attivo ' + selDatiBloccati.MessaggioLog + '.';
    RegistraMsg.InserisciMessaggio('B',StrMsg,'',Progressivo);
    LogMsg:=LogMsg + StrMsg;
    insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
    insT280.SetVariable('FLAG','2');
    Elaborato:='E';
    CommitRichiesta;
    Exit;
  end;

  // verifica se richiesta è autorizzata
  if Autorizzazione <> 'S' then
  begin
    StrMsg:='ESITO NEGATIVO: Richiesta non autorizzata.';
    RegistraMsg.InserisciMessaggio('I',StrMsg,'',Progressivo);
    LogMsg:=LogMsg + StrMsg;
    insT280.SetVariable('TITOLO','<' + NomeOwner + '> ESITO NEGATIVO - Caricamento timbrature richieste e autorizzate');
    insT280.SetVariable('FLAG','2');
    Elaborato:='E';
    CommitRichiesta;
    Exit;
  end;

  // gestione della richiesta in base al tipo:
  //   I = Inserimento
  //   M = Modifica
  //   C = Cancellazione
  if Operazione = 'I' then
  begin
    // gestisce inserimento timbratura in base alla funzione del rilevatore
    if R180In(FunzioneRilevatore,['P','E']) then
      GestioneInserimento(trPresenza);
    if Elaborato = 'S' then
    begin
      if R180In(FunzioneRilevatore,['M','E']) then
        GestioneInserimento(trMensa);
    end;
  end
  else if Operazione = 'M' then
  begin
    // gestisce modifica timbratura in base alla funzione del rilevatore
    if R180In(FunzioneRilevatore,['P','E']) then
      GestioneModifica(trPresenza);
    if Elaborato = 'S' then
    begin
      if R180In(FunzioneRilevatore,['M','E']) then
        GestioneModifica(trMensa);
    end;
  end
  else if Operazione = 'C' then
  begin
    // gestisce modifica timbratura in base alla funzione del rilevatore
    if R180In(FunzioneRilevatore,['P','E']) then
      GestioneCancellazione(trPresenza);
    if Elaborato = 'S' then
    begin
      if R180In(FunzioneRilevatore,['M','E']) then
        GestioneCancellazione(trMensa);
    end;
  end;

  // salva log su relativa tabella e imposta il flag elaborato sulla richiesta
  CommitRichiesta;
end;

procedure TA023FTimbratureMW.InizializzaAcquisizioneWeb(PSingola: Boolean);
var OldIdSingolo: Integer;
begin
  AcquisizioneWebInCorso:=True;

  if PSingola then
  begin
    // importazione richiesta singola
    OldIdSingolo:=selT105.FieldByName('ID').AsInteger;
  end
  else
  begin
    OldIdSingolo:=-1;
  end;

  // aggiorna le richieste da importare prima di iniziare l'elaborazione
  selT105.Refresh;

  // avvisa se dopo il refresh non ci sono più richieste da importare
  if selT105.RecordCount = 0 then
  begin
    if PSingola then
      raise Exception.Create('La richiesta selezionata è già stata importata in precedenza.')
    else
      raise Exception.Create('Tutte le richieste visualizzate sono già state importate in precedenza.');
  end
  else if (PSingola) and
          (not selT105.SearchRecord('ID',OldIdSingolo,[srFromBeginning])) then
  begin
    raise Exception.Create('La richiesta selezionata è già stata importata in precedenza.');
  end;

  // posizionamento su prima richiesta per elaborazione massiva
  if not PSingola then
    selT105.First;

  // datamodulo di supporto per lettura note richiesta
  C018DM:=TC018FIterAutDM.Create(nil);
  C018DM.Iter:=ITER_TIMBR;
  C018DM.selTabellaIter:=selT105;
end;

procedure TA023FTimbratureMW.FinalizzaAcquisizioneWeb;
begin
  try FreeAndNil(C018DM); except end;
  AcquisizioneWebInCorso:=False;
end;

procedure TA023FTimbratureMW.selT100Ora(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TA023FTimbratureMW.selT105CalcFields(DataSet: TDataSet);
var C018DatoAutorizzatore:TC018DatoAutorizzatore;
begin
  with selT105 do
  begin
    //CAUSALE_UTILE
    FieldByName('CAUSALE_UTILE').AsString:=FieldByName('CAUSALE').AsString;
    if C018DM <> nil then
    begin
      if C018DM.IterModificaValori then
      begin
        C018DM.Id:=FieldByName('ID').AsInteger;
        C018DatoAutorizzatore:=C018DM.GetDatoAutorizzatore('CAUSALE');
        if C018DatoAutorizzatore.Valore <> '' then
        begin
          FieldByName('CAUSALE_UTILE').AsString:=C018DatoAutorizzatore.Valore;
          //FieldByName('CAUSALE_UTILE_LIV').AsInteger:=C018DatoAutorizzatore.Livello;
        end;
      end;
    end;
  end;
end;

procedure TA023FTimbratureMW.AzzeraTabelle;

begin
  A000FGestioneTimbraGiustMW.AzzeraTabelle;
end;


procedure TA023FTimbratureMW.CaricaMese(Anno,Mese:Integer;bCalc: Boolean);
{Cambio i parametri alle query e carico i vettori Timbrature e Giustificativi
con i dati del mese}
var i,j:Byte;
    Inizio,Fine:TDateTime;
begin
  AzzeraTabelle;
  MaxGiorni:=R180GiorniMese(EncodeDate(Anno,Mese,1));
  Inizio:=EncodeDate(Anno,Mese,1);
  Fine:=EncodeDate(Anno,Mese,MaxGiorni);
  //Se i conteggi sono aperti imposto il periodo richiesto
  if bCalc then
    R502ProDtM1.PeriodoConteggi(Inizio,Fine);

  {Limito la vista dei giustificativi e timbrature}
  Q040.Close;
  Q080.Close;
  Q100.Close;
  selT320.Close;
  Q040.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q040.SetVariable('DataInizio',Inizio);
  Q040.SetVariable('DataFine',Fine);
  Q080.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q080.SetVariable('DataInizio',Inizio);
  Q080.SetVariable('DataFine',Fine);
  Q100.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q100.SetVariable('DataInizio',Inizio);
  Q100.SetVariable('DataFine',Fine);
  selT320.SetVariable('Progressivo',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  selT320.SetVariable('DataInizio',Inizio);
  selT320.SetVariable('DataFine',Fine);
  Q040.Open;
  Q080.Open;
  Q100.Open;
  selT320.Open;
  A000FGestioneTimbraGiustMW.CaricaArrayGiustificativi(Q265,Q031_1);
  A000FGestioneTimbraGiustMW.CaricaArrayTimbrature;
  {Ciclo su selT320}
  for i:=1 to 31 do
    FPianif[i]:=False;
  selT320.First;
  while not selT320.Eof do
  begin
    FPianif[R180Giorno(selT320.FieldByName('Data').AsDateTime)]:=True;
    selT320.Next;
  end;
  selT320.Close;
end;

function TA023FTimbratureMW.DescrizioneCausale(Causale:String): String;
begin
  Result:='';
  if Q265.Locate('Codice',Causale,[]) then
    Result:=Q265.FieldByName('Descrizione').AsString
  else if Q275.Locate('Codice',Causale,[]) then
    Result:=Q275.FieldByName('Descrizione').AsString
  else if Q305.Locate('Codice',Causale,[]) then
    Result:=Q305.FieldByName('Descrizione').AsString
end;

function TA023FTimbratureMW.TrovaAssenzeDaValidare(Giorno: Integer): String;
var
  StrCaus: String;
  i: Integer;
begin
  StrCaus:='';
  for i:=1 to MaxGiustif do
    if (A000FGestioneTimbraGiustMW.FGiustificativi[Giorno,i].Causale <> '') and (A000FGestioneTimbraGiustMW.FGiustificativi[Giorno,i].Validata  = 'N') and
       (A000FiltroDizionario('CAUSALI ASSENZA', A000FGestioneTimbraGiustMW.FGiustificativi[Giorno,i].Causale)) then
    begin
      if (i > 1) and (StrCaus <> '') then
        StrCaus:=StrCaus + ', ';
      StrCaus:=StrCaus + A000FGestioneTimbraGiustMW.FGiustificativi[Giorno,i].Causale;
    end;
  Result:=StrCaus;
end;

procedure TA023FTimbratureMW.selSG101FilterRecord(DataSet: TDataSet; var Accept: Boolean);
// Filtro per il dataset SG101 della R600
var
  D: TDateTime;
begin
  try
    D:=StrToDate(getDataGestGiustif);
    Accept:=True;
  except
    D:=0;
    Accept:=False;
  end;
  Accept:=Accept and
         ((R180CarattereDef(VarToStr(Q265.Lookup('CODICE',getCausaleGestGiustif,'CUMULO_FAMILIARI')),1,#0) in ['S','D'])
           or
          (R180CarattereDef(VarToStr(Q265.Lookup('CODICE',getCausaleGestGiustif,'FRUIZIONE_FAMILIARI')),1,#0) in ['S','D']));
  if Accept then
    with R600DtM1.selSG101Causali do
    begin
      Accept:=False;
      if SearchRecord('NUMORD',Dataset.FieldByName('NUMORD').AsInteger,[srFromBeginning]) then
        repeat
          if (D >= FieldByName('DECORRENZA').AsDateTime) and (D <= FieldByName('DECORRENZA_FINE').AsDateTime) then
          begin
            Accept:=(Pos('<*>',FielDByName('CAUSALI_ABILITATE').AsString) > 0)
                    or
                   (Pos('<' + getCausaleGestGiustif + '>',FieldByName('CAUSALI_ABILITATE').AsString) > 0);
            Break;
          end;
        until not SearchRecord('NUMORD',Dataset.FieldByName('NUMORD').AsInteger,[]);
    end;
end;

procedure TA023FTimbratureMW.ImpostaProgressivoSG101;
begin
  // parte nuova da considerare
  R600DtM1.selSG101Causali.SetVariable('Progressivo',ProgressivoC700);
  R600DtM1.selSG101Causali.Close;
  R600DtM1.selSG101Causali.Open;
  R600DtM1.selSG101.SetVariable('Progressivo',ProgressivoC700);
  R600DtM1.selSG101.Close;
end;

function TA023FTimbratureMW.GetValStrT230(Causale,Nome:String; Data:TDateTime):String;
{Leggo il valore storicizzato alla Data per la Causale}
begin
  Result:='';
  with T230F_GETVALUE do
  begin
    if (VarToStr(GetVariable('CAUSALE')) <> Causale) or
       (VarToStr(GetVariable('NOME')) <> Nome) or
       (GetVariable('DATA') <> Data) then
    begin
      SetVariable('CAUSALE',Causale);
      SetVariable('NOME',Nome);
      SetVariable('DATA',Data);
      Execute;
    end;
    Result:=VarToStr(GetVariable('VALORE'));
  end;
end;

function TA023FTimbratureMW.VerificaCausaleTipoGiust(TipoCausale: Word; DataGiust: TDateTime; TipoGiust,Causale,CausOrig:String; bFamiliareSelezionato: Boolean; var DaOre,AOre:String): String;
var CausInizio: String;
    FruizVincolata,FruizMin,FruizArr:Integer;
begin
  if TipoCausale = 0 then
  begin
    // causali di presenza
    // Controllo 'tipo giustificativo' con 'unità misura di fruizione'
    if (TipoGiust = 'N') and
       (VarToStr(Q275.Lookup('CODICE',Causale,'UM_INSERIMENTO_H')) = 'N') then
    begin
      Result:=A000MSG_A023_ERR_GIUST_NO_ORE;
      Exit;
    end;
    if (TipoGiust = 'D') and
       (VarToStr(Q275.Lookup('CODICE',Causale,'UM_INSERIMENTO_D')) = 'N') then
    begin
      Result:=A000MSG_A023_ERR_GIUST_NO_DA_A;
      Exit;
    end;
  end;

  if TipoCausale = 1 then
  begin
    // causali di assenza
    with Q265 do
    begin
      // Controllo 'tipo giustificativo' con 'unità misura di fruizione'
      if (TipoGiust = 'I') and
         (VarToStr(Lookup('CODICE',Causale,'UM_INSERIMENTO')) = 'N') then
      begin
        Result:=A000MSG_A023_ERR_GIUST_NO_GIORN;
        Exit;
      end;
      if (TipoGiust = 'M') and
         (VarToStr(Lookup('CODICE',Causale,'UM_INSERIMENTO_MG')) = 'N') then
      begin
        Result:=A000MSG_A023_ERR_GIUST_NO_MG;
        Exit;
      end;
      if (TipoGiust = 'N') and
         (VarToStr(Lookup('CODICE',Causale,'UM_INSERIMENTO_H')) = 'N') then
      begin
        Result:=A000MSG_A023_ERR_GIUST_NO_ORE;
        Exit;
      end;
      if (TipoGiust = 'D') and
         (VarToStr(Lookup('CODICE',Causale,'UM_INSERIMENTO_D')) = 'N') then
      begin
        Result:=A000MSG_A023_ERR_GIUST_NO_DA_A;
        Exit;
      end;

      // TORINO_ASLTO2 - 2013/044 - INT_TECN 4 - controllo inizio catena.ini
      if (Parametri.CampiRiferimento.C23_InsNegCatena = 'S') and
         (Causale <> CausOrig) and
         (not R600DtM1.IsInizioCatenaCausAss(Causale,CausInizio)) then
      begin
        Result:=A000TraduzioneStringhe(Format(A000MSG_MSG_FMT_INIZIOCATENA,[Causale,CausInizio]));
        Exit;
      end;
      // TORINO_ASLTO2.fine
      //Controllo richiesta familiare
      if (R180CarattereDef(FieldByName('CUMULO_FAMILIARI').AsString,1,'N') in ['S','D']) or
         (R180CarattereDef(FieldByName('FRUIZIONE_FAMILIARI').AsString,1,'N') in ['S','D']) then
      begin
        if (not bFamiliareSelezionato) then
        begin
          Result:=A000MSG_A023_ERR_GIUST_NO_FAMILIARE;
          Exit;
        end;
      end;

      //Verifica vincoli sulla fruizione oraria
      FruizArr:=FieldByName('FRUIZ_ARR').AsInteger;
      FruizMin:=FieldByName('FRUIZ_MIN').AsInteger;
      if FieldByName('FRUIZCOMPETENZE_ARR').AsString = 'S' then
      begin
        FruizArr:=0;
        if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
          FruizMin:=0;
      end;
      if TipoGiust = 'N' then
      begin
        FruizVincolata:=R180OreMinutiExt(DaOre);
        if FruizVincolata > 0 then
        begin
          R600DtM1.ControllaVincoliFruizione(R180OreMinutiExt(DaOre),FruizMin,FieldByName('FRUIZ_MAX').AsInteger,FruizArr,FruizVincolata);
          if FieldByName('FRUIZ_MAX_DEBITO').AsString = 'S' then
            R600DtM1.ControllaFruizMaxDebito(DataGiust,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,FruizVincolata,Causale,'N',DaOre,AOre,FruizVincolata);
          DaOre:=R180MinutiOre(FruizVincolata);
        end
        else
          FruizVincolata:=1;
      end
      else if TipoGiust = 'D' then
      begin
        R600DtM1.ControllaVincoliFruizione(IfThen(R180OreMinutiExt(AOre) = 0,1440,R180OreMinutiExt(AOre)) - R180OreMinutiExt(DaOre),FruizMin,FieldByName('FRUIZ_MAX').AsInteger,FruizArr,FruizVincolata);
        if R180OreMinutiExt(DaOre) + FruizVincolata = 1440 then
          AOre:='00.00'
        else
          AOre:=R180MinutiOre(R180OreMinutiExt(DaOre) + FruizVincolata);
      end;
      if ((TipoGiust = 'N') or (TipoGiust = 'D')) and (FruizVincolata = 0 ) then
      begin
        Result:=A000MSG_ERR_FRUIZ_INF_VINCOLI;
        Exit;
      end;

      //Verifica della fruizione oraria se richiesto il controllo col debito gg
      if FieldByName('FRUIZ_MAX_DEBITO').AsString = 'S' then
      begin
        if ((TipoGiust = 'N') or (TipoGiust = 'D')) then
        begin
          if TipoGiust = 'N' then
          begin
            R600DtM1.ControllaFruizMaxDebito(DataGiust,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180OreMinutiExt(DaOre),Causale,'N',DaOre,AOre,FruizVincolata);
            DaOre:=R180MinutiOre(FruizVincolata);
          end
          else
          begin
            R600DtM1.ControllaFruizMaxDebito(DataGiust,SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,IfThen(R180OreMinutiExt(AOre) = 0,1440,R180OreMinutiExt(AOre)) - R180OreMinutiExt(DaOre),Causale,'D',DaOre,AOre,FruizVincolata);
            if R180OreMinutiExt(DaOre) + FruizVincolata = 1440 then
              AOre:='00.00'
            else
              AOre:=R180MinutiOre(R180OreMinutiExt(DaOre) + FruizVincolata);
          end;
          if FruizVincolata = 0 then
          begin
            Result:=A000MSG_ERR_FRUIZ_INF_VINCOLI;
            Exit;
          end;
        end;
      end;
    end;
  end;
  Result:='';
end;

procedure TA023FTimbratureMW.CaricaTimbratureGiustificativi;
{Carico le timbrature e i giustificativi del mese su
m_tab_timbrature e m_tab_giustificativi}
var i,j,Num:Byte;
    xx,yy:Integer;
begin
  with R502ProDtM1 do
  begin
    for xx:=Low(m_tab_timbrature) to High(m_tab_timbrature) do
      for yy:=1 to MaxTimbrature do
        m_tab_timbrature[xx,yy]:=m_tab_timbrature_vuoto;
    for xx:=Low(m_tab_giustificativi) to High(m_tab_giustificativi) do
      for yy:=1 to MaxGiustif do
        m_tab_giustificativi[xx,yy]:=m_tab_giustificativi_vuoto;
    for i:=1 to 31 do
    begin
      //Carica timbrature
      Num:=A000FGestioneTimbraGiustMW.FNumTimbrature[i];
      for j:=1 to Num do
      begin
        m_tab_timbrature[i,j].toratimb:=R180VarToDateTime(A000FGestioneTimbraGiustMW.FTimbrature[i,j].Ora);
        m_tab_timbrature[i,j].tversotimb:=R180CarattereDef(A000FGestioneTimbraGiustMW.FTimbrature[i,j].Verso,1,#0);
        m_tab_timbrature[i,j].tflagtimb:=R180CarattereDef(A000FGestioneTimbraGiustMW.FTimbrature[i,j].Flag,1,#0);
        m_tab_timbrature[i,j].trilevtimb:=A000FGestioneTimbraGiustMW.FTimbrature[i,j].Rilevatore;
        m_tab_timbrature[i,j].tcaustimb:=A000FGestioneTimbraGiustMW.FTimbrature[i,j].Causale;
      end;
      //Carica Giustificativi
      Num:=A000FGestioneTimbraGiustMW.FNumGiustif[i];
      for j:=1 to Num do
      begin
        m_tab_giustificativi[i,j].tcausgius:=A000FGestioneTimbraGiustMW.FGiustificativi[i,j].Causale;
        m_tab_giustificativi[i,j].tproggius:=A000FGestioneTimbraGiustMW.FGiustificativi[i,j].ProgCaus;
        m_tab_giustificativi[i,j].tdallegius:=A000FGestioneTimbraGiustMW.FGiustificativi[i,j].DaOre;
        m_tab_giustificativi[i,j].ttipogius:=R180CarattereDef(A000FGestioneTimbraGiustMW.FGiustificativi[i,j].Tipo,1,#0);
        m_tab_giustificativi[i,j].tallegius:=A000FGestioneTimbraGiustMW.FGiustificativi[i,j].AOre;
        m_tab_giustificativi[i,j].tflscheda:=A000FGestioneTimbraGiustMW.FGiustificativi[i,j].FlagScheda;
        m_tab_giustificativi[i,j].ttipomg:=A000FGestioneTimbraGiustMW.FGiustificativi[i,j].CSITipoMG;
      end;
    end;
  end;
end;

procedure TA023FTimbratureMW.AllineamentoTimbraturePeriodo(DataI,DataF:TDateTime);
var
  A023FAllTimbMW: TA023FAllTimbMW;
begin
  A023FAllTimbMW:=TA023FAllTimbMW.Create(nil);
  try
    A023FAllTimbMW.Q100.Session:=SessioneOracle;
    A023FAllTimbMW.Q100Upd.Session:=SessioneOracle;
    //Scorro dipendenti selezionati
    A023FAllTimbMW.Allinea(ProgressivoC700,DataI,DataF);

    RegistraLog.SettaProprieta('M','T100_TIMBRATURE',NomeOwner,nil,True);
    RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(ProgressivoC700),'');
    RegistraLog.InserisciDato('ALLINEAMENTO DAL - AL',Format('%s - %s',[DateToStr(DataI),DateToStr(DataF)]),'');
    RegistraLog.RegistraOperazione;
  finally
    FreeAndNil(A023FAllTimbMW);
  end;
end;

procedure TA023FTimbratureMW.AllineamentoTimbrature(Giorno: TDateTime);
// allineamento timbrature automatico - daniloc 17.11.2009
// se l'anomalia è "timbr. non in sequenza" (R502ProDtM1.Blocca = 2) ->
//   esegue l'allineamento timbrature nel giorno per tentare di risolvere il problema
var A023FAllTimb:TA023FAllTimbMW;
    i,j:Integer;
begin
  A023FAllTimb:=TA023FAllTimbMW.Create(nil);
  try
    // allineamento timbrature
    A023FAllTimb.Q100.Session:=SessioneOracle;
    A023FAllTimb.Q100Upd.Session:=SessioneOracle;
    A023FAllTimb.Allinea(ProgressivoC700,Giorno,Giorno);

    // reimposta le timbrature del mese
    i:=0;
    j:=0;
    Q100.Close;
    Q100.Open;
    Q100.First;
    while not Q100.Eof do
    begin
      if R180Giorno(Q100.FieldByName('Data').AsDateTime) <> i then
      begin
        i:=R180Giorno(Q100.FieldByName('Data').AsDateTime);
        j:=0;
      end;
      if j < MaxTimbrature then
      begin
        inc(j);
        A000FGestioneTimbraGiustMW.FNumTimbrature[i]:=j;
        A000FGestioneTimbraGiustMW.FTimbrature[i,j].Ora:=Q100.FieldByName('Ora').AsDateTime;
        A000FGestioneTimbraGiustMW.FTimbrature[i,j].Verso:=Q100.FieldByName('Verso').AsString;
        A000FGestioneTimbraGiustMW.FTimbrature[i,j].Flag:=Q100.FieldByName('Flag').AsString;
        A000FGestioneTimbraGiustMW.FTimbrature[i,j].Rilevatore:=Q100.FieldByName('Rilevatore').AsString;
        A000FGestioneTimbraGiustMW.FTimbrature[i,j].Causale:=Q100.FieldByName('Causale').AsString;
      end;
      Q100.Next;
    end;
    CaricaTimbratureGiustificativi;
  finally
    FreeAndNil(A023FAllTimb);
  end;
end;

function TA023FTimbratureMW.TestoTurno(Data: TDateTime): String;
begin
  Result:='';
  if Q080.Locate('Data',Data,[]) then
    Result:=Format('%2s%1s%2s%1s',[Q080.FieldByName('Turno1').AsString,Q080.FieldByName('Turno1EU').AsString,Q080.FieldByName('Turno2').AsString,Q080.FieldByName('Turno2EU').AsString]);
end;

procedure TA023FTimbratureMW.AggDataControllo(Data: TDateTime);
begin
  Q031.Edit;
  Q031.FieldByName('Progressivo').AsInteger:=ProgressivoC700;
  Q031.FieldByName('Data').AsDateTime:=Data;
  Q031.FieldByName('Tipo').AsString:='0';
  Q031.Post;
end;

procedure TA023FTimbratureMW.CreaDataSetSimulazione;
begin
  // crea il clientdataset per la simulazione del ripristino
  with cdsT100RiprSim do
  begin
    CreateDataSet;
    LogChanges:=False;
  end;
end;

procedure TA023FTimbratureMW.SimulaRipristino(RipristinaOrig,CancManuali,CancIterWeb: boolean);
// applica i filtri sul clientdataset in modo da simulare l'esecuzione
// delle operazioni richieste
var
  LFlag, FlagSim, VisSim: String;
begin
  // esegue la simulazione del ripristino
  with cdsT100RiprSim do
  begin
    Filtered:=False;
    DisableControls;
    First;
    while not Eof do
    begin
      LFlag:=FieldByName('FLAG').AsString;

      // inizializza i campi per la simulazione
      FlagSim:=LFlag;
      VisSim:='S';

      // ripristina le timbrature originali (flag M / C)
      if RipristinaOrig then
      begin
        if (LFlag = 'M') or (LFlag = 'C') then
        begin
          // il ripristino avviene modificando il flag = 'O' (originale)
          FlagSim:='O';
        end;
      end;

      // cancella timbrature inserite manualmente
      if CancManuali then
      begin
        if (LFlag = 'I') and
           (FieldByName('ID_RICHIESTA').IsNull) then
        begin
          // nasconde la timbratura
          VisSim:='N';
        end;
      end;

      if CancIterWeb then
      begin
        if (LFlag = 'I') and
           (not FieldByName('ID_RICHIESTA').IsNull) then
        begin
          // nasconde la timbratura
          VisSim:='N';
        end;
      end;

      // aggiorna i dati
      Edit;
      FieldByName('FLAG_SIM').AsString:=FlagSim;
      FieldByName('VIS_SIM').AsString:=VisSim;
      Post;

      Next;
    end;
    Filtered:=True;
    First;
    EnableControls;
  end;
end;

procedure TA023FTimbratureMW.AggiornaTabella(DataInizio, DataFine: TDateTime;OperazioniSelezionate, RipristinaOrig ,CancManuali, CancIterWeb : boolean);
// aggiorna la tabella delle timbrature in base ai valori di
// - Progressivo
// - DataInizio
// - DataFine
var
  i: Integer;
  Nome: String;
begin
  selT100Ripristino.DisableControls;
  cdsT100RiprSim.Filtered:=False;
  cdsT100RiprSim.DisableControls;

  // apertura dataset principale
  R180SetVariable(selT100Ripristino,'PROGRESSIVO',ProgressivoC700);
  R180SetVariable(selT100Ripristino,'DATA_INIZIO',DataInizio);
  R180SetVariable(selT100Ripristino,'DATA_FINE',DataFine);
  selT100Ripristino.Open;

  // popolamento clientdataset di appoggio
  cdsT100RiprSim.EmptyDataSet;
  selT100Ripristino.First;
  while not selT100Ripristino.Eof do
  begin
    // copia i valori di ogni campo dal dataset al clientdataset
    cdsT100RiprSim.Append;
    for i:=0 to selT100Ripristino.FieldCount - 1 do
    begin
      Nome:=selT100Ripristino.Fields[i].FieldName;
      if Assigned(cdsT100RiprSim.FindField(Nome)) then
        cdsT100RiprSim.FieldValues[Nome]:=selT100Ripristino.Fields[i].Value;
    end;
    cdsT100RiprSim.FieldByName('FLAG_SIM').AsString:=cdsT100RiprSim.FieldByName('FLAG').AsString;
    cdsT100RiprSim.FieldByName('VIS_SIM').AsString:='S';
    cdsT100RiprSim.Post;

    selT100Ripristino.Next;
  end;

  // effettua simulazione ripristino in base alle operazioni selezionate
  if OperazioniSelezionate then
    SimulaRipristino(RipristinaOrig,CancManuali,CancIterWeb);
  // posiziona su primo record
  selT100Ripristino.First;
  cdsT100RiprSim.Filter:='VIS_SIM = ''S''';
  cdsT100RiprSim.Filtered:=True;
  cdsT100RiprSim.First;

  // riabilita aggiornamento interfaccia
  selT100Ripristino.EnableControls;
  cdsT100RiprSim.EnableControls;
end;

procedure TA023FTimbratureMW.EseguiRipristino(DataInizio,DataFine:TDateTime; RipristinaOrig, CancManuali, CancIterWeb: Boolean);
// esegue il ripristino delle timbrature originali in base alle opzioni selezionate
var
  FiltroIdRichiesta: String;
begin

  // 1. cancellazione timbrature inserite (manualmente / da iter web)
  if (CancManuali or CancIterWeb) then
  begin
    if (CancManuali and CancIterWeb) then
    begin
      // elimina tutte le timbrature con flag I
      FiltroIdRichiesta:='';
    end
    else if CancManuali then
    begin
      // elimina solo le timbrature inserite manualmente
      FiltroIdRichiesta:='and ID_RICHIESTA is null';
    end
    else if CancIterWeb then
    begin
      // elimina solo le timbrature inserite da iter autorizzativo web
      FiltroIdRichiesta:='and ID_RICHIESTA is not null';
    end;

    // esegue l'operazione di cancellazione timbrature manuali
    with Q100Delete do
    begin
      SetVariable('Data1',DataInizio);
      SetVariable('Data2',DataFine);
      SetVariable('Progressivo',ProgressivoC700);
      SetVariable('FILTRO_ID_RICHIESTA',FiltroIdRichiesta);
      Execute;
    end;
  end;

  // 2. ripristino timbrature originali
  if RipristinaOrig then
  begin
    with Q100Update do
    begin
      SetVariable('Data1',DataInizio);
      SetVariable('Data2',DataFine);
      SetVariable('Progressivo',ProgressivoC700);
      Execute;
    end;
  end;

  // committa operazioni
  SessioneOracle.Commit;
end;

procedure TA023FTimbratureMW.SetProgOperAnomale;
begin
  with Q101 do
  begin
    Close;
    SetVariable('Operatore',Parametri.ProgOper);
  end;
end;

procedure TA023FTimbratureMW.EliminaTimbratureDoppie(Tutti:Boolean; Inizio,Fine:TDateTime);
{Processo di ripristino timbrature originali: cancello tutte le timbrature
con flag = 'I' e modifico le timbrature con Flag = 'M' o 'C' settando Flag = 'O'}
begin
  with EliminaTimbriDoppi do
  begin
    if Tutti then
      SetVariable('MATRICOLA','*')
    else
      SetVariable('MATRICOLA',ProgressivoC700);
    SetVariable('DAL',FormatDateTime('dd/mm/yyyy',Inizio));
    SetVariable('AL',FormatDateTime('dd/mm/yyyy',Fine));
    Execute;
  end;
end;

function TA023FTimbratureMW.DatoBloccato(Data: TDateTime): Boolean;
begin
  Result:=selDatiBloccati.DatoBloccato(ProgressivoC700,R180InizioMese(Data),'T100');
end;

procedure TA023FTimbratureMW.ImpostaQ031;
begin
  Q031.Close;
  Q031.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q031.Open;

  Q031_1.Close;
  Q031_1.SetVariable('Progressivo',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  Q031_1.Open;
end;

procedure TA023FTimbratureMW.OpenSelT030(Prog: Integer);
begin
  selT030.SQL.Add('SELECT T030.COGNOME || '' '' || T030.NOME AS NOMINATIVO');
  selT030.SQL.Add('FROM T030_ANAGRAFICO T030');
  selT030.SQL.Add('WHERE T030.PROGRESSIVO = ' + IntToStr(Prog));
  selT030.Open;
end;

procedure TA023FTimbratureMW.ValidaAssenza(DataDa, DataA: TDateTime; Prog: Integer; Caus: String);
var DataScorr:TDateTime;
begin
  DataScorr:=DataDa;
  While DataScorr <= DataA do
  begin
    UpdT040.SetVariable('PROG',Prog);
    UpdT040.SetVariable('DATA',DataScorr);
    UpdT040.SetVariable('CAUS',Caus);
    UpdT040.Execute;
    DataScorr:=DataScorr + 1;
  end;
  UpdT040.Session.Commit;
end;

function TA023FTimbratureMW.ConfermaModifica(TipoCausale: Integer; Data,NewDataNas,OldDataNas:TDateTime;OldGiustif,NewGiustif: TGiustificativo; TipoGiust:Char; ProgCausOrig: Integer; OldValidata: String;NumGiustificativo: Integer; var L133GGModif: Boolean): Boolean;
var AssenzaOk: boolean;
    Assenza: TControlloAssenza;
begin
  Result:=False;
  //Cancello la causale originaria
  Q040.Delete;
  SessioneOracle.Commit;

  AssenzaOK:=False;
  if TipoCausale = 1 then
  begin
    Assenza.Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    Assenza.Data:=Data;
    Assenza.DataNas:=NewDataNas;
    Assenza.OldGiustif:=OldGiustif;
    Assenza.NewGiustif:=NewGiustif;
    try
      AssenzaOK:=ControlloAssenze(Assenza,NewGiustif.Causale);
    except
      on E:Exception do
      begin
        R180MessageBox(E.Message,ESCLAMA);
        AssenzaOK:=False;
      end;
    end;
  end;
  Q040.Append;
  if (TipoCausale = 0) or (AssenzaOK) then
  begin
    //L133 - Brunetta
    (*if AssenzaOK and (Data >= EncodeDate(2008,6,25)) then
      begin
        R600DtM1.scrDieciGiorniDopo.SetVariable('PROGRESSIVO',C700Progressivo);
        R600DtM1.scrDieciGiorniDopo.SetVariable('CAUSALE',OldGiustif.Causale);
        R600DtM1.scrDieciGiorniDopo.SetVariable('DATA',Data);
        R600DtM1.scrDieciGiorniDopo.Execute;
        L133GGModif:=R600DtM1.scrDieciGiorniDopo.GetVariable('GGMODIF') > 0;
      end;*)
    //Inserimento giustificativo modificato
    Q040.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    Q040.FieldByName('Data').AsDateTime:=Data;
    Q040.FieldByName('Causale').AsString:=NewGiustif.Causale;//ECausale.Text;
    if (AssenzaOK) and (NewDataNas <> 0) then
      Q040.FieldByName('DataNas').AsDateTime:=NewDataNas;
    Q040.FieldByName('ProgrCausale').AsInteger:=0;
    Q040.FieldByName('TipoGiust').AsString:=TipoGiust;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    if TipoGiust = 'M' then
      Q040.FieldByName('CSI_TIPO_MG').AsString:=NewGiustif.CSITipoMG;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Q040.FieldByName('DaOre').Clear;
    Q040.FieldByName('AOre').Clear;
    if TipoGiust in ['N','D'] then
      Q040.FieldByName('DaOre').AsDateTime:=StrToTime(NewGiustif.DaOre); //tempdario StrToTime(EDaOre.EditText);
    if TipoGiust = 'D' then
      Q040.FieldByName('AOre').AsDateTime:=StrToTime(NewGiustif.AOre); //tempdario StrToTime(EAOre.EditText);
    if (TipoGiust = 'M') and (R180OreMinutiExt(NewGiustif.DaOre) > 0) then //tempdario R180OreMinutiExt(EDaOre.EditText)
      Q040.FieldByName('DaOre').AsDateTime:=StrToTime(NewGiustif.DaOre);  //tempdario StrToTime(EDaOre.EditText);

    // se giustificativo modificato -> rimuove l'eventuale link richiesta
    Q040.FieldByName('Id_Richiesta').Value:=null;
  end
  else
  begin
    //Inserimento giustificativo originale (Solo assenza)
    Q040.FieldByName('Progressivo').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    Q040.FieldByName('Data').AsDateTime:=Data;
    Q040.FieldByName('Causale').AsString:=OldGiustif.Causale;
    if OldDataNas <> 0 then
      Q040.FieldByName('DataNas').AsDateTime:=OldDataNas;
    Q040.FieldByName('ProgrCausale').AsInteger:=ProgCausOrig;
    Q040.FieldByName('TipoGiust').AsString:=OldGiustif.Modo;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    if OldGiustif.Modo = 'M' then
      Q040.FieldByName('CSI_TIPO_MG').AsString:=OldGiustif.CSITipoMG;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
    Q040.FieldByName('DaOre').Clear;
    Q040.FieldByName('AOre').Clear;
    if OldGiustif.Modo in ['N','D'] then
      Q040.FieldByName('DaOre').AsDateTime:=StrToTime(OldGiustif.DaOre);
    if OldGiustif.Modo = 'D' then
      Q040.FieldByName('AOre').AsDateTime:=StrToTime(OldGiustif.AOre);
    Q040.FieldByName('Scheda').AsString:=OldValidata;
  end;
  Q040.Post;
  with A000FGestioneTimbraGiustMW.FGiustificativi[R180Giorno(Data),NumGiustificativo] do
  begin
    Causale:=Q040.FieldByName('Causale').AsString;
    Tipo:=Q040.FieldByName('TipoGiust').AsString;
    DaOre:=Q040.FieldByName('DaOre').AsDateTime;
    AOre:=Q040.FieldByName('AOre').AsDateTime;
    DataNas:=Q040.FieldByName('DataNas').AsDateTime;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.ini
    CSITipoMG:=Q040.FieldByName('CSI_TIPO_MG').AsString;
    // ALESSANDRIA_COMUNE - commessa 2015/214 SVILUPPO#1.fine
  end;

  Result:=True;
//Gestione periodi di assenza
  if AssenzaOK then
  begin
    //L133 - Brunetta
    if Data >= EncodeDate(2008,6,25) then
    begin
      R600DtM1.scrDieciGiorniDopo.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      //R600DtM1.scrDieciGiorniDopo.SetVariable('CAUSALE',NewGiustif.Causale);
      R600DtM1.scrDieciGiorniDopo.SetVariable('DATA',Data);
      R600DtM1.scrDieciGiorniDopo.Execute;
      L133GGModif:=L133GGModif or (R600DtM1.scrDieciGiorniDopo.GetVariable('GGMODIF') > 0);
    end;
    with Periodiassenza do
    begin
      SetVariable('PROG',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('INIZIO',Data);
      SetVariable('FINE',Data);
      SetVariable('CAUS',OldGiustif.Causale);
      SetVariable('TG',OldGiustif.Modo);
      SetVariable('OPER','C');
      if (OldGiustif.Modo = 'I') or (OldGiustif.Modo = 'M') then
      begin
        SetVariable('DALLE','');
        SetVariable('ALLE','');
      end
      else if OldGiustif.Modo = 'N' then
      begin
        SetVariable('DALLE',OldGiustif.DaOre);
        SetVariable('ALLE','');
      end
      else if OldGiustif.Modo = 'D' then
      begin
        SetVariable('DALLE',OldGiustif.DaOre);
        SetVariable('ALLE',OldGiustif.AOre);
      end;
      Execute;
      SetVariable('CAUS',NewGiustif.Causale);
      SetVariable('TG',NewGiustif.Modo);
      SetVariable('OPER','I');
      if (NewGiustif.Modo = 'I') or (NewGiustif.Modo = 'M') then
      begin
        SetVariable('DALLE','');
        SetVariable('ALLE','');
      end
      else if NewGiustif.Modo = 'N' then
      begin
        SetVariable('DALLE',NewGiustif.DaOre);
        SetVariable('ALLE','');
      end
      else if NewGiustif.Modo = 'D' then
      begin
        SetVariable('DALLE',NewGiustif.DaOre);
        SetVariable('ALLE',NewGiustif.AOre);
      end;
      Execute;
    end;
  end;
  SessioneOracle.Commit;
end;

function TA023FTimbratureMW.ControlloAssenze(Assenza: TControlloAssenza; var CausAss:String):Boolean;
// Effettuo i conteggi delle assenze sull'assenza modificata
// non considerando il giustificativo originale
var
  CausPeriodi,ElencoCausali,Msg:String;
  ShowAnom: Boolean;
begin
  Result:=False;
  R600DtM1.OldGiustif:=Assenza.OldGiustif; //Causale Originale
  ElencoCausali:='';
  R600DtM1.RiferimentoDataNascita.Data:=Assenza.DataNas;
  //Caratto 8/10/2013
  //Simulato comportamento A004 (vedere InserisciGiustif di A004MW)
  case R600DtM1.SettaConteggi(Assenza.Progressivo,Assenza.Data,Assenza.Data,Assenza.NewGiustif) of
    mrOk:
    begin
      Result:=True;
    end;
    mrIgnore: //Non dovrebbe mai verificarsi.
    begin
      Result:=True;
    end;
    mrAbort:
    begin
      // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
      // la function Anomalie non visualizza più un messaggio interattivo
      // pertanto occorre prevederlo qui (solo se VisualizzaAnomalie è True)
      Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
           R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) +
           A000TraduzioneStringhe(A000MSG_A004_MSG_GG_STOP_INS);
      if R600DtM1.VisualizzaAnomalie then
        R180MessageBox(Msg,ESCLAMA);
      // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine

      // annulla operazione: abort
      Result:=False;
    end;
  end;

  if Result then
  begin
    while True do
    begin
      case R600DtM1.ControlliGenerali(Assenza.Data) of
        mrOK:
        begin
          Result:=True;
          Break; //interrompe ciclo
        end;
        mrAbort:
        begin
          ShowAnom:=True;
          if (R600DtM1.AnomaliaAssenze = 20) and (not R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').IsNull) then
          begin
            if Pos(',' + R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString + ',',',' + ElencoCausali + ',') = 0 then
            begin
              Assenza.NewGiustif.Causale:=R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString;
              CausAss:=Assenza.NewGiustif.Causale;
              ElencoCausali:=ElencoCausali + ',' + Assenza.NewGiustif.Causale;
              R600DtM1.SettaConteggi(Assenza.Progressivo,Assenza.Data,Assenza.Data,Assenza.NewGiustif);
              ShowAnom:=False; //Riprova con causale successiva
              Continue;
            end;
          end;

          if ShowAnom then
          begin
            // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.ini
            // la function Anomalie non visualizza più un messaggio interattivo
            // pertanto occorre prevederlo qui (solo se VisualizzaAnomalie è True)
            Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
                                        R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) +
                                        A000TraduzioneStringhe(A000MSG_A004_MSG_GG_STOP_INS);
            R600DtM1.ListAnomalie.Clear;
            if R600DtM1.VisualizzaAnomalie then
            begin
              // annulla giorno (ignore), annulla operazione (abort)
              R180MessageBox(Msg,ESCLAMA,A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600));
              Result:=False;
              Break;
              end
            else
            begin
              // annulla operazione: abort
              Result:=False;
              Break;
            end;
            // commessa MAN/08 - SVILUPPO#56 - riesame del 07.10.2013.fine
          end;
        end;
        mrIgnore:
        begin
          if (R600DtM1.AnomaliaAssenze > 0) or (R600DtM1.GGSignific) then
          begin
            Msg:=A000TraduzioneStringhe(A000MSG_A004_MSG_PRESENZA_ANOMALIE) + CRLF +
                                        R600DtM1.FormattaAnomaliaWeb(R600DtM1.ListAnomalie) +
                                        A000TraduzioneStringhe(A000MSG_MSG_CONTINUA_ANOM);
                                        R600DtM1.ListAnomalie.Clear;
            if R600Dtm1.VisualizzaAnomalie and (not R600DtM1.GGSignific) then
            begin
              // richiesta di ignorare anomalie
              // continua (si), annulla (no)
              case R180MessageBox(Msg,DOMANDA,A000TraduzioneStringhe(A000MSG_MSG_ANOMALIE_R600)) of
                mrYes:
                begin
                  // continua:
                  Result:=True;
                  Break;
                end;
                mrNo:
                begin
                  // annulla giorno:
                  Result:=False;
                  Break;
                end;
              end;
            end
            else
            begin
              // annulla operazione
              Result:=False;
              Break;
            end;
          end
          else
          begin
            //non ci sono anomalie. Non dovrebbe mai capitare
            Result:=True;
            Break;
          end;
        end;
      end;
    end;
  end;

  if Result and
     //(Assenza.NewGiustif.Modo = 'I')
     (R600DtM1.CheckScaricoPagheFruiz(R600DtM1.Q265.FieldByName('CODCAU3').AsString,Assenza.NewGiustif.Modo,Assenza.Data) = 'S')
  then
  begin
    // decreto brunetta: modifica causale per i primi 10 giorni di assenza
    if (Assenza.Data >= EncodeDate(2008,06,25)) and
       (not R600DtM1.Q265.FieldByName('CODCAU3').IsNull) then
    begin
      with R600DtM1.scrDieciGiorniPrima do
      begin
        SetVariable('PROGRESSIVO',Assenza.Progressivo);
        SetVariable('DATA',Assenza.Data);
        SetVariable('GSIGNIFIC',R600DtM1.Q265.FieldByName('GSIGNIFIC').AsString);
        CausPeriodi:=Assenza.NewGiustif.Causale + ',' + R600DtM1.Q265.FieldByName('CODCAU2').AsString;
        CausPeriodi:='''' + StringReplace(CausPeriodi,',',''',''',[rfReplaceAll]) + '''';
        SetVariable('CAUSPERIODI',CausPeriodi);
        Execute;
        if GetVariable('NUMGG') <= 9 then
        begin
          CausAss:=R600DtM1.Q265.FieldByName('CODCAU3').AsString;
        end;
      end;
    end;
    // decreto brunetta.fine
  end;
end;

function TA023FTimbratureMW.ConteggiGiornalieri(Giorno:TDateTime): TConteggiGiorno;
{Richiama i conteggi e li visualizza nelle TLabel}
var HReali,Scostam:SmallInt;
    i,j:Integer;
    S:String;
begin
  tmpLstAnomalieGiorno.clear();
  R502ProDtM1.Conteggi('Cartellino',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Giorno);
  Result.Repaint:=False;
  Result.Blocca:=False;
  Result.OrarioFontNero:=False;
  Result.TurniFontNero:=False;
  // allineamento timbrature automatico - daniloc 17.11.2009
  // se l'anomalia è "timbr. non in sequenza" (R502ProDtM1.Blocca = 2) ->
  //   esegue l'allineamento timbrature nel giorno per tentare di risolvere il problema
  if R502ProDtM1.Blocca = 2 then
  begin
    AllineamentoTimbrature(Giorno);
    Result.Repaint:=True;
    // riesegue i conteggi per il giorno
    R502ProDtM1.Conteggi('Cartellino',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Giorno);
  end;
  //allineamento timbrature automatico.fine

  //Anomalie bloccanti
  if R502ProDtM1.Blocca <> 0 then
  begin
    tmpLstAnomalieGiorno.Add(DateToStr(Giorno) + ': anomalia bloccante! ' + R502ProDtM1.DescAnomaliaBloccante);
    Result.OreLavorate:='Anom.';
    Result.Scostamento:='';
    Result.Debito:='';
    Result.EscluseDaNorm:='';
    Result.Blocca:=True;
  end;
  //Anomalie di secondo livello
  for i:=0 to High(R502ProDtM1.tanom2riscontrate) do
  begin
    if tdescanom2[R502ProDtM1.tanom2riscontrate[i].ta2puntdesc].F = 1 then
      S:=R502ProDtM1.tanom2riscontrate[i].ta2caus + ':'
    else
      S:='';
    tmpLstAnomalieGiorno.Add(DateToStr(Giorno) + ': anomalia di 2° livello! ' +
              S + tdescanom2[R502ProDtM1.tanom2riscontrate[i].ta2puntdesc].D);
  end;
  //Anomalie di terzo livello
  for i:=0 to High(R502ProDtM1.tanom3riscontrate) do
  begin
    tmpLstAnomalieGiorno.Add(DateToStr(Giorno) + ': anomalia di 3° livello! [' +
                  R180MinutiOre(R502ProDtM1.tanom3riscontrate[i].ta3timb) + ']: ' +
                  tdescanom3[R502ProDtM1.tanom3riscontrate[i].ta3puntdesc].D);
    if R502ProDtM1.tanom3riscontrate[i].ta3puntdesc in [4,6,11] then
      tmpLstAnomalieGiorno.Add(R180Spaces('',45) + R502ProDtM1.tanom3riscontrate[i].ta3desc);
  end;
  if R502ProDtM1.Blocca <> 0 then
  begin
    exit;
  end;

  HReali:=0;
  for i:=1 to R502ProDtM1.n_fasce do
    inc(HReali,R502ProDtM1.tminlav[i]);
  Scostam:=HReali - R502ProDtM1.DebitoGG;
  Result.OreLavorate:=R180MinutiOre(HReali);
  Result.Scostamento:=R180MinutiOre(Scostam);
  Result.Debito:=R180MinutiOre(R502ProDtM1.DebitoGG);
  Result.EscluseDaNorm:=R180MinutiOre(R502ProDtM1.minlavesc);
  //Se non c'è pianificazione visualizzo l'orario utilizzato
  if R502ProDtM1.Pianif = 'no' then
  begin
    Result.OrarioFontNero:=true;
    Result.Orario:=R502ProDtM1.c_orario;
  end
  else
  //caratto 26/11/2013. Utente: MONDOEDP -  Chiamata: 79584 Ini. L'orario veniva sovrascritto in caso di conteggi attivi
  begin
    Result.OrarioFontNero:=False;
    Result.Orario:='';
  end;
  //Utente: MONDOEDP -  Chiamata: 79584 fine.
  //caratto 02/12/2013. Utente: MONDOEDP - Ini - il turno veniva sovrascritto in caso di conteggi attivi
  Result.TurniDaConteggio:=False;
  if (R502ProDtM1.c_turni1 = -1) then
  begin
    Result.TurniDaConteggio:=True;
    Result.Turni:='';
    if (R502ProDtM1.r_turno1 > 0) or (R502ProDtM1.r_turno1 = -8) then
    begin
      Result.TurniFontNero:=True;
      Result.Turni:=Format('%2s',[IntToStr(R502ProDtM1.r_turno1)]);
      if R502ProDtM1.r_turno2 > 0 then
        Result.Turni:=Result.Turni + Format('%2s',[IntToStr(R502ProDtM1.r_turno2)]);
    end;
  end;
  //caratto 02/12/2013. Utente: MONDOEDP - Fine - il turno veniva sovrascritto in caso di conteggi attivi
end;

function TA023FTimbratureMW.getLstAnomalieConteggiGiornalieri: TStringList;
begin
  Result:=tmpLstAnomalieGiorno;
end;

(*
function TA023FTimbratureMW.ControlloAssenze(Assenza: TControlloAssenza; var CausAss:String):Boolean;
// Effettuo i conteggi delle assenze sull'assenza modificata
// non considerando il giustificativo originale
var
  CausPeriodi,ElencoCausali:String;
begin
  //with A023FGestGiustif do
  begin
    Result:=False;
    R600DtM1.OldGiustif:=Assenza.OldGiustif; //Causale Originale
    ElencoCausali:='';
    R600DtM1.RiferimentoDataNascita.Data:=Assenza.DataNas;
    if R600DtM1.SettaConteggi(Assenza.Progressivo,Assenza.Data,Assenza.Data,Assenza.NewGiustif) = mrOK then
    while True do
    case ControlliGenerali(Assenza.Data) of
      mrOK:
      begin
        Result:=True;
        // decreto brunetta: modifica causale per i primi 10 giorni di assenza
        if (Assenza.Data >= EncodeDate(2008,06,25)) and
           (not R600DtM1.Q265.FieldByName('CODCAU3').IsNull) then
        begin
          with R600DtM1.scrDieciGiorniPrima do
          begin
            SetVariable('PROGRESSIVO',Assenza.Progressivo);
            SetVariable('DATA',Assenza.Data);
            SetVariable('GSIGNIFIC',R600DtM1.Q265.FieldByName('GSIGNIFIC').AsString);
            CausPeriodi:=Assenza.NewGiustif.Causale + ',' + R600DtM1.Q265.FieldByName('CODCAU2').AsString;
            CausPeriodi:='''' + StringReplace(CausPeriodi,',',''',''',[rfReplaceAll]) + '''';
            SetVariable('CAUSPERIODI',CausPeriodi);
            Execute;
            if GetVariable('NUMGG') <= 9 then
            begin
              CausAss:=R600DtM1.Q265.FieldByName('CODCAU3').AsString;
            end;
          end;
        end;
        // decreto brunetta.fine
        Break;
      end;
      mrIgnore:
        Break;
      mrAbort:
        if (R600DtM1.AnomaliaAssenze = 20) and (not R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').IsNull) then
        begin
          if Pos(',' + R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString + ',',',' + ElencoCausali + ',') = 0 then
          begin
            Assenza.NewGiustif.Causale:=R600DtM1.Q265.FieldByName('CAUSALE_SUCCESSIVA').AsString;
            CausAss:=Assenza.NewGiustif.Causale;
            ElencoCausali:=ElencoCausali + ',' + Assenza.NewGiustif.Causale;
            R600DtM1.SettaConteggi(Assenza.Progressivo,Assenza.Data,Assenza.Data,Assenza.NewGiustif);
            Continue;
          end
          else
            Abort;
        end
        else
          Abort;
    end;
  end;
end;
*)




end.
