unit WC015USelEditGridFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  DB, DBClient, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWDBGrids, medpIWDBGrid, Oracle, OracleData, IWCompButton, meIWButton,
  C190FunzioniGeneraliWeb, meIWGrid, meIWImageFile, meIWEdit, A000UCostanti, A000USessione,
  A000UInterfaccia, IWCompGrids, IWCompJQueryWidget, Vcl.Menus, IWCompLabel,
  meIWLabel, IWCompEdit, IWCompExtCtrls, medpIWImageButton, meIWImageButton,
  Vcl.Imaging.pngimage, meIWImage;

type
  TWC015ModalResultEvents = procedure(Sender: TObject; Result: Boolean) of object;
  TWC015DataSetEvent = procedure (Sender: TObject; Row: Integer)of object;
  TWC015InitializeEvent = procedure (Sender: TObject)of object;

  TWC015FSelEditGridFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    grdElenco: TmedpIWDBGrid;
    btnConferma: TmeIWButton;
    ppMnu: TPopupMenu;
    CopiaInExcel: TMenuItem;
    lblRicerca: TmeIWLabel;
    edtRicerca: TmeIWEdit;
    btnRicerca: TmeIWImage;
    procedure grdElencoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnChiudiClick(Sender: TObject);
    procedure grdElencoComponenti2DataSet(Row: Integer);
    procedure grdElencoDataSet2Componenti(Row: Integer);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure grdElencoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnRicercaClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    {private declaration}
    Titolo:string;
    FConfermaAutomatica: Boolean;
    procedure grdElencoRowClick;
  public
    {pubplc declaration}
    ResultEvent:TWC015ModalResultEvents;
    //Massimo 18/12/2012 aggiunto DataSetEvent per permettere al chiamante di ridefinire
    //componenti2dataSet, dataSet2Componenti e medppreparacomponeti
    DataSet2ComponentiEvent:TWC015DataSetEvent;
    Componenti2DataSetEvent:TWC015DataSetEvent;
    InizializzaEvent:TWC015InitializeEvent;
    //Massimo 18/12/2012 aggiunta property
    property grdTabella: TmedpIWDBGrid read grdElenco write grdElenco;
    property ConfermaAutomatica: Boolean read FConfermaAutomatica write FConfermaAutomatica;
    procedure Visualizza(Title:String;selElenco:TDataset;const ActiveEdit:Boolean = True;const AllowInsert:Boolean = True;const Conferma:Boolean = False;W:Integer = 700);
  end;

implementation

uses WR010UBase;

{$R *.dfm}

procedure TWC015FSelEditGridFM.Visualizza(Title:String;selElenco:TDataset;const ActiveEdit:Boolean = True;const AllowInsert:Boolean = True;const Conferma:Boolean = False;W:Integer = 700);
var Puntatore:TBookmark;
begin
  btnConferma.Visible:=Conferma;
  btnChiudi.Visible:=Conferma;
  grdElenco.Summary:=Format('Tabella per %s',[Title]);

  { DONE : TEST IW 15 }
  Puntatore:=selElenco.GetBookmark;
  try
    grdElenco.medpAttivaGrid(selElenco,ActiveEdit,AllowInsert);
    selElenco.GotoBookmark(Puntatore);
    grdElenco.medpAggiornaCDS(False);
    if Assigned(InizializzaEvent) then
    try
      InizializzaEvent(Self);
    except
      on E: EAbort do;
      on E: Exception do
        raise;
    end;
    Titolo:=Title;

    if FConfermaAutomatica then
      grdElenco.OnRowClick:=grdElencoRowClick;

    if Conferma then
      (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,W,-1,EM2PIXEL * 30, Titolo,'#wc015_container',False,True,-1,'','')
    else
      (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,W,-1,EM2PIXEL * 30, Titolo,'#wc015_container',True,True,-1,'','',btnChiudi.HTMLName);
  finally
    selElenco.FreeBookmark(Puntatore);
  end;
end;

procedure TWC015FSelEditGridFM.btnRicercaClick(Sender: TObject);
begin
  inherited;
  if grdElenco.medpDataSet <> nil then
  begin
    TOracleDataSet(grdElenco.medpDataSet).SearchRecord(grdElenco.medpSortField,edtRicerca.Text,[srFromBeginning,srIgnoreCase,srPartialMatch]);
    grdElenco.medpAggiornaCDS;
  end;
end;

procedure TWC015FSelEditGridFM.CopiaInExcelClick(Sender: TObject);
var NomeFile:String;
begin
  inherited;
  NomeFile:=Titolo + '.xls';
  NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
  (Self.Owner as TWR010FBase).InviaFile(NomeFile,grdElenco.ToCsv);
end;

procedure TWC015FSelEditGridFM.grdElencoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
begin
  inherited;
  lblRicerca.Visible:=btnConferma.Visible and (grdElenco.medpSortField <> '');
  edtRicerca.Visible:=btnConferma.Visible and (grdElenco.medpSortField <> '');
  btnRicerca.Visible:=btnConferma.Visible and (grdElenco.medpSortField <> '');
  if lblRicerca.Visible then
  begin
    lblRicerca.Caption:='Ricerca ' + grdElenco.medpDataSet.FieldByName(grdElenco.medpSortField).DisplayLabel;
    edtRicerca.Text:='';
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoComponenti2DataSet(Row: Integer);
begin
  inherited;
  if Assigned(Componenti2DataSetEvent) then
  try
    Componenti2DataSetEvent(Self,Row);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoDataSet2Componenti(Row: Integer);
begin
  inherited;
  if Assigned(DataSet2ComponentiEvent) then
  try
    DataSet2ComponentiEvent(Self,Row);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdElenco.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdElenco.medpCompGriglia) + 1) and (grdElenco.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdElenco.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoRowClick;
begin
  if FConfermaAutomatica then
    btnChiudiClick(btnConferma);
end;

procedure TWC015FSelEditGridFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  FConfermaAutomatica:=False;
  grdElenco.medpPaginazione:=True;
  grdElenco.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
end;

procedure TWC015FSelEditGridFM.btnChiudiClick(Sender: TObject);
var Res: Boolean;
begin
  if Sender = btnConferma then
    Res:=True
  else
    Res:=False;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Res);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  ReleaseOggetti;
  Free;
end;

end.
