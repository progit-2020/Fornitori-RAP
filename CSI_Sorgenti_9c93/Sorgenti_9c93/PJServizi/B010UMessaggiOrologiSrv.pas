unit B010UMessaggiOrologiSrv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  C180FunzioniGenerali, Variants, A000UCostanti, A000USessione, B010UMessaggiOrologiDTM1;

type
  TThreadMessaggi = class(TThread)
  private
    SessioneIW:TSessioneIrisWIN;
    B010:TB010FMessaggiOrologiDtM1;
  protected
    procedure Execute; override;
  end;

  TB010FMessaggiOrologiSrv = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
    NomeLog:String;
    ThreadList:TList;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  B010FMessaggiOrologiSrv: TB010FMessaggiOrologiSrv;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B010FMessaggiOrologiSrv.Controller(CtrlCode);
end;

function TB010FMessaggiOrologiSrv.GetServiceController: TServiceController;
begin
  Result:=ServiceController;
end;

procedure TB010FMessaggiOrologiSrv.ServiceStart(Sender: TService;
  var Started: Boolean);
var D,DBList,Alias:String;
    nc,i:Integer;
    Priorita:TThreadPriority;
    ThScarico:TThreadMessaggi;
begin
  NomeLog:='B010Srv.log';
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Start del servizio B010FMessaggiOrologiSrv');

  ThreadList:=TList.Create;
  D:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Database','');
  DBList:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','DatabaseList',D);
  Priorita:=TThreadPriority(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B010','Priority','3'),3));
  R180AppendFile(NomeLog,'  Priorità: ' + IntToStr(Ord(Priorita)));
  R180AppendFile(NomeLog,'  Database: ' + DBList);
  Alias:='';
  nc:=0;
  ThreadList.Clear;
  repeat
    inc(nc);
    if ((nc > Length(DbList)) or (R180CarattereDef(DBList,nc,',') = ',')) then
    begin
      try
        ThScarico:=TThreadMessaggi.Create(True);
        ThScarico.Priority:=Priorita; {tpIdle, tpLowest, tpLower, tpNormal, tpHigher, tpHighest, tpTimeCritical}
        ThScarico.FreeOnTerminate:=True;
        ThScarico.SessioneIW:=TSessioneIrisWIN.Create(nil);
        ThScarico.SessioneIW.SessioneOracle.Name:='xxx';
        ThScarico.B010:=TB010FMessaggiOrologiDtM1.Create(ThScarico.SessioneIW);//@Parametri
        ThScarico.B010.ConnettiDatabase(Trim(Alias));
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
    TThreadMessaggi(ThreadList[i]).Start{Resume}; // resume deprecato
  (*B010FMessaggiOrologiDtM1:=TB010FMessaggiOrologiDtM1.Create(nil);
  B010FMessaggiOrologiDtM1.Timer1.Enabled:=True;*)
  Started:=True;
end;

procedure TB010FMessaggiOrologiSrv.ServiceStop(Sender: TService;
  var Stopped: Boolean);
var i:Integer;
begin
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Stop del servizio B010FMessaggiOrologiSrv');
  try
    for i:=0 to ThreadList.Count - 1 do
    begin
      try
        TThreadMessaggi(ThreadList[i]).Terminate;
        if TThreadMessaggi(ThreadList[i]).B010 <> nil then
          TThreadMessaggi(ThreadList[i]).B010.Free;
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
procedure TThreadMessaggi.Execute;
begin
  try
    while not Terminated do
    begin
      try
        B010.Timer1Timer(nil);
      except
        { 30.06.2009 daniloc - gestione log su db (affidata al datamodulo)
        on E:Exception do
        begin
          B010.ScriviLog(E.Message);
          B010.SalvaLog;
        end;
        }
      end;
      Sleep(60000);
    end;
  finally
    FreeAndNil(B010);
  end;
end;

end.
