unit B007UManipolazioneDati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, ComCtrls, DB, Menus, Math,
  checklst,A000UCostanti, A000USessione,A000UInterfaccia, C700USelezioneAnagrafe,
  C180FunzioniGenerali, ExtCtrls, A003UDataLavoroBis, SelAnagrafe,
  C005UDatiAnagrafici, Grids, DBGrids, Oracle, OracleData,
  Variants, C012UVisualizzaTesto, C013UCheckList, StrUtils,
  A083UMsgElaborazioni, C006UStoriaDati, C015UElencoValori, Mask,
  B007UManipolazioneDatiMW, A000UMessaggi, Generics.Collections,
  A023UAllTimbMW, FileCtrl, C004UParamForm;

type
  TCampi = TStringList;

  TString = class(TObject)
  private
    fStr: String;
  public
    constructor Create(const AStr: String) ;
    property Str: String read FStr write FStr;
  end;

  TCampo = record
    Nome: String;
    NomeLogico: String;
    DataType: String;
    DataLength: Integer;
    Info: String;
  end;

  TB007FManipolazioneDati = class(TForm)
    ProgressBar: TProgressBar;
    StatusBar: TStatusBar;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    PageControl1: TPageControl;
    tabCancellazioneDati: TTabSheet;
    tabCancellazioneGiustif: TTabSheet;
    rgpCancDati: TRadioGroup;
    tabRicodificaGiustif: TTabSheet;
    rgpCancGiust: TRadioGroup;
    rgpRicodificaGiust: TRadioGroup;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edtOldCausale: TEdit;
    Label3: TLabel;
    dCmbCausali: TDBLookupComboBox;
    Panel1: TPanel;
    BitVideo: TBitBtn;
    BtnClose: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Panel2: TPanel;
    LblDaData: TLabel;
    LblAData: TLabel;
    TBBDaData: TBitBtn;
    TBBAData: TBitBtn;
    tabStoricizzazione: TTabSheet;
    tabAllineamento: TTabSheet;
    dGrdValori: TDBGrid;
    rgpPeriodi: TRadioGroup;
    RadioGroup5: TRadioGroup;
    Panel5: TPanel;
    Label5: TLabel;
    dCmbDatoAgg: TDBLookupComboBox;
    chkStorico: TCheckBox;
    rgpTipoCaus: TRadioGroup;
    Label7: TLabel;
    DBText1: TDBText;
    tabUnioneProgressivi: TTabSheet;
    Panel7: TPanel;
    btnAggiornaMatr: TBitBtn;
    btnDatiAnag: TBitBtn;
    edtDatiAnag: TEdit;
    Label8: TLabel;
    GroupBox2: TGroupBox;
    dGrdMatricole: TDBGrid;
    btnAnomalie: TBitBtn;
    btnLog: TBitBtn;
    gpbTabelle: TGroupBox;
    chkLstTabelle: TCheckListBox;
    dGrdSchedeAnag: TDBGrid;
    pnlSchedeAnag: TPanel;
    chkLogSchedeAnag: TCheckBox;
    btnAggiornaSchedeAnag: TBitBtn;
    Invertiselezione1: TMenuItem;
    tabEsecuzioneScript: TTabSheet;
    Panel3: TPanel;
    MemoLog: TMemo;
    BtnEseguiScript: TButton;
    DlgApriScript: TOpenDialog;
    EdtPathFile: TEdit;
    chkStoriciSuccessivi: TCheckBox;
    tabRiallineaGiust: TTabSheet;
    Label1: TLabel;
    edtCausali: TEdit;
    btnScegliCaus: TButton;
    grpElencoCaus: TGroupBox;
    chklstCausGiust: TCheckListBox;
    GroupBox3: TGroupBox;
    clbDatiLiberi: TCheckListBox;
    tabMigrazioneDomicilio: TTabSheet;
    grpDatiDomicilio: TGroupBox;
    grpIndirizzoDomicilio: TGroupBox;
    grpCapDomicilio: TGroupBox;
    grpComuneDomicilio: TGroupBox;
    chkIndirizzoDomicilio: TCheckBox;
    chkCapDomicilio: TCheckBox;
    chkComuneDomicilio: TCheckBox;
    pnlIndirizzoDomicilio: TPanel;
    lblDescIndirizzoDomicilio: TLabel;
    lblIndirizzoSorg: TLabel;
    cmbIndirizzoDomicilio: TComboBox;
    pnlCapDomicilio: TPanel;
    lblCapSorg: TLabel;
    lblDescCapDomicilio: TLabel;
    cmbCapDomicilio: TComboBox;
    pnlComuneDomicilio: TPanel;
    lblComuneSorg: TLabel;
    lblDescComuneDomicilio: TLabel;
    lblInfoMigrazioneComune: TLabel;
    cmbComuneDomicilio: TComboBox;
    chkSovrascriviIndirizzo: TCheckBox;
    chkSovrascriviCap: TCheckBox;
    chkSovrascriviComune: TCheckBox;
    tabCestino: TTabSheet;
    cmbFiltrotabelle: TComboBox;
    dGrdCestino: TDBGrid;
    dsrI025: TDataSource;
    ppMnuCestino: TPopupMenu;
    Ripristina1: TMenuItem;
    Cancella1: TMenuItem;
    lblFunzione: TLabel;
    tabAllineaTimb: TTabSheet;
    dgrdTimbUguali: TDBGrid;
    pnlAllineaTimbTop: TPanel;
    btnRefreshAllTimb: TBitBtn;
    tabAllegatiIter: TTabSheet;
    pnlFiltro: TPanel;
    btnFiltro: TButton;
    chkFiltroAnagrafe: TCheckBox;
    dbgT960: TDBGrid;
    Panel4: TPanel;
    edtNuovoPath: TEdit;
    lblNuovoPathStorage: TLabel;
    btnNuovoPath: TButton;
    rgTest: TRadioGroup;
    procedure dcmbKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnEseguiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnADataClick(Sender: TObject);
    procedure TBBDaDataClick(Sender: TObject);
    procedure rgpCancDatiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure rgpCancGiustClick(Sender: TObject);
    procedure rgpRicodificaGiustClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure dCmbDatoAggCloseUp(Sender: TObject);
    procedure dCmbDatoAggKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rgpPeriodiClick(Sender: TObject);
    procedure RadioGroup5Click(Sender: TObject);
    procedure rgpTipoCausClick(Sender: TObject);
    procedure btnDatiAnagClick(Sender: TObject);
    procedure btnAggiornaMatrClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure btnAggiornaSchedeAnagClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAnomalieClick(Sender: TObject);
    procedure BtnEseguiScriptClick(Sender: TObject);
    procedure dGrdValoriExit(Sender: TObject);
    procedure btnScegliCausClick(Sender: TObject);
    procedure cmbIndirizzoDomicilioChange(Sender: TObject);
    procedure cmbCapDomicilioChange(Sender: TObject);
    procedure cmbComuneDomicilioChange(Sender: TObject);
    procedure cmbIndirizzoDomicilioKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkIndirizzoDomicilioClick(Sender: TObject);
    procedure chkCapDomicilioClick(Sender: TObject);
    procedure chkComuneDomicilioClick(Sender: TObject);
    procedure cmbFiltrotabelleChange(Sender: TObject);
    procedure dsrI025DataChange(Sender: TObject; Field: TField);
    procedure Ripristina1Click(Sender: TObject);
    procedure Cancella1Click(Sender: TObject);
    procedure ppMnuCestinoPopup(Sender: TObject);
    procedure btnRefreshAllTimbClick(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure chkFiltroAnagrafeClick(Sender: TObject);
    procedure btnNuovoPathClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgTestClick(Sender: TObject);
  private
    ElencoTab,LMessaggi:TStringList;
    InterrompiElaborazione:boolean;
    RisMsg:integer;
    tempoCancellazione: TTempoCancellazione;
    CampoIndirizzo, CampoCap, CampoComune: TCampo;
    IndirizzoDomicilioDefault: String;
    CapDomicilioDefault: String;
    ComuneDomicilioDefault: String;
    DatiAgg: TDatiAgg;
    procedure StatusBarSetInfo(const Testo: String = '');
    Procedure CancBudget;
    procedure CancRiepil;
    procedure CancGius;
    procedure CancGiusCaus;
    procedure RenCausali;
    procedure CancMesi(indice:Integer);
    procedure CancAnni(indice:Integer);
    procedure CancDate(indice:Integer);
    procedure CancDaA(indice:Integer);
    procedure CancellazioneDati;
    procedure CancellazioneGiustificativi;
    procedure RicodificaGiustificativi;
    procedure StoricizzazioneDati;
    procedure UnificazioneProgressivi;
    procedure RiallineamentoGiustificativi;
    procedure SetDomValoreDefault(PComboBox: TComboBox; PVal: String);
    function  ControlloMigrazioneDomicilio(var RErrMsg: String): Boolean;
    procedure MigrazioneDomicilio;
    function  GetCampo(const PNome, PNomeLogico, PDataType: String; const PDataLength: Integer): TCampo; overload;
    function  GetCampo(const PNome: String): TCampo; overload;
    function  GetUpdateCampo(const CampoSorgente, CampoDestinazione: TCampo; const PSovrascrivi: Boolean): String;
    procedure AllineamentoTimbrature;
    procedure ControlloDipendenti;
    procedure ImpostaFiltroAllegati;
    procedure ElaboraAllegatiIter;
    procedure DBtoFS;
    function DataMaxIter: TDateTime;
  public
    AllaData:TDateTime;
    DallaData:TDateTime;
    Badge,Nome:String;
end;

const
  CAMPO_INDIRIZZO_RESIDENZA = 'INDIRIZZO';
  CAMPO_CAP_RESIDENZA       = 'CAP';
  CAMPO_COMUNE_RESIDENZA    = 'COMUNE';
  CAMPO_INDIRIZZO_DOMICILIO = 'INDIRIZZO_DOM_BASE';
  CAMPO_CAP_DOMICILIO       = 'CAP_DOM_BASE';
  CAMPO_COMUNE_DOMICILIO    = 'COMUNE_DOM_BASE';

var
  B007FManipolazioneDati: TB007FManipolazioneDati;

procedure OpenB007ManipolazioneDati(Prog:Integer);

implementation

uses B007UManipolazioneDatiDtM1, B022UUtilityGestDocumentaleDM;

{$R *.DFM}

procedure OpenB007ManipolazioneDati(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenB007ManipolazioneDati') of
    'N','R':begin
            SolaLettura:=SolaLetturaOriginale;
            ShowMessage('Funzione non abilitata!');
            Exit;
            end;
  end;
  B022FUtilityGestDocumentaleDM:=TB022FUtilityGestDocumentaleDM.Create(nil);
  B007FManipolazioneDatiDtM1:=TB007FManipolazioneDatiDtM1.Create(nil);
  B007FManipolazioneDati:=TB007FManipolazioneDati.Create(nil);
  try
    C700Progressivo:=Prog;
    B007FManipolazioneDati.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(B007FManipolazioneDatiDtM1);
    FreeAndNil(B007FManipolazioneDati);
  end;
end;

procedure TB007FManipolazioneDati.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('NUOVOPATH',edtNuovoPath.Text);
  C004FParamForm.Free;
end;

procedure TB007FManipolazioneDati.FormCreate(Sender: TObject);
begin
  ElencoTab:=TStringList.Create;
  LMessaggi:=TStringList.Create;
  dsrI025.DataSet:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.MyCestino.Get_selI025;
  btnAnomalie.Enabled:=False;
  btnLog.Enabled:=False;
  DatiAgg.SelezioneAnagrafe:='';
  DatiAgg.Dal:=DATE_NULL;
  DatiAgg.Al:=DATE_NULL;
  //Tab allegati iter visibile solo se il parametro aziendale è impostato (valore diverso dal default)
  tabAllegatiIter.TabVisible:=StrToInt(Parametri.CampiRiferimento.C90_CancellaAnnoAllegatiIter) <> 99;
end;

procedure TB007FManipolazioneDati.FormShow(Sender: TObject);
var
  i:integer;
  Str:String;
  CampoCorr: TCampo;
begin
  // parametri utente
  CreaC004(SessioneOracle,'B007',Parametri.ProgOper);
  edtNuovoPath.Text:=C004FParamForm.GetParametro('NUOVOPATH','');

  // generale
  dGrdMatricole.DataSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrDipendentiUnificazione;
  dGrdSchedeAnag.DataSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrDipendenti;
  B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.DatoDaAggiornare:=VarToStr(dCmbDatoAgg.KeyValue);
  DBText1.DataSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrQ265;
  dCmbCausali.ListSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrQ265;
  AllaData:=Parametri.DataLavoro;
  DallaData:=Parametri.DataLavoro;
  LblAData.Caption:=FormatDateTime('dd MMM yyyy',AllaData);
  LblDaData.Caption:=FormatDateTime('dd MMM yyyy',DallaData);
  PageControl1.ActivePage:=TabStoricizzazione;
  PageControl1Change(nil);
  //RadioGroup1Click(nil);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ', T430INIZIO, T430FINE';
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW, SessioneOracle,StatusBar,0,True);
  frmSelAnagrafe.SoloPersonaleInterno:=False;
  frmSelAnagrafe.SelezionePeriodica:=True;
// inizializzazione TabSheet1
  ElencoTab.Clear;
  chkLstTabelle.Clear;
  for i:=0 to high(TabelleCancella) do
    ElencoTab.Add(Format('%-40s <%s>',[TabelleCancella[i].Desc,TabelleCancella[i].Nome]));
// inizializzazione TabSheet2
  chklstCausGiust.Clear;
  with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.selQ265 do
  begin
    First;
    while not Eof do
    begin
      chklstCausGiust.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
// inizializzazione TabSheet5
  TabAllineamento.TabVisible:=False;  //Lorena 04/06/2008 -- tolta momentaneamente x nuova gestione dati liberi
  clbDatiLiberi.Clear;
  clbDatiLiberi.ScrollWidth:=clbDatiLiberi.Width;
  with B007FManipolazioneDatiDtM1.selI500 do
  begin
    Filter:='(RIFERIMENTO = ''S'') OR (RIFERIMENTO = ''L'')';
    Filtered:=True;
    First;
    while not Eof do
    begin
      if FieldByName('RIFERIMENTO').AsString <> 'L' then
      begin
        clbDatiLiberi.Items.Add(FieldByName('NOMECAMPO').AsString + ' link--> ' +
                                FieldByName('NOMELINK').AsString);
        if clbDatiLiberi.Canvas.TextWidth(clbDatiLiberi.Items[clbDatiLiberi.Count - 1]) > clbDatiLiberi.ScrollWidth then
          clbDatiLiberi.ScrollWidth:=clbDatiLiberi.Canvas.TextWidth(clbDatiLiberi.Items[clbDatiLiberi.Count - 1]);
      end
      else
      begin
        Str:=FieldByName('NOMELINK').AsString + ',';
        while ((pos(',',Str) <> 0) and (Length(Str) > 0)) do
        begin
          clbDatiLiberi.Items.Add(FieldByName('NOMECAMPO').AsString + ' link--> ' + copy(Str,0,pos(',',Str)-1));
          Str:=copy(Str,pos(',',Str)+1,Length(Str));
        end;
      end;
      Next;
    end;
    Filter:='';
    Filtered:=False;
  end;

  // inizializzazione dati migrazione domicilio
  // il dataset contiene i soli dati liberi della T430
  // + i dati fissi legati alla residenza (indirizzo, cap, comune)
  // + i dati fissi legati al domicilio (indirizzo, cap, comune)
  // escludendo tutti i dati decodificati (T430D_*)
  // cfr. B007UManipolazioneDatiDtM1.B007FCancellaDtM1Create
  with B007FManipolazioneDatiDtM1.selI010MigrDom do
  begin
    // estrae datatype + datalength dei dati di domicilio
    CampoIndirizzo:=GetCampo(CAMPO_INDIRIZZO_DOMICILIO);
    CampoCap:=GetCampo(CAMPO_CAP_DOMICILIO);
    CampoComune:=GetCampo(CAMPO_COMUNE_DOMICILIO);
    First;
    while not Eof do
    begin
      CampoCorr:=GetCampo(FieldByName('NOME_CAMPO').AsString,FieldByName('NOME_LOGICO').AsString,FieldByName('DATA_TYPE').AsString,FieldByName('DATA_LENGTH').AsInteger);

      // non aggiunge alle liste i campi anagrafici di destinazione
      if (CampoCorr.Nome <> CAMPO_INDIRIZZO_DOMICILIO) and
         (CampoCorr.Nome <> CAMPO_CAP_DOMICILIO) and
         (CampoCorr.Nome <> CAMPO_COMUNE_DOMICILIO) then
      begin
        // per indirizzo e cap considera solo i campi con datatype uguale
        if (CampoCorr.Nome <> CAMPO_CAP_RESIDENZA) and
           (CampoCorr.Nome <> CAMPO_COMUNE_RESIDENZA) and
           (CampoCorr.DataType = CampoIndirizzo.DataType) then
        begin
          cmbIndirizzoDomicilio.AddItem(CampoCorr.NomeLogico,TString.Create(Format('%s (%s)',[CampoCorr.Nome,CampoCorr.Info])));
        end;

        if (CampoCorr.Nome <> CAMPO_INDIRIZZO_RESIDENZA) and
           (CampoCorr.Nome <> CAMPO_COMUNE_RESIDENZA) and
           (CampoCorr.DataType = CampoCap.DataType) then
        begin
          cmbCapDomicilio.AddItem(CampoCorr.NomeLogico,TString.Create(Format('%s (%s)',[CampoCorr.Nome,CampoCorr.Info])));
        end;

        // per comune non filtra in base al datatype perché il dato potrebbe essere tabellare
        if (CampoCorr.Nome <> CAMPO_INDIRIZZO_RESIDENZA) and
           (CampoCorr.Nome <> CAMPO_CAP_RESIDENZA) then
        begin
          cmbComuneDomicilio.AddItem(CampoCorr.NomeLogico,TString.Create(Format('%s (%s)',[CampoCorr.Nome,CampoCorr.Info])));
        end;
      end;

      Next;
    end;
  end;

  // imposta i dati di default se presenti su P500
  // la select viene effettuata sull'ultimo anno presente in tabella -> max(anno)
  IndirizzoDomicilioDefault:=VarToStr(B007FManipolazioneDatiDtM1.selI010MigrDom.Lookup('NOME_CAMPO',CAMPO_INDIRIZZO_RESIDENZA,'NOME_LOGICO'));
  CapDomicilioDefault:=VarToStr(B007FManipolazioneDatiDtM1.selI010MigrDom.Lookup('NOME_CAMPO',CAMPO_CAP_RESIDENZA,'NOME_LOGICO'));
  ComuneDomicilioDefault:=VarToStr(B007FManipolazioneDatiDtM1.selI010MigrDom.Lookup('NOME_CAMPO',CAMPO_COMUNE_RESIDENZA,'NOME_LOGICO'));

  // abilita i checkbox in base ai dati di default riconosciuti
  chkIndirizzoDomicilio.Checked:=cmbIndirizzoDomicilio.ItemIndex > -1;
  chkCapDomicilio.Checked:=cmbCapDomicilio.ItemIndex > -1;
  chkComuneDomicilio.Checked:=cmbComuneDomicilio.ItemIndex > -1;

  ImpostaFiltroAllegati;
end;

procedure TB007FManipolazioneDati.ControlloDipendenti;
// aggiornamento C700Selanagrafe
// e controllo che ci sia almeno un dipendente selezionato
begin
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DallaData,AllaData) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
end;

procedure TB007FManipolazioneDati.BtnEseguiClick(Sender: TObject);
var
  ErrMsg: String;
  lstOutput: TStringList;
begin
  LMessaggi.Clear;
  ProgressBar.Position:=0;
  RisMsg:=mrYes;
  RegistraMsg.IniziaMessaggio('B007');
  if PageControl1.ActivePage = tabCancellazioneDati then
  begin
    if rgpCancDati.ItemIndex = 0 then
      ControlloDipendenti;
    CancellazioneDati;
  end
  else if PageControl1.ActivePage = tabCancellazioneGiustif then
  begin
    if rgpCancGiust.ItemIndex = 1 then
      ControlloDipendenti;
    CancellazioneGiustificativi;
  end
  else if PageControl1.ActivePage = tabRicodificaGiustif then
  begin
    if rgpRicodificaGiust.ItemIndex = 1 then
      ControlloDipendenti;
    RicodificaGiustificativi;
  end
  else if PageControl1.ActivePage = tabStoricizzazione then
  begin
    ControlloDipendenti;
    StoricizzazioneDati;
  end
  else if PageControl1.ActivePage = tabUnioneProgressivi then
  begin
    UnificazioneProgressivi;
  end
  else if PageControl1.ActivePage = tabEsecuzioneScript then
  begin
    if Trim(EdtPathFile.Text) = '' then
      raise Exception.Create(A000MSG_B007_ERR_INDICARE_FILE_SCRIPT);
    if not FileExists(EdtPathFile.Text) then
      raise Exception.Create(A000MSG_ERR_FILE_INESISTENTE);
    lstOutput:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.EseguiScript(EdtPathFile.Text);
    MemoLog.Lines.Assign(lstOutput);
    FreeAndNil(lstOutput);
  end
  else if PageControl1.ActivePage = tabRiallineaGiust then
  begin
    ControlloDipendenti;
    RiallineamentoGiustificativi;
  end
  else if PageControl1.ActivePage = tabMigrazioneDomicilio then
  begin
    ControlloDipendenti;
    if ControlloMigrazioneDomicilio(ErrMsg) then
    begin
      MigrazioneDomicilio;
    end
    else
    begin
      LMessaggi.Add(ErrMsg);
    end;
  end
  else if PageControl1.ActivePage = tabAllegatiIter then
  begin
    ElaboraAllegatiIter;
  end
  else
  begin
    ControlloDipendenti;
    // effettua allineamento timbrature uguali per i dipendenti nel periodo
    AllineamentoTimbrature;
    // refresh vista
    btnRefreshAllTimbClick(nil);
  end;

  StatusBarSetInfo('');
  ProgressBar.Position:=0;
  Screen.Cursor:=crDefault;
  if LMessaggi.Count > 1 then
  begin
    // elenco di anomalie -> visualizzazione con editor di testo
    R180MessageBox('Operazione terminata con errori.'#13#10'Premere OK per visualizzarli',ESCLAMA);
    OpenC012VisualizzaTesto(Self.Caption + ' - anomalie','',LMessaggi,'');
  end
  else if LMessaggi.Count = 1 then
  begin
    // una anomalia -> messagebox
    R180MessageBox(LMessaggi.Text,ESCLAMA);
  end
  else
  begin
    // nessuna anomalia
    R180MessageBox('Operazione terminata.',INFORMA);
  end;
end;

procedure TB007FManipolazioneDati.BtnEseguiScriptClick(Sender: TObject);
var Path:String;
begin
  Path:=R180EstraiPercorsoFile(Application.ExeName) + 'Archivi\Temp';
  if Not DirectoryExists(Path) then
    Path:=R180EstraiPercorsoFile(Application.ExeName);
  DlgApriScript.InitialDir:=Path;

  MemoLog.Lines.Clear;
  with B007FManipolazioneDatiDtM1 do //???
    if DlgApriScript.Execute then
      EdtPathFile.Text:=DlgApriScript.FileName;
end;

procedure TB007FManipolazioneDati.btnFiltroClick(Sender: TObject);
begin
  ImpostaFiltroAllegati;
end;

procedure TB007FManipolazioneDati.btnLogClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'B007','I');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TB007FManipolazioneDati.btnNuovoPathClick(Sender: TObject);
var
  Dir:String;
begin
 { Options:=DlgApriScript.Options;
  DlgApriScript.InitialDir:=edtNuovoPath.Text;
  DlgApriScript.   :=[fdoPickFolders];

  if DlgApriScript.Execute then
    edtNuovoPath.Text:=DlgApriScript.FileName;

  DlgApriScript.Options:=Options;   }
   DIr:=edtNuovoPath.Text;
   if FileCtrl.SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt],-1) then
    edtNuovoPath.Text:=Dir;
end;

procedure TB007FManipolazioneDati.btnScegliCausClick(Sender: TObject);
var
  ElencoValoriChecklist: TElencoValoriChecklist;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with C013FCheckList do
    begin
      ElencoValoriChecklist:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.ListaTesteCatena;

      clbListaDati.Items.Clear;
      clbListaDati.Items.Assign(ElencoValoriChecklist.lstDescrizione);

      R180PutCheckList(edtCausali.Text,5,clbListaDati);
      if (ShowModal = mrOK) then
        edtCausali.Text:=R180GetCheckList(5,clbListaDati);
    end;
  finally
    FreeAndNil(ElencoValoriChecklist);
    C013FCheckList.Free;
  end;
end;

procedure TB007FManipolazioneDati.StatusBarSetInfo(const Testo: String = '');
{ imposta il testo del pannello informativo della statusbar e forza un repaint }
begin
  try
    StatusBar.Panels[1].Text:=Testo;
    StatusBar.Repaint;
  except
  end;
end;

procedure TB007FManipolazioneDati.CancellazioneDati;
var i:integer;
    ok,Anom:boolean;
    s,messaggio,funzione,InputString:string;
    indice, ContaDel: integer;
begin
  if rgpCancDati.ItemIndex = 0 then  // cancellazione dei dipendenti selezionati
  begin
    messaggio:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.MessaggioConfermaCancellazioneDatiDipendente;
    if Application.MessageBox(PChar(Messaggio), PChar('ATTENZIONE!!!'), MB_YESNO + MB_ICONEXCLAMATION + MB_DEFBUTTON2) = IDNO then
    begin
      LMessaggi.Add(A000MSG_MSG_OPERAZIONE_ANNULLATA);
      exit;
    end;
    InputString:=InputBox('Conferma cancellazione', 'Indicare il numero di dipendenti da cancellare:', '0');
    if (InputString = '0') or (InputString <> IntToStr(C700SelAnagrafe.RecordCount)) then
    begin
      LMessaggi.Add(A000MSG_MSG_OPERAZIONE_ANNULLATA);
      exit;
    end;
//    ProgressBar.Max:=high(TabelleCancella) * C700SelAnagrafe.RecordCount;
    with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
    begin
      selCols.Close;
      selCols.Open;
      ProgressBar.Max:=selCols.RecordCount * C700SelAnagrafe.RecordCount;
    end;
    Anom:=False;
    btnAnomalie.Enabled:=False;
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.Eof do
    begin
      with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
      begin
        selCols.First;
        while not selCols.Eof do
        begin
          StatusBar.Panels[1].Text:='Cancellazione in corso della tabella '+selCols.FieldByName('TABELLA').AsString;
          StatusBar.Repaint;
          if (not ElaborazioneCancellaTabellaDipendente(selCols.FieldByName('TABELLA').AsString)) then
            Anom:=True;
          selCols.Next;
          ProgressBar.StepBy(1);
        end;
        if (not ElaborazioneCancellatabelleAnagDipendente) then
          Anom:=True;
      end;

      C700SelAnagrafe.Next;
    end;
    if Anom then
    begin
      btnAnomalie.Enabled:=True;
      LMessaggi.Add(A000MSG_MSG_ELABORAZIONE_ANOMALIE);
      Exit;
    end;
  end
  else if rgpCancDati.ItemIndex = 1 then  //Cancellazione schede anagrafiche
  begin
    if dGrdSchedeAnag.SelectedRows.Count <= 0 then
      raise Exception.Create(A000MSG_B007_ERR_NO_MATRICOLA);

    messaggio:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.MessaggioConfermaCancellazioneSchedeAnag(dGrdSchedeAnag.SelectedRows.Count);
    if R180MessageBox(messaggio ,'DOMANDA') <> mrYes then
      Exit;
    Screen.Cursor:=crHourGlass;
    ProgressBar.Position:=0;
    ProgressBar.Max:=dGrdMatricole.SelectedRows.Count;
    with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
    begin
      cdsDipendenti.First;
      ContaDel:=0;
      while not cdsDipendenti.Eof do
      begin
        if dGrdSchedeAnag.SelectedRows.CurrentRowSelected then
        begin
          ProgressBar.StepBy(1);
          ElaborazioneCancellaSchedaAnagDipendente(cdsDipendenti.FieldByName('PROGRESSIVO').AsInteger);
          inc(ContaDel);
        end;
        cdsDipendenti.Next;
      end;
    end;

    Screen.Cursor:=crDefault;
    ProgressBar.Position:=0;
    R180MessageBox('Operazione conclusa: ' + IntToStr(ContaDel) + ' anagrafiche cancellate!','INFORMA');
  end
  else if (rgpCancDati.ItemIndex = 2) or (rgpCancDati.ItemIndex = 3) then
  begin
    // cancellazione dati periodici
    if rgpCancDati.ItemIndex = 3 then
      // controllo almeno un dipendente selezionato
      if C700SelAnagrafe.RecordCount = 0 then
        raise exception.Create(A000MSG_ERR_NO_DIP);
    ok:=False;
    indice:=0;
    for i:=0 to chkLstTabelle.Items.Count - 1 do
      if chkLstTabelle.Checked[i] then
      begin
        ok:=True;
        inc(indice);
      end;
    if not ok then
      raise exception.Create(A000MSG_B007_ERR_NO_TABELLA);
    ProgressBar.Max:=indice;
    tempoCancellazione:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.InizializzaTempo(DallaData, AllaData);
    Anom:=False;
    btnAnomalie.Enabled:=False;
    for i:=0 to chkLstTabelle.Items.Count - 1 do
    begin
      if (RisMsg=mrCancel) then
        break;
      if chkLstTabelle.Checked[i] then
      begin
        funzione:=StringReplace(StringReplace(chkLstTabelle.Items[i],'[','<',[]),']','>',[]);
        indice:=ElencoTab.IndexOf(funzione);
        if ((rgpCancDati.ItemIndex = 3) and (TabelleCancella[indice].Indiv)) or (rgpCancDati.ItemIndex = 2) then
          // prosegue solo se la tabella è individuale e si è scelta la cancellazione periodica per dipendente
          // oppure se si è scelta la cancellazione periodica totale
(*          if TabelleCancella[indice].Nome='T500_PIANTAORG' then
            CancPiantaOrg
          else*)
            if B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.IsBudgetAnno(indice) then
              try
                CancBudget
              except
                on E:Exception do
                begin
                  Anom:=True;
                  s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,[TabelleCancella[indice].Nome]);
                  RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                end;
              end
            else
              if B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.IsSchedaRiepil(indice) then
                try
                  CancRiepil
                 except
                   on E:Exception do
                   begin
                     Anom:=True;
                     s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,[TabelleCancella[indice].Nome]);
                     RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                   end;
                end
              else
                if B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.IsGiustificativi(indice) then
                  try
                    CancGius
                  except
                    on E:Exception do
                    begin
                      Anom:=True;
                      s:=Format(A000MSG_B007_ERR_FMT_CANC_TAB,[TabelleCancella[indice].Nome]);
                      RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                    end;
                  end
                else
                  case TabelleCancella[indice].Peri of
                    'M':    //cancellazione per mesi
                       if tempoCancellazione.MeseOk then
                         try
                           CancMesi(indice);
                         except
                           on E:Exception do
                           begin
                             Anom:=True;
                             s:='Cancellazione ' + TabelleCancella[indice].Nome + ' terminata con anomalie';
                             RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                           end;
                         end;
                    'A':   //cancellazione per anni
                       if tempoCancellazione.AnnoOk then
                         try
                           CancAnni(indice);
                         except
                           on E:Exception do
                           begin
                             Anom:=True;
                             s:='Cancellazione ' + TabelleCancella[indice].Nome + ' terminata con anomalie';
                             RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                           end;
                         end;
                    'G':   //cancellazione per giorni
                       try
                         CancDate(indice);
                       except
                         on E:Exception do
                         begin
                           Anom:=True;
                           s:='Cancellazione ' + TabelleCancella[indice].Nome + ' terminata con anomalie';
                           RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                         end;
                       end;
                    'E':   //cancellazione per giorni minimo 1 mese
                       if tempoCancellazione.MeseOk then
                         try
                           CancDate(indice);
                         except
                           on E:Exception do
                           begin
                             Anom:=True;
                             s:='Cancellazione ' + TabelleCancella[indice].Nome + ' terminata con anomalie';
                             RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                           end;
                         end;
                    'D':   //Cancellazione Da..A
                       try
                         CancDaA(indice);
                       except
                         on E:Exception do
                         begin
                           Anom:=True;
                           s:='Cancellazione ' + TabelleCancella[indice].Nome + ' terminata con anomalie';
                           RegistraMsg.InserisciMessaggio('A',Format('%s: %s',[s,E.Message]),'',C700Progressivo);
                         end;
                       end;
                  end; // chiusura case
      end; // chiude if su checked
    end; // chiude il for su CheckListBox1
    if Anom then
    begin
      btnAnomalie.Enabled:=True;
      LMessaggi.Add('Operazione conclusa con anomalie');
      Exit;
    end;
  end;
end;

procedure TB007FManipolazioneDati.CancellazioneGiustificativi;
var i:integer;
    ok:boolean;
begin
  ok:=False;
  for i:=0 to chklstCausGiust.Items.Count-1 do
    if chklstCausGiust.Checked[i] then
      ok:=True;
  if not ok then
    raise exception.Create(A000MSG_B007_ERR_NO_CAUSALE);
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  CancGius;
end;

procedure TB007FManipolazioneDati.RicodificaGiustificativi;
begin
  if (edtOldCausale.Text='') or (dCmbCausali.Text='') then
    raise exception.Create(A000MSG_B007_ERR_DATI_RICODIFICA);
  RenCausali;
end;

procedure TB007FManipolazioneDati.Cancella1Click(Sender: TObject);
var
  msg, Cod:string;
  i:integer;
begin
  if dGrdCestino.SelectedRows.Count = 1 then
    Msg:=A000MSG_B007_DLG_FMT_CANCELLA_CODICE
  else
    Msg:=A000MSG_B007_DLG_FMT_CANCELLA_CODICI;
  Cod:='';
  for i:=0 to dGrdCestino.SelectedRows.Count - 1 do
  begin
    Cod:=Cod + dGrdCestino.DataSource.DataSet.FieldByName('CHIAVE').AsString;
    if i < dGrdCestino.SelectedRows.Count - 1 then
      Cod:=Cod + ', ';
  end;
  if R180MessageBox(Format(Msg,[Cod]),DOMANDA,'Cancellazione') = mrNo then
    Exit;
  Msg:='';
  with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
  begin
    for i:=0 to dGrdCestino.SelectedRows.Count - 1 do
    begin
      dGrdCestino.DataSource.DataSet.GotoBookmark(dGrdCestino.SelectedRows.Items[i]);
      msg:=msg + #13#10 + CancellaCestino;
    end;
    if Trim(msg) <> '' then
      R180MessageBox(Msg,ERRORE)
    else
      R180MessageBox(A000MSG_B007_DLG_CANCELLA_OK,INFORMA);
    MyCestino.Get_selI025.Refresh;
  end;
  dGrdCestino.SelectedRows.Clear;
  dGrdCestino.SelectedRows.CurrentRowSelected:=True;
end;

procedure TB007FManipolazioneDati.Ripristina1Click(Sender: TObject);
var
  Msg,Cod, NuovoValore,s:string;
  i:integer;
begin
  //Creazione messaggio di conferma
  if dGrdCestino.SelectedRows.Count = 1 then
    Msg:=A000MSG_B007_DLG_FMT_RIPRISTINA_CODICE
  else
    Msg:=A000MSG_B007_DLG_FMT_RIPRISTINA_CODICI;
  Cod:='';
  for i:=0 to dGrdCestino.SelectedRows.Count - 1 do
  begin
    dGrdCestino.DataSource.DataSet.GotoBookmark(dGrdCestino.SelectedRows.Items[i]);
    Cod:=Cod + dGrdCestino.DataSource.DataSet.FieldByName('CHIAVE').AsString;
    if i < dGrdCestino.SelectedRows.Count - 1 then
      Cod:=Cod + ', ';
  end;
  if R180MessageBox(Format(Msg,[Cod]),DOMANDA,'Ripristino') = mrNo then
    Exit;

  //Esecuzione ripristino o cancellazione
  Msg:='';
  with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
  begin
    for i:=0 to dGrdCestino.SelectedRows.Count - 1 do
    begin
      dGrdCestino.DataSource.DataSet.GotoBookmark(dGrdCestino.SelectedRows.Items[i]);
      NuovoValore:='';
      if MyCestino.TestRipristino then
      begin
        if dGrdCestino.SelectedRows.Count = 1 then
        begin
          NuovoValore:=MyCestino.Get_selI025.FieldByName('CHIAVE').AsString;
          s:=Format(A000MSG_B007_DLG_FMT_RIDEF_RIPRISTINA,[MyCestino.Get_selI025.FieldByName('TABELLA').AsString,MyCestino.Get_selI025.FieldByName('CHIAVE').AsString]);
          if not InputQuery('Rinomina valore', s , NuovoValore) then
            Break;
        end
        else
          Msg:=Msg + #13#10'Nella tabella "' + MyCestino.Get_selI025.FieldByName('TABELLA').AsString + '" esiste già il valore "'
                   + MyCestino.Get_selI025.FieldByName('CHIAVE').AsString + '".';
      end;
      Msg:=Msg + RipristinaCestino(NuovoValore);
    end;
  end;
  if Trim(Msg) <> '' then
    R180MessageBox(Msg,ERRORE)
  else
    R180MessageBox(A000MSG_B007_DLG_RIPRISTINA_OK,INFORMA);
  B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.MyCestino.Get_selI025.Refresh;
  dGrdCestino.SelectedRows.Clear;
  dGrdCestino.SelectedRows.CurrentRowSelected:=True;
end;

procedure TB007FManipolazioneDati.StoricizzazioneDati;
var
  sMsg:String;
  PreparazioneStoricizzazione: TPreparazioneStoricizzazione;
  ParametriStoricizzazione: TParametriStoricizzazione;
  bRecordAggiornati: Boolean;
begin
  with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
  begin
    sMsg:=ControlliStoricizzazione(VarToStr(dCmbDatoAgg.KeyValue),chkStoriciSuccessivi.Checked);
    if sMsg <> '' then
      raise Exception.Create(sMsg);

    // Conferma
    if R180MessageBox(MessaggioConfermaStoricizzazione(rgpPeriodi.ItemIndex,DallaData, AllaData),'DOMANDA') = mrNo then
      Exit;
    // Preparazione
    PreparazioneStoricizzazione:=PreparaStoricizzazione(VarToStr(dCmbDatoAgg.KeyValue));
  end;

  // Ciclo su dipendenti per aggiornamento
  C700SelAnagrafe.First;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  ProgressBar.Position:=0;
  btnLog.Enabled:=False;

  ParametriStoricizzazione.bStorico:=chkStorico.Checked;
  ParametriStoricizzazione.DataDa:=DallaData;
  ParametriStoricizzazione.DataA:=AllaData;
  ParametriStoricizzazione.iPeriodo:=rgpPeriodi.ItemIndex;
  ParametriStoricizzazione.bStoriciSuccessivi:=chkStoriciSuccessivi.Checked;
  ParametriStoricizzazione.Dato:=VarToStr(dCmbDatoAgg.KeyValue);
  ParametriStoricizzazione.DescDato:=dCmbDatoAgg.Text;
  ParametriStoricizzazione.PreparazioneStoricizzazione:=PreparazioneStoricizzazione;

  //
  bRecordAggiornati:=False;
  while not C700SelAnagrafe.Eof do
  begin
    frmSelAnagrafe.VisualizzaDipendente;
    ProgressBar.StepBy(1);
    if B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.ElaborazioneStoricizzaDipendente(ParametriStoricizzazione,LMessaggi) then
      bRecordAggiornati:=True;
    C700SelAnagrafe.Next;
  end;
  if bRecordAggiornati then
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.InserisciI020(PreparazioneStoricizzazione.NomeTabella,VarToStr(dCmbDatoAgg.KeyValue));
  ProgressBar.Position:=0;
  if chkStoriciSuccessivi.Checked then
    btnLog.Enabled:=True;
end;

procedure TB007FManipolazioneDati.BtnADataClick(Sender: TObject);
begin
  if PageControl1.ActivePage = tabAllegatiIter then
    AllaData:=DataOutLim(Min(AllaData,DataMaxIter),'Alla data:','G',0, DataMaxIter)
  else
    AllaData:=DataOut(AllaData,'Alla data:','G'); //,0,StrToDate('01/01/2000'));
  LblAData.Caption:=FormatDateTime('dd mmm yyyy',AllaData);
  if PageControl1.ActivePage = tabAllegatiIter then
    ImpostaFiltroAllegati;
end;

procedure TB007FManipolazioneDati.btnDatiAnagClick(Sender: TObject);
var s:String;
  ElencoValoriChecklist: TElencoValoriChecklist;
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  with C013FCheckList do
    try
      ElencoValoriChecklist:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.ListaDatiAnagraficiUnificazione;
      clbListaDati.Items.Assign(ElencoValoriChecklist.lstDescrizione);

      R180PutCheckList(edtDatiAnag.Text,40,clbListaDati);
      if ShowModal = mrOK then
        edtDatiAnag.Text:=R180GetCheckList(40,clbListaDati);
    finally
      FreeAndNil(ElencoValoriChecklist);
      Free;
    end;
end;

procedure TB007FManipolazioneDati.btnAggiornaMatrClick(Sender: TObject);
begin
  if C700SelAnagrafe.RecordCount < 1 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  if C700SelAnagrafe.RecordCount > 1 then
    raise exception.Create(A000MSG_B007_ERR_SOLO_UN_DIP);
  if Trim(edtDatiAnag.Text) = '' then
    raise exception.Create(A000MSG_B007_ERR_DATI_ANAG_UNIF);
  with B007FManipolazioneDatiDtM1 do
  begin
    Screen.Cursor:=crHourGlass;
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.CaricaElencoUnificazioneMatr(edtDatiAnag.Text);
    Screen.Cursor:=crDefault;
    btnAnomalie.Enabled:=False;
  end;
end;

procedure TB007FManipolazioneDati.btnAggiornaSchedeAnagClick(Sender: TObject);
begin
  if C700SelAnagrafe.RecordCount <= 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  if R180MessageBox('Attenzione: questa operazione potrebbe richiedere alcuni minuti. Continuare? ','DOMANDA') <> mrYes then
    Exit;
  StatusBar.Panels[1].Text:='Elaborazione in corso...premere Esc per interrompere';
  StatusBar.Repaint;
  InterrompiElaborazione:=False;
  B007FManipolazioneDati.KeyPreview:=True;
  btnLog.Enabled:=False;
  btnAnomalie.Enabled:=False;
  RegistraMsg.IniziaMessaggio('B007');
  with B007FManipolazioneDatiDtM1 do
  begin
    B007FManipolazioneDatiMW.ImpostaCdsDipendenti;
    Screen.Cursor:=crHourGlass;
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.Eof do
    begin
      Application.ProcessMessages;
      if InterrompiElaborazione then
      begin
        InterrompiElaborazione:=False;
        Screen.Cursor:=crDefault;
        ProgressBar.Position:=0;
        StatusBar.Panels[1].Text:='';
        StatusBar.Refresh;
        raise exception.Create('Operazione interrotta dall''operatore.');
      end;
      ProgressBar.StepBy(1);
      frmSelAnagrafe.VisualizzaDipendente;

      B007FManipolazioneDatiMW.CaricaCdsDipendentiSelCols(chkLogSchedeAnag.Checked);

      C700SelAnagrafe.Next;
    end;
    B007FManipolazioneDatiMW.CaricaCdsDipendentiSelSQL;
    StatusBar.Panels[1].Text:='';
    StatusBar.Repaint;
    Screen.Cursor:=crDefault;
    ProgressBar.Position:=0;
    B007FManipolazioneDati.KeyPreview:=False;
    if chkLogSchedeAnag.Checked then
      btnLog.Enabled:=True;
    if RegistraMsg.ContieneTipoA then
      btnAnomalie.Enabled:=True;
  end;
end;

procedure TB007FManipolazioneDati.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'B007','');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;
end;

procedure TB007FManipolazioneDati.UnificazioneProgressivi;
var
  lstProgressivi: TList<Integer>;
  prog: Integer;
  s,msg,SalvaFine: String;

begin
  if dGrdMatricole.SelectedRows.Count <= 0 then
    raise exception.Create(A000MSG_B007_ERR_NO_MATR_UNIF);

  if R180MessageBox(format(A000MSG_B007_DLG_FMT_UNIFICAZIONE,[IntToStr(dGrdMatricole.SelectedRows.Count),C700SelAnagrafe.FieldByName('MATRICOLA').AsString]),'DOMANDA') <> mrYes then
    Exit;

  lstProgressivi:=TList<Integer>.Create();
  with B007FManipolazioneDatiDtM1 do
  begin
    //Salvo progressivi selezionati
    B007FManipolazioneDatiMW.cdsDipendentiUnificazione.First;
    while not B007FManipolazioneDatiMW.cdsDipendentiUnificazione.Eof do
    begin
      if dGrdMatricole.SelectedRows.CurrentRowSelected then
        lstProgressivi.Add(B007FManipolazioneDatiMW.cdsDipendentiUnificazione.FieldByName('T430PROGRESSIVO').AsInteger);
      B007FManipolazioneDatiMW.cdsDipendentiUnificazione.Next;
    end;

    if (not C700SelAnagrafe.FieldByName('T430FINE').IsNull) and (C700SelAnagrafe.FieldByName('T430FINE').AsDateTime < Parametri.DataLavoro) then
    begin  //se matr.new non è in servzio controllo le old
      for prog in lstProgressivi do
      begin
        msg:=B007FManipolazioneDatiMW.VerificaDateUnificazione(prog);
        if msg <> '' then
        begin
          if R180MessageBox(msg,'DOMANDA') <> mrYes then
            Exit;
          //Break; //caratto 16/09/2014 si interrompeva alla prima matricola
        end;
      end;
    end;
  end;

  Screen.Cursor:=crHourGlass;
  btnLog.Enabled:=False;
  btnAnomalie.Enabled:=False;
  ProgressBar.Position:=0;
  ProgressBar.Max:=dGrdMatricole.SelectedRows.Count;

  with B007FManipolazioneDatiDtM1 do
  begin
    SalvaFine:=B007FManipolazioneDatiMW.InizioUnificazioneMatricole;

    for prog in lstProgressivi do
    begin
      B007FManipolazioneDatiMW.UnificazioneMatricolaDip(prog);
      ProgressBar.StepBy(1);
    end;
    B007FManipolazioneDatiMW.FineUnificazioneMatricole(SalvaFine);
  end;
  FreeAndNil(lstProgressivi);
  btnAggiornaMatrClick(nil);
  ProgressBar.Position:=0;
  Screen.Cursor:=crDefault;
  if RegistraMsg.ContieneTipoA then
  begin
    LMessaggi.Add('Operazione conclusa con anomalie');
    btnAnomalie.Enabled:=True;
  end;
end;

procedure TB007FManipolazioneDati.RiallineamentoGiustificativi;
var

  CausList: TStringList;
  Msg: String;
begin
  // inizializzazioni
  StatusBarSetInfo('');
  btnAnomalie.Enabled:=False;
  btnLog.Enabled:=False;

  // controllo dati input
  if (edtCausali.Text = '') then
  begin
    edtCausali.SetFocus;
    LMessaggi.Add(A000MSG_B007_ERR_NO_CAUSALE_ASS);
    Exit;
  end;

  // richiede conferma per questa operazione
  Msg:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.MessaggioConfermaRiallineamentoGiust(DallaData,C700SelAnagrafe.RecordCount);
  if R180MessageBox(Msg,DOMANDA) = mrNo then
  begin
    LMessaggi.Add(A000MSG_MSG_OPERAZIONE_ANNULLATA);
    Exit;
  end;

  // avvio elaborazione
  Screen.Cursor:=crHourGlass;
  RegistraMsg.IniziaMessaggio('B007');
  CausList:=TStringList.Create;

  B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.InizioElaborazioneRiallineamentoGiust;

  try
    CausList.CommaText:=edtCausali.Text;
    // ciclo sui dipendenti selezionati
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    while not C700SelAnagrafe.Eof do
    begin
      try
        // aggiorna barra di progresso
        ProgressBar.StepBy(1);
        ProgressBar.Repaint;

        if not B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.ElaborazioneRiallinementoGiustDipendente(CausList,DallaData) then
        begin
          if LMessaggi.count = 0 then
            LMessaggi.Add(A000MSG_MSG_ELABORAZIONE_ANOMALIE);
        end;

        // passa al dipendente successivo
        C700SelAnagrafe.Next;
      except
        // gestione generica errori
        on E:Exception do
        begin
          RegistraMsg.InserisciMessaggio('A',E.Message,'',C700Progressivo);
          LMessaggi.Add('Operazione interrotta per anomalie!');
        end;
      end;
    end;
  finally
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.FineElaborazioneRiallineamentoGiust;
    FreeAndNil(CausList);

    // ripristina videata
    ProgressBar.Position:=0;
    ProgressBar.Repaint;
    StatusBarSetInfo('');
    // abilita pulsanti di log / anomalie
    btnLog.Enabled:=True;
    btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB007FManipolazioneDati.TBBDaDataClick(Sender: TObject);
begin
  if PageControl1.ActivePage = tabAllegatiIter then
    DallaData:=DataOutLim(Min(DallaData,DataMaxIter),'Dalla data:','G',0, DataMaxIter)
  else
    DallaData:=DataOut(DallaData,'Dalla data:','G');
  LblDaData.Caption:=FormatDateTime('dd mmm yyyy',DallaData);
  if (PageControl1.ActivePage = tabStoricizzazione) and (rgpPeriodi.ItemIndex = 1) then
  begin
    AllaData:=DallaData;
    LblAData.Caption:=FormatDateTime('dd mmm yyyy',AllaData);
  end;
  if PageControl1.ActivePage = tabAllegatiIter then
    ImpostaFiltroAllegati;
end;

procedure TB007FManipolazioneDati.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  // distrugge oggetti in combobox
  for i:=0 to cmbIndirizzoDomicilio.Items.Count - 1 do
  begin
    (cmbIndirizzoDomicilio.Items.Objects[i] as TString).Free;
    cmbIndirizzoDomicilio.Items.Objects[i]:=nil;
  end;
  for i:=0 to cmbCapDomicilio.Items.Count - 1 do
  begin
    (cmbCapDomicilio.Items.Objects[i] as TString).Free;
    cmbCapDomicilio.Items.Objects[i]:=nil;
  end;
  for i:=0 to cmbComuneDomicilio.Items.Count - 1 do
  begin
    (cmbComuneDomicilio.Items.Objects[i] as TString).Free;
    cmbComuneDomicilio.Items.Objects[i]:=nil;
  end;
  if Assigned(A023FAllTimbMW) then
    FreeAndNil(A023FAllTimbMW);
  FreeAndNil(ElencoTab);
  FreeAndNil(LMessaggi);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TB007FManipolazioneDati.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    if R180MessageBox('Si desidera interrompere l''operazione?','DOMANDA') = mrYes then
      InterrompiElaborazione:=True;
  end;
end;

procedure TB007FManipolazioneDati.Selezionatutto1Click(Sender: TObject);
var i:integer;
begin
  if PopupMenu1.PopupComponent = dGrdMatricole then
    R180DBGridSelezionaRighe(dGrdMatricole,'S')
  else if PopupMenu1.PopupComponent = dGrdSchedeAnag then
    R180DBGridSelezionaRighe(dGrdSchedeAnag,'S')
  else
    for i:=0 to TCheckListBox(PopupMenu1.PopupComponent).Items.Count - 1 do
      TCheckListBox(PopupMenu1.PopupComponent).Checked[i]:=True;
end;

procedure TB007FManipolazioneDati.Annullatutto1Click(Sender: TObject);
var i:integer;
begin
  if PopupMenu1.PopupComponent = dGrdMatricole then
    R180DBGridSelezionaRighe(dGrdMatricole,'N')
  else if PopupMenu1.PopupComponent = dGrdSchedeAnag then
    R180DBGridSelezionaRighe(dGrdSchedeAnag,'N')
  else
    for i:=0 to TCheckListBox(PopupMenu1.PopupComponent).Items.Count - 1 do
      TCheckListBox(PopupMenu1.PopupComponent).Checked[i]:=False;
end;

procedure TB007FManipolazioneDati.Invertiselezione1Click(Sender: TObject);
var i:integer;
begin
  if PopupMenu1.PopupComponent = dGrdMatricole then
  begin
    if dGrdMatricole.SelectedRows.Count > 0 then
      R180DBGridSelezionaRighe(dGrdMatricole,'C')
    else
      Exit;
  end
  else if PopupMenu1.PopupComponent = dGrdSchedeAnag then
  begin
    if dGrdSchedeAnag.SelectedRows.Count > 0 then
      R180DBGridSelezionaRighe(dGrdSchedeAnag,'C')
    else
      Exit;
  end
  else
    for i:=0 to TCheckListBox(PopupMenu1.PopupComponent).Items.Count - 1 do
      TCheckListBox(PopupMenu1.PopupComponent).Checked[i]:=not TCheckListBox(PopupMenu1.PopupComponent).Checked[i];
end;

procedure TB007FManipolazioneDati.CancBudget;
var messaggio:string;
begin
  with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
  begin
    StatusBar.Panels[1].Text:='Cancellazione della tabella BUDGET STRAORDINARIO ANNUO';
    StatusBar.Repaint;
    if tempoCancellazione.AnnoOk then
    begin
      // richiesta conferma cancellazione
      if RisMsg<>mrAll then
      begin
        messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
              'BUDGET STRAORDINARIO ANNUO'+#13#10+
              'dall''anno ' + IntToStr(tempoCancellazione.DaAnno) + ' all''anno ' + IntToStr(tempoCancellazione.AAnno) + #13#10 +
              'Vuoi continuare?';
        RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        if (RisMsg=mrNo) or (RisMsg=mrCancel) then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
      end;
      CancellaBudget(tempoCancellazione.DaMese, tempoCancellazione.AMese, tempoCancellazione.DaAnno, tempoCancellazione.AAnno);
    end;
  end;
  ProgressBar.StepBy(1);
end;

procedure TB007FManipolazioneDati.CancRiepil;
var comodo,messaggio:string;
begin
  if not tempoCancellazione.MeseOk then
    Exit;
  messaggio:='Attenzione!!! Verranno cancellati i dati della tabella SCHEDA RIEPILOGATIVA '
            +'da mese/anno: '+IntToStr(tempoCancellazione.DaMese)+'/'+IntToStr(tempoCancellazione.DaAnMe)
            +' a mese/anno: '+IntToStr(tempoCancellazione.AMese)+'/'+IntToStr(tempoCancellazione.AAnMe);
  StatusBar.Panels[1].Text:='Cancellazione della tabella SCHEDA RIEPILOGATIVA';
  StatusBar.Repaint;
  with B007FManipolazioneDatiDtM1 do
  begin
    if rgpCancDati.ItemIndex = 2 then
    begin
      // richiesta conferma cancellazione
      if RisMsg<>mrAll then
      begin
        RisMsg:=MessageDlg(messaggio+'#13#10Vuoi continuare?',mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        if (RisMsg=mrNo) or (RisMsg=mrCancel) then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
      end;
      B007FManipolazioneDatiMW.CancellaSchedaRiepil(tempoCancellazione.DaDataMese, tempoCancellazione.ADataMese);
    end
    else
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        if RisMsg<>mrAll then
        begin
          comodo:=messaggio+' relativi al dipendente: '+C700SelAnagrafe.FieldByName('Cognome').AsString+' '+
                C700SelAnagrafe.FieldByName('Nome').AsString+' Badge; '+C700SelAnagrafe.FieldByName('T430Badge').AsString+
                #13#10+'Vuoi continuare?';
          RisMsg:=MessageDlg(comodo,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        end;
        if RisMsg=mrCancel then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
        if (RisMsg=mrAll) or (RisMsg=mrYes) then
        begin
          B007FManipolazioneDatiMW.CancellaSchedaRiepilDipendente(tempoCancellazione.DaDataMese, tempoCancellazione.ADataMese);
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  end;
  ProgressBar.StepBy(1);
end;

procedure TB007FManipolazioneDati.CancMesi(indice:integer);
var messaggio:string;
begin
  StatusBar.Panels[1].Text:='Cancellazione della tabella ' + TabelleCancella[indice].Desc;
  StatusBar.Repaint;
  with B007FManipolazioneDatiDtM1 do
  begin
    if rgpCancDati.ItemIndex=2 then
    begin
      if RisMsg<>mrAll then
      begin
        messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
              TabelleCancella[indice].Desc + #13#10 +
              'da mese/anno: ' + IntToStr(tempoCancellazione.DaMese) + '/' + IntToStr(tempoCancellazione.DaAnMe)+
              ' a mese/anno: ' + IntToStr(tempoCancellazione.AMese) + '/' + IntToStr(tempoCancellazione.AAnMe) + #13#10 +
              'Vuoi continuare?';
        RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        if (RisMsg=mrNo) or (RisMsg=mrCancel) then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
      end;
      B007FManipolazioneDatiMW.CancellaMesi(indice,tempoCancellazione);
    end
    else
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        if RisMsg<>mrAll then
        begin
          messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
              TabelleCancella[indice].Desc+#13#10+
              'da mese/anno: '+IntToStr(tempoCancellazione.DaMese)+'/'+IntToStr(tempoCancellazione.DaAnMe)+
              ' a mese/anno: '+IntToStr(tempoCancellazione.AMese)+'/'+IntToStr(tempoCancellazione.AAnMe)+#13#10+
              ' relativi al dipendente: '+C700SelAnagrafe.FieldByName('Cognome').AsString+' '+
              C700SelAnagrafe.FieldByName('Nome').AsString+' Badge; '+C700SelAnagrafe.FieldByName('T430Badge').AsString+
              #13#10+'Vuoi continuare?';
          RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        end;
        if RisMsg=mrCancel then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
        if (RisMsg=mrAll) or (RisMsg=mrYes) then
        begin
          B007FManipolazioneDatiMW.CancellaMesiDipendente(indice,tempoCancellazione);
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  end;
  ProgressBar.StepBy(1);
end;

procedure TB007FManipolazioneDati.CancAnni(indice:integer);
var messaggio:string;
begin
  StatusBar.Panels[1].Text:='Cancellazione della tabella '+TabelleCancella[indice].Desc;
  StatusBar.Repaint;
  with B007FManipolazioneDatiDtM1 do
  begin
    if rgpCancDati.ItemIndex=2 then
    begin
      if RisMsg<>mrAll then
      begin
        messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
              TabelleCancella[indice].Desc+#13#10+
              'da anno: '+IntToStr(tempoCancellazione.DaAnno)+' ad anno: '+IntToStr(tempoCancellazione.AAnno)+#13#10+
              'Vuoi continuare?';
        RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        if (RisMsg=mrNo) or (RisMsg=mrCancel) then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
      end;
      B007FManipolazioneDatiMW.CancellaAnni(Indice, tempoCancellazione);
    end
    else
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        if RisMsg<>mrAll then
        begin
          messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
              TabelleCancella[indice].Desc+#13#10+
              'da anno: '+IntToStr(tempoCancellazione.DaAnno)+' ad anno: '+IntToStr(tempoCancellazione.AAnno)+#13#10+
              ' relativi al dipendente: '+C700SelAnagrafe.FieldByName('Cognome').AsString+' '+
              C700SelAnagrafe.FieldByName('Nome').AsString+' Badge; '+C700SelAnagrafe.FieldByName('T430Badge').AsString+
              #13#10+'Vuoi continuare?';
          RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        end;
        if RisMsg=mrCancel then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
        if (RisMsg=mrAll) or (RisMsg=mrYes) then
        begin
          B007FManipolazioneDatiMW.CancellaAnniDipendente(Indice, tempoCancellazione);
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  end;
  ProgressBar.StepBy(1);
end;

procedure TB007FManipolazioneDati.CancDate(indice:integer);
var mess,messaggio,comodo:string;
begin
  StatusBar.Panels[1].Text:='Cancellazione della tabella ' + TabelleCancella[indice].Desc;
  StatusBar.Repaint;
  with B007FManipolazioneDatiDtM1 do
  begin
    mess:='Cancellazione dati periodo: ';
    messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
        TabelleCancella[indice].Desc+#13#10+'del periodo: ';
    if TabelleCancella[indice].Peri='E' then
      comodo:=FormatDateTime('dd/mm/yyyy',tempoCancellazione.DaDataMese)+' - '+FormatDateTime('dd/mm/yyyy',tempoCancellazione.ADataMese)
    else
      comodo:=FormatDateTime('dd/mm/yyyy',DallaData)+' - '+FormatDateTime('dd/mm/yyyy',AllaData);
    mess:=mess+comodo;
    messaggio:=messaggio+comodo+#13#10;

    if rgpCancDati.ItemIndex=2 then
    begin
      if RisMsg<>mrAll then
      begin
        messaggio:=messaggio+'Vuoi continuare?';
        RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        if (RisMsg=mrNo) or (RisMsg=mrCancel) then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
      end;
      B007FManipolazioneDatiMW.CancellaDate(indice, DallaData, AllaData, tempoCancellazione);
    end
    else
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        if RisMsg<>mrAll then
        begin
          comodo:=messaggio+' relativi al dipendente: '+C700SelAnagrafe.FieldByName('Cognome').AsString+' '+
                C700SelAnagrafe.FieldByName('Nome').AsString+' Badge; '+C700SelAnagrafe.FieldByName('T430Badge').AsString+
                #13#10+'Vuoi continuare?';
          RisMsg:=MessageDlg(comodo,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        end;
        if RisMsg=mrCancel then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;

        if (RisMsg=mrAll) or (RisMsg=mrYes) then
        begin
          B007FManipolazioneDatiMW.CancellaDateDipendente(indice, DallaData, AllaData, tempoCancellazione);
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  end;
  ProgressBar.StepBy(1);
end;

procedure TB007FManipolazioneDati.CancDaA(indice:integer);
var messaggio:string;
begin
  StatusBar.Panels[1].Text:='Cancellazione della tabella '+TabelleCancella[indice].Desc;
  StatusBar.Repaint;
  with B007FManipolazioneDatiDtM1 do
  begin
    if rgpCancDati.ItemIndex = 2 then
    begin
      if RisMsg <> mrAll then
      begin
        messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
          TabelleCancella[indice].Desc+#13#10+'del periodo: '+
          FormatDateTime('dd/mm/yyyy',DallaData) + ' - ' + FormatDateTime('dd/mm/yyyy',AllaData) + #13#10 +
          'Vuoi continuare?';
        RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        if (RisMsg = mrNo) or (RisMsg = mrCancel) then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
      end;
      B007FManipolazioneDatiMW.CancellaDaA(indice, DallaData, AllaData);
    end
    else
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        if RisMsg<>mrAll then
        begin
          messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
            TabelleCancella[indice].Desc+#13#10+'del periodo: '+
            FormatDateTime('dd/mm/yyyy',DallaData)+' - '+FormatDateTime('dd/mm/yyyy',AllaData)+#13#10+
            'relativi al dipendente: '+C700SelAnagrafe.FieldByName('Cognome').AsString+' '+
            C700SelAnagrafe.FieldByName('Nome').AsString+' Badge; '+C700SelAnagrafe.FieldByName('T430Badge').AsString+
            #13#10+'Vuoi continuare?';
          RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        end;
        if RisMsg=mrCancel then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;

        if (RisMsg=mrAll) or (RisMsg=mrYes) then
        begin
          B007FManipolazioneDatiMW.CancellaDaADipendente(indice, DallaData, AllaData);
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  end;
  ProgressBar.StepBy(1);
end;

procedure TB007FManipolazioneDati.CancGius;
var
  messaggio: String;
  i: Integer;
begin
  StatusBar.Panels[1].Text:='Cancellazione della tabella GIUSTIFICATIVI';
  StatusBar.Repaint;
  if ((PageControl1.ActivePage = tabCancellazioneDati) and (rgpCancDati.ItemIndex = 2)) or
     ((PageControl1.ActivePage = tabCancellazioneGiustif) and (rgpCancGiust.ItemIndex = 0)) then
  begin
    // richiesta conferma cancellazione
    if RisMsg <> mrAll then
    begin
      messaggio:='Attenzione!!! Verranno cancellati i dati della tabella '+
         'GIUSTIFICATIVI dalla data: '+FormatDateTime('dd/mm/yyyy',DallaData)+
         ' alla data '+FormatDateTime('dd/mm/yyyy',AllaData)+#13#10+
         'Vuoi continuare?';
      RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
      if (RisMsg = mrNo) or (RisMsg = mrCancel) then
      begin
        ProgressBar.StepBy(1);
        ProgressBar.Repaint;
        Exit;
      end;
    end;
    // Cancellazione tabella T040_Giustificativi
    with B007FManipolazioneDatiDtM1 do
    begin
      if PageControl1.ActivePage = tabCancellazioneDati then
      begin
        B007FManipolazioneDatiMW.CancellaDatiGiustif(DallaData,AllaData);
      end
      else
      begin
        for i:=0 to chklstCausGiust.Items.Count - 1 do
        begin
          if chklstCausGiust.Checked[i] then
          begin
            B007FManipolazioneDatiMW.CancellaCodiceGiustifProg(Trim(Copy(chklstCausGiust.Items.Strings[i],1,5)), DallaData, AllaData, 0);
          end;
        end;
      end;
    end;
  end
  else
  begin
    with B007FManipolazioneDatiDtM1 do
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        if RisMsg <> mrAll then
        begin
          messaggio:='Attenzione!!! Verranno cancellati i dati della tabella GIUSTIFICATIVI'+
          ' del periodo: '+FormatDateTime('dd/mm/yyyy',DallaData)+' - '+FormatDateTime('dd/mm/yyyy',AllaData)+#13#10+
          'relativi al dipendente: '+C700SelAnagrafe.FieldByName('Cognome').AsString+' '+
          C700SelAnagrafe.FieldByName('Nome').AsString+' Badge; '+C700SelAnagrafe.FieldByName('T430Badge').AsString+
          #13#10+'Vuoi continuare?';
          RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        end;
        if RisMsg = mrCancel then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
        if (RisMsg = mrAll) or (RisMsg = mrYes) then
        begin
          if PageControl1.ActivePage = tabCancellazioneDati then
          begin
            B007FManipolazioneDatiMW.CancellaDatiGiustifDipendente(DallaData,AllaData);
          end
          else
          begin
            ProgressBar.StepBy(1);
            for i:=0 to chklstCausGiust.Items.Count - 1 do
            begin
              if chklstCausGiust.Checked[i] then
              begin
                B007FManipolazioneDatiMW.CancellaCodiceGiustifProg(Trim(Copy(chklstCausGiust.Items.Strings[i],1,5)), DallaData, AllaData, C700Progressivo);
              end;
            end;
          end;
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  end;
end;

procedure TB007FManipolazioneDati.CancGiusCaus;
var i:integer;
begin
  for i:=0 to chklstCausGiust.Items.Count - 1 do
    if chklstCausGiust.Checked[i] then
    begin
    end;
end;

procedure TB007FManipolazioneDati.RenCausali;
var
  messaggio: string;
  Anom: Boolean;
begin
  Anom:=False;
  btnAnomalie.Enabled:=False;
  if rgpRicodificaGiust.ItemIndex = 0 then
  begin
    // richiesta conferma ricodifica
    if rgpTipoCaus.ItemIndex = 0 then
      messaggio:='Attenzione!!! Verranno ricodificati i Giustificativi ' + #13#10
    else
      messaggio:='Attenzione!!! Verranno ricodificati i Giustificativi, le Timbrature, le Schede Riepil., i Residui ' + #13#10;
    messaggio:=messaggio + ' dalla causale ' + edtOldCausale.Text + ' alla causale ' + dCmbCausali.Text + #13#10 +
      ' dalla data ' + FormatDateTime('dd/mm/yyyy',DallaData) + ' alla data ' + FormatDateTime('dd/mm/yyyy',AllaData) + #13#10 +
      ' L''operazione riguarda TUTTI i dipendenti dell''azienda ' + Parametri.Azienda + '.' + #13#10 +
      ' Vuoi continuare?';
    RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
    if (RisMsg=mrNo) or (RisMsg=mrCancel) then
      Exit;
    with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
      Anom:=not ElaborazioneRicodificaGiust(DallaData,
                                            AllaData,
                                            Trim(edtOldCausale.Text),
                                            dCmbCausali.Text,
                                            (rgpTipoCaus.ItemIndex = 1));
  end
  else
  begin
    with B007FManipolazioneDatiDtM1 do
    begin
      C700SelAnagrafe.First;
      while not C700SelAnagrafe.Eof do
      begin
        //conferma ricodifica
        if RisMsg<>mrAll then
        begin
          if rgpTipoCaus.ItemIndex = 0 then
            messaggio:='Attenzione!!! Verranno ricodificati i Giustificativi ' + #13#10
          else
            messaggio:='Attenzione!!! Verranno ricodificati i Giustificativi, le Timbrature, le Schede Riepil., i Residui ' + #13#10;
          messaggio:=messaggio + ' dalla causale ' + edtOldCausale.Text + ' alla causale ' + dCmbCausali.Text + #13#10 +
            ' dalla data ' + FormatDateTime('dd/mm/yyyy',DallaData) + ' alla data ' + FormatDateTime('dd/mm/yyyy',AllaData) + #13#10 +
            ' relativi al dipendente: ' + C700SelAnagrafe.FieldByName('Cognome').AsString + ' ' + C700SelAnagrafe.FieldByName('Nome').AsString +
            ' Matricola: ' + C700SelAnagrafe.FieldByName('Matricola').AsString + ' Badge: ' + C700SelAnagrafe.FieldByName('T430Badge').AsString + #13#10 +
            ' Vuoi continuare?';
          RisMsg:=MessageDlg(messaggio,mtConfirmation,[mbYes, mbNo, mbAll, mbCancel],0);
        end;
        if RisMsg=mrCancel then
        begin
          ProgressBar.StepBy(1);
          Exit;
        end;
        if (RisMsg=mrAll) or (RisMsg=mrYes) then
        begin
          with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
            if (not ElaborazioneRicodificaGiustDipendente(DallaData,
                                                          AllaData,
                                                          Trim(edtOldCausale.Text),
                                                          dCmbCausali.Text,
                                                          (rgpTipoCaus.ItemIndex = 1))) then
              Anom:=True;
        end;
        C700SelAnagrafe.Next;
      end;
    end;
  end;
  if Anom then
  begin
    btnAnomalie.Enabled:=True;
    LMessaggi.Add('Operazione conclusa con anomalie');
  end;
end;

procedure TB007FManipolazioneDati.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataDal:=DallaData;
  C700DataLavoro:=AllaData;
  frmSelAnagrafe.SelezionePeriodica:=not ((PageControl1.ActivePage = tabStoricizzazione) and (rgpPeriodi.ItemIndex = 1));
  frmSelAnagrafe.btnSelezioneClick(Sender);
  if chkFiltroAnagrafe.Checked then
    ImpostaFiltroAllegati;
end;

procedure TB007FManipolazioneDati.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  C005DataVisualizzazione:=AllaData;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

function TB007FManipolazioneDati.GetCampo(const PNome, PNomeLogico, PDataType: String;
  const PDataLength: Integer): TCampo;
begin
  Result.Nome:=PNome;
  Result.NomeLogico:=PNomeLogico;
  Result.DataType:=PDataType;
  Result.DataLength:=PDataLength;
  if PDataType.ToUpper = 'VARCHAR2' then
    Result.Info:=Format('alfanumerico: %d caratteri',[PDataLength])
  else if PDataType.ToUpper = 'NUMBER' then
    Result.Info:='numerico'
  else if PDataType.ToUpper = 'DATE' then
    Result.Info:='data';
end;

function TB007FManipolazioneDati.GetCampo(const PNome: String): TCampo;
// versione semplificata per estrarre i dati del campo indicato
begin
  with B007FManipolazioneDatiDtM1.selI010MigrDom do
  begin
    if Active then
    begin
      // effettua lookup per estrarre le informazioni del campo indicato
      Result:=GetCampo(PNome,
                       VarToStr(Lookup('NOME_CAMPO',PNome,'NOME_LOGICO')),
                       VarToStr(Lookup('NOME_CAMPO',PNome,'DATA_TYPE')),
                       StrToIntDef(VarToStr(Lookup('NOME_CAMPO',PNome,'DATA_LENGTH')),0));
    end
    else
    begin
      // dataset di supporto non disponibile: restituisce valori vuoti
      Result:=GetCampo(PNome,'','',0);
    end;
  end;
end;

procedure TB007FManipolazioneDati.dCmbDatoAggCloseUp(Sender: TObject);
var
  ElencoValori: TElencoValoriAggDati;
  S: String;
begin
  B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.DatoDaAggiornare:=VarToStr(dCmbDatoAgg.KeyValue);
  // Pulizia cdsValori
  B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.InizializzaCdsValori;

  ElencoValori:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.ValoriAggDati(VarToStr(dCmbDatoAgg.KeyValue));

  // Aggiornamento griglia
  dGrdValori.Columns[0].PickList.Clear;
  dGrdValori.Columns[1].PickList.Clear;
  for s in ElencoValori.lstValoreEsistente do
    dGrdValori.Columns[0].PickList.Add(S);

  for s in ElencoValori.lstNuovoValore do
    dGrdValori.Columns[1].PickList.Add(S);

  FreeAndNil(ElencoValori);
end;

procedure TB007FManipolazioneDati.dCmbDatoAggKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  dCmbDatoAggCloseUp(nil);
end;

procedure TB007FManipolazioneDati.PageControl1Change(Sender: TObject);
begin
  BitVideo.Visible:=PageControl1.ActivePage <> tabCestino;
  frmSelAnagrafe.pnlSelAnagrafe.Enabled:=PageControl1.ActivePage <> tabCestino;
  TBBDaData.Enabled:=(PageControl1.ActivePage <> tabUnioneProgressivi) and
                     (PageControl1.ActivePage <> tabMigrazioneDomicilio) and
                     (PageControl1.ActivePage <> tabCestino);
  TBBAData.Enabled:=(PageControl1.ActivePage <> tabUnioneProgressivi) and
                    (PageControl1.ActivePage <> tabRiallineaGiust) and
                    (PageControl1.ActivePage <> tabMigrazioneDomicilio) and
                    (PageControl1.ActivePage <> tabCestino);
  LblDaData.Enabled:=TBBDaData.Enabled;
  LblAData.Enabled:=TBBAData.Enabled;
  btnLog.Visible:=(PageControl1.ActivePage = tabCancellazioneDati) or
                  (PageControl1.ActivePage = tabUnioneProgressivi) or
                  (PageControl1.ActivePage = tabStoricizzazione) or
                  (PageControl1.ActivePage = tabRiallineaGiust);
  btnAnomalie.Visible:=(PageControl1.ActivePage = tabCancellazioneDati) or
                       (PageControl1.ActivePage = tabUnioneProgressivi) or
                       (PageControl1.ActivePage = tabRiallineaGiust) or
                       (PageControl1.ActivePage = tabRicodificaGiustif);
  if PageControl1.ActivePage <> tabUnioneProgressivi then
  begin
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.selI010.Filter:='TABLE_NAME = ''V430_STORICO''';
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.selI010.Filtered:=True;
  end
  else
  begin
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.selI010.Filter:='';
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.selI010.Filtered:=False;
  end;
  frmSelAnagrafe.Enabled:=True;

  if PageControl1.ActivePage = tabCancellazioneDati then
    rgpCancDatiClick(nil)
  else if PageControl1.ActivePage = tabCancellazioneGiustif then
    rgpCancGiustClick(nil)
  else if PageControl1.ActivePage = tabRicodificaGiustif then
    rgpRicodificaGiustClick(nil)
  else if PageControl1.ActivePage = tabStoricizzazione then
    rgpPeriodiClick(nil)
  else if PageControl1.ActivePage = tabAllineamento then
    RadioGroup5Click(nil)
  else if PageControl1.ActivePage = tabEsecuzioneScript then
  begin
    TBBAData.Enabled:=False;
    TBBDaData.Enabled:=False;
    LblAData.Enabled:=False;
    LblDaData.Enabled:=False;
  end
  else if PageControl1.ActivePage = tabMigrazioneDomicilio then
  begin
    cmbIndirizzoDomicilio.OnChange(cmbIndirizzoDomicilio);
    cmbCapDomicilio.OnChange(cmbCapDomicilio);
    cmbComuneDomicilio.OnChange(cmbComuneDomicilio);
  end
  else if PageControl1.ActivePage = tabCestino then
  begin
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.MyCestino.ListaTabelle(cmbFiltrotabelle.Items);
  end
  else if PageControl1.ActivePage = tabAllineaTimb then
  begin
    if Assigned(A023FAllTimbMW) then
      FreeAndNil(A023FAllTimbMW);

    A023FAllTimbMW:=TA023FAllTimbMW.Create(nil);
    A023FAllTimbMW.Q100.Session:=SessioneOracle;
    A023FAllTimbMW.Q100Upd.Session:=SessioneOracle;
    dgrdTimbUguali.DataSource:=A023FAllTimbMW.dsrT100;
  end
  else if PageControl1.ActivePage = tabAllegatiIter then
  begin
    AllaData:=DataMaxIter;
    LblAData.Caption:=FormatDateTime('dd MMM yyyy',AllaData);
    DallaData:=EncodeDate(1900,1,1);
    LblDaData.Caption:=FormatDateTime('dd MMM yyyy',DallaData);
    ImpostaFiltroAllegati;
  end;
end;

procedure TB007FManipolazioneDati.ppMnuCestinoPopup(Sender: TObject);
begin
  if dGrdCestino.SelectedRows.Count <= 0 then
    Abort;
end;

procedure TB007FManipolazioneDati.rgpCancDatiClick(Sender: TObject);
var
  i:integer;
  lstTabelle: TStringList;
begin
  chkLstTabelle.Clear;
  if rgpCancDati.ItemIndex = 0 then
  begin
    TBBDaData.Enabled:=False;
    TBBAData.Enabled:=False;
    LblDaData.Enabled:=False;
    LblAData.Enabled:=False;
    gpbTabelle.Enabled:=False;
    chkLstTabelle.Visible:=True;
    pnlSchedeAnag.Visible:=False;
    dgrdSchedeAnag.Visible:=False;
    frmSelAnagrafe.Enabled:=True;
  end
  else if rgpCancDati.ItemIndex = 1 then
  begin
    TBBDaData.Enabled:=False;
    TBBAData.Enabled:=False;
    LblDaData.Enabled:=False;
    LblAData.Enabled:=False;
    gpbTabelle.Enabled:=True;
    gpbTabelle.Caption:='Elenco matricole';
    chkLstTabelle.Visible:=False;
    pnlSchedeAnag.Visible:=True;
    dgrdSchedeAnag.Visible:=True;
    frmSelAnagrafe.Enabled:=True;
  end
  else if (rgpCancDati.ItemIndex=2) or (rgpCancDati.ItemIndex=3) then
  begin
    TBBDaData.Enabled:=True;
    TBBAData.Enabled:=True;
    LblDaData.Enabled:=True;
    LblAData.Enabled:=True;
    gpbTabelle.Enabled:=True;
    gpbTabelle.Caption:='Elenco tabelle';
    chkLstTabelle.Visible:=True;
    pnlSchedeAnag.Visible:=False;
    dgrdSchedeAnag.Visible:=False;
    if rgpCancDati.ItemIndex = 2 then
    begin
      frmSelAnagrafe.Enabled:=False;
      lstTabelle:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.ElencoTabelleCancellaTotale;
      chkLstTabelle.Items.Assign(lstTabelle);
      FreeAndNil(lstTabelle);
    end
    else
    begin
      frmSelAnagrafe.Enabled:=True;
      lstTabelle:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.ElencoTabelleCancellaDipendente;
      chkLstTabelle.Items.Assign(lstTabelle);
      FreeAndNil(lstTabelle);
    end;
  end;
end;

procedure TB007FManipolazioneDati.rgpCancGiustClick(Sender: TObject);
begin
  frmSelAnagrafe.Enabled:=(rgpCancGiust.ItemIndex = 1);
end;

procedure TB007FManipolazioneDati.rgpRicodificaGiustClick(Sender: TObject);
begin
  frmSelAnagrafe.Enabled:=rgpRicodificaGiust.ItemIndex = 1;
end;

procedure TB007FManipolazioneDati.rgpPeriodiClick(Sender: TObject);
begin
  TBBDaData.Enabled:=(rgpPeriodi.ItemIndex = 0) or (rgpPeriodi.ItemIndex = 1);
  LblDaData.Enabled:=(rgpPeriodi.ItemIndex = 0) or (rgpPeriodi.ItemIndex = 1);
  TBBAData.Enabled:=rgpPeriodi.ItemIndex = 0;
  LblAData.Enabled:=rgpPeriodi.ItemIndex = 0;
  if (PageControl1.ActivePage = tabStoricizzazione) and (rgpPeriodi.ItemIndex = 1) then
  begin
    AllaData:=DallaData;
    LblAData.Caption:=FormatDateTime('dd mmm yyyy',AllaData);
  end;
end;

procedure TB007FManipolazioneDati.RadioGroup5Click(Sender: TObject);
begin
  TBBDaData.Enabled:=RadioGroup5.ItemIndex = 1;
  LblDaData.Enabled:=RadioGroup5.ItemIndex = 1;
  TBBAData.Enabled:=RadioGroup5.ItemIndex = 1;
  LblAData.Enabled:=RadioGroup5.ItemIndex = 1;
end;

procedure TB007FManipolazioneDati.rgpTipoCausClick(Sender: TObject);
begin
  if rgpTipoCaus.ItemIndex = 0 then
  begin
    dCmbCausali.ListSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrQ265;
    dbText1.DataSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrQ265;
  end
  else
  begin
    dCmbCausali.ListSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrQ275;
    dbText1.DataSource:=B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.dsrQ275;
  end;
end;

procedure TB007FManipolazioneDati.rgTestClick(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to PageControl1.PageCount-1 do
    PageControl1.Pages[i].TabVisible:=(RgTest.ItemIndex = 0) or (PageControl1.Pages[i] = tabAllegatiIter);
  tabAllegatiIter.TabVisible:=StrToInt(Parametri.CampiRiferimento.C90_CancellaAnnoAllegatiIter) <> 99;
  PageControl1Change(Sender);
end;

procedure TB007FManipolazioneDati.dcmbKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW.DatoDaAggiornare:=VarToStr(dCmbDatoAgg.KeyValue);
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TB007FManipolazioneDati.dGrdValoriExit(Sender: TObject);
{ Forza il post quando la griglia è in modifica e perde il fuoco }
begin
  with dGrdValori.DataSource.DataSet do
    if State in [dsInsert,dsEdit] then
      Post;
end;

procedure TB007FManipolazioneDati.dsrI025DataChange(Sender: TObject;
  Field: TField);
begin

end;

// ### MIGRAZIONE DOMICILIO ###

procedure TB007FManipolazioneDati.chkIndirizzoDomicilioClick(Sender: TObject);
begin
  pnlIndirizzoDomicilio.Visible:=chkIndirizzoDomicilio.Checked;
  if chkIndirizzoDomicilio.Checked then
  begin
    SetDomValoreDefault(cmbIndirizzoDomicilio,IndirizzoDomicilioDefault);
  end
  else
  begin
    if cmbIndirizzoDomicilio.ItemIndex > -1 then
    begin
      cmbIndirizzoDomicilio.ItemIndex:=-1;
      cmbIndirizzoDomicilio.OnChange(cmbIndirizzoDomicilio);
    end;
    chkSovrascriviIndirizzo.Checked:=False;
  end;
end;

procedure TB007FManipolazioneDati.chkCapDomicilioClick(Sender: TObject);
begin
  pnlCapDomicilio.Visible:=chkCapDomicilio.Checked;
  if chkCapDomicilio.Checked then
  begin
    SetDomValoreDefault(cmbCapDomicilio,CapDomicilioDefault);
  end
  else
  begin
    if cmbCapDomicilio.ItemIndex > -1 then
    begin
      cmbCapDomicilio.ItemIndex:=-1;
      cmbCapDomicilio.OnChange(cmbCapDomicilio);
    end;
    chkSovrascriviCap.Checked:=False;
  end;
end;

procedure TB007FManipolazioneDati.chkComuneDomicilioClick(Sender: TObject);
begin
  pnlComuneDomicilio.Visible:=chkComuneDomicilio.Checked;
  if chkComuneDomicilio.Checked then
  begin
    SetDomValoreDefault(cmbComuneDomicilio,ComuneDomicilioDefault);
  end
  else
  begin
    if cmbComuneDomicilio.ItemIndex > -1 then
    begin
      cmbComuneDomicilio.ItemIndex:=-1;
      cmbComuneDomicilio.OnChange(cmbComuneDomicilio);
    end;
    chkSovrascriviComune.Checked:=False;
  end;
end;

procedure TB007FManipolazioneDati.chkFiltroAnagrafeClick(Sender: TObject);
begin
  ImpostaFiltroAllegati;
end;

procedure TB007FManipolazioneDati.cmbIndirizzoDomicilioKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    with (Sender as TComboBox) do
    begin
      ItemIndex:=-1;
      OnChange(Sender);
    end;

    if Sender = cmbIndirizzoDomicilio then
      chkIndirizzoDomicilio.Checked:=False
    else if Sender = cmbCapDomicilio then
      chkCapDomicilio.Checked:=False
    else if Sender = cmbComuneDomicilio then
      chkComuneDomicilio.Checked:=False;
  end;
end;

procedure TB007FManipolazioneDati.cmbIndirizzoDomicilioChange(Sender: TObject);
begin
  if cmbIndirizzoDomicilio.ItemIndex < 0 then
    lblDescIndirizzoDomicilio.Caption:=''
  else
    lblDescIndirizzoDomicilio.Caption:=(cmbIndirizzoDomicilio.Items.Objects[cmbIndirizzoDomicilio.ItemIndex] as TString).Str;
end;

procedure TB007FManipolazioneDati.cmbCapDomicilioChange(Sender: TObject);
begin
  if cmbCapDomicilio.ItemIndex < 0 then
    lblDescCapDomicilio.Caption:=''
  else
    lblDescCapDomicilio.Caption:=(cmbCapDomicilio.Items.Objects[cmbCapDomicilio.ItemIndex] as TString).Str;
end;

procedure TB007FManipolazioneDati.cmbComuneDomicilioChange(Sender: TObject);
begin
  if cmbComuneDomicilio.ItemIndex < 0 then
    lblDescComuneDomicilio.Caption:=''
  else
    lblDescComuneDomicilio.Caption:=(cmbComuneDomicilio.Items.Objects[cmbComuneDomicilio.ItemIndex] as TString).Str;
end;

procedure TB007FManipolazioneDati.cmbFiltrotabelleChange(Sender: TObject);
begin
  with B007FManipolazioneDatiDtM1.B007FManipolazioneDatiMW do
  begin
    MyCestino.Seek_selI025(MyCestino.DescToCod(cmbFiltrotabelle.Items[cmbFiltrotabelle.ItemIndex]));
    if MyCestino.Get_selI025.RecordCount > 0 then
      dGrdCestino.SelectedRows.CurrentRowSelected:=True;
      //rdCestino.DataSource.DataSet.GotoBookmark(Pointer(dGrdCestino.SelectedRows.Items[i]));
  end;
end;

procedure TB007FManipolazioneDati.SetDomValoreDefault(PComboBox: TComboBox; PVal: String);
var
  idx: Integer;
begin
  idx:=-1;
  if PVal <> '' then
  begin
    // cerca il nome campo nell'array
    idx:=R180IndexOf(PComboBox.Items,PVal,MAXWORD);
    if idx < 0 then
    begin
      // se non lo trova, controlla che sia un campo di decodifica
      // in questo caso ricerca il relativo campo codice
      if PVal.ToUpper.Substring(0,6) = 'T430D_' then
        idx:=R180IndexOf(PComboBox.Items,PVal.Replace('T430D_','T430'),MAXWORD);
    end;
  end;

  PComboBox.ItemIndex:=idx;
  PComboBox.OnChange(PComboBox);
end;

function TB007FManipolazioneDati.ControlloMigrazioneDomicilio(var RErrMsg: String): Boolean;
var
  CampoOrig: TCampo;
  Tabella, Codice, Storico: String;
begin
  Result:=False;
  RErrMsg:='';

  // controllo indicazione di almeno un dato di domicilio da migrare
  if (cmbIndirizzoDomicilio.ItemIndex < 0) and
     (cmbCapDomicilio.ItemIndex < 0) and
     (cmbComuneDomicilio.ItemIndex < 0) then
  begin
    RErrMsg:='E'' necessario selezionare almeno un dato da migrare';
    Exit;
  end;

  // controllo indirizzo
  if cmbIndirizzoDomicilio.ItemIndex >= 0 then
  begin
    // PRE: in cmbIndirizzoDomicilio.Text è indicato il NOME_LOGICO
    CampoOrig:=GetCampo(VarToStr(B007FManipolazioneDatiDtM1.selI010MigrDom.Lookup('NOME_LOGICO',cmbIndirizzoDomicilio.Text,'NOME_CAMPO')));

    // determina il campo indirizzo è tabellare o meno
    A000GetTabella(CampoOrig.Nome,Tabella,Codice,Storico,SessioneOracle);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
    begin
      RErrMsg:='Impossibile selezionare un dato tabellare per l''indirizzo!';
      cmbIndirizzoDomicilio.SetFocus;
      Exit;
    end;

    // PRE: CampoOrig.DataType = CampoIndirizzo.DataType
    if (CampoOrig.DataType.ToUpper = 'VARCHAR2') and
       (CampoOrig.DataLength > CampoIndirizzo.DataLength) then
    begin
      if R180MessageBox(Format('Attenzione!'#13#10 +
                               'Il dato selezionato per l''indirizzo ha una lunghezza'#13#10 +
                               'di %d caratteri, maggiore del dato di destinazione.'#13#10 +
                               'Se si continua, tutti i valori saranno troncati a %d caratteri.'#13#10 +
                               'Vuoi continuare?',[CampoOrig.DataLength,CampoIndirizzo.DataLength]),DOMANDA) = mrNo then
      begin
        RErrMsg:=A000MSG_MSG_OPERAZIONE_ANNULLATA;
        Exit;
      end;
    end;
  end;

  // controllo cap
  if cmbCapDomicilio.ItemIndex >= 0 then
  begin
    // PRE: in cmbCapDomicilio.Text è indicato il NOME_LOGICO
    CampoOrig:=GetCampo(VarToStr(B007FManipolazioneDatiDtM1.selI010MigrDom.Lookup('NOME_LOGICO',cmbCapDomicilio.Text,'NOME_CAMPO')));

    // determina il campo cap è tabellare o meno
    A000GetTabella(CampoOrig.Nome,Tabella,Codice,Storico,SessioneOracle);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') then
    begin
      RErrMsg:='Impossibile selezionare un dato tabellare per il CAP!';
      cmbCapDomicilio.SetFocus;
      Exit;
    end;

    // PRE: CampoOrig.DataType = CampoCap.DataType
    if (CampoOrig.DataType.ToUpper = 'VARCHAR2') and
       (CampoOrig.DataLength > CampoCap.DataLength) then
    begin
      if R180MessageBox(Format('Attenzione!'#13#10 +
                               'Il dato selezionato per il CAP ha una lunghezza'#13#10 +
                               'di %d caratteri, maggiore del dato di destinazione.'#13#10 +
                               'Se si continua, tutti i valori saranno troncati a %d caratteri.'#13#10 +
                               'Vuoi continuare?',[CampoOrig.DataLength,CampoCap.DataLength]),DOMANDA) = mrNo then
      begin
        RErrMsg:=A000MSG_MSG_OPERAZIONE_ANNULLATA;
        Exit;
      end;
    end;
  end;

  // controllo comune
  if cmbComuneDomicilio.ItemIndex >= 0 then
  begin
    CampoOrig:=GetCampo(VarToStr(B007FManipolazioneDatiDtM1.selI010MigrDom.Lookup('NOME_LOGICO',cmbComuneDomicilio.Text,'NOME_CAMPO')));
    A000GetTabella(CampoOrig.Nome,Tabella,Codice,Storico,SessioneOracle);
    if (Tabella <> '') and (Tabella <> 'T430_STORICO') and (Tabella <> 'T480_COMUNI') then
    begin
      if R180MessageBox(Format('Attenzione!'#13#10 +
                               'Il dato selezionato per il comune è di tipo tabellare.'#13#10 +
                               'In fase di migrazione la ricodifica sarà effettuata'#13#10 +
                               'sulla descrizione, e NON sul codice.'#13#10 +
                               'Vuoi continuare?',[CampoOrig.DataLength,CampoCap.DataLength]),DOMANDA) = mrNo then
      begin
        RErrMsg:=A000MSG_MSG_OPERAZIONE_ANNULLATA;
        Exit;
      end;
    end;
  end;

  // richiesta conferma operazione
  if R180MessageBox('Riepilogo delle operazioni di migrazione selezionate:'#13#10#13#10 +
                    IfThen(chkIndirizzoDomicilio.Checked,
                    'Indirizzo: ' + cmbIndirizzoDomicilio.Text +
                    IfThen(chkSovrascriviIndirizzo.Checked,' (*)') + #13#10) +

                    IfThen(chkCapDomicilio.Checked,
                    'Cap: ' + cmbCapDomicilio.Text +
                    IfThen(chkSovrascriviCap.Checked,' (*)') + #13#10) +

                    IfThen(chkComuneDomicilio.Checked,
                    'Comune: ' + cmbComuneDomicilio.Text +
                    IfThen(chkSovrascriviComune.Checked,' (*)') + #13#10) +

                    IfThen(chkSovrascriviIndirizzo.Checked or chkSovrascriviCap.Checked or chkSovrascriviComune.Checked,
                    #13#10'(*) ATTENZIONE!!!'#13#10 +
                    'I dati contrassegnati con l''asterisco verranno'#13#10 +
                    'sovrascritti anche se risultano già impostati.' + #13#10) +
                    #13#10'Confermi la migrazione dei dati di domicilio'#13#10 +
                    'sopra indicati per i dipendenti selezionati?',
                    DOMANDA) = mrNo then
  begin
    RErrMsg:=A000MSG_MSG_OPERAZIONE_ANNULLATA;
    Exit;
  end;

  // controlli ok
  Result:=True;
end;

function TB007FManipolazioneDati.GetUpdateCampo(const CampoSorgente, CampoDestinazione: TCampo;
  const PSovrascrivi: Boolean): String;
var
  Tabella, Codice, Storico, NomeSorgente: String;
  IsTabellare: Boolean;
begin
  if CampoDestinazione.Nome = CAMPO_COMUNE_DOMICILIO then
  begin
    // determina se il campo sorgente è tabellare o meno
    A000GetTabella(CampoSorgente.Nome,Tabella,Codice,Storico,SessioneOracle);
    IsTabellare:=(Tabella <> '') and (Tabella <> 'T430_STORICO') and (Tabella <> 'T480_COMUNI');
  end;
  if (CampoDestinazione.Nome = CAMPO_COMUNE_DOMICILIO) and (Tabella <> 'T480_COMUNI') then
  begin
    // caso particolare del comune, decodificato su T480
    if IsTabellare then
    begin
      // caso 1. dato comune tabellare
      // IMPORTANTE: l'utilizzo di max() è una precauzione per evitare che la subquery estragga più di 1 record
      NomeSorgente:=Format('(select max(T480.CODICE) ' +
                           ' from   %s I501, ' +
                           '        T480_COMUNI T480 ' +
                           ' where  I501.CODICE = %s ' +
                           ' and    upper(trim(I501.DESCRIZIONE)) = upper(trim(T480.CITTA))) ',
                           [Tabella,CampoSorgente.Nome]);
    end
    else
    begin
      // caso 2. dato comune semplice
      // IMPORTANTE: l'utilizzo di max() è una precauzione per evitare che la subquery estragga più di 1 record
      NomeSorgente:=Format('(select max(T480.CODICE) ' +
                           ' from   T480_COMUNI T480 ' +
                           ' where  upper(trim(T480.CITTA)) = upper(trim(%s))) ',
                           [CampoSorgente.Nome]);
    end;
  end
  else
  begin
    // caso 2. dato semplice
    // imposta nel dato di destinazione il dato sorgente
    NomeSorgente:=CampoSorgente.Nome;

    // per i dati non tabellari di tipo varchar gestisce il troncamento
    // se il dato di partenza è più lungo di quello di destinazione
    if (CampoSorgente.DataType.ToUpper = 'VARCHAR2') and
       (CampoSorgente.DataLength > CampoDestinazione.DataLength) then
    begin
      NomeSorgente:=Format('substr(%s,1,%d)',[NomeSorgente,CampoDestinazione.DataLength]);
    end;
  end;

  // gestione update del campo solo se è nullo
  if PSovrascrivi then
    Result:=Format('%s = %s',[CampoDestinazione.Nome,NomeSorgente])
  else
    Result:=Format('%s = nvl(%s,%s)',[CampoDestinazione.Nome,CampoDestinazione.Nome,NomeSorgente]);
end;

procedure TB007FManipolazioneDati.MigrazioneDomicilio;
// migrazione campi domicilio
var
  UpdSet,ComuneSorgente: String;
  CampoOrig: TCampo;
  vCodice,vArrCodici: variant;
begin
  Screen.Cursor:=crHourGlass;
  with B007FManipolazioneDatiDtM1.selI010MigrDom do
  begin
    // update indirizzo
    if cmbIndirizzoDomicilio.ItemIndex >= 0 then
    begin
      CampoOrig:=GetCampo(VarToStr(Lookup('NOME_LOGICO',cmbIndirizzoDomicilio.Text,'NOME_CAMPO')));
      UpdSet:=UpdSet + GetUpdateCampo(CampoOrig,CampoIndirizzo,chkSovrascriviIndirizzo.Checked) + ',';
    end;

    // update cap
    if cmbCapDomicilio.ItemIndex >= 0 then
    begin
      CampoOrig:=GetCampo(VarToStr(Lookup('NOME_LOGICO',cmbCapDomicilio.Text,'NOME_CAMPO')));
      UpdSet:=UpdSet + GetUpdateCampo(CampoOrig,CampoCap,chkSovrascriviCap.Checked) + ',';
    end;

    // update comune
    if cmbComuneDomicilio.ItemIndex >= 0 then
    begin
      CampoOrig:=GetCampo(VarToStr(Lookup('NOME_LOGICO',cmbComuneDomicilio.Text,'NOME_CAMPO')));
      ComuneSorgente:=CampoOrig.Nome;
      UpdSet:=UpdSet + GetUpdateCampo(CampoOrig,CampoComune,chkSovrascriviComune.Checked) + ',';
    end;
  end;

  // prepara update
  UpdSet:=UpdSet.Substring(0,UpdSet.Length - 1);
  with B007FManipolazioneDatiDtM1.updT430Domicilio do
  begin
    Close;
    SetVariable('SET_COMMAND',UpdSet);
  end;

  // ciclo di update sui progressivi selezionati
  ProgressBar.Position:=0;
  ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  C700SelAnagrafe.First;
  while not C700SelAnagrafe.Eof do
  begin
    Application.ProcessMessages;
    ProgressBar.StepBy(1);
    frmSelAnagrafe.VisualizzaDipendente;

    B007FManipolazioneDatiDtM1.updT430Domicilio.SetVariable('PROGRESSIVO',C700Progressivo);
    try
      B007FManipolazioneDatiDtM1.updT430Domicilio.Execute;
      SessioneOracle.Commit;
    except
      on E: Exception do
      begin
        if LMessaggi.Count = 0 then
        begin
          LMessaggi.Add('Elenco errori riscontrati durante la migrazione dei dati di domicilio');
          LMessaggi.Add('');
        end;

        LMessaggi.Add(Format('%-35s - matr. %-8s: (%s) %s',
                             [Copy(C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
                                   C700SelAnagrafe.FieldByName('NOME').AsString,1,35),
                              C700SelAnagrafe.FieldByName('MATRICOLA').AsString,
                              E.ClassName,E.Message]));
        SessioneOracle.RollBack;
      end;
    end;

    C700SelAnagrafe.Next;
  end;
  // riposizionamento su primo dipendente
  C700SelAnagrafe.First;
  frmSelAnagrafe.VisualizzaDipendente;
  Screen.Cursor:=crDefault;

  if chkComuneDomicilio.Checked then
  begin
    B007FManipolazioneDatiDtM1.selT430COMUNE_DOM.SetVariable('COMUNE_DOM',ComuneSorgente);
    B007FManipolazioneDatiDtM1.selT430COMUNE_DOM.Close;
    B007FManipolazioneDatiDtM1.selT430COMUNE_DOM.Open;
    OpenC015FElencoValori('', 'Comuni di Domicilio non associati','','',vCodice,vArrCodici,B007FManipolazioneDatiDtM1.selT430COMUNE_DOM,800,300,False);
    B007FManipolazioneDatiDtM1.selT430COMUNE_DOM.Close;
  end;
end;

// ### ALLINEAMENTO TIMBRATURE ###

procedure TB007FManipolazioneDati.btnRefreshAllTimbClick(Sender: TObject);
var
  DatiAnag: TDatiAnag;
begin
  // controlli su selezione anagrafe e periodo
  ControlloDipendenti;

  Screen.Cursor:=crHourGlass;

  // svuota clientdataset di riferimento
  A023FAllTimbMW.cdsT100.DisableControls;
  A023FAllTimbMW.cdsT100.Filter:='';
  A023FAllTimbMW.cdsT100.Filtered:=False;
  DatiAnag:=TA023FAllTimbMW.GetDatiAnag;
  A023FAllTimbMW.LeggiTimbratureUguali(DatiAnag,DATE_NULL,DATE_NULL,True);

  // ciclo di update sui progressivi selezionati
  if Sender <> nil then
  begin
    ProgressBar.Position:=0;
    ProgressBar.Max:=C700SelAnagrafe.RecordCount;
  end;
  C700SelAnagrafe.First;
  while not C700SelAnagrafe.Eof do
  begin
    Application.ProcessMessages;
    if Sender <> nil then
    begin
      ProgressBar.StepBy(1);
      frmSelAnagrafe.VisualizzaDipendente;
    end;
    try
      DatiAnag:=TA023FAllTimbMW.GetDatiAnag(C700Progressivo,C700SelAnagrafe.FieldByName('COGNOME').AsString,C700SelAnagrafe.FieldByName('NOME').AsString,C700SelAnagrafe.FieldByName('MATRICOLA').AsString);
      A023FAllTimbMW.LeggiTimbratureUguali(DatiAnag,DallaData,AllaData,False);
    except
      on E: Exception do
      begin
        if LMessaggi.Count = 0 then
        begin
          LMessaggi.Add(Format('Elenco errori riscontrati durante la lettura delle timbrature da allineare dal %s al %s',[DateToStr(DallaData),DateToStr(AllaData)]));
          LMessaggi.Add('');
        end;

        LMessaggi.Add(Format('%-35s - matr. %-8s: (%s) %s',
                             [Copy(C700SelAnagrafe.FieldByName('COGNOME').AsString + ' ' +
                                   C700SelAnagrafe.FieldByName('NOME').AsString,1,35),
                              C700SelAnagrafe.FieldByName('MATRICOLA').AsString,
                              E.ClassName,E.Message]));
      end;
    end;

    C700SelAnagrafe.Next;
  end;

  // filtra solo timbrature con scambio automatico
  A023FAllTimbMW.cdsT100.Filter:='AUTOMATICO = ''S''';
  A023FAllTimbMW.cdsT100.Filtered:=True;
  A023FAllTimbMW.cdsT100.EnableControls;

  // riposizionamento su primo dipendente
  ProgressBar.Position:=0;
  C700SelAnagrafe.First;
  frmSelAnagrafe.VisualizzaDipendente;
  Screen.Cursor:=crDefault;

  // salva i dati di selezione anagrafe e periodo
  DatiAgg.SelezioneAnagrafe:=C700FSelezioneAnagrafe.SQLCreato.Text;
  DatiAgg.Dal:=DallaData;
  DatiAgg.Al:=AllaData;
end;

procedure TB007FManipolazioneDati.AllineamentoTimbrature;
var
  DS: TDataSet;
  OldProgressivo: Integer;
begin
  // controllo se la tabella è aggiornata
  if (DatiAgg.Dal <> DallaData) or
     (DatiAgg.Al <> AllaData) or
     (DatiAgg.SelezioneAnagrafe <> C700FSelezioneAnagrafe.SQLCreato.Text) then
  begin
    LMessaggi.Add('E'' necessario aggiornare la tabella prima di eseguire l''allineamento!');
    Exit;
  end;

  // dataset
  DS:=dgrdTimbUguali.DataSource.DataSet;
  OldProgressivo:=-1;

  // ciclo di update sui progressivi presenti in tabella
  Screen.Cursor:=crHourGlass;
  ProgressBar.Position:=0;
  ProgressBar.Max:=DS.RecordCount;

  DS.DisableControls;
  DS.First;
  while not DS.Eof do
  begin
    Application.ProcessMessages;
    ProgressBar.StepBy(1);

    if DS.FieldByName('PROGRESSIVO').AsInteger <> OldProgressivo then
    begin
      try
        A023FAllTimbMW.Allinea(DS.FieldByName('PROGRESSIVO').AsInteger,DallaData,AllaData);

        RegistraLog.SettaProprieta('M','T100_TIMBRATURE','B007',nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',DS.FieldByName('PROGRESSIVO').AsString,'');
        RegistraLog.InserisciDato('ALLINEAMENTO DAL - AL',Format('%s - %s',[DateToStr(DallaData),DateToStr(AllaData)]),'');
        RegistraLog.RegistraOperazione;

        SessioneOracle.Commit;
      except
        on E: Exception do
        begin
          if LMessaggi.Count = 0 then
          begin
            LMessaggi.Add(Format('Elenco errori riscontrati durante l''allineamento delle timbrature dal %s al %s',[DateToStr(DallaData),DateToStr(AllaData)]));
            LMessaggi.Add('');
          end;

          LMessaggi.Add(Format('%-35s - matr. %-8s: (%s) %s',
                               [Copy(DS.FieldByName('COGNOME').AsString + ' ' +
                                     DS.FieldByName('NOME').AsString,1,35),
                                DS.FieldByName('MATRICOLA').AsString,
                                E.ClassName,E.Message]));
          SessioneOracle.RollBack;
        end;
      end;
    end;
    OldProgressivo:=DS.FieldByName('PROGRESSIVO').AsInteger;
    DS.Next;
  end;

  // riposizionamento su primo record della tabella
  ProgressBar.Position:=0;
  DS.First;
  DS.EnableControls;
  Screen.Cursor:=crDefault;
end;

constructor TString.Create(const AStr: String);
begin
  inherited Create;
  FStr:=AStr;
end;

procedure TB007FManipolazioneDati.ImpostaFiltroAllegati;
var
  PathStorage: TStringList;
  //i: Integer;
  //PeriodoDal, PeriodoAl: TDateTime;
  DimensioneTotale: Integer;
begin
  try
    // recupero delle righe checkate del path storage
    PathStorage:=TStringList.Create;
    {for i:=0 to chkPathStorage.Items.Count - 1 do
    begin
      if chkPathStorage.Checked[i] then
        PathStorage.Add('''' + chkPathStorage.Items[i] + '''');
    end;}
    PathStorage.Add('''DB''');

    // periodo dal-al
    {if not TryStrToDate(edtPeriodoDal.Text, PeriodoDal) then
      raise Exception.Create('La data di inizio non è valida');
    if not TryStrToDate(edtPeriodoAl.Text, PeriodoAl) then
      raise Exception.Create('La data di fine non è valida');}

    // applicazione del filtro --> se la data è superiore a quella limite da parametri aziendali, passa PathStorage nullo per ottenere nessun record dalla query
    B022FUtilityGestDocumentaleDM.ApplicaFiltri(chkFiltroAnagrafe.Checked, IfThen(AllaData <= DataMaxIter, PathStorage.CommaText, ''), DallaData, AllaData);

    // inserimento numero di record nella status bar
    DimensioneTotale:=0;

    try
      dbgT960.DataSource.DataSet.DisableControls;
      dbgT960.DataSource.DataSet.First;
      while not dbgT960.DataSource.DataSet.Eof do
      begin
        DimensioneTotale:=DimensioneTotale + dbgT960.DataSource.DataSet.FieldByName('DIMENSIONE').AsInteger;
        dbgT960.DataSource.DataSet.Next;
      end;
    finally
      dbgT960.DataSource.DataSet.First;
      dbgT960.DataSource.DataSet.EnableControls;
    end;
    //lblFilesSelezionati.Caption:='Files selezionati: ' + IntToStr(dbgT960.DataSource.DataSet.RecordCount);
    //lblDimensioneTotale.Caption:='Dimensione totale: ' + R180GetFileSizeStr(DimensioneTotale);

    // aggiornamento dei path storage
    //ValorizzaListaPathStorage;
  finally
    FreeAndNil(PathStorage);
  end;
end;

procedure TB007FManipolazioneDati.ElaboraAllegatiIter;
begin
  if dbgT960.DataSource.DataSet.RecordCount = 0 then
    ShowMessage('Non ci sono file da elaborare')
  else
  begin
    if AllaData > DataMaxIter then
      raise Exception.Create('La data di fine non è valida');

    ProgressBar.Max:=dbgT960.DataSource.DataSet.RecordCount;
    //if rgpElaborazione.ItemIndex = 0 then
      DBtoFS;
    //else if rgpElaborazione.ItemIndex = 1 then
    //  FStoDB
    //else if rgpElaborazione.ItemIndex = 2 then
    //  FStoFS;

    // operazioni di fine elaborazione
    //ValorizzaListaPathStorage;
    ProgressBar.Position:=ProgressBar.Min;
    btnAnomalie.Enabled:=RegistraMsg.ContieneTipoI or RegistraMsg.ContieneTipoA;
  end;
end;

function TB007FManipolazioneDati.DataMaxIter: TDateTime;
begin
  Result:=R180InizioAnno(R180AddMesi(Date,-12 * StrToInt(Parametri.CampiRiferimento.C90_CancellaAnnoAllegatiIter),True))-1;
end;

procedure TB007FManipolazioneDati.DBtoFS;
var
  Scelta: Integer;
begin
  if not B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestWebService then
  begin
    ShowMessage('Il servizio B021 non è in funzione');
    // oppure raise Exception fa la stessa cosa (se però l'applicazione è chiamata, il chiamante deve gestire l'eccezione
    Exit;
  end;
  if edtNuovoPath.Text <> '' then
  begin
    Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "' +
                        edtNuovoPath.Text + '" (File system)' + CRLF +
                        'Procedere?', mtWarning, mbOKCancel,0);
    if not (Scelta = mrOk) then
      Exit;
    if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(edtNuovoPath.Text) then
      B022FUtilityGestDocumentaleDM.ElaborazioneRecords(0 (*rgpElaborazione.ItemIndex*), edtNuovoPath.Text)
    else
    begin
      ShowMessage('Non è possibile spostare file nella nuova area di storage');
      Exit;
    end;
  end
  else
  begin
    if Parametri.CampiRiferimento.C90_PathAllegati = 'DB' then
    begin
      ShowMessage('Il campo "Area di storage dove registrare gli allegati" è impostato come "DB" (Database), operazione annullata');
      Exit;
    end
    else
    begin
      Scelta:=MessageDlg(IntToStr(dbgT960.DataSource.DataSet.RecordCount) + ' file verranno spostati nell''area di storage "' +
                          Parametri.CampiRiferimento.C90_PathAllegati + '" (File system)' + CRLF +
                          'Procedere?', mtWarning, mbOKCancel,0);
      if not (Scelta = mrOk) then
        Exit;
      if B022FUtilityGestDocumentaleDM.B022FUtilityGestDocumentaleMW.C021DM.TestAccesso(Parametri.CampiRiferimento.C90_PathAllegati) then
        B022FUtilityGestDocumentaleDM.ElaborazioneRecords(0 (*rgpElaborazione.ItemIndex*), Parametri.CampiRiferimento.C90_PathAllegati)
      else
      begin
        ShowMessage('Non è possibile spostare file nella nuova area di storage');
        Exit;
      end
    end;
  end;
  if RegistraMsg.ContieneTipoA then
    ShowMessage('Elaborazione terminata con anomalie')
  else
    ShowMessage('Elaborazione terminata senza anomalie')
end;

end.

