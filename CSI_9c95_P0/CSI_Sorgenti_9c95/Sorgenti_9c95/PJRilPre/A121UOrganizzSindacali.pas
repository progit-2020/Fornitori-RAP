unit A121UOrganizzSindacali;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList, Grids,
  DBGrids,A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, Variants,
  C013UCheckList, C180FunzioniGenerali, A121URecapitiSindacati,
  DateUtils, ToolbarFiglio, C600USelAnagrafe, System.Actions;

type
  TA121FOrganizzSindacali = class(TR004FGestStorico)
    pmnNew: TPopupMenu;
    NuovoElemento1: TMenuItem;
    PageControl2: TPageControl;
    tabOrganizzazioni: TTabSheet;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    dGrdRecapiti: TDBGrid;
    TabSheet2: TTabSheet;
    dGrdCompetenze: TDBGrid;
    Panel1: TPanel;
    lblCodMinisteriale: TLabel;
    lblDescrizione: TLabel;
    lblCodice: TLabel;
    lblFiltro: TLabel;
    lblSindacati: TLabel;
    dedtCodMinisteriale: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtCodice: TDBEdit;
    dedtFiltro: TDBEdit;
    chkRsu: TDBCheckBox;
    chkRaggruppamento: TDBCheckBox;
    dEdtSindacati: TDBEdit;
    btnSindacati: TBitBtn;
    tabOrganismi: TTabSheet;
    dGrdOrganismi: TDBGrid;
    dEdtVocePaghe: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    dlckCausaleCompetenze: TDBLookupComboBox;
    Label3: TLabel;
    dlckCausaleCompetenzeNo: TDBLookupComboBox;
    edtSindacati: TEdit;
    PopupMenu1: TPopupMenu;
    Annocorrente1: TMenuItem;
    frmToolbarFiglio1: TfrmToolbarFiglio;
    frmToolbarFiglio2: TfrmToolbarFiglio;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    procedure dlckCausaleCompetenzeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSindacatiClick(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure chkRaggruppamentoClick(Sender: TObject);
    procedure chkRsuClick(Sender: TObject);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure TCancClick(Sender: TObject);
    procedure Annocorrente1Click(Sender: TObject);
    procedure frmToolbarFiglio2actTFCancellaExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A121FOrganizzSindacali: TA121FOrganizzSindacali;

procedure OpenA121OrganizzSindacali(ValoreChiave:String);

implementation

uses A121UOrganizzSindacaliDtM;

{$R *.DFM}
procedure OpenA121OrganizzSindacali(ValoreChiave:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA121OrganizzSindacali') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA121FOrganizzSindacali, A121FOrganizzSindacali);
  Application.CreateForm(TA121FOrganizzSindacaliDtM, A121FOrganizzSindacaliDtM);
  A121FOrganizzSindacaliDtM.selT240.SearchRecord('CODICE',ValoreChiave,[srFromBeginning]);
  try
    A121FOrganizzSindacali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A121FOrganizzSindacali);
    FreeAndNil(A121FOrganizzSindacaliDtM);
  end;
end;

procedure TA121FOrganizzSindacali.FormShow(Sender: TObject);
begin
  inherited;
  //frmToolbarFiglio1
  dlckCausaleCompetenze.ListSource:=A121FOrganizzSindacaliDtM.A121MW.dsrT265;
  dlckCausaleCompetenzeNo.ListSource:=A121FOrganizzSindacaliDtM.A121MW.dsrT265;
  dGrdOrganismi.DataSource:=A121FOrganizzSindacaliDtM.A121MW.dsrT245;
  dGrdRecapiti.DataSource:=A121FOrganizzSindacaliDtM.A121MW.dsrT241;
  dGrdCompetenze.DataSource:=A121FOrganizzSindacaliDtM.A121MW.dsrT242;
  frmToolbarFiglio1.TFDButton:=A121FOrganizzSindacaliDtM.A121MW.dsrT242;
  frmToolbarFiglio1.TFDBGrid:=dgrdCompetenze;
  SetLength(frmToolbarFiglio1.lstLock,5);
  frmToolbarFiglio1.lstLock[0]:=Panel1;
  frmToolbarFiglio1.lstLock[1]:=File1;
  frmToolbarFiglio1.lstLock[2]:=Strumenti1;
  frmToolbarFiglio1.lstLock[3]:=ToolBar1;
  frmToolbarFiglio1.lstLock[4]:=grbDecorrenza;
  frmToolbarFiglio1.AbilitaAzioniTF(nil);
  //frmToolbarFiglio2
  frmToolbarFiglio2.TFDButton:=A121FOrganizzSindacaliDtM.A121MW.dsrT245;
  A121FOrganizzSindacaliDtM.A121MW.dsrT245.OnStateChange:=frmToolbarFiglio2.DButtonStateChange;
  frmToolbarFiglio2.ConfermaCancella:=False;
  frmToolbarFiglio2.TFDBGrid:=dgrdOrganismi;
  SetLength(frmToolbarFiglio2.lstLock,5);
  frmToolbarFiglio2.lstLock[0]:=Panel1;
  frmToolbarFiglio2.lstLock[1]:=File1;
  frmToolbarFiglio2.lstLock[2]:=Strumenti1;
  frmToolbarFiglio2.lstLock[3]:=ToolBar1;
  frmToolbarFiglio2.lstLock[4]:=grbDecorrenza;
  frmToolbarFiglio2.AbilitaAzioniTF(nil);
  VisioneCorrente1Click(nil);
  PageControl1.ActivePage:=TabSheet1;
  PageControl2.ActivePage:=TabOrganizzazioni;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
end;

procedure TA121FOrganizzSindacali.frmToolbarFiglio2actTFCancellaExecute(
  Sender: TObject);
begin
  inherited;
  with A121FOrganizzSindacaliDtM.A121MW do
    if selT245.RecordCount > 0 then
      if R180MessageBox(A000MSG_A121_DLG_CANCELLA_PARTECIPANTI,'DOMANDA') = mrYes then
      begin
        delCollegateOrg.SetVariable('CODICE',selT245.FieldByName('CODICE').AsString);
        delCollegateOrg.Execute;
        frmToolbarFiglio2.actTFCancellaExecute(nil);
      end;
end;

procedure TA121FOrganizzSindacali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  TabSheet2.Enabled:=DButton.State = dsBrowse;
  TabOrganismi.Enabled:=DButton.State = dsBrowse;
  pmnNew.AutoPopup:=DButton.State = dsBrowse;
  if dEdtSindacati.Enabled then
    btnSindacati.Enabled:=DButton.State in [dsInsert, dsEdit];
//  btnFiltro.Enabled:=DButton.State in [dsInsert, dsEdit];
  C600frmSelAnagrafe.Enabled:=DButton.State in [dsInsert, dsEdit];
end;

procedure TA121FOrganizzSindacali.btnSindacatiClick(Sender: TObject);
begin
  inherited;
  A121FOrganizzSindacaliDtM.A121MW.PreparaListaSindacati;
  // richiamo C013 per esplodere lista sindacati
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Elenco sindacati';
  with C013FCheckList do
    try
      clbListaDati.Items.Assign(A121FOrganizzSindacaliDtM.A121MW.ListaSindacati);
      R180PutCheckList(A121FOrganizzSindacaliDtM.selT240.FieldByName('SINDACATI_RAGGRUPPATI').AsString,10,clbListaDati);
      if ShowModal = mrOK then
        A121FOrganizzSindacaliDtM.selT240.FieldByName('SINDACATI_RAGGRUPPATI').AsString:=R180GetCheckList(10,clbListaDati);
    finally
      Free;
    end;
end;

procedure TA121FOrganizzSindacali.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=X;
  end;
begin
  inherited;
  C600frmSelAnagrafe.C600DataLavoro:=Date;
//  inherited;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=EliminaRitornoACapo(Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text));
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A121FOrganizzSindacaliDtM.selT240.FieldByName('FILTRO').AsString:=TrasformaV430(S);
  end;
end;

procedure TA121FOrganizzSindacali.btnFiltroClick(Sender: TObject);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=X;
  end;
begin
  inherited;
  C600frmSelAnagrafe.C600DataLavoro:=Date;
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A121FOrganizzSindacaliDtM.selT240.FieldByName('FILTRO').AsString:=TrasformaV430(S);
  end;
end;

procedure TA121FOrganizzSindacali.chkRaggruppamentoClick(Sender: TObject);
begin
  inherited;
  chkRsu.Enabled:=not chkRaggruppamento.Checked;
  dEdtSindacati.Enabled:=chkRaggruppamento.Checked;
  dEdtSindacati.Visible:=chkRaggruppamento.Checked;
  edtSindacati.Enabled:=(not chkRaggruppamento.Checked) and (not chkRsu.Checked);
  edtSindacati.Visible:=(not chkRaggruppamento.Checked);
  if dEdtSindacati.Enabled then
  begin
    btnSindacati.Enabled:=DButton.State in [dsInsert, dsEdit];
    lblSindacati.Caption:='Sindacati raggruppati';
  end
  else
  begin
    btnSindacati.Enabled:=False;
    lblSindacati.Caption:='Raggruppato in';
  end;
  lblSindacati.Enabled:=(chkRaggruppamento.Checked) or ((lblSindacati.Caption = 'Raggruppato in')and (not chkRsu.Checked));
end;

procedure TA121FOrganizzSindacali.chkRsuClick(Sender: TObject);
begin
  inherited;
  chkRaggruppamento.Enabled:=not chkRsu.Checked;
  edtSindacati.Enabled:=not chkRsu.Checked;
  lblSindacati.Enabled:=not chkRsu.Checked;
  if chkRsu.Checked then
    chkRaggruppamento.Checked:=False;
end;

procedure TA121FOrganizzSindacali.NuovoElemento1Click(Sender: TObject);
begin
  inherited;
  OpenA121RecapitiSindacati(A121FOrganizzSindacaliDtM.selT240.FieldByName('CODICE').AsString,
    A121FOrganizzSindacaliDtM.A121MW.selT241.FieldByName('TIPO_RECAPITO').AsString,A121FOrganizzSindacaliDtM.A121MW.selT241.FieldByName('PROG_RECAPITO').AsInteger);
//  A121FOrganizzSindacaliDtM.selT241.Refresh;
  actRefreshExecute(nil);
end;

procedure TA121FOrganizzSindacali.TCancClick(Sender: TObject);
begin
  //Cancellazione tabelle collegate
  if R180MessageBox(A000MSG_A121_DLG_CANCELLA_RECAPITI,'DOMANDA') = mrYes then
  begin
    A121FOrganizzSindacaliDtM.A121MW.CancellaCollegate;
    DButton.DataSet.Delete;
    SessioneOracle.Commit;
    NumRecords;
  end;
end;

procedure TA121FOrganizzSindacali.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA121FOrganizzSindacali.Annocorrente1Click(Sender: TObject);
begin
  inherited;
  A121FOrganizzSindacaliDtM.A121MW.FiltraAnnoCorrente(Annocorrente1.Checked);
end;

procedure TA121FOrganizzSindacali.dlckCausaleCompetenzeKeyDown(Sender: TObject;
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
end;

end.
