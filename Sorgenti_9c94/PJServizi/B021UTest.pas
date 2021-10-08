unit B021UTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, ExtCtrls, IdIOHandlerStream, DBXJSON,
  {$IF CompilerVersion >= 31}System.JSON,{$ENDIF} ComCtrls, Spin,
  SyncObjs, IdZLibCompressorBase, IdCompressorZLib, StrUtils,
  C180FunzioniGenerali, Clipbrd, B021UUtils, A000UCostanti,
  Generics.Collections, Generics.Defaults;

type
  TParametriMetodo = record
    Get: String;
    Post: String;
    Put: String;
    Delete: String;
  end;

  TMetodo = class
  private
    FName: String;
    FParametri: TParametriMetodo;
    FPostData: String;
    FAutenticazione: Boolean;
  public
    constructor Create(PName: String; PParametri: TParametriMetodo; PPostData: String; PAutenticazione: Boolean);
    property Name: String read FName write FName;
    property Parametri: TParametriMetodo read FParametri write FParametri;
    property PostData: String read FPostData write FPostData;
    property Autenticazione: Boolean read FAutenticazione write FAutenticazione;
  end;

  TMetodoList = class(TObjectList<TMetodo>)
  public
    constructor Create();
    procedure Sort; reintroduce;
  end;

  // classe di thread per elaborazioni contemporanee
  TThreadElab = class(TThread)
  private
    IdHTTPThread: TIdHTTP;
    IdSSLIOHandlerThread: TIdSSLIOHandlerSocketOpenSSL;
    IdCompressorThread: TIdCompressorZLib;
  protected
    procedure Execute; override;
    function EseguiPost(PFormat, PRequest: String): String;
    procedure ParseGiustificativi(const AString: String);
  public
    Metodo,UrlThread,Res,jsonData: String;
  end;

  TB021FTest = class(TForm)
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    grpInfo: TGroupBox;
    lblInfoDatabase: TLabel;
    lblInfoPathLog: TLabel;
    lblInfoAzienda: TLabel;
    edtInfoDatabase: TEdit;
    edtInfoUtente: TEdit;
    edtInfoPathLog: TEdit;
    edtInfoAzienda: TEdit;
    grpEsecuzione: TGroupBox;
    Label9: TLabel;
    btnEsegui: TButton;
    SpinEdit1: TSpinEdit;
    ProgressBar1: TProgressBar;
    grpParametri: TGroupBox;
    lblServerURL: TLabel;
    lblMetodoURL: TLabel;
    lblParJson: TLabel;
    cmbServerURL: TComboBox;
    edtMethodUrl: TEdit;
    edtParametri: TEdit;
    TabSheet2: TTabSheet;
    memOutputSvc: TMemo;
    Panel2: TPanel;
    btnSaveFile: TButton;
    lblTempo: TLabel;
    lblInfoUtenteI070: TLabel;
    chkLog: TCheckBox;
    btnCopia: TButton;
    TabSheet3: TTabSheet;
    memLog: TMemo;
    Panel1: TPanel;
    btnCancLog: TButton;
    lblConta: TLabel;
    Timer1: TTimer;
    Label4: TLabel;
    Label5: TLabel;
    lblPostData: TLabel;
    memPostData: TMemo;
    IdCompressorZLib1: TIdCompressorZLib;
    btnPulisciPostData: TButton;
    chkFiddler: TCheckBox;
    btnCopiaURL: TButton;
    grpMetodo: TGroupBox;
    cmbMetodo: TComboBox;
    cmbMetodoHtml: TComboBox;
    btnSalvaRegistro: TButton;
    btnAnnullaRegistro: TButton;
    lblQueryString: TLabel;
    edtQueryString: TEdit;
    chkTokenAutenticazione: TCheckBox;
    edtPassphrase: TEdit;
    lblPassphrase: TLabel;
    procedure btnEseguiClick(Sender: TObject);
    procedure btnSaveFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCopiaClick(Sender: TObject);
    procedure btnCancLogClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpinEdit1Enter(Sender: TObject);
    procedure edtMethodUrlKeyPress(Sender: TObject; var Key: Char);
    procedure edtParametriKeyPress(Sender: TObject; var Key: Char);
    procedure SpinEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure btnPulisciPostDataClick(Sender: TObject);
    procedure cmbServerURLChange(Sender: TObject);
    procedure btnCopiaURLClick(Sender: TObject);
    procedure cmbMetodoChange(Sender: TObject);
    procedure cmbMetodoHtmlChange(Sender: TObject);
    procedure btnSalvaRegistroClick(Sender: TObject);
    procedure edtInfoDatabaseChange(Sender: TObject);
    procedure chkLogClick(Sender: TObject);
    procedure btnAnnullaRegistroClick(Sender: TObject);
  private
    Inizio: TDateTime;
    PathLog,FileLogCompleto,FUrl,FMetodo,Res,FJsonData: String;
    MetodoList: TObjectList<TMetodo>;
    function GetParametriMetodo(PGet, PPost, PPut, PDelete: String): TParametriMetodo;
    function EseguiPost(PFormat, PRequest: String): String;
    procedure Execute;
    procedure CaricaMetodi;
    procedure ImpostaMetodoServer;
    procedure ImpostaVisibilitaPostData;
    procedure LeggiInfoRegistro;
    procedure SalvaInfoRegistro;
    function GetURLCompleto: String;
  public
  end;

var
  B021FTest: TB021FTest;
//  CSGui: TMedpCriticalSection;

const
  CHIAVE_REG_B021        = 'B021';

  DEFAULT_DB             = '*';
  DEFAULT_AZIENDA        = '*';
  DEFAULT_UTENTE         = '*';
  DEFAULT_MATRICOLA_TEST = '001703';

  ITEM_METODO_GET        = 0;
  ITEM_METODO_POST       = 1;
  ITEM_METODO_PUT        = 2;
  ITEM_METODO_DELETE     = 3;

implementation

{$R *.dfm}

procedure TB021FTest.FormCreate(Sender: TObject);
begin
//  CSGui:=TMedpCriticalSection.Create;
  LeggiInfoRegistro;
  btnSalvaRegistro.Enabled:=False;
  btnAnnullaRegistro.Enabled:=False;

  PathLog:=edtInfoPathLog.Text;
  PathLog:=PathLog + IfThen(PathLog.EndsWith('\'),'','\');
  FileLogCompleto:=PathLog + FILE_LOG;

  MetodoList:=TObjectList<TMetodo>.Create(True);
  CaricaMetodi;

  // imposta il metodo html Get di default
  cmbMetodoHtml.ItemIndex:=ITEM_METODO_GET;
  cmbMetodoHtmlChange(nil);
end;

procedure TB021FTest.CaricaMetodi;
var
  LMetodo: TMetodo;
  LDataRif: String;
  LUtente: String;
  LPassword: String;
  LPostData: String;
begin
  // echostring (metodo di test)
  LPostData:='{                             '#13#10 +
             '  "stringa":"valore_di_prova" '#13#10 +
             '}                             ';
  MetodoList.Add(
    TMetodo.Create(
      'EchoString',
      GetParametriMetodo('valore_di_prova',
                         'chiave',
                         'chiave',
                         'valore_di_prova'),
      LPostData,
      False
    )
  );

  // giustificativi
  LPostData:=Format('{                             '#13#10 +
                    '   "matricola":"%s",          '#13#10 +
                    '   "causale":"40101",         '#13#10 +
                    '   "dataInizio":"21-11-2012", '#13#10 +
                    '   "dataFine":"23-11-2012",   '#13#10 +
                    '   "dalle": "",               '#13#10 +
                    '   "alle": "",                '#13#10 +
                    '   "dataFamiliare": ""        '#13#10 +
                    '}                             ',
                    [DEFAULT_MATRICOLA_TEST]);
  MetodoList.Add(
    TMetodo.Create(
      'Giustificativi',
      GetParametriMetodo(Format('%s/01-05-2012/31-05-2012',[DEFAULT_MATRICOLA_TEST]),
                         '',
                         '',
                         Format('%s/FERIE/27-02-2012/29-02-2012',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // anagrafiche
  LPostData:=Format('{                                          '#13#10 +
             '  "anagrafiche": [                                '#13#10 +
             '    {                                             '#13#10 +
             '      "id": "%s",                                 '#13#10 +
             '      "surname": "DOTTI",                         '#13#10 +
             '      "name": "SILVANA",                          '#13#10 +
             '      "birthdate": "13-03-1953",                  '#13#10 +
             '      "fiscalCode": "DTTSVN53C53C933R",           '#13#10 +
             '      "sex": "F",                                 '#13#10 +
             '      "phone": "",                                '#13#10 +
             '      "history": [                                '#13#10 +
             '        {                                         '#13#10 +
             '          "field": "startEmploymentContract",     '#13#10 +
             '          "value": "",                            '#13#10 +
             '          "from": "24-01-1994",                   '#13#10 +
             '          "to": "23-05-1995"                      '#13#10 +
             '        },                                        '#13#10 +
             '        {                                         '#13#10 +
             '          "field": "partTime",                    '#13#10 +
             '          "value": "100",                         '#13#10 +
             '          "from": "24-01-1994",                   '#13#10 +
             '          "to": "31-12-3999"                      '#13#10 +
             '        }                                         '#13#10 +
             '      ]                                           '#13#10 +
             '    }                                             '#13#10 +
             '  ]                                               '#13#10 +
             '}                                                 ',
             [DEFAULT_MATRICOLA_TEST]);
  MetodoList.Add(
    TMetodo.Create(
      'Anagrafiche',
      GetParametriMetodo(Format('%s',[DEFAULT_MATRICOLA_TEST]),
                         '',
                         '',
                         Format('%s',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // conteggi R502
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'R502Conteggi',
      GetParametriMetodo(Format('%s/08-02-2012',[DEFAULT_MATRICOLA_TEST]),
                                '',
                                '',
                                Format('%s/29-02-2012',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // assenze R600
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'R600GetAssenze',
      GetParametriMetodo(Format('%s/23-05-2012/40101',[DEFAULT_MATRICOLA_TEST]),
                         '',
                                '',
                         Format('%s/29-02-2012/1_001',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // dizionarioassenze
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'DizionarioAssenze',
      GetParametriMetodo(Format('%s',[DEFAULT_MATRICOLA_TEST]),
                                '',
                                '',
                                Format('%s',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // turni
  LPostData:='{                                                         '#13#10 +
             '  "start": "02-07-2012",                                  '#13#10 +
             '  "end": "09-07-2012",                                    '#13#10 +
             '  "shifts": [                                             '#13#10 +
             '    {                                                     '#13#10 +
             '      "id": "CD001",                                      '#13#10 +
             '      "name": "CASA",                                     '#13#10 +
             '      "surname": "DANILO",                                '#13#10 +
             '      "employeeShifts": [                                 '#13#10 +
             '        {                                                 '#13#10 +
             '          "day": "02-07-2012",                            '#13#10 +
             '          "shiftName": "3TURNI",                          '#13#10 +
             '          "shiftStart": "02-07-2012 22:00",               '#13#10 +
             '          "shiftEnd": "03-07-2012 06:00",                 '#13#10 +
             '          "expectedShiftStart": "02-07-2012 22:00",       '#13#10 +
             '          "expectedShiftEnd": "03-07-2012 06:00",         '#13#10 +
             '          "shiftBreakStart": "02-07-2012 22:00",          '#13#10 +
             '          "shiftBreakEnd": "03-07-2012 06:00",            '#13#10 +
             '          "section": "SEZIONE PROVA",                     '#13#10 +
             '          "skill": "SKILL PROVA",                         '#13#10 +
             '          "publicHoliday": false,                         '#13#10 +
             '          "note": "NOTE PER DANILO CASA 2 LUGLIO",        '#13#10 +
             '          "dailyShiftChanges": []                         '#13#10 +
             '        }                                                 '#13#10 +
             '      ]                                                   '#13#10 +
             '    },                                                    '#13#10 +
             '    {                                                     '#13#10 +
             '      "id": "CD003",                                      '#13#10 +
             '      "name": "CASA",                                     '#13#10 +
             '      "surname": "GIANCARLO",                             '#13#10 +
             '      "employeeShifts": [                                 '#13#10 +
             '        {                                                 '#13#10 +
             '          "day": "04-07-2012",                            '#13#10 +
             '          "shiftName": "3TURNI",                          '#13#10 +
             '          "shiftStart": "04-07-2012 14:00",               '#13#10 +
             '          "shiftEnd": "04-07-2012 22:00",                 '#13#10 +
             '          "expectedShiftStart": "04-07-2012 14:00",       '#13#10 +
             '          "expectedShiftEnd": "04-07-2012 22:00",         '#13#10 +
             '          "shiftBreakStart": "04-07-2012 14:00",          '#13#10 +
             '          "shiftBreakEnd": "04-07-2012 22:00",            '#13#10 +
             '          "section": "SEZIONE GIANCARLO",                 '#13#10 +
             '          "skill": "SKILL_GIANCARLO",                     '#13#10 +
             '          "publicHoliday": false,                         '#13#10 +
             '          "note": "NOTE PER CASA GIANCARLO",              '#13#10 +
             '          "dailyShiftChanges": []                         '#13#10 +
             '        },                                                '#13#10 +
             '        {                                                 '#13#10 +
             '          "day": "09-07-2012",                            '#13#10 +
             '          "shiftName": "3TURNI",                          '#13#10 +
             '          "shiftStart": "09-07-2012 22:00",               '#13#10 +
             '          "shiftEnd": "10-07-2012 06:00",                 '#13#10 +
             '          "expectedShiftStart": "09-07-2012 22:00",       '#13#10 +
             '          "expectedShiftEnd": "10-07-2012 06:00",         '#13#10 +
             '          "shiftBreakStart": "09-07-2012 22:00",          '#13#10 +
             '          "shiftBreakEnd": "10-07-2012 06:00",            '#13#10 +
             '          "section": "SEZIONE_GIANCARLO",                 '#13#10 +
             '          "skill": "SKILL_GIANCARLO",                     '#13#10 +
             '          "publicHoliday": false,                         '#13#10 +
             '          "note": "NOTE PER CASA GIANCARLO",              '#13#10 +
             '          "dailyShiftChanges": []                         '#13#10 +
             '        }                                                 '#13#10 +
             '      ]                                                   '#13#10 +
             '    }                                                     '#13#10 +
             '  ]                                                       '#13#10 +
             '}                                                         ';
  MetodoList.Add(
    TMetodo.Create(
      'Turni',
      GetParametriMetodo('01-01-2012/30-04-2012',
                         '',
                         '',
                         '27-02-2012/28-02-2012'),
      LPostData,
      True
    )
  );

  // controlli R600
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'R600ControlliGenerali',
      GetParametriMetodo(Format('%s/40101/23-05-2012',[DEFAULT_MATRICOLA_TEST]),
                         '',
                         '',
                         Format('%s/1_004/27-02-2012/10:00/12:00',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  //  dizionario orari
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'DizionarioOrari',
      GetParametriMetodo(Format('%s/50521300',[DEFAULT_MATRICOLA_TEST]),
                         '',
                         '',
                         Format('%s/50521300',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // dizionario generico
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'Dizionario',
      GetParametriMetodo('Firlab_REPARTO/',
                         '',
                         '',
                         'Firlab_[NOME_VISTA]/'),
      LPostData,
      True
    )
  );

  // timbrature
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'Timbrature',
      GetParametriMetodo(Format('%s/08-02-2012/14-02-2012',[DEFAULT_MATRICOLA_TEST]),
                         '',
                         '',
                         Format('%s/01-02-2012/02-02-2012',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // timbrature conteggiate Rp502
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'R502TimbratureConteggiate',
      GetParametriMetodo(Format('%s/08-02-2012/14-02-2012',[DEFAULT_MATRICOLA_TEST]),
                         '',
                         '',
                         Format('%s/01-02-2012/02-02-2012',[DEFAULT_MATRICOLA_TEST])),
      LPostData,
      True
    )
  );

  // anagrafiche per FSE Aosta_Asl
  LPostData:='';
  MetodoList.Add(
    TMetodo.Create(
      'AnaOpeFSE',
      GetParametriMetodo('WS_ATTIVI',
                         '',
                         '',
                         ''),
      LPostData,
      False // dispone di un'autenticazione particolare
    )
  );

  // anagrafiche per MONZA_HSGERARDO - personale giornaliero
  LPostData:='';
  LDataRif:=FormatDateTime('dd-mm-yyyy',Date);
  LUtente:='MANCOP';
  LPassword:='MEDP';
  MetodoList.Add(
    TMetodo.Create(
      'Mancop_PersGG',
      GetParametriMetodo(Format('%s/%s/%s',[LDataRif,LUtente,LPassword]),
                         '',
                         '',
                         ''),
      LPostData,
      True
    )
  );

  // anagrafiche per MONZA_HSGERARDO - assenze mensili
  LPostData:='';
  LDataRif:=FormatDateTime('dd-mm-yyyy',R180InizioMese(Date));
  LUtente:='MANCOP';
  LPassword:='MEDP';
  MetodoList.Add(
    TMetodo.Create(
      'Mancop_PersMM',
      GetParametriMetodo(Format('%s/%s/%s',[LDataRif,LUtente,LPassword]),
                         '',
                         '',
                         ''),
      LPostData,
      True
    )
  );

  // aggiunge i metodi alla combobox di selezione
  for LMetodo in MetodoList do
  begin
    cmbMetodo.Items.Add(LMetodo.Name);
  end;

  // seleziona il primo metodo disponibile
  cmbMetodo.ItemIndex:=0;
  cmbMetodoChange(cmbMetodo);
end;

procedure TB021FTest.LeggiInfoRegistro;
begin
  edtInfoDatabase.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'DATABASE','');
  edtInfoAzienda.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'AZIENDA','');
  edtInfoUtente.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'UTENTE','');
  edtInfoPathLog.Text:=R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','c:\IrisWIN\Archivi');
  chkLog.Checked:=R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'FILE_LOG','N') = 'S';
end;

procedure TB021FTest.SalvaInfoRegistro;
begin
  R180PutRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'DATABASE',edtInfoDatabase.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'AZIENDA',edtInfoAzienda.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'UTENTE',edtInfoUtente.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG',edtInfoPathLog.Text);
  R180PutRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REG_B021,'FILE_LOG',IfThen(chkLog.Checked,'S','N'));
end;

procedure TB021FTest.FormDestroy(Sender: TObject);
begin
  FreeAndNil(MetodoList);
//  FreeAndNil(CSGui);
end;

function TB021FTest.GetParametriMetodo(PGet, PPost, PPut, PDelete: String): TParametriMetodo;
begin
  Result.Get:=PGet;
  Result.Post:=PPost;
  Result.Put:=PPut;
  Result.Delete:=PDelete;
end;

procedure TB021FTest.btnCancLogClick(Sender: TObject);
begin
  if DeleteFile(FileLogCompleto) then
    memLog.Clear;
end;

procedure TB021FTest.btnCopiaClick(Sender: TObject);
begin
  Clipboard.AsText:=memOutputSvc.Text;
end;

function TB021FTest.GetURLCompleto: String;
var
  LQueryString: string;
begin
  Result:=Format('%s/%s/%s',[cmbServerURL.Text,edtMethodUrl.Text,edtParametri.Text]);

  // gestione querystring
  LQueryString:=Trim(edtQueryString.Text);
  if LQueryString <> '' then
  begin
    if not LQueryString.StartsWith('?') then
      LQueryString:='?' + LQueryString;

    Result:=Result + LQueryString;
  end;
end;

procedure TB021FTest.btnCopiaURLClick(Sender: TObject);
// copia l'url di chiamata negli appunti di windows
begin
  ClipBoard.AsText:=GetURLCompleto;
end;

procedure TB021FTest.btnSalvaRegistroClick(Sender: TObject);
begin
  SalvaInfoRegistro;
  btnSalvaRegistro.Enabled:=False;
  btnAnnullaRegistro.Enabled:=False;
end;

procedure TB021FTest.btnAnnullaRegistroClick(Sender: TObject);
begin
  LeggiInfoRegistro;
  btnSalvaRegistro.Enabled:=False;
  btnAnnullaRegistro.Enabled:=False;
end;

procedure TB021FTest.btnSaveFileClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    memOutputSvc.Lines.SaveToFile(SaveDialog1.FileName);
end;

function TB021FTest.EseguiPost(PFormat, PRequest: String): String;
var
  RBody: TStringStream;
  lstString:TStringList;
  m: String;
begin
  RBody:=TStringStream.Create(AnsiString(PRequest));
  lstString:=TStringList.Create;
  try
    // per far vedere a Fiddler la richiesta
    if chkFiddler.Checked then
    begin
      IdHTTP1.ProxyParams.ProxyServer:='127.0.0.1';
      IdHTTP1.ProxyParams.ProxyPort:=8888;
    end
    else
    begin
      IdHTTP1.ProxyParams.ProxyServer:='';
      IdHTTP1.ProxyParams.ProxyPort:=0;
    end;

    if PFormat = 'json' then
    begin
      IdHTTP1.Request.Accept:='text/javascript';
      IdHTTP1.Request.ContentType:='application/json';
      //IdHTTP1.Request.ContentEncoding:='utf-8';
    end
    else if PFormat = 'xml' then
    begin
      IdHTTP1.Request.Accept:='text/xml';
      IdHTTP1.Request.ContentType:='text/xml';
      IdHTTP1.Request.ContentEncoding:='utf-8';
    end
    else
    begin
      IdHTTP1.Request.Accept:='text/plain';
      IdHTTP1.Request.ContentType:='text/plain';
      IdHTTP1.Request.ContentEncoding:='utf-8';
    end;

    //IdHTTP1.Request.BasicAuthentication := True;
    //IdHTTP1.Request.Authentication := TIdBasicAuthentication.Create;
    //IdHTTP1.Request.Authentication.Username := 'admin';
    //IdHTTP1.Request.Authentication.Password := 'admin';
    //Result:=IdHTTP1.Post(UrlThread,RBody);

    lstString.Add(PRequest);

    m:=UpperCase(FMetodo);
    if m = 'POST' then
      Result:=IdHTTP1.Post(FUrl,RBody)
    else if m = 'PUT' then
      Result:=IdHTTP1.Put(FUrl,RBody);
  finally
    try FreeAndNil(RBody); except end;
    try FreeAndNil(lstString); except end;
  end;
end;

procedure TB021FTest.Execute;
begin
  try
    if UpperCase(FMetodo) = 'GET' then
      Res:=IdHTTP1.Get(FUrl)
    else if UpperCase(FMetodo) = 'DELETE' then
    begin
      IdHTTP1.Delete(FUrl);
      Res:=IdHTTP1.ResponseText + #13#10 +
           IdHTTP1.Response.ContentType;
    end
    else
    begin
      if cmbMetodoHtml.ItemIndex = ITEM_METODO_GET then
        FJsonData:=''
      else
      begin
        // incredibilmente gli spazi e i CRLF danno problemi
        FJsonData:=PulisciStringaJson(memPostData.Text);
      end;
      Res:=EseguiPost('json',FJsonData);
    end;
    memOutputSvc.Text:=Res;
  except
    on E: Exception do
    begin
      memOutputSvc.Text:=Format('%s: %s',[E.ClassName,E.Message]);
      Screen.Cursor:=crDefault;
    end;
  end;
end;


procedure TB021FTest.btnEseguiClick(Sender: TObject);
var
  i: Integer;
  LUnixTimeCorr: Int64;
  LThElab: TThreadElab;
  LMetodo: TMetodo;
  LToken: string;
  LPassphrase: String;
begin
  Screen.Cursor:=crHourGlass;
  //PutParametri;

  ProgressBar1.Visible:=(SpinEdit1.Value > 1);
  ProgressBar1.State:=pbsNormal;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=SpinEdit1.Value;
  ProgressBar1.Repaint;

  try
    // determina ora corrente per token di autenticazione
    LUnixTimeCorr:=GetUnixTimeCorrente;

    LMetodo:=MetodoList.Items[cmbMetodo.ItemIndex];
    if LMetodo.Name = 'AnaOpeFSE' then
    begin
      // imposta autenticazione specifica per Aosta_Asl
      edtQueryString.Text:=Format('?time=%d&auth=%s',[LUnixTimeCorr,GetHashAutenticazioneAostaAsl(LUnixTimeCorr)]);
    end
    else if LMetodo.Autenticazione then
    begin
      if chkTokenAutenticazione.Checked then
      begin
        // imposta autenticazione generica per i metodi che la richiedono
        LPassphrase:=edtPassphrase.Text;
        LToken:=CreaToken(LUnixTimeCorr,LPassphrase);
        edtQueryString.Text:=Format('?token=%s&timestamp=%d',[LToken,LUnixTimeCorr]);
      end
      else
      begin
        edtQueryString.Text:='';
        if R180MessageBox('Il metodo selezionato richiede l''autenticazione.'#13#10'Confermi l''invio della richiesta senza il token?',DOMANDA) = mrNo then
          Exit;
      end;
    end;

    FUrl:=GetURLCompleto;

    // elaborazione unica / massiva via thread
    if SpinEdit1.Value = 1 then
    begin
      lblConta.Caption:='0 / 1';
      lblConta.Repaint;
      Application.ProcessMessages;
      FMetodo:=cmbMetodoHtml.Items[cmbMetodoHtml.ItemIndex];
      Inizio:=Now;
      Execute;
      lblTempo.Caption:=FormatDateTime('nn.ss.zzz',Now - Inizio);
      lblConta.Caption:='1 / 1';
    end
    else
    begin
      // elaborazione principale
      lblConta.Caption:=Format('0 / %d',[ProgressBar1.Max]);
      Inizio:=Now;
      Timer1.Enabled:=True;

      FMetodo:=cmbMetodoHtml.Items[cmbMetodoHtml.ItemIndex];
      if cmbMetodoHtml.ItemIndex = ITEM_METODO_GET then
        FJsonData:=''
      else
      begin
        // incredibilmente gli spazi e i CRLF danno problemi
        FJsonData:=PulisciStringaJson(memPostData.Text);
      end;

      for i:=1 to SpinEdit1.Value do
      begin
        LThElab:=TThreadElab.Create(True);

        LThElab.UrlThread:=FUrl;
        LThElab.FreeOnTerminate:=True;
        LThElab.Start;
      end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB021FTest.btnPulisciPostDataClick(Sender: TObject);
begin
  memPostData.Clear;
end;

procedure TB021FTest.cmbServerURLChange(Sender: TObject);
begin
  cmbMetodoChange(nil);
end;

procedure TB021FTest.edtInfoDatabaseChange(Sender: TObject);
begin
  btnSalvaRegistro.Enabled:=True;
  btnAnnullaRegistro.Enabled:=True;
end;

procedure TB021FTest.edtMethodUrlKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnEseguiClick(nil);
end;

procedure TB021FTest.edtParametriKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnEseguiClick(nil);
end;

procedure TB021FTest.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 2 then
  begin
    if FileExists(FileLogCompleto) then
      memLog.Lines.LoadFromFile(FileLogCompleto);
  end;
end;

procedure TB021FTest.chkLogClick(Sender: TObject);
begin
  btnSalvaRegistro.Enabled:=True;
  btnAnnullaRegistro.Enabled:=True;
end;

procedure TB021FTest.cmbMetodoChange(Sender: TObject);
begin
  ImpostaMetodoServer;
end;

procedure TB021FTest.cmbMetodoHtmlChange(Sender: TObject);
begin
  ImpostaVisibilitaPostData;
  ImpostaMetodoServer;
end;

procedure TB021FTest.ImpostaMetodoServer;
var
  LNomeMetodo,Par: String;
  LMetodo: TMetodo;
begin
  if cmbMetodo.ItemIndex < 0 then
    Exit;

  // determina url metodo
  LNomeMetodo:=cmbMetodo.Items[cmbMetodo.ItemIndex];
  edtMethodUrl.Text:=LNomeMetodo;

  // determina parametri in base al metodo
  LMetodo:=MetodoList.Items[cmbMetodo.ItemIndex];

  case cmbMetodoHtml.ItemIndex of
    ITEM_METODO_GET:
      Par:=LMetodo.Parametri.Get;
    ITEM_METODO_POST:
      Par:=LMetodo.Parametri.Post;
    ITEM_METODO_PUT:
      Par:=LMetodo.Parametri.Put;
    ITEM_METODO_DELETE:
      Par:=LMetodo.Parametri.Delete;
  else
    Par:='';
  end;

  // imposta i parametri del metodo
  if cmbMetodo.ItemIndex = 0 then
  begin
    // metodo di prova echostring (non coinvolge il database)
    edtParametri.Text:=Par;
  end
  else
  begin
    // altri metodi che coinvolgono il database
    edtParametri.Text:=Format('%s/%s/%s',[DEFAULT_DB,DEFAULT_AZIENDA,DEFAULT_UTENTE]);
    if Par <> '' then
      edtParametri.Text:=edtParametri.Text + '/' + Par;
  end;

  // imposta indicazione per generare token di autenticazione
  chkTokenAutenticazione.Checked:=LMetodo.Autenticazione;

  // imposta eventuale postdata
  if R180In(cmbMetodoHtml.ItemIndex,[ITEM_METODO_POST,ITEM_METODO_PUT]) then
    memPostData.Text:=LMetodo.PostData;
end;

procedure TB021FTest.ImpostaVisibilitaPostData;
var
  LShowPostData: Boolean;
begin
  LShowPostData:=R180In(cmbMetodoHtml.ItemIndex,[ITEM_METODO_POST,ITEM_METODO_PUT]);
  lblPostData.Visible:=LShowPostData;
  btnPulisciPostData.Visible:=LShowPostData;
  memPostData.Visible:=LShowPostData;
  if not memPostData.Visible then
    memPostData.Clear;
end;

procedure TB021FTest.SpinEdit1Enter(Sender: TObject);
begin
  btnEseguiClick(nil);
end;

procedure TB021FTest.SpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnEseguiClick(nil);
end;

procedure TB021FTest.Timer1Timer(Sender: TObject);
begin
  lblTempo.Caption:=FormatDateTime('nn.ss.zzz',Now - Inizio);
  lblTempo.Repaint;
end;

//*********************************************************

// thread elaborazione

function TThreadElab.EseguiPost(PFormat, PRequest: String): String;
var
  RBody: TStringStream;
  lstString:TStringList;
  m: String;
begin
  RBody:=TStringStream.Create(AnsiString(PRequest));
  lstString:=TStringList.Create;
  try
    if PFormat = 'json' then
    begin
      IdHTTPThread.Request.Accept:='text/javascript';
      IdHTTPThread.Request.ContentType:='application/json';
      IdHTTPThread.Request.ContentEncoding:='utf-8';
    end
    else if PFormat = 'xml' then
    begin
      IdHTTPThread.Request.Accept:='text/xml';
      IdHTTPThread.Request.ContentType:='text/xml';
      IdHTTPThread.Request.ContentEncoding:='utf-8';
    end
    else
    begin
      IdHTTPThread.Request.Accept:='text/plain';
      IdHTTPThread.Request.ContentType:='text/plain';
      IdHTTPThread.Request.ContentEncoding:='utf-8';
    end;

    //IdHTTPThread.Request.BasicAuthentication := True;
    //IdHTTPThread.Request.Authentication := TIdBasicAuthentication.Create;
    //IdHTTPThread.Request.Authentication.Username := 'admin';
    //IdHTTPThread.Request.Authentication.Password := 'admin';
    //Result:=IdHTTPThread.Post(UrlThread,RBody);

    lstString.Add(PRequest);

    m:=UpperCase(metodo);
    if m = 'POST' then
      Result:=IdHTTPThread.Post(UrlThread,RBody)
    else if m = 'PUT' then
      Result:=IdHTTPThread.Put(UrlThread,RBody);
  finally
    try FreeAndNil(RBody); except end;
    try FreeAndNil(lstString); except end;
  end;
end;

procedure TThreadElab.Execute;
begin
  if not Terminated then
    try
      try
        IdSSLIOHandlerThread:=TIdSSLIOHandlerSocketOpenSSL.Create(nil);
        IdCompressorThread:=TIdCompressorZLib.Create(nil);
        IdHTTPThread:=TIDHttp.Create(nil);
        IdHTTPThread.HandleRedirects:=True;
        IdHTTPThread.IOHandler:=IdSSLIOHandlerThread;
        IdHTTPThread.Compressor:=IdCompressorThread;

        if UpperCase(metodo) = 'GET' then
          Res:=IdHTTPThread.Get(UrlThread)
        else if UpperCase(metodo) = 'DELETE' then
        begin
          IdHTTPThread.Delete(UrlThread);
          Res:=IdHTTPThread.ResponseText + #13#10 +
               IdHTTPThread.Response.ContentType;
        end
        else
          Res:=EseguiPost('json',jsonData);


        // aggiorna progressbar
//        if Assigned(pbTh) then
//        begin
//          CSGui.Enter;
//          try
//            memOutTh.Text:=Res;
//            pbTh.StepBy(1);
//            pbTh.Repaint;
//            lblContaTh.Caption:=Format('%d / %d',[pbTh.Position,pbTh.Max]);
//            lblContaTh.Repaint;
//            if pbTh.Position = pbTh.Max then
//            begin
//              tmrTh.Enabled:=False;
//              Screen.Cursor:=crDefault;
//            end;
//          finally
//            CSGui.Leave;
//          end;
//        end;
      except
        on E: Exception do
        begin
          // imposta memo con errore
//          if Assigned(CSGui) then
//          begin
//            CSGui.Enter;
//            try
//              tmrTh.Enabled:=False;
//              if pbTh.Position = 0 then
//                pbTh.StepBy(1);
//              pbTh.State:=pbsError;
//              memOutTh.Text:=Format('%s: %s',[E.ClassName,E.Message]);
//            finally
//              CSGui.Leave;
//              Screen.Cursor:=crDefault;
//            end;
//          end;
        end;
      end;
    finally
      FreeAndNil(IdSSLIOHandlerThread);
      FreeAndNil(IdCompressorThread);
      FreeAndNil(IdHTTPThread);
    end;
end;

procedure TThreadElab.ParseGiustificativi(const AString: string);
var
  json: TJSONObject;
  jPair,jPairGiust: TJSONPair;
  jGiustArr: TJSONArray;
  jObj: TJSONObject;
  i,j,numGiust: Integer;
  Val: String;
begin
  json:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AString),0) as TJSONObject;
  try
    // data inizio e fine
//    for i:=0 to 1 do
//    begin
//      jPair:=json.Pairs(i);
//      memOutTh.Lines.Add(Format('%s: %s',[jPair.JsonString.Value,jPair.JsonValue.Value]));
//    end;

    // array dei giustificativi
    jPair:=json.Pairs[2];
    jGiustArr:=TJSONArray(jPair.JsonValue);
    numGiust:=jGiustArr.Count;
    for i:=0 to numGiust - 1 do
    begin
      // info giustificativo
      //memOutputSvc.Lines.Add('-------------------------------------');
      jObj:=TJSONObject(jGiustArr.Items[i]);
      for j:=0 to jObj.Count - 1 do
      begin
       //show the result
       jPairGiust:=TJSONPair(jObj.Pairs[j]);
       if jPairGiust.JsonValue is TJSONString then
         Val:=jPairGiust.JsonValue.Value
       else if jPairGiust.JsonValue is TJSONNumber then
         Val:=FloatToStr(StrToFloat(jPairGiust.JsonValue.Value))
       else if jPairGiust.JsonValue is TJSONTrue then
         Val:='true'
       else if jPairGiust.JsonValue is TJSONFalse then
         Val:='false'
       else if jPairGiust.JsonValue is TJSONNull then
         Val:='null';
       //memOutputSvc.Lines.Add(Format('%s: %s',[jPairGiust.JsonString.Value,Val]));
      end;
    end;
  finally
    json.Free;
  end;
end;

{ TMetodo }

constructor TMetodo.Create(PName: String; PParametri: TParametriMetodo; PPostData: String; PAutenticazione: Boolean);
begin
  FName:=PName;
  FParametri:=PParametri;
  FPostData:=PPostData;
  FAutenticazione:=PAutenticazione
end;

{ TMetodoList }

constructor TMetodoList.Create;
begin
  inherited;
end;

procedure TMetodoList.Sort;
var
  Comparer: IComparer<TMetodo>;
  Comparison: TComparison<TMetodo>;
begin
  Comparison:=function(const M1, M2 : TMetodo): Integer
              begin
                Result:=CompareText(M1.Name,M2.Name);
              end;

  Comparer:=TComparer<TMetodo>.Construct(Comparison);
  inherited Sort(Comparer);
end;

end.
