unit Bc06UMonitorB006Srv;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, OracleData, Variants, Math, StrUtils, Oracle,
  A000USessione, Bc06UClassi, Bc06UExecMonitorB006DtM, C180FunzioniGenerali;

type
  TThreadMonitor = class(TThread)
  private
    Bc06:TBc06FExecMonitorB006DtM;
    procedure ScriviLog(StrLst: TStringList);
  protected
    procedure Execute; override;

  end;

  TBc06FMonitorB006Srv = class(TService)
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
    { Private declarations }
    ThreadList:TList;

  public
    NomeLog:String;
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Bc06FMonitorB006Srv: TBc06FMonitorB006Srv;

const
  Bc06_SHORT_NAME      = 'Bc06';
  B006_SHORT_NAME      = 'B006';
implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Bc06FMonitorB006Srv.Controller(CtrlCode);
end;

function TBc06FMonitorB006Srv.GetServiceController: TServiceController;
begin
  Result:=ServiceController;
end;

procedure TBc06FMonitorB006Srv.ServiceStart(Sender: TService; var Started: Boolean);
var M, P, D:String;
    DBList: TStringList;
    nc,i:Integer;
    Priorita:TThreadPriority;
    ThScarico:TThreadMonitor;
begin
  NomeLog:='Bc06Srv.log';
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Start del servizio ' + self.Name);

  {
  while 1=1 do
  begin
    //R180AppendFile(NomeLog, FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - In attesa');
    sleep(1000);
  end;
  }

  ThreadList:=TList.Create;
  M:='*';
  D:='*';
  P:='*';
  if ParamCount > 0 then R180AppendFile(NomeLog, 'Param 0: ' + Param[0]);
  for i:=1 to ParamCount - 1 do
  begin
    if UpperCase(Copy(Param[i],1,2)) = 'M=' then
      M:=Copy(Param[i],3,Length(Param[i]))
    else if UpperCase(Copy(Param[i],1,2)) = 'D=' then
      D:=Copy(Param[i],3,Length(Param[i]))
    else if UpperCase(Copy(Param[i],1,2)) = 'P=' then
      P:=Copy(Param[i],3,Length(Param[i]));
    R180AppendFile(NomeLog, 'Param ' + IntToStr(i) +': ' + Param[i]);
  end;

  if D <> '*' then
    R180PutRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME,'DatabaseList',D);

  //Creazione dei thread, uno per ogni database specificato in DBList
  D:=R180GetRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME,'Database','');
  DBList:= TStringList.Create;
  if R180GetRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME,'DatabaseList',D) = '<B006_DatabaseList>' then
    DBList.CommaText:=R180GetRegistro(HKEY_LOCAL_MACHINE, B006_SHORT_NAME,'DatabaseList',D)
  else
    DBList.CommaText:=R180GetRegistro(HKEY_LOCAL_MACHINE, Bc06_SHORT_NAME,'DatabaseList',D);

  Priorita:=TThreadPriority(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,Bc06_SHORT_NAME,'Priority','3'),3));

  R180AppendFile(NomeLog,'  Priorità: ' + IntToStr(Ord(Priorita)));
  R180AppendFile(NomeLog,'  DatabaseList: ' + DBList.CommaText);
  nc:=0;

  ThreadList.Clear;
  for i:=0 to DBList.Count-1 do
  begin
    try
      ThScarico:=TThreadMonitor.Create(True);
      ThScarico.Priority:=Priorita;
      ThScarico.FreeOnTerminate:=True;

      ThScarico.Bc06:=TBc06FExecMonitorB006DtM.Create(nil);
      ThScarico.Bc06.TipoModulo:=ThScarico.Bc06.ModuloServizio;
      ThScarico.Bc06.SessioneOracleBc06:=TOracleSession.Create(ThScarico.Bc06);
      ThScarico.Bc06.SessioneOracleBc06.ThreadSafe:=True;
      if ThScarico.Bc06.ConnettiDatabase(Trim(DBList[i])) then
        R180AppendFile(Bc06FMonitorB006Srv.NomeLog, FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - ThScarico[' + IntToStr(i) + ']  (' + DBList[i] + ') aggiunto')
      else
        R180AppendFile(Bc06FMonitorB006Srv.NomeLog, FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Connessione a ' + DBList[i] + ' non riuscita.');

      ThreadList.Add(ThScarico);
    except
      on E:Exception do
        R180AppendFile(NomeLog,'Errore in fase di creazione thread[' + IntToStr(i) + '] (' + DBList[i] + '): ' + E.Message);
    end;
  end;

  //Esecuzione dei thread
  for i:=0 to ThreadList.Count - 1 do
    TThreadMonitor(ThreadList[i]).Start;

  Started:=True;
end;

procedure TThreadMonitor.ScriviLog(StrLst: TStringList);
var str: String;
begin
  R180AppendFile(Bc06FMonitorB006Srv.NomeLog, FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' ------------');
  for str in StrLst do
    R180AppendFile(Bc06FMonitorB006Srv.NomeLog, str);

  StrLst.Free;
end;

// The main Thread function
procedure TThreadMonitor.Execute;
var DurataInt,Minuti:Integer;
    IntInizio,IntFine:TDateTime;
    ConfServizio:TConfServizio;
    ConfIstanza:TConfIstanza;
    LstTmp: TStringList;
begin
  try
    try
      while not Terminated do
      begin
        IntInizio:=Now;

        if not Bc06.ControlloConnessioneDatabase then
        begin
          Sleep(60000);
          Continue;
        end;

        // Gli errori sono gestiti internamente in LanciaControllo
        for ConfServizio in Bc06.Configurazione.Servizi.Values do
        begin
          for ConfIstanza in ConfServizio.Istanze do
          begin
            LstTmp:=Bc06.LanciaControllo(ConfServizio,ConfIstanza); //ScriviLog(Bc06.LanciaControllo(ConfServizio,ConfIstanza));
            LstTmp.Free;
          end;
        end;

        IntFine:=Now;
        if R180OreMinuti(IntInizio) > R180OreMinuti(IntFine) then
          DurataInt:=R180OreMinuti(IntFine) + 1440 - R180OreMinuti(IntInizio)
        else
          DurataInt:=R180OreMinuti(IntFine) - R180OreMinuti(IntInizio);
        DurataInt:=DurataInt * 60 + StrToInt(FormatDateTime('ss',(IntFine - IntInizio)));
        DurataInt:=DurataInt * 1000; //DURATA [ms]
        if ConfServizio.IntervalloMS - DurataInt > 0 then //Se la durata è superiore all'intervallo impostato parte subito con un nuovo loop
        begin
          try
            Minuti:=(ConfServizio.IntervalloMS - DurataInt) div 60000;
            Bc06.RegistraMsg.InserisciMessaggio('I','  <Prossima acquisizione alle ore ' +
                           TimeToStr(Now + EncodeTime(Minuti div 60,Minuti mod 60,0,0)) + '>');
          except
          end;
          Sleep(ConfServizio.IntervalloMS - DurataInt);
        end;
      end;
    except
      on E:Exception do
        Bc06.RegistraMsg.InserisciMessaggio('A',E.Message);
    end;
  finally
    FreeAndNil(Bc06);
  end;
end;

procedure TBc06FMonitorB006Srv.ServiceStop(Sender: TService;
  var Stopped: Boolean);
var i:Integer;
begin
  R180AppendFile(NomeLog,FormatDateTime('dd/mm/yyyy hh.nn.ss',Now) + ' - Stop del servizio ' + Self.Name);
  try
    for i:=0 to ThreadList.Count - 1 do
    begin
      try
        TThreadMonitor(ThreadList[i]).Terminate;
        if TThreadMonitor(ThreadList[i]).Bc06 <> nil then
          TThreadMonitor(ThreadList[i]).Bc06.Free;
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
