unit B015UScaricoGiustificativiSrv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, C180FunzioniGenerali, OracleData, Variants, R250UScaricoGiustificativiDtM;

type
  TThreadScarico = class(TThread)
  private
    R250:TR250FScaricoGiustificativiDtM;
  protected
    procedure Execute; override;
  end;

  TB015FScaricoGiustificativiSrv = class(TService)
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
  B015FScaricoGiustificativiSrv: TB015FScaricoGiustificativiSrv;
  ScaricoPianificato:Boolean;
  Intervallo:Integer;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B015FScaricoGiustificativiSrv.Controller(CtrlCode);
end;

function TB015FScaricoGiustificativiSrv.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TB015FScaricoGiustificativiSrv.ServiceStart(Sender: TService;
  var Started: Boolean);
var M,D,P,DBList,Alias:String;
    nc,i:Integer;
    Priorita:TThreadPriority;
    ThScarico:TThreadScarico;
begin
  NomeLog:='B015Srv.log';
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Start del servizio B015FScaricoGiustificativiSrv');
  ThreadList:=TList.Create;
  M:='*';
  D:='*';
  P:='*';
  for i:=1 to ParamCount - 1 do
    begin
    if UpperCase(Copy(Param[i],1,2)) = 'M=' then
      M:=Copy(Param[i],3,Length(Param[i]))
    else if UpperCase(Copy(Param[i],1,2)) = 'D=' then
      D:=Copy(Param[i],3,Length(Param[i]))
    else if UpperCase(Copy(Param[i],1,2)) = 'P=' then
      P:=Copy(Param[i],3,Length(Param[i]))
    end;
  if D <> '*' then
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','DatabaseList',D);
  if M <> '*' then
    try
      if StrToInt(M) = 0 then
        M:='60';
      R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','Intervallo',IntToStr(StrToInt(M)));
    except
      R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','Intervallo','60');
    end;
  if P <> '*' then
    R180PutRegistro(HKEY_LOCAL_MACHINE,'B015','Pianificazione',P);

  //R250FScaricoGiustificativiDtM:=TR250FScaricoGiustificativiDtM.Create(nil);

  P:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','Pianificazione','N');
  ScaricoPianificato:=P = 'S';
  (*if ScaricoPianificato then
    Timer1.Interval:=60000
  else
    Timer1.Interval:=60000 * StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','Intervallo','60'),60);
  Timer1.Enabled:=True;*)
  //Timer1Timer(nil);
  if ScaricoPianificato then
    Intervallo:=1
  else
    Intervallo:=StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','Intervallo','60'),1);
  //Creazione dei thread, uno per ogni database specificato in DBList
  D:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','Database','');
  DBList:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','DatabaseList',D);
  Priorita:=TThreadPriority(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B015','Priority','3'),3));
  R180AppendFile(NomeLog,'  Pianificazione: ' + P);
  R180AppendFile(NomeLog,'  Intervallo: ' + IntToStr(Intervallo));
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
        ThScarico:=TThreadScarico.Create(True);
        ThScarico.Priority:=Priorita; {tpIdle, tpLowest, tpLower, tpNormal, tpHigher, tpHighest, tpTimeCritical}
        ThScarico.FreeOnTerminate:=True;
        ThScarico.R250:=TR250FScaricoGiustificativiDtM.Create(nil);
        ThScarico.R250.ConnettiDatabase(Trim(Alias));
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
    TThreadScarico(ThreadList[i]).Start{Resume}; // resume deprecato
  Started:=True;
end;

// The main Thread function
procedure TThreadScarico.Execute;
var DurataInt:Integer;
    IntInizio,IntFine:TDateTime;
begin
  try
    while not Terminated do
    begin
      if ScaricoPianificato then
      begin
        try
          // verifica connessione db
          // (se fallisce continua a provare ogni minuto)
          if not R250.ControlloConnessioneDatabase then
          begin
            Sleep(60000);
            Continue;
          end;

          // se l'ora corrente è pianificata per l'acquisizione, la effettua
          R250.selI102.Refresh;
          if R250.selI102.SearchRecord('ORA',FormatDateTime('hh.nn',Now),[srFromBeginning]) then
            R250.Scarico(False,True);
        except
        end;
        Sleep(60000);
      end
      else
      try
        IntInizio:=Now;
        if not R250.ControlloConnessioneDatabase then
        begin
          Sleep(60000);
          Continue;
        end;
        R250.Scarico(False,True);
        IntFine:=Now;
        if R180OreMinuti(IntInizio) > R180OreMinuti(IntFine) then
          DurataInt:=R180OreMinuti(IntFine) + 1440 - R180OreMinuti(IntInizio)
        else
          DurataInt:=R180OreMinuti(IntFine) - R180OreMinuti(IntInizio);
        DurataInt:=DurataInt * 60 + StrToInt(FormatDateTime('ss',(IntFine - IntInizio)));
        if (Intervallo * 60) - DurataInt > 0 then
          Sleep(((Intervallo * 60) - DurataInt) * 1000);
      except
      end;
    end;
  finally
    FreeAndNil(R250);
  end;
end;

procedure TB015FScaricoGiustificativiSrv.ServiceStop(Sender: TService;
  var Stopped: Boolean);
var i:Integer;
begin
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Stop del servizio B015FScaricoGiustificativiSrv');
  try
    for i:=0 to ThreadList.Count - 1 do
    begin
      try
        TThreadScarico(ThreadList[i]).Terminate;
        if TThreadScarico(ThreadList[i]).R250 <> nil then
          TThreadScarico(ThreadList[i]).R250.Free;
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

end.
