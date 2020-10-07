unit WR000UBaseDM;

interface

uses
  A000UCostanti, A000USessione, A000UMessaggi, A001UPasswordDtM1, C180FunzioniGenerali,
  L021Call, USelI010, DatiBloccati,
  Db, OracleData, Oracle, Variants, Math, DBClient,
  SysUtils, StrUtils, Classes, Graphics, Controls, Forms,
  IWInit, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase,
  IdSMTP, IWAppForm, IWApplication,
  meIWGrid, meIWLink, System.SyncObjs, System.Contnrs;

type
  // thread per invio mail asincrono
  TThreadMail = class(TThread)
  private
    C017DtMTh: TDataModule;
  protected
    procedure Execute; override;
  public
  end;

  TDatiModuliAccessori = record
    Azienda: String;
    Modulo: String;
    Abilitato: Boolean;
  end;

  TModuliAccessori = class(TComponent)
  private
    FModuliArr: array of TDatiModuliAccessori;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear;
    function  GetIndex(const PAzienda, PModulo: String): Integer;
    function  Add(const PAzienda, PModulo: String): Boolean;
    function  IsAbilitato(const PAzienda, PModulo: String): Boolean;
  end;

  THistoryTab = record
    F: TIWAppForm;
    LastAdded, Highlight: Boolean;
    Scheda,
    Chiudi: TmeIWLink;
  end;

  THistory = class(TComponent)
  private
    HistoryLinkArr: array of THistoryTab;
    function GetCount: Integer;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assegna(PFormParent: TIWAppForm);
    procedure Clear;
    procedure Disegna(PFormSelezionata: TIWAppForm);
    procedure SetHighlighted(PForm: TIWAppForm);
    function  FormByTag(PTag: Integer): TIWAppForm;
    function  FormByIndex(PIndex: Integer): TIWAppForm;
    function  FormPrev(F: TIWAppForm): TIWAppForm;
    function  FormNext(F: TIWAppForm): TIWAppForm;
    function  FormAdd(F: TIWAppForm): Integer;
    function  FormRemove(PIndex: Integer; ReleaseForm: Boolean = False): Boolean; overload;
    function  FormRemove(PForm: TIWAppForm; ReleaseForm: Boolean = False): Boolean; overload;
    procedure FormReleaseAll;
    property  Count: Integer read GetCount;
  end;

  TWR000FBaseDM = class(TDataModule)
    selaT033: TOracleDataSet;
    selT432: TOracleDataSet;
    selAnagrafe: TOracleDataSet;
    cdsAnagrafe: TClientDataSet;
    cdsI010: TClientDataSet;
    dsrAnagrafe: TDataSource;
    selI015: TOracleDataSet;
    cdsI015: TClientDataSet;
    selI076: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selAnagrafeAfterOpen(DataSet: TDataSet);
  private
    FIpAddressClient:String;
    FClientName:String;
    FPaginaIniziale:String;
    FPaginaSingola:String;
    function SessioneOracle: TOracleSession;
    procedure _MailImmediata(PDestResponsabile: Boolean; PProgressivo: Integer;
      const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
      const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
    procedure _MailDifferita(PDestResponsabile: Boolean; PProgressivo: Integer;
      const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
      const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
  protected
  public
    LogoutUrl: String;
    NumFrameVisualizzati,
    TimeoutDip,
    TimeoutOper: Integer;
    selI010: TselI010;
    selDatiBloccati: TDatiBloccati;
    lstCompInvisibili: TStringList;
    History: THistory;
    TipoUtente:String;            // Dipendente / Supervisore
    Responsabile: Boolean;        // utilizzato negli iter autorizzativi
    EsisteUtenteI070: Boolean;    // utilizzato per richiamo IrisWeb->IrisCloud->IrisWeb
    ModuliAccessori: TModuliAccessori;
    C700NavigatorBarMain: TmeIWGrid;
    W001FPasswordDtM:TA001FPasswordDtM1;
    function  GetSessioneLogin(DatabaseName:String):Integer;
    function  GetSessioneLavoro:Integer;
    procedure InizializzazioneW001DtM; virtual;
    function  SessioneDisponibile(Sessione:TOracleSession; CursPerSessione:Integer):Boolean;
    procedure InviaEMail(PDestResponsabile: Boolean; PProgressivo: Integer;
      const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
      const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
    property IpAddressClient:String read FIpAddressClient write FIpAddressClient;
    property ClientName:String read FClientName write FClientName;
    property PaginaIniziale:String read FPaginaIniziale write FPaginaIniziale;
    property PaginaSingola:String read FPaginaSingola write FPaginaSingola;
  end;

implementation

uses A000UInterfaccia, C017UEMailDtM, WR010UBase;

{$R *.DFM}

//############################################//
//###       GESTIONE MODULI ACCESSORI      ###//
//############################################//

constructor TModuliAccessori.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(FModuliArr,0);
end;

procedure TModuliAccessori.Clear;
begin
  SetLength(FModuliArr,0);
end;

function TModuliAccessori.GetIndex(const PAzienda, PModulo: String): Integer;
// estrae la posizione nell'array dei moduli accessori
var
  i: Integer;
  D: TDatiModuliAccessori;
begin
  Result:=-1;
  //ricerca nell'array
  for i:=Low(FModuliArr) to High(FModuliArr) do
  begin
    D:=FModuliArr[i];
    if (PAzienda = D.Azienda) and (PModulo = D.Modulo) then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function TModuliAccessori.Add(const PAzienda, PModulo: String): Boolean;
// aggiunge i dati relativi al modulo
// restituisce
// - True se l'elemento è stato inserito,
// - False se era già presente
var
  i, x: Integer;
begin
  if PAzienda = '' then
    raise Exception.Create('L''azienda non è indicata!');
  if PModulo = '' then
    raise Exception.Create('Il modulo non è indicato!');

  i:=GetIndex(PAzienda,PModulo);
  if i = -1 then
  begin
    // modulo non presente nell'array: lo aggiunge
    x:=Length(FModuliArr);
    SetLength(FModuliArr,x + 1);
    with FModuliArr[x] do
    begin
      Azienda:=PAzienda;
      Modulo:=PModulo;
      Abilitato:=Parametri.ModuloInstallato[PModulo];//A000ModuloAbilitato(SessioneOracle,PModulo,PAzienda);
    end;
    Result:=True;
  end
  else
  begin
    // modulo già presente nell'array
    Result:=False;
  end;
end;

function TModuliAccessori.IsAbilitato(const PAzienda, PModulo: String): Boolean;
// restituisce True/False a seconda che il modulo sia abilitato
var
  i: Integer;
begin
  // estrae la posizione nell'array
  i:=GetIndex(Pazienda, PModulo);
  try
    if i = -1 then
    begin
      // se il modulo non è stato trovato lo aggiunge all'array
      // e ne determina l'abilitazione
      if Add(PAzienda,PModulo) then
        i:=High(FModuliArr)
      else
        raise Exception.Create('Errore durante lettura abilitazioni per il modulo ' + PModulo);
    end;
    Result:=FModuliArr[i].Abilitato;
  except
    on E: Exception do
      try
        Result:=Parametri.ModuloInstallato[PModulo];//A000ModuloAbilitato(SessioneOracle,PModulo,PAzienda);
      except
        Result:=False
      end;
  end;
end;

//############################################//
//###           GESTIONE HISTORY           ###//
//############################################//
constructor THistory.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(HistoryLinkArr,0);
end;

destructor THistory.Destroy;
begin
  Clear;
  inherited;
end;

procedure THistory.Clear;
var
  i:Integer;
begin
  for i:=0 to High(HistoryLinkArr) do
  begin
    try
      FreeAndNil(HistoryLinkArr[i].Scheda);
      if HistoryLinkArr[i].Chiudi <> nil then
        FreeAndNil(HistoryLinkArr[i].Chiudi);
    except
    end;
  end;
  SetLength(HistoryLinkArr,0);
end;

function THistory.GetCount: Integer;
begin
  try
    Result:=Length(HistoryLinkArr);
  except
    Result:=0;
  end;
end;

procedure THistory.Assegna(PFormParent: TIWAppForm);
// assegna la history (intesa come oggetti che la compongono) alla form
// indicata come parametro, in modo che quest'ultima ne diventi il Parent
var
  i: Integer;
begin
  for i:=0 to High(HistoryLinkArr) do
  begin
    HistoryLinkArr[i].Scheda.Parent:=PFormParent;
    if not (HistoryLinkArr[i].F as TWR010FBase).medpFissa then
      HistoryLinkArr[i].Chiudi.Parent:=PFormParent;
  end;
end;

procedure THistory.Disegna(PFormSelezionata: TIWAppForm);
// ridisegna la grafica della history, evidenziando come selezionata la form
// passata come parametro
var
  i: Integer;
  S1,S2,NomeTab,Classe,Effetto: String;
  Scheda,Chiudi: TmeIWLink;
  TmpForm: TWR010FBase;
begin
  if ((PFormSelezionata as TWR010FBase).IsLoginForm) or
     (Length(HistoryLinkArr) = 0) then
  begin
    S1:='';
    S2:='';
  end
  else
  begin
    if (WR000DM.PaginaSingola <> '') and (WR000DM.PaginaSingola = WR000DM.PaginaIniziale) then
      S1:='document.getElementById("bndHistory").className = "invisibile";' + CRLF
    else
      S1:='document.getElementById("bndHistory").className = "";' + CRLF;
    S2:='';
    for i:=0 to High(HistoryLinkArr) do
    begin
      Scheda:=HistoryLinkArr[i].Scheda;
      TmpForm:=(HistoryLinkArr[i].F as TWR010FBase);

      // 1. gestione scheda
      NomeTab:='tab' + Copy(Scheda.Name,4);
      Effetto:='';
      if PFormSelezionata = TmpForm then
      begin
        // la form è quella selezionata
        if HistoryLinkArr[i].LastAdded then
          Effetto:='.fadeIn(900)'
        else if HistoryLinkArr[i].Highlight then
        begin
          Effetto:=''; // '.effect("highlight")';  per ora l'effetto di evidenziazione è rimosso;
          HistoryLinkArr[i].Highlight:=False;
        end
        else
          Effetto:='';
        Classe:='history sel';
        Scheda.OnClick:=nil; // il tab non deve essere cliccabile

        // effetto fade in fase di apertura della nuova pagina
        S2:=S2 + 'try { ' + CRLF +
                 '  var $elem = jQuery.root.find("#T000contenuto"); ' + CRLF +
                 '  if (($elem.length) && ($elem.hasClass("invisibile"))) { ' + CRLF +
                 IfThen(HistoryLinkArr[i].LastAdded,
                 '    $elem.fadeIn(500); ',
                 '    $elem.removeClass("invisibile"); ') + CRLF +
                 '  } ' + CRLF +
                 '} ' + CRLF +
                 'catch(err) { ' + CRLF +
                 '  try { document.getElementById("T000contenuto").className = ""; } catch(err2) {} ' + CRLF +
                 '} ' + CRLF;
      end
      else
      begin
        // la form non è quella selezionata
        // se la form selezionata è modale disabilita la selezione degli altri tab
        if (PFormSelezionata as TWR010FBase).medpModale then
        begin
          Classe:='history disab';
          Scheda.OnClick:=nil;
        end
        else
        begin
          Classe:='history';
          Scheda.OnClick:=(PFormSelezionata as TWR010FBase).actLinkSelect;
        end;
      end;
      // aggiorna dati della scheda
      Scheda.Caption:=(TmpForm as TWR010FBase).medpNomeFunzione;
      Scheda.Hint:=(TmpForm as TWR010FBase).medpInfoFunzione;
      Scheda.ShowHint:=(Scheda.Hint <> '');
      Scheda.Css:='scheda' + IfThen(Scheda.ShowHint,' tooltipHistory');
      Scheda.Parent:=PFormSelezionata; // imposta come parent la form selezionata: molto importante!

      // effetti di visualizzazione tab
      S1:=S1 + Format('document.getElementById("%s").className = "%s";',[NomeTab,IfThen(Effetto = '',Classe,'invisibile')]) + CRLF;
      if Effetto <> '' then
        S2:=S2 + Format('jQuery.root.find("#%s").addClass("%s")%s;',[NomeTab,Classe,Effetto]) + CRLF;

      // 2. gestione immagine di chiusura tab
      // gestisce la chiusura solo se la form non è fissa
      // (altrimenti il link non esiste)
      if not TmpForm.medpFissa then
      begin
        Chiudi:=HistoryLinkArr[i].Chiudi;
        // se la form selezionata è modale disabilita la chiusura degli altri tab
        if (PFormSelezionata <> TmpForm) and
           ((PFormSelezionata as TWR010FBase).medpModale) then
          Chiudi.OnClick:=nil
        else
          Chiudi.OnClick:=(PFormSelezionata as TWR010FBase).actLinkClose;
        Chiudi.Parent:=PFormSelezionata;
      end;

      // altre impostazioni
      HistoryLinkArr[i].LastAdded:=False;
    end;
  end;

  // impostazioni per disegno history ed effetti
  with (PFormSelezionata as TWR010FBase) do
  begin
    TagJsHistory:=S1; // utilizzato come tag nell'intestazione T000
    if jQHistory.Enabled then
      jQHistory.OnReady.Text:=S2;
  end;
end;

procedure THistory.SetHighlighted(PForm: TIWAppForm);
// inutilizzato
// segna la form indicata come da evidenziare graficamente
var
  i: Integer;
  Found: Boolean;
begin
  Found:=False;
  for i:=0 to High(HistoryLinkArr) do
  begin
    if PForm = HistoryLinkArr[i].F then
    begin
      Found:=True;
      Break;
    end;
  end;

  if Found then
    HistoryLinkArr[i].Highlight:=True;
end;

function THistory.FormByTag(PTag: Integer): TIWAppForm;
var
  i: Integer;
begin
  Result:=nil;
  for i:=0 to High(HistoryLinkArr) do
  begin
    if PTag = HistoryLinkArr[i].F.Tag then
    begin
      Result:=HistoryLinkArr[i].F;
      Break;
    end;
  end;
end;

function THistory.FormByIndex(PIndex: Integer): TIWAppForm;
begin
  if (PIndex >= 0) and
     (PIndex < Length(HistoryLinkArr)) then
    Result:=HistoryLinkArr[PIndex].F
  else
    Result:=nil;
end;

function THistory.FormPrev(F: TIWAppForm): TIWAppForm;
// estrae la form precedente a quella indicata nella history
var
  i: Integer;
begin
  Result:=nil;

  if Length(HistoryLinkArr) = 0 then
    Exit;

  // se si tratta della prima form -> restituisce nil
  if F = HistoryLinkArr[0].F then
    Exit;

  // ciclo di ricerca elemento
  for i:=1 to High(HistoryLinkArr) do
    if F = HistoryLinkArr[i].F then
    begin
      Result:=HistoryLinkArr[i - 1].F;
      Break;
    end;
end;

function THistory.FormNext(F: TIWAppForm): TIWAppForm;
// estrae la form successiva a quella indicata nella history
var
  i: Integer;
begin
  Result:=nil;

  if Length(HistoryLinkArr) = 0 then
    Exit;

  // se si tratta dell'ultima form -> restituisce nil
  if F = HistoryLinkArr[High(HistoryLinkArr)].F then
    Exit;

  // ciclo di ricerca elemento
  for i:=High(HistoryLinkArr) - 1 downto 0 do
    if F = HistoryLinkArr[i].F then
    begin
      Result:=HistoryLinkArr[i + 1].F;
      Break;
    end;
end;

function THistory.FormAdd(F: TIWAppForm): Integer;
// aggiunge la form indicata alla history
// e restituisce la posizione dell'array in cui è stata aggiunta
// oppure -1 in caso di errore
var
  i: Integer;
begin
  if Length(HistoryLinkArr) >= ELEMENTI_HISTORY then
  begin
    // shift a sx dell'elenco per fare spazio alla nuova form
    // (si perde la prima form non "fissa")
    //Rimuove la prima form non fissa per la quale si può chiudere il tab
    //e senza richiesta di conferma
    for i:=0 to High(HistoryLinkArr) do
    begin
      HistoryLinkArr[i].Scheda.Parent:=nil;
      if HistoryLinkArr[i].Chiudi <> nil then
        HistoryLinkArr[i].Chiudi.Parent:=nil;
    end;
    for i:=0 to High(HistoryLinkArr) do
      if FormRemove(i,True) then
        Break;
  end;

  // aggiunge il corrispondente nuovo "tab"
  SetLength(HistoryLinkArr,Length(HistoryLinkArr) + 1);
  i:=High(HistoryLinkArr);

  // form
  HistoryLinkArr[i].F:=F;
  HistoryLinkArr[i].LastAdded:=True;
  HistoryLinkArr[i].HighLight:=False;

  // scheda
  HistoryLinkArr[i].Scheda:=TmeIWLink.Create(Self);
  with HistoryLinkArr[i].Scheda do
  begin
    Name:=Format('lnkHistory%.2d',[i + 1]);
    Tag:=i;
  end;

  // link di chiusura funzione
  if not TWR010FBase(F).medpFissa then
  begin
    HistoryLinkArr[i].Chiudi:=TmeIWLink.Create(Self);
    with HistoryLinkArr[i].Chiudi do
    begin
      Name:=Format('lnkHistoryX%.2d',[i + 1]);
      Caption:=' ';
      Tag:=i;
      Css:='chiudi';
      Hint:=A000TraduzioneStringhe(A000MSG_MSG_CHIUDI_SCHEDA);
      ShowHint:=True;
    end;
  end;

  Result:=i;
end;

function THistory.FormRemove(PIndex: Integer; ReleaseForm: Boolean = False): Boolean;
// rimuove la form indicata dalla history
var
  i: Integer;
begin
  Result:=False;
  if (PIndex < Low(HistoryLinkArr)) or
     (PIndex > High(HistoryLinkArr)) then
    Exit;

  if HistoryLinkArr[PIndex].F <> nil then
  begin
    // gestione form "fisse"
    if TWR010FBase(HistoryLinkArr[PIndex].F).medpFissa then
      Exit;

    // se richiesto distrugge la form
    if ReleaseForm then
      try HistoryLinkArr[PIndex].F.Release; except end;
  end;

  // pulizia elemento
  HistoryLinkArr[PIndex].F:=nil;
  FreeAndNil(HistoryLinkArr[PIndex].Scheda);
  FreeAndNil(HistoryLinkArr[PIndex].Chiudi);

  // shift a sinistra delle altre form
  for i:=PIndex to High(HistoryLinkArr) - 1 do
  begin
    HistoryLinkArr[i]:=HistoryLinkArr[i + 1];
    // importante: aggiorna i nomi e i tag dei link
    HistoryLinkArr[i].Scheda.Name:=Format('lnkHistory%.2d',[i + 1]);
    HistoryLinkArr[i].Scheda.Tag:=i;
    HistoryLinkArr[i].Chiudi.Name:=Format('lnkHistoryX%.2d',[i + 1]);
    HistoryLinkArr[i].Chiudi.Tag:=i;
  end;

  // decrementa lunghezza array
  SetLength(HistoryLinkArr,Length(HistoryLinkArr) - 1);
  Result:=True;
end;

function THistory.FormRemove(PForm: TIWAppForm; ReleaseForm: Boolean = False): Boolean;
// rimuove la form indicata dalla history
var
  i: Integer;
begin
  Result:=False;
  for i:=0 to High(HistoryLinkArr) do
  begin
    if PForm = HistoryLinkArr[i].F then
    begin
      Result:=FormRemove(i,ReleaseForm);
      Break;
    end;
  end;
end;

procedure THistory.FormReleaseAll;
// release di tutte le form presenti nella history
var
  i: Integer;
  F: TIWAppForm;
begin
  for i:=High(HistoryLinkArr) downto 0 do
  begin
    if not FormRemove(i,True) then
    begin
      // la form non è eliminabile: la seleziona e termina il ciclo
      F:=FormByIndex(i);
      Assegna(F);
      SetHighlighted(F);
      with (F as TWR010FBase) do
      begin
        RefreshPageAttivo:=True;
        Show;
      end;
      Break;
    end;
  end;
end;


//############################################//
//###         GESTIONE DATAMODULE          ###//
//############################################//
function TWR000FBaseDM.SessioneOracle: TOracleSession;
begin
  Result:=TSessioneWeb(TIWApplication(Owner).Data).SessioneIrisWIN.SessioneOracle;
end;

procedure TWR000FBaseDM.DataModuleCreate(Sender: TObject);
// questa funzione viene richiamata due volte
// evitare l'utilizzo di GGetWebApplicationThreadVar, che in alcuni casi potrebbe
// non essere inizializzato
// utilizzare invece Owner (facendo il downcast a TIWApplication)
var
  i: Integer;
begin
 try
  // Owner dovrebbe essere TIWApplication
  // dare errore se è nil
  if Owner = nil then
  begin
    W000RegistraLog('Errore',Format('%sDataModuleCreate: Owner = nil',[GetTestoLog('WR000')]));
    Exit;
  end;

  // assegnazione sessione oracle
  if (Owner as TIWApplication).Data <> nil then
  begin
    for i:=0 to ComponentCount - 1 do
    begin
      if Components[i] is TOracleQuery then
        try (Components[i] as TOracleQuery).Session:=SessioneOracle; except end
      else if Components[i] is TOracleDataSet then
        try (Components[i] as TOracleDataSet).Session:=SessioneOracle; except end;
    end;

    if selI010 = nil then
      selI010:=TselI010.Create((Owner as TIWApplication));

    if selDatiBloccati = nil then
    begin
      selDatiBloccati:=TDatiBloccati.Create(nil);
      selDatiBloccati.TipoLog:='';
    end;
  end;

  // gestione campi da non visualizzare
  if lstCompInvisibili = nil then
  begin
    lstCompInvisibili:=TStringList.Create;
    lstCompInvisibili.CommaText:=UpperCase(W000ParConfig.CampiInvisibili);
  end;

  // creazione history
  if History = nil then
    History:=THistory.Create(Self)
  else
    History.Clear;

  // creazione struttura per moduli accessori
  if ModuliAccessori = nil then
    ModuliAccessori:=TModuliAccessori.Create(Self)
  else
    ModuliAccessori.Clear;

  // inizializzazione variabili
  LogoutUrl:='';
  TimeoutDip:=0;
  TimeoutOper:=0;
  NumFrameVisualizzati:=0;

  if (Parametri <> nil) then
    Parametri.CampiRiferimento.C90_W038CheckIP:='S';
  // imposta le variabili per il dataset del filtro IP
  if (Parametri <> nil) and
     (Parametri.CampiRiferimento.C90_W038CheckIP = 'S') then
  begin
    selI076.Close;
    selI076.SetVariable('AZIENDA',Parametri.Azienda);
    // in irisweb non si considera l'applicazione
    //selI076.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    selI076.SetVariable('PROFILO',Parametri.ProfiloFiltroFunzioni);
    selI076.Open;
  end;
 except
 end;
end;

function TWR000FBaseDM.GetSessioneLogin(DatabaseName:String):Integer;
var i:Integer;
    OS:TOracleSession;
begin
  Result:=-1;
  if Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) > 0 then
    exit;
  begin
    CSSessioneMondoEDP.Enter;
    try
      for i:=0 to lstSessioniMondoEDP.Count - 1 do
      begin
        try
          if TOracleSession(lstSessioniMondoEDP[i]).LogonDatabase <> DatabaseName then
            Continue;
          if (Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0) and
             (TOracleSession(lstSessioniMondoEDP[i]).CheckConnection(W000ParConfig.ReconnectSession) = ccError) then
            Continue
          else if (Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) > 0) and (not TOracleSession(lstSessioniMondoEDP[i]).Connected) then
          try
            TOracleSession(lstSessioniMondoEDP[i]).Logon;
          except
            Continue;
          end
          else
            ;//TOracleSession(lstSessioniMondoEDP[i]).Tag:=0;
          if (TOracleSession(lstSessioniMondoEDP[i]).Tag > 0) and (not WR000DM.SessioneDisponibile(TOracleSession(lstSessioniMondoEDP[i]),W000ParConfig.CursoriLogin)) then
            Continue;
        except
          Continue;
        end;
        TOracleSession(lstSessioniMondoEDP[i]).Tag:=TOracleSession(lstSessioniMondoEDP[i]).Tag + 1;
        Result:=i;
        Break;
      end;
      if Result = -1 then
      begin
        OS:=TOracleSession.Create(nil);
        OS.NullValue:=nvNull;
        OS.Preferences.ZeroDateIsNull:=False;
        OS.Preferences.TrimStringFields:=False;
        OS.Preferences.UseOCI7:=False;
        OS.Cursor:=crSQLWait;
        OS.ThreadSafe:=True;
        OS.Tag:=1;
        OS.StatementCache:=Pos(INI_PAR_DB_STATEMENT_CACHE,W000ParConfig.ParametriAvanzati) > 0;
        if OS.StatementCache then
          OS.StatementCacheSize:=50;
        lstSessioniMondoEDP.Add(OS);
        Result:=lstSessioniMondoEDP.Count - 1;
      end;
      W001FPassWordDtM.SessioneMondoEDP:=TOracleSession(lstSessioniMondoEDP[Result]);
    finally
      CSSessioneMondoEDP.Leave;
    end;
  end;
end;

function TWR000FBaseDM.GetSessioneLavoro:Integer;
var i:Integer;
    OS:TOracleSession;
begin
  Result:=-1;
  (*Annullato
  A000SettaVariabiliAmbiente;
  *)
  CSSessioniOracle.Enter;
  try
    for i:=0 to lstSessioniOracle.Count - 1 do
    begin
      try
        if TOracleSession(lstSessioniOracle[i]) = nil then
          Continue;
        if not Assigned(TOracleSession(lstSessioniOracle[i])) then
          Continue;
        if (Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0) and
           (TOracleSession(lstSessioniOracle[i]).CheckConnection(W000ParConfig.ReconnectSession) = ccError) then
          Continue;
        if (TOracleSession(lstSessioniOracle[i]).LogonUserName <> Parametri.UserName) or
           (TOracleSession(lstSessioniOracle[i]).LogonDatabase <> Parametri.DataBase) then
          Continue;
        if (Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) > 0) and (not TOracleSession(lstSessioniOracle[i]).Connected) then
        try
          TOracleSession(lstSessioniOracle[i]).Logon;
        except
          Continue;
        end;
        {$IFNDEF WEBPJ}
        if (TOracleSession(lstSessioniOracle[i]).Tag > 0) and (not WR000DM.SessioneDisponibile(TOracleSession(lstSessioniOracle[i]),W000ParConfig.CursoriSessione)) then
          Continue;
        {$ELSE}
        //Per IrisCLOUD una sessione oracle per ogni sessione web. se però la sessione è scaduta
        //riutilizzo la connessione db (tag 0 non usata da nessuno) e non ne creo una ulteriore
        if (TOracleSession(lstSessioniOracle[i]).Tag > 0)then
          Continue;
        {$ENDIF}
      except
        Continue;
      end;

      if (lstSessioniOracle[i] as TOracleSession).Tag = 0 then
        A000ParamDBOracle(lstSessioniOracle[i] as TOracleSession)
      else
        A000SetParametri(lstSessioniOracle[i] as TOracleSession);

      (lstSessioniOracle[i] as TOracleSession).Tag:=(lstSessioniOracle[i] as TOracleSession).Tag + 1;
      if (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Name <> 'SessioneIrisWEB' then
        try (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Free; except end;
      (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle:=(lstSessioniOracle[i] as TOracleSession);
      Result:=i;
      Break;
    end;

    if Result = -1 then
    begin
      OS:=TOracleSession.Create(nil);
      OS.Name:='SessioneIrisWEB';
      OS.NullValue:=nvNull;
      OS.Preferences.ZeroDateIsNull:=False;
      OS.Preferences.TrimStringFields:=False;
      OS.Preferences.UseOCI7:=False;
      OS.Cursor:=crSQLWait;
      OS.ThreadSafe:=True;
      OS.Tag:=1;
      OS.StatementCache:=Pos(INI_PAR_DB_STATEMENT_CACHE,W000ParConfig.ParametriAvanzati) > 0;
      if OS.StatementCache then
        OS.StatementCacheSize:=100;
      A000ParamDBOracle(OS);
      lstSessioniOracle.Add(OS);
      Result:=lstSessioniOracle.Count - 1;
      if (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Name <> 'SessioneIrisWEB' then
        try (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle.Free; except end;
      (GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.SessioneOracle:=OS;
    end;
  finally
    IndennitaTurno:=True;
    CSSessioniOracle.Leave;
  end;
end;

procedure TWR000FBaseDM.InizializzazioneW001DtM;
var
  i: Integer;
  Ricerca,Posizione: Boolean;
  ElencoCampi,CampoCaptionLayout,CampiV430: String;
begin
  begin
    selaT033.Open;
    try
      if selaT033.SearchRecord('NOME',Parametri.Layout,[srFromBeginning]) then
        Parametri.Layout:=selaT033.FieldByName('NOME').AsString
      else if selaT033.SearchRecord('NOME',Parametri.Operatore,[srFromBeginning]) then
        Parametri.Layout:=selaT033.FieldByName('NOME').AsString
      else
        Parametri.Layout:='DEFAULT';
    except;
      Parametri.Layout:='DEFAULT';
    end;
    // data lavoro.ini
    Parametri.DataLavoro:=Date;
    IF FALSE THEN
    BEGIN
      R180SetVariable(selT432,'UTENTE',Parametri.Operatore);
      selT432.Open;
      if (selT432.RecordCount > 0) and
         (not selT432.FieldByName('DATA').IsNull) then
        Parametri.DataLavoro:=selT432.FieldByName('DATA').AsDateTime
      else
        Parametri.DataLavoro:=Date;
      selT432.CloseAll;
    END;
    // data lavoro.fine
    selaT033.CloseAll;

    //selI010
    CampoCaptionLayout:=IfThen(Pos(INI_PAR_CAPTION_LAYOUT,W000ParConfig.ParametriAvanzati) = 0,'NOME_LOGICO','CAPTION_LAYOUT||DECODE(CAMPO_DESCRIZIONE,0,NULL,'' (desc.)'')');
    ElencoCampi:=Format('NOME_CAMPO,DATA_TYPE,DATA_LENGTH,NOME_LOGICO,%s CAPTION_LAYOUT,RICERCA,POSIZIONE,ACCESSO',[CampoCaptionLayout]);
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
    // aggiunta dati di T033 finalizzati all'ordinamento della scheda anagrafe
    ElencoCampi:=ElencoCampi + ',NOMEPAGINA,decode(NOMEPAGINA,''Dati Anagrafici'',''0'',''Parametri orario'',''1'',''Presenze/Assenze'',''2'',NOMEPAGINA) NOMEPAGINA_ORD,TOP,LFT';
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.fine
    selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,ElencoCampi,'','RICERCA,POSIZIONE,NOME_LOGICO');
    cdsI010.Close;
    cdsI010.FieldDefs.Assign(selI010.FieldDefs);
    cdsI010.CreateDataSet;
    cdsI010.LogChanges:=False;
    cdsI010.IndexDefs.Clear;
    cdsI010.IndexDefs.Add('Visualizzazione',('POSIZIONE;NOME_LOGICO'),[ixPrimary,ixUnique]);
    cdsI010.IndexDefs.Add('Ricerca',('RICERCA;POSIZIONE;NOME_LOGICO'),[ixPrimary,ixUnique]);
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.ini
    // aggiunta indice per visualizzazione scheda anagrafe
    cdsI010.IndexDefs.Add('Layout',('NOMEPAGINA_ORD;TOP;LFT;NOME_LOGICO'),[ixPrimary,ixUnique]);
    // MONDOEDP - commessa MAN/02 SVILUPPO#110.fine
    CampiV430:='';
    Parametri.ColonneStruttura.Clear;
    Parametri.TipiStruttura.Clear;
    selI010.First;
    while not selI010.Eof do
    begin
      cdsI010.Append;
      for i:=0 to selI010.FieldCount - 1 do
      begin
        Ricerca:=(UpperCase(selI010.Fields[i].FieldName) = 'RICERCA');
        Posizione:=(UpperCase(selI010.Fields[i].FieldName) = 'POSIZIONE');
        // i valori nulli dei campi RICERCA e POSIZIONE sono sostituiti con un valore numerico molto elevato
        if (Ricerca or Posizione) and (selI010.Fields[i].IsNull) then
          cdsI010.Fields[i].Value:=IfThen(Ricerca,RICERCA_NULL,POSIZIONE_NULL)
        else
          // copia del valore nel campo del clientdataset
          cdsI010.Fields[i].Value:=selI010.Fields[i].Value;
      end;
      cdsI010.Post;
      if ((Copy(cdsI010.FieldByName('NOME_CAMPO').AsString,1,4) = 'T430') or
          (Copy(cdsI010.FieldByName('NOME_CAMPO').AsString,1,4) = 'P430')) and
          //(cdsI010.FieldByName('POSIZIONE').Value <> POSIZIONE_NULL) and
          (cdsI010.FieldByName('ACCESSO').AsString <> 'N') then
        CampiV430:=CampiV430 + 'V430.' + cdsI010.FieldByName('NOME_CAMPO').AsString + ',';

      Parametri.ColonneStruttura.Add(Format('%s=%s',[selI010.FieldByName('NOME_LOGICO').AsString,selI010.FieldByName('NOME_CAMPO').AsString]));
      if selI010.FieldByName('DATA_TYPE').AsString = 'VARCHAR2' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftString)))
      else if selI010.FieldByName('DATA_TYPE').AsString = 'NUMBER' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftInteger)))
      else if selI010.FieldByName('DATA_TYPE').AsString = 'DATE' then
        Parametri.TipiStruttura.Add(IntToStr(Ord(ftDateTime)));
      selI010.Next;
    end;
    FreeAndNil(selI010);
    if CampiV430 <> '' then
      CampiV430:=',' + Copy(CampiV430,1,Length(CampiV430) - 1);
    if Pos(',V430.T430BADGE,',',' + CampiV430 + ',') = 0 then
      CampiV430:=CampiV430 + ',V430.T430BADGE';

    selAnagrafe.SQL.Clear;
    selAnagrafe.SQL.Text:=QVistaOracle;
    selAnagrafe.SQL.Insert(0,Format('SELECT %s T030.*,T480.CITTA, T480.PROVINCIA %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,CampiV430]));
    selAnagrafe.SQL.Add(':FILTRO_IN_SERVIZIO');
    selAnagrafe.SQL.Add(':FILTRO');
    selAnagrafe.DeleteVariables;
    selAnagrafe.DeclareVariable('DATALAVORO',otDate);
    selAnagrafe.DeclareVariable('FILTRO',otSubst);
    selAnagrafe.DeclareVariable('FILTRO_IN_SERVIZIO',otSubst);

    // utilizzo di clientdataset per localizzazione
    Parametri.cdsI015:=nil;
    selI015.SetVariable('AZIENDA',Parametri.Azienda);
    selI015.SetVariable('LINGUA',UpperCase(Parametri.CampiRiferimento.C90_Lingua));
    selI015.SetVariable('APPLICAZIONE','W000');
    try
      selI015.Open;
      cdsI015.Filtered:=False;
      cdsI015.Close;
      cdsI015.FieldDefs.Assign(selI015.FieldDefs);
      cdsI015.FieldDefs.Find('CAPTION').Required:=False;
      cdsI015.CreateDataSet;
      cdsI015.LogChanges:=False;
      cdsI015.IndexDefs.Clear;
      cdsI015.IndexDefs.Add('Primario',('LINGUA;APPLICAZIONE;MASCHERA'),[]);
      selI015.First;
      while not selI015.Eof do
      begin
        cdsI015.Append;
        for i:=0 to selI015.FieldCount - 1 do
          cdsI015.Fields[i].Value:=selI015.Fields[i].Value;
        cdsI015.Post;
        selI015.Next;
      end;
      if cdsI015.RecordCount > 0 then
        Parametri.cdsI015:=cdsI015;
    except
    end;
    selI015.CloseAll;
  end;
end;

function TWR000FBaseDM.SessioneDisponibile(Sessione:TOracleSession; CursPerSessione:Integer):Boolean;
var MOC:Integer;
begin
  MOC:=W000ParConfig.MaxOpenCursors;
  Result:=MOC - (Sessione.Tag * CursPerSessione) > CursPerSessione;
end;

//############################################//
//###             INVIO MAIL               ###//
//############################################//
procedure TWR000FBaseDM.InviaEMail(PDestResponsabile: Boolean; PProgressivo: Integer;
  const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
  const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
begin
  if Parametri.CampiRiferimento.C90_EmailThread = 'S' then
  begin
    // gestione invio mail con thread separato
    _MailDifferita(PDestResponsabile,PProgressivo,POggetto,PTesto,PTag,PIter,PCodIter,PLivelliDest,
                   PDestinatari,PDestinatariCC,PDestinatariCCN);
  end
  else
  begin
    // gestione invio mail normale
    _MailImmediata(PDestResponsabile,PProgressivo,POggetto,PTesto,PTag,PIter,PCodIter,PLivelliDest,
                   PDestinatari,PDestinatariCC,PDestinatariCCN);
  end;
end;

procedure TWR000FBaseDM.selAnagrafeAfterOpen(DataSet: TDataSet);
var
  NomeCampo: String;
  PosizioneNulla: Boolean;
begin
  if (cdsI010 <> nil) and (cdsI010.Active) then
  begin
    cdsI010.IndexName:='Visualizzazione';
    cdsI010.Filtered:=False;
    cdsI010.First;
    while not cdsI010.Eof do
    begin
      try
        NomeCampo:=cdsI010.FieldByName('NOME_CAMPO').AsString;
        PosizioneNulla:=(cdsI010.FieldByName('POSIZIONE').IsNull) or
                        (cdsI010.FieldByName('ACCESSO').AsString = 'N') or
                        (cdsI010.FieldByName('POSIZIONE').AsInteger = POSIZIONE_NULL);

        if selAnagrafe.FindField(NomeCampo) <> nil then
        begin
          // caption da layout anagrafico - daniloc 04.10.2010
          //selAnagrafe.FieldByName(NomeCampo).DisplayLabel:=cdsI010.FieldByName('NOME_LOGICO').AsString;
          selAnagrafe.FieldByName(NomeCampo).DisplayLabel:=cdsI010.FieldByName('CAPTION_LAYOUT').AsString;
          // caption da layout anagrafico.fine
          selAnagrafe.FieldByName(NomeCampo).Index:=IfThen(PosizioneNulla,POSIZIONE_NULL,cdsI010.FieldByName('POSIZIONE').AsInteger);
          selAnagrafe.FieldByName(NomeCampo).Visible:=not PosizioneNulla;
        end;
      except
      end;
      cdsI010.Next;
    end;
    selAnagrafe.FieldByName('COGNOME').Visible:=True;
    selAnagrafe.FieldByName('NOME').Visible:=True;
    selAnagrafe.FieldByName('MATRICOLA').Visible:=True;
    //selAnagrafe.FieldByName('T430BADGE').Visible:=True;
    selAnagrafe.FieldByName('COGNOME').Index:=0;
    selAnagrafe.FieldByName('NOME').Index:=1;
    selAnagrafe.FieldByName('MATRICOLA').Index:=2;
    //selAnagrafe.FieldByName('T430BADGE').Index:=3;
    selAnagrafe.FieldByName('PROGRESSIVO').Visible:=False;
    if selAnagrafe.FindField('T430PROGRESSIVO') <> nil then
      selAnagrafe.FieldByName('T430PROGRESSIVO').Visible:=False;
  end;
end;

procedure TWR000FBaseDM._MailImmediata(PDestResponsabile: Boolean; PProgressivo: Integer;
  const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
  const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
var
  C017DtM:TC017FEMailDtM;
  i: Integer;
  L: TStringList;
begin
  C017DtM:=TC017FEMailDtM.Create(GGetWebApplicationThreadVar);
  try
    try
      C017DtM.SollevaEccezioni:=True;
      C017DtM.Sessione:=SessioneOracle;
      C017DtM.DestResponsabile:=PDestResponsabile;
      C017DtM.Progressivo:=PProgressivo;
      C017DtM.Oggetto:=POggetto;
      C017DtM.Testo:=PTesto;
      C017DtM.TagFunzione:=PTag;
      C017DtM.Iter:=PIter;
      C017DtM.CodIter:=PCodIter;
      C017DtM.LivelliDest:=PLivelliDest;
      C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      C017DtM.InviaEMail;
    except
      on E:Exception do
        W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
    end;
  finally
    // riporta i messaggi di traccia su database
    try
      if (Pos('TRACCIA',W000ParConfig.LogAbilitati) > 0) and
         (C017DtM.Traccia <> '') then
      begin
        L:=TStringList.Create;
        try
          R180Tokenize(L,C017DtM.Traccia,'|');
          for i:=0 to L.Count - 1 do
            W000RegistraLog('Traccia',L[i]);
        finally
          L.Free;
        end;
      end;
    except
    end;
    FreeAndNil(C017DtM);
  end;

  if (PDestinatari <> '') or (PDestinatariCC <> '') or (PDestinatariCCN <> '') then
  begin
    // In questo caso in aggiunta alla mail inviata precedentemente ne inviamo una ai destinatari
    // esplicitamente indicati
    C017DtM:=TC017FEMailDtM.Create(GGetWebApplicationThreadVar);
    try
      try
        C017DtM.SollevaEccezioni:=True;
        C017DtM.Sessione:=SessioneOracle;
        C017DtM.DestResponsabile:=False;
        C017DtM.Oggetto:=POggetto;
        C017DtM.Testo:=PTesto;
        C017DtM.TagFunzione:=PTag;
        C017DtM.CercaDestinatari:=False;
        C017DtM.Destinatari:=PDestinatari;
        C017DtM.DestinatariCC:=PDestinatariCC;
        C017DtM.DestinatariCCN:=PDestinatariCCN;
        C017DtM.WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
        C017DtM.InviaEMail;
      except
        on E:Exception do
          W000RegistraLog('Errore',GetTestoLog('W001D',GGetWebApplicationThreadVar) + '[C017] ' + E.Message);
      end;
    finally
      // riporta i messaggi di traccia su database
      try
        if (Pos('TRACCIA',W000ParConfig.LogAbilitati) > 0) and
           (C017DtM.Traccia <> '') then
        begin
          L:=TStringList.Create;
          try
            R180Tokenize(L,C017DtM.Traccia,'|');
            for i:=0 to L.Count - 1 do
              W000RegistraLog('Traccia',L[i]);
          finally
            L.Free;
          end;
        end;
      except
      end;
      FreeAndNil(C017DtM);
      end;
  end;

end;

procedure TWR000FBaseDM._MailDifferita(PDestResponsabile: Boolean; PProgressivo: Integer;
  const POggetto,PTesto: String; const PTag:Integer = -1; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '';
  const PDestinatari: String = ''; const PDestinatariCC:String = ''; const PDestinatariCCN: String = '');
var
  ThMail,ThMail2: TThreadMail;
begin
  ThMail:=TThreadMail.Create(True);
  with ThMail do
  begin
    FreeOnTerminate:=True;
    C017DtMTh:=TC017FEMailDtM.Create(Self);
    with (C017DtMTh as TC017FEMailDtM) do
    begin
      SollevaEccezioni:=True;
      Sessione:=SessioneOracle;
      DestResponsabile:=PDestResponsabile;
      Progressivo:=PProgressivo;
      Oggetto:=POggetto;
      Testo:=PTesto;
      TagFunzione:=PTag;
      Iter:=PIter;
      CodIter:=PCodIter;
      LivelliDest:=PLivelliDest;
      WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
    end;
    Start;
  end;

  if (PDestinatari <> '') or (PDestinatariCC <> '') or (PDestinatariCCN <> '') then
  begin
    // In questo caso in aggiunta alla mail inviata precedentemente ne inviamo una ai destinatari
    // esplicitamente indicati
    ThMail2:=TThreadMail.Create(True);
    with ThMail2 do
    begin
      FreeOnTerminate:=True;
      C017DtMTh:=TC017FEMailDtM.Create(Self);
      with (C017DtMTh as TC017FEMailDtM) do
      begin
        SollevaEccezioni:=True;
        Sessione:=SessioneOracle;
        DestResponsabile:=False;
        Oggetto:=POggetto;
        Testo:=PTesto;
        TagFunzione:=PTag;
        CercaDestinatari:=False;
        Destinatari:=PDestinatari;
        DestinatariCC:=PDestinatariCC;
        DestinatariCCN:=PDestinatariCCN;
        WebParametriAvanzati:=W000ParConfig.ParametriAvanzati;
      end;
      Start;
    end;
  end;
end;

// thread invio mail.ini
procedure TThreadMail.Execute;
// non viene utilizzata una critical section
// in quanto per ogni chiamata viene creato un thread distinto
// che utilizza un proprio datamodule
begin
  if not Terminated then
    try
      (C017DtMTh as TC017FEMailDtM).InviaEMail;
    except
      // al momento nulla
      // impossibile dal thread utilizzare W000RegistraLog (non vede A000UInterfaccia)
    end;
end;
// thread invio mail.fine

procedure TWR000FBaseDM.DataModuleDestroy(Sender: TObject);
begin
 try
  if selI010 <> nil then
    try FreeAndNil(selI010); except end;
  if selDatiBloccati <> nil then
    try FreeAndNil(selDatiBloccati); except end;
  if lstCompInvisibili <> nil then
    try FreeAndNil(lstCompInvisibili); except end;
  if History <> nil then
    try FreeAndNil(History); except end;
  if ModuliAccessori <> nil then
    try FreeAndNil(ModuliAccessori); except end;
 except
 end;
end;

end.
