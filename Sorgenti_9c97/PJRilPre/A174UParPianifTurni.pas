unit A174UParPianifTurni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  A174UParPianifTurniDtm, ExtCtrls, StdCtrls, Mask, DBCtrls, C180FunzioniGenerali,
  A000USessione, A000UMessaggi , OracleData, C013UCheckList, A000UInterfaccia,
  System.Actions, Vcl.CheckLst;

type
  TA174FParPianifTurni = class(TR001FGestTab)
    PgCtrlParametri: TPageControl;
    TSheetVisualizzazione: TTabSheet;
    TSheetStampa: TTabSheet;
    lblCodProfilo: TLabel;
    dEdtCodice: TDBEdit;
    pnlTOP: TPanel;
    lblDescProfilo: TLabel;
    dEdtDesc: TDBEdit;
    lblTitolo: TLabel;
    dEdtTitolo: TDBEdit;
    lblDesc1: TLabel;
    dEdtDesc1: TDBEdit;
    dEdtDesc2: TDBEdit;
    lblDesc2: TLabel;
    Label1: TLabel;
    dEdtNotePagina: TDBEdit;
    drgDettStampa: TDBRadioGroup;
    drgRigheDip: TDBRadioGroup;
    dgrTipoStampa: TDBRadioGroup;
    grpDatiOpzionali: TGroupBox;
    dChkTotTurni: TDBCheckBox;
    dchkTotTurnoOpe: TDBCheckBox;
    dchkTotCopertura: TDBCheckBox;
    dChkToTurnitMese: TDBCheckBox;
    dChkDettOrari: TDBCheckBox;
    dChkTotLiquid: TDBCheckBox;
    dChkAssenze: TDBCheckBox;
    dChkSaldiOre: TDBCheckBox;
    lblMarginesx: TLabel;
    dEdtMgSx: TDBEdit;
    lblDimFont: TLabel;
    dEdtDimFont: TDBEdit;
    lblNumGG: TLabel;
    dEdtNumGG: TDBEdit;
    dCmbOPagina: TDBComboBox;
    lblOPagina: TLabel;
    dRgModLavoro: TDBRadioGroup;
    grpOpzioniPianif: TGroupBox;
    dChkPianifGGFest: TDBCheckBox;
    dChkPinifSoloTurnista: TDBCheckBox;
    dChkPianifGGAss: TDBCheckBox;
    dEdtEcludiCaus: TDBEdit;
    lblCauEsclusione: TLabel;
    btnCaus: TButton;
    dChkRigheNome: TDBCheckBox;
    dChkVisOrario: TDBCheckBox;
    dChkSeparatoreCol: TDBCheckBox;
    dChkSepratoreRighe: TDBCheckBox;
    lblDatoAnag: TLabel;
    dCmbDatoAnag: TDBLookupComboBox;
    grpBoxProgressiva: TGroupBox;
    dchkGenera: TDBCheckBox;
    dchkIniziale: TDBCheckBox;
    dchkCorrente: TDBCheckBox;
    dChkRendiOperativa: TDBCheckBox;
    dChkGiustifOperativi: TDBCheckBox;
    grpOrd_Visualizzazione: TGroupBox;
    lstElencoOrd: TListBox;
    lstOrdinamento: TListBox;
    lblListaDati: TLabel;
    lblOrdVis: TLabel;
    grpOrd_Stampa: TGroupBox;
    lstElencoOrdStampa: TListBox;
    lstOrdinamentoStampa: TListBox;
    lblListaDatiStampa: TLabel;
    lblOrdStampa: TLabel;
    procedure dCmbOPaginaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure dgrTipoStampaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dChkTotTurniClick(Sender: TObject);
    procedure btnCausClick(Sender: TObject);
    procedure drgDettStampaClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure dchkGeneraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dRgModLavoroClick(Sender: TObject);
    procedure lstElencoOrdDblClick(Sender: TObject);
    procedure lstOrdinamentoDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstOrdinamentoDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstOrdinamentoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lstOrdinamentoDblClick(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure TModifClick(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure lstElencoOrdStampaDblClick(Sender: TObject);
    procedure lstOrdinamentoStampaDblClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
  private
    StartingPoint:TPoint;
    procedure Abilitazioni;
    procedure OrdAbilitazioni(Stato:boolean);
  public
    { Public declarations }
  end;

var
  A174FParPianifTurni: TA174FParPianifTurni;

  procedure OpenA174ParPianifTurni(Profilo:String = '');

implementation

{$R *.dfm}

procedure OpenA174ParPianifTurni(Profilo:String = '');
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA174ParPianifTurni') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A174FParPianifTurni:=TA174FParPianifTurni.Create(nil);
  try
    A174FParPianifTurniDtm:=TA174FParPianifTurniDtm.Create(nil);
    if Trim(Profilo) <> '' then
      A174FParPianifTurniDtm.selT082.SearchRecord('CODICE',Profilo,[srFromBeginning]);
    A174FParPianifTurni.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A174FParPianifTurni);
    FreeAndNil(A174FParPianifTurniDtm);
  end;
end;

procedure TA174FParPianifTurni.OrdAbilitazioni(Stato:boolean);
begin
  lstElencoOrd.Enabled:=Stato;
  lstOrdinamento.Enabled:=Stato;
  lstElencoOrdStampa.Enabled:=Stato;
  lstOrdinamentoStampa.Enabled:=Stato;
end;

procedure TA174FParPianifTurni.actRefreshExecute(Sender: TObject);
begin
  inherited;
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_VIS',A174FParPianifTurni.lstOrdinamento.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_STAMPA',A174FParPianifTurni.lstOrdinamentoStampa.Items);
end;

procedure TA174FParPianifTurni.btnCausClick(Sender: TObject);
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  with TOracleDataSet.Create(Self) do
    try
      Session:=SessioneOracle;
      SQL.Add(A174FParPianifTurniDtm.A174MW.SqlCausali);
      Open;
      C013FCheckList.clbListaDati.Items.Clear;
      while not Eof do
      begin
        C013FCheckList.clbListaDati.Items.Add(Format('%-5s',[FieldByName('CODICE').AsString]) + ' ' +
                                                             FieldByName('DESCRIZIONE').AsString);
        Next;
      end;
      R180PutCheckList(A174FParPianifTurniDtm.selT082.FieldByName('CAUS_ECLUDITURNO').AsString,5,C013FCheckList.clbListaDati);
      C013FCheckList.ShowModal;
    finally
      if A174FParPianifTurniDtm.selT082.State in [dsInsert,dsEdit] then
        A174FParPianifTurniDtm.selT082.FieldByName('CAUS_ECLUDITURNO').AsString:=Trim(R180GetCheckList(5,C013FCheckList.clbListaDati));
      FreeAndNil(C013FCheckList);
      Free;
    end;
end;

procedure TA174FParPianifTurni.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = nil then
    Abilitazioni;
end;

procedure TA174FParPianifTurni.dchkGeneraClick(Sender: TObject);
begin
  inherited;
  if (DButton.State in [dsInsert,dsEdit]) and dchkGenera.Checked then
    DButton.DataSet.FieldByName('INIZIALE').AsString:='S';
end;

procedure TA174FParPianifTurni.dChkTotTurniClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.dCmbOPaginaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  if Control = dCmbOPagina then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A174FParPianifTurniDtm.A174MW.Orientamento[Index].Item);
end;

procedure TA174FParPianifTurni.Abilitazioni;
begin
  dChkRendiOperativa.Visible:=dRgModLavoro.ItemIndex = 1;
  dChkTotLiquid.Enabled:=dgrTipoStampa.ItemIndex = 1;
  if Not dChkTotLiquid.Enabled then
    dChkTotLiquid.Field.AsString:='N';
  dchkTotTurnoOpe.Enabled:=dChkTotTurni.Checked and (dgrTipoStampa.ItemIndex = 0);
  if Not dchkTotTurnoOpe.Enabled then
    dchkTotTurnoOpe.Field.AsString:='N';
  dChkVisOrario.Enabled:=drgDettStampa.ItemIndex = 0;
  if Not dChkVisOrario.Enabled then
    dChkVisOrario.Field.AsString:='N';
end;

procedure TA174FParPianifTurni.dgrTipoStampaClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.drgDettStampaClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.dRgModLavoroClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TA174FParPianifTurni.FormActivate(Sender: TObject);
begin
  inherited;
  dCmbDatoAnag.ListSource:=A174FParPianifTurniDtm.A174MW.dsrI010;
  R180SetComboItemsValues(dCmbOPagina.Items,A174FParPianifTurniDtm.A174MW.Orientamento,'V');
end;

procedure TA174FParPianifTurni.FormShow(Sender: TObject);
begin
  inherited;
  pgctrlParametri.ActivePageIndex:=0;
  grpBoxProgressiva.Visible:=Parametri.CampiRiferimento.C11_PianifOrariProg = 'S';
  //Visualizzazione tabellone
  A174FParPianifTurniDtm.A174MW.CaricaListaDatiOrdinamento(lstElencoOrd.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_VIS',A174FParPianifTurni.lstOrdinamento.Items);
  //Stampa tabellone
  A174FParPianifTurniDtm.A174MW.CaricaListaDatiOrdinamento(lstElencoOrdStampa.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_STAMPA',A174FParPianifTurni.lstOrdinamentoStampa.Items);
  OrdAbilitazioni(False);
end;

procedure TA174FParPianifTurni.lstElencoOrdDblClick(Sender: TObject);
begin
  inherited;
  if lstOrdinamento.Items.IndexOf(lstElencoOrd.Items[lstElencoOrd.ItemIndex]) < 0 then
    lstOrdinamento.Items.Add(lstElencoOrd.Items[lstElencoOrd.ItemIndex]);
end;

procedure TA174FParPianifTurni.lstElencoOrdStampaDblClick(Sender: TObject);
begin
  inherited;
  if lstOrdinamentoStampa.Items.IndexOf(lstElencoOrdStampa.Items[lstElencoOrdStampa.ItemIndex]) < 0 then
    lstOrdinamentoStampa.Items.Add(lstElencoOrdStampa.Items[lstElencoOrdStampa.ItemIndex]);
end;

procedure TA174FParPianifTurni.lstOrdinamentoDblClick(Sender: TObject);
begin
  inherited;
  lstOrdinamento.Items.Delete(lstOrdinamento.ItemIndex);
end;

procedure TA174FParPianifTurni.lstOrdinamentoDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  DropPosition,StartPosition:Integer;
  DropPoint:TPoint;
begin
  inherited;
  DropPoint.X:=X;
  DropPoint.Y:=Y;
  with Source as TListBox do
  begin
    StartPosition:=ItemAtPos(StartingPoint,True);
    DropPosition:=ItemAtPos(DropPoint,True);
    Items.Move(StartPosition,DropPosition);
  end;
end;

procedure TA174FParPianifTurni.lstOrdinamentoDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  Accept:=(Source = lstOrdinamento) or (Source = lstOrdinamentoStampa);
end;

procedure TA174FParPianifTurni.lstOrdinamentoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  StartingPoint.X:=X;
  StartingPoint.Y:=Y;
end;

procedure TA174FParPianifTurni.lstOrdinamentoStampaDblClick(Sender: TObject);
begin
  inherited;
  lstOrdinamentoStampa.Items.Delete(lstOrdinamentoStampa.ItemIndex);
end;

procedure TA174FParPianifTurni.TAnnullaClick(Sender: TObject);
begin
  inherited;
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_VIS',A174FParPianifTurni.lstOrdinamento.Items);
  A174FParPianifTurniDtm.A174MW.CaricaOrdinamento('ORD_STAMPA',A174FParPianifTurni.lstOrdinamentoStampa.Items);
  OrdAbilitazioni(False);
end;

procedure TA174FParPianifTurni.TInserClick(Sender: TObject);
begin
  inherited;
  OrdAbilitazioni(True);
end;

procedure TA174FParPianifTurni.TModifClick(Sender: TObject);
begin
  inherited;
  OrdAbilitazioni(True);
end;

procedure TA174FParPianifTurni.TRegisClick(Sender: TObject);
begin
  inherited;
  OrdAbilitazioni(False);
end;

end.
