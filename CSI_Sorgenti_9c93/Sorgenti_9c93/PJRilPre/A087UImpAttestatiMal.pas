unit A087UImpAttestatiMal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DBCtrls, Menus,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, ComCtrls, OracleData, XMLDoc, XMLIntf, C004UParamForm,
  A000UInterfaccia, A083UMsgElaborazioni, C012UVisualizzaTesto, R600, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UMessaggi, A087UImpAttestatiMalMW, SelAnagrafe,
  C700USelezioneAnagrafe, A148UProfiliImportazioneCertificatiINPS, ShellAPI, Mask, A003UDataLavoroBis,
  C015UElencoValori, Oracle, IOUtils;

type
  TA087FImpAttestatiMal = class(TForm)
    DataSource1: TDataSource;
    OpenDlg: TOpenDialog;
    frmSelAnagrafe: TfrmSelAnagrafe;
    StatusBar: TStatusBar;
    dGrdProfili: TDBGrid;
    pnlRegoleInserimento: TPanel;
    ppMnuAccedi: TPopupMenu;
    Accedi1: TMenuItem;
    ppMnu: TPopupMenu;
    CopiainExcel1: TMenuItem;
    pgcINPS: TPageControl;
    TabCertificatiXML: TTabSheet;
    PrgBar1: TProgressBar;
    pnlButton: TPanel;
    btnEsegui: TBitBtn;
    btnVisFile: TBitBtn;
    btnAnomalie: TBitBtn;
    btnChiudi: TBitBtn;
    DBGrdPreview: TDBGrid;
    pnlLabel: TPanel;
    TabControl1: TTabControl;
    pnlDatiIn: TPanel;
    lblPercorsoFile: TLabel;
    edtPathFile: TEdit;
    btnPathFile: TButton;
    chkAnomalie: TCheckBox;
    chkInserimento: TCheckBox;
    chkEsenzione: TCheckBox;
    btnDipEsclusi: TBitBtn;
    TabInsManuale: TTabSheet;
    tabFile: TTabSheet;
    edtIDPeriodo: TEdit;
    lblIDPeriodo: TLabel;
    lblDataInizioMal: TLabel;
    lblDataFineMal: TLabel;
    lblDataRilascio: TLabel;
    lblDataConsegna: TLabel;
    rdgTipoCertificato: TRadioGroup;
    rgpTipoRicovero: TRadioGroup;
    rgpAgevolazioni: TRadioGroup;
    rgpTipoComunicazione: TRadioGroup;
    btnDataInizioMal: TButton;
    btnDataFineMal: TButton;
    btnDataRilascio: TButton;
    btnDataConsegna: TButton;
    edtDataInizioMal: TMaskEdit;
    edtDataFineMal: TMaskEdit;
    edtDataRilascio: TMaskEdit;
    edtDataConsegna: TMaskEdit;
    rgpCauseMalattia: TRadioGroup;
    TabCancManuale: TTabSheet;
    dGridCanc: TDBGrid;
    dsrCancManuale: TDataSource;
    pnlCancManuale: TPanel;
    btnCancella: TBitBtn;
    grpReperibilita: TGroupBox;
    edtCognome: TEdit;
    edtVia: TEdit;
    lblCognome: TLabel;
    lblVia: TLabel;
    edtCodCatastale: TEdit;
    edtCAP: TEdit;
    edtProv: TEdit;
    btnComune: TBitBtn;
    lblCodCatastale: TLabel;
    lblProv: TLabel;
    lblCAP: TLabel;
    lblNote: TLabel;
    mmNote: TMemo;
    lblDescComune: TLabel;
    dGrdElenco: TDBGrid;
    pnlPathFile: TPanel;
    edtFileTxt: TEdit;
    lblNomeFile: TLabel;
    btnPathTxt: TButton;
    pnlCaption: TPanel;
    dsrFTXT: TDataSource;
    pnlInserisci: TPanel;
    btnInsFileTxt: TBitBtn;
    prgBarFileTxt: TProgressBar;
    btnAnomalieTxt: TBitBtn;
    btnChiudiInsMan: TBitBtn;
    btnChiudiCanc: TBitBtn;
    btnChiudiImpTXT: TBitBtn;
    btnInserisci: TBitBtn;
    btnModificaPeriodo: TBitBtn;
    btnAnnulla: TBitBtn;
    edtIDPeriodoRettifica: TEdit;
    Label1: TLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnPathFileClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnVisFileClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure chkAnomalieClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrdPreviewDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbCmbCausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure dbCmbCausRicoveroKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnDipEsclusiClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure pgcINPSChange(Sender: TObject);
    procedure btnDataInizioMalClick(Sender: TObject);
    procedure btnInserisciClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure edtDataInizioMalDblClick(Sender: TObject);
    procedure edtDataFineMalEnter(Sender: TObject);
    procedure btnComuneClick(Sender: TObject);
    procedure btnPathTxtClick(Sender: TObject);
    procedure btnInsFileTxtClick(Sender: TObject);
    procedure btnModificaPeriodoClick(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
    procedure pgcINPSChanging(Sender: TObject; var AllowChange: Boolean);
    procedure TabInsManualeShow(Sender: TObject);
    procedure dGridCancCellClick(Column: TColumn);
    procedure dGridCancKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dGridCancDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    A087MW: TA087FImpAttestatiMalMW;
    ColoraGriglia:Boolean;
    LstDipEsclusi:TStringList;
    procedure TestPreInserimento;
    procedure FiltroDipendenti;
    procedure PutParametri;
    procedure GetParametri;
    procedure InizializzaProgressBarTXT;
    procedure ProgressBarStepItTXT;
    procedure InizializzaProgressBar;
    procedure ProgressBarStepIt;
    procedure setT269Fields; //in base al tab attivo abilito o disabilito i campi del dataset T269
    procedure FormattaGrid(MyGrid:TDBGrid);
    procedure AbilitaModifica(Stato:Boolean);
    procedure ResetComponenti;
    procedure selT048CancManC700;
    procedure CambiaProgressivo;
    procedure AfterSelAnagrafe(MyTab:TTabSheet);
    function GetPathFile: String;
    function IsAnomalieChecked: Boolean;
    function IsInserimentoChecked: Boolean;
    function IsInserimentoTXTCSI: Boolean;
    function IsValidChkEsenzione: Boolean;
  public
    { Public declarations }
  end;

procedure OpenA087ImpAttestatiMal;

var
  A087FImpAttestatiMal: TA087FImpAttestatiMal;

implementation

{$R *.dfm}

procedure OpenA087ImpAttestatiMal;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA087ImpAttestatiMal') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA087FImpAttestatiMal,A087FImpAttestatiMal);
  try
    A087FImpAttestatiMal.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Screen.Cursor:=crDefault;
    FreeAndNil(A087FImpAttestatiMal);
  end;
end;

procedure TA087FImpAttestatiMal.FormCreate(Sender: TObject);
begin
  LstDipEsclusi:=TStringList.Create;
  A087MW:=TA087FImpAttestatiMalMW.Create(Self);
  A087MW.StatoOperazione:='I';
  FormattaGrid(dGridCanc);
  CreaC004(SessioneOracle,'A087',Parametri.ProgOper);
  ColoraGriglia:=False;
end;

procedure TA087FImpAttestatiMal.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(A087MW);
end;

procedure TA087FImpAttestatiMal.selT048CancManC700;
begin
  with A087MW do
  begin
    selT048CancMan.Close;
    selT048CancMan.ClearVariables;
    C700MergeSelAnagrafe(selT048CancMan,True);
    selT048CancMan.Open;
  end;
end;

procedure TA087FImpAttestatiMal.FormattaGrid(MyGrid:TDBGrid);
var
  i:integer;
begin
  MyGrid.TitleFont.Color:=clBlue;
  for i:=0 to MyGrid.Columns.Count - 1 do
  begin
    MyGrid.Columns[i].Title.Caption:=StringReplace(MyGrid.Columns[i].Title.Caption,'_',' ',[rfReplaceAll]);
    MyGrid.Columns[i].Title.Caption:=UpperCase(Copy(MyGrid.Columns[i].Title.Caption,1,1)) + LowerCase(Copy(MyGrid.Columns[i].Title.Caption,2,Length(MyGrid.Columns[i].Title.Caption) - 1));
  end;
end;

procedure TA087FImpAttestatiMal.CambiaProgressivo;
var
  CausaMalattia:string;
begin
  CausaMalattia:=A087MW.getCausaMalDaAnagrafico(C700Progressivo,Date,Date).Trim;
  if CausaMalattia = 'G' then
    rgpCauseMalattia.ItemIndex:=1
  else if CausaMalattia = 'S' then
    rgpCauseMalattia.ItemIndex:=2
  else
    rgpCauseMalattia.ItemIndex:=0;
end;

procedure TA087FImpAttestatiMal.FormShow(Sender: TObject);
begin
  with A087MW do
  begin
    evtAnomalieChecked:=IsAnomalieChecked;
    evtGetPathFile:=GetPathFile;
    evtIsValidChkEsenzione:=IsValidChkEsenzione;
    evtInitProgressBar:=InizializzaProgressBar;
    evtProgressBarStepIt:=ProgressBarStepIt;
  end;
  DataSource1.DataSet:=A087MW.CDtsTemp;
  try
    GetParametri;
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DatiSelezionati:=C700CampiBase + ',CODFISCALE';
    if pgcINPS.ActivePage = TabCertificatiXML then
      C700Progressivo:=0;
    C700DataLavoro:=Parametri.DataLavoro;
    frmSelAnagrafe.CreaSelAnagrafe(A087MW,SessioneOracle,StatusBar,0,True);
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
    begin
      frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
      if C700Progressivo > 0 then
        CambiaProgressivo;
    end;
    tabFile.TabVisible:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
    tabInsManuale.TabVisible:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
    tabCancManuale.TabVisible:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
    if Parametri.ModuloInstallato['TORINO_CSI_PRV'] then
      A087MW.evtInserimentoChecked:=IsInserimentoTXTCSI
    else
      A087MW.evtInserimentoChecked:=IsInserimentoChecked;
    AbilitaModifica(True);
    btnAnomalie.Enabled:=False;
    btnAnomalieTxt.Enabled:=False;
    btnEsegui.Enabled:=chkAnomalie.Checked or chkInserimento.Checked;
    if FileExists(edtPathFile.Text) and (pgcINPS.ActivePage = TabCertificatiXML) then
      A087MW.LeggiFileXML(False);
    if FileExists(edtFileTxt.Text) and (pgcINPS.ActivePage = tabFile) then
      A087MW.LeggiFileTXT(edtFileTxt.Text);
    if ((pgcINPS.ActivePage = TabInsManuale) or (pgcINPS.ActivePage = TabCancManuale) or (pgcINPS.ActivePage = tabFile)) and
       (C700SelAnagrafe.RecordCount > 0) then
      selT048CancManC700;
  except
  end;
end;

procedure TA087FImpAttestatiMal.setT269Fields;
var
  MostraCampi:boolean;
begin
  MostraCampi:=(pgcINPS.ActivePage = TabInsManuale) or
               (pgcINPS.ActivePage = TabCancManuale) or
               (pgcINPS.ActivePage = tabFile);
  with A087MW do
  begin
    selT269.FieldByName('CAUS_GRAVIDANZA').Visible:=MostraCampi;
    selT269.FieldByName('CAUS_PATGRAVI').Visible:=MostraCampi;
    selT269.FieldByName('STATO_CAUSA_MALATTIA').Visible:=MostraCampi;
  end;
end;

procedure TA087FImpAttestatiMal.FiltroDipendenti;
var
  StrOut:String;
begin
  LstDipEsclusi.Clear;
  btnDipEsclusi.Enabled:=False;
  if A087MW.CDtsTemp.Active then
  begin
    A087MW.CDtsTemp.Filtered:=False;
    if C700SelAnagrafe.Active and (C700SelAnagrafe.RecordCount > 0) then
    begin
      //Carico dipendenti esclusi
      A087MW.DipInclusi:=False;
      A087MW.CDtsTemp.Filtered:=True;
      btnDipEsclusi.Enabled:=A087MW.CDtsTemp.RecordCount > 0;
      A087MW.CDtsTemp.First;
      StrOut:='';
      while Not A087MW.CDtsTemp.Eof do
      begin
        StrOut:=A087MW.CDtsTemp.FieldByName('cognome_lavoratore').AsString + ' ' +
                A087MW.CDtsTemp.FieldByName('nome_lavoratore').AsString + ' ' +
                A087MW.CDtsTemp.FieldByName('codicefiscale_lavoratore').AsString;
        LstDipEsclusi.Add(StrOut);
        A087MW.CDtsTemp.Next;
      end;
      //-------------------------
      A087MW.CDtsTemp.Filtered:=False;
      A087MW.DipInclusi:=True;
      A087MW.CDtsTemp.Filtered:=True;
    end;
    if btnDipEsclusi.Enabled then
      if R180MessageBox(A000MSG_A087_DLG_DIP_ESCLUSI,DOMANDA,'Conferma') = mrYes then
        btnDipEsclusiClick(Self);
  end;
end;

procedure TA087FImpAttestatiMal.AfterSelAnagrafe(MyTab:TTabSheet);
begin
  if MyTab = TabCertificatiXML then
    FiltroDipendenti;
  if MyTab = TabCancManuale then
    selT048CancManC700;
end;

procedure TA087FImpAttestatiMal.frmSelAnagrafebtnEreditaSelezioneClick(
  Sender: TObject);
begin
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
  AfterSelAnagrafe(pgcINPS.ActivePage);
end;

procedure TA087FImpAttestatiMal.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  frmSelAnagrafe.btnSelezioneClick(Sender);
  AfterSelAnagrafe(pgcINPS.ActivePage);
end;

procedure TA087FImpAttestatiMal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if A087MW.StatoOperazione = 'M' then
    Abort;
  PutParametri;
  FreeAndNil(C004FParamForm);
  FreeAndNil(LstDipEsclusi);
end;

procedure TA087FImpAttestatiMal.PutParametri;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro(UpperCase(edtPathFile.Name),edtPathFile.Text);
  C004FParamForm.PutParametro(UpperCase(pgcINPS.Name),pgcINPS.TabIndex.ToString);
  if chkEsenzione.Checked then
    C004FParamForm.PutParametro(UpperCase(chkEsenzione.Name),'S')
  else
    C004FParamForm.PutParametro(UpperCase(chkEsenzione.Name),'N');
  if chkAnomalie.Checked then
    C004FParamForm.PutParametro(UpperCase(chkAnomalie.Name),'S')
  else
    C004FParamForm.PutParametro(UpperCase(chkAnomalie.Name),'N');
  if chkInserimento.Checked then
    C004FParamForm.PutParametro(UpperCase(chkInserimento.Name),'S')
  else
    C004FParamForm.PutParametro(UpperCase(chkInserimento.Name),'N');
  C004FParamForm.PutParametro(UpperCase(edtFileTxt.Name),edtFileTxt.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TA087FImpAttestatiMal.GetParametri;
begin
  pgcINPS.TabIndex:=C004FParamForm.GetParametro(UpperCase(pgcINPS.Name),'0').ToInteger;
  setT269Fields;
  chkEsenzione.Checked:=C004FParamForm.GetParametro(UpperCase(chkEsenzione.Name),'N') = 'S';
  edtPathFile.Text:=C004FParamForm.GetParametro(UpperCase(edtPathFile.Name),'');
  chkAnomalie.Checked:=C004FParamForm.GetParametro(UpperCase(chkAnomalie.Name),'N') = 'S';
  chkInserimento.Checked:=C004FParamForm.GetParametro(UpperCase(chkInserimento.Name),'N') = 'S';
  edtFileTxt.Text:=C004FParamForm.GetParametro(UpperCase(edtFileTxt.Name),'');
end;

procedure TA087FImpAttestatiMal.Accedi1Click(Sender: TObject);
begin
  OpenA148ProfiliImportazioneCertificatiINPS;
  A087MW.selT269.Refresh;
end;

procedure TA087FImpAttestatiMal.btnAnnullaClick(Sender: TObject);
begin
  if A087MW.StatoOperazione = 'M' then
  begin
    {Stato operazione dev'esere settato a I prima del cambio tab
     perché nel changingtab c'è un controllo che inibisce lo spostamento
     se Stato operazione è uguale a "M"}
    A087MW.StatoOperazione:='I';
    pgcINPS.ActivePage:=TabCancManuale;
  end
  else
    A087MW.StatoOperazione:='I';
  AbilitaModifica(True);
  ResetComponenti;
end;

procedure TA087FImpAttestatiMal.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A087','A');
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A087MW);
end;

procedure TA087FImpAttestatiMal.btnCancellaClick(Sender: TObject);
begin
  with A087MW do
  begin
    if selT048CancMan.RecordCount <= 0 then
      Exit;
    if R180MessageBox(Format(A000MSG_A087_DLG_CANCELLA_CAUSALE,[selT048CancMan.FieldByName('DATA_INIZIO_MAL').AsString,
                                                                selT048CancMan.FieldByName('DATA_FINE_MAL').AsString,
                                                                selT048CancMan.FieldByName('COGNOME').AsString,
                                                                selT048CancMan.FieldByName('NOME').AsString]),DOMANDA) = mrNo then
      Exit;
    A087FImpAttestatiMal.Enabled:=False;
    StatusBar.Panels[1].Text:='Cancellazione in corso...';
    try
      Progressivo:=selT048CancMan.FieldByName('PROGRESSIVO').AsInteger;
      if T048CancellaPerido(selT048CancMan.FieldByName('ID_CERTIFICATO').AsString) then
        R180MessageBox(A000MSG_A087_MSG_PERIODO_MAL_CANC_SI,INFORMA)
      else
        R180MessageBox(A000MSG_A087_MSG_PERIODO_MAL_CANC_NO,ESCLAMA);
      selT048CancMan.Refresh;
      selCertificatiRett.Refresh;
    finally
      StatusBar.Panels[1].Text:='';
      A087FImpAttestatiMal.Enabled:=True;
    end;
  end;
end;

procedure TA087FImpAttestatiMal.btnChiudiClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TA087FImpAttestatiMal.btnComuneClick(Sender: TObject);
var
  Selezione:String;
  vCodice: Variant;
begin
  Selezione:='select T480.CODCATASTALE, T480.CITTA, T480.PROVINCIA, T480.CAP' +
             '  from T480_COMUNI T480' +
             ' order by T480.CITTA';
  vCodice:=VarArrayOf(['','','','']);
  OpenC015FElencoValori('T480_COMUNI',A000MSG_A087_MSG_CAPTION_ELENCO_COMUNI,Selezione,'CODCATASTALE;CITTA;PROVINCIA;CAP',vCodice,nil,500,400);
  if not VarIsClear(vCodice) then
  begin
    edtCodCatastale.Text:=VarToStr(vCodice[0]);
    lblDescComune.Caption:=UpperCase(Copy(VarToStr(VCodice[1]),1,1)) + LowerCase(Copy(VarToStr(VCodice[1]),2,Length(VarToStr(VCodice[1])) - 1));
    edtProv.Text:=VarToStr(vCodice[2]);
    edtCap.Text:=VarToStr(vCodice[3]);
  end;
end;

procedure TA087FImpAttestatiMal.btnDataInizioMalClick(Sender: TObject);
var
  MyEdit:TMaskEdit;
  MyData:TDateTime;
begin
  MyEdit:=nil;
  if Sender = btnDataInizioMal then
    MyEdit:=edtDataInizioMal
  else if Sender = btnDataFineMal then
    MyEdit:=edtDataFineMal
  else if Sender = btnDataRilascio then
    MyEdit:=edtDataRilascio
  else if Sender = btnDataConsegna then
    MyEdit:=edtDataConsegna;
  if not TryStrToDate(MyEdit.Text,MyData) then
    MyData:=Parametri.DataLavoro;
  MyEdit.Text:=DateToStr(DataOut(MyData,A000MSG_A087_MSG_DADATA,'G'));
end;

procedure TA087FImpAttestatiMal.btnDipEsclusiClick(Sender: TObject);
begin
  OpenC012VisualizzaTesto(A000MSG_A087_MSG_DIP_ESCLUSI,'',LstDipEsclusi);
end;

procedure TA087FImpAttestatiMal.btnEseguiClick(Sender: TObject);
var
  i:integer;
begin
  inherited;
  if not A087MW.TestFiltroProfili then
    raise Exception.Create(Format(A000MSG_A087_ERR_FMT_FILTROPROFILI,['IrisWIN']));

  ColoraGriglia:=True;
  Screen.Cursor:=crHourGlass;
  //Serve per committare i dati sulla tabella T001
  SessioneOracle.Commit;

  RegistraMsg.IniziaMessaggio('A087');
  A087MW.BloccoAnomalia:=False;
  Self.Enabled:=False;
  try
    A087MW.CDtsTemp.DisableControls;
    //Lettura file XML e creazione DATASET temporaneo dati
    A087MW.LeggiFileXML(True);

    //Inserimento su tabella Oracle T048
    if Not A087MW.BloccoAnomalia then
      A087MW.InsDipT048;

    A087MW.InsDipT040;
    A087MW.CDtsTemp.EnableControls;
  finally
    if A087MW.CDtsTemp.Active then
    begin
      A087MW.CDtsTemp.First;
      A087MW.CDtsTemp.EnableControls;

      //Elaborazione finale in caso SOLO verifica anomalia
      if Not chkInserimento.Checked then
      begin
        SessioneOracle.Rollback;
        for i:=low(A087MW.VetAttestato) to High(A087MW.VetAttestato) do
        begin
          A087MW.delT048.SetVariable('ID',A087MW.VetAttestato[i].ID_Certificato);
          A087MW.delT048.SetVariable('TIPO',A087MW.VetAttestato[i].Tipo_Elemento);
          A087MW.delT048.Execute;
        end;
        if High(A087MW.VetAttestato) >= 0 then
          SessioneOracle.Commit;
      end;
    end;
    Self.Enabled:=True;
    Screen.Cursor:=crDefault;
    if chkInserimento.Checked then
    begin
      if A087MW.BloccoAnomalia then
      begin
        R180MessageBox(A000MSG_A087_MSG_ANOMALIE_BLOCCANTI,INFORMA);
        btnAnomalieClick(btnAnomalie);
      end
      else if (Not A087MW.BloccoAnomalia) and (RegistraMsg.ContieneTipoA) then
        R180MessageBox(A000MSG_A087_MSG_ANOMALIE_NON_BLOCCANTI,INFORMA)
      else if Not A087MW.BloccoAnomalia then
        R180MessageBox(A000MSG_A087_MSG_IMPORT_TERMINATA,INFORMA)
    end
    else
    begin
      if A087MW.BloccoAnomalia then
      begin
        R180MessageBox(A000MSG_A087_ERR_ANOMALIE_BLOCCANTI,INFORMA);
        btnAnomalieClick(btnAnomalie);
      end
      else if (Not A087MW.BloccoAnomalia) and (RegistraMsg.ContieneTipoA) then
        R180MessageBox(A000MSG_A087_ERR_ANOMALIE_NON_BLOCCANTI,INFORMA)
      else
        R180MessageBox(A000MSG_A087_MSG_NO_ANOMALIE,INFORMA);
    end;
    PrgBar1.Position:=0;
    btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    DBGrdPreview.Repaint;
  end;
end;

procedure TA087FImpAttestatiMal.ResetComponenti;
var
  CausaMalattia:string;
begin
  edtIDPeriodo.Clear;
  edtDataInizioMal.Clear;
  edtDataFineMal.Clear;
  edtDataConsegna.Clear;
  edtDataRilascio.Clear;
  edtIDPeriodoRettifica.Clear;
  rgpTipoRicovero.ItemIndex:=0;
  rdgTipoCertificato.ItemIndex:=0;
  rgpAgevolazioni.ItemIndex:=0;
  rgpTipoComunicazione.ItemIndex:=0;

  //Reinizializzazione rgpCauseMalattia
  CausaMalattia:=A087MW.getCausaMalDaAnagrafico(C700Progressivo,Date,Date).Trim;
  if CausaMalattia = 'G' then
    rgpCauseMalattia.ItemIndex:=1
  else if CausaMalattia = 'S' then
    rgpCauseMalattia.ItemIndex:=2
  else
    rgpCauseMalattia.ItemIndex:=0;

  edtCognome.Clear;
  edtVia.Clear;
  edtCodCatastale.Clear;
  edtCAP.Clear;
  edtProv.Clear;
  mmNote.Lines.Clear;
end;

procedure TA087FImpAttestatiMal.TabInsManualeShow(Sender: TObject);
begin
  R180RadioGroupButton(rgpTipoComunicazione,3).Enabled:=False;
end;

procedure TA087FImpAttestatiMal.TestPreInserimento;
var
  ErrMsg:string;
  NOpzioni:integer;
  DataInizio, DataFine,
  DataRilascio, DataConsegna:TDateTime;
begin
  if C700SelAnagrafe.RecordCount <= 0 then
    raise Exception.Create(A000MSG_A087_MSG_NO_DIP_SELEZIONATI);
  if (trim(edtDataInizioMal.Text) = '/  /') then
    raise Exception.Create(A000MSG_A087_MSG_NO_DATA_INI_NULLA);
  if trim(edtDataFineMal.Text) = '/  /' then
    raise Exception.Create(A000MSG_A087_MSG_NO_DATA_FINE_NULLA);
  if not TryStrToDateTime(edtDataInizioMal.Text,DataInizio) then
    raise Exception.Create(A000MSG_A087_MSG_DATA_INI_NON_VALIDA);
  if not TryStrToDateTime(edtDataFineMal.Text,DataFine) then
    raise Exception.Create(A000MSG_A087_MSG_DATA_FINE_NON_VALIDA);
  if DataFine < DataInizio then
    raise Exception.Create(A000MSG_A087_ERR_FINE_MINORE_INIZIO);
  DataRilascio:=DATE_NULL;
  if trim(edtDataRilascio.Text) <> '/  /' then
  begin
    if not TryStrToDateTime(edtDataRilascio.Text,DataRilascio) then
      raise Exception.Create(A000MSG_A087_ERR_RILASCIO_NON_VALIDO);
    if DataInizio > DataRilascio then
      raise Exception.Create(A000MSG_A087_ERR_RILASCIO_MIN_INIZIO);
  end;
  DataConsegna:=DATE_NULL;
  if trim(edtDataConsegna.Text) <> '/  /' then
  begin
    if not TryStrToDateTime(edtDataRilascio.Text,DataRilascio) then
      raise Exception.Create(A000MSG_A087_ERR_RILASCIO_NON_VALIDO);
    if not TryStrToDateTime(edtDataConsegna.text,DataConsegna) then
      raise Exception.Create(A000MSG_A087_ERR_CONSEGNA_NON_VALIDA);
    if DataConsegna < DataRilascio then
      raise Exception.Create(A000MSG_A087_ERR_CONSEGNA_MIN_RILASCIO);
  end;
  if trim(edtIDPeriodo.Text) = '' then
  begin
    if (DataRilascio <> DATE_NULL) or (DataConsegna <> DATE_NULL) then
      raise Exception.Create(A000MSG_A087_ERR_PROTOCOLLO_NULL_1);
    if (rgpTipoComunicazione.ItemIndex = 0) and
       ((DataRilascio = DATE_NULL) or (DataConsegna = DATE_NULL)) then
      raise Exception.Create(A000MSG_A087_ERR_PROTOCOLLO_NULL_2);
  end;
  ErrMsg:='';
  NOpzioni:=0;
  if rgpTipoRicovero.Items[rgpTipoRicovero.ItemIndex] <> 'Nessuno'  then
  begin
    if not ErrMsg.IsEmpty then
      ErrMsg:=ErrMsg + ', ';
    ErrMsg:=ErrMsg + Format('"%s" diverso da "%s"',[rgpTipoRicovero.Caption, rgpTipoRicovero.Items[0]]);
    inc(NOpzioni);
  end;
  if rgpAgevolazioni.Items[rgpAgevolazioni.ItemIndex] <> 'Nessuna' then
  begin
    if not ErrMsg.IsEmpty then
      ErrMsg:=ErrMsg + ', ';
    ErrMsg:=ErrMsg + Format('"%s" diverso da "%s"',[rgpAgevolazioni.Caption, rgpAgevolazioni.Items[0]]);
    inc(NOpzioni);
  end;
  if rgpCauseMalattia.Items[rgpCauseMalattia.ItemIndex] <> 'Nessuna' then
  begin
    if not ErrMsg.IsEmpty then
      ErrMsg:=ErrMsg + ', ';
    ErrMsg:=ErrMsg + Format('"%s" diverso da "%s"',[rgpCauseMalattia.Caption, rgpCauseMalattia.Items[0]]);
    inc(NOpzioni);
  end;
  if rdgTipoCertificato.Items[rdgTipoCertificato.ItemIndex] <> 'Inserimento' then
  begin
    if not ErrMsg.IsEmpty then
      ErrMsg:=ErrMsg + ', ';
    ErrMsg:=ErrMsg + Format('"%s" diverso da "%s"',[rdgTipoCertificato.Caption, rdgTipoCertificato.Items[0]]);
  end;
  if NOpzioni > 1 then
    raise Exception.Create(A000MSG_A087_ERR_OPZIONI_1);
  {if (rgpTipoComunicazione.Items[rgpTipoComunicazione.ItemIndex] = 'Telefonata') and
     ((rdgTipoCertificato.Items[rdgTipoCertificato.ItemIndex] <> 'Inserimento') or (NOpzioni > 0)) then
    raise Exception.Create(Format(A000MSG_A087_ERR_OPZIONI_2,[ErrMsg]));}
end;

procedure TA087FImpAttestatiMal.btnInserisciClick(Sender: TObject);
begin
  with A087MW do
  begin
    TestPreInserimento;
    InsT048.ClearVariables;
    IDCertificatoModificato:='';
    if StatoOperazione = 'M' then
    begin
      TipoRegistrazione:='T';
      IDCertificatoModificato:=selT048CancMan.FieldByName('ID_CERTIFICATO').AsString;
    end;
    IDCertificato:='';
    NumProtocollo:=edtIDPeriodo.Text;
    TestNumProtocollo(NumProtocollo);
    DataFineMalStr:=edtDataFineMal.Text;
    DataConsegnaStr:=edtDataConsegna.Text;
    DataRilascioStr:=edtDataRilascio.Text;
    Note:=mmNote.Text;
    {Gestione dati repribilità}
    RepCognome:=edtCognome.Text;
    RepVia:=edtVia.Text;
    RepCodCatastale:=edtCodCatastale.Text;
    RepCAP:=edtCAP.Text;
    RepProv:=edtProv.Text;
    DataInizioMalStr:=edtDataInizioMal.Text;
    Progressivo:=C700Progressivo;
    if (rgpTipoComunicazione.Items[rgpTipoComunicazione.ItemIndex] = 'Telefonata') and
       (edtIDPeriodo.Text = '') and (ContaGiorniConsegutivi > 3) then
      raise Exception.Create(A000MSG_A087_ERR_PROTOCOLLO_NULL_3);
    case rdgTipoCertificato.ItemIndex of
      0:TipoCertificato:='I';
      1:TipoCertificato:='C';
      2:TipoCertificato:='R';
    end;
    case rgpTipoRicovero.ItemIndex of
      0:TipoElemento:='I';
      1:begin
          TipoElemento:='R';
          TipoRicovero:='R';
        end;
      2:begin
          TipoElemento:='R';
          TipoRicovero:='H';
        end;
      3:TipoElemento:='D';
    end;
    TipoGestione:='M';
    {Acquisizione da APP solo in visualizzazione(W)}
    case rgpTipoComunicazione.ItemIndex of
      0:TipoGestione:='M';
      1:TipoGestione:='E';
      2:TipoGestione:='T';
      3:TipoGestione:='W';
    end;
    case rgpCauseMalattia.ItemIndex of
      1:CausaMalattia:='G';
      2:CausaMalattia:='S';
    end;
    case rgpAgevolazioni.ItemIndex of
      1:Agevolazioni:='T';
      2:Agevolazioni:='C';
      3:Agevolazioni:='I';
    end;
    setNumProtocolloRett(edtIDPeriodoRettifica.Text);
    if T048InserisciPerido then
    begin
      if StatoOperazione = 'I' then
        R180MessageBox(A000MSG_A087_MSG_PERIODO_INSERITO,INFORMA)
      else
        R180MessageBox('Periodo modificato correttamente.',INFORMA);
      ResetComponenti;
      if StatoOperazione = 'M' then
      begin
        StatoOperazione:='I';
        AbilitaModifica(True);
        pgcINPS.ActivePage:=TabCancManuale;
        pgcINPSChange(nil);
      end;
      selCertificatiRett.Refresh;
    end;
  end;
end;

procedure TA087FImpAttestatiMal.btnInsFileTxtClick(Sender: TObject);
var
  Anomalia:boolean;
begin
  Self.Enabled:=False;
  try
    if not TFile.Exists(edtFileTxt.Text) then
      raise Exception.Create('Percorso o file "' + edtFileTxt.Text + '" inesistente!');
    btnAnomalieTxt.Enabled:=False;
    A087MW.evtInitProgressBarTXT:=InizializzaProgressBarTXT;
    A087MW.evtProgressBarStepItTXT:=ProgressBarStepItTXT;
    RegistraMsg.IniziaMessaggio('A087');
    RegistraMsg.InserisciMessaggio('I', DateTimeToStr(R180SysDate(SessioneOracle)) + ' - Inizio importazione malattie.', Parametri.Azienda);
    A087MW.LeggiFileTXT(edtFileTxt.Text);
    Anomalia:=A087MW.InsDipTXT;
    btnAnomalieTxt.Enabled:=Anomalia;
    RegistraMsg.InserisciMessaggio('I', DateTimeToStr(R180SysDate(SessioneOracle)) + ' - Fine importazione malattie.', Parametri.Azienda);
    if not Anomalia then
      R180MessageBox(A000MSG_A087_MSG_IMPORT_TXT_TERMINATA,INFORMA)
    else
      R180MessageBox(A000MSG_A087_ERR_IMPORT_TXT_TERMINATA,ESCLAMA);
  finally
    Self.Enabled:=True;
  end;
end;

procedure TA087FImpAttestatiMal.AbilitaModifica(Stato:Boolean);
begin
  edtDataInizioMal.Enabled:=Stato;
  btnDataInizioMal.Enabled:=Stato;
  edtIDPeriodoRettifica.Enabled:=Stato;
  if (rgpTipoComunicazione.ControlCount > 0) then
    R180RadioGroupButton(rgpTipoComunicazione,3).Enabled:=rgpTipoComunicazione.ItemIndex = 3;
  rgpTipoRicovero.Enabled:=Stato;
  btnChiudiInsMan.Enabled:=Stato;
  frmSelAnagrafe.Enabled:=Stato;
  if Stato then
    TabInsManuale.Caption:='Inserisci periodo'
  else
    TabInsManuale.Caption:='Modifica periodo';
end;

procedure TA087FImpAttestatiMal.btnModificaPeriodoClick(Sender: TObject);
begin
  with A087MW do
  begin
    if SelAnagrafe.RecordCount <= 0 then
      Exit;
    StatoOperazione:='M';
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',selT048CancMan.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]);
    frmSelAnagrafe.VisualizzaDipendente;
    edtIDPeriodo.Text:=selT048CancMan.FieldByName('NUM_PROTOCOLLO').AsString;
    edtDataInizioMal.Text:=selT048CancMan.FieldByName('DATA_INIZIO_MAL').AsString;
    edtDataFineMal.Text:=selT048CancMan.FieldByName('DATA_FINE_MAL').AsString;
    edtDataRilascio.Text:=selT048CancMan.FieldByName('DATA_RILASCIO').AsString;
    edtDataConsegna.Text:=selT048CancMan.FieldByName('DATA_CONSEGNA').AsString;
    edtIDPeriodoRettifica.Text:=selT048CancMan.FieldByName('DescIdCertificatoRett').AsString;

    if selT048CancMan.FieldByName('TIPO_GESTIONE').AsString = 'M' then
      rgpTipoComunicazione.ItemIndex:=0
    else if selT048CancMan.FieldByName('TIPO_GESTIONE').AsString = 'E' then
      rgpTipoComunicazione.ItemIndex:=1
    else if selT048CancMan.FieldByName('TIPO_GESTIONE').AsString = 'T' then
      rgpTipoComunicazione.ItemIndex:=2
    else if selT048CancMan.FieldByName('TIPO_GESTIONE').AsString = 'W' then
      rgpTipoComunicazione.ItemIndex:=3;

    if selT048CancMan.FieldByName('TIPO_CERTIFICATO').AsString = 'I' then
      rdgTipoCertificato.ItemIndex:=0
    else if selT048CancMan.FieldByName('TIPO_CERTIFICATO').AsString = 'C' then
      rdgTipoCertificato.ItemIndex:=1
    else if selT048CancMan.FieldByName('TIPO_CERTIFICATO').AsString = 'R' then
      rdgTipoCertificato.ItemIndex:=2;

    if selT048CancMan.FieldByName('TIPO_ELEMENTO').AsString = 'I'  then
      rgpTipoRicovero.ItemIndex:=0
    else if selT048CancMan.FieldByName('TIPO_ELEMENTO').AsString = 'R' then
    begin
      if selT048CancMan.FieldByName('TIPO_RICOVERO').AsString = 'R' then
        rgpTipoRicovero.ItemIndex:=1
      else if selT048CancMan.FieldByName('TIPO_RICOVERO').AsString = 'H' then
        rgpTipoRicovero.ItemIndex:=2;
    end
    else if selT048CancMan.FieldByName('TIPO_ELEMENTO').AsString = 'D' then
      rgpTipoRicovero.ItemIndex:=3;

    if selT048CancMan.FieldByName('CAUSA_MALATTIA').AsString = '' then
      rgpCauseMalattia.ItemIndex:=0
    else if selT048CancMan.FieldByName('CAUSA_MALATTIA').AsString = 'G' then
      rgpCauseMalattia.ItemIndex:=1
    else if selT048CancMan.FieldByName('CAUSA_MALATTIA').AsString = 'S' then
      rgpCauseMalattia.ItemIndex:=2;

    if selT048CancMan.FieldByName('AGEVOLAZIONI').AsString = '' then
      rgpAgevolazioni.ItemIndex:=0
    else if selT048CancMan.FieldByName('AGEVOLAZIONI').AsString = 'T' then
      rgpAgevolazioni.ItemIndex:=1
    else if selT048CancMan.FieldByName('AGEVOLAZIONI').AsString = 'C' then
      rgpAgevolazioni.ItemIndex:=2
    else if selT048CancMan.FieldByName('AGEVOLAZIONI').AsString = 'I' then
      rgpAgevolazioni.ItemIndex:=3;

    edtCognome.Text:=selT048CancMan.FieldByName('COGNOME_REP').AsString;
    edtVia.Text:=selT048CancMan.FieldByName('VIA_REP').AsString;
    edtCodCatastale.Text:=selT048CancMan.FieldByName('CODCATASTALE_REP').AsString;
    edtCAP.Text:=selT048CancMan.FieldByName('CAP_REP').AsString;
    edtProv.Text:=selT048CancMan.FieldByName('PROV_REP').AsString;

    mmNote.Lines.Clear;
    if not selT048CancMan.FieldByName('NOTE').IsNull then
      mmNote.Lines.Text:=selT048CancMan.FieldByName('NOTE').AsString;

    pgcINPS.ActivePage:=TabInsManuale;
    AbilitaModifica(StatoOperazione = 'I');
  end;
end;

procedure TA087FImpAttestatiMal.btnPathFileClick(Sender: TObject);
begin
  OpenDlg.Filter:='XML|*.XML';
  if edtPathFile.Text <> '' then
    OpenDlg.FileName:=edtPathFile.Text;
  OpenDlg.InitialDir:=ExtractFilePath(edtPathFile.Text);
  if OpenDlg.Execute then
    edtPathFile.Text:=OpenDlg.FileName;
  if FileExists(edtPathFile.Text) then
  begin
    A087MW.LeggiFileXML(False);
    FiltroDipendenti;
  end;
  ColoraGriglia:=False;
end;

procedure TA087FImpAttestatiMal.btnPathTxtClick(Sender: TObject);
begin
  OpenDlg.Filter:='TXT|*.TXT';
  if edtPathFile.Text <> '' then
    OpenDlg.FileName:=edtFileTxt.Text;
  OpenDlg.InitialDir:=ExtractFilePath(edtFileTxt.Text);
  if OpenDlg.Execute then
    edtFileTxt.Text:=OpenDlg.FileName;
  if FileExists(edtFileTxt.Text) then
    A087MW.LeggiFileTXT(edtFileTxt.Text);
end;

procedure TA087FImpAttestatiMal.btnVisFileClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar(edtPathFile.Text),nil,nil,SW_SHOWNORMAL);
end;

procedure TA087FImpAttestatiMal.chkAnomalieClick(Sender: TObject);
begin
  if Sender = chkInserimento then
    if chkInserimento.Checked then
    begin
      chkAnomalie.Checked:=True;
      chkAnomalie.Enabled:=False;
    end
    else
      chkAnomalie.Enabled:=True;
  btnEsegui.Enabled:=chkAnomalie.Checked or chkInserimento.Checked;
end;

procedure TA087FImpAttestatiMal.CopiainExcel1Click(Sender: TObject);
begin
  R180DBGridSelezionaRighe(DBGrdPreview,'S');
  R180DBGridCopyToClipboard(DBGrdPreview,True,True,True,False);
end;

procedure TA087FImpAttestatiMal.dbCmbCausaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).DataSource.Edit;
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        begin
          (Sender as TDBLookupComboBox).Field.Dataset.FieldByName((Sender as TDBLookupComboBox).KeyField).Clear;
          (Sender as TDBLookupComboBox).Field.FocusControl;
        end
        else
          (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA087FImpAttestatiMal.dbCmbCausRicoveroKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).DataSource.Edit;
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        begin
          (Sender as TDBLookupComboBox).Field.Dataset.FieldByName((Sender as TDBLookupComboBox).KeyField).Clear;
          (Sender as TDBLookupComboBox).Field.FocusControl;
        end
        else
          (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA087FImpAttestatiMal.DBGrdPreviewDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  clrCella:TColor;
begin
  if (gdFixed in State) or Not ColoraGriglia then
    exit;

  clrCella:=A087MW.ColoraCella;
  if clrCella <> clWhite then
  begin
    DBGrdPreview.Canvas.Brush.Color:=clrCella;
    DBGrdPreview.Canvas.Font.Color:=clWhite;
  end
  else
  begin
    DBGrdPreview.Canvas.Brush.Color:=clrCella;
    DBGrdPreview.Canvas.Font.Color:=clBlack;
  end;
  DBGrdPreview.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TA087FImpAttestatiMal.dGridCancCellClick(Column: TColumn);
var
  Abilitazione:boolean;
begin
  with A087MW do
  begin
    Abilitazione:=not IDIsRett(selT048CancMan.FieldByName('ID_CERTIFICATO').AsString);
    btnModificaPeriodo.Enabled:=Abilitazione;
    btnCancella.Enabled:=Abilitazione;
  end;
end;

procedure TA087FImpAttestatiMal.dGridCancDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdSelected in State) and dGridCanc.Focused then
    Exit;
  with A087MW do
    if IDIsRett(selT048CancMan.FieldByName('ID_CERTIFICATO').AsString) then
      dGridCanc.Canvas.Brush.Color:=clSilver
    else
      dGridCanc.Canvas.Brush.Color:=clWindow;
  dGridCanc.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TA087FImpAttestatiMal.dGridCancKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Abilitazione:boolean;
begin
  with A087MW do
  begin
    Abilitazione:=not IDIsRett(selT048CancMan.FieldByName('ID_CERTIFICATO').AsString);
    btnModificaPeriodo.Enabled:=Abilitazione;
    btnCancella.Enabled:=Abilitazione;
  end;
end;

procedure TA087FImpAttestatiMal.edtDataFineMalEnter(Sender: TObject);
begin
  if (trim(edtDataInizioMal.Text) <> '') and (trim(edtDataFineMal.Text) = '/  /') then
    edtDataFineMal.Text:=edtDataInizioMal.Text
end;

procedure TA087FImpAttestatiMal.edtDataInizioMalDblClick(Sender: TObject);
begin
  if Sender = edtDataInizioMal then
    (Sender as TMaskEdit).Text:=DateToStr(trunc(Parametri.DataLavoro))
  else if (Sender = edtDataFineMal) and (trim(edtDataInizioMal.Text) <> '') then
    (Sender as TMaskEdit).Text:=edtDataInizioMal.Text
  else if (Sender = edtDataRilascio) and (trim(edtDataInizioMal.Text) <> '') then
    (Sender as TMaskEdit).Text:=edtDataInizioMal.Text
  else if (Sender = edtDataConsegna) and (trim(edtDataRilascio.Text) <> '') then
    (Sender as TMaskEdit).Text:=edtDataRilascio.Text;
end;

function TA087FImpAttestatiMal.GetPathFile: String;
begin
  Result:=edtPathFile.Text;
end;

function TA087FImpAttestatiMal.IsAnomalieChecked: Boolean;
begin
  Result:=chkAnomalie.Checked;
end;

function TA087FImpAttestatiMal.IsValidChkEsenzione: Boolean;
begin
  Result:=chkEsenzione.Enabled and chkEsenzione.Checked;
end;

procedure TA087FImpAttestatiMal.pgcINPSChange(Sender: TObject);
begin
  if pgcINPS.ActivePage = TabCertificatiXML then
  begin
    if FileExists(edtPathFile.Text) then
      A087MW.LeggiFileXML(False);
    FiltroDipendenti;
  end
  else if pgcINPS.ActivePage = TabCancManuale then
  begin
    A087MW.selT048CancMan.Close;
    if C700Progressivo > 0 then
      C700MergeSelAnagrafe(A087MW.selT048CancMan,True)
    else
      A087MW.OpenSelT048CancMan;
    A087MW.selT048CancMan.Open;
  end
  else if pgcINPS.ActivePage = tabFile then
  begin
    if FileExists(edtFileTxt.Text) then
      A087MW.LeggiFileTXT(edtFileTxt.Text);
  end;
  setT269Fields;
end;

procedure TA087FImpAttestatiMal.pgcINPSChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=A087MW.StatoOperazione = 'I';
end;

function TA087FImpAttestatiMal.IsInserimentoChecked: Boolean;
begin
  Result:=chkInserimento.Checked;
end;

function TA087FImpAttestatiMal.IsInserimentoTXTCSI: Boolean;
begin
  Result:=True;
end;

procedure TA087FImpAttestatiMal.InizializzaProgressBarTXT;
begin
  prgBarFileTxt.Min:=0;
  prgBarFileTxt.Position:=0;
  prgBarFileTxt.Max:=High(A087MW.VetAttestato) + 1;
end;

procedure TA087FImpAttestatiMal.ProgressBarStepItTXT;
begin
  prgBarFileTxt.StepIt;
end;

procedure TA087FImpAttestatiMal.InizializzaProgressBar;
begin
  PrgBar1.Min:=0;
  PrgBar1.Position:=0;
  PrgBar1.Max:=High(A087MW.VetAttestato) + 1;
end;

procedure TA087FImpAttestatiMal.ProgressBarStepIt;
begin
  PrgBar1.StepIt;
end;

end.
