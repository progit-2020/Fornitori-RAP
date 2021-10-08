unit A043UDialogStampa;

interface

uses
  Dialogs, Forms, ComCtrls, StdCtrls, ExtCtrls, Controls,
  DBCtrls, Spin, Buttons, Classes, Windows, SysUtils, DB, Variants, StrUtils,
  SelAnagrafe, QueryStorico, Math,
  A000UInterfaccia, A000UMessaggi, A000USessione, A043UStampaRepMW, A083UMsgElaborazioni,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe, InputPeriodo;

type
  TA043FDialogStampa = class(TForm)
    btnPrinterSetUp: TBitBtn;
    btnStampa: TBitBtn;
    btnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    chkSpezzoniMese: TCheckBox;
    chkSalva: TCheckBox;
    chkCumula: TCheckBox;
    lblRaggr: TLabel;
    dcmbCampo: TDBLookupComboBox;
    rgpTipoStampa: TRadioGroup;
    StatusBar: TStatusBar;
    ProgressBar: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkSaltoPagina: TCheckBox;
    btnAnomalie: TBitBtn;
    btnSoloAggiornamento: TBitBtn;
    btnAnteprima: TBitBtn;
    chkSoloAnomalie: TCheckBox;
    chkIgnoraAnomalie: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure chkSalvaClick(Sender: TObject);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure dcmbCampoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnPrinterSetUpClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodobtnDataInizioClick(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnDataFineClick(Sender: TObject);
  private
    CampoRagg,NomeCampo:String;
    TipoStampa: Integer;
    bRiepilogoBloccato:Boolean;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ScorriQueryAnagrafica;
    procedure AggiornaDataFine(pGiorno: Word);
    procedure AggiornaDataInizio;
    procedure AbilitaAmbiente;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    A043MW: TA043FStampaRepMW;
    SoloAgg:String;//Usato per richiamo da WA043 tramite B028

    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A043FDialogStampa: TA043FDialogStampa;

procedure OpenA043StampaRep(Prog:LongInt);

implementation

uses A043UStampa;

{$R *.DFM}

procedure OpenA043StampaRep(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA043StampaRep') of
    'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A043FDialogStampa:=TA043FDialogStampa.Create(nil);
  with A043FDialogStampa do
    try
      C700Progressivo:=Prog;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
    end;
end;

procedure TA043FDialogStampa.FormCreate(Sender: TObject);
begin
  A043MW:=TA043FStampaRepMW.Create(Self);
  btnAnomalie.Enabled:=False;

  frmInputPeriodo.AutoCompletamento:= acGiorno;
end;

procedure TA043FDialogStampa.FormShow(Sender: TObject);
begin
  A043MW.CodForm:=IfThen(A043MW.TipoModulo = 'CS','A043','WA043');
  A043FStampa:=TA043FStampa.Create(nil);
  CreaC004(SessioneOracle,A043MW.CodForm,Parametri.ProgOper);
  TipoStampa:=rgpTipoStampa.ItemIndex;

  DataI:= R180InizioMese(Parametri.DataLavoro);
  DataF:= R180FineMese(DataI);
  AbilitaAmbiente;

  GetParametriFunzione;

  A043MW.A043ProgressBar:=ProgressBar;

  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A043MW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  chkIgnoraAnomalie.Enabled:=chkSalva.Checked;
end;

procedure TA043FDialogStampa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA043FDialogStampa.FormDestroy(Sender: TObject);
begin
  A043FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  A043MW.Free;
end;

procedure TA043FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpTipoStampa.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSTAMPA','0'));
  chkSpezzoniMese.Checked:=C004FParamForm.GetParametro('SOMMASPEZZONI','N') = 'S';
  chkCumula.Checked:=C004FParamForm.GetParametro('CUMULA','N') = 'S';
  chkSoloAnomalie.Checked:=C004FParamForm.GetParametro('SOLOANOMALIE','N') = 'S';
  dcmbCampo.KeyValue:=C004FParamForm.GetParametro('RAGGRUPPAMENTO',dcmbCampo.Text);
  chkIgnoraAnomalie.Checked:=C004FParamForm.GetParametro('IGNORAANOMALIE','N') = 'S';
  if dcmbCampo.Text = '' then
    dcmbCampo.KeyValue:=null;
  chkSalvaClick(nil);
end;

procedure TA043FDialogStampa.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  with A043FDialogStampa do
  begin
    C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
    if chkSpezzoniMese.Checked then
      C004FParamForm.PutParametro('SOMMASPEZZONI','S')
    else
      C004FParamForm.PutParametro('SOMMASPEZZONI','N');
    if chkCumula.Checked then
      C004FParamForm.PutParametro('CUMULA','S')
    else
      C004FParamForm.PutParametro('CUMULA','N');
    if chkSoloAnomalie.Checked then
      C004FParamForm.PutParametro('SOLOANOMALIE','S')
    else
      C004FParamForm.PutParametro('SOLOANOMALIE','N');
    if chkIgnoraAnomalie.Checked then
      C004FParamForm.PutParametro('IGNORAANOMALIE','S')
    else
      C004FParamForm.PutParametro('IGNORAANOMALIE','N');
    C004FParamForm.PutParametro('RAGGRUPPAMENTO',VarToStr(dcmbCampo.KeyValue));
  end;
  try SessioneOracle.Commit; except end;
end;

procedure TA043FDialogStampa.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA043FDialogStampa.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=DataI;
  C700DataLavoro:=DataF;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA043FDialogStampa.chkSalvaClick(Sender: TObject);
begin
  btnSoloAggiornamento.Enabled:=chkSalva.Enabled and chkSalva.Checked;
  chkIgnoraAnomalie.Enabled:=chkSalva.Checked;
end;

procedure TA043FDialogStampa.rgpTipoStampaClick(Sender: TObject);
begin
  TipoStampa:=rgpTipoStampa.ItemIndex;
  chkSoloAnomalie.Enabled:=(TipoStampa = 0);
  if not chkSoloAnomalie.Enabled then
    chkSoloAnomalie.Checked:=False;
end;

procedure TA043FDialogStampa.dcmbCampoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA043FDialogStampa.btnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A043FStampa.RepR);
end;

procedure TA043FDialogStampa.btnStampaClick(Sender: TObject);
var S:String;
begin
  btnAnomalie.Enabled:=False;
  RegistraMsg.IniziaMessaggio(A043MW.CodForm);
  A043MW.selDatiBloccati.Close;

  if (DataI <= 0) or (DataF <=0) then
    raise Exception.Create(A000MSG_ERR_DATE_INSERITE);
  if DataI > DataF then
    raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
    C700SelAnagrafe.CloseAll;
  //Caratto 04/03/2014 mail nando oggetto R: Erorre su IrisCloud del 04/032014
  //Se arrivo da B028 con campo non impostato keyvalue ='' e non null
  if (dcmbCampo.KeyValue <> Null) and (dcmbCampo.KeyValue <> '') then
  begin
    CampoRagg:=dcmbCampo.KeyValue;
    NomeCampo:=dcmbCampo.Text;
    S:=C700SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,AliasTabella(A043MW.selI010.FieldByName('Nome_Campo').AsString)+'.'+dcmbCampo.KeyValue) then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SQL.Text:=S;
    end;
  end
  else
  begin
    CampoRagg:='';
    NomeCampo:='';
  end;
  with A043MW do
  begin
    A043chkCumula:=chkCumula.Checked;
    A043chkSpezzoniMese:=chkSpezzoniMese.Checked;
    A043ChkIgnoraAnomalie:=chkIgnoraAnomalie.Checked;
    A043DataI:=DataI;
    A043DataF:=DataF;
    A043CampoRagg:=CampoRagg;
  end;
  if SolaLettura then
    chkSalva.Checked:=False;
  A043MW.CreaTabellaStampa;
  C700SelAnagrafe.Open;
  ScorriQueryAnagrafica;
  A043MW.SalvaDatiTurni:=chkSalva.Checked and chkSalva.Enabled;
  if A043MW.SalvaDatiTurni or chkSoloAnomalie.Checked then
    A043MW.CalcolaRiepiloghi;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if A043MW.TipoModulo = 'CS' then
  begin
    if (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
    begin
      if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes) then
        btnAnomalieClick(nil);
    end
    else if Sender = btnSoloAggiornamento then
    begin
      ShowMessage(A000MSG_MSG_ELABORAZIONE_TERMINATA);
      exit;
    end;
  end;
  if Sender <> btnSoloAggiornamento then
  begin
    A043FStampa.CampoRagg:=CampoRagg;
    A043FStampa.NomeCampo:=NomeCampo;
    A043FStampa.TipoStampa:=TipoStampa;
    A043FStampa.CreaReport(Sender = btnAnteprima);
  end;
end;

procedure TA043FDialogStampa.ScorriQueryAnagrafica;
var NomeCorr:String;
begin
  with A043MW do
  begin
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount * Trunc(DataF - DataI + 1);
    C700SelAnagrafe.First;
    bRiepilogoBloccato:=False;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      while not C700SelAnagrafe.Eof  do
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        NomeCorr:=C700SelAnagrafe.FieldByName('Cognome').AsString;
        //Eliminazione situazione precedente
        if chkSalva.Checked then
        begin
          //Cancello i turni se il riepilogo non è bloccato
          bRiepilogoBloccato:=selDatiBloccati.DatoBloccato(C700Progressivo,R180InizioMese(DataI),'T340');
          if not bRiepilogoBloccato then
          begin
            try
              QDelete.SetVariable('Progressivo',C700Progressivo);
              QDelete.SetVariable('Anno', R180Anno(DataI));
              QDelete.SetVariable('Mese', R180Mese(DataI));
              QDelete.Execute;
              RegistraLog.SettaProprieta('C','T340_TURNIREPERIB',A043MW.CodForm,nil,True);
              RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(C700Progressivo));
              RegistraLog.InserisciDato('DATA','',DateToStr(R180InizioMese(DataI)));
              RegistraLog.RegistraOperazione;
              SessioneOracle.Commit;
            except
            end;
          end;
        end;
        //Lettura turni pianificati
        Q380Pianif.Close;
        Q380Pianif.SetVariable('Progressivo',C700Progressivo);
        Q380Pianif.SetVariable('Data1',DataI);
        Q380Pianif.SetVariable('Data2',DataF);
        Q380Pianif.Open;
        ElaboraReperib;
        C700SelAnagrafe.Next;
      end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar.Position:=0;
    end;
  end;
end;


procedure TA043FDialogStampa.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,A043MW.CodForm,'');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A043MW);
end;

procedure TA043FDialogStampa.frmInputPeriodobtnDataFineClick(Sender: TObject);
begin
  frmInputPeriodo.btnDataFineClick(Sender);
  AggiornaDataInizio;
end;

procedure TA043FDialogStampa.frmInputPeriodobtnDataInizioClick(Sender: TObject);
var gg: Word;
begin
  if DataF > 0 then gg:= R180Giorno(DataF)
    else gg:= 0;
  frmInputPeriodo.btnDataInizioClick(Sender);
  AggiornaDataFine(gg);
end;

procedure TA043FDialogStampa.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  AggiornaDataInizio;
end;

procedure TA043FDialogStampa.frmInputPeriodoedtInizioExit(Sender: TObject);
var gg: Word;
begin
  if DataF > 0 then gg:= R180Giorno(DataF)
    else gg:= 0;
  frmInputPeriodo.edtInizioExit(Sender); //<--- gestisce i casi con DataI > DataF
  AggiornaDataFine(gg);
end;

// Disabilito il CheckBox del salvataggio se il mese non e' completo.
procedure TA043FDialogStampa.AbilitaAmbiente;
begin
  chkSalva.Enabled:= (not SolaLettura) and (DataI > 0) and (DataF > 0) and (R180Giorno(DataI) = 1) and (R180Giorno(DataF) = R180GiorniMese(DataF));
  if not chkSalva.Enabled then
    chkSalva.Checked:=False;
  chkSalvaClick(nil);
end;

procedure TA043FDialogStampa.AggiornaDataFine(pGiorno: Word);
begin
  if DataI <= 0 then exit;

  pGiorno:= Max(pGiorno, R180Giorno(DataF));
  pGiorno:= Min(pGiorno, R180GiorniMese(DataI));

  DataF:= EncodeDate(R180Anno(DataI), R180Mese(DataI), pGiorno);
  AbilitaAmbiente;
end;

procedure TA043FDialogStampa.AggiornaDataInizio;
var gg: Word;
begin
  if DataF <= 0 then exit;
  if DataI > 0 then gg:= Min(R180Giorno(DataI), R180Giorno(DataF))
    else gg:= R180Giorno(DataF);
  DataI:= EncodeDate(R180Anno(DataF), R180Mese(DataF), gg);
  AbilitaAmbiente;
end;

{ DataF }
function TA043FDialogStampa._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;

procedure TA043FDialogStampa._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ---- DataF }
{ DataI }
function TA043FDialogStampa._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;

procedure TA043FDialogStampa._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ---- DataI }

end.
