unit medpSendMail;

{!!!ATTENZIONE!!!
 I file: libeay32.dll, ssleay32.dll
 Per eseguibili e servizi è sufficentie che vengano posizionati all'interno della stessa cartella
 Se IrisWeb viene utilizzato tramite IIS i file devo essere posizionati nella cartella C:\Windows\}

interface

uses
  SysUtils, Classes, Oracle, DB, OracleData, Math, StrUtils, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, R005UDataModuleMW,
  C180FunzioniGenerali, DBClient, C018UIterAutDM, Datasnap.Provider,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP, IdMessage,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

type
  TmedpSendMail = class
  private
    ParC90_EMailSMTPHost:string;
    ParC90_EMailUserName:string;
    ParC90_EMailHeloName:string;
    ParC90_EMailPassword:string;
    ParC90_EMailPort:string;
    ParC90_EMailSenderIndirizzo:string;
    ParC90_EMailAuthType,ParC90_EMailUseTLS:string;
    LogTraccia:string;
    MySMTP:TIdSMTP;
    MyMessage:TIdMessage;
    MyOpenSSL:TIdSSLIOHandlerSocketOpenSSL;
    function GetTipoCriptazione:TIdSSLVersion;
    procedure LeggiParametri;
  public
    constructor Create;
    destructor Destroy; override;
    function ConnettiSMTP:string;
    function Invia(Dest,Oggetto,Msg:string):string; overload;
    function Invia(Dest,DestCC,DestCCN,Oggetto,Msg:string):string; overload;
  end;

implementation

constructor TmedpSendMail.Create;
begin
  MySMTP:=TIdSMTP.Create(nil);
  MySMTP.UseEhlo:=True;
  MyMessage:=TIdMessage.Create(nil);
  MyMessage.CharSet:='ISO-8859-15';
  MyMessage.ConvertPreamble:=True;
  MyMessage.Encoding:=meMIME;
  MyMessage.AttachmentEncoding:='MIME';
  MyMessage.UseNowForDate:=True;
  LeggiParametri;
end;

procedure TmedpSendMail.LeggiParametri;
begin
  ParC90_EMailSMTPHost:=Parametri.CampiRiferimento.C90_EMailSMTPHost;
  ParC90_EMailUserName:=Parametri.CampiRiferimento.C90_EMailUserName;
  ParC90_EMailHeloName:=Parametri.CampiRiferimento.C90_EMailHeloName;
  ParC90_EMailPassword:=Parametri.CampiRiferimento.C90_EMailPassWord;
  ParC90_EMailPort:=Parametri.CampiRiferimento.C90_EMailPort;
  ParC90_EMailSenderIndirizzo:=Parametri.CampiRiferimento.C90_EMailSenderIndirizzo;
  ParC90_EMailAuthType:=Parametri.CampiRiferimento.C90_EMailAuthType;
  ParC90_EMailUseTLS:=Parametri.CampiRiferimento.C90_EMailUseTLS;
end;

function TmedpSendMail.GetTipoCriptazione:TIdSSLVersion;
begin
  Result:=sslvTLSv1;
  if ParC90_EMailAuthType.ToUpper = 'TLSV1_1' then
    Result:=sslvTLSv1_1
  else if ParC90_EMailAuthType.ToUpper = 'TLSV1_2' then
    Result:=sslvTLSv1_2
  else if ParC90_EMailAuthType.ToUpper = 'SSLV2' then
    Result:=sslvSSLv2
  else if ParC90_EMailAuthType.ToUpper = 'SSLV23' then
    Result:=sslvSSLv23
  else if ParC90_EMailAuthType.ToUpper = 'SSLV3' then
    Result:=sslvSSLv3;
end;

function TmedpSendMail.ConnettiSMTP:string;
begin
  LogTraccia:='';
  Result:='';
  try
    MySMTP.Disconnect;
    if ParC90_EMailPort.Trim = '' then
      MySMTP.Port:=25
    else
      MySMTP.Port:=ParC90_EMailPort.ToInteger;
    MySMTP.Host:=ParC90_EMailSMTPHost;
    MySMTP.IOHandler:=nil;
    //MySMTP.Connect;
    MySMTP.AuthType:=satDefault;
    {Assegnazione e valorizzazione oggetto necessario per l'autenticazione TLS\SSL}
    if (ParC90_EMailAuthType.Trim <> '') and
       (ParC90_EMailAuthType.Trim.ToUpper <> 'NO AUTENTICAZIONE') then
    begin
      MySMTP.IOHandler:=TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      with (MySMTP.IOHandler as TIdSSLIOHandlerSocketOpenSSL) do
      begin
        MySMTP.UseEhlo:=False;
        SSLOptions.Method:=GetTipoCriptazione;
        SSLOptions.RootCertFile:='';
        SSLOptions.Mode:=sslmUnassigned;
        SSLOptions.VerifyMode:=[];
        SSLOptions.VerifyDepth:=0;
        ConnectTimeout:=0;
      end;
      MySMTP.UseTLS:=utUseImplicitTLS;

      if ParC90_EMailUseTLS.ToUpper = 'NO' then
        MySMTP.UseTLS:=utNoTLSSupport
      else if ParC90_EMailUseTLS.ToUpper = 'IMPLICIT' then
        MySMTP.UseTLS:=utUseImplicitTLS
      else if ParC90_EMailUseTLS.ToUpper = 'EXPLICIT' then
        MySMTP.UseTLS:=utUseExplicitTLS
      else if ParC90_EMailUseTLS.ToUpper = 'REQUIRE' then
        MySMTP.UseTLS:=utUseRequireTLS;

      if ParC90_EMailPort = '587' then
        MySMTP.UseTLS:=utUseExplicitTLS;
    end;
    MySMTP.Connect;
    MySMTP.Username:=ParC90_EMailUserName.Trim;
    MySMTP.Password:=ParC90_EMailPassword.Trim;
  except
    on e:exception do
      Result:=e.Message;
  end;
end;

function TmedpSendMail.Invia(Dest,Oggetto,Msg:string):string;
begin
  Result:='';
  try
    if not MySMTP.Connected then
      Result:=ConnettiSMTP.Trim;
    try
      MyMessage.ContentType:='text/plain; charset=ISO-8859-15';
      MyMessage.From.Address:=ParC90_EMailSenderIndirizzo; // 'irisweb@mondoedp.com' è il default
      MyMessage.From.Name:='IrisWEB';
      MyMessage.BccList.Clear;
      MyMessage.Recipients.Clear;
      MyMessage.CCList.Clear;
      MyMessage.Recipients.EmailAddresses:=Dest;
      MyMessage.Subject:=Oggetto;
      MyMessage.MessageParts.Clear;
      MyMessage.Body.Text:=Msg;
      MySMTP.Send(MyMessage);
    finally
      MySMTP.Disconnect;
    end;
  except
    on e:exception do
      Result:=e.Message;
  end;
end;

function TmedpSendMail.Invia(Dest,DestCC,DestCCN,Oggetto,Msg:string):string;
begin
  Result:='';
  try
    if not MySMTP.Connected then
      Result:=ConnettiSMTP.Trim;
    try
      MyMessage.ContentType:='text/plain; charset=ISO-8859-15';
      MyMessage.From.Address:=ParC90_EMailSenderIndirizzo; // 'irisweb@mondoedp.com' è il default
      MyMessage.From.Name:='IrisWEB';
      MyMessage.BccList.Clear;
      MyMessage.Recipients.Clear;
      MyMessage.CCList.Clear;
      MyMessage.Recipients.EmailAddresses:=Dest;
      MyMessage.CCList.EMailAddresses:=DestCC;
      MyMessage.BccList.EMailAddresses:=DestCCN;
      MyMessage.Subject:=Oggetto;
      MyMessage.MessageParts.Clear;
      MyMessage.Body.Text:=Msg;
      MySMTP.Send(MyMessage);
    finally
      MySMTP.Disconnect;
    end;
  except
    on e:exception do
      Result:=e.Message;
  end;
end;

destructor TmedpSendMail.Destroy;
begin
  MySMTP.Disconnect;
  if (ParC90_EMailAuthType.Trim <> '') and (ParC90_EMailAuthType.Trim <> 'No autenticazione') then
    MySMTP.IOHandler.Free;
  FreeAndNil(MyMessage);
  FreeAndNil(MySMTP);
  inherited;
end;

end.