unit A000USessione;

interface

uses
  SysUtils, Classes, Forms, Controls, Oracle, OracleData, Windows,
  Registry, A000UCostanti, A000UMessaggi, C180FunzioniGenerali, Variants, DBClient,
  RegolePassword, System.SyncObjs, Data.DB;

type
  TCampiRiferimento = record
    C0_DecorrenzaNonBollanti,
    C1_CedoliniConValuta,
    C2_Budget,
    C2_Capitolo,
    C2_Articolo,
    C2_Costo_Orario,
    C2_WebSrv_Bilancio,
    C2_Livello,
    C2_Facoltativo,
    C3_IndPres,
    C3_IndPres2,
    C3_DatoPianificabile,
    C3_RiepTurni_IndPres,
    C3_DettGG_TipoI,
    C3_Indennita_Funzione,
    C4_BuoniMensa,
    C5_IntegrazAnag,
    C5_Office,
    C6_InizioProva,
    C6_DurataProva,
    C7_Dato1,
    C7_Dato2,
    C7_Dato3,
    C8_Missione,
    C8_MissioneCommessa,
    C8_Sede,
    C8_GestioneMensile,
    C8_ProtocolloObbligatorio,
    C8_W032RichiediTipoMissione,
    C8_W032DettaglioGG,
    C8_W032DocumentoMissioni,
    C8_W032RimborsiDett,
    C8_W032RiapriMissione,
    C8_W032TappeSoloSuDistanziometro,
    C8_W032MessaggioTappeInesistenti,
    C8_W032UpdRichiesta,
    C8_W032ProtocolloManuale,
    C9_ScaricoPaghe,
    C10_FormazioneProfiloCrediti,
    C10_FormazioneProfiloCorso,
    C11_PianifOrariProg,
    C11_PianifOrari_DebGG,
    C11_PianifOrari_No_CopiaGiustif,
    C12_PreferenzeDestinazione,
    C12_PreferenzeCompetenza,
    C13_CdcPercentualizzati,
    C14_ProvvSede,
    C15_LimitiMensCaus,
    C16_InsRiposi,
    C17_PostiLetto,
    C18_AccessiMensa,
    C19_StoriaInizioFine,
    C20_IncaricoUnitaOrg,
    C21_ValutazioniLiv1,
    C21_ValutazioniLiv2,
    C21_ValutazioniLiv3,
    C21_ValutazioniLiv4,
    C21_ValutazioniRsp1,
    C21_ValutazioniRsp2,
    C21_ValutazioniPnt1,
    (*C22_PianServLiv1,
    C22_PianServLiv2,*)
    C23_ContrCompetenze,
    C23_InsNegCatena,
    C23_VMHCumuloTriennio,
    C23_VMHFruizGG,
    C24_AziendaTipoBudget,
    C25_TimbIrr_Auto,
    C26_HintT030V430,
    C26_HintT030V430_NC,
    C26_V430Materializzata,
    C27_TablespaceFree,
    C28_CancellaAnnoLog,
    C29_ChiamateRepFiltro1,
    C29_ChiamateRepFiltro2,
    C29_ChiamateRepDatiVis,
    C29_ChiamateRepDatiModif,
    C30_WebSrv_A004_URL,
    C30_WebSrv_A004_Dati,
    C30_WebSrv_A025_URL_GET,
    C30_WebSrv_A025_URL_PUT,
    C30_WebSrv_B021_URL,
    C30_WebSrv_B021_TOKEN,
    C30_WebSrv_B021_PASSPHRASE,
    C30_WebSrv_B021_TIMEOUT,
    C31_NoteGiustificativi,
    C31_Giustif_GGMG,
    C32_GestMensile,
    C33_Link_I070_T030,
    C35_ResiduiTriggerBefore,
    C35_ResiduiTriggerAfter,
    C37_NumColAltriProg,
    C37_SoloAttRend,
    C37_TipoTempo,
    C37_SezGiustRitardi,
    C90_WebAutorizCurric,
    C90_EMailW010Uff,
    C90_EMailW018Uff,
    C90_EMailSMTPHost,
    C90_EMailUserName,
    C90_EMailPassWord,
    C90_EMailPort,
    C90_EMailRespOttimizzata,
    C90_EMailRespGGReinvio,
    C90_EMailRespOggetto,
    C90_EMailRespTesto,
    C90_EMailSenderIndirizzo,
    C90_EMailHeloName,
    C90_EMailAuthType,
    C90_EMailUseTLS,
    C90_WebRighePag,
    C90_WebTipoCambioOrario,
    C90_WebSettCambioOrario,
    C90_W003MsgAccesso,
    C90_W005Settimane,
    C90_W005Riepilogo,
    C90_W009PathPdf,
    C90_W009FilePdf,
    C90_W010CausPres,
    C90_W024MMIndietro,
    C90_W024AggScheda,
    C90_W026CausE,
    C90_W026CausU,
    C90_W026TipoRichiesta,
    C90_W026Spezzoni,
    C90_W026ConfermaAutorizzazioni,
    C90_W026TipoAutorizzazione,
    C90_W026TipoStraord,
    C90_W026UtilizzoDal,
    C90_W026UtilizzoAl,
    C90_W026EccedGGTutta,
    C90_W026CheckSaldoDisponibile,
    C90_W026MMIndietroDal,
    C90_W026MMIndietroAl,
    C90_W026Arrotondamento,
    C90_W026SpezzoneMinimo,
    C90_W026EccedOltreDebito,
    C90_NomeProfiloDelega,
    C90_EmailThread,
    C90_Lingua,
    C90_W010AcquisizioneAuto,
    C90_W018AcquisizioneAuto,
    C90_MessaggisticaReply,
    C90_FiltroDeleghe,
    C90_MessaggisticaObbligoLettura,
    C90_CronologiaNote,
    C90_PathAllegati,
    C90_IterMaxAllegati,
    C90_IterMaxDimAllegatoMB,
    C90_IterEstensioneAllegato,
    C90_CancellaAnnoAllegatiIter,
    C90_PreavvisoDelAllegati,
    C90_WC38Tolleranza_E,
    C90_WC38Tolleranza_U,
    C90_WC38Rilevatore,
    C90_WC38TimbCausalizzabile,
    C90_W038CheckIP: String;
    C99_DecorrenzaTAS000000233536:TDateTime;
    C99_DecorrenzaTAS000000240638:TDateTime;
  end;

  TAbilitazioniFunzioni = record
    Descrizione,Funzione:String;
    Tag:Integer;
    Inibizione:Char;
    AccessoBrowse: String;
    RighePagina: Integer;
  end;

  TFiltroDizionario = record
    Tabella,Codice:String;
    Abilitato,Cestino:Boolean;
  end;

  TAuthDomInfo = record
    DominioDip,
    DominioDipTipo,
    DominioUsr,
    DominioUsrTipo: String;
  end;

  TIPStatus = (isUndefined,isOk,isError);

  TIPInfo = record
    Status: TIPStatus;
    IP: String;
    IPLocale: String;
  end;

  TParametri = class(TComponent)
  private
    function GetModuloInstallato(Modulo:String):Boolean; inline;
  public
    HostName: String;
    HostIPAddress: String;
    ClientIPInfo: TIPInfo;
    Path:String;
    VersioneOracle:Integer;
    TimeSeparatorDef:String;
    Applicazione:String;
    Azienda:String;
    DAzienda:String;
    RagioneSociale:String;
    Alias:String;
    Username:String;
    Password:String;
    PasswordMondoEDP:String;
    Operatore:String;
    ProfiloWEB:String;
    ProfiloWEBDelegatoDa:String; // MONZA_HSGERARDO - chiamata 88132
    ProfiloWEBIterAutorizzativi:String;
    ProfiloFiltroFunzioni:String;
    TipoOperatore:String;
    PassOper:String;
    ProgressivoOper:Integer;
    MatricolaOper:String;
    AuthDom:Boolean;
    AuthDomInfo:TAuthDomInfo;
    LogTabelle:String;
    Database:String;
    NomePJ:String;
    VersionePJ:String;
    BuildPJ:String;
    DataPJ:String;
    VersioneDB:String;
    BuildDB:String;
    DBUnicode:Boolean;
    TimbOrig_Verso:String;
    TimbOrig_Causale:String;
    ValiditaPassword:Word;
    LunghezzaPassword:Word;
    RegolePassword:TRegolePassword;
    GruppoBadge:String;
    ValiditaUtente:Word;
    ValiditaCessati:Word;
    ProgOper:Word;
    OperBloc:Boolean;
    V430:String;
    Lingua:String;
    cdsI015:TClientDataSet;
    IntegrazioneAnagrafe:String;
    CodiceIntegrazione:String;
    CodContrattoVoci:String;
    T040_Validazione:String;
    T100_Ora:String;
    T100_Rilevatore:String;
    T100_Causale:String;
    T100_CancTimbOrig:String;
    CancellaTimbrature:String;
    InserisciTimbrature:String;
    AbilitaSchedeChiuse:String;
    A029_Saldi:String;
    A029_Indennita:String;
    A029_Straordinario:String;
    A029_CauPresenza:String;
    A037_EliminaDataCassa:String;
    A037_RicreaScaricoPaghe:String;
    A058_PianifOperativa:String;
    A058_PianifNonOperativa:String;
    A094_Mese:String;
    A094_Anno:String;
    A094_Raggr:String;
    LiquidazioneForzata:String;
    Layout:String;
    Storicizzazione:String;
    EliminaStorici:String;
    InserimentoMatricole:String;
    DefTipoPersonale:String;
    ModPersonaleEsterno:String;
    RipristinoTimbOri:String;
    AggiornamentoBaseDati:String;
    MonitorIntegrAnagra:String;
    C700_SalvaSelezioni:String;
    DatiC700:String;
    ModuliInstallati:String;
    DataLavoro:TDateTime;
    TSLavoro:String;
    TSIndici:String;
    TSAusiliario:String;
    FileAnomalie:String;
    CampiAnagraficiNonVisibili:String;
    A131_AnticipiGestibili:String;
    I035_ModificaAbbinamenti:String;
    InibizioneIndividuale:Boolean;
    Inibizioni:TStringList;
    CampiRiferimento:TCampiRiferimento;
    NomiTabelleLog:TStringList;
    ColonneStruttura:TStringList;
    TipiStruttura:TStringList;
    AbilitazioniFunzioni:array of TAbilitazioniFunzioni;
    FiltroDizionario:array of TFiltroDizionario;
    A139_ServiziComandati:String;
    A139_ServiziBlocco:String;
    A139_ServiziSblocco:String;
    S710_SupervisoreValut:String;
    S710_ModValutatore:String;
    S710_ValidaStato:String;
    WEBIterAssGGPrec:Integer;
    WEBIterAssGGSucc:Integer;
    WEBIterTimbGGPrec:Integer;
    WEBCartelliniDataMin:TDateTime;
    WEBCartelliniMMPrec:Integer;
    WEBCartelliniMMSucc:Integer;
    WEBCartelliniChiusi:String;
    WEBCedoliniDataMin:TDateTime;
    WEBCedoliniMMPrec:Integer;
    WEBCedoliniGGEmiss:Integer;
    WEBCedoliniFilePDF:String;
    ModificaDatiProtetti:Boolean;
    WEBRichiestaConsegnaCed:String;
    WEBRichiestaConsegnaVal:String;
    WEBNotificaAnomalie:string;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ModuloInstallato[Modulo:String]:Boolean read GetModuloInstallato;
  end;

  TSessioneIrisWIN = class(TComponent)
  public
    SessioneOracle:TOracleSession;
    (*
    QueryPK1:TQueryPK;
    RegistraLog:TRegistraLog;
    RegistraMsg:TRegistraMsg;
    *)
    QueryPK1:TOracleDataSet; //TQueryPK;
    RegistraLog:TOracleQuery;//TRegistraLog;
    RegistraMsg:TOracleQuery;//TRegistraMsg;
    Parametri:TParametri;
    QVistaOracle:String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AlterSessionSessioneOracle;
    procedure ApplicationOnException(Sender:TObject; E:Exception);
  end;

var
  DataBaseDrv:TDataBaseDrv;
  {$IFNDEF IRISWEB}
    A000SessioneIrisWIN:TSessioneIrisWIN;//IrisWIN
    SolaLettura,SolaScrittura,SolaLetturaOriginale:Boolean;
  {$ELSEIF Defined(WEBSVC)}
    A000SessioneIrisWIN:TSessioneIrisWIN;//WebServices
  {$ENDIF}
  IntestazioneStampa:String;
  //QVistaOracle:String = QVistaOracle_Const;
  //QVistaOraclePeriodica:String = QVistaOracle_Const;

procedure A000SettaVariabiliAmbiente;
procedure A000LogonDBOracle(Sessione:TOracleSession);
procedure A000ParamDBOracle(DB:TOracleSession);
procedure A000SetParametri(DB:TOracleSession);
procedure A000ParamDBOracleMultiThread(SessioneIW:TSessioneIrisWIN);
procedure A000GetMsgTradotti;
function A000GetInibizioni(TipoDato,Dato:String):Char;
function A000GetAbilitazioniFunzioni(const PTipoDato, PDato:String): TAbilitazioniFunzioni;
function A000OperatoreAbilitato(Prog:LongInt; DataDa,DataA:TDateTime):Boolean;
function A000ModuloAbilitato(Sessione:TOracleSession; Modulo,Azienda:String):Boolean;
function GetPassword:Boolean;
function A000GetSuffissoQVista(Campo:String):String;
procedure A000GetTabella(Dato:String; var Tabella,Codice,Storico:String; Sessione:TOracleSession = nil);
procedure A000GetTabellaP430(Dato:String; var Tabella,Codice,Storico:String);
function A000LookupTabella(Dato:String; Query:TOracleDataSet):Boolean;
procedure A000GetLayout(SessioneIW:TSessioneIrisWIN; SessioneDB:TOracleSession);
procedure A000GetChiavePrimaria(Sessione:TOracleSession; Tabella:String; L:TStringList);
function A000FiltroDizionario(T,C:String):Boolean;
procedure A000AggiornaFiltroDizionario(T,CodOld,C:String);
function A000GetHomePath: String;
function A000GetPassword:String;
function A000DescDatiEnte(Dato:String):String;

implementation

//uses A000UInterfaccia, C003UPassword;
uses A000UInterfaccia, C003UPassword, QueryPK, RegistrazioneLog, Cestino;

function GetPassword:Boolean;
var S:String;
    i,j:Integer;
begin
  Result:=True;
  C003FPassword:=TC003FPassword.Create(nil);
  with C003FPassword do
    try
      try
        Password.Text:='***********************';
        if ShowModal <> mrOK then
          begin
          Result:=False;
          Abort;
          end;
        S:=Password.Text;
        if Length(S) <> Length(Parametri.PassOper) then
          begin
          Result:=False;
          Abort;
          end;
        j:=Length(S);
        for i:=1 to Length(Parametri.PassOper) do
          if S[j] <> Parametri.PassOper[i] then
            begin
            Result:=False;
            Break;
            end
          else
            dec(j);
      finally
        Release;
      end;
    except
    end;
end;

procedure A000SettaVariabiliAmbiente;
var FS:TFormatSettings;
    i:Integer;
begin
  if CSFormatSettings <> nil then
    CSFormatSettings.Enter;
  try
    {$IFNDEF VER210}FormatSettings.{$ENDIF}DateSeparator:='/';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat:='dd/mm/yyyy';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator:='.';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator:=',';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:='.';
    {$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:='hh.nn.ss';
    if Parametri <> nil then
    begin
      {$IFDEF IRISWEB}{$IFNDEF WEBSVC}
        if Pos(INI_PAR_TRADUZIONE_CAPTION,W000ParConfig.ParametriAvanzati) > 0 then
          Parametri.Lingua:='E';
      {$ENDIF}{$ENDIF}
      if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then //TORINO_ITC
        Parametri.Lingua:='E';
      if Parametri.Lingua = 'I' then
      begin
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[1]:='gen';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[2]:='feb';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[3]:='mar';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[4]:='apr';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[5]:='mag';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[6]:='giu';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[7]:='lug';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[8]:='ago';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[9]:='set';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[10]:='ott';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[11]:='nov';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortMonthNames[12]:='dic';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[1]:='gennaio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[2]:='febbraio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[3]:='marzo';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[4]:='aprile';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[5]:='maggio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[6]:='giugno';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[7]:='luglio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[8]:='agosto';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[9]:='settembre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[10]:='ottobre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[11]:='novembre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[12]:='dicembre';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[1]:='dom';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[2]:='lun';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[3]:='mar';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[4]:='mer';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[5]:='gio';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[6]:='ven';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDayNames[7]:='sab';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[1]:='domenica';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[2]:='lunedì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[3]:='martedì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[4]:='mercoledì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[5]:='giovedì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[6]:='venerdì';
        {$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[7]:='sabato';
      end
      else if Parametri.Lingua = 'E' then
      begin
        FS:=TFormatSettings.Create('en-GB');
        for i:=Low(FS.ShortMonthNames) to High(FS.ShortMonthNames) do
        begin
          FormatSettings.ShortMonthNames[i]:=FS.ShortMonthNames[i];
          FormatSettings.LongMonthNames[i]:=FS.LongMonthNames[i];
        end;
        for i:=Low(FS.ShortDayNames) to High(FS.ShortDayNames) do
        begin
          FormatSettings.ShortDayNames[i]:=FS.ShortDayNames[i];
          FormatSettings.LongDayNames[i]:=FS.LongDayNames[i];
        end;
      end;
    end;
    {$IFNDEF IRISWEB}
    Application.UpdateFormatSettings:=False;
    {$ENDIF}
  finally
    if CSFormatSettings <> nil then
      CSFormatSettings.Leave;
  end;
end;

procedure A000LogonDBOracle(Sessione:TOracleSession);
begin
  R180SetOracleInstantClient;
  Sessione.LogonUserName:='MONDOEDP';
  Sessione.LogonPassword:=A000GetPassword;
  try
    Sessione.Logon;
  except
    (*on E:Exception do
      raise Exception.Create('DB: ' + Sessione.LogonDatabase + #13 +
                             'User: ' + Sessione.LogonUsername + #13 +
                             'PWD: ' + Sessione.LogonPassword + #13 +
                             E.Message);*)
    Sessione.LogonPassword:=A000PasswordFissa;
    try
      Sessione.Logon;
    except
    end;
  end;

  A000SettaVariabiliAmbiente;
end;

procedure A000ParamDBOracle(DB:TOracleSession);
var SetPar:TOracleQuery;
    FormatSetting:TFormatSettings;
    //S:String;
begin
  {$IFNDEF IRISWEB}
  R180SetOracleInstantClient;
  DataBaseDrv:=dbOracle;
  {$ENDIF}
  //Leggo i parametri di connessione al DataBase
  //--A000SetParametri--//Parametri.Path:=ExtractFilePath(Application.ExeName) + 'Archivi';
  ForceDirectories(Parametri.Path + '\Temp');
  //--A000SetParametri--//Parametri.DataLavoro:=Date;
  with DB do
  begin
    LogOff;
    LogonUserName:=Parametri.UserName;
    LogonPassword:=R180Decripta(Parametri.Password,21041974);
    LogonDataBase:=Parametri.Database;
    if Parametri.VersioneOracle >= 11 then
      Preferences.UseOci7:=False;
    try
      LogOn;
    except
      {$IFNDEF IRISWEB}
      if Pos('B006',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','Database','IRIS')
      else if Pos('B010',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Database','IRIS')
      else if Pos('B014',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','IRIS')
      else
        LogonDataBase:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
      {$ENDIF}
      LogOn;
    end;
  end;
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=DB;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
  finally
    SetPar.Free;
  end;
  if Parametri.Applicazione = 'PAGHE' then
    IntestazioneStampa:='Gestione Economica'
  else if Parametri.Applicazione = 'RILPRE' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if Parametri.Applicazione = 'RPWEB' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if Parametri.Applicazione = 'STAGIU' then
    IntestazioneStampa:='Gestione Giuridica'
  else if Parametri.Applicazione = 'MISTRA' then
    IntestazioneStampa:='Missioni/Trasferte'
  else if Parametri.Applicazione = 'PINFO' then
    IntestazioneStampa:='Punto Informativo';

  A000SetParametri(DB);

  {$IFNDEF IRISWEB}//Applicativi client-server
  A000SettaVariabiliAmbiente;
  A000GetMsgTradotti;
  {$ENDIF}

  {$IFDEF WEBSVC}//Web services ma non IrisWEB/IrisCloud
  A000SettaVariabiliAmbiente;
  {$ENDIF}
end;

procedure A000SetParametri(DB:TOracleSession);
var SetPar:TOracleQuery;
    FormatSetting:TFormatSettings;
    //S:String;
begin
  Parametri.Path:=ExtractFilePath(Application.ExeName) + 'Archivi';
  Parametri.DataLavoro:=Date;
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=DB;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('SELECT COUNT(*) FROM P001_TABP430 WHERE TABELLA = ''T030_ANAGRAFICO''');
    try
      A000SessioneIrisWIN.QVistaOracle:=QVistaOracle_Const;
      SetPar.Execute;
      if SetPar.FieldAsInteger(0) > 0 then
      begin
        Parametri.V430:='P430';
        A000SessioneIrisWIN.QVistaOracle:=QVistaOracle_Const + #13#10 + 'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)';
      end;
    except
    end;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('select count(*) from v$nls_parameters where parameter = ''NLS_CHARACTERSET'' and value like ''%UTF%''');
    try
      SetPar.Execute;
      if SetPar.FieldAsInteger(0) > 0 then
        Parametri.DBUnicode:=True;
    except
    end;
    with TCestino.create(DB) do
      try
        CaricaCestino;
      finally
        Free;
      end;
  finally
    SetPar.Free;
  end;
  try
    FormatSetting:=TFormatSettings.Create(0);  //non serve fare il free
    Parametri.TimeSeparatorDef:=FormatSetting.TimeSeparator;
  except
    Parametri.TimeSeparatorDef:=':';
  end;
end;

procedure A000ParamDBOracleMultiThread(SessioneIW:TSessioneIrisWIN);
var SetPar:TOracleQuery;
    FormatSetting:TFormatSettings;
begin
  R180SetOracleInstantClient;
  DataBaseDrv:=dbOracle;
  //Leggo i parametri di connessione al DataBase
  SessioneIW.Parametri.Path:=ExtractFilePath(Application.ExeName) + 'Archivi';
  ForceDirectories(SessioneIW.Parametri.Path + '\Temp');
  SessioneIW.Parametri.DataLavoro:=Date;
  with SessioneIW.SessioneOracle do
  begin
    LogOff;
    LogonUserName:=SessioneIW.Parametri.UserName;
    LogonPassword:=R180Decripta(SessioneIW.Parametri.Password,21041974);
    LogonDataBase:=SessioneIW.Parametri.Database;
    if SessioneIW.Parametri.VersioneOracle >= 11 then
      Preferences.UseOci7:=False;
    try
      LogOn;
    except
      if Pos('B006',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B006','Database','IRIS')
      else if Pos('B010',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Database','IRIS')
      else if Pos('B014',ExtractFileName(Application.ExeName)) = 1 then
        LogonDataBase:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','IRIS')
      else
        LogonDataBase:=R180GetRegistro(HKEY_CURRENT_USER,'A001','Database','IRIS');
      LogOn;
    end;
  end;
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=SessioneIW.SessioneOracle;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
    //SetPar.SQL.Clear;
    //SetPar.SQL.Add('ALTER SESSION SET CURSOR_SHARING = FORCE');
    //SetPar.Execute;
    {P430}SetPar.SQL.Clear;
    SetPar.SQL.Add('SELECT COUNT(*) FROM P001_TABP430 WHERE TABELLA = ''T030_ANAGRAFICO''');
    try
      SessioneIW.QVistaOracle:=QVistaOracle_Const;
      SetPar.Execute;
      if SetPar.FieldAsInteger(0) > 0 then
      begin
        SessioneIW.Parametri.V430:='P430';
        SessioneIW.QVistaOracle:=QVistaOracle_Const + #13#10 + 'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)';
      end;
    except
    {P430}end;
  finally
    SetPar.Free;
  end;
  if SessioneIW.Parametri.Applicazione = 'PAGHE' then
    IntestazioneStampa:='Gestione Economica'
  else if SessioneIW.Parametri.Applicazione = 'RILPRE' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if SessioneIW.Parametri.Applicazione = 'RPWEB' then
    IntestazioneStampa:='Rilevazione Presenze'
  else if SessioneIW.Parametri.Applicazione = 'STAGIU' then
    IntestazioneStampa:='Gestione Giuridica'
  else if SessioneIW.Parametri.Applicazione = 'MISTRA' then
    IntestazioneStampa:='Missioni/Trasferte'
  else if SessioneIW.Parametri.Applicazione = 'PINFO' then
    IntestazioneStampa:='Punto Informativo';
  try
    FormatSetting:=TFormatSettings.Create(0);  //non serve fare il free
    //GetLocaleFormatSettings(0,FormatSetting);
    Parametri.TimeSeparatorDef:=FormatSetting.TimeSeparator;
  except
    Parametri.TimeSeparatorDef:=':';
  end;
  A000SettaVariabiliAmbiente;
end;

procedure A000GetMsgTradotti;
var selI015:TOracleDataSet;
    cdsI015:TClientDataSet;
    i:Integer;
begin
  // utilizzo di clientdataset cdsI015 per localizzazione
  if (Parametri.CampiRiferimento.C90_Lingua = '') (*or
     (UpperCase(Parametri.CampiRiferimento.C90_Lingua) = 'ITALIANO')*) then
    exit;
  if Parametri.cdsI015 = nil then
  try
    cdsI015:=TClientDataSet.Create(nil);
    selI015:=TOracleDataSet.Create(nil);
    selI015.Session:=SessioneOracle;
    selI015.SQL.Text:='select I015.*' + #13#10 +
                      'from   MONDOEDP.I015_TRADUZIONI_CAPTION I015' + #13#10 +
                      'where  I015.AZIENDA = :AZIENDA' + #13#10 +
                      'and    I015.LINGUA = :LINGUA' + #13#10 +
                      'and    I015.APPLICAZIONE = :APPLICAZIONE' + #13#10 +
                      'order by I015.MASCHERA, I015.COMPONENTE';
    selI015.DeclareAndSet('AZIENDA',otString,Parametri.Azienda);
    selI015.DeclareAndSet('LINGUA',otString,UpperCase(Parametri.CampiRiferimento.C90_Lingua));
    selI015.DeclareAndSet('APPLICAZIONE',otString,'W000');
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
        Parametri.cdsI015:=cdsI015
      else
        FreeAndNil(cdsI015);
    except
    end;
  finally
    selI015.Free;
  end;
end;

function A000GetHomePath: String;
begin
  Result:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','C:\IrisWIN').Trim;
end;

function A000GetPassword:String;
//Restituisce la password criptata su file
var L:TStringList;
    HomePath:String;
begin
  Result:=A000PasswordFissa;
  L:=TStringList.Create;
  try
    try
      HomePath:=Trim(R180GetRegistro(HKEY_LOCAL_MACHINE,'','HOME','c:\IrisWIN'));
      if FileExists(HomePath + '\IrisWIN.INI') then
        L.LoadFromFile(HomePath + '\IrisWIN.INI')
      else if FileExists('IrisWIN.INI') then
        L.LoadFromFile('IrisWIN.INI');
      if L.Count > 0 then
        Result:=R180Decripta(L[0],20111972);
    except
      Result:=A000PasswordFissa;
    end;
  finally
    L.Free;
  end;
end;

function A000DescDatiEnte(Dato:String):String;
var i:Integer;
begin
  Result:='';
  for i:=1 to High(DatiEnte) do
    if DatiEnte[i].Nome = Dato then
    begin
      Result:=DatiEnte[i].Desc;
      Break;
    end;
end;

function A000GetInibizioni(TipoDato,Dato:String):Char;
{Restituisce il tipo di abilitazione sulla funzione specificata:
R = ReadOnly; S = Scrittura; N = Negato
TipoDato può essere: 'Funzione','Tag'}
var i:Integer;
begin
  Result:='N';
  if (UpperCase(TipoDato) = 'TAG') and (StrToIntDef(Dato,-1) < 0) then
  begin
    Result:='S';
    exit;
  end;
  for i:=0 to High(Parametri.AbilitazioniFunzioni) do
  begin
    if UpperCase(TipoDato) = 'FUNZIONE' then
    begin
      if UpperCase(Parametri.AbilitazioniFunzioni[i].Funzione) = UpperCase(Dato) then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i].Inibizione;
        Break;
      end;
    end
    else if UpperCase(TipoDato) = 'TAG' then
      if Parametri.AbilitazioniFunzioni[i].Tag = StrToIntDef(Dato,-1) then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i].Inibizione;
        Break;
      end;
  end;
  {$IFNDEF IRISWEB}
  if Result = 'N' then
    SolaLettura:=SolaLetturaOriginale;
  {$ENDIF}
end;

function A000GetAbilitazioniFunzioni(const PTipoDato, PDato:String): TAbilitazioniFunzioni;
var
  i, LDatoInt: Integer;
  LDatoStr: String;
  LCercaFunzione: Boolean;
begin
  // imposta variabili per la ricerca
  LDatoStr:=PDato.ToUpper;
  LDatoInt:=-1;
  LCercaFunzione:=(PTipoDato.ToUpper = 'FUNZIONE');
  if LCercaFunzione then
    LDatoStr:=PDato.ToUpper
  else
    LDatoInt:=StrToIntDef(PDato,-1);

  // imposta record fittizio se dato non trovato
  Result.Descrizione:='';
  Result.Funzione:='';
  Result.Tag:=0;
  Result.Inibizione:=#0;
  Result.AccessoBrowse:='';
  Result.RighePagina:=0;

  // effettua la ricerca del record corrispondente
  for i:=0 to High(Parametri.AbilitazioniFunzioni) do
  begin
    if LCercaFunzione then
    begin
      if Parametri.AbilitazioniFunzioni[i].Funzione.ToUpper = LDatoStr then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i];
        Break;
      end;
    end
    else
    begin
      if Parametri.AbilitazioniFunzioni[i].Tag = LDatoInt then
      begin
        Result:=Parametri.AbilitazioniFunzioni[i];
        Break;
      end;
    end;
  end;
end;

function A000OperatoreAbilitato(Prog:LongInt; DataDa,DataA:TDateTime) : Boolean;
begin
  Result:=True;
  if Parametri.OperBloc then
    with TOracleQuery.Create(nil) do
    try
      Session:=SessioneOracle;
      SQL.Add('SELECT COUNT(*) FROM T070_SCHEDARIEPIL WHERE');
      SQL.Add('PROGRESSIVO = ' + IntToStr(Prog) + ' AND');
      SQL.Add('DATA BETWEEN ''' + FormatDateTime('dd/mm/yyyy',R180InizioMese(DataDa)) + '''');
      SQL.Add('AND ''' + FormatDateTime('dd/mm/yyyy',R180InizioMese(DataA)) + '''');
      Execute;
      if Field(0) > 0 then
        Result:=Parametri.AbilitaSchedeChiuse = 'S';
      Close;
    finally
      Free;
    end;
end;

function A000ModuloAbilitato(Sessione:TOracleSession; Modulo,Azienda:String):Boolean;
var SQLtext:String;
begin
  Result:=True;
  try
    with TOracleDataSet.Create(nil) do
    try
      Session:=Sessione;
      SQLtext:='SELECT * FROM MONDOEDP.I080_MODULI WHERE MODULO = ''' + R180Cripta(Modulo,14091943) + '''';
      SQLtext:=SQLtext + ' AND AZIENDA = ''' + UpperCase(Azienda) + '''';
      SQL.Add(SQLtext);
      Open;
      if RecordCount = 0 then
        Result:=False;
    finally
      Free;
    end;
  except
  end;
end;

function A000GetSuffissoQVista(Campo:String):String;
begin
  if (Pos('T430',Campo) <> 1) and ((Pos('P430',Campo) <> 1)) then
  begin
    if (UpperCase(Campo) = 'CITTA') or (UpperCase(Campo) = 'PROVINCIA') then
      Campo:='T480.'
    else
      Campo:='T030.';
  end;
end;

procedure A000GetTabella(Dato:String; var Tabella,Codice,Storico:String; Sessione:TOracleSession = nil);
const StruttT430:Array[1..43] of TStruttT430 =
      ((Campo:'PROGRESSIVO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'DATADECORRENZA';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'DATAFINE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'BADGE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'EDBADGE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'INDIRIZZO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'COMUNE';Tabella:'T480_COMUNI';Codice:'CODICE';Storico:'N'),
       (Campo:'CAP';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TELEFONO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'INIZIO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'FINE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TIPOOPE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TERMINALI';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'CAUSSTRAORD';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDU';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDEU';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'STRAORDEU2';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'CONTRATTO';Tabella:'T200_CONTRATTI';Codice:'CODICE';Storico:'N'),
       (Campo:'ORARIO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'HTEORICHE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'PERSELASTICO';Tabella:'T025_CONTMENSILI';Codice:'CODICE';Storico:'N'),
       (Campo:'TGESTIONE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'PLUSORA';Tabella:'T060_PLUSORARIO';Codice:'CODICE';Storico:'N'),
       (Campo:'CALENDARIO';Tabella:'T010_CALENDIMPOSTAZ';Codice:'CODICE';Storico:'N'),
       (Campo:'IPRESENZA';Tabella:'T163_CODICIINDENNITA';Codice:'CODICE';Storico:'N'),
       (Campo:'PORARIO';Tabella:'T220_PROFILIORARI';Codice:'CODICE';Storico:'S'),
       (Campo:'PASSENZE';Tabella:'T261_DESCPROFASS';Codice:'CODICE';Storico:'N'),
       (Campo:'ABCAUSALE1';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'ABPRESENZA1';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'SQUADRA';Tabella:'T600_SQUADRE';Codice:'CODICE';Storico:'N'),
       (Campo:'TIPORAPPORTO';Tabella:'T450_TIPORAPPORTO';Codice:'CODICE';Storico:'N'),
       (Campo:'PARTTIME';Tabella:'T460_PARTTIME';Codice:'CODICE';Storico:'N'),
       (Campo:'DOCENTE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'TIPO_LOCALITA_DIST_LAVORO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'COD_LOCALITA_DIST_LAVORO';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'QUALIFICAMINIST';Tabella:'T470_QUALIFICAMINIST';Codice:'CODICE';Storico:'S'),
       (Campo:'MEDICINA_LEGALE';Tabella:'T485_MEDICINELEGALI';Codice:'CODICE';Storico:'N'),
       (Campo:'INIZIO_IND_MAT';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'FINE_IND_MAT';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'INDIRIZZO_DOM_BASE';Tabella:'T430_STORICO';Codice:'';Storico:'N'),
       (Campo:'COMUNE_DOM_BASE';Tabella:'T480_COMUNI';Codice:'CODICE';Storico:'N'),
       (Campo:'CAP_DOM_BASE';Tabella:'T430_STORICO';Codice:'';Storico:'N')
       );
var I500:TOracleQuery;
    i:Integer;
begin
  Storico:='N';
  Tabella:='';
  Codice:='';
  if Dato = '' then exit;
  for i:=1 to High(StruttT430) do
  begin
    if UpperCase(Dato) = StruttT430[i].Campo then
    begin
      Tabella:=StruttT430[i].Tabella;
      Codice:=StruttT430[i].Codice;
      Storico:=StruttT430[i].Storico;
      Break;
    end;
  end;
  if Tabella = '' then
  begin
    I500:=TOracleQuery.Create(nil);
    try
      if Sessione = nil then
        I500.Session:=SessioneOracle
      else
        I500.Session:=Sessione;
      I500.SQL.Add('SELECT TABELLA,STORICO FROM I500_DATILIBERI WHERE UPPER(NOMECAMPO) = ''' + UpperCase(Dato) + '''');
      I500.Execute;
      if I500.RowsProcessed > 0 then
      begin
        if I500.Field('TABELLA') = 'S' then
        begin
          Tabella:='I501' + Dato;
          Codice:='CODICE';
          Storico:=I500.Field('STORICO');
        end
        else
          Tabella:='T430_STORICO';
      end;
      I500.Close;
    except
    end;
    I500.Free;
  end;
  if Tabella = 'T430_STORICO' then
    Codice:=Dato;
end;

procedure A000GetTabellaP430(Dato:String; var Tabella,Codice,Storico:String);
const StruttP430:Array[1..41] of TStruttT430 =
      ((Campo:'PROGRESSIVO';Tabella:'P430_ANAGRAFICO';Codice:'';Storico:'N'),
       (Campo:'DECORRENZA';Tabella:'P430_ANAGRAFICO';Codice:'';Storico:'N'),
       (Campo:'DECORRENZA_FINE';Tabella:'P430_ANAGRAFICO';Codice:'';Storico:'N'),
       (Campo:'COD_CONTRATTO';Tabella:'P210_CONTRATTI';Codice:'COD_CONTRATTO';Storico:'N'),
       (Campo:'COD_PARAMETRISTIPENDI';Tabella:'P212_PARAMETRISTIPENDI';Codice:'COD_PARAMETRISTIPENDI';Storico:'S'),
       (Campo:'COD_TIPOASSOGGETTAMENTO';Tabella:'P240_TIPIASSOGGETTAMENTI';Codice:'COD_TIPOASSOGGETTAMENTO';Storico:'S'),
       (Campo:'COD_POSIZIONE_ECONOMICA';Tabella:'P220_LIVELLI';Codice:'COD_POSIZIONE_ECONOMICA';Storico:'S'),
       (Campo:'COD_PARTTIME';Tabella:'P040_PARTTIME';Codice:'COD_PARTTIME';Storico:'N'),
       (Campo:'PROGRESSIVO_EREDE_DI';Tabella:'T030_ANAGRAFICO';Codice:'PROGRESSIVO';Storico:'N'),
       (Campo:'COD_BANCA';Tabella:'P010_BANCHE';Codice:'COD_BANCA';Storico:'N'),
       (Campo:'COD_STATOCIVILE';Tabella:'P020_STATOCIVILE';Codice:'COD_STATOCIVILE';Storico:'N'),
       (Campo:'COD_NAZIONALITA';Tabella:'P120_NAZIONALITA';Codice:'COD_NAZIONALITA';Storico:'N'),
       (Campo:'COD_PAGAMENTO';Tabella:'P130_PAGAMENTI';Codice:'COD_PAGAMENTO';Storico:'N'),
       (Campo:'COD_VALUTA_STAMPA';Tabella:'P030_VALUTE';Codice:'COD_VALUTA';Storico:'S'),
       (Campo:'COD_CAUSALEIRPEF';Tabella:'P080_CAUSALIIRPEF';Codice:'COD_CAUSALEIRPEF';Storico:'N'),
       (Campo:'COD_REGIONE_IRPEF';Tabella:'T482_REGIONI';Codice:'COD_REGIONE';Storico:'N'),
       (Campo:'COD_COMUNE_IRPEF';Tabella:'T480_COMUNI';Codice:'CODCATASTALE';Storico:'N'),
       (Campo:'COD_DEDUZIONEIRPEF';Tabella:'P082_DEDUZIONIIRPEF';Codice:'COD_DEDUZIONEIRPEF';Storico:'N'),
       (Campo:'COD_TABELLAANF';Tabella:'P236_TABELLEANF';Codice:'COD_TABELLAANF';Storico:'S'),
       (Campo:'COD_CODICEINPS';Tabella:'P090_CODICIINPS';Codice:'COD_CODICEINPS';Storico:'S'),
       (Campo:'COD_INQUADRINPS';Tabella:'P096_INQUADRINPS';Codice:'COD_INQUADRINPS';Storico:'S'),
       (Campo:'COD_EMENSTIPOASS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_EMENSTIPOCESS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_TIPORAPP_COCOCO';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_TIPOATT_COCOCO';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ALTRAASS_COCOCO';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_CUDINPDAPCAUSACESS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_INQUADRINPDAP';Tabella:'P094_INQUADRINPDAP';Codice:'COD_INQUADRINPDAP';Storico:'S'),
       (Campo:'COD_CODICEINAIL';Tabella:'P092_CODICIINAIL';Codice:'COD_CODICEINAIL';Storico:'S'),
       (Campo:'COD_QUALIFICA_INAIL';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_COMUNE_INAIL';Tabella:'T480_COMUNI';Codice:'CODCATASTALE';Storico:'N'),
       (Campo:'COD_CATEGPARTICOLARE';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_CAUSALELA';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ONAOSITIPOPAG';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ONAOSITIPOASS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_ONAOSITIPOCESS';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_FPC';Tabella:'P026_FONDIPREVCOMPL';Codice:'COD_FPC';Storico:'S'),
       (Campo:'COD_INPDAPMOTIVOSOSP_FPC';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_INPDAPTIPOCESS_FPC';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_CATEG_CONVENZ';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N'),
       (Campo:'COD_INPDAPTIPOLS_ALTRA_AMM';Tabella:'P004_CODICITABANNUALI';Codice:'COD_CODICITABANNUALI';Storico:'N')
       );
var i:Integer;
begin
  Storico:='N';
  Tabella:='';
  Codice:='';
  if Dato = '' then exit;
  for i:=1 to High(StruttP430) do
    if UpperCase(Dato) = StruttP430[i].Campo then
    begin
      Tabella:=StruttP430[i].Tabella;
      Codice:=StruttP430[i].Codice;
      Storico:=StruttP430[i].Storico;
      Break;
    end;
end;

function A000LookupTabella(Dato:String; Query:TOracleDataSet):Boolean;
var Tabella,Codice,Storico:String;
    lst:TStringList;
begin
  Result:=False;
  A000GetTabella(Dato,Tabella,Codice,Storico);
  if Tabella <> '' then
  begin
    Result:=True;
    if Query = nil then
      exit;
    lst:=TStringList.Create;
    try
      if (Dato.ToUpper = 'COD_LOCALITA_DIST_LAVORO') and (Tabella.ToUpper = 'T430_STORICO') then
      //Caso particolare di COD_LOCALITA_DIST_LAVORO
      begin
        lst.Text:=
          'select distinct' + CRLF +
          '  T430.COD_LOCALITA_DIST_LAVORO CODICE,' + CRLF +
          '  decode(T430.TIPO_LOCALITA_DIST_LAVORO,''C'',T480.CITTA,''P'',M042.DESCRIZIONE) DESCRIZIONE' + CRLF +
          'from T430_STORICO T430, T480_COMUNI T480, M042_LOCALITA M042' + CRLF +
          'where T430.COD_LOCALITA_DIST_LAVORO = T480.CODICE(+)' + CRLF +
          'and   T430.COD_LOCALITA_DIST_LAVORO = M042.CODICE(+)' + CRLF +
          'and   decode(T430.TIPO_LOCALITA_DIST_LAVORO,''C'',T480.CITTA,''P'',M042.DESCRIZIONE) is not null' + CRLF +
          'order by 1';
      end
      else
      //Gestione standard
      begin
        lst.Add(Format('SELECT DISTINCT %s CODICE,',[Codice]));
        if Tabella = 'T430_STORICO' then
          lst.Add('NULL DESCRIZIONE')
        else if Tabella = 'T480_COMUNI' then
          lst.Add('CITTA DESCRIZIONE')
        else
          lst.Add('DESCRIZIONE');
        lst.Add(Format(' FROM %s T1 WHERE %s IS NOT NULL :FILTRO',[Tabella,Codice]));
        if Storico = 'S' then
          if Copy(Tabella,1,4) = 'I501' then
            lst.Add(' AND :DECORRENZA BETWEEN DECORRENZA AND DECORRENZA_FINE')
          else
            lst.Add(Format(' AND DECORRENZA = (SELECT MAX(DECORRENZA) FROM %s WHERE %s = T1.%s AND DECORRENZA <= :DECORRENZA)',[Tabella,Codice,Codice]));
        lst.Add(' ORDER BY 1');
      end;
      if lst.Text <> Query.SQL.Text then
      begin
        Query.SQL.Assign(lst);
        Query.DeleteVariables;
        Query.DeclareAndSet('FILTRO',otSubst,null);
        if Storico = 'S' then
          Query.DeclareVariable('DECORRENZA',otDate);
        Query.Close;
      end;
    finally
      lst.Free;
    end;
  end;
end;

procedure A000GetChiavePrimaria(Sessione:TOracleSession; Tabella:String; L:TStringList);
{Restituisce in L l'elenco delle colonne che fanno parte della chiave primaria}
var OwnerMondoEDP:Boolean;
begin
  OwnerMondoEDP:=Pos('MONDOEDP.',UpperCase(Tabella)) > 0;
  Tabella:=StringReplace(Tabella,'MONDOEDP.','',[rfIgnoreCase]);
  with TOracleDataSet.Create(nil) do
  try
    Session:=Sessione;
    SQL.Add('SELECT COLUMN_NAME FROM USER_CONS_COLUMNS T1,USER_CONSTRAINTS T2 WHERE');
    SQL.Add('T1.TABLE_NAME = T2.TABLE_NAME AND');
    SQL.Add('T1.CONSTRAINT_NAME = T2.CONSTRAINT_NAME AND');
    SQL.Add('T1.TABLE_NAME = ''' + UpperCase(Tabella) + ''' AND ');
    SQL.Add('CONSTRAINT_TYPE = ''P''');
    if OwnerMondoEDP then
      SQL.Add('AND T1.OWNER = ''MONDOEDP'' AND T2.OWNER = ''MONDOEDP''');
    SQL.Add('ORDER BY POSITION');
    Open;
    L.Clear;
    while not Eof do
      begin
      L.Add(FieldByName('COLUMN_NAME').AsString);
      Next;
      end;
    Close;
  finally
    Free;
  end;
end;

procedure A000GetLayout(SessioneIW:TSessioneIrisWIN; SessioneDB:TOracleSession);
begin
  with TOracleDataSet.Create(SessioneDB) do
  try
    try
      Session:=SessioneDB;
      if SessioneIW.Parametri.Username = '' then
        SQL.Text:='SELECT DISTINCT NOME FROM T033_LAYOUT'
      else
        SQL.Text:='SELECT DISTINCT NOME FROM ' + SessioneIW.Parametri.Username + '.T033_LAYOUT';
      Open;
      if SearchRecord('NOME',SessioneIW.Parametri.Layout,[srFromBeginning]) then
        SessioneIW.Parametri.Layout:=FieldByName('NOME').AsString
      else if SearchRecord('NOME',SessioneIW.Parametri.Operatore,[srFromBeginning]) then
        SessioneIW.Parametri.Layout:=FieldByName('NOME').AsString
      else
        SessioneIW.Parametri.Layout:='DEFAULT';
      Close;
    except;
      SessioneIW.Parametri.Layout:='DEFAULT';
    end;
  finally
    Free;
  end;
end;

function A000FiltroDizionario(T,C:String):Boolean;
{Filtro sulle seguenti tabelle:
CAUSALI ASSENZA
RAGGRUPPAMENTI ASSENZA
PROFILI ASSENZA
CAUSALI PRESENZA
RAGGRUPPAMENTI PRESENZA
MODELLI ORARIO
PROFILI ORARIO
CALENDARI
TURNI REPERIBILITA
GENERATORE DI STAMPE
PARAMETRIZZAZIONI CARTELLINO
TIPOLOGIA TRASFERTA
GRUPPI PESATURE INDIVIDUALI
GRUPPI SC.QUANTITATIVE IND.
RIMBORSI MISSIONI
PROFILI PIANIF. TURNI
OROLOGI DI TIMBRATURA
PROGETTI RENDICONTABILI
}
var i:Integer;
begin
  Result:=True;
  for i:=0 to High(Parametri.FiltroDizionario) do
    if Parametri.FiltroDizionario[i].Tabella = T then
    begin
      //Elementi del cestino: sempre esclusi
      if Parametri.FiltroDizionario[i].Cestino and (Parametri.FiltroDizionario[i].Codice = C) then
      begin
        Result:=False;
        exit;
      end
      //Elementi NON del cestino: comportamento normale
      else if not Parametri.FiltroDizionario[i].Cestino then
      begin
        Result:=not Parametri.FiltroDizionario[i].Abilitato;
        if Parametri.FiltroDizionario[i].Codice = C then
        begin
          Result:=not Result;
          Break;
        end;
      end;
    end;
end;

procedure A000AggiornaFiltroDizionario(T,CodOld,C:String);
var OQ:TOracleQuery;
    T1,C1:String;
    EsisteTabella,Abilitato:Boolean;
    i,iOld:Integer;
  procedure CorreggiFiltroDizionarioVuoto(T,C:String);
  var selI074:TOracleDataSet;
      insDizionario:TOracleQuery;
  begin
    selI074:=TOracleDataSet.Create(nil);
    insDizionario:=TOracleQuery.Create(nil);
    with selI074 do
    try
      Session:=SessioneOracle;
      SQL.Clear;
      SQL.Add('SELECT PROFILO,MAX(CODICE) CODICE FROM MONDOEDP.I074_FILTRODIZIONARIO');
      SQL.Add('WHERE TABELLA = ''' + T + '''');
      SQL.Add(Format('AND PROFILO = (SELECT FILTRO_DIZIONARIO FROM MONDOEDP.I070_UTENTI WHERE PROGRESSIVO = %d)',[Parametri.ProgOper]));
      SQL.Add('GROUP BY PROFILO HAVING COUNT(*) = 1 AND MAX(CODICE) = ''' + C + '''');
      Open;
      if RecordCount > 0 then
      begin
        insDizionario.Session:=SessioneOracle;
        insDizionario.SQL.Clear;
        insDizionario.SQL.Add('INSERT INTO MONDOEDP.I074_FILTRODIZIONARIO (PROFILO,TABELLA,CODICE,ABILITATO)');
        insDizionario.SQL.Add('SELECT ''' + FieldByName('PROFILO').AsString + ''',A.TABELLA,A.CODICE,''N'' FROM (');
        insDizionario.SQL.Add(A000selDizionario);
        insDizionario.SQL.Add(') A');
        insDizionario.SQL.Add('WHERE A.TABELLA = ''' + T + ''' AND A.CODICE <> ''' + C + '''');
        try
          insDizionario.Execute;
          SessioneOracle.Commit;
        except
          raise;
        end;
        SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) + 1);
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Tabella:=T;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Codice:='TABELLA DISABILITATA';
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Abilitato:=True;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Cestino:=False;
      end;
    finally
      Free;
      insDizionario.Free;
    end;
  end;
begin
  EsisteTabella:=False;
  Abilitato:=False;
  iOld:=-1;
  C:=Trim(C);
  CodOld:=Trim(CodOld);
  if C = CodOld then
    exit;
  for i:=0 to High(Parametri.FiltroDizionario) do
    if (Parametri.FiltroDizionario[i].Tabella = T) and (not Parametri.FiltroDizionario[i].Cestino) then
    begin
      EsisteTabella:=True;
      Abilitato:=Parametri.FiltroDizionario[i].Abilitato;
      if C <> '' then
        if not Abilitato then
          C:=''
        else if Parametri.FiltroDizionario[i].Codice = C then
          C:='';
      if (CodOld <> '') and (Parametri.FiltroDizionario[i].Codice = CodOld) then
        iOld:=i;
    end;
  if not EsisteTabella then
    C:='';
  OQ:=TOracleQuery.Create(nil);
  try
    T1:='''' + T + '''';
    C1:='''' + C + '''';
    OQ.Session:=SessioneOracle;
    if CodOld <> '' then
    begin
      if Abilitato then
        CorreggiFiltroDizionarioVuoto(T,CodOld);
      OQ.SQL.Clear;
      OQ.SQL.Add('DELETE MONDOEDP.I074_FILTRODIZIONARIO WHERE');
      OQ.SQL.Add(Format('TABELLA = ''%s'' AND CODICE = ''%s''',[T,CodOld]));
      OQ.SQL.Add(Format('AND PROFILO = (SELECT FILTRO_DIZIONARIO FROM MONDOEDP.I070_UTENTI WHERE PROGRESSIVO = %d)',[Parametri.ProgOper]));
      try
        OQ.Execute;
        SessioneOracle.Commit;
        if iOld >= 0 then
        begin
          for i:=iOld + 1 to High(Parametri.FiltroDizionario) do
            Parametri.FiltroDizionario[i - 1]:=Parametri.FiltroDizionario[i];
          SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) - 1);
        end;
      except
      end;
    end;
    if C <> '' then
    begin
      OQ.SQL.Clear;
      OQ.SQL.Add('INSERT INTO MONDOEDP.I074_FILTRODIZIONARIO (PROFILO,TABELLA,CODICE)');
      OQ.SQL.Add(Format('SELECT FILTRO_DIZIONARIO,%s,%s FROM MONDOEDP.I070_UTENTI WHERE',[T1,C1]));
      OQ.SQL.Add(Format('PROGRESSIVO = %d AND',[Parametri.ProgOper]));
      OQ.SQL.Add('FILTRO_DIZIONARIO IS NOT NULL AND');
      OQ.SQL.Add('EXISTS (SELECT ''X'' FROM MONDOEDP.I074_FILTRODIZIONARIO');
      OQ.SQL.Add(Format('WHERE PROFILO = FILTRO_DIZIONARIO AND TABELLA = %s)',[T1]));
      try
        OQ.Execute;
        SetLength(Parametri.FiltroDizionario,Length(Parametri.FiltroDizionario) + 1);
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Tabella:=T;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Codice:=C;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Abilitato:=True;
        Parametri.FiltroDizionario[High(Parametri.FiltroDizionario)].Cestino:=False;
      except
      end;
    end;
    SessioneOracle.Commit;
  finally
    OQ.Free;
  end;
end;

constructor TParametri.Create(AOwner: TComponent);
{$IFNDEF IRISWEB}
var
  TempHost, TempIP, Err: String;
{$ENDIF}
begin
  inherited Create(AOwner);
  Inibizioni:=TStringList.Create;
  NomiTabelleLog:=TStringList.Create;
  ColonneStruttura:=TStringList.Create;
  TipiStruttura:=TStringList.Create;
  SetLength(AbilitazioniFunzioni,0);
  V430:='';
  Lingua:='I';
  FileAnomalie:='';
  ValiditaPassword:=6;
  LunghezzaPassword:=8;
  InibizioneIndividuale:=False;
  ProgressivoOper:=-1;
  MatricolaOper:='';
  ProfiloWEB:='';
  ProfiloWEBDelegatoDa:=''; // MONZA_HSGERARDO - chiamata 88132
  ProfiloWEBIterAutorizzativi:='';
  cdsI015:=nil;
  RegolePassword:=TRegolePassword.Create(AOwner);
  // daniloc.ini 28.09.2011
  // host non viene impostato qui per irisweb
  // l'impostazione viene effettuata su A000UInterfaccia - IWServerControllerBaseNewSession
  {$IFDEF IRISWEB}
  HostName:='';
  HostIPAddress:='';
  {$ELSE}
  if R180GetIPFromHost(TempHost,TempIP,Err) then
  begin
    HostName:=TempHost;
    HostIPAddress:=TempIP;
  end
  else
  begin
    HostName:='localhost';
    HostIPAddress:='127.0.0.1';
  end;
  {$ENDIF}
  // daniloc.fine
end;

destructor TParametri.Destroy;
begin
  Inibizioni.Free;
  NomiTabelleLog.Free;
  ColonneStruttura.Free;
  TipiStruttura.Free;
  SetLength(AbilitazioniFunzioni,0);
  if cdsI015 <> nil then
    FreeAndNil(cdsI015);
  inherited Destroy;
end;

function TParametri.GetModuloInstallato(Modulo:String):Boolean;
begin
  Result:=Pos(Modulo + #13,ModuliInstallati) > 0;
end;

constructor TSessioneIrisWIN.Create(AOwner: TComponent);
var tmpOwner:TComponent;
begin
  inherited Create(AOwner);
  //Gestione Owner nella creazione componenti all'interno di SessioneIrisWIN per accedere alla struttura completa
  tmpOwner:=AOwner;
  if tmpOwner = nil then
    tmpOwner:=Self;
  SessioneOracle:=TOracleSession.Create(AOwner);
  SessioneOracle.NullValue:=nvNull;
  SessioneOracle.Preferences.ZeroDateIsNull:=False;
  SessioneOracle.Preferences.TrimStringFields:=False;
  //{$IFNDEF IRISWEB}SessioneOracle.Preferences.UseOCI7:=True;{$ENDIF}
  //{$IFDEF IRISWEB}SessioneOracle.Preferences.UseOCI7:=False;{$ENDIF}
  SessioneOracle.Preferences.UseOCI7:=False;//Alberto 15/02/2013
  {$IFDEF IRISWEB}SessioneOracle.ThreadSafe:=True;{$ENDIF}
  SessioneOracle.Cursor:=crSQLWait;
  QueryPK1:=TQueryPK.Create(tmpOwner);
  QueryPK1.Session:=SessioneOracle;
  RegistraLog:=TRegistraLog.Create(tmpOwner);
  RegistraLog.Session:=SessioneOracle;
  RegistraMsg:=TRegistraMsg.Create(SessioneOracle);
  Parametri:=TParametri.Create(tmpOwner);
  Parametri.ClientIPInfo.Status:=isUndefined;
  Parametri.ClientIPInfo.IP:=PUBLIC_IP_UNKNOWN;
  QVistaOracle:=QVistaOracle_Const;
  {$IFNDEF IRISWEB}
  Application.OnException:=ApplicationOnException;
  {$ENDIF}
end;

procedure TSessioneIrisWIN.AlterSessionSessioneOracle;
var SetPar:TOracleQuery;
begin
  SetPar:=TOracleQuery.Create(nil);
  try
    SetPar.Session:=SessioneOracle;
    SetPar.SQL.Add('ALTER SESSION SET NLS_TERRITORY = AMERICA');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN');
    SetPar.Execute;
    SetPar.SQL.Clear;
    SetPar.SQL.Add('ALTER SESSION SET NLS_SORT = BINARY');
    SetPar.Execute;
  finally
    SetPar.Free;
  end;
end;

procedure TSessioneIrisWIN.ApplicationOnException(Sender:TObject; E:Exception);
begin
  {$IFNDEF IRISWEB}
  E.Message:=A000TraduzioneEccezioni(E.Message);
  Application.ShowException(E);
  {$ENDIF}
end;

destructor TSessioneIrisWIN.Destroy;
begin
  try
    if (SessioneOracle <> nil) and (SessioneOracle.Tag <= 0) and (SessioneOracle.Name <> 'SessioneIrisWEB') then
    begin
      SessioneOracle.LogOff;
      SessioneOracle.Free;
    end;
  except
  end;
  try if QueryPK1 <> nil then QueryPK1.Free; except end;
  try if RegistraLog <> nil then RegistraLog.Free; except end;
  try if RegistraMsg <> nil then RegistraMsg.Free; except end;
  try if Parametri <> nil then Parametri.Free; except end;
  inherited Destroy;
end;

initialization
  {$IFNDEF VER210}FormatSettings.{$ENDIF}DateSeparator:='/';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat:='dd/mm/yyyy';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator:='.';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator:=',';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator:='.';
  {$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:='hh.nn.ss';
  Oracle.NoUnicodeSupport:=True;
end.

