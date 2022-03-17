unit B019UGeneratoreStampeSrv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  C180FunzioniGenerali, Variants, A000UCostanti, A000USessione, B019UGeneratoreStampeDTM, DB,
  OracleData, Oracle;

type
  TThreadStampe = class(TThread)
  private
    SessioneIW:TSessioneIrisWIN;
    B019:TB019FGeneratoreStampeDtM;
  protected
    procedure Execute; override;
  end;

  TB019FGeneratoreStampeSrv = class(TService)
    SessioneMondoEDP: TOracleSession;
    selI090: TOracleDataSet;
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
  B019FGeneratoreStampeSrv: TB019FGeneratoreStampeSrv;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  B019FGeneratoreStampeSrv.Controller(CtrlCode);
end;

function TB019FGeneratoreStampeSrv.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TB019FGeneratoreStampeSrv.ServiceStart(Sender: TService;
  var Started: Boolean);
var D,DBList,Alias:String;
    nc,i:Integer;
    EsisteConnDB:Boolean;
    Priorita:TThreadPriority;
    ThStampe:TThreadStampe;
begin
  NomeLog:='B019Srv.log';
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Start del servizio B019FGeneratoreStampeSrv');
  ThreadList:=TList.Create;
  D:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B019','Database','');
  DBList:=R180GetRegistro(HKEY_LOCAL_MACHINE,'B019','DatabaseList',D);
  Priorita:=TThreadPriority(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,'B019','Priority','3'),3));
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
        SessioneMondoedp.LogOff;
        SessioneMondoedp.LogonDatabase:=Trim(Alias);
        A000LogonDBOracle(SessioneMondoedp);
        //Se fallisce la connessione va nell'except successivo
        selI090.Open;
        while not selI090.Eof do
        try
          EsisteConnDB:=False;
          for i:=0 to ThreadList.Count - 1 do
          begin
            if (ThStampe.SessioneIW.SessioneOracle.LogonDatabase = Trim(Alias)) and
               (UpperCase(ThStampe.SessioneIW.SessioneOracle.LogonUsername) = UpperCase(selI090.FieldByName('UTENTE').AsString)) then
            begin
              EsisteConnDB:=True;
              Break;
            end;
          end;
          if not EsisteConnDB then
          begin
            R180AppendFile(NomeLog,Format('%s - Creazione Thread DB: %s - Azienda: %s',[FormatDateTime('dd/mm/yyyy hh.nn.ss',Now),Alias,selI090.FieldByName('AZIENDA').AsString]));
            ThStampe:=TThreadStampe.Create(True);
            ThStampe.Priority:=Priorita; {tpIdle, tpLowest, tpLower, tpNormal, tpHigher, tpHighest, tpTimeCritical}
            ThStampe.FreeOnTerminate:=True;
            ThStampe.SessioneIW:=TSessioneIrisWIN.Create(nil);
            ThStampe.SessioneIW.SessioneOracle.Name:='xxx';
            //Occhio!
            ThStampe.SessioneIW.SessioneOracle.ThreadSafe:=True;
            ThStampe.SessioneIW.SessioneOracle.Preferences.UseOCI7:=False;
            //Fine
            ThStampe.B019:=TB019FGeneratoreStampeDtM.Create(ThStampe.SessioneIW);//@Parametri
            ThStampe.B019.ConnettiDatabase(Trim(Alias),selI090.FieldByName('AZIENDA').AsString);
            if ThStampe.SessioneIW.SessioneOracle.Connected then
              R180AppendFile(NomeLog,Format('DB: %s - Azienda: %s - Connesso',[Alias,selI090.FieldByName('AZIENDA').AsString]))
            else
              R180AppendFile(NomeLog,Format('DB: %s - Azienda: %s - Non connesso',[Alias,selI090.FieldByName('AZIENDA').AsString]));
            ThreadList.Add(ThStampe);
          end;
        finally
          selI090.Next;
        end;
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
    TThreadStampe(ThreadList[i]).Start{Resume}; // resume deprecato
  (*B010FMessaggiOrologiDtM1:=TB010FMessaggiOrologiDtM1.Create(nil);
  B010FMessaggiOrologiDtM1.Timer1.Enabled:=True;*)
  Started:=True;
end;

procedure TB019FGeneratoreStampeSrv.ServiceStop(Sender: TService;
  var Stopped: Boolean);
var i:Integer;
begin
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Stop del servizio B019FGeneratoreStampeSrv');
  try
    for i:=0 to ThreadList.Count - 1 do
    begin
      try
        TThreadStampe(ThreadList[i]).Terminate;
        if TThreadStampe(ThreadList[i]).B019 <> nil then
          TThreadStampe(ThreadList[i]).B019.Free;
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
procedure TThreadStampe.Execute;
begin
  try
    while not Terminated do
    begin
      try
        B019.Timer1Timer(nil);
      except
        //on E:Exception do
        //begin
        //  B019.ScriviLog('Errore: ' + E.Message);
        //  B019.SalvaLog;
        //end;
      end;
      Sleep(60000);
    end;
  finally
    FreeAndNil(B019);
  end;
end;

end.
