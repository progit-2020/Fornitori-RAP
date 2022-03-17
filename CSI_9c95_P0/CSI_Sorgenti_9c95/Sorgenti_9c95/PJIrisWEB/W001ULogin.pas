unit W001ULogin;

interface

uses
  R010UPaginaWeb, W000UMessaggi, L021Call, System.Contnrs,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdMessage, IdBaseComponent, IdComponent, IdSMTPBase, IdSMTP,
  Oracle, DB, OracleData, DateUtils, Windows,
  IWAppForm, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompLabel, Classes, Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  Math, SysUtils, Variants, IWCompButton, meIWButton,
  A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi,
  A001UPasswordDtM1, C180FunzioniGenerali, RegistrazioneLog,
  IWCompListbox, StrUtils, IniFiles, IW.Common.System,
  JBFService, xmldom, msxmldom, XMLDoc,
  IWCompEdit, meIWLabel, meIWComboBox, meIWEdit, meIWLink, XMLIntf;

type
  TSSORisposta = record
    Utente,
    Profilo: String;
  end;

  TW001FLogin = class(TR010FPaginaWeb)
    xmlDoc: TXMLDocument;
    lblAzienda: TmeIWLabel;
    lblUtente: TmeIWLabel;
    lblPassword: TmeIWLabel;
    lblDatabase: TmeIWLabel;
    edtAzienda: TmeIWEdit;
    edtUtente: TmeIWEdit;
    edtPassword: TmeIWEdit;
    edtDatabase: TmeIWEdit;
    lblNomeProfilo: TmeIWLabel;
    edtNomeProfilo: TmeIWEdit;
    cmbNomeProfilo: TmeIWComboBox;
    lnkAccedi: TmeIWLink;
    btnAccedi: TmeIWButton;
    lnkRecuperaPassword: TmeIWLink;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    procedure IWAppFormCreate(Sender: TObject);
    procedure lnkAccediClick(Sender: TObject);
    procedure edtAziendaSubmit(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure lnkRecuperaPasswordClick(Sender: TObject);
    procedure IWAppFormAfterRender(Sender: TObject);
  private
    UrlWSAuth: String;
    ScriviDatabase: Boolean;
    ForzaAziendaVisibile: Boolean; // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6
    W001FPasswordDtM:TA001FPasswordDtM1;
    function  ConvertiHomeUrl(const PHome: String): String;
    procedure GetAbilitazioniModuli;
    procedure TraduzionePagina;
    procedure SSOVisualizzaAnomalia(const PAnomalia: String);
    function  SSOTicket(const PTicket:String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
    function  SSOComo(const PUID, PTime, PHash: String; var Anomalia: String; var Risposta: TSSORisposta): Boolean;
  public
    LoginEsterno: String;
  end;

implementation

uses W001UIrisWebDtM, W002URicercaAnagrafe, WC023UCambioPasswordFM,
     IWApplication, IWGlobal;

{$R *.DFM}

procedure TW001FLogin.IWAppFormCreate(Sender: TObject);
var
  ParAzienda,ParUsr,ParPwd,ParProfilo,
  ParDatabase,ParLoginEsterno,
  ParHome,ParWSAuth,ParTicket,
  Anomalia,RedirectStr,
  ParURLMan,ParUID,ParTime,ParHash,ParRemoteUser,STemp:String;
  AutSSO: Boolean;
  Risposta: TSSORisposta;
  ListaPar: TStrings;
  i: Integer;
const
  PAR_REMOTE_USER_NAME = 'remoteuser';
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - inizio metodo');

  // esce subito se la sessione è terminata (W001 è la main form, per cui viene comunque creata)
  if GGetWebApplicationThreadVar.Terminated then
    Exit;

  inherited;

  //Gestione eventuale pagina di manutenzione
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - gestione pagina di manutenzione');
  ParURLMan:=W000ParConfig.UrlManutenzione;
  if Trim(ParURLMan) <> '' then
  begin
    if Pos('http:', LowerCase(ParURLMan)) > 0 then
      GGetWebApplicationThreadVar.Response.SendRedirect(AnsiString(ParURLMan))
    else
    begin
      edtAzienda.Visible:=False;
      edtUtente.Visible:=False;
      edtPassword.Visible:=False;
      edtDatabase.Visible:=False;
      edtNomeProfilo.Visible:=False;
      cmbNomeProfilo.Visible:=False;
      lblAzienda.Css:='MsgManutenzione';
      lblAzienda.Left:=(Self.Width div 2) - (lblAzienda.Width div 2);
      lblAzienda.Caption:=ParURLMan;
      lblUtente.Visible:=False;
      lblPassword.Visible:=False;
      lblDatabase.Visible:=False;
      lblNomeProfilo.Visible:=False;
      lnkAccedi.Visible:=False;
      lnkRecuperaPassword.Visible:=False;
    end;
  end;

  // lettura parametri
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - lettura parametri');
  if GGetWebApplicationThreadVar.RunParams.Count >= 1 then
  begin
    // parametri passati con metodi propri di intraweb
    ListaPar:=GGetWebApplicationThreadVar.RunParams;
  end
  else if GGetWebApplicationThreadVar.Request.ContentFields.Count >= 1 then
  begin
    // metodo POST
    ListaPar:=GGetWebApplicationThreadVar.Request.ContentFields;
  end
  else if GGetWebApplicationThreadVar.Request.QueryFields.Count >= 1 then
  begin
    // metodo GET
    ListaPar:=GGetWebApplicationThreadVar.Request.QueryFields;
  end
  else
  begin
    // HEADER HTTP personalizzati
    ListaPar:=GGetWebApplicationThreadVar.Request.RawHeaders;
  end;

  // salva i parametri in variabili
  if Assigned(ListaPar) then
  begin
    // parametri comuni a tutte le installazioni
    ParAzienda:=ListaPar.Values['azienda'];
    ParUsr:=ListaPar.Values['usr'];
    ParPwd:=ListaPar.Values['pwd'];
    ParProfilo:=ListaPar.Values['profilo'];
    ParDatabase:=ListaPar.Values['database'];
    ParLoginEsterno:=ListaPar.Values['loginesterno'];
    ParHome:=ListaPar.Values['home'];
    ParWSAuth:=ListaPar.Values['wsauth'];
    WR000DM.PaginaIniziale:=IfThen(ListaPar.Values['startpage'] <> '',ListaPar.Values['startpage'],W000ParConfig.PaginaIniziale);
    WR000DM.PaginaSingola:=IfThen(ListaPar.Values['singlepage'] <> '',ListaPar.Values['singlepage'],W000ParConfig.PaginaSingola);

    // SSO roma_hsantandrea
    ParTicket:=ListaPar.Values['ticket'];

    // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.ini
    // SSO como_hsanna
    ParUID:=ListaPar.Values['uid'];
    ParTime:=ListaPar.Values['time'];
    ParHash:=ListaPar.Values['hash'];
    // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.fine

    // VENEZIA_IUAV.ini
    ParRemoteUser:='';
    for i:=0 to ListaPar.Count - 1 do
    begin
      STemp:=ListaPar[i];
      if STemp.StartsWith(Format('%s:',[PAR_REMOTE_USER_NAME]),True) then
      begin
        ParRemoteUser:=STemp.Substring(PAR_REMOTE_USER_NAME.Length + 1).Trim;
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - trovato remoteuser = ' + ParRemoteUser);
      end;
    end;
    // VENEZIA_IUAV.fine

    //chiamata da X002 (VILLAFALLETTO_PERARIA)
    if ListaPar.Values['xusr'] <> '' then
      ParUsr:=R180DecriptaI070(ListaPar.Values['xusr']);
    WR000DM.IpAddressClient:=ListaPar.Values['ipclient'];
    WR000DM.ClientName:=ListaPar.Values['clientname'];
  end;

  // gestione login esterno e abilitazione campi
  LoginEsterno:=IfThen(ParLoginEsterno <> '',ParLoginEsterno,W000ParConfig.LoginEsterno);
  edtAzienda.Enabled:=(LoginEsterno = 'N');
  edtUtente.Enabled:=(LoginEsterno = 'N');
  edtPassword.Enabled:=(LoginEsterno = 'N');
  edtNomeProfilo.Enabled:=(LoginEsterno = 'N');
  edtDatabase.Enabled:=(LoginEsterno = 'N');

  // segnalazione di login in corso
  if LoginEsterno = 'S' then
    JavascriptBottom.Add('document.write("<div id=\"loginInProgress\">' + A000TraduzioneStringhe(A000MSG_MSG_ACCESSO_IN_CORSO) + '</div>");')
  else
    JavascriptBottom.Add('document.getElementById("loginForm").className = "";');

  // impostazione dati login
  // Nota: i parametri via http sovrascrivono le impostazioni di default su registro
  edtAzienda.Text:=IfThen(ParAzienda <> '',ParAzienda,W000ParConfig.Azienda);
  edtUtente.Text:=ParUsr;
  edtPassword.Text:=ParPwd;
  edtNomeProfilo.Text:=IfThen(ParProfilo <> '',ParProfilo,W000ParConfig.Profilo);
  edtDatabase.Text:=IfThen(ParDatabase <> '',ParDatabase,W000ParConfig.Database);
  ScriviDatabase:=((ParDatabase = '') and (W000ParConfig.Database = '')) or (DebugHook <> 0);
  (GGetWebApplicationThreadVar.Data as TSessioneWeb).HomeUrl:=ConvertiHomeUrl(IfThen(ParHome <> '',ParHome,W000ParConfig.Home));
  UrlWSAuth:=IfThen(ParWSAuth <> '',ParWSAuth,W000ParConfig.UrlWSAutenticazione);

  // ROMA_HSANTANDREA - SSO.ini
  if ParTicket <> '' then
  begin
    // gestione del ticket
    Risposta.Utente:='';
    Risposta.Profilo:='';
    try
      AutSSO:=SSOTicket(ParTicket,Anomalia,Risposta);
    except
      on E:Exception do
      begin
        AutSSO:=False;
        Anomalia:=E.Message;
      end;
    end;

    // ticket autorizzato -> accesso con nuovi parametri
    if AutSSO then
    begin
      Log('Traccia','GGetWebApplicationThreadVar.AppURLBase: ' + GGetWebApplicationThreadVar.AppURLBase);
      RedirectStr:='?azienda=' + edtAzienda.Text +
                   '&usr=' + Risposta.Utente +
                   '&profilo=' + Risposta.Profilo +
                   '&database=' + edtDatabase.Text +
                   '&loginesterno=' + LoginEsterno;
      // bugfix.ini iw 12.2.12.1
      // appurlbase contiene erroneamente il session id: occorre rimuoverlo
      RedirectStr:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/' + GGetWebApplicationThreadVar.AppID,'',[]) + RedirectStr;
      // bugfix.fine
      Log('Traccia','Ticket autorizzato: accesso ad IrisWeb con redirect su: ' + RedirectStr);
      GGetWebApplicationThreadVar.Response.SendRedirect(RedirectStr);
    end
    else
    begin
      SSOVisualizzaAnomalia(Anomalia);
      Exit;
    end;
  end
  // ROMA_HSANTANDREA - SSO.fine
  // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.ini
  // implementazione sso per como_hsanna
  else if ParUID <> '' then
  begin
    // gestione del sso via confronto stringa sha1
    Risposta.Utente:='';
    Risposta.Profilo:='';
    try
      AutSSO:=SSOComo(ParUID,ParTime,ParHash,Anomalia,Risposta);
    except
      on E:Exception do
      begin
        AutSSO:=False;
        Anomalia:=E.Message;
      end;
    end;

    // utente autorizzato -> accesso con nuovi parametri
    if AutSSO then
    begin
      Log('Traccia','GGetWebApplicationThreadVar.AppURLBase: ' + GGetWebApplicationThreadVar.AppURLBase);
      RedirectStr:='?azienda=' + edtAzienda.Text +
                   '&usr=' + Risposta.Utente +
                   '&profilo=' + Risposta.Profilo +
                   '&database=' + edtDatabase.Text +
                   '&loginesterno=' + LoginEsterno;
      // bugfix.ini iw 12.2.12.1
      // appurlbase contiene erroneamente il session id: occorre rimuoverlo
      RedirectStr:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/' + GGetWebApplicationThreadVar.AppID,'',[]) + RedirectStr;
      // bugfix.fine
      Log('Traccia','Token autorizzato: accesso ad IrisWeb con redirect su: ' + RedirectStr);
      GGetWebApplicationThreadVar.Response.SendRedirect(RedirectStr);
    end
    else
    begin
      SSOVisualizzaAnomalia('Autenticazione con SSO fallita: ' + Anomalia);
      Exit;
    end;
  end
  // COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.fine
  // VENEZIA_IUAV.ini
  else if ParRemoteUser <> '' then
  begin
    // l'utente è indicato nel parametro
    edtUtente.Text:=ParRemoteUser;
  end;
  // VENEZIA_IUAV.fine

  // avvio automatico login
  if (edtAzienda.Text <> '') and (edtUtente.Text <> '') then
  begin
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - avvio automatico login');
    AddToInitProc(Format('SubmitClickConfirm("%s","",true,"");',[lnkAccedi.HTMLName]));
  end;

  // gestione login esterno
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - gestione login esterno');
  if (LoginEsterno = 'S') and
     ((edtAzienda.Text = '') or (edtUtente.Text = '')) then
  begin
    Log('Traccia','Login esterno - uscita forzata: ' +
        IfThen(edtAzienda.Text = '','azienda non indicata;') +
        IfThen(edtUtente.Text = '','utente non indicato;'));
    edtAzienda.Required:=False;
    edtUtente.Required:=False;
    AddToInitProc(Format('SubmitClickConfirm("%s","",true,"");',[lnkEsci.HTMLName]));
  end;

  TraduzionePagina;

  // visibilità link di recupero password
  lnkRecuperaPassword.Visible:=(LoginEsterno <> 'S') and
                               (Pos(INI_PAR_RECUPERO_PASSWORD,W000ParConfig.ParametriAvanzati) > 0);
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormCreate - fine metodo');
end;

procedure TW001FLogin.TraduzionePagina;
var
  Lingua: String;
  i,nsl: Integer;
begin
  // gestione traduzione
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - inizio metodo');
  if (Pos(INI_PAR_TRADUZIONE_CAPTION,W000ParConfig.ParametriAvanzati) > 0) and
     (LoginEsterno = 'N') and
     (edtAzienda.Text <> '') and
     (edtDatabase.Text <> '') then
  begin
    Lingua:='INGLESE';
    if W001FPasswordDtM = nil then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: chiamata al costruttore');
      W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: creazione terminata');
    end;
    try
      W001FPasswordDtM.EseguiCheckConnection:=Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0;
      WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - WR000DM.GetSessioneLogin(' + edtDatabase.Text + '): invocata');
      nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - WR000DM.GetSessioneLogin(' + edtDatabase.Text + '): terminata');
      if nsl = -1 then
        Abort;

      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: attesa per Enter');
      CSSessioneMondoEDP.Enter;
      try
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM.InizializzazioneSessione(' + edtDatabase.Text + '): invocata');
        W001FPasswordDtM.InizializzazioneSessione(edtDatabase.Text);
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM.InizializzazioneSessione(' + edtDatabase.Text + '): terminata');
      finally
        CSSessioneMondoEDP.Leave;
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: Leave effettuata');
      end;
      
      (**)
      with WR000DM do
      begin
        Parametri.CampiRiferimento.C90_Lingua:=Lingua;
        // utilizzo di clientdataset per localizzazione
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - selI015: inizio gestione');
        selI015.SetVariable('AZIENDA',edtAzienda.Text);
        selI015.SetVariable('LINGUA',UpperCase(Parametri.CampiRiferimento.C90_Lingua));
        selI015.SetVariable('APPLICAZIONE','W000');
        selI015.Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
        try
          selI015.Open;
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
          if cdsI015.RecordCOunt > 0 then
            Parametri.cdsI015:=cdsI015;
        except
        end;
        selI015.CloseAll;
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - selI015: fine gestione');
      end;
    finally
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: inizio distruzione');
      FreeAndNil(W001FPasswordDtM);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - W001FPasswordDtM: fine distruzione');

      if nsl >= 0 then
      begin
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: attesa per Enter');
        CSSessioneMondoEDP.Enter;
        try
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: dentro la critical section');
          (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=(lstSessioniMondoEDP[nsl] as TOracleSession).Tag - 1;
        finally
          CSSessioneMondoEDP.Leave;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - CSSessioneMondoEDP: Leave effettuata');
        end;
      end;
    end;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.TraduzionePagina - fine metodo');
end;

procedure TW001FLogin.IWAppFormRender(Sender: TObject);
var idx:Integer;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormRender - inizio metodo');
  inherited;

  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
  // se necessario forza visibilità campo azienda (e relativa label)
  // rimuove anche i campi dalla lista dei componenti invisibili
  if ForzaAziendaVisibile then
  begin
    // ripristina css per azienda e label relativa
    lblAzienda.Css:='intestazione';
    edtAzienda.Css:='width15chr spazio_sx';
    idx:=WR000DM.lstCompInvisibili.IndexOf(UpperCase(Self.Name + '.' + lblAzienda.Name));
    if idx >= 0 then
      WR000DM.lstCompInvisibili.Delete(idx);
    idx:=WR000DM.lstCompInvisibili.IndexOf(UpperCase(Self.Name + '.' + edtAzienda.Name));
    if idx >= 0 then
      WR000DM.lstCompInvisibili.Delete(idx);
  end;
  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine

  // focus sul primo campo non valorizzato
  if LoginEsterno <> 'S' then
  begin
    if (edtAzienda.Visible) and (not edtAzienda.Css.Contains('invisibile')) and (edtAzienda.Text = '') then
      Self.ActiveControl:=edtAzienda
    else if (edtUtente.Visible) and (not edtUtente.Css.Contains('invisibile')) and (edtUtente.Text = '') then
      Self.ActiveControl:=edtUtente
    else if (edtPassword.Visible) and (not edtPassword.Css.Contains('invisibile')) and (edtPassword.Text = '') then
      Self.ActiveControl:=edtPassword
    else if (edtNomeProfilo.Visible) and (not edtNomeProfilo.Css.Contains('invisibile')) and (edtNomeProfilo.Text = '') then
      Self.ActiveControl:=edtNomeProfilo
    else if (cmbNomeProfilo.Visible) and (not cmbNomeProfilo.Css.Contains('invisibile')) and (cmbNomeProfilo.Text = '') then
      Self.ActiveControl:=cmbNomeProfilo
    else if (edtDatabase.Visible) and (not edtDatabase.Css.Contains('invisibile')) and (edtDatabase.Text = '') then
      Self.ActiveControl:=edtDatabase;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormRender - fine metodo');
end;

procedure TW001FLogin.IWAppFormAfterRender(Sender: TObject);
begin
  { DONE : TEST IW 15 }
  if not GGetWebApplicationThreadVar.IsCallBack then
  begin
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormAfterRender - inizio metodo');
    inherited;
    RimuoviNotifiche;
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.IWAppFormAfterRender - fine metodo');
  end;
end;

function TW001FLogin.SSOTicket(const PTicket: String; var Anomalia: String;
  var Risposta: TSSORisposta): Boolean;
// Gestione sso per ospedale sant'andrea
//   L'autenticazione avviene in questo modo:
//   INPUT
//     - parametro "ticket" letto dai parametri della request
//   AUTENTICAZIONE
//   - il ticket viene impacchettato in una stringa xml che rappresenta la richiesta
//     da inoltrare al webservice di autenticazione
//   - viene chiamato il webservice e si attende la risposta
//   - se la risposta contiene il tag <info> allora l'autenticazione è ok
//       -> viene fatto un redirect alla dll di irisweb con il parametro usr ecc.
//     altrimenti se la risposta contiene il tag <Exception> l'autenticazione è fallita
var
  Richiesta,StrXML,Err: String;
  oJSB: DefaultWebService;
  xmlNodoList: IDOMNodeList;
begin
  Log('Traccia','JBFService;Autenticazione con ticket: ' + PTicket + ';Webservice chiamato: ' + UrlWSAuth);

  // inizializzazioni
  Result:=False;
  Anomalia:='';
  Risposta.Utente:='';
  Risposta.Profilo:='';
  Err:='';
  StrXML:='';

  // assembla l'xml di richiesta
  Richiesta:='<Input>' +
             '<WebServicesOggettiComuni id=''SSOTCK'' preAuthentication=''false''>'+
             '<GetTicket>' + PTicket + '</GetTicket></WebServicesOggettiComuni></Input>';
  Log('Traccia','JBFService;XML richiesta: [' + Richiesta + ']');

  // richiama il web service JBF con la richiesta
  oJSB:=JBFService.GetDefaultWebService(False,UrlWSAuth);
  try
    StrXML:=oJSB.call(Richiesta);
    Log('Traccia','JBFService;Call: OK;Risposta: [' + Copy(StrXML,1,1500) + ']');
  except
    on E:Exception do
    begin
      Log('Errore','JBFService;Call: FALLITA',E);
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_CHIMATA_FALLITA));
    end;
  end;

  // legge l'xml di risposta e ne esegue il parsing
  xmlDoc.XML.Add(StrXML);
  try
    xmlDoc.Active:=True;
    Log('Traccia','JBFService;Parsing risposta: OK');
  except
    on E:Exception do
    begin
      Log('Errore','JBFService;Parsing risposta: FALLITO',E);
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_WEBSRV_RISP_ERRATA),[E.ClassName,E.Message]));
    end;
  end;

  // verifica l'xml di risposta
  if Pos('<Exception>',StrXML) > 0 then
  begin
    // Autenticazione fallita
    try
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('Code');
      if Assigned(xmlNodoList) then
      begin
        try
          Err:=xmlNodoList.item[0].childNodes[0].nodeValue;
        except end;
      end;
      Log('Errore','JBFService;Autenticazione: FALLITA;Motivo: ' + IfThen(Err <> '',Err,'(errore non rilevabile)'));
      Anomalia:='Errore durante l''autenticazione sul servizio web!' +
                IfThen(Err <> '',CRLF + 'Motivo: ' + Err);
      Exit;
    except
      on E:Exception do
      begin
        Log('Errore','JBFService;Autenticazione: FALLITA',E);
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_WEBSRV_GENERICO),[E.ClassName,E.Message]));
      end;
    end;
  end
  else if Pos('<info>',StrXML) > 0 then
  begin
    // Autenticazione ok
    try
      // lettura utente
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('utente');
      if Assigned(xmlNodoList) then
      begin
        try
          Risposta.Utente:=xmlNodoList.item[0].childNodes[0].nodeValue;
        except
          on E:Exception do
          begin
            Log('Errore','JBFService;Autenticazione: OK',E);
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_NO_NOME_UTENTE));
          end;
        end;
      end;
      // lettura profilo
      xmlNodoList:=xmlDoc.DOMDocument.getElementsByTagName('profilo');
      if Assigned(xmlNodoList) then
      begin
        try
          Risposta.Profilo:=xmlNodoList.item[0].childNodes[0].nodeValue;
        except
          on E:Exception do
          begin
            Log('Errore','JBFService;Autenticazione: OK',E);
            // il profilo non è indispensabile...
            Risposta.Profilo:='';
            //raise Exception.Create('Errore durante l''autenticazione sul servizio web!' +
            //                       'Motivo: Impossibile recuperare il profilo');
          end;
        end;
      end;
      // terminazione ok: redirect alla pagina di login con l'utente impostato
      Log('Traccia','JBFService;Autenticazione: OK;Utente: ' + Risposta.Utente + ',Profilo: ' + Risposta.Profilo);
      Result:=True;
      Exit;
    except
      on E:Exception do
      begin
        Log('Errore','JBFService;Autenticazione: OK',E);
        raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_ERR_FMT_WEBSRV_GENERICO),[E.ClassName,E.Message]));
      end;
    end;
  end
  else
  begin
    // autenticazione indefinita: nessun tag conosciuto
    Log('Errore','JBFService;Autenticazione: N/D;Errore: tag <info> e <Exception> non rilevati');
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_WEBSRV_RISP_NO_RICONOS));
  end;
end;

// COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.ini
function TW001FLogin.SSOComo(const PUID, PTime, PHash: String;
  var Anomalia: String; var Risposta: TSSORisposta): Boolean;
// Gestione sso per COMO_HSANNA
//   L'autenticazione avviene in questo modo:
//   INPUT
//   - sono previsti 3 parametri letti dalla request
//     uid  = username dell'utente da autenticare
//     time = timestamp della richiesta in formato unix time
//     hash = l'hash calcolato in questo modo
//            sha1 di una stringa formata concatenando:
//            uid + time + password condivisa
//   AUTENTICAZIONE
//   - verifica che l'ora corrente non sia più distante di un minuto dal parametro "time"
//     (questo evita che un token possa essere riutilizzato)
//   - ricostruisce il l'hash sha1 utilizzando i parametri uid, time e la password condivisa
//   - confronta il risultato ottenuto con l'hash calcolato prima
//     se e' uguale l'autenticazione è ok
//       -> viene fatto un redirect alla dll di irisweb con il parametro usr ecc.
//     altrimenti l'autenticazione è fallita
var
  Fase,TokenSha1,Formato,OraAttualeStr,OraRichiestaStr: String;
  UnixTimeRichiesta,UnixTimeOraAttuale,Delta: Int64;
  OraRichiesta, OraAttuale: TDateTime;
  UTC:TSystemTime;
const
  SSO_COMO_TOKEN_TIMEOUT_SECONDI = 60;                // timeout oltre il quale il token non è più valido
  SSO_COMO_SHARED_PWD            = 'pwdIrisWEBsha1';  // password condivisa per generazione hash
begin
  Log('Traccia',Format('SSO_Como;Autenticazione SSO con parametri [UID=%s] [time=%s] [hash=%s],',[PUID,PTime,PHash]));

  // inizializzazioni
  Result:=False;
  Anomalia:='';
  Risposta.Utente:='';
  Risposta.Profilo:='';

  // 1. controlla i parametri in ingresso

  // verifica indicazione uid
  Fase:='SSO_Como;Verifica parametri: uid';
  Log('Traccia',Fase);

  if Trim(PUID) = '' then
  begin
    Anomalia:='user ID non indicato';
    Log('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // verifica indicazione ora richiesta
  Fase:='SSO_Como;Verifica parametri: time';
  Log('Traccia',Fase);
  if Trim(PTime) = '' then
  begin
    Anomalia:='ora della richiesta non indicata';
    Log('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // verifica correttezza ora richiesta
  if not TryStrToInt64(PTime,UnixTimeRichiesta) then
  begin
    Anomalia:=Format('ora della richiesta in formato unix time non corretta [%s]',[PTime]);
    Log('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // salva ora richiesta e ora attuale (in formato UTC, ora di Greenwich)
  OraRichiesta:=UnixToDateTime(UnixTimeRichiesta);
  //OraAttuale:=Now;
  GetSystemTime(UTC);
  OraAttuale:=SystemTimeToDateTime(UTC);

  UnixTimeOraAttuale:=DateTimeToUnix(OraAttuale);

  // controlla che la "distanza" dell'ora attuale rispetto all'ora della richiesta
  // non sia maggiore del timeout in secondi specificato
  // questo accorgimento serve ad evitare che il token possa essere riutilizzato
  Delta:=UnixTimeOraAttuale - UnixTimeRichiesta;
  if Abs(Delta) > SSO_COMO_TOKEN_TIMEOUT_SECONDI then
  begin
    // errore: l'ora di elaborazione è più distante del numero max di secondi
    // tollerato rispetto all'ora della richiesta
    Formato:=IfThen(Trunc(OraAttuale) <> Trunc(OraRichiesta),'dd/mm/yyyy ') + 'hhhh.mm.ss';
    OraAttualeStr:=FormatDateTime(Formato,OraAttuale);
    OraRichiestaStr:=FormatDateTime(Formato,OraRichiesta);
    if Delta > SSO_COMO_TOKEN_TIMEOUT_SECONDI then
    begin
      // token scaduto
      Anomalia:='token di autenticazione scaduto';
    end
    else if Delta < 0 then
    begin
      // data richiesta precedente a data attuale
      // (probabilmente gli orari dei server sono sfasati)
      Anomalia:=Format('ora della richiesta non congruente: %s',[OraRichiestaStr]);
    end;
    Log('Errore',Format('%s: FALLITA: %s [ora attuale=%s] [ora request=%s]',[Fase,Anomalia,OraAttualeStr,OraRichiestaStr]));
    Exit;
  end;

  // controlla hash sha1
  Fase:='SSO_Como;Verifica parametri: hash;';
  if Trim(PHash) = '' then
  begin
    Anomalia:='Hash sha1 non indicato';
    Log('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
    Exit;
  end;

  // 2. ricostruisce il token da confrontare con l'hash ricevuto
  Fase:='SSO_Como;Calcolo token';
  try
    TokenSha1:=R180Sha1Encrypt(Format('%s%d%s',[PUID,UnixTimeRichiesta,SSO_COMO_SHARED_PWD]));
  except
    on E: Exception do
    begin
      Anomalia:=Format('errore di cifratura sha-1: %s (%s)',[E.Message,E.ClassName]);
      Log('Errore',Format('%s: FALLITA: %s',[Fase,Anomalia]));
      Exit;
    end;
  end;

  // verifica corrispondenza degli hash
  // si potrebbe obiettare che il confronto è fatto fra stringhe ma i valori sono esadecimali
  // lo so, non è per nulla elegante.. ma se trovate una soluzione migliore che sfrutti
  // un confronto numerico implementatela pure
  Fase:='SSO_Como;Autenticazione: ';
  if UpperCase(TokenSha1) <> UpperCase(PHash) then
  begin
    Anomalia:='token non corrispondente';
    Log('Traccia',Format('%s: FALLITA; Token non corrispondente [calcolato=%s]',[Fase,TokenSha1]));
    Exit;
  end;

  // tutto ok
  Risposta.Utente:=PUID;
  Risposta.Profilo:=''; // verificare
  Result:=True;
  Log('Traccia',Format('%s: OK;Utente: %s,Profilo: %s',[Fase,Risposta.Utente,Risposta.Profilo]));
end;

procedure TW001FLogin.SSOVisualizzaAnomalia(const PAnomalia: String);
begin
  // visualizza anomalia
  MessaggioStatus(ERRORE,PAnomalia);

  // disabilita login
  edtAzienda.Enabled:=False;
  edtUtente.Enabled:=False;
  edtPassword.Enabled:=False;
  edtNomeProfilo.Enabled:=False;
  edtDatabase.Enabled:=False;

  // disabilita link di accesso
  lnkAccedi.Enabled:=False;

  // disabilita anche recupero password
  lnkRecuperaPassword.Enabled:=False;

  // ...
  //if Home <> '' then
  //  GGetWebApplicationThreadVar.Response.SendRedirect(Home);
end;
// COMO_HSANNA - commessa: 2013/012 SVILUPPO#2.fine

function TW001FLogin.ConvertiHomeUrl(const PHome: String): String;
var
  ParUrlBase,Risultato: String;
begin
  Risultato:=PHome;

  // sostituzione variabili
  if Pos('(URLBASE)',Risultato) > 0 then
  begin
    // URLBASE = directory base applicazione
    ParUrlBase:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/W000PIrisWEB_IIS.dll','',[rfIgnoreCase]);
    Risultato:=StringReplace(Risultato,'(URLBASE)',ParUrlBase,[rfIgnoreCase]);
  end;

  Result:=Risultato;
end;

procedure TW001FLogin.lnkAccediClick(Sender: TObject);
var
  W002:TW002FRicercaAnagrafe;
  WC023: TWC023FCambioPasswordFM;
  Sysdate:TDateTime;
  PwdScaduta,CSEnter,AuthDom:Boolean;
  ValProfilo,ElencoAziende:String;
  ns,nsl:Integer;
  IniFile: TIniFile;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - inizio metodo');
  nsl:=-1; // inizializzazione
  TRY
    //Autenticazione
    AuthDom:=False;
    if W001FPasswordDtM = nil then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: chiamata al costruttore');
      W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: creazione terminata');
    end;
    try
      W001FPasswordDtM.EseguiCheckConnection:=Pos(INI_PAR_DB_NO_CHECK_CONNECTION,W000ParConfig.ParametriAvanzati) = 0;
      WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
      with W001FPasswordDtM do
      begin
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - GetSessioneLogin: invocato');
        nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - GetSessioneLogin: terminato');
        Log('Sessione','GetSessioneLogin');
        if nsl = -1 then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_CONN_FALLITA));
          Abort;
        end;
        PwdScaduta:=False;
        try
          CSEnter:=False;
          if (Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) = 0) and
             (not W001FPasswordDtM.SessioneMondoEDP.Connected) then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: attesa per Enter');
            CSSessioneMondoEDP.Enter;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: dentro la critical section');
            CSEnter:=True;
          end;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - InizializzazioneSessione(' + edtDatabase.Text + '): invocato');
            InizializzazioneSessione(edtDatabase.Text);
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - InizializzazioneSessione(' + edtDatabase.Text + '): terminato');
          finally
            if CSEnter then
            begin
              CSSessioneMondoEDP.Leave;
              DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: Leave effettuata');
            end;
          end;
        except
          on E:Exception do
          begin
            Log('Errore','InizializzazioneSessione Respinta',E);
            GGetWebApplicationThreadVar.ShowMessage(E.Message);
            Abort;
          end;
        end;
        Log('Sessione','SessioneLogin:' + IntToStr(nsl) + '/' + IntToStr(W001FPasswordDtM.SessioneMondoEDP.Tag));
        if ScriviDatabase then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSParConfig: attesa per Enter');
          CSParConfig.Enter;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSParConfig: dentro la critical section');
            { DONE : TEST IW 15 }
            IniFile:=TIniFile.Create(IncludeTrailingPathDelim(gsAppPath) + FILE_CONFIG);
            try
              IniFile.WriteString(INI_SEZ_IMPOST_OPER,INI_ID_DATABASE,edtDatabase.Text);
            finally
              FreeAndNil(IniFile);
            end;
          finally
            CSParConfig.Leave;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSParConfig: Leave effettuata');
          end;
        end;

        // richiesta indicazione nome utente
        if edtUtente.Text = '' then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_NON_INDICATO));
          edtUtente.SetFocus;
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_NON_INDICATO));
        end;

        // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
        // in fase di login interattivo, se l'azienda non viene indicata,
        // il programma cerca di individuarla utilizzando solo il nome utente,
        // ricercando su I060 per le aziende con LOGIN_DIP_ABILITATO = 'S'
        // e su I070 per le aziende con LOGIN_USR_ABILITATO = 'S'
        ForzaAziendaVisibile:=False;
        if (LoginEsterno <> 'S') and (edtAzienda.Text = '') then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - ricerca automatica azienda iniziata');
          // azienda non indicata: ricerca tramite nome utente
          // estrae l'elenco delle aziende
          selDistAzienda.Close;
          selDistAzienda.ClearVariables;
          selDistAzienda.SetVariable('UTENTE',edtUtente.Text);
          selDistAzienda.Open;
          // casi da gestire:
          // 0   record -> errore utente inesistente
          // 1   record -> ok (si rifà alla gestione precedente)
          // N>1 record -> proporre lista aziende da selezionare
          if selDistAzienda.RecordCount = 0 then
          begin
            // TORINO_CITTADELLASALUTE - chiamata 81857.ini
            // nel caso in cui l'utente non venga trovato nelle aziende con il riconoscimento automatico
            // dare il messaggio di utente inesistente
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_INESISTENTE));
            ActiveControl:=edtUtente;
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_INESISTENTE));
            {
            // ricerca azienda fallita -> chiede all'utente di indicare l'azienda
            // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
            ForzaAziendaVisibile:=True;
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
            }
            // TORINO_CITTADELLASALUTE - chiamata 81857.fine
          end
          else if selDistAzienda.RecordCount = 1 then
          begin
            // imposta l'azienda individuata
            edtAzienda.Text:=selDistAzienda.FieldByName('AZIENDA').AsString;
          end
          else if selDistAzienda.RecordCount > 1 then
          begin
            // il nome utente indicato è presente in più aziende:
            // propone la lista delle aziende da scegliere
            // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
            ForzaAziendaVisibile:=True;
            ElencoAziende:='';
            selDistAzienda.First;
            while not selDistAzienda.Eof do
            begin
              ElencoAziende:=ElencoAziende + selDistAzienda.FieldByName('AZIENDA').AsString.QuotedString + ',';
              selDistAzienda.Next;
            end;
            jqAutocomplete.OnReady.Text:=
              'var elementi = [' + ElencoAziende.Substring(0,ElencoAziende.Length - 1) + '];' + CRLF +
              '$("#' + edtAzienda.HTMLName + '").autocomplete({' + CRLF +
              '  source: elementi,' + CRLF +
              '  delay: 0,' + CRLF +
              '  minLength: 0' + CRLF +
              '}).focus(function(){ ' + CRLF +
              '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
              '}); ';
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_MSG_SEL_AZIENDA));
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - ricerca automatica azienda terminata');
        end;
        // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine

        // azienda indicata: ricerca su database per estrarre informazioni
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - estrazione dati azienda');
        QI090.Close;
        QI090.SetVariable('Azienda',edtAzienda.Text);
        QI090.Open;
        if QI090.RecordCount = 0 then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_INESISTENTE));
          ActiveControl:=edtAzienda;
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_INESISTENTE));
        end;

        // salva parametri del dominio di autenticazione
        Parametri.AuthDomInfo.DominioDip:=QI090.FieldByName('DOMINIO_DIP').AsString;
        Parametri.AuthDomInfo.DominioDipTipo:=QI090.FieldByName('DOMINIO_DIP_TIPO').AsString;
        Parametri.AuthDomInfo.DominioUsr:=QI090.FieldByName('DOMINIO_USR').AsString;
        Parametri.AuthDomInfo.DominioUsrTipo:=QI090.FieldByName('DOMINIO_USR_TIPO').AsString;

        // ricerca record con lo username indicato
        // su I070 (supervisore) e su I060 (dipendente)
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - ricerca utente in I070 e I060');
        QI070.Close;
        QI070.SetVariable('Azienda',edtAzienda.Text);
        QI070.SetVariable('Utente',edtUtente.Text);
        QI070.Open;
        QI060.Close;
        QI060.ClearVariables;
        QI060.SetVariable('Azienda',edtAzienda.Text);
        QI060.SetVariable('Utente',edtUtente.Text);
        QI060.Open;

        WR000DM.EsisteUtenteI070:=QI070.RecordCount > 0;
        // ricerca user fallita -> messaggio di errore
        if (QI070.RecordCount = 0) and (QI060.RecordCount = 0) then
        begin
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_INESISTENTE));
          ActiveControl:=edtUtente;
          raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_UTENTE_INESISTENTE));
        end;

        if (QI070.RecordCount = 0) or (QI060.RecordCount > 0) then
        begin
          // utente di irisweb
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente web: iniziata');
          //Alberto: autenticazione su dominio
          if (not QI090.FieldByName('DOMINIO_DIP').IsNull) and QI060.FieldByName('PassWord').IsNull then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione su dominio iniziata');
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: attesa per Enter');
            CSAutenticazioneDominio.Enter;
            try
              DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: dentro la critical section');
              AuthDom:=AutenticazioneDominio(QI090.FieldByName('DOMINIO_DIP').AsString, edtUtente.Text, edtPassword.Text, QI090.FieldByName('DOMINIO_DIP_TIPO').AsString);
            finally
              CSAutenticazioneDominio.Leave;
              DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: Leave effettuata');
            end;
            if not AuthDom and ((edtPassword.Text = '') or (edtPassword.Text <> R180Decripta(QI060.FieldByName('PassWord').AsString,30011945))) then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_DOM_FALLITA));
              raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_DOM_FALLITA)); //Abort;
            end;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione su dominio terminata');
          end
          //Fine autenticazione su dominio
          else if (LoginEsterno = 'N') and (edtPassword.Text <> R180Decripta(QI060.FieldByName('PassWord').AsString,30011945)) then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_PSW_ERRATA));
            edtPassword.Clear;
            ActiveControl:=edtPassword;
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PSW_ERRATA));
          end;

          //Registrazione parametri/inibizioni
          if edtNomeProfilo.Visible then
            ValProfilo:=edtNomeProfilo.Text
          else if cmbNomeProfilo.ItemIndex >= 0 then
            ValProfilo:=cmbNomeProfilo.Items[cmbNomeProfilo.ItemIndex]
          else if edtNomeProfilo.Text <> '' then
            ValProfilo:=edtNomeProfilo.Text;  // profilo specificato su registro - daniloc 09.03.2010
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioniInfo: iniziata');
          if Not RegistraInibizioniInfo(ValProfilo) then
          begin
            lblNomeProfilo.Css:='font_rosso';
            cmbNomeProfilo.Visible:=True;
            edtNomeProfilo.Visible:=False;
            cmbNomeProfilo.Items.Clear;
            selI061.First;
            while Not selI061.Eof do
            begin
              cmbNomeProfilo.Items.Add(selI061.FieldByName('NOME_PROFILO').AsString);
              selI061.Next;
            end;
            cmbNomeProfilo.ItemIndex:=0;
            if cmbNomeProfilo.Items.Count >= 1 then
            begin
              ActiveControl:=cmbNomeProfilo;
              raise Exception.Create(A000TraduzioneStringhe(A000MSG_MSG_SEL_PROFILO));
            end
            else
              raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PROFILO_NON_TROVATO));
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioniInfo: terminata');

          // controllo lunghezza password (saltato se login esterno)
          if (LoginEsterno = 'N') and
             (edtPassword.Text = '') and
             (Parametri.LunghezzaPassword > 0) then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_ACCESSO_NEGATO_NO_PSW));
            ActiveControl:=edtPassword;
            Abort;
          end;
          WR000DM.TipoUtente:='Dipendente';
          GGetWebApplicationThreadVar.SessionTimeOut:=WR000DM.TimeoutDip;
          A000SessioneWEB.TimeOutOriginale:=GGetWebApplicationThreadVar.SessionTimeOut;

          // controllo scadenza password (saltato se login esterno)
          Sysdate:=Trunc(R180Sysdate(QI090.Session));
          if (LoginEsterno = 'N') and
             (QI060.FindField('DATA_PW') <> nil) and
             (not AuthDom) then
            if ((Parametri.ValiditaPassword > 0) and
               (R180AddMesi(QI060.FieldByName('DATA_PW').AsDateTime,Parametri.ValiditaPassword) <= Sysdate)) or
               (QI060.FieldByName('DATA_PW').IsNull) then
              PwdScaduta:=True;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente web: terminata');
        end
        else
        begin
          // utente di iriswin (supervisore)
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente win: iniziata');
          //Autenticazione su dominio
          if (edtUtente.Text <> 'SYSMAN') and
             (edtUtente.Text <> 'MONDOEDP') and
             (not QI090.FieldByName('DOMINIO_USR').IsNull) then
          begin
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione su dominio iniziata');
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: attesa per Enter');
            CSAutenticazioneDominio.Enter;
            try
              DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: dentro la critical section');
              AuthDom:=AutenticazioneDominio(QI090.FieldByName('DOMINIO_USR').AsString, edtUtente.Text, edtPassword.Text, QI090.FieldByName('DOMINIO_USR_TIPO').AsString);
            finally
              CSAutenticazioneDominio.Leave;
              DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSAutenticazioneDominio: Leave effettuata');
            end;
            if not AuthDom and ((edtPassword.Text = '') or (R180CriptaI070(edtPassword.Text) <> QI070.FieldByName('PassWd').AsString)) then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AUT_DOM_FALLITA));
              raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_AUT_DOM_FALLITA));
            end;
          end
          //Fine autenticazione su dominio
          else if (LoginEsterno = 'N') and (R180CriptaI070(edtPassword.Text) <> QI070.FieldByName('PassWd').AsString) then
          begin
            GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_PSW_ERRATA));
            edtPassword.Clear;
            ActiveControl:=edtPassword;
            raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PSW_ERRATA));
          end;
          // daniloc.fine

          //Registrazione parametri/inibizioni
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioni: iniziata');
          RegistraInibizioni;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM.RegistraInibizioni: terminata');
          WR000DM.TipoUtente:='Supervisore';
          GGetWebApplicationThreadVar.SessionTimeOut:=WR000DM.TimeoutOper;
          A000SessioneWEB.TimeOutOriginale:=GGetWebApplicationThreadVar.SessionTimeOut;

          // controllo scadenza password (saltato se login esterno)
          Sysdate:=Trunc(R180Sysdate(QI090.Session));
          if (LoginEsterno = 'N') and
             (QI070.FindField('DATA_PW') <> nil) and
             (not AuthDom) then
            if (Parametri.ValiditaPassword > 0) and
               (R180AddMesi(QI070.FieldByName('DATA_PW').AsDateTime,Parametri.ValiditaPassword) <= Sysdate) then
              PwdScaduta:=True;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - autenticazione per utente win: terminata');
        end;

        if Parametri.VersioneOracle = 0 then
          Parametri.VersioneOracle:=11;

        //Controllo allineamento versione db e versione applicativo
        if (Parametri.VersioneDB <> '') and (Parametri.VersionePJ <> Parametri.VersioneDB) then
        begin
          GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_MSG_ALLINEAMENTO_VERSIONE),[Parametri.VersioneDB,Parametri.VersionePJ]));
          Abort;
        end;
        Parametri.AuthDom:=AuthDom;
        if AuthDom then
          Parametri.PassOper:=edtPassword.Text;
        if WR000DM.TipoUtente = 'Supervisore' then
        begin
          //Verifica se il campo ACCESSO_NEGATO è N (significa che l'accesso è valido)
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica ACCESSO_NEGATO: iniziata');
          if QI070.FindField('ACCESSO_NEGATO') <> nil then
          begin
            if QI070.FieldByName('ACCESSO_NEGATO').AsString = 'S' then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_ACCESSO_INIBITO));
              Abort;
            end;
          end;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica ACCESSO_NEGATO: terminata');

          //Verifica se dall'ultimo accesso sono passati "VALID_UTENTE" mesi.In tal caso nega l'accesso
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica scadenza password: iniziata');
          Sysdate:=Trunc(R180Sysdate(QI090.Session));
          if (edtUtente.Text <> 'SYSMAN') and (QI070.FindField('DATA_ACCESSO') <> nil) then
            if (not QI070.FieldByName('DATA_ACCESSO').IsNull) and
               (QI090.FieldByName('VALID_UTENTE').AsInteger > 0) and
               (R180AddMesi(QI070.FieldByName('DATA_ACCESSO').AsDateTime,Parametri.ValiditaUtente) <= Sysdate) then
            begin
              GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_USER_SCADUTA));
              Abort;
            end;
          //Testa il campo NUOVA_PASSWORD per vedere se l'utente deve cambiare la password
          if (not AuthDom) and (QI070.FindField('NUOVA_PASSWORD') <> nil) then
            if (Parametri.Applicazione <> '') and (QI070.FieldByName('NUOVA_PASSWORD').AsString = 'S') then
              PwdScaduta:=True;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - verifica scadenza password: terminata');
        end;
        if (WR000DM.TipoUtente = 'Supervisore') and (Parametri.Applicazione <> '') then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - aggiornamento data accesso: iniziata');
          OperSQL.SQL.Clear;
          OperSQL.SQL.Add(Format('UPDATE I070_UTENTI SET NUOVA_PASSWORD = ''N'', DATA_ACCESSO = TRUNC(SYSDATE) WHERE AZIENDA = ''%s'' AND UTENTE = ''%s''',[edtAzienda.Text,edtUtente.Text]));
          OperSQL.Execute;
          OperSQL.Session.Commit;
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - aggiornamento data accesso: terminata');
        end;
      end;
    finally
      try
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: distruzione con FreeAndNil iniziata');
        if W001FPasswordDtM <> nil then
          FreeAndNil(W001FPasswordDtM);
        DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W001FPasswordDtM: distruzione con FreeAndNil terminata');
        //Se la sessione oracle di autenticazione è condivisa,
        //diminuisco il tag per indicare che non è più in uso da questa sessione web
        if (nsl >= 0) and
           (Pos(INI_PAR_NO_SHARED_LOGIN,W000ParConfig.ParametriAvanzati) = 0) then
        begin
          DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: attesa per Enter');
          CSSessioneMondoEDP.Enter;
          try
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: dentro la critical section');
            (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=(lstSessioniMondoEDP[nsl] as TOracleSession).Tag - 1;
          finally
            CSSessioneMondoEDP.Leave;
            DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - CSSessioneMondoEDP: Leave effettuata');
          end;
        end;
      except
        on E:Exception do
          Log('Errore','Errore in fase di accesso',E);
      end;
    end;
    //Fine Autenticazione

    //Ricerca e inizializzazione di SessioneOracle
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.GetSessioneLavoro: invocato');
    ns:=WR000DM.GetSessioneLavoro;
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.GetSessioneLavoro: terminato');
    Log('Sessione','GetSessioneLavoro');

    // registra accesso sui log
    Log('Accesso','Login utente ' + WR000DM.TipoUtente + ': ' + Parametri.Operatore);

    QueryPK1.Session:=SessioneOracle;
    RegistraLog.Session:=SessioneOracle;
    //Caratto 15/04/2013 Imposto sessione oracle corretta. Non uso la funzione RegistraMsg perchè mi restituirebbe il A000RegistraMsg
    ((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN.RegistraMsg as TRegistraMsg).SessioneOracleApp:=SessioneOracle;
    RegistraMsgSessione.IniziaMessaggio(medpCodiceForm);

    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.DataModuleCreate: invocato');
    WR000DM.DataModuleCreate(nil);
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.DataModuleCreate: terminato');
    Log('Sessione','SessioneORACLE:' + IntToStr(ns) + ';SessioneWEB:' + IntToStr(SessioneOracle.Tag));

    //Inizializzazione del datamodule
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.InizializzazioneW001DtM: invocato');
    Log('Traccia','InizializzazioneW001DtM: inizio');
    WR000DM.InizializzazioneW001DtM;
    Log('Traccia','InizializzazioneW001DtM completata');
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.InizializzazioneW001DtM: terminato');

    if PwdScaduta then
    begin
      Log('Traccia','Password scaduta: gestione');
      WC023:=TWC023FCambioPasswordFM.Create(GGetWebApplicationThreadVar);
      //TODO WC023.MessaggioStatus(ESCLAMA,A000TraduzioneStringhe(A000MSG_MSG_PSW_SCADUTA));
      WC023.lblEMail.Visible:=False;
      WC023.edtEMail.Visible:=False;
      WC023.lblRicMail.Visible:=False;
      WC023.chkRicMail.Visible:=False;
      WC023.btnAnnulla.Visible:=False;
      WC023.Visualizza;
      Exit;
    end;

    Log('Traccia','Determina accesso diretto valutatore');
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.AccessoValutatore: invocato');
    WR000DM.AccessoDirettoValutatore:=WR000DM.AccessoValutatore(UpperCase(edtAzienda.Text),UpperCase(edtUtente.Text));
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - WR000DM.AccessoValutatore: terminato');

    // registra data e ora di accesso su I060 se dipendente
    if WR000DM.TipoUtente = 'Dipendente' then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - registrazione accesso dipendente: iniziato');
      Log('Traccia','Registrazione accesso dipendente');
      with WR000DM.updI061UltimoAccesso do
      begin
        SetVariable('AZIENDA',Parametri.Azienda);
        SetVariable('NOME_UTENTE',Parametri.Operatore);
        SetVariable('NOME_PROFILO',Parametri.ProfiloWEB);
        Execute;
        SessioneOracle.Commit;
      end;
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - registrazione accesso dipendente: terminato');
    end;

    if WR000DM.TipoUtente = 'Dipendente' then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - impostazione parametri progressivo e matricola: iniziato');
      Log('Traccia','Impostazione progressivo e matricola dipendente');
      with TOracleDataSet.Create(nil) do
      try
        Session:=SessioneOracle;
        SQL.Text:=Format('select PROGRESSIVO,MATRICOLA from T030_ANAGRAFICO where MATRICOLA = (select MATRICOLA from MONDOEDP.I060_LOGIN_DIPENDENTE where AZIENDA = ''%s'' and NOME_UTENTE = ''%s'')',[Parametri.Azienda,AggiungiApice(Parametri.Operatore)]);
        Open;
        if RecordCount > 0 then
        begin
          Parametri.ProgressivoOper:=FieldByName('PROGRESSIVO').AsInteger;
          Parametri.MatricolaOper:=FieldByName('MATRICOLA').AsString;
        end;
      finally
        Free;
      end;
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - impostazione parametri progressivo e matricola: terminato');
    end;

    // legge le abilitazioni dei moduli irisweb da FunzioniDisponibili
    Log('Traccia','Lettura abilitazioni: inizio');
    GetAbilitazioniModuli;
    Log('Traccia','Lettura abilitazioni: fine');

    // effettua automaticamente la ricerca dei dipendenti in base al filtro anagrafe
    // anche per l'operatore iriswin (supervisore)
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002: invocato costruttore');
    W002:=TW002FRicercaAnagrafe.Create(GGetWebApplicationThreadVar);
    DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002: creazione terminata');
    if WR000DM.AccessoDirettoValutatore <> 'N' then
      W002.VisualizzaCessati:=True
    else
      W002.VisualizzaCessati:=Parametri.InibizioneIndividuale;

    // se utente supervisore e filtro anagrafe non indicato richiede i criteri di ricerca
    if (WR000DM.TipoUtente = 'Supervisore') and
       (WR000DM.AccessoDirettoValutatore = 'N') and
       (Parametri.Inibizioni.Text = '') then
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.OpenPage: invocato');
      W002.OpenPage;
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.OpenPage: terminato');
    end
    else
    begin
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.btnRicercaTopClick invocato');
      W002.TipoRicerca:='';
      W002.btnRicercaTopClick(Self);
      DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - W002.btnRicercaTopClick terminato');
    end;
  EXCEPT
    on E:Exception do
    begin
      if (not (E is EAbort)) and
         (E.Message <> A000TraduzioneStringhe(A000MSG_MSG_SEL_PROFILO)) and
         (E.Message <> A000TraduzioneStringhe(A000MSG_ERR_PROFILO_NON_TROVATO)) and
         (E.Message <> A000TraduzioneStringhe(A000MSG_ERR_AUT_DOM_FALLITA)) then
      begin
        Log('Errore','Errore in fase di accesso',E);
      end;

      // gestione errore in caso di login esterno
      if LoginEsterno = 'S' then
      begin
        // se fallito login esterno ed è specificato un url differente uso quello:
        if W000ParConfig.UrlLoginErrato <> '' then
          (GGetWebApplicationThreadVar.Data as TSessioneWeb).HomeUrl:=W000ParConfig.UrlLoginErrato;
        lnkEsciClick(nil);
      end
      else
      begin
        MessaggioStatus(ERRORE,E.Message);
      end;
      Exit; // aggiunto per evitare la free
    end;
  END;

  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkAccediClick - fine metodo (prima di release)');
  Release;
end;

procedure TW001FLogin.GetAbilitazioniModuli;
// legge le abilitazioni dei moduli opzionali
var
  i: Integer;
  LAzienda: String;
  LModulo: String;
  LAbilitato: Boolean;
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.GetAbilitazioniModuli - inizio metodo');
  WR000DM.ModuliAccessori.Clear;
  for i:=Low(FunzioniDisponibili) to High(FunzioniDisponibili) do
  begin
    // se la funzione è associata ad un modulo opzionale ne valuta l'abilitazione
    if FunzioniDisponibili[i].MIW <> '' then
    begin
      LAzienda:=Parametri.Azienda;
      LModulo:=FunzioniDisponibili[i].MIW;
      if WR000DM.ModuliAccessori.Add(LAzienda,LModulo) then
      begin
        // traccia l'abilitazione (una volta sola per modulo)
        LAbilitato:=WR000DM.ModuliAccessori.IsAbilitato(LAzienda,LModulo);
        Log('Traccia',Format('Azienda %s: modulo %s %s',[LAzienda,LModulo,IfThen(LAbilitato,'abilitato','non abilitato')]));
      end;
    end;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.GetAbilitazioniModuli - fine metodo');
end;

procedure TW001FLogin.edtAziendaSubmit(Sender: TObject);
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.edtAziendaSubmit - inizio metodo');
  lnkAccediClick(nil);
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.edtAziendaSubmit - fine metodo');
end;

procedure TW001FLogin.lnkRecuperaPasswordClick(Sender: TObject);
var
  nsl: Integer;
  ParDominioDip: String;
  ParEMailSMTPHost: String;
  ParEMailUserName: String;
  ParEMailPassWord: String;
  ParEMailPort: String;
  ParEMailSenderIndirizzo: String;
  MailPwd: String;
  MailPwdDecifrata: String;
  MailIndirizzi: String;
  MailTestoHtml: String;
  MailTestoNormale: String; // AOSTA_ASL - chiamata 79156
  EsisteAzienda: Boolean;
  EsisteUtente: Boolean;
  ElencoAziende: String; // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6
begin
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkRecuperaPasswordClick - inizio metodo');
  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
  // controllo indicazione limitato al nome utente

  // verifica che azienda e utente siano indicati
  // questi dati sono indispensabili per il recupero della password
  // (l'azienda è comunque impostata automaticamente)

  // controlla campo utente
  if edtUtente.Text = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W001_ERR_FMT_RECUPERO_PWD_INPUT),[lblUtente.Caption]));
    edtUtente.SetFocus;
    Exit;
  end;
  // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine

  // avvia recupero password
  if W001FPasswordDtM = nil then
  begin
    W001FPasswordDtM:=TA001FPasswordDtM1.Create((GGetWebApplicationThreadVar.Data as TSessioneWeb).SessioneIrisWIN);
  end;
  try
    WR000DM.W001FPasswordDtM:=W001FPasswordDtM;
    nsl:=WR000DM.GetSessioneLogin(edtDatabase.Text);
    if nsl = -1 then
      Abort;
    CSSessioneMondoEDP.Enter;
    try
      W001FPasswordDtM.InizializzazioneSessione(edtDatabase.Text);
    finally
      CSSessioneMondoEDP.Leave;
    end;

    // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.ini
    // in fase di login interattivo, se l'azienda non viene indicata,
    // il programma cerca di individuarla utilizzando solo il nome utente,
    // ricercando su I060 per le aziende con LOGIN_DIP_ABILITATO = 'S'
    // e su I070 per le aziende con LOGIN_USR_ABILITATO = 'S'
    ForzaAziendaVisibile:=False;
    if (edtAzienda.Text = '') and (edtUtente.Text <> '') then
    begin
      // azienda non indicata: ricerca tramite nome utente
      // estrae l'elenco delle aziende
      with W001FPasswordDtM.selDistAzienda do
      begin
        Close;
        ClearVariables;
        SetVariable('UTENTE',edtUtente.Text);
        SetVariable('FILTRO_DOMINIO_DIP','AND    I090.DOMINIO_DIP IS NULL');
        SetVariable('FILTRO_DOMINIO_USR','AND    I090.DOMINIO_USR IS NULL');
        Open;
        // casi da gestire:
        // 0   record -> errore azienda non indicata
        // 1   record -> ok (si rifà alla gestione precedente)
        // N>1 record -> proporre lista aziende da selezionare
        if RecordCount = 0 then
        begin
          // ricerca azienda fallita -> chiede all'utente di indicare l'azienda
          // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
          ForzaAziendaVisibile:=True;
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_ERR_AZIENDA_NON_INDICATA));
          Exit;
        end
        else if RecordCount = 1 then
        begin
          // imposta l'azienda individuata
          edtAzienda.Text:=FieldByName('AZIENDA').AsString;
        end
        else if RecordCount > 1 then
        begin
          // il nome utente indicato è presente in più aziende:
          // propone la lista delle aziende da scegliere
          // nel caso in cui l'azienda fosse non visibile, ne forza la visibilità
          ForzaAziendaVisibile:=True;
          ElencoAziende:='';
          First;
          while not Eof do
          begin
            ElencoAziende:=ElencoAziende + FieldByName('AZIENDA').AsString.QuotedString + ',';
            Next;
          end;
          jqAutocomplete.OnReady.Text:=
            'var elementi = [' + ElencoAziende.Substring(0,ElencoAziende.Length - 1) + '];' + CRLF +
            '$("#' + edtAzienda.HTMLName + '").autocomplete({' + CRLF +
            '  source: elementi,' + CRLF +
            '  delay: 0,' + CRLF +
            '  minLength: 0' + CRLF +
            '}).focus(function(){ ' + CRLF +
            '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
            '}); ';
          GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_MSG_SEL_AZIENDA));
          Exit;
        end;
      end;
    end;
    // TORINO_CITTADELLASALUTE - commessa: 2013/110 INT_TECN#6.fine


    // inizializa variabili
    MailIndirizzi:='';
    MailPwd:='';
    MailPwdDecifrata:='';

    // estrae parametro per dominio di autenticazione
    // (verifica contestualmente esistenza dell'azienda)
    with W001FPasswordDtM.QI090 do
    begin
      Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
      Close;
      SetVariable('AZIENDA',edtAzienda.Text);
      Open;
      EsisteAzienda:=RecordCount > 0;
      if RecordCount > 0 then
      begin
        ParDominioDip:=FieldByName('DOMINIO_DIP').AsString;
      end;
      Close;
    end;

    if not EsisteAzienda then
    begin
      // utente inesistente
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_NO_AZIENDA));
      Exit;
    end;

    // estrae dati utente da I060
    with W001FPasswordDtM.QI060 do
    begin
      Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
      Close;
      ClearVariables;
      SetVariable('AZIENDA',edtAzienda.Text);
      SetVariable('UTENTE',edtUtente.Text);
      Open;
      EsisteUtente:=RecordCount > 0;
      if RecordCount > 0 then
      begin
        MailIndirizzi:=FieldByName('EMAIL').AsString;
        MailPwd:=FieldByName('PASSWORD').AsString;
      end;
      Close;
    end;

    if not EsisteUtente then
    begin
      // utente inesistente
      GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_NO_UTENTE));
      Exit;
    end;

    // gestione recupero password via mail
    with W001FPasswordDtM.QI091 do
    begin
      Session:=(lstSessioniMondoEDP[nsl] as TOracleSession);
      Close;
      SetVariable('AZIENDA',edtAzienda.Text);
      Open;
      ParEmailSMTPHost:=VarToStr(Lookup('Tipo','C90_EMAIL_SMTPHOST','Dato'));
      ParEmailUserName:=VarToStr(LookUp('Tipo','C90_EMAIL_USERNAME','Dato'));
      ParEmailPassWord:=R180Decripta(VarToStr(Lookup('Tipo','C90_EMAIL_PASSWORD','Dato')),30011945);
      ParEmailPort:=VarToStr(Lookup('Tipo','C90_EMAIL_PORT','Dato'));
      ParEmailSenderIndirizzo:=VarToStr(Lookup('Tipo','C90_EMAIL_SENDER_INDIRIZZO','Dato'));
      Close;
    end;
  finally
    FreeAndNil(W001FPasswordDtM);
    if nsl >= 0 then
    begin
      CSSessioneMondoEDP.Enter;
      try
        (lstSessioniMondoEDP[nsl] as TOracleSession).Tag:=(lstSessioniMondoEDP[nsl] as TOracleSession).Tag - 1;
      finally
        CSSessioneMondoEDP.Leave;
      end;
    end;
  end;

  // se l'autenticazione avviene sul dominio e la password non è indicata
  // avvisa l'utente che la modifica della password non è consentita
  if (MailPwd = '') and
     (ParDominioDip <> '') then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_AUT_ESTERNA));
    Exit;
  end;

  // avvisa se l'utente non ha una mail associata
  if MailIndirizzi = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_NO_MAIL));
    Exit;
  end;

  // avvisa se non è indicato il server di posta
  if ParEmailSMTPHost = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W001_ERR_RECUPERO_PWD_NO_HOST));
    Exit;
  end;

  // decifra la password
  if MailPwd = '' then
    MailPwdDecifrata:='<vuota>'
  else
    MailPwdDecifrata:=R180Decripta(MailPwd,30011945);

  // imposta il testo della mail
  MailTestoHtml:='<div style="font-size: 13px; font-family: Arial">' +
                 '<p>' +
                 '  Gentile utente,<br>' +
                 '  ecco i dati di accesso a <b>IrisWeb</b> richiesti alle %s<br>' +
                 '  tramite la procedura di recupero password:' +
                 '</p>' +
                 '<table cellpadding="5" style="width: 200px; font-size: 12px; font-family: Courier New, Courier, mono; border-collapse: collapse;">' +
                 '  <tbody>' +
                 '    <tr>' +
                 '      <td style="border: 1px solid #AAAAAA;">Azienda</td>' +
                 '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                 '    </tr>' +
                 '    <tr>' +
                 '      <td style="border: 1px solid #AAAAAA;">Utente</td>' +
                 '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                 '    </tr>' +
                 '    <tr>' +
                 '      <td style="border: 1px solid #AAAAAA;">Password</td>' +
                 '      <td style="border: 1px solid #AAAAAA;">%s</td>' +
                 '    </tr>' +
                 '  </tbody>' +
                 '</table>' +
                 '<br><br>' +
                 '<p>' +
                 '  Avviso:<br>' +
                 '  La presente e-mail &egrave; stata generata automaticamente dal sistema IrisWEB.<br>' +
                 '  Si prega di non rispondere a questo indirizzo di posta,<br>' +
                 '  in quanto non &egrave; abilitato alla ricezione di messaggi.' +
                 '</p>' +
                 '</div>';
  MailTestoHtml:=Format(MailTestoHtml,[FormatDateTime('dd/mm/yyyy hhhh.mm',Now),edtAzienda.Text,edtUtente.Text,MailPwdDecifrata]);
  // AOSTA_ASL - chiamata 79156.ini
  // prepara il testo alternativo per i client che non supportano html
  MailTestoNormale:='Gentile utente,'#13#10 +
                    '  ecco i dati di accesso a IrisWeb richiesti alle %s'#13#10 +
                    'tramite la procedura di recupero password:'#13#10 +
                    #13#10 +
                    'Azienda: %s'#13#10 +
                    'Utente: %s'#13#10 +
                    'Password: %s'#13#10 +
                    #13#10 +
                    'Avviso:'#13#10 +
                    //'  versione in testo normale per i client di posta che non supportano html.'#13#10 +
                    '  La presente e-mail è stata generata automaticamente dal sistema IrisWEB.'#13#10 +
                    '  Si prega di non rispondere a questo indirizzo di posta,'#13#10 +
                    '  in quanto non è abilitato alla ricezione di messaggi.';
  MailTestoNormale:=Format(MailTestoNormale,[FormatDateTime('dd/mm/yyyy hhhh.mm',Now),edtAzienda.Text,edtUtente.Text,MailPwdDecifrata]);
  // AOSTA_ASL - chiamata 79156.fine

  // parametri ok
  IdSMTP.Host:=ParEmailSMTPHost;
  IdSMTP.Port:=StrToIntDef(ParEmailPort,25);

  // invia la password all'indirizzo di posta indicato
  try
    try
      // connessione smtp
      IdSMTP.HeloName:=ParEMailUserName;
      IdSMTP.Connect;

      // parametri di autenticazione per invio mail
      IdSMTP.AuthType:=satDefault;
      IdSMTP.Username:=ParEMailUserName;
      IdSMTP.Password:=ParEMailPassWord;

      // imposta i dati della mail
      IdMessage.From.Address:=ParEMailSenderIndirizzo;
      IdMessage.From.Name:='IrisWEB';
      IdMessage.BccList.Clear;
      IdMessage.Recipients.Clear;
      IdMessage.Recipients.EmailAddresses:=MailIndirizzi;
      IdMessage.Subject:='Password di accesso a IrisWeb';

      // imposta il testo della mail
      IdMessage.MessageParts.Clear;
      // AOSTA_ASL - chiamata 79156.ini
      // gestione invio mail con testo alternativo (per client che non supportano html)
      // cfr. http://www.indyproject.org/sockets/blogs/rlebeau/2005_08_17_a.en.aspx

      {
      // v1. invio mail solo in html (versione da non usare, troppo debole)
      IdMessage.ContentType:='text/html';
      IdMessage.Body.Text:=MailTesto;
      }

      // v2: testo html + testo normale
      {
      // oggetto per testo normale (usato dai client che non supportano html)
      with TIdText.Create(IdMessage.MessageParts, nil) do
      begin
        Body.Text:=MailTestoNormale;
        ContentType:='text/plain';
      end;
      // oggetto per testo html
      with TIdText.Create(IdMessage.MessageParts, nil) do
      begin
        Body.Text:=MailTestoHtml;
        ContentType:='text/html';
      end;
      IdMessage.ContentType:='multipart/alternative';
      }
      // v2.fine
      // AOSTA_ASL - chiamata 79156.fine

      // AOSTA_ASL - chiamata 80050.ini
      // nonostante gli sforzi, i client di Aosta_Asl continuano a non visualizzare correttamente il testo della mail
      // la difficoltà è che non si riesce a riprodurre il problema: sono stati effettuati test
      // su diversi client di posta, anche molto vecchi (es. outlook 2003) ma senza riscontrare problemi
      // come soluzione si è deciso di inviare il testo in text/plain
      // nota: è stato copiato il content type da C017, compresa la specifica del character set iso-8859-15
      // v3: solo testo normale
      IdMessage.ContentType:='text/plain; charset=ISO-8859-15';
      IdMessage.Body.Text:=MailTestoNormale;
      // v3.fine
      // AOSTA_ASL - chiamata 80050.fine

      IdSMTP.Send(IdMessage);
      Log('Traccia','Recupero password utente ' + edtUtente.Text);

      // messaggio di invio della mail completato
      Notifica(A000TraduzioneStringhe(A000MSG_W001_MSG_RECUPERO_PWD_INVIATA_TITLE),A000TraduzioneStringhe(A000MSG_W001_MSG_RECUPERO_PWD_INVIATA),'../img/mail-icon-ok.png',False,False,10000);
    except
      on E:Exception do
      begin
        raise Exception.Create('Invio email fallito su host ' + IdSMTP.Host + ': ' + E.ClassName + '/' + E.Message);
      end;
    end;
  finally
    IdSMTP.Disconnect;
  end;
  DebugToFile(GGetWebApplicationThreadVar,'TW001FLogin.lnkRecuperaPasswordClick - fine metodo');
end;

initialization
  TW001FLogin.SetAsMainForm;

end.