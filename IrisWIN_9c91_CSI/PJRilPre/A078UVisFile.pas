unit A078UVisFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Printers, C180FunzioniGenerali, Shellapi,
  IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdMessageClient, IdSMTP, IdMessage, IdAntiFreezeBase,
  IdAntiFreeze, IdExplicitTLSClientServerBase, IdSMTPBase, IDAttachment, IDAttachmentFile, IDText;

type
  TA078FVisFile = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    memoComunicazione: TMemo;
    btnStampa: TBitBtn;
    btnStampante: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    btnEMail: TBitBtn;
    btnRegistra: TBitBtn;
    SaveDialog1: TSaveDialog;
    IdSMTP: TIdSMTP;
    IdAntiFreeze1: TIdAntiFreeze;
    IdMessage: TIdMessage;
    procedure btnStampanteClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure btnRegistraClick(Sender: TObject);
    procedure btnEMailClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    F,A:TextFile;
  public
    { Public declarations }
    Contatto,EMail:String;
  end;

var
  A078FVisFile: TA078FVisFile;

implementation

uses A078URichiestaAssistenza;

{$R *.DFM}

procedure TA078FVisFile.btnStampanteClick(Sender: TObject);
begin
  PrinterSetUpDialog1.Execute;
end;

procedure TA078FVisFile.btnStampaClick(Sender: TObject);
var I:Integer;
    Intestazione:String;
begin
  Screen.Cursor:=crHourGlass;
  Intestazione:='Visualizzazione comunicazione';
  AssignPrn(F);
  Rewrite(F);
  try
   Printer.Canvas.Font:=memoComunicazione.Font;
   writeln(F,Intestazione);
   writeln(F,'');
   for I:=0 to memoComunicazione.Lines.Count - 1 do
     writeln(F,memoComunicazione.Lines[I])
  finally
    CloseFile(F);
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA078FVisFile.btnRegistraClick(Sender: TObject);
var NomeFile:String;
begin
  SaveDialog1.Title:='Scelta nome file';
  if SaveDialog1.Execute then
    NomeFile:=SaveDialog1.FileName;
  if Trim(NomeFile) <> '' then
  begin
    AssignFile(A,NomeFile);
    Rewrite(A);
    writeln(A,memoComunicazione.Text);
    CloseFile(A);
    R180MessageBox('Elaborazione terminata!','INFORMA');
  end;
end;

procedure TA078FVisFile.btnEMailClick(Sender: TObject);
begin
  if (Trim(A078FRichiestaAssistenza.edtServer.Text) <> '') {and
     (Trim(A078FRichiestaAssistenza.edtUserID.Text) <> '')} then
  begin
    // msg di conferma perchè non apre Outlook ma invia direttamente il msg
    if R180MessageBox('Confermi invio messaggio?','DOMANDA') = mrYes then
    begin
      IdSMTP.Host:=A078FRichiestaAssistenza.edtServer.Text;
      try
        IdSMTP.Connect;
        //if (IdSMTP.AuthSchemesSupported.IndexOf('LOGIN') >= 0) and (A078FRichiestaAssistenza.edtUserID.Text <> '') then
        begin
          //IdSMTP.AuthType:=atLogin;
          IdSMTP.AuthType:=satDefault;
          IdSMTP.HeloName:=A078FRichiestaAssistenza.edtUserID.Text;
          IdSMTP.Username:=A078FRichiestaAssistenza.edtUserID.Text;
          IdSMTP.Password:=A078FRichiestaAssistenza.edtPassword.Text;
        end;
        IdMessage.ContentType:='text/plain; charset=ISO-8859-15';
        IdMessage.From.Address:=A078FRichiestaAssistenza.edtUserID.Text;
        IdMessage.Sender.Address:=A078FRichiestaAssistenza.edtUserID.Text;
        IdMessage.Recipients.Clear;
        IdMessage.Recipients.Add;
        IdMessage.Recipients[IdMessage.Recipients.Count - 1].Address:='assistenza@mondoedp.com';
        IdMessage.Subject:='Soggetto';
        IdMessage.Body.Assign(memoComunicazione.Lines);
        IdMessage.MessageParts.Clear;
        if FileExists(ExtractFilePath(Application.ExeName) + 'PERMONDOEDP.DMP') then
        begin
          TIdText.Create(IdMessage.MessageParts, memoComunicazione.Lines);
          TIdAttachmentFile.Create(IdMessage.MessageParts, ExtractFilePath(Application.ExeName)+ 'PERMONDOEDP.DMP');
        end;
        IdSMTP.Send(IdMessage);
        IdSMTP.Disconnect;
        ShowMessage('Messaggio inviato');
      except
        ShellExecute(0,'open', pchar('mailto:assistenza@mondoedp.com?subject=All''attenzione di ' + Contatto + '&body=' + EMail),nil,nil,SW_SHOWNORMAL);
      end
    end
  end
  else
    //ShellExecute(0,'open', pchar('mailto:x@x.com?subject=xxx &body=xxx'),
    ShellExecute(0,'open', pchar('mailto:assistenza@mondoedp.com?subject=All''attenzione di ' + Contatto + '&body=' + EMail),nil,nil,SW_SHOWNORMAL);
end;

procedure TA078FVisFile.FormShow(Sender: TObject);
begin
  //btnEMail.Enabled:=Trim(A078FRichiestaAssistenza.edtMail.Text) <> '';
end;

end.
