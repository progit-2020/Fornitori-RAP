unit Ac08URegistraIndFunzione;

interface

uses
  StdCtrls, Mask, Buttons, Controls, ExtCtrls, Forms, ComCtrls, Classes, Dialogs, SysUtils, StrUtils, OracleData,
  A000UMessaggi, A000UInterfaccia, A000USessione, A003UDataLavoroBis, A083UMsgElaborazioni,
  C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe, SelAnagrafe,
  Vcl.Samples.Spin;

type
  TAc08FRegistraIndFunzione = class(TForm)
    StatusBar: TStatusBar;
    ProgressBar1: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel1: TPanel;
    btnAnomalie: TBitBtn;
    BtnClose: TBitBtn;
    btnEsegui: TBitBtn;
    chkCalcola: TCheckBox;
    chkAnnulla: TCheckBox;
    lblAnno: TLabel;
    lblMese: TLabel;
    lblDa: TLabel;
    lblA: TLabel;
    edtAnno: TSpinEdit;
    cmbMese: TComboBox;
    edtDa: TSpinEdit;
    edtA: TSpinEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure cmbMeseChange(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure chkCalcolaClick(Sender: TObject);
  private
    { Private declarations }
    DataI,DataF:TDateTime;
    procedure CalcolaDate(var DataI,DataF:TDateTime);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
  end;

var
  Ac08FRegistraIndFunzione: TAc08FRegistraIndFunzione;

procedure OpenAc08RegistraIndFunzione(Prog:LongInt;DataDal,DataAl:TDateTime);

implementation

uses Ac08URegistraIndFunzioneDM;

{$R *.DFM}

procedure OpenAc08RegistraIndFunzione(Prog:LongInt;DataDal,DataAl:TDateTime);
{Inserimento automatico dei riposi}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc08RegistraIndFunzione') of
    'N','R':
      begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
      end;
  end;
  Ac08FRegistraIndFunzione:=TAc08FRegistraIndFunzione.Create(nil);
  with Ac08FRegistraIndFunzione do
    try
      C700Progressivo:=Prog;
      DataI:=DataDal;
      DataF:=DataAl;
      Ac08FRegistraIndFunzioneDM:=TAc08FRegistraIndFunzioneDM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Ac08FRegistraIndFunzioneDM.Free;
      Free;
    end;
end;

procedure TAc08FRegistraIndFunzione.FormCreate(Sender: TObject);
begin
  inherited;
  C700Progressivo:=0;
  A000SettaVariabiliAmbiente;
end;

procedure TAc08FRegistraIndFunzione.FormShow(Sender: TObject);
var AA,MM,GG:Word;
begin
  inherited;
  edtAnno.OnChange:=nil;
  CreaC004(SessioneOracle,'Ac08',Parametri.ProgOper);
  GetParametriFunzione;
  if DataI > 0 then //richiamo esterno
  begin
    DecodeDate(DataI,AA,MM,GG);
    edtAnno.Value:=AA;
    cmbMese.ItemIndex:=MM - 1;
    edtDa.MaxValue:=R180GiorniMese(EncodeDate(AA,MM,GG));
    edtA.MaxValue:=edtDa.MaxValue;
    edtDa.Value:=GG;
    DecodeDate(DataF,AA,MM,GG);
    edtA.Value:=GG;
  end;
  CalcolaDate(DataI,DataF);
  edtAnno.OnChange:=cmbMeseChange;
  chkCalcola.Checked:=True;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(Ac08FRegistraIndFunzioneDM.Ac08MW,SessioneOracle,StatusBar,0,False);
  //Disabilito anomalie
  btnAnomalie.Enabled:=False;
  if Trim(Parametri.CampiRiferimento.C3_Indennita_Funzione) = '' then
  begin
    ShowMessage(A000MSG_Ac08_ERR_CAMPO_RIFERIMENTO);
    Close;
  end;
end;

procedure TAc08FRegistraIndFunzione.GetParametriFunzione;
var AA,MM,GG:Word;
begin
  DecodeDate(StrToDate(C004FParamForm.GetParametro('edtDallaData',FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro)))),AA,MM,GG);
  edtAnno.Value:=AA;
  cmbMese.ItemIndex:=MM - 1;
  edtDa.MaxValue:=R180GiorniMese(EncodeDate(AA,MM,GG));
  edtA.MaxValue:=edtDa.MaxValue;
  edtDa.Value:=GG;
  DecodeDate(StrToDate(C004FParamForm.GetParametro('edtAllaData',FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro)))),AA,MM,GG);
  edtA.Value:=GG;
end;

procedure TAc08FRegistraIndFunzione.PutParametriFunzione;
begin
  CalcolaDate(DataI,DataF);
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('edtDallaData',DateToStr(DataI));
  C004FParamForm.PutParametro('edtAllaData',DateToStr(DataF));
  try SessioneOracle.Commit; except end;
end;

procedure TAc08FRegistraIndFunzione.FormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TAc08FRegistraIndFunzione.CalcolaDate(var DataI,DataF:TDateTime);
var AA,GG,MM:Word;
begin
  AA:=edtAnno.Value;
  MM:=cmbMese.ItemIndex + 1;
  GG:=edtDa.Value;
  DataI:=EncodeDate(AA,MM,GG);
  GG:=edtA.Value;
  DataF:=EncodeDate(AA,MM,GG);
end;

procedure TAc08FRegistraIndFunzione.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  CalcolaDate(DataI,DataF);
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TAc08FRegistraIndFunzione.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  CalcolaDate(DataI,DataF);
  C700DataDal:=DataI;
  C700DataLavoro:=DataF;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TAc08FRegistraIndFunzione.cmbMeseChange(Sender: TObject);
var DataApp:TDateTime;
begin
  try
    DataApp:=EncodeDate(edtAnno.Value,cmbMese.ItemIndex + 1,1);
  except
    exit;
  end;
  if (edtDa.Value = 1) and (edtA.Value = edtA.MaxValue) then
  begin
    edtA.MaxValue:=R180GiorniMese(DataApp);
    edtA.Value:=R180GiorniMese(DataApp);
  end;
  edtDa.MaxValue:=R180GiorniMese(DataApp);
  edtA.MaxValue:=R180GiorniMese(DataApp);
  if edtDa.Value > edtDa.MaxValue then
    edtDa.Value:=edtDa.MaxValue;
  if edtA.Value > edtA.MaxValue then
    edtA.Value:=edtA.MaxValue;
end;

procedure TAc08FRegistraIndFunzione.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'Ac08','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TAc08FRegistraIndFunzione.btnEseguiClick(Sender: TObject);
var OldProg:Integer;
begin
  with Ac08FRegistraIndFunzioneDM.Ac08MW do
  begin
    Operazione:=IfThen(chkCalcola.Checked,'I',IfThen(chkAnnulla.Checked,'C'));
    CalcolaDate(DataI,DataF);
    dDallaData:=DataI;
    dAllaData:=DataF;
    Controlli;
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(dDallaData,dAllaData) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    Domande;
  end;
  btnAnomalie.Enabled:=False;
  frmSelAnagrafe.pnlSelAnagrafe.Enabled:=False;
  Panel1.Enabled:=False;
  OldProg:=C700Progressivo;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  frmSelAnagrafe.OnCambiaProgressivo:=nil;
  C700SelAnagrafe.First;
  Screen.Cursor:=crHourglass;
  Ac08FRegistraIndFunzioneDM.Ac08MW.InizioElaborazione;
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  try
    while not C700SelAnagrafe.Eof do
    begin
      ProgressBar1.StepBy(1);
      Application.ProcessMessages;
      frmSelAnagrafe.VisualizzaDipendente;
      frmSelAnagrafe.NumRecords;
      Ac08FRegistraIndFunzioneDM.Ac08MW.ElaboraDipendente;
      C700SelAnagrafe.Next;
    end;
  finally
    Ac08FRegistraIndFunzioneDM.Ac08MW.FineElaborazione;
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;
    frmSelAnagrafe.pnlSelAnagrafe.Enabled:=True;
    Panel1.Enabled:=True;
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB;
  if frmSelAnagrafe.ElaborazioneInterrotta then
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_INTERROTTA,INFORMA);
  if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
  begin
    if R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else if not frmSelAnagrafe.ElaborazioneInterrotta then
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
  frmSelAnagrafe.ElaborazioneInterrotta:=False;
end;

procedure TAc08FRegistraIndFunzione.chkCalcolaClick(Sender: TObject);
begin
  chkCalcola.Enabled:=not chkAnnulla.Checked;
  chkAnnulla.Enabled:=not chkCalcola.Checked;
  if not (Sender as TCheckBox).Enabled then
    (Sender as TCheckBox).Checked:=False;
end;

end.
