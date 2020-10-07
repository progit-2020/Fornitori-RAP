unit A074URiepilogoBuoni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  Buttons, DBCtrls, StdCtrls,C001StampaLib, C180FunzioniGenerali,A000UCostanti, A000USessione,
  A000UInterfaccia,ExtCtrls,DB,checklst, ComCtrls, C700USelezioneAnagrafe, QRPDFFilt,
  QueryStorico,C004UParamForm, SelAnagrafe, Menus, C005UDatiAnagrafici,
  A003UDataLavoroBis, OracleData, Variants, DatiBloccati, A037UScaricoPaghe,
  A083UMsgElaborazioni,A000UMessaggi, InputPeriodo;

type
  TA074FRiepilogoBuoni = class(TForm)
    BtnPrinterSetUp: TBitBtn;
    BtnStampa: TBitBtn;
    BtnClose: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    Label3: TLabel;
    dcmbRaggrAnagrafico: TDBLookupComboBox;
    SaveDialog1: TSaveDialog;
    frmSelAnagrafe: TfrmSelAnagrafe;
    PageControl1: TPageControl;
    tabMaturazione: TTabSheet;
    ChkAggiorna: TCheckBox;
    ChkDettaglio: TCheckBox;
    ChkSaltoPagina: TCheckBox;
    ChkAcquisto: TCheckBox;
    ChkInizioAnno: TCheckBox;
    chkIgnoraAnomalie: TCheckBox;
    tabAcquisto: TTabSheet;
    btnDataAcquisto: TBitBtn;
    chkAcqDatiIndividuali: TCheckBox;
    chkAcqSaltoPagina: TCheckBox;
    chkAcqAggiornamento: TCheckBox;
    lblIntUltimoAcquisto: TLabel;
    Label4: TLabel;
    edtDataAcquisto: TEdit;
    btnEliminaAcquisto: TBitBtn;
    edtUltimoAcquisto: TEdit;
    btnAnomalie: TBitBtn;
    GroupBox1: TGroupBox;
    edtFileSequenziale: TEdit;
    btnFileSequenziale: TButton;
    btnParametriGemeaz: TButton;
    chkFileSequenziale: TCheckBox;
    GroupBox2: TGroupBox;
    lblParPaghe: TLabel;
    DBText1: TDBText;
    dcmbParametrizzazione: TDBLookupComboBox;
    chkScaricoPaghe: TCheckBox;
    DBText2: TDBText;
    chkSoloElaborazione: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure dcmbRaggrAnagraficoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnDataAcquistoClick(Sender: TObject);
    procedure ChkInizioAnnoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFileSequenzialeClick(Sender: TObject);
    procedure chkFileSequenzialeClick(Sender: TObject);
    procedure btnParametriGemeazClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnEliminaAcquistoClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure chkScaricoPagheClick(Sender: TObject);
  private
    FileSeq:TextFile;
    RegistraFileSeq:Boolean;
    RaggruppamentoGemeaz:String;
    procedure ScorriQueryAnagrafica;
    procedure ScorriQueryAnagraficaAcquisto;
    procedure AbilitaSalvataggio(DataI,DataF : TDateTime);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CartellinoMaturazione;
    procedure CartellinoAcquisto;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  public
    DataAcquisto:TDateTime;
    CampoRagg,NomeCampo,DocumentoPDF,TipoModulo,FsPassword:String;
    VarBuoniPasto,VarTicket:Integer;
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  A074FRiepilogoBuoni: TA074FRiepilogoBuoni;

procedure OpenA074RiepilogoBuoni(Prog:LongInt);

implementation

uses A074UStampaBuoni, A074URiepilogoBuoniDtM1, A074UGemeaz,
     R350UCalcoloBuoniDtM, A074UStampaAcquisti;

{$R *.DFM}

procedure OpenA074RiepilogoBuoni(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA074RiepilogoBuoni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A074FRiepilogoBuoni:=TA074FRiepilogoBuoni.Create(nil);
  with A074FRiepilogoBuoni do
  try
    C700Progressivo:=Prog;
    A074FRiepilogoBuoniDtM1:=TA074FRiepilogoBuoniDtM1.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A074FRiepilogoBuoniDtM1.Free;
    Free;
  end;
end;

procedure TA074FRiepilogoBuoni.FormCreate(Sender: TObject);
begin
  A074FStampaBuoni:=TA074FStampaBuoni.Create(nil);
  A074FStampaAcquisti:=TA074FStampaAcquisti.Create(nil);
  A074FGemeaz:=TA074FGemeaz.Create(nil);
  btnAnomalie.Enabled:=False;
  PageControl1.ActivePage:=tabMaturazione;
  TipoModulo:='CS';
end;

procedure TA074FRiepilogoBuoni.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A074',Parametri.ProgOper);
  DataI:=R180InizioMese(Parametri.DataLavoro);
  DataF:=R180FineMese(Parametri.DataLavoro);
  A074FRiepilogoBuoniDtM1.GetMeseUltimoAcquisto(True);
  chkAcqAggiornamento.Enabled:=not SolaLettura;
  btnEliminaAcquisto.Enabled:=(not SolaLettura) and (Parametri.A037_EliminaDataCassa = 'S');
  AbilitaSalvataggio(DataI,DataF);
  CampoRagg:='';
  if Trim(Parametri.CampiRiferimento.C4_BuoniMensa) = '' then
  begin
    if TipoModulo = 'CS' then
      ShowMessage(A000MSG_A074_ERR_CAMPO_RIFERIMENTO);
    Close;
  end;
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW,SessioneOracle,StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
end;

procedure TA074FRiepilogoBuoni.GetParametriFunzione;
{Leggo i parametri della form}
begin
  with A074FRiepilogoBuoni do
  begin
    ChkDettaglio.Checked:=C004FParamForm.GetParametro('DETTAGLIO','N') = 'S';
    ChkAcquisto.Checked:=C004FParamForm.GetParametro('ACQUISTO','N') = 'S';
    ChkInizioAnno.Checked:=C004FParamForm.GetParametro('INIZIOANNO','N') = 'S';
    ChkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
    chkIgnoraAnomalie.Checked:=C004FParamForm.GetParametro('IGNORAANOMALIE','N') = 'S';
    chkAcqDatiIndividuali.Checked:=C004FParamForm.GetParametro('ACQDATIINDIVIDUALI','S') = 'S';
    chkAcqSaltoPagina.Checked:=C004FParamForm.GetParametro('ACQSALTOPAGINA','N') = 'S';
    chkFileSequenziale.Checked:=C004FParamForm.GetParametro('CREAFILESEQ','N') = 'S';
    edtFileSequenziale.Text:=C004FParamForm.GetParametro('FILESEQUENZIALE','');
    chkScaricoPaghe.Checked:=C004FParamForm.GetParametro('CREAFILEACQ','N') = 'S';
    chkSoloElaborazione.Checked:=C004FParamForm.GetParametro('chkSoloElaborazione','N') = 'S';
    A074FRiepilogoBuoniDtM1.cdsT191.Edit;
    A074FRiepilogoBuoniDtM1.cdsT191.FieldByName('CODICE').AsString:=C004FParamForm.GetParametro('PARPAGHE','');
    A074FRiepilogoBuoniDtM1.cdsT191.Post;
    dcmbRaggrAnagrafico.KeyValue:=C004FParamForm.GetParametro('RAGGRUPPAMENTO',dcmbRaggrAnagrafico.Text);
    if dcmbRaggrAnagrafico.Text = '' then
      dcmbRaggrAnagrafico.KeyValue:=null;
    A074FGemeaz.edtCodCliente.Text:=C004FParamForm.GetParametro('CODCLIENTE','');
    A074FGemeaz.edtValoreBuono.Text:=C004FParamForm.GetParametro('VALOREBUONO','');
    A074FGemeaz.edtSiglaTestata.Text:=C004FParamForm.GetParametro('SIGLATESTATA','TR');
    A074FGemeaz.rgpTipoFile.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOFILEGEMEAZ','1'));
    A074FGemeaz.cmbFormatoMatricola.Text:=C004FParamForm.GetParametro('FORMATOMATRICOLA','');
    A074FGemeaz.chkTicket.Checked:=C004FParamForm.GetParametro('TICKETGEMEAZ','N') = 'S';
    A074FGemeaz.chkBuoniPasto.Checked:=C004FParamForm.GetParametro('BUONIGEMEAZ','N') = 'S';
  end;
  chkFileSequenzialeClick(nil);
end;

procedure TA074FRiepilogoBuoni.BtnDataAcquistoClick(Sender: TObject);
{Data iniziale}
var D:TDateTime;
begin
  D:=DataOut(DataAcquisto,'Mese di acquisto:','M');
  if D = DataAcquisto then exit;
  DataAcquisto:=D;
  edtDataAcquisto.Text:=FormatDateTime('mmmmm yyyy',DataAcquisto);
end;

procedure TA074FRiepilogoBuoni.AbilitaSalvataggio(DataI,DataF : TDateTime);
var YY1,MM1,DD1,YY2,MM2,DD2:Word;
    Abilitato:Boolean;
begin
  Abilitato:=False;
  DecodeDate(DataI,YY1,MM1,DD1);
  DecodeDate(DataF,YY2,MM2,DD2);
  if (YY1 = YY2) and (MM1 = MM2) then
    if (DD1 = 01)and(DD2 = R180GiorniMese(DataF)) then
      Abilitato:=True;
  if not(Abilitato) then
    ChkAggiorna.Checked:=False;
  ChkAggiorna.Enabled:=(not SolaLettura) (* and Abilitato *) and (not ChkInizioAnno.Checked);
end;

procedure TA074FRiepilogoBuoni.ChkInizioAnnoClick(Sender: TObject);
begin
  if ChkInizioAnno.Checked then
    ChkAggiorna.Checked:=False;
  AbilitaSalvataggio(DataI,DataF);
end;

procedure TA074FRiepilogoBuoni.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
  begin
    C001SettaQuickReport(A074FStampaBuoni.RepR);
    C001SettaQuickReport(A074FStampaAcquisti.QRep);
  end;
end;

procedure TA074FRiepilogoBuoni.BtnStampaClick(Sender: TObject);
var
  App,S:String;
  P:Integer;
begin
  if chkAggiorna.Checked and not((DataI = R180InizioMese(DataI)) and (DataF = R180FineMese(DataF))) then
  begin
    raise Exception.Create('Attenzione!' + CRLF + 'Aggiornamento impedito sui mesi parziali.');
  end;

  btnAnomalie.Caption:='Anomalie';
  btnAnomalie.Enabled:=False;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.selDatiBloccati.Close;
  //A074FRiepilogoBuoniDtM1.R350FCalcoloBuoniDtM.selDatiBloccati.FileLog:='';
  RegistraMsg.IniziaMessaggio('A074');
  if (dcmbRaggrAnagrafico.KeyValue <> Null) then
    App:=dcmbRaggrAnagrafico.KeyValue
  else
    App:='';
  if PageControl1.ActivePage = tabMaturazione then
  begin
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
      C700SelAnagrafe.Close;
  end
  else if frmSelAnagrafe.SettaPeriodoSelAnagrafe(R180InizioMese(DataAcquisto),R180FineMese(DataAcquisto)) then
    C700SelAnagrafe.Close;
  if App <> '' then
  begin
    NomeCampo:=dcmbRaggrAnagrafico.Text;
    CampoRagg:=App;
    C700SelAnagrafe.Close;
    S:=C700SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,App) then
    begin
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=S;
    end;
    P:=Pos('ORDER BY',S);
    if (P > 0) and (Pos(App,Copy(S,P,Length(S))) = 0) then
    begin
      C700SelAnagrafe.Close;
      Insert(App + ',',S,P + Length('ORDER BY '));
      C700SelAnagrafe.SQL.Text:=S;
    end;
  end;
  C700SelAnagrafe.Open;
  if PageControl1.ActivePage = tabMaturazione then
    CartellinoMaturazione
  else
    CartellinoAcquisto;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB or RegistraMsg.ContieneTipoI;
  if ((Not RegistraMsg.ContieneTipoA) and (Not RegistraMsg.ContieneTipoB)) and RegistraMsg.ContieneTipoI then
    btnAnomalie.Caption:='Messaggi';
end;

procedure TA074FRiepilogoBuoni.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A074','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW);
end;

procedure TA074FRiepilogoBuoni.CartellinoMaturazione;
begin
  if DataI > DataF then
    raise Exception.Create('La data iniziale deve essere minore di quella finale');
  C001SettaQuickReport(A074FStampaBuoni.RepR);
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.selAnagrafe:=C700SelAnagrafe;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.CreaTabellaStampa;
  if ChkInizioAnno.Checked then
    A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.R502ProDtM1.PeriodoConteggi(EncodeDate(R180Anno(DataI),1,1),DataF)
  else
    A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.R502ProDtM1.PeriodoConteggi(DataI,DataF);
  ScorriQueryAnagrafica;
  if chkSoloElaborazione.Checked then
     exit;

  A074FStampaAcquisti.QRep.DataSet:=A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa;
  A074FStampaBuoni.QRLabel12.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel13.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel14.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel15.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel19.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel20.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel21.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel22.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel23.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel24.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel25.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel26.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel27.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel28.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel29.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRLabel30.Enabled:=ChkAcquisto.Checked;
  A074FStampaBuoni.QRGroup2.Enabled:=CampoRagg <> '';
  A074FStampaBuoni.QRBand2.Enabled:=CampoRagg <> '';
  A074FStampaBuoni.LRagg.Caption:=NomeCampo;
  A074FStampaBuoni.DataI := DataI;
  A074FStampaBuoni.DataF := DataF;
  A074FStampaBuoni.QRGroup1.ForceNewPage:=False;
  A074FStampaBuoni.QRGroup2.ForceNewPage:=False;
  if ChkSaltoPagina.Checked then
  begin
    A074FStampaBuoni.QRGroup2.ForceNewPage:=CampoRagg <> '';
    A074FStampaBuoni.QRGroup1.ForceNewPage:=CampoRagg = '';
  end;
  A074FStampaBuoni.QRLAzienda.Caption:=Parametri.DAzienda;
  A074FStampaBuoni.LPeriodo.Caption:='dal ' + FormatDateTime('dd/mm/yyyy',DataI) + ' al ' + FormatDateTime('dd/mm/yyyy',DataF);

  if (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') and (Trim(TipoModulo) = 'COM')then
  begin
      A074FStampaBuoni.RepR.ShowProgress:=False;
      A074FStampaBuoni.RepR.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
  end
  else
    A074FStampaBuoni.CreaReport;

  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa.Close;
  if ChkAggiorna.Checked then
  begin
    RegistraLog.SettaProprieta('I','T680_BUONIMENSILI',Copy(Self.Name,1,4),nil,True);
    RegistraLog.InserisciDato('DAL-AL','',DateToStr(DataI) + '-' + DateToStr(DataF));
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TA074FRiepilogoBuoni.CartellinoAcquisto;
begin
  if chkFileSequenziale.Checked then
  begin
    if (TipoModulo = 'CS') and
       (MessageDlg(A000MSG_A074_DLG_FILE_SEQUENZIALE, mtInformation,[mbYes,mbNo],0,mbNo) = mrNo) then
      Abort;
    if ((TipoModulo = 'CS') and (InputBox('Generazione file sequenziale','Password','') <> 'A074FS')) or
       ((TipoModulo = 'COM') and (FsPassword <> 'A074FS'))then
        raise Exception.Create(A000MSG_A074_ERR_PWD_FILE);
  end;
  //Verifica che non si stia aggiornando o registrando un mese precedente ad altri acquisti effettuati
  if chkAcqAggiornamento.Checked or chkFileSequenziale.Checked or chkScaricoPaghe.Checked then
  begin
    if A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.getUltimoAcquistoAuto > R180InizioMese(DataAcquisto) then
      if (TipoModulo = 'CS') and
         (MessageDlg(A000MSG_A074_DLG_DISAB_AGGIORNAMENTO,mtConfirmation,[mbYes,mbNo],0) = mrNo) then
        Abort
      else
      begin
        chkAcqAggiornamento.Checked:=False;
        chkFileSequenziale.Checked:=False;
        chkScaricoPaghe.Checked:=False;
      end;
  end;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.selAnagrafe:=C700SelAnagrafe;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.CreaTabellaStampa;
  RaggruppamentoGemeaz:='';
  RegistraFileSeq:=False;
  if (chkFileSequenziale.Checked) and (edtFileSequenziale.Text <> '') then
  try
    AssignFile(FileSeq,edtFileSequenziale.Text);
    Rewrite(FileSeq);
    RegistraFileSeq:=True;
  except
    raise Exception.Create(Format(A000MSG_A074_ERR_FMT_CREATE_FILE,[edtFileSequenziale.Text]));
  end;
  if (chkScaricoPaghe.Checked) and (dcmbParametrizzazione.Text = '') then
    raise Exception.Create(A000MSG_A074_ERR_PARAMETRIZZAZIONE);
  ScorriQueryAnagraficaAcquisto;
  if chkScaricoPaghe.Checked then
  begin
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    C004FParamForm.Free;
    try
      OpenA037ScaricoBuoni(dcmbParametrizzazione.Text,frmSelAnagrafe.OldSelAnagrafe.Text,DataAcquisto,frmSelAnagrafe.SelezionePeriodica,frmSelAnagrafe.SoloPersonaleInterno);
    finally
      CreaC004(SessioneOracle,'A074',Parametri.ProgOper);
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      C700OldProgressivo:=-1;
      frmSelAnagrafe.RipristinaC00SelAnagrafe(A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW);
    end;
  end;
  if RegistraFileSeq then
    CloseFile(FileSeq);
  //Stampa
  C001SettaQuickReport(A074FStampaAcquisti.QRep);
  A074FStampaAcquisti.QRep.DataSet:=A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.TabellaStampa;
  A074FStampaAcquisti.lblMese.Caption:=FormatDateTime('mmmm yyyy',DataAcquisto);
  A074FStampaAcquisti.LEnte.Caption:=Parametri.DAzienda;
  A074FStampaAcquisti.LRagg.Caption:=NomeCampo;
  A074FStampaAcquisti.QRGroup1.Enabled:=CampoRagg <> '';
  A074FStampaAcquisti.QRBand1.Enabled:=CampoRagg <> '';
  A074FStampaAcquisti.QRGroup1.ForceNewPage:=chkAcqSaltoPagina.Checked;

  if (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') and (Trim(TipoModulo) = 'COM')then
  begin
      A074FStampaAcquisti.QRep.ShowProgress:=False;
      A074FStampaAcquisti.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
  end
  else
    A074FStampaAcquisti.QRep.Preview;

  if chkAcqAggiornamento.Checked then
    A074FRiepilogoBuoniDtM1.GetMeseUltimoAcquisto(False);
  if chkAcqAggiornamento.Checked then
  begin
    RegistraLog.SettaProprieta('I','T690_ACQUISTOBUONI',Copy(Self.Name,1,4),nil,True);
    RegistraLog.InserisciDato('DATA','',DateToStr(DataAcquisto));
    RegistraLog.RegistraOperazione;
  end;
end;

procedure TA074FRiepilogoBuoni.ScorriQueryAnagrafica;
var Data:TDateTime;
    DipInSer:TDipendenteInServizio;
begin
  if ChkInizioAnno.Checked then
    Data:=StrToDate(FormatDateTime('01/01/yyyy',DataI))
  else
    Data:=DataI;
  DipInSer:=TDipendenteInServizio.Create(nil);
  DipInSer.Session:=SessioneOracle;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RMCampoRagg:=A074FRiepilogoBuoni.CampoRagg;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RMStampa:=True;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RMIgnoraAnomalie:=chkIgnoraAnomalie.Checked;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RMRegistrazione:=(not SolaLettura) and ChkAggiorna.Checked;
  with A074FRiepilogoBuoniDtM1 do
  begin
    Screen.Cursor:=crHourGlass;
    C700SelAnagrafe.First;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
      while not C700SelAnagrafe.EOF do
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        ProgressBar1.StepBy(1);
        if DipInSer.DipendenteInServizio(C700Progressivo,DataI,DataF) then
          A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RiepilogoMensileMaturazione(C700Progressivo,Data,DataF,DataI);
        C700SelAnagrafe.Next;
      end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.Position:=0;
      Screen.Cursor:=crDefault;
      DipInSer.Free;
    end;
  end;
end;

procedure TA074FRiepilogoBuoni.ScorriQueryAnagraficaAcquisto;
var S:String;
    DipInSer:TDipendenteInServizio;
    Variazioni:Integer;
    Intestazione: String;
begin
  DipInSer:=TDipendenteInServizio.Create(nil);
  DipInSer.Session:=SessioneOracle;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RMCampoRagg:=A074FRiepilogoBuoni.CampoRagg;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RMStampa:=True;
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RMRegistrazione:=(not SolaLettura) and (chkAcqAggiornamento.Checked);
  with A074FRiepilogoBuoniDtM1 do
  begin
    Screen.Cursor:=crHourGlass;
    C700SelAnagrafe.First;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True;
    Self.Enabled:=False;
    try
    while not C700SelAnagrafe.EOF do
    begin
      frmSelAnagrafe.VisualizzaDipendente;
      ProgressBar1.StepBy(1);
      if DipInSer.DipendenteInServizio(C700Progressivo,R180InizioMese(DataAcquisto),R180FineMese(DataAcquisto)) then
      begin
        A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM.RiepilogoMensileAcquisto(C700Progressivo,DataAcquisto);
        //Registrazione del file sequenziale degli acquisti per prenotazione (Gemeaz)
        if RegistraFileSeq then
        begin
          Variazioni:=0;
          with A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.R350FCalcoloBuoniDtM do
          begin
            selT690.Close;
            selT690.SetVariable('PROGRESSIVO',C700Progressivo);
            selT690.SetVariable('DATA',DataAcquisto);
            selT690.Open;
            if (RiepilogoBT.Tipo = 'B') or (A074FGemeaz.chkBuoniPasto.Checked) then
              inc(Variazioni,selT690.FieldByName('BUONIPASTO').AsInteger);
            if (RiepilogoBT.Tipo = 'T') or (A074FGemeaz.chkTicket.Checked) then
              inc(Variazioni,selT690.FieldByName('TICKET').AsInteger);
            selT690.Close;
            if RiepilogoBT.Acquisto + Variazioni > 0 then
            begin
              S:=A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.GetRigaFile(RiepilogoBT.Acquisto + Variazioni,
                                                                           A074FGemeaz.edtSiglaTestata.Text,
                                                                           A074FGemeaz.edtCodCliente.Text,
                                                                           A074FGemeaz.edtValoreBuono.Text,
                                                                           CampoRagg,
                                                                           A074FGemeaz.cmbFormatoMatricola.Text,
                                                                           RaggruppamentoGemeaz,
                                                                           Intestazione,
                                                                           A074FGemeaz.rgpTipoFile.ItemIndex);

              if Intestazione <> '' then
                Writeln(FileSeq,Intestazione);

              Writeln(FileSeq,S);
            end;
          end;
        end;
      end;
      C700SelAnagrafe.Next;
    end;
    finally
      frmSelAnagrafe.ElaborazioneInterrompibile:=False;
      Self.Enabled:=True;
      frmSelAnagrafe.VisualizzaDipendente;
      Screen.Cursor:=crDefault;
      ProgressBar1.Position:=0;
      DipInSer.Free;
    end;
  end;
  if RegistraFileSeq and (A074FGemeaz.rgpTipoFile.ItemIndex = 0) then
    Writeln(FileSeq,Format('%s3%37s',[A074FGemeaz.edtSiglaTestata.Text,'']));
end;

procedure TA074FRiepilogoBuoni.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  if ChkDettaglio.Checked then
    C004FParamForm.PutParametro('DETTAGLIO','S')
  else
    C004FParamForm.PutParametro('DETTAGLIO','N');
  if ChkAcquisto.Checked then
    C004FParamForm.PutParametro('ACQUISTO','S')
  else
    C004FParamForm.PutParametro('ACQUISTO','N');
  if ChkInizioAnno.Checked then
    C004FParamForm.PutParametro('INIZIOANNO','S')
  else
    C004FParamForm.PutParametro('INIZIOANNO','N');
  if ChkSaltoPagina.Checked then
    C004FParamForm.PutParametro('SALTOPAGINA','S')
  else
    C004FParamForm.PutParametro('SALTOPAGINA','N');
  if chkIgnoraAnomalie.Checked then
    C004FParamForm.PutParametro('IGNORAANOMALIE','S')
  else
    C004FParamForm.PutParametro('IGNORAANOMALIE','N');
  if chkFileSequenziale.Checked then
    C004FParamForm.PutParametro('CREAFILESEQ','S')
  else
    C004FParamForm.PutParametro('CREAFILESEQ','N');
  if chkScaricoPaghe.Checked then
    C004FParamForm.PutParametro('CREAFILEACQ','S')
  else
    C004FParamForm.PutParametro('CREAFILEACQ','N');
  if chkAcqDatiIndividuali.Checked then
    C004FParamForm.PutParametro('ACQDATIINDIVIDUALI','S')
  else
    C004FParamForm.PutParametro('ACQDATIINDIVIDUALI','N');
  if chkAcqSaltoPagina.Checked then
    C004FParamForm.PutParametro('ACQSALTOPAGINA','S')
  else
    C004FParamForm.PutParametro('ACQSALTOPAGINA','N');
  C004FParamForm.PutParametro('FILESEQUENZIALE',edtFileSequenziale.Text);
  C004FParamForm.PutParametro('PARPAGHE',VarToStr(dcmbParametrizzazione.KeyValue));
  C004FParamForm.PutParametro('RAGGRUPPAMENTO',VarToStr(dcmbRaggrAnagrafico.KeyValue));
  C004FParamForm.PutParametro('CODCLIENTE',A074FGemeaz.edtCodCliente.Text);
  C004FParamForm.PutParametro('VALOREBUONO',A074FGemeaz.edtValoreBuono.Text);
  C004FParamForm.PutParametro('SIGLATESTATA',A074FGemeaz.edtSiglaTestata.Text);
  C004FParamForm.PutParametro('TIPOFILEGEMEAZ',IntToStr(A074FGemeaz.rgpTipoFile.ItemIndex));
  C004FParamForm.PutParametro('FORMATOMATRICOLA',A074FGemeaz.cmbFormatoMatricola.Text);
  if A074FGemeaz.chkTicket.Checked then
    C004FParamForm.PutParametro('TICKETGEMEAZ','S')
  else
    C004FParamForm.PutParametro('TICKETGEMEAZ','N');
  if A074FGemeaz.chkBuoniPasto.Checked then
    C004FParamForm.PutParametro('BUONIGEMEAZ','S')
  else
    C004FParamForm.PutParametro('BUONIGEMEAZ','N');
  C004FParamForm.PutParametro('chkSoloElaborazione',IfThen(chkSoloElaborazione.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TA074FRiepilogoBuoni.btnFileSequenzialeClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
    edtFileSequenziale.Text:=SaveDialog1.FileName;
end;

procedure TA074FRiepilogoBuoni.chkFileSequenzialeClick(Sender: TObject);
begin
  edtFileSequenziale.Enabled:=chkFileSequenziale.Checked;
  btnFileSequenziale.Enabled:=chkFileSequenziale.Checked;
  if chkFileSequenziale.Checked then
    chkScaricoPaghe.Checked:=False;
end;

procedure TA074FRiepilogoBuoni.chkScaricoPagheClick(Sender: TObject);
begin
  if chkScaricoPaghe.Checked then
  begin
    chkFileSequenziale.Checked:=False;
    if (dcmbParametrizzazione.KeyValue = null) or (Trim(dcmbParametrizzazione.Text) = '') then
    begin
      A074FRiepilogoBuoniDtM1.cdsT191.Edit;
      A074FRiepilogoBuoniDtM1.cdsT191.FieldByName('CODICE').AsString:='A074';
      A074FRiepilogoBuoniDtM1.cdsT191.Post;
    end;
  end;

  lblParPaghe.Enabled:=chkScaricoPaghe.Checked;
  dcmbParametrizzazione.Enabled:=chkScaricoPaghe.Checked;
end;

procedure TA074FRiepilogoBuoni.btnParametriGemeazClick(Sender: TObject);
begin
  A074FGemeaz.ShowModal;
end;

procedure TA074FRiepilogoBuoni.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=DataF;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA074FRiepilogoBuoni.frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  if PageControl1.ActivePage = tabMaturazione then
  begin
    C700DataDal:=DataI;
    C700DataLavoro:=DataF;
  end
  else
  begin
    C700DataDal:=R180InizioMese(DataAcquisto);
    C700DataLavoro:=R180FineMese(DataAcquisto);
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA074FRiepilogoBuoni.btnEliminaAcquistoClick(Sender: TObject);
var
 Data: TDateTime;
 Tot: Integer;
begin
  A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.CountUltimoAcquisto(Data,Tot);

  if Data <> DATE_NULL then
    if MessageDlg(Format(A000MSG_A074_DLG_FMT_ELIMINA_ACQUISTO,[Tot,UpperCase(FormatDateTime('mmmm yyyy',Data))]),
                  mtInformation,[mbYes,mbNo],0) = mrYes then
    begin
      A074FRiepilogoBuoniDtM1.A074FRiepilogoBuoniMW.EliminaAcquisto(Data);
      A074FRiepilogoBuoniDtM1.GetMeseUltimoAcquisto(True);
    end;
end;

procedure TA074FRiepilogoBuoni.dcmbRaggrAnagraficoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA074FRiepilogoBuoni.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PutParametriFunzione;
  FreeAndNil(C004FParamForm);
end;

procedure TA074FRiepilogoBuoni.FormDestroy(Sender: TObject);
begin
  FreeAndNil(A074FStampaBuoni);
  FreeAndNil(A074FStampaAcquisti);
  FreeAndNil(A074FGemeaz);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

{ DataF }
function TA074FRiepilogoBuoni._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TA074FRiepilogoBuoni._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ ----DataF }

{ DataI }
function TA074FRiepilogoBuoni._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TA074FRiepilogoBuoni._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ ----DataI }

end.
