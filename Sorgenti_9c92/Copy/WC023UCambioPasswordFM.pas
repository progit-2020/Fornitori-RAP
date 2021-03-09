unit WC023UCambioPasswordFM;

interface

uses
  Winapi.Windows, Winapi.Messages, StrUtils, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompCheckbox, meIWCheckBox,
  IWCompButton, meIWButton, IWCompLabel, meIWLabel, IWVCLBaseControl, IWApplication,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, meIWEdit, IWHTMLControls,
  Oracle, A000UInterfaccia, C180FunzioniGenerali;

type
  TWC023FCambioPasswordFM = class(TWR200FBaseFM)
    edtPwdAttuale: TmeIWEdit;
    edtNuovaPwd: TmeIWEdit;
    edtConfermaPwd: TmeIWEdit;
    edtEMail: TmeIWEdit;
    lblPwdAttuale: TmeIWLabel;
    lblNuovaPwd: TmeIWLabel;
    lblConfermaPwd: TmeIWLabel;
    lblEMail: TmeIWLabel;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    chkRicMail: TmeIWCheckBox;
    lblRicMail: TmeIWLabel;
    procedure btnConfermaClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    VecchiaEMail: String;
    VecchiaRicezioneMail: Boolean;
  public
    procedure Visualizza;
  end;

implementation

uses WR010UBase;

{$R *.dfm}

procedure TWC023FCambioPasswordFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  if WR000DM.TipoUtente = 'Dipendente' then
  begin
    with TOracleQuery.Create(GGetWebApplicationThreadVar) do
      try
        Session:=SessioneOracle;
        //Lettura vecchia E-Mail
        SQL.Add('SELECT EMAIL FROM MONDOEDP.I060_LOGIN_DIPENDENTE ');
        SQL.Add('WHERE NOME_UTENTE = ''' + Parametri.Operatore + '''');
        SQL.Add('AND AZIENDA = ''' + Parametri.Azienda + '''');
        Execute;
        VecchiaEMail:=FieldAsString('EMail');
        edtEMail.Text:=VecchiaEMail;
        //Lettura vecchio stato ricezione E-Mail
        VecchiaRicezioneMail:=False;
        SQL.Clear;
        SQL.Add('SELECT I061.RICEZIONE_MAIL');
        SQL.Add('  FROM MONDOEDP.I061_PROFILI_DIPENDENTE I061');
        SQL.Add(' WHERE I061.AZIENDA = ''' + Parametri.Azienda + '''');
        SQL.Add('   AND I061.NOME_UTENTE = ''' + Parametri.Operatore + '''');
        SQL.Add('   AND I061.NOME_PROFILO = ''' + Parametri.ProfiloWEB + '''');
        Execute;
        if RowCount > 0 then
          VecchiaRicezioneMail:=FieldAsString ('RICEZIONE_MAIL') = 'S';
        chkRicMail.Checked:=VecchiaRicezioneMail;
      finally
        Free;
      end;
  end
  else
  begin
    lblEMail.Visible:=False;
    edtEMail.Visible:=False;
    lblRicMail.Visible:=False;
    chkRicMail.Visible:=False;
  end;
end;

procedure TWC023FCambioPasswordFM.Visualizza;
begin
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,338,218,218, 'Cambio Password','#wc023_container',False,True);
end;

procedure TWC023FCambioPasswordFM.btnConfermaClick(Sender: TObject);
var
  NuovaPwd, NuovaEMail, Err: Boolean;
  S,Dominio,ErrMsg: String;
begin
  if (sender = btnConferma) then
  begin
    S:='';
    NuovaPwd:=False;
    NuovaEMail:=False;
    Err:=True;
    Dominio:=IfThen(WR000DM.TipoUtente = 'Dipendente',Parametri.AuthDomInfo.DominioDip,Parametri.AuthDomInfo.DominioUsr);
    if edtNuovaPwd.Text <> edtPwdAttuale.Text then
    begin
      NuovaPwd:=True;
      //Parametri.RegolePassword.PasswordI060:=False;
      if (Dominio = '') or (Length(edtNuovaPwd.Text) > 0) then
        S:=Parametri.RegolePassword.PasswordValida(edtNuovaPwd.Text);

      if edtPwdAttuale.Text <> Parametri.PassOper then
        ErrMsg:='La password attuale indicata è errata!'
      else if edtNuovaPwd.Text <> edtConfermaPwd.Text then
        ErrMsg:='La nuova password non è stata confermata correttamente!'
      else if S <> '' then
        ErrMsg:=S
      (*
      // controllo lunghezza password solo se dominio di autenticazione non specificato
      //else if Length(edtNuovaPwd.Text) < Parametri.LunghezzaPassword then
      else if (Length(edtNuovaPwd.Text) < Parametri.LunghezzaPassword) and
              ((Dominio = '') or (Length(edtNuovaPwd.Text) > 0)) then
        ErrMsg:=Format('La password deve essere di almeno %d caratteri!',[Parametri.LunghezzaPassword])
      // controllo caratteri password per crittografia su db - daniloc. 25.01.2011
      else if not R180CtrlCripta(edtNuovaPwd.Text) then
        ErrMsg:='La nuova password contiene caratteri non ammessi!'
      *)
      else
      begin
        Err:=False;
        if WR000DM.TipoUtente = 'Dipendente' then
          S:='PASSWORD = ''' + AggiungiApice(R180Cripta(edtNuovaPwd.Text, 30011945)) + ''', DATA_PW = TRUNC(SYSDATE)';
      end;

      // messaggio di errore
      if Err then
      begin
        edtNuovaPwd.Clear;
        edtConfermaPwd.Clear;
        //ActiveControl:=edtNuovaPwd;
        MsgBox.MessageBox(ErrMsg,ESCLAMA);
        Exit;
      end;
    end;
    if WR000DM.TipoUtente = 'Dipendente' then
      if edtEMail.Text <> VecchiaEMail then
      begin
        NuovaEMail:=True;
        if (Length(edtEMail.Text) > 0) and ((Pos('@', edtEMail.Text) = 0) or (Pos('.', edtEMail.Text) = 0)) then
          GGetWebApplicationThreadVar.ShowMessage('Indirizzo e-mail non valido.')
        else
        begin
          Err:=False;
          S:=IfThen(Length(S) > 0, S + ', ', '') + 'EMAIL = ''' + edtEMail.Text + '''';
        end;
      end;
    //Aggiornamento PASSWORD e/o EMAIL
    if (chkRicMail.Checked <> VecchiaRicezioneMail) and (WR000DM.TipoUtente = 'Dipendente') then
    begin
      with TOracleQuery.Create(GGetWebApplicationThreadVar) do
        try
          Session:=SessioneOracle;
          SQL.Add('UPDATE MONDOEDP.I061_PROFILI_DIPENDENTE I061');
          SQL.Add('   SET I061.RICEZIONE_MAIL = ''' + ifThen(chkRicMail.Checked,'S','N') + '''');
          SQL.Add(' WHERE I061.AZIENDA = ''' + Parametri.Azienda + '''');
          SQL.Add('   AND I061.NOME_UTENTE = ''' + Parametri.Operatore + '''');
          SQL.Add('   AND I061.NOME_PROFILO = ''' + Parametri.ProfiloWEB + '''');
          Execute;
          SessioneOracle.Commit;
        finally
          Free;
        end;
    end;
    //Aggiornamento RICEZIONE_MAIL
    if NuovaEMail or NuovaPwd then
    begin
      if not Err then
        with TOracleQuery.Create(GGetWebApplicationThreadVar) do
        begin
          try
            Session:=SessioneOracle;
            if WR000DM.TipoUtente = 'Dipendente' then
            begin
              SQL.Add('UPDATE MONDOEDP.I060_LOGIN_DIPENDENTE SET ' + S);
              SQL.Add('WHERE NOME_UTENTE = ''' + Parametri.Operatore + '''');
              SQL.Add('AND AZIENDA = ''' + Parametri.Azienda + '''');
            end
            else
            begin
              SQL.Add('UPDATE MONDOEDP.I070_UTENTI SET PASSWD = ''' + R180CriptaI070(edtNuovaPwd.Text) + '''');
              SQL.Add(',DATA_PW = TRUNC(SYSDATE)');
              SQL.Add('WHERE PROGRESSIVO = ' + IntToStr(Parametri.ProgOper));
            end;
            Execute;
            SessioneOracle.Commit;
            if RowsProcessed <> 0 then
              Parametri.PassOper:=edtNuovaPwd.Text;
          finally
            Free;
          end;
        end;
    end;
    if NuovaEMail or NuovaPwd or (chkRicMail.Checked <> VecchiaRicezioneMail) then
    begin
      //ClosePage;
      if NuovaPwd then
        GGetWebApplicationThreadVar.ShowMessage('La password è stata modificata correttamente!');
    end
    else
      GGetWebApplicationThreadVar.ShowMessage('Non sono stati modificati né l''indirizzo e-mail né la password!');
  end;

  Free;
end;


end.
