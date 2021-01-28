unit A044UAllineaStorici;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ExtCtrls, A000UCostanti, A000USessione,A000UInterfaccia,
  C700USelezioneAnagrafe, DBCtrls,DB,C180FunzioniGenerali, Menus, StrUtils,
  SelAnagrafe, C005UDatiAnagrafici, Variants, A000UMessaggi, A083UMsgElaborazioni;

type
  TA044FAllineaStorici = class(TForm)
    EnBBUpDate: TBitBtn;
    StatusBar: TStatusBar;
    Progress: TProgressBar;
    BtnClose: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    cbxAllineaMovSucc: TCheckBox;
    gbxOttimizzaPeriodiStorici: TGroupBox;
    gbxEsecuzioneImmediata: TGroupBox;
    cbxPresenze: TCheckBox;
    cbxStipendi: TCheckBox;
    gbxSchedulazioneJob: TGroupBox;
    medtOrarioJob: TMaskEdit;
    lblOrarioJob: TLabel;
    sbtnRicreazioneJob: TSpeedButton;
    sbtnApplicaOrario: TSpeedButton;
    lblIdJob: TLabel;
    cbxAssLiberaPresenze: TCheckBox;
    cbxAssLiberaStipendi: TCheckBox;
    btnAnomalie: TBitBtn;
    cbxAllineaPrimoStorico: TCheckBox;
    procedure EnBBUpDateClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxAllineaMovSuccClick(Sender: TObject);
    procedure cbxPresenzeClick(Sender: TObject);
    procedure cbxStipendiClick(Sender: TObject);
    procedure sbtnApplicaOrarioJobClick(Sender: TObject);
    procedure sbtnRicreazioneJobClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure cbxAllineaPrimoStoricoClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbilitaComponenti;
    function VisualizzaDatiJob(Creazione: Boolean):String;
   public
    { Public declarations }
    AbilCont:Boolean;
  end;

var
  A044FAllineaStorici: TA044FAllineaStorici;

procedure OpenA044AllineaStorici(Prog:LongInt);

implementation

uses A044UAllineaStoriciDtM1;

{$R *.DFM}

procedure OpenA044AllineaStorici(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA044AllineaStorici') of
    'N','R':
      begin
        ShowMessage('Funzione non abilitata!');
        Exit;
      end;
  end;
  A044FAllineaStorici:=TA044FAllineaStorici.Create(nil);
  with A044FAllineaStorici do
    try
      C700Progressivo:=Prog;
      A044FAllineaStoriciDtM1:=TA044FAllineaStoriciDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A044FAllineaStoriciDtM1.Free;
      Free;
    end;
end;

procedure TA044FAllineaStorici.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A044FAllineaStoriciDtM1.A044FAllineaStoriciMW,SessioneOracle,StatusBar,0,False);
  VisualizzaDatiJob(False);
end;

procedure TA044FAllineaStorici.EnBBUpDateClick(Sender: TObject);
var
  Msg: String;
begin
  Screen.Cursor:=crHourGlass;
  RegistraMsg.IniziaMessaggio('A044');
  btnAnomalie.Enabled:=False;
  C700SelAnagrafe.First;
  Progress.Max:=C700SelAnagrafe.RecordCount;
  Progress.Position:=0;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      Progress.Position:=Progress.Position + 1;
      if cbxAllineaMovSucc.Checked then
        A044FAllineaStoriciDtM1.A044FAllineaStoriciMW.AllineamentoPeriodi(C700Progressivo)
      else if cbxAllineaPrimoStorico.Checked then
        A044FAllineaStoriciDtM1.A044FAllineaStoriciMW.AllineamentoPrimaDecorrenza(C700Progressivo)
      else if (cbxPresenze.Checked) or (cbxStipendi.Checked) then
      begin
        Msg:=A044FAllineaStoriciDtM1.A044FAllineaStoriciMW.OttimizzazionePeriodi(C700Progressivo,
                                                                            cbxPresenze.Checked,
                                                                            cbxAssLiberaPresenze.Checked,
                                                                            cbxStipendi.Checked,
                                                                            cbxAssLiberaStipendi.Checked);
        if Msg <> '' then
          RegistraMsg.InserisciMessaggio('A',Msg,'',C700Progressivo);
      end;
      C700SelAnagrafe.Next;
    end;
  finally
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    SessioneOracle.Commit;
    Progress.Position:=0;
    Screen.Cursor:=crDefault;
    btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    if btnAnomalie.Enabled then
    begin
      if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
        btnAnomalieClick(nil);
    end
    else
      R180MessageBox('Elaborazione terminata',INFORMA);

  end;
end;

procedure TA044FAllineaStorici.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A044','');
  C700DatiSelezionati:=C700TuttiCampi;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A044FAllineaStoriciDtM1.A044FAllineaStoriciMW);
end;

procedure TA044FAllineaStorici.cbxAllineaMovSuccClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA044FAllineaStorici.cbxAllineaPrimoStoricoClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA044FAllineaStorici.cbxPresenzeClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA044FAllineaStorici.cbxStipendiClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TA044FAllineaStorici.sbtnApplicaOrarioJobClick(Sender: TObject);
var
  Mess:String;
begin
  if medtOrarioJob.Text <> '__.__' then
    with A044FAllineaStoriciDtM1.A044FAllineaStoriciMW do
    begin
      ImpostaOraJob(medtOrarioJob.Text);
      Mess:=VisualizzaDatiJob(False);
      ShowMessage(Mess);
    end
  else
    ShowMessage(A000MSG_A044_ERR_ORA_JOB);
end;

procedure TA044FAllineaStorici.sbtnRicreazioneJobClick(Sender: TObject);
var
  Mess:String;
begin
  with A044FAllineaStoriciDtM1.A044FAllineaStoriciMW do
  begin
    RicreaJob;
    Mess:=VisualizzaDatiJob(True);
    ShowMessage(Mess);
  end;
end;

function TA044FAllineaStorici.VisualizzaDatiJob(Creazione: Boolean): String;
var
  Msg, idJob,OraJob:String;
  ProssimaEsecuzione: TDateTime;
begin
  if Creazione then
    Msg:=A000MSG_A044_MSG_CREATO
  else
    Msg:=A000MSG_A044_MSG_SCHEDULATO;

  if A044FAllineaStoriciDtM1.A044FAllineaStoriciMW.getDatiJob(idJob,OraJob,ProssimaEsecuzione) then
  begin
    lblIdJob.Caption:='Id job: ' + idJob;
    lblIdJob.Font.Color:=clBlue;
    if OraJob <> '' then
    begin
      medtOrarioJob.Text:=OraJob;
      Result:=Format(A000MSG_A044_DLG_FMT_ESEC_JOB,[Msg,FormatDateTime('dd/mm/yyyy hh.nn.ss',ProssimaEsecuzione)]);
    end
    else
    begin
      medtOrarioJob.Text:='__.__';
      Result:=Format(A000MSG_A044_MSG_FMT_JOB,[Msg]);
    end;
  end
  else
  begin
    if Creazione then
      Result:=A000MSG_A044_ERR_JOB_NON_CREATO
    else
      Result:=A000MSG_A044_ERR_JOB_INESISTENTE;
    lblIdJob.Caption:=A000MSG_A044_ERR_JOB_INESISTENTE;
    lblIdJob.Font.Color:=clRed;
  end;
end;

procedure TA044FAllineaStorici.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA044FAllineaStorici.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA044FAllineaStorici.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA044FAllineaStorici.AbilitaComponenti;
begin
  if cbxAllineaMovSucc.Checked then
  begin
    cbxAllineaPrimoStorico.Checked:=False;
    cbxAllineaPrimoStorico.Enabled:=False;
  end;
  if cbxAllineaPrimoStorico.Checked then
  begin
    cbxAllineaMovSucc.Checked:=False;
    cbxAllineaMovSucc.Enabled:=False;
  end;
  if cbxAllineaMovSucc.Checked or cbxAllineaPrimoStorico.Checked then
  begin
    cbxPresenze.Checked:=False;
    cbxStipendi.Checked:=False;
    cbxPresenze.Enabled:=False;
    cbxStipendi.Enabled:=False;
    cbxAssLiberaPresenze.Checked:=False;
    cbxAssLiberaStipendi.Checked:=False;
    cbxAssLiberaPresenze.Enabled:=False;
    cbxAssLiberaStipendi.Enabled:=False;
  end
  else
  begin
    cbxPresenze.Enabled:=True;
    cbxStipendi.Enabled:=True;
  end;
  cbxAssLiberaPresenze.Enabled:=cbxPresenze.Checked;
  cbxAssLiberaStipendi.Enabled:=cbxStipendi.Checked;
  if not cbxPresenze.Checked then
    cbxAssLiberaPresenze.Checked:=False;
  if not cbxStipendi.Checked then
    cbxAssLiberaStipendi.Checked:=False;
  if (cbxPresenze.Checked) or (cbxStipendi.Checked) then
  begin
    cbxAllineaMovSucc.Checked:=False;
    cbxAllineaMovSucc.Enabled:=False;
    cbxAllineaPrimoStorico.Checked:=False;
    cbxAllineaPrimoStorico.Enabled:=False;
  end
  else
  begin
    cbxAllineaMovSucc.Enabled:=not cbxAllineaPrimoStorico.Checked;
    cbxAllineaPrimoStorico.Enabled:=not cbxAllineaMovSucc.Checked;
  end;
  EnBBUpDate.Enabled:=(cbxAllineaMovSucc.Checked) or (cbxAllineaPrimoStorico.Checked) or (cbxPresenze.Checked) or (cbxStipendi.Checked);
end;

end.
