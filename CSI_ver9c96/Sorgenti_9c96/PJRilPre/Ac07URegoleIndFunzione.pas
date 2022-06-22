unit Ac07URegoleIndFunzione;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Grids, DBGrids, DBCtrls, Buttons, Mask,
  C013UCheckList, C180FunzioniGenerali, A000USessione, A000UInterfaccia, A000UMessaggi,
  Oracle, OracleData, ToolbarFiglio, Math, StrUtils,
  ExtCtrls, System.Actions;

type
  TAc07FRegoleIndFunzione = class(TR004FGestStorico)
    pnlTestata: TPanel;
    pnlRiepilogo: TPanel;
    GroupBox1: TGroupBox;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdFasce: TDBGrid;
    lblContratto: TLabel;
    dcmbContratto: TDBLookupComboBox;
    lblCodice: TLabel;
    dlblCodice: TDBText;
    dcmbCodice: TDBLookupComboBox;
    dlblContratto: TDBText;
    lblAssenzeTollerate: TLabel;
    dedtAssenzeTollerate: TDBEdit;
    btnAssenzeTollerate: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DButtonStateChange(Sender: TObject);
    procedure frmToolbarFiglioactTFCancellaExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFInserisciExecute(Sender: TObject);
    procedure frmToolbarFiglioactTFModificaExecute(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure dcmbCodiceCloseUp(Sender: TObject);
    procedure dcmbCodiceKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dcmbCodiceKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dedtDecorrenzaExit(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure btnAssenzeCheckListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitaComponenti;
  end;

var
  Ac07FRegoleIndFunzione: TAc07FRegoleIndFunzione;

procedure OpenAc07RegoleIndFunzione;

implementation

uses Ac07URegoleIndFunzioneDM;

{$R *.dfm}

procedure OpenAc07RegoleIndFunzione;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenAc07RegoleIndFunzione') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TAc07FRegoleIndFunzione, Ac07FRegoleIndFunzione);
  Application.CreateForm(TAc07FRegoleIndFunzioneDM, Ac07FRegoleIndFunzioneDM);
  try
    Screen.Cursor:=crDefault;
    Ac07FRegoleIndFunzione.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Ac07FRegoleIndFunzioneDM.Free;
    Ac07FRegoleIndFunzione.Free;
  end;
end;

procedure TAc07FRegoleIndFunzione.FormShow(Sender: TObject);
var Cod:String;
begin
  inherited;
  chkStoriciPrec.Visible:=False;
  chkStoriciSucc.Visible:=False;
  btnStoricizza.Left:=chkStoriciPrec.Left;
  dgrdFasce.DataSource:=Ac07FRegoleIndFunzioneDM.Ac07MW.dsrCSI005;
  frmToolbarFiglio.TFDButton:=Ac07FRegoleIndFunzioneDM.Ac07MW.dsrCSI005;
  frmToolbarFiglio.TFDBGrid:=dgrdFasce;
  frmToolbarFiglio.RefreshDopoPost:=True;
  SetLength(frmToolbarFiglio.lstLock,4);
  (*frmToolbarFiglio.tlbarFiglio.HandleNeeded;//necessario per XE3
  //Per gestire i pulsanti quando CachedUpdate:=False; (si considera lo state della singola riga invece che tutta l'operazione di inserimento/modifica)
  Ac07FRegoleIndFunzioneDM.Ac07MW.dsrCSI005.OnStateChange:=frmToolbarFiglio.DButtonStateChange;*)
  frmToolbarFiglio.lstLock[0]:=ToolBar1;
  frmToolbarFiglio.lstLock[1]:=grbDecorrenza;
  frmToolbarFiglio.lstLock[2]:=File1;
  frmToolbarFiglio.lstLock[3]:=Strumenti1;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
  //Posizionamento sul periodo corrente
  with Ac07FRegoleIndFunzioneDM.Ac07MW.selCSI004 do
  begin
    Cod:=FieldByName('CODICE').AsString;
    while (FieldByName('CODICE').AsString = Cod) and not Eof do
    begin
      if (Parametri.DataLavoro >= FieldByName('DECORRENZA').AsDateTime)
      and (Parametri.DataLavoro <= FieldByName('DECORRENZA_FINE').AsDateTime) then
        Break;
      Next;
    end;
    RefreshRecord;
  end;
  AbilitaComponenti;
  if Trim(Parametri.CampiRiferimento.C3_Indennita_Funzione) = '' then
  begin
    ShowMessage(A000MSG_Ac07_ERR_CAMPO_RIFERIMENTO);
    Close;
  end;
  lblCodice.Caption:=R180Capitalize(Trim(Parametri.CampiRiferimento.C3_Indennita_Funzione));
  Ac07FRegoleIndFunzioneDM.Ac07MW.selCSI004.FieldByName('CODICE').DisplayLabel:=lblCodice.Caption;
  with Ac07FRegoleIndFunzioneDM.Ac07MW.selT210 do
    while not Eof do
    begin
      dgrdFasce.Columns[0].PickList.Add(FieldByName('CODICE').AsString);
      Next;
    end;
end;

procedure TAc07FRegoleIndFunzione.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if not ToolBar1.Enabled then
    Action:=caNone;
end;

procedure TAc07FRegoleIndFunzione.btnAssenzeCheckListClick(Sender: TObject);
var NomeCampo:String;
    C013:TC013FCheckList;
begin
  if not (DButton.State in [dsEdit,dsInsert]) then
    exit;
  C013:=TC013FCheckList.Create(nil);
  NomeCampo:='ASSENZE_TOLLERATE';
  with C013 do
    try
      clbListaDati.Items.Assign(Ac07FRegoleIndFunzioneDM.Ac07MW.ListaAssenze);
      R180PutCheckList(DButton.DataSet.FieldByName(NomeCampo).AsString,5,clbListaDati);
      if ShowModal = mrOK then
        DButton.DataSet.FieldByName(NomeCampo).AsString:=StringReplace(StringReplace(R180GetCheckList(5,clbListaDati),'*** A','',[]),'*** P','',[]);
    finally
      Free;
    end;
end;

procedure TAc07FRegoleIndFunzione.btnStoricizzaClick(Sender: TObject);
begin
  with Ac07FRegoleIndFunzioneDM.Ac07MW.selCSI004 do
  begin
    //Disabilito temporaneamente la SequenceField per far estrarre il nuovo id nel BeforePost, altrimenti qui ne estrae uno che non viene usato
    SequenceField.Sequence:='';
    SequenceField.Field:='';
    inherited;
    SequenceField.Sequence:='CSI004_ID';
    SequenceField.Field:='ID';
  end;
end;

procedure TAc07FRegoleIndFunzione.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TAc07FRegoleIndFunzione.dcmbCodiceCloseUp(Sender: TObject);
begin
  inherited;
  dlblCodice.Visible:=Trim(dcmbCodice.Text) <> '';
end;

procedure TAc07FRegoleIndFunzione.dcmbCodiceKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TAc07FRegoleIndFunzione.dcmbCodiceKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbCodiceCloseUp(nil);
end;

procedure TAc07FRegoleIndFunzione.dedtDecorrenzaExit(Sender: TObject);
var sTmp: String;
begin
  inherited;
  with Ac07FRegoleIndFunzioneDM do
    if selCSI004.State in [dsEdit,dsInsert] then
    begin
      Ac07MW.ImpostaDecorrenzaDatasetLookup;
      //reimposto campi per forzare reload del campo di lookup
      sTmp:=selCSI004.FieldByName('CODICE').AsString;
      selCSI004.FieldByName('CODICE').AsString:='';
      selCSI004.FieldByName('CODICE').AsString:=sTmp;
    end;
end;

procedure TAc07FRegoleIndFunzione.TAnnullaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TAc07FRegoleIndFunzione.frmToolbarFiglioactTFCancellaExecute(Sender: TObject);
begin
  frmToolbarFiglio.actTFCancellaExecute(Sender);
  AbilitaComponenti;
end;

procedure TAc07FRegoleIndFunzione.frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
begin
  frmToolbarFiglio.actTFAnnullaExecute(Sender);
end;

procedure TAc07FRegoleIndFunzione.frmToolbarFiglioactTFConfermaExecute(Sender: TObject);
begin
  frmToolbarFiglio.actTFConfermaExecute(Sender);
  AbilitaComponenti;
end;

procedure TAc07FRegoleIndFunzione.frmToolbarFiglioactTFInserisciExecute(Sender: TObject);
begin
  frmToolbarFiglio.actTFInserisciExecute(Sender);
end;

procedure TAc07FRegoleIndFunzione.frmToolbarFiglioactTFModificaExecute(Sender: TObject);
begin
  frmToolbarFiglio.actTFModificaExecute(Sender);
end;

procedure TAc07FRegoleIndFunzione.AbilitaComponenti;
begin
  with Ac07FRegoleIndFunzioneDM.Ac07MW do
  begin
    if selCSI004.Active then
    begin
      if selCSI004.State = dsBrowse then
        selCSI004.RefreshRecord;
      if frmToolbarFiglio.TFDButton <> nil then
        frmToolbarFiglio.AbilitaAzioniTF(nil);
    end;
    if selCSI005.Active then
    begin
      if selCSI005.State = dsBrowse then
        selCSI005.RefreshRecord;
    end;
  end;
end;

end.
