unit A008UProfili;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ActnList, ToolWin, ComCtrls, Menus, DBCtrls, StdCtrls, Oracle, OracleData,
  Buttons, Grids, DBGrids, ExtCtrls, A000UCostanti, A000USessione,A000UInterfaccia, A003UDataLavoroBis,
  C013UCheckList, C180FunzioniGenerali, C600USelAnagrafe, R500Lin,A000UMessaggi,
  DB, CheckLst, Variants,Mask, SelAnagrafe, System.Actions, System.UITypes,
  System.ImageList, B007UManipolazioneDati;

type
  TA008FProfili = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    actEsci: TAction;
    actNuovoProfilo: TAction;
    actModificaProfilo: TAction;
    actCancellaProfilo: TAction;
    actConferma: TAction;
    actAnnulla: TAction;
    ImageList1: TImageList;
    Esci1: TMenuItem;
    Strumenti1: TMenuItem;
    Nuovoprofilo1: TMenuItem;
    Cancellaprofilo1: TMenuItem;
    Esci2: TMenuItem;
    Conferma1: TMenuItem;
    Annulla1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    actCopiaSu: TAction;
    Copiasu1: TMenuItem;
    ToolButton7: TToolButton;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    AbilitazioniS1: TMenuItem;
    AbilitazioniN1: TMenuItem;
    AbilitazioniR1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    cmbSelAzin: TComboBox;
    ToolButton8: TToolButton;
    lblAzienda: TLabel;
    PageControl1: TPageControl;
    tabPermessi: TTabSheet;
    dlstPermessi: TDBLookupListBox;
    PageControl2: TPageControl;
    tabPermessiBase: TTabSheet;
    Label8: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    DBCheckBox12: TDBCheckBox;
    DBCheckBox13: TDBCheckBox;
    DBLookupComboBox1: TDBLookupComboBox;
    DBCheckBox23: TDBCheckBox;
    DBRadioGroup3: TDBRadioGroup;
    dchkEliminaStorici: TDBCheckBox;
    GroupBox1: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    DBCheckBox22: TDBCheckBox;
    GroupBox2: TGroupBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox11: TDBCheckBox;
    GroupBox5: TGroupBox;
    DBCheckBox20: TDBCheckBox;
    DBCheckBox19: TDBCheckBox;
    DBCheckBox21: TDBCheckBox;
    DBCheckBox17: TDBCheckBox;
    dedtDatiC700: TDBEdit;
    btnDatiC700: TButton;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox14: TDBCheckBox;
    DBCheckBox16: TDBCheckBox;
    dChkModificaDatiProtetti: TDBCheckBox;
    drgpC700SalvaSelezioni: TDBRadioGroup;
    tabPermessiAccessori: TTabSheet;
    Label6: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup2: TDBRadioGroup;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    DBCheckBox25: TDBCheckBox;
    DBCheckBox26: TDBCheckBox;
    DBComboBox1: TDBComboBox;
    DEdtAnticipi: TDBEdit;
    BtnAnticipi: TButton;
    DBCheckBox24: TDBCheckBox;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    btnWEBCartelliniDataMin: TSpeedButton;
    dedtWebCartelliniChiusi: TDBCheckBox;
    dedtWebCartelliniDataMin: TDBEdit;
    dedtWebCartelliniMMPrec: TDBEdit;
    dedtWebCartelliniMMSucc: TDBEdit;
    GroupBox7: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    btnWEBCedoliniDataMin: TSpeedButton;
    dedtWebCedoliniDataMin: TDBEdit;
    dedtWebCedoliniMMPrec: TDBEdit;
    dedtWebCartelliniGGEmiss: TDBEdit;
    tabFiltroAnagrafe: TTabSheet;
    dlstFiltroAnagrafe: TDBLookupListBox;
    Panel1: TPanel;
    memoFiltroAnagrafe: TMemo;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    tabFiltroFunzioni: TTabSheet;
    dlstFiltroFunzioni: TDBLookupListBox;
    Panel3: TPanel;
    ScrollBox2: TScrollBox;
    Label3: TLabel;
    chkSelezioneMultipla: TCheckBox;
    DBGrid2: TDBGrid;
    tabFiltroDizionario: TTabSheet;
    dlstFiltroDizionario: TDBLookupListBox;
    Panel4: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    cmbDizionario: TComboBox;
    rgpDizionario: TRadioGroup;
    lstDizionario: TCheckListBox;
    tabIterAutorizzativi: TTabSheet;
    dlstIterAutorizzativi: TDBLookupListBox;
    Panel6: TPanel;
    Panel7: TPanel;
    Label2: TLabel;
    cmbCodiceIter: TComboBox;
    dGridIterAutorizzativi: TDBGrid;
    chkCancTimbOrig: TDBCheckBox;
    GroupBox8: TGroupBox;
    lblStatiAvanzamentoVal: TLabel;
    dchkSupervisoreValut: TDBCheckBox;
    dchkModValutatore: TDBCheckBox;
    dedtStatiAvanzamentoVal: TDBEdit;
    btnStatiAvanzamentoVal: TButton;
    btnAnteprima: TBitBtn;
    splFAnag: TSplitter;
    dGridFAnag: TDBGrid;
    dchkWebCedoliniFilePDF: TDBCheckBox;
    dchkWebRichiestaConsegnaCed: TDBCheckBox;
    dchkWebRichiestaConsegnaVal: TDBCheckBox;
    popmnuFiltroanagrafe: TPopupMenu;
    Copiainexcel1: TMenuItem;
    dchkValidaStato: TDBCheckBox;
    dchkWebNotificaAnomalie: TDBCheckBox;
    N1: TMenuItem;
    mnuRegoleAccessoIP: TMenuItem;
    procedure BtnAnticipiClick(Sender: TObject);
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actEsciExecute(Sender: TObject);
    procedure actNuovoProfiloExecute(Sender: TObject);
    procedure actCancellaProfiloExecute(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
    procedure actModificaProfiloExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRefreshClick(Sender: TObject);
    procedure memoFiltroAnagrafeDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure AbilitazioniR1Click(Sender: TObject);
    procedure cmbDizionarioChange(Sender: TObject);
    procedure chkSelezioneMultiplaClick(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure cmbSelAzinChange(Sender: TObject);
    procedure btnDatiC700Click(Sender: TObject);
    procedure btnWEBCartelliniDataMinClick(Sender: TObject);
    procedure btnWEBCedoliniDataMinClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cmbCodiceIterChange(Sender: TObject);
    procedure cmbCodiceIterDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnStatiAvanzamentoValClick(Sender: TObject);
    procedure Copiainexcel1Click(Sender: TObject);
    procedure popmnuFiltroanagrafePopup(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure mnuRegoleAccessoIPClick(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaCmbIter;
    procedure AbilitaAzioni(Azione:TAction);
  public
    { Public declarations }
    selCorrente,selCorrenteDist:TOracleDataSet;
    insCorrente:TOracleQuery;
    lstNomeCampo:TStringList;
    procedure EspandiGridFAnagrafe(Espandi:Boolean);
  end;

var
  A008FProfili: TA008FProfili;

implementation

uses
  A008UOperatoriDtM1,
  A008UListaGriglia,
  A008URegoleAccessoIP;

{$R *.DFM}

procedure TA008FProfili.FormCreate(Sender: TObject);
var T:TTabelleDizionario;
begin
  PageControl1.ActivePage:=tabPermessi;
  lstNomeCampo:=TStringList.Create;
  cmbDizionario.Items.Clear;
  for T in TabelleDizionario do
    cmbDizionario.Items.Add(T.DescTabella);
  //tabIterAutorizzativi.TabVisible:=ITER_ATTIVO = 'S';
end;

procedure TA008FProfili.CaricaCmbIter;
var i:Integer;
begin
  cmbCodiceIter.Items.Clear;
  cmbCodiceIter.Items.Add('');
  for i:=0 to High(A000IterAutorizzativi) do
    cmbCodiceIter.Items.Add(A000IterAutorizzativi[i].Cod);
  cmbCodiceIter.ItemIndex:=0;
end;

procedure TA008FProfili.FormShow(Sender: TObject);
{Inizializzazioni delle pagine}
var S:String;
begin
  tabPermessi.TabVisible:=A000GetInibizioni('Tag','85') <> 'N';
  tabFiltroAnagrafe.TabVisible:=A000GetInibizioni('Tag','86') <> 'N';
  tabFiltroFunzioni.TabVisible:=A000GetInibizioni('Tag','87') <> 'N';
  tabFiltroDizionario.TabVisible:=A000GetInibizioni('Tag','88') <> 'N';
  //tabIterAutorizzativi.TabVisible:=A000GetInibizioni('Tag','82') <> 'N';
  tabPermessi.Visible:=tabPermessi.TabVisible;
  tabFiltroAnagrafe.Visible:=tabFiltroAnagrafe.TabVisible;
  tabFiltroFunzioni.Visible:=tabFiltroFunzioni.TabVisible;
  tabFiltroDizionario.Visible:=tabFiltroDizionario.TabVisible;
  tabIterAutorizzativi.Visible:=tabIterAutorizzativi.TabVisible;

  PageControl2.ActivePage:=tabPermessiBase;
  PageControl1Change(nil);
  AbilitaAzioni(actConferma);
  A008FOperatoriDtM1.selI072DistAfterScroll(nil);
  cmbDizionario.ItemIndex:=0;
  rgpDizionario.ItemIndex:=0;
  cmbDizionarioChange(nil);
  //lblNomeCampo.Caption:='Colonne di ' + A008FOperatoriDtM1.QI070.FieldByName('AZIENDA').AsString;
  with A008FOperatoriDtM1 do
  begin
    S:=QI090.FieldByName('AZIENDA').AsString;
    cmbSelAzin.Items.Clear;
    //cmbSelAzin.Text:=QI090.FieldByName('AZIENDA').AsString;
    QI090.AfterScroll:=nil;
    try
      QI090.First;
      while not QI090.Eof do
      begin
        if (Parametri.Azienda = 'AZIN') or (Parametri.Azienda = QI090.FieldByName('AZIENDA').AsString) then
          cmbSelAzin.Items.Add(QI090.FieldByName('AZIENDA').AsString);
        QI090.Next;
      end;
      QI090.SearchRecord('AZIENDA',S,[srFromBeginning]);
    finally
      QI090.AfterScroll:=QI090AfterScroll;
    end;
    CaricaCmbIter;
    testFiltroAnagrafe.Session:=DbIris008B;
  end;
  EspandiGridFAnagrafe(False);
  cmbSelAzin.ItemIndex:=cmbSelAzin.Items.IndexOf(S);
  C600frmSelAnagrafe.CreaSelAnagrafe(A008FOperatoriDtM1.DbIris008B,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False
end;

procedure TA008FProfili.AbilitaAzioni(Azione:TAction);
{Abilitazione azioni di Inserimento, Cancellazione, Modifica, Conferma, Annulla}
begin
  actEsci.Enabled:=(Azione = actConferma) or (Azione = actAnnulla);
  actNuovoProfilo.Enabled:=((Azione = actConferma) or (Azione = actAnnulla)) and (not SolaLettura);
  actCopiaSu.Enabled:=((Azione = actConferma) or (Azione = actAnnulla)) and (not SolaLettura);
  actCancellaProfilo.Enabled:=((Azione = actConferma) or (Azione = actAnnulla)) and (not SolaLettura);
  actModificaProfilo.Enabled:=((Azione = actConferma) or (Azione = actAnnulla)) and (not SolaLettura);
  actConferma.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  actAnnulla.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  //btnEspressione.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  C600frmSelAnagrafe.btnSelezione.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  //cmbNomeCampo.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  //cmbOperatori.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  //cmbValori.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  //btnRefresh.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  chkSelezioneMultipla.Enabled:=not((Azione = actConferma) or (Azione = actAnnulla));
  BtnAnticipi.Enabled:=Not((Azione = actConferma) or (Azione = actAnnulla));
  btnDatiC700.Enabled:=Not((Azione = actConferma) or (Azione = actAnnulla));
  btnStatiAvanzamentoVal.Enabled:=Not((Azione = actConferma) or (Azione = actAnnulla));
  btnWEBCartelliniDataMin.Enabled:=Not((Azione = actConferma) or (Azione = actAnnulla));
  btnWEBCedoliniDataMin.Enabled:=Not((Azione = actConferma) or (Azione = actAnnulla));
  if not chkSelezioneMultipla.Enabled then
    chkSelezioneMultipla.Checked:=False;
  A008FOperatoriDtM1.BrowseProfili:=(Azione = actConferma) or (Azione = actAnnulla);
end;

procedure TA008FProfili.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=A008FOperatoriDtM1.BrowseProfili;
end;

procedure TA008FProfili.popmnuFiltroanagrafePopup(Sender: TObject);
begin
  CopiaInExcel1.Enabled:=dGridFAnag.DataSource.DataSet.Active;
end;

procedure TA008FProfili.PopupMenu1Popup(Sender: TObject);
var
  LTag: Integer;
begin
  if Sender = nil then
    Exit;

  try
    LTag:=((Sender as TPopupMenu).PopupComponent as TDBGrid).DataSource.DataSet.FieldByName('TAG').AsInteger;
  except
    LTag:=-1;
  end;
  mnuRegoleAccessoIP.Enabled:=LTag = 100075;
end;

procedure TA008FProfili.btnWEBCartelliniDataMinClick(Sender: TObject);
begin
  with A008FOperatoriDtM1.selI071 do
    FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime:=R180InizioMese(DataOut(FieldByName('WEB_CARTELLINI_DATAMIN').AsDateTime,'','M'));
end;

procedure TA008FProfili.btnWEBCedoliniDataMinClick(Sender: TObject);
begin
  with A008FOperatoriDtM1.selI071 do
    FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime:=R180InizioMese(DataOut(FieldByName('WEB_CEDOLINI_DATAMIN').AsDateTime,'','M'));
end;

procedure TA008FProfili.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
begin
  if memoFiltroAnagrafe.ReadOnly then
    exit;
  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    memoFiltroAnagrafe.Lines.Add(S);
  end;
end;

procedure TA008FProfili.PageControl1Change(Sender: TObject);
{Settaggio della pagina attiva}
begin
  with A008FOperatoriDtM1 do
  begin
    if PageControl1.ActivePage = tabPermessi then
    begin
      SolaLettura:=A000GetInibizioni('Tag','85') = 'R';
      selCorrente:=selI071;
      selCorrenteDist:=selI071;
      insCorrente:=insI071;
      dlstPermessi.KeyValue:=selCorrenteDist.FieldByName('PROFILO').AsString;
    end
    else if PageControl1.ActivePage = tabFiltroAnagrafe then
    begin
      SolaLettura:=A000GetInibizioni('Tag','86') = 'R';
      selCorrente:=selI072;
      selCorrenteDist:=selI072Dist;
      insCorrente:=insI072;
      dlstFiltroAnagrafe.KeyValue:=selCorrenteDist.FieldByName('PROFILO').AsString;
    end
    else if PageControl1.ActivePage = tabFiltroFunzioni then
    begin
      SolaLettura:=A000GetInibizioni('Tag','87') = 'R';
      selCorrente:=selI073;
      selCorrenteDist:=selI073Dist;
      insCorrente:=insI073;
      dlstFiltroFunzioni.KeyValue:=selCorrenteDist.FieldByName('PROFILO').AsString;
      // filtro funzioni - visibilità colonna Accesso_Browse
      DBGrid2.Columns[3].Visible:=(Parametri.ModuloInstallato['IRIS_CLOUD']);
    end
    else if PageControl1.ActivePage = tabFiltroDizionario then
    begin
      SolaLettura:=A000GetInibizioni('Tag','88') = 'R';
      selCorrente:=selI074;
      selCorrenteDist:=selI074Dist;
      insCorrente:=insI074;
      dlstFiltroDizionario.KeyValue:=selCorrenteDist.FieldByName('PROFILO').AsString;
    end
    else if PageControl1.ActivePage = tabIterAutorizzativi then
    begin
      SolaLettura:=A000GetInibizioni('Tag','82') = 'R';
      selCorrente:=selI075;
      selCorrenteDist:=selI075Dist;
      insCorrente:=insI075;
      dlstIterAutorizzativi.KeyValue:=selCorrenteDist.FieldByName('PROFILO').AsString;
    end;
  end;
  StatusBar1.SimpleText:=Format('%d Records',[selCorrenteDist.RecordCount]);
  SolaLettura:=SolaLettura or (not PageControl1.ActivePage.TabVisible);
  AbilitaAzioni(actAnnulla);
  StatusBar1.SimpleText:=Format('%d Records',[selCorrenteDist.RecordCount]);
end;

procedure TA008FProfili.actNuovoProfiloExecute(Sender: TObject);
{Iserimento nuovo profilo}
var Profilo:String;
begin
  if PageControl1.ActivePage = tabPermessi then
    if InputQuery('Profilo dei Permessi','Profilo:',Profilo) then
    begin
      selCorrente.Append;
      selCorrente.FieldByName('AZIENDA').AsString:=A008FOperatoriDtM1.AziendaCorrente;
      selCorrente.FieldByName('PROFILO').AsString:=Profilo;
      selCorrente.Post;
      dlstPermessi.KeyValue:=Profilo;
    end;
  if PageControl1.ActivePage = tabFiltroAnagrafe then
    if InputQuery('Profilo dei Filtri Anagrafici','Profilo:',Profilo) then
    begin
      if VarToStr(A008FOperatoriDtM1.selI072Dist.Lookup('PROFILO',Profilo,'PROFILO')) = '' then
      begin
        selCorrente.Append;
        selCorrente.FieldByName('AZIENDA').AsString:=A008FOperatoriDtM1.AziendaCorrente;
        selCorrente.FieldByName('PROFILO').AsString:=Profilo;
        selCorrente.FieldByName('PROGRESSIVO').AsInteger:=0;
        selCorrente.Post;
        selCorrenteDist.Refresh;
        selCorrenteDist.SearchRecord('Profilo',Profilo,[srFromBeginning]);
        dlstFiltroAnagrafe.KeyValue:=Profilo;
      end
      else
        R180MessageBox('Profilo anagrafe già inserito','ERRORE');
    end;
  if PageControl1.ActivePage = tabFiltroFunzioni then
    if InputQuery('Profilo dei Filtri delle Funzioni','Profilo:',Profilo) then
    begin
      A008FOperatoriDtM1.CreaFiltroFunzioni(A008FOperatoriDtM1.AziendaCorrente,Profilo);
      selCorrenteDist.Refresh;
      selCorrenteDist.SearchRecord('Profilo',Profilo,[srFromBeginning]);
      dlstFiltroFunzioni.KeyValue:=Profilo;
    end;
  if PageControl1.ActivePage = tabFiltroDizionario then
    if InputQuery('Profilo dei Filtri dei Dizionari','Profilo:',Profilo) then
    begin
      selCorrente.Append;
      selCorrente.FieldByName('AZIENDA').AsString:=A008FOperatoriDtM1.AziendaCorrente;
      selCorrente.FieldByName('PROFILO').AsString:=Profilo;
      selCorrente.FieldByName('TABELLA').AsString:='DIZIONARIO';
      selCorrente.FieldByName('CODICE').AsString:='DIZIONARIO';
      selCorrente.Post;
      selCorrenteDist.Refresh;
      selCorrenteDist.SearchRecord('Profilo',Profilo,[srFromBeginning]);
      dlstFiltroDizionario.KeyValue:=Profilo;
    end;
  if PageControl1.ActivePage = tabIterAutorizzativi then
    if InputQuery('Iter autorizzativi','Iter:',Profilo) then
    begin
      insCorrente.SetVariable('AZIENDA',A008FOperatoriDtM1.AziendaCorrente);
      insCorrente.SetVariable('PROFILO',Profilo);
      insCorrente.SetVariable('ITER',null);
      insCorrente.SetVariable('COD_ITER',null);
      insCorrente.Execute;
      SessioneOracle.Commit;
      selCorrenteDist.Refresh;
      selCorrenteDist.SearchRecord('Profilo',Profilo,[srFromBeginning]);
      dlstFiltroDizionario.KeyValue:=Profilo;
    end;
  StatusBar1.SimpleText:=Format('%d Records',[selCorrenteDist.RecordCount]);
end;

procedure TA008FProfili.actCancellaProfiloExecute(Sender: TObject);
{Eliminazione di un profilo}
var OQ:TOracleQuery;
begin
  if MessageDlg('Cancellare il profilo selezionato?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  with A008FOperatoriDtM1 do
  begin
    OQ:=nil;
    if PageControl1.ActivePage = tabPermessi then
      OQ:=selPermessi
    else if PageControl1.ActivePage = tabFiltroAnagrafe then
      OQ:=selFiltroAnagrafe
    else if PageControl1.ActivePage = tabFiltroFunzioni then
      OQ:=selFiltroFunzioni
    else if PageControl1.ActivePage = tabFiltroDizionario then
      OQ:=selFiltroDizionario
    else if PageControl1.ActivePage = tabIterAutorizzativi then
      OQ:=selIterAutorizzativi;
    OQ.SetVariable('AZIENDA',SelCorrente.FieldByName('AZIENDA').AsString);
    OQ.SetVariable('PROFILO',SelCorrente.FieldByName('PROFILO').AsString);
    OQ.Execute;
    if OQ.RowCount > 0 then
      //if A008FOperatoriDtM1.QI070.SearchRecord('AZIENDA;' + S,VarArrayOf([SelCorrente.FieldByName('AZIENDA').AsString,SelCorrente.FieldByName('PROFILO').AsString]),[srFromBeginning]) then
      raise Exception.Create('Profilo utilizzato! Impossibile eliminarlo!');
  end;
  if PageControl1.ActivePage = tabPermessi then
    A008FOperatoriDtM1.selI071.Delete
  else if PageControl1.ActivePage = tabFiltroFunzioni then
  begin
    selCorrente.DisableControls;
    A008FOperatoriDtM1.delI073.SetVariable('AZIENDA',SelCorrente.FieldByName('AZIENDA').AsString);
    A008FOperatoriDtM1.delI073.SetVariable('PROFILO',SelCorrente.FieldByName('PROFILO').AsString);
    A008FOperatoriDtM1.delI073.Execute;
    selCorrente.Session.Commit;
    selCorrente.EnableControls;
    selCorrenteDist.Refresh;
  end
  else if (PageControl1.ActivePage = tabFiltroAnagrafe) or
          (PageControl1.ActivePage = tabFiltroDizionario) then
  begin
    selCorrente.DisableControls;
    selCorrente.First;
    if selCorrente.RecordCount > 0 then
    begin
      RegistraLog.SettaProprieta('C',IfThen(PageControl1.ActivePage = tabFiltroAnagrafe,'I072_FILTROANAGRAFE','I074_FILTRODIZIONARIO'),'A008',nil,True);
      RegistraLog.InserisciDato('PROFILO',selCorrente.FieldByName('PROFILO').AsString,'');
      RegistraLog.RegistraOperazione;
    end;
    while not selCorrente.Eof do
      selCorrente.Delete;
    selCorrente.Session.Commit;
    selCorrente.EnableControls;
    selCorrenteDist.Refresh;
  end
  else if (PageControl1.ActivePage = tabIterAutorizzativi) then
    with A008FOperatoriDtM1 do
    begin
      delI075.SetVariable('AZIENDA',SelCorrente.FieldByName('AZIENDA').AsString);
      delI075.SetVariable('PROFILO',SelCorrente.FieldByName('PROFILO').AsString);
      delI075.Execute;
      selCorrente.Session.Commit;
      selCorrente.EnableControls;
      selCorrenteDist.Refresh;
    end;
  if PageControl1.ActivePage = tabPermessi then
    dlstPermessi.KeyValue:=null
  else if PageControl1.ActivePage = tabFiltroAnagrafe then
    dlstFiltroAnagrafe.KeyValue:=null
  else if PageControl1.ActivePage = tabFiltroFunzioni then
    dlstFiltroFunzioni.KeyValue:=null
  else if PageControl1.ActivePage = tabFiltroDizionario then
    dlstFiltroDizionario.KeyValue:=null
  else if PageControl1.ActivePage = tabIterAutorizzativi then
    dlstIterAutorizzativi.KeyValue:=null;
  StatusBar1.SimpleText:=Format('%d Records',[selCorrenteDist.RecordCount]);
end;

procedure TA008FProfili.actCopiaSuExecute(Sender: TObject);
{Duplicazione di un profilo esistente}
var Profilo:String;
begin
  if selCorrente.RecordCount = 0 then exit;
  if PageControl1.ActivePage = tabPermessi then
    if InputQuery('Copia profilo Permessi','Profilo:',Profilo) then
    begin
      insCorrente.SetVariable(':AZIENDA',A008FOperatoriDtM1.AziendaCorrente);
      insCorrente.SetVariable(':OLD_PROFILO',selCorrente.FieldByName('PROFILO').AsString);
      insCorrente.SetVariable(':NEW_PROFILO',Profilo);
      insCorrente.Execute;
      insCorrente.Session.Commit;
      selCorrente.Refresh;
      selCorrenteDist.Refresh;
      selCorrente.SearchRecord('PROFILO',Profilo,[srFromBeginning]);
      dlstPermessi.KeyValue:=Profilo;
    end;
  if PageControl1.ActivePage = tabFiltroAnagrafe then
    if InputQuery('Copia profilo Filtro Anagrafe','Profilo:',Profilo) then
    begin
      insCorrente.SetVariable(':AZIENDA',A008FOperatoriDtM1.AziendaCorrente);
      insCorrente.SetVariable(':OLD_PROFILO',selCorrente.FieldByName('PROFILO').AsString);
      insCorrente.SetVariable(':NEW_PROFILO',Profilo);
      insCorrente.Execute;
      RegistraLog.SettaProprieta('I','I072_FILTROANAGRAFE','A008',nil,True);
      RegistraLog.InserisciDato('PROFILO','',Profilo);
      RegistraLog.RegistraOperazione;
      insCorrente.Session.Commit;
      selCorrente.Refresh;
      selCorrenteDist.Refresh;
      selCorrente.SearchRecord('PROFILO',Profilo,[srFromBeginning]);
      dlstFiltroAnagrafe.KeyValue:=Profilo;
    end;
  if PageControl1.ActivePage = tabFiltroFunzioni then
    if InputQuery('Copia profilo Filtro Funzioni','Profilo:',Profilo) then
    begin
      insCorrente.SetVariable(':AZIENDA',A008FOperatoriDtM1.AziendaCorrente);
      insCorrente.SetVariable(':OLD_PROFILO',selCorrente.FieldByName('PROFILO').AsString);
      insCorrente.SetVariable(':NEW_PROFILO',Profilo);
      insCorrente.Execute;
      insCorrente.Session.Commit;
      selCorrente.Refresh;
      selCorrenteDist.Refresh;
      selCorrente.SearchRecord('PROFILO',Profilo,[srFromBeginning]);
      dlstFiltroFunzioni.KeyValue:=Profilo;
    end;
  if PageControl1.ActivePage = tabFiltroDizionario then
    if InputQuery('Copia profilo Filtro Dizionario','Profilo:',Profilo) then
    begin
      insCorrente.SetVariable(':AZIENDA',A008FOperatoriDtM1.AziendaCorrente);
      insCorrente.SetVariable(':OLD_PROFILO',selCorrente.FieldByName('PROFILO').AsString);
      insCorrente.SetVariable(':NEW_PROFILO',Profilo);
      insCorrente.Execute;
      insCorrente.Session.Commit;
      selCorrente.Refresh;
      selCorrenteDist.Refresh;
      selCorrente.SearchRecord('PROFILO',Profilo,[srFromBeginning]);
      dlstFiltroDizionario.KeyValue:=Profilo;
    end;
  if PageControl1.ActivePage = tabIterAutorizzativi then
    if InputQuery('Copia Iter Autorizzativo','Profilo:',Profilo) then
    begin
      with A008FOperatoriDtm1 do
      begin
        insI075_2.SetVariable(':AZIENDA',A008FOperatoriDtM1.AziendaCorrente);
        insI075_2.SetVariable(':OLD_PROFILO',selCorrente.FieldByName('PROFILO').AsString);
        insI075_2.SetVariable(':NEW_PROFILO',Profilo);
        insI075_2.Execute;
        insI075_2.Session.Commit;
      end;
      selCorrente.Refresh;
      selCorrenteDist.Refresh;
      selCorrente.SearchRecord('PROFILO',Profilo,[srFromBeginning]);
      dlstIterAutorizzativi.KeyValue:=Profilo;
    end;
  StatusBar1.SimpleText:=Format('%d Records',[selCorrenteDist.RecordCount]);
end;

procedure TA008FProfili.actModificaProfiloExecute(Sender: TObject);
{Apertura delle modifiche}
begin
  if selCorrenteDist.RecordCount = 0 then exit;
  if PageControl1.ActivePage = tabPermessi then
    selCorrente.Edit
  else if PageControl1.ActivePage = tabFiltroAnagrafe then
    memoFiltroAnagrafe.ReadOnly:=False
  else if PageControl1.ActivePage = tabFiltroFunzioni then
    selCorrente.ReadOnly:=False
  else if PageControl1.ActivePage = tabFiltroDizionario then
  begin
    cmbDizionario.Enabled:=False;
    lstDizionario.Enabled:=True;
    rgpDizionario.Enabled:=True;
  end
  else if PageControl1.ActivePage = tabIterAutorizzativi then
  begin
    selCorrente.ReadOnly:=False;
    cmbCodiceIter.Enabled:=False;
  end;
  AbilitaAzioni(actModificaProfilo);
end;

procedure TA008FProfili.actConfermaExecute(Sender: TObject);
{Conferma delle modifiche}
begin
  if PageControl1.ActivePage = tabPermessi then
    selCorrente.Post
  else if PageControl1.ActivePage = tabFiltroAnagrafe then
  begin
    // verifica filtro anagrafe.ini
    try
      SpeedButton1Click(nil);
    except
      on E:Exception do
      begin
        R180MessageBox(Format(A000MSG_A183_ERR_FMT_FILTRO,[E.Message]) ,ESCLAMA);
        Abort;
      end;
    end;
    // verifica filtro anagrafe.fine
    A008FOperatoriDtM1.PutFiltroAnagrafe;
    memoFiltroAnagrafe.ReadOnly:=True;
  end
  else if (PageControl1.ActivePage = tabFiltroFunzioni) or
          (PageControl1.ActivePage = tabIterAutorizzativi) then
  begin
    if selCorrente.State = dsEdit then
      selCorrente.Post;
    selCorrente.ReadOnly:=True;
    cmbCodiceIter.Enabled:=True;
    if PageControl1.ActivePage = tabIterAutorizzativi then
    begin
      SessioneOracle.ApplyUpdates([selCorrente],True);
      selCorrente.Refresh;
    end;
  end
  else if PageControl1.ActivePage = tabFiltroDizionario then
  begin
    A008FOperatoriDtM1.PutFiltroDizionario;
    cmbDizionario.Enabled:=True;
    lstDizionario.Enabled:=False;
    rgpDizionario.Enabled:=False;
  end;
  SessioneOracle.Commit;
  AbilitaAzioni(actConferma);
end;

procedure TA008FProfili.actAnnullaExecute(Sender: TObject);
{Annullamento delle modifiche}
begin
  if PageControl1.ActivePage = tabPermessi then
   selCorrente.Cancel
  else if PageControl1.ActivePage = tabFiltroAnagrafe then
  begin
    A008FOperatoriDtM1.GetFiltroAnagrafe;
    memoFiltroAnagrafe.ReadOnly:=True;
  end
  else if PageControl1.ActivePage = tabFiltroFunzioni then
  begin
    selCorrente.Session.Rollback;
    selCorrente.ReadOnly:=True;
    selCorrente.Refresh;
  end
  else if PageControl1.ActivePage = tabFiltroDizionario then
  begin
    cmbDizionario.Enabled:=True;
    cmbDizionarioChange(nil);
    lstDizionario.Enabled:=False;
    rgpDizionario.Enabled:=False;
    selCorrente.Refresh;
  end
  else if PageControl1.ActivePage = tabIterAutorizzativi then
  begin
    cmbCodiceIter.Enabled:=True;
    SessioneOracle.CancelUpdates([selCorrente]);
    selCorrente.Refresh;
  end;
  AbilitaAzioni(actAnnulla);
end;

procedure TA008FProfili.btnRefreshClick(Sender: TObject);
{Lettura dei valori disponibili da T030_ANAGRAFICO / V430_STORICO}
begin
  (*if cmbNomeCampo.Text <> '' then
    with A008FOperatoriDtM1.selValues do
    begin
      SQL.Clear;
      SQL.Add('SELECT DISTINCT ' + VarToStr(cmbNomeCampo.Text) + ' VALORE');
      if Copy(VarToStr(cmbNomeCampo.Text),1,4) = 'T430' then
        SQL.Add('FROM V430_STORICO')
      else
        SQL.Add('FROM T030_ANAGRAFICO');
      SQL.Add('WHERE ' + VarToStr(cmbNomeCampo.Text) + ' IS NOT NULL');
      CloseAll;
      Open;
      cmbValori.Items.Clear;
      while not Eof do
      begin
        cmbValori.Items.Add(FieldByName('VALORE').AsString);
        Next;
      end;
    end;*)
end;

procedure TA008FProfili.btnStatiAvanzamentoValClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with C013FCheckList do
    begin
      with A008FOperatoriDtM1.selSG746 do
      begin
        Open;
        while not Eof do
        begin
          clbListaDati.Items.Add(Format('%-7s %s',[FieldByName('CODREGOLA').AsString + '.' + IntToStr(FieldByName('CODICE').AsInteger),FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
        Close;
      end;
      R180PutCheckList(dedtStatiAvanzamentoVal.Text,7,clbListaDati);
      ShowModal;
    end;
  finally
    A008FOperatoriDtM1.selI071.FieldByName('S710_STATI_ABILITATI').AsString:=Trim(R180GetCheckList(7,C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TA008FProfili.memoFiltroAnagrafeDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=True;
end;

procedure TA008FProfili.mnuRegoleAccessoIPClick(Sender: TObject);
begin
  // apre il dataset delle regole di accesso IP per la funzione selezionata
  A008FOperatoriDtM1.selI076.Close;
  A008FOperatoriDtM1.selI076.SetVariable('AZIENDA',A008FOperatoriDtM1.selI073.FieldByName('AZIENDA').AsString);
  A008FOperatoriDtM1.selI076.SetVariable('PROFILO',A008FOperatoriDtM1.selI073.FieldByName('PROFILO').AsString);
  A008FOperatoriDtM1.selI076.SetVariable('APPLICAZIONE',A008FOperatoriDtM1.selI073.FieldByName('APPLICAZIONE').AsString);
  A008FOperatoriDtM1.selI076.SetVariable('TAG',A008FOperatoriDtM1.selI073.FieldByName('TAG').AsInteger);
  A008FOperatoriDtM1.selI076.Open;

  // visualizza form di gestione regole accesso IP
  A008FRegoleAccessoIP:=TA008FRegoleAccessoIP.Create(nil);
  try
    A008FRegoleAccessoIP.ShowModal;
  finally
    FreeAndNil(A008FRegoleAccessoIP);
  end;
end;

procedure TA008FProfili.btnDatiC700Click(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with C013FCheckList do
    begin
      clbListaDati.Sorted:=True;
      clbListaDati.Items.Assign(lstNomeCampo);
      R180PutCheckList(dedtDatiC700.Text,255,clbListaDati);
      ShowModal;
    end;
  finally
    A008FOperatoriDtM1.selI071.FieldByName('DATIC700').AsString:=Trim(R180GetCheckList(255,C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TA008FProfili.cmbSelAzinChange(Sender: TObject);
begin
  A008FOperatoriDtM1.AziendaCorrente:=cmbSelAzin.Text;
  A008FOperatoriDtM1.selI090.SearchRecord('AZIENDA',A008FOperatoriDtM1.AziendaCorrente,[srFromBeginning]);
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  Parametri.ColonneStruttura.Clear;
  C600frmSelAnagrafe.CreaSelAnagrafe(A008FOperatoriDtM1.DbIris008B,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  with A008FOperatoriDtM1 do
  begin
    AggiornaFiltroProfili;
    //============================================
    //Aggiornamento Combo codice IterAutorizzativo
    CaricaCmbIter;
    //============================================
    dlstPermessi.KeyValue:=selI071.FieldByName('PROFILO').AsString;
    dlstFiltroAnagrafe.KeyValue:=selI072Dist.FieldByName('PROFILO').AsString;
    dlstFiltroFunzioni.KeyValue:=selI073Dist.FieldByName('PROFILO').AsString;
    dlstFiltroDizionario.KeyValue:=selI074Dist.FieldByName('PROFILO').AsString;
    dlstIterAutorizzativi.KeyValue:=selI075Dist.FieldByName('PROFILO').AsString;
  end;
  StatusBar1.SimpleText:=Format('%d Records',[selCorrenteDist.RecordCount]);
end;

procedure TA008FProfili.Copiainexcel1Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dGridFAnag,True,False,True,True);
end;

procedure TA008FProfili.chkSelezioneMultiplaClick(Sender: TObject);
{Abilita/Disabilita la selezione multipla nella griglia del filtro funzioni}
begin
  if chkSelezioneMultipla.Checked then
    DbGrid2.Options:=DbGrid2.Options + [dgRowSelect,dgMultiSelect] - [dgEditing]
  else if not chkSelezioneMultipla.Checked then
    DbGrid2.Options:=DbGrid2.Options - [dgRowSelect,dgMultiSelect] + [dgEditing];
end;

procedure TA008FProfili.AbilitazioniR1Click(Sender: TObject);
{Impostazione accesso funzioni S - N - R}
var S:String;
    i:Integer;
begin
  S:='N';
  if Sender = AbilitazioniR1 then
    S:='R'
  else if Sender = AbilitazioniN1 then
    S:='N'
  else if Sender = AbilitazioniS1 then
    S:='S';
  with A008FOperatoriDtM1.selI073 do
  begin
    if ReadOnly then exit;
    if State = dsEdit then
      Cancel;
    DisableControls;
    try
      try
        if chkSelezioneMultipla.Checked then
        begin
          for i:=0 to DBGrid2.SelectedRows.Count - 1 do
          begin
            GotoBookmark(DBGrid2.SelectedRows.Items[i]);
            Edit;
            FieldByName('INIBIZIONE').AsString:=S;
            Post;
          end;
        end
        else
        begin
          // tutti i record
          First;
          while not Eof do
          begin
            Edit;
            FieldByName('INIBIZIONE').AsString:=S;
            Post;
            Next;
          end;
          First;
        end;
      except
        on E:Exception do
        begin
          Refresh;
          R180MessageBox('Attenzione! Il filtro funzioni è stato modificato nel frattempo!' + #13#10 +
                         'Si prega di effettuare nuovamente l''operazione.',INFORMA);
        end;
      end;
    finally
      EnableControls;
    end;
  end;
end;

procedure TA008FProfili.cmbCodiceIterChange(Sender: TObject);
begin
  A008FOperatoriDtm1.FiltraSelI075;
end;

procedure TA008FProfili.cmbCodiceIterDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Index = 0 then
    (Control as TComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,'Tutti')
  else
    (Control as TComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A000IterAutorizzativi[Index - 1].Desc);
end;

procedure TA008FProfili.cmbDizionarioChange(Sender: TObject);
{Lettura dei codici di dizionario abilitati}
var i:Integer;
  B007:TB007FManipolazioneDati;
begin
  if not R180In(cmbDizionario.Text,['ANOMALIE DEI CONTEGGI','ANOMALIE NASCOSTE SU CARTELLINO WEB','MANIPOLAZIONE DATI']) then
    with A008FOperatoriDtM1.selDizionario do
    begin
      Filtered:=False;
      Filter:='TABELLA = ''' + cmbDizionario.Text + '''';
      Filtered:=True;
      First;
      lstDizionario.Items.Clear;
      while not Eof do
      begin
        lstDizionario.Items.Add(FieldByName('CODICE').AsString);
        Next;
      end;
    end
  else if cmbDizionario.Text = 'MANIPOLAZIONE DATI' then
  begin
    lstDizionario.Items.Clear;
    B007:=TB007FManipolazioneDati.Create(Self);
    for i:=0 to B007.PageControl1.PageCount-1 do
      lstDizionario.Items.Add(B007.PageControl1.Pages[i].Caption);
    FreeAndNil(B007);
  end
  else
  begin
    lstDizionario.Items.Clear;
    for i:=low(tdescanom2) to High(tdescanom2) do
      lstDizionario.Items.Add(R180DimLung('A2_' + IntToStr(tdescanom2[i].N),6) + ' ' + tdescanom2[i].D);
    for i:=low(tdescanom3) to High(tdescanom3) do
      lstDizionario.Items.Add(R180DimLung('A3_' + IntToStr(tdescanom3[i].N),6) + ' ' + tdescanom3[i].D);
  end;
  for i:=0 to lstDizionario.Items.Count - 1 do
    if not R180In(cmbDizionario.Text,['ANOMALIE DEI CONTEGGI','ANOMALIE NASCOSTE SU CARTELLINO WEB']) then
      lstDizionario.Checked[i]:=A008FOperatoriDtM1.selI074.SearchRecord('TABELLA;CODICE',VarArrayOf([cmbDizionario.Text,lstDizionario.Items[i]]),[srFromBeginning])
    else
      lstDizionario.Checked[i]:=A008FOperatoriDtM1.selI074.SearchRecord('TABELLA;CODICE',VarArrayOf([cmbDizionario.Text,Trim(copy(lstDizionario.Items[i],1,5))]),[srFromBeginning]);
  if A008FOperatoriDtM1.selI074.Lookup('TABELLA',cmbDizionario.Text,'ABILITATO') = 'S' then
    rgpDizionario.ItemIndex:=0
  else
    rgpDizionario.ItemIndex:=1;
  rgpDizionario.Enabled:=False;
end;

procedure TA008FProfili.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  if A008FOperatoriDtM1.BrowseProfili then exit;
  for i:=0 to lstDizionario.Items.Count - 1 do
    if Sender = Selezionatutto1 then
      lstDizionario.Checked[i]:=True
    else if Sender = Annullatutto1 then
      lstDizionario.Checked[i]:=False
    else if Sender = Invertiselezione1 then
      lstDizionario.Checked[i]:=not lstDizionario.Checked[i];
end;

procedure TA008FProfili.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with A008FoperatoriDtm1 do
  begin
    selI075.Close;
    testFiltroAnagrafe.Close;
  end;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA008FProfili.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=A008FOperatoriDtM1.BrowseProfili;
end;

procedure TA008FProfili.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TA008FProfili.EspandiGridFAnagrafe(Espandi:Boolean);
begin
  if Espandi then
    memoFiltroAnagrafe.Height:=(Panel1.Height - memoFiltroAnagrafe.Top) div 2
  else
    memoFiltroAnagrafe.Height:=Panel1.Height - memoFiltroAnagrafe.Top;
end;

procedure TA008FProfili.SpeedButton1Click(Sender: TObject);
var
  i:Integer;
  Riga,NomeUtente,NomeDelegato: String;
begin
  with A008FOperatoriDtM1 do
  begin
    testFiltroAnagrafe.SQL.Text:=QVistaOracle;
    testFiltroAnagrafe.SQL.Insert(0,'SELECT MATRICOLA, COGNOME, NOME, T430INIZIO, T430FINE FROM');
    if Trim(memoFiltroAnagrafe.Lines.Text) <> '' then
    begin
      testFiltroAnagrafe.Sql.Add('AND (');
      //Gestione variabili.ini
      if Pos(':NOME_UTENTE',UpperCase(memoFiltroAnagrafe.Text)) > 0 then
        NomeUtente:=InputBox('Anteprima filtro anagrafe','Nome utente:',Parametri.Operatore);
      if Pos(':UTENTE_AUTENTICATO',UpperCase(memoFiltroAnagrafe.Text)) > 0 then
        NomeDelegato:=InputBox('Anteprima filtro anagrafe','Utente autenticato:',Parametri.Operatore);
      if NomeUtente = '' then
        NomeUtente:='1';
      if NomeDelegato = '' then
        NomeDelegato:='1';
      //Gestione variabili.fine
      for i:=0 to memoFiltroAnagrafe.Lines.Count - 1 do
      begin
        Riga:=memoFiltroAnagrafe.Lines[i];
        if Trim(Riga) <> '' then
        begin
          Riga:=StringReplace(Riga,':NOME_UTENTE','''' + NomeUtente + '''',[rfReplaceAll,rfIgnoreCase]);
          Riga:=StringReplace(Riga,':UTENTE_AUTENTICATO','''' + NomeDelegato + '''',[rfReplaceAll,rfIgnoreCase]);
          testFiltroAnagrafe.Sql.Add(Riga);
        end;
      end;
      testFiltroAnagrafe.Sql.Add(')');
    end;
    testFiltroAnagrafe.SQL.Add('order by COGNOME, NOME, MATRICOLA');
    //Imposto la data di lavoro per i dati storici
    testFiltroAnagrafe.DeclareVariable('DataLavoro',otDate);
    testFiltroAnagrafe.SetVariable('DataLavoro',Parametri.DataLavoro);
    testFiltroAnagrafe.Close;
    dGridFAnag.Hint:='';
    EspandiGridFAnagrafe(False);
    if Sender = SpeedButton1 then
      testFiltroAnagrafe.ExecSQL
    else if Sender = btnAnteprima then
    begin
      testFiltroAnagrafe.Open;
      dGridFAnag.Hint:=testFiltroAnagrafe.RecordCount.ToString + ' records';
      EspandiGridFAnagrafe(True);
    end;
    if (Sender <> nil) and (Sender <> btnAnteprima) then
      R180MessageBox(A000MSG_A183_MSG_FILTRO_CORRETTO,INFORMA);
  end;
end;

procedure TA008FProfili.DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA008FProfili.BtnAnticipiClick(Sender: TObject);
begin
  C013FCheckList:=TC013FCheckList.Create(nil);
  try
    with C013FCheckList do
    begin
      clbListaDati.Items.Add(Format('%-10s %s',['S','Anticipi Sospesi']));
      clbListaDati.Items.Add(Format('%-10s %s',['P','Anticipi Protocollati']));
      clbListaDati.Items.Add(Format('%-10s %s',['L','Anticipi Liquidati']));
      clbListaDati.Items.Add(Format('%-10s %s',['R','Anticipi Recuperati']));
      R180PutCheckList(DEdtAnticipi.Text,9,clbListaDati);
      ShowModal;
    end;
  finally
    A008FOperatoriDtM1.selI071.FieldByName('A131_ANTICIPIGESTIBILI').AsString:=Trim(R180GetCheckList(9, C013FCheckList.clbListaDati));
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TA008FProfili.FormDestroy(Sender: TObject);
begin
  FreeAndNil(lstNomeCampo);
end;

end.
