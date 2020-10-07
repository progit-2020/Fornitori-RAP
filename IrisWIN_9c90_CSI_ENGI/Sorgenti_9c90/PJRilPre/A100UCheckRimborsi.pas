unit A100UCheckRimborsi;

interface

uses
  A100UMissioniDtM, A100UCheckRimborsiMW, C700USelezioneAnagrafe,
  A000UInterfaccia, C180FunzioniGenerali, C004UParamForm,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions,
  Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.ActnMan, Vcl.ActnCtrls, ToolbarFiglio;

type
  TA100FCheckRimborsi = class(TR001FGestTab)
    tabPrincipale: TPageControl;
    tbsDatiLiberi: TTabSheet;
    tbsMezzi: TTabSheet;
    tbsRimborsi: TTabSheet;
    tbsIndKm: TTabSheet;
    frmToolbarFiglioDatiLiberi: TfrmToolbarFiglio;
    dgrdDatiLiberi: TDBGrid;
    frmToolbarFiglioMezzi: TfrmToolbarFiglio;
    dgrdMezzi: TDBGrid;
    dgrdRimborsi: TDBGrid;
    dgrdIndKm: TDBGrid;
    frmToolbarFiglioRimborsi: TfrmToolbarFiglio;
    frmToolbarFiglioIndKm: TfrmToolbarFiglio;
    pnlTop: TPanel;
    grpPeriodo: TGroupBox;
    lblPeriodoDal: TLabel;
    lblPeriodoAl: TLabel;
    edtPeriodoDal: TMaskEdit;
    edtPeriodoAl: TMaskEdit;
    rgpRimborsi: TRadioGroup;
    rgpStato: TRadioGroup;
    pnlMaster: TPanel;
    dgrdDatiMissione: TDBGrid;
    splMasterDetail: TSplitter;
    PopupMenu1: TPopupMenu;
    CopiaInExcel: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure rgpRimborsiClick(Sender: TObject);
    procedure rgpStatoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
  private
    procedure FiltraMissioni;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitazioneFiltri;
  end;

var
  A100FCheckRimborsi: TA100FCheckRimborsi;

implementation

{$R *.dfm}

procedure TA100FCheckRimborsi.FormCreate(Sender: TObject);
begin
  inherited;

  CreaC004(SessioneOracle,'A100',Parametri.ProgOper);
  GetParametriFunzione;

  // imposta il dataset principale
  DButton.DataSet:=A100FMISSIONIDTM.A100FCheckRimbMW.selM040CheckRimb_Funzioni;

  // apre il dataset delle missioni
  DButton.DataSet.Close;
  C700MergeSelAnagrafe(DButton.DataSet);
  C700MergeSettaPeriodo(DButton.DataSet,Parametri.DataLavoro,Parametri.DataLavoro);

  FiltraMissioni;
end;

procedure TA100FCheckRimborsi.FormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TA100FCheckRimborsi.GetParametriFunzione;
var
  IdxRimborsi, IdxStato: Integer;
begin
  IdxRimborsi:=StrToIntDef(C004FParamForm.GetParametro('RGPRIMBORSI',''),0);
  rgpRimborsi.OnClick:=nil;
  rgpRimborsi.ItemIndex:=IdxRimborsi;
  rgpRimborsi.OnClick:=rgpRimborsiClick;

  IdxStato:=StrToIntDef(C004FParamForm.GetParametro('RGPSTATO',''),2);
  rgpStato.OnClick:=nil;
  rgpStato.ItemIndex:=IdxStato;
  rgpStato.OnClick:=rgpStatoClick;

  AbilitazioneFiltri;
end;

procedure TA100FCheckRimborsi.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('RGPRIMBORSI',rgpRimborsi.ItemIndex.ToString);
  C004FParamForm.PutParametro('RGPSTATO',rgpStato.ItemIndex.ToString);
  SessioneOracle.Commit;
end;

procedure TA100FCheckRimborsi.FormShow(Sender: TObject);
begin
  inherited;

  // imposta i datasource dei detail
  dgrdDatiLiberi.DataSource:=A100FMissioniDtM.A100FCheckRimbMW.dsrM175;
  dgrdMezzi.DataSource:=A100FMissioniDtM.A100FCheckRimbMW.dsrM170;
  dgrdRimborsi.DataSource:=A100FMissioniDtM.A100FCheckRimbMW.dsrM051;
  dgrdIndKm.DataSource:=A100FMissioniDtM.A100FCheckRimbMW.dsrM052;

  // toolbar dati liberi
  frmToolbarFiglioDatiLiberi.TFDButton:=A100FMissioniDtM.A100FCheckRimbMW.dsrM175;
  frmToolbarFiglioDatiLiberi.TFDBGrid:=dgrdDatiLiberi;
  SetLength(frmToolbarFiglioDatiLiberi.lstLock,6);
  frmToolbarFiglioDatiLiberi.lstLock[0]:=Panel1;
  frmToolbarFiglioDatiLiberi.lstLock[1]:=File1;
  frmToolbarFiglioDatiLiberi.lstLock[2]:=Strumenti1;
  frmToolbarFiglioDatiLiberi.lstLock[3]:=frmToolbarFiglioMezzi;
  frmToolbarFiglioDatiLiberi.lstLock[4]:=frmToolbarFiglioRimborsi;
  frmToolbarFiglioDatiLiberi.lstLock[5]:=frmToolbarFiglioIndKm;
  frmToolbarFiglioDatiLiberi.AbilitaAzioniTF(nil);
  // toolbar mezzi di trasporto
  frmToolbarFiglioMezzi.TFDButton:=A100FMissioniDtM.A100FCheckRimbMW.dsrM170;
  frmToolbarFiglioMezzi.TFDBGrid:=dgrdMezzi;
  SetLength(frmToolbarFiglioMezzi.lstLock,6);
  frmToolbarFiglioMezzi.lstLock[0]:=Panel1;
  frmToolbarFiglioMezzi.lstLock[1]:=File1;
  frmToolbarFiglioMezzi.lstLock[2]:=Strumenti1;
  frmToolbarFiglioMezzi.lstLock[3]:=frmToolbarFiglioDatiLiberi;
  frmToolbarFiglioMezzi.lstLock[4]:=frmToolbarFiglioRimborsi;
  frmToolbarFiglioMezzi.lstLock[5]:=frmToolbarFiglioIndKm;
  frmToolbarFiglioMezzi.AbilitaAzioniTF(nil);
  // toolbar rimborsi
  frmToolbarFiglioRimborsi.TFDButton:=A100FMissioniDtM.A100FCheckRimbMW.dsrM051;
  frmToolbarFiglioRimborsi.TFDButton.OnStateChange:=frmToolbarFiglioRimborsi.DButtonStateChange;
  frmToolbarFiglioRimborsi.TFDBGrid:=dgrdRimborsi;
  SetLength(frmToolbarFiglioRimborsi.lstLock,6);
  frmToolbarFiglioRimborsi.lstLock[0]:=Panel1;
  frmToolbarFiglioRimborsi.lstLock[1]:=File1;
  frmToolbarFiglioRimborsi.lstLock[2]:=Strumenti1;
  frmToolbarFiglioRimborsi.lstLock[3]:=frmToolbarFiglioDatiLiberi;
  frmToolbarFiglioRimborsi.lstLock[4]:=frmToolbarFiglioMezzi;
  frmToolbarFiglioRimborsi.lstLock[5]:=frmToolbarFiglioIndKm;
  frmToolbarFiglioRimborsi.AbilitaAzioniTF(nil);
  // nasconde azioni di inserimento e cancellazione
  frmToolbarFiglioRimborsi.actTFInserisci.Visible:=False;
  frmToolbarFiglioRimborsi.actTFCancella.Visible:=False;
  // toolbar indennità km
  frmToolbarFiglioIndKm.TFDButton:=A100FMissioniDtM.A100FCheckRimbMW.dsrM052;
  frmToolbarFiglioIndKm.TFDButton.OnStateChange:=frmToolbarFiglioIndKm.DButtonStateChange;
  frmToolbarFiglioIndKm.TFDBGrid:=dgrdIndKm;
  SetLength(frmToolbarFiglioIndKm.lstLock,6);
  frmToolbarFiglioIndKm.lstLock[0]:=Panel1;
  frmToolbarFiglioIndKm.lstLock[1]:=File1;
  frmToolbarFiglioIndKm.lstLock[2]:=Strumenti1;
  frmToolbarFiglioIndKm.lstLock[3]:=frmToolbarFiglioDatiLiberi;
  frmToolbarFiglioIndKm.lstLock[4]:=frmToolbarFiglioMezzi;
  frmToolbarFiglioIndKm.lstLock[5]:=frmToolbarFiglioRimborsi;
  frmToolbarFiglioIndKm.AbilitaAzioniTF(nil);
  // nasconde azioni di inserimento e cancellazione
  frmToolbarFiglioIndKm.actTFInserisci.Visible:=False;
  frmToolbarFiglioIndKm.actTFCancella.Visible:=False;
end;

procedure TA100FCheckRimborsi.actRefreshExecute(Sender: TObject);
begin
  //inherited;
  FiltraMissioni;
end;

procedure TA100FCheckRimborsi.CopiaInExcelClick(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdDatiMissione,True,False);
end;

procedure TA100FCheckRimborsi.FiltraMissioni;
// applica i filtri sul dataset master delle missioni in base ai valori
// presenti sull'interfaccia
begin
  A100FMISSIONIDTM.A100FCheckRimbMW.FiltraMissioni(edtPeriodoDal.Text,edtPeriodoAl.Text,rgpRimborsi.ItemIndex,rgpStato.ItemIndex);
end;

procedure TA100FCheckRimborsi.AbilitazioneFiltri;
begin
  rgpStato.Enabled:=rgpRimborsi.ItemIndex <> 1;
  if not rgpStato.Enabled then
  begin
    rgpStato.OnClick:=nil;
    rgpStato.ItemIndex:=0;
    rgpStato.OnClick:=rgpStatoClick;
  end;
end;

procedure TA100FCheckRimborsi.rgpRimborsiClick(Sender: TObject);
begin
  AbilitazioneFiltri;
  FiltraMissioni;
end;

procedure TA100FCheckRimborsi.rgpStatoClick(Sender: TObject);
begin
  FiltraMissioni;
end;

end.
