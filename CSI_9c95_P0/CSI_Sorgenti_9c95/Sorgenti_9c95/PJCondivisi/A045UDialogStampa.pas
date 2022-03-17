unit A045UDialogStampa;
//Dal conto annuale 2012 (riferito al 2011) l'esportazione su file non c'è più
//Per fare il parallelo tra quello che esce dalla T11 del modulo Conto annuale e la stampa bisogna elaborarla così
//- selezionare i dipendenti in base a COD_CONTRATTO EDP e al filtro impostato su T11 del conto annuale
//- selezionare tutte le qualifiche
//- selezionare le tipologie di rapporto presenti nel filtro impostato su T11 del conto annuale
//- elaborarla con gli stessi parametri usati per la generazione di T43
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin , Grids, DBGrids, ExtCtrls,DB,ComCtrls, Oracle,
  CheckLst, Menus, A000UCostanti, A000USessione,A000UInterfaccia, A003UDataLavoroBis, OracleData,
  C001StampaLib,C004UParamForm, C005UDatiAnagrafici, C700USelezioneAnagrafe, C180FunzioniGenerali,
  SelAnagrafe, Variants, R500Lin, Rp502Pro, Math, Mask, C013UCheckList, C012UVisualizzaTesto,
  A000UMessaggi, A045UStatAssenzeMW,QRPDFFilt;

type
  TA045FDialogStampa = class(TForm)
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    Panel2: TPanel;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SaveDialog1: TSaveDialog;
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    chkElabora: TCheckBox;
    chkEsportaFile: TCheckBox;
    GroupBox1: TGroupBox;
    lblCodRegione: TLabel;
    lblCodAzienda: TLabel;
    EdtCodRegione: TEdit;
    EdtCodAzienda: TEdit;
    lblFile: TLabel;
    edtFile: TEdit;
    btnFile: TBitBtn;
    chkStampa: TCheckBox;
    chkAnteprima: TCheckBox;
    Panel3: TPanel;
    BitBtn7: TBitBtn;
    btnVisualizzaFile: TBitBtn;
    btnEsegui: TBitBtn;
    BtnPrinterSetUp: TBitBtn;
    Panel4: TPanel;
    BitBtn2: TBitBtn;
    edtAData: TMaskEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    edtDaData: TMaskEdit;
    Label1: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    LstListaCausali: TCheckListBox;
    TabSheet2: TTabSheet;
    LstListaTipiRapporto: TCheckListBox;
    rgpComparto: TRadioGroup;
    rgpTipoOperaz: TRadioGroup;
    TabSheet3: TTabSheet;
    chkGGLavorativi: TCheckBox;
    ChkAssTutte: TCheckBox;
    chkSantoPatrono: TCheckBox;
    ChkPartOr: TCheckBox;
    ChkContNumDip: TCheckBox;
    edtCausali: TEdit;
    Label3: TLabel;
    PgcArrotondamenti: TPageControl;
    TabAssenzeRilevate: TTabSheet;
    rgpArrotondamentoAssenza: TRadioGroup;
    rgpTipoArrotondamentoAssenza: TRadioGroup;
    TabTotaleAssenzeDipendente: TTabSheet;
    RgpArrotondamentoTotale: TRadioGroup;
    RgpTipoArrotondamentoTotale: TRadioGroup;
    TabTotaleAssenzeQualifica: TTabSheet;
    RgpArrotondamentoQualifica: TRadioGroup;
    RgpTipoArrotondamentoQualifica: TRadioGroup;
    btnCausali: TBitBtn;
    btnDisattivaElaborazioni: TBitBtn;
    procedure edtDaDataExit(Sender: TObject);
    procedure ChkPartOrClick(Sender: TObject);
    procedure ChkAssTutteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnDaDataClick(Sender: TObject);
    procedure BtnADataClick(Sender: TObject);
    procedure BtnPrinterSetUpClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpArrotondamentoAssenzaClick(Sender: TObject);
    procedure RgpArrotondamentoTotaleClick(Sender: TObject);
    procedure RgpArrotondamentoQualificaClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafebtnRicercaClick(Sender: TObject);
    procedure frmSelAnagrafebtnPrimoClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure btnCausaliClick(Sender: TObject);
    procedure BtnFileClick(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure chkEsportaFileClick(Sender: TObject);
    procedure chkElaboraClick(Sender: TObject);
    procedure chkAnteprimaClick(Sender: TObject);
    procedure chkStampaClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnDisattivaElaborazioniClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    InterrompiElaborazione:Boolean;
    procedure Controlli;
    procedure EstrazioneAssenze;
    procedure PutParametriFunzione;
    procedure GetParametriFunzione;
    procedure GeneraFile;
    procedure evtA045MergeSelAnagrafe(DataSet: TOracleDataSet; RicreaVariabili: Boolean);
    procedure evtA045MergeSettaPeriodo(DataSet: TOracleDataSet; DataDa, DataA: TDateTime);
    function evtA045SqlCreatoC700: String;
    procedure evtA045ShowMsg(Msg: String);
  public
    A045MW: TA045FStatAssenzeMW;
    Progressivo:LongInt;
    sDescTipiRapporto,DocumentoPDF:string;
    procedure PopolaListaQualifiche;
    procedure PopolaListaTipiRapporto;
  end;

var
  A045FDialogStampa: TA045FDialogStampa;

procedure OpenA045StatAssenze(Prog:LongInt);

implementation

uses A045UStampa;

{$R *.DFM}

procedure OpenA045StatAssenze(Prog:LongInt);
{Stampa ministeriale statistica assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA045StatAssenze') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
  end;
  //A045FStatAssenzeDtM1:=TA045FStatAssenzeDtM1.Create(nil);
  A045FDialogStampa:=TA045FDialogStampa.Create(nil);
  C700Progressivo:=Prog;
  with A045FDialogStampa do
    try
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      //A045FStatAssenzeDtM1.Free;
      if A045MW <> nil then
        A045MW.Free;
      Free;
    end;
end;

procedure TA045FDialogStampa.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'A045',Parametri.ProgOper);
  GetParametriFunzione;
  A045FStampa:=TA045FStampa.Create(nil);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=EncodeDate(R180Anno(Parametri.DataLavoro),1,1);
  C700DataDal:=EncodeDate(R180Anno(Parametri.DataLavoro),12,31);
  frmSelAnagrafe.CreaSelAnagrafe(A045MW,SessioneOracle, StatusBar,0,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  edtDaData.Text:=DateToStr(A045MW.DataInizio);
  edtAData.Text:=DateToStr(A045MW.DataFine);
  PopolaListaQualifiche;
  PopolaListaTipiRapporto;
  PageControl1.ActivePageIndex:=0;
  PgcArrotondamenti.ActivePageIndex:=0;
  InterrompiElaborazione:=False;
end;

procedure TA045FDialogStampa.EstrazioneAssenze;
begin
  with A045MW do
  begin
    //Inizializzo i conteggi
    CreaSQLEstrazioneAssenze(chkGGLavorativi.Checked);
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    C700SelAnagrafe.First;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    while not C700SelAnagrafe.Eof do
    begin
      Application.ProcessMessages;
      if InterrompiElaborazione then
      begin
        InterrompiElaborazione:=False;
        Screen.Cursor:=crDefault;
        ProgressBar1.Position:=0;
        StatusBar.Panels[1].Text:='';
        raise exception.Create(A000MSG_MSG_OPERAZIONE_INTERROTTA);
      end;
      ProgressBar1.StepBy(1);
      frmSelAnagrafe.VisualizzaDipendente;
      //Santo Patrono
      if chkSantoPatrono.Checked and ConteggiaPatrono(C700SelAnagrafe.FieldByName('Progressivo').AsInteger) then
        AggiungiDip;
      // Chiamata a 'ElaboraCausaliPresenza'
      GGLavorativiChecked:=chkGGLavorativi.Checked;
      AssTutteChecked:=ChkAssTutte.Checked;
      ChkPartOrChecked:=ChkPartOr.Checked;
      Causali:=edtCausali.Text;
      TipoArrotondamentoAssenzaItemIndex:=rgpTipoArrotondamentoAssenza.ItemIndex;
      ArrotondamentoAssenzaItemIndex:=rgpArrotondamentoAssenza.ItemIndex;
      ElaboraCausaliPresenza;
      C700SelAnagrafe.Next;
    end;
    ProgressBar1.Position:=0;
  end;
end;

procedure TA045FDialogStampa.Controlli;
var i: integer;
begin
  A045MW.DataInizio:=StrToDate(edtDaData.Text);
  A045MW.DataFine:=StrToDate(edtAData.Text);
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(A045MW.DataInizio,A045MW.DataFine) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;
  if C700SelAnagrafe.RecordCount = 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  if A045MW.DataInizio > A045MW.DataFine then
    raise Exception.Create(A000MSG_A045_ERR_ORDINE_DATE);
  //QUALIFICHE
  with A045MW do
  begin
    sQualifiche:='';
    for i:=0 to LstListaCausali.Items.Count - 1 do
      if LstListaCausali.Checked[i] then
      begin
        if sQualifiche <> '' then
          sQualifiche:=sQualifiche + ',';
        sQualifiche:=sQualifiche + '''' + Trim(Copy(LstListaCausali.Items[i],1, Pos(' - ', LstListaCausali.Items[i]))) + '''';
      end;
    if Trim(sQualifiche) = '' then
      raise Exception.Create(A000MSG_A045_ERR_SELEZ_QUALIFICA);
    //TIPI RAPPORTO
    sTipiRapporto:='';
    sDescTipiRapporto:='';
    for i:=0 to LstListaTipiRapporto.Items.Count - 1 do
      if LstListaTipiRapporto.Checked[i] then
      begin
        if sTipiRapporto <> '' then
        begin
          sTipiRapporto:=sTipiRapporto + ',';
          sDescTipiRapporto:=sDescTipiRapporto + ', ';
        end;
        sTipiRapporto:=sTipiRapporto + '''' + Trim(Copy(LstListaTipiRapporto.Items[i],1,5)) + '''';
        sDescTipiRapporto:= sDescTipiRapporto + Trim(Copy(LstListaTipiRapporto.Items[i],1,5));
      end;
  end;
end;

procedure TA045FDialogStampa.chkAnteprimaClick(Sender: TObject);
begin
  btnEsegui.Enabled:=chkElabora.Checked or chkAnteprima.Checked or chkStampa.Checked or chkEsportaFile.Checked;
  if (not chkElabora.Checked) and chkAnteprima.Checked then
    chkElabora.Checked:=True;
  chkStampa.Enabled:=not chkAnteprima.Checked;
  if not chkStampa.Enabled then
    chkStampa.Checked:=False;
  chkEsportaFile.Enabled:=not chkAnteprima.Checked;
  if not chkEsportaFile.Enabled then
    chkEsportaFile.Checked:=False;
  chkEsportaFileClick(nil);
end;

procedure TA045FDialogStampa.GeneraFile;
(*
var sRiga,sNomeFile:string;
    F:TextFile;
*)
begin
// Procedure già commentata prima dell'introduzione del Middleware
(*  try
    sNomeFile:=edtFile.Text;
    //Creo il nuovo file ...
    AssignFile(F, sNomeFile);
    Rewrite(F);
    with A045FStatAssenzeDtM1 do
    begin
      while not TabellaStampa.Eof do
      begin
        //sRiga:='';
        sRiga:=FormattaStringa(trim(edtCodRegione.Text),3,'s') + FormattaStringa(trim(edtCodAzienda.Text),3,'s');
        sRiga:=sRiga + FormatDateTime('yyyy', DataI);
        if rgpComparto.ItemIndex = 0 then
          sRiga:=sRiga + '01'
        else
          sRiga:=sRiga + '04';
        //Codice
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('Codice').AsString,6,'s');
        //Campi 6-9 Ferie
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NDipURagg1').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg1').AsString,8,'n');
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NDipDRagg1').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg1').AsString,8,'n');
        //Campi 10-13
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        //Campi 14-17
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        //Campi 18-21
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        //Campi 22-25
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa('0',8,'n');
        //Campi 26-29 Sciopero
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NDipURagg10').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg10').AsString,8,'n');
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NDipDRagg10').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg10').AsString,8,'n');
        //Campi 30-33 Altre assenze
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NDipURagg11').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg11').AsString,8,'n');
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NDipDRagg11').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg11').AsString,8,'n');
        //Campi 34-37 Totali
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NTotDipU').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(FloatToStr(TabellaStampa.FieldByName('NTotGioU').AsFloat),8,'n');
        if ChkContNumDip.Checked then
          sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NTotDipD').AsString,8,'n')
        else
          sRiga:=sRiga + FormattaStringa('0',8,'n');
        sRiga:=sRiga + FormattaStringa(FloatToStr(TabellaStampa.FieldByName('NTotGioD').AsFloat),8,'n');
        //Campi 38-41 Malattia
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg3').AsString,8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg3').AsString,8,'n');
        //Campi 42-45 Legge 104
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg5').AsString,8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg5').AsString,8,'n');
        //Campi 46-49 Maternità
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg7').AsString,8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg7').AsString,8,'n');
        //Campi 50-53 Permessi
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg9').AsString,8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg9').AsString,8,'n');
        //Campi 54-55 Formazione
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioURagg12').AsString,8,'n');
        sRiga:=sRiga + FormattaStringa(TabellaStampa.FieldByName('NGioDRagg12').AsString,8,'n');
        //Indicatore del tipo di operazione effettuata
        If rgpTipoOperaz.ItemIndex = 0 then
          sRiga:=sRiga + '0'
        else if rgpTipoOperaz.ItemIndex = 1 then
          sRiga:=sRiga + '1'
        else if rgpTipoOperaz.ItemIndex = 2 then
          sRiga:=sRiga + '9';
        //Scrivo il Record nel file...
        Writeln(F, sRiga);
        //Record successivo..
        TabellaStampa.Next;
      end;
      CloseFile(F);
//      ShowMessage('La generazione del file ' + sNomeFile + ' è terminata con esito positivo.');
    end;
  except
    A045FStatAssenzeDtM1.TabellaStampa.Close;
    CloseFile(F);
    raise exception.Create('ATTENZIONE!' + chr(13) + 'Si è verificato un errore durante la generazione del file ' +sNomeFile + '.');
  end;*)
end;

procedure TA045FDialogStampa.btnCausaliClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
  try
    with A045MW.selT275 do
    begin
      Close;
      Open;
      First;
      C013FCheckList.clbListaDati.Items.Add(' * PRESENZE * ');
      C013FCheckList.clbListaDati.Header[0]:=True;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
    with A045MW.selT305 do
    begin
      Close;
      Open;
      First;
      C013FCheckList.clbListaDati.Items.Add(' * GIUSTIFICAZIONE * ');
      C013FCheckList.clbListaDati.Header[C013FCheckList.clbListaDati.Count-1]:=True;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
        Next;
      end;
    end;
    R180PutCheckList(edtCausali.Text,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
      edtCausali.Text:=R180GetCheckList(5,C013FCheckList.clbListaDati);
  finally
    Release;
  end;
end;

procedure TA045FDialogStampa.BtnDaDataClick(Sender: TObject);
begin
  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtDaData.Text),'Dalla data:','G')));
  edtDaDataExit(nil);
end;

procedure TA045FDialogStampa.btnDisattivaElaborazioniClick(Sender: TObject);
begin
  if R180MessageBox(A000MSG_DLG_INTEROMPERE_OPERAZIONE,'DOMANDA') = mrYes then
    InterrompiElaborazione:=True;
end;

procedure TA045FDialogStampa.btnEseguiClick(Sender: TObject);
var DataCorr,DataInizioTmp,DataFineTmp:TDateTime;
begin
  Controlli;
  if A045MW.TipoModulo = 'CS' then
  begin
    if chkAnteprima.Checked and not chkElabora.Checked then
      if R180MessageBox(A000MSG_A045_DLG_ANTEPRIMA_ULTIMA_OPERAZ,'DOMANDA') <> mrYes then
        Exit;
    if chkStampa.Checked and not chkElabora.Checked then
      if R180MessageBox(A000MSG_A045_DLG_STAMPA_ULTIMA_OPERAZ,'DOMANDA') <> mrYes then
        Exit;
    if chkEsportaFile.Checked and not chkElabora.Checked then
      if R180MessageBox(A000MSG_A045_DLG_ESPORTAZ_ULTIMA_OPERAZ,'DOMANDA') <> mrYes then
        Exit;
    if chkElabora.Checked then
      if R180MessageBox(A000MSG_DLG_CONFERMA_ELABORAZIONE,'DOMANDA') <> mrYes then
        Exit;
    Screen.Cursor:= crHourGlass;
  end;
  A045FDialogStampa.KeyPreview:=True;
  if chkElabora.Checked then
  begin
    DataCorr:=A045MW.DataInizio;
    DataInizioTmp:=A045MW.DataInizio;
    DataFineTmp:=A045MW.DataFine;
    while DataCorr <= DataFineTmp do  //ciclo per ogni mese del periodo
    begin
      A045MW.DataInizio:=DataCorr;
      A045MW.DataFine:=Min(R180FineMese(DataCorr),DataFineTmp);
      StatusBar.Panels[1].Text:='Elaborazione ' + R180NomeMese(R180Mese(A045MW.DataFine)) + ' ' + IntToStr(R180Anno(A045MW.DataFine)) + ' in corso...';
      A045MW.SvuotaLista;
      EstrazioneAssenze;
      A045MW.OrdinaListaDip;
      //Chiamata a 'GeneraTabella'
      A045MW.ArrotondamentoTotaleItemIndex:=rgpArrotondamentoTotale.ItemIndex;
      A045MW.TipoArrotondamentoTotaleItemIndex:=rgpTipoArrotondamentoTotale.ItemIndex;
      A045MW.GeneraTabella;
      DataCorr:=R180InizioMese(R180AddMesi(DataCorr,1));
    end;
    A045MW.DataInizio:=DataInizioTmp;
    A045MW.DataFine:=DataFineTmp;
  end;
  if chkAnteprima.Checked or chkStampa.Checked then
  begin
    StatusBar.Panels[1].Text:='Elaborazione anno ' + IntToStr(R180Anno(A045MW.DataFine));
    A045MW.CreaTabellaStampa;
    A045MW.TipoArrotondamentoQualificaItemIndex:=rgpTipoArrotondamentoQualifica.ItemIndex;
    A045MW.ArrotondamentoQualificaItemIndex:=rgpArrotondamentoQualifica.ItemIndex;
    A045MW.CaricaTabellaStampa;
    A045MW.TabellaStampa.First;
    screen.Cursor:=crDefault;
    StatusBar.Panels[1].Text:='';
    //Massimo: Commentato in modo che per i richiami da WA045 per la stampa mi crea in ogni caso il file, anche se vuoto
    //if A045MW.TabellaStampa.RecordCount > 0 then
    //begin
      A045FStampa.CreaReport;
      if (Sender = Self) and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
      begin
          A045FStampa.RepR.ShowProgress:=False;
          A045FStampa.RepR.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
      end
      else if chkAnteprima.Checked then
        A045FStampa.RepR.Preview
      else
        A045FStampa.RepR.Print;
    //end
    //else if A045MW.TipoModulo = 'CS' then
      //R180MessageBox(A000MSG_A045_ERR_ASSENZE_NON_CORRISPONDONO,'ERRORE');
    A045MW.TabellaStampa.Close;
  end
  else if chkEsportaFile.Checked then
  begin
    if (trim(EdtCodRegione.Text ) = '') or (trim(EdtCodAzienda.Text ) = '') then
    begin
      screen.Cursor:=crDefault;
      StatusBar.Panels[1].Text:='';
      EdtCodRegione.SetFocus;
      raise Exception.Create(A000MSG_A045_ERR_CODICI_MANCANTI);
    end;
    if (trim(EdtFile.Text ) = '') then
    begin
      screen.Cursor:=crDefault;
      StatusBar.Panels[1].Text:='';
      EdtFile.SetFocus;
      raise Exception.Create(A000MSG_A045_ERR_FILE_ESPORTAZ);
    end;
    StatusBar.Panels[1].Text:='Elaborazione anno ' + IntToStr(R180Anno(A045MW.DataFine));
    A045MW.CreaTabellaStampa;
    A045MW.TipoArrotondamentoQualificaItemIndex:=rgpTipoArrotondamentoQualifica.ItemIndex;
    A045MW.ArrotondamentoQualificaItemIndex:=rgpArrotondamentoQualifica.ItemIndex;
    A045MW.CaricaTabellaStampa;
    A045MW.TabellaStampa.First;
    if A045MW.TabellaStampa.RecordCount > 0 then
      GeneraFile
    else
    begin
      Screen.Cursor:=crDefault;
      StatusBar.Panels[1].Text:='';
      if A045MW.TipoModulo = 'CS' then
        R180MessageBox(A000MSG_A045_ERR_ASSENZE_NON_CORRISPONDONO,'ERRORE');
    end;
    A045MW.TabellaStampa.Close;
  end;
  A045FDialogStampa.KeyPreview:=False;
  Screen.Cursor:=crDefault;
  StatusBar.Panels[1].Text:='';
  if (not chkAnteprima.Checked) and (not chkStampa.Checked) then
    ShowMessage(A000MSG_MSG_ELAB_OK);
end;

procedure TA045FDialogStampa.BtnFileClick(Sender: TObject);
var sNomeFile:String;
begin
  sNomeFile:='';
  SaveDialog1.Title:='Scelta nome file Statistica Ministeriale';
  SaveDialog1.FileName:='STATISTICA_MINISTERIALE.TXT';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if SaveDialog1.Execute then
  begin
    sNomeFile:=SaveDialog1.FileName;
    if FileExists(sNomeFile) then
      if R180MessageBox(Format(A000MSG_A045_DLG_FMT_SOSTITUZIONE_FILE,[sNomeFile]),'DOMANDA') = mrYes then
        Deletefile(sNomeFile)
      else
        sNomeFile:='';
  end;
  edtFile.Text:=sNomeFile;
end;

procedure TA045FDialogStampa.BtnADataClick(Sender: TObject);
begin
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',(DataOut(StrToDate(edtAData.Text),'Alla data:','G')));
  edtDaDataExit(nil);
end;

procedure TA045FDialogStampa.BtnPrinterSetUpClick(Sender: TObject);
begin
  if PrinterSetUpDialog1.Execute then
    C001SettaQuickReport(A045FStampa.RepR);
end;

procedure TA045FDialogStampa.btnVisualizzaFileClick(Sender: TObject);
begin
  try
    OpenC012VisualizzaTesto('<A045> Visualizzazione file di esportazione della statistica ministeriale assenze',edtFile.Text,nil,
                            'Visualizzazione file di esportazione della statistica ministeriale assenze del periodo '+ edtDaData.Text + ' - ' + edtAData.Text);
  except
    raise Exception.Create(A000MSG_ERR_VISUALIZ_FILE);
  end;
end;

procedure TA045FDialogStampa.PopolaListaQualifiche;
var i: Integer;
    LstQualifiche:TStringList;
begin
  LstQualifiche:=A045MW.CreaListaQualifiche;
  LstListaCausali.Items.Assign(LstQualifiche);
  FreeAndNil(LstQualifiche);
  for i:=0 to lstListaCausali.Count - 1 do
    lstListaCausali.Checked[i]:=True;
end;

procedure TA045FDialogStampa.PopolaListaTipiRapporto;
var i: Integer;
    LstRapporti:TStringList;
begin
  LstRapporti:=A045MW.CreaListaTipiRapporto;
  LstListaTipiRapporto.Items.Assign(LstRapporti);
  FreeAndNil(LstRapporti);
  for i:=0 to LstListaTipiRapporto.Count - 1 do
    LstListaTipiRapporto.Checked[i]:=True;
end;

procedure TA045FDialogStampa.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('REGIONE',EdtCodRegione.Text);
  C004FParamForm.PutParametro('AZIENDA',EdtCodAzienda.Text);
  C004FParamForm.PutParametro('CAUSALI',EdtCausali.Text);
  if ChkContNumDip.Checked then
    C004FParamForm.PutParametro('CONTNUMDIP','S')
  else
    C004FParamForm.PutParametro('CONTNUMDIP','N');
  if chkGGLavorativi.Checked then
    C004FParamForm.PutParametro('GGLAVORATIVI', 'S')
  else
    C004FParamForm.PutParametro('GGLAVORATIVI', 'N');
  if chkSantoPatrono.Checked then
    C004FParamForm.PutParametro('SANTOPATRONO', 'S')
  else
    C004FParamForm.PutParametro('SANTOPATRONO', 'N');
  if chkAssTutte.Checked then
    C004FParamForm.PutParametro('TEORICOGG', 'S')
  else
    C004FParamForm.PutParametro('TEORICOGG', 'N');
  C004FParamForm.PutParametro('TIPOOPERAZIONE',IntToStr(rgpTipoOperaz.ItemIndex));
  C004FParamForm.PutParametro('CONTRATTAZIONE',IntToStr(rgpComparto.ItemIndex));
  try SessioneOracle.Commit; except end;
end;

procedure TA045FDialogStampa.GetParametriFunzione;
{Leggo i parametri della form}
begin
  EdtCodRegione.Text:=C004FParamForm.GetParametro('REGIONE', '');
  EdtCodAzienda.Text:=C004FParamForm.GetParametro('AZIENDA', '');
  EdtCausali.Text:=C004FParamForm.GetParametro('CAUSALI', '');
  ChkContNumDip.Checked:=C004FParamForm.GetParametro('CONTNUMDIP', 'S') = 'S';
  chkGGLavorativi.Checked:=C004FParamForm.GetParametro('GGLAVORATIVI', 'S') = 'S';
  chkSantoPatrono.Checked:=C004FParamForm.GetParametro('SANTOPATRONO', 'N') = 'S';
  chkAssTutte.Checked:=C004FParamForm.GetParametro('TEORICOGG', 'S') = 'S';
  rgpTipoOperaz.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('TIPOOPERAZIONE', '1'),1);
  rgpComparto.ItemIndex:=StrToIntDef(C004FParamForm.GetParametro('CONTRATTAZIONE', '0'),0);
end;

procedure TA045FDialogStampa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PutParametriFunzione;
  C004FParamForm.Free;
end;

procedure TA045FDialogStampa.FormCreate(Sender: TObject);
begin
  A045MW:=TA045FStatAssenzeMW.Create(Self);
  A045MW.evtA045MergeSelAnagrafe:=evtA045MergeSelAnagrafe;
  A045MW.evtA045MergeSettaPeriodo:=evtA045MergeSettaPeriodo;
  A045MW.evtA045SqlCreatoC700:=evtA045SqlCreatoC700;
  A045MW.evtA045ShowMsg:=evtA045ShowMsg;
end;

procedure TA045FDialogStampa.evtA045ShowMsg(Msg: String);
begin
 if A045MW.TipoModulo = 'CS' then
   R180MessageBox(Msg,INFORMA);
end;

procedure TA045FDialogStampa.rgpArrotondamentoAssenzaClick(Sender: TObject);
begin
  if rgpArrotondamentoAssenza.ItemIndex > 0 then
    rgpTipoArrotondamentoAssenza.Enabled:=true
  else
  begin
    rgpTipoArrotondamentoAssenza.ItemIndex:=2;
    rgpTipoArrotondamentoAssenza.Enabled:=false;
  end;
end;

procedure TA045FDialogStampa.RgpArrotondamentoTotaleClick(Sender: TObject);
begin
  if rgpArrotondamentoTotale.ItemIndex > 0 then
    rgpTipoArrotondamentoTotale.Enabled:=true
  else
  begin
    rgpTipoArrotondamentoTotale.ItemIndex:=2;
    rgpTipoArrotondamentoTotale.Enabled:=false;
  end;
end;

procedure TA045FDialogStampa.RgpArrotondamentoQualificaClick(Sender: TObject);
begin
  if rgpArrotondamentoQualifica.ItemIndex > 0 then
    rgpTipoArrotondamentoQualifica.Enabled:=true
  else
  begin
    rgpTipoArrotondamentoQualifica.ItemIndex:=2;
    rgpTipoArrotondamentoQualifica.Enabled:=false;
  end;
end;

procedure TA045FDialogStampa.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  with (PopupMenu1.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
end;

procedure TA045FDialogStampa.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=A045MW.DataInizio;
  C700DataLavoro:=A045MW.DataFine;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  if frmSelAnagrafe.C700ModalResult = mrOK then
    PopolaListaQualifiche;
end;

procedure TA045FDialogStampa.frmSelAnagrafebtnRicercaClick(Sender: TObject);
begin
  frmSelAnagrafe.btnRicercaClick(Sender);
end;

procedure TA045FDialogStampa.frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
begin
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
  PopolaListaQualifiche;
end;

procedure TA045FDialogStampa.frmSelAnagrafebtnPrimoClick(Sender: TObject);
begin
  frmSelAnagrafe.btnBrowseClick(Sender);
end;

procedure TA045FDialogStampa.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA045FDialogStampa.FormDestroy(Sender: TObject);
begin
  A045FStampa.Release;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA045FDialogStampa.ChkAssTutteClick(Sender: TObject);
begin
  if ChkAssTutte.Checked then
  begin
    ChkPartOr.Checked:=False;
  end;
  ChkPartOr.Enabled:=Not(ChkAssTutte.Checked);
end;

procedure TA045FDialogStampa.chkElaboraClick(Sender: TObject);
begin
  btnEsegui.Enabled:=chkElabora.Checked or chkAnteprima.Checked or chkStampa.Checked or chkEsportaFile.Checked;
end;

procedure TA045FDialogStampa.chkEsportaFileClick(Sender: TObject);
begin
  if Sender = chkEsportaFile then
  begin
    btnEsegui.Enabled:=chkElabora.Checked or chkAnteprima.Checked or chkStampa.Checked or chkEsportaFile.Checked;
    if (not chkElabora.Checked) and chkEsportaFile.Checked then
      chkElabora.Checked:=True;
    chkAnteprima.Enabled:=not chkEsportaFile.Checked;
    if not chkAnteprima.Enabled then
      chkAnteprima.Checked:=False;
    chkStampa.Enabled:=not chkEsportaFile.Checked;
    if not chkStampa.Enabled then
      chkStampa.Checked:=False;
  end;
  btnVisualizzaFile.Enabled:=chkEsportaFile.Checked;
  rgpTipoOperaz.Enabled:=chkEsportaFile.Checked;
  rgpComparto.Enabled:=chkEsportaFile.Checked;
  edtCodRegione.Enabled:=chkEsportaFile.Checked;
  edtCodAzienda.Enabled:=chkEsportaFile.Checked;
  lblCodRegione.Enabled:=chkEsportaFile.Checked;
  lblCodAzienda.Enabled:=chkEsportaFile.Checked;
  lblFile.Enabled:=chkEsportaFile.Checked;
  edtFile.Enabled:=chkEsportaFile.Checked;
  btnFile.Enabled:=chkEsportaFile.Checked;
end;

procedure TA045FDialogStampa.ChkPartOrClick(Sender: TObject);
begin
  if ChkPartOr.Checked then
  begin
    ChkAssTutte.Checked:=False;
  end;
  ChkAssTutte.Enabled:=Not(ChkPartOr.Checked);
end;

procedure TA045FDialogStampa.chkStampaClick(Sender: TObject);
begin
  btnEsegui.Enabled:=chkElabora.Checked or chkAnteprima.Checked or chkStampa.Checked or chkEsportaFile.Checked;
  if (not chkElabora.Checked) and chkStampa.Checked then
    chkElabora.Checked:=True;
  chkAnteprima.Enabled:=not chkStampa.Checked;
  if not chkAnteprima.Enabled then
    chkAnteprima.Checked:=False;
  chkEsportaFile.Enabled:=not chkStampa.Checked;
  if not chkEsportaFile.Enabled then
    chkEsportaFile.Checked:=False;
  chkEsportaFileClick(nil);
end;

procedure TA045FDialogStampa.edtDaDataExit(Sender: TObject);
begin
  if (A045MW.DataInizio <> StrToDate(edtDaData.Text)) or (A045MW.DataFine <> StrToDate(edtAData.Text)) then
    PopolaListaQualifiche;
  A045MW.DataInizio:=StrToDate(edtDaData.Text);
  A045MW.DataFine:=StrToDate(edtAData.Text);
end;

procedure TA045FDialogStampa.evtA045MergeSelAnagrafe(DataSet: TOracleDataSet; RicreaVariabili: Boolean);
begin
  C700MergeSelAnagrafe(DataSet,RicreaVariabili);
end;

procedure TA045FDialogStampa.evtA045MergeSettaPeriodo(DataSet: TOracleDataSet; DataDa, DataA: TDateTime);
begin
  C700MergeSettaPeriodo(DataSet,DataDa,DataA);
end;

function TA045FDialogStampa.evtA045SqlCreatoC700: String;
begin
  Result:=C700FSelezioneAnagrafe.SQLCreato.Text
end;

end.
