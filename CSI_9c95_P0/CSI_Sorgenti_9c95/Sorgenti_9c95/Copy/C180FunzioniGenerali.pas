unit C180FunzioniGenerali;

interface

uses
  A000UCostanti, A000UMessaggi,
  SysUtils, StrUtils, Graphics, Registry, db, classes, Controls, Oracle, OracleData,
  Math, checklst, forms, windows, Variants, Grids, DBGrids, DBCtrls, Clipbrd, WinSvc,
  ComCtrls, StdCtrls, Spin, MAsk,  DBXJSON, Dialogs, ExtCtrls, System.IOUtils,
  DCPcrypt2, DCPsha1, System.JSON, Soap.EncdDecd;

type
  TAnnoInt   = 1900..3999;
  TMeseInt   = 1..12;
  TGiornoInt = 1..31;

  T180SyncProcessExecResults = record
    CodiceUscita:DWORD;
    DatiStdOut, DatiStdErr:String;
  end;

  T180StatoServizio = record
    CurrentState: DWord;
    DescrizioneCurrentState: String;
    EsitoQuery: Integer; // -1: errore generico, 0 = OK, 1 = errore connessione SCM,
                         // 2 = errore apertura servizio, 3 = errore query servizio
    Errore: DWord; // DWORD WINAPI GetLastError(void);
    DescrizioneErrore: String;
  end;

  T180SyncProcessExecNotifyProcedure = procedure(DettagliEsecuzione:T180SyncProcessExecResults) of object;

function  R180VarToDateTime(V:Variant):TDateTime;
procedure R180PutCheckList(S:String; L:Word; CL:TCheckListBox; Separator:char=',');
function  R180GetCheckList(L:Word; CL:TCheckListBox; Separator:char=','):String;
function  R180RadioGroupButton(RG: TRadioGroup; I: Integer): TRadioButton;
function  R180CalcolaCIN(ABI,CAB,CC:String):String;
function  R180CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione:String):String;
function  R180CheckIban(IBAN: String): Boolean;
function  R180IndexOf(L:TStrings; S:String; NC:Word):Integer;
function  R180IndexFromValue(L:TStrings; Value:String):Integer;
function  FormattaCodice(Argomento:string):string;
function  R180OreMinuti(Ora:TDateTime):Word; overload;
function  R180OreMinuti(Ora:Variant):Word; overload;
function  R180OreMinuti(Ora:String):LongInt; overload;
function  R180OreMinutiExt(Ora:String):LongInt;
function  R180MinutiOre(Minuti:LongInt; const PTimeSeparator: Char = '.'):String;
function  R180GiorniMese(Data:TDateTime):Byte;
function  R180InizioMese(Data:TDateTime):TDateTime;
function  R180InizioAnno(Data:TDateTime):TDateTime;
function  R180FineMese(Data:TDateTime):TDateTime;
function  R180InizioMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
function  R180FineMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
function  R180AddMesi(Data:TDateTime; Mesi:Integer; MantieniFineMese:Boolean = False):TDateTime;
function  R180Anno(Data:TDateTime):Word;
function  R180Mese(Data:TDateTime):Word;
function  R180Giorno(Data:TDateTime):Word;
function  R180SettimanaAnno(Data:TDateTime; IniziaDomenica:Boolean = True):Integer;
function  R180StrToDateFmt(Data,Formato:String):TDateTime;
function  EsisteApice(Value:String):Boolean;
function  AggiungiApice(Value:String):String;
function  AggiungiApiceDoppio(Value:String):String;
function  R180Centesimi(Minuti:Longint):String;
function  R180CarattereDef(const S:String; N:Word = 1; D:Char = #0):Char;
function  R180Spaces(S:String; L:Word):String;
function  R180EliminaSpaziMultipli(const Val: String): String;
function  R180GetValore(S,P,A:String; var Valore:String):Boolean;
function  R180GetFontStyle(FS:String):TFontStyles;
function  R180DimLung(S:String; D:Integer):String;
function  R180LPad(const PStr:String; PNumCaratteri:Integer; PCarattere:char):String;
function  R180RPad(const PStr:String; PNumCaratteri:Integer; PCarattere:char):String;
function  R180ElencoGiorni(Inizio,Fine:TDateTime; Formato:String):String;
function  R180ElencoMesi(Inizio,Fine:TDateTime; Formato:String):String;
procedure R180AppendFile(const NomeFile,Testo:String);
procedure R180AppendFileNoCR(const NomeFile,Testo:String);
function  R180NomeMese(Num:Byte):String;
function  R180NomeMeseAnno(D: TDateTime): String;
function  R180NomeGiorno(Anno,Mese,Giorno:Word):String; overload;
function  R180NomeGiorno(D:TDateTime):String; overload;
function  R180NomeGiornoSett(GiornoSettimana:Word):String;
function  Identificatore(const Nome:String):String;
function  EliminaRitornoACapo(Testo : String) : String;
function  CalcolaPasqua(Anno:Integer):TDateTime;
function  Festivo(Giorno,Mese,Anno:Integer):Boolean;
function  R180ArrotondaMinuti(Valore,Arrotondamento:Integer):Integer;
procedure R180DecodeFileB64(const PStringaB64,PFileName: string);
function  R180Decripta(S:String; Key:LongInt):String;
function  R180Cripta(S:String; Key:LongInt):String;
function  R180CriptaI070(Password:string):string;
function  R180DecriptaI070(Password:string):string;
function  R180DimLungR(S:String; D:Integer):String;
function  R180InserisciColonna(var S:String; const C:String):Boolean;
function  R180InConcat(const Parola,Stringa:String):Boolean;
function  R180CercaParolaIntera(const Parola,Stringa,CaratteriSeparazione:String):Integer;
function  R180NumOccorrenzeCar(S:String; C:Char):Integer;
function  R180NumOccorrenzeString(const Substring, Text: string): integer;
procedure R180PutRegistro(Root:HKEY; const Chiave,Dato,Valore:String);
function  R180GetRegistro(Root:HKEY; const Chiave,Dato,Def:String):String;
function  R180ScriviMsgLog(const FileLog,Msg:String):Boolean;
function  R180GetEnvVar(const VarName: string): string;
function  R180GetEnvVarValue(const VarName: string): string;
function  R180SetEnvVarValue(const VarName, VarValue: string): Integer;
procedure R180SetOracleInstantClient;
procedure R180OraValidate(S:String);
function  OreMinutiValidate(Valore:String): Boolean;
procedure R180ClearDBEditDateTime(Sender:TObject);
function  R180StrToGiorniOre(Valore,UM:String):Real;
function  R180GiorniOreToStr(Valore:Real; UM:String; Formato:String=''):String;
function  R180GetFilePath(S:String):String;
function  R180GetFileName(S:String):String;
function  R180GetFileSize(const PFileName:String): Int64;
function  R180GetFileSizeStr(const PSizeInBytes: Int64): String; overload;
function  R180GetFileSizeStr(const PFileName:String): String; overload;
function  R180GetCampiConcatenati(D:TDataSet; C:TStringList):String;
function  R180EstraiNomeTabella(SqlText:string):string;
function  R180Query2NomeTabella(DS:TDataSet):string;
function  R180Arrotonda(Dato,Valore:Real; Tipo:String): Real;
function  R180AzzeraPrecisione(Dato:Real; NumDec:Integer): Real;
function  R180Formatta(Dato:Real; NumCrt,NumDec:Integer):String;
function  R180CifreDecimali(Dato:Real):Byte;
function  R180FormattaNumero(S,F:String):String;
function  R180IsDigit(const PStr: String; PIndex: Integer): Boolean; overload;
function  R180IsDigit(const PChr: Char): Boolean; overload;
function  R180IsNumeric(S:String):Boolean;
function  R180IsSpecialChar(const PChr: Char): Boolean;
function  R180EliminaZeriASinistra(S:String):String;
function  R180EncodeFileB64(const PFileName: string): String;
function  R180ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean; overload;
function  R180ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean; overload;
function  R180ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var Err: String): Boolean; overload;
function  R180MessageBox(const Messaggio, Tipo: String; const Titolo: String = ''; const KeyID: String = ''): Integer;
function  R180Values(S:String):String;
function  R180NomeFileDatato(NomeFile,Formato:String; Data:TDateTime):String;
function  R180EstraiNomeFile(S:String):String;
function  R180EstraiExtFile(S:String):String;
function  R180EstraiPercorsoFile(S:String):String;
function  R180GetOracleRelease(ss:TOracleSession):String;
//function R180EstraiProgressivoC700(C700SqlText:String; C700Progressivo:integer):String;
procedure R180InizializzaArray(var Vettore:array of Integer; Valore:Integer = 0); overload;
procedure R180InizializzaArray(var Vettore:array of Real; Valore:Real = 0); overload;
function  R180SommaArray(Vettore:array of Integer):Integer; overload;
function  R180SommaArray(Vettore:array of Real):Real; overload;
function  R180SyncProcessExec(PathProgramma,DirProgramma,Argomenti:String; ProceduraNotify:T180SyncProcessExecNotifyProcedure=nil):T180SyncProcessExecResults;
function  R180SysDate(Sessione:TOracleSession):TDateTime;
function  R180AttivaHintSQL(SQL:String; VersioneOracle:Integer):String;
function  R180NumeroInLettere(Sessione:TOracleSession; Numero:Real):String;
function  R180LunghezzaCampo(F:TField):Integer;
procedure R180DBGridCopyToClipboard(DBGrid:TDBGrid; CopyToExcel:Boolean; RigheSelezionate:Boolean = True; Intestazione:Boolean = True; NoACapo:Boolean = False);
procedure R180StringGridCopyToClipboard(StringGrid:TStringGrid);
function  R180IncollaTestoDaClipboard(Testo:String;InizioSelezione,LunghezzaSelezione:Integer):String;
procedure R180DBGridSelezionaRighe(DBGrid:TDBGrid; Modo:Char);
function  R180GetColonnaDBGrid(DBGrid:TDBGrid; Campo:String):Integer;
function  R180FormatiCodificati(Dato,Formato:String;Lung:integer=0):String;
function  R180FormattaValoreLike(sValore:String):String;
procedure R180AbilitaOggetti(C:TWinControl; Abilitato:Boolean);
function  R180GetStringList(DataSet:TDataSet; Colonne:String):String;
//function  R180In(const Valore,lstValori:Variant):Boolean; overload;
function  R180In(const Valore:String; lstValori:array of String):Boolean; overload;
function  R180In(const Valore:Integer; lstValori:array of Integer):Boolean; overload;
//function  R180Between(const Valore,Da,A:Variant):Boolean; overload;
function  R180Between(const Valore,Da,A:String):Boolean; overload;
function  R180Between(const Valore,Da,A:Integer):Boolean; overload;
function  R180Between(const Valore,Da,A:TDateTime):Boolean; overload;
function  R180Indenta(const PTesto: String; const PIndentazione: Integer): String;
function  R180Sha1Encrypt(const PStr: String): String;
(*
function  R180Decode(const Valore: Variant; KeyValueArr: array of const): Variant;
function  R180DecodeStr(const Valore: Variant; KeyValueArr: array of const): String;
*)
function  R180SetVariable(ODS:TOracleDataset; Variabile:String; Valore:Variant):Boolean;
procedure R180SetReadBuffer(ODS:TOracleDataset);
function  R180CloseDataSetTag0(DS: TDataset; const DistruggiFields: Boolean = False): Boolean;
function  R180Capitalize(const PTesto: String): String;
function  R180SplittaArray(Const InStringa, Separatore:String):TArrString;
procedure R180Tokenize(const Lista: TStrings; const Value: String; const Delimiter: String = ',');
procedure R180SplitLines(Lista: TStrings; BreakSet: TSysCharSet = [' ',',']; MaxCol: Integer = 2000);
function  R180GetOSTempDir: String;
procedure R180RemoveDir(const DirName: string);
function  R180IsDirectoryWritable(const PDirName: String): Boolean;
function  R180InserisciAliasT030(const StrSql: String): String;
function  R180GetIPFromHost(var HostName, IPaddr, WSAErr: String): Boolean;
function  R180GetServicePath(strServiceName: string; strMachine: string = ''): String;
function  R180GetServiceStatus(strServiceName: string; strMachine: string = ''): T180StatoServizio;
function  R180CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):String;
function  R180SostituisciCaratteriSpeciali(Testo:String):String;
function  R180ValueToItem(MyArray:array of TItemsValues;Value:string):string;
procedure R180SetComboItemsValues(lst:TStrings; ItemsValues:array of TItemsValues; TipoLista:String);
function  R180GetCsvIntersect(const PElenco1, PElenco2: String): String;
procedure R180StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList);
procedure R180JsonString2Comp(Sender: TComponent; JsonPair: TJSONPair);
function  R180getCaptionTipologia(TipoQuota: String) : String;
function  R180PreparaFileHelpTemp(NomeFileHelp:String):String;
procedure R180OracleObjectSource(const PObjName: String; POracleSession: TOracleSession; var RResultList: TStringList);
function  R180WinApiIsUserAnAdmin():BOOL; stdcall; // https://docs.microsoft.com/en-us/windows/desktop/api/shlobj_core/nf-shlobj_core-isuseranadmin
function  R180IsUserAnAdmin():Boolean; // wrapper per R180WinApiIsUserAnAdmin(), che chiama IsUserAnAdmin() da shell32.dll

//XE4
procedure R180DBGridSetDrawingStyle(Sender:TComponent);
procedure R180ToolBarHandleNeeded(Sender: TWinControl);

// costanti
const
  // messagebox
  INFORMA             = 'INFORMA';             // icona info     + pulsante OK
  DOMANDA             = 'DOMANDA';             // icona question + pulsanti Si, No
  DOMANDA_ALL         = 'DOMANDA_ALL';         // icona question + pulsanti Si, No, No a tutti, Sì a tutti
  DOMANDA_ESCI        = 'DOMANDA_ESCI';        // icona question + pulsanti Si, No, Annulla
  DOMANDA_YESALL_ESCI = 'DOMANDA_YESALL_ESCI'; // icona question + pulsanti Si, No, Annulla, Sì a tutti
  ERR_ELAB_CONTINUA   = 'ERR_ELAB_CONTINUA';   // icona warning  + pulsanti Si, No, Termina
  ERR_ELAB_STOP       = 'ERR_ELAB_STOP';       // icona warning  + pulsanti Ignora, Termina
  ERR_ELAB_TERMINA    = 'ERR_ELAB_TERMINA';    // icona warning  + pulsante Termina
  ESCLAMA             = 'ESCLAMA';             // icona warning  + pulsante OK
  ERRORE              = 'ERRORE';              // icona error    + pulsante OK
  // win admin
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5)) ;
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS = $00000220;

implementation

uses {$IFNDEF WEBSVC}
       {$IFDEF IRISWEB}
       A000UInterfaccia, // necessaria per ThreadElaborazione
       medpIWMessageDlg, // necessaria per R180MessageBox su web
       {$ENDIF IRISWEB}
     {$ENDIF WEBSVC}
     Winsock;            // necessaria per ip address

function R180VarToDateTime(V:Variant):TDateTime;
var S:String;
    TS:Char;
begin
  Result:=0;
  if not VarIsNull(V) then
  try
    if VarIsType(V,varDate) then
      Result:=VarToDateTime(V)
    else
    begin
      //Utilizza di preferenza TryStrToDateTime perchè VarToDateTime usa le impostazioni locali della macchina, anche se ridefinite dai FormatSettings
      S:=VarToStr(V);
      TS:={$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator;
      //Converto il separatore delle ore in quello previsto da FormatSettings.TimeSeparator in modo che la funzione TryStrToDateTime lavori orettamente
      //questo perchè VarToStr usa le impostazioni locali, mentre TryStrToDateTime le impostazioni di FormatSettings
      if Pos(TS,S) = 0 then
        S:=StringReplace(S,IfThen(TS = '.',':','.'),IfThen(TS = '.','.',':'),[rfReplaceAll]);
      if not TryStrToDateTime(S,Result) then
        Result:=VarToDateTime(V);
    end;
  except
    try
      Result:=VarToDateTime(V);
    except
      Result:=0;
    end;
  end;
end;

function R180getCaptionTipologia(TipoQuota: String) : String;
begin
  Result:='';
  if TipoQuota = 'A' then
    Result:='Acconto'
  else if TipoQuota = 'S' then
    Result:='Saldo'
  else if TipoQuota = 'T' then
    Result:='Saldo Totale'
  else if TipoQuota = 'I' then
    Result:='Saldo Individuale'
  else if TipoQuota = 'V' then
    Result:='Saldo Valutativo'
  else if TipoQuota = 'C' then
    Result:='Saldo Collettivo'
  else if TipoQuota = 'D' then
    Result:='Saldo Collettivo Valutativo'
  else if TipoQuota = 'Q' then
    Result:='Quota quantitativa'
  else if TipoQuota = 'P' then
    Result:='Penalizzazione';
end;

function R180GetOracleRelease(ss:TOracleSession):String;
begin
  try
    Result:=trim(copy(ss.ServerVersion,Pos('release',LowerCase(ss.ServerVersion)) + Length('Release')));
    Result:=Copy(StringReplace(Result,'.','',[RFREPLACEALL]),1);
  except
    Result:='';
  end;
end;

function R180GetServicePath(strServiceName: string; strMachine: string = ''): String;
var
  hSCManager,hSCService: SC_Handle;
  lpServiceConfig: {$IFNDEF VER210}LPQuery_Service_ConfigW{$ELSE}PQueryServiceConfigW{$ENDIF};
  NSIZE, nBytesNeeded: DWord;
begin
  Result := '';
  hSCManager := OpenSCManager(PChar(strMachine), nil, SC_MANAGER_CONNECT);
  if (hSCManager > 0) then
  begin
    hSCService := OpenService(hSCManager, PChar(strServiceName), SERVICE_QUERY_CONFIG);
    if (hSCService > 0) then
    begin
      QueryServiceConfig(hSCService, nil, 0, nSize);
      lpServiceConfig := AllocMem(nSize);
      try
        if not QueryServiceConfig(hSCService, lpServiceConfig, nSize, nBytesNeeded) Then
          Exit;
        Result := lpServiceConfig^.lpBinaryPathName;
      finally
        Dispose(lpServiceConfig);
      end;
      CloseServiceHandle(hSCService);
    end;
  end;
end;

function R180GetServiceStatus(strServiceName: string; strMachine: string = ''): T180StatoServizio;
var
  SCManHandle,SvcHandle:SC_Handle;
  ServiceStatus:TServiceStatus;
begin
  Result.CurrentState:=0;
  Result.DescrizioneCurrentState:='-';
  Result.EsitoQuery:=-1;
  Result.Errore:=0;
  Result.DescrizioneErrore:='-';

  // Apro il service manager
  SCManHandle:=OpenSCManager(PChar(strMachine),nil,SC_MANAGER_CONNECT);
  if SCManHandle = 0 then
  begin
    // Se OpenSCManager ritorna 0 significa la connessione al service control manager è fallita. Perchè?
    Result.EsitoQuery:=1;
    Result.Errore:=GetLastError;
    case Result.Errore of
      ERROR_ACCESS_DENIED:
        Result.DescrizioneErrore:='Accesso negato al SCM';
      ERROR_DATABASE_DOES_NOT_EXIST:
        Result.DescrizioneErrore:='Database inesistente';
      else
        Result.DescrizioneErrore:='Errore indefinito durante la connessione al SCM';
    end;
    Exit;
  end;
  try
    SvcHandle:=OpenService(SCManHandle,PChar(strServiceName),SERVICE_QUERY_STATUS);
    if SvcHandle = 0 then
    begin
      // Se OpenService ritorna 0 significa che non siamo riusciti ad ottenere l'handle al servizio
      Result.EsitoQuery:=2;
      Result.Errore:=GetLastError;
      case Result.Errore of
        ERROR_ACCESS_DENIED:
          Result.DescrizioneErrore:='Accesso negato durante l''apertura del servizio';
        ERROR_INVALID_HANDLE:
          Result.DescrizioneErrore:='Handle servizio non valido';
        ERROR_INVALID_NAME:
          Result.DescrizioneErrore:='Nome del servizio non valido';
        ERROR_SERVICE_DOES_NOT_EXIST:
          Result.DescrizioneErrore:='Il servizio non esiste';
        else
          Result.DescrizioneErrore:='Errore indefinito durante l''apertura del servizio';
      end;
      Exit;
    end;
    try
      // Apertura del servizio riuscita. Interrogo lo stato.
      if not QueryServiceStatus(SvcHandle,ServiceStatus) then
      begin
        Result.EsitoQuery:=3;
        Result.Errore:=GetLastError;
        case Result.Errore of
          ERROR_ACCESS_DENIED:
            Result.DescrizioneErrore:='Accesso negato durante la query per lo stato del servizio';
          ERROR_INVALID_HANDLE:
            Result.DescrizioneErrore:='Handle servizio non valido (query)';
          else
            Result.DescrizioneErrore:='Errore indefinito durante la query per lo stato del servizio';
        end;
        Exit;
      end;
      // Tutto ok
      Result.EsitoQuery:=0;
      Result.CurrentState:=ServiceStatus.dwCurrentState;
      case Result.CurrentState of
        SERVICE_CONTINUE_PENDING:
          Result.DescrizioneCurrentState:='In fase di ripresa';
        SERVICE_PAUSE_PENDING:
          Result.DescrizioneCurrentState:='In fase di messa in pausa';
        SERVICE_PAUSED:
          Result.DescrizioneCurrentState:='In pausa';
        SERVICE_RUNNING:
          Result.DescrizioneCurrentState:='In esecuzione';
        SERVICE_START_PENDING:
          Result.DescrizioneCurrentState:='In fase di avvio';
        SERVICE_STOP_PENDING:
          Result.DescrizioneCurrentState:='In fase di arresto';
        SERVICE_STOPPED:
          Result.DescrizioneCurrentState:='Arrestato';
        0:
          Result.DescrizioneCurrentState:='Impossibile ottenere lo stato';
        else
          Result.DescrizioneCurrentState:='Stato indefinito (' + IntToStr(Result.CurrentState) + ')';
      end;
    finally
      CloseServiceHandle(SvcHandle);
    end;
  finally
    CloseServiceHandle(SCManHandle);
  end;
end;


// G E S T I O N E   I B A N
function R180CalcolaCIN(ABI,CAB,CC:String):String;
{Dato un ABI, CAB e conto corrente, calcola il CIN Italia}
const Numeri:String = '0123456789';
      Lettere:String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      LisPari:array[0..25]of Integer =
      (0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25);
      LisDisp:array[0..25]of Integer =
      (1,0,5,7,9,13,15,17,19,21,2,4,18,20,11,3,6,8,12,14,16,10,22,25,24,23);
var BBAN,Aus,Ret:String;
    i,j,Sum:Integer;
    Errore:Boolean;
  function Normalizza(Val:String;Dim:Integer):String;
  var i:Integer;
      Ret:String;
  begin
    Val:=Trim(Val);
    for i:=Length(Val)+1 to Dim do
      Ret:=Ret + '0';
    Result:=Ret + Val;
  end;
begin
  Errore:=False;
  if (ABI = '') or (CAB = '') or (CC = '') then
    Errore:=True;

  ABI:=Normalizza(ABI,5);
  CAB:=Normalizza(CAB,5);
  CC:=Normalizza(UpperCase(CC),12);
  BBAN:=CC + ABI + CAB;

  if Length(BBAN) > 22 then
    Errore:=True;

  Sum:=0;
  for i:=1 to Length(BBAN) do
  begin
    Aus:=copy(BBAN,i,1);
    j:=pos(Aus,Numeri);
    if j <= 0 then
      j:=pos(Aus,Lettere);
    if j > 0 then
      if (i mod 2) = 0 then
        Sum:=Sum + LisPari[j-1]
      else
        Sum:=Sum + LisDisp[j-1]
    else
      Errore:=True;
  end;
  if Not(Errore) then
    Ret:=copy(Lettere,(Sum mod 26) + 1,1)
  else
    Ret:='';
  Result:=Ret;
end;

function R180CalcolaCINEuropa(ABI,CAB,CC,CinItalia,CodNazione:String):String;
const ValoreOriginale:array[0..35] of char =
      ('0','1','2','3','4','5','6','7','8','9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');
      ValoreDecodificato:array[0..35] of String =
      ('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35');
var   IBANInvertito,IBANNumerico,S:String;
      I,J,Resto:Integer;
      TrovatoValore,Errore:Boolean;
  function Normalizza(Val:String;Dim:Integer):String;
  var i:Integer;
      Ret:String;
  begin
    Val:=Trim(Val);
    for i:=Length(Val)+1 to Dim do
      Ret:=Ret + '0';
    Result:=Ret + Val;
  end;
begin
  Errore:=False;
  if (ABI = '') or (CAB = '') or (CC = '') or (CinItalia = '') or (CodNazione = '') then
    Errore:=True;

  ABI:=Normalizza(ABI,5);
  CAB:=Normalizza(CAB,5);
  CC:=Normalizza(UpperCase(CC),12);
  IBANInvertito:=CinItalia+ABI+CAB+CC+CodNazione+'00';
  TrovatoValore:=False;
  for I:=1 to Length(IBANInvertito) do
  begin
    TrovatoValore:=False;
    for J:=0 to 35 do
      if IBANInvertito[I] = ValoreOriginale[J] then
      begin
        IBANNumerico:=IBANNumerico+ValoreDecodificato[J];
        TrovatoValore:=True;
        break;
      end;
    if not TrovatoValore then
      break;
  end;
  if (TrovatoValore) and (not Errore) then
  begin
    S:=IBANNumerico;
    Resto:=0;
    while Length(S) > 0 do
    begin
      Resto:=StrToInt(Copy(S,1,8)) mod 97;
      if Length(S) > 8 then
        S:=IntToStr(Resto)+Copy(S,9)
      else
        S:='';
    end;
    Result:=Format('%.2d',[(98-Resto) mod 97]);
  end
  else
    Result:='';
end;

function R180CheckIban(IBAN: string): Boolean;
  function ChangeAlpha(input: string): string;
  var
    a: Char;
  begin
    Result:=input;
    for a:='A' to 'Z' do
    begin
      Result:=StringReplace(Result,a,IntToStr(Ord(a) - 55),[rfReplaceAll]);
    end;
  end;

  function CalculateDigits(IBAN: String): Integer;
  var
    v, l: Integer;
    alpha: String;
    number: Longint;
    resto: Integer;
  begin
    IBAN:=UpperCase(IBAN);
    IBAN:=IBAN + Copy(IBAN,1,4);
    Delete(IBAN,1,4);
    IBAN:=ChangeAlpha(IBAN);
    v:=1;
    l:=9;
    resto:=0;
    alpha:='';
    try
      while v <= Length(IBAN) do
      begin
        if l > Length(IBAN) then
          l:=Length(IBAN);
        alpha:=alpha + Copy(IBAN,v,l);
        number:=StrToInt(alpha);
        resto:=number mod 97;
        v:=v + l;
        alpha:=IntToStr(resto);
        l:=9 - Length(alpha);
      end;
    except
      resto:=0;
    end;
    Result:=resto;
  end;
begin
  IBAN:=StringReplace(IBAN,' ','',[rfReplaceAll]);
  Result:=CalculateDigits(IBAN) = 1;
end;

function R180FormattaValoreLike(sValore:String):String;
//Indicare il valore del campo like comprendente le i Wildchars
//Es.: '%VALORE%'
begin
  if Pos('_', sValore) > 0 then
    sValore:=StringReplace(sValore,'_','\_',[rfReplaceAll]);
  Result:=sValore;
end;

(*function R180EstraiProgressivoC700(C700SqlText:String; C700Progressivo:integer):String;
//ESEMPIO DI UTILIZZO...
//    MiaStringa:='AND PROGRESSIVO in ' + R180EstraiProgressivoC700(C700SelAnagrafe.SQL.Text,C700Progressivo);
//    MioDataset.SetVariable('progressivo', MiaStringa);
//    if MioDataset.VariableIndex('DATALAVORO')>-1 then
//      MioDataset.DeleteVariable('DATALAVORO');
//    if Pos(':DATALAVORO',UpperCase(MiaStringa)) > 0 then
//    begin
//      MioDataset.DeclareVariable('DATALAVORO',otDate);
//      MioDataset.SetVariable('DATALAVORO',Parametri.DataLavoro);
//    end;
var
  sSelAnagrafico:String;
begin
  Result:='';
  //Leggo il progressivo filtrato dalla C700
  sSelAnagrafico:=C700SqlText;
  //Considero la parte di istruzione SQL dal FROM in poi...
  sSelAnagrafico:=Copy(sSelAnagrafico, Pos('FROM', UpperCase(sSelAnagrafico)), length(sSelAnagrafico));
  //Elimino eventuali ORDER BY...
  if Pos('ORDER BY', UpperCase(sSelAnagrafico)) > 0 then
    sSelAnagrafico:=Copy(sSelAnagrafico, 1, Pos('ORDER BY', UpperCase(sSelAnagrafico))-1);
  sSelAnagrafico:= '(SELECT PROGRESSIVO ' + sSelAnagrafico + ')';
  //Se nella stringa SelAnagrafico trovo ":PROGRESSIVO" significa che non ho filtrato tramite la lente ed allora
  //sostituisco :PROGRESSIVO con la variabile pubblica P700FDialogStampa.Progressivo
  if Pos(':PROGRESSIVO', sSelAnagrafico) > 0 then
    sSelAnagrafico:= StringReplace(sSelAnagrafico, ':PROGRESSIVO', inttostr(C700Progressivo), [rfReplaceAll, rfIgnoreCase]);
  Result:=sSelAnagrafico;
end;*)

function R180ControllaPeriodo(const PDataInizio, PDataFine: String; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean;
// function che effettua i controlli standard su un periodo indicato con date in formato stringa
// nota: entrambe le date del periodo devono essere indicate
// restituisce
//   True  se il periodo è valido
//   False se il periodo non è valido (valorizza Err con il dettaglio dell'errore)
// valorizza
//   RDataInizio e RDataFine
//     con le date convertite se il periodo è valido
//     con date vuote se il periodo non è valido
// esempio
//   R180ControllaPeriodo('02/08/2014','31/09/2014')
//   -> controlla la validità delle date espresse in stringa e la correttezza del periodo
//      in questo caso restituisce False (la data finale è errata)
var
  LInizio, LFine: TDateTime;
begin
  // 1. determina le date del periodo in base ai parametri
  // inizializzazione variabili
  Result:=False;
  RDataInizio:=DATE_NULL;
  RDataFine:=DATE_NULL;

  // data inizio periodo
  if Trim(PDataInizio) = '' then
  begin
    // data inizio vuota
    LInizio:=DATE_MIN;
  end
  else
  begin
    // data inizio indicata: verifica formato
    if not TryStrToDate(PDataInizio,LInizio) then
    begin
      Err:='Indicare una data valida per l''inizio del periodo!'; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
      Exit;
    end;
  end;

  // data fine periodo
  if Trim(PDataFine) = '' then
  begin
    // data fine vuota
    LFine:=DATE_MAX;
  end
  else
  begin
    // data fine indicata: verifica formato
    if not TryStrToDate(PDataFine,LFine) then
    begin
      Err:='Indicare una data valida per la fine del periodo!'; //A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO);
      Exit;
    end;
  end;

  // 2. controlla il periodo
  Result:=R180ControllaPeriodo(LInizio,LFine,Err);
  if Result then
  begin
    RDataInizio:=LInizio;
    RDataFine:=LFine;
  end;
end;

function R180ControllaPeriodo(const PDataInizio: String; const PNumeroGiorni: Integer; var RDataInizio, RDataFine: TDateTime; var Err: String): Boolean;
// function che effettua i controlli standard su un periodo indicato con data iniziale
// in formato stringa e numero di giorni
// restituisce
//   True  se il periodo è valido
//   False se il periodo non è valido (valorizza Err con il dettaglio dell'errore)
// valorizza
//   RDataInizio e RDataFine
//     con le date convertite se il periodo è valido
//     con date vuote se il periodo non è valido
// esempio
//   R180ControllaPeriodo('10/04/2014',18)
//   -> controlla la correttezza del periodo 10/04/2014 - 27/04/2014
//      in questo caso restituisce True
var
  LInizio, LFine: TDateTime;
begin
  // 1. determina le date del periodo in base ai parametri
  // inizializzazione variabili
  Result:=False;
  RDataInizio:=DATE_NULL;
  RDataFine:=DATE_NULL;

  // data inizio periodo
  if Trim(PDataInizio) = '' then
  begin
    // data inizio vuota
    LInizio:=DATE_MIN;
  end
  else
  begin
    // data inizio indicata: verifica formato
    if not TryStrToDate(PDataInizio,LInizio) then
    begin
      Err:='Indicare una data valida per l''inizio del periodo!'; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
      Exit;
    end;
  end;

  // il numero di giorni deve essere almeno pari a 1 (1 giorno totale)
  if PNumeroGiorni < 1 then
  begin
    Err:='Il periodo indicato non è corretto'; //A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO);
    Exit;
  end;

  // calcola data fine periodo
  LFine:=LInizio + (PNumeroGiorni - 1);

  // 2. controlla il periodo
  Result:=R180ControllaPeriodo(LInizio,LFine,Err);
  if Result then
  begin
    RDataInizio:=LInizio;
    RDataFine:=LFine;
  end;
end;

function R180ControllaPeriodo(const PDataInizio, PDataFine: TDateTime; var Err: String): Boolean;
// function che effettua i controlli standard su un periodo indicato
// nota: la funzione controlla che le date siano entrambe indicate
begin
  Result:=False;

  // 1. data inizio periodo
  // controlla validità nel range convenzionale
  if (PDataInizio < DATE_MIN) or (PDataInizio > DATE_MAX) then
  begin
    Err:='Indicare una data valida per l''inizio del periodo!'; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO);
    Exit;
  end;
  // controlla indicazione data
  // la data inizio è considerata "vuota" se è uguale a DATE_NULL oppure a DATE_MIN
  if (PDataInizio = DATE_NULL) or (PDataInizio = DATE_MIN) then
  begin
    Err:='E'' necessario indicare la data di inizio del periodo!'; //A000TraduzioneStringhe(A000MSG_ERR_DATA_INIZIO_PERIODO_VUOTA);
    Exit;
  end;

  // 2. data fine periodo
  // controlla validità nel range convenzionale
  if (PDataFine < DATE_MIN) or (PDataFine > DATE_MAX) then
  begin
    Err:='Indicare una data valida per la fine del periodo!'; //A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO);
    Exit;
  end;
  // controlla indicazione data
  // la data fine è considerata "vuota" se è uguale a DATE_NULL oppure a DATE_MAX
  if (PDataFine = DATE_NULL) or (PDataFine = DATE_MAX) then
  begin
    Err:='E'' necessario indicare la data di fine periodo!'; //A000TraduzioneStringhe(A000MSG_ERR_DATA_FINE_PERIODO_VUOTA);
    Exit;
  end;

  // 3. controlla consecutività periodo
  if PDataInizio > PDataFine then
  begin
    Err:='Il periodo indicato non è corretto'; //A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO);
    Exit;
  end;

  // periodo ok
  Result:=True;
end;

function R180MessageBox(const Messaggio, Tipo: String; const Titolo: String = '';
  const KeyID: String = ''): Integer;
// questa funzione opera sia in ambito win che in ambito web
// (in modo sostanzialmente differente) ...
{$IFNDEF WEBSVC}
var
  // dettagli dialog
  LDlgType: {$IFDEF IRISWEB}medpIWMessageDlg.TmeIWMsgDlgType{$ELSE}Dialogs.TMsgDlgType{$ENDIF IRISWEB};
  LButtons: {$IFDEF IRISWEB}medpIWMessageDlg.TmeIWMsgDlgBtns{$ELSE}Dialogs.TMsgDlgButtons{$ENDIF IRISWEB};
  LDefaultBtn: {$IFDEF IRISWEB}medpIWMessageDlg.TmeIWMsgDlgBtn{$ELSE}Dialogs.TMsgDlgBtn{$ENDIF IRISWEB};
  {$IFDEF IRISWEB}
  // variabili di supporto per controllo messaggio web
  Element: medpIWMessageDlg.TmeIWMsgDlgBtn;
  NumBtn: Integer;
  {$ENDIF IRISWEB}
{$ENDIF WEBSVC}
begin
  {$IFNDEF WEBSVC}
    if Tipo = INFORMA then
    begin
      // icona info + pulsante OK
      LDlgType:=mtInformation;
      LButtons:=[mbOK];
      LDefaultBtn:=mbOK;
    end
    else if Tipo = ESCLAMA then
    begin
      // icona warning + pulsante OK
      LDlgType:=mtWarning;
      LButtons:=[mbOK];
      LDefaultBtn:=mbOK;
    end
    else if Tipo = ERRORE then
    begin
      // icona errore + pulsante OK
      LDlgType:=mtError;
      LButtons:=[mbOK];
      LDefaultBtn:=mbOK;
    end
    else if Tipo = DOMANDA then
    begin
      // icona question + pulsanti Si, No
      LDlgType:=mtConfirmation;
      LButtons:=[mbYes,mbNo];
      LDefaultBtn:=mbYes;
    end
    else if Tipo = DOMANDA_ALL then
    begin
      // icona question + pulsanti Si, No, No a tutti, Sì a tutti
      LDlgType:=mtConfirmation;
      LButtons:=[mbYes,mbNo,mbNoToAll,mbYesToAll];//l'ordine dei pulsanti TMsgDlgBtn è fissato in System.UITypes
      LDefaultBtn:=mbYes;
    end
    else if Tipo = DOMANDA_ESCI then
    begin
      // icona question + pulsanti Si, No, Annulla
      LDlgType:=mtConfirmation;
      LButtons:=[mbYes,mbNo,mbCancel];
      LDefaultBtn:=mbYes;
    end
    else if Tipo = DOMANDA_YESALL_ESCI then
    begin
      // icona question + pulsanti Si, No, Annulla, Sì a tutti
      LDlgType:=mtConfirmation;
      LButtons:=[mbYes,mbNo,mbCancel,mbYesToAll];//l'ordine dei pulsanti TMsgDlgBtn è fissato in System.UITypes
      LDefaultBtn:=mbYes;
    end
    else if Tipo = ERR_ELAB_CONTINUA then
    begin
      // icona warning  + pulsanti Si, No, Termina
      LDlgType:=mtWarning;
      LButtons:=[mbYes,mbNo,mbAbort];
      LDefaultBtn:=mbYes;
    end
    else if Tipo = ERR_ELAB_STOP then
    begin
      // icona warning  + pulsanti Ignora, Termina then
      LDlgType:=mtWarning;
      LButtons:=[mbIgnore,mbAbort];
      LDefaultBtn:=mbIgnore;
    end
    else if Tipo = ERR_ELAB_TERMINA then
    begin
      // icona warning  + pulsante Termina then
      LDlgType:=mtWarning;
      LButtons:=[mbAbort];
      LDefaultBtn:=mbAbort;
    end
    else
      raise Exception.Create('C180FunzioniGenerali: parametri errati per la funzione R180MessageBox.');

    {$IFDEF IRISWEB}
    // 1. web
    // se l'elaborazione non è su thread separato ma l'interazione prevede
    // scelte multiple solleva un'eccezione
    // (non sarebbe gestibile)
    if ThreadElaborazione = nil then
    begin
      NumBtn:=0;
      for Element:=Low(TmeIWMsgDlgBtn) to High(TmeIWMsgDlgBtn) do
      begin
        if Element in LButtons then
        begin
          inc(NumBtn);
          // la discriminante è che i pulsanti siano 1 oppure > 1
          if NumBtn > 1 then
            Break;
        end;
      end;
      if NumBtn > 1 then
        raise Exception.Create(Format('R180MessageBox non utilizzabile con scelte multiple fuori dal contesto del thread di elaborazione separato',[Tipo]));
    end;

    // messagebox bloccante per web
    Result:=MsgBox.WebMessageDlg(Messaggio,LDlgType,LButtons,nil,KeyID,Titolo,LDefaultBtn);
    {$ELSE}
    // 2. win
    // utilizzo messagedlg
    Result:=MessageDlg(Messaggio,LDlgType,LButtons,0,LDefaultBtn);
    {$ENDIF IRISWEB}
  {$ELSE}
  // in ambito webservice questa funzione non ha senso
  Result:=0;
  {$ENDIF WEBSVC}
end;

procedure R180PutCheckList(S:String; L:Word; CL:TCheckListBox; Separator:char=',');
var Lista:TStringList;
    i,j,indice:Integer;
begin
  for i:=0 to CL.Items.Count - 1 do
    CL.Checked[i]:=False;
  Lista:=TStringList.Create;
  try
    if Separator = ',' then
    begin
      Lista.StrictDelimiter:=True;
      Lista.CommaText:=S
    end
    else
    begin
      if s <> '' then
      begin
        while Pos(Separator,s) > 0 do
        begin
          Lista.Add(Copy(s,1,Pos(Separator,s) - 1));
          s:=Copy(s,Pos(Separator,s) + 1,Length(s));
        end;
        Lista.Add(s);
      end;
    end;
    indice:=-1;
    for i:=0 to Lista.Count - 1 do
      for j:=0 to CL.Items.Count - 1 do
        if Lista[i] = Trim(Copy(CL.Items[j],1,L)) then
          begin
          CL.Checked[j]:=True;
          if indice = -1 then
            indice:=j;
          Break;
          end;
    if indice > -1 then
      CL.ItemIndex:=indice;
  finally
    Lista.Free;
  end;
end;

function R180EncodeFileB64(const PFileName: string): String;
var
  stream: TMemoryStream;
begin
  stream:=TMemoryStream.Create;
  try
    stream.LoadFromFile(PFileName);
    {$WARN IMPLICIT_STRING_CAST OFF}
    result:=EncodeBase64(stream.Memory, stream.Size);
    {$WARN IMPLICIT_STRING_CAST ON}
  finally
    stream.Free;
  end;
end;

function R180GetCheckList(L:Word; CL:TCheckListBox; Separator:char=','):String;
var i:Integer;
begin
  Result:='';
  for i:=0 to CL.Items.Count - 1 do
    if CL.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + Separator;
      Result:=Result + Trim(Copy(CL.Items[i],1,L));
    end;
end;

function R180RadioGroupButton(RG: TRadioGroup; I: Integer): TRadioButton;
begin
  if (I < 0) or (I >= RG.Items.Count) then
  begin
    Result:=nil;
    Exit;
  end;
  Result:=(RG.Controls[I] as TRadioButton);
end;

function R180IndexOf(L:TStrings; S:String; NC:Word):Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to L.Count - 1 do
    if Trim(Copy(L[i],1,NC)) = Trim(S) then
    begin
      Result:=i;
      Break;
    end;
end;

function R180IndexFromValue(L:TStrings; Value:String):Integer;
var i:Integer;
begin
  Result:=-1;
  for i:=0 to L.Count - 1 do
    if L.ValueFromIndex[i] = Value then
    begin
      Result:=i;
      Break;
    end;
end;

function EsisteApice(Value: String): Boolean;
begin
  Result:=Pos('''',Value) > 0;
end;

function AggiungiApice(Value:String):String;
begin
  Result:=StringReplace(Value,'''','''''',[rfReplaceAll]);
end;

function AggiungiApiceDoppio(Value: String): String;
var I,J,Z : Integer;
begin
  Result:=Value;
  if EsisteApice(Value) then
  begin
    I:=1;
    J:=1;
    while I <= Length(Value) do
    begin
      if Value[I] <> '''' then
        Result[J]:= Value[I]
      else
      begin
        SetLength(Result,Length(Result)+1);
        Result[J]:=Value[I];
        for Z:=1 to 1 do
        begin
          J:=J + 1;
          Result[J]:=Value[I];
        end;
      end;
      I:=I + 1;
      J:=J + 1;
    end;
  end;
end;

function FormattaCodice(Argomento:string):string;
Var i:integer;
    appo:string;
Begin
  i:=2;
  Appo:=argomento;
  While (length(appo))>i do
    begin
      insert('.',appo,i);
      i:=i+3;
    end;
  FormattaCodice:=appo;
End;


// ----------   F U N Z I O N I   P E R   O R E / M I N U T I   ----------------
function R180Centesimi(Minuti:LongInt):String;
//Dati i minuti, restituisce la stringa nel formato hh:mm
// con i minuti espressi in centesimi.
var Ore:Word;
    Min : Word;
    OreS,MinS{,OldTimeFormat}:String;
    L:Byte;
begin
  Ore:=Abs(Minuti) div 60;
  Min:=Abs(Minuti) mod 60;
  Min:=round((Min * 100) / 60);
  // gestione non thread safe rimossa.ini
  {
  OldTimeFormat:=LongTimeFormat;
  LongTimeFormat:='hh:mm';
  TimeSeparator:='.';
  }
  // gestione non thread safe rimossa.fine
  OreS:=IntToStr(Ore);
  L:=Length(OreS);
  //Calcolo la lunghezza delle ore
  if L = 1 then inc(L);
  MinS:=FloatToStr(Min);
  // gestione non thread safe rimossa.ini
  //try
  //  Result:=TimeToStr(EncodeTime(Ore,Min,0,0));
  //except
  // gestione non thread safe rimossa.fine
    Result:=Copy('0' + OreS,Length(OreS) + 2 - L,L) + '.' + Copy('0' + MinS,Length(Mins),2);
  //end;
  if Minuti < 0 then
    Result:='-' + Result;
  // gestione non thread safe rimossa.ini
  // {$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:=OldTimeFormat;
  // gestione non thread safe rimossa.fine
end;

function R180OreMinuti(Ora:TDateTime):Word;
{Data un 'ora del giorno in TDateTime, la converte in Minuti}
var Hour,Min,Sec,MSec:Word;
begin
  DecodeTime(Ora, Hour, Min, Sec, MSec);
  Result:=Hour * 60  + Min;
end;

function R180OreMinuti(Ora:Variant):Word;
{Data un 'ora del giorno in Variant (Data o Stringa), la converte in Minuti}
begin
  if VarIsStr(Ora) then
    Result:=R180OreMinuti(VarToStr(Ora))
  else
    Result:=R180OreMinuti(R180VarToDateTime(Ora));
end;

function R180OreMinuti(Ora:String):LongInt;
// Data un'ora in formato stringa, la converte in Minuti
// L'ora può avere i seguenti formati:
// - [-]hhhh[.|:|,]mm           | es. 134.59, 18.36, -20:50
// - [-]hhhh[.|:|,]mm[.|:|,]ss  | es. 134.59.00, 18.36.00, -20:50:00
// Da usare quando si hanno più di 23 ore e quindi non si può usare il tipo TDateTime
var Posiz,i:Byte;
    Hour,Min:LongInt;
    Negativo:Boolean;
    sMin:String;
begin
  i:=1;
  Negativo:=False;
  while i <= Length(Ora) do
  begin
    if (Ora[i] <> ' ') and (Ora[i] <> '-') then
      Break;
    if Ora[i] = '-' then
    begin
      Negativo:=True;
      Break;
    end;
    inc(i);
  end;
  i:=1;
  while i <= Length(Ora) do
  begin
    if Ora[i] = ' ' then
      Delete(Ora,i,1)
    else
      inc(i);
  end;
  Min:=0;
  Posiz:=Pos('.',Ora);
  //Controllo se vengono usati i ':' come separatore
  if Posiz = 0 then
    Posiz:=Pos(':',Ora);
  //Controllo se viene usata la ',' come separatore
  if Posiz = 0 then
    Posiz:=Pos(',',Ora);
  if Posiz = 0 then
    Hour:=StrToIntDef(Ora,0)
  else
  begin
    Hour:=StrToIntDef(Copy(Ora,1,Posiz - 1),0);
    // chiamata 74591.ini - TORINO_COMUNE
    // accetta anche i valori di "Ora" comprensivi di secondi (es. 23.59.00)
    sMin:=Copy(Ora,Posiz + 1,Length(Ora));
    if Pos('.',sMin) > 0 then
      sMin:=Copy(sMin,1,Pos('.',sMin) - 1)
    else if Pos(':',sMin) > 0 then
      sMin:=Copy(sMin,1,Pos(':',sMin) - 1)
    else if Pos(',',sMin) > 0 then
      sMin:=Copy(sMin,1,Pos(',',sMin) - 1);
    Min:=StrToIntDef(sMin,0);
    // chiamata 74591.fine
  end;
  Result:=Abs(Hour) * 60 + Min;
  if Negativo then
    Result:=-Result;
end;

function R180OreMinutiExt(Ora:String):LongInt;
begin
  Result:=R180OreMinuti(Ora);
end;

function R180MinutiOre(Minuti:LongInt; const PTimeSeparator: Char = '.'):String;
{Dati i minuti, restituisce la stringa nel formato hh:mm}
var Ore,Min:LongInt;
    OreS,MinS{,OldTimeFormat}:String;
    L:Byte;
begin
  // gestione non thread safe rimossa.ini
  //OldTimeFormat:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat;
  //{$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:='hh:mm';
  //{$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator:='.';
  // gestione non thread safe rimossa.fine
  Ore:=Abs(Minuti) div 60;
  Min:=Abs(Minuti) mod 60;
  OreS:=IntToStr(Ore);
  L:=Length(OreS);
  //Calcolo la lunghezza delle ore
  if L = 1 then inc(L);
  MinS:=IntToStr(Min);
  Result:=Copy('0' + OreS,Length(OreS) + 2 - L,L) + PTimeSeparator {'.'} + Copy('0' + MinS,Length(Mins),2);
  if Minuti < 0 then
    Result:='-' + Result;
  // gestione non thread safe rimossa.ini
  //{$IFNDEF VER210}FormatSettings.{$ENDIF}LongTimeFormat:=OldTimeFormat;
  // gestione non thread safe rimossa.fine
end;

function R180GiorniMese(Data:TDateTime):Byte;
{Restituisce il numero di giorni del mese}
var Anno,Mese,Giorno:Word;
begin
  Result:=0;
  DecodeDate(Data,Anno,Mese,Giorno);
  case Mese of
     1: Result:=31;
     2: Result:=IfThen(IsLeapYear(Anno),29,28);
     3: Result:=31;
     4: Result:=30;
     5: Result:=31;
     6: Result:=30;
     7: Result:=31;
     8: Result:=31;
     9: Result:=30;
    10: Result:=31;
    11: Result:=30;
    12: Result:=31;
  end;
end;

function R180InizioMese(Data:TDateTime):TDateTime;
var A,M,G:Word;
begin
  DecodeDate(Data,A,M,G);
  Result:=EncodeDate(A,M,1);
end;

function R180InizioAnno(Data:TDateTime):TDateTime;
var A,M,G:Word;
begin
  DecodeDate(Data,A,M,G);
  Result:=EncodeDate(A,1,1);
end;

function R180FineMese(Data:TDateTime):TDateTime;
var A,M,G:Word;
begin
  DecodeDate(Data,A,M,G);
  Result:=EncodeDate(A,M,R180GiorniMese(Data));
end;

function R180InizioMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
{Restituisce l'inizio del mese nell'ambito del conteggio settimanale:
  il mese comincia sempre di lunedì e finisce sempre di domenica}
begin
  Result:=R180InizioMese(Data);
  if UltimaSettInterna then
    //lunedì della prima settimana che interseca il mese e ultima settimana interna al mese
    Result:=Result - DayOfWeek(Result - 1) + 1
  else
    //lunedì della prima settimana compresa nel mese e ultima settimana interseca mese succ.
    Result:=Result + ((8 - DayOfWeek(Result - 1)) mod 7);
end;

function R180FineMeseSettimanale(Data:TDateTime; UltimaSettInterna:Boolean):TDateTime;
{Restituisce la fine del mese nell'ambito del conteggio settimanale:
  il mese comincia sempre di lunedì e finisce sempre di domenica}
begin
  Result:=R180FineMese(Data);
  if DayOfWeek(Result - 1) < 7 then
  begin
    if UltimaSettInterna then
      //domenica dell'ultima settimana compresa nel mese
      Result:=Result - DayOfWeek(Result - 1)
    else
      //domenica dell'ultima settimana che interseca il mese
      Result:=Result + 7 - DayOfWeek(Result - 1);
  end;
end;

function R180AddMesi(Data:TDateTime; Mesi:Integer; MantieniFineMese:Boolean = False):TDateTime;
var A,M,G:Word;
    i:Integer;
    InizioMese: TDateTime;
begin
  DecodeDate(Data,A,M,G);
  if Mesi > 0 then
    for i:=1 to Abs(Mesi) do
    begin
      inc(M);
      if M > 12 then
      begin
        M:=1;
        inc(A);
      end;
    end
  else
    for i:=1 to Abs(Mesi) do
    begin
      dec(M);
      if M < 1 then
      begin
        M:=12;
        dec(A);
      end;
    end;
  InizioMese:=EncodeDate(A,M,1);
  if (G > R180GiorniMese(InizioMese)) or ((Data = R180FineMese(Data)) and MantieniFineMese) then
    Result:=R180FineMese(InizioMese)
  else
  begin
    try
      Result:=EncodeDate(A,M,G);
    except
      Result:=R180FineMese(InizioMese);
    end;
  end;
end;

function R180StrToDateFmt(Data,Formato:String):TDateTime;
var DataOut,TimeOut:String;
    i:Integer;
begin
  Formato:=Trim(UpperCase(Formato));
  DataOut:=Data;
  TimeOut:='HH.NN';
  if Formato <> '' then
  begin
    DataOut:=UpperCase({$IFNDEF VER210}FormatSettings.{$ENDIF}ShortDateFormat);
    for i:=1 to min(Length(Formato),Length(Data)) do
      if Formato[i] in ['Y','M','D'] then
      //if CharInSet(Formato[i],['Y','M','D']) then
        DataOut:=StringReplace(DataOut,Formato[i],Data[i],[rfIgnoreCase])
      else if Formato[i] in ['H','N'] then
        TimeOut:=StringReplace(TimeOut,Formato[i],Data[i],[rfIgnoreCase])
  end;
  if TimeOut = 'HH.NN' then
    Result:=StrToDate(DataOut)
  else
    Result:=StrToDateTime(DataOut + ' ' + TimeOut);
end;

function R180CarattereDef(const S:String; N:Word = 1; D:Char = #0):Char;
{Restituisce il carattere in posizione N della stringa S
 Gestisce la non esistenza di quella posizione nella stringa}
begin
  Result:=#0;
  if N = 0 then
    exit;
  if Length(S) >= N then
    Result:=S[N]
  else
    Result:=D;
end;

function R180Spaces(S:String; L:Word):String;
{Aggiungo N Spazi alla stringa S}
var i,Lung:Word;
begin
  Result:=S;
  Lung:=Length(S) + 1;
  for i:=Lung to L do
    S:=S + ' ';
  Result:=S;
end;

function R180EliminaSpaziMultipli(const Val: String): String;
var
  i, n : integer;
begin
  SetLength(Result,Length(Val));
  if Val <> '' then
  begin
    n:=0;
    for i:=1 to Length(Val) do
    begin
      if (Val[i] in SPAZI_SET) then
      begin
        if (n < 1) or (Result[n] <> SPACE) then
        begin
          inc(n);
          Result[n]:=SPACE;
        end;
      end
      else
      begin
        inc(n);
        Result[n]:=Val[i];
      end;
    end;

    // elimina spazi in fondo
    while (n > 1) and (Result[n] = SPACE) do
      Dec(n);
    SetLength(Result,n);
  end;
end;

function R180GetValore(S,P,A:String; var Valore:String):Boolean;
var i,j:Integer;
begin
  Result:=False;
  //Stringa di partenza
  i:=Pos(P,S);
  if i = 0 then exit;
  i:=i + Length(P);
  //Stringa di arrivo
  if A = '' then
    j:=Length(S) + 1
  else
    begin
    j:=Pos(A,S);
    if j = 0 then j:=Length(S) + 1;
    end;
  Result:=True;
  Valore:=Copy(S,i,j - i);
end;

function R180GetFontStyle(FS:String):TFontStyles;
{Restituisce il FontStyle partendo dal formato stringa
 precedentemente salvato}
begin
  Result:=[];
  if R180CarattereDef(FS,1,'0') = '1' then
    Result:=Result + [fsBold];
  if R180CarattereDef(FS,2,'0') = '1' then
    Result:=Result + [fsItalic];
  if R180CarattereDef(FS,3,'0') = '1' then
    Result:=Result + [fsUnderline];
  if R180CarattereDef(FS,4,'0') = '1' then
    Result:=Result + [fsStrikeOut];
end;

function R180DimLung(S:String; D:Integer):String;
{Aggiungo n spazi in coda ad S in modo da ottenere la lunghezza = D}
var i,L:Integer;
begin
  if D = 0 then D:=Length(S);
  Result:=Copy(S,1,D);
  L:=Length(Result);
  for i:=L to D - 1 do
    Result:=Result + ' ';
end;

function R180LPad(const PStr:string; PNumCaratteri:integer; PCarattere:char): string;
// left pad
begin
  Result:=StringOfChar(PCarattere,PNumCaratteri - Length(PStr)) + PStr;
end;

function R180RPad(const PStr:string; PNumCaratteri:integer; PCarattere:char): string;
// right pad
begin
  Result:=PStr + StringOfChar(PCarattere,PNumCaratteri - Length(PStr));
end;

function R180ElencoGiorni(Inizio,Fine:TDateTime; Formato:String):String;
{Restituisce una stringa contenente tutte le date da inizio a fine nel formato specificato}
var Corr:TDateTime;
begin
  Result:='';
  Corr:=Inizio;
  while Corr <= Fine do
    begin
    Result:=Result + FormatDateTime(Formato,Corr);
    Corr:=Corr + 1;
    end;
end;

function R180ElencoMesi(Inizio,Fine:TDateTime; Formato:String):String;
{Restituisce una stringa contenente il numero del mese solo}
var Corr:TDateTime;
    M:String;
begin
  Result:='';
  Corr:=Inizio;
  M:='';
  while Corr <= Fine do
    begin
    if M <> FormatDateTime('mm',Corr) then
      begin
      Result:=Result + R180DimLung(FormatDateTime('mm',Corr),Length(Formato));
      M:=FormatDateTime('mm',Corr);
      end
    else
      Result:=Result + R180DimLung('',Length(Formato));
    Corr:=Corr + 1;
    end;
end;

function R180NomeMese(Num:Byte):String;
{ Restituisce il nome del mese indicato dal numero
  (1 = gennaio, 2 = febbraio, ...)
}
begin
  Result:='';
  if Num in [1..12] then
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongMonthNames[Num];
end;

function R180NomeMeseAnno(D: TDateTime): String;
// restituisce mese in lettere e anno della data indicati
// es. R180NomeMeseAnno(05/04/2014) = 'Aprile 2014'
begin
  Result:=Format('%s %d',[R180NomeMese(R180Mese(D)),R180Anno(D)]);
end;

function R180NomeGiorno(Anno,Mese,Giorno:Word):String;
begin
  Result:='';
  try
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[DayOfWeek(EncodeDate(Anno,Mese,Giorno))];
  except
    Result:='';
  end;
end;

function R180NomeGiorno(D:TDateTime):String;
begin
  Result:='';
  Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[DayOfWeek(D)];
end;

function R180NomeGiornoSett(GiornoSettimana:Word):String;
//Non si può fare un overload di R180NomeGiorno
//perché non viene fatta distinzione sul parametro in ingresso tra Word e TDateTime,
//con l'effetto collaterale di richiamare sempre la stessa function
begin
  Result:='';
  if (GiornoSettimana >= 1) and (GiornoSettimana <= 6) then
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[GiornoSettimana + 1]
  else if GiornoSettimana = 7 then
    Result:={$IFNDEF VER210}FormatSettings.{$ENDIF}LongDayNames[1];
end;

// -----------------------   G E S T I O N E   F I L E   -----------------------
procedure R180AppendFile(const NomeFile,Testo:String);
{Appende il testo specificato al file NomeFile (usato per i file di log)}
var F:TextFile;
begin
  AssignFile(F,NomeFile);
  if FileExists(NomeFile) then
    Append(F)
  else
    Rewrite(F);
  Writeln(F,Testo);
  CloseFile(F);
end;

procedure R180AppendFileNoCR(const NomeFile,Testo:String);
{Appende il testo specificato al file NomeFile (usato per i file di log)}
var F:TextFile;
begin
  AssignFile(F,NomeFile);
  if FileExists(NomeFile) then
    Append(F)
  else
    Rewrite(F);
  Write(F,Testo);
  CloseFile(F);
end;

function Identificatore(const Nome:String):String;
var I:Integer;
begin
  Result:=Nome;
  i:=1;
  while i <= Length(Result) do
    begin
    if not (Result[i] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) then
      Delete(Result,i,1)
    else
      inc(i);
    end;
end;

function EliminaRitornoACapo(Testo:String):String;
var Pos1:Integer;
begin
  Pos1:=pos(#$D#$A,UpperCase(Testo));
  while Pos1 > 0 do
    begin
    Delete(Testo,Pos1,2);
    Insert(' ',Testo,Pos1);
    Pos1:=pos(#$D#$A,UpperCase(Testo));
    end;
  Result:=Testo;
end;

function CalcolaPasqua(Anno: Integer):TDateTime;
var SAnno,DAnno,VarCal,VarCal1,VarCal2,Anno1,Anno2,Anno3,Anno4,Ope,Ope1,Erre,Erre1: Integer;
    GP,MP: Integer;
begin
  SAnno:=StrToInt(Copy(IntToStr(Anno),1,2));
  DAnno:=StrToInt(Copy(IntToStr(Anno),3,2));
  VarCal:=Trunc(Anno / 19);
  Anno1:=Anno - VarCal * 19;
  VarCal:=Trunc(SAnno / 30);
  Anno2:=SAnno - Varcal * 30;
  VarCal:=Trunc((SAnno - 15) / 25);
  Anno3:=(SAnno - 15) - VarCal * 25;
  VarCal:=Trunc(SAnno / 4);
  VarCal1:=Trunc(Anno3 / 3);
  VarCal2:=Trunc((SAnno - 15) / 25);
  Ope1:=30 + Anno1 * 11 - Anno2 + VarCal + VarCal2 * 8 + VarCal1;
  VarCal:=Trunc(Ope1 / 30);
  Ope:=Ope1 - VarCal * 30;
  if Ope <> 11 then
    begin
    if Ope > 11 then
      begin
      VarCal:=TRUNC(Anno / 19);
      Anno4:=VarCal * 19;
      if (Ope = 12) and (Anno4 > 10) then
        Ope:=13;
      end
    else
      Ope:=Ope + 30;
    end
  else
    Ope:=12;
  VarCal:=Trunc(SAnno / 4);
  Anno4:=SAnno - VarCal * 4;
  VarCal:=Trunc(DAnno / 4);
  Erre1:=DAnno + VarCal + Anno4 * 5 + Ope * 6;
  VarCal:=Trunc(Erre1 / 7);
  Erre:=Erre1 - VarCal * 7;
  GP:=68 - Ope - Erre;
  MP:=3;
  if GP > 31 then
    begin
    GP:=GP - 31;
    MP:=4;
    end;
  Result:=StrToDateTime(IntToStr(GP)+'/'+IntToStr(MP)+'/'+IntToStr(Anno));
end;

function Festivo(Giorno,Mese,Anno: Integer):Boolean;
begin
  Result:=False;
  case Mese of
    1:Result:=(giorno = 1) or (giorno = 6);
    4:Result:=giorno = 25;
    5:Result:=giorno = 1;
    6:Result:=(giorno = 2) and (anno >= 2001);
    8:Result:=giorno = 15;
    11:Result:=giorno = 1;
    12:Result:=(giorno = 8) or (giorno = 25) or (giorno = 26);
  end;
end;

function R180ArrotondaMinuti(Valore,Arrotondamento:Integer):Integer;
{Arrotondamento Valore come routine z892_arrotondaP su Rp502Pro}
var ArrAbs:Integer;
begin
  Result:=Valore;
  if Arrotondamento = 0 then exit;
  ArrAbs:=Abs(Arrotondamento);
  if Valore mod ArrAbs = 0 then exit;
  Result:=(Valore div ArrAbs) * ArrAbs;
  if Arrotondamento < 0 then
    inc(Result,ArrAbs);
end;


// ------------------   G E S T I O N E   P A S S W O R D    -------------------
function R180Decripta(S:String; Key:LongInt):String;
{Usata per decriptare la password dell'utente Oracle MONDOEDP
 I caratteri utilizzati vanno dal codice 32 al 126}
var i,k,OS:Integer;
    SKey:String;
begin
  Result:='';
  SKey:=IntToStr(Key);
  k:=0;
  for i:=1 to Length(S) do
    begin
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=StrToInt(SKey[k]);
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=OS + StrToInt(SKey[k]);
    dec(k);
    if Ord(S[i]) - OS < 32 then
      Result:=Result + Chr(126 - (31 - (Ord(S[i]) - OS)))
    else
      Result:=Result + Chr(Ord(S[i]) - OS);
    end;
end;

function R180Cripta(S:String; Key:LongInt):String;
{Usata per criptare la password dell'utente Oracle MONDOEDP
 I caratteri utilizzati vanno dal codice 32 al 126}
var i,k,OS:Integer;
    SKey:String;
begin
  Result:='';
  SKey:=IntToStr(Key);
  k:=0;
  for i:=1 to Length(S) do
    begin
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=StrToInt(SKey[k]);
    inc(k);
    if k > Length(SKey) then
      k:=1;
    OS:=OS + StrToInt(SKey[k]);
    dec(k);
    if Ord(S[i]) + OS > 126 then
      Result:=Result + Chr(31 + Ord(S[i]) + OS - 126)
    else
      Result:=Result + Chr(Ord(S[i]) + OS);
    end;
end;

function R180CriptaI070(Password:string):string;
{Restituisce la stringa crittografata per la password riferita a I070_UTENTI}
var Criptato:String;
    i:integer;
begin
  if Trim(Password) = '' then
    begin
    result:= '';
    exit;
    end;
  Criptato:='';
  for i:=Length(Password) downto 1 do
  begin
    Criptato:=Criptato+IntToHex(158-Ord(Password[i]),2);
  end;
  Result:=Criptato;
end;

function R180DecriptaI070(Password:string):string;
{Rende leggibile la stringa crittografata per la password riferita a I070_UTENTI}
var Criptato,EsaDec:String;
    i:integer;
begin
  if Trim(Password) = '' then
    begin
    result:= '';
    exit;
    end;
  Criptato:='';
  i:=Length(PassWord);
  while i > 0 do
    begin
    EsaDec:='$'+Copy(Password,i-1,2);
    try
      Criptato:=Criptato+Chr(158-StrToInt(EsaDec));
    except
    end;
    i:=i-2;
    end;
  Result:=Criptato;
end;

function R180DimLungR(S:String; D:Integer):String;
{Aggiungo n spazi in testa ad S in modo da ottenere la lunghezza = D}
var L:Integer;
begin
  if D = 0 then D:=Length(S);
  Result:=Copy(S,1,D);
  L:=Length(Result);
  if D > L then
    Result:=StringOfChar(' ',D - L) + Result;
end;

function R180InserisciColonna(var S:String; const C:String): Boolean;
// Ricerca la stringa C in S
//   S è la query anagrafica restituita da C700
// Se C non esiste viene inserita
var P,P1:Integer;
    CampiSel,SUpper:String;
begin
  Result:=False;
  if C = '' then exit;

  SUpper:=UpperCase(S);
  // ricerca parole chiave "FROM"
  P:=Pos('FROM',SUpper);
  if P = 0 then exit;

  // ricerca parola chiave "SELECT"
  P1:=Pos('SELECT',SUpper);
  if P1 = 0 then exit;

  // se la colonna C non è presente fra i campi selezionati, viene aggiunta
  CampiSel:=UpperCase(Copy(S,P1 + 6,P - 7));
  if R180CercaParolaIntera(C,CampiSel,'.,;') = 0 then
  begin
    Insert(',' + C + ' ',S,P);
    Result:=True;
  end;
end;

function R180InserisciAliasT030(const StrSql: String): String;
// Verifica nella stringa SQL indicata la presenza di campi della T030_ANAGRAFICO
// privi dell'alias "T030" e lo inserisce automaticamente
var
  i, Offset: Integer;
  SearchStr, OldCampo, NewCampo, NewStr: string;
const
  ALIAS_T030: String = 'T030.';
begin
  Result:=StrSql;
  for i:=Low(CampiT030) to High(CampiT030) do
  begin
    SearchStr:=UpperCase(Result);
    OldCampo:=UpperCase(CampiT030[i]);
    NewCampo:=ALIAS_T030 + OldCampo;

    NewStr:=Result;
    Result:='';
    while SearchStr <> '' do
    begin
      Offset:=R180CercaParolaIntera(OldCampo,SearchStr,',()=<>|!/+-*');
      if Offset = 0 then
      begin
        Result:=Result + NewStr;
        Break;
      end;
      Result:=Result + Copy(NewStr, 1, Offset - 1) + NewCampo;
      NewStr:=Copy(NewStr, Offset + Length(OldCampo), MaxInt);
      SearchStr:=Copy(SearchStr, Offset + Length(OldCampo), MaxInt);
    end;
  end;
end;

function R180InConcat(const Parola,Stringa:String):Boolean;
{Restituisce True se Parola esiste in Stringa che contiene valori separati da Virgola}
begin
  Result:=Pos(',' + Parola + ',',',' + Stringa + ',') > 0;
end;

function R180CercaParolaIntera(const Parola,Stringa,CaratteriSeparazione:String):Integer;
// Funzione ricorsiva per cercare Parola dentro Stringa se è limitata da spazi
// o da caratteri contenuti in CaratteriSeparazione
var x,y:Integer;
    S:String;
begin
  Result:=0;
  if Parola = '' then
    exit;
  x:=Pos(Parola,Stringa);
  if x > 0 then
  begin
    // determina porzione da verificare
    if x = 1 then
      S:=Trim(Copy(Stringa,1,Length(Parola) + 1))
    else
      S:=Trim(Copy(Stringa,x - 1,Length(Parola) + 2));
    // verifica carattere precedente
    if Pos(Copy(S,1,1),CaratteriSeparazione) > 0 then
      S:=Copy(S,2,Length(S));
    // verifica carattere successivo
    if Pos(Copy(S,Length(S),1),CaratteriSeparazione) > 0 then
      S:=Copy(S,1,Length(S) -1);
    // determina posizione
    if S = Parola then
      Result:=x
    else
    begin
      // ricerca nella porzione successiva di stringa
      y:=R180CercaParolaIntera(Parola,Copy(Stringa,x + 1,Length(Stringa)),CaratteriSeparazione);
      if y > 0 then
        Result:=x + y;
    end;
  end
end;

function R180NumOccorrenzeCar(S:String; C:Char):Integer;
{ Conta il numero di occorrenze del carattere C nella stringa S }
var i:Integer;
begin
  Result:=0;
  for i:=1 to Length(s) do
    if S[i] = C then
      inc(Result);
end;

// G E S T I O N E   R E G I S T R O   W I N D O W S
procedure R180PutRegistro(Root:HKEY; const Chiave,Dato,Valore:String);
var Registro:TRegistry;
begin
  Registro:=TRegistry.Create;
  try
    Registro.RootKey:=Root;
    if Registro.OpenKey('Software\IrisWIN\' + Chiave,True) then
    begin
      try
        Registro.WriteString(Dato,Valore);
      except
        Registro.CloseKey;
        raise;
      end;
      Registro.CloseKey;
    end;
  finally
    FreeAndNil(Registro);
  end;
end;

function R180GetRegistro(Root:HKEY; const Chiave,Dato,Def:String):String;
var Registro:TRegistry;
begin
  Result:=Def;
  Registro:=TRegistry.Create;
  try
    Registro.RootKey:=Root;
    if Registro.OpenKeyReadOnly('Software\IrisWIN\' + Chiave) then
    begin
      try
        if Registro.ValueExists(Dato) then
          Result:=Registro.ReadString(Dato)
      except
        Registro.CloseKey;
        raise;
      end;
      Registro.CloseKey;
    end;
  finally
    FreeAndNil(Registro);
  end;
end;

function R180ScriviMsgLog(const FileLog,Msg:String):Boolean;
//var sPath:String;
begin
  Result:=TRUE;
  EXIT;
  (*
  Result:=False;
  try
    sPath:=Trim(R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','c:\IrisWIN\Archivi'));
    if sPath = '' then
      exit;
    if Copy(sPath,Length(sPath),1) <> '\' then
      sPath:=sPath + '\';
    if ForceDirectories(sPath) then
    begin
      R180AppendFile(sPath + FileLog,Msg);
      Result:=True;
    end;
  except
  end;
  *)
end;

// G E S T I O N E   V A R I A B I L I   D I   A M B I E N T E
function R180GetEnvVar(const VarName: string): string;
var BufSize: Integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize:=GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    // Read env var value into result string
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
  end
  else
    // No such environment variable
    Result:='';
end;

function R180GetEnvVarValue(const VarName: string): string;
var
  BufSize: Integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    // Read env var value into result string
    SetLength(Result, BufSize - 1);
    GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
  end
  else
    // No such environment variable
    Result := '';
end;

function R180SetEnvVarValue(const VarName, VarValue: string): Integer;
begin
  // Simply call API function
  if SetEnvironmentVariable(PChar(VarName), PChar(VarValue)) then
    Result:=0
  else
    Result:=GetLastError;
end;

procedure R180SetOracleInstantClient;
var Registro:TRegistry;
    PathOIC:String;
  function UsaoIC:Boolean;
  var S:String;
  begin
    Result:=False;
    if not FileExists('B012PAllineamentoClient.ini') then
      exit;
    with TStringList.Create do
    try
      LoadFromFile('B012PAllineamentoClient.ini');
      S:=Values['#PathOIC'];
    finally
      Free;
    end;
    if S <> '' then
    begin
      if DirectoryExists(ExtractFilePath(Application.ExeName) + S) then
      begin
        PathOIC:=ExtractFilePath(Application.ExeName) + S;
        Result:=True;
      end
      else if DirectoryExists(S) then
      begin
        PathOIC:=S;
        Result:=True;
      end
    end;
  end;
begin
  try
    Registro:=TRegistry.Create;
    try
      Registro.RootKey:=HKEY_LOCAL_MACHINE;
      Registro.OpenKeyReadOnly('Software');
      PathOIC:=ExtractFilePath(Application.ExeName) + 'OIC';
      if (not Registro.KeyExists('oracle')) or UsaOIC then
      begin
        R180SetEnvVarValue('TNS_ADMIN',PathOIC);
        R180SetEnvVarValue('LD_LIBRARY_PATH',PathOIC);
        R180SetEnvVarValue('PATH',PathOIC + ';%PATH%');
        //R180SetEnvVarValue('NLS_LANG','AMERICAN_AMERICA.WE8MSWIN1252');
        R180SetEnvVarValue('NLS_LANG','ITALIAN_ITALY.WE8MSWIN1252');
      end;
    finally
      FreeAndNil(Registro);
    end;
  except
  end;
end;

procedure R180OraValidate(S:String);
begin
  if S = '' then
    exit;
  if Length(S) <> 5 then
    raise Exception.Create('Il formato del dato è HH.MM');
  if Pos(' ',S) > 0 then
    raise Exception.Create('Il formato del dato è HH.MM');
  if StrToInt(Copy(S,1,2)) > 23 then
    raise Exception.Create('Le ore devono essere comprese tra 00 e 23');
  if StrToInt(Copy(S,4,2)) > 59 then
    raise Exception.Create('I minuti devono essere compresi tra 00 e 59');
end;

function OreMinutiValidate(Valore: String):Boolean;
// verifica se il campo contiene un valore ore minuti valido
var Posiz,Minuti : Integer;
    SOre, SMin : String;
begin
  Result:=False;
  if Pos(' ',Trim(Valore)) > 1 then
    raise Exception.Create('Dato non valido!');
  Posiz:=Pos('.',Valore);
  if Posiz = 0 then
    Posiz:=Pos(':',Valore);
  if Posiz = 0 then exit;
  SMin:=Trim(Copy(Valore,Posiz + 1,2));
  if Length(SMin)<2 then
    raise Exception.Create('Indicare 2 cifre per i minuti');
  SOre:=Trim(Copy(Valore,1,Posiz-1));
  if Length(SOre)<2 then
    raise Exception.Create('Indicare almeno 2 cifre per le ore');
  Minuti:=StrToInt(SMin);
  if Minuti > 59 then
    raise Exception.Create('I minuti devono essere minori di 60!');
  Result:=True;
end;

procedure R180ClearDBEditDateTime(Sender:TObject);
begin
  if Sender is TDBEdit then
    with TDBEdit(Sender) do
    begin
      if DataSource = nil then exit;
      if DataSource.DataSet = nil then exit;
      if not(DataSource.DataSet.State in [dsEdit,dsInsert]) then exit;
      if DataField = '' then exit;
      if not(Field is TDateTimeField) then exit;
      if (StringReplace(Text,' ','',[rfReplaceAll]) = '//') or (StringReplace(Text,' ','',[rfReplaceAll]) = '/') then
        Field.Clear;
    end;
end;

function R180StrToGiorniOre(Valore,UM:String):Real;
begin
  Result:=0;
  try
    if UM = 'G' then
    begin
      Valore:=StringReplace(Valore,' ','0',[rfReplaceAll]);
      Valore:=StringReplace(Valore,'.',{$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,[rfReplaceAll]);
      Result:=StrToFloat(Valore);
    end
    else if UM = 'O' then
      Result:=R180OreMinutiExt(Valore);
  except
  end;
end;

function R180GiorniOreToStr(Valore:Real; UM:String; Formato:String=''):String;
begin
  Result:='';
  try
    if UM = 'G' then
    begin
      if Formato = '' then
        Result:=FloatToStr(Valore)
      else
        Result:=Format(Formato,[Valore]);
    end
    else if UM = 'O' then
      Result:=R180MinutiOre(Trunc(Valore));
  except
  end;
end;

function R180GetFilePath(S:String):String;
var i:Integer;
begin
  Result:=S;
  for i:=Length(S) downto 1 do
    if S[i] in ['/','\'] then
      begin
      Result:=Copy(S,1,i - 1);
      Break;
      end;
end;

function R180GetFileName(S:String):String;
var i:Integer;
begin
  Result:=S;
  for i:=Length(S) downto 1 do
    if S[i] in ['/','\'] then
      begin
      Result:=Copy(S,i + 1,Length(S));
      Break;
      end;
end;

function R180GetFileSize(const PFileName:String): Int64;
// determina la dimensione del file specificato espressa in byte
{$WARN SYMBOL_PLATFORM OFF}
var
  sr:TSearchRec;
begin
  Result:=-1;
  try
    if FindFirst(PFileName, faAnyFile, sr ) = 0 then
      Result:=Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow);
  finally
    SysUtils.FindClose(sr) ;
  end;
{$WARN SYMBOL_PLATFORM ON}
end;

function R180GetFileSizeStr(const PSizeInBytes: Int64): String;
// converte la dimensione del file espressa in byte in un formato stringa human-readable
const
  SOGLIA_GB = 1073741823; // soglia oltre la quale la dimensione è espressa in Gb
  SOGLIA_MB =    1048575; // soglia oltre la quale la dimensione è espressa in Mb
  SOGLIA_KB =       1023; // soglia oltre la quale la dimensione è espressa in Kb
begin
  if PSizeInBytes > SOGLIA_GB then
    Result:=FormatFloat('#,##0.## GB',(PSizeInBytes / BYTES_GB))
  else if PSizeInBytes > SOGLIA_MB then
    Result:=FormatFloat('#,##0.# MB',(PSizeInBytes / BYTES_MB))
  else if PSizeInBytes > SOGLIA_KB then
    Result:=FormatFloat('#,##0 kB',Trunc(PSizeInBytes / BYTES_KB))
  else
    Result:=FormatFloat('#,##0 bytes',PSizeInBytes);
end;

function R180GetFileSizeStr(const PFileName:String): String;
// determina la dimensione del file specificato e la restituisce in un formato stringa human-readable
begin
  Result:=R180GetFileSizeStr(R180GetFileSize(PFileName));
end;

procedure R180DecodeFileB64(const PStringaB64, PFileName: string);
var
  stream: TBytesStream;
begin
  {$WARN IMPLICIT_STRING_CAST_LOSS OFF}
  stream:=TBytesStream.Create(DecodeBase64(PStringaB64));
  {$WARN IMPLICIT_STRING_CAST_LOSS ON}
  try
    stream.SaveToFile(PFileName);
  finally
    stream.Free;
  end;
end;

function R180GetCampiConcatenati(D:TDataSet; C:TStringList):String;
var i:Integer;
begin
  Result:='';
  for i:=0 to C.Count - 1 do
    try
      Result:=Result + D.FieldByName(C[i]).AsString;
      if i < C.Count - 1 then
        Result:=Result + ' ';
    except
    end;
end;

function R180EstraiNomeTabella(SqlText:String):String;
{funzione che estrae da una frase Sql il nome della prima tabella dopo la
 clausola FROM}
var i,Posiz,Lung:integer;
    Testo:string;
begin
  Posiz:=Pos('FROM',UpperCase(SqlText));
  if Posiz > 0 then
  begin
    i:=Posiz + 4;
    Lung:=Length(SqlText);
    Testo:='';
    while (i <= Lung) and (not(UpCase(SqlText[i]) in ['A'..'Z'])) do
      inc(i);
    while (i <= Lung) and (not(SqlText[i] in [#10,#13,#0,' ',',','"',''''])) do
    begin
      Testo:=Testo + SqlText[i];
      inc(i);
    end;
    Result:=Testo;
  end
  else
    Result:='';
end;

function R180Query2NomeTabella(DS:TDataSet):string;
begin
  Result:='';
  (*if DS is TQuery then
     Result:=R180EstraiNomeTabella((DS as TQuery).SQL.Text)
  else*)
  if DS is TOracleDataSet then
    Result:=R180EstraiNomeTabella((DS as TOracleDataSet).SQL.Text);
end;

function R180Anno(Data:TDateTime):Word;
begin
  Result:=StrToInt(FormatDateTime('yyyy',Data));
end;

function R180Mese(Data:TDateTime):Word;
begin
  Result:=StrToInt(FormatDateTime('mm',Data));
end;

function R180Giorno(Data:TDateTime):Word;
begin
  Result:=StrToInt(FormatDateTime('dd',Data));
end;

function R180SettimanaAnno(Data:TDateTime; IniziaDomenica:Boolean = True):Integer;
begin
  if IniziaDomenica then
    //num settimana cconsiderando Domenica come primo giorno
    Result:=Trunc(R180Arrotonda((Trunc(Data + 7 - DayOfWeek(Data) - EncodeDate(R180Anno(Data),1,1) + 1)/7),1,'E'))
  else
    //num settimana cconsiderando Lunedì come primo giorno
    Result:=Trunc(R180Arrotonda((Trunc(Data + 7 - DayOfWeek(Data - 1) - EncodeDate(R180Anno(Data),1,1) + 1)/7),1,'E'));
end;

function R180Arrotonda(Dato,Valore:Real; Tipo:String): Real;
//Arrotondamento
var Delta:Real;
begin
  if Valore = 0 then
  begin
    Result:=Dato;
    Exit;
  end;
  try
    Result:=Dato / Valore;
  except
    Result:=Dato;
    exit;
  end;
  Delta:=Power(10, -8);
  if Dato < 0 then
    Delta:= -Delta;
  if Abs(Result - Trunc(Result + Delta)) < Power(10, -8) then
    Result:=Round(Result) * Valore
  else
  begin
    if Dato > 0 then
    begin
      //Dato da arrotondare positivo
      if Tipo = 'E' then
        //Eccesso
        Result:=Trunc(Result + 1)
      else if Tipo = 'D' then
        //Difetto
        Result:=Trunc(Result)
      else if Tipo = 'P' then
        //Puro
        Result:=Trunc(Result + 0.5 + Delta)
      else if Tipo = 'P-' then
        //Puro ma per difetto sul .5
        if Result - Trunc(Result) = 0.5 then
          Result:=Trunc(Result)
        else
          Result:=Trunc(Result + 0.5);
    end
    else
    begin
      //Dato da arrotondare negativo
      if Tipo = 'E' then
        //Eccesso
        Result:=Trunc(Result)
      else if Tipo = 'D' then
        //Difetto
        Result:=Trunc(Result - 1)
      else if Tipo = 'P' then
        //Puro
        Result:=Trunc(Result - 0.5 + Delta)
      else if Tipo = 'P-' then
        //Puro ma per difetto sul .5
        if Abs(Result) - Trunc(Abs(Result)) = 0.5 then
          Result:=Trunc(Result)
        else
          Result:=Trunc(Result - 0.5);
    end;
    Result:=Result * Valore;
  end;
end;

function R180AzzeraPrecisione(Dato:Real; NumDec:Integer): Real;
//Azzera il dato se minore della precisione
var Precisione:Real;
begin
  Precisione:=Power(10, -NumDec);
  if Abs(Dato) < Precisione then
    Result:=0
  else
    Result:=Dato;
end;

function R180Formatta(Dato:Real; NumCrt,NumDec:Integer):String;
//Formattazione dato numerico in stringa
var FS:TFormatSettings;
begin
  //Alberto 09/05/2013: forzo il separatore delle migliaia
  FS:=TFormatSettings.Create(LOCALE_SYSTEM_DEFAULT);  //non serve fare il free
  //GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT,FS);
  FS.ThousandSeparator:='.';
  FS.DecimalSeparator:=',';
  Result:=Format('%*.*n',[NumCrt,NumDec,Dato],FS);
end;

function R180CifreDecimali(Dato:Real):Byte;
var P:Byte;
begin
  Result:=0;
  P:=Pos({$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator,FloatToStr(Dato));
  if P > 0 then
    Result:=Length(FloatToStr(Dato)) - P;
end;

function R180FormattaNumero(S,F:String):String;
{M = Separatore di migliaia     (S/N)
 D = Num. cifre per i decimali  (0..x)
 0 = Stampare 0 (S/N)
 SD = ./,
}
var C:Currency;
    i:Integer;
    SD:String;
begin
  if F = '' then
  begin
    Result:=S;
    exit;
  end;
  if S = '' then
    S:='0';
  C:=StrToFloat(S);
  with TStringList.Create do
  try
    CommaText:=UpperCase(F);
    //Decido se stampare il valore Zero o meno
    if (Values['0'] = 'N') and (C = 0) then
    begin
      Result:='';
      exit;
    end;
    //Separatore di migliaia
    if Values['M'] = 'S' then
      F:='n'
    else
      F:='f';
    //Precisione (numero di decimali)
    if Values['D'] <> '' then
      F:='.' + Values['D'] + F;
    Result:=Format('%' + F,[C]);
    SD:=Values['SD'];
    if SD <> '' then
      if SD <> {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator then
      begin
        for i:=1 to Length(Result) do
          if Result[i] = {$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator then
            Result[i]:={$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator
          else if Result[i] = {$IFNDEF VER210}FormatSettings.{$ENDIF}ThousandSeparator then
            Result[i]:={$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator;
      end;
  finally
    Free;
  end;
end;

function R180IsDigit(const PStr: String; PIndex: Integer): Boolean;
// restituisce True se il carattere PIndex-esimo della stringa PStr è una cifra
begin
  Result:=R180IsDigit(R180CarattereDef(PStr,PIndex));
end;

function R180IsDigit(const PChr: Char): Boolean;
// restituisce True se il carattere specificato è una cifra
begin
  Result:=PChr in ['0'..'9'];
end;

{$HINTS OFF} // l'hint sulla variabile "nr" è trascurabile
function R180IsNumeric(S:String):Boolean;
var nr:Real;
    c:Integer;
begin
  S:=Trim(StringReplace(S,',','.',[rfReplaceAll]));
  val(S,nr,c);
  Result:=c = 0;
end;
{$HINTS ON}

function R180IsSpecialChar(const PChr: Char): Boolean;
begin
  Result:=Pos(PChr,SPECIAL_CHAR) > 0;
end;

function R180EliminaZeriASinistra(S:String):String;
{Elimina gli zeri a sinistra di una stringa}
var i:Integer;
begin
  Result:=S;
  for i:=1 to Length(S) - 1 do
    if S[i] <> '0' then
      Break
    else
      Result:=Copy(Result,2,Length(S));
end;

function R180Values(S:String):String;
begin
  Result:='';
  if Pos('=',S) > 0 then
    Result:=Copy(S,Pos('=',S) + 1,Length(S));
end;

function R180NomeFileDatato(NomeFile,Formato:String; Data:TDateTime):String;
var Path,FN:String;
begin
  if Trim(Formato) = '' then
  begin
    Result:=NomeFile;
    exit;
  end;
  Path:=ExtractFilePath(NomeFile);
  FN:=ExtractFileName(NomeFile);
  if pos('.',FN) <> 0 then
    Insert(FormatDateTime(Formato,Data),FN,pos('.',FN))
  else
    FN:=FN + FormatDateTime(Formato,Data);
  Result:=Path + FN;
end;

function R180EstraiNomeFile(S:String):String;
{Estrae il nome del file, dove il percorso è delimitato dai caratteri '/' o '\'}
var i:Integer;
begin
  Result:='';
  for i:=Length(S) downto 1 do
    if S[i] in ['/','\'] then
      Break
    else
      Result:=S[i] + Result;
end;

function R180EstraiExtFile(S:String):String;
{Estrae l'estensione del file, delimitata da '.'}
var i:Integer;
begin
  Result:='';
  for i:=Length(S) downto 1 do
    if S[i] = '.' then
      Break
    else
      Result:=S[i] + Result;
end;

function R180EstraiPercorsoFile(S:String):String;
begin
  Result:=Copy(S,1,Length(S) - Length(R180EstraiNomeFile(S)));
end;

procedure R180InizializzaArray(var Vettore:array of Integer; Valore:Integer = 0); overload;
var i:Integer;
begin
  for i:=0 to High(Vettore) do
    Vettore[i]:=Valore;
end;

procedure R180InizializzaArray(var Vettore:array of Real; Valore:Real = 0); overload;
var i:Integer;
begin
  for i:=0 to High(Vettore) do
    Vettore[i]:=Valore;
end;

function R180SommaArray(Vettore:array of Integer):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=0 to High(Vettore) do
    Result:=Result + Vettore[i];
end;

function R180SommaArray(Vettore:array of Real):Real;
var i:Integer;
begin
  Result:=0;
  for i:=0 to High(Vettore) do
    Result:=Result + Vettore[i];
end;

function R180SyncProcessExec(PathProgramma,DirProgramma,Argomenti:String; ProceduraNotify:T180SyncProcessExecNotifyProcedure):T180SyncProcessExecResults;
var
  saSecurityAttributes:TSecurityAttributes;
  hStdOutReadHandle,hStdOutWriteHandle: THandle;
  hStdErrReadHandle,hStdErrWriteHandle: THandle;
  bStdOutHandleInit,bStdErrHandleInit,bProcessCreated: Boolean;
  siStartupInfo:TStartupInfo;
  piProcessInformation:TProcessInformation;
  sProcCommandLine:String;
  pcDirProgramma:PChar;
  sperSyncProcessExecResults:T180SyncProcessExecResults;

  function ReadFromPipe(hReadHandle:THandle):String;
  var
    cByteDisponibili, cByteLetti:Cardinal;
    aBuffer:array[0..4096] of AnsiChar;
    sResult:String; //=UnicodeString, compatibile con AnsiChar
  begin
    sResult:='';
    // Verifico che sul pipe siano presenti dei dati
    PeekNamedPipe(hReadHandle,nil,0,nil,@cByteDisponibili,nil);
    while (cByteDisponibili > 0) do
    begin
      FillChar(aBuffer,SizeOf(aBuffer),0); //Svuoto il buffer (in teoria si potrebbe evitare grazie a #0);
      ReadFile(hReadHandle,aBuffer,4096,cByteLetti,nil); // Leggo fino a 4096 byte
      aBuffer[cByteLetti]:=#0; // Terminatore di stringa. aBuffer è lungo 4097 caratteri, non si rischia overflow.
      sResult:=sResult + String(aBuffer);
      PeekNamedPipe(hReadHandle,nil,0,nil,@cByteDisponibili,nil);
    end;
    Result:=sResult;
  end;

begin
  if Trim(PathProgramma) = '' then
    raise Exception.Create('Percorso del file da eseguire vuoto!');
  (*
  if Trim(DirProgramma) = '' then
    raise Exception.Create('Directory di esecuzione vuota!');
  *)

  sProcCommandLine:=PathProgramma;
  if Trim(Argomenti) = '' then
    sProcCommandLine:=PathProgramma
  else
    sProcCommandLine:=PathProgramma + ' ' + Argomenti;

  if DirProgramma = '' then
    pcDirProgramma:=nil
  else
    pcDirProgramma:=PChar(WideString(DirProgramma));
  bStdOutHandleInit:=false;
  bStdErrHandleInit:=false;;
  bProcessCreated:=false;
  try
    try
      saSecurityAttributes.nLength:=SizeOf(TSecurityAttributes);
      saSecurityAttributes.lpSecurityDescriptor:=nil;
      saSecurityAttributes.bInheritHandle:=true;

      // Creazione pipe per redirezione stdout e stderr
      if not CreatePipe(hStdOutReadHandle, hStdOutWriteHandle, @saSecurityAttributes, 0)then
        raise Exception.Create('Creazione pipe per STDOUT fallita:' + CRLF + SysErrorMessage(GetLastError));
      bStdOutHandleInit:=true;

      if not CreatePipe(hStdErrReadHandle, hStdErrWriteHandle, @saSecurityAttributes, 0) then
        raise Exception.Create('Creazione pipe per STDERR fallita:' + CRLF + SysErrorMessage(GetLastError));
      bStdErrHandleInit:=true;

      FillChar(siStartupInfo,SizeOf(siStartupInfo),0);  //Svuoto il record _STARTUPINFOW
      siStartupInfo.cb:=SizeOf(TStartupInfo);  // cb deve contenere la dimensione del record
      siStartupInfo.hStdInput:=GetStdHandle(STD_INPUT_HANDLE); // handle di default per stdin
      siStartupInfo.hStdOutput:=hStdOutWriteHandle;  // il processo dovrà scrivere su hStdOutWriteHandle anzichè su stdout
      siStartupInfo.hStdError:=hStdErrWriteHandle;   // stessa cosa per stderr
      siStartupInfo.dwFlags:=STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW;
      siStartupInfo.wShowWindow:=SW_HIDE;

      FillChar(piProcessInformation,SizeOf(TProcessInformation),0); // Probabilmente non serve

      FillChar(sperSyncProcessExecResults,SizeOf(T180SyncProcessExecResults),0);

      if CreateProcess(nil, // lpApplicationName
        PChar(WideString(sProcCommandLine)), // lpCommandLine
        @saSecurityAttributes, // lpProcessAttributes
        @saSecurityAttributes, // lpThreadAttributes
        true, // bInheritHandles
        NORMAL_PRIORITY_CLASS, // dwCreationFlags
        nil, // lpEnvironment
        pcDirProgramma, // lpCurrentDirectory
        //PChar(WideString(DirProgramma)), // lpCurrentDirectory
        siStartupInfo, // lpStartupInfo
        piProcessInformation)  // lpProcessInformation
        then
      begin
        bProcessCreated:=true;
        (* Resta in attesa al massimo 50 ms per verificare se il processo è terminato.
           Ritorna valori > 0 (WAIT_ABANDONED, WAIT_TIMEOUT o WAIT_FAILED) se il processo è
           ancora attivo o 0 (WAIT_OBJECT_0) se il processo è terminato. *)
        while WaitForSingleObject(piProcessInformation.hProcess, 50) > 0 do
          begin
            sperSyncProcessExecResults.DatiStdOut:=sperSyncProcessExecResults.DatiStdOut +
              ReadFromPipe(hStdOutReadHandle);
            sperSyncProcessExecResults.DatiStdErr:=sperSyncProcessExecResults.DatiStdErr +
              ReadFromPipe(hStdErrReadHandle);
            if @ProceduraNotify <> nil then
              ProceduraNotify(sperSyncProcessExecResults);
            Application.ProcessMessages;
          end;
          // Leggo i pipe per leggere gli eventuali dati residui.
          sperSyncProcessExecResults.DatiStdOut:=sperSyncProcessExecResults.DatiStdOut +
            ReadFromPipe(hStdOutReadHandle);
          sperSyncProcessExecResults.DatiStdErr:=sperSyncProcessExecResults.DatiStdErr +
            ReadFromPipe(hStdErrReadHandle);
          if @ProceduraNotify <> nil then // Per fornire al chiamante eventuali dati dell'ultimo minuto
            ProceduraNotify(sperSyncProcessExecResults);
          Application.ProcessMessages;
          // Leggo il codice di ritorno
          GetExitCodeProcess(piProcessInformation.hProcess,sperSyncProcessExecResults.CodiceUscita);
      end
      else
        raise Exception.Create('Errore durante la creazione del processo:'  + CRLF + SysErrorMessage(GetLastError));
    except
      on E:Exception do
      begin
        raise Exception.Create('R180SyncProcessExec(): ' + E.Message);
      end;
    end;
  finally
    // Libero le risorse allocate.
    // Devo assicurarmi che CreatePipe() sia stato eseguito, o CloseHandle() andrà in errore.
    if bStdOutHandleInit then
    begin
      CloseHandle(hStdOutReadHandle);
      CloseHandle(hStdOutWriteHandle);
    end;
    if bStdErrHandleInit then
    begin
      CloseHandle(hStdErrReadHandle);
      CloseHandle(hStdErrWriteHandle);
    end;
    // Stessa cosa per gli handle del processo e del thread, solo se CreateProcess li ha valorizzati
    if bProcessCreated then
    begin
      CloseHandle(piProcessInformation.hProcess);
      CloseHandle(piProcessInformation.hThread);
    end;
  end;
  Result:=sperSyncProcessExecResults;
end;

function R180SysDate(Sessione:TOracleSession):TDateTime;
begin
  with TOracleQuery.Create(nil) do
  try
    Session:=Sessione;
    SQL.Add('SELECT SYSDATE FROM DUAL');
    Execute;
    Result:=FieldAsDate(0);
  finally
    Free;
  end;
end;

function R180AttivaHintSQL(SQL:String; VersioneOracle:Integer):String;
{Attiva/disattiva gli hint delle query in base alla versione del db}
var i:Integer;
begin
  Result:=SQL;
  if VersioneOracle = 0 then
    exit;
  for i:=1 to 99 do
  begin
    if VersioneOracle < i then
      SQL:=StringReplace(SQL,'/*NOHINT' + IntToStr(i) + ' ','/*+ ',[rfReplaceAll,rfIgnoreCase])
    else
      SQL:=StringReplace(SQL,'/*SIHINT' + IntToStr(i) + ' ','/*+ ',[rfReplaceAll,rfIgnoreCase]);
  end;
  Result:=SQL;
end;

function R180NumeroInLettere(Sessione:TOracleSession; Numero:Real):String;
begin
  Result:='';
  with TOracleQuery.Create(nil) do
  try
    Session:=Sessione;
    SQL.Add('SELECT NUMERO_IN_LETTERE(:NUMERO) FROM DUAL');
    DeclareVariable('NUMERO',otFloat);
    SetVariable('NUMERO',Numero);
    try
      Execute;
      Result:=FieldAsString(0);
    except
    end;
  finally
    Free;
  end;
end;

function R180LunghezzaCampo(F:TField):Integer;
begin
  if F is TStringField then
    Result:=F.Size
  else
    Result:=F.DisplayWidth;
  if F.Index < F.DataSet.FieldCount - 1 then
    inc(Result);
end;

procedure R180DBGridCopyToClipboard(DBGrid:TDBGrid; CopyToExcel:Boolean; RigheSelezionate:Boolean = True; Intestazione:Boolean = True; NoACapo:Boolean = False);
var S:String;
    i,j:Integer;
begin
  with DbGrid.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;

    // determina l'indice dell'ultimo campo visibile
    for j:=FieldCount - 1 downto 0 do
    begin
      if Fields[j].Visible then
        Break;
    end;

    First;
    try
      // esporta campi di intestazione
      if Intestazione then
      begin
        if not Eof then
        begin
          for i:=0 to FieldCount - 1 do
          begin
            if Fields[i].Visible then
            begin
              if CopyToExcel then
              begin
                // accoda carattere di tabulazione (separatore di colonna excel)
                // eccetto per l'ultimo campo visibile
                S:=S + Fields[i].FieldName + IfThen(i < j,TAB);
              end
              else
              begin
                if i < j then
                  S:=S + Format('%-*s',[R180Lunghezzacampo(Fields[i]),Copy(Fields[i].FieldName,1,R180Lunghezzacampo(Fields[i]))])
                else
                  S:=S + Format('%-s',[Fields[i].FieldName]);
              end;
            end;
          end;

          // accoda caratteri di ritorno a capo
          if (Not NoACapo) or CopyToExcel then
            S:=S + CRLF;
        end;
      end;

      // esporta righe dati
      while not EOF do
      begin
        if DbGrid.SelectedRows.CurrentRowSelected or (not RigheSelezionate) then
        begin
          for i:=0 to FieldCount - 1 do
          begin
            if Fields[i].Visible then
            begin
              if CopyToExcel then
              begin
                // accoda carattere di tabulazione (separatore di colonna excel)
                // eccetto per l'ultimo campo visibile
                //Alberto 06/02/2017: se il campo contiene dei ritorni a capo, viene racchiuso tra virgolette in modo che su excel non vaa a capo su un'altra riga
                S:=S + IfThen(Pos(CRLF,Fields[i].AsString) > 0,'"') +
                       Fields[i].AsString +
                       IfThen(Pos(CRLF,Fields[i].AsString) > 0,'"') +
                       IfThen(i < j,TAB);
              end
              else
              begin
                if i < j then
                  S:=S + Format('%-*s',[R180Lunghezzacampo(Fields[i]),Copy(Fields[i].AsString,1,R180Lunghezzacampo(Fields[i]))])
                else
                  S:=S + Format('%-s',[Fields[i].AsString]);
              end;
            end;
          end;

          // accoda caratteri di ritorno a capo
          if (Not NoACapo) or CopyToExcel then
            S:=S + CRLF;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;

  // copia il testo negli appunti di windows
  Clipboard.AsText:=S;
end;

procedure R180StringGridCopyToClipboard(StringGrid:TStringGrid);
var S:String;
    i,j:Integer;
begin
  S:='';
  Clipboard.Clear;
  Screen.Cursor:=crHourGlass;
  try
    for i:=0 to StringGrid.RowCount - 1 do
    begin
      for j:=0 to StringGrid.ColCount - 1 do
        S:=S + StringGrid.Cells[j,i] + #9;
      S:=S + #13#10;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
  Clipboard.AsText:=S;
end;

function R180IncollaTestoDaClipboard(Testo:String;InizioSelezione,LunghezzaSelezione:Integer):String;
var TestoSalvato:String;
begin
  TestoSalvato:=Testo;
  try
    Result:=Copy(Testo,1,InizioSelezione) + Clipboard.AsText + Copy(Testo,InizioSelezione + 1 + LunghezzaSelezione);
  except
    Result:=TestoSalvato;
  end;
end;

procedure R180DBGridSelezionaRighe(DBGrid:TDBGrid; Modo:Char);
var BM:TBookMark;
begin
  {$IFNDEF VER185}
    SetLength(BM,0);
  {$ENDIF}
  with DbGrid.DataSource.DataSet do
  begin
    if not Active then
      exit;
    if Modo = 'N' then
    begin
      DbGrid.SelectedRows.Clear;
      exit;
    end;
    DisableControls;
    First;
    try
      while not EOF do
      begin
        case Modo of
          'S':DbGrid.SelectedRows.CurrentRowSelected:=True;
          'C':DbGrid.SelectedRows.CurrentRowSelected:=not DbGrid.SelectedRows.CurrentRowSelected;
        end;
        if (DbGrid.SelectedRows.CurrentRowSelected) and
           ({$IFNDEF VER185}(Length(BM) = 0) or {$ENDIF} (not DbGrid.DataSource.DataSet.BookMarkValid(BM))) then
          BM:=DbGrid.DataSource.DataSet.GetBookmark;
        Next;
      end;
    finally
      if {$IFNDEF VER185}(Length(BM) > 0) and {$ENDIF} DbGrid.DataSource.DataSet.BookMarkValid(BM) then
      begin
        DbGrid.DataSource.DataSet.GotoBookmark(BM);
        DbGrid.DataSource.DataSet.FreeBookmark(BM);
      end;
      EnableControls;
    end;
  end;
end;

function R180GetColonnaDBGrid(DBGrid:TDBGrid; Campo:String):Integer;
var
  i:Integer;
begin
  Result:=-1;
  Campo:=UpperCase(Campo); // ottimizzazione confronto
  for i:=0 to DBGrid.Columns.Count - 1 do
  begin
    if UpperCase(DBGrid.Columns[i].FieldName) = Campo then
    begin
      Result:=i;
      Break;
    end;
  end;
end;

function R180FormatiCodificati(Dato,Formato:String;Lung:integer=0):String;
begin
  Result:=Trim(Dato);
  Formato:=UpperCase(Trim(Formato));
  if Formato = 'D10' then  //Data di 10 inps
  begin
    if Result = '' then
      Result:='          '
    else if Result <> '*' then
      try
        Result:=FormatDateTime('yyyy-mm-dd',StrToDate(Dato));
      except
      end;
  end
  else if Formato = 'D7' then //Data di 7 inps
  begin
    if Result = '' then
      Result:='       '
    else if Length(Result) = 10 then    // Arriva 'DD/MM/AAAA'
    begin
      try
        Result:=FormatDateTime('yyyy-mm',StrToDate(Dato));
      except
      end;
    end
    else if Length(Result) = 7 then       //Arriva 'MM/AAAA'
    begin
      try
        Result:=FormatDateTime('yyyy-mm',StrToDate('01/' + Dato));
      except
      end;
    end
    else if Length(Result) = 6 then       //Arriva 'MMAAAA'
    begin
      try
        Result:=FormatDateTime('yyyy-mm',StrToDate('01/' + Copy(Dato,1,2) + '/' + Copy(Dato,3,4)));
      except
      end;
    end;
  end
  else if Formato = 'DTA' then //Data di 8 fluper
  begin
    if Result = '' then
      Result:='        '
    else
      Result:=FormatDateTime('YYYYMMDD',StrToDate(Dato));
  end
  else if Formato = 'DTB' then //Data di 6 fluper
  begin
    if Result = '' then
      Result:='      '
    else
      Result:=FormatDateTime('YYYYMM',StrToDate(Dato));
  end
  else if Formato = 'AN' then //Alfanumerico fluper
  begin
    Result:=Format('%-' + IntToStr(Lung) + '.' + IntToStr(Lung)+'s',[Dato]);
  end
  else if Formato = 'CF' then //Codice fiscale fluper
  begin
    Result:=Format('%-16.16s',[Dato]);
  end
  else if Formato = 'NU' then //Numerico intero positivo e negativo fluper
  begin
    //Gestisco il valore negativo...
    if StrToInt(Dato) < 0 then
      if Lung>1 then
        Lung:=Lung-1;
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Dato)]);
  end
  else if Formato = 'NP' then //Numerico intero positivo fluper
  begin
    if StrToInt(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Dato)]);
  end
  else if Formato = 'VP' then //Numerico positivo con 2 decimali fluper
  begin
    if StrToFloat(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + IntToStr(Lung) + '.2f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Formato = 'VN' then //Numerico positivo e negativo con 2 decimali fluper
  begin
    //Gestisco il valore negativo...
    if StrToFloat(Dato) < 0 then
      if Lung>1 then
        Lung:=Lung-1;
    Result:=Format('%' + IntToStr(Lung) + '.2f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Formato = 'VP1' then //Numerico positivo con 1 decimale fluper
  begin
    if StrToFloat(Dato) < 0 then
      Dato:='0';
    Result:=Format('%' + IntToStr(Lung) + '.1f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Formato = 'VN1' then //Numerico positivo e negativo con 1 decimale fluper
  begin
    //Gestisco il valore negativo...
    if StrToFloat(Dato) < 0 then
      if Lung>1 then
        Lung:=Lung-1;
    Result:=Format('%' + IntToStr(Lung) + '.1f',[StrToFloat(Dato)]);
    Result:=StringReplace(Result,',','',[RfReplaceAll]);
    Result:=StringReplace(Result,'.','',[RfReplaceAll]);
    Result:=Format('%' + IntToStr(Lung) + '.' + IntToStr(Lung) + 'd',[StrToInt(Result)]);
  end
  else if Copy(Formato,1,1) = 'L' then //inps
  begin
    if Lung=0 then
      Lung:=StrToIntDef(Copy(Formato,2,Length(Formato)),Length(Result));
    Result:=Copy(Result,1,Lung);
  end;
end;

procedure R180AbilitaOggetti(C:TWinControl; Abilitato:Boolean);
var i:Integer;
begin
  for i:=0 to C.ControlCount - 1 do
  begin
    if C.Controls[i] is TWinControl then
      (C.Controls[i] as TWinControl).Enabled:=Abilitato
    else if C.Controls[i] is TGraphicControl then
      (C.Controls[i] as TGraphicControl).Enabled:=Abilitato;
  end;
end;

function R180Sha1Encrypt(const PStr: String): String;
// funzione per cifrare una stringa con l'algoritmo sha-1
// importante: utilizza librerie open source per effettuare la cifratura
var
  Hash: TDCP_hash;
  HashDigest: array of byte;
  i, read: integer;
  buffer: array[0..16383] of byte;
  strmInput: TStringStream;
begin
  Result:='';

  Hash:=TDCP_sha1.Create(nil);
  try
    try
      // inizializza l'oggetto hash
      Hash.Init;

      // crea stream di appoggio per impostazione dati da cifrare
      strmInput:=TStringStream.Create(PStr);
      read:=strmInput.Read(buffer,Sizeof(buffer));

      Hash.Update(buffer,read);

      // distrugge lo stream di appoggio
      FreeAndNil(strmInput);

      // garantisce che l'hashsize sia 160 bit
      if Hash.HashSize <> 160 then
        raise Exception.Create(Format('Errore nella crittografia sha-1: hashsize = %d',[Hash.HashSize]));

      // il digest è un array 0 based con 20 elementi (uno per ogni byte)
      SetLength(HashDigest,Hash.HashSize div 8);

      // salva il risultato nell'hashdigest (array di 20 byte)
      Hash.Final(HashDigest[0]);

      // ricompone la stringa sha1 concatenando i caratteri esadecimali
      for i:=0 to Length(HashDigest) - 1 do
        Result:=Result + IntToHex(HashDigest[i],2);
    except
      on E: Exception do
        raise Exception.Create(Format('Errore nella crittografia sha-1: %s (%s)',[E.Message,E.ClassName]));
    end;
  finally
    FreeAndNil(Hash);
  end;
end;

function R180SetVariable(ODS:TOracleDataset; Variabile:String; Valore:Variant):Boolean;
begin
  Result:=False;
  if ODS.GetVariable(Variabile) <> Valore then
  begin
    Result:=True;
    ODS.SetVariable(Variabile,Valore);
    ODS.Close;
  end;
end;

procedure R180SetReadBuffer(ODS:TOracleDataset);
begin
  ODS.ReadBuffer:=min(max(ODS.CountQueryHits,5),9999) + 1;
end;

function R180CloseDataSetTag0(DS: TDataset; const DistruggiFields: Boolean = False): Boolean;
// Decrementa il tag del dataset e quindi lo chiude se il tag è <= 0
// Questo sistema è utilizzato in Irisweb per evitare la chiusura dei
// dataset condivisi su W001DtM
begin
  Exit;//Alberto 07/06/2013 - annullata la chiusura del dataset

  Result:=False;
  DS.Tag:=DS.Tag - 1;
  if DS.Tag <= 0 then
  begin
    // 1. distruzione campi persistenti
    if DistruggiFields then
    begin
      while (DS.FieldCount <> 0) do
        try DS.Fields[0].Free; except end;
    end;

    // 2. chiusura dataset
    try
      if DS is TOracleDataset then
        TOracleDataset(DS).CloseAll
      else
        DS.Close;
      DS.Tag:=0;
      Result:=True;
    except
    end;
  end;
end;

function R180GetStringList(DataSet:TDataSet; Colonne:String):String;
var i,lung:Integer;
    S:String;
begin
  Result:='';
  with DataSet do
  try
    DisableControls;
    First;
    while not Eof do
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
        if R180CercaParolaIntera(Fields[i].FieldName,Colonne,',') > 0 then
        begin
          lung:=Fields[i].Size;
          if lung = 0 then
            lung:=Fields[i].DisplayWidth;
          if lung > 0 then
            S:=S + IfThen(S <> '',' ') + Format('%-*s',[lung,Fields[i].AsString]);
        end;
      if S <> '' then
        Result:=Result + S + CRLF;
      Next;
    end;
  finally
    EnableCOntrols;
  end;
  Result:=Trim(Result);
end;

(*
function R180In(const Valore,lstValori:Variant):Boolean;
var i,i0,i1:Integer;
begin
  if not VarIsArray(lstValori) then
    Result:=Valore = lstValori
  else
  begin
    Result:=False;
    i0:=VarArrayLowBound(lstValori,1);
    i1:=VarArrayHighBound(lstValori,1);
    for i:=i0 to i1 do
      if Valore = lstValori[i] then
      begin
        Result:=True;
        Break;
      end;
  end;
end;
*)

function R180In(const Valore:String; lstValori:array of String):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
end;

function R180In(const Valore:Integer; lstValori:array of Integer):Boolean;
var i:Integer;
begin
  Result:=False;
  for i:=Low(lstValori) to High(lstValori) do
    if Valore = lstValori[i] then
    begin
      Result:=True;
      Break;
    end;
end;

(*
function R180Between(const Valore,Da,A:Variant):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;
*)

function R180Between(const Valore,Da,A:String):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

function R180Between(const Valore,Da,A:Integer):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

function R180Between(const Valore,Da,A:TDateTime):Boolean;
begin
  Result:=(Valore >= Da) and (Valore <= A);
end;

function R180Indenta(const PTesto: String; const PIndentazione: Integer): String;
// indenta il testo contenuto in PTesto di PIndentazione caratteri
// es.
//   PTesto = 'alfa'#13#10'beta'#13#10'gamma'
//   R180Indenta(PTesto,2) = '  alfa'#13#10'  beta'#13#10'  gamma'
//
var
  L: TStringList;
  Indentazione: String;
  i: Integer;
begin
  Result:='';
  if PTesto = '' then
    Exit;

  // spazi di indentazione
  Indentazione:=StringOfChar(' ',PIndentazione);

  // utilizza una stringlist di appoggio perché consente una migliore gestione
  // dei ritorni a capo di una semplice replace di CRLF
  // es. a volte nel codice i ritorni a capo
  L:=TStringList.Create;
  try
    L.Text:=PTesto;
    for i:=0 to L.Count - 1 do
      L[i]:=Indentazione + L[i];
    Result:=L.Text;
  finally
    FreeAndNil(L);
  end;
end;

(* Non utilizzare al momento: sono dei prototipi non funzionanti
function R180Decode(const Valore: Variant; KeyValueArr: array of const): Variant;
{ Emula la funzione Decode di Oracle.
    Esempio di utilizzo:
    [definizione variabili]
    var Variabile: Variant;
    var Matricola: String;
    [utilizzo funzione]
    Risultato:=R180Decode(Matricola, ['1', 500,
                                      '2', 600,
                                      '3', 700,
                                      '4', 800,
                                      1000] )
    // Matricola = '3' -> Risultato = 700
    // Matricola = '9' -> Risultato = 1000
}
var
  i, Lim, NumElem: Integer;
  function VarRecValue(Key: TVarRec): Variant;
  begin
    case Key.VType of
      vtInteger:    Result:=Key.VInteger;
      vtBoolean:    Result:=Key.VBoolean;
      vtChar:       Result:=Key.VChar;
      vtExtended:   Result:=Key.VExtended^;
      vtString:     Result:=Key.VString^;
      vtPChar:      Result:=String(Key.VPChar);
      vtObject:     Result:=Key.VObject.ClassName;
      vtClass:      Result:=Key.VClass.ClassName;
      vtAnsiString: Result:=String(Key.VAnsiString);
      vtCurrency:   Result:=Key.VCurrency^;
      vtVariant:    Result:=Key.VVariant^;
      vtInt64:      Result:=Key.VInt64^;
    else
      Result:=null;
    end;
  end;
begin
  // inizializza variabili di supporto
  NumElem:=Length(KeyValueArr);

  // determina il valore di default
  if NumElem mod 2 = 0 then
  begin
    // no valore di default
    Lim:=NumElem - 1;
    Result:=null
  end
  else
  begin
    // è indicato il valore di default
    Lim:=NumElem - 2;
    Result:=VarRecValue(KeyValueArr[NumElem - 1]);
  end;

  // ciclo di decodifica
  i:=0;
  while i <= Lim do
  begin
    if Valore = VarRecValue(KeyValueArr[i]) then
    begin
      Result:=VarRecValue(KeyValueArr[i + 1]);
      Exit;
    end;
    i:=i + 2;
  end;
end;

function R180DecodeStr(const Valore: Variant; KeyValueArr: array of const): String;
{ Emula la funzione Decode di Oracle, con la limitazione di tipo
  sul valore restituito.
    Esempio di utilizzo:
    [definizione variabili]
    var Altezza: Variant;
    var Risultato: String;
    [utilizzo funzione]
    Risultato:=R180DecodeStr(Variabile, [10, 'Basso',
                                         20, 'Medio',
                                         30, 'Alto',
                                         'Fuori misura',
                                      1000] )
    // Altezza = 10 -> Risultato = 'Basso'
    // Altezza = 45 -> Risultato = 'Fuori misura'
}
begin
  Result:=VarToStr(R180Decode(Valore,KeyValueArr));
end;
*)

// G E S T I O N E   S T R I N G
function R180Capitalize(const PTesto: String): String;
// Restituisce la stringa data con l'iniziale maiuscola
begin
  Result:=UpperCase(Copy(PTesto,1,1)) +
          LowerCase(Copy(PTesto,2,Length(PTesto) - 1));
end;

function R180SplittaArray(Const InStringa, Separatore:String):TArrString;
{Data una stringa ed un delimitatore, restituisce un TArrString
 (array of String, dichiarato all'interno della C180) i cui elementi
 sono rappresentati dai singoli token delimitati.
 Esempi:
  Input1  -> Value = 'aaa|bbb|ccc', Delimiter = '|'
  Output1 -> Lista[0] = 'aaa', Lista[1] = 'bbb', Lista[2] = 'ccc'
 ATTENZIONE!
 Il delimitatore dev'essere di 1 singolo caratttere}
var i:integer;
begin
  SetLength(Result,1);
  for i:=1 to Length(InStringa) do
    if Trim(InStringa[i]) <> Separatore then
      Result[High(Result)]:=Result[High(Result)] + InStringa[i]
    else
      SetLength(Result,Length(Result) + 1);
end;

procedure R180Tokenize(const Lista: TStrings; const Value: String; const Delimiter: String = ',');
{ Data una stringa ed un delimitatore, restituisce una stringlist i cui elementi
  sono rappresentati dai singoli token delimitati.
  Rappresenta un'alternativa all'uso di commatext, in quanto più flessibile.
  Il delimitatore è di tipo string e può contenere più caratteri.
  Esempi:
    Input1  -> Value = 'aaa|bbb|ccc', Delimiter = '|'
    Output1 -> Lista[0] = 'aaa', Lista[1] = 'bbb', Lista[2] = 'ccc'
    Input2  -> Value = 'aaa+++ddd+++eee', Delimiter = '+++'
    Output2 -> Lista[0] = 'aaa', Lista[1] = 'ddd', Lista[2] = 'eee'
  Nota: la gestione della StringList (creazione/distruzione) è delegata all'utilizzatore }
var
  Dx,Delta: integer;
  Testo,Token: string;
begin
  if Lista = nil then
    raise Exception.Create('Lista non inizializzata!');
  if Value = '' then
  begin
    // valore vuoto: la stringlist viene pulita
    Lista.Clear;
    Exit;
  end;
  if Delimiter = '' then
  begin
    // delimitatore vuoto: la stringlist viene caricata con un solo elemento
    Lista.Clear;
    Lista.Add(Value);
    Exit;
  end;

  Delta:=Length(Delimiter);
  Testo:=Value + Delimiter;
  Lista.BeginUpdate;
  Lista.Clear;
  // ciclo di estrazione dei token
  try
    while Length(Testo) > 0 do
    begin
      Dx:=Pos(Delimiter, Testo);
      Token:=Copy(Testo,0,Dx - 1);
      Lista.Add(Token);
      Testo:=Copy(Testo,Dx + Delta,MaxInt);
    end;
  finally
    Lista.EndUpdate;
  end;
end;

procedure R180SplitLines(Lista: TStrings; BreakSet: TSysCharSet = [' ',',']; MaxCol: Integer = 2000);
{ Suddivide le righe dell'oggetto TStrings indicato, mandando a capo
  il testo di ogni riga al numero di caratteri specificato in MaxCol;
  una riga potrà quindi essere divisa in 2 o più.
  Il BreakSet rappresenta il set di caratteri considerati separatori di parole,
  ovvero dove la riga può essere troncata in modo sicuro.
  es. per codice SQL si consiglia di mantenere il default: spazio e virgola.
  Attenzione!! La funzione modifica l'oggetto TStrings indicato, suddividendo
  ogni riga "lunga" in più righe (aggiungendo quindi elementi alla lista).

  Es.
    // input
    SQLCreato.Count = 2
    SQLCreato[0] = 'select A, B, C from T1'
    SQLCreato[1] = 'where B in (10,20,30,40,50) order by A'

    // richiamo la funzione con limite a 15 caratteri
    BreakSet:=[' ',','];
    R180SplitLines(SQLCreato,BreakSet,15);

    // output
    SQLCreato.Count = 5
    SQLCreato[0] = 'select A, B, C'
    SQLCreato[1] = 'from T1'
    SQLCreato[2] = 'where B in (10,'
    SQLCreato[3] = '20,30,40,50)
    SQLCreato[4] = 'order by A'
  }
var
  RigheList: TStringList;
  TempStr: String;
  i,j: Integer;
begin
  if Lista = nil then
    Exit;

  if Lista.Count = 0 then
    Exit;

  // creazione stringlist di appoggio
  RigheList:=TStringList.Create();
  try
    i:=0;
    while i < Lista.Count do
    begin
      if Length(Lista[i]) > MaxCol then
      begin
        // wrap del testo a 2000 caratteri
        TempStr:=WrapText(Lista[i],#13#10,BreakSet,MaxCol);

        // tokenize della riga splittata
        R180Tokenize(RigheList,TempStr,#13#10);

        // reimposta la stringlist originale
        Lista[i]:=RigheList[0];
        for j:=1 to RigheList.Count - 1 do
          Lista.Insert(i+j,RigheList[j]);

        i:=i + RigheList.Count - 1;
      end;
      i:=i + 1;
    end;
  finally
    FreeAndNil(RigheList);
  end;
end;

// G E S T I O N E   C A R T E L L E
function R180GetOSTempDir: String;
// restituisce la directory temp di windows
var
  LTempFolder: array[0..MAX_PATH] of Char;
begin
  try
    GetTempPath(MAX_PATH,@LTempFolder);
    {$WARN IMPLICIT_STRING_CAST OFF}
    Result:=AnsiString(LTempFolder);
    {$WARN IMPLICIT_STRING_CAST ON}
  except
    on E: Exception do
      raise Exception.Create(Format('Errore durante l''estrazione della directory temp del sistema: %s',[E.Message]));
  end;
end;

procedure R180RemoveDir(const DirName: string);
{ Elimina una directory e TUTTO il suo contenuto senza chiedere conferma
  Questa procedura utilizza chiamate ricorsive per attraversare le strutture
  delle directory, per cui vengono utilizzati i puntatori per mantenere
  minimo l'utilizzo dello stack.
}
{$WARN SYMBOL_PLATFORM OFF}
var
  SearchRec: ^TSearchRec;
  FileName: PString;
  NumFile: Integer;
begin
  if Trim(DirName) = '' then
    Exit;

  // disabilita input/output checking
  {$I-}

  // alloca un nuovo record (TSearchRec) e una nuova string (FileName)
  New(SearchRec);
  New(FileName);

  try
    NumFile:=SysUtils.FindFirst(DirName + '\*.*', SysUtils.faAnyFile, SearchRec^);

    while (NumFile = 0) do
    begin
      with SearchRec^ do
      begin
        FileName^:=DirName + '\' + Name;

        // verifica se il file corrente è in realtà una directory
        if ((Attr and SysUtils.faDirectory) = 0) then
        begin
          // il file non è una directory: verifica che non sia un file di sistema o un volume ID (C:) }
          if ((Attr and SysUtils.faSysFile) = 0) then
          begin
            // rimuove l'attributo readonly, se il file è indicato come tale
            if ((Attr and SysUtils.faReadOnly) <> 0) then
              FileSetAttr(FileName^,FileGetAttr(FileName^) and (not SysUtils.faReadOnly));

            // cancella file
            SysUtils.DeleteFile(FileName^);
          end;
        end
        else if ((Name <> '.') and (Name <> '..')) then
        begin
          // si tratta di una directory -> chiamata ricorsiva
          R180RemoveDir(FileName^);
        end;
      end;
      NumFile:=SysUtils.FindNext(SearchRec^);
    end;

    SysUtils.FindClose(SearchRec^);
    RmDir(DirName);
  finally
    // rilascia la memoria allocata per le strutture
    Dispose(FileName);
    Dispose(SearchRec);
  end;

  // riabilita input/output checking
  {$I+}
{$WARN SYMBOL_PLATFORM ON}
end;

function R180IsDirectoryWritable(const PDirName: String): Boolean;
// restituisce
// - True  se la directory indicata esiste ed è accessibile in scrittura
// - False altrimenti
var
  FileName: String;
  H: THandle;
begin
  Result:=False;

  // se la directory non esiste restituisce False
  if not TDirectory.Exists(PDirName) then
    Exit;

  // imposta un file temporaneo per verificare scrittura in directory
  FileName:=IncludeTrailingPathDelimiter(PDirName) + 'chk.tmp';

  // creazione file temporaneo
  H:=CreateFile(PChar(FileName),GENERIC_READ or GENERIC_WRITE,0,nil,CREATE_NEW,FILE_ATTRIBUTE_TEMPORARY or FILE_FLAG_DELETE_ON_CLOSE,0);
  Result:=H <> INVALID_HANDLE_VALUE;

  // chiude handle ed elimina contestualmente il file
  if Result then
    CloseHandle(H);
end;

// A L T R E   F U N Z I O N I
function R180GetIPFromHost(var HostName, IPaddr, WSAErr: String): Boolean;
type
  Name = array[0..100] of AnsiChar;
  PName = ^Name;
var
  HEnt: pHostEnt;
  HName: PName;
  WSAData: TWSAData;
  i: Integer;
begin
  Result:=False;
  if WSAStartup($0101, WSAData) <> 0 then
  begin
    WSAErr:='Winsock is not responding."';
    Exit;
  end;
  IPaddr:='';
  New(HName);
  if GetHostName(HName^, SizeOf(Name)) = 0 then
  begin
    //HostName:=StrPas(HName^);
    HostName:=AnsiString(HName^);
    HEnt:=GetHostByName(HName^);
    for i:=0 to HEnt^.h_length - 1 do
      IPaddr:=Concat(IPaddr,IntToStr(Ord(HEnt^.h_addr_list^[i])) + '.');
    SetLength(IPaddr, Length(IPaddr) - 1);
    Result:=True;
  end
  else
  begin
    case WSAGetLastError of
      WSANOTINITIALISED: WSAErr:='WSANotInitialised';
      WSAENETDOWN      : WSAErr:='WSAENetDown';
      WSAEINPROGRESS   : WSAErr:='WSAEInProgress';
    end;
  end;
  Dispose(HName);
  WSACleanup;
end;

function R180CalcoloCodiceFiscale(Cognome,Nome,Sesso,CodCat:String; DataNas:TDateTime):String;
{Routine di calcolo del codice fiscale}
type
  TPari = Array [1..36] of Byte;
  TDispari = Array [1..36] of Byte;
const
  Vocali = 'AEIOU';
  Consonanti = 'BCDFGHJKLMNPQRSTVWXYZ';
  Controllo = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Mesi = 'ABCDEHLMPRST';
  Pari:TPari = ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
                18, 19, 20, 21, 22, 23, 24, 25, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
  Dispari:TDispari = ( 1, 0, 5, 7, 9, 13, 15, 17, 19, 21, 2, 4, 18, 20, 11, 3, 6, 8,
                      12, 14, 16, 10, 22, 25, 24, 23, 1, 0, 5, 7, 9, 13, 15, 17, 19, 21);
var
  cod_fisc, tmp, c_contr:string;
  tmp_voc:array [1..2] of char; // contiene le prime due vocali
  tmp_cons:array [1..4] of char; // contiene le prime 4 consonanti
  Valido:boolean;
  n_voc, n_cons,k,A,M,G:Word;
function Calc_Chk(Cod_Fisc:string):string;
// calcola il carattere di controllo del codice fiscale
// ritorna 'errore' se trovato carattere non consentito
var tmp, k, posiz:Word;
begin
  if Length(Trim(Cod_Fisc)) < 15 then
    begin
    Result:='errore';
    exit;
    end;
  tmp:=0;
  k:=1;
  //Valori dei caratteri dispari
  repeat
    posiz:=Pos(Copy(Cod_Fisc, k, 1),Controllo);
    if Posiz  > 0 then
      tmp:=tmp + Dispari[posiz];
    k:=k + 2;
  until k > 15;
  k:=2;
  repeat
    posiz:=Pos(Copy(Cod_Fisc, k, 1),Controllo);
    tmp:=tmp + Pari[posiz];
    k:=k + 2;
  until k > 14;
  tmp:=(tmp mod 26) + 1;
  Result:=Copy(Controllo, tmp, 1);
end;
begin
  //FUNCTION calc_cf( cognome, nome, sesso, d_nasc, cod_cat )
  // calcola il codice fiscale noti i dati di partenza
  SetLength(Tmp,1);
  Tmp_Voc[1]:=#0;
  Tmp_Voc[2]:=#0;
  Tmp_Cons[1]:=#0;
  Tmp_Cons[2]:=#0;
  Tmp_Cons[3]:=#0;
  Tmp_Cons[4]:=#0;
  Result:='';//ECodFiscale.Field.AsString;
  if (Trim(Cognome) = '') or (Trim(Nome) = '') or (DataNas = 0) or (Trim(CodCat) = '') then
    exit;
  // calcola le lettere del cognome
  Cognome:=UpperCase(Trim(Cognome ));
  n_voc:=0;
  n_cons:=0;
  for k:=1 to Length(Cognome) do
    begin
    tmp:=Copy(Cognome, k, 1);
    if (Pos(Tmp,Vocali) > 0) and (n_voc < 2) then
      begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=Tmp[1];
      end;
    if (Pos(Tmp,Consonanti) > 0) and (n_cons < 4) then
      begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=Tmp[1];
      end;
    if (n_cons = 4) and (n_voc = 2) then
      Break;
    end;
  // ora conosco le prime vocali e consonanti
  Valido:=True;
  case n_cons of
    3,4:cod_fisc:=tmp_cons[1] + tmp_cons[2] + tmp_cons[3];
    2:if n_voc >= 1 then
        cod_fisc:=tmp_cons[1] + tmp_cons[2] + tmp_voc[1]
      else
        Valido:=False;
    1:if n_voc >= 2 then
        cod_fisc:=tmp_cons[1] + tmp_voc[1] + tmp_voc[2]
      else
        if n_voc = 1 then
          cod_fisc:=tmp_cons[1] + tmp_voc[1] + 'X'
        else
          Valido:=False;
    0:if n_voc = 2 then
        cod_fisc:=tmp_voc[1] + tmp_voc[2] + 'X'
      else
        Valido:=False;
    else
      Valido:=False;
  end;
  if not Valido then
    exit;
  // calcola le lettere del nome
  Nome:=UpperCase(Trim(Nome));
  n_voc:=0;
  n_cons:=0;
  for k:=1 to Length(Nome) do
    begin
    tmp:=Copy(Nome, k, 1);
    if (Pos(Tmp,Vocali) > 0) and (n_voc < 2) then
      begin
      Inc(n_voc);
      Tmp_Voc[n_voc]:=Tmp[1];
      end;
    if (Pos(Tmp,Consonanti) > 0) and (n_cons < 4) then
      begin
      Inc(n_cons);
      Tmp_Cons[n_cons]:=Tmp[1];
      end;
    if (n_cons = 4) and (n_voc = 2) then
      Break;
    end;
  // ora conosco le prime vocali e consonanti
  case n_cons of
    4:cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[3] + tmp_cons[4];
    3:cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[2] + tmp_cons[3];
    2:if n_voc >= 1 then
        cod_fisc:=cod_fisc + tmp_cons[1] + tmp_cons[2] + tmp_voc[1]
      else
        Valido:=False;
    1:if n_voc >= 2 then
        cod_fisc:=cod_fisc + tmp_cons[1] + tmp_voc[1] + tmp_voc[2]
      else
        if n_voc = 1 then
          cod_fisc:=cod_fisc + tmp_cons[1] + tmp_voc[1] + 'X'
        else
          Valido:=False;
    0:if n_voc = 2 then
        cod_fisc:=cod_fisc + tmp_voc[1] + tmp_voc[2] + 'X'
      else
        Valido:=False;
    else
      Valido:=False;
  end;
  if not Valido then
    exit;
  // calcola la parte relativa alla data di nascita
  DecodeDate(DataNas,A,M,G);
  Cod_Fisc:=Cod_Fisc + Copy(IntToStr(A),3,2);
  Cod_Fisc:=Cod_Fisc + Mesi[M];
  if Sesso = 'F' then
    G:=G + 40;
  if G < 10 then
    tmp:='0' + IntToStr(G)
  else
    tmp:=IntTostr(G);
  Cod_Fisc:=Cod_Fisc + tmp;
  // aggiunge codice catastale
  Cod_Fisc:= Cod_Fisc + CodCat;
  // trasforma eventuali spazi in zeri
  // Clipper - do zerpad with cod_fisc
  // calcola il carattere di controllo
  c_contr:=calc_chk(Cod_Fisc);
  if c_contr = 'errore' then
   exit
  else
    begin
    Cod_Fisc:=Cod_Fisc + c_contr;
    Result:=Cod_Fisc;
    end;
end;

function R180SostituisciCaratteriSpeciali(Testo:String):String;
begin
  //Tabella caratteri ascii: http://cloford.com/resources/charcodes/symbols.htm
  //Primi 32 caratteri: http://www.robelle.com/smugbook/ascii.html
  Result:=Testo;
  Result:=StringReplace(Result,#145,#39,[rfReplaceAll]);// ‘ -> '
  Result:=StringReplace(Result,#146,#39,[rfReplaceAll]);// ’ -> '
  Result:=StringReplace(Result,#147,#34,[rfReplaceAll]);// “ -> "
  Result:=StringReplace(Result,#148,#34,[rfReplaceAll]);// ” -> "
  Result:=StringReplace(Result,#9,#32#32,[rfReplaceAll]);// TAB -> 2 spazi
end;

function R180ValueToItem(MyArray:array of TItemsValues;Value:string):string;
{Data un array of TItemsValues e il Value restituisce il corrispettivo item}
var
  i:integer;
begin
  Result:='';
  i:=Low(MyArray);
  while (i <= High(MyArray)) and (MyArray[i].Value <> Value) do
    inc(i);
  Result:=MyArray[i].Item;
end;

procedure R180SetComboItemsValues(lst:TStrings; ItemsValues:array of TItemsValues; TipoLista:String);
{TipoLista: I=Item, V=Value}
var i,c:Integer;
    S:String;
begin
  lst.Clear;
  for i:=0 to High(ItemsValues) do
  begin
    S:='';
    for c:=1 to Length(TipoLista) do
    begin
      if c > 1 then
        S:=S + '=';
      if TipoLista[c] = 'I' then
        S:=S + ItemsValues[i].Item
      else if TipoLista[c] = 'V' then
        S:=S + ItemsValues[i].Value;
    end;
    lst.Add(S);
  end;
end;

//XE3
procedure R180DBGridSetDrawingStyle(Sender:TComponent);
var i:Integer;
begin
  for i:=0 to Sender.ComponentCount - 1 do
    if Sender.Components[i] is TDBGrid then
      TDBGrid(Sender.Components[i]).DrawingStyle:=gdsClassic;
end;

function R180GetCsvIntersect(const PElenco1, PElenco2: String): String;
// questa function calcola l'intersezione insiemistica di due liste di valori
// separati da virgola e la restituisce come stringa di valori separati da virgola
// parametri:
//   PElenco1:
//     la prima stringa di valori separati da virgola
//   PElenco2:
//     la seconda stringa di valori separati da virgola
// restituisce:
//   una stringa contenente l'elenco dei valori facenti parte dell'intersezione separati da virgola
// esempio di utilizzo:
//   PElenco1 = 'Fonzie,Pippo,Paperino,Pluto'
//   PElenco2 = 'Paperino,Pippo,Gargamella';
//   R180GetCsvIntersect(PElenco1,PElenco2) = 'Paperino,Pippo'
var
  LElenco1,LElenco2: String;
  L1, L2, LIntersect: TStringList;
begin
  // inizializza variabili
  Result:='';
  L1:=nil;
  L2:=nil;
  LIntersect:=nil;

  // trim della stringa con l'elenco 1
  // rimuove eventuale virgola finale nella stringa
  LElenco1:=Trim(PElenco1);
  if RightStr(LElenco1,1) = ',' then
    LElenco1:=LeftStr(LElenco1,Length(LElenco1) - 1);

  // trim della stringa con l'elenco 2
  // rimuove eventuale virgola finale nella stringa
  LElenco2:=Trim(PElenco2);
  if RightStr(LElenco2,1) = ',' then
    LElenco2:=LeftStr(LElenco2,Length(LElenco2) - 1);

  // esce subito se una delle due liste è vuota
  if (LElenco1 = '') or (LElenco2 = '') then
    Exit;

  // se le liste sono uguali restituisce subito la lista stessa
  if LElenco1 = LElenco2 then
  begin
    Result:=LElenco1;
    Exit;
  end;

  // determina l'intersezione utilizzando delle stringlist di appoggio
  try
    try
      // crea stringlist di appoggio
      L1:=TStringList.Create;
      L2:=TStringList.Create;
      LIntersect:=TStringList.Create;

      L1.CommaText:=LElenco1;
      L2.CommaText:=LElenco2;

      // determina stringlist con intersezione
      R180StringListIntersect(L1,L2,LIntersect);

      Result:=LIntersect.CommaText;
    except
    end;
  finally
    FreeAndNil(L1);
    FreeAndNil(L2);
    FreeAndNil(LIntersect);
  end;
end;

procedure R180StringListIntersect(PList1, PList2: TStringList; var RListIntersect: TStringList);
// questa procedure determina l'intersezione insiemistica di due stringlist e
// la carica in una stringlist di destinazione
// parametri:
//   PList1:
//     la prima stringlist
//   PList2:
//     la seconda stringlist
// parametri restituiti
//   RListIntersect:
//     la stringlist calcolata come intersezione fra le due stringlist di input
var
  L: TStringList;
  i: Integer;
begin
  // controlla i parametri
  if not Assigned(PList1) then
    raise Exception.Create('StringList di input #1 nulla');
  if not Assigned(PList2) then
    raise Exception.Create('StringList di input #2 nulla');
  if not Assigned(RListIntersect) then
    raise Exception.Create('StringList di destinazione nulla');

  // pulisce stringlist di destinazione
  RListIntersect.Clear;

  // esce subito se una delle due liste è vuota
  if (PList1.Count = 0) or (PList2.Count = 0) then
    Exit;

  // l'IndexOf deve distinguere tra maiuscole e minuscole
  PList1.CaseSensitive:=True;
  PList2.CaseSensitive:=True;

  // crea una nuova stringlist di appoggio
  L:=TStringList.Create;
  try
    // tratta la stringlist come fosse un insieme
    L.CaseSensitive:=True;
    L.Duplicates:=dupIgnore;
    L.Sorted:=True;
    L.AddStrings(PList1);

    // rimuove gli elementi della lista 2 non presenti nella lista 1
    for i:=L.Count - 1 downto 0 do
    begin
      if PList2.IndexOf(L[i]) = -1 then
        L.Delete(i);
    end;

    // assegna gli elementi della stringlist risultante nella variabile del risultato
    RListIntersect.AddStrings(L);
  finally
    FreeAndNil(L);
  end;
end;

procedure R180JsonString2Comp(Sender: TComponent; JsonPair: TJSONPair);
begin
  if Sender is TTabControl then
    (Sender as TTabControl).TabIndex:=StrToInt(jsonPair.JSONValue.Value)
  else if Sender is TCheckBox then
    (Sender as TCheckBox).Checked:=jsonPair.JSONValue.Value = 'S'
  else if Sender is TEdit then
    (Sender as TEdit).Text:=jsonPair.JSONValue.Value
  else if Sender is TMaskEdit then
    (Sender as TMaskEdit).Text:=jsonPair.JSONValue.Value
  else if Sender is TSpinEdit then
    (Sender as TSpinEdit).Text:=jsonPair.JSONValue.Value
  else if Sender is TComboBox then
    (Sender as TComboBox).Text:=jsonPair.JSONValue.Value
  else if Sender is TDBLookupComboBox then
    (Sender as TDBLookupComboBox).KeyValue:=jsonPair.JSONValue.Value
  else if Sender is TRadioGroup then
    (Sender as TRadioGroup).ItemIndex:=StrToInt(jsonPair.JSONValue.Value)
  else if Sender is TMemo then
    (Sender as TMemo).Text:=jsonPair.JSONValue.Value
  else
    raise Exception.Create('Errore durante la lettura del JSON, classe '+Sender.ClassName+' non gestita.');
end;

procedure R180ToolBarHandleNeeded(Sender: TWinControl);
var i:Integer;
begin
  for i:=0 to Sender.ControlCount - 1 do
    if Sender.Controls[i] is TToolbar then
      (Sender.Controls[i] as TToolbar).HandleNeeded
    else if Sender.Controls[i] is TWinControl then
      R180ToolBarHandleNeeded(Sender.Controls[i] as TWinControl);
end;

function R180NumOccorrenzeString(const Substring, Text: string): integer;
var
  offset: integer;
begin
  result:=0;
  offset:=PosEx(Substring, Text, 1);
  while offset <> 0 do
  begin
    inc(result);
    offset:=PosEx(Substring, Text, offset + length(Substring));
  end;
end;

// Verifica se l'utente corrente è membro del gruppo degli amministratori.
function R180WinApiIsUserAnAdmin():BOOL; external 'shell32.dll' name 'IsUserAnAdmin';

// Utilizza i tipi di Delphi
function R180IsUserAnAdmin():Boolean;
begin
  Result:=R180WinApiIsUserAnAdmin;
end;

{ Copia il file di help indicato nella directory temporanea di Windows (In XP+ è quella dell'utente).
  Necessario perchè le nuove versioni del visualizzatore dell'help di Windows non aprono file
  che non risiedono sulla macchina locale.
  Ritorna il percorso del nuovo file di help o '' se la copia fallisce. }
function R180PreparaFileHelpTemp(NomeFileHelp:String): String;
var
  OriginaleCHMPath,TempCHMDir,TempCHMPath:String;
begin
  Result:='';
  OriginaleCHMPath:=IncludeTrailingPathDelimiter(GetCurrentDir) + 'Help\' + NomeFileHelp;
  // Verifichiamo che il file di help originale esista
  if FileExists(OriginaleCHMPath) then
  begin
    // Ricaviamo il path del CHM temporaneo
    TempCHMDir:=IncludeTrailingPathDelimiter(TPath.GetTempPath) + 'IrisWin';
    if not DirectoryExists(TempCHMDir) then
    begin
      if not ForceDirectories(TempCHMDir) then
      begin
        // Creazione della directory temporanea fallita. Non dovrebbe mai accadere.
        Exit;
      end;
    end;
    TempCHMPath:=TempCHMDir + '\' + NomeFileHelp;
    // Tento di copiare il file nella directory temporanea dell'utente, sovrascrivendolo se già esiste
    try
      TFile.Copy(OriginaleCHMPath,TempCHMPath,True);
      Result:=TempCHMPath; // Copia riuscita
    except
      on E:EInOutError do
      begin
        // Copia fallita, probabilmente esiste già un file in temp ed è in lock.
        // E' lo stesso che vogliamo copiare?
        if FileExists(TempCHMPath) and (TFile.GetLastWriteTimeUtc(OriginaleCHMPath) = TFile.GetLastWriteTimeUtc(TempCHMPath)) then
          Result:=TempCHMPath; // Potenzialmente sì.
      end;
    end;
  end;
end;

procedure R180OracleObjectSource(const PObjName: String; POracleSession: TOracleSession; var RResultList: TStringList);
var
  LOQ: TOracleQuery;
begin
  if PObjName.Trim = '' then
    raise Exception.Create('L''oggetto oracle di cui visualizzare il sorgente non è stato indicato!');

  if RResultList = nil then
    raise Exception.Create('Non è stata indicata la stringlist per contenere il risultato!');

  RResultList.Clear;

  LOQ:=TOracleQuery.Create(nil);
  try
    LOQ.Session:=POracleSession;
    LOQ.ReadBuffer:=500;
    LOQ.SQL.Add('select V.TEXT ');
    LOQ.SQL.Add('from   USER_SOURCE V ');
    LOQ.SQL.Add('where  V.NAME = :NAME ');
    LOQ.SQL.Add('order by V.LINE ');
    LOQ.DeclareAndSet('NAME',otString,PObjName);
    LOQ.Execute;
    while not LOQ.Eof do
    begin
      RResultList.Add(LOQ.FieldAsString('TEXT').Replace(#13#10,'',[rfReplaceAll]));
      LOQ.Next;
    end;
  finally
    FreeAndNil(LOQ);
  end;
end;

end.


