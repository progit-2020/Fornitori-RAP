unit S031UFamiliari;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICO, Grids, DBGrids, ExtCtrls, Menus, DBCtrls, ImgList, Db,
  ComCtrls, ToolWin, StdCtrls, Mask, Buttons, C700USelezioneAnagrafe, A003UDataLavoroBis,
  A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, A011UComuniProvinceRegioni,
  C005UDatiAnagrafici, C013UCheckList, C180FunzioniGenerali, OracleData, ActnList, SelAnagrafe, Variants,
  System.Actions, System.ImageList;

type
  TElencoNumOrd = record
    NumOrd:Integer;
    Colorata:Boolean;
  end;

  TS031FFamiliari = class(TR004FGestStorico)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dgrdDATIBASE: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnCarica: TBitBtn;
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    tabDatiAnagrafici: TTabSheet;
    tabLegge104: TTabSheet;
    tabDatiStipendiali: TTabSheet;
    tabNote: TTabSheet;
    dmemNote: TDBMemo;
    GroupBox1: TGroupBox;
    lblRedditoANF: TLabel;
    lblRedditoAltroANF: TLabel;
    lblTotaleANF: TLabel;
    dchkANFSpeciale: TDBCheckBox;
    dchkANF: TDBCheckBox;
    dchkANFInabile: TDBCheckBox;
    dedtREDDITOANF: TDBEdit;
    dedtRedditoAltroANF: TDBEdit;
    edtTotaleANF: TEdit;
    lblNUMORD: TLabel;
    lblCOGNOME: TLabel;
    lblDataNas: TLabel;
    lblComNas: TLabel;
    lblProvNas: TLabel;
    lblDATAMAT: TLabel;
    lblDATASEP: TLabel;
    lblNOME: TLabel;
    lblMatricola: TLabel;
    lblDataAdoz: TLabel;
    lblCodFiscale: TLabel;
    lblDataNasPresunta: TLabel;
    lblCapNas: TLabel;
    dedtNUMORD: TDBEdit;
    dedtCOGNOME: TDBEdit;
    dcmbComNas: TDBLookupComboBox;
    dedtProvNas: TDBEdit;
    dedtDATAMAT: TDBEdit;
    dedtDATASEP: TDBEdit;
    dedtNOME: TDBEdit;
    dedtCOMNAS: TDBEdit;
    dedtDataNas: TDBEdit;
    dcmbMatricola: TDBLookupComboBox;
    dedtDataAdoz: TDBEdit;
    drgpSesso: TDBRadioGroup;
    dedtCodFiscale: TDBEdit;
    dedtDataNasPresunta: TDBEdit;
    dedtCAPNas: TDBEdit;
    Panel1: TPanel;
    gpbAnnoAvv: TGroupBox;
    lblAnnoAvv: TLabel;
    lblAnnoAvvFam: TLabel;
    dedtAnnoAvv: TDBEdit;
    dedtAnnoAvvFam: TDBEdit;
    gpbDisabilita: TGroupBox;
    lblAnnoRevisione: TLabel;
    lblTipoDisabilita: TLabel;
    gpbFamiliare: TGroupBox;
    lblDurataContratto: TLabel;
    lblNomePA: TLabel;
    gpbAlternativa: TGroupBox;
    lblAlternativaNomePA: TLabel;
    lblAlternativaMotivoTerzoGrado: TLabel;
    lblAlternativa: TLabel;
    cmbAlternativaMotivoTerzoGrado: TComboBox;
    cmbAlternativa: TComboBox;
    cmbDurataContratto: TComboBox;
    cmbTipoDisabilita: TComboBox;
    gpbCausali: TGroupBox;
    dedtCausaliAbilitate: TDBEdit;
    btnCausali: TButton;
    gpbResidenza: TGroupBox;
    dedtIndirizzo: TDBEdit;
    lblIndirizzo: TLabel;
    dcmbComune: TDBLookupComboBox;
    lblComune: TLabel;
    dedtComune: TDBEdit;
    dedtCAP: TDBEdit;
    lblCap: TLabel;
    dedtProvincia: TDBEdit;
    lblProvincia: TLabel;
    dedtTelefono: TDBEdit;
    lblTelefono: TLabel;
    gpbDetrazioniIRPEF: TGroupBox;
    lblPERC_CARICO: TLabel;
    lblDATA_ULT_FAM_CAR: TLabel;
    drgpTIPO_DETRAZIONE: TDBRadioGroup;
    dedtPERC_CARICO: TDBEdit;
    dchkDetrFiglioHandicap: TDBCheckBox;
    dedtDATA_ULT_FAM_CAR: TDBEdit;
    dchkDetr100Affid: TDBCheckBox;
    cmbNomePA: TComboBox;
    cmbAlternativaNomePA: TComboBox;
    MnuCopia: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N9: TMenuItem;
    Copia1: TMenuItem;
    CopiaInExcel: TMenuItem;
    cmbTipoAdoz: TComboBox;
    lblTipoAdoz: TLabel;
    dedtDataPreAdoz: TDBEdit;
    lblDataPreAdoz: TLabel;
    lblNumGrado: TLabel;
    lblTipoPar: TLabel;
    lblParentela: TLabel;
    lblMotivoTerzoGrado: TLabel;
    dedtNumGrado: TDBEdit;
    cmbParentela: TComboBox;
    cmbTipoPar: TComboBox;
    cmbMotivoTerzoGrado: TComboBox;
    gpbGravidanza: TGroupBox;
    dedtGravInizioTeorico: TDBEdit;
    lblGravInizioTeorico: TLabel;
    dedtGravInizioScelto: TDBEdit;
    lblGravInizioScelto: TLabel;
    dedtGravInizioEffettivo: TDBEdit;
    lblGravInizioEffettivo: TLabel;
    dedtGravFine: TDBEdit;
    lblGravFine: TLabel;
    dedtAnnoRevisione: TDBEdit;
    btnGravInizioTeorico: TButton;
    btnGravInizioScelto: TButton;
    btnGravInizioEffettivo: TButton;
    btnGravFine: TButton;
    btnDataPreAdoz: TButton;
    btnDataSep: TButton;
    btnDataMat: TButton;
    btnAnnoRevisione: TButton;
    btnDATA_ULT_FAM_CAR: TButton;
    chkRegDatanas: TDBCheckBox;
    lblNoteIndividuali: TLabel;
    dedtNoteIndividuali: TDBEdit;
    edtDataNasDummy: TEdit;
    lblPartFruizMaternita: TLabel;
    cmbPartFruizMaternita: TComboBox;
    procedure TAnnullaClick(Sender: TObject);
    procedure dedtREDDITOANFExit(Sender: TObject);
    procedure dedtCodFiscaleKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dedtCodFiscaleEnter(Sender: TObject);
    procedure dcmbMatricolaKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure btnCausaliClick(Sender: TObject);
    procedure dedtCAPNasDblClick(Sender: TObject);
    procedure dedtCAPNasKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dcmbMatricolaCloseUp(Sender: TObject);
    procedure dcmbMatricolaKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnCaricaClick(Sender: TObject);
    procedure cmbParentelaCloseUp(Sender: TObject);
    procedure cmbParentelaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TInserClick(Sender: TObject);
    procedure drgpTIPO_DETRAZIONEClick(Sender: TObject);
    procedure dedtPERC_CARICOExit(Sender: TObject);
    procedure dedtNumGradoChange(Sender: TObject);
    procedure cmbAlternativaCloseUp(Sender: TObject);
    procedure cmbAlternativaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbTipoDisabilitaCloseUp(Sender: TObject);
    procedure cmbTipoDisabilitaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TRegisClick(Sender: TObject);
    procedure cmbTipoParKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TModifClick(Sender: TObject);
    procedure cmbNomePAChange(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure dgrdDATIBASEDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Visionecorrente1Click(Sender: TObject);
    procedure btnGravInizioTeoricoClick(Sender: TObject);
    procedure btnGravInizioSceltoClick(Sender: TObject);
    procedure btnGravInizioEffettivoClick(Sender: TObject);
    procedure btnGravFineClick(Sender: TObject);
    procedure btnDataPreAdozClick(Sender: TObject);
    procedure btnDataSepClick(Sender: TObject);
    procedure btnDataMatClick(Sender: TObject);
    procedure btnAnnoRevisioneClick(Sender: TObject);
    procedure btnDATA_ULT_FAM_CARClick(Sender: TObject);
    procedure dedtDataPreAdozChange(Sender: TObject);
    procedure chkRegDatanasClick(Sender: TObject);
    procedure cmbTipoAdozCloseUp(Sender: TObject);
    procedure cmbTipoAdozClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
  private
    ElencoNumOrd:array of TElencoNumOrd;
    procedure CambiaProgressivo;
    procedure CaricaLista;
    procedure CaricaNomePA(Combo:TComboBox);
    procedure CaricaElencoNumOrd;
  public
    procedure SetAbilitazioneDateGravidanza;
    procedure AllineaComponenti;
    procedure AbilitaComponenti;
  end;

var
  S031FFamiliari: TS031FFamiliari;

procedure OpenS031Familiari(Prog:Integer);

implementation

uses S031UFamiliariDtM;

{$R *.DFM}

procedure OpenS031Familiari(Prog:Integer);
begin
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS031Familiari') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S031FFamiliari:=TS031FFamiliari.Create(nil);
  with S031FFamiliari do
  try
    C700Progressivo:=Prog;
    S031FFamiliariDtM:=TS031FFamiliariDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S031FFamiliariDtM.Free;
    Free;
  end;
end;

procedure TS031FFamiliari.FormShow(Sender: TObject);
begin
  inherited;

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  // utilizza un edit fittizio senza testo da mostrare sopra alla data di nascita
  edtDataNasDummy.Visible:=False;
  edtDataNasDummy.Enabled:=False;
  edtDataNasDummy.Text:='';
  edtDataNasDummy.Top:=dedtDataNas.Top;
  edtDataNasDummy.Left:=dedtDataNas.Left;
  edtDataNasDummy.Width:=dedtDataNas.Width;
  edtDataNasDummy.Height:=dedtDataNas.Height;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(S031FFamiliariDtM.S031FFamiliariMW,SessioneOracle,StatusBar,3,True);
  PageControl1.ActivePage:=tabDatiAnagrafici;
  VisioneCorrente1Click(nil);
end;

procedure TS031FFamiliari.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    S031FFamiliariDtM.SettaProgressivo;
    GetDateDecorrenza;
    NumRecords;
    AllineaComponenti;
    AbilitaComponenti;
  end;
end;

procedure TS031FFamiliari.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso and InterfacciaR004.RipristinoValoriInCorso then
    exit;

  with S031FFamiliariDtm.QSG101 do
  begin
    if Field = FieldByName('GRAV_FINE') then
    begin
      if FieldByName('GRAV_FINE').Value <> S031FFamiliariDtM.S031FFamiliariMW.selSG101OldValues.FieldByName('GRAV_FINE').Value then
      begin
        if FieldByName('GRAV_FINE').AsDateTime > R180AddMesi(FieldByName('GRAV_INIZIO_EFF').AsDateTime,5,True) then
          if MessageDlg('Il periodo di gravidanza/adozione specificato supera i 5 mesi: confermare la modifica?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
          begin
            FieldByName('GRAV_FINE').Value:=S031FFamiliariDtM.S031FFamiliariMW.selSG101OldValues.FieldByName('GRAV_FINE').Value;
          end;
      end;
    end;
  end;
end;

procedure TS031FFamiliari.DButtonStateChange(Sender: TObject);
begin
  inherited;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  DButton.DataSet.DisableControls;
  try
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    dgrdDatiBase.Enabled:=DButton.State = dsBrowse;
    frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
    btnCarica.Enabled:=DButton.State = dsBrowse;
    btnCausali.Enabled:=DButton.State in [dsEdit,dsInsert];
    AbilitaComponenti;

    // blocca modifica numero ordine in inserimento
    //dedtNUMORD.ReadOnly:=DButton.State = dsInsert;

    // blocca campi anagrafici fissi in fase di storicizzazione
    with S031FFamiliariDtm.QSG101 do
    begin
      FieldByName('NUMORD').ReadOnly:=DButton.State = dsInsert;
      FieldByName('MATRICOLA').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
      FieldByName('COGNOME').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
      FieldByName('NOME').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
      FieldByName('SESSO').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
      FieldByName('DATANAS').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
      FieldByName('COMNAS').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
      FieldByName('CAPNAS').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
      FieldByName('CODFISCALE').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  finally
    DButton.DataSet.EnableControls;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TS031FFamiliari.Nuovoelemento1Click(Sender: TObject);
{Carica la Struttura griglia con i dati della tabella}
begin
  if PopupMenu1.PopupComponent.Name = 'dcmbComNas' then
    OpenA011ComuniProvinceRegioni(dedtComNas.Text,'C')
  else
    OpenA011ComuniProvinceRegioni(dedtComune.Text,'C');
  S031FFamiliariDtM.S031FFamiliariMW.Q480.Close;
  S031FFamiliariDtM.S031FFamiliariMW.Q480.Open;
end;

procedure TS031FFamiliari.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDatiBase,'S');
end;

procedure TS031FFamiliari.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TS031FFamiliari.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDatiBase,'C');
end;

procedure TS031FFamiliari.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TS031FFamiliari.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TS031FFamiliari.dcmbMatricolaCloseUp(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS031FFamiliari.dcmbMatricolaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TS031FFamiliari.dcmbMatricolaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dcmbMatricolaCloseUp(nil);
end;

procedure TS031FFamiliari.dedtCAPNasDblClick(Sender: TObject);
begin
  inherited;
  {Ricava il CAP dalla tabella comuni se si fa DoppiClick}
  if S031FFamiliariDtM.QSG101.State in [dsInsert,dsEdit] then
    if Sender = dedtCAPNas then
      with S031FFamiliariDtM.QSG101 do
        FieldByName('CAPNas').AsString:=FieldByName('D_CAPNAS').AsString
    else
      with S031FFamiliariDtM.QSG101 do
        FieldByName('CAP').AsString:=FieldByName('D_CAP').AsString;
end;

procedure TS031FFamiliari.dedtCAPNasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  {Ricava il CAP dalla tabella comuni se si preme Ctrl + Enter}
  if (Key = 13) and (Shift = [ssCtrl]) then
    dedtCAPNasDblClick(Sender);
end;

procedure TS031FFamiliari.dedtCodFiscaleEnter(Sender: TObject);
begin
  inherited;
  if (dedtCodFiscale.DataSource.State in [dsEdit,dsInsert]) and (Trim(dedtCodFiscale.Field.AsString) = '') then
    with S031FFamiliariDtM.QSG101 do
      dedtCodFiscale.Field.AsString:=R180CalcoloCodiceFiscale(FieldByName('Cognome').AsString,
                                                       FieldByName('Nome').AsString,
                                                       FieldByName('Sesso').AsString,
                                                       FieldByName('D_CodCatastale').AsString,
                                                       FieldByName('DataNas').AsDateTime);
end;

procedure TS031FFamiliari.dedtCodFiscaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
   if (dedtCodFiscale.DataSource.State in [dsEdit,dsInsert]) and (Key = 13) and (Shift = [ssCtrl]) then
    with S031FFamiliariDtM.QSG101 do
      dedtCodFiscale.Field.AsString:=R180CalcoloCodiceFiscale(FieldByName('Cognome').AsString,
                                                       FieldByName('Nome').AsString,
                                                       FieldByName('Sesso').AsString,
                                                       FieldByName('D_CodCatastale').AsString,
                                                       FieldByName('DataNas').AsDateTime);
end;

procedure TS031FFamiliari.dedtDataPreAdozChange(Sender: TObject);
// attenzione, è agganciato da diversi dbedit!!!
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso and InterfacciaR004.RipristinoValoriInCorso then
    exit;

  R180ClearDBEditDateTime(Sender);
end;

procedure TS031FFamiliari.dedtNumGradoChange(Sender: TObject);
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso and InterfacciaR004.RipristinoValoriInCorso then
    exit;

  lblMotivoTerzoGrado.Enabled:=(dedtNumGrado.Text = '3');
  cmbMotivoTerzoGrado.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (dedtNumGrado.Text = '3');
  if not cmbMotivoTerzoGrado.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbMotivoTerzoGrado.ItemIndex:=-1;
end;

procedure TS031FFamiliari.dedtPERC_CARICOExit(Sender: TObject);
begin
  inherited;
  drgpTIPO_DETRAZIONEClick(nil);
end;

procedure TS031FFamiliari.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  AllineaComponenti;
  AbilitaComponenti;
  dedtDecorrenza.SetFocus;
end;

procedure TS031FFamiliari.btnCaricaClick(Sender: TObject);
begin
  inherited;

  Screen.Cursor:=crHourGlass;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  DButton.DataSet.DisableControls;
  try
    cmbParentela.ItemIndex:=0;
    dcmbMatricola.KeyValue:=C700SelAnagrafe.FieldByName('MATRICOLA').AsString;
    S031FFamiliariDtM.QSG101.AfterScroll:=nil;
    S031FFamiliariDtM.QSG101.OnCalcFields:=nil;
    S031FFamiliariDtM.QSG101.BeforePost:=nil;
    S031FFamiliariDtM.QSG101.AfterPost:=nil;
    S031FFamiliariDtM.S031FFamiliariMW.CaricaSeStesso;
    S031FFamiliariDtM.QSG101.Refresh;
    S031FFamiliariDtM.QSG101.BeforePost:=S031FFamiliariDtM.BeforePost;
    S031FFamiliariDtM.QSG101.AfterPost:=S031FFamiliariDtM.AfterPost;
    S031FFamiliariDtM.QSG101.OnCalcFields:=S031FFamiliariDtM.QSG101CalcFields;
    S031FFamiliariDtM.QSG101.AfterScroll:=S031FFamiliariDtM.QSG101AfterScroll;
    // Screen.Cursor:=crDefault; // TORINO_CSI - commessa 2015/142 SVILUPPO#7 - spostato sotto
    actRefresh.Execute;
    S031FFamiliariDtM.QSG101.Last;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  finally
    DButton.DataSet.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TS031FFamiliari.btnCausaliClick(Sender: TObject);
var S:String;
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Scelta causali fruibili';
  with C013FCheckList do
  try
    S:=dedtCausaliAbilitate.Field.AsString;
    CaricaLista;
    R180PutCheckList(S,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
    begin
      dedtCausaliAbilitate.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
      if Copy(dedtCausaliAbilitate.Field.AsString,1,2) = '*,' then
        dedtCausaliAbilitate.Field.AsString:='*';
    end;
  finally
    Release;
  end;
end;

procedure TS031FFamiliari.btnDataMatClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATAMAT').AsDateTime,'Data matrimonio','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATAMAT').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataPreAdozClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATA_PREADOZ').AsDateTime,'Data pre-adozione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATA_PREADOZ').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataSepClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATASEP').AsDateTime,'Data esclusione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATASEP').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDATA_ULT_FAM_CARClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATA_ULT_FAM_CAR').AsDateTime,'Data ultima dichiarazione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATA_ULT_FAM_CAR').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravInizioTeoricoClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime,'Data inizio teorico','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravFineClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_FINE').AsDateTime,'Data fine effettiva','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_FINE').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravInizioEffettivoClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime,'Data inizio effettivo','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravInizioSceltoClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime,'Data inizio scelto dal dip.','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnAnnoRevisioneClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('ANNO_REVISIONE').AsDateTime,'Data revisione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('ANNO_REVISIONE').AsDateTime:=D;
end;

procedure TS031FFamiliari.CaricaLista;
begin
  with S031FFamiliariDtM.S031FFamiliariMW.selT265 do
  begin
    Open;
    First;
    C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',['*','Tutte le causali']));
    while not Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
procedure TS031FFamiliari.chkRegDatanasClick(Sender: TObject);
begin
  if InterfacciaR004.StoricizzazioneInCorso and InterfacciaR004.RipristinoValoriInCorso then
    exit;

  dedtDataNas.Enabled:=chkRegDatanas.Checked;
  lblDataNas.Enabled:=dedtDataNas.Enabled;
  // se il check viene attivato:
  //   visualizza il campo data nascita e lo valorizza uguale alla data presunta
  // altrimenti
  //   nasconde il campo data nascita e visualizza al suo posto un campo fittizio vuoto
  if DButton.DataSet.State in [dsEdit,dsInsert] then
  begin
    dedtDataNas.Visible:=dedtDataNas.Enabled;
    edtDataNasDummy.Visible:=not dedtDataNas.Enabled;
    if dedtDataNas.Enabled then
      S031FFamiliariDtM.QSG101.FieldByName('DATANAS').Value:=S031FFamiliariDtM.QSG101.FieldByName('DATANAS_PRESUNTA').Value;
  end;
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

procedure TS031FFamiliari.cmbAlternativaCloseUp(Sender: TObject);
begin
  inherited;
  lblAlternativaMotivoTerzoGrado.Enabled:=cmbAlternativa.ItemIndex = 4;
  cmbAlternativaMotivoTerzoGrado.Enabled:=cmbAlternativa.ItemIndex = 4;
  if not cmbAlternativaMotivoTerzoGrado.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=-1;
  lblAlternativaNomePA.Enabled:=(cmbAlternativa.ItemIndex <> -1) and (cmbAlternativa.ItemIndex <> 5);
  cmbAlternativaNomePA.Enabled:=(cmbAlternativa.ItemIndex <> -1) and (cmbAlternativa.ItemIndex <> 5);
  if not cmbAlternativaNomePA.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbAlternativaNomePA.ItemIndex:=-1;
end;

procedure TS031FFamiliari.cmbAlternativaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbAlternativaCloseUp(nil);
end;

procedure TS031FFamiliari.cmbNomePAChange(Sender: TObject);
begin
  inherited;
  if InterfacciaR004.StoricizzazioneInCorso and InterfacciaR004.RipristinoValoriInCorso then
    exit;

  lblDurataContratto.Enabled:=Trim(cmbNomePA.Text) <> '';
  cmbDurataContratto.Enabled:=Trim(cmbNomePA.Text) <> '';
  if not cmbDurataContratto.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbDurataContratto.ItemIndex:=-1;
end;

procedure TS031FFamiliari.cmbParentelaCloseUp(Sender: TObject);
begin
  inherited;

  if DButton.State in [dsEdit,dsInsert] then
  begin
    DButton.DataSet.FieldByName('NUMGRADO').AsString:='';
    cmbTipoPar.ItemIndex:=-1;
    if cmbParentela.ItemIndex in [2,3] then //Figlio,Genitore
    begin
      DButton.DataSet.FieldByName('NUMGRADO').AsString:='1';
      cmbTipoPar.ItemIndex:=0;
    end
    else if cmbParentela.ItemIndex in [4] then //Fratello-Sorella
    begin
      DButton.DataSet.FieldByName('NUMGRADO').AsString:='2';
      cmbTipoPar.ItemIndex:=0;
    end
    else if cmbParentela.ItemIndex in [5,6] then //Nipote
    begin
      DButton.DataSet.FieldByName('NUMGRADO').AsString:='2';
      cmbTipoPar.ItemIndex:=0;
    end;
    if (gpbCausali.Enabled) and (DButton.State = dsInsert) then
    begin
      if cmbParentela.ItemIndex = 2 then  //Figlio
        DButton.DataSet.FieldByName('CAUSALI_ABILITATE').AsString:=S031FFamiliariDtM.S031FFamiliariMW.GetCausaliFG
      else
        DButton.DataSet.FieldByName('CAUSALI_ABILITATE').Clear;
    end;
  end;
  AbilitaComponenti;
end;

procedure TS031FFamiliari.cmbParentelaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbParentelaCloseUp(nil);
end;

// TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
procedure TS031FFamiliari.SetAbilitazioneDateGravidanza;
var
  LAbilDato, LAbilPeriodoAdoz, LNotPaghe, LNotAdozione: Boolean;
begin
  inherited;

  LNotPaghe:=Parametri.Applicazione <> 'PAGHE';
  LNotAdozione:=cmbTipoAdoz.ItemIndex = -1;
  LAbilPeriodoAdoz:=cmbTipoAdoz.ItemIndex > 1;
  LAbilDato:=LNotPaghe and (LNotAdozione or LAbilPeriodoAdoz);

  // inizio teorico (in sola visualizzazione)
  lblGravInizioTeorico.Enabled:=False;
  dedtGravInizioTeorico.Enabled:=False;
  btnGravInizioTeorico.Enabled:=False;

  // inizio scelto dal dipendente
  lblGravInizioScelto.Enabled:=LNotPaghe;
  dedtGravInizioScelto.Enabled:=LAbilDato ;
  btnGravInizioScelto.Enabled:=(DButton.State in [dsEdit,dsInsert]) and LAbilDato;

  // inizio effettivo
  lblGravInizioEffettivo.Enabled:=LNotPaghe;
  dedtGravInizioEffettivo.Enabled:=LAbilDato;
  btnGravInizioEffettivo.Enabled:=(DButton.State in [dsEdit,dsInsert]) and LAbilDato;

  // fine
  lblGravFine.Enabled:=LNotPaghe;
  dedtGravFine.Enabled:=LAbilDato;
  btnGravFine.Enabled:=(DButton.State in [dsEdit,dsInsert]) and LAbilDato;
end;

procedure TS031FFamiliari.cmbTipoAdozClick(Sender: TObject);
begin
  SetAbilitazioneDateGravidanza;
end;

procedure TS031FFamiliari.cmbTipoAdozCloseUp(Sender: TObject);
begin
  SetAbilitazioneDateGravidanza;
end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

procedure TS031FFamiliari.cmbTipoDisabilitaCloseUp(Sender: TObject);
begin
  inherited;
  lblAnnoRevisione.Enabled:=cmbTipoDisabilita.ItemIndex = 0;
  dedtAnnoRevisione.Enabled:=cmbTipoDisabilita.ItemIndex = 0;
  btnAnnoRevisione.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (cmbTipoDisabilita.ItemIndex = 0);
  if not dedtAnnoRevisione.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    DButton.DataSet.FieldByName('ANNO_REVISIONE').Clear;
  if (cmbTipoDisabilita.ItemIndex = -1) and (DButton.State in [dsEdit,dsInsert]) then
  begin
    DButton.DataSet.FieldByName('ANNO_AVV').Clear;
    DButton.DataSet.FieldByName('ANNO_AVV_FAM').Clear;
    DButton.DataSet.FieldByName('ALTERNATIVA').Clear;
    cmbAlternativa.ItemIndex:=-1;
    cmbAlternativaCloseUp(nil);
  end;
end;

procedure TS031FFamiliari.cmbTipoDisabilitaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbTipoDisabilitaCloseUp(nil);
end;

procedure TS031FFamiliari.cmbTipoParKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
    (Sender as TComboBox).ItemIndex:=-1;
end;

procedure TS031FFamiliari.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdDatiBase,Sender = CopiaInExcel);
end;

procedure TS031FFamiliari.dedtREDDITOANFExit(Sender: TObject);
begin
  inherited;
  edtTotaleANF.Text:=FloatToStr(DButton.DataSet.FieldByName('REDDITO_ANF').AsFloat + DButton.DataSet.FieldByName('REDDITO_ALTRO_ANF').AsFloat);
end;

procedure TS031FFamiliari.dgrdDATIBASEDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:Integer;
begin
  inherited;
  if actVisioneCorrente.Checked then
    Exit;
  if gdFixed in State then exit;
  //Ciclo su tabella
  for i:=0 to High(ElencoNumOrd) do
    if (ElencoNumOrd[i].Colorata) and
       (ElencoNumOrd[i].NumOrd = DButton.DataSet.FieldByName('NUMORD').AsInteger) then
    begin
      if gdSelected in State then
      begin
        dgrdDATIBASE.Canvas.Brush.Color:=clHighLight;
        dgrdDATIBASE.Canvas.Font.Color:=clWhite;
      end
      else
      begin
        dgrdDATIBASE.Canvas.Brush.Color:=$00FFFF80;
        dgrdDATIBASE.Canvas.Font.Color:=clWindowText;
      end;
      dgrdDATIBASE.DefaultDrawColumnCell(Rect,DataCol,Column,State);
      Break;
    end;
end;

procedure TS031FFamiliari.CaricaElencoNumOrd;
var i:integer;
    Puntatore:TBookmark;
begin
  SetLength(ElencoNumOrd,0);
  with DButton.DataSet do
  begin
    DisableControls;
    Puntatore:=GetBookmark;
	{ TODO : TEST IW 15 }
	try
      First;
      i:=-1;
      while not Eof do
      begin
        if Length(ElencoNumOrd) = 0 then
        begin
          inc(i);
          SetLength(ElencoNumOrd,i + 1);
          ElencoNumOrd[i].NumOrd:=FieldByName('NUMORD').AsInteger;
          ElencoNumOrd[i].Colorata:=False;
        end
        else if (ElencoNumOrd[i].NumOrd <> FieldByName('NUMORD').AsInteger) then
        begin
          inc(i);
          SetLength(ElencoNumOrd,i + 1);
          ElencoNumOrd[i].NumOrd:=FieldByName('NUMORD').AsInteger;
          ElencoNumOrd[i].Colorata:=not ElencoNumOrd[i - 1].Colorata;
        end;
        Next;
      end;
      GotoBookmark(Puntatore);
	finally
      FreeBookmark(Puntatore);
	end;
    EnableControls;
  end;
end;

procedure TS031FFamiliari.drgpTIPO_DETRAZIONEClick(Sender: TObject);
begin
  inherited;
  dchkDetr100Affid.Visible:=(drgpTIPO_DETRAZIONE.ItemIndex = 2) and (DButton.DataSet.FieldByName('PERC_CARICO').AsFloat = 100);
  if not dchkDetr100Affid.Visible then
    dchkDetr100Affid.Checked:=False;
end;

procedure TS031FFamiliari.TAnnullaClick(Sender: TObject);
var tabCorrente:TTabSheet;
begin
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  Screen.Cursor:=crHourGlass;
  DButton.DataSet.DisableControls;
  try
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    tabCorrente:=PageControl1.ActivePage;
    inherited;
    PageControl1.ActivePage:=tabCorrente;
    actRefresh.Execute;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  finally
    DButton.DataSet.EnableControls;
    Screen.Cursor:=crDefault;
  end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TS031FFamiliari.TInserClick(Sender: TObject);
begin
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  Screen.Cursor:=crHourGlass;
  DButton.DataSet.DisableControls;
  try
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    inherited;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    DButton.DataSet.EnableControls;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    cmbParentela.SetFocus;
     // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    DButton.DataSet.DisableControls;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    cmbParentela.ItemIndex:=2;
    cmbParentelaCloseUp(nil);
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  finally
    DButton.DataSet.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TS031FFamiliari.TModifClick(Sender: TObject);
begin
  if Dbutton.DataSet.RecordCount <= 0 then
    TInserClick(nil)
  else
    inherited;
end;

procedure TS031FFamiliari.TRegisClick(Sender: TObject);
var tabCorrente:TTabSheet;
begin
  // forza il focus su un componente per far scattare gli eventi onchange / onexit / ecc...
  dedtDecorrenza.SetFocus;

  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  Screen.Cursor:=crHourGlass;
  DButton.DataSet.DisableControls;
  try
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    tabCorrente:=PageControl1.ActivePage;
    inherited;
    PageControl1.ActivePage:=tabCorrente;
    actRefresh.Execute;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  finally
    DButton.DataSet.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TS031FFamiliari.Visionecorrente1Click(Sender: TObject);
begin
  inherited;
  CaricaElencoNumOrd;
end;

procedure TS031FFamiliari.AllineaComponenti;
begin
  with S031FFamiliariDtM do
  begin
    cmbParentela.ItemIndex:=S031FFamiliariMW.cmbParentelaItemIndex;
    cmbTipoPar.ItemIndex:=S031FFamiliariMW.cmbTipoParentelaItemIndex;
    cmbMotivoTerzoGrado.ItemIndex:=S031FFamiliariMW.cmbMotivoTerzoGradoItemIndex;
    cmbTipoAdoz.ItemIndex:=S031FFamiliariMW.cmbTipoAdozItemIndex;
    cmbTipoDisabilita.ItemIndex:=S031FFamiliariMW.cmbTipoDisabilitaItemIndex;
    cmbNomePA.ItemIndex:=S031FFamiliariMW.cmbNomePAItemIndex;
    cmbNomePA.Text:=QSG101.FieldByName('NOME_PA').AsString;
    cmbDurataContratto.ItemIndex:=S031FFamiliariMW.cmbDurataContrattoItemIndex;
    cmbAlternativa.ItemIndex:=S031FFamiliariMW.cmbAlternativaItemIndex;
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=S031FFamiliariMW.cmbAlternativaMotivoTerzoGradoItemIndex;
    cmbAlternativaNomePA.ItemIndex:=S031FFamiliariMW.cmbAlternativaNomePAItemIndex;
    cmbAlternativaNomePA.Text:=QSG101.FieldByName('NOME_PA_ALT').AsString;
    TabNote.Highlighted:=QSG101.FieldByName('NOTE').AsString <> '';
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    cmbPartFruizMaternita.ItemIndex:=S031FFamiliariMW.cmbPartFruizMaternitaItemIndex;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
  end;
end;

procedure TS031FFamiliari.Annullatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDatiBase,'N');
end;

procedure TS031FFamiliari.AbilitaComponenti;
begin
(*
0 Nessuno/Sè stesso
1 Coniuge
2 Figlio/Figlia
3 Genitore
4 Fratello/Sorella
5 Nipote
6 Nipote equiparato Figlio
7 Altro
8 Affidato
*)
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  // evidenzia l'attesa per le abilitazioni
  Screen.Cursor:=crHourGlass;
  DButton.DataSet.DisableControls;
  try
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

    //--- Dati anagrafici
    cmbParentela.Enabled:=(DButton.State in [dsEdit,dsInsert]);
    lblTipoPar.Enabled:=(cmbParentela.ItemIndex in [7]);
    cmbTipoPar.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (cmbParentela.ItemIndex in [7]);
    lblNumGrado.Enabled:=(cmbParentela.ItemIndex in [5,6,7]);
    dedtNumGrado.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (cmbParentela.ItemIndex in [5,6,7]);
    dedtNumGradoChange(nil);
    dedtCognome.Enabled:=(Trim(dcmbMatricola.Text) = '');
    dedtNome.Enabled:=(Trim(dcmbMatricola.Text) = '');
    drgpSesso.Enabled:=(Trim(dcmbMatricola.Text) = '');
    dedtDataNas.Enabled:=(Trim(dcmbMatricola.Text) = '');

    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    lblDataNas.Enabled:=True;
    // consente l'indicazione di data presunta solo se TIPOPAR è
    //   - FG = Figlio/Figlia, oppure
    //   - NF = Nipote equiparato Figlio, oppure
    //   - AF = Affidato
    lblDataNasPresunta.Enabled:=(Parametri.Applicazione <> 'PAGHE');
    // dedtDataNasPresunta.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '');
    dedtDataNasPresunta.Enabled:=(Parametri.Applicazione <> 'PAGHE') and
                                 (Trim(dcmbMatricola.Text) = '') and
                                 (cmbParentela.ItemIndex in [2,6,8]);

    if (not dedtDataNasPresunta.Enabled) and
       (DButton.State in [dsEdit,dsInsert]) and
       (not dedtDataNasPresunta.Field.IsNull) then
    begin
      dedtDataNasPresunta.Field.Clear;
    end;

    // il checkbox "Registrazione evento data nascita" è visibile solo se la data di nascita presunta è abilitata
    chkRegDatanas.Visible:=dedtDataNasPresunta.Enabled;

    // effettua considerazioni sulla data di nascita in base al checkbox di registrazione
    if chkRegDatanas.Visible then
    begin
      // la data di nascita è abilitata solo se è indicata la registrazione
      dedtDataNas.Enabled:=dedtDataNas.Enabled and chkRegDatanas.Checked;
    end;
    dedtDataNas.Visible:=dedtDataNas.Enabled;
    edtDataNasDummy.Visible:=not dedtDataNas.Enabled;
    lblDataNas.Enabled:=dedtDataNas.Enabled;

    // fruizione particolare della maternità
    lblPartFruizMaternita.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    cmbPartFruizMaternita.Enabled:=lblPartFruizMaternita.Enabled;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

    lblDataAdoz.Enabled:=(Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    dedtDataAdoz.Enabled:=(Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    lblDataPreAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    dedtDataPreAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    btnDataPreAdoz.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    lblTipoAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    cmbTipoAdoz.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [2,8]);
    if (DButton.State in [dsEdit,dsInsert]) and (not dedtDataAdoz.Enabled) then
    begin
      dedtDataAdoz.Field.Clear;
      dedtDataPreAdoz.Field.Clear;
      cmbTipoAdoz.ItemIndex:=-1;
    end;
    S031FFamiliariDtM.QSG101DATAADOZChange(nil);
    dedtComNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
    dcmbComNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
    dedtCapNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
    dedtProvNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
    dedtCodFiscale.Enabled:=(Trim(dcmbMatricola.Text) = '');
    dedtDataSep.Enabled:=(Trim(dcmbMatricola.Text) = '') or (cmbParentela.ItemIndex <> 0); //Diverso da sè stesso
    btnDataSep.Enabled:=(DButton.State in [dsEdit,dsInsert]) and ((Trim(dcmbMatricola.Text) = '') or (cmbParentela.ItemIndex <> 0));
    lblDataMat.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = 1);
    dedtDataMat.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = 1);
    btnDataMat.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = 1);
    gpbCausali.Enabled:=Parametri.Applicazione <> 'PAGHE';
    if cmbParentela.ItemIndex = 0 then
      gpbCausali.Caption:='Causali fruibili per sè stesso'
    else
      gpbCausali.Caption:='Causali fruibili per questo familiare';

    //--- Legge 104
    tabLegge104.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblAnnoAvv.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = 0);   //Sè stesso
    dedtAnnoAvv.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = 0);   //Sè stesso
    lblAnnoAvvFam.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex <> 0);   //Diverso da sè stesso
    dedtAnnoAvvFam.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex <> 0);  //Diverso da sè stesso
    lblAnnoRevisione.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
    dedtAnnoRevisione.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
    btnAnnoRevisione.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
    lblTipoDisabilita.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbTipoDisabilita.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
    if cmbTipoDisabilita.Enabled then
      cmbTipoDisabilitaCloseUp(nil);
    gpbResidenza.Visible:=(Trim(dcmbMatricola.Text) = '');  //Diverso da Sè stesso e coniuge interno
    if gpbResidenza.Visible then
    begin
      lblIndirizzo.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtIndirizzo.Enabled:=Parametri.Applicazione <> 'PAGHE';
      lblComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dcmbComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
      lblCAP.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtCAP.Enabled:=Parametri.Applicazione <> 'PAGHE';
      lblProvincia.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtProvincia.Enabled:=Parametri.Applicazione <> 'PAGHE';
      lblTelefono.Enabled:=Parametri.Applicazione <> 'PAGHE';
      dedtTelefono.Enabled:=Parametri.Applicazione <> 'PAGHE';
    end;
    gpbFamiliare.Visible:=(Trim(dcmbMatricola.Text) = '');  //Diverso da Sè stesso e coniuge interno
    if gpbFamiliare.Visible then
    begin
      lblDurataContratto.Enabled:=Parametri.Applicazione <> 'PAGHE';
      cmbDurataContratto.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
      lblNomePA.Enabled:=Parametri.Applicazione <> 'PAGHE';
      cmbNomePA.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
      if cmbNomePA.Enabled then
      begin
        CaricaNomePA(cmbNomePA);
        cmbNomePAChange(nil);
      end;
    end
    else if (DButton.State in [dsEdit,dsInsert]) then
    begin
      cmbNomePA.ItemIndex:=-1;
      cmbNomePA.Text:='';
      cmbDurataContratto.ItemIndex:=-1;
    end;
    gpbAlternativa.Visible:=(cmbParentela.ItemIndex = 2); //Figlio
    if gpbAlternativa.Visible then
    begin
      lblAlternativaMotivoTerzoGrado.Enabled:=Parametri.Applicazione <> 'PAGHE';
      cmbAlternativaMotivoTerzoGrado.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
      lblAlternativaNomePA.Enabled:=Parametri.Applicazione <> 'PAGHE';
      cmbAlternativaNomePA.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
      lblAlternativa.Enabled:=Parametri.Applicazione <> 'PAGHE';
      cmbAlternativa.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
      if cmbAlternativa.Enabled then
      begin
        CaricaNomePA(cmbAlternativaNomePA);
        cmbAlternativaCloseUp(nil);
      end;
    end
    else if (DButton.State in [dsEdit,dsInsert]) then
    begin
      cmbAlternativa.ItemIndex:=-1;
      cmbAlternativaMotivoTerzoGrado.ItemIndex:=-1;
      cmbAlternativaNomePA.ItemIndex:=-1;
      cmbAlternativaNomePA.Text:='';
    end;

    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
    SetAbilitazioneDateGravidanza;
    // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine

    //--- Dati stipendiali - Abilitati per chi ha le paghe solo dall'applicativo paghe, altrimenti sempre
    tabDatiStipendiali.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    lblDATA_ULT_FAM_CAR.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dedtDATA_ULT_FAM_CAR.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    btnDATA_ULT_FAM_CAR.Enabled:=(DButton.State in [dsEdit,dsInsert]) and ((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    drgpTipo_Detrazione.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    lblPerc_Carico.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dedtPerc_Carico.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dchkDetrFiglioHandicap.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dchkDetr100Affid.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dchkANF.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dchkANFSpeciale.Visible:=cmbParentela.ItemIndex = 2;  //Studente/apprendista
    dchkANFSpeciale.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dchkANFInabile.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    lblRedditoANF.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dedtRedditoANF.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    lblRedditoAltroANF.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    dedtRedditoAltroANF.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    lblTotaleANF.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    edtTotaleANF.Enabled:=((Parametri.V430 = 'P430') and (Parametri.Applicazione = 'PAGHE')) or (Parametri.V430 <> 'P430');
    drgpTIPO_DETRAZIONEClick(nil);
    dedtREDDITOANFExit(nil);

    //--- BtnCarica
    with S031FFamiliariDtM.S031FFamiliariMW.selGradoPar do
    begin
      SetVariable('PROGRESSIVO',C700Progressivo);
      SetVariable('NUM',-1);
      Execute;
      btnCarica.Visible:=(StrToIntDef(VarToStr(Field(0)),0) <= 0) and (not SolaLettura);
    end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  finally
    DButton.DataSet.EnableControls;
    Screen.Cursor:=crDefault;
  end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

procedure TS031FFamiliari.CaricaNomePA(Combo:TComboBox);
begin
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  Screen.Cursor:=crHourGlass;
  try
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
    Combo.Items.Clear;
    with S031FFamiliariDtM.S031FFamiliariMW.selNomePA do
    begin
      Close;
      SetVariable('DATO','NOME_PA');
      Open;
      First;
      while not Eof do
      begin
        Combo.Items.Add(FieldByName('NOME_PA').AsString);
        Next;
      end;
      Close;
      SetVariable('DATO','NOME_PA_ALT');
      Open;
      First;
      while not Eof do
      begin
        if R180IndexOf(Combo.Items,FieldByName('NOME_PA_ALT').AsString,100) < 0 then
          Combo.Items.Add(FieldByName('NOME_PA_ALT').AsString);
        Next;
      end;
    end;
  // TORINO_CSI - commessa 2015/142 SVILUPPO#7.ini
  finally
    Screen.Cursor:=crDefault;
  end;
// TORINO_CSI - commessa 2015/142 SVILUPPO#7.fine
end;

end.
