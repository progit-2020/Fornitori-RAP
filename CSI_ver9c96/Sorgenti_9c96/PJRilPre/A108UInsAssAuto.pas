unit A108UInsAssAuto;

interface

uses Vcl.Dialogs, Vcl.Mask, Vcl.Buttons, Vcl.Controls, Vcl.StdCtrls, Vcl.Forms,
  Vcl.ExtCtrls, SelAnagrafe, Vcl.ComCtrls, System.Classes, SysUtils, Math,
  A000UInterfaccia, A000UMessaggi, A000USessione, Rp502Pro, R600,
  A003UDataLavoroBis, A083UMsgElaborazioni, A108UInsAssAutoMW,
  C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe;

type
  TA108FInsAssAuto = class(TForm)
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel1: TPanel;
    lblMese: TLabel;
    btnEsegui: TBitBtn;
    BtnClose: TBitBtn;
    edtMese: TMaskEdit;
    btnMese: TButton;
    btnAnomalie: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnMeseClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    A108MW: TA108FInsAssAutoMW;
    procedure ScorriQueryAnagrafica;
  public
    { Public declarations }
  end;

var
  A108FInsAssAuto: TA108FInsAssAuto;

procedure OpenA108InsAssAuto(Prog:LongInt);

implementation

{$R *.DFM}

procedure OpenA108InsAssAuto(Prog:LongInt);
{Gestione inserimento automatico assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA108InsAssAuto') of
    'N','R':begin
              ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
              Exit;
            end;
  end;
  A108FInsAssAuto:=TA108FInsAssAuto.Create(nil);
  with A108FInsAssAuto do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA108FInsAssAuto.FormCreate(Sender: TObject);
begin
  A108MW:=TA108FInsAssAutoMW.Create(Self);
  inherited;
  A108MW.Mese:=Parametri.DataLavoro;
  edtMese.Text:=FormatDateTime('mm/yyyy',A108MW.Mese);
end;

procedure TA108FInsAssAuto.FormShow(Sender: TObject);
begin
  BtnAnomalie.Enabled:=False;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A108MW,SessioneOracle,StatusBar,0,False);
end;

procedure TA108FInsAssAuto.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  A108MW.Free;
end;

procedure TA108FInsAssAuto.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=R180FineMese(StrToDate('01/' + edtMese.Text));
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA108FInsAssAuto.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=R180FineMese(StrToDate('01/' + edtMese.Text));
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA108FInsAssAuto.btnMeseClick(Sender: TObject);
begin
  A108MW.Mese:=DataOut(A108MW.Mese,'Mese da elaborare','M');
  edtMese.Text:=FormatDateTime('mm/yyyy',A108MW.Mese);
end;

procedure TA108FInsAssAuto.btnEseguiClick(Sender: TObject);
begin
  try
    A108MW.Mese:=StrToDate('01/' + edtMese.Text);
  except
    raise Exception.Create(A000MSG_A108_ERR_MESE);
  end;
  ScorriQueryAnagrafica;
end;

procedure TA108FInsAssAuto.ScorriQueryAnagrafica;
var DataCorr:TDateTime;
begin
  btnAnomalie.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  RegistraMsg.IniziaMessaggio('A108');
  R180SetVariable(C700SelAnagrafe,'DATALAVORO',R180FineMese(A108MW.Mese));
  C700SelAnagrafe.Open;
  frmSelAnagrafe.NumRecords;
  C700SelAnagrafe.First;
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
  A108MW.R502ProDtM:=TR502ProDtM1.Create(nil);
  A108MW.R502ProDtM.PeriodoConteggi(R180InizioMese(A108MW.Mese),R180FineMese(A108MW.Mese));
  A108MW.R600DtM:=TR600DtM1.Create(nil);
  frmSelAnagrafe.ElaborazioneInterrompibile:=True;
  Self.Enabled:=False;
  try
    while not C700SelAnagrafe.EOF do
    begin
      ProgressBar1.StepBy(1);
      frmSelAnagrafe.VisualizzaDipendente;
      DataCorr:=R180InizioMese(A108MW.Mese);
      A108MW.ResetCompensazione(DataCorr);
      while DataCorr <= R180FineMese(A108MW.Mese) do
      begin
        A108MW.CompensazioneGiornalieraAutomatica(DataCorr);
        DataCorr:=DataCorr + 1;
      end;
      C700SelAnagrafe.Next;
    end;
  finally
    FreeAndNil(A108MW.R502ProDtM);
    FreeAndNil(A108MW.R600DtM);
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA');
end;

procedure TA108FInsAssAuto.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A108','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A108MW);
end;

end.
