unit C017UEMailDtM;

interface

uses
  Windows, SysUtils, Classes, Oracle, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient,
  IdSMTPBase, IdSMTP, C180FunzioniGenerali,
  A000UInterfaccia, A000UCostanti, Variants, DB, OracleData, StrUtils, Math,
  medpSendMail;

type
  TDatiMail = record
    TipoMail: String;
    Oggetto: String;
    Corpo: String;
    class operator Equal(ALeftOp, ARightOp: TDatiMail): Boolean;
    class operator NotEqual(ALeftOp, ARightOp: TDatiMail): Boolean;
  end;

  TC017FEMailDtM = class(TDataModule)
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    scrEMailResponsabile: TOracleQuery;
    scrEMailDipendente: TOracleQuery;
    selI060MailResp: TOracleDataSet;
    updI061UltimoInvio: TOracleQuery;
    selI060NomiResp: TOracleDataSet;
    selI091: TOracleDataSet;
    procedure DataModuleDestroy(Sender: TObject);
  private
    medpEMail:TmedpSendMail;
    FQueryDest: TOracleQuery;
    FDestResponsabile,
    FSollevaEccezioni: Boolean;
    FSessione: TOracleSession;
    FTagFunzione,
    FProgressivo: Integer;
    FDestinatari: String;
    FNomiDestinatari: String;
    FCercaDestinatari: Boolean;
    FDestinatariCC: String;
    FDestinatariCCN: String;
    FOggetto: String;
    FTesto: String;
    FFiltroAgg: String;
    FIter: String;
    FCodIter: String;
    FLivelliDest: String;
    FDisclaimer: String;
    FTraccia: String;
    FWebParametriAvanzati: String;
    // variabili per i dati di "Parametri.XXX" non leggibili dal thread
    ParAzienda,
    ParV430,
    ParHintT030V430,
    ParC90_EmailThread,
    ParC90_EMailRespOttimizzata,
    ParC90_EMailRespGGReinvio,
    ParC90_EMailSMTPHost,
    ParC90_EMailSenderIndirizzo,
    ParC90_EMailUserName,
    ParC90_EMailPassword,
    ParC90_EMailPort,
    ParC90_EMailHeloName: String;
    function ConvertiFiltro(const PFiltro: String): String;
    procedure AggiornaOraInvio;
    procedure AddTraccia(const Funzione, Messaggio: String);
    procedure PutCercaDestinatari(const Value: Boolean);
    const
      MAIL_DISCLAIMER = CRLF + CRLF + 'Avviso:' + CRLF +
                        'La presente e-mail e'' stata generata automaticamente dal sistema IrisWEB.' + CRLF +
                        'Si prega di non rispondere a questo indirizzo di posta,' + CRLF +
                        'in quanto non è abilitato alla ricezione di messaggi.%s';
  public
    constructor Create(AOwner: TComponent); override;
    procedure GetDestinatari;
    procedure SendMail;
    procedure InviaEmail; overload;
    procedure InviaEMail(PSessione:TOracleSession; PDestResponsabile:Boolean; PProgressivo: Integer;
      POggetto,PTesto:String; PTag:Integer; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = ''); overload;
    //Se CercaDestinatari = False, non usare Progressivo e/o DestResponsabile in quanto si dà per scontato che Destinatari è già valorizzato
    property CercaDestinatari: Boolean read FCercaDestinatari write PutCercaDestinatari;
    property Destinatari: String read FDestinatari write FDestinatari;
    property NomiDestinatari: String read FNomiDestinatari write FNomiDestinatari;
    property DestinatariCC: String read FDestinatariCC write FDestinatariCC;
    property DestinatariCCN: String read FDestinatariCCN write FDestinatariCCN;
    property DestResponsabile: Boolean read FDestResponsabile write FDestResponsabile;
    property Disclaimer: String read FDisclaimer write FDisclaimer;
    property FiltroAgg: String read FFiltroAgg write FFiltroAgg;
    property Iter: String read FIter write FIter;
    property CodIter: String read FCodIter write FCodIter;
    property LivelliDest: String read FLivelliDest write FLivelliDest;
    property Oggetto: String read FOggetto write FOggetto;
    property Progressivo: Integer read FProgressivo write FProgressivo;
    property Sessione: TOracleSession read FSessione write FSessione;
    property SollevaEccezioni: Boolean read FSollevaEccezioni write FSollevaEccezioni;
    property TagFunzione: Integer read FTagFunzione write FTagFunzione;
    property Testo: String read FTesto write FTesto;
    property Traccia: String read FTraccia;
    property WebParametriAvanzati: String read FWebParametriAvanzati write FWebParametriAvanzati;
  end;

implementation

{$R *.dfm}

constructor TC017FEMailDtM.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // inizializza proprietà default
  DestResponsabile:=True;
  Destinatari:='';
  DestinatariCC:='';
  DestinatariCCN:='';
  CercaDestinatari:=True;
  Disclaimer:=Format(MAIL_DISCLAIMER,[CRLF + '[versione applicativo: ' + Parametri.VersionePJ + ']']);
  FiltroAgg:='';
  Iter:='';
  CodIter:='';
  LivelliDest:='';
  Oggetto:='';
  Progressivo:=0;
  Sessione:=nil;
  SollevaEccezioni:=False;
  TagFunzione:=-1;
  Testo:='';
  FTraccia:='';
  FWebParametriAvanzati:='';

  medpEMail:=TmedpSendMail.Create;
  // inizializza parametri ("Parametri.XXX" non leggibili dal thread)
  ParAzienda:=Parametri.Azienda;
  ParV430:=Parametri.V430;
  ParHintT030V430:=Parametri.CampiRiferimento.C26_HintT030V430;
  ParC90_EmailThread:=Parametri.CampiRiferimento.C90_EmailThread;
  ParC90_EMailRespOttimizzata:=Parametri.CampiRiferimento.C90_EMailRespOttimizzata;
  ParC90_EMailRespGGReinvio:=Parametri.CampiRiferimento.C90_EMailRespGGReinvio;
  ParC90_EMailSMTPHost:=Parametri.CampiRiferimento.C90_EMailSMTPHost;
  ParC90_EMailUserName:=Parametri.CampiRiferimento.C90_EMailUserName;
  ParC90_EMailHeloName:=Parametri.CampiRiferimento.C90_EMailHeloName;
  ParC90_EMailPassword:=Parametri.CampiRiferimento.C90_EMailPassWord;
  ParC90_EMailPort:=Parametri.CampiRiferimento.C90_EMailPort;
  ParC90_EMailSenderIndirizzo:=Parametri.CampiRiferimento.C90_EMailSenderIndirizzo;
end;

procedure TC017FEMailDtM.DataModuleDestroy(Sender: TObject);
begin
 try
  FreeAndNil(medpEMail);
 except
 end;
end;

procedure TC017FEMailDtM.AddTraccia(const Funzione,Messaggio: String);
var
  Ora: String;
const
  APP_ID = '0000000000000000000000000000';
begin
  Ora:=FormatDateTime('dd/mm/yyyy hh.nn.ss',Now);
  if FTraccia <> '' then
    FTraccia:=FTraccia + '|';
  FTraccia:=FTraccia + Format('%s;%s;%s;%s - %s',[Ora,APP_ID,'    ;C017 ',Funzione,Messaggio]);
end;

function TC017FEMailDtM.ConvertiFiltro(const PFiltro: String): String;
const
  FUNZIONE = 'ConvertiFiltro';
begin
  AddTraccia(FUNZIONE,'inizio');
  Result:=AggiungiApice(PFiltro); // gestione carattere apice nel nome profilo - daniloc. 26.03.2012
  Result:=StringReplace(Result,'<U>','I061.NOME_UTENTE = ''',[rfReplaceAll]);
  Result:=StringReplace(Result,'<P>',''' and I061.NOME_PROFILO = ''',[rfReplaceAll]);
  if Pos(';',Result) = 0 then
    Result:='and ' + Result + ''''
  else
  begin
    Result:=StringReplace(Result,';',''') or (',[rfReplaceAll]);
    Result:='and ((' + Result + '''))';
  end;
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.GetDestinatari;
// estrae l'elenco dei destinatari in base alle informazioni sotto riportate.
// Nota: l'elenco viene eventualmente filtrato se la mail è rivolta
//       al responsabile ed è attivo il parametro di ottimizzazione
// parametri per estrazione destinatari:
// - Progressivo:       progressivo del dipendente
// - DestResponsabile:  direzione mail (a responsabile / a dipendente)
// - TagFunzione:       tag di abilitazione funzione (facoltativo)
const
  FUNZIONE = 'GetDestinatari';
begin
  AddTraccia(FUNZIONE,'inizio');
  AddTraccia(FUNZIONE,Format('destinatario=%s,azienda=%s,progressivo=%d,tag=%d,v430=%s,iter=%s,coditer=%s,livelli=%s',
                             [IfThen(DestResponsabile,'responsabile','dipendente'),ParAzienda,Progressivo,TagFunzione,ParV430,Iter,CodIter,LivelliDest]));
  FDestinatari:='';
  FNomiDestinatari:='';
  try
    // controllo proprietà
    if DestResponsabile and (Iter <> '') and (CodIter = '') then
      raise Exception.Create('Recupero indirizzo email: codice iter non specificato per iter ' + CodIter + '!');

    // 1. estrae i dati dei destinatari della mail di avviso
    if DestResponsabile then
      FQueryDest:=scrEMailResponsabile
    else
      FQueryDest:=scrEMailDipendente;

    // i parametri avanzati sono impostati dal chiamante perché non accessibili da qui
    // (v. WR000UBaseDM, A023UTimbratureMW, A004UGiustifAssPresMW)
    if Pos(INI_PAR_C017_V430,WebParametriAvanzati) > 0 then
      ParV430:='P430';
    if (ParV430 = 'P430') and (ParHintT030V430 = '') then
      ParHintT030V430:='/*+ ordered */';
    FQueryDest.Session:=Sessione;
    FQueryDest.ClearVariables;
    FQueryDest.SetVariable('AZIENDA',ParAzienda);
    FQueryDest.SetVariable('PROGRESSIVO',Progressivo);
    if TagFunzione <> -1 then
      FQueryDest.SetVariable('TAG',TagFunzione);
    if DestResponsabile then
    begin
      // variabili specifiche per la mail verso il responsabile
      FQueryDest.SetVariable('hintT030V430',ParHintT030V430);
      FQueryDest.SetVariable('V430',ParV430);
      FQueryDest.SetVariable('ITER',Iter);
      FQueryDest.SetVariable('COD_ITER',CodIter);
      FQueryDest.SetVariable('ELENCO_LIVELLI',LivelliDest);
    end;
    try
      FQueryDest.Execute;
      FDestinatari:=Trim(VarToStr(FQueryDest.GetVariable('EMAIL')));
      AddTraccia(FUNZIONE,'mail destinatari: ' + FDestinatari);
      if FDestinatari = '' then
        Exit;
      if DestResponsabile and (FQueryDest.VariableIndex('FILTRO_AGG') <> -1) then
      begin
        FFiltroAgg:=Trim(VarToStr(FQueryDest.GetVariable('FILTRO_AGG')));
        AddTraccia(FUNZIONE,'filtro agg.: ' + FFiltroAgg);
        FFiltroAgg:=ConvertiFiltro(FFiltroAgg);
        AddTraccia(FUNZIONE,'filtro agg. convertito: ' + FFiltroAgg);
      end
      else
        FFiltroAgg:='';
    except
      on E:Exception do
        raise Exception.Create('Recupero indirizzo email: ' + E.ClassName + '/' + E.Message);
    end;

    AddTraccia(FUNZIONE,'gestione ottimizzata ' + IfThen(ParC90_EMailRespOttimizzata = 'S','attiva','disattiva'));

    // 2. se mail diretta a responsabile e parametro ottimizzazione attivo
    //    elabora gli indirizzi dei destinatari
    if DestResponsabile and (ParC90_EMailRespOttimizzata = 'S') then
    begin
      AddTraccia(FUNZIONE,'elaborazione indirizzi destinatari.ini');
      // imposta oggetto e corpo della mail con diciture predefinite
      Oggetto:='Notifica presenza richieste da autorizzare';
      Testo:='Si avvisa che sono presenti richieste' + CRLF +
             'in attesa di autorizzazione.';

      // elabora indirizzi dei destinatari
      selI060MailResp.Session:=Sessione;
      selI060MailResp.Close;
      selI060MailResp.SetVariable('AZIENDA',ParAzienda);
      selI060MailResp.SetVariable('GG_REINVIO_MAIL',StrToFloatDef(ParC90_EMailRespGGReinvio,0));
      selI060MailResp.SetVariable('FILTRO_AGG',FFiltroAgg);
      try
        selI060MailResp.Open;
        FDestinatari:='';
        while not selI060MailResp.Eof do
        begin
          FDestinatari:=FDestinatari + selI060MailResp.FieldByName('EMAIL').AsString + ';';
          selI060MailResp.Next;
        end;
        AddTraccia(FUNZIONE,'mail destinatari dopo filtro: ' + FDestinatari);
        AddTraccia(FUNZIONE,'elaborazione indirizzi destinatari.fine');
        if FDestinatari = '' then
          Exit;
        FDestinatari:=Copy(FDestinatari,1,Length(FDestinatari) - 1);
      except
        on E:Exception do
          raise Exception.Create('Filtro destinatari per invio ottimizzato: ' + E.ClassName + '/' + E.Message);
      end;
    end;

    // 3. recupera i nomi dei responsabili per successiva notifica
    //    (al momento non implementata)
    if DestResponsabile and (FDestinatari <> '') then
    begin
      AddTraccia(FUNZIONE,'estrazione nomi destinatari.ini');

      // elabora indirizzi dei destinatari
      selI060NomiResp.Session:=Sessione;
      selI060NomiResp.Close;
      selI060NomiResp.SetVariable('AZIENDA',ParAzienda);
      selI060NomiResp.SetVariable('FILTRO_AGG',FFiltroAgg);
      try
        selI060NomiResp.Open;
        FNomiDestinatari:='';
        while not selI060NomiResp.Eof do
        begin
          FNomiDestinatari:=FNomiDestinatari + selI060NomiResp.FieldByName('NOMINATIVO').AsString + ',';
          selI060NomiResp.Next;
        end;
        FNomiDestinatari:=Copy(FNomiDestinatari,1,Length(FNomiDestinatari) - 1);
      except
        on E:Exception do
          raise Exception.Create('Estrazione nomi destinatari: ' + E.ClassName + '/' + E.Message);
      end;
      AddTraccia(FUNZIONE,'estrazione nomi destinatari.fine');
    end;
  finally
    AddTraccia(FUNZIONE,'fine');
  end;
end;

procedure TC017FEMailDtM.SendMail;
// esegue l'invio effettivo della mail con i parametri impostato
const
  FUNZIONE = 'SendMail';
var
  LogSendMail:string;
begin
  AddTraccia(FUNZIONE,'inizio');
  LogSendMail:=medpEMail.ConnettiSMTP;
  if not LogSendMail.IsEmpty then
    AddTraccia(FUNZIONE,'connessione server SMTP:' + LogSendMail)
  else
    AddTraccia(FUNZIONE,'connessione server SMTP: OK');

  LogSendMail:=medpEMail.Invia(Destinatari,DestinatariCC,DestinatariCCN,Oggetto,Testo + Disclaimer);
  if not LogSendMail.IsEmpty then
    AddTraccia(FUNZIONE,'invio E-Mail:' + LogSendMail)
  else
    AddTraccia(FUNZIONE,'invio E-Mail: OK');
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.AggiornaOraInvio;
// aggiorna l'ora di ultimo invio mail su profili responsabile (tabella I061)
const
  FUNZIONE = 'AggiornaOraInvio';
begin
  if Sessione = nil then
    exit;
  AddTraccia(FUNZIONE,'inizio');
  selI091.Session:=Sessione;
  R180SetVariable(selI091,'AZIENDA',ParAzienda);
  selI091.Open;
  if selI091.RecordCount = 0 then
    exit;
  with updI061UltimoInvio do
  begin
    // pragma autonomous transaction
    Session:=Sessione;
    SetVariable('AZIENDA',ParAzienda);
    SetVariable('GG_REINVIO_MAIL',StrToFloatDef(ParC90_EMailRespGGReinvio,0));
    SetVariable('FILTRO_AGG',FiltroAgg);
    try
      Execute;
      AddTraccia(FUNZIONE,'aggiornamento ora invio eseguito correttamente');
    except
      on E:Exception do
        raise Exception.Create('Aggiornamento ora ultimo invio email fallito: ' + E.ClassName + '/' + E.Message);
    end;
  end;
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.InviaEmail;
// invia mail utilizzando il server SMTP specificato nei parametri aziendali
// in base alle informazioni contenute nelle proprietà
//   Sessione:           sessione oracle da utilizzare per estrazione dati dei destinatari
//   DestResponsabile:   indica se il destinatario della mail è un responsabile / dipendente
//                       - True:  destinatario = responsabile
//                       - False: destinatario = dipendente
//   Destinatari         elenco degli indirizzi mail dei destinatari
//   Disclaimer          testo fisso da includere in calce al corpo della mail
//   Oggetto:            oggetto (subject) della mail
//   SollevaEccezioni:   indica se è necessario sollevare eccezione in caso di errori
//                       - True: in caso di errori effettua una raise con il dettaglio dell'eccezione
//                       - False: in caso di errori l'eccezione è sempre silenziosa
//   Progressivo:        progressivo del dipendente
//   TagFunzione:        se indicato verifica l'abilitazione del/i destinatario/i alla funzione indicata dal tag
//                       (l'abilitazione si intende verificata quando INIBIZIONE vale 'S' oppure 'R')
//   Testo:              corpo (body) della mail
const
  FUNZIONE = 'InviaEmail';
begin
  if Sessione = nil then
    exit;
  //Sessione.Commit;//Test di carico CSI 2014
  AddTraccia(FUNZIONE,'inizio');
  try
    // 1. estrae elenco destinatari, eventualmente filtrato se la mail è rivolta
    //    al responsabile ed è attivo il parametro di ottimizzazione
    if CercaDestinatari then
      GetDestinatari;

    if (Destinatari <> '') or (DestinatariCC <> '') or (DestinatariCCN <> '') then
    begin
      // 2. gestisce invio email
      SendMail;

      // 3. aggiorna data ultimo invio mail su profili responsabile (tabella I061)
      if DestResponsabile then
        AggiornaOraInvio;
    end;
  except
    on E: Exception do
      if SollevaEccezioni then
        raise Exception.Create('Errore di invio mail al ' + IfThen(DestResponsabile,'responsabile','dipendente') + #13#10 +
                               'Dettaglio: ' + E.Message);
  end;
  AddTraccia(FUNZIONE,'fine');
end;

procedure TC017FEMailDtM.InviaEMail(PSessione:TOracleSession; PDestResponsabile:Boolean; PProgressivo: Integer;
  POggetto,PTesto:String; PTag:Integer; const PIter:String = ''; const PCodIter:String = ''; const PLivelliDest:String = '');
begin
  // impostazione proprietà
  Sessione:=PSessione;
  DestResponsabile:=PDestResponsabile;
  Progressivo:=PProgressivo;
  Oggetto:=POggetto;
  Testo:=PTesto;
  TagFunzione:=PTag;
  Iter:=PIter;
  CodIter:=PCodIter;
  LivelliDest:=PLivelliDest;

  InviaEmail;
end;

procedure TC017FEMailDtM.PutCercaDestinatari(const Value: Boolean);
begin
  FCercaDestinatari:=Value;
  if not Value then
  begin
    Progressivo:=0;
    DestResponsabile:=False;
  end;
end;

{ TDatiMail }

class operator TDatiMail.Equal(ALeftOp, ARightOp: TDatiMail): Boolean;
begin
  Result:=(ALeftOp.TipoMail = ARightOp.TipoMail) and
          (ALeftOp.Oggetto = ARightOp.Oggetto) and
          (ALeftOp.Corpo = ARightOp.Corpo);
end;

class operator TDatiMail.NotEqual(ALeftOp, ARightOp: TDatiMail): Boolean;
begin
  Result:=(ALeftOp.TipoMail <> ARightOp.TipoMail) or
          (ALeftOp.Oggetto <> ARightOp.Oggetto) or
          (ALeftOp.Corpo <> ARightOp.Corpo);
end;

end.
