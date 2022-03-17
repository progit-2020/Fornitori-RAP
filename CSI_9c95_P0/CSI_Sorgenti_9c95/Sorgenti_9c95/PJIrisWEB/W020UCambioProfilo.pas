unit W020UCambioProfilo;

interface

uses
  R010UPaginaWeb, A000USessione, A000UInterfaccia, C190FunzioniGeneraliWeb, OracleData,
  IWApplication, IWAppForm,SysUtils, Classes, Controls, Math,
  IWCompLabel, Variants, IWVCLBaseControl,Forms, IWVCLBaseContainer, IWContainer,
  DB, StrUtils, meIWLabel, meIWComboBox, meIWEdit, meIWButton, IWCompButton,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWBaseControl, IWBaseHTMLControl, IWHTMLControls,
  meIWLink, IWCompListbox, IWCompEdit, IWControl;

type
  TW020FCambioProfilo = class(TR010FPaginaWeb)
    edtProfiloAttuale: TmeIWEdit;
    lblProfiloAttuale: TmeIWLabel;
    lblProfiloNuovo: TmeIWLabel;
    cmbProfiloNuovo: TmeIWComboBox;
    lblInfoDelega: TmeIWLabel;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure cmbProfiloNuovoAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnConfermaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    procedure PopolaProfili;
    function  GetDelegatoDa(const Profilo: String): String;
  protected
    procedure DistruggiOggetti; override;
  end;

implementation

uses W001UIrisWebDtM;

{$R *.DFM}

procedure TW020FCambioProfilo.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  medpModale:=True;

  // apre dataset dei profili
  with WR000DM.selI061 do
  begin
    Close;
    SetVariable('AZIENDA',Parametri.Azienda);
    SetVariable('NOME_UTENTE',Parametri.Operatore);
    Open;
  end;

  // propone il nome del profilo da associare
  edtProfiloAttuale.Text:=Parametri.ProfiloWEB;
  edtProfiloAttuale.Hint:=GetDelegatoDa(Parametri.ProfiloWEB);
  edtProfiloAttuale.ShowHint:=True;

  // popola la combo dei profili
  PopolaProfili;

  lblInfoDelega.Caption:=GetDelegatoDa(cmbProfiloNuovo.Text);

  // imposta hidden fields da inviare via post
  HiddenFields.Add('azienda=' + Parametri.Azienda);
  HiddenFields.Add('usr=' + Parametri.Operatore);
  HiddenFields.Add('pwd=');
  HiddenFields.Add('profilo=');
  HiddenFields.Add('database=' + Parametri.Database);
  HiddenFields.Add('loginesterno=S');
end;

procedure TW020FCambioProfilo.IWAppFormRender(Sender: TObject);
begin
  inherited;
  btnConferma.Visible:=(not SolaLettura);
end;

procedure TW020FCambioProfilo.DistruggiOggetti;
begin
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    try WR000DM.selI061.CloseAll; except end;
  end;
end;

procedure TW020FCambioProfilo.PopolaProfili;
begin
  // popola la combobox dei profili disponibili per il dipendente alla data odierna
  cmbProfiloNuovo.Items.Clear;
  with WR000DM.selI061 do
  begin
    First;
    while not Eof do
    begin
      if Parametri.ProfiloWEB <> FieldByName('NOME_PROFILO').AsString then
        cmbProfiloNuovo.Items.Add(FieldByName('NOME_PROFILO').AsString);
      Next;
    end;
    // seleziona il primo profilo nell'ordine
    // nota: è sicuramente presente almeno un profilo alternativo
    cmbProfiloNuovo.ItemIndex:=0;
  end;
end;

function TW020FCambioProfilo.GetDelegatoDa(const Profilo: String): String;
// Estrae informazioni per il profilo selezionato
//  Nota importante:
//    NOME_PROFILO identifica univocamente un record, in quanto è impossibile
//    avere più date di inizio validità per come è strutturato il dataset
var
  Inizio,Fine: TDateTime;
begin
  Result:='';
  try
    with WR000DM.selI061 do
    begin
      if SearchRecord('NOME_PROFILO',Profilo,[srFromBeginning]) then
        if not FieldByName('DELEGATO_DA').IsNull then
        begin
          Inizio:=FieldByName('INIZIO_VALIDITA').AsDateTime;
          Fine:=FieldByName('FINE_VALIDITA').AsDateTime;
          Result:='(delegato da ' + FieldByName('DELEGATO_DA').AsString +
                  IfThen(Inizio = Fine,
                         ' per il giorno ' + DateToStr(Inizio),
                         ' dal ' + DateToStr(Inizio) + ' al ' + DateToStr(Fine)) + ')';
        end;
    end;
  except
    Result:='';
  end;
end;

procedure TW020FCambioProfilo.cmbProfiloNuovoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  lblInfoDelega.Caption:=GetDelegatoDa(cmbProfiloNuovo.Text);
end;

procedure TW020FCambioProfilo.btnAnnullaClick(Sender: TObject);
begin
  ClosePage;
end;

{ DONE : TEST IW 15 }
procedure TW020FCambioProfilo.btnConfermaAsyncClick(Sender: TObject; EventParams: TStringList);
var
  AzioneForm,S: String;
begin
  // L'URL indica a IW di creare una nuova sessione per gestire questa richiesta
  if not IsLibrary then
    AzioneForm:='/$/start'
  else
    AzioneForm:=C190IncludeEndingSlash(GGetWebApplicationThreadVar.InternalUrlBase) + 'start';

  // imposta il nuovo profilo (+ la password, in modo che non sia visibile inizialmente)
  // quindi effettua un submit della form SubmitForm con il metodo
  // normale SubmitClick
  S:='var formIris = document.forms["SubmitForm"]; ' +
     'formIris.setAttribute("action","' + AzioneForm + '"); ' +
     'document.getElementById("HIDDEN_pwd").value = "' + Parametri.PassOper + '"; ' +
     'document.getElementById("HIDDEN_profilo").value = "' + cmbProfiloNuovo.Text + '"; ' +
     'formIris.elements["IW_SessionID_"].value="";' +
     'formIris.elements["IW_TrackID_"].value="";' +
     'SubmitClick("' + btnConferma.HTMLName + '", "", true); ';
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(S);

  // tentativo per ridurre il timeout della attuale sessione, che non è più usata
  GGetWebApplicationThreadVar.SessionTimeOut:=2;
end;

end.
