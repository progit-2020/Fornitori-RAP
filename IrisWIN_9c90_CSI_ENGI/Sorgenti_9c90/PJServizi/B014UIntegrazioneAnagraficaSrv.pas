unit B014UIntegrazioneAnagraficaSrv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs, Variants,
  B014UIntegrazioneAnagraficaDtM, C180FunzioniGenerali, A000UCostanti, A000USessione;

type
  TThreadIntegrazione = class(TThread)
  private
    SessioneIW:TSessioneIrisWIN;
    B014:TB014FIntegrazioneAnagraficaDtM;
  protected
    procedure Execute; override;
  end;

  TB014FIntegrazioneAnagraficaSrv = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
    ThreadList:TList;
    NomeLog:String;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  B014FIntegrazioneAnagraficaSrv: TB014FIntegrazioneAnagraficaSrv;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B014FIntegrazioneAnagraficaSrv.Controller(CtrlCode);
end;

function TB014FIntegrazioneAnagraficaSrv.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TB014FIntegrazioneAnagraficaSrv.ServiceStart(Sender: TService; var Started: Boolean);
var D,DBList,Alias:String;
    nc,i:Integer;
    Priorita:TThreadPriority;
    ThScarico:TThreadIntegrazione;
begin
  NomeLog:='B014Srv.log';
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Start del servizio B014FIntegrazioneAnagraficaSrv');
  ThreadList:=TList.Create;
  D:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Database','');
  DBList:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','DatabaseList',D);
  Priorita:=TThreadPriority(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B014','Priority','3'),3));
  R180AppendFile(NomeLog,'  Priorità: ' + IntToStr(Ord(Priorita)));
  R180AppendFile(NomeLog,'  Database: ' + DBList);
  Alias:='';
  nc:=0;
  ThreadList.Clear;
  repeat
    inc(nc);
    if (Alias <> '') and ((nc > Length(DbList)) or (R180CarattereDef(DBList,nc,',') = ',')) then
    begin
      try
        ThScarico:=TThreadIntegrazione.Create(True);
        ThScarico.Priority:=Priorita; {tpIdle, tpLowest, tpLower, tpNormal, tpHigher, tpHighest, tpTimeCritical}
        ThScarico.FreeOnTerminate:=True;
        ThScarico.SessioneIW:=TSessioneIrisWIN.Create(nil);
        ThScarico.SessioneIW.Parametri.Database:=Trim(Alias);
        ThScarico.B014:=TB014FIntegrazioneAnagraficaDtM.Create(ThScarico.SessioneIW);//@Parametri
        //Alberto 04/03/2009: tolta compatibilità con OCI7
        ThScarico.SessioneIW.SessioneOracle.Preferences.UseOCI7:=False;
        ThScarico.SessioneIW.SessioneOracle.ThreadSafe:=True;
        ThScarico.B014.SessioneAzienda.Preferences.UseOCI7:=False;
        ThScarico.B014.SessioneAzienda.ThreadSafe:=True;
        ThScarico.B014.SessioneLock.Preferences.UseOCI7:=False;
        ThScarico.B014.SessioneLock.ThreadSafe:=True;
        ThScarico.B014.ConnettiDatabase(Trim(Alias));
        if ThScarico.SessioneIW.SessioneOracle.Connected then
          R180AppendFile(NomeLog,Alias + ': Connesso')
        else
          R180AppendFile(NomeLog,Alias + ': Non connesso');
        ThreadList.Add(ThScarico);
      except
        on E:Exception do
          R180AppendFile(NomeLog,E.Message);
      end;
      Alias:='';
    end
    else
      Alias:=Alias + R180CarattereDef(DBList,nc,#0);
  until nc > Length(DbList);
  //Esecuzione dei thread
  for i:=0 to ThreadList.Count - 1 do
    TThreadIntegrazione(ThreadList[i]).Start{Resume}; // resume deprecato
  //B014FIntegrazioneAnagraficaDtM:=TB014FIntegrazioneAnagraficaDtM.Create(nil);
  Started:=True;
end;

procedure TB014FIntegrazioneAnagraficaSrv.ServiceStop(Sender: TService;
  var Stopped: Boolean);
var i:Integer;
begin
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Stop del servizio B014FIntegrazioneAnagraficaSrv');
  try
    for i:=0 to ThreadList.Count - 1 do
    begin
      try
        TThreadIntegrazione(ThreadList[i]).Terminate;
        if TThreadIntegrazione(ThreadList[i]).B014 <> nil then
          TThreadIntegrazione(ThreadList[i]).B014.Free;
      except
        on E:Exception do
          R180AppendFile(NomeLog,E.Message);
      end;
    end;
    try
      ThreadList.Free;
    except
      on E:Exception do
        R180AppendFile(NomeLog,E.Message);
    end;
  except
  end;
  Stopped:=True;
end;

// The main Thread function
procedure TThreadIntegrazione.Execute;
begin
  try
    while not Terminated do
    begin
      try B014.GetStruttureDaElaborare; except end;
      Sleep(60000);
    end;
  finally
    FreeAndNil(B014);
  end;
end;

end.
