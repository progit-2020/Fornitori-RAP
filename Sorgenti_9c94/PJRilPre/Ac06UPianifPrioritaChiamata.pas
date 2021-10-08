unit Ac06UPianifPrioritaChiamata;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Spin, DBCtrls, Menus, Grids, DBGrids, ComCtrls,
  OracleData, Variants, DB, Mask, StrUtils,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  A003UDataLavoroBis, C005UDatiAnagrafici, C180FunzioniGenerali,
  C700USelezioneAnagrafe, RegistrazioneLog, SelAnagrafe;

type
  TAc06FPianifPrioritaChiamata = class(TForm)
    Panel1: TPanel;
    btnDataPartenza: TBitBtn;
    lblPrioritaChiamata: TLabel;
    edtPrioritaChiamata: TSpinEdit;
    btnInserisci: TBitBtn;
    DBGrid1: TDBGrid;
    StatusBar: TStatusBar;
    btnCancella: TBitBtn;
    ProgressBar1: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkTuttiDip: TCheckBox;
    edtDataPartenza: TMaskEdit;
    lblDataPartenza: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure edtDataPartenzaExit(Sender: TObject);
    procedure btnDataPartenzaClick(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
  private
    procedure CambiaProgressivo;
  public
    {public declarations}
  end;

var
  Ac06FPianifPrioritaChiamata: TAc06FPianifPrioritaChiamata;

procedure OpenAc06PianifPrioritaChiamata(Prog:LongInt);

implementation

uses Ac06UPianifPrioritaChiamataDM;

{$R *.DFM}

procedure OpenAc06PianifPrioritaChiamata(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc06PianifPrioritaChiamata') of
    'N':
        begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Ac06FPianifPrioritaChiamata:=TAc06FPianifPrioritaChiamata.Create(nil);
  with Ac06FPianifPrioritaChiamata do
    try
      C700Progressivo:=Prog;
      Ac06FPianifPrioritaChiamataDM:=TAc06FPianifPrioritaChiamataDM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Ac06FPianifPrioritaChiamataDM.Free;
      Free;
    end;
end;

procedure TAc06FPianifPrioritaChiamata.FormCreate(Sender: TObject);
begin
  btnInserisci.Enabled:=not SolaLettura;
  btnCancella.Enabled:=not SolaLettura;
end;

procedure TAc06FPianifPrioritaChiamata.FormShow(Sender: TObject);
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(Ac06FPianifPrioritaChiamataDM.Ac06MW,SessioneOracle,StatusBar,0,True);
  edtDataPartenza.Text:=DateToStr(Parametri.DataLavoro);
end;

procedure TAc06FPianifPrioritaChiamata.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TAc06FPianifPrioritaChiamata.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=Ac06FPianifPrioritaChiamataDM.Ac06MW.Data;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TAc06FPianifPrioritaChiamata.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataDal:=EncodeDate(R180Anno(Ac06FPianifPrioritaChiamataDM.Ac06MW.Data),1,1);
    C700DataLavoro:=EncodeDate(R180Anno(Ac06FPianifPrioritaChiamataDM.Ac06MW.Data),12,31);
  except
    C700DataDal:=EncodeDate(R180Anno(Parametri.DataLavoro),1,1);
    C700DataLavoro:=EncodeDate(R180Anno(Parametri.DataLavoro),12,31);
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TAc06FPianifPrioritaChiamata.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    Ac06FPianifPrioritaChiamataDM.selT381.Close;
    Ac06FPianifPrioritaChiamataDM.selT381.SetVariable('Progressivo',C700Progressivo);
    Ac06FPianifPrioritaChiamataDM.selT381.Open;
    frmSelAnagrafe.VisualizzaDipendente;
  end;
end;

procedure TAc06FPianifPrioritaChiamata.edtDataPartenzaExit(Sender: TObject);
begin
  try
    Ac06FPianifPrioritaChiamataDM.Ac06MW.Data:=StrToDate(edtDataPartenza.Text);
  except
    abort;
  end;
end;

procedure TAc06FPianifPrioritaChiamata.btnDataPartenzaClick(Sender: TObject);
begin
  try
    Ac06FPianifPrioritaChiamataDM.Ac06MW.Data:=DataOut(StrToDate(edtDataPartenza.Text),'Riferimento per priorità','G');
  except
    Ac06FPianifPrioritaChiamataDM.Ac06MW.Data:=DataOut(Ac06FPianifPrioritaChiamataDM.Ac06MW.Data,'Riferimento per priorità','G');
  end;
  edtDataPartenza.Text:=DateToStr(Ac06FPianifPrioritaChiamataDM.Ac06MW.Data);
end;

procedure TAc06FPianifPrioritaChiamata.btnInserisciClick(Sender: TObject);
var OldProg,Risposta:Integer;
    SostPrioritaTutti:Boolean;
begin
  with Ac06FPianifPrioritaChiamataDM.Ac06MW do
  begin
    Data:=StrToDate(edtDataPartenza.Text);
    Priorita:=edtPrioritaChiamata.Value;
    Controlli;
  end;
  if Sender = btnCancella then
    if MessageDlg(Format(A000MSG_Ac06_DLG_CANCELLAZIONE,[IfThen(chkTuttiDip.Checked,A000MSG_Ac06_DLG_TUTTI_DIP)]),mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit;
  if Sender = btnInserisci then
    if MessageDlg(Format(A000MSG_Ac06_DLG_INSERIMENTO,[IfThen(chkTuttiDip.Checked,A000MSG_Ac06_DLG_TUTTI_DIP)]),mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit;
  with Ac06FPianifPrioritaChiamataDM do
  begin
    frmSelAnagrafe.OnCambiaProgressivo:=nil;
    OldProg:=C700Progressivo;
    Risposta:=mrYes;
    SostPrioritaTutti:=False;
    if chkTuttiDip.Checked then
      C700SelAnagrafe.First;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    ProgressBar1.Position:=0;
    while not C700SelAnagrafe.Eof do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      Ac06MW.Progressivo:=C700Progressivo;
      Ac06MW.RecuperaPriorita;
      if Sender = btnInserisci then
      begin
        Risposta:=mrYes;
        if Ac06MW.selT381.SearchRecord('DATA',Ac06MW.Data,[srFromBeginning]) then
        begin
          if Ac06MW.Priorita = Ac06MW.selT381.FieldByName('PRIORITA').AsInteger then
            Risposta:=mrNo
          else if not SostPrioritaTutti then
            Risposta:=R180MessageBox(Format(A000MSG_Ac06_DLG_FMT_SOST_PRIORITA +
                                            IfThen(chkTuttiDip.Checked,A000MSG_Ac06_DLG_FMT_SOST_PRIORITA_TUTTI),
                                            [C700SelAnagrafe.FieldByName('MATRICOLA').AsString + ' ' +
                                             C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
                                             C700SelAnagrafe.FieldByName('NOME').AsString,
                                             DateToStr(Ac06MW.Data)]),
                                     IfThen(chkTuttiDip.Checked,DOMANDA_YESALL_ESCI,DOMANDA));
        end;
        //Risposta = mrCancel interrompe l'operazione
        if Risposta = mrCancel then
          Break
        //Risposta = mrYes inserisce/sostituisce priorità
        else if Risposta = mrYes then
          Ac06MW.InserisciPriorita
        //Risposta = mrYesToAll inserisce/sostituisce priorità e non chiede più per prossimi dipendenti
        else if Risposta = mrYesToAll then
        begin
          Ac06MW.InserisciPriorita;
          SostPrioritaTutti:=True;
        end;
        //Risposta = mrNo salta il dipendente
      end
      else
        Ac06MW.CancellaPriorita;
      if not chkTuttiDip.Checked then
        Break;
      C700SelAnagrafe.Next;
    end;
    ProgressBar1.Position:=0;
    frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
    if chkTuttiDip.Checked then
      C700SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
    C700OldProgressivo:=-1;
    CambiaProgressivo;
    if Risposta = mrCancel then
      ShowMessage(A000MSG_MSG_OPERAZIONE_INTERROTTA)
    else
      ShowMessage(A000MSG_MSG_OPERAZIONE_COMPLETATA);
  end;
end;

end.
