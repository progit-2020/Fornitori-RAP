unit W030UTabelloneTurni;

interface

uses
  SysUtils, StrUtils, Classes, Graphics, Controls,
  IWTemplateProcessorHTML, IWCompLabel, IWApplication,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  IWCompButton, OracleData, IWCompCheckbox, RegistrazioneLog, Variants, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWAppForm, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWVCLComponent, DatiBloccati, ActnList, Menus, IWCompMenu, R012UWebAnagrafico,
  IWDBGrids, medpIWDBGrid, DB, DBClient,
  A000UCostanti, A000USessione, A000UInterfaccia, A058UPianifTurniDtm1,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB, Rp502Pro,
  IWTypes, meIWLabel, meIWEdit,
  meIWButton, meIWCheckBox, meIWRadioGroup,W000UMessaggi,
  IWCompExtCtrls, IWCompGrids,IW.Browser.InternetExplorer, meIWImageFile,
  meIWLink, meIWGrid, medpIWTabControl, Forms, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, medpIWMultiColumnComboBox,
  IWMultiColumnComboBox, WA058UTabelloneTurniFM,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component;

type
  TW030FTabelloneTurni = class(TR012FWebAnagrafico)
    procedure IWAppFormCreate(Sender: TObject);
  private
    WA058FM: TWA058FTabelloneTurniFM;
    procedure AggiornaDipendentiDisponibili(Dal,Al: TDateTime);
  protected
    procedure RefreshPage; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.DFM}

procedure TW030FTabelloneTurni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AddScrollBarManager('divtable','WA058');
  CampiV430:='V430.T430BADGE,V430.T430INIZIO,V430.T430FINE,V430.T430DATADECORRENZA,V430.T430DATAFINE';
  WA058FM:=TWA058FTabelloneTurniFM.Create(Self);
  WA058FM.AggiornaDipendentiDisponibili:=AggiornaDipendentiDisponibili;
  with WA058FM  do
  begin
    WA058SelAnagrafe:=selAnagrafeW;
    WA058SolaLettura:=SolaLettura;
    Inizializza;
  end;
end;

function TW030FTabelloneTurni.InizializzaAccesso:Boolean;
begin
  Result:=True;
  if Parametri.Inibizioni.Text = '' then
    GetDipendentiDisponibili(ParametriForm.Dal)
  else
    GetDipendentiDisponibili(ParametriForm.Dal,ParametriForm.Al);
end;

procedure TW030FTabelloneTurni.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  Conferma:=WA058FM.ModificheInCorso;
end;

procedure TW030FTabelloneTurni.RefreshPage;
begin
  inherited;
  WA058FM.RefreshTabellone;
end;

procedure TW030FTabelloneTurni.AggiornaDipendentiDisponibili(Dal, Al: TDateTime);
begin
  if (ParametriForm.Dal <> Dal) or (ParametriForm.Al <> Al) then
  begin
    // salva parametri form
    ParametriForm.Dal:=Dal;
    ParametriForm.Al:=Al;
    // effettua selezione dipendenti periodica nei seguenti due casi:
    // a. utente supervisore oppure
    // b. dipendente con filtro anagrafe impostato
    if (WR000DM.TipoUtente = 'Dipendente') and
       (Trim(Parametri.Inibizioni.Text) = '') then
      GetDipendentiDisponibili(Al)
    else
      GetDipendentiDisponibili(Dal,Al);
  end;
end;

end.
