unit Bc22UGeneratoreCartelliniSrv;

interface

uses
  Bc22UGeneratoreCartelliniMW, C180FunzioniGenerali,
  Generics.Collections, System.IOUtils, System.StrUtils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs, Winapi.ActiveX, Oracle;

type
  TThreadElab = class(TThread)
  private
    Bc22MW: TBc22FGeneratoreCartelliniMW;
    NomeLog: String;
    function ComponiLog(const PMessaggio: String): String;
  protected
    procedure Execute; override;
  end;

  TBc22FGeneratoreCartelliniSrv = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceExecute(Sender: TService);
  private
    ThreadList: TObjectList<TThreadElab>;
    NomeLog: String;
    function ComponiLog(const PMessaggio: String): String;
    procedure Inizializzazione;
    procedure ReleaseListaThread;
    procedure TerminaThread;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  Bc22FGeneratoreCartelliniSrv: TBc22FGeneratoreCartelliniSrv;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Bc22FGeneratoreCartelliniSrv.Controller(CtrlCode);
end;

function TBc22FGeneratoreCartelliniSrv.GetServiceController: TServiceController;
begin
  Result:=ServiceController;
end;

function TBc22FGeneratoreCartelliniSrv.ComponiLog(const PMessaggio: String): String;
// compone l'informazione da scrivere nel file di log
var
  Ora: String;
begin
  Ora:=FormatDateTime('dd/mm/yyyy hh.nn.ss',Now);
  Result:=Format('%s - %s',[Ora,PMessaggio]);
end;

procedure TBc22FGeneratoreCartelliniSrv.Inizializzazione;
// operazioni da eseguire in fase di avvio del servizio windows
// prepara la lista di thread da eseguire
var
  D, ParName, ParVal, DBList, Alias: String;
  {$WARN SYMBOL_PLATFORM OFF}
  Priorita: TThreadPriority;
  {$WARN SYMBOL_PLATFORM ON}
  trdElab: TThreadElab;
  i: Integer;

  R: TCheckConnectionResult;
begin
  // valuta parametri da riga di comando
  D:='*';
  for i:=1 to ParamCount - 1 do
  begin
    ParName:=Param[i].Substring(0,2).ToUpper;
    ParVal:=Param[i].Substring(2);
    if ParName = 'D=' then
      D:=ParVal;
  end;
  if D <> '*' then
    R180PutRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'DatabaseList',D);

  // estrae info da registro di sistema
  D:=R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Database','');
  DBList:=R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'DatabaseList',D);
  {$WARN SYMBOL_PLATFORM OFF}
  Priorita:=TThreadPriority(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,Bc22_MASCHERA,'Priority','3'),3));
  {$WARN SYMBOL_PLATFORM ON}

  R180AppendFile(NomeLog,ComponiLog(Format('  priorità: %d',[Ord(Priorita)])));
  R180AppendFile(NomeLog,ComponiLog(Format('  database list: %s',[DBList])));

  // creazione di un thread per ogni database specificato in DBList
  ThreadList:=TObjectList<TThreadElab>.Create;
  for Alias in DBList.Split([',']) do
  begin
    R180AppendFile(NomeLog,ComponiLog(Format('  creazione thread per il database %s: inizio',[Alias])));
    try
      trdElab:=TThreadElab.Create(True);
      trdElab.Priority:=Priorita;
      trdElab.FreeOnTerminate:=False; // importante!!! ThreadList distrugge tutto!

      // imposta file di log per il singolo thread
      trdElab.NomeLog:=Format('%s\%s_%s%s',[TPath.GetDirectoryName(NomeLog),
                                            TPath.GetFileNameWithoutExtension(NomeLog),
                                            Alias,
                                            TPath.GetExtension(NomeLog)]);
      R180AppendFile(NomeLog,ComponiLog(Format('  file di log: %s',[trdElab.NomeLog])));

      // prepara il middleware Bc22
      trdElab.Bc22MW:=TBc22FGeneratoreCartelliniMW.Create(nil);
      trdElab.Bc22MW.SessioneOracleBc22.ThreadSafe:=True;
      trdElab.Bc22MW.ConnettiDatabase(Alias);
      R:=trdElab.Bc22MW.SessioneOracleBc22.CheckConnection(False);
      R180AppendFile(NomeLog,ComponiLog(Format('  sessione oracle Bc22 (%s@%s): checkconnection = %s',
                                               [trdElab.Bc22MW.SessioneOracleBc22.LogonUsername,
                                                trdElab.Bc22MW.SessioneOracleBc22.LogonDatabase,
                                                IfThen(R = ccOK,'ok',IfThen(R = ccError,'error','reconnected'))])));

      // aggiunge il thread alla lista
      ThreadList.Add(trdElab);
    except
      on E:Exception do
        R180AppendFile(NomeLog,ComponiLog(Format('  errore in fase di creazione del thread per il database %s: %s',[Alias,E.Message])));
    end;
    R180AppendFile(NomeLog,ComponiLog(Format('  creazione thread per il database %s: completata',[Alias])));
  end;
end;

procedure TBc22FGeneratoreCartelliniSrv.TerminaThread;
// termina tutti i thread presenti nella lista
var
  trdElab: TThreadElab;
begin
  R180AppendFile(NomeLog,ComponiLog(Format('  TerminaThread: inizio',[])));

  // ciclo di terminazione thread
  for trdElab in ThreadList do
  begin
    try
      trdElab.Terminate;
      trdElab.WaitFor;
    except
      on E:Exception do
        R180AppendFile(NomeLog,ComponiLog(Format('  errore in fase di terminazione del thread: %s',[E.Message])));
    end;
  end;

  R180AppendFile(NomeLog,ComponiLog(Format('  TerminaThread: terminato',[])));
end;

procedure TBc22FGeneratoreCartelliniSrv.ReleaseListaThread;
// distrugge la lista di thread
begin
  R180AppendFile(NomeLog,ComponiLog(Format('  ReleaseListaThread: inizio',[])));
  try
    ThreadList.Free;
  except
    on E:Exception do
      R180AppendFile(NomeLog,ComponiLog(Format('  errore in fase di distruzione della lista di thread: %s',[E.Message])));
  end;
  R180AppendFile(NomeLog,ComponiLog(Format('  ReleaseListaThread: terminato',[])));
end;

// ########################################################################## //
// #############   G E S T I O N E   D E L   S E R V I Z I O   ############## //
// ########################################################################## //

procedure TBc22FGeneratoreCartelliniSrv.ServiceStart(Sender: TService; var Started: Boolean);
// operazioni da eseguire in fase di avvio del servizio windows
begin
  // imposta log
  NomeLog:=IncludeTrailingPathDelimiter(R180GetRegistro(HKEY_LOCAL_MACHINE,'','PATH_LOG','C:\IrisWin')) +
           Format('%s.log',[Name]);
  R180AppendFile(NomeLog,ComponiLog(Format('%s',[StringOfChar('-',80)])));
  R180AppendFile(NomeLog,ComponiLog(Format('Servizio %s: ServiceStart...',[Name])));

  // procedura di inizializzazione
  Inizializzazione;

  R180AppendFile(NomeLog,ComponiLog(Format('Servizio %s: ServiceStart completato',[Name])));
  Started:=True;
end;

procedure TBc22FGeneratoreCartelliniSrv.ServiceExecute(Sender: TService);
var
  trdElab: TThreadElab;
  EsisteThread:Boolean;
begin
  R180AppendFile(NomeLog,ComponiLog(Format('Servizio %s: ServiceExecute...',[Name])));

  // avvio dei thread
  R180AppendFile(NomeLog,ComponiLog(Format('  avvio i %d thread di elaborazione',[ThreadList.Count])));
  for trdElab in ThreadList do
    trdElab.Start;

  // attesa terminazione thread
  R180AppendFile(NomeLog,ComponiLog(Format('  attendo che i thread siano terminati',[])));
  EsisteThread:=True;
  while EsisteThread do
  begin
    EsisteThread:=False;
    for trdElab in ThreadList do
    begin
      if not trdElab.Terminated then
        EsisteThread:=True;
    end;
  end;
  R180AppendFile(NomeLog,ComponiLog(Format('  tutti i thread sono terminati',[])));

  // libera le risorse
  ReleaseListaThread;

  R180AppendFile(NomeLog,ComponiLog(Format('Servizio %s: ServiceExecute terminato',[Name])));
end;

procedure TBc22FGeneratoreCartelliniSrv.ServiceStop(Sender: TService; var Stopped: Boolean);
// operazioni da eseguire in fase di stop del servizio windows
begin
  R180AppendFile(NomeLog,ComponiLog(Format('Servizio %s: ServiceStop...',[Name])));

  // termina tutti i thread
  TerminaThread;

  // libera le risorse
  ReleaseListaThread;

  // log di arresto completato
  R180AppendFile(NomeLog,ComponiLog(Format('Servizio %s: ServiceStop completato',[Name])));
  Stopped:=True;
end;

{ TThreadElab }

function TThreadElab.ComponiLog(const PMessaggio: String): String;
var
  Ora: String;
begin
  Ora:=FormatDateTime('dd/mm/yyyy hh.nn.ss',Now);
  Result:=Format('%s - %s',[Ora,PMessaggio]);
end;

procedure TThreadElab.Execute;
begin
  // bugfix "Microsoft MSXML is not installed"
  // cfr. http://edn.embarcadero.com/article/29240
  CoInitialize(nil);

  R180AppendFile(NomeLog,ComponiLog(Format('Thread.Execute: thread #%d avviato | database: %s',[ThreadID,Bc22MW.SessioneOracleBc22.LogonDatabase])));
  // generazione dei cartellini
  try
    try
      R180AppendFile(NomeLog,ComponiLog(Format('  Bc22MW.GeneraPdf: avviato',[])));
      Bc22MW.GeneraPdf;
      R180AppendFile(NomeLog,ComponiLog(Format('  Bc22MW.GeneraPdf: terminato',[])));
    except
      on E: Exception do
      begin
        R180AppendFile(NomeLog,ComponiLog(Format('  errore durante la generazione dei cartellini: %s (%s)',[E.Message,E.ClassName])));
      end;
    end;
  finally
    try
      FreeAndNil(Bc22MW);
      CoUninitialize;
      R180AppendFile(NomeLog,ComponiLog(Format('Thread.Execute: thread #%d terminato',[ThreadID])));
      R180AppendFile(NomeLog,ComponiLog(Format('%s',[StringOfChar('-',80)])));
    finally
      Terminate;
    end;
  end;
end;

end.
