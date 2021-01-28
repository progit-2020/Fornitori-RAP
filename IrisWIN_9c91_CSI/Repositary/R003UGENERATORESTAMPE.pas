unit R003UGeneratoreStampe;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  C012UVisualizzaTesto,C700USelezioneAnagrafe, DBCtrls, checklst, C180FunzioniGenerali,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, C001StampaLib, Oracle, ActnList, ImgList, ToolWin,
  SelAnagrafe, C005UDatiAnagrafici, C007ULabelSize, L021Call,Qrctrls, qrprntr,
  Math, Printers, OracleData, Variants,
  A062UQueryServizio, QRExport, QRPDFFilt, QuickRpt, C013UCheckList,Generics.Collections,
  System.Actions,  R003UGeneratoreStampeMW, InputPeriodo, System.ImageList;

type
  TDato = (pcIntestazione, pcDettaglio);

  TListaCodici = record
    Lunghezza:Word;
    chklst:TCheckListBox;
  end;

  TR003FGeneratoreStampe = class(TR001FGestTab)
    FontDialog1: TFontDialog;
    PageControl1: TPageControl;
    tabGenerale: TTabSheet;
    tabAreaStampa: TTabSheet;
    tabFiltro: TTabSheet;
    DBRadioGroup1: TDBRadioGroup;
    Panel2: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Panel3: TPanel;
    btnAnteprima: TBitBtn;
    BtnClose: TBitBtn;
    Panel4: TPanel;
    ListBox1: TListBox;
    pnlSerbatoi: TPanel;
    PopupMenu1: TPopupMenu;
    Caption1: TMenuItem;
    Dimensioni1: TMenuItem;
    N10: TMenuItem;
    Cancella2: TMenuItem;
    N11: TMenuItem;
    Totale1: TMenuItem;
    BitBtn1: TBitBtn;
    PopupMenu2: TPopupMenu;
    Pulisci1: TMenuItem;
    ProgressBar1: TProgressBar;
    btnStampa: TBitBtn;
    PopupMenu3: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Esportazionestampa1: TMenuItem;
    Importazionestampe1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Formato1: TMenuItem;
    frmSelAnagrafe: TfrmSelAnagrafe;
    cmbSerbatoi: TComboBox;
    Contatore1: TMenuItem;
    Splitter1: TSplitter;
    tabSelezioneCodici: TTabSheet;
    pnlFiltro: TPanel;
    Memo1: TMemo;
    Panel5: TPanel;
    chkFiltroEsclusivo: TCheckBox;
    popKeyCumulo: TPopupMenu;
    mnuTotKeyCumulo: TMenuItem;
    popOrdinamento: TPopupMenu;
    mnuRotturaOrdinamento: TMenuItem;
    mnuDiscendente: TMenuItem;
    tabDettaglioSerbatoio: TTabSheet;
    popDatiCalcolati: TPopupMenu;
    Daticalcolati1: TMenuItem;
    grpFont: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    BFont: TBitBtn;
    tabOrdinamento: TTabSheet;
    LSort: TListBox;
    Label8: TLabel;
    grpIntestazione: TGroupBox;
    dchkNomeAzienda: TDBCheckBox;
    dchkPeriodoSelezionato: TDBCheckBox;
    dchkDataCorrente: TDBCheckBox;
    dchkNumeroPagina: TDBCheckBox;
    dchkTitoloStampa: TDBCheckBox;
    grpStruttura: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    dchkTotParziali: TDBCheckBox;
    dchkTotGenerali: TDBCheckBox;
    Label9: TLabel;
    cmbOrientamentoPag: TComboBox;
    cmbFormatoPag: TComboBox;
    grpVarie: TGroupBox;
    dchkValoreNullo: TDBCheckBox;
    dchkPeriodoStorico: TDBCheckBox;
    dchkFiltriEsclusivi: TDBCheckBox;
    Ordinealfabetico1: TMenuItem;
    btnTabella: TBitBtn;
    N4: TMenuItem;
    N5: TMenuItem;
    Interrogazionidiservizio1: TMenuItem;
    dchkTotRiepilogo: TDBCheckBox;
    VaiAlSerbatoio1: TMenuItem;
    Splitter3: TSplitter;
    pnlDettaglio: TPanel;
    Panel6: TPanel;
    LTop2: TLabel;
    LLeft2: TLabel;
    Dettaglio: TScrollBox;
    pnlIntestazione: TPanel;
    Panel7: TPanel;
    LLeft: TLabel;
    LTop: TLabel;
    Intestazione: TScrollBox;
    dchkCDCPercentualizzati: TDBCheckBox;
    PercentualizzaperCdC1: TMenuItem;
    lstKeyCumuloGlobale: TListBox;
    Splitter4: TSplitter;
    Memo2: TMemo;
    Splitter2: TSplitter;
    Panel8: TPanel;
    lstKeyCumulo: TListBox;
    dChkIntestazioneCol: TDBCheckBox;
    Elementiselezionatiinalto1: TMenuItem;
    NRicercaTesto: TMenuItem;
    Ricercatestocontenuto1: TMenuItem;
    Successivo2: TMenuItem;
    drgpFiltroInServizio: TDBRadioGroup;
    ConvertiInValuta1: TMenuItem;
    dchkSaltoPaginaTotali: TDBCheckBox;
    grpGeneraTabella: TGroupBox;
    lblTabellaStampa: TLabel;
    dEdtChiavi: TDBEdit;
    lblDelete: TLabel;
    dEdtDelete: TDBEdit;
    lblChiavi: TLabel;
    btnChiavi: TButton;
    btnDelete: TButton;
    dedtTabellaStampa: TDBEdit;
    dgrpRicreaTabella: TDBRadioGroup;
    Ripetisuogniriga1: TMenuItem;
    dChkStampaBloccata: TDBCheckBox;
    Invertiselezione1: TMenuItem;
    lblDatoDalAl: TLabel;
    cmbDatoDalAl: TComboBox;
    lblQueryIntestazione: TLabel;
    dcmbQueryIntestazione: TDBLookupComboBox;
    lblQueryFineStampa: TLabel;
    dcmbQueryFineStampa: TDBLookupComboBox;
    popmnuAccediA062: TPopupMenu;
    mnuAccediA062: TMenuItem;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure PercentualizzaperCdC1Click(Sender: TObject);
    procedure dchkPeriodoStoricoClick(Sender: TObject);
    procedure BFontClick(Sender: TObject);
    procedure DBRadioGroup1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IntestazioneDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure IntestazioneDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBEdit2Change(Sender: TObject);
    procedure Caption1Click(Sender: TObject);
    procedure Dimensioni1Click(Sender: TObject);
    procedure Cancella2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Totale1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure LSortDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LSortDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure LSortDblClick(Sender: TObject);
    procedure LSortMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LSortMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox1DblClick(Sender: TObject);
    procedure btnAnteprimaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Pulisci1Click(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Esportazionestampa1Click(Sender: TObject);
    procedure Importazionestampe1Click(Sender: TObject);
    procedure Formato1Click(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure cmbSerbatoiChange(Sender: TObject); virtual;
    procedure Contatore1Click(Sender: TObject);
    procedure lstKeyCumuloDblClick(Sender: TObject);
    procedure lstKeyCumuloDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure lstKeyCumuloDragOver(Sender, Source: TObject; X,
      Y: Integer; State: TDragState; var Accept: Boolean);
    procedure lstKeyCumuloMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lstKeyCumuloMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Memo1Change(Sender: TObject);
    procedure chkFiltroEsclusivoClick(Sender: TObject);
    procedure Memo1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Memo1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lstKeyCumuloDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure mnuTotKeyCumuloClick(Sender: TObject);
    procedure popKeyCumuloPopup(Sender: TObject);
    procedure LSortDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure mnuRotturaOrdinamentoClick(Sender: TObject);
    procedure mnuDiscendenteClick(Sender: TObject);
    procedure popOrdinamentoPopup(Sender: TObject);
    procedure Daticalcolati1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Ordinealfabetico1Click(Sender: TObject);
    procedure hChange(Sender: TObject);
    procedure Interrogazionidiservizio1Click(Sender: TObject);
    procedure frmSelAnagrafebtnSuccessivoClick(Sender: TObject);
    procedure dchkTotRiepilogoClick(Sender: TObject);
    procedure VaiAlSerbatoio1Click(Sender: TObject);
    procedure Elementiselezionatiinalto1Click(Sender: TObject);
    procedure Ricercatestocontenuto1Click(Sender: TObject);
    procedure Successivo2Click(Sender: TObject);
    procedure ConvertiInValuta1Click(Sender: TObject);
    procedure btnChiaviClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure dgrpRicreaTabellaChange(Sender: TObject);
    procedure Ripetisuogniriga1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
    procedure cmbDatoDalAlChange(Sender: TObject);
    procedure mnuAccediA062Click(Sender: TObject);
    procedure TCancClick(Sender: TObject);
  private
    { Private declarations }
    DefWidth:Byte;
    DefHeight:Byte;
    StartX,StartY:Integer;
    MuoviOggetto,AnteprimaInCorso:Boolean;
    ItemSort:Integer;
    ListBox1Search:String;
    procedure SettaFontIntestazione;
    procedure GetDati;
    procedure AggAbilitazioniTabella;
    function BloccaStampa:Boolean;
    function GotoNearestX(X:Integer):Integer;
    function GotoNearestY(Y:Integer):Integer;
    function SettaWidth(W:Integer; S:String; SB:TScrollBox ):Integer;
    function GetLabel(Nome:string):TLabel;
    procedure OggettoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;X, Y: Integer);
    procedure OggettoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure OggettoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure chklstClickCheck(Sender: TObject);
    function GetMaxLeft(Sender: TScrollBox):Integer;
    procedure VisualizzaFiltri;
    procedure AccediA062(Nome,SQL:String);
    procedure CreaDatiDiStampa;
    { Metodi Property }
    function _GetDataI: TDateTime;
    procedure _PutDataI(const Value: TDateTime);
    function _GetDataF: TDateTime;
    procedure _PutDataF(const Value: TDateTime);
  protected
    { Protected declarations }
    procedure CreaTabelle; virtual; abstract;
    procedure SetCdcPerc; virtual; abstract;
    procedure SetInizioPeriodoC700; virtual; abstract;
    procedure SetFinePeriodoC700; virtual; abstract;
    function getControlOpzioneAvanzata(Val: String): TControl; virtual; abstract;
  public
    { Public declarations }
    ValoreNullo:String;
    TabellaStampa:String;
    DocumentoPDF,SelectLog,TestoLog:String;
    TipoModulo:String;  //CS=ClientServer, COM=COMServer
    DatiDaPercentualizzare:Boolean;
    NoStampa,DropTabelleTemp,CreaTabellaGenerata,ConfermaRegistrazione:Boolean;
    TestoIntestazione,TestoFineStampa:String;
    ComObj_UseStandardPrinter:Boolean; // parametri di configurazione applicativi web su file
    procedure DistruggiDettaglio;
    procedure DistruggiIntestazione;
    procedure AddLabel(X,Y,H,W,Tot:Integer;Nome,Caption:String; Sender:TScrollBox; Manuale,Colonne:Boolean);
    function EsisteRoutine(R:Word):Boolean;
    function Molteplice(Num:Byte):Integer;
    procedure RefreshLstKeyCumuloGlobale;
    function GetIdxTabelleCollegate(R:Byte):Integer;
    function GetIdxSerbatoi(R:Byte):Integer;
    function IdxSerbatoiDaTabelleCollegate(idx:Byte):Integer;
    function KeyCumuloTotaleCount:Integer;
    function getCheckListBoxTabellaCollegata(M: Integer): TListaCodici; virtual;abstract;
    function getValoreOpzioneAvanzata(Opz: String): String;
    procedure setValoreOpzioneAvanzata(Opz, Valore: String);
    { Property }
    property DataI:TDateTime read _GetDataI write _PutDataI;
    property DataF:TDateTime read _GetDataF write _PutDataF;
  end;

var
  R003FGeneratoreStampe: TR003FGeneratoreStampe;

implementation

uses R003UGeneratoreStampeDtM, R003UFormato, R003UStampa, R003USerbatoi, R003UDatiCalcolati;

{$R *.DFM}

procedure TR003FGeneratoreStampe.FormCreate(Sender: TObject);
var i:TQRPaperSize;
begin
  inherited;
  TipoModulo:='CS';
  AnteprimaInCorso:=False;
  PageControl1.ActivePage:=tabGenerale;
  SelectLog:='';
  ConfermaRegistrazione:=False;
  R001LinkC700:=False;
  R003FGeneratoreStampe:=Self;
  FontDialog1.Font.Name:='Courier New';
  FontDialog1.Font.Size:=8;
  SettaFontIntestazione;
  ValoreNullo:='***';
  DropTabelleTemp:=False;
  if Parametri.Applicazione = '' then
    GeneratoreDiStampe:=True;
  cmbFormatoPag.Items.Clear;
  cmbFormatoPag.Items.Add('(non impostato)');
  for i:=Low(TQRPaperSize) to High(TQRPaperSize) do
    cmbFormatoPag.Items.Add(QRPaperName(i));
  ComObj_UseStandardPrinter:=False; // parametri di configurazione applicativi web su file
end;

procedure TR003FGeneratoreStampe.FormShow(Sender: TObject);
var
  i:Integer;
  ListaCodici: TListaCodici;
begin
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T430DATADECORRENZA,T430DATAFINE';
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.SoloPersonaleInterno:=Parametri.Applicazione <> 'STAGIU';
  frmSelAnagrafe.CreaSelAnagrafe(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW, SessioneOracle,StatusBar,2,False);
  frmSelAnagrafe.SelezionePeriodica:=True;

  GetDati;
  dedtTabellaStampa.OnChange(nil);
  DataI:= R180InizioMese(Parametri.DataLavoro);
  DataF:= R180FineMese(Parametri.DataLavoro);
  dchkTotRiepilogoClick(nil);
  for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate) do
  begin
    ListaCodici:=getCheckListBoxTabellaCollegata(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate[i].M);
    if ListaCodici.chklst <> nil then
      ListaCodici.chklst.OnClickCheck:=chklstClickCheck;
  end;
  //dEdtChiavi.Field.ReadOnly:=True;

  DButton.DataSet:=R003FGeneratoreStampeDtM.Q910;
  inherited;
  R003FGeneratoreStampeDtM.Q910.ReadOnly:=False;  //Alberto 10/08/2007: nell'inherited viene messo a True, ma qua non serve.

  dcmbQueryIntestazione.ListSource:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.dsrT002;
  dcmbQueryIntestazione.ListField:='NOME';
  dcmbQueryIntestazione.KeyField:='NOME';
  dcmbQueryFineStampa.ListSource:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.dsrT002;
  dcmbQueryFineStampa.ListField:='NOME';
  dcmbQueryFineStampa.KeyField:='NOME';

  //Alberto 20/08/2009: gestione dell'anteprima sempre in primo piano
  if not assigned(R003FStampa) then exit;
  if not assigned(R003FStampa.QRep) then exit;
  if not assigned(R003FStampa.QRep.QRPrinter) then exit;
  if not assigned(R003FStampa.QRep.QRPrinter.Client) then exit;
  if not assigned(R003FStampa.QRep.QRPrinter.Client.Parent) then exit;
  if R003FStampa.QRep.QRPrinter.Client.Parent.Visible then
    R003FStampa.QRep.QRPrinter.Client.Parent.SetFocus;
end;

function TR003FGeneratoreStampe.BloccaStampa;
begin
  Result:=SolaLettura;
  if (not SolaLettura) and (R003FGeneratoreStampeDtm.Q910.FieldByName('STAMPA_BLOCCATA').AsString = 'S') then
    Result:=not Parametri.ModificaDatiProtetti;
end;

procedure TR003FGeneratoreStampe.SettaFontIntestazione;
begin
  DefWidth:=FontDialog1.Font.Size;
  DefHeight:=2 * DefWidth;
end;

procedure TR003FGeneratoreStampe.GetDati;
var i:Integer;
begin
  with R003FGeneratoreStampedtm do
  begin
    R003FGeneratoreStampeMW.CaricaDati(True);
    for i:=0 to High(R003FGeneratoreStampeMW.Serbatoi) do
    begin
      cmbSerbatoi.Items.Add(R003FGeneratoreStampeMW.Serbatoi[i].Nome);
    end;
  end;

  cmbSerbatoi.ItemIndex:=0;
  cmbSerbatoiChange(nil);
end;

procedure TR003FGeneratoreStampe.Elementiselezionatiinalto1Click(
  Sender: TObject);
var i:Integer;
  ListaCodici: TListaCodici;
begin
  for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate) do
  begin
    ListaCodici:=getCheckListBoxTabellaCollegata(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate[i].M);
    if ListaCodici.chklst <> nil then
    begin
      ListaCodici.chklst.Sorted:=not Elementiselezionatiinalto1.Checked;
      if Elementiselezionatiinalto1.Checked then
        chklstClickCheck(ListaCodici.chklst);
    end;
  end;
end;

procedure TR003FGeneratoreStampe.chklstClickCheck(Sender: TObject);
var i:Integer;
    lst1,lst2:TStringList;
    Visibile:Boolean;
begin
  if not Elementiselezionatiinalto1.Checked then
    exit;
  lst1:=TStringList.Create;
  lst2:=TStringList.Create;
  lst1.BeginUpdate;
  lst2.BeginUpdate;
  lst1.Sorted:=True;
  lst2.Sorted:=True;
  Visibile:=(Sender as TCheckListBox).Visible;
  (Sender as TCheckListBox).Visible:=False;
  (Sender as TCheckListBox).Items.BeginUpdate;
  try
    (Sender as TCheckListBox).Sorted:=True;
    (Sender as TCheckListBox).Sorted:=False;
    for i:=0 to (Sender as TCheckListBox).Items.Count - 1 do
      if (Sender as TCheckListBox).Checked[i] then
        lst1.Add((Sender as TCheckListBox).Items[i]);
    for i:=0 to (Sender as TCheckListBox).Items.Count - 1 do
      if not (Sender as TCheckListBox).Checked[i] then
        lst2.Add((Sender as TCheckListBox).Items[i]);
    (Sender as TCheckListBox).Items.Clear;
    for i:=0 to lst1.Count - 1 do
    begin
      (Sender as TCheckListBox).Items.Add(lst1[i]);
      (Sender as TCheckListBox).Checked[i]:=True;
    end;
    for i:=0 to lst2.Count - 1 do
      (Sender as TCheckListBox).Items.Add(lst2[i]);
  finally
    lst1.EndUpdate;
    lst2.EndUpdate;
    (Sender as TCheckListBox).Items.EndUpdate;
    (Sender as TCheckListBox).Visible:=Visibile;
    FreeAndNil(lst1);
    FreeAndNil(lst2);
  end;
end;

procedure TR003FGeneratoreStampe.BFontClick(Sender: TObject);
begin
  if DButton.State in [dsInsert,dsEdit] then
    if FontDialog1.Execute then
    begin
      DBEdit2.Field.AsString:=FontDialog1.Font.Name;
      DBEdit3.Field.AsInteger:=FontDialog1.Font.Size;
      SettaFontIntestazione;
    end;
end;

procedure TR003FGeneratoreStampe.DBRadioGroup1Change(Sender: TObject);
{Abilitazione del flag 'Separatore di colonna' a seconda del Tipo Stampa}
begin
  if DButton.State in [dsEdit,dsInsert] then
  begin
    if DBRadioGroup1.ItemIndex = 1 then
      DBCheckBox3.Field.AsString:='N';
    if DBRadioGroup1.ItemIndex = 1 then
      dChkIntestazioneCol.Field.AsString:='N';
  end;
  DBCheckBox3.Enabled:=DBRadioGroup1.ItemIndex = 0;
  dChkIntestazioneCol.Enabled:=DBRadioGroup1.ItemIndex = 0;
end;

procedure TR003FGeneratoreStampe.dchkTotRiepilogoClick(Sender: TObject);
begin
  //dchkTotGenerali.Enabled:=dchkTotRiepilogo.Checked or dchkTotParziali.Checked;
  dchkSaltoPaginaTotali.Enabled:=dchkTotRiepilogo.Checked;
end;

procedure TR003FGeneratoreStampe.dgrpRicreaTabellaChange(Sender: TObject);
begin
  inherited;
  lblDelete.Enabled:=dgrpRicreaTabella.ItemIndex = 1;
  dEdtDelete.Enabled:=(dgrpRicreaTabella.ItemIndex = 1) and (DButton.State in [dsEdit,dsInsert]) and (Not BloccaStampa);
  btnDelete.Enabled:=(dgrpRicreaTabella.ItemIndex = 1) and (DButton.State in [dsEdit,dsInsert]) and (Not BloccaStampa);
end;

procedure TR003FGeneratoreStampe.ListBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbLeft) or (Shift <> [ssLeft]) then exit;
  ListBox1.BeginDrag(False);
end;

procedure TR003FGeneratoreStampe.IntestazioneDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=GetLabel(ListBox1.Items[ListBox1.ItemIndex]) = nil;
end;

procedure TR003FGeneratoreStampe.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  inherited;
  with (PopupMenu3.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=Not Checked[i];
end;

procedure TR003FGeneratoreStampe.IntestazioneDragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Gestisco il rilascio dell'oggetto sulla ScrollBox}
var L,P:Integer;
    C,S:String;
begin
  C:=ListBox1.Items[ListBox1.ItemIndex];
  S:=C;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    P:=GetDato(C,False);
    if P >= 0 then
    begin
      Dati[P].Cont:=0;
      Dati[P].ConvValuta:=False;
      Dati[P].Ripetuto:=False;
      L:=Dati[P].W;
      AddLabel(GotoNearestX(X),GotoNearestY(Y),DefHeight,SettaWidth(L,C,Sender as TScrollBox),1,S,C,Sender as TScrollBox,True,DBRadioGroup1.ItemIndex = 0);
      modAreaStampa:=True;
    end;
  end;
end;

function TR003FGeneratoreStampe.GotoNearestX(X:Integer):Integer;
{Arrotonda la posizione di inserimento in base alle variabili DefWidth/DefHeight}
begin
  Result:=(X div DefWidth) * DefWidth;
end;

function TR003FGeneratoreStampe.GotoNearestY(Y:Integer):Integer;
{Arrotonda la posizione di inserimento in base alle variabili DefWidth/DefHeight}
begin
  Result:=(Y div DefHeight) * DefHeight;
end;

function TR003FGeneratoreStampe.SettaWidth(W:Integer; S:String; SB:TScrollBox):Integer;
{Setto la larghezza della TLabel in base alla descrizione e alla lunghezza del dato}
begin
  if W = 0 then W:=10;
  Result:=DefWidth * W;
  if (SB = Intestazione) or (DBRadioGroup1.ItemIndex = 1) then
    Result:=Result + DefWidth * Length(S);
end;

procedure TR003FGeneratoreStampe.AddLabel(X,Y,H,W,Tot:Integer;Nome,Caption:String; Sender:TScrollBox; Manuale,Colonne:Boolean);
{Creo una TLabel e la inserisco nella ScrollBox appropriata}
var IntApp:TLabel;
begin
  if Colonne and Manuale and (Sender = Dettaglio) then
  begin
    if Sender.ComponentCount > 0 then
      Y:=TLabel(Sender.Components[0]).Top;
    X:=GetMaxLeft(Sender);
  end;
  IntApp:=TLabel.Create(Sender);
  IntApp.ParentFont:=True;
  IntApp.Parent:=Sender;
  IntApp.Top:=Max(0,Y);
  IntApp.Left:=Max(0,X);
  IntApp.Tag:=Tot;
  IntApp.Autosize:=False;
  IntApp.Hint:=Nome;
  IntApp.Caption:=Caption;
  IntApp.Height:=Max(2,H);
  IntApp.Width:=Max(2,W);
  IntApp.Transparent:=False;
  IntApp.OnMouseDown:=OggettoMouseDown;
  IntApp.OnMouseUp:=OggettoMouseUp;
  if IntApp.Tag = 1 then
    IntApp.Color:=clWhite
  else
    IntApp.Color:=cl3DLight;
  IntApp.PopupMenu:=PopupMenu1;
end;

function TR003FGeneratoreStampe.GetMaxLeft(Sender: TScrollBox):Integer;
{Restituisce la posizione del componente più a sinistra nell'area di stampa}
var i:Integer;
begin
  Result:=0;
  for i:=0 to Sender.ComponentCount - 1 do
    if Result <= TLabel(Sender.Components[i]).Left then
      Result:=TLabel(Sender.Components[i]).Left + TLabel(Sender.Components[i]).Width;
  Result:=Result + DefWidth;
end;

procedure TR003FGeneratoreStampe.DBEdit2Change(Sender: TObject);
{Impostazione del font corrente}
begin
  Intestazione.Font.Name:=DBEdit2.Text;
  Intestazione.Font.Size:=StrToIntDef(DBEdit3.Text,8);
  Dettaglio.Font.Name:=DBEdit2.Text;
  Dettaglio.Font.Size:=StrToIntDef(DBEdit3.Text,8);
end;

procedure TR003FGeneratoreStampe.DistruggiIntestazione;
{Distruzione delle Labels usate per l'intestazione}
var i:Integer;
begin
  for i:=Intestazione.ComponentCount - 1 downto 0 do
    TLabel(Intestazione.Components[i]).Free;
end;

function TR003FGeneratoreStampe.GetLabel(Nome:string):TLabel;
{Ricerca del dato identificato da Nome tra le lablesgià create in Dettaglio/Intestazione}
var i:integer;
begin
  Result:=nil;
  for i:=0 to Dettaglio.ComponentCount - 1 do
    if TLabel(Dettaglio.Components[i]).Hint = Nome then
    begin
      Result:=TLabel(Dettaglio.Components[i]);
      Break;
    end;
  for i:=0 to Intestazione.ComponentCount - 1 do
    if TLabel(Intestazione.Components[i]).Hint = Nome then
    begin
      Result:=TLabel(Intestazione.Components[i]);
      Break;
    end;
end;

procedure TR003FGeneratoreStampe.OggettoMouseDown(Sender: TObject; Button: TMouseButton;
                                      Shift: TShiftState;X, Y: Integer);
{Impostazioni per spostare la label}
begin
  if Button <> mbLeft then exit;
  StartX:=x;
  StartY:=y;
  if TLabel(Sender).Parent = Intestazione then  //Intestazione
  begin
    LTop.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
    LLeft.Caption:='X:' + IntToStr(TLabel(Sender).Left);
  end
  else if TLabel(Sender).Parent = Dettaglio then  //Dettaglio
  begin
    LTop2.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
    LLeft2.Caption:='X:' + IntToStr(TLabel(Sender).Left);
  end;
  TLabel(Sender).OnMouseMove:=OggettoMouseMove;
  MuoviOggetto:=True;
end;

procedure TR003FGeneratoreStampe.OggettoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
{Sposto l'oggetto col mouse}
var DW:LongInt;
    LT,LL:TLabel;
begin
  if not(ssLeft in Shift) then exit;
  if not MuoviOggetto then exit;
  DW:=DefWidth;
  if TLabel(Sender).Parent = Intestazione then
  //Intestazione
  begin
    LT:=LTop;
    LL:=LLeft;
   end
  else
  //Dettaglio
  begin
    LT:=LTop2;
    LL:=LLeft2;
  end;
  if (TLabel(Sender).Left + ((x - StartX) div DW)*DW < 0) or
     (TLabel(Sender).Top + ((y - StartY) div DW)*DW < 0) then exit;
  TLabel(Sender).Left:=TLabel(Sender).Left + ((x - StartX)div DW)*DW;
  TLabel(Sender).Top:=TLabel(Sender).Top + ((y - StartY)div DW)*DW;
  LT.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
  LL.Caption:='X:' + IntToStr(TLabel(Sender).Left);
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.modAreaStampa:=True;
end;

procedure TR003FGeneratoreStampe.OggettoMouseUp(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
{Rilascio l'oggetto dopo lo spostamento}
var DW:LongInt;
    LT,LL:TLabel;
begin
  if Button <> mbLeft then exit;
  MuoviOggetto:=False;
  TLabel(Sender).OnMouseMove:=nil;
  DW:=DefWidth;
  if TLabel(Sender).Parent = Intestazione then
  //Intestazione
  begin
    LT:=LTop;
    LL:=LLeft;
  end
  else
  //Dettaglio
  begin
    LT:=LTop2;
    LL:=LLeft2;
  end;
  if (TLabel(Sender).Left + ((x - StartX)div DW)*DW < 0) or
     (TLabel(Sender).Top + ((y - StartY)div DW)*DW < 0) then exit;
  TLabel(Sender).Left:=TLabel(Sender).Left+ ((x - StartX) div DW)*DW;
  TLabel(Sender).Top:=TLabel(Sender).Top+ ((y - StartY) div DW)*DW;
  LT.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
  LL.Caption:='X:' + IntToStr(TLabel(Sender).Left);
end;

procedure TR003FGeneratoreStampe.DistruggiDettaglio;
{Distruzione delle Labels usate per il dettaglio}
var i:Integer;
begin
  for i:=Dettaglio.ComponentCount - 1 downto 0 do
    TLabel(Dettaglio.Components[i]).Free;
end;

procedure TR003FGeneratoreStampe.PopupMenu1Popup(Sender: TObject);
{Abilitazione proprietà del dato sul popup menu}
var P:Integer;
begin
  P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(TLabel(PopupMenu1.PopupComponent).Hint,False);
  Totale1.Enabled:=P >= 0;
  Formato1.Enabled:=P >= 0;
  Caption1.Enabled:=P >= 0;
  Dimensioni1.Enabled:=P >= 0;
  if P = -1 then exit;
  //Abilitazione voce TOTALE
  Totale1.Enabled:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].T = 0;
  Totale1.Checked:=(Totale1.Enabled) and (TLabel(PopupMenu1.PopupComponent).Tag = 0);
  //Abilitazione voce contatore
  Contatore1.Enabled:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].F in [0,1,2];
  Contatore1.Checked:=(Contatore1.Enabled) and (R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Cont = 1);
  //Abilitazione voce Ripeti su ogni riga
  Ripetisuogniriga1.Enabled:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].M = 0;
  Ripetisuogniriga1.Checked:=(Ripetisuogniriga1.Enabled) and (R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Ripetuto);
  //Abilitazione voce Percentualizza per CdC
  PercentualizzaPerCdC1.Enabled:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].F in [1,2];
  PercentualizzaPerCdC1.Checked:=PercentualizzaPerCdC1.Enabled and R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].CDCPerc;
  //Abilitazione voce FORMATO
  Formato1.Caption:='Formato';
  Formato1.Enabled:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Fex = 'S';
  if Formato1.Enabled then
    Formato1.Caption:=Formato1.Caption + ' (' + R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Fmt + ')';
  // Abilitazione voce CONVERTI IN VALUTA: di default è False
  ConvertiInValuta1.Visible:=False;
  //ConvertiInValuta1.Visible:=(Copy(Self.Name,1,4) = 'P077') and (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S') and (Dati[P].F = 1);
  //ConvertiInValuta1.Checked:=(ConvertiInValuta1.Visible) and (Dati[P].ConvValuta);
end;

procedure TR003FGeneratoreStampe.Caption1Click(Sender: TObject);
var S:String;
begin
  S:=TLabel(PopupMenu1.PopupComponent).Caption;
  if InputQuery('Modifica caption ' + TLabel(PopupMenu1.PopupComponent).Hint,'Nuova caption:',S) then
    TLabel(PopupMenu1.PopupComponent).Caption:=S;
end;

procedure TR003FGeneratoreStampe.Dimensioni1Click(Sender: TObject);
{Impostazioni manuali Altezza e Larghezza delle label di intestazione}
var HorzOffset,VertOffset:Integer;
begin
  HorzOffset:=TScrollBox(TLabel(PopupMenu1.PopupComponent).Parent).HorzScrollBar.Position;
  VertOffset:=TScrollBox(TLabel(PopupMenu1.PopupComponent).Parent).VertScrollBar.Position;
  C007FLabelSize:=TC007FLabelSize.Create(nil);
  with C007FLabelSize do
  try
    Caption:=Format('Dimensioni del dato %s',[TLabel(PopupMenu1.PopupComponent).Hint]);
    if Trim(TLabel(PopupMenu1.PopupComponent).Caption) <> '' then
      Caption:=Caption + Format(' (%s)',[Trim(TLabel(PopupMenu1.PopupComponent).Caption)]);
    Altezza:=TLabel(PopupMenu1.PopupComponent).Height;
    Larghezza:=TLabel(PopupMenu1.PopupComponent).Width;
    Sinistra:=TLabel(PopupMenu1.PopupComponent).Left + HorzOffset;
    Alto:=TLabel(PopupMenu1.PopupComponent).Top + VertOffset;
    if ShowModal = mrOk then
    begin
      TLabel(PopupMenu1.PopupComponent).Height:=Max(2,Altezza);
      TLabel(PopupMenu1.PopupComponent).Width:=Max(2,Larghezza);
      TLabel(PopupMenu1.PopupComponent).Left:=Max(0,Sinistra) - HorzOffset;
      TLabel(PopupMenu1.PopupComponent).Top:=Max(0,Alto) - VertOffset;
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.modAreaStampa:=True;
    end;
  finally
    Release;
  end;
end;

procedure TR003FGeneratoreStampe.Cancella2Click(Sender: TObject);
{Cancellazione della label di intestazione}
var S1:String;
begin
  S1:=TLabel(PopupMenu1.PopupComponent).Hint;
  if Trim(TLabel(PopupMenu1.PopupComponent).Caption) <> '' then
    S1:=S1 + Format(' (%s)',[Trim(TLabel(PopupMenu1.PopupComponent).Caption)]);
  if MessageDlg('Eliminare il dato ' + S1 + ' ?', mtConfirmation,[mbYes, mbNo],0) = mrYes then
  begin
    TLabel(PopupMenu1.PopupComponent).Free;
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.modAreaStampa:=True;
  end;
end;

procedure TR003FGeneratoreStampe.TCancClick(Sender: TObject);
begin
  if R180MessageBox('Confermi cancellazione?',DOMANDA) = mrNo then
    Exit;
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CancellaT910;
end;

procedure TR003FGeneratoreStampe.Totale1Click(Sender: TObject);
{Visualizzazione del dato totalizzato in Grigio}
begin
  if TLabel(PopupMenu1.PopupComponent).Tag = 0 then
    TLabel(PopupMenu1.PopupComponent).Tag:=1
  else
    TLabel(PopupMenu1.PopupComponent).Tag:=0;
  Totale1.Checked:=TLabel(PopupMenu1.PopupComponent).Tag = 0;
  if TLabel(PopupMenu1.PopupComponent).Tag = 1 then
    TLabel(PopupMenu1.PopupComponent).Color:=clWhite
  else
    TLabel(PopupMenu1.PopupComponent).Color:=cl3DLight;
end;

procedure TR003FGeneratoreStampe.Contatore1Click(Sender: TObject);
{Attiva/Disattiva il contatore}
var P:Integer;
begin
  P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(TLabel(PopupMenu1.PopupComponent).Hint,False);
  if P >= 0 then
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Cont:=IfThen(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Cont = 0,1,0);
end;

procedure TR003FGeneratoreStampe.ConvertiInValuta1Click(Sender: TObject);
{Attiva/Disattiva la Conversione in valuta}
var P:Integer;
begin
  P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(TLabel(PopupMenu1.PopupComponent).Hint,False);
  if P >= 0 then
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].ConvValuta:=not R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].ConvValuta;
end;

procedure TR003FGeneratoreStampe.Copiada1Click(Sender: TObject);
var NomeStampa:String;
    lstErrors,StrSQL:TStringList;
    NomeOK:Boolean;
    lstCodiciTabCollegate: TList<TCodiciTabCollegate>;
    Msg:String;
begin
  with R003FGeneratoreStampeDtm do
  begin
    NomeOK:=True;
    repeat
      NomeOK:=True;
      NomeStampa:=InputBox('Creazione nuovo elemento','Codice stampa: ','');
      if NomeStampa = '' then
        Exit;
      Msg:=R003FGeneratoreStampeMW.VerificaNomeDuplica(NomeStampa);
      if Msg <> '' then
      begin
        NomeOK:=False;
        R180MessageBox(Msg,ERRORE);
      end;
    until NomeOK;
    StrSQL:=TStringList.Create;
    lstCodiciTabCollegate:=getListCodiciSelezionati;
    R003FGeneratoreStampeMW.DuplicaStampa(StrSQL,NomeStampa,lstCodiciTabCollegate);
    FreeAndNil(lstCodiciTabCollegate);

    lstErrors:=R003FGeneratoreStampeMW.EseguiDuplicaStampa(StrSql);
    if lstErrors.Count > 0 then
    begin
      StrSQL.Assign(lstErrors);
      OpenC012VisualizzaTesto('<R003> Anomalie riscontrate in fase di copia della stampa ''' + NomeStampa + '''','',StrSQL);
    end;
    FreeAndNil(lstErrors);
    FreeAndNil(StrSQL);

    Q910.Refresh;
    Q910.SearchRecord('CODICE',NomeStampa,[srFromBeginning]);
  end;

end;

procedure TR003FGeneratoreStampe.PercentualizzaperCdC1Click(Sender: TObject);
{Attiva/Disattiva la Percentualizzazione}
var P:Integer;
begin
  P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(TLabel(PopupMenu1.PopupComponent).Hint,False);
  if P >= 0 then
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].CDCPerc:=not R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].CDCPerc;
end;

procedure TR003FGeneratoreStampe.Formato1Click(Sender: TObject);
{Richiesta del formato di visualizzazione}
var P:Integer;
begin
  R003FFormato:=TR003FFormato.Create(nil);
  P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(TLabel(PopupMenu1.PopupComponent).Hint,False);
  if P >= 0 then
    with R003FFormato do
    try
      Caption:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].D;
      ComboBox1.Text:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Fmt;
      Dato:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P];
      if ShowModal = mrOk then
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Fmt:=ComboBox1.Text;
    finally
      Release;
    end;
end;

procedure TR003FGeneratoreStampe.VaiAlSerbatoio1Click(Sender: TObject);
{Ricerca e posizionamento del serbatoio in cui è contenuto il dato}
var i,P:Integer;
begin
  inherited;
  P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(TLabel(PopupMenu1.PopupComponent).Hint,False);
  if P >= 0 then
    for i:=0 to High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi) do
      if R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[i].X = R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].X then
      begin
        cmbSerbatoi.ItemIndex:=i;
        cmbSerbatoiChange(nil);
        Break;
      end;
end;

procedure TR003FGeneratoreStampe.AggAbilitazioniTabella;
//Abilitazioni dedicate al groupbox "Genera tabella sul database"
begin
  lblChiavi.Enabled:=(Not BloccaStampa);
  dEdtChiavi.Enabled:=(Not BloccaStampa);
  btnChiavi.Enabled:=(Not BloccaStampa) and (DButton.State in [dsEdit,dsInsert]);
  dedtTabellaStampa.Enabled:=(Not BloccaStampa);
  lblDelete.Enabled:=(Not BloccaStampa) and (dgrpRicreaTabella.ItemIndex = 1);
  dEdtDelete.Enabled:=(Not BloccaStampa) and (dgrpRicreaTabella.ItemIndex = 1) and (DButton.State in [dsEdit,dsInsert]);
  btnDelete.Enabled:=(Not BloccaStampa) and (dgrpRicreaTabella.ItemIndex = 1) and (DButton.State in [dsEdit,dsInsert]);
  grpGeneraTabella.Enabled:=(Not BloccaStampa);
  lblTabellaStampa.Enabled:=(Not BloccaStampa);
  dgrpRicreaTabella.Enabled:=(Not BloccaStampa);
end;

procedure TR003FGeneratoreStampe.DButtonStateChange(Sender: TObject);
var i:Integer;
  ctrl: TControl;
begin
  inherited;
  actCancella.Enabled:=actCancella.Enabled and GeneratoreDiStampe and (not BloccaStampa);
  actInserisci.Enabled:=actInserisci.Enabled and GeneratoreDiStampe;
  actModifica.Enabled:=(Dbutton.State = dsBrowse) and GeneratoreDiStampe;
  actConferma.Enabled:=actConferma.Enabled and GeneratoreDiStampe and (not SolaLettura) and (not BloccaStampa);
  dChkStampaBloccata.Enabled:=Parametri.ModificaDatiProtetti;
  //actAnnulla.Enabled:=actAnnulla.Enabled and GeneratoreDiStampe;
  ListBox1.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbOrientamentoPag.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbFormatoPag.Enabled:=DButton.State in [dsEdit,dsInsert];
  Intestazione.Enabled:=DButton.State in [dsEdit,dsInsert];
  Dettaglio.Enabled:=DButton.State in [dsEdit,dsInsert];
  LSort.Enabled:=DButton.State in [dsEdit,dsInsert];
  Memo1.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbDatoDalAl.Enabled:=DButton.State in [dsEdit,dsInsert];
  lstKeyCumulo.Enabled:=DButton.State in [dsEdit,dsInsert];
  EsportazioneStampa1.Enabled:=DButton.State in [dsBrowse];
  ImportazioneStampe1.Enabled:=DButton.State in [dsBrowse];
  AggAbilitazioniTabella;
  for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.OpzioniAvanzate) do
  begin
    ctrl:=getControlOpzioneAvanzata(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione);
    ctrl.Enabled:=DButton.State in [dsEdit,dsInsert];
  end;
end;

procedure TR003FGeneratoreStampe.setValoreOpzioneAvanzata(Opz,Valore:String);
var
  ctrl: TControl;
begin
  ctrl:=getControlOpzioneAvanzata(Opz);
  if ctrl is TCheckBox then
    (ctrl as TCheckBox).Checked:=Valore = 'S'
  else if ctrl is TRadioGroup then
    (ctrl as TRadioGroup).ItemIndex:=StrToIntDef(Valore,0)
  else if ctrl is TDBLookupComboBox then
  begin
    if Valore <> '' then
      (ctrl as TDBLookupComboBox).KeyValue:=Valore
    else
      (ctrl as TDBLookupComboBox).KeyValue:=null;
  end
  else if ctrl is TComboBox then
    (ctrl as TComboBox).ItemIndex:=(ctrl as TComboBox).Items.IndexOf(Valore);
end;

function TR003FGeneratoreStampe.getValoreOpzioneAvanzata(Opz:String):String;
var
  ctrl: TControl;
begin
  Result:='';
  ctrl:=getControlOpzioneAvanzata(Opz);

  if ctrl is TCheckBox then
  begin
    Result:=IfThen((ctrl as TCheckBox).Checked,'S','N');
  end
  else if ctrl is TRadioGroup then
  begin
    Result:=IntToStr((ctrl as TRadioGroup).ItemIndex);
  end
  else if ctrl is TDBLookupComboBox then
  begin
    Result:=VarToStr((ctrl as TDBLookupComboBox).KeyValue);
  end
  else if ctrl is TComboBox then
  begin
    Result:=(ctrl as TComboBox).Text;
  end;
end;

procedure TR003FGeneratoreStampe.DButtonDataChange(Sender: TObject;
  Field: TField);
var TabName:string;
  DaData: TDateTime;
  AData: TDateTime;
begin
  actCancella.Enabled:=Not BloccaStampa and GeneratoreDiStampe and (Dbutton.State = dsBrowse);
  AggAbilitazioniTabella;
  if (Field = nil) and (DButton.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
  if not ConfermaRegistrazione then
  begin
    with R003FGeneratoreStampeDtM do
    begin
      R003FGeneratoreStampeMW.ElencoDatiCalcolati;
      CaricaImpostazioni;
    end;
    Elementiselezionatiinalto1Click(nil);
    SettaFontIntestazione;
    //ElencoDatiCalcolati;
    cmbSerbatoiChange(nil);
  end;
  if Not R003FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').IsNull then
  begin
    DaData:= DataI;
    AData:= DataF;

    TabName:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CreaNometabella(R003FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString,DaData,AData);
    if (R003FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> TabName) then
      lblTabellaStampa.Caption:='Nome Tabella (' + TabName + ')'
    else
      lblTabellaStampa.Caption:='Nome Tabella';
  end;
end;

procedure TR003FGeneratoreStampe.LSortDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=LSort.Items.IndexOf(ListBox1.Items[ListBox1.ItemIndex]) = -1;
end;

procedure TR003FGeneratoreStampe.LSortDragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Trascinamento e rilascio su Ordinamento}
var i,P:Integer;
    TP:TPoint;
begin
  TP.X:=X;
  TP.Y:=Y;
  P:=LSort.ItemAtPos(TP,False);
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    SetLength(Ordinamento,Length(Ordinamento) + 1);
    for i:=High(Ordinamento) - 1 downto P do
      Ordinamento[i + 1]:=Ordinamento[i];
    Ordinamento[P].Nome:=ListBox1.Items[ListBox1.ItemIndex];
    Ordinamento[P].Rottura:=False;
    Ordinamento[P].Discendente:=False;
    modOrdinamento:=True;
  end;
  LSort.Items.Insert(P,ListBox1.Items[ListBox1.ItemIndex]);

end;

procedure TR003FGeneratoreStampe.LSortDblClick(Sender: TObject);
{Cancellazione Ordinamento}
begin
  if LSort.ItemIndex >= 0 then
  begin
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.RimuoviOrdinamentoByIndice(LSort.ItemIndex);
    LSort.Items.Delete(LSort.ItemIndex);
  end;
end;

procedure TR003FGeneratoreStampe.LSortMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var TP:TPoint;
begin
  TP.X:=X;
  TP.Y:=Y;
  if (Button = mbRight) and (LSort.ItemAtPos(TP,True) >= 0) then
    LSort.ItemIndex:=LSort.ItemAtPos(TP,True);
  ItemSort:=LSort.ItemIndex;
end;

procedure TR003FGeneratoreStampe.LSortMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{Spostamento degli elementi all'interno della lista}
var SW:TOrdinamento;
    i:Integer;
begin
  if (ItemSort <> -1) and (ItemSort <> LSort.ItemIndex) then
  begin
    with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
    begin
      SW:=Ordinamento[ItemSort];
      if LSort.ItemIndex < ItemSort then
        for i:=ItemSort downto LSort.ItemIndex + 1 do
          Ordinamento[i]:=Ordinamento[i - 1]
      else
        for i:=ItemSort to LSort.ItemIndex - 1 do
          Ordinamento[i]:=Ordinamento[i + 1];
      Ordinamento[LSort.ItemIndex]:=SW;
      LSort.Items.Clear;
      for i:=0 to High(Ordinamento) do
        LSort.Items.Add(Ordinamento[i].Nome);
      modOrdinamento:=True;
    end;
  end;
  ItemSort:= - 1;
end;

procedure TR003FGeneratoreStampe.ListBox1DblClick(Sender: TObject);
{Il dato del serbatoio viene riportato sui rispettivi contenitori col doppio-click}
var i,L,P,NL,RP,SS:Integer;
    C,S:String;
    Scritto:Boolean;
begin
  //Ordinamento
  if PageControl1.ActivePage = tabOrdinamento then
  begin
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.AggiungiOrdinamento(ListBox1.Items[ListBox1.ItemIndex]) then
      LSort.Items.Add(ListBox1.Items[ListBox1.ItemIndex]);
  end;
  //Dettaglio serbatoio
  if PageControl1.ActivePage = tabDettaglioSerbatoio then
    if R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.AggiungiDettaglioSerbatoio(cmbSerbatoi.ItemIndex,ListBox1.Items[ListBox1.ItemIndex])  then
    begin
      lstKeyCumulo.Items.Add(ListBox1.Items[ListBox1.ItemIndex]);
      RefreshLstKeyCumuloGlobale;
    end;

  //Area di stampa - dettaglio
  if PageControl1.ActivePage = tabAreaStampa then
    if GetLabel(ListBox1.Items[ListBox1.ItemIndex]) = nil then
    begin
      C:=ListBox1.Items[ListBox1.ItemIndex];
      S:=C;
      with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
      begin
        P:=GetDato(C,False);
        if P >= 0 then
        begin
          L:=Dati[P].W;
          AddLabel(0,0,DefHeight,SettaWidth(L,C,Dettaglio),1,S,C,Dettaglio,True,True);
          modAreaStampa:=True;
        end;
      end;
    end;
  if PageControl1.ActivePage <> tabFiltro then exit;
  //Filtro
  NL:=0;
  RP:=Memo1.SelStart;
  SS:=RP;
  Scritto:=False;
  for i:=0 to Memo1.Lines.Count - 1 do
  begin
    inc(NL,Length(Memo1.Lines[i]) + 2);
    if NL - 1 >=Memo1.SelStart then
    begin
      S:=Memo1.Lines[i];
      Insert(Identificatore(ListBox1.Items[ListBox1.ItemIndex]),S,RP + 1);
      Memo1.Lines[i]:=S;
      Scritto:=True;
      Break;
    end;
    dec(RP,Length(Memo1.Lines[i]) + 2);
  end;
  if not Scritto then
    Memo1.Lines.Add(Identificatore(ListBox1.Items[ListBox1.ItemIndex]));
  Memo1.SelStart:=SS + Length(Identificatore(ListBox1.Items[ListBox1.ItemIndex]));
  Memo1.SetFocus;
end;

procedure TR003FGeneratoreStampe.BitBtn1Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TR003FGeneratoreStampe.btnAnteprimaClick(Sender: TObject);
var D,D1:TDateTime;
    SQLOri,CdcTab,CdcCod,CdcSt,S,ST433:String;
    i,ProgErrato:Integer;
  DaData: TDateTime;
  AData: TDateTime;
begin
  if AnteprimaInCorso then
    raise Exception.Create('Chiudere l''anteprima di stampa!');
  NoStampa:=Sender = btnTabella;
  TestoLog:='';
  if dchkValoreNullo.Checked then
    ValoreNullo:='***'
  else
    ValoreNullo:='';
  Intestazione.HorzScrollBar.Position:=0;
  Intestazione.VertScrollBar.Position:=0;
  Dettaglio.HorzScrollBar.Position:=0;
  Dettaglio.VertScrollBar.Position:=0;
  try
    D1:=DataI;
    D:=DataF;
    if D1 > D then Abort;
  except
    raise Exception.Create('Il periodo indicato non è valido!');
  end;
  TabellaStampa:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CreaNomeTabella(R003FGeneratoreStampeDtm.Q910.FieldByName('TABELLA_GENERATA').AsString,D1,D);
  if Trim(TabellaStampa) <> Identificatore(TabellaStampa) then
    raise Exception.Create(Format('Il nome della tabella da generare non è valido (%s)!',[TabellaStampa]));
  (*
  if C700SelAnagrafe.GetVariable('DataLavoro') <> D then
  begin
    C700SelAnagrafe.Close;
    C700SelAnagrafe.SetVariable('DataLavoro',D);
  end;
  *)
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(D1,D) then
    C700SelAnagrafe.Close;
  CreaDatiDiStampa;

  CreaTabellaGenerata:=(TabellaStampa <> '') and R003FGeneratoreStampeDtM.VerificaCreazioneTabellaGenerata('T920' + TabellaStampa);

  frmSelAnagrafe.SalvaC00SelAnagrafe;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    PeriodiStorici:=dchkPeriodoStorico.Checked;
    CDCPercentualizzati:=False;
    EsistonoDatiDaProporzionare:=False;
    DatiDaPercentualizzare:=True;//Serve la prima volta a True e la seconda volta a False, utilizzato in PutValore
  end;

  ProgErrato:=-1;
  try
    Screen.Cursor:=crHourGlass;
    with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
    begin
      if dchkCDCPercentualizzati.Checked (*and (not dchkPeriodoStorico.Checked)*) then
      begin
        A000GetTabella(Parametri.CampiRiferimento.C13_CDCPercentualizzati,CdcTab,CdcCod,CdcSt);
      if (CdcTab <> '') and (CdcCod <> '') then
        CDCPercentualizzati:=True;
      end;
      //Verifico se esisonto dati da proporzionare sui periodi storici (simili ai cdc percentualizzati)
      if PeriodiStorici and (not CdcPercentualizzati) then
      begin
        SetCdcPerc;
        for i:=0 to High(DatiStampa) do
          if (DatiStampa[i].N >= 0) and (Dati[DatiStampa[i].N].CDCPerc) then
          begin
            EsistonoDatiDaProporzionare:=True;
            Break;
          end;
      end;
    end;
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.PeriodiStorici and
       (C700FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex = 0) and
       ((Pos('T430',C700FSelezioneAnagrafe.WhereSql.ToUpper) > 0) or (Pos('P430',C700FSelezioneAnagrafe.WhereSql.ToUpper) > 0))
    then
    begin
      S:='La stampa prevede la gestione dei Periodi storici' + #13#10 +
         'pertanto si consiglia di estendere la Selezione anagrafica' + #13#10 +
         Format('a tutto il Periodo %s – %s.',[frmInputPeriodo.edtInizio.Text, frmInputPeriodo.edtFine.Text]) + #13#10 +
         'Estenderla automaticamente?';
      if TipoModulo = 'CS' then
        case MessageDlg(S,mtConfirmation,[mbYes,mbNo,mbAbort],0) of
          mrYes:
            begin
              C700FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex:=1;
              C700FSelezioneAnagrafe.QueryDinamica(2);
            end;
          mrAbort:
            Abort;
        end;
    end;

    //Selezione anagrafica periodica
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.PeriodiStorici and
       (not R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CDCPercentualizzati) then
    begin
      SQLOri:=C700SelAnagrafe.SQL.Text;
      SQLOri:=StringReplace(SQLOri,
                            ':DATALAVORO BETWEEN V430.T430DATADECORRENZA AND V430.T430DATAFINE',
                            'V430.T430DATADECORRENZA <= :DATALAVORO AND V430.T430DATAFINE >= :DATALAVOROI',
                            [rfIgnoreCase]);
      SQLOri:=StringReplace(SQLOri,
                            'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)','',
                            [rfIgnoreCase]);
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=SQLOri;
      C700SelAnagrafe.DeclareVariable('DATALAVOROI',otDate);
      C700SelAnagrafe.SetVariable('DATALAVOROI',DataI);
    end;
    //Join coi CDC percentualizzati
    if (not R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.PeriodiStorici) and
       R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CDCPercentualizzati then
    begin
      SQLOri:=C700SelAnagrafe.SQL.Text;
      R180InserisciColonna(SQLOri,'NVL(T433.CODICE,V430.T430' + Parametri.CampiRiferimento.C13_CDCPercentualizzati + ') T433CODICE');
      R180InserisciColonna(SQLOri,'NVL(T433.PERCENTUALE,100) T433PERCENTUALE');
      S:=', V430_Storico V430,';
      SQLOri:=StringReplace(SQLOri,S,S + ' T433_CDC_Percent T433,',[rfIgnoreCase]);
      S:=':DataLavoro BETWEEN V430.T430DataDecorrenza AND V430.T430DataFine';
      SQLOri:=StringReplace(SQLOri,S,S + ' AND T030.PROGRESSIVO = T433.PROGRESSIVO(+) AND :DATALAVORO BETWEEN T433.DECORRENZA(+) and T433.DECORRENZA_FINE(+)',[rfIgnoreCase]);
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=SQLOri;
    end;
    //Join C700 storica coi CDC percentualizzati
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.PeriodiStorici and
       R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CDCPercentualizzati then
    begin
      SQLOri:=C700SelAnagrafe.SQL.Text;
      R180InserisciColonna(SQLOri,'NVL(T433.CODICE,V430.T430' + Parametri.CampiRiferimento.C13_CDCPercentualizzati + ') T433CODICE');
      R180InserisciColonna(SQLOri,'NVL(T433.PERCENTUALE,100) T433PERCENTUALE');
      ST433:='(' + StringReplace(A000T433,':CENTRO_COSTO',Parametri.CampiRiferimento.C13_CDCPercentualizzati,[rfReplaceAll,rfIgnoreCase]) + ') T433';
      S:=', V430_Storico V430,';
      SQLOri:=StringReplace(SQLOri,S,S + #13#10 + ST433 + ',' + #13#10,[rfIgnoreCase]);
      SQLOri:=StringReplace(SQLOri,
                            ':DATALAVORO BETWEEN V430.T430DATADECORRENZA AND V430.T430DATAFINE',
                            //'T433.DECORRENZA <= :DATALAVORO AND T433.DECORRENZA_FINE >= :DATALAVOROI ' +
                            //'AND T030.PROGRESSIVO = T433.PROGRESSIVO AND T433.DECORRENZA BETWEEN T430DATADECORRENZA AND T430DATAFINE',
                            'GREATEST(T433.DECORRENZA, T430DATADECORRENZA) <= :DATALAVORO AND LEAST(T433.DECORRENZA_FINE, T430DATAFINE) >= :DATALAVOROI ' +
                            'AND T030.PROGRESSIVO = T433.PROGRESSIVO AND T433.DECORRENZA <= T430DATAFINE AND T433.DECORRENZA_FINE >= T430DATADECORRENZA',
                            [rfIgnoreCase]);
      SQLOri:=StringReplace(SQLOri,
                            'AND :DATALAVORO BETWEEN NVL(P430DECORRENZA,:DATALAVORO) AND NVL(P430DECORRENZA_FINE,:DATALAVORO)',
                            '',
                            [rfIgnoreCase]);
      SQLOri:=StringReplace(SQLOri,
                            ',T430DATADECORRENZA,T430DATAFINE',
                            //',T433.DECORRENZA T430DATADECORRENZA,T433.DECORRENZA_FINE T430DATAFINE',
                            ',GREATEST(T433.DECORRENZA, T430DATADECORRENZA) T430DATADECORRENZA, LEAST(T433.DECORRENZA_FINE, T430DATAFINE) T430DATAFINE',
                            [rfIgnoreCase]);
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=SQLOri;
      C700SelAnagrafe.DeclareVariable('DATALAVOROI',otDate);
      C700SelAnagrafe.SetVariable('DATALAVOROI',DataI);
    end;
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CDCPercentualizzati then
      //Apertura query delle descrizioni
      with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
      begin
        selCDCPerc.Close;
        if A000LookupTabella(Parametri.CampiRiferimento.C13_CDCPercentualizzati,selCDCPerc) then
        begin
          if selCDCPerc.VariableIndex('DECORRENZA') >= 0 then
            selCDCPerc.Setvariable('DECORRENZA',D);
          selCDCPerc.Open;
        end;
      end;
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.PeriodiStorici then
    begin
      SetInizioPeriodoC700;
      SetFinePeriodoC700;
    end;
    try
      C700SelAnagrafe.Open;
    except
      on E:Exception do
        raise Exception.Create('La selezione effettuata non è valida!' + #13#10 + E.Message);
    end;
    if C700SelAnagrafe.RecordCount = 0 then
      raise Exception.Create('Nessun dipendente selezionato!');
    if R003FGeneratoreStampeDtM.ControllaSemaforo then
    begin
      S:=Format('Stampa impegnata dall''operatore %s il %s',[Parametri.Operatore,FormatDateTime('dd/mm/yyyy hh.nn.ss',R003FGeneratoreStampeDtM.selT919.FieldByName('DATA').AsDateTime)]);
      if TipoModulo = 'CS' then
        if MessageDlg(S + #13#10 + 'L''esecuzione richiesta bloccherà la precedente elaborazione.' + #13#10 + 'Continuare?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
          Abort;
    end;
    R003FGeneratoreStampeDtM.BloccaSemaforo;

    with R003FGeneratoreStampeDtM do
    begin
      //Cancello Tabelle temporanee ("T920_%") più vecchie di un anno
      selDropTabs.Close;
      selDropTabs.Open;
      exeDropTabs.Lines.Clear;
      while Not selDropTabs.Eof do
      begin
        exeDropTabs.Lines.Add(selDropTabs.FieldByName('DROPTAB').AsString);
        selDropTabs.Next;
      end;
      exeDropTabs.Execute;
      //Cancello Tabelle utenti ("T920%") più vecchie di un anno
      selDropUserTabs.Close;
      selDropUserTabs.Open;
      ExeDropTabs.Lines.Clear;
      DaData:= DataI;
      AData:= DataF;

      while not selDropUserTabs.Eof do
      begin
        exeDropTabs.Lines.Add('DROP TABLE T920' + R003FGeneratoreStampeMW.CreaNomeTabella(selDropUserTabs.FieldByName('TABELLA_GENERATA').AsString,DaData,AData) + ';');
        selDropUserTabs.Next;
      end;
      exeDropTabs.Execute;

      //Registra utilizzo stampa
      if Q910.State = dsBrowse then
      begin
      if Q910.FieldByName('CODICE').AsString <> '' then
        with R003FGeneratoreStampeMW.OperSQL do
        begin
          SQL.Text:='update T910_RIEPILOGO set DATA_ACCESSO = SYSDATE, UTENTE_ACCESSO = ''' + Parametri.Operatore + ''' where CODICE = ''' + Q910.FieldByName('CODICE').AsString + '''';
          Execute;
        end;
      end
      else
      begin
        Q910.FieldByName('DATA_ACCESSO').AsDateTime:=Now;
        Q910.FieldByName('UTENTE_ACCESSO').AsString:=Parametri.Operatore;
      end;
    end;
    try
      CreaTabelle;
      try
        R003FGeneratoreStampeDtM.CaricaT920;
      except
        ProgErrato:=C700Progressivo;
        raise;
      end;
      DatiDaPercentualizzare:=False;
      R003FGeneratoreStampeDtM.DatiStoriciT920;
      R003FGeneratoreStampeDtM.CaricaT920Join;
    finally
      try
        if R003FGeneratoreStampeDtM.selT919.Active and (R003FGeneratoreStampeDtM.selT919.RecordCount > 0) then
          R003FGeneratoreStampeDtM.selT919.Delete;
      except
      end;
      Screen.Cursor:=crDefault;
    end;
    with R003FStampa do
    begin
      try
        C001SettaQuickReport(QRep);
      except
      end;
      case cmbOrientamentoPag.ItemIndex of
        1:QRep.Page.Orientation:=poPortrait;
        2:QRep.Page.Orientation:=poLandScape;
      end;
      if cmbFormatoPag.ItemIndex > 0 then
        QRep.Page.PaperSize:=TQRPaperSize(cmbFormatoPag.ItemIndex - 1);
      QRep.DataSet:=R003FGeneratoreStampeDtM.cds920;
      LEnte.Caption:=Parametri.DAzienda;
      LTitolo.Caption:='';
      if R003FGeneratoreStampeDtM.Q910.FieldByName('STAMPA_TITOLO').AsString = 'S' then
        LTitolo.Caption:=DBEdit1.Text;
      if R003FGeneratoreStampeDtM.Q910.FieldByName('STAMPA_PERIODO').AsString = 'S' then
        //LTitolo.Caption:=LTitolo.Caption + ' (' + Format(A000TraduzioneStringhe(A000MSG_MSG_FMT_DALAL),[EDaData.Text,EAData.Text]) + ')';
        LTitolo.Caption:=LTitolo.Caption + Format('(%s - %s)',[frmInputPeriodo.edtInizio.Text, frmInputPeriodo.edtFine.Text]);
      LEnte.Enabled:=R003FGeneratoreStampeDtM.Q910.FieldByName('STAMPA_AZIENDA').AsString = 'S';
      qlblSysData.Enabled:=R003FGeneratoreStampeDtM.Q910.FieldByName('STAMPA_DATA').AsString = 'S';
      qlblSysPagina.Enabled:=R003FGeneratoreStampeDtM.Q910.FieldByName('STAMPA_NUMPAG').AsString = 'S';
      if LTitolo.Caption = '' then
        Titolo.Height:=LEnte.Top + LEnte.Height + 2
      else
        Titolo.Height:=LTitolo.Top + LTitolo.Height + 2;

      TestoIntestazione:='';
      TestoFineStampa:='';
      with R003FGeneratoreStampeDtM do
      begin
        if Q910.FieldByName('QUERY_INTESTAZIONE').AsString <> '' then
          TestoIntestazione:=GetTestoAggiuntivo(Q910.FieldByName('QUERY_INTESTAZIONE').AsString);
        if Q910.FieldByName('QUERY_FINESTAMPA').AsString <> '' then
          TestoFineStampa:=GetTestoAggiuntivo(Q910.FieldByName('QUERY_FINESTAMPA').AsString);
      end;

      CreazioneReport;
      if (Sender = Self) and (TipoModulo = 'COM') and (Trim(DocumentoPDF) <> '') and (Trim(DocumentoPDF) <> '<VUOTO>') then
      begin
        if R003FGeneratoreStampeDtM.cds920.RecordCount > 0 then
        begin
          QRep.ShowProgress:=False;
          if LowerCase(Copy(DocumentoPDF,Length(DocumentoPDF) - 3,4)) = '.pdf' then
            QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF))
          else if LowerCase(Copy(DocumentoPDF,Length(DocumentoPDF) - 3,4)) = '.xls' then
            QRep.ExportToFilter(TQRXLSFilter.Create(DocumentoPDF));
        end;
      end
      else if Sender = btnAnteprima then
      begin
        AnteprimaInCorso:=True;
        QRep.Preview;
        SessioneOracle.Commit;
      end
      else if Sender = btnStampa then
        QRep.Print;
    end;
  finally
    AnteprimaInCorso:=False;
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.PeriodiStorici then
    begin
      C700SelAnagrafe.DeleteVariables;
      if Pos('C700DATADAL',UpperCase(C700SelAnagrafe.SQL.Text)) > 0 then
        C700SelAnagrafe.DeclareVariable('C700DATADAL',otDate);
      C700SelAnagrafe.DeclareVariable('DATALAVORO',otDate);
    end;
    //C700SelAnagrafe.SetVariable('DataLavoro',StrToDate(EAData.Text));
    frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI, DataF);

    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.PeriodiStorici or
       R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CDCPercentualizzati then
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
    if ProgErrato <> -1 then
      C700SelAnagrafe.SearchRecord('PROGRESSIVO',ProgErrato,[srFromBeginning]);
    Screen.Cursor:=crDefault;
  end;
  if DropTabelleTemp then
  begin
    R003FGeneratoreStampeDtM.DropT920(0);
    for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate) do
      R003FGeneratoreStampeDtM.DropT920(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate[i].M);
  end;
  //if (Sender = btnTabella) and (Trim(DocumentoPDF) = '') then
  if (Sender = btnTabella) and (TipoModulo = 'CS') then
    ShowMessage('Dati registrati sulla tabella T920' + TabellaStampa);
end;

procedure TR003FGeneratoreStampe.btnChiaviClick(Sender: TObject);
var i,MaxLength:integer;
begin
  inherited;
  //if High(DatiStampa) < 0 then
  C013FCheckList:=TC013FCheckList.Create(Self);
  try
    C013FCheckList.Caption:='Campi chiave';
    CreaDatiDiStampa;
    MaxLength:=0;
    with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
    begin
      for i:=low(DatiStampa) to High(DatiStampa) do
      begin
        C013FCheckList.clbListaDati.Items.Add(DatiStampa[i].D);
        if Length(DatiStampa[i].D) > MaxLength then
          MaxLength:=Length(DatiStampa[i].D);
      end;
    end;
    R180PutCheckList(dEdtChiavi.Text,MaxLength,C013FCheckList.clbListaDati,',');
    C013FCheckList.clbListaDati.Sorted:=True;
    C013FCheckList.ShowModal;
    R003FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA_KEY').AsString:=
    R180GetCheckList(MaxLength,C013FCheckList.clbListaDati,',');
  finally
    FreeAndNil(C013FCheckList);
  end;
end;

procedure TR003FGeneratoreStampe.btnDeleteClick(Sender: TObject);
var Temp:String;
begin
  inherited;
  R003FFormato:=TR003FFormato.Create(nil);
  with R003FFormato do
    try
      R003FFormato.Caption:='Dati disponibili';
      R003FFormato.Label1.Caption:='Nome dato';
      R003FFormato.UsaDato:=False;
      CreaDatiDiStampa;
      R003FFormato.UsaDato:=False;
      if ShowModal = mrOk then
      begin
        Temp:=R003FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA_DELETE').AsString;
        Insert(ComboBox1.Text,Temp,dEdtDelete.SelStart);
        R003FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA_DELETE').AsString:=Temp;
      end;
    finally
      Release;
    end;
end;

procedure TR003FGeneratoreStampe.CreaDatiDiStampa;
{Caricamento in DatiStampa di tutti i dati selezionati}
var
  aCompIntestazione,
  aCompDettaglio: Array of String;
  i:Integer;
begin
  if (Intestazione.ComponentCount = 0) and (Dettaglio.ComponentCount = 0) then
    raise Exception.Create(A000MSG_R003_ERR_NO_DATO_STAMPA);

  SetLength(aCompIntestazione,Intestazione.ComponentCount);
  for i:=0 to Intestazione.ComponentCount - 1 do
    aCompIntestazione[i]:=Identificatore(TLabel(Intestazione.Components[i]).Hint);

  SetLength(aCompDettaglio,Dettaglio.ComponentCount);
  for i:=0 to Dettaglio.ComponentCount - 1 do
    aCompDettaglio[i]:=Identificatore(TLabel(Dettaglio.Components[i]).Hint);

  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.CaricaDatiDiStampa(aCompIntestazione,aCompDettaglio);
  SetLength(aCompIntestazione,0);
  SetLength(aCompDettaglio,0);
end;

function TR003FGeneratoreStampe.Molteplice(Num:Byte):Integer;
{Restituisce l'indice di TabelleCollegate se esiste in stampa almeno un dato con la molteplicità specificata}
var i:Integer;
begin
  Result:=-1;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(TabelleCollegate) do
      if (TabelleCollegate[i].M = Num) and TabelleCollegate[i].Esiste then
      begin
        Result:=i;
        Break;
      end;
  end;
end;

function TR003FGeneratoreStampe.EsisteRoutine(R:Word):Boolean;
var i:Integer;
begin
  Result:=False;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
      if Dati[DatiStampa[i].N].R = R then
      begin
        Result:=True;
        Break;
      end;
  end;
end;

procedure TR003FGeneratoreStampe.Pulisci1Click(Sender: TObject);
{Eliminazione di tutte le label dall'area di stampa (intestazione/dettaglio)}
var i:Integer;
begin
  if MessageDlg('Eliminare tutti i dati ?', mtConfirmation,[mbYes, mbNo],0) = mrYes then
  begin
    for i:=PopupMenu2.PopupComponent.ComponentCount - 1 downto 0 do
      TLabel(PopupMenu2.PopupComponent.Components[i]).Free;
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.modAreaStampa:=True;
  end;
end;

procedure TR003FGeneratoreStampe.Selezionatutto1Click(Sender: TObject);
{Selezione/Deselezione della CheckListBox collegata al PopupMenu3}
var i:Integer;
begin
  with (PopupMenu3.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=Sender = SelezionaTutto1;
end;


procedure TR003FGeneratoreStampe.Esportazionestampa1Click(Sender: TObject);
{Esportazione SQL di creazione della stampa su file sequenziale}
var L:TStringList;
  lstCodiciTabCollegate:TList<TCodiciTabCollegate>;
begin
  if DButton.DataSet.RecordCount = 0 then
    exit;
  SaveDialog1.FileName:=Trim(DBEdit4.Text) + '.sql';
  if not SaveDialog1.Execute then
    exit;
  L:=TStringList.Create;
  lstCodiciTabCollegate:=R003FGeneratoreStampeDtM.getListCodiciSelezionati;
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DuplicaStampa(L,'',lstCodiciTabCollegate);
  L.SaveToFile(SaveDialog1.FileName);
  L.Free;
  FreeAndNil(lstCodiciTabCollegate);
end;

procedure TR003FGeneratoreStampe.Importazionestampe1Click(Sender: TObject);
{Esecuzione dello script di creazione della stampa da file sequenziale}
var Lst:TStringList;
begin
  if not OpenDialog1.Execute then exit;
  try
    Lst:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.ImportaStampa(OpenDialog1.FileName);
    if Lst.Count >0 then
    begin
      OpenC012VisualizzaTesto('<R003> Anomalie riscontrate in fase di importazione della stampa','',Lst);
    end;
  finally
    FreeAndNil(Lst);
  end;
  cmbSerbatoiChange(nil);
  NumRecords;
end;

procedure TR003FGeneratoreStampe.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
{Selezione dipendenti}
begin
  C700DataDal:= IfThen(DataI > 0, DataI, Parametri.DataLavoro);
  C700DataLavoro:= IfThen(DataF > 0, DataF, Parametri.DataLavoro);
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TR003FGeneratoreStampe.cmbDatoDalAlChange(Sender: TObject);
begin
  inherited;
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].DatoDalAl:=cmbDatoDalAl.Text;
end;

procedure TR003FGeneratoreStampe.cmbSerbatoiChange(Sender: TObject);
{Caricamento dati del serbatoio selezionato}
var i,j:Integer;
    TabCodici,DettSerbatoi:Boolean;
    ListaCodici: TListaCodici;
begin
  //Caricamento serbatoio
  ListBox1.Items.Assign(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].lst);
  //Caricamento chiave di cumulo
  DettSerbatoi:=PageControl1.ActivePage = tabDettaglioSerbatoio;
  tabDettaglioSerbatoio.TabVisible:=False;
  lstKeyCumulo.Items.Clear;
  Memo1.Lines.Text:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].FiltroTxt;
  VisualizzaFiltri;
  chkFiltroEsclusivo.Checked:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].Esclusivo;
  lblDatoDalAl.Visible:=False;
  cmbDatoDalAl.Visible:=False;
  cmbDatoDalAl.ItemIndex:=-1;
  with R003FGeneratoreStampedtm.R003FGeneratoreStampeMW do
  begin
    if (IdxTabelleCollegateDaSerbatoi(cmbSerbatoi.ItemIndex) >= 0) and (R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate[IdxTabelleCollegateDaSerbatoi(cmbSerbatoi.ItemIndex)].DatiDalAl <> '') then
    begin
      lblDatoDalAl.Visible:=True;
      cmbDatoDalAl.Visible:=True;
      cmbDatoDalAl.Items.CommaText:=',' + TabelleCollegate[IdxTabelleCollegateDaSerbatoi(cmbSerbatoi.ItemIndex)].DatiDalAl;
      cmbDatoDalAl.ItemIndex:=cmbDatoDalAl.Items.IndexOf(Serbatoi[cmbSerbatoi.ItemIndex].DatoDalAl)
    end;
    if Serbatoi[cmbSerbatoi.ItemIndex].Multiplo then
    begin
      tabDettaglioSerbatoio.TabVisible:=True;
      i:=cmbSerbatoi.ItemIndex;
      for j:=0 to High(Serbatoi[i].KeyCumulo) do
        lstKeyCumulo.Items.Add(Serbatoi[i].KeyCumulo[j].Nome);
    end;
  end;
  //visualizzazione lista codici collegata
  TabCodici:=PageControl1.ActivePage = tabSelezioneCodici;
  tabSelezioneCodici.TabVisible:=False;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(TabelleCollegate) do
    begin
      ListaCodici:=getCheckListBoxTabellaCollegata(TabelleCollegate[i].M);
      if ListaCodici.chklst <> nil then
      begin
        ListaCodici.chklst.Align:=alClient;
        ListaCodici.chklst.Visible:=TabelleCollegate[i].M = R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].M;
        if ListaCodici.chklst.Visible then
          tabSelezioneCodici.TabVisible:=True;
      end;
    end;
  end;
  if TabCodici and tabSelezioneCodici.TabVisible then
    PageControl1.ActivePage:=tabSelezioneCodici
  else if DettSerbatoi and tabDettaglioSerbatoio.TabVisible then
    PageControl1.ActivePage:=tabDettaglioSerbatoio;
end;

procedure TR003FGeneratoreStampe.lstKeyCumuloDblClick(
  Sender: TObject);
{Cancellazione KeyCumulo}
var i:Integer;
begin
  if lstKeyCumulo.ItemIndex >= 0 then
  begin
    for i:=lstKeyCumulo.ItemIndex to High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo) - 1 do
      R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i]:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i + 1];
    SetLength(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo,Length(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo) - 1);
    lstKeyCumulo.Items.Delete(lstKeyCumulo.ItemIndex);
    R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.modDettaglioSerbatoio:=True;
    RefreshLstKeyCumuloGlobale;
  end;
end;

procedure TR003FGeneratoreStampe.lstKeyCumuloDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=(Sender as TListBox).Items.IndexOf(ListBox1.Items[ListBox1.ItemIndex]) = -1;
  try
    Accept:=Accept and (R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(ListBox1.Items[ListBox1.ItemIndex],False)].KC = 1);
  except
    Accept:=False;
  end;
end;

procedure TR003FGeneratoreStampe.lstKeyCumuloDragDrop(Sender,
  Source: TObject; X, Y: Integer);
{Trascinamento e rilascio su KeyCumulo}
var i,P:Integer;
    TP:TPoint;
begin
  TP.X:=X;
  TP.Y:=Y;
  P:=lstKeyCumulo.ItemAtPos(TP,False);
  SetLength(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo,Length(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo) + 1);
  for i:=High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo) - 1 downto P do
    R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i + 1]:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i];
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[P].Nome:=ListBox1.Items[ListBox1.ItemIndex];
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[P].Totale:=False;
  lstKeyCumulo.Items.Insert(P,ListBox1.Items[ListBox1.ItemIndex]);
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.modDettaglioSerbatoio:=True;
  RefreshLstKeyCumuloGlobale;
end;

procedure TR003FGeneratoreStampe.lstKeyCumuloMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var TP:TPoint;
begin
  TP.X:=X;
  TP.Y:=Y;
  if (Button = mbRight) and (lstKeyCumulo.ItemAtPos(TP,True) >= 0) then
    lstKeyCumulo.ItemIndex:=lstKeyCumulo.ItemAtPos(TP,True);
  ItemSort:=lstKeyCumulo.ItemIndex;
end;

procedure TR003FGeneratoreStampe.lstKeyCumuloMouseUp(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
{Spostamento degli elementi all'interno della lista}
var SW:TKeyCumulo;
    i:Integer;
begin
  if (ItemSort <> -1) and (ItemSort <> lstKeyCumulo.ItemIndex) then
  begin
    SW:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[ItemSort];
    if lstKeyCumulo.ItemIndex < ItemSort then
      for i:=ItemSort downto lstKeyCumulo.ItemIndex + 1 do
        R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i]:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i - 1]
    else
      for i:=ItemSort to lstKeyCumulo.ItemIndex - 1 do
        R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i]:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i + 1];
    R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[lstKeyCumulo.ItemIndex]:=SW;
    lstKeyCumulo.Items.Clear;
    for i:=0 to High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo) do
      lstKeyCumulo.Items.Add(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[i].Nome);
    R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.modDettaglioSerbatoio:=True;
    RefreshLstKeyCumuloGlobale;
  end;
  ItemSort:= - 1;
end;

procedure TR003FGeneratoreStampe.Memo1Change(Sender: TObject);
//Registro in memoria il filtro per il serbatoio selezionato
begin
  with R003FGeneratoreStampedtm.R003FGeneratoreStampeMW do
  begin
    Serbatoi[cmbSerbatoi.ItemIndex].FiltroTxt:=Memo1.Lines.Text;
    modFiltro:=True;
  end;
  VisualizzaFiltri;
end;

procedure TR003FGeneratoreStampe.VisualizzaFiltri;
var
  lst: TStringList;
{Visualizzazione globale dei filtri}
begin
  Memo2.Lines.Clear;

  lst:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.getElencoFiltri;
  try
   Memo2.Lines.Assign(lst);
  finally
    FreeAndNil(lst);
  end;
end;

procedure TR003FGeneratoreStampe.chkFiltroEsclusivoClick(Sender: TObject);
//Registro in memoria se il filtro è esclusivo per il serbatoio selezionato
begin
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].Esclusivo:=chkFiltroEsclusivo.Checked;
end;

procedure TR003FGeneratoreStampe.Memo1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=True;
end;

procedure TR003FGeneratoreStampe.Memo1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Trascinamento dei dati sul Filtro}
var RP:Integer;
    S:String;
begin
  RP:=Memo1.SelStart;
  S:=Memo1.Lines.Text;
  Insert(Identificatore(ListBox1.Items[ListBox1.ItemIndex]),S,RP + 1);
  Memo1.Lines.Text:=S;
  Memo1.SelStart:=RP + 1 + Length(Identificatore(ListBox1.Items[ListBox1.ItemIndex]));
  Memo1.SetFocus;
end;

procedure TR003FGeneratoreStampe.lstKeyCumuloDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Index > High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo) then exit;
  if odSelected in State then
  begin
    if R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[Index].Totale then
      lstKeyCumulo.Canvas.Brush.Color:=clBlack
    else
      lstKeyCumulo.Canvas.Brush.Color:=clHighLight;
  end
  else if R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[Index].Totale then
    lstKeyCumulo.Canvas.Brush.Color:=cl3DLight
  else
    lstKeyCumulo.Canvas.Brush.Color:=clWindow;
  lstKeyCumulo.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,lstKeyCumulo.Items[Index]);
end;

procedure TR003FGeneratoreStampe.mnuTotKeyCumuloClick(Sender: TObject);
begin
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[lstKeyCumulo.ItemIndex].Totale:=not R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[lstKeyCumulo.ItemIndex].Totale;
  lstKeyCumulo.Refresh;
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.modDettaglioSerbatoio:=True;
  RefreshLstKeyCumuloGlobale;
end;

procedure TR003FGeneratoreStampe.popKeyCumuloPopup(Sender: TObject);
begin
  mnuTotKeyCumulo.Visible:=lstKeyCumulo.ItemIndex >= 0;
  if lstKeyCumulo.ItemIndex >= 0 then
    mnuTotKeyCumulo.Checked:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[lstKeyCumulo.ItemIndex].Totale;
end;

procedure TR003FGeneratoreStampe.RefreshLstKeyCumuloGlobale;
var lst: TStringList;
begin
  lstKeyCumuloGlobale.Items.Clear;
  lst:=R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.getRiepilogoKeyCumulo;
  try
    lstKeyCumuloGlobale.items.Assign(lst);
  finally
    FreeAndNil(lst);
  end;
end;

function TR003FGeneratoreStampe.GetIdxTabelleCollegate(R:Byte):Integer;
{Restituisce l'indice di TabelleCollegate a fronte dell'indice di routine R}
var i,j,M:Integer;
begin
  Result:=-1;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(Dati) do
      if Dati[i].R = R then
      begin
        M:=Dati[i].M;
        for j:=0 to High(TabelleCollegate) do
          if TabelleCollegate[j].M = M then
          begin
            Result:=j;
            Break;
          end;
        Break;
      end;
  end;
end;

function TR003FGeneratoreStampe.GetIdxSerbatoi(R:Byte):Integer;
{Restituisce l'indice di Serbatoi a fronte dell'indice di routine R}
var i,j,M:Integer;
begin
  Result:=-1;
  for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati) do
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[i].R = R then
    begin
      M:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[i].M;
      for j:=0 to High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi) do
        if R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[j].M = M then
        begin
          Result:=j;
          Break;
        end;
      Break;
    end;
end;

function TR003FGeneratoreStampe.IdxSerbatoiDaTabelleCollegate(idx:Byte):Integer;
var i:Integer;
begin
  Result:=-1;
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(Serbatoi) do
      if Serbatoi[i].M = TabelleCollegate[idx].M then
      begin
        Result:=i;
        Break;
      end;
  end;
end;

function TR003FGeneratoreStampe.KeyCumuloTotaleCount:Integer;
var i,j:Integer;
begin
  Result:=0;
  for i:=0 to High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi) do
    for j:=0 to High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[i].KeyCumulo) do
      if R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[i].KeyCumulo[j].Totale then
        inc(Result);
end;

procedure TR003FGeneratoreStampe.Ricercatestocontenuto1Click(Sender: TObject);
var i:Integer;
begin
  if ListBox1.ItemIndex = -1 then
    exit;
  ListBox1Search:=Trim(InputBox('Ricerca per testo contenuto','Nome dato',ListBox1Search));
  for i:=0 to ListBox1.Items.Count - 1 do
    if Pos(UpperCase(ListBox1Search),UpperCase(ListBox1.Items[i])) > 0 then
    begin
      ListBox1.ItemIndex:=i;
      Break;
    end;
end;

procedure TR003FGeneratoreStampe.Ripetisuogniriga1Click(Sender: TObject);
{Attiva/Disattiva la ripetizione dei dati anagrafici su ogni riga di dettaglio}
var P:Integer;
begin
  P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.GetDato(TLabel(PopupMenu1.PopupComponent).Hint,False);
  if P >= 0 then
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Ripetuto:=not R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Dati[P].Ripetuto;
end;

procedure TR003FGeneratoreStampe.Successivo2Click(Sender: TObject);
var i:Integer;
begin
  if ListBox1.ItemIndex = -1 then
    exit;
  if ListBox1Search = '' then
  begin
    Ricercatestocontenuto1Click(nil);
    exit;
  end;
  for i:=ListBox1.ItemIndex + 1 to ListBox1.Items.Count - 1 do
    if Pos(UpperCase(ListBox1Search),UpperCase(ListBox1.Items[i])) > 0 then
    begin
      ListBox1.ItemIndex:=i;
      Break;
    end;
end;

procedure TR003FGeneratoreStampe.LSortDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Index > High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento) then exit;
  if odSelected in State then
  begin
    if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[Index].Rottura then
      LSort.Canvas.Brush.Color:=clMaroon
    else
      LSort.Canvas.Brush.Color:=clHighLight;
  end
  else if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[Index].Rottura then
    LSort.Canvas.Brush.Color:=clRed
  else
    LSort.Canvas.Brush.Color:=$0080FF80;
  if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[Index].Discendente then
    LSort.Canvas.Font.Style:=[fsUnderline]
  else
    LSort.Canvas.Font.Style:=[];
  LSort.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,LSort.Items[Index]);
end;

procedure TR003FGeneratoreStampe.mnuRotturaOrdinamentoClick(
  Sender: TObject);
{Definizione della rottura di chiave}
begin
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    Ordinamento[LSort.ItemIndex].Rottura:=not R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[LSort.ItemIndex].Rottura;
    modOrdinamento:=True;
  end;
  LSort.Refresh;
end;

procedure TR003FGeneratoreStampe.mnuAccediA062Click(Sender: TObject);
var S:String;
begin
  inherited;
  S:=TDBLookupComboBox(popmnuAccediA062.PopupComponent).Field.AsString;
  AccediA062(S,'');
end;

procedure TR003FGeneratoreStampe.mnuDiscendenteClick(Sender: TObject);
{Definizione dei campi con ordinamento discendente}
begin
  with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
  begin
    Ordinamento[LSort.ItemIndex].Discendente:=not R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[LSort.ItemIndex].Discendente;
    modOrdinamento:=True;
  end;
  LSort.Refresh;
end;

procedure TR003FGeneratoreStampe.popOrdinamentoPopup(Sender: TObject);
begin
  if LSort.ItemIndex < 0 then
    Abort;
  mnuRotturaOrdinamento.Checked:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[LSort.ItemIndex].Rottura;
  mnuDiscendente.Checked:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[LSort.ItemIndex].Discendente;
end;

procedure TR003FGeneratoreStampe.Daticalcolati1Click(Sender: TObject);
var i:Integer;
begin
  R003FDatiCalcolati:=TR003FDatiCalcolati.Create(nil);
  with R003FDatiCalcolati do
  begin
    R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.selT909.SearchRecord('ID_SERBATOIO',R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].X,[srFromBeginning]);
    if ListBox1.ItemIndex >= 0 then
      R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.selT909.SearchRecord('NOME',ListBox1.Items[ListBox1.ItemIndex],[srFromBeginning]);
    for i:=0 to High(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi) do
      dcmbSerbatoi.Items.Add(IntToStr(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[i].X));
    ShowModal;
    Release;
  end;
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.ElencoDatiCalcolati;
  cmbSerbatoiChange(nil);
end;

procedure TR003FGeneratoreStampe.Ordinealfabetico1Click(Sender: TObject);
begin
  inherited;
  Ordinealfabetico1.Checked:=not Ordinealfabetico1.Checked;
  ListBox1.Sorted:=Ordinealfabetico1.Checked;
  if not ListBox1.Sorted then
    ListBox1.Items.Assign(R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].lst);
end;

procedure TR003FGeneratoreStampe.hChange(Sender: TObject);
begin
  inherited;
  btnTabella.Enabled:=Trim(dedtTabellaStampa.Text) <> '';
end;

procedure TR003FGeneratoreStampe.Interrogazionidiservizio1Click(Sender: TObject);
var
  DaData: TDateTime;
  AData: TDateTime;
  S:String;
begin
  DaData:= DataI;
  AData:= DataF;

  S:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.SQLInterrogazioniServizio(DaData,AData);
  AccediA062('',S);
end;

procedure TR003FGeneratoreStampe.AccediA062(Nome,SQL:String);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA062QueryServizio(Nome,SQL);
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.selT002.Refresh;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW);
end;

procedure TR003FGeneratoreStampe.frmSelAnagrafebtnSuccessivoClick(
  Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnBrowseClick(Sender);
end;

procedure TR003FGeneratoreStampe.dchkPeriodoStoricoClick(Sender: TObject);
begin
  inherited;
  //dchkCDCPercentualizzati.Enabled:=not dchkPeriodoStorico.Checked;
end;

procedure TR003FGeneratoreStampe.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
  DistruggiIntestazione;
  DistruggiDettaglio;
end;

{ DataI }
function TR003FGeneratoreStampe._GetDataI: TDateTime;
begin
  Result := frmInputPeriodo.DataInizio;
end;
procedure TR003FGeneratoreStampe._PutDataI(const Value: TDateTime);
begin
  frmInputPeriodo.DataInizio := Value;
end;
{ DataI----- }
{ DataF }
function TR003FGeneratoreStampe._GetDataF: TDateTime;
begin
  Result := frmInputPeriodo.DataFine;
end;
procedure TR003FGeneratoreStampe._PutDataF(const Value: TDateTime);
begin
  frmInputPeriodo.DataFine := Value;
end;
{ DataF----- }
end.
