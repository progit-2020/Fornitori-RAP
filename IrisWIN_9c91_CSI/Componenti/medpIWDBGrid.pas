unit medpIWDBGrid;

interface

uses
  // ***************************************************************************** //
  // *** ATTENZIONE!!! NON UTILIZZARE CLASSI PROPRIE DI MONDOEDP NELLE USES!!! *** //
  // ***************************************************************************** //
  meIWGrid, meIWImageFile, meIWLabel, meIWCheckBox,
  SysUtils, Classes, Controls, Math, StrUtils, Forms,
  DBClient, Db, OracleData, Oracle, Provider,
  Variants, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  IWAppForm, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,IWTMSBase,
  IWControl, IWCompGrids, IWDBGrids,
  IWGlobal, IWColor, IWCompGridCommon,
  IWTypes, IWCompExtCtrls,
  IWBaseInterfaces, IWHTMLTag, IWRenderContext,Menus,
  meIWEdit, meIWComboBox, medpIWMultiColumnComboBox, A000UCostanti, A000UMessaggi;

type
  TmedpDBGridColumnClick = procedure (ASender: TObject; const AValue: string) of object;
  TmedpDBGridColumnTitleClick = procedure (Sender: TObject) of object;
  TmedpDataSetBeforeScroll = procedure (DataSet: TDataSet) of object;
  TmedpDataSetAfterScroll = procedure (DataSet: TDataSet) of object;
  TmedpDataSourceDataChange = procedure (Sender: TObject; Field: TField) of object;
  TmedpIWDBGridRowEvent = procedure(Row:Integer) of object;
  TmedpIWDBGridProcedure = procedure of object;

  TCompRiga = record
    RowID: String;
    CompColonne: array of TIWCustomControl;
  end;

  TmedpCompGriglia = array of TCompRiga;

  TOnCaricaCDS = procedure(Sender: TObject; DBG_ROWID: String = '') of object;
  TOnBeforeOperazione = function(Sender: TObject): Boolean of object;
  TOnOperazione = procedure(Sender: TObject) of object;
  TOnmedpStatoChange = procedure of object;

  TmedpStato = (msBrowse,msInsert,msEdit);
  TmedpStatoInterno = (msiNone,msiCaricaCDS,msiAllineaRecordCDS);

  TComponenti = record
    Tipo:String;
    Formato:String;
    Elementi:String;
    Hint:String;
    Confirmation:String;
    Allineamento:String;
    Grid:Boolean;
    Riga:Integer;
    GridInRiga:Boolean;
  end;

  TPropCompGriglia = array of TComponenti;

  TmedpDescCompGriglia = record
    RigaIns:array of TPropCompGriglia;
    Riga:array of TPropCompGriglia;
    RigaWR102:array of TPropCompGriglia;
    RigaWR102R:array of TPropCompGriglia;
    RigaWR102I:array of TPropCompGriglia;
  end;

  TmedpIWDBGrid = class;

  TmedpIWDBGridNavBar = class(TmeIWGrid)
  private
    imgPrimo,
    imgPrec,
    imgSucc,
    imgUltimo: TmeIWImageFile;
    lblCurrent,
    lblCaption,
    lblCurrentRecord: TmeIWLabel;
    FBrowse: Boolean;
    FGrid: TmedpIWDBGrid;
    function  IsBrowse: Boolean;
    procedure SetBrowse(const Val: Boolean);
    procedure AbilitaPrimo(const Val: Boolean);
    procedure AbilitaPrec(const Val: Boolean);
    procedure AbilitaSucc(const Val: Boolean);
    procedure AbilitaUltimo(const Val: Boolean);
    procedure SetCurrentValue(const Val: String);
    procedure SetCurrentRecord(const Val: String);
    procedure grdNavBarRender(Sender: TObject);
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure ShowLink;
    procedure HideLink;
    property medpGrid: TmedpIWDBGrid read FGrid write FGrid;
    property Browse: Boolean read IsBrowse write SetBrowse;
    property CurrentValue: String write SetCurrentValue;
    property CurrentRecord: String write SetCurrentRecord;
  end;

  TmedpIWDBGrid = class(TIWDBGrid)
  private
    FPaginazione,
    FBrowse: Boolean;
    FSortField: String;
    FComandiCustom: Boolean;
    FComandiEdit: Boolean;
    FComandiInsert: Boolean;
    FEditMultiplo: Boolean;
    FComandoDelete: Boolean;
    FRowSelect: Boolean;
    FOrdinamentoColonne: Boolean;
    FRighePagina: Integer;
    FFixedColumns: Integer;
    FRowIdField: String;
    FTipoContatore: String;
    FContextMenu: TPopupMenu;
    FStato: TmedpStato;
    FStatoInterno: TmedpStatoInterno;
    FTestoNoRecord: String;
    grdNavBar: TmedpIWDBGridNavBar;
    RowCount: Integer;
    Offset: Integer;
    Limit: Integer;
    RowSelected: Integer;
    SalvaStileCellaVisibile, SalvaStileCellaCancella: String;
    FOnBeforeCaricaCDS: TOnCaricaCDS;
    FOnAfterCaricaCDS: TOnCaricaCDS;
    FOnmedpStatoChange: TOnmedpStatoChange;
    FOnDataSet2Componenti: TmedpIWDBGridRowEvent;
    FOnComponenti2DataSet: TmedpIWDBGridRowEvent;
    FOnInserisci: TOnOperazione;
    FOnModifica: TOnOperazione;
    FOnCancella: TOnOperazione;
    FOnCustom: TOnOperazione;
    FOnConferma: TOnOperazione;
    FOnAnnulla: TOnOperazione;
    FOnBeforeInserisci: TOnBeforeOperazione;
    FOnBeforeModifica: TOnBeforeOperazione;
    FOnBeforeCancella: TOnBeforeOperazione;
    FOnRowClick: TProc;
    cdsGrid: TClientDataSet;
    cdsrGrid: TDataSource;
    lstCampiVisibili: TStringList;
    function  IsPaginazione: Boolean;
    procedure SetPaginazione(const Val: Boolean);
    function  GetTipoContatore: String;
    function  GetContextMenu: TPopupMenu;
    procedure SetContextMenu(const Val: TPopupMenu);
    function  GetStato: TmedpStato;
    procedure SetStato(const Val: TmedpStato);
    function  GetRighePagina: Integer;
    procedure SetRighePagina(const Val: Integer);
    function  GetTestoNoRecord: String;
    procedure SetTestoNoRecord(const Val: String);
    function  IsBrowse: Boolean;
    procedure SetBrowse(const Val: Boolean);
    procedure AbilitaComandi(Abil: Boolean);
    procedure VisualizzaComandi(Vis: Boolean);
    procedure NavBarClick(Sender:TObject);
    procedure NavBarAggiorna;
    function  GetRowSelect: Boolean;
    procedure SetRowSelect(const Value: Boolean);
  protected
    LastConfermaPressed: TmeIWImageFile;
    bInibizioneEventoRowClick: boolean;
    procedure imgInserisciClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgCancellaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure TrasformaComponenti(FN:String;DaTestoAControlli: Boolean);
    procedure medpColumnTitleClick(Sender: TObject);
    procedure SetSortField(const Val: String);
  public
    medpCompGriglia:TmedpCompGriglia;
    medpDescCompGriglia:TmedpDescCompGriglia;
    Componenti: array of TComponenti;
    RigaInserimento:Boolean;
    RigheIntestazione:Integer;
    DisabilitaEventiDataset:Boolean;
    AggiornaRecord: TmedpIWDBGridProcedure;
    procedure medpAttivaGrid(SourceDataSet:TDataset;const ActiveEdit:Boolean = True;const AllowInsert:Boolean = True;const AllowDelete:Boolean = True);
    function  medpGetRowID: String;
    function  medpIndexColonna(Campo:String):Integer;
    function  medpColonna(const Campo:String):TIWDBGridColumn; overload;
    function  medpColonna(const Index:Integer):TIWDBGridColumn; overload;
    function  medpGetCurrPag:Integer;
    procedure medpClearCompGriglia;
    procedure medpResetComponenti(Row: Integer);
    procedure medpInizializzaCompGriglia(const ClearRigaWR102:Boolean = False);
    procedure medpEliminaColonne;
    procedure medpAggiungiRowClick(const _LinkField:String; _OnClick:TmedpDBGridColumnClick);
    function  medpIsColonnaRowClick(NumColonna: Integer): Boolean;
    procedure medpAggiungiColonna(_DataField,_Title,_LinkField:String; _OnClick:TmedpDBGridColumnClick; _OnTitleClick:TmedpDBGridColumnTitleClick = nil);
    procedure medpAbilitaComandi;
    procedure medpDisabilitaComandi;
    procedure medpVisualizzaComandi;
    procedure medpNascondiComandi;
    procedure medpCreaCDS;
    procedure medpCaricaCDS(const DBG_ROWID:String = '');
    procedure medpAggiornaCDS(const Ricarica: Boolean = True);
    procedure medpAllineaRecordCDS;
    procedure medpPreparaComponentiDefault;
    procedure medpPreparaComponenteGenerico(TipoRiga:String; i,j:Integer; Tipo:String; Formato:String; Elementi:String; Hint:String; Confirmation:String; Allineamento:String = ''; Grid: Boolean = False);
    function  GetStile(PComponente: TComponenti): String;
    procedure medpCreaComponenteGenerico(nr,nc:Integer; Componenti: array of TComponenti);
    function  medpValoreColonna(const Riga:Integer; const Colonna:String):String;
    function  medpRigaDiCompGriglia(RowID:String):Integer;
    function  medpRigaInserimento:Boolean;
    function  medpNumColonna(AColumn:Integer):Integer;
    function  medpCompCella(ARow,AColumn,AComponent:Integer): TIWCustomControl; overload;
    function  medpCompCella(ARow: Integer; AColumn: String; AComponent: Integer): TIWCustomControl; overload;
    function  medpRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer; const Intestazione,RigheAlterne:Boolean; const EvidenziaRigaSel:Boolean = True): Boolean;
    procedure medpRenderCellComp(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure medpResetOffset;
    function  medpCachedUpdates:Boolean;
    function  medpUpdatesPending:Boolean;
    procedure medpColumnClick(ASender: TObject; const AValue: string);

    procedure DataSet2Componenti(Row:Integer);
    procedure medpCreaColonne;
    procedure medpAnnulla(Row:Integer);
    procedure medpConferma(Row:Integer);
    procedure medpCancella;
    procedure medpModifica(EditOnDataset: Boolean);
    procedure medpInserisci(InsertOnDataset: Boolean);
    procedure medpCancellaRigaWR102;
    procedure medpElencoCampiVisibili(ElencoCampi: String);
    procedure medpRiconferma;
    function  ToCsv: String;

    property  medpOffset: Integer read Offset;
    property  medpStato: TmedpStato read GetStato write SetStato;
    property  medpStatoInterno: TmedpStatoInterno read FStatoInterno;
    property  medpPaginazione: Boolean read IsPaginazione write SetPaginazione;
    property  medpTestoNoRecord: String read GetTestoNoRecord write SetTestoNoRecord;
    property  medpRowIdField: String read FRowIdField write FRowIdField;
    property  medpSortField: String read FSortField write SetSortField;
    property  medpOrdinamentoColonne: Boolean read FOrdinamentoColonne write FOrdinamentoColonne;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  published
    medpClientDataSet:TClientDataSet;
    medpDataSet:TDataSet;
    medpDataSource:TDataSource;
    procedure set_Visible(Value: Boolean); override;
    property medpContextMenu: TPopupMenu read GetContextMenu write SetContextMenu;
    property medpTipoContatore: String read GetTipoContatore write FTipoContatore; // property per retrocompatibilità
    property medpRighePagina: Integer read GetRighePagina write SetRighePagina;
    property medpBrowse: Boolean read IsBrowse write SetBrowse;
    property medpRowSelect: Boolean read GetRowSelect write SetRowSelect;
    property medpEditMultiplo: Boolean read FEditMultiplo write FEditMultiplo;
    property medpFixedColumns: Integer read FFixedColumns write FFixedColumns;
    property medpComandiCustom: Boolean read FComandiCustom write FComandiCustom;
    property medpComandiEdit: Boolean read FComandiEdit write FComandiEdit;
    property medpComandiInsert: Boolean read FComandiInsert write FComandiInsert;
    property medpComandoDelete: Boolean read FComandoDelete write FComandoDelete;
    property OnBeforeCaricaCDS: TOnCaricaCDS read FOnBeforeCaricaCDS write FOnBeforeCaricaCDS;
    property OnAfterCaricaCDS: TOnCaricaCDS read FOnAfterCaricaCDS write FOnAfterCaricaCDS;
    property OnDataSet2Componenti: TmedpIWDBGridRowEvent read FOnDataSet2Componenti write FOnDataSet2Componenti;
    property OnComponenti2DataSet: TmedpIWDBGridRowEvent read FOnComponenti2DataSet write FOnComponenti2DataSet;
    property OnmedpStatoChange: TOnmedpStatoChange read FOnmedpStatoChange write FOnmedpStatoChange;
    property OnInserisci: TOnOperazione read FOnInserisci write FOnInserisci;
    property OnModifica: TOnOperazione read FOnModifica write FOnModifica;
    property OnCancella: TOnOperazione read FOnCancella write FOnCancella;
    property OnCustom: TOnOperazione read FOnCustom write FOnCustom;
    property OnConferma: TOnOperazione read FOnConferma write FOnConferma;
    property OnAnnulla: TOnOperazione read FOnAnnulla write FOnAnnulla;
    property OnBeforeInserisci:TOnBeforeOperazione read FOnBeforeInserisci write FOnBeforeInserisci;
    property OnBeforeModifica: TOnBeforeOperazione read FOnBeforeModifica write FOnBeforeModifica;
    property OnBeforeCancella: TOnBeforeOperazione read FOnBeforeCancella write FOnBeforeCancella;
    property OnRowClick: TProc read FOnRowClick write FOnRowClick;
  end;

implementation

uses A000UInterfaccia;
// ***************************************************************************** //
// *** ATTENZIONE!!! NON UTILIZZARE CLASSI PROPRIE DI MONDOEDP NELLE USES!!! *** //
// ***************************************************************************** //


// ********************************************************************************************* //
// **********************************   TmedpIWDBGridNavBar   ********************************** //
// ********************************************************************************************* //

constructor TmedpIWDBGridNavBar.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  OnRender:=grdNavBarRender;
end;

destructor TmedpIWDBGridNavBar.Destroy;
begin
  FreeAndNil(imgPrimo);
  FreeAndNil(imgPrec);
  FreeAndNil(imgSucc);
  FreeAndNil(imgUltimo);
  FreeAndNil(lblCurrent);
  FreeAndNil(lblCaption);
  FreeAndNil(lblCurrentRecord);
  inherited;
end;

procedure TmedpIWDBGridNavBar.grdNavBarRender(Sender: TObject);
begin
  if Assigned(FGrid) then
  begin
    // mantenere questa riga (v. anche override di set_Visible della grid principale)
    Visible:=FGrid.Visible;

    // aggiorna caption
    if Assigned(lblCaption) then
      lblCaption.Caption:=FGrid.Caption;
  end;
end;

function TmedpIWDBGridNavBar.IsBrowse: Boolean;
begin
  Result:=FBrowse;
end;

procedure TmedpIWDBGridNavBar.SetBrowse(const Val: Boolean);
begin
  AbilitaPrimo(Val);
  AbilitaPrec(Val);
  AbilitaSucc(Val);
  AbilitaUltimo(Val);
  FBrowse:=Val;
end;

procedure TmedpIWDBGridNavBar.AbilitaPrimo(const Val: Boolean);
begin
  if imgPrimo <> nil then
  begin
    imgPrimo.Enabled:=Val;
    imgPrimo.ImageFile.FileName:=IfThen(Val,filebtnPrimo,filebtnPrimoDisab);
  end;
end;

procedure TmedpIWDBGridNavBar.AbilitaPrec(const Val: Boolean);
begin
  if imgPrec <> nil then
  begin
    imgPrec.Enabled:=Val;
    imgPrec.ImageFile.FileName:=IfThen(Val,filebtnPrec,filebtnPrecDisab);
  end;
end;

procedure TmedpIWDBGridNavBar.AbilitaSucc(const Val: Boolean);
begin
  if imgSucc <> nil then
  begin
    imgSucc.Enabled:=Val;
    imgSucc.ImageFile.FileName:=IfThen(Val,filebtnSucc,filebtnSuccDisab);
  end;
end;

procedure TmedpIWDBGridNavBar.AbilitaUltimo(const Val: Boolean);
begin
  if imgUltimo <> nil then
  begin
    imgUltimo.Enabled:=Val;
    imgUltimo.ImageFile.FileName:=IfThen(Val,filebtnUltimo,filebtnUltimoDisab);
  end;
end;

procedure TmedpIWDBGridNavBar.SetCurrentValue(const Val: String);
begin
  lblCurrent.Caption:=Val;
end;

procedure TmedpIWDBGridNavBar.SetCurrentRecord(const Val: String);
begin
  lblCurrentRecord.Css:=IfThen(Val = '','invisibile','contatore align_right');
  lblCurrentRecord.Caption:=Val;
end;

procedure TmedpIWDBGridNavBar.ShowLink;
begin
  imgPrimo.Css:='';
  imgPrec.Css:='';
  imgSucc.Css:='';
  imgUltimo.Css:='';
end;

procedure TmedpIWDBGridNavBar.HideLink;
begin
  imgPrimo.Css:='invisibile';
  imgPrec.Css:='invisibile';
  imgSucc.Css:='invisibile';
  imgUltimo.Css:='invisibile';
end;



// ********************************************************************************************* //
// ************************************   TmedpIWDBGrid   ************************************** //
// ********************************************************************************************* //


constructor TmedpIWDBGrid.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  with BorderColors do
  begin
    Color:=clWebWHITE;
    Dark:=clWebWHITE;
    Light:=clWebWHITE;
  end;
  BorderSize:=0;
  BorderStyle:=tfVoid;
  Caption:='';
  CellPadding:=0;
  CellRenderOptions:=[];
  CellSpacing:=0;
  Css:='grid';
  Font.Enabled:=False;
  with StyleRenderOptions do
  begin
    RenderAbsolute:=False;
    RenderFont:=False;
    RenderPosition:=False;
    RenderSize:=False;
    RenderZIndex:=False;
   	{ DONE : TEST IW 15 }
   	RenderBorder:=False;
  end;
  RowClick:=True;
  UseFrame:=False;
  UseSize:=False;

  medpRowIdField:='';
  RigaInserimento:=False;
  medpComandiCustom:=False;
  medpComandiEdit:=False;
  medpComandiInsert:=False;
  medpComandoDelete:=False;
  RigheIntestazione:=0;
  DisabilitaEventiDataset:=True;

  medpBrowse:=True;
  FPaginazione:=False;
  medpRighePagina:=-1;
  FTipoContatore:='P';
  FRowSelect:=True;
  medpEditMultiplo:=False;
  medpFixedColumns:=0;
  FStatoInterno:=msiNone;
  FTestoNoRecord:='Nessun record';
  FContextMenu:=nil;
  FOrdinamentoColonne:=True;
  lstCampiVisibili:=TStringList.Create;
  LastConfermaPressed:=nil;

  OnRenderCell:=medpRenderCellComp;
  bInibizioneEventoRowclick:=False;
  { DONE : TEST IW 15 }
  HeaderRowCount:=0;
end;

destructor TmedpIWDBGrid.Destroy;
begin
  { DONE : TEST IW 15 }
  // FreeAndNil(grdNavBar); // Destroy() già richiamato da IW
  //medpClearCompGriglia; // Destroy() dei componenti interni già richiamato da IW (ex-automatismo aggiunto da daniloc - 12.09.2011)
  FreeAndNil(lstCampiVisibili);
  inherited;
end;

function TmedpIWDBGrid.ToCsv: String;
var
  Riga,Campo,Valore,Uguale: String;
  BM: TBookMark;
  i: Integer;
  Col: TIWDBGridColumn;
begin
  Result:='';

  // utilizza il dataset collegato via datasource alla grid
  if not Assigned(medpDataset) then
    raise Exception.Create(Format('dataset della tabella %s non assegnato',[Name]));

  // intestazione
  Riga:='';
  for i:=0 to Columns.Count - 1 do
  begin
    Campo:=UpperCase((Columns.Items[i] as TIWDBGridColumn).DataField);
    Col:=medpColonna(Campo);
    if (Copy(Campo,1,4) <> 'DBG_') and
       (Col.Visible) then
      Riga:=Riga + Format('"%s"',[Col.Title.Text]) + #9;
  end;
  Result:=Result + Riga + #13#10;

  // dettaglio
  { DONE : TEST IW 15 }
  BM:=medpDataset.Bookmark;
  try
    medpDataset.First;
    while not medpDataset.Eof do
    begin
    Riga:='';
    for i:=0 to Columns.Count - 1 do
    begin
      Campo:=UpperCase((Columns.Items[i] as TIWDBGridColumn).DataField);
      Col:=medpColonna(Campo);
      if (Copy(Campo,1,4) <> 'DBG_') and
       (Col.Visible) then
      begin
      try
        Valore:=medpDataset.FieldByName(Campo).AsString;
      except
        Valore:='';
      end;
      Uguale:=IfThen((medpDataset.FieldByName(Campo).DataType = ftString) and (Pos(CRLF,Valore) = 0),'=');//campo stringa su una riga
      Riga:=Riga + Format('%s"%s"',[Uguale,Valore]) + #9;
      end;
    end;
    Result:=Result + Riga + #13#10;
    medpDataset.Next;
    end;

    // riposizionamento cursore
    try
      if {$IFNDEF VER185}(Length(BM) > 0) and{$ENDIF}
       (medpDataset.BookmarkValid(BM)) then
      medpDataset.GotoBookmark(BM);
    except
    end;
  finally
	  medpDataset.FreeBookmark(BM);
  end;
end;

procedure TmedpIWDBGrid.medpAttivaGrid(SourceDataSet:TDataset;const ActiveEdit:Boolean = True;const AllowInsert:Boolean = True;const AllowDelete:Boolean = True);
begin
  if cdsGrid = nil then
  begin
    cdsGrid:=TClientDataSet.Create(Self.Owner);
    cdsrGrid:=TDataSource.Create(Self.Owner);
  end;
  cdsrGrid.DataSet:=cdsGrid;

  medpDataSet:=SourceDataSet;
  DataSource:=cdsrGrid;

  medpComandiEdit:=ActiveEdit;
  medpComandiInsert:=AllowInsert;
  medpComandoDelete:=AllowDelete;
  medpCreaColonne;
end;

procedure TmedpIWDBGrid.NavBarClick(Sender:TObject);
// gestione del click sui pulsanti di navigazione pagina
var
  NumRecord:Integer;
  Primo,Prec,Succ,Ultimo:Boolean;
  Tipo:Char;
  S:String;
begin
  if not(Sender is TmeIWImageFile) then
    Exit;

  S:=TmeIWImageFile(Sender).Name;
  NumRecord:=medpDataSet.RecordCount;
  Primo:=False;
  Prec:=False;
  Succ:=False;
  Ultimo:=False;

  // ricava il tipo di pulsante premuto
  Tipo:=R180CarattereDef(S,4,#0);
  case Tipo of
    '0': Primo:=True;
    '1': Prec:=True;
    '2': Succ:=True;
    '3': Ultimo:=True;
  end;

  if NumRecord = 0 then
  begin
    // nessun record -> nessuna operazione
    Offset:=0;
    RowSelected:=0;
  end
  else
  begin
    // ricalcola offset
    if Primo then
      Offset:=0
    else if Prec then
      Offset:=max(Offset - FRighePagina,0)
    else if Succ then
    begin
      if Offset + FRighePagina <= NumRecord - 1 then
        Offset:=Offset + FRighePagina;
    end
    else if Ultimo then
      Offset:=(max(NumRecord - 1,0) div FRighePagina) * FRighePagina;

    // determina la riga selezionata in base all'offset
    RowSelected:=(Offset mod FRighePagina) + 1;

    // esegue popolamento grid
    medpCaricaCDS;
  end;
end;

function TmedpIWDBGrid.medpGetCurrPag:Integer;
// Restituisce la pagina corrente
var
  NumRecord,LimInf,LimSup:Integer;
begin
  Result:=0;
  if not medpDataSet.Active then
    Exit;

  NumRecord:=medpDataSet.RecordCount;

  // imposta default se paginazione non è attiva
  if not FPaginazione then
  begin
    Result:=0;
    Exit;
  end;

  // verifica offset e quindi ricalcola limite e rowcount della grid
  LimInf:=0;
  LimSup:=(max(NumRecord - 1,0) div FRighePagina) * FRighePagina;
  if Offset > LimSup then
    Offset:=LimSup;
  if Offset < LimInf then
    Offset:=LimInf;

  Result:=Offset div FRighePagina + 1;
end;

procedure TmedpIWDBGrid.NavBarAggiorna;
// aggiorna visualizzazione del contatore di record / pagine
var
  NumRecord,recDa,recA,recTot,pagCurr,pagTot,LimInf,LimSup:Integer;
begin
  if not Assigned(medpDataSet) then
    Exit;

  if not medpDataSet.Active then
    Exit;

  if grdNavBar <> nil then
    grdNavBar.Parent:=Self.Parent;

  NumRecord:=medpDataSet.RecordCount;

  // imposta default se paginazione non è attiva
  if not FPaginazione then
  begin
    Offset:=0;
    Limit:=NumRecord - 1;
    RowCount:=Limit + 2;
    Exit;
  end;

  // verifica offset e quindi ricalcola limite e rowcount della grid
  LimInf:=0;
  LimSup:=(max(NumRecord - 1,0) div FRighePagina) * FRighePagina;
  if Offset > LimSup then
    Offset:=LimSup;
  if Offset < LimInf then
    Offset:=LimInf;

  Limit:=min(NumRecord,Offset + FRighePagina) - 1;
  RowCount:=Limit - Offset + 2;

  // aggiorna label contatore
  if NumRecord = 0 then
  begin
    grdNavBar.CurrentValue:=FTestoNoRecord;
    grdNavBar.CurrentRecord:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_REC),[0,0,0]);
    grdNavBar.HideLink;
  end
  else
  begin
    // calcoli per num. record
    recDa:=Offset + 1;
    recA:=Limit + 1;
    recTot:=NumRecord;

    // calcoli per num pagine
    pagCurr:=Offset div FRighePagina + 1;
    pagTot:=(NumRecord div FRighePagina) + IfThen(NumRecord mod FRighePagina > 0,1);

    // contatore in formato numero pagine
    grdNavBar.CurrentValue:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_PAG),[pagCurr,pagTot]);

    // num. record
    grdNavBar.CurrentRecord:=Format(A000TraduzioneStringhe(A000MSG_FMT_PAGIN_COUNT_REC),[recDa,recA,recTot]);

    // se num. pag. totale è maggiore di 1 visualizza le immagini per la navigazione
    if pagTot > 1 then
    begin
      grdNavBar.ShowLink;
      grdNavBar.AbilitaPrimo(Offset > 0);
      grdNavBar.AbilitaPrec(Offset - FRighePagina >= 0);
      grdNavBar.AbilitaSucc(Offset + FRighePagina <= NumRecord - 1 );
      grdNavBar.AbilitaUltimo(recA < recTot);
    end
    else
      grdNavBar.HideLink;
  end;
end;

function TmedpIWDBGrid.IsPaginazione: Boolean;
begin
  Result:=FPaginazione;
end;

procedure TmedpIWDBGrid.SetPaginazione(const Val: Boolean);
var
  Nome: String;
  FormOwner: TIWAppForm;
  PrimaEsecuzione: Boolean;
begin
  // creazione iniziale grid di navigazione
  PrimaEsecuzione:=not Assigned(grdNavBar);
  FormOwner:=C190GetMainOwner(Self);
  if PrimaEsecuzione then
  begin
    Nome:=StringReplace(Self.Name,'grd','PagNavBar',[]);
    grdNavBar:=TmedpIWDBGridNavBar.Create(Self.Owner);
    with grdNavBar do
    begin
      Parent:=Self.Parent;
      Name:=Nome;
      BorderSize:=0;
      Caption:='';
      Css:='';
      Height:=1;
      RowCount:=1;
      Top:=-25;
      Left:=Self.Left;
      UseSize:=False;
      Width:=1;
      medpGrid:=Self;

      // label caption tabella
      lblCaption:=TmeIWLabel.Create(Self.Owner);
      with lblCaption do
      begin
        Parent:=FormOwner;
        Name:=Format('lbl%sCaption',[Nome]);
        Caption:=medpGrid.Caption;
        Css:='tblCaption';
        ControlStyle:=ControlStyle + [csNoDesignVisible];
        Height:=1;
        Width:=1;
        Left:=Self.Left;
        Top:=-25;
      end;
    end;
  end;

  if (Val = FPaginazione) and (not PrimaEsecuzione) then
    Exit;

  if Val then
  begin
    with grdNavBar do
    begin
      ColumnCount:=7;

      // primo
      imgPrimo:=TmeIWImageFile.Create(Self.Owner);
      with imgPrimo do
      begin
        Parent:=FormOwner;
        Name:=Format('img0%s',[Nome]);
        //Caratto 21/02/2013 Cambio nome componenti per gestione cambio parent a runtime
        Name:=C190CreaNomeComponente(Name,Self.Owner);

        ImageFile.FileName:=filebtnPrimo;
        Hint:=A000TraduzioneStringhe(A000MSG_PAGIN_PRIMA_PAG);
        AltText:=Hint;
        OnClick:=NavBarClick;
        Height:=1;
        Width:=1;
        Left:=Self.Left;
        Top:=-25;
      end;

      // precedente
      imgPrec:=TmeIWImageFile.Create(Self.Owner);
      with imgPrec do
      begin
        Parent:=FormOwner;
        Name:=Format('img1%s',[Nome]);
        //Caratto 21/02/2013 Cambio nome componenti per gestione cambio parent a runtime
        Name:=C190CreaNomeComponente(Name,Self.Owner);

        ImageFile.FileName:=filebtnPrec;
        Hint:=A000TraduzioneStringhe(A000MSG_PAGIN_PAG_PREC);
        AltText:=Hint;
        OnClick:=NavBarClick;
        Height:=1;
        Width:=1;
        Left:=Self.Left;
        Top:=-25;
      end;

      // label con contatore di righe / pag.
      lblCurrent:=TmeIWLabel.Create(Self.Owner);
      with lblCurrent do
      begin
        Parent:=FormOwner;
        Name:=Format('lbl%sCurr',[Nome]);
        //Caratto 21/02/2013 Cambio nome componenti per gestione cambio parent a runtime
        Name:=C190CreaNomeComponente(Name,Self.Owner);

        Caption:='';
        //Hint:=FTestoNoRecord;
        ShowHint:=True;
        Css:='contatore';
        ControlStyle:=ControlStyle + [csNoDesignVisible];
        Height:=1;
        Width:=1;
        Left:=Self.Left;
        Top:=-25;
      end;

      // successivo
      imgSucc:=TmeIWImageFile.Create(Self.Owner);
      with imgSucc do
      begin
        Parent:=FormOwner;
        Name:=Format('img2%s',[Nome]);
        //Caratto 21/02/2013 Cambio nome componenti per gestione cambio parent a runtime
        Name:=C190CreaNomeComponente(Name,Self.Owner);

        ImageFile.FileName:=filebtnSucc;
        Hint:=A000TraduzioneStringhe(A000MSG_PAGIN_PAG_SUCC);
        AltText:=Hint;
        OnClick:=NavBarClick;
        Height:=1;
        Width:=1;
        Left:=Self.Left;
        Top:=-25;
      end;

      // ultimo
      imgUltimo:=TmeIWImageFile.Create(Self.Owner);
      with imgUltimo do
      begin
        Parent:=FormOwner;
        Name:=Format('img3%s',[Nome]);
        //Caratto 21/02/2013 Cambio nome componenti per gestione cambio parent a runtime
        Name:=C190CreaNomeComponente(Name,Self.Owner);

        ImageFile.FileName:=filebtnUltimo;
        Hint:=A000TraduzioneStringhe(A000MSG_PAGIN_ULTIMA_PAG);
        AltText:=Hint;
        OnClick:=NavBarClick;
        Height:=1;
        Width:=1;
        Left:=Self.Left;
        Top:=-25;
      end;

      // label numero record
      lblCurrentRecord:=TmeIWLabel.Create(Self.Owner);
      with lblCurrentRecord do
      begin
        Parent:=FormOwner;
        Name:=Format('lbl%sRecord',[Nome]);
        //Caratto 21/02/2013 Cambio nome componenti per gestione cambio parent a runtime
        Name:=C190CreaNomeComponente(Name,Self.Owner);

        Caption:='Record 0 di 0';
        Css:='contatore align_right';
        ControlStyle:=ControlStyle + [csNoDesignVisible];
        Height:=1;
        Width:=1;
        Left:=Self.Left;
        Top:=-25;
      end;

      // attribuzione controlli alle celle
      Cell[0,0].Control:=imgPrimo;
      Cell[0,0].Width:='0'; // il valore di default è 0 e non ''
      Cell[0,0].Alignment:=taLeftJustify;
      Cell[0,1].Control:=imgPrec;
      Cell[0,1].Width:='0';
      Cell[0,2].Control:=lblCurrent;
      Cell[0,3].Control:=imgSucc;
      Cell[0,3].Width:='0';
      Cell[0,4].Control:=imgUltimo;
      Cell[0,4].Width:='0';
      Cell[0,5].Control:=lblCaption;
      Cell[0,5].Width:='99%';
      Cell[0,5].Alignment:=taCenter;
      Cell[0,6].Control:=lblCurrentRecord;
      Cell[0,6].Alignment:=taRightJustify;
    end;

    // se righepagina è negativo imposta un default
    if FRighePagina = -1 then
      FRighePagina:=15;
  end
  else
  begin
    with grdNavBar do
    begin
      ColumnCount:=1;
      // attribuzione controlli alle celle (solo caption)
      Cell[0,0].Control:=lblCaption;
      Cell[0,0].Width:='99%';
      Cell[0,0].Alignment:=taCenter;
    end;

    // valore elevato per righepagina
    FRighePagina:=999999;
  end;

  FPaginazione:=Val;
end;

function TmedpIWDBGrid.GetTipoContatore: String;
begin
  Result:=FTipoContatore;
end;

procedure TmedpIWDBGrid.set_Visible(Value: Boolean);
begin
  inherited;
  if Assigned(grdNavBar) then
    grdNavBar.Visible:=Value;
end;

function TmedpIWDBGrid.GetContextMenu: TPopupMenu;
begin
  Result:=FContextMenu;
end;

procedure TmedpIWDBGrid.SetContextMenu(const Val: TPopupMenu);
begin
  FContextMenu:=Val;
end;

function TmedpIWDBGrid.GetStato: TmedpStato;
begin
  Result:=FStato;
end;

procedure TmedpIWDBGrid.SetStato(const Val: TmedpStato);
var Changed:Boolean;
begin
  Changed:=False;
  if FStato <> Val then
    Changed:=True;

  FStato:=Val;

  if Changed then
    if Assigned(OnmedpStatoChange) then
      OnmedpStatoChange;
end;

function TmedpIWDBGrid.GetRowSelect: Boolean;
begin
  Result:=FRowSelect;
end;

procedure TmedpIWDBGrid.SetRowSelect(const Value: Boolean);
begin
  if Value <> FRowSelect then
  begin
    if Value then
      medpAggiungiRowClick('DBG_ROWID',medpColumnClick);
    //else
    //  medpRimuoviRowClick

    FRowSelect:=Value;
  end;
end;

function TmedpIWDBGrid.GetRighePagina: Integer;
begin
  if FPaginazione then
    Result:=FRighePagina
  else
    Result:=-1;
end;

procedure TmedpIWDBGrid.SetRighePagina(const Val: Integer);
begin
  if FPaginazione then
  begin
    if Val <= 0 then
      medpPaginazione:=False
    else
      FRighePagina:=Val;
  end
  else
  begin
    if Val > 0 then
    begin
      medpPaginazione:=True;
      FRighePagina:=Val;
    end
    else
      // valore elevato
      FRighePagina:=999999;
  end;
end;

function TmedpIWDBGrid.GetTestoNoRecord: String;
begin
  Result:=FTestoNoRecord;
end;

procedure TmedpIWDBGrid.SetTestoNoRecord(const Val: String);
begin
  FTestoNoRecord:=Val;
end;

function TmedpIWDBGrid.IsBrowse: Boolean;
begin
  Result:=FBrowse;
end;

procedure TmedpIWDBGrid.SetBrowse(const Val: Boolean);
begin
  // navbar
  if FPaginazione then
    grdNavBar.Browse:=Val;

  // abilitazione rowclick
  RowClick:=Val;

  // abilitazione colonna comandi
  if not medpEditMultiplo then
  begin
    if Val then
      medpAbilitaComandi
    else
      medpDisabilitaComandi;
  end;

  // impostazione clickable
  if Columns.Count > 0 then
    (Columns.Items[0] as TIWDBGridColumn).Clickable:=Val;

  FBrowse:=Val;
end;
// gestione integrata.fine

function TmedpIWDBGrid.medpCachedUpdates:Boolean;
begin
  Result:=False;
  if (medpDataSet is TOracleDataSet) and TOracleDataSet(medpDataSet).CachedUpdates then
    Result:=True;
end;

function TmedpIWDBGrid.medpUpdatesPending:Boolean;
begin
  Result:=False;
  if (medpDataSet is TOracleDataSet) and TOracleDataSet(medpDataSet).UpdatesPending then
    Result:=True;
end;

function TmedpIWDBGrid.medpGetRowID:String;
// Recupero il rowid relativo al record corrente
begin
  Result:='';
  if (FRowIdField <> '') and (medpDataset.FindField(FRowIdField) <> nil) then
    Result:=medpDataset.FieldByName(FRowIdField).AsString
  else
  begin
    Result:=IntToStr(medpDataset.RecNo);
    if medpDataset is TOracleDataSet then
      if TOracleDataSet(medpDataset).RowID <> '' then
        Result:=TOracleDataSet(medpDataset).RowId;
  end;
end;

function TmedpIWDBGrid.medpIndexColonna(Campo:String):Integer;
var i:Integer;
begin
  Result:=-1;
  Campo:=UpperCase(Campo);
  for i:=0 to Columns.Count - 1 do
    if UpperCase((Columns.Items[i] as TIWDBGridColumn).DataField) = Campo then
    begin
      Result:=i;
      Break;
    end;
end;

function TmedpIWDBGrid.medpColonna(const Campo:String):TIWDBGridColumn;
var i:Integer;
begin
  Result:=nil;
  i:=medpIndexColonna(Campo);
  if i >= 0 then
    Result:=(Columns.Items[i] as TIWDBGridColumn);
end;

function TmedpIWDBGrid.medpColonna(const Index:Integer):TIWDBGridColumn;
begin
  if (Index < 0) or (Index >= Columns.Count) then
    Result:=nil
  else
    Result:=(Columns.Items[Index] as TIWDBGridColumn);
end;

procedure TmedpIWDBGrid.medpCreaCDS;
var
  i: Integer;
begin
  // controlli per facilitare debug.ini
  if not Assigned(DataSource) then
    raise Exception.Create(Format('%s.medpCreaCDS: DataSource non impostato',[Self.Name]));

  if not Assigned(DataSource.DataSet) then
    raise Exception.Create(Format('%s.medpCreaCDS: DataSource %s non associato ad un DataSet',[Self.Name,DataSource.Name]));
  // controlli per facilitare debug.fine

  medpClientDataset:=(DataSource.DataSet as TClientDataSet);
  medpClientDataset.Close;
  medpClientDataset.FieldDefs.Clear;
  //Per creare il FieldDefs leggo i Fields per considerare anche campi calcolati e di lookup
  for i:=0 to medpDataset.FieldCount - 1 do
  begin
    if medpDataset.Fields[i].DataType = ftString then
      medpClientDataset.FieldDefs.Add(medpDataset.Fields[i].FieldName, medpDataset.Fields[i].DataType, medpDataset.Fields[i].Size)
    else
      medpClientDataset.FieldDefs.Add(medpDataset.Fields[i].FieldName, medpDataset.Fields[i].DataType);
  end;
  medpClientDataset.FieldDefs.Add('DBG_ROWID',ftString,30);
  medpClientDataset.FieldDefs.Add('DBG_COMANDI',ftString,1);
  medpClientDataset.FieldDefs.Add('DBG_COMANDI2',ftString,1);
  medpClientDataset.FieldDefs.Add('DBG_ROWCLICK',ftString,1);
  medpClientDataset.FieldDefs.Add(DBG_ITER,ftString,1);
  medpClientDataset.FieldDefs.Add(DBG_ALLEG,ftString,1);
  medpClientDataset.CreateDataSet;
  medpClientDataset.LogChanges:=False;
end;

procedure TmedpIWDBGrid.medpClearCompGriglia;
var i,j:Integer;
    IWC:TIWCustomControl;
begin
  for i:=0 to High(medpCompGriglia) do
  begin
    for j:=0 to High(medpCompGriglia[i].CompColonne) do
    begin
      if medpCompGriglia[i].CompColonne[j] = nil then
        Continue;
      if medpCompGriglia[i].CompColonne[j] is TmeIWGrid then
        C190PulisciIWGrid((medpCompGriglia[i].CompColonne[j] as TmeIWGrid));
      IWC:=medpCompGriglia[i].CompColonne[j];
      medpCompGriglia[i].CompColonne[j]:=nil;
      FreeAndNil(IWC);
    end;
    SetLength(medpCompGriglia[i].CompColonne,0);
  end;
  SetLength(medpCompGriglia,0);
end;

procedure TmedpIWDBGrid.medpInizializzaCompGriglia(const ClearRigaWR102:Boolean = False);
var i:Integer;
begin
  NavBarAggiorna;
  medpClearCompGriglia;
  SetLength(medpDescCompGriglia.RigaIns,Columns.Count);
  SetLength(medpDescCompGriglia.Riga,Columns.Count);
  SetLength(medpDescCompGriglia.RigaWR102I,Columns.Count);
  SetLength(medpDescCompGriglia.RigaWR102R,Columns.Count);
  for i:=0 to High(medpDescCompGriglia.RigaIns) do
    SetLength(medpDescCompGriglia.RigaIns[i],0);
  for i:=0 to High(medpDescCompGriglia.Riga) do
    SetLength(medpDescCompGriglia.Riga[i],0);
  if ClearRigaWR102 then
  begin
    medpCancellaRigaWR102;
(*
    for i:=0 to High(medpDescCompGriglia.RigaWR102) do
      SetLength(medpDescCompGriglia.RigaWR102[i],0);
    SetLength(medpDescCompGriglia.RigaWR102,0);
    for i:=0 to High(medpDescCompGriglia.RigaWR102I) do
      SetLength(medpDescCompGriglia.RigaWR102I[i],0);
    for i:=0 to High(medpDescCompGriglia.RigaWR102R) do
      SetLength(medpDescCompGriglia.RigaWR102R[i],0);
*)
  end;
end;

(*
Utilizzata quando lo stesso dataset viene usato da più medpDBGrid (es WA029).
In quel caso la visibilità delle colonne della grid non può essere pilotato dal dataset (questo contiene campi visibili per altre grid).
*)
procedure TmedpIWDBGrid.medpElencoCampiVisibili(ElencoCampi: String);
begin
  lstCampiVisibili.Clear;
  lstCampiVisibili.CommaText:=UpperCase(ElencoCampi);
end;

procedure TmedpIWDBGrid.medpEliminaColonne;
var
  i: Integer;
begin
  for i:=Columns.Count - 1 downto 0 do
    Columns.Delete(i);
end;

procedure TmedpIWDBGrid.medpAggiungiColonna(_DataField,_Title,_LinkField:String; _OnClick:TmedpDBGridColumnClick; _OnTitleClick:TmedpDBGridColumnTitleClick = nil);
var
  nc: Integer;
begin
  Columns.Add;
  nc:=Columns.Count - 1;
  with (Columns.Items[nc] as TIWDBGridColumn) do
  begin
    DataField:=_DataField;
    Font.Enabled:=False;
    Title.Text:=_Title;
    Title.RawText:=True;
    Title.Font.Enabled:=False;
    LinkField:=_LinkField;
    OnClick:=_OnClick;
    OnTitleClick:=_OnTitleClick;
  end;
end;

procedure TmedpIWDBGrid.medpAggiungiRowClick(const _LinkField:String; _OnClick:TmedpDBGridColumnClick);
var
  TempCol: TIWDBGridColumn;
begin
  TempCol:=medpColonna('DBG_ROWCLICK');
  if TempCol = nil then
    medpAggiungiColonna('DBG_ROWCLICK','',_LinkField,_OnClick)
  else
  begin
    TempCol.LinkField:=_LinkField;
    TempCol.OnClick:=_OnClick;
  end;
end;

function TmedpIWDBGrid.medpIsColonnaRowClick(NumColonna: Integer): Boolean;
var
  TempCol: TIWDBGridColumn;
begin
  TempCol:=medpColonna(NumColonna);
  if TempCol = nil then
    Result:=False
  else
    Result:=(TempCol.DataField = 'DBG_ROWCLICK');
end;

procedure TmedpIWDBGrid.medpModifica(EditOnDataSet: Boolean);
var x: Integer;
begin
  if EditOnDataSet then
    medpDataSet.Edit;

  medpStato:=msEdit;
  x:=medpClientDataSet.RecNo - 1;
  if not medpEditMultiplo then
    DataSet2Componenti(x)
  else
  begin
    for x:=IfThen(RigaInserimento,1,0) to High(medpCompGriglia) do
      DataSet2Componenti(x);
  end;
end;

procedure TmedpIWDBGrid.medpInserisci(InsertOnDataset: Boolean);
begin
  if InsertOnDataset then
    medpDataSet.Insert;

  medpStato:=msInsert;
  DataSet2Componenti(0);
end;

procedure TmedpIWDBGrid.AbilitaComandi(Abil: Boolean);
var
  i,j,currentRow: Integer;
  OldCss,NewCss: String;
begin
  OldCss:=IfThen(Abil,'invisibile','gridComandi');
  NewCss:=IfThen(Abil,'gridComandi','invisibile');

  // determina riga corrente
  currentRow:=-1;
  if medpClientDataSet <> nil then
  try
    currentRow:=medpRigaDiCompGriglia(medpClientDataSet.FieldByName('DBG_ROWID').AsString);
  except
  end;

  for i:=0 to High(medpCompGriglia) do
  begin
    // se disabilita comandi ignora la riga corrente
    if (not Abil) and (i = currentRow) then
      Continue;
    for j:=0 to High(medpCompGriglia[i].CompColonne) do
    begin
      if medpCompGriglia[i].CompColonne[j] <> nil then
      begin
        if (medpCompGriglia[i].CompColonne[j] is TmeIWGrid) and
           ((medpCompGriglia[i].CompColonne[j] as TmeIWGrid).Css = OldCss) then
          medpCompGriglia[i].CompColonne[j].Css:=NewCss;
      end;
    end;
  end;
end;

procedure TmedpIWDBGrid.VisualizzaComandi(Vis: Boolean);
var
  i:Integer;
begin
  i:=medpIndexColonna('DBG_COMANDI');
  if i >= 0 then
    (Columns.Items[i] as TIWDBGridColumn).Visible:=Vis;
end;

procedure TmedpIWDBGrid.medpAbilitaComandi;
begin
  AbilitaComandi(True);
end;

procedure TmedpIWDBGrid.medpDisabilitaComandi;
begin
  AbilitaComandi(False);
end;

procedure TmedpIWDBGrid.medpVisualizzaComandi;
begin
  VisualizzaComandi(True);
end;

procedure TmedpIWDBGrid.medpNascondiComandi;
begin
  VisualizzaComandi(False);
end;

procedure TmedpIWDBGrid.medpCreaColonne;
var
  i:Integer;
  _OnTitleClick:TmedpDBGridColumnTitleClick;
begin
  medpBrowse:=True;

  //Massimo 07/11/2012 : inserito questo controllo perchè nella gestione Master/Detail, con Detail in
  //cached update, il refresh sporcava medpDataSet aggiungendo un record (duplicava quello appena inserito dall'utente)
  if medpDataset is TOracleDataset then // solo per oracledataset - daniloc. 12.11.2012
  begin
    if not (medpCachedUpdates and medpUpdatesPending)  then
      medpDataSet.Refresh;
  end;
  medpCreaCDS;
  //Impostazione delle colonne da visualizzare sulla DBGrid
  medpEliminaColonne;

  if medpComandiEdit or medpComandiCustom then
  begin
    medpAggiungiColonna('DBG_COMANDI',' ','',nil);
    (Columns.Items[0] as TIWDBGridColumn).Width:='30';
  end;

  for i:=0 to medpDataSet.FieldCount - 1 do
  begin
    _OnTitleClick:=nil;
    // solo per oracledataset - daniloc. 12.11.2012
    if medpDataset is TOracleDataset then
    begin
      //caratto 17/12/2012 aggiunto FOrdinamentoColonne
      if ((medpDataSet as TOracleDataSet).VariableIndex('ORDERBY') >= 0) and (medpDataSet.Fields[i].FieldKind in [fkData,fkInternalCalc]) and
         (FOrdinamentoColonne) then
        _OnTitleClick:=medpColumnTitleClick;
    end;
    medpAggiungiColonna(medpDataSet.Fields[i].FieldName,medpDataSet.Fields[i].DisplayLabel,'',nil,_OnTitleClick);
    //Caratto 10/05/2013 Nel caso il dataset sia usato da più grid nella stessa form, la visibilità dei campi viene indicata
    //espressamente tramite medpElencoCampiVisibili
    if lstCampiVisibili.Count > 0 then
      medpColonna(medpDataSet.Fields[i].FieldName).Visible:=lstCampiVisibili.IndexOf(UpperCase(medpDataSet.Fields[i].FieldName)) >= 0
    else
      medpColonna(medpDataSet.Fields[i].FieldName).Visible:=medpDataSet.Fields[i].Visible;
  end;

  // gestione rowclick
  if FRowSelect then
    medpAggiungiRowClick('DBG_ROWID',medpColumnClick);

  medpInizializzaCompGriglia;

  if medpComandiInsert then
  begin
    medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','null','','S');
    medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','null','','S');
    medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','null','','D');
  end;

  if medpComandiEdit then
  begin
    medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','MODIFICA','null','','S');
    medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','CANCELLA','null','Eliminare la voce selezionata?','D');
    medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','null','','S');
    medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','null','','D');
  end;

  if not medpComandiCustom then
    medpCaricaCDS;
end;

procedure TmedpIWDBGrid.medpCaricaCDS(const DBG_ROWID:String = '');
var
  RigaIns:Boolean;
  nr,i,j:Integer;
  RowID:String;
  medpDataSetBeforeScroll:TmedpDataSetBeforeScroll;
  medpDataSetAfterScroll:TmedpDataSetAfterScroll;
  medpDataSourceDataChange:TmedpDataSourceDataChange;
begin
  FStatoInterno:=msiCaricaCDS;
  try
    NavBarAggiorna;

    // gestione evento OnBeforeCaricaCDS
    if Assigned(OnBeforeCaricaCDS) then
    begin
      try
        OnBeforeCaricaCDS(Self,DBG_ROWID);
      except
        on E: Exception do
          raise Exception.Create(Format('%s.OnBeforeCaricaCDS: %s (%s)',[Self.Name,E.Message,E.ClassName]));
      end;
    end;

    medpClearCompGriglia;
    medpClientDataSet.EmptyDataSet;
    medpClientDataset.Open;

    //Disabilito gli eventi legati allo scorrimento del dataset
    medpDataSetBeforeScroll:=nil;
    medpDataSetAfterScroll:=nil;
    medpDataSourceDataChange:=nil;
    if DisabilitaEventiDataset then
    begin
      medpDataSetBeforeScroll:=medpDataset.BeforeScroll;
      medpDataset.BeforeScroll:=nil;
      medpDataSetAfterScroll:=medpDataset.AfterScroll;
      medpDataset.AfterScroll:=nil;
      if DataSource <> nil then
      begin
        medpDataSourceDataChange:=DataSource.OnDataChange;
        DataSource.OnDataChange:=nil;
      end;
    end;
    try
      medpDataset.First;
      nr:=-1;
      for i:=0 to medpDataset.FieldCount - 1 do
      begin
        medpClientDataset.Fields[i].DisplayLabel:=medpDataset.Fields[i].DisplayLabel;
        medpClientDataset.Fields[i].DisplayWidth:=medpDataset.Fields[i].DisplayWidth;
        medpClientDataset.Fields[i].Alignment:=medpDataset.Fields[i].Alignment;
        if medpClientDataset.Fields[i] is TDateTimeField then
          TDateTimeField(medpClientDataset.Fields[i]).DisplayFormat:=TDateTimeField(medpDataset.Fields[i]).DisplayFormat;
      end;
      //Righe di Intestazione: inserisco n righe vuote nel client dataset
      for i:=1 to RigheIntestazione do
      begin
        medpClientDataset.Append;
        for j:=0 to medpDataset.FieldCount - 1 do
          medpClientDataset.Fields[j].Value:=null;
        medpClientDataset.FieldByName('DBG_ROWID').AsString:='*' + IntToStr(i);
        medpClientDataset.Post;
        inc(nr);
        SetLength(medpCompGriglia,nr + 1);
        medpCompGriglia[nr].RowID:='*' + IntToStr(i);
        SetLength(medpCompGriglia[nr].CompColonne,Length(medpDescCompGriglia.Riga));
        for j:=0 to High(medpCompGriglia[nr].CompColonne) do
          medpCompGriglia[nr].CompColonne[j]:=nil;
      end;
      //Riga di Inserimento: inserisco una riga vuota nel client dataset
      RigaIns:=medpRigaInserimento;
      if RigaIns then
      begin
        medpClientDataset.Append;
        for i:=0 to medpDataset.FieldCount - 1 do
          medpClientDataset.Fields[i].Value:=null;
        medpClientDataset.FieldByName('DBG_ROWID').AsString:='*';
        medpClientDataset.Post;
        inc(nr);
        SetLength(medpCompGriglia,nr + 1);
        medpCompGriglia[nr].RowID:='*';
        SetLength(medpCompGriglia[nr].CompColonne,Length(medpDescCompGriglia.Riga));
        for i:=0 to High(medpCompGriglia[nr].CompColonne) do
        begin
          medpCompGriglia[nr].CompColonne[i]:=nil;
          if Length(medpDescCompGriglia.RigaIns[i]) > 0 then
            medpCreaComponenteGenerico(nr,i,medpDescCompGriglia.RigaIns[i]);
          if Length(medpDescCompGriglia.RigaWR102I[i]) > 0 then
            medpCreaComponenteGenerico(nr,i,medpDescCompGriglia.RigaWR102I[i]);
        end;
      end;
      //Caricamento dati effettivi considerando la paginazione
      if Offset > 0 then
        medpDataset.MoveBy(Offset);
      while not medpDataset.Eof do
      begin
        RowID:=medpGetRowID;
        medpClientDataset.Append;
        for i:=0 to medpDataset.FieldCount - 1 do
        begin
          medpClientDataset.Fields[i].Value:=medpDataset.Fields[i].Value;
          medpClientDataset.Fields[i].OnGetText:=medpDataset.Fields[i].OnGetText;
        end;
        medpClientDataset.FieldByName('DBG_ROWID').AsString:=RowID;
        medpClientDataset.Post;
        //Gestione componenti da visualizzare sulla dbgrid
        inc(nr);
        SetLength(medpCompGriglia,nr + 1);
        medpCompGriglia[nr].RowID:=RowID;
        SetLength(medpCompGriglia[nr].CompColonne,Length(medpDescCompGriglia.Riga));
        for i:=0 to High(medpCompGriglia[nr].CompColonne) do
          medpCompGriglia[nr].CompColonne[i]:=nil;
        for i:=0 to High(medpCompGriglia[nr].CompColonne) do
        begin
          if Length(medpDescCompGriglia.Riga[i]) > 0 then
            medpCreaComponenteGenerico(nr,i,medpDescCompGriglia.Riga[i](*, medpDescCompGriglia.Riga[i,0].Grid or Length(medpDescCompGriglia.Riga[i]) > 1*));
          if Length(medpDescCompGriglia.RigaWR102R[i]) > 0 then
            medpCreaComponenteGenerico(nr,i,medpDescCompGriglia.RigaWR102R[i](*, medpDescCompGriglia.Riga[i,0].Grid or Length(medpDescCompGriglia.Riga[i]) > 1*));
        end;
        medpDataset.Next;
        //Getisco la paginazione interrompendo il ciclo quando si sono caricati 'Limit' record
        //Se è richiesta la riga di inserimento, questa non conta
        if nr - RigheIntestazione - IfThen(RigaIns,1,0) >= (Limit - OffSet) then
          Break;
      end;
      medpClientDataset.First;
      if RigaIns and (not medpClientDataset.Eof) then
        medpClientDataset.Next;
      if DBG_ROWID <> '' then
        medpClientDataset.Locate('DBG_ROWID',DBG_ROWID,[]);
    finally
      if DisabilitaEventiDataset then
      begin
        medpDataset.BeforeScroll:=medpDataSetBeforeScroll;
        medpDataset.AfterScroll:=medpDataSetAfterScroll;
        if DataSource <> nil then
          DataSource.OnDataChange:=medpDataSourceDataChange;
      end;
    end;

    medpStato:=msBrowse; // daniloc. 27.09.2011

    // gestione rowclick
    if (medpColonna('DBG_ROWCLICK') <> nil) and (@medpColonna('DBG_ROWCLICK').OnClick <> nil) then
    begin
      //Quando carica il cds richiama il rowclick;
      //devo inibire il richiamo dell'evento personalizzato perchè voglio
      //che scateni solo quando l'utente clicca su una riga
      bInibizioneEventoRowclick:=True;
      medpColonna('DBG_ROWCLICK').OnClick(Self,medpClientDataset.FieldByName(medpColonna('DBG_ROWCLICK').LinkField).AsString);
      bInibizioneEventoRowclick:=False;
    end
    else
    begin
      for i:=0 to Columns.Count - 1 do
      begin
        if @medpColonna(i).OnClick <> nil then
        begin
          medpColonna(i).OnClick(Self,medpClientDataset.FieldByName(medpColonna(i).LinkField).AsString);
          break;
        end;
      end;
    end;
    RowClick:=True;

    // comandi per inserimento
    if medpComandiInsert then
    begin
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciClick;
      (medpCompCella(0,0,1) as TmeIWImageFile).OnClick:=imgAnnullaClick;
      (medpCompCella(0,0,2) as TmeIWImageFile).OnClick:=imgConfermaClick;
      with (medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end;

    // comandi per edit
    if medpComandiEdit then
    begin
      for i:=IfThen(medpComandiInsert,1,0) to High(medpCompGriglia) do
      begin
        //Associo l'evento OnClick alle icone dei comandi
        if (medpCompGriglia[i].CompColonne[0] <> nil) then
        begin
          (medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaClick;
          (medpCompCella(i,0,1) as TmeIWImageFile).OnClick:=imgCancellaClick;
          (medpCompCella(i,0,2) as TmeIWImageFile).OnClick:=imgAnnullaClick;
          (medpCompCella(i,0,3) as TmeIWImageFile).OnClick:=imgConfermaClick;
          with (medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
          begin
            Cell[0,2].Css:='invisibile';
            Cell[0,3].Css:='invisibile';
          end;
          //Caratto 10/12/2012 Aggiunta parametrizzazione presenza pulsante cancella
          if not medpComandoDelete then
            (medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css:='invisibile';
          //Caratto 10/12/2012 lo stile salvato veniva impostato anche su celle diverse;
          //se alcune icone partono invisibili crea problemi.
          //Cambiato  SalvaStileCella1 e SalvaStileCella2;
          SalvaStileCellaVisibile:=(medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,0].Css;
          SalvaStileCellaCancella:=(medpCompGriglia[i].CompColonne[0] as TmeIWGrid).Cell[0,1].Css;
          //SalvaStileCella1:=TmeIWGrid(medpCompGriglia[i].CompColonne[0]).Cell[0,0].Css;
          //SalvaStileCella2:=TmeIWGrid(medpCompGriglia[i].CompColonne[0]).Cell[0,1].Css;
        end;
      end;
    end;

    // gestione evento OnAfterCaricaCDS
    if Assigned(OnAfterCaricaCDS) then
    begin
      try
        OnAfterCaricaCDS(Self,DBG_ROWID);
      except
        on E: Exception do
          raise Exception.Create(Format('%s.OnAfterCaricaCDS: %s (%s)',[Self.Name,E.Message,E.ClassName]));
      end;
    end;
  finally
    FStatoInterno:=msiNone;
  end;
end;

procedure TmedpIWDBGrid.medpAggiornaCDS(const Ricarica: Boolean = True);
// aggiorna il client dataset a seguito di scroll / refresh
// del dataset server
var
  CambioPagina: Boolean;
  i: Integer;
begin
  // ricalcola offset e imposta riga selezionata
  CambioPagina:=(medpDataSet.RecNo - 1 < Offset) or (medpDataSet.RecNo - 1 > Limit);
  Offset:=medpDataSet.RecNo div FRighePagina * FRighePagina;
  RowSelected:=medpDataSet.RecNo mod FRighePagina + 1;
  if RowSelected = 1 then
  begin
    Offset:=Offset - FRighePagina;
    RowSelected:=FRighePagina + 1;
  end;

  if CambioPagina or Ricarica then
  begin
    // ricarica il clientdataset a seguito del cambio pagina
    medpCaricaCDS(medpGetRowID);
  end
  else
  begin
    // allineamento cursore clientdataset al cursore dataset
    medpClientDataset.Locate('DBG_ROWID',medpGetRowID,[]);

    // gestione onclick sulla riga
    if (medpColonna('DBG_ROWCLICK') <> nil) and (@medpColonna('DBG_ROWCLICK').OnClick <> nil) then
      medpColonna('DBG_ROWCLICK').OnClick(Self,medpClientDataset.FieldByName(medpColonna('DBG_ROWCLICK').LinkField).AsString)
    else
    begin
      for i:=0 to Columns.Count - 1 do
      begin
        if @medpColonna(i).OnClick <> nil then
        begin
          medpColonna(i).OnClick(Self,medpClientDataset.FieldByName(medpColonna(i).LinkField).AsString);
          break;
        end;
      end;
    end;
  end;
end;

procedure TmedpIWDBGrid.medpPreparaComponentiDefault;
var
  i:Integer;
begin
  for i:=0 to medpDataSet.FieldCount - 1 do
  begin
  //caratto 05/02/2014 per i campi read-only devo creare una label altrimenti in caso di nuova
  //storicizzazione in line nella grid non vengono popolati i campi chiave che sono readonly
//    if medpColonna(medpDataSet.Fields[i].FieldName).Visible and (not medpDataSet.Fields[i].ReadOnly) then
    if medpColonna(medpDataSet.Fields[i].FieldName).Visible then
    begin
      if medpDataSet.Fields[i].ReadOnly then
        medpPreparaComponenteGenerico('WR102',medpIndexColonna(medpDataSet.Fields[i].FieldName),0,DBG_LBL,medpDataSet.Fields[i].DataSize.ToString,'','','','S')
      else
        //Alberto 28/03/2014: Il formato non viene passato perchè creato automaticamente in Dataset2Componenti in base a DisplayWidth, EditMask e classe del Field
        //medpPreparaComponenteGenerico('WR102',medpIndexColonna(medpDataSet.Fields[i].FieldName),0,DBG_EDT,medpDataSet.Fields[i].DataSize.ToString,'','','','S');
        medpPreparaComponenteGenerico('WR102',medpIndexColonna(medpDataSet.Fields[i].FieldName),0,DBG_EDT,'','','','','S');
    end;
  end;
end;

procedure TmedpIWDBGrid.medpPreparaComponenteGenerico(TipoRiga:String; i,j:Integer; Tipo:String; Formato:String; Elementi:String; Hint:String; Confirmation:String; Allineamento:String = ''; Grid: Boolean = False);
begin
  //Hint = 'null' permesso solo per IWImageFile
  if (Tipo <> DBG_IMG) and (Hint = 'null') then
    Hint:='';
  if TipoRiga = 'R' then //Riga
  begin
    if j = 0 then
      SetLength(medpDescCompGriglia.Riga[i],0);
    SetLength(medpDescCompGriglia.Riga[i],j + 1);
    medpDescCompGriglia.Riga[i,j].Tipo:=Tipo;
    medpDescCompGriglia.Riga[i,j].Formato:=Formato;
    medpDescCompGriglia.Riga[i,j].Elementi:=Elementi;
    medpDescCompGriglia.Riga[i,j].Hint:=Hint;
    medpDescCompGriglia.Riga[i,j].Confirmation:=Confirmation;
    medpDescCompGriglia.Riga[i,j].Allineamento:=Allineamento;
    medpDescCompGriglia.Riga[i,j].Grid:=Grid or (Elementi = 'ELENCO') or (Elementi = 'STAMPA') or (Elementi = 'ALLEGATI'); // forza grid a true per alcuni elementi
    medpDescCompGriglia.Riga[i,j].Riga:=0;
    medpDescCompGriglia.Riga[i,j].GridInRiga:=True;
  end
  else if TipoRiga = 'I' then //RigaIns
  begin
    if j = 0 then
      SetLength(medpDescCompGriglia.RigaIns[i],0);
    SetLength(medpDescCompGriglia.RigaIns[i],j + 1);
    medpDescCompGriglia.RigaIns[i,j].Tipo:=Tipo;
    medpDescCompGriglia.RigaIns[i,j].Formato:=Formato;
    medpDescCompGriglia.RigaIns[i,j].Elementi:=Elementi;
    medpDescCompGriglia.RigaIns[i,j].Hint:=Hint;
    medpDescCompGriglia.RigaIns[i,j].Confirmation:=Confirmation;
    medpDescCompGriglia.RigaIns[i,j].Allineamento:=Allineamento;
    medpDescCompGriglia.RigaIns[i,j].Grid:=Grid;
    medpDescCompGriglia.RigaIns[i,j].Riga:=0;
    medpDescCompGriglia.RigaIns[i,j].GridInRiga:=True;
  end
  else if TipoRiga = 'C' then //Componenti
  begin
    if j = 0 then
      SetLength(Componenti,0);
    SetLength(Componenti,j + 1);
    Componenti[j].Tipo:=Tipo;
    Componenti[j].Formato:=Formato;
    Componenti[j].Elementi:=Elementi;
    Componenti[j].Hint:=Hint;
    Componenti[j].Confirmation:=Confirmation;
    Componenti[j].Allineamento:=Allineamento;
    Componenti[j].Grid:=Grid;
    Componenti[j].Riga:=0;
    Componenti[j].GridInRiga:=True;
  end
  else if TipoRiga = 'WR102' then //per progetto WEBPJ
  begin
    if i > High(medpDescCompGriglia.RigaWR102) then
      SetLength(medpDescCompGriglia.RigaWR102, i + 1);
    if j = 0 then
      SetLength(medpDescCompGriglia.RigaWR102[i],0);
    SetLength(medpDescCompGriglia.RigaWR102[i],j + 1);
    medpDescCompGriglia.RigaWR102[i,j].Tipo:=Tipo;
    medpDescCompGriglia.RigaWR102[i,j].Formato:=Formato;
    medpDescCompGriglia.RigaWR102[i,j].Elementi:=Elementi;
    medpDescCompGriglia.RigaWR102[i,j].Hint:=Hint;
    medpDescCompGriglia.RigaWR102[i,j].Confirmation:=Confirmation;
    medpDescCompGriglia.RigaWR102[i,j].Allineamento:=Allineamento;
    medpDescCompGriglia.RigaWR102[i,j].Grid:=Grid;
    medpDescCompGriglia.RigaWR102[i,j].Riga:=0;
    medpDescCompGriglia.RigaWR102[i,j].GridInRiga:=True;
  end
  else if TipoRiga = 'WR102-R' then //per progetto WEBPJ - Riga
  begin
    if i > High(medpDescCompGriglia.RigaWR102R) then
      SetLength(medpDescCompGriglia.RigaWR102R, i + 1);
    if j = 0 then
      SetLength(medpDescCompGriglia.RigaWR102R[i],0);
    SetLength(medpDescCompGriglia.RigaWR102R[i],j + 1);
    medpDescCompGriglia.RigaWR102R[i,j].Tipo:=Tipo;
    medpDescCompGriglia.RigaWR102R[i,j].Formato:=Formato;
    medpDescCompGriglia.RigaWR102R[i,j].Elementi:=Elementi;
    medpDescCompGriglia.RigaWR102R[i,j].Hint:=Hint;
    medpDescCompGriglia.RigaWR102R[i,j].Confirmation:=Confirmation;
    medpDescCompGriglia.RigaWR102R[i,j].Allineamento:=Allineamento;
    medpDescCompGriglia.RigaWR102R[i,j].Grid:=Grid;
    medpDescCompGriglia.RigaWR102R[i,j].Riga:=0;
    medpDescCompGriglia.RigaWR102R[i,j].GridInRiga:=True;
  end
  else if TipoRiga = 'WR102-I' then //per progetto WEBPJ - RigaIns
  begin
    if i > High(medpDescCompGriglia.RigaWR102I) then
      SetLength(medpDescCompGriglia.RigaWR102I, i + 1);
    if j = 0 then
      SetLength(medpDescCompGriglia.RigaWR102I[i],0);
    SetLength(medpDescCompGriglia.RigaWR102I[i],j + 1);
    medpDescCompGriglia.RigaWR102I[i,j].Tipo:=Tipo;
    medpDescCompGriglia.RigaWR102I[i,j].Formato:=Formato;
    medpDescCompGriglia.RigaWR102I[i,j].Elementi:=Elementi;
    medpDescCompGriglia.RigaWR102I[i,j].Hint:=Hint;
    medpDescCompGriglia.RigaWR102I[i,j].Confirmation:=Confirmation;
    medpDescCompGriglia.RigaWR102I[i,j].Allineamento:=Allineamento;
    medpDescCompGriglia.RigaWR102I[i,j].Grid:=Grid;
    medpDescCompGriglia.RigaWR102I[i,j].Riga:=0;
    medpDescCompGriglia.RigaWR102I[i,j].GridInRiga:=True;
  end;
end;

function TmedpIWDBGrid.GetStile(PComponente: TComponenti): String;
var
  T,Fmt: String;
  function GetFormatoWidth(const PFormato: String): String;
  // restituisce il formato per adattarlo alla classe css
  var
    Suffisso,LFormato: String;
    W: Integer;
  begin
    //Alberto 28/03/2014: aggiunto controllo formato numerico
    Result:=PFormato;

    Suffisso:=IfThen((PFormato = '') or (Pos('%',PFormato) > 0),'pc','chr');
    LFormato:=StringReplace(PFormato,'%','',[]);

    //Alberto 28/03/2014: se formato non è numerico esco restituendo il formato originale
    if not TryStrToInt(LFormato,W) then
      exit;

    // correzione per combobox con width a caratteri (aggiunge 2chr)
    if (T = DBG_CMB) or (T = DBG_CMB_COUR) then
    begin
      //Alberto 28/03/2014: correzione solo per width <= 8 caratteri
      //if (Suffisso = 'chr') and TryStrToInt(LFormato,W) then
      if (Suffisso = 'chr') and TryStrToInt(LFormato,W) and (W <= 8) then
        LFormato:=IntToStr(W + 2);
    end;

    //Alberto 28/03/2014: per il formato chr si utilizza la funzione su C190
    //Result:=Format('width%s%s',[LFormato,Suffisso]);
    if Suffisso = 'chr' then
      Result:=C190GetCssWidthChr(LFormato.ToInteger)
    else
      Result:=Format('width%spc',[LFormato]);
  end;
begin
  T:=PComponente.Tipo;
  Fmt:=PComponente.Formato;

  if T = DBG_CMB then
    Result:=GetFormatoWidth(Fmt)
  else if T = DBG_CMB_COUR then
    Result:='fontcourier ' + GetFormatoWidth(Fmt)
  else if T = DBG_EDT then
  begin
    if Fmt = 'DATA' then
      Result:='input_data_dmy'
    else if Fmt = 'ORA2' then
      // MONDOEDP - chiamata 82423.ini
      //Result:='input_hour_hhmm
      Result:='input_hour_hhmm width3chr'
      // MONDOEDP - chiamata 82423.fine
    else if Fmt = 'ORA3' then
      // MONDOEDP - chiamata 82423.ini
      //Result:='width10chr'
      Result:='input_hour_hhhmm width4chr'
      // MONDOEDP - chiamata 82423.fine
    else if LeftStr(UpperCase(Fmt),6) = 'INPUT_' then // daniloc 15.07.2011 - gestione formati numerici
      Result:=Fmt
    else if Fmt = '' then //caratto 13/03/2014 se componente creato senza larghezza di default lascio vuoto
      Result:=''
    else
      Result:=GetFormatoWidth(Fmt);
    if PComponente.Allineamento = 'C' then
      Result:=Result + ' ' + 'align_center'
    else if PComponente.Allineamento = 'D' then
      Result:=Result + ' ' + 'align_right';
  end
  else if T = DBG_LNK then
    Result:=Fmt
  { DONE : TEST IW 15 }	
  {else if T = DBG_FPK then
    Result:='medpFilePicker'}
  else if T = DBG_MECMB then
    Result:=GetFormatoWidth(Fmt)
  else if T = DBG_MEMO then
    Result:='fontarial ' + GetFormatoWidth(Fmt)
  else if T = DBG_MEMO_COUR then
    Result:='fontarial ' + GetFormatoWidth(Fmt)
  else if T = DBG_RGP then
    Result:=GetFormatoWidth(Fmt)
  else
    Result:='';
end;

procedure TmedpIWDBGrid.medpCreaComponenteGenerico(nr,nc:Integer; Componenti: array of TComponenti);
var
  i,j,k,kr:Integer;
  FN,Stile,Allin: String;
  IWC: TIWCustomControl;
  IWG: TmeIWGrid;
  Possessore: TComponent;
  Contenitore: TWinControl;
begin
  //FormContenitore:=C190GetMainOwner(Self);
  Possessore:=Self.Owner;
              //Self.Owner;             //Form/Frame (funziona)
              //C190GetMainOwner(Self); Form (dà errore già esistente)
  //Contenitore:=NIL; //Form (funziona)
  Contenitore:=TWinControl(Self.Parent);
               //nil;               //Form (dà errore su gestione componenti interni alla dbgrid)
               //TIWAppForm(Self.Owner); (dà errore Async)
               //Self.Parent  Form/Region(dà errore Async)
               //C190GetMainOwner(Self); Form (funziona)
  if (Length(Componenti) > 1) or Componenti[0].Grid then
  begin
    //medpCompGriglia[nr].CompColonne[nc]:=TmeIWGrid.Create(Self.Owner{FormContenitore});
    medpCompGriglia[nr].CompColonne[nc]:=TmeIWGrid.Create(Possessore);
    with TmeIWGrid(medpCompGriglia[nr].CompColonne[nc]) do
    begin
      //Parent:=Self.Parent{FormContenitore};
      Parent:=Contenitore;
      FriendlyName:=medpCompGriglia[nr].RowID;
      if Componenti[High(Componenti)].Riga > 0 then
        ColumnCount:=1
      else
        ColumnCount:=Length(Componenti);
      RowCount:=1;
      Css:='gridComandi';
      ShowHint:=True;
    end;
  end;
  k:=-1;
  for i:=0 to High(Componenti) do
  begin
    // *** precedentemente: IWC.Owner e IWC.Parent erano impostati a TIWAppForm(Self.Owner)
    IWC:=nil;
    FN:=medpCompGriglia[nr].RowID;
    Stile:=GetStile(Componenti[i]);
    if Componenti[i].Tipo = DBG_BTN then
    begin
      // button
      IWC:=C190DBGridCreaButton(Possessore,Contenitore,FN,Componenti[i].Elementi);
    end
    else if Componenti[i].Tipo = DBG_CHK then
    begin
      // checkbox
      IWC:=C190DBGridCreaChkBox(Possessore,Contenitore,FN,Componenti[i].Elementi);
    end
    else if (Componenti[i].Tipo = DBG_CMB) or (Componenti[i].Tipo = DBG_CMB_COUR) then
    begin
      // combobox
      IWC:=C190DBGridCreaCombo(Possessore,Contenitore,FN,Stile,Componenti[i].Hint);
    end
    else if Componenti[i].Tipo = DBG_EDT then
    begin
      // edit
      IWC:=C190DBGridCreaEdit(Possessore,Contenitore,medpCompGriglia[nr].RowID,Stile,Componenti[i].Hint);
    end
    else if Componenti[i].Tipo = DBG_FPK then
    begin
      // file picker
  	  { DONE : TEST IW 15 }
      IWC:=C190DBGridCreaFileUploader(Possessore,Contenitore,medpCompGriglia[nr].RowID,Componenti[i].Hint);
    end
    else if Componenti[i].Tipo = DBG_IMG then
    begin
      // immagine
      IWC:=C190DBGridCreaComandi(Possessore,Contenitore,medpCompGriglia[nr].RowID,Componenti[i].Elementi,Componenti[i].Hint,Componenti[i].Confirmation);
    end
    else if Componenti[i].Tipo = DBG_LBL then
    begin
      // label
      IWC:=C190DBGridCreaLabel(Possessore,Contenitore,medpCompGriglia[nr].RowID);
    end
    else if Componenti[i].Tipo = DBG_LNK then
    begin
      // link
      IWC:=C190DBGridCreaLink(Possessore,Contenitore,medpCompGriglia[nr].RowID,Stile,Componenti[i].Elementi);
    end
    else if Componenti[i].Tipo = DBG_MECMB then
    begin
      // medpmulticolumn combobox
      IWC:=C190DBGridCreaMedpMultiColCombo(Possessore,Contenitore,medpCompGriglia[nr].RowID,Stile,Componenti[i].Elementi)
    end
    else if (Componenti[i].Tipo = DBG_MEMO) or (Componenti[i].Tipo = DBG_MEMO_COUR) then
    begin
      // memo
      IWC:=C190DBGridCreaMemo(Possessore,Contenitore,medpCompGriglia[nr].RowID,Stile)
    end
    else if Componenti[i].Tipo = DBG_RGP then
    begin
      // radiogroup
      IWC:=C190DBGridCreaRadioGroup(Possessore,Contenitore,medpCompGriglia[nr].RowID,Componenti[i].Elementi,Stile,Componenti[i].Hint);
    end
    else if Componenti[i].Tipo = DBG_TXT then
    begin
      // iwtext
      IWC:=C190DBGridCreaText(Possessore,Contenitore,medpCompGriglia[nr].RowID,'');
    end;

    // assegnazione del componente alla cella
    // verifica se è possibile assegnarlo direttamente o utilizzare una sottotabella
    if Componenti[i].Grid or (Length(Componenti) > 1) then
    begin
      // utilizzo sottotabella
      j:=Componenti[i].Riga;
      if j > TmeIWGrid(medpCompGriglia[nr].CompColonne[nc]).RowCount - 1 then
      begin
        TmeIWGrid(medpCompGriglia[nr].CompColonne[nc]).RowCount:=j + 1;
        k:=-1;
      end;
      if Componenti[High(Componenti)].GridInRiga and
         (((i > 0) and (j > Componenti[i - 1].Riga)) or
         ((i = 0) and (Componenti[High(Componenti)].Riga > 0))) then
      begin
        //TmeIWGrid(medpCompGriglia[nr].CompColonne[nc]).Cell[j,0].Control:=TmeIWGrid.Create({Self.Owner}FormContenitore);
        (medpCompGriglia[nr].CompColonne[nc] as TmeIWGrid).Cell[j,0].Control:=TmeIWGrid.Create(Possessore);
        with ((medpCompGriglia[nr].CompColonne[nc] as TmeIWGrid).Cell[j,0].Control as TmeIWGrid) do
        begin
          //Parent:={Self.Parent}FormContenitore;
          Parent:=Contenitore;
          FriendlyName:=medpCompGriglia[nr].RowID;
          ColumnCount:=1;
          RowCount:=1;
          Css:='gridComandi';
          ShowHint:=True;
          UseFrame:=True;
        end;
        k:=-1;
        //kr:=0;
      end;
      inc(k);
      if Componenti[High(Componenti)].GridInRiga and (Componenti[High(Componenti)].Riga > 0) then
      begin
        IWG:=((medpCompGriglia[nr].CompColonne[nc] as TmeIWGrid).Cell[j,0].Control as TmeIWGrid);
        kr:=0;
      end
      else
      begin
        IWG:=(medpCompGriglia[nr].CompColonne[nc] as TmeIWGrid);
        kr:=j;
      end;
      if IWG.ColumnCount - 1 < k then
        IWG.ColumnCount:=k + 1;
      IWG.Cell[kr,k].Control:=IWC;
      if Componenti[i].Tipo = DBG_CHK then
        IWG.Cell[kr,k].Font.Enabled:=False;
      // allineamento
      if Componenti[i].Allineamento = '' then
        IWG.Cell[kr,k].Css:=IWG.Cell[kr,k].Css + ' align_center'
      else if Componenti[i].Allineamento = 'S' then
        IWG.Cell[kr,k].Css:=IWG.Cell[kr,k].Css + ' align_left'
      else if Componenti[i].Allineamento = 'D' then
        IWG.Cell[kr,k].Css:=IWG.Cell[kr,k].Css + ' align_right';
    end
    else
    begin
      medpCompGriglia[nr].CompColonne[nc]:=IWC;
      // allineamento
      if Componenti[i].Allineamento = '' then
        Allin:=' align_left'
      else if Componenti[i].Allineamento = 'C' then
        Allin:=' align_center'
      else if Componenti[i].Allineamento = 'S' then
        Allin:=' align_left'
      else if Componenti[i].Allineamento = 'D' then
        Allin:=' align_right';
      with (medpCompGriglia[nr].CompColonne[nc] as TIWCustomControl) do
        Css:=Css + Allin;
    end;
  end;
end;

procedure TmedpIWDBGrid.medpAllineaRecordCDS;
var i:Integer;
begin
  if not medpClientDataset.Locate('DBG_ROWID',medpGetRowID,[]) then
    exit;
  FStatoInterno:=msiAllineaRecordCDS;
  try
    medpClientDataset.Edit;
    for i:=0 to medpDataset.FieldCount - 1 do
      medpClientDataset.Fields[i].Value:=medpDataset.Fields[i].Value;
    medpClientDataset.Post;
  finally
    FStatoInterno:=msiNone;
  end;
end;

function TmedpIWDBGrid.medpValoreColonna(const Riga:Integer; const Colonna:String):String;
// data la riga di medpCompGriglia, ricerca nel dataset il valore di Colonna corrispondente al RowID associato a quella riga
var
  V:Variant;
  RI,Errore:String;
const
  ERR_TEXT_FMT = '%s.medpValoreColonna(Riga: %d; Colonna: "%s"): %s';
begin
  Result:='';
  try
    // in debug tenta una migliore segnalazione errori
    if (DebugHook <> 0) then
    begin
      // verifica esistenza colonna
      if medpClientDataset.FindField(Colonna) = nil then
      begin
        Errore:=Format(ERR_TEXT_FMT,[Name,Riga,Colonna,'colonna inesistente!']);
        raise Exception.Create(Errore);
      end;
      // verifica che l'array medpCompGriglia abbia almeno un elemento
      if Length(medpCompGriglia) = 0 then
      begin
        Errore:=Format(ERR_TEXT_FMT,[Name,Riga,Colonna,'l''array medpCompGriglia ha 0 elementi']);
        raise Exception.Create(Errore);
      end;
      // verifica che Riga sia nei limiti dell'array medpCompGriglia
      if not R180Between(Riga,Low(medpCompGriglia),High(medpCompGriglia)) then
      begin
        Errore:=Format(ERR_TEXT_FMT,[Name,Riga,Colonna,Format('riga fuori dal range di medpCompGriglia [%d..%d]',[Low(medpCompGriglia),High(medpCompGriglia)])]);
        raise Exception.Create(Errore);
      end;
    end;

    V:=medpClientDataset.Lookup('DBG_ROWID',medpCompGriglia[Riga].RowID,Colonna);
    if (V = null) and (medpCompGriglia[Riga].RowID <> '') then
    begin
      RI:=medpClientDataset.FieldByName('DBG_ROWID').AsString;
      medpClientDataset.Locate('DBG_ROWID',medpCompGriglia[Riga].RowID,[]);
      V:=medpClientDataset.FieldByName(Colonna).Value;
      medpClientDataset.Locate('DBG_ROWID',RI,[]);
    end;
    if VarType(V) = varDate then
      Result:=DateTimeToStr(TVarData(V).VDate) // fix perché VarToStr utilizza formato data ora di windows
    else
      Result:=VarToStr(V);
  except
    //on E:Exception do
  end;
end;

procedure TmedpIWDBGrid.medpRiconferma;
begin
  //simulo presssione conferma. usato per messaggi di conferma in before post
  //su grid autoedit
  if LastConfermaPressed <> nil then
    imgConfermaClick(LastConfermaPressed);
end;

function TmedpIWDBGrid.medpRigaDiCompGriglia(RowID:String):Integer;
// data la RowID, restituisce la riga di medpCompGriglia corrispondente
var i:Integer;
begin
  Result:=-1;
  for i:=0 to High(medpCompGriglia) do
    if medpCompGriglia[i].RowID = RowID then
    begin
      Result:=i;
      Break;
    end;
end;

function TmedpIWDBGrid.medpRigaInserimento:Boolean;
var i:Integer;
begin
  Result:=False;
  if RigaInserimento then
    Result:=True
  else
    for i:=0 to High(medpDescCompGriglia.RigaIns) do
      if Length(medpDescCompGriglia.RigaIns[i]) > 0 then
      begin
        Result:=True;
        Break;
      end;
end;

function TmedpIWDBGrid.medpNumColonna(AColumn:Integer):Integer;
// Restituisce il numero di colonna nella lista Columns a partire dal numero di colonna effettivamente visualizzato
// considerando le colonne invisibili.
// Necessario nell'evento OnRenderCell dove AColumn considera le sole colonne visibili, e non corrisponde alle colonne effettive
var i:Integer;
begin
  Result:=AColumn;
  for i:=0 to Columns.Count - 1 do
  begin
    if i > Result then
      Break;
    if (i <= Result) and (not medpColonna(i).Visible) then
      inc(Result);
  end;
end;

function TmedpIWDBGrid.medpCompCella(ARow,AColumn,AComponent:Integer): TIWCustomControl;
// Restituisce il componente individuato dalle coordinate: riga e colonna della griglia esterna e posizione nella griglia annidata.
var i,j,x,nc:Integer;
begin
  Result:=nil;
  try
    if medpCompGriglia[ARow].CompColonne[AColumn] is TmeIWGrid then
    begin
      nc:=(medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).ColumnCount;
      //Componenti su una sola riga
      if (medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).RowCount = 1 then
        Result:=(medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).Cell[0,AComponent].Control
      //Componenti su più righe all'interno di stessa grid
      else if not ((medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).Cell[0,0].Control is TmeIWGrid) then
        Result:=(medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).Cell[AComponent div nc,AComponent mod nc].Control
      //Componenti su più righe, ciascuna è una sotto-grid separata
      else
      begin
        x:=-1;
        for i:=0 to (medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).RowCount - 1 do
        begin
          for j:=0 to ((medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).Cell[i,0].Control as TmeIWGrid).ColumnCount - 1 do
          begin
            if ((medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control <> nil then
            begin
              inc(x);
              if x = AComponent then
                Result:=((medpCompGriglia[ARow].CompColonne[AColumn] as TmeIWGrid).Cell[i,0].Control as TmeIWGrid).Cell[0,j].Control;
            end;
          end;
        end;
      end;
    end
    else
      Result:=medpCompGriglia[ARow].CompColonne[AColumn];
  except
  end;
end;

function TmedpIWDBGrid.medpCompCella(ARow: Integer; AColumn: String; AComponent: Integer): TIWCustomControl;
// Restituisce il componente individuato dalle coordinate: riga e nome colonna della griglia esterna e posizione nella griglia annidata.
var
  Col: Integer;
begin
  Col:=medpIndexColonna(AColumn);
  if Col < 0 then
    Result:=nil
  else
    Result:=medpCompCella(ARow,Col,AComponent);
end;

procedure TmedpIWDBGrid.medpRenderCellComp(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna:Integer;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=(ACell.Grid as TmedpIWDBGrid).medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High((ACell.Grid as TmedpIWDBGrid).medpCompGriglia) + 1) and ((ACell.Grid as TmedpIWDBGrid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=(ACell.Grid as TmedpIWDBGrid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

function TmedpIWDBGrid.medpRenderCell(ACell:TIWGridCell; const ARow,AColumn:Integer; const Intestazione,RigheAlterne:Boolean; const EvidenziaRigaSel:Boolean = True): Boolean;
var
  NumColonna:Integer;
begin
  NumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);
  if TmedpIWDBGrid(ACell.Grid).medpIsColonnaRowClick(NumColonna) then
  begin
    //Caratto 12/07/2013 cella comandi su intestazione come th
    if (ARow = 0) and (Intestazione) then
      ACell.Header:=True;
    ACell.Css:='invisibile';
    Result:=False;
  end
  else
  begin
    Result:=C190RenderCell(ACell,ARow,AColumn,Intestazione,RigheAlterne,medpRowSelect and EvidenziaRigaSel);
    if (ARow > 0) and (medpColonna(NumColonna) <> nil) and (medpClientDataSet.FindField(medpColonna(NumColonna).DataField) <> nil) then
      if medpClientDataSet.FindField(medpColonna(NumColonna).DataField).Alignment = taCenter then
        ACell.Css:=ACell.Css + ' align_center'
      else if medpClientDataSet.FindField(medpColonna(NumColonna).DataField).Alignment = taRightJustify then
        ACell.Css:=ACell.Css + ' align_right';
    // gestione riga inserimento
    if Result and (ARow = 1) and TmedpIWDBGrid(ACell.Grid).medpRigaInserimento then
    begin
      if medpStato = msInsert then
      begin
        ACell.Css:=StringReplace(ACell.Css,'riga_grigia','riga_selezionata',[rfReplaceAll]);
        ACell.Css:=StringReplace(ACell.Css,'riga_bianca','riga_selezionata',[rfReplaceAll]);
        ACell.Css:=StringReplace(ACell.Css,'riga_colorata','riga_selezionata',[rfReplaceAll]);
      end
      else
      begin
        ACell.Css:=StringReplace(ACell.Css,'riga_selezionata','riga_grigia',[rfReplaceAll]);
        ACell.Css:=StringReplace(ACell.Css,'riga_bianca','riga_grigia',[rfReplaceAll]);
        ACell.Css:=StringReplace(ACell.Css,'riga_colorata','riga_grigia',[rfReplaceAll]);
      end;
    end;
  end;
end;

procedure TmedpIWDBGrid.medpResetOffset;
begin
  if FPaginazione then
  begin
    RowCount:=1;
    Offset:=0;
    Limit:=0;
    RowSelected:=0;
  end;
end;

procedure TmedpIWDBGrid.medpColumnClick(ASender: TObject; const AValue: string);
var
  tmp: Integer;
begin
  medpClientDataSet.Locate('DBG_ROWID',AValue,[]);
  if AValue <> '*' then
  begin
    //Caratto 17/10/2014 se dataset in cachedupdate, cliccando su un record appena inserito, questo non ha
    //rowid valorizzato e arriva come AValue il recno.
    // fatto una pezza
    if tryStrToInt(AValue,tmp) then
    begin
      medpDataSet.RecNo:=StrToIntDef(AValue,1);
    end
    else
    begin
      if (medpDataSet is TOracleDataSet) and (TOracleDataSet(medpDataSet).RowID <> '') then
      begin
        if (medpRowIDField <> '') and (medpDataset.FindField(medpRowIDField) <> nil) then
          medpDataSet.Locate(medpRowIDField,AValue,[])
        else
          medpDataSet.Locate('ROWID',AValue,[]);
      end
      else if AValue <> '' then
        medpDataSet.RecNo:=StrToIntDef(AValue,1);
    end;
  end;
  //Caratto 30/07/2014
  if not bInibizioneEventoRowClick then
    if Assigned(OnRowClick) then
      FOnRowClick();
end;

procedure TmedpIWDBGrid.medpColumnTitleClick(Sender: TObject);
var
  i:Integer;
  RI,ElencoCampi:String;
  VarValori:Variant;
begin
  if not medpBrowse then
    exit;
  inherited;
  medpSortField:=(Sender as TIWDBGridColumn).DataField;
  if (medpDataSet is TOracleDataSet) and ((medpDataSet as TOracleDataSet).RowID <> '') then
    RI:=medpClientDataSet.FieldByName('DBG_ROWID').AsString
  else
  begin
    VarValori:=VarArrayCreate([0,medpDataSet.FieldCount - 1],VarVariant);
    ElencoCampi:='';
    for i:=0 to medpDataSet.FieldCount - 1 do
      if medpDataSet.Fields[i].FieldKind in [fkData,fkInternalCalc] then
      begin
        VarValori[i]:=medpDataSet.Fields[i].Value;
        ElencoCampi:=ElencoCampi + medpDataSet.Fields[i].FieldName + ';';
      end;
  end;
  medpDataSet.Refresh;
  if (medpDataSet is TOracleDataSet) and (TOracleDataSet(medpDataSet).RowID <> '') then
    medpDataSet.Locate('ROWID',RI,[])
  else
  begin
    //Caratto 17/03/2014 Utente: MONDOEDP Chiamata: 82153. se si cliccka sull'intestazione
    //di colonna per ordinare e il dataset e vuoto da errore
    if medpDataSet.RecordCount > 0 then
      medpDataSet.Locate(ElencoCampi,VarValori,[]);
    VarClear(VarValori);
  end;
  medpAggiornaCDS;

  if Assigned(AggiornaRecord) then
    AggiornaRecord;
end;

procedure TmedpIWDBGrid.SetSortField(const Val: String);
begin
  if not (medpDataSet is TOracleDataSet) then
    exit;
  if TOracleDataSet(medpDataSet).VariableIndex('ORDERBY') = -1 then
    exit;
  if FSortField <> Val then
  begin
    TOracleDataSet(medpDataSet).SetVariable('ORDERBY','ORDER BY ' + Val);
    FSortField:=Val;
  end
  else
  begin
    TOracleDataSet(medpDataSet).SetVariable('ORDERBY','ORDER BY ' + Val + ' DESC');
    FSortField:=Val + ',DESC';
  end;
end;

procedure TmedpIWDBGrid.TrasformaComponenti(FN:String;DaTestoAControlli: Boolean);
// Trasforma i componenti della riga indicata da text a control e viceversa per la grid grdCambiOrari
var
  r:Integer;
begin
  r:=medpRigaDiCompGriglia(FN);
  if DaTestoAControlli then
  begin
    if medpStato = msInsert then
    begin
      //Caratto 10/12/2012 lo stile salvato veniva impostato anche su celle diverse;
      //se alcune icone partono invisibili crea problemi.
      //Cambiato  SalvaStileCella1 e SalvaStileCella2;
      with (medpCompgriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:='invisibile';
        Cell[0,1].Css:=SalvaStileCellaVisibile;
        Cell[0,2].Css:=SalvaStileCellaVisibile;
        //Cell[0,1].Css:=SalvaStileCella1;
        //Cell[0,2].Css:=SalvaStileCella2;
      end;
    end
    else //Modifica
    begin
      with (medpCompgriglia[r].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:='invisibile';
        Cell[0,1].Css:='invisibile';
        //Caratto 10/12/2012 lo stile salvato veniva impostato anche su celle diverse;
        //se alcune icone partono invisibili crea problemi.
        //Cambiato  SalvaStileCella1 e SalvaStileCella2;
        Cell[0,2].Css:=SalvaStileCellaVisibile;
        Cell[0,3].Css:=SalvaStileCellaVisibile;
        //Cell[0,2].Css:=SalvaStileCella1;
        //Cell[0,3].Css:=SalvaStileCella2;
      end;
    end;
    DataSet2Componenti(r);
  end
  else
  begin
    if medpStato = msInsert then
    begin
      //Caratto 10/12/2012 lo stile salvato veniva impostato anche su celle diverse;
      //se alcune icone partono inivisibili crea problemi.
      //Cambiato  SalvaStileCella1 e SalvaStileCella2;
      with (medpCompgriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=SalvaStileCellaVisibile;
        //Cell[0,0].CSS:=SalvaStileCella1;
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end
    else
    begin
      //Caratto 10/12/2012 lo stile salvato veniva impostato anche su celle diverse;
      //se alcune icone partono inivisibili crea problemi.
      //Cambiato  SalvaStileCella1 e SalvaStileCella2;
      with (medpCompgriglia[r].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,0].Css:=SalvaStileCellaVisibile;
        Cell[0,1].Css:=SalvaStileCellaCancella;
        //Cell[0,0].Css:=SalvaStileCella1;
        //Cell[0,1].Css:=SalvaStileCella2;
        Cell[0,2].Css:='invisibile';
        Cell[0,3].Css:='invisibile';
      end;
    end;
    medpAnnulla(r);
  end;
end;

procedure TmedpIWDBGrid.DataSet2Componenti(Row:Integer);
{Crea i componenti utili alla modalità di inserimento/modifica}
var i:Integer;
    Campo,S:String;
    IsLabel: Boolean;
  procedure insertValue;
  begin
    if medpCompCella(Row,i,0) is TmeIWEdit then
    begin
      (medpCompCella(Row,i,0) as TmeIWEdit).Text:=IfThen(medpStato = msInsert,medpDataSet.FieldByName(Campo).AsString,medpClientDataSet.FieldByName(Campo).AsString);
      if medpDataSet.FieldByName(Campo) is TDateTimeField then
      begin
        //Caratto 13/06/2013 formati specifici (es ORA2 e my) non devono avere il datepicker per giorno (ES WEBPROJECT WA022,WA117)
        if (Pos('input_data_my',(medpCompCella(Row,i,0) as TmeIWEdit).Css) > 0) then
        begin
          //indicato formato input_data_my. devo prendere il valore restituito da OnGetText
          //richiamo metodo .Text del campo
          (medpCompCella(Row,i,0) as TmeIWEdit).Text:=IfThen(medpStato = msInsert,medpDataSet.FieldByName(Campo).Text,medpClientDataSet.FieldByName(Campo).Text);
        end
        else if (Pos('input_hour_hhmm',(medpCompCella(Row,i,0) as TmeIWEdit).Css) = 0) then
          (medpCompCella(Row,i,0) as TmeIWEdit).Css:='input_data_dmy';    //css che attiva datepicker
      end
      else if medpDataSet.FieldByName(Campo).DisplayWidth > 0 then
      begin
         //Caratto 14/05/2013 formati di input (es INPUT_NNDD su WA029) pilotano plugin jquery di controllo.
         //perciò il css impostato in creazione del componente non deve essere sovrascritto
         //(medpCompCella(Row,i,0) as TmeIWEdit).Css:=C190GetCssWidthChr(medpDataSet.FieldByName(Campo).DisplayWidth)
        (medpCompCella(Row,i,0) as TmeIWEdit).Css:=(medpCompCella(Row,i,0) as TmeIWEdit).Css + ' ' + C190GetCssWidthChr(medpDataSet.FieldByName(Campo).DisplayWidth);
      end
      else if medpDataSet.FieldByName(Campo) is TStringField then
      begin
        //Alberto 24/03/2014: mantiene il css già precedentemente impostato
        //(medpCompCella(Row,i,0) as TmeIWEdit).Css:=C190GetCssWidthChr(medpDataSet.FieldByName(Campo).Size);
        (medpCompCella(Row,i,0) as TmeIWEdit).Css:=(medpCompCella(Row,i,0) as TmeIWEdit).Css + ' ' + C190GetCssWidthChr(medpDataSet.FieldByName(Campo).Size);
      end;

      //Alberto 24/03/2014: la gestione del campo integer viene effettuata in alternativa all'EditMask
      //if medpDataSet.FieldByName(Campo) is TIntegerField then
      //  (medpCompCella(Row,i,0) as TmeIWEdit).Css:=(medpCompCella(Row,i,0) as TmeIWEdit).Css + ' input_integer';

      //Massimo 17/05/2013 assegnazione Css sulla base dell'editMask del Field.
      if (medpDataSet.FieldByName(Campo).EditMask <> '') and
         (medpDataSet.FieldByName(Campo).EditMask <> '!00/00/0000;1;_') then
      begin
        //Alberto 24/03/2014: mantiene il css precedentemente impostato e non aggiunge il css "width[n]chr"
        //(medpCompCella(Row,i,0) as TmeIWEdit).Css:=C190EditMaskToCss(medpDataSet.FieldByName(Campo).EditMask) + ' ' + C190GetCssWidthChr(medpDataSet.FieldByName(Campo).Size);
        (medpCompCella(Row,i,0) as TmeIWEdit).Css:=(medpCompCella(Row,i,0) as TmeIWEdit).Css + ' ' + C190EditMaskToCss(medpDataSet.FieldByName(Campo).EditMask);
      end
      else if (medpDataSet.FieldByName(Campo) is TFloatField) and
              (Pos('input_num',(medpCompCella(Row,i,0) as TmeIWEdit).Css) = 0) then
      begin
        //Alberto 29/10/2014: gestione displayformat per i campi float
        S:='';
        if (medpDataSet.FieldByName(Campo) as TFloatField).DisplayFormat <> '' then
          S:=C190EditMaskToCss((medpDataSet.FieldByName(Campo) as TFloatField).DisplayFormat);
        if S = '' then
          S:='input_num_generic';
        (medpCompCella(Row,i,0) as TmeIWEdit).Css:=(medpCompCella(Row,i,0) as TmeIWEdit).Css + ' ' + S;
      end
      //Alberto 24/03/2014: la gestione del campo integer viene effettuata in alternativa all'EditMask ed esclude eventuali campi con css "input_num_..."
      else if (medpDataSet.FieldByName(Campo) is TIntegerField) and (Pos('input_num',(medpCompCella(Row,i,0) as TmeIWEdit).Css) = 0) then
      begin
        (medpCompCella(Row,i,0) as TmeIWEdit).Css:=(medpCompCella(Row,i,0) as TmeIWEdit).Css + ' input_integer';
      end;

      if (Pos('input_num',(medpCompCella(Row,i,0) as TmeIWEdit).Css) > 0) then
      begin
        with (medpCompCella(Row,i,0) as TmeIWEdit) do
        begin
          css:=StringReplace(css,'align_left','',[rfReplaceAll]);
          css:=StringReplace(css,'align_ceter','',[rfReplaceAll]);
          Alignment:=taRightJustify;
        end;
      end;


      //Alberto 24/03/2014: maxlength viene impostato in ogni caso per i campi di tipo string
      if medpDataSet.FieldByName(Campo) is TStringField then
        (medpCompCella(Row,i,0) as TmeIWEdit).MaxLength:=(medpDataSet.FieldByName(Campo) as TStringField).Size;
    end
    else if medpCompCella(Row,i,0) is TMedpIWMultiColumnComboBox then
    begin
      (medpCompCella(Row,i,0) as TMedpIWMultiColumnComboBox).Text:=IfThen(medpStato = msInsert,medpDataSet.FieldByName(Campo).AsString,medpClientDataSet.FieldByName(Campo).AsString);
    end
    else if medpCompCella(Row,i,0) is TMeIWLabel then
    begin
      //caratto 05/02/2014 per i campi read-only devo creare una label altrimenti in caso di nuova
      //storicizzazione in line nella grid non vengono popolati i campi chiave che sono readonly
      (medpCompCella(Row,i,0) as TMeIWLabel).Caption:=IfThen(medpStato = msInsert,medpDataSet.FieldByName(Campo).AsString,medpClientDataSet.FieldByName(Campo).AsString);
    end;
  end;

begin
  if Row >= IfThen(RigaInserimento,1,0) then
    medpClientDataSet.RecNo:=Row + 1;

  if Length(medpDescCompGriglia.RigaWR102) > 0 then
  begin
    //Crea componenti personalizzati specificati in RigaWR102
    for i:=0 to High(medpDescCompGriglia.RigaWR102) do
    begin
      //Massimo 14/12/2012 Crea componente solamente se il Field è visible e non readOnly
      Campo:=medpColonna(i).DataField;
      //Caratto 13/03/2013 i Componenti label vanno creati anche se il campo è readOnly. Questo perchè sono usati
      //per poter aggiornare i valori a video in async
      IsLabel:=False;
      if (medpDescCompGriglia.RigaWR102[i] <> nil) and (medpDescCompGriglia.RigaWR102[i][0].Tipo = DBG_LBL) then
        IsLabel:=True;
      (*
      //Massimo 19/03/2013 i campi calcolati li impostiamo readonly di default
      if Copy(Campo,1,4) <> 'DBG_' then
      with medpDataSet.FieldByName(Campo) do
        if calculated then
          ReadOnly:=True;
      *)
      //CARATTO 10/06/2013 testare visible di colonna e non di dataset per gestione di più grid
      //sullo stesso dataset. La colonna può essere invisibile anche se il campo è visibile
      if (Copy(Campo,1,4) <> 'DBG_') and (medpColonna(Campo).Visible) and (Length(medpDescCompGriglia.RigaWR102[i]) > 0) then
      begin
        if ((not medpDataSet.FieldByName(Campo).ReadOnly) or isLabel) then   //Caratto 12/07/2013 - Il componente deve essere definito
        begin
          medpCreaComponenteGenerico(Row,i,medpDescCompGriglia.RigaWR102[i]);
          insertValue;
        end
        else if medpStato = msInsert then
        begin
          (*Caratto 28/08/2014 per i campi read-only devo creare una label altrimenti
          in caso di nuova storicizzazione in line nella grid non vengono popolati i campi chiave che sono readonly.
          Cosi come per la gestione in casi di componenti default
          *)
          // bugfix.ini
          // corretto errore list index out of bounds
          // non è corretto indicizzare i fields con la variabile "i", perché fa riferimento alle colonne della grid
          //medpPreparaComponenteGenerico('C',0,0,DBG_LBL,medpDataSet.Fields[i].DataSize.ToString,'','','','S');
          medpPreparaComponenteGenerico('C',0,0,DBG_LBL,medpDataSet.FieldByName(Campo).DataSize.ToString,'','','','S');
          // bugfix.fine
          medpCreaComponenteGenerico(Row,i,Componenti);
          insertValue;
        end;
      end;
    end;

    if Assigned(OnDataSet2Componenti) then
    begin
      try
        OnDataSet2Componenti(Row);
      except
        on E: EAbort do;
        on E: Exception do
          raise;
      end;
    end;
  end
  else
    //Crea componenti IWEdit standard
    for i:=0 to High(medpCompGriglia[Row].CompColonne) do
    begin
      Campo:=medpColonna(i).DataField;
      (*
      //Massimo 19/03/2013 i campi calcolati li impostiamo readonly di default
      if Copy(Campo,1,4) <> 'DBG_' then
      with medpDataSet.FieldByName(Campo) do
        if calculated then
          ReadOnly:=True;
      *)
      //caratto 05/02/2014 per i campi read-only devo creare una label altrimenti in caso di nuova
      //storicizzazione in line nella grid non vengono popolati i campi chiave che sono readonly
//      if (Copy(Campo,1,4) <> 'DBG_') and (medpDataSet.FieldByName(Campo).Visible) and (not medpDataSet.FieldByName(Campo).ReadOnly) then
      if (Copy(Campo,1,4) <> 'DBG_') and (medpDataSet.FieldByName(Campo).Visible) then
        if not medpDataSet.FieldByName(Campo).ReadOnly then
        begin
          //Caratto 13/03/2014 rimozione larghezza di default perchè impostata da insertvalue
          //medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'10','','','','S');
          medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'','','','','S');
          medpCreaComponenteGenerico(Row,i,Componenti);
          insertValue;
        end
        else if medpStato = msInsert then //gestisco solo se in inserimento (la storicizzazione è un inserimento)
        begin
          // bugfix.ini
          // corretto errore list index out of bounds
          // non è corretto indicizzare i fields con la variabile "i", perché fa riferimento alle colonne della grid
          //medpPreparaComponenteGenerico('C',0,0,DBG_LBL,medpDataSet.Fields[i].DataSize.ToString,'','','','S');
          medpPreparaComponenteGenerico('C',0,0,DBG_LBL,medpDataSet.FieldByName(Campo).DataSize.ToString,'','','','S');
          // bugfix.fine
          medpCreaComponenteGenerico(Row,i,Componenti);
          insertValue;
        end;
    end;
end;

procedure TmedpIWDBGrid.imgInserisciClick(Sender: TObject);
// inserisci
var
  FN: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  medpColumnClick(Sender,FN);

  // gestione evento OnBeforeInserisci
  if Assigned(OnBeforeInserisci) then
    if not OnBeforeInserisci(Sender) then
      Exit;

  //Caratto 10/12/2012 Dataset subito in append
  medpDataSet.Append;

  medpStato:=msInsert;

  // comportamento standard
  TrasformaComponenti(FN,True);

  medpBrowse:=False;

  // gestione evento OnInserisci
  if Assigned(OnInserisci) then
    OnInserisci(Sender);
end;

procedure TmedpIWDBGrid.imgModificaClick(Sender: TObject);
// modifica il record selezionato
begin
  medpColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);

  // gestione evento OnBeforeModifica
  if Assigned(OnBeforeModifica) then
    if not OnBeforeModifica(Sender) then
      Exit;

  //Caratto 10/12/2012 Dataset subito in Edit
  medpDataSet.Edit;
  medpStato:=msEdit;

  // comportamento standard
  TrasformaComponenti((Sender as TmeIWImageFile).FriendlyName,True);

  medpBrowse:=False;

  // gestione evento OnModifica
  if Assigned(OnModifica) then
    OnModifica(Sender);
end;

procedure TmedpIWDBGrid.imgCancellaClick(Sender: TObject);
// cancella il record selezionato
begin
  medpColumnClick(Sender,TmeIWImageFile(Sender).FriendlyName);

  // gestione evento OnBeforeCancella
  if Assigned(OnBeforeCancella) then
    if not OnBeforeCancella(Sender) then
      Exit;

  // gestione evento OnCancella
  if Assigned(OnCancella) then
  begin
    OnCancella(Sender);
  end
  else
  begin
    // comportamento standard
    medpCancella;
    // commit
    if (medpDataSet is TOracleDataSet) and (not (medpDataSet as TOracleDataSet).CommitOnPost) then
      (medpDataSet as TOracleDataSet).Session.Commit;
  end;
end;

procedure TmedpIWDBGrid.imgAnnullaClick(Sender: TObject);
begin
  //Caratto 10/12/2012 Dataset subito in Edit, perciò devo annnullare
  if medpDataSet.State <> dsBrowse then
    medpDataSet.Cancel;
  medpColumnClick(Sender,(Sender as TmeIWImageFile).FriendlyName);

  // comportamento standard
  TrasformaComponenti((Sender as TmeIWImageFile).FriendlyName,False);

  // gestione evento OnAnnulla
  if Assigned(OnAnnulla) then
    OnAnnulla(Sender);

  medpAggiornaCDS(True);
end;

procedure TmedpIWDBGrid.imgConfermaClick(Sender: TObject);
var
  r:Integer;
begin
  //Caratto 27/05/2013. in caso di messageDlg di conferma in before post, devo simulare
  //nuovamente la pressione di conferma
  LastConfermaPressed:=(Sender as TmeIWImageFile);
  //Caratto 10/12/2012 eseguito già da imgModificaClick e imgInserisciClick.
  //non eseguo di nuovo altrimenti riporta il dataset in browse
//  medpColumnClick(Sender,TmeIWImageFile(Sender).FriendlyName);
  r:=medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);

  (*Caratto 10/12/2012 spostato in imgModificaClick e imgInserisciClick
  if medpStato = msEdit then
    medpDataSet.Edit
  else
    medpDataSet.Append;
  *)

  // gestione evento OnConferma
  if Assigned(OnConferma) then
  begin
    // comportamento ridefinito
    OnConferma(Sender);
  end
  else
  begin
    // comportamento standard
    medpConferma(r);

    // commit
    if (medpDataSet is TOracleDataSet) and (not (medpDataSet as TOracleDataSet).CommitOnPost) then
      (medpDataSet as TOracleDataSet).Session.Commit;
  end;

  medpStato:=msBrowse;
  medpBrowse:=True;

  // aggiornamento dati
  if medpCachedUpdates then
    medpCaricaCDS(IntToStr(medpDataSet.RecNo))
  else
    medpCaricaCDS;
end;

procedure TmedpIWDBGrid.medpAnnulla(Row:Integer);
// Elimina i componenti ripristinando la modalità in visualizzazione
//var i:Integer;
begin
  (*Massimo 05/11/2013: creato medpResetComponenti
  for i:=0 to High(medpCompGriglia[Row].CompColonne) do
  begin
    if (Copy(medpColonna(i).DataField,1,4) <> 'DBG_') and
       (medpCompGriglia[Row].CompColonne[i] <> nil) then
    begin
      if medpCompGriglia[Row].CompColonne[i] is TmeIWGrid then
        (medpCompGriglia[Row].CompColonne[i] as TmeIWGrid).medpClearComp;
      FreeAndNil(medpCompgriglia[Row].CompColonne[i]);
    end;
  end;
  *)
  medpResetComponenti(Row);
  medpStato:=msBrowse;
  medpBrowse:=True;
end;

procedure TmedpIWDBGrid.medpResetComponenti(Row: Integer);
var i:Integer;
begin
  for i:=0 to High(medpCompGriglia[Row].CompColonne) do
  begin
    if (Copy(medpColonna(i).DataField,1,4) <> 'DBG_') and
       (medpCompGriglia[Row].CompColonne[i] <> nil) then
    begin
      if medpCompGriglia[Row].CompColonne[i] is TmeIWGrid then
        (medpCompGriglia[Row].CompColonne[i] as TmeIWGrid).medpClearComp;
      FreeAndNil(medpCompgriglia[Row].CompColonne[i]);
    end;
  end;
end;

procedure TmedpIWDBGrid.medpConferma(Row:Integer);
// Riporta i valori dai componenti al dataset effettuando le operazioni di Append o Edit
var
  i: Integer;
begin
  for i:=0 to High(medpCompGriglia[Row].CompColonne) do
  begin
    if (medpDataSet.FindField(medpColonna(i).DataField) <> nil) and
       (medpCompGriglia[Row].CompColonne[i] <> nil) then
    begin
      if medpCompCella(Row,i,0) is TmeIWEdit then
      begin
        //Caratto 14/06/2013 per edit con solo mese e anno su campi DateTime si aggiunge il giorno (01/)
        if (Pos('input_data_my',(medpCompCella(Row,i,0) as TmeIWEdit).Css) > 0) and
            (medpDataSet.FieldByName(medpColonna(i).DataField) is TDateTimeField) then
        begin
          if (medpCompCella(Row,i,0) as TmeIWEdit).Text <> '' then
            medpDataSet.FindField(medpColonna(i).DataField).AsString:='01/'+(medpCompCella(Row,i,0) as TmeIWEdit).Text
          else
            medpDataSet.FindField(medpColonna(i).DataField).AsString:='';
        end
        else
          medpDataSet.FindField(medpColonna(i).DataField).AsString:=(medpCompCella(Row,i,0) as TmeIWEdit).Text
      end
      else if medpCompCella(Row,i,0) is TmeIWComboBox then
        medpDataSet.FindField(medpColonna(i).DataField).AsString:=(medpCompCella(Row,i,0) as TmeIWComboBox).Text
//      else if medpCompCella(Row,i,0) is TmeTIWMultiColumnComboBox then
//        medpDataSet.FindField(medpColonna(i).DataField).AsString:=(medpCompCella(Row,i,0) as TmeTIWMultiColumnComboBox).Text
      //CARATTO 16/05/2013 gestione medpMulticolumnCombobox
      else if medpCompCella(Row,i,0) is TmedpIWMultiColumnComboBox then
        medpDataSet.FindField(medpColonna(i).DataField).AsString:=(medpCompCella(Row,i,0) as TmedpIWMultiColumnComboBox).Text;
    end;
  end;

  if Length(medpDescCompGriglia.RigaWR102) > 0 then
  begin
    if Assigned(OnComponenti2DataSet) then
    begin
      try
        OnComponenti2DataSet(Row);
      except
        on E: EAbort do;
        on E: Exception do
          raise;
      end;
    end;
  end;

  // log solo se cachedupdates è false
  if not medpCachedUpdates then
    RegistraLog.SettaProprieta(IfThen(medpDataSet.State = dsInsert,'I','M'),R180Query2NomeTabella(medpDataSet),Copy(C190GetMainOwner(Self).Name,1,5),medpDataSet,True);
  medpDataSet.Post;
  // log solo se cachedupdates è false
  if not medpCachedUpdates then
    RegistraLog.RegistraOperazione;
end;

procedure TmedpIWDBGrid.medpCancella;
{Elimina il record selezionato}
begin
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(medpDataSet),Copy(C190GetMainOwner(Self).Name,1,5),medpDataSet,True);
  medpDataSet.Delete;
  RegistraLog.RegistraOperazione;
  medpAggiornaCDS;
end;

procedure TmedpIWDBGrid.medpCancellaRigaWR102;
var
  i: Integer;
begin
  for i:=0 to High(medpDescCompGriglia.RigaWR102) do
    SetLength(medpDescCompGriglia.RigaWR102[i],0);
  SetLength(medpDescCompGriglia.RigaWR102,0);
  for i:=0 to High(medpDescCompGriglia.RigaWR102I) do
    SetLength(medpDescCompGriglia.RigaWR102I[i],0);
  for i:=0 to High(medpDescCompGriglia.RigaWR102R) do
    SetLength(medpDescCompGriglia.RigaWR102R[i],0);
end;

end.
