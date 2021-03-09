unit B005UInvioEMail;

interface

uses
  Windows, Messages, StrUtils, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IdMessage, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdExplicitTLSClientServerBase, IdSMTPBase, IDAttachment, IDAttachmentFile, IDText,
  A000UCostanti, C004UParamForm, C180FunzioniGenerali;

type
  TB005FInvioEMail = class(TForm)
    Label1: TLabel;
    edtindirizzo: TEdit;
    Label2: TLabel;
    edtServer: TEdit;
    btnInvia: TBitBtn;
    btnChiudi: TBitBtn;
    Label3: TLabel;
    edtUtente: TEdit;
    Label4: TLabel;
    edtPassword: TEdit;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    btnDatiAziendali: TButton;
    procedure edtindirizzoChange(Sender: TObject);
    procedure btnInviaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDatiAziendaliClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B005FInvioEMail: TB005FInvioEMail;

implementation

uses B005UAggIrisDtM1;

{$R *.dfm}

procedure TB005FInvioEMail.FormShow(Sender: TObject);
begin
  edtIndirizzo.Text:=C004FParamForm.GetParametro('INDIRIZZO','');
  edtServer.Text:=C004FParamForm.GetParametro('SERVER','');
  edtUtente.Text:=C004FParamForm.GetParametro('UTENTE','');
  edtPassword.Text:=R180Decripta(C004FParamForm.GetParametro('PASSWORD',''),I091CryptKey);
  B005FAggIrisDtM1.selI091.Open;
  btnDatiAziendali.Enabled:=B005FAggIrisDtM1.selI091.RecordCount > 0;
end;

procedure TB005FInvioEMail.edtindirizzoChange(Sender: TObject);
begin
  //btnInvia.Enabled:=(edtIndirizzo.Text <> '') and (edtServer.Text <> '');
end;

procedure TB005FInvioEMail.btnDatiAziendaliClick(Sender: TObject);
begin
//('C90_EMAIL_SENDER_INDIRIZZO','C90_EMAIL_SMTPHOST','C90_EMAIL_USERNAME','C90_EMAIL_PASSWORD')
  if B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_SENDER_INDIRIZZO','DATO') <> null then
    edtIndirizzo.Text:=B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_SENDER_INDIRIZZO','DATO');
  if B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_SMTPHOST','DATO') <> null then
    edtServer.Text:=B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_SMTPHOST','DATO');
  if B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_USERNAME','DATO') <> null then
    edtUtente.Text:=B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_USERNAME','DATO');
  if B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_PASSWORD','DATO') <> null then
    edtPassword.Text:=B005FAggIrisDtM1.selI091.Lookup('TIPO','C90_EMAIL_PASSWORD','DATO');
end;

procedure TB005FInvioEMail.btnInviaClick(Sender: TObject);
var F:TSearchRec;
    FileSearch:String;
begin
  if (Pos('@',edtIndirizzo.Text) = 0) or (Length(edtIndirizzo.Text) < 3) then
    raise Exception.Create('E'' necessario specificare un indirizzo valido per il mittente');

  Screen.Cursor:=crHourGlass;
  try
    IdSMTP.Host:=IfThen(edtServer.Text = '','mail.mondoedp.com',edtServer.Text);//edtServer.Text;
    IdSMTP.HeloName:=IfThen(IdSMTP.Host = 'mail.mondoedp.com','smtp@mondoext.net',edtUtente.Text);
    IdSMTP.Connect;
    //IdSMTP.AuthenticationType:=atLogin;
    IdSMTP.AuthType:=satDefault;
    IdSMTP.Username:=IfThen(IdSMTP.Host = 'mail.mondoedp.com','smtp@mondoext.net',edtUtente.Text);
    IdSMTP.Password:=IfThen(IdSMTP.Host = 'mail.mondoedp.com','SmTP3xt!13E8p',edtPassword.Text);
    IdMessage.ContentType:='text/plain; charset=ISO-8859-15';
    IdMessage.From.Address:=edtIndirizzo.Text;
    IdMessage.Sender.Address:=edtIndirizzo.Text;;
    IdMessage.Recipients.Clear;
    IdMessage.Recipients.Add;
    IdMessage.BccList.Clear;
    //IdMessage.BccList.Add;
    //IdMessage.BCCList[IdMessage.BCCList.Count  - 1].Address:='assistenza@mondoedp.com';
    IdMessage.Recipients.EmailAddresses:='assistenza@mondoedp.com';
    IdMessage.Subject:='Aggiornamento IrisWIN: LOG';
    IdMessage.MessageParts.Clear;

    FileSearch:=ExtractFilePath(Application.ExeName) + 'Script_*.log';
    if FindFirst(FileSearch,$3F,F) = 0 then
    repeat
      TIdAttachmentFile.Create(IdMessage.MessageParts, ExtractFilePath(Application.ExeName) + F.Name);
    until FindNext(F) <> 0;
    FindClose(F);
    FileSearch:=ExtractFilePath(Application.ExeName) + 'Proc_*.log';
    if FindFirst(FileSearch,$3F,F) = 0 then
    repeat
      TIdAttachmentFile.Create(IdMessage.MessageParts, ExtractFilePath(Application.ExeName) + F.Name);
    until FindNext(F) <> 0;
    FindClose(F);

    try
      IdSMTP.Send(IdMessage);
    except
      on E:Exception do
        if (*(IdSMTP.AuthSchemesSupported.IndexOf('LOGIN') >= 0) and*) (edtUtente.Text = '') then
          raise Exception.Create('Si è verificato l''errore:' + #13 + E.Message + #13 + #13 + 'Provare a specificare Utente e Password');
        else
          raise;
    end;
    ShowMessage('Messaggio inviato');
  finally
    Screen.Cursor:=crDefault;
    IdSMTP.Disconnect;
  end;
end;

procedure TB005FInvioEMail.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  C004FParamForm.PutParametro('INDIRIZZO',edtIndirizzo.Text);
  C004FParamForm.PutParametro('SERVER',edtServer.Text);
  C004FParamForm.PutParametro('UTENTE',edtUtente.Text);
  C004FParamForm.PutParametro('PASSWORD',R180Cripta(edtPassword.Text,I091CryptKey));
  B005FAggIrisDtM1.DBAggIris.Commit;
  Close;
end;

end.

