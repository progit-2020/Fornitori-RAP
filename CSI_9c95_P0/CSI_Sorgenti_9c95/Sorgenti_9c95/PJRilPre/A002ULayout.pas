unit A002ULayout;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, StdCtrls, Forms, DBCtrls, DB, Buttons,
  Mask, ExtCtrls, Dialogs, Menus, SelezionaDati, A002UAnagrafeVista,
  A000UCostanti, A000USessione,A000UInterfaccia, ImgList, ComCtrls, ToolWin, ActnList, QueryStorico,
  OracleData, Variants, C180FunzioniGenerali, StrUtils, Math, Oracle,
  System.Actions, System.ImageList;

//const NumComp = 41;52;49;
const NumComp = 54;

type
  TObjRecord=record
    LinkComp:array[0..2] of TControl; {Insieme dei Controlli collegati}
    Rett:TRect;
    Accesso:String;                  {Visibile/Non Visibile/Sola Lettura (S/N/R)}
    Parent:TWinControl;              {TTabSheet proprietaria del controllo}
    end;

  TA002FLayout = class(TForm)
    MainMenu2: TMainMenu;
    Comandi1: TMenuItem;
    Sposta1: TMenuItem;
    Proprieta1: TMenuItem;
    Cancella1: TMenuItem;
    Ripristinacampo1: TMenuItem;
    File1: TMenuItem;
    Salva1: TMenuItem;
    N1: TMenuItem;
    Esci1: TMenuItem;
    Carica1: TMenuItem;
    Shape1: TShape;
    Cancella2: TMenuItem;
    PopupMenu1: TPopupMenu;
    mpuProprieta: TMenuItem;
    N2: TMenuItem;
    mpuElimina: TMenuItem;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    tbtnEliminaCampo: TToolButton;
    ActionList1: TActionList;
    actRicerca: TAction;
    actPrimo: TAction;
    actPrecedente: TAction;
    actSuccessivo: TAction;
    actUltimo: TAction;
    actInserisci: TAction;
    actModifica: TAction;
    actCancella: TAction;
    actConferma: TAction;
    actAnnulla: TAction;
    actStampa: TAction;
    actStoricizza: TAction;
    actDataLavoro: TAction;
    actEsci: TAction;
    actStoricoPrecedente: TAction;
    actStoricoSuccessivo: TAction;
    actCarica: TAction;
    tbtnEsci: TToolButton;
    tbtnCaricaConfig: TToolButton;
    stbBottom1: TStatusBar;
    tbtnSalvaConfig: TToolButton;
    actSalva: TAction;
    actSposta: TAction;
    tbtnRipristinaCampo: TToolButton;
    actCaption: TAction;
    actRipristina: TAction;
    actElimina: TAction;
    actPulisci: TAction;
    tbtnCancellaConfig: TToolButton;
    actPosizioni: TAction;
    tbtnSpostaCampo: TToolButton;
    tbtnProprietaCampo: TToolButton;
    actProprieta: TAction;
    ToolButton3: TToolButton;
    R1: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    Panel2: TPanel;
    Panel3: TPanel;
    lblConfigurazione: TLabel;
    ToolButton9: TToolButton;
    cbxUTENTE: TComboBox;
    rgpPagina: TRadioGroup;
    chkConfigDefault: TCheckBox;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    lblTipoConfigurazione: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Carica1Click(Sender: TObject);
    procedure CaricaConfigClick(Sender: TObject);
    procedure SalvaConfigClick(Sender: TObject);
    procedure actSpostaExecute(Sender: TObject);
    procedure actEsciExecute(Sender: TObject);
    procedure actCancellaExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actRipristinaExecute(Sender: TObject);
    procedure actProprietaExecute(Sender: TObject);
    procedure rgpPaginaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxUTENTEChange(Sender: TObject);
    procedure TipoConfigurazione;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { private declarations }
    Trascina:Boolean;
    XDisplacement,YDisplacement,Group:integer;
    NDL:Byte;
    Nome:string;
    procedure PageControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PageControlChange(Sender: TObject);
    procedure TabSheetMouseDown(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    procedure TabSheetMouseMove(Sender: TObject; Shift: TShiftState; X,
              Y: Integer);
    procedure TabSheetMouseUp(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    procedure CreaRettangoli;
    procedure SpostaGruppo(Key:Word);
    function CercaGruppo(X,Y:Integer; Parent:TWinControl; var xD,yD:Integer):Integer;
    function CercaParent:TWinControl;
    procedure DimensionaShape;
    function OkSalva(Nome:String):boolean;
    function OkCancella(Nome:String):boolean;
    procedure Salva;
    procedure SettaProprieta(i,X,Y:Integer);
    procedure ImpostaAccesso(ImpAcc:String);
    function ObjCaption(Sender:TControl; Stringa:String; Op:Byte):String;
    procedure ObjColor(Sender:TControl; NC:Integer; ClT:Boolean);
    procedure StatoPagina;
    procedure NomiConfig;
    procedure PrimoGruppoPagina;
    procedure AppDeactivate(Sender: TObject);
    procedure CreaDefault;
    procedure CreaPagine;
    function Carica:Boolean;
    procedure VisualizzoPagina;
  public
    { public declarations }
    Modificato,EditMode:boolean;
    Layout:array of TObjRecord;
    procedure Inizializza;
    procedure Attivazione;
    end;
var
  A002FLayout: TA002FLayout;

implementation

uses A002UAnagrafeDtM1, A002UAnagrafeGest, A002UProprieta;

{$R *.DFM}

procedure TA002FLayout.FormCreate(Sender: TObject);
begin
  with A002FAnagrafeDtM1 do
  begin
    sel070.Close;
    sel070.SetVariable('AZIELAV',Parametri.Azienda);
    sel070.Open;
    if Q030.Active then
      Attivazione;
  end;
end;

procedure TA002FLayout.FormActivate(Sender: TObject);
{Operazioni eseguite all'attivazione della Form}
var i,j:integer;
begin
  with A002FAnagrafeDtM1 do
  begin
    Q030.DisableControls;
    Q430.DisableControls;
  end;
  CreaRettangoli;
  EditMode:=true;
  stbBottom1.Panels[1].Text:='Coordinata X del campo: ';
  stbBottom1.Panels[2].Text:='Coordinata Y del campo: ';
  group:=0;
  PrimoGruppoPagina;
  Trascina:=False;
  {Associo gli eventi al PageControl1}
  A002FAnagrafeGest.PageControl1.OnChanging:=PageControlChanging;
  A002FAnagrafeGest.PageControl1.OnChange:=PageControlChange;
  {Associo gli eventi ad ogni TabSheet della PageControl1}
  with A002FAnagrafeGest do
  begin
    for i:=0 to PageControl1.PageCount - 1 do
    begin
      PageControl1.Pages[i].TabVisible:=True;
      PageControl1.Pages[i].OnMouseDown:=TabSheetMouseDown;
      PageControl1.Pages[i].OnMouseMove:=TabSheetMouseMove;
      PageControl1.Pages[i].OnMouseUp:=TabSheetMouseUp;
    end;
  end;
  for i:=0 to (NumComp+NDL) do
  begin
    for j:=0 to 2 do
    begin
      if Layout[i].LinkComp[j] <> nil then
        Layout[i].LinkComp[j].Enabled:=False;
    end;
  end;
  DimensionaShape;
  actSposta.checked:=False;
  StatoPagina;
end;

procedure TA002FLayout.Attivazione;
{Operazioni da fare ad ogni attivazione della scheda anagrafica successive
 a funzioni che ne condizionano il contenuto}
begin
  Inizializza;
  NomiConfig;
  CreaPagine;
  //Carico la configurazione di layout scheda anagrafica
  Nome:=Parametri.Layout;
  cbxUTENTE.ItemIndex:=cbxUTENTE.Items.IndexOf(Nome);
  TipoConfigurazione;
  if Carica then
  begin
    CreaRettangoli;
    PageControlChange(nil);
    Shape1.Visible:=False;
  end
  else
  begin
    {Carico la configurazione di base non registrata}
    with A002FAnagrafeGest.PageControl1 do
    begin
      with TTabSheet.Create(nil) do
      begin
        PageControl := A002FAnagrafeGest.PageControl1;
        Caption:='Dati liberi 1';
      end;
      with TTabSheet.Create(nil) do
      begin
        PageControl := A002FAnagrafeGest.PageControl1;
        Caption:='Dati liberi 2';
      end;
    end;
    CreaDefault;
    CreaRettangoli;
    PageControlChange(nil);
    Shape1.Visible:=False;
  end;
  VisualizzoPagina;
end;

procedure TA002FLayout.NomiConfig;
begin
  with A002FAnagrafeDtM1 do
  begin
    cbxUTENTE.Items.Clear;
    if not sel070.SearchRecord('UTENTE','DEFAULT',[srFromBeginning]) then
      cbxUTENTE.Items.Add('DEFAULT');
    sel070.First;
    while not sel070.Eof do
    begin
      cbxUTENTE.Items.Add(sel070.FieldByName('UTENTE').AsString);
      sel070.Next;
    end;
  end;
end;

procedure TA002FLayout.Inizializza;
{Inizializza Layout con i dati di tutti i componenti interessati}
var i,j:integer;
begin
  NDL:=A002FAnagrafeVista.NumDatiLiberi;
  SetLength(Layout,0);
  SetLength(Layout,NumComp + NDL + 1);
  Application.HintHidePause:=3000;
  EditMode:=False;
  for i:=0 to (NumComp+NDL) do
    begin
    for j:=0 to 2 do
      Layout[i].LinkComp[j]:=nil;
    end;

  with A002FAnagrafeGest do
  begin
    //1° Pagina
    Layout[0].Parent:=PageControl1.Pages[0];
    Layout[0].LinkComp[0]:=L1;
    Layout[0].LinkComp[1]:=EMatricola;

    Layout[1].Parent:=PageControl1.Pages[0];
    Layout[1].LinkComp[0]:=L2;
    Layout[1].LinkComp[1]:=ECognome;

    Layout[2].Parent:=PageControl1.Pages[0];
    Layout[2].LinkComp[0]:=L3;
    Layout[2].LinkComp[1]:=ENome;

    Layout[3].Parent:=PageControl1.Pages[0];
    Layout[3].LinkComp[0]:=DBRadioGroup1;

    Layout[4].Parent:=PageControl1.Pages[0];
    Layout[4].LinkComp[0]:=L4;
    Layout[4].LinkComp[1]:=ENascita;

    Layout[5].Parent:=PageControl1.Pages[0];
    Layout[5].LinkComp[0]:=L5;
    Layout[5].LinkComp[1]:=LookupComune;
    Layout[5].LinkComp[2]:=EComune;

    Layout[6].Parent:=PageControl1.Pages[0];
    Layout[6].LinkComp[0]:=L6;
    Layout[6].LinkComp[1]:=ECapNas;

    Layout[7].Parent:=PageControl1.Pages[0];
    Layout[7].LinkComp[0]:=L50;
    Layout[7].LinkComp[1]:=EProvNas;

    Layout[8].Parent:=PageControl1.Pages[0];
    Layout[8].LinkComp[0]:=LI060EMail;
    Layout[8].LinkComp[1]:=EI060EMail;

    Layout[9].Parent:=PageControl1.Pages[0];
    Layout[9].LinkComp[0]:=L52;
    Layout[9].LinkComp[1]:=ECodFiscale;

    Layout[10].Parent:=PageControl1.Pages[0];
    Layout[10].LinkComp[0]:=L7;
    Layout[10].LinkComp[1]:=EditBadge;

    Layout[11].Parent:=PageControl1.Pages[0];
    Layout[11].LinkComp[0]:=L53;
    Layout[11].LinkComp[1]:=EEdBadge;

    Layout[12].Parent:=PageControl1.Pages[0];
    Layout[12].LinkComp[0]:=DBRadioGroup2;

    Layout[13].Parent:=PageControl1.Pages[0];
    Layout[13].LinkComp[0]:=DChkDocente;

    Layout[14].Parent:=PageControl1.Pages[0];
    Layout[14].LinkComp[0]:=lblIndirizzo;
    Layout[14].LinkComp[1]:=dedtIndirizzo;

    Layout[15].Parent:=PageControl1.Pages[0];
    Layout[15].LinkComp[0]:=lblComune;
    Layout[15].LinkComp[1]:=dcmbComune; //dedtComune;
    Layout[15].LinkComp[2]:=dedtComune;

    Layout[16].Parent:=PageControl1.Pages[0];
    Layout[16].LinkComp[0]:=lblCap;
    Layout[16].LinkComp[1]:=dedtCap;

    Layout[17].Parent:=PageControl1.Pages[0];
    Layout[17].LinkComp[0]:=lblProvincia;
    Layout[17].LinkComp[1]:=dedtProvincia;

    Layout[18].Parent:=PageControl1.Pages[0];
    Layout[18].LinkComp[0]:=lblTelefono;
    Layout[18].LinkComp[1]:=dedtTelefono;

    Layout[19].Parent:=PageControl1.Pages[0];
    Layout[19].LinkComp[0]:=L15;
    Layout[19].LinkComp[1]:=EInizio;

    Layout[20].Parent:=PageControl1.Pages[0];
    Layout[20].LinkComp[0]:=L16;
    Layout[20].LinkComp[1]:=EFine;

    Layout[21].Parent:=PageControl1.Pages[0];
    Layout[21].LinkComp[0]:=L26;
    Layout[21].LinkComp[1]:=ESquadra;
    Layout[21].LinkComp[2]:=LSquadra;

    Layout[22].Parent:=PageControl1.Pages[0];
    Layout[22].LinkComp[0]:=L27;
    Layout[22].LinkComp[1]:=ETipoOpe;

    Layout[23].Parent:=PageControl1.Pages[0];
    Layout[23].LinkComp[0]:=L17;
    Layout[23].LinkComp[1]:=EInizioServizio;

    Layout[24].Parent:=PageControl1.Pages[0];
    Layout[24].LinkComp[0]:=L54;
    Layout[24].LinkComp[1]:=ETipoRapp;
    Layout[24].LinkComp[2]:=LTipoRapp;

    Layout[25].Parent:=PageControl1.Pages[0];
    Layout[25].LinkComp[0]:=L28;
    Layout[25].LinkComp[1]:=ETerminali;

    Layout[26].Parent:=PageControl1.Pages[0];
    Layout[26].LinkComp[0]:=dchkRapportiUniti;
    //2° Pagina
    Layout[27].Parent:=PageControl1.Pages[1];
    Layout[27].LinkComp[0]:=ECausStraord;

    Layout[28].Parent:=PageControl1.Pages[1];
    Layout[28].LinkComp[0]:=EStraordE;

    Layout[29].Parent:=PageControl1.Pages[1];
    Layout[29].LinkComp[0]:=EStraordU;

    Layout[30].Parent:=PageControl1.Pages[1];
    Layout[30].LinkComp[0]:=EStraordEU;

    Layout[31].Parent:=PageControl1.Pages[1];
    Layout[31].LinkComp[0]:=EStraordEU2;

    Layout[32].Parent:=PageControl1.Pages[1];
    Layout[32].LinkComp[0]:=L29;
    Layout[32].LinkComp[1]:=EContratto;
    Layout[32].LinkComp[2]:=LContratto;

    Layout[33].Parent:=PageControl1.Pages[1];
    Layout[33].LinkComp[0]:=L30;
    Layout[33].LinkComp[1]:=EOrario;

    Layout[34].Parent:=PageControl1.Pages[1];
    Layout[34].LinkComp[0]:=EHTeoriche;

    Layout[35].Parent:=PageControl1.Pages[1];
    Layout[35].LinkComp[0]:=L55;
    Layout[35].LinkComp[1]:=EPartTime;
    Layout[35].LinkComp[2]:=LPartTime;

    Layout[36].Parent:=PageControl1.Pages[1];
    Layout[36].LinkComp[0]:=L56;
    Layout[36].LinkComp[1]:=ETipoCart;
    Layout[36].LinkComp[2]:=LTipoCart;

    Layout[37].Parent:=PageControl1.Pages[1];
    Layout[37].LinkComp[0]:=ETGestione;

    Layout[38].Parent:=PageControl1.Pages[1];
    Layout[38].LinkComp[0]:=L31;
    Layout[38].LinkComp[1]:=EPlusOra;
    Layout[38].LinkComp[2]:=LPlusOra;

    Layout[39].Parent:=PageControl1.Pages[1];
    Layout[39].LinkComp[0]:=L32;
    Layout[39].LinkComp[1]:=ECalendario;
    Layout[39].LinkComp[2]:=LCalendario;

    Layout[40].Parent:=PageControl1.Pages[1];
    Layout[40].LinkComp[0]:=L33;
    Layout[40].LinkComp[1]:=EIPresenza;
    Layout[40].LinkComp[2]:=LIPresenza;

    Layout[41].Parent:=PageControl1.Pages[1];
    Layout[41].LinkComp[0]:=L34;
    Layout[41].LinkComp[1]:=EPOrario;
    Layout[41].LinkComp[2]:=LPOrario;

    //3° Pagina
    Layout[42].Parent:=PageControl1.Pages[2];
    Layout[42].LinkComp[0]:=L35;
    Layout[42].LinkComp[1]:=EPAssenze;
    Layout[42].LinkComp[2]:=LPAssenze;

    Layout[43].Parent:=PageControl1.Pages[2];
    Layout[43].LinkComp[0]:=L36;
    Layout[43].LinkComp[1]:=dedtAssenzeAbilitate;//EAbCausale1;
    Layout[43].LinkComp[2]:=btnSceltaAssenze;//LAbCausale1;

    Layout[44].Parent:=PageControl1.Pages[2];
    Layout[44].LinkComp[0]:=L42;
    Layout[44].LinkComp[1]:=dedtPresenzeAbilitate;//EAbPresenze1;
    Layout[44].LinkComp[2]:=btnSceltaPresenze;//LAbPresenze1;

    Layout[45].Parent:=PageControl1.Pages[2];
    Layout[45].LinkComp[0]:=drgpTipoLocalitaDistLavoro;

    Layout[46].Parent:=PageControl1.Pages[2];
    Layout[46].LinkComp[0]:=lblLocalitaDistLavoro;
    Layout[46].LinkComp[1]:=dedtLocalitaDistLavoro;
    Layout[46].LinkComp[2]:=dcmbLocalitaDistLavoro;

    Layout[47].Parent:=PageControl1.Pages[2];
    Layout[47].LinkComp[0]:=lblQualificaMinisteriale;
    Layout[47].LinkComp[1]:=dcmbQualificaMinisteriale;
    Layout[47].LinkComp[2]:=dlblQualificaMinisteriale;

    // altri dati
    Layout[48].Parent:=PageControl1.Pages[0];
    Layout[48].LinkComp[0]:=L57;
    Layout[48].LinkComp[1]:=EInizioIndMat;

    Layout[49].Parent:=PageControl1.Pages[0];
    Layout[49].LinkComp[0]:=L58;
    Layout[49].LinkComp[1]:=EFineIndMat;

    Layout[50].Parent:=PageControl1.Pages[2];
    Layout[50].LinkComp[0]:=lblMedicinaLegale;
    Layout[50].LinkComp[1]:=dcmbMedicinaLegale;
    Layout[50].LinkComp[2]:=dlblMedicinaLegale;

    // domicilio
    Layout[51].Parent:=PageControl1.Pages[0];
    Layout[51].LinkComp[0]:=lblIndirizzoDomBase;
    Layout[51].LinkComp[1]:=dedtIndirizzoDomBase;

    Layout[52].Parent:=PageControl1.Pages[0];
    Layout[52].LinkComp[0]:=lblComuneDomBase;
    Layout[52].LinkComp[1]:=dcmbComuneDomBase;
    Layout[52].LinkComp[2]:=dedtComuneDomBase;

    Layout[53].Parent:=PageControl1.Pages[0];
    Layout[53].LinkComp[0]:=lblCapDomBase;
    Layout[53].LinkComp[1]:=dedtCapDomBase;

    Layout[54].Parent:=PageControl1.Pages[0];
    Layout[54].LinkComp[0]:=lblProvinciaDomBase;
    Layout[54].LinkComp[1]:=dedtProvinciaDomBase;

    {Carico i dati liberi riferendomi all'Array DatiLiberi del DtM1}
    for i:=(NumComp+1) to (NumComp+NDL) do
    begin
      with A002FAnagrafeDtM1.DatiLiberi[i-NumComp] do
      begin
        Layout[i].LinkComp[0]:=IntCampo;
        if LCampo = nil then
        begin
          //Campo non tabellare
          Layout[i].LinkComp[1]:=ECampo2;
        end
        else
        //Campo tabellare
        begin
          Layout[i].LinkComp[1]:=ECampo;
          Layout[i].LinkComp[2]:=LCampo;
        end;
      end;
    end;
  end;
end;

procedure TA002FLayout.CreaRettangoli;
{Inizializza Layout.Rett in modo da sapere le coordinate di tutti i rettangoli}
var i,j,STop,SBottom,SLeft,SRight:integer;
begin
  for i:=0 to (NumComp+NDL) do
    with Layout[i] do
    begin
    STop:=LinkComp[0].Top;
    SBottom:=LinkComp[0].Top+LinkComp[0].Height;
    SLeft:=LinkComp[0].Left;
    SRight:=LinkComp[0].Left+LinkComp[0].Width;
    for j:=1 to 2 do
      if LinkComp[j] <> nil then
        with LinkComp[j] do
          begin
          if STop>Top then STop:=Top;
          if SBottom<(Top+Height) then SBottom:=Top+Height;
          if SLeft>Left then SLeft:=Left;
          if SRight<(Left+Width) then SRight:=Left+Width;
          end;
    Rett.Top:=STop-2;
    Rett.Bottom:=SBottom+2;
    Rett.Left:=SLeft-2;
    Rett.Right:=SRight+2;
    end;
end;

function TA002FLayout.CercaGruppo(X,Y:Integer; Parent:TWinControl; var xD,yD:Integer):Integer;
{Cerco il rettangolo che contiene le coordinate del mouse}
var i:integer;
begin
  Result:=-1;
  for i:=0 to (NumComp+NDL) do
    begin
    if Parent <> Layout[i].Parent then continue;
    if not Layout[i].LinkComp[0].Visible then continue;
    if (X>Layout[i].Rett.Left) and (X<Layout[i].Rett.Right) and
       (Y>Layout[i].Rett.Top) and (Y<Layout[i].Rett.Bottom) then
       begin
       Result:=i;
       xD:=X-Layout[i].Rett.Left;
       yD:=Y-Layout[i].Rett.Top;
       Break;
       end;
    end;
end;

function TA002FLayout.CercaParent:TWinControl;
{Restituisco TabSheet della pagina attiva}
var
  i:integer;
begin
  Result:=nil;
  with A002FAnagrafeGest do
  begin
    for i:=0 to A002FAnagrafeGest.PageControl1.PageCount - 1 do
      if PageControl1.ActivePage.Caption = A002FAnagrafeGest.PageControl1.Pages[i].Caption then
      begin
        Result:=A002FAnagrafeGest.PageControl1.Pages[i];
        Break;
      end;
  end;
end;

procedure TA002FLayout.DimensionaShape;
{Dimensiona Shape1 in modo da incorniciare tutti i controlli interessati}
begin
  with Layout[Group].Rett do
    begin
    Shape1.Top:=Top;
    Shape1.Left:=Left;
    Shape1.Height:=Bottom-Top;
    Shape1.Width:=Right-Left;
    stbBottom1.Panels[1].Text:='Coordinata X del campo: '+IntToStr(Left);
    stbBottom1.Panels[2].Text:='Coordinata Y del campo: '+IntToStr(Top);
    end;
  if Shape1.Parent<>Layout[Group].Parent then
    Shape1.Parent:=Layout[Group].Parent;
  Shape1.Visible:=True;
end;

procedure TA002FLayout.SpostaGruppo(Key:Word);
{Consente lo spostamento dei controlli con i tasti Alt+[Freccia]}
var i:integer;
begin
  modificato:=true;
  if (key=vk_left)and(Layout[group].LinkComp[0].left>0) then
    begin
    for i:=0 to 2 do
      if Layout[group].LinkComp[i] <> nil then
        Layout[group].LinkComp[i].left:=Layout[group].LinkComp[i].left-1;
    shape1.left:=shape1.left-1;
    stbBottom1.Panels[1].Text:='Coordinata X del campo: '+IntToStr(Layout[group].LinkComp[0].left - 2);
    end;
  if (key=vk_right)and(Layout[group].LinkComp[0].left<(Layout[Group].Parent.width-shape1.width+2)) then
    begin
    for i:=0 to 2 do
      if Layout[group].LinkComp[i] <> nil then
        Layout[group].LinkComp[i].left:=Layout[group].LinkComp[i].left+1;
    shape1.left:=shape1.left+1;
    stbBottom1.Panels[1].Text:='Coordinata X del campo: '+inttostr(Layout[group].LinkComp[0].left - 2);
    end;
  if (key=vk_up)and(Layout[group].LinkComp[0].top>0) then
    begin
    for i:=0 to 2 do
      if Layout[group].LinkComp[i] <> nil then
        Layout[group].LinkComp[i].top:=Layout[group].LinkComp[i].top-1;
    shape1.top:=shape1.top-1;
    stbBottom1.Panels[2].Text:='Coordinata Y del campo: '+inttostr(Layout[group].LinkComp[0].top - 2);
    end;
  if (key=vk_down)and(Layout[group].LinkComp[0].top<(Layout[Group].Parent.height-shape1.height+2)) then
    begin
    for i:=0 to 2 do
      if Layout[group].LinkComp[i] <> nil then
        Layout[group].LinkComp[i].top:=Layout[group].LinkComp[i].top+1;
    shape1.top:=shape1.top+1;
    stbBottom1.Panels[2].Text:='Coordinata Y del campo: '+inttostr(Layout[group].LinkComp[0].top - 2);
    end;
end;

procedure TA002FLayout.ObjColor(Sender:TControl; NC:Integer; ClT:Boolean);
{Cambio il colore e ReadOnly sul Field per i controlli a sola lettura}
begin
  //Per i componenti con Label+Edit o LookupComboBox deve lavorare sul
  //sottocomponente [1].
  if Layout[NC].LinkComp[1] = nil then
  begin
    if Layout[NC].LinkComp[0] is TDBRadioGroup then
      (Layout[NC].LinkComp[0] as TDBRadioGroup).Field.ReadOnly:=ClT or (Layout[NC].LinkComp[0] as TDBRadioGroup).Field.ReadOnly
    else if Layout[NC].LinkComp[0] is TDBCheckBox then
      (Layout[NC].LinkComp[0] as TDBCheckBox).Field.ReadOnly:=ClT or (Layout[NC].LinkComp[0] as TDBCheckBox).Field.ReadOnly;
  end
  else
  begin
    if Layout[NC].LinkComp[1] is TDBEdit then
      (Layout[NC].LinkComp[1] as TDBEdit).Field.ReadOnly:=ClT or (Layout[NC].LinkComp[1] as TDBEdit).Field.ReadOnly
    else if Layout[NC].LinkComp[1] is TDBLookupComboBox then
//      (Layout[NC].LinkComp[1] as TDBLookupComboBox).Field.ReadOnly:=ClT;  //LORENA 19/07/2004
      (Layout[NC].LinkComp[1] as TDBLookupComboBox).ReadOnly:=ClT or (Layout[NC].LinkComp[1] as TDBLookupComboBox).ReadOnly;
  end;
  if not (Layout[NC].LinkComp[2] = nil) then
  begin
    if Layout[NC].LinkComp[2] is TDBEdit then
    begin
      (Layout[NC].LinkComp[2] as TDBEdit).Field.ReadOnly:=ClT or (Layout[NC].LinkComp[2] as TDBEdit).Field.ReadOnly;
    end;
  end;
  if Sender is TLabel then
  begin
    if ClT then
      //(Sender as TLabel).Color:=clGray
      (Sender as TLabel).Enabled:=False
    else
      ;//(Sender as TLabel).ParentColor:=True;
  end
  else if Sender is TDBRadioGroup then
  begin
    if ClT then
      //(Sender as TDBRadioGroup).Color:=clGray
      (Sender as TDBRadioGroup).Enabled:=False
    else
      ;//(Sender as TDBRadioGroup).ParentColor:=True;
  end
  else if Sender is TDBCheckBox then
  begin
    if ClT then
      //(Sender as TDBCheckBox).Color:=clGray
      (Sender as TDBCheckBox).Enabled:=False
    else
      ;//(Sender as TDBCheckBox).ParentColor:=True;
  end;
end;

function TA002FLayout.ObjCaption(Sender: TControl; Stringa:String; Op:Byte):String;
{Legge o scrive la stringa nella Caption del controllo a seconda
di Op: 0 Legge - 1 Scrive}
begin
  Result:='';
  if Sender is TLabel then
    if Op = 1 then (Sender as TLabel).Caption:=Stringa
    else Result:=(Sender as TLabel).Caption;
  if Sender is TDBRadioGroup then
    if Op = 1 then (Sender as TDBRadioGroup).Caption:=Stringa
    else Result:=(Sender as TDBRadioGroup).Caption;
  if Sender is TDBCheckBox then
    if Op = 1 then (Sender as TDBCheckBox).Caption:=Stringa
    else Result:=(Sender as TDBCheckBox).Caption;
end;

procedure TA002FLayout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{Gestione dei comandi da tastiera}
var i:Integer;
begin
  if not Shape1.Visible then exit;
  {Spostamento dei controlli}
  if (shift=[ssAlt])and actSposta.checked then SpostaGruppo(Key);
  {Spostamento su gruppo successivo}
  if (Shift = []) and (Key = vk_Down) then
    if Group < (NumComp+NDL) then
      begin
      for i:=Group+1 to (NumComp+NDL) do
        if (Layout[Group].Parent = Layout[i].Parent) and (Layout[i].LinkComp[0].Visible) then
          begin
          Group:=i;
          break;
          end;
      DimensionaShape;
      end;
  {Spostamento su gruppo precedente}
  if (Shift = []) and (Key = vk_Up) then
    if Group > 0 then
      begin
      for i:=Group-1 downto 0 do
      if (Layout[Group].Parent = Layout[i].Parent) and (Layout[i].LinkComp[0].Visible) then
        begin
        Group:=i;
        break;
        end;
      DimensionaShape;
      end;
end;

procedure TA002FLayout.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{Aggiorna il campo Rett con le nuove coordinate}
begin
  if not Shape1.Visible then exit;
  if (Shift = [ssAlt]) and ((Key = vk_Up)or(Key = vk_Down)or
                             (Key = vk_Left)or(Key = vk_Right)) then
    with Layout[Group].Rett do
      begin
      Top:=Shape1.Top;
      Left:=Shape1.Left;
      Bottom:=Shape1.Top+Shape1.Height;
      Right:=Shape1.Left+Shape1.Width;
      end;
end;

procedure TA002FLayout.TabSheetMouseDown(Sender: TObject; Button: TMouseButton;
                       Shift: TShiftState; X, Y: Integer);
{Incornicia il gruppo su cui si e' cliccato e eventualmente lo cancella o cambia label}
var G:Integer;
begin
  G:=CercaGruppo(X,Y,Sender as TWinControl,xDisplacement,yDisplacement);
  if G = -1 then exit;
  Group:=G;
  DimensionaShape;
  if not Shape1.Visible then exit;
end;

procedure TA002FLayout.TabSheetMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
{Sposta il rettangolo se e' premuto il bottone del mouse}
begin
  if not Shape1.Visible then exit;
  if (actSposta.checked) and (shift=[ssleft]) then
    begin
    if not Trascina then Trascina:=True;
    shape1.left:=x-xDisplacement;
    shape1.top:=y-yDisplacement;
    stbBottom1.Panels[1].Text:='Coordinata X del campo: '+IntToStr(Shape1.Left);
    stbBottom1.Panels[2].Text:='Coordinata Y del campo: '+IntToStr(Shape1.Top);
    end;
end;

procedure TA002FLayout.TabSheetMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
{Sposta tutti i controlli nella nuova posizione quando si rilascia il mouse}
var i,varx,vary,OldTop,OldLeft:integer;
begin
  if not Trascina then exit;
  if EditMode then
    begin
    Trascina:=False;
    modificato:=true;
    OldTop:=Layout[group].LinkComp[0].top;
    OldLeft:=Layout[group].LinkComp[0].left;
    Layout[group].LinkComp[0].top:=Shape1.Top + 2;
    Layout[group].LinkComp[0].left:=Shape1.Left + 2;
    stbBottom1.Panels[1].Text:='Coordinata X del campo: '+inttostr(Shape1.left);
    stbBottom1.Panels[2].Text:='Coordinata Y del campo: '+inttostr(Shape1.top);
    for i:=1 to 2 do
      if A002FLayout.Layout[group].LinkComp[i] <> nil then
        with A002FLayout.Layout[group].LinkComp[i] do
          begin
          varx:=left-OldLeft;
          vary:=top-OldTop;
          top:=A002FLayout.Layout[group].LinkComp[0].top+vary;
          left:=A002FLayout.Layout[group].LinkComp[0].left+varx;
          end;
    with Layout[Group].Rett do
      begin
      Top:=Shape1.Top;
      Left:=Shape1.Left;
      Bottom:=Shape1.Top+Shape1.Height;
      Right:=Shape1.Left+Shape1.Width;
      end;
    end;
end;

procedure TA002FLayout.PageControlChanging(Sender: TObject;
  var AllowChange: Boolean);
{Impedisce di cambiare pagina quando e' in corso lo spostamento}
begin
  AllowChange:=not(actSposta.checked);
end;

procedure TA002FLayout.PageControlChange(Sender: TObject);
{Quando cambio pagina si posiziona sul primo Gruppo di quella pagina}
begin
  StatoPagina;
  PrimoGruppoPagina;
end;

procedure TA002FLayout.PrimoGruppoPagina;
{Si posiziona sul primo Gruppo di quella pagina}
var i:integer;
    Trovato:boolean;
begin
  Trovato:=False;
  for i:=0 to (NumComp+NDL) do
    if (Layout[i].Parent = CercaParent) and (Layout[i].LinkComp[0].Visible) then
      begin
      Trovato:=True;
      Break;
      end;
  if Trovato then
    begin
    Group:=i;
    DimensionaShape;
    end
  else
    Shape1.Visible:=False;
end;

procedure TA002FLayout.StatoPagina;
{Setto pagina Modificabile - ReadOnly - Non Visibile - Non Impostato}
var
  i,StatoComp:Integer;
begin
  StatoComp:=3;
  for i:=0 to (NumComp+NDL) do
  begin
    if Layout[i].Parent <> CercaParent then continue;
    if Layout[i].Accesso = 'N' then
    begin
      if (StatoComp = 3) or (StatoComp = 2)  then
        StatoComp:=2
      else
      begin
        StatoComp:=3;
        break;
      end;
    end
    else if Layout[i].Accesso = 'R' then
    begin
      if (StatoComp = 3) or (StatoComp = 1)  then
        StatoComp:=1
      else
      begin
        StatoComp:=3;
        break;
      end;
    end
    else
    begin
      if (StatoComp = 3) or (StatoComp = 0)  then
        StatoComp:=0
      else
      begin
        StatoComp:=3;
        break;
      end;
    end
  end;
  rgpPagina.ItemIndex:=StatoComp;
end;

procedure TA002FLayout.VisualizzoPagina;
{Stabilisco se la pagina deve essere visualizzata (esiste almeno un dato visibile) o no
 in fase di gestione. In fase di layout invece vanno visualizzate anche le pagine vuote}
var
  i,j:Integer;
begin
  for i:=0 to A002FAnagrafeGest.PageControl1.PageCount - 1 do
  begin
    A002FAnagrafeGest.PageControl1.Pages[i].TabVisible:=False;
    for j:=0 to A002FAnagrafeGest.PageControl1.Pages[i].ControlCount - 1 do
    begin
      if A002FAnagrafeGest.PageControl1.Pages[i].Controls[j].Visible then
      begin
        A002FAnagrafeGest.PageControl1.Pages[i].TabVisible:=True;
        Break;
      end;
    end;
  end;
  A002FAnagrafeGest.PageControl1.ActivePageIndex:=0;
end;

function TA002FLayout.OkSalva(Nome:String):boolean;
{Chiedo conferma del salvataggio se esiste gia' il nome}
begin
  Result:=True;
  with A002FAnagrafeDtM1 do
    if Q033B.RecordCount > 0 then
      Result:=MessageDlg('Configurazione per utente ' + Nome +' già esistente: si desidera sostituirla?',
                     mtConfirmation,[mbYes,mbNo],0) = mrYes;
end;

function TA002FLayout.OkCancella(Nome:String):boolean;
{Chiedo conferma per la cancellazione della configurazione}
begin
  Result:=MessageDlg('Confermi la cancellazione della configurazione per l''utente ' + Nome +'?',
          mtConfirmation,[mbYes,mbNo],0) = mrNo;
end;

procedure TA002FLayout.Salva;
{Esegue il ciclo sui gruppi e inserisce o aggiorna i record
a seconda che esista o meno lo stesso nome}
var i:integer;
    StrCaption,CampoDB:String;
begin
  //Cancello eventuale configurazione esistente con questo nome
  with A002FAnagrafeDtM1.OperSQL,A002FAnagrafeDtM1 do
  begin
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T033_Layout WHERE Nome = ''%s''',[Nome]));
    try
      Execute;
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      exit;
    end;
  end;
  //Inserisco le nuove impostazioni
  with A002FAnagrafeDtM1 do
  begin
    try
      for i:=0 to (NumComp + NDL) do
      begin
        with Layout[i].LinkComp[0] do
        begin
          InsQ033.SetVariable('Nome',Nome);
          InsQ033.SetVariable('Top',Top);
          InsQ033.SetVariable('Lft',Left);
          InsQ033.SetVariable('Caption',ObjCaption(Layout[i].LinkComp[0],StrCaption,0));
          if Visible then
            if Layout[i].Accesso = 'R' then
              InsQ033.SetVariable('Accesso','R')
            else
              InsQ033.SetVariable('Accesso','S')
          else
            InsQ033.SetVariable('Accesso','N');
          {Indicare qui il riferimento alle TabSheet}
          InsQ033.SetVariable('NomePagina',(Parent as TTabSheet).Caption);
          //Campo a cui fa riferimento il componente
          if Layout[i].LinkComp[1] = nil then
          begin
            if Layout[i].LinkComp[0] is TDBRadioGroup then
              CampoDB:=(Layout[i].LinkComp[0] as TDBRadioGroup).Field.FieldName
            else if Layout[i].LinkComp[0] is TDBCheckBox then
              CampoDB:=(Layout[i].LinkComp[0] as TDBCheckBox).Field.FieldName;
          end
          else
          begin
            if Layout[i].LinkComp[1] is TDBEdit then
              CampoDB:=(Layout[i].LinkComp[1] as TDBEdit).Field.FieldName
            else if Layout[i].LinkComp[1] is TDBLookupComboBox then
              CampoDB:=(Layout[i].LinkComp[1] as TDBLookupComboBox).Field.FieldName;
          end;
          InsQ033.SetVariable('CampoDB',CampoDB);
          InsQ033.Execute;
        end;
      end;
      SessioneOracle.Commit;
    except
      SessioneOracle.Rollback;
      exit;
    end;
  end;
end;

procedure TA002FLayout.SettaProprieta(i,X,Y:Integer);
{Dopo aver letto le proprieta' da file, le assegno a tutti
i componenti del gruppo}
var j,XNew,YNew:integer;
begin
  with Layout[i] do
  begin
    for j:=1 to 2 do
    begin
      if LinkComp[j] <> nil then
      begin
        {Calcolo l'offset dei componenti rispetto alla Label}
        XNew:=LinkComp[j].Left-X;
        YNew:=LinkComp[j].Top-Y;
        LinkComp[j].Left:=LinkComp[0].Left+XNew;
        LinkComp[j].Top:=LinkComp[0].Top+YNew;
        LinkComp[j].Visible:=LinkComp[0].Visible;
        LinkComp[j].Parent:=LinkComp[0].Parent;
      end;
    end;
  end;
end;

procedure TA002FLayout.CreaPagine;
var i:Integer;
    NewPage:Boolean;
begin
  with A002FAnagrafeDtM1 do
  begin
    selT033.Open;
    while not selT033.Eof do
    begin
      NewPage:=True;
      for i:=0 to A002FAnagrafeGest.PageControl1.PageCount - 1 do
        if selT033.FieldByName('NomePagina').AsString = A002FAnagrafeGest.PageControl1.Pages[i].Caption then
        begin
          NewPage:=False;
          Break;
        end;
      if NewPage then
        with A002FAnagrafeGest.PageControl1 do
          with TTabSheet.Create(nil) do
          begin
            PageControl:=A002FAnagrafeGest.PageControl1;
            Caption:=selT033.FieldByName('NomePagina').AsString;
          end;
      selT033.Next;
    end;
    selT033.Close;
  end;
end;

procedure TA002FLayout.Carica1Click(Sender: TObject);
begin
  CaricaConfigClick(Sender);
end;

function TA002FLayout.Carica:boolean;
{Leggo il file e assegno le proprieta' al componente label}
var i,NC,XOld,YOld,iTabOrder,iNCompPag:integer;
    CampoDB,sNomePagOld:String;
begin
  with A002FAnagrafeDtM1 do
  begin
    iTabOrder:=0;
    iNCompPag:=0;
    sNomePagOld:='';
    Q033B.Close;
    Q033B.SetVariable('Nome',Nome);
    Q033B.SetVariable('OrderBy',
                      IfThen(StrToInt(R180GetOracleRelease(A000SessioneIrisWIN.SessioneOracle)) > 90000,
                      'ORDER BY','GROUP BY'));
    Q033B.Open;
    Result:=Q033B.RecordCount  > 0;
    if not Result then
    begin
      Q033B.Close;
      exit;
    end;
    try
      while not Q033B.Eof do
      begin
        NC:=-1;
        for i:=0 to NumComp + NDL do
        begin
          CampoDB:='';
          if Layout[i].LinkComp[1] = nil then
          begin
            if Layout[i].LinkComp[0] is TDBRadioGroup then
              CampoDB:=(Layout[i].LinkComp[0] as TDBRadioGroup).Field.FieldName
            else if Layout[i].LinkComp[0] is TDBCheckBox then
              CampoDB:=(Layout[i].LinkComp[0] as TDBCheckBox).Field.FieldName;
          end
          else
          begin
            if Layout[i].LinkComp[1] is TDBEdit then
              CampoDB:=(Layout[i].LinkComp[1] as TDBEdit).Field.FieldName
            else if Layout[i].LinkComp[1] is TDBLookupComboBox then
              CampoDB:=(Layout[i].LinkComp[1] as TDBLookupComboBox).Field.FieldName;
          end;
          if CampoDB = Q033BCampoDb.AsString then
          begin
            NC:=i;
            Break;
          end;
        end;
        if (NC > NumComp + NDL) or (NC = -1) then
        begin
          Q033B.Next;
          Continue;
        end;
        XOld:=Layout[NC].LinkComp[0].Left;
        YOld:=Layout[NC].LinkComp[0].Top;
        Layout[NC].LinkComp[0].Top:=Q033B['Top'];
        Layout[NC].LinkComp[0].Left:=Q033B['Lft'];
        Layout[NC].Accesso:=Q033B['Accesso'];
        if Q033B['Accesso'] = 'N' then
          Layout[NC].LinkComp[0].Visible:=False
        else
          Layout[NC].LinkComp[0].Visible:=True;
        ObjCaption(Layout[NC].LinkComp[0],Q033B.FieldByName('Caption').AsString,1);
        ObjColor(Layout[NC].LinkComp[0],NC,Q033B.FieldByName('Accesso').AsString = 'R');
        {Associo la TabSheet adeguata}
        for i:=0 to A002FAnagrafeGest.PageControl1.PageCount - 1 do
          if Q033B['NomePagina'] = A002FAnagrafeGest.PageControl1.Pages[i].Caption then
          begin
            Layout[NC].Parent:=A002FAnagrafeGest.PageControl1.Pages[i];
            Break;
          end;
        Layout[NC].LinkComp[0].Parent:=layout[NC].Parent;
        SettaProprieta(NC,XOld,YOld);
        //Imposto il TabOrder corretto per ogni componente
        if sNomePagOld = '' then
          sNomePagOld:=Q033B.FieldByName('NOMEPAGINA').AsString;
        if Q033B.FieldByName('NOMEPAGINA').AsString <> sNomePagOld then
        begin
          sNomePagOld:=Q033B.FieldByName('NOMEPAGINA').AsString;
          iNCompPag:=Q033B.FieldByName('ROWNUM').AsInteger;
        end;
        try
          if TWinControl(Layout[NC].LinkComp[0]).TabOrder <> -1 then
            TWinControl(Layout[NC].LinkComp[0]).TabOrder:=Q033B.FieldByName('ROWNUM').AsInteger - iNCompPag + iTabOrder
          else if TWinControl(Layout[NC].LinkComp[1]).TabOrder <> -1 then
            TWinControl(Layout[NC].LinkComp[1]).TabOrder:=Q033B.FieldByName('ROWNUM').AsInteger - iNCompPag + iTabOrder;
          if Q033B.FieldByName('CAMPODB').AsString = 'DescComune' then
          begin
            inc(iTabOrder);
            A002FAnagrafeGest.EComune.TabOrder:=Q033B.FieldByName('ROWNUM').AsInteger - iNCompPag + iTabOrder;
          end;
          if Q033B.FieldByName('CAMPODB').AsString = 'D_Comune' then
          begin
            inc(iTabOrder);
            A002FAnagrafeGest.dedtComune.TabOrder:=Q033B.FieldByName('ROWNUM').AsInteger - iNCompPag + iTabOrder;
          end;
        except
        end;
        Q033B.Next;
      end;
    except
      Result:=False;
    end;
    Q033B.Close;
  end;
end;

procedure TA002FLayout.CreaDefault;
{Creo la configurazione di default nel caso non esista smistando i dati liberi su Dati
 liberi 1 e Dati liberi 2}
var
  NC:integer;
  CampoDB:String;
  NDatiLiberi,Offset:Word;
  Parente:TTabSheet;
  PLeft:Word;
begin
  with A002FAnagrafeDtM1 do
  begin
    with A002FAnagrafeMW.selI500 do
    begin
      NDatiLiberi:=0;
      Close;
      Open;
      if RecordCount = 0 then exit;
      First;
      while not Eof do
      begin
        Inc(NDatiLiberi);
        if NDatiLiberi <= 8 then
        begin
          Parente:=A002FAnagrafeGest.PageControl1.Pages[3];
          Offset:=0;
          PLeft:=8;
        end
        else if NDatiLiberi <= 16 then
        begin
          Parente:=A002FAnagrafeGest.PageControl1.Pages[3];
          Offset:=8;
          PLeft:=Parente.Width div 2;
        end
        else if NDatiLiberi <= 24 then
        begin
          Parente:=A002FAnagrafeGest.PageControl1.Pages[4];
          Offset:=16;
          PLeft:=8;
        end
        else
        begin
          Parente:=A002FAnagrafeGest.PageControl1.Pages[4];
          Offset:=24;
          PLeft:=Parente.Width div 2;
        end;
        NC:=NumComp+NDatiLiberi;
        CampoDB:=FieldByName('NomeCampo').AsString;
        Layout[NC].LinkComp[0].Left:=PLeft;
        Layout[NC].LinkComp[0].Top:=(NDatiLiberi - Offset - 1) * 36 + 6;
        Layout[NC].Accesso:='S';
        Layout[NC].LinkComp[0].Visible:=True;
        ObjCaption(Layout[NC].LinkComp[0],FieldByName('NomeCampo').AsString,1);
        Layout[NC].Parent:=Parente;
        Layout[NC].LinkComp[0].Parent:=Layout[NC].Parent;
        Layout[NC].LinkComp[1].Visible:=True;
        Layout[NC].LinkComp[1].Parent:=Layout[NC].Parent;
        if FieldByName('Tabella').AsString = 'S' then
          //Se campo tabellare creo LookupComboBox e DBText
        begin
          Layout[NC].LinkComp[1].Left:=PLeft;
          Layout[NC].LinkComp[1].Top:=(NDatiLiberi - Offset - 1) * 36 + 20;
          //Creo DBText per descrizione codice}
          Layout[NC].LinkComp[2].Left:=PLeft + Layout[NC].LinkComp[1].Width + 2;
          Layout[NC].LinkComp[2].Top:=(NDatiLiberi - Offset - 1) * 36 + 23;
          Layout[NC].LinkComp[2].Visible:=True;
          Layout[NC].LinkComp[2].Parent:=Layout[NC].Parent;
        end
        else
          //Se campo NON tabellare creo DBEdit
        begin
          Layout[NC].LinkComp[1].Left:=PLeft;
          Layout[NC].LinkComp[1].Top:=(NDatiLiberi - Offset - 1) * 36 + 20;
        end;
        Next;
      end;
      Close;
    end;
  end;
end;

procedure TA002FLayout.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
{Operazioni prima della chiusura della Form}
var i,j:integer;
begin
  with A002FAnagrafeDtM1 do
  begin
    //Se non esiste la configurazione 'DEFAULT' la creo
    if not selaT033.SearchRecord('NOME','DEFAULT',[srFromBeginning]) then
    begin
      chkConfigDefault.Checked := True;
      Modificato := True;
    end;
  end;
  if Modificato then
    SalvaConfigClick(Sender);
  Shape1.Parent:=A002FLayout;
  A002FAnagrafeGest.PageControl1.Parent:=A002FAnagrafeGest;
  A002FAnagrafeDtM1.Q030.EnableControls;
  A002FAnagrafeDtM1.Q430.EnableControls;
  for i:=0 to (NumComp+NDL) do
    for j:=0 to 2 do
      if Layout[i].LinkComp[j] <> nil then
        Layout[i].LinkComp[j].Enabled:=True;
  {Tolgo i gestori di evento prima di tornare in AnagrafeGest}
  with A002FAnagrafeGest do
  begin
    PageControl1.OnChanging:=nil;
    PageControl1.OnChange:=nil;
    for i:=0 to PageControl1.PageCount - 1 do
    begin
      PageControl1.Pages[i].OnMouseDown:=nil;
      PageControl1.Pages[i].OnMouseMove:=nil;
      PageControl1.Pages[i].OnMouseUp:=nil;
    end;
  end;
  CanClose:=True;
  Attivazione;
  Application.OnDeactivate:=nil;
end;

procedure TA002FLayout.CaricaConfigClick(Sender: TObject);
{Chiedo il nome della configurazione (nome utente) da caricare}
begin
  Nome:=cbxUTENTE.Text;
  if Trim(Nome) = '' then exit;
  if Carica then
    begin
    CreaRettangoli;
    PageControlChange(Sender);
    end;
end;

procedure TA002FLayout.SalvaConfigClick(Sender: TObject);
{Salvo l'impostazione: con un nome utente}
begin
  Modificato:=False;
  {if Trim(Nome) = '' then
  begin
    ShowMessage('La configurazione deve essere associata ad un nome operatore valido');
    exit;
  end;}
  Nome:=Trim(cbxUTENTE.Text);
  if Length(Nome) > 30 then
    raise Exception.Create('La dimensione del nome layout dev''essere minore di 30 caratteri.');
  if UpperCase(Nome) = 'MONDOEDP' then
    raise Exception.Create('Impossibile utilizzare ' + Nome + ' come nome layout angrafico.');
  with A002FAnagrafeDtM1 do
  begin
    Q033B.Close;
    Q033B.SetVariable('Nome',Trim(Nome));
    Q033B.Open;
    if OkSalva(Nome) then
    begin
      Salva;
      Q033B.Close;
      if chkConfigDefault.Checked then
      begin
        Nome:='DEFAULT';
        Q033B.SetVariable('Nome',Trim(Nome));
        Q033B.Open;
        if OkSalva(Nome) then
          Salva;
        Q033B.Close;
      end;
      sel070.Refresh;
      NomiConfig;
    end
    else
    begin
      Carica;
      VisualizzoPagina;
    end;
    Q033B.Close;
  end;
end;

procedure TA002FLayout.actSpostaExecute(Sender: TObject);
begin
  actSposta.checked:=not actSposta.checked;
  if actSposta.checked then
    stbBottom1.Panels[0].Text:='Abilitazione spostamento campi attiva'
  else
    stbBottom1.Panels[0].Text:='Abilitazione spostamento campi disattiva';
end;

procedure TA002FLayout.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TA002FLayout.actCancellaExecute(Sender: TObject);
{Cancellazione configurazione}
begin
  Nome:=cbxUTENTE.Text;
  if Trim(Nome) = '' then
  begin
    ShowMessage('La configurazione deve essere associata ad un nome operatore valido');
    exit;
  end;
  if Trim(Nome) = 'DEFAULT' then
  begin
    ShowMessage('La configurazione DEFAULT non può essere cancellata');
    exit;
  end;
  if OkCancella(Nome) then exit;
  with A002FAnagrafeDtM1.OperSql,A002FAnagrafeDtM1 do
  begin
    Sql.Clear;
    Sql.Add(Format('DELETE FROM T033_Layout WHERE Nome = ''%s''',[Nome]));
    try
      Execute;
      SessioneOracle.Commit;
      sel070.Refresh;
      NomiConfig;
    except
      SessioneOracle.Rollback;
    end;
  end;
end;

procedure TA002FLayout.actEliminaExecute(Sender: TObject);
var
  i:Integer;
begin
  modificato:=true;
  for i:=0 to 2 do
  if Layout[Group].LinkComp[i] = nil then
    Break
  else
  begin
    Layout[Group].LinkComp[i].visible:=false;
    Layout[Group].Accesso:='N';
  end;
  PageControlChange(Sender);
end;

procedure TA002FLayout.actRipristinaExecute(Sender: TObject);
{Richiama la Form L004FSelezione per ripristinare i dati;
Gestisce la possibilita' di spostare i campi su un'altra pagina}
var cancellato:boolean;
    i,j,k:integer;
    StrCaption:String;
    ListaInput,ListaOutput:TStrings;
begin
  actSposta.checked:=False;
  cancellato:=false;
  ListaInput:=TStringList.Create;
  ListaOutput:=TStringList.Create;
  try
    for i:=0 to (NumComp+NDL) do
    if not(Layout[i].LinkComp[0].visible) then
      begin
      cancellato:=true;
      ListaInput.Add(ObjCaption(Layout[i].LinkComp[0],StrCaption,0));
      end;
    if (cancellato) then
      begin
      FSelezionaDati:=TFSelezionaDati.Create(Application);
      try
        for i:=0 to ListaInput.Count-1 do
          FSelezionaDati.ListBox1.Items.Add(ListaInput[i]);
        if FSelezionaDati.ShowModal = mrOk then
          begin
          modificato:=true;
          for i:=0 to FSelezionaDati.ListBox2.Items.Count-1 do
            begin
            k:=0;
            while ObjCaption(A002FLayout.Layout[k].LinkComp[0],StrCaption,0) <>
                  FSelezionaDati.ListBox2.Items[i] do k:=k+1;
            for j:=0 to 2 do
              if A002FLayout.Layout[k].LinkComp[j] <> nil then
                with Layout[k] do
                  begin
                  Parent:=CercaParent;
                  LinkComp[j].Parent:=Parent;
                  LinkComp[j].Visible:=True;
                  if LinkComp[j] = A002FAnagrafeGest.EI060EMail then
                    Accesso:='R'
                  else
                    Accesso:='S';
                  end;
            PageControlChange(Sender);
            end;
          end;
      finally
        FSelezionaDati.Release;
      end;
      end
    else
      ShowMessage('Non esistono campi cancellati!');
    finally
      ListaInput.Free;
      ListaOutput.Free;
    end;
end;

procedure TA002FLayout.actProprietaExecute(Sender: TObject);
{Impostazioni Caption, Coordinata X e Coordinata Y del dato}
var
  StrCaption:String;
begin
  if not Shape1.Visible then exit;
  A002FProprieta:=TA002FProprieta.Create(nil);
  with A002FProprieta do
  try
    // VALORIZZAZIONE CAMPO NOME  //LORENA 19/07/2004
    if not (Layout[group].LinkComp[0] = nil) then
    begin
      if Layout[group].LinkComp[0] is TDBRadioGroup then
        edtNome.Text:=(Layout[group].LinkComp[0] as TDBRadioGroup).Field.FieldName
      else if Layout[group].LinkComp[0]is TDBCheckBox then
        edtNome.Text:=(Layout[group].LinkComp[0] as TDBCheckBox).Field.FieldName;
    end;
    if not (Layout[group].LinkComp[1] = nil) then
    begin
      if Layout[group].LinkComp[1] is TDBEdit then
        edtNome.Text:=(Layout[group].LinkComp[1] as TDBEdit).Field.FieldName
      else if Layout[group].LinkComp[1] is TDBLookupComboBox then
        edtNome.Text:=(Layout[group].LinkComp[1] as TDBLookupComboBox).Field.FieldName;
    end;
    if not (Layout[group].LinkComp[2] = nil) then
      if Layout[group].LinkComp[2] is TDBEdit then
        edtNome.text:=(Layout[group].LinkComp[2] as TDBEdit).Field.FieldName;
    edtCaption.text:=ObjCaption(Layout[group].LinkComp[0],StrCaption,0);
    edtCoordX.text:=IntToStr(Shape1.Left);
    edtCoordY.text:=IntToStr(Shape1.Top);
    chkReadOnly.checked:=Layout[group].Accesso = 'R';
    if ShowModal = mrOk then
    begin
      //Cambia la caption del dato
      ObjCaption(Layout[group].LinkComp[0],edtCaption.text,1);
      ObjColor(Layout[group].LinkComp[0],group,chkReadOnly.checked);
      if chkReadOnly.checked then
        Layout[group].Accesso:='R'
      else
        Layout[group].Accesso:='S';
      //Cambia la posizione X dei controlli digitando direttamente il valore
      if (edtCoordX.text<>'')and(edtCoordX.text[1]<>'-')  then
      begin
        xdisplacement:=0;
        ydisplacement:=0;
        Shape1.Left:=StrToInt(Trim(edtCoordX.text));
        Trascina:=True;
        TabSheetMouseUp(sender,mbLeft,[],Shape1.Left,Shape1.Top);
      end;
      //Cambia la posizione Y dei controlli digitando direttamente il valore
      if (edtCoordY.text<>'')and(edtCoordY.text[1]<>'-')  then
      begin
        xdisplacement:=0;
        ydisplacement:=0;
        Shape1.Top:=StrToInt(Trim(edtCoordY.text));
        Trascina:=True;
        TabSheetMouseUp(sender,mbLeft,[],Shape1.Left,Shape1.Top);
      end;
    end;
  finally
    Release;
  end;
  StatoPagina;
end;

procedure TA002FLayout.rgpPaginaClick(Sender: TObject);
var i,j:Integer;
begin
  if A002FAnagrafeGest.PageControl1.Parent = A002FLayout then
    A002FAnagrafeGest.PageControl1.SetFocus;
  case rgpPagina.ItemIndex of
    0:
      begin
        for j:=0 to High(Layout) do
          if Layout[j].Parent = A002FAnagrafeGest.PageControl1.ActivePage then
          begin
            for i:=0 to 2 do
              if Layout[j].LinkComp[i] <> nil then
                Layout[j].LinkComp[i].Visible:=True;
            ObjColor(Layout[j].LinkComp[0],j,False);
          end;
        ImpostaAccesso('S');
      end;
    1:
      begin
        for j:=0 to High(Layout) do
        begin
          if Layout[j].Parent = A002FAnagrafeGest.PageControl1.ActivePage then
            ObjColor(Layout[j].LinkComp[0],j,True);
        end;
        ImpostaAccesso('R');
      end;
    2:
      begin
        for j:=0 to High(Layout) do
          if Layout[j].Parent = A002FAnagrafeGest.PageControl1.ActivePage then
            for i:=0 to 2 do
              if Layout[j].LinkComp[i] <> nil then
                Layout[j].LinkComp[i].Visible:=False;
        ImpostaAccesso('N');
      end;
  end;
end;

procedure TA002FLayout.ImpostaAccesso(ImpAcc:String);
var
  i:Integer;
begin
  for i:=0 to (NumComp+NDL) do
    if Layout[i].Parent = CercaParent then
    begin
      if Layout[i].Accesso <> ImpAcc then
        modificato:=true;
      Layout[i].Accesso:=ImpAcc;
    end;
end;

procedure TA002FLayout.AppDeactivate(Sender: TObject);
begin
  A002FAnagrafeGest.PageControl1.SetFocus;
end;

procedure TA002FLayout.FormShow(Sender: TObject);
begin
  Application.OnDeactivate:=AppDeactivate;
  actSalva.Enabled:=not SolaLettura;
  actCancella.Enabled:=not SolaLettura;
  actSposta.Enabled:=not SolaLettura;
  actProprieta.Enabled:=not SolaLettura;
  actElimina.Enabled:=not SolaLettura;
  actRipristina.Enabled:=not SolaLettura;
  rgpPagina.Enabled:=not SolaLettura;
  chkConfigDefault.Enabled:=not SolaLettura;
end;

procedure TA002FLayout.FormDestroy(Sender: TObject);
begin
  SetLength(Layout,0);
  A002FAnagrafeDtM1.sel070.Close;
end;

procedure TA002FLayout.cbxUTENTEChange(Sender: TObject);
begin
  TipoConfigurazione;
end;


procedure TA002FLayout.TipoConfigurazione;
  function UserExists(Nome:String):Boolean;
  begin
    Result:=False;
    with TOracleQuery.Create(nil) do
      try
        Session:=SessioneOracle;
        SQL.Add('select count(*) as NUMREC');
        SQL.Add('  from MONDOEDP.I070_UTENTI I070');
        SQL.Add(' where I070.UTENTE = ''' + Nome + '''');
        Execute;
        Result:=FieldAsInteger('NUMREC') > 0;
      finally
        Free;
      end;
  end;
begin
  with A002FAnagrafeDtM1 do
  begin
    if Not UserExists(cbxUTENTE.Text) then
    begin
        if not selaT033.SearchRecord('NOME',cbxUTENTE.Text,[srFromBeginning]) then
          lblTipoConfigurazione.Caption:='Config.non registrata'
        else
          lblTipoConfigurazione.Caption:='Config.registrata'
    end
    else
      if not selaT033.SearchRecord('NOME',cbxUTENTE.Text,[srFromBeginning]) then
        lblTipoConfigurazione.Caption:='Nome operatore'
      else
        lblTipoConfigurazione.Caption:='Nome operatore e configurazione';
  end;
end;

procedure TA002FLayout.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  A002FAnagrafeDtM1.A002FAnagrafeMW.selT033_campoDecode.Refresh;
end;

end.
