unit A008UCambioPassword;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Variants, Oracle,
  RegolePassword, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  TA008FCambioPassword = class(TForm)
    edtPasswordOld: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtPasswordNew: TEdit;
    Label3: TLabel;
    edtPasswordConferma: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    lblScadenza: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A008FCambioPassword: TA008FCambioPassword;

procedure OpenA008GestioneSicurezza(Sessione:TOracleSession; Abort:Boolean);

implementation

{$R *.DFM}

procedure OpenA008GestioneSicurezza(Sessione:TOracleSession; Abort:Boolean);
var MR:TModalResult;
    S:String;
begin
  try
    A008FCambioPassword:=TA008FCambioPassword.Create(nil);
    A008FCambioPassword.BitBtn2.Visible:=Abort;
    while True do
    begin
      A008FCambioPassword.lblScadenza.Visible:=Parametri.RegolePassword.MesiValidita > 0;
      A008FCambioPassword.lblScadenza.Caption:='Scade il ' + DateToStr(R180AddMesi(Date,Parametri.RegolePassword.MesiValidita));
      MR:=A008FCambioPassword.ShowModal;
      if MR = mrAbort then Break;
      if MR <> mrOk then Continue;
      S:=Parametri.RegolePassword.PasswordValida(A008FCambioPassword.edtPasswordNew.Text);
      if A008FCambioPassword.edtPasswordOld.Text <> Parametri.PassOper then
        ShowMessage('Password attuale errata!')
      else if A008FCambioPassword.edtPasswordNew.Text <> A008FCambioPassword.edtPasswordConferma.Text then
        ShowMessage(A000MSG_A186_ERR_DLG_PWD)
      else if A008FCambioPassword.edtPasswordNew.Text = Parametri.PassOper then
        ShowMessage('La nuova password non può essere uguale alla precedente!')
      else if S <> '' then
      begin
        R180MessageBox(S,INFORMA);
        Continue;
      end
      else
        with TOracleQuery.Create(nil) do
        begin
          Session:=Sessione;
          SQL.Add('UPDATE MONDOEDP.I070_UTENTI SET PASSWD = ''' + R180CriptaI070(A008FCambioPassword.edtPasswordNew.Text) + '''');
          SQL.Add(',DATA_PW = TRUNC(SYSDATE)');
          SQL.Add('WHERE PROGRESSIVO = ' + IntToStr(Parametri.ProgOper));
          Execute;
          Sessione.Commit;
          Parametri.PassOper:=A008FCambioPassword.edtPasswordNew.Text;
          Break;
        end;
    end;
  finally
    A008FCambioPassword.Release;
  end;
end;

end.
