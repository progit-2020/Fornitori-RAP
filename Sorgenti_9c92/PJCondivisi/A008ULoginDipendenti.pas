unit A008ULoginDipendenti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Menus, Buttons, ExtCtrls, ComCtrls, DBCtrls, StdCtrls,
  Grids, DBGrids, Mask, ActnList, ImgList, ToolWin, Oracle, OracleData, Variants,
  A000UCostanti, A000USessione, A000UMessaggi, A000UInterfaccia, A001USSPIValidatePassword,
  A002UInterfacciaSt, A003UDataLavoroBis, System.UITypes,
  C001UFiltroTabelleDtM, C001UFiltroTabelle, C001UScegliCampi,
  C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali, (*C700USelezioneAnagrafe,*)
  SelAnagrafe, R001UGESTTAB, ToolbarFiglio, C600USelAnagrafe, A083UMsgElaborazioni,A008UIterCondizValidita,
  RegolePassword, System.Actions, System.StrUtils;

type
  TA008FLoginDipendenti = class(TR001FGestTab)
    Panel2: TPanel;
    dgrdLoginDipendente: TDBGrid;
    ProgressBar1: TProgressBar;
    actTrigger: TAction;
    N4: TMenuItem;
    AbilitaDisabilitaTrigger1: TMenuItem;
    actDefault: TAction;
    N5: TMenuItem;
    actDefault1: TMenuItem;
    PnlDettaglio: TPanel;
    DBGridDettaglio: TDBGrid;
    frmToolbarFiglio: TfrmToolbarFiglio;
    Splitter1: TSplitter;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    ppMnuLogin: TPopupMenu;
    Richiediilcambiopassword1: TMenuItem;
    N6: TMenuItem;
    actEstrazioneExcel: TAction;
    Copiainexcel1: TMenuItem;
    actModificaPassword: TAction;
    ppMnuPwd: TPopupMenu;
    Accedi1: TMenuItem;
    PageControl1: TPageControl;
    tbsAzioni: TTabSheet;
    grpGenerazioneLogin: TGroupBox;
    lblExprUtente: TLabel;
    lblExprPassword: TLabel;
    chkForzaCambioPwd: TCheckBox;
    cmbExprUtente: TDBLookupComboBox;
    cmbExprPassword: TDBLookupComboBox;
    btnInserisciLogin: TBitBtn;
    btnCancellaLogin: TBitBtn;
    btnModificaPassword: TBitBtn;
    btnAnomalie: TBitBtn;
    tbsEspressioni: TTabSheet;
    dgrdExrAccount: TDBGrid;
    grpImpostazioniProfili: TGroupBox;
    lblFiltroFunzioni: TLabel;
    lblFiltroAnagrafe: TLabel;
    lblPermessi: TLabel;
    lblFiltroDizionario: TLabel;
    Label2: TLabel;
    lblIterAutor: TLabel;
    cmbFiltroFunzioni: TComboBox;
    cmbFiltroAnagrafe: TComboBox;
    cmbPermessi: TComboBox;
    cmbFiltroDizionario: TComboBox;
    cmbNomeProfilo: TComboBox;
    cmbIterAutor: TComboBox;
    btnAggDizionario: TBitBtn;
    btnAggIter: TBitBtn;
    btnAggFunzioni: TBitBtn;
    btnAggAnagrafe: TBitBtn;
    btnAggPermessi: TBitBtn;
    ppMnuUtente: TPopupMenu;
    MenuItem1: TMenuItem;
    ppMnFunzioni: TPopupMenu;
    itemPermessi: TMenuItem;
    Panel3: TPanel;
    Label1: TLabel;
    dcmbAzienda: TDBLookupComboBox;
    DBText1: TDBText;
    actCancellaProfili: TAction;
    GroupBox1: TGroupBox;
    btnDefault: TBitBtn;
    btnTrigger: TBitBtn;
    BitBtn1: TBitBtn;
    chkApplicaFiltro: TCheckBox;
    procedure DButtonStateChange(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Chiudi1Click(Sender: TObject);
    procedure btnInserisciLoginClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancellaLoginClick(Sender: TObject);
    procedure dgrdLoginDipendenteEditButtonClick(Sender: TObject);
    procedure actTriggerExecute(Sender: TObject);
    procedure dcmbAziendaKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dcmbAziendaCloseUp(Sender: TObject);
    procedure actDefaultExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure Richiediilcambiopassword1Click(Sender: TObject);
    procedure btnAggPermessiClick(Sender: TObject);
    procedure btnAggAnagrafeClick(Sender: TObject);
    procedure btnAggFunzioniClick(Sender: TObject);
    procedure btnAggIterClick(Sender: TObject);
    procedure btnAggDizionarioClick(Sender: TObject);
    procedure ppMnuLoginPopup(Sender: TObject);
    procedure actEstrazioneExcelExecute(Sender: TObject);
    procedure actModificaPasswordExecute(Sender: TObject);
    procedure cmbExprUtenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbExprPasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbExprPasswordCloseUp(Sender: TObject);
    procedure cmbExprUtenteCloseUp(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure itemPermessiClick(Sender: TObject);
    procedure actCancellaProfiliExecute(Sender: TObject);
    procedure chkApplicaFiltroClick(Sender: TObject);
    procedure cmbNomeProfiloChange(Sender: TObject);
    procedure dgrdLoginDipendenteTitleClick(Column: TColumn);
    procedure frmToolbarFiglioactTFGenerica1Execute(Sender: TObject);
    procedure frmToolbarFiglioactTFInserisciExecute(Sender: TObject);
   private
    { Private declarations }
    lstDominio:TStringList;
    LastFieldDipClick,TipoOrdQI060:String;
    procedure AggiornaCampiI061(CampoUpdate, ValUpdate:String);
    procedure SettaFiltroProfili;
    procedure GetTriggerT030;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure DistruggoRicreoSelAnagrafe;
    procedure TestExprLogin(var ODS:TOracleDataSet);
  public
    { Public declarations }
    Inserimento, ForzaCambioPsw:Boolean;
    spvAzienda, OldSel: String;
    procedure CaricaCmbNomiProfili;
  end;

var
  A008FLoginDipendenti: TA008FLoginDipendenti;

implementation

uses A008UOperatoriDtM1, A008UProfili, A008UCambioPassword, A008UListaGriglia;

{$R *.DFM}

procedure TA008FLoginDipendenti.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  PageControl1.ActivePage:=tbsAzioni;
  A008FOperatoriDtM1.selI065P.Open;
  A008FOperatoriDtM1.selI065U.Open;
  A008FOperatoriDtM1.selI065.Open;
  A008FOperatoriDtM1.selI065.ReadOnly:=SolaLettura;
  cmbExprUtente.Hint:=A008FOperatoriDtM1.selI065U.FieldByName('ESPRESSIONE').AsString;
  cmbExprPassword.Hint:=A008FOperatoriDtM1.selI065P.FieldByName('ESPRESSIONE').AsString;

  Inserimento:=False;
  lstDominio:=TStringList.Create;
  lstDominio.Sorted:=True;
  Richiediilcambiopassword1.Enabled:=Not SolaLettura;
  for i:=0 to dgrdLoginDipendente.Columns.Count - 1 do
    if UpperCase(dgrdLoginDipendente.Columns[i].FieldName) = 'NOME_UTENTE' then
    begin
      if A008FOperatoriDtM1.QI090.FieldByName('DOMINIO_DIP').IsNull then
        dgrdLoginDipendente.Columns[i].ButtonStyle:=cbsAuto
      else
        dgrdLoginDipendente.Columns[i].ButtonStyle:=cbsEllipsis;
      Break;
    end;
  for i:=0 to DBGridDettaglio.Columns.Count - 1 do
    if UpperCase(DBGridDettaglio.Columns[i].FieldName) = 'ITER_AUTORIZZATIVI' then
      DBGridDettaglio.Columns[i].Visible:=ITER_ATTIVO = 'S';

  LastFieldDipClick:='';
  TipoOrdQI060:='ASC';
end;

procedure TA008FLoginDipendenti.FormShow(Sender: TObject);
begin
  A008FOperatoriDtM1.selI090.SearchRecord('AZIENDA',A008FOperatoriDtM1.AziendaCorrente,[srFromBeginning]);
  dcmbAzienda.KeyValue:=A008FOperatoriDtM1.AziendaCorrente;
  ForzaCambioPsw:=False;
  CreaC004(SessioneOracle,'A008',Parametri.ProgOper);
  GetParametriFunzione;
  btnAnomalie.Enabled:=False;
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.CreaSelAnagrafe(A008FOperatoriDtM1.DbIris008B,StatusBar,2,False);
  C600frmSelAnagrafe.C600Progressivo:=0;
  with A008FOperatoriDtM1 do
  begin
    //if not selI090.SearchRecord('AZIENDA',QI070.FieldByName('AZIENDA').AsString,[srFromBeginning]) then
    //  selI090.First;
    QI060.Close;
    //QI060.SetVariable('AZIENDA',QI070.FieldByName('AZIENDA').AsString);
    QI060.SetVariable('AZIENDA',AziendaCorrente);
    QI060.Open;
    OpenI061;

    //dcmbAzienda.KeyValue:=selI090.FieldByName('AZIENDA').AsString;
    //cmbFiltroFunzioni.ItemIndex:=0;
    //cmbFiltroAnagrafe.ItemIndex:=0;
  end;
  GetTriggerT030;
//===============================
//INIZIALIZZAZIONE TOOLBAR FIGLIO
//===============================
  frmToolbarFiglio.TFDButton:=A008FOperatoriDtm1.dsrI061;
  frmToolbarFiglio.TFDBGrid:=DBGridDettaglio;
  //Per gestire i pulsanti quando CachedUpdate:=False;(si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  //A008FOperatoriDtm1.dsrI061.OnStateChange:=frmToolbarFiglio.DButtonStateChange;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  //frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.lstLock[3]:=C600frmSelAnagrafe;
  frmToolbarFiglio.AbilitaAzioniTF(nil);

  CaricaCmbNomiProfili;
  DButton.DataSet:=A008FOperatoriDtM1.QI060;
end;

procedure TA008FLoginDipendenti.C600frmSelAnagrafebtnSelezioneClick(
  Sender: TObject);
begin
  if Parametri.DataLavoro <> 0 then
    C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro
  else
    C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.C600DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  A008FOperatoriDtM1.QI060.Filtered:=False;
  A008FOperatoriDtM1.QI060.Filtered:=True;
end;

procedure TA008FLoginDipendenti.CaricaCmbNomiProfili;
var Index:integer;
begin
  with A008FOperatoriDtM1 do
  begin
    selI061Dist.Close;
    selI061Dist.SetVariable('AZIENDA',selI090.FieldByName('AZIENDA').AsString);
    selI061Dist.Open;
    Index:=R180GetColonnaDBGrid(DBGridDettaglio,'NOME_PROFILO');
    DBGridDettaglio.Columns.Items[Index].PickList.BeginUpdate;
    DBGridDettaglio.Columns.Items[Index].PickList.Clear;
    cmbNomeProfilo.Items.Clear;
    selI061Dist.First;
    while Not selI061Dist.Eof do
    begin
      cmbNomeProfilo.Items.Add(selI061Dist.FieldByName('NOME_PROFILO').AsString);
      DBGridDettaglio.Columns[Index].PickList.Add(selI061Dist.FieldByName('NOME_PROFILO').AsString);
      selI061Dist.Next;
    end;
    DBGridDettaglio.Columns.Items[Index].PickList.EndUpdate;
  end;
end;

procedure TA008FLoginDipendenti.GetTriggerT030;
begin
  A008FOperatoriDtM1.selUser_Triggers.Open;
  if A008FOperatoriDtM1.selUser_Triggers.fieldbyname('STATUS').AsString = 'ENABLED' then
  begin
    actTrigger.Tag:=1;
    actTrigger.Caption:='Disabilita Trigger';
    AbilitaDisabilitaTrigger1.Caption:='Disabilita Trigger';
  end
  else
  begin
    actTrigger.Tag:=2;
    actTrigger.Caption:='Abilita Trigger';
    AbilitaDisabilitaTrigger1.Caption:='Abilita Trigger';
  end;
end;

procedure TA008FLoginDipendenti.itemPermessiClick(Sender: TObject);
var
  PrevSolaLettura:Boolean;
begin
  if ppMnFunzioni.PopupComponent = DBGridDettaglio then
  begin
    PrevSolaLettura:=SolaLettura;
    case A000GetInibizioni('Funzione','OpenA008Operatori') of
      'N':begin
          ShowMessage('Funzione non abilitata!');
          Exit;
          end;
      'R':SolaLettura:=True;
    end;
    if A008FProfili = nil then
      A008FProfili:=TA008FProfili.Create(nil);
    if DBGridDettaglio.SelectedField.FieldName  = 'PERMESSI' then
    begin
      if A008FOperatoriDtM1.selI061.FieldByName('PERMESSI').AsString <> '' then
        A008FProfili.dlstPermessi.KeyValue:=A008FOperatoriDtM1.selI061.FieldByName('PERMESSI').AsString;
      A008FProfili.PageControl1.ActivePage:=A008FProfili.tabPermessi;
    end
    else if DBGridDettaglio.SelectedField.FieldName  = 'FILTRO_ANAGRAFE' then
    begin
      if A008FOperatoriDtM1.selI061.FieldByName('FILTRO_ANAGRAFE').AsString <> '' then
        A008FProfili.dlstFiltroAnagrafe.KeyValue:=A008FOperatoriDtM1.selI061.FieldByName('FILTRO_ANAGRAFE').AsString;
      A008FProfili.PageControl1.ActivePage:=A008FProfili.tabFiltroAnagrafe;
    end
    else if DBGridDettaglio.SelectedField.FieldName  = 'FILTRO_FUNZIONI' then
    begin
      if A008FOperatoriDtM1.selI061.FieldByName('FILTRO_FUNZIONI').AsString <> '' then
        A008FProfili.dlstFiltroFunzioni.KeyValue:=A008FOperatoriDtM1.selI061.FieldByName('FILTRO_FUNZIONI').AsString;
      A008FProfili.PageControl1.ActivePage:=A008FProfili.tabFiltroFunzioni;
    end
    else if DBGridDettaglio.SelectedField.FieldName  = 'FILTRO_DIZIONARIO' then
    begin
      if A008FOperatoriDtM1.selI061.FieldByName('FILTRO_DIZIONARIO').AsString <> '' then
        A008FProfili.dlstFiltroDizionario.KeyValue:=A008FOperatoriDtM1.selI061.FieldByName('FILTRO_DIZIONARIO').AsString;
      A008FProfili.PageControl1.ActivePage:=A008FProfili.tabFiltroDizionario;
    end
    else if DBGridDettaglio.SelectedField.FieldName  = 'ITER_AUTORIZZATIVI' then
    begin
      if A008FOperatoriDtM1.selI061.FieldByName('ITER_AUTORIZZATIVI').AsString <> '' then
        A008FProfili.dlstIterAutorizzativi.KeyValue:=A008FOperatoriDtM1.selI061.FieldByName('ITER_AUTORIZZATIVI').AsString;
      A008FProfili.PageControl1.ActivePage:=A008FProfili.tabIterAutorizzativi;
    end;
    A008FProfili.ShowModal;
    SolaLettura:=PrevSolaLettura;
  end;
end;

procedure TA008FLoginDipendenti.MenuItem1Click(Sender: TObject);
begin
  PageControl1.ActivePage:=tbsEspressioni;
  TOracleDataSet(dgrdExrAccount.DataSource.DataSet).SearchRecord('TIPO;CODICE',VarArrayOf(['U',cmbExprUtente.Text]),[srFromBeginning]);
end;

procedure TA008FLoginDipendenti.ppMnuLoginPopup(Sender: TObject);
begin
  inherited;
  with A008FOperatoriDtM1 do
  begin
    Richiediilcambiopassword1.Enabled:=QI060.RecordCount > 0;
    actEstrazioneExcel.Enabled:=QI060.RecordCount > 0;
  end;
end;

procedure TA008FLoginDipendenti.GetParametriFunzione;
{Leggo i parametri della form}
begin
  chkForzaCambioPwd.Checked:=C004FParamForm.GetParametro('DIP_PASSWORD','N') = 'S';
  chkApplicaFiltro.Checked:=C004FParamForm.GetParametro('DIP_FILTRO','N') = 'S';
  cmbExprUtente.KeyValue:=C004FParamForm.GetParametro('EXPR_UTENTE','');
  cmbExprPassword.KeyValue:=C004FParamForm.GetParametro('EXPR_PASSWORD','');
  cmbPermessi.Text:=C004FParamForm.GetParametro('DIP_PERMESSI','');
  cmbFiltroAnagrafe.Text:=C004FParamForm.GetParametro('DIP_ANAGRAFE','');
  cmbFiltroFunzioni.Text:=C004FParamForm.GetParametro('DIP_FUNZIONI','');
  cmbIterAutor.Text:=C004FParamForm.GetParametro('DIP_ITERAUTOR','');
  cmbFiltroDizionario.Text:=C004FParamForm.GetParametro('DIP_DIZIONARIO','');
  cmbNomeProfilo.Text:=C004FParamForm.GetParametro('DIP_NOMEPROFILO','');
  frmToolbarFiglio.btnTFGenerico1.Down:=C004FParamForm.GetParametro('DIP_PROFILI_VISIONE_CORR','N') = 'S';
  frmToolbarFiglio.btnTFGenerico1.OnClick(nil);
end;

procedure TA008FLoginDipendenti.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  if chkForzaCambioPwd.Checked then
    C004FParamForm.PutParametro('DIP_PASSWORD','S')
  else
    C004FParamForm.PutParametro('DIP_PASSWORD','N');
  if chkApplicaFiltro.Checked then
    C004FParamForm.PutParametro('DIP_FILTRO','S')
  else
    C004FParamForm.PutParametro('DIP_FILTRO','N');
  C004FParamForm.PutParametro('EXPR_UTENTE',cmbExprUtente.Text);
  C004FParamForm.PutParametro('EXPR_PASSWORD',cmbExprPassword.Text);
  C004FParamForm.PutParametro('DIP_PERMESSI',cmbPermessi.Text);
  C004FParamForm.PutParametro('DIP_ANAGRAFE',cmbFiltroAnagrafe.Text);
  C004FParamForm.PutParametro('DIP_FUNZIONI',cmbFiltroFunzioni.Text);
  C004FParamForm.PutParametro('DIP_ITERAUTOR',cmbIterAutor.Text);
  C004FParamForm.PutParametro('DIP_DIZIONARIO',cmbFiltroDizionario.Text);
  C004FParamForm.PutParametro('DIP_NOMEPROFILO',cmbNomeProfilo.Text);
  if frmToolbarFiglio.btnTFGenerico1.Down then
    C004FParamForm.PutParametro('DIP_PROFILI_VISIONE_CORR','S')
  else
    C004FParamForm.PutParametro('DIP_PROFILI_VISIONE_CORR','N');
end;

procedure TA008FLoginDipendenti.Richiediilcambiopassword1Click(Sender: TObject);
var PrevStat:TDataSetState;
begin
  inherited;
  with A008FOperatoriDtM1 do
  begin
    ForzaCambioPsw:=True;
    PrevStat:=QI060.State;
    if QI060.State = dsBrowse then
      QI060.Edit;
    QI060.FieldByName('DATA_PW').Clear;
    if PrevStat = dsBrowse then
      QI060.Post;
  end;
end;

procedure TA008FLoginDipendenti.btnInserisciLoginClick(Sender: TObject);
var NLogin:Integer;
    ODS:TOracleDataSet;
begin
  NLogin:=0;
  with A008FOperatoriDTM1 do
  begin
    if cmbFiltroFunzioni.Text = '' then
    begin
      R180MessageBox(Format(A000MSG_A186_ERR_FMT_DEFINIRE_FILTRO,['funzioni']),ERRORE);
      exit;
    end;
    if cmbPermessi.Text = '' then
    begin
      R180MessageBox(Format(A000MSG_A186_ERR_FMT_DEFINIRE_FILTRO,['permessi']),ERRORE);
      exit;
    end;
    //if not (R180MessageBox('Confermi l''inserimento del login di accesso per i ' + IntToStr(C700SelAnagrafe.RecordCount) + ' dipendenti selezionati?','DOMANDA') = mrYes) then
    if not (R180MessageBox(Format(A000MSG_A186_DLG_FMT_INS_LOGIN,[IntToStr(C600frmSelAnagrafe.C600SelAnagrafe.RecordCount)]),'DOMANDA') = mrYes) then
      exit;
    RegistraMsg.IniziaMessaggio('A008');
    selI090.SearchRecord('AZIENDA',spvAzienda,[srFromBeginning]);
    Screen.Cursor:=crHourGlass;
    //Apertura del database indicato dall'Azienda
    CambioDataBase;
    //C700SelAnagrafe.Close;
    C600frmSelAnagrafe.C600SelAnagrafe.Close;
    //C700SelAnagrafe.Open;
    C600frmSelAnagrafe.C600SelAnagrafe.Open;
    ProgressBar1.Position:=0;
    //ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    ProgressBar1.Max:=C600frmSelAnagrafe.C600SelAnagrafe.RecordCount;
    TestExprLogin(ODS);
    try
      while not C600frmSelAnagrafe.C600SelAnagrafe.Eof do
      begin
        ODS.Close;
        //ODS.SetVariable('PROGRESSIVO',C600frmSelAnagrafe.C600Progressivo);
        ODS.SetVariable('MATRICOLA',C600frmSelAnagrafe.C600SelAnagrafe.FieldByName('MATRICOLA').AsString);
        ODS.Open;

        insI060.SetVariable('AZIENDA',spvAzienda);
        insI060.SetVariable('Matricola',C600frmSelAnagrafe.C600SelAnagrafe.FieldByName('MATRICOLA').AsString);
        insI060.SetVariable('NOMEUTENTE',ODS.FieldByName('EXPR_UTENTE').AsString);
        insI060.SetVariable('Password',R180Cripta(ODS.FieldByName('EXPR_PASSWORD').AsString,30011945));
        if chkForzaCambioPwd.Checked then
          insI060.SetVariable('DataPW',null)
        else
          insI060.SetVariable('DataPW',Date);

        insI061.SetVariable('AZIENDA', spvAzienda);
        insI061.SetVariable('NOME_UTENTE', ODS.FieldByName('EXPR_UTENTE').AsString);
        InsI061.SetVariable('NOME_PROFILO', cmbNomeProfilo.Text);
        insI061.SetVariable('FILTRO_FUNZIONI',cmbFiltroFunzioni.Text);
        insI061.SetVariable('FILTRO_ANAGRAFE',cmbFiltroAnagrafe.Text);
        insI061.SetVariable('ITER_AUTORIZZATIVI',cmbIterAutor.Text);
        insI061.SetVariable('FILTRO_DIZIONARIO',cmbFiltroDizionario.Text);
        insI061.SetVariable('PERMESSI',cmbPermessi.Text);
        InsI061.SetVariable('INIZIO_VALIDITA',EncodeDate(1900,1,1));
        InsI061.SetVariable('FINE_VALIDITA',EncodeDate(3999,12,31));
        try
          InsI061.Execute;
          inc(NLogin);
        except
          on E:EOracleError do
            RegistraMsg.InserisciMessaggio('A','Inserimento profilo fallito: ' + E.Message,spvAzienda,C600frmSelAnagrafe.C600Progressivo)
        end;
        try
          insI060.Execute;
        except
          on E:EOracleError do
            RegistraMsg.InserisciMessaggio('A','Inserimento login fallito: ' + E.Message,spvAzienda,C600frmSelAnagrafe.C600Progressivo)
        end;
        ProgressBar1.StepBy(1);
        //C700SelAnagrafe.Next;
        C600frmSelAnagrafe.C600SelAnagrafe.Next;
      end;
    finally
      insI060.Session.Commit;
      FreeAndNil(ODS);
      ProgressBar1.Position:=0;
      actRefresh.Execute;
      selI061.Refresh;
      Screen.Cursor:=crDefault;
      NumRecords;
    end;
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if (RegistraMsg.ContieneTipoA) then
  begin
    if R180MessageBox('Elaborazione terminata con anomalie.' + #13#10 + 'Si vuole visualizzarle?',DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata ' + IntToStr(NLogin) + ' login inseriti',INFORMA);
end;

procedure TA008FLoginDipendenti.AggiornaCampiI061(CampoUpdate, ValUpdate:String);
var I061PrevStat:Boolean;
    RowIDPrev:String;
begin
  if R180MessageBox('Vuoi aggiornare "' + LowerCase(CampoUpdate) + '" con il nuovo valore?',DOMANDA) = mrNo then
    Exit;
  if Trim(cmbNomeProfilo.Text) = '' then
  begin
    R180MessageBox('Specificare il nome del profilo d''aggiornare.',ESCLAMA);
    Exit;
  end;
  with A008FOperatoriDtM1 do
  begin
    QI060.DisableControls;
    RowIDPrev:=QI060.RowID;
    QI060.First;
    while Not QI060.Eof do
    begin
      selI061.First;
      I061PrevStat:=selI061.ReadOnly;
      selI061.ReadOnly:=False;
      try
        while Not selI061.Eof do
        begin
          if selI061.FieldByName('NOME_PROFILO').AsString = cmbNomeProfilo.Text then
          begin
            selI061.Edit;
            selI061.FieldByName(CampoUpdate).AsString:=ValUpdate;
            selI061.Post;
            SessioneOracle.ApplyUpdates([selI061],True);
          end;
          selI061.Next;
        end;
      finally
        selI061.ReadOnly:=I061PrevStat;
      end;
      QI060.Next;
    end;
    QI060.SearchRecord('ROWID',RowIDPrev,[srFromBeginning]);
    QI060.EnableControls;
  end;
end;

procedure TA008FLoginDipendenti.btnAggAnagrafeClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('FILTRO_ANAGRAFE',cmbFiltroAnagrafe.Text);
end;

procedure TA008FLoginDipendenti.btnAggDizionarioClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('FILTRO_DIZIONARIO',cmbFiltroDizionario.Text);
end;

procedure TA008FLoginDipendenti.btnAggFunzioniClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('FILTRO_FUNZIONI',cmbFiltroFunzioni.Text);
end;

procedure TA008FLoginDipendenti.btnAggIterClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('ITER_AUTORIZZATIVI',cmbIterAutor.Text);
end;

procedure TA008FLoginDipendenti.btnAggPermessiClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('PERMESSI',cmbPermessi.Text);
end;

procedure TA008FLoginDipendenti.btnAnomalieClick(Sender: TObject);
begin
  inherited;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A008','A');
end;

procedure TA008FLoginDipendenti.btnCancellaLoginClick(Sender: TObject);
var
  NLogin:Integer;
  mex:String;
begin
  NLogin:=0;
  with A008FOperatoriDTM1 do
  begin
    //Apertura del database indicato dall'Azienda
    mex:='Confermi l''eliminazione del login di accesso per i ' + IntToStr(QI060.RecordCount) + ' login selezionati?';
    if not (R180MessageBox(mex,'DOMANDA') = mrYes) then
      exit;
    Screen.Cursor:=crHourGlass;
    QI060.First;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=QI060.RecordCount;
    delI060.SetVariable('AZIENDA',spvAzienda);
    RegistraMsg.IniziaMessaggio('A008');
    RegistraMsg.InserisciMessaggio('I','Cancellazione login');
    while not QI060.Eof do
    begin
      delI060.SetVariable('NOME_UTENTE',QI060.FieldByName('NOME_UTENTE').AsString);
      try
        delI060.Execute;
        NLogin:=NLogin + delI060.GetVariable('LOGIN_CANC');
      except
        on E:EOracleError do
          RegistraMsg.InserisciMessaggio('A',Format('Cancellazione login %s: %s',[QI060.FieldByName('NOME_UTENTE').AsString,E.Message]),spvAzienda);
      end;
      ProgressBar1.StepBy(1);
      QI060.Next;
    end;
    delI060.Session.Commit;
  end;
  Screen.Cursor:=crDefault;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA);
  if (RegistraMsg.ContieneTipoA) then
  begin
    if R180MessageBox('Elaborazione terminata con anomalie.' + #13#10 + 'Si vuole visualizzarle?',DOMANDA) = mrYes then
      btnAnomalieClick(Nil);
  end
  else
    R180MessageBox('Elaborazione terminata: ' + IntToStr(NLogin) + ' login eliminati.',INFORMA);
  ProgressBar1.Position:=0;
  Screen.Cursor:=crHourGlass;
  A008FOperatoriDTM1.QI060.First;
  actRefresh.Execute;
  Screen.Cursor:=crDefault;
  NumRecords;
end;

procedure TA008FLoginDipendenti.Stampa1Click(Sender: TObject);
begin
  R001LinkC700:=False;
  QueryStampa.Clear;
  QueryStampa.Add('SELECT I060.AZIENDA,I060.MATRICOLA,I060.NOME_UTENTE,I060.DATA_PW,I061.NOME_PROFILO,');
  QueryStampa.Add('       I061.PERMESSI,I061.FILTRO_FUNZIONI,I061.FILTRO_ANAGRAFE,I061.FILTRO_DIZIONARIO,');
  QueryStampa.Add('       I061.INIZIO_VALIDITA,I061.FINE_VALIDITA,I061.DELEGATO_DA');
  QueryStampa.Add('FROM   MONDOEDP.I060_LOGIN_DIPENDENTE I060, MONDOEDP.I061_PROFILI_DIPENDENTE I061');
  QueryStampa.Add('WHERE  I060.AZIENDA = I061.AZIENDA');
  QueryStampa.Add('AND    I060.NOME_UTENTE = I061.NOME_UTENTE');
  QueryStampa.Add('ORDER BY I060.AZIENDA,I060.NOME_UTENTE,I061.NOME_PROFILO');

  NomiCampiR001.Clear;
  NomiCampiR001.Add('I060.AZIENDA');
  NomiCampiR001.Add('I060.MATRICOLA');
  NomiCampiR001.Add('I060.NOME_UTENTE');
  NomiCampiR001.Add('I060.DATA_PW');
  NomiCampiR001.Add('I061.NOME_PROFILO');
  NomiCampiR001.Add('I061.PERMESSI');
  NomiCampiR001.Add('I061.FILTRO_FUNZIONI');
  NomiCampiR001.Add('I061.FILTRO_ANAGRAFE');
  NomiCampiR001.Add('I061.FILTRO_DIZIONARIO');
  NomiCampiR001.Add('I061.INIZIO_VALIDITA');
  NomiCampiR001.Add('I061.FINE_VALIDITA');
  NomiCampiR001.Add('I061.DELEGATO_DA');
  inherited;
end;

procedure TA008FLoginDipendenti.Chiudi1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TA008FLoginDipendenti.chkApplicaFiltroClick(Sender: TObject);
begin
  inherited;
  SettaFiltroProfili;
end;

procedure TA008FLoginDipendenti.cmbExprPasswordCloseUp(Sender: TObject);
begin
  inherited;
  cmbExprPassword.Hint:=StringReplace(A008FOperatoriDtM1.selI065P.FieldByName('ESPRESSIONE').AsString,'||','+',[rfReplaceAll]);
end;

procedure TA008FLoginDipendenti.cmbExprPasswordKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbExprPassword.Hint:=StringReplace(A008FOperatoriDtM1.selI065P.FieldByName('ESPRESSIONE').AsString,'||','+',[rfReplaceAll]);
end;

procedure TA008FLoginDipendenti.cmbExprUtenteCloseUp(Sender: TObject);
begin
  inherited;
  cmbExprUtente.Hint:=StringReplace(A008FOperatoriDtM1.selI065U.FieldByName('ESPRESSIONE').AsString,'||','+',[rfReplaceAll]);
end;

procedure TA008FLoginDipendenti.cmbExprUtenteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbExprUtente.Hint:=StringReplace(A008FOperatoriDtM1.selI065U.FieldByName('ESPRESSIONE').AsString,'||','+',[rfReplaceAll]);
end;

procedure TA008FLoginDipendenti.cmbNomeProfiloChange(Sender: TObject);
begin
  inherited;
  SettaFiltroProfili;
end;

procedure TA008FLoginDipendenti.SettaFiltroProfili;
var Cambiato:Boolean;
begin
  Cambiato:=False;
  with A008FOperatoriDtM1.FiltroProfiliI061 do
  begin
    if (NomeProfilo <> cmbNomeProfilo.Text) or
       (Permessi <> cmbPermessi.Text) or
       (FiltroAnagrafe <> cmbFiltroAnagrafe.Text) or
       (FiltroFunzioni <> cmbFiltroFunzioni.Text) or
       (IterAutorizzativi <> cmbIterAutor.Text) or
       (FiltroDizionario <> cmbFiltroDizionario.Text) then
      Cambiato:=True;
    NomeProfilo:=cmbNomeProfilo.Text;
    Permessi:=cmbPermessi.Text;
    FiltroAnagrafe:=cmbFiltroAnagrafe.Text;
    FiltroFunzioni:=cmbFiltroFunzioni.Text;
    IterAutorizzativi:=cmbIterAutor.Text;
    FiltroDizionario:=cmbFiltroDizionario.Text;
    if Attivo <> chkApplicaFiltro.Checked then
    begin
      Attivo:=chkApplicaFiltro.Checked;
      A008FOperatoriDtM1.I060SettaFiltroI061;
    end
    else if Attivo and Cambiato then
      A008FOperatoriDtM1.I060SettaFiltroI061;
  end;
end;

procedure TA008FLoginDipendenti.DButtonDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  //frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  C600frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  if Field = nil then
  begin
    NumRecords;
  end;
end;

procedure TA008FLoginDipendenti.frmSelAnagrafeR003DatianagraficiClick(
  Sender: TObject);
begin
  try
    C005DataVisualizzazione:=EncodeDate(DButton.DataSet.FieldByName('Anno').AsInteger,1,1);
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  //frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA008FLoginDipendenti.frmToolbarFiglioactTFConfermaExecute(
  Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.actTFConfermaExecute(frmToolbarFiglio.actTFConferma);
  CaricaCmbNomiProfili;
  frmToolbarFiglioactTFGenerica1Execute(nil);
end;

procedure TA008FLoginDipendenti.frmToolbarFiglioactTFGenerica1Execute(
  Sender: TObject);
begin
  inherited;
  A008FOperatoriDtm1.selI061VisioneCorrente:=frmToolbarFiglio.btnTFGenerico1.Down;
  A008FOperatoriDtm1.selI061.Filtered:=False;
  A008FOperatoriDtm1.selI061.Filtered:=(A008FOperatoriDtm1.selI061.Filter <> '') or
                                       (A008FOperatoriDtm1.selI061VisioneCorrente);
end;

procedure TA008FLoginDipendenti.frmToolbarFiglioactTFInserisciExecute(
  Sender: TObject);
begin
  frmToolbarFiglio.btnTFGenerico1.Down:=False;
  frmToolbarFiglioactTFGenerica1Execute(nil);
  inherited;
  frmToolbarFiglio.actTFInserisciExecute(Sender);
end;

procedure TA008FLoginDipendenti.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  if Parametri.DataLavoro <> 0 then
    C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro
  else
    C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.C600DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  //Queste 2 righe fanno si che il programma passi per l'evento OnFilterRecord
  A008FOperatoriDtM1.QI060.Filtered:=False;
  A008FOperatoriDtM1.QI060.Filtered:=True;
end;

procedure TA008FLoginDipendenti.dgrdLoginDipendenteEditButtonClick(Sender: TObject);
var RegolePassword:TRegolePassword;
    S:String;
begin
  if dgrdLoginDipendente.SelectedField.FieldName = 'NOME_UTENTE' then
  begin
    if not (Dbutton.State in [dsEdit,dsInsert]) then
      exit;
    try
      A008FListaGriglia:=TA008FListaGriglia.Create(nil);
      if lstDominio.Count = 0 then
      begin
        A001GetUsers(lstDominio, A001GetDomainControllerName(A008FOperatoriDtM1.QI090.FieldByName('DOMINIO_DIP').AsString));
        if lstDominio.Count = 0 then
          A001GetUsers(lstDominio, A008FOperatoriDtM1.QI090.FieldByName('DOMINIO_DIP').AsString);
      end;
      with A008FListaGriglia do
      begin
        Lista.Items.Assign(lstDominio);
        if (ShowModal = mrOK) and (Lista.ItemIndex >= 0) then
          A008FOperatoriDtM1.QI060.FieldByName('NOME_UTENTE').AsString:=Lista.Items[Lista.ItemIndex];
      end;
    finally
      A008FListaGriglia.Free;
    end;
  end
  else if dgrdLoginDipendente.SelectedField.FieldName = 'D_PASSWORD' then
  //Richiesta password tramite gestione sicurezza
  begin
    if not (Dbutton.State in [dsEdit,dsInsert]) then
      exit;
    Application.CreateForm(TA008FCambioPassword,A008FCambioPassword);
    A008FCambioPassword.Label1.Visible:=False;
    A008FCambioPassword.edtPasswordOld.Visible:=False;
    RegolePassword:=TRegolePassword.Create(nil);
    try
      while True do
      begin
        A008FCambioPassword.lblScadenza.Visible:=Parametri.RegolePassword.MesiValidita > 0;
        A008FCambioPassword.lblScadenza.Caption:='Scade il ' + DateToStr(R180AddMesi(Date,Parametri.RegolePassword.MesiValidita));
        if A008FCambioPassword.ShowModal <> mrOk then
          Break;
        if A008FOperatoriDtM1.QI090.FieldByName('DOMINIO_DIP').IsNull or (Trim(A008FCambioPassword.edtPasswordNew.Text) <> '') then
          with A008FOperatoriDtM1.QI090 do
          begin
            RegolePassword.PasswordI060:=True;
            RegolePassword.MesiValidita:=FieldByName('VALID_PASSWORD').AsInteger;
            RegolePassword.Lunghezza:=FieldByName('LUNG_PASSWORD').AsInteger;
            RegolePassword.Cifre:=FieldByName('PASSWORD_CIFRE').AsInteger;
            RegolePassword.Maiuscole:=FieldByName('PASSWORD_MAIUSCOLE').AsInteger;
            RegolePassword.CarSpeciali:=FieldByName('PASSWORD_CARSPECIALI').AsInteger;
            S:=RegolePassword.PasswordValida(A008FCambioPassword.edtPasswordNew.Text);
            if S <> '' then
            begin
              R180MessageBox(S,INFORMA);
              Continue;
            end;
          end;
        (*
        if Length(A008FCambioPassword.edtPasswordNew.Text) < Parametri.LunghezzaPassword then
        begin
          if A008FOperatoriDtM1.QI090.FieldByName('DOMINIO_DIP').IsNull or (Length(A008FCambioPassword.edtPasswordNew.Text) > 0) then
          begin
            R180MessageBox(Format('La password deve essere di almeno %d caratteri!',[Parametri.LunghezzaPassword]),INFORMA);
            Continue;
          end;
        end;
        *)
        if A008FCambioPassword.edtPasswordNew.Text <> A008FCambioPassword.edtPasswordConferma.Text then
          R180MessageBox(A000MSG_A186_ERR_DLG_PWD,INFORMA)
        (*
        // controllo caratteri password per crittografia su db - daniloc. 26.01.2011
        else if not R180CtrlCripta(A008FCambioPassword.edtPasswordNew.Text) then
          R180MessageBox('La nuova password contiene caratteri non ammessi!',INFORMA)
        *)
        else
        begin
          A008FOperatoriDtM1.QI060.FieldByName('PASSWORD').AsString:=R180Cripta(A008FCambioPassword.edtPasswordNew.Text,30011945);
          Break;
        end;
      end;
    finally
      FreeAndNil(A008FCambioPassword);
      FreeAndNil(RegolePassword);
    end;
  end;
end;

procedure TA008FLoginDipendenti.dgrdLoginDipendenteTitleClick(
  Column: TColumn);
var
  NomeFieldOrd,ColonnaOrd:String;
  FieldOrd:TField;
begin
  ColonnaOrd:='';
  NomeFieldOrd:=Column.FieldName;
  if NomeFieldOrd <> LastFieldDipClick then
    TipoOrdQI060:='ASC'
  else
    TipoOrdQI060:=IfThen(TipoOrdQI060 = 'ASC','DESC','ASC');

  { Casi particolari:
    - La colonna password (che è comunque offuscata) viene ignorata;
    - La colonna nominativo non è una campo diretto di I060, l'ordinamento viene effettuato sul campo
      sulla SELECT "NOMINATIVO_QRY" e solo se non si rischiano incosistenze (Vedi sotto)
    - La colonna nomi profili è sulla clausula SELECT ed ha alias "NOMI_PROFILI"
    - Per le altre colonne si tratta di campi fisici di I060. Si aggiunge il prefisso per evitare
      ambiguità. }
  if NomeFieldOrd = 'D_PASSWORD' then
  begin
    Exit;
  end
  else if NomeFieldOrd = 'D_NOMINATIVO' then
  begin
    // L'elenco dei login è su MONDOEDP.I060_LOGIN_DIPENDENTE I060. I nominativi sono
    // su T030_ANAGRAFICO dello schema corrente. Se l'azienda su cui sono loggato è <>
    // da quella che sto visualizzando, NOMINATIVO_QRY è potenzialmente inconsistente.
    // In questo caso l'ordinamento per nominativo va inibito.
    if Parametri.Azienda = A008FOperatoriDtM1.AziendaCorrente then
      ColonnaOrd:='NOMINATIVO_QRY'
  end
  else if NomeFieldOrd = 'NOMI_PROFILI' then
  begin
    ColonnaOrd:='NOMI_PROFILI';
  end
  else
  begin
    FieldOrd:=A008FOperatoriDtM1.QI060.FieldByName(NomeFieldOrd);
    if (not FieldOrd.Calculated) and (not FieldOrd.Lookup) then
      ColonnaOrd:='I060.' + NomeFieldOrd;
  end;
  if ColonnaOrd <> '' then
  begin
    A008FOperatoriDtM1.QI060.SetVariable('COLONNA_ORD',ColonnaOrd);
    A008FOperatoriDtM1.QI060.SetVariable('TIPO_ORD',TipoOrdQI060);
    A008FOperatoriDtM1.QI060.Refresh;
  end;
  LastFieldDipClick:=NomeFieldOrd;
end;

procedure TA008FLoginDipendenti.actEstrazioneExcelExecute(Sender: TObject);
begin
  inherited;
  if A008FOperatoriDtM1.QI060.RecordCount > 0 then
  begin
    if not SolaLettura then
      with TA008FCambioPassword.Create(nil) do
      try
        Label2.Visible:=False;
        Label3.Visible:=False;
        edtPasswordNew.Visible:=False;
        edtPasswordConferma.Visible:=False;
        lblScadenza.Visible:=False;
        Label1.Caption:='Password ' + Parametri.Operatore;
        if ShowModal <> mrOK then
          exit;
        if edtPasswordOld.Text <> Parametri.PassOper then
          raise Exception.Create('Password errata!');
      finally
        Free;
      end;
    R180DBGridCopyToClipboard(dgrdLoginDipendente,True,False,True,True);
    if not SolaLettura then
    begin
      RegistraMsg.IniziaMessaggio('A008');
      RegistraMsg.InserisciMessaggio('I',Format('Esportato elenco Login dipendenti con password in chiaro: %d records - primo utente: %s',[A008FOperatoriDtM1.QI060.RecordCount,A008FOperatoriDtM1.QI060.FieldByName('NOME_UTENTE').AsString]));
    end;
  end;
end;

procedure TA008FLoginDipendenti.actModificaPasswordExecute(Sender: TObject);
var
  NLogin: integer;
  ODS:TOracleDataSet;
  mex:String;
begin
  inherited;
  NLogin:=0;
  ForzaCambioPsw:=True;
  with A008FOperatoriDTM1 do
  begin
    //Apertura del database indicato dall'Azienda
    mex:=Format(A000MSG_A186_DLG_FMT_UPD_PWD,[IntToStr(QI060.RecordCount)]);
    if not (R180MessageBox(mex,'DOMANDA') = mrYes) then
      exit;
    RegistraMsg.IniziaMessaggio('A008');
    Screen.Cursor:=crHourGlass;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=QI060.RecordCount;
    TestExprLogin(ODS);
    try
      UpdI060.SetVariable('AZIENDA',spvAzienda);
      QI060.First;
      while not QI060.Eof do
      begin
        ODS.Close;
        ODS.SetVariable('MATRICOLA',QI060.FieldByName('MATRICOLA').AsString);
        ODS.Open;
        //Forza il cambio pwd
        if chkForzaCambioPwd.Checked then
          UpdI060.SetVariable('DATAPW',null)
        else
          UpdI060.SetVariable('DATAPW',Date);
        UpdI060.SetVariable('NOME_UTENTE',QI060.FieldByName('NOME_UTENTE').AsString);
        UpdI060.SetVariable('PASSWORD_NEW',R180Cripta(ODS.FieldByName('EXPR_PASSWORD').AsString,30011945));
        try
          UpdI060.Execute;
          inc(NLogin);
        except
          on E:EOracleError do
            RegistraMsg.InserisciMessaggio('A',Format('Modifica password del login %s: %s',[QI060.FieldByName('NOME_UTENTE').AsString,E.Message]),spvAzienda);
        end;
        ProgressBar1.StepBy(1);
        QI060.Next;
      end;
    finally
      UpdI060.Session.Commit;
      FreeAndNil(ODS);
      ProgressBar1.Position:=0;
      QI060.First;
      actRefresh.Execute;
      Screen.Cursor:=crDefault;
    end;
  end;
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if (RegistraMsg.ContieneTipoA) then
  begin
    if R180MessageBox('Elaborazione terminata con anomalie.' + #13#10 + 'Si vuole visualizzarle?',DOMANDA) = mrYes then
      btnAnomalieClick(nil);
  end
  else
    R180MessageBox('Elaborazione terminata ' + IntToStr(NLogin) + ' login modificati.',INFORMA);
end;

procedure TA008FLoginDipendenti.actTriggerExecute(Sender: TObject);
var S:String;
begin
  inherited;
  A008FOperatoriDtM1.OperSQL.Session:=A008FOperatoriDtM1.DbIris008B;
  try
    if actTrigger.Tag = 2 then
      S:=Format(A000MSG_A186_DLG_FMT_TRIG_060,['Attivare'])
    else
      S:=Format(A000MSG_A186_DLG_FMT_TRIG_060,['Disattivare']);
    if MessageDlg(S,mtConfirmation,[mbYes,mbNo],0) = mrNo then
      abort
    else
    if actTrigger.Tag = 2 then
    begin
      with A008FOperatoriDtM1.OperSQL do
      begin
        SQL.Clear;
        SQL.Add('ALTER TRIGGER T030_AFTERINS_I060 ENABLE');
        Execute;
      end;
      actTrigger.Caption:='Disabilita Trigger';
      actTrigger.Tag:=1;
    end
    else
    begin
      with A008FOperatoriDtM1.OperSQL do
      begin
        SQL.Clear;
        SQL.Add('ALTER TRIGGER T030_AFTERINS_I060 DISABLE');
        Execute;
      end;
      actTrigger.Caption:='Abilita Trigger';
      actTrigger.Tag:=2;
    end;
  finally
    A008FOperatoriDtM1.OperSQL.Session:=A008FOperatoriDtM1.DbIris008B;
  end;
end;

procedure TA008FLoginDipendenti.dcmbAziendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
  DistruggoRicreoSelAnagrafe;
end;

procedure TA008FLoginDipendenti.dcmbAziendaCloseUp(Sender: TObject);
begin
  inherited;
  DistruggoRicreoSelAnagrafe;
end;

procedure TA008FLoginDipendenti.DistruggoRicreoSelAnagrafe;
var i:Integer;
begin
  GetTriggerT030;
  //Farlo solo se è stata cambiata l'azienda, altrimenti perde i riferimenti al vecchio filtro sulla vecchia selezione
  if dcmbAzienda.KeyValue <> OldSel then
  begin
    OldSel:=dcmbAzienda.KeyValue;
    try
      //frmSelAnagrafe.DistruggiSelAnagrafe;
      C600frmSelAnagrafe.DistruggiSelAnagrafe;
    except
    end;
    Parametri.ColonneStruttura.Clear;
    //C700Progressivo:=0;
    //frmSelAnagrafe.CreaSelAnagrafe(A008FOperatoriDtM1.DbIris008B,StatusBar,2,False);
    C600frmSelAnagrafe.CreaSelAnagrafe(A008FOperatoriDtM1.DbIris008B,StatusBar,2,False);
    C600frmSelAnagrafe.C600Progressivo:=0;
  end;
  for i:=0 to dgrdLoginDipendente.Columns.Count - 1 do
    if UpperCase(dgrdLoginDipendente.Columns[i].FieldName) = 'NOME_UTENTE' then
    begin
      if A008FOperatoriDtM1.QI090.FieldByName('DOMINIO_DIP').IsNull then
        dgrdLoginDipendente.Columns[i].ButtonStyle:=cbsAuto
      else
        dgrdLoginDipendente.Columns[i].ButtonStyle:=cbsEllipsis;
      Break;
    end;
end;

procedure TA008FLoginDipendenti.Accedi1Click(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=tbsEspressioni;
  TOracleDataSet(dgrdExrAccount.DataSource.DataSet).SearchRecord('TIPO;CODICE',VarArrayOf(['P',cmbExprPassword.Text]),[srFromBeginning]);
end;

procedure TA008FLoginDipendenti.actCancellaProfiliExecute(Sender: TObject);
var
  Trovato:Boolean;
  NProfili:Integer;
  mex:String;
begin
  NProfili:=0;
  if (trim(cmbFiltroFunzioni.Text) = '') and (trim(cmbFiltroAnagrafe.Text) = '') and
     (trim(cmbPermessi.Text) = '') and (trim(cmbFiltroDizionario.Text) = '') and
     (trim(cmbIterAutor.Text) = '') and (trim(cmbNomeProfilo.Text) = '') then
    raise Exception.Create('Attenzione! Non sono state specificate le impostazioni dei profili.');
  with A008FOperatoriDTM1 do
  begin
    mex:=A000MSG_A186_DLG_ELIM_PROFILI;
    if not (R180MessageBox(mex,'DOMANDA') = mrYes) then
      exit;
    Screen.Cursor:=crHourGlass;
    QI060.First;
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=QI060.RecordCount;
    delI060.SetVariable('AZIENDA',spvAzienda);
    RegistraMsg.IniziaMessaggio('A008');
    RegistraMsg.InserisciMessaggio('I','Cancellazione login');
    while not QI060.Eof do
    begin
      if chkApplicaFiltro.Checked then
      begin
        Trovato:=True;
        if (trim(cmbNomeProfilo.Text) <> '') and (not selI061.SearchRecord('NOME_PROFILO',trim(cmbNomeProfilo.Text),[srFromBeginning])) then
          Trovato:=False
        else if (trim(cmbPermessi.Text) <> '') and (not selI061.SearchRecord('PERMESSI',trim(cmbPermessi.Text),[srFromBeginning])) then
          Trovato:=False
        else if (trim(cmbFiltroAnagrafe.Text) <> '') and (not selI061.SearchRecord('FILTRO_ANAGRAFE',trim(cmbFiltroAnagrafe.Text),[srFromBeginning])) then
          Trovato:=False
        else if (trim(cmbFiltroFunzioni.Text) <> '') and (not selI061.SearchRecord('FILTRO_FUNZIONI',trim(cmbFiltroFunzioni.Text),[srFromBeginning])) then
          Trovato:=False
        else if (trim(cmbIterAutor.Text) <> '') and (not selI061.SearchRecord('ITER_AUTORIZZATIVI',trim(cmbIterAutor.Text),[srFromBeginning])) then
          Trovato:=False
        else if (trim(cmbFiltroDizionario.Text) <> '') and (not selI061.SearchRecord('FILTRO_DIZIONARIO',trim(cmbFiltroDizionario.Text),[srFromBeginning])) then
          Trovato:=False;
        if Trovato then
        begin
          selI061.Delete;
          selI061.Session.ApplyUpdates([selI061],True);
          inc(NProfili);
        end;
      end;
      ProgressBar1.StepBy(1);
      QI060.Next;
    end;
  end;
  Screen.Cursor:=crDefault;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA);
  if (RegistraMsg.ContieneTipoA) then
  begin
    if R180MessageBox('Elaborazione terminata con anomalie.' + #13#10 + 'Si vuole visualizzarle?',DOMANDA) = mrYes then
      btnAnomalieClick(Nil);
  end
  else
    R180MessageBox('Elaborazione terminata: ' + IntToStr(NProfili) + ' profili eliminati.',INFORMA);
  ProgressBar1.Position:=0;
  Screen.Cursor:=crHourGlass;
  A008FOperatoriDTM1.QI060.First;
  actRefresh.Execute;
  Screen.Cursor:=crDefault;
  NumRecords;
end;

procedure TA008FLoginDipendenti.actDefaultExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg(A000MSG_A186_DLG_VAL_DEFAULT,mtConfirmation,[mbYes,mbNo],0) = mrNo then
    abort
  else
    with A008FOperatoriDtM1.OperSQL do
    begin
      try
        SQL.Clear;
        if cmbFiltroFunzioni.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_FUNZIONI DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_FUNZIONI DEFAULT ''%s''',[cmbFiltroFunzioni.Text]));
        Execute;
        SQL.Clear;
        if cmbFiltroDizionario.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_DIZIONARIO DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_DIZIONARIO DEFAULT ''%s''',[cmbFiltroDizionario.Text]));
        Execute;
        SQL.Clear;
        if cmbPermessi.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY PERMESSI DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY PERMESSI DEFAULT ''%s''',[cmbPermessi.Text]));
        SQL.Clear;
        if cmbIterAutor.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY ITER_AUTORIZZATIVI DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY ITER_AUTORIZZATIVI DEFAULT ''%s''',[cmbIterAutor.Text]));
        Execute;
        R180MessageBox('Valori di default applicati correttamente.','INFORMA');
      except
        raise exception.create('Errore nell''applicazione dei valori di default.');
      end;
    end;
end;

procedure TA008FLoginDipendenti.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnTrigger.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  btnDefault.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  btnInserisciLogin.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  btnCancellaLogin.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  dcmbAzienda.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  cmbPermessi.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  cmbFiltroAnagrafe.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  cmbIterAutor.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  cmbNomeProfilo.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  cmbFiltroFunzioni.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
  cmbFiltroDizionario.Enabled:=not (DButton.State in [dsInsert, dsEdit]);
end;

procedure TA008FLoginDipendenti.TestExprLogin(var ODS:TOracleDataSet);
var ExprUtente,ExprPasswd:String;
begin
  ExprUtente:=VarToStr(A008FOperatoriDtM1.selI065U.Lookup('CODICE',cmbExprUtente.Text,'ESPRESSIONE'));
  ExprPasswd:=VarToStr(A008FOperatoriDtM1.selI065P.Lookup('CODICE',cmbExprPassword.Text,'ESPRESSIONE'));
  ODS:=TOracleDataset.Create(nil);
  ODS.Session:=A008FOperatoriDtM1.DbIris008B;
  ODS.SQL.Text:='SELECT :EXPR_UTENTE EXPR_UTENTE, :EXPR_PASSWORD EXPR_PASSWORD FROM T030_ANAGRAFICO T030, V430_STORICO V430 WHERE T030.PROGRESSIVO = T430PROGRESSIVO AND TO_DATE(''31123999'',''DDMMYYYY'')'+
                ' BETWEEN T430DATADECORRENZA AND T430DATAFINE AND T030.MATRICOLA = :MATRICOLA';
  ODS.DeclareVariable('MATRICOLA',otString);
  ODS.DeclareVariable('EXPR_UTENTE',otSubst);
  ODS.DeclareVariable('EXPR_PASSWORD',otSubst);
  if Trim(cmbExprUtente.Text) = '' then
    ODS.SetVariable('EXPR_UTENTE','MATRICOLA')
  else
    ODS.SetVariable('EXPR_UTENTE',ExprUtente);
  if Trim(cmbExprPassword.Text) = '' then
    ODS.SetVariable('EXPR_PASSWORD','NULL')
  else
    ODS.SetVariable('EXPR_PASSWORD',ExprPasswd);
  ODS.SetVariable('MATRICOLA',null);
  try
    ODS.Open;
  except
    on E:Exception do
      raise Exception.Create(Format(A000MSG_A186_ERR_FMT_ESPR_UT_PWD,[E.Message]));
  end;
end;

procedure TA008FLoginDipendenti.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Action <> caNone then
  begin
    DButton.DataSet:=nil;
    PutParametriFunzione;
    SessioneOracle.Commit;
    C004FParamForm.Free;
  end;
end;

procedure TA008FLoginDipendenti.FormDestroy(Sender: TObject);
begin
 inherited;
  //frmSelAnagrafe.DistruggiSelAnagrafe;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
  A008FOperatoriDtM1.QI090.AfterScroll:=A008FOperatoriDtM1.QI090AfterScroll;
  FreeAndNil(lstDominio);
end;

end.
