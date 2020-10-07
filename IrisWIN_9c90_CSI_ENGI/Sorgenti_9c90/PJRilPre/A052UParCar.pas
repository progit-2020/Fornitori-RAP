unit A052UParCar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  DBCtrls, Grids, A027UCostanti, C180FunzioniGenerali, ActnList, ImgList,
  ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, C007ULabelSize, OracleData, Variants,
  C013UCheckList, System.Actions,A052UParCarMW;

type
  TA052FParCar = class(TR001FGestTab)
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DatiIntestazione: TDBLookupListBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    BFont: TBitBtn;
    Intestazione: TScrollBox;
    PopupMenu1: TPopupMenu;
    LLeft: TLabel;
    LTop: TLabel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Riepilogo: TScrollBox;
    Panel10: TPanel;
    LLeft3: TLabel;
    LTop3: TLabel;
    BFont3: TBitBtn;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    DatiRiepilogo: TListBox;
    Cancella2: TMenuItem;
    Caption1: TMenuItem;
    Dimensioni1: TMenuItem;
    FontDialog1: TFontDialog;
    N10: TMenuItem;
    BCancella3: TBitBtn;
    BCancella: TBitBtn;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    LLeft2: TLabel;
    LTop2: TLabel;
    BFont2: TBitBtn;
    BCancella2: TBitBtn;
    Dettaglio: TScrollBox;
    DatiDettaglio: TListBox;
    N11: TMenuItem;
    Propriet1: TMenuItem;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    tabTitolo: TTabSheet;
    dchkRagioneSociale: TDBCheckBox;
    dchkNumPagine: TDBCheckBox;
    Label3: TLabel;
    dedtDataStampa: TDBEdit;
    Label4: TLabel;
    dedtMargineSup: TDBEdit;
    Label5: TLabel;
    dedtLogoLarghezza: TDBEdit;
    cmbOrientamento: TComboBox;
    Label6: TLabel;
    dchkIntestazioneRipetuta: TDBCheckBox;
    Label7: TLabel;
    dedtAssenzeNoRiepilogo: TDBEdit;
    btnSceltaAssenze: TButton;
    drgpValCartellino: TDBRadioGroup;
    procedure IntestazioneDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure IntestazioneDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DatiIntestazioneClick(Sender: TObject);
    procedure BFontClick(Sender: TObject);
    procedure Cancella2Click(Sender: TObject);
    procedure Caption1Click(Sender: TObject);
    procedure Dimensioni1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure DatiRiepilogoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BCancellaClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Propriet1Click(Sender: TObject);
    procedure btnSceltaAssenzeClick(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    MuoviOggetto:Boolean;
    var DW,DH:LongInt;
    LT,LL:TLabel;
    function PosizioneIntestazione(Nome:string):integer;
    procedure OggettoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
                               X, Y: Integer);
    procedure OggettoMouseUp(Sender: TObject; Button: TMouseButton;
                             Shift: TShiftState; X, Y: Integer);
    procedure OggettoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure GetDatiDettaglio;
    procedure GetDatiRiepilogo;
    function PosizioneDettaglio(Nome:string):integer;
    function PosizioneRiepilogo(Nome:string):integer;
  public
    { Public declarations }
    procedure DistruggiIntestazione;
    procedure DistruggiRiepilogo;
    procedure DistruggiDettaglio;
    procedure AddLabel(Sezione:String; LabelProperties:TLabelProperties);
  end;

var
  A052FParCar: TA052FParCar;
  StartX,StartY:Integer;

procedure OpenA052ParCar(C:String);

implementation

uses A052UParCarDtM1, A052UProprieta;

{$R *.DFM}

procedure OpenA052ParCar(C:String);
{Parametrizzazione stampa del cartellino}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA052ParCar') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A052FParCar:=TA052FParCar.Create(nil);
  with A052FParCar do
  try
    A052FParCarDtM1:=TA052FParCarDtM1.Create(nil);
    A052FParCarDtM1.selT950.SearchRecord('CODICE',C,[srfromBeginning]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A052FParCarDtM1.Free;
    Release;
  end;
end;

procedure TA052FParCar.FormCreate(Sender: TObject);
{Creazione della form con caricamento costanti per Dettaglio e Riepilogo e
 impostazione varibili DefWidth/DefHeight in base al font delle scroll box}
begin
  inherited;
  PageControl1.ActivePage:=tabTitolo;
  GetDatiDettaglio;
  GetDatiRiepilogo;
end;

procedure TA052FParCar.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A052FParCarDtM1.selT950;
  inherited;
end;

procedure TA052FParCar.GetDatiRiepilogo;
{Caricamento della ListBox DatiRiepilogo con i dati contenuti in
 A027UCostanti.DatiRiep}
var i:Byte;
begin
  DatiRiepilogo.Items.Clear;
  for i:=1 to High(DatiRiep) do
    DatiRiepilogo.Items.Add(DatiRiep[i].D);
end;

procedure TA052FParCar.GetDatiDettaglio;
{Caricamento della ListBox DatiDettaglio con i dati contenuti in
 A027UCostanti.DatiDett}
var i:Byte;
begin
  DatiDettaglio.Items.Clear;
  for i:=1 to High(DatiDett) do
    DatiDettaglio.Items.Add(DatiDett[i].D);
end;

procedure TA052FParCar.DButtonDataChange(Sender: TObject; Field: TField);
{Carico la configurazione corrente}
begin
  (*if (Field = nil) and (DButton.State = dsBrowse) and (DButton.DataSet.RecordCount > 0) then
    begin
    A052FParCarDtM1.CaricaImpostazioni;
    SettaFontIntestazione;
    SettaFontDettaglio;
    SettaFontRiepilogo;
    end;
  *)
end;

procedure TA052FParCar.DButtonStateChange(Sender: TObject);
{Abilitazione/Disabilitazione dei TabSheet in base allo stato del DataSet}
begin
  inherited;
  TabSheet1.Enabled:=DButton.State in [dsEdit,dsInsert];
  TabSheet2.Enabled:=DButton.State in [dsEdit,dsInsert];
  TabSheet3.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbOrientamento.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

function TA052FParCar.PosizioneIntestazione(Nome:string):integer;
{Ricerca del dato identificato da Nome nella lista delle intestazioni}
var i:integer;
begin
  Result:=-1;
  for i:=0 to Intestazione.ComponentCount - 1 do
    if Trim(TLabel(Intestazione.Components[i]).Hint) = Trim(Nome) then
    begin
      Result:=i;
      Break;
    end
    else
      Result:=-1;
end;

function TA052FParCar.PosizioneDettaglio(Nome:string):integer;
{Ricerca del dato identificato da Nome nella lista del dettaglio}
var i:integer;
begin
  Result:=-1;
  for i:=0 to Dettaglio.ComponentCount - 1 do
    if Trim(TLabel(Dettaglio.Components[i]).Hint) = Trim(Nome) then
    begin
      Result:=i;
      Break;
    end
    else
      Result:=-1;
end;

function TA052FParCar.PosizioneRiepilogo(Nome:string):integer;
{Ricerca del dato identificato da Nome nella lista del riepilogo}
var i:integer;
begin
  Result:=-1;
  for i:=0 to Riepilogo.ComponentCount - 1 do
    if Trim(TLabel(Riepilogo.Components[i]).Hint) = Trim(Nome) then
    begin
      Result:=i;
      Break;
    end
    else
      Result:=-1;
end;

procedure TA052FParCar.IntestazioneDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
{Trascinamento dei dati dalla lista alla scrollbox}
var
  AllowMultiple: boolean;
  t:Integer;
begin
  Accept:=False;
  if Source = DatiIntestazione then  //Intestazione
    Accept:=PosizioneIntestazione(A052FParCarDtM1.A052FParCarMW.selI010.FieldByName('NOME_CAMPO').AsString) = -1
  else if Source = DatiDettaglio then  //Dettaglio
    Accept:=PosizioneDettaglio(DatiDettaglio.Items[DatiDettaglio.ItemIndex]) = -1
  else if Source = DatiRiepilogo then  //Riepilogo
  begin
    AllowMultiple:=False;
    for t in TSezione.TAG_MULTIPLI do
    begin
      if t = DatiRiep[DatiRiepilogo.ItemIndex + 1].N  then
        AllowMultiple:=True;
    end;
    if AllowMultiple then
      //Accetto sempre il Dato Libero in modo da poterne inserire più di uno
      Accept:=True
    else
      Accept:=PosizioneRiepilogo(DatiRiepilogo.Items[DatiRiepilogo.ItemIndex]) = -1;
  end;
end;

procedure TA052FParCar.IntestazioneDragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Gestisco il rilascio dell'oggetto sulla ScrollBox Intestazione}
var
  LabelProperties : TLabelProperties;
  sezione: String;
begin
  try
    if Sender = Intestazione then  //Intestazione
    begin
      LabelProperties:=A052FParCarDtM1.A052FParCarMW.CreaLabelIntestazione(X, Y);
      sezione:=TSezione.INTESTAZIONE;
      AddLabel(sezione,LabelProperties);
    end
    else if Sender = Dettaglio then  //Dettaglio
    begin
      LabelProperties:=A052FParCarDtM1.A052FParCarMW.CreaLabelDettaglio(DatiDett[DatiDettaglio.ItemIndex + 1], X, Y);
      sezione:=TSezione.DETTAGLIO;
      AddLabel(sezione,LabelProperties);
    end
    else if Sender = Riepilogo then  //Riepilogo
    begin
      LabelProperties:=A052FParCarDtM1.A052FParCarMW.CreaLabelRiepilogo(DatiRiep[DatiRiepilogo.ItemIndex + 1], X, Y);
      sezione:=TSezione.RIEPILOGO;
      AddLabel(sezione,LabelProperties);
    end;
    //devo aggiungere anche all'array lstLabels perchè per la creazione
    //del uniqueName delle labels devo avere tutti i componenti correttamente impostati
    //NON METTERE QUESTO CODICE IN ADDLABEL PERCHE USATO ANCHE IN CARICAMENTO
    A052FParCarDtM1.A052FParCarMW.dicSezioni[sezione].addLabel(LabelProperties);

  finally
    //NON FARE FREE DI LabelProperties perchè aggiunta all lstLabels
    //FreeAndNil(LabelProperties);
  end;
end;

procedure TA052FParCar.AddLabel(Sezione:String; LabelProperties:TLabelProperties);
{Creo una TLabel e la inserisco nella ScrollBox appropriata}
var IntApp:TLabel;
begin
  IntApp:=nil;
  if Sezione = TSezione.INTESTAZIONE then
  begin
    IntApp:=TLabel.Create(Intestazione);
    IntApp.Parent:=Intestazione;
    IntApp.PopupMenu:=PopupMenu1;
  end
  else if Sezione = TSezione.DETTAGLIO then
  begin
    IntApp:=TLabel.Create(Dettaglio);
    IntApp.Parent:=Dettaglio;
    IntApp.PopupMenu:=PopupMenu1;
  end
  else
  begin
    IntApp:=TLabel.Create(Riepilogo);
    IntApp.Parent:=Riepilogo;
    IntApp.PopupMenu:=PopupMenu1;
  end;

  IntApp.Top:=LabelProperties.Top;
  IntApp.Left:=LabelProperties.Left;
  IntApp.Tag:=LabelProperties.Tag;
  IntApp.Autosize:=False;
  IntApp.Name:=LabelProperties.uniqueName;
  IntApp.Hint:=LabelProperties.Name;
  IntApp.Caption:=LabelProperties.Caption;
  IntApp.Height:=LabelProperties.Height;
  IntApp.Width:=LabelProperties.Width;
  IntApp.Transparent:=False;
  IntApp.OnMouseDown:=OggettoMouseDown;
  IntApp.OnMouseUp:=OggettoMouseUp;
  IntApp.Color:=clWhite;
  IntApp.ParentFont:=True;
end;

//------------------------------------------------------------------------------

procedure TA052FParCar.TAnnullaClick(Sender: TObject);
var RI:String;
begin
  inherited;
  RI:=A052FParCarDtM1.selT950.RowID;
  A052FParCarDtM1.selT950.Refresh;
  A052FParCarDtM1.selT950.SearchRecord('ROWID',RI,[srFromBeginning]);
end;

procedure TA052FParCar.OggettoMouseDown(Sender: TObject; Button: TMouseButton;
                                      Shift: TShiftState;X, Y: Integer);
{Impostazioni per spostare la label}
begin
  if Button <> mbLeft then exit;
  StartX:=x;
  StartY:=y;
  if PageControl1.ActivePage = TabSheet1 then  //Intestazione
  begin
    with A052FParCarDtM1.A052FParCarMW.dicSezioni[TSezione.INTESTAZIONE] do
    begin
      DW:=getDefWidth;
      DH:=getDefHeight;
    end;
    LT:=LTop;
    LL:=LLeft;
  end
  else if PageControl1.ActivePage = TabSheet2 then  //Dettaglio
  begin
    with A052FParCarDtM1.A052FParCarMW.dicSezioni[TSezione.DETTAGLIO] do
    begin
      DW:=getDefWidth;
      DH:=getDefHeight;
    end;
    LT:=LTop2;
    LL:=LLeft2;
  end
  else if PageControl1.ActivePage = TabSheet3 then  //Riepilogo
  begin
    with A052FParCarDtM1.A052FParCarMW.dicSezioni[TSezione.RIEPILOGO] do
    begin
      DW:=getDefWidth;
      DH:=getDefHeight;
    end;
    LT:=LTop3;
    LL:=LLeft3;
  end;

  LT.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
  LL.Caption:='X:' + IntToStr(TLabel(Sender).Left);

  TLabel(Sender).OnMouseMove:=OggettoMouseMove;
  MuoviOggetto:=True;
end;

procedure TA052FParCar.OggettoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
{Sposto l'oggetto col mouse}

begin
  if not(ssLeft in Shift) then exit;
  if not MuoviOggetto then exit;

  if (TLabel(Sender).Left + ((x - StartX)div DW)*DW < 0) or
     (TLabel(Sender).Top + ((y - StartY)div DH)*DH < 0) then exit;
  TLabel(Sender).Left:=TLabel(Sender).Left + ((x - StartX)div DW)*DW;
  TLabel(Sender).Top:=TLabel(Sender).Top + ((y - StartY)div DH)*DH;
  LT.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
  LL.Caption:='X:' + IntToStr(TLabel(Sender).Left);
end;

procedure TA052FParCar.OggettoMouseUp(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
{Rilascio l'oggetto dopo lo spostamento}
begin
  if Button <> mbLeft then exit;
  MuoviOggetto:=False;
  TLabel(Sender).OnMouseMove:=nil;

  if (TLabel(Sender).Left + ((x - StartX)div DW)*DW < 0) or
     (TLabel(Sender).Top + ((y - StartY)div DH)*DH < 0) then exit;
  TLabel(Sender).Left:=TLabel(Sender).Left+ ((x - StartX)div DW)*DW;
  TLabel(Sender).Top:=TLabel(Sender).Top+ ((y - StartY)div DH)*DH;
  LT.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
  LL.Caption:='X:' + IntToStr(TLabel(Sender).Left);
end;

procedure TA052FParCar.DatiIntestazioneClick(Sender: TObject);
{Comincio l'operazione di Drag}
begin
  DatiIntestazione.BeginDrag(False,5);
end;

procedure TA052FParCar.DatiRiepilogoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button <> mbLeft) or (Shift <> [ssLeft]) then exit;
  if Sender = DatiRiepilogo then
    DatiRiepilogo.BeginDrag(False, -1)
  else if Sender = DatiDettaglio then
    DatiDettaglio.BeginDrag(False, -1)
  else if Sender = DatiIntestazione then
    DatiIntestazione.BeginDrag(False, -1);
end;

procedure TA052FParCar.BFontClick(Sender: TObject);
{Cambiamento del font dell'intestazione/dettaglio/riepilogo}
var
  SB:TScrollBox;
  sezione: String;
begin
  if Sender = BFont then
  begin
    SB:=Intestazione;
    sezione:=TSezione.INTESTAZIONE;
  end
  else if Sender = BFont2 then
  begin
    SB:=Dettaglio;
    sezione:=TSezione.DETTAGLIO;
  end
  else
  begin
    SB:=Riepilogo;
    sezione:=TSezione.RIEPILOGO;
  end;
  FontDialog1.Font.Assign(SB.Font);
  if FontDialog1.Execute then
    SB.Font.Assign(FontDialog1.Font);

  //devo settare fontproperties size per il calcolo corretto di defWidth e defHeight
  with A052FParCarDtM1.A052FParCarMW do
  begin
    dicSezioni[sezione].FontProperties.size:=FontDialog1.Font.size;
  end;
end;

procedure TA052FParCar.btnSceltaAssenzeClick(Sender: TObject);
begin
  if DButton.State in [dsEdit,dsInsert] then
  begin
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      C013FCheckList.clbListaDati.Items.Clear;
      with A052FParCarDtm1.A052FParCarMW.selT265 do
      begin
        First;
        while not Eof do
        begin
          C013FCheckList.clbListaDati.Items.Add(Format('%5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
      end;
      R180PutCheckList(dedtAssenzeNoRiepilogo.Field.AsString,5,C013FCheckList.clbListaDati);
      if C013FCheckList.ShowModal = mrOK then
        dedtAssenzeNoRiepilogo.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA052FParCar.Cancella2Click(Sender: TObject);
{Cancellazione della label di intestazione}
var S,S1, sezione:String;
    i:Integer;
begin
  i:=0;
  S:=TLabel(PopupMenu1.PopupComponent).Hint;
  S1:=TLabel(PopupMenu1.PopupComponent).Caption;
  if PageControl1.ActivePage = TabSheet1 then //Intestazione
  begin
    i:=PosizioneIntestazione(S);
    sezione:=TSezione.INTESTAZIONE;
  end
  else if PageControl1.ActivePage = TabSheet2 then //Dettaglio
  begin
    i:=PosizioneDettaglio(S);
    sezione:=TSezione.DETTAGLIO;
  end
  else if PageControl1.ActivePage = TabSheet3 then //Riepilogo
  begin
    i:=PosizioneRiepilogo(S);
    sezione:=TSezione.RIEPILOGO;
  end;
  if i >= 0 then
    if MessageDlg('Eliminare il dato ' + S1, mtConfirmation,[mbYes, mbNo],0) = mrYes then
    begin
      //devo cancellare anche la lstLabel perhcè la lista è usata per l'attribuzione di uniqueName
      A052FParCarDtM1.A052FParCarMW.dicSezioni[sezione].removeLabel(TLabel(PopupMenu1.PopupComponent).Name);
      TLabel(PopupMenu1.PopupComponent).Free;
    end;
end;

procedure TA052FParCar.Caption1Click(Sender: TObject);
var S:String;
begin
  S:=TLabel(PopupMenu1.PopupComponent).Caption;
  if InputQuery('Modifica caption','Nuova caption:',S) then
    TLabel(PopupMenu1.PopupComponent).Caption:=S;
end;

procedure TA052FParCar.Dimensioni1Click(Sender: TObject);
{Impostazioni manuali Altezza e Larghezza delle label di intestazione}
begin
  C007FLabelSize:=TC007FLabelSize.Create(nil);
  with C007FLabelSize do
    try
      Caption:='Dimensioni del dato ' + TLabel(PopupMenu1.PopupComponent).Name;
      Altezza:=TLabel(PopupMenu1.PopupComponent).Height;
      Larghezza:=TLabel(PopupMenu1.PopupComponent).Width;
      Sinistra:=TLabel(PopupMenu1.PopupComponent).Left;
      Alto:=TLabel(PopupMenu1.PopupComponent).Top;
      if ShowModal = mrOk then
        begin
        TLabel(PopupMenu1.PopupComponent).Height:=Altezza;
        TLabel(PopupMenu1.PopupComponent).Width:=Larghezza;
        TLabel(PopupMenu1.PopupComponent).Left:=Sinistra;
        TLabel(PopupMenu1.PopupComponent).Top:=Alto;
        end;
    finally
      Release;
    end;
end;

procedure TA052FParCar.DistruggiIntestazione;
{Distruzione delle Labels usate per l'intestazione}
var i:Integer;
begin
  for i:=Intestazione.ComponentCount - 1 downto 0 do
    TLabel(Intestazione.Components[i]).Free;
end;

procedure TA052FParCar.DistruggiDettaglio;
{Distruzione delle Labels usate per il dettaglio}
var i:Integer;
begin
  for i:=Dettaglio.ComponentCount - 1 downto 0 do
    TLabel(Dettaglio.Components[i]).Free;
end;

procedure TA052FParCar.DistruggiRiepilogo;
{Distruzione delle Labels usate per il riepilogo}
var i:Integer;
begin
  for i:=Riepilogo.ComponentCount - 1 downto 0 do
    TLabel(Riepilogo.Components[i]).Free;
end;

procedure TA052FParCar.FormDestroy(Sender: TObject);
begin
  inherited;
  DistruggiIntestazione;
  DistruggiDettaglio;
  DistruggiRiepilogo;
end;

procedure TA052FParCar.FormShow(Sender: TObject);
begin
  inherited;
  DatiIntestazione.listSource:=A052FParCarDtM1.A052FParCarMW.DI010;
end;

procedure TA052FParCar.BCancellaClick(Sender: TObject);
begin
  if Sender = BCancella then
  begin
    A052FParCarDtM1.A052FParCarMW.dicSezioni[TSezione.INTESTAZIONE].removeAllLabels;
    DistruggiIntestazione;
  end
  else if Sender = BCancella2 then
  begin
    A052FParCarDtM1.A052FParCarMW.dicSezioni[TSezione.DETTAGLIO].removeAllLabels;
    DistruggiDettaglio
  end
  else if Sender = BCancella3 then
  begin
    A052FParCarDtM1.A052FParCarMW.dicSezioni[TSezione.RIEPILOGO].removeAllLabels;
    DistruggiRiepilogo;
  end;
end;

procedure TA052FParCar.PopupMenu1Popup(Sender: TObject);
{Abilitazione del menu Proprietà}
begin
  Propriet1.Enabled:=(TLabel(PopupMenu1.PopupComponent).Parent = Dettaglio) and
                     (A052FParCarDtM1.A052FParCarMW.HasProprieta(PopupMenu1.PopupComponent.Tag)) ;
end;

procedure TA052FParCar.Propriet1Click(Sender: TObject);
{Finestra di dialogo delle proprietà dei dati di dettaglio}
var T:Integer;
begin
  A052FProprieta:=TA052FProprieta.Create(nil);
  with A052FProprieta do
    try
      //Impostazione delle proprietà da visualizzare e da abilitare
      Caption:='Proprietà del dato ' + TLabel(PopupMenu1.PopupComponent).Name;
      //
      GiorniMese.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableGiorniMese(PopupMenu1.PopupComponent.Tag);
      DBCheckBox1.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableGiorniMese(PopupMenu1.PopupComponent.Tag);
      DBCheckBox2.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableGiorniMese(PopupMenu1.PopupComponent.Tag);
      DBCheckBox3.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableGiorniMese(PopupMenu1.PopupComponent.Tag);
      //
      Orologio.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableTimbrature(PopupMenu1.PopupComponent.Tag);
      LAnomOrologio.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableTimbrature(PopupMenu1.PopupComponent.Tag);
      EAnomOrologio.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableTimbrature(PopupMenu1.PopupComponent.Tag);
      dchkTimbratureManuali.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableTimbrature(PopupMenu1.PopupComponent.Tag);
      //
      Giustificativi.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableGiustificativi(PopupMenu1.PopupComponent.Tag);
      Causale.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableTimbrature(PopupMenu1.PopupComponent.Tag);
      //
      Turno.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableTurno(PopupMenu1.PopupComponent.Tag);
      //
      Totali.Enabled:=A052FParCarDtM1.A052FParCarMW.EnableTotali(PopupMenu1.PopupComponent.Tag);

      Tag:=PopupMenu1.PopupComponent.Tag;
      if A052FParCarDtM1.A052FParCarMW.EnableTimbrature(Tag) then
      begin
        Orologio.Checked:=A052FParCarDtM1.A052FParCarMW.GetCheckedOrologio(Tag);
        Causale.ItemIndex:=A052FParCarDtM1.A052FParCarMW.GetItemIndexCausale(Tag);
      end;

      if Giustificativi.Enabled then
        Giustificativi.ItemIndex:=A052FParCarDtM1.A052FParCarMW.GetItemIndexGiustificativi(Tag);

      if A052FParCarDtM1.A052FParCarMW.EnableTurno(Tag) then
        Turno.ItemIndex:=A052FParCarDtM1.A052FParCarMW.GetItemIndexTurno(Tag);

      if A052FParCarDtM1.A052FParCarMW.EnableTotali(Tag) then
        Totali.Checked:=A052FParCarDtM1.A052FParCarMW.GetCheckedTotali(Tag);

      CausaliDaVisualizzare:=A052FParCarDtM1.A052FParCarMW.CausaliDaVisualizzare(Tag);
      //
      if ShowModal = mrOk then
      begin
        //Assegnazione delle proprietà indicate
        T:=Tag;
        //Giustificativi
        if A052FParCarDtM1.A052FParCarMW.EnableGiustificativi(Tag) then
          T:=A052FParCarDtM1.A052FParCarMW.GetTagGiustificativi(Giustificativi.ItemIndex);

        //Timbrature
        if A052FParCarDtM1.A052FParCarMW.EnableTimbrature(Tag) then
        begin
          T:=A052FParCarDtM1.A052FParCarMW.GetTagCausale(Causale.ItemIndex);
          T:=A052FParCarDtM1.A052FParCarMW.getTagOrologio(Orologio.Checked, T);
        end;
        if A052FParCarDtM1.A052FParCarMW.EnableTurno(Tag) then
          T:=A052FParCarDtM1.A052FParCarMW.GetTagTurno(turno.ItemIndex);

        if A052FParCarDtM1.A052FParCarMW.EnableTotali(Tag) then
          T:=A052FParCarDtM1.A052FParCarMW.GetTagTotali(Totali.Checked,Tag);

        PopupMenu1.PopupComponent.Tag:=T;
      end;
    finally
      Release;
    end;
end;

end.
