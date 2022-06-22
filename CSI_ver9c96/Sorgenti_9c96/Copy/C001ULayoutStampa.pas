unit C001ULayoutStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,StdCtrls, ComCtrls, Menus, Buttons, C001StampaLib, db, Printers,
  Spin, QuickRpt, QRPrntr, Variants;

type   
  TC001FLayoutStampa = class(TForm)
    PgCtrlStampa: TPageControl;
    TabDettaglio: TTabSheet;
    TabIntestazione: TTabSheet;
    ScrBox1: TScrollBox;
    ScrBox2: TScrollBox;
    PopMenu: TPopupMenu;
    Font1: TMenuItem;
    Size1: TMenuItem;
    FontDlg: TFontDialog;
    ColorDlg: TColorDialog;
    Colo1: TMenuItem;
    Del1: TMenuItem;
    Transparent1: TMenuItem;
    Allinea1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    LLeft: TLabel;
    LTop: TLabel;
    CmbOggetti: TComboBox;
    BtnAdd: TBitBtn;
    BtnDel: TBitBtn;
    BtnFont: TBitBtn;
    BitBtn1: TBitBtn;
    BtnSize: TBitBtn;
    BtnAllinea: TBitBtn;
    BtnFonts: TBitBtn;
    BitBtn2: TBitBtn;
    TabSheet2: TTabSheet;
    CheckSingola: TCheckBox;
    RGrpTipo: TRadioGroup;
    TabSheet3: TTabSheet;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    CheckSeparate: TCheckBox;
    Panel2: TPanel;
    Label1: TLabel;
    ETitolo: TEdit;
    TabOpzioni: TTabSheet;
    CkBLineaSup: TCheckBox;
    CkBLineaInf: TCheckBox;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    CkBLineaRec: TCheckBox;
    SpeedButton1: TSpeedButton;
    CheckSpaziatura: TCheckBox;
    SpSpaziatura: TSpinEdit;
    RGTipoGruppo: TRadioGroup;
    SpeedButton4: TSpeedButton;
    BtnStampa: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure OggettoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
                               X, Y: Integer);
    procedure OggettoMouseUp(Sender: TObject; Button: TMouseButton;
                             Shift: TShiftState; X, Y: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure Size1Click(Sender: TObject);
    procedure BtnStampaClick(Sender: TObject);
    procedure Colo1Click(Sender: TObject);
    procedure trasparente1Click(Sender: TObject);
    procedure PopMenuPopup(Sender: TObject);
    procedure BtnAllineaClick(Sender: TObject);
    procedure BtnFontsClick(Sender: TObject);
    procedure CheckSingolaClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ScrBox1Enter(Sender: TObject);
    procedure ScrBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ScrBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure RGrpTipoClick(Sender: TObject);
    procedure CheckSeparateClick(Sender: TObject);
    procedure CheckSpaziaturaClick(Sender: TObject);
    procedure SpSpaziaturaChange(Sender: TObject);
    procedure SalvaOggettiStampa;
    procedure BitBtn2Click(Sender: TObject);
    procedure ETitoloChange(Sender: TObject);
    procedure ScrBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrBox2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RGTipoGruppoClick(Sender: TObject);
    procedure CkBLineaRecClick(Sender: TObject);
    procedure CkBLineaSupClick(Sender: TObject);
    procedure CkBLineaInfClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
    ListaOggetti:TList;
    ListaMultipla:TList;
    NumSelezionati:Word;
    LastFontColor,SelColore:TColor;
    PagAttiva:BandaTipo;
    DefWidth:Byte;
    DefHeight:Byte;
    Selezione:Boolean;
    TempVettStampa:ArrayStampa;
    TempNOggetti:Integer;
    procedure CreaComponenti;
    procedure AggiungiOggetto(RecStampa:Rec_Stampa);
    procedure EliminaOggetto(var RecStampa:Rec_Stampa);
    procedure CaricaCombo;
    procedure ImpostaCmbOggetti(nome:string);
    function FindListaOggetti(nome:string):integer;
    procedure OggettoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure AllineaScrollBox;
    procedure GeneraElencoDefault;
    procedure GeneraSchedaDefault;
    procedure GeneraGruppoDefault(AssegnaBanda:Boolean);
    procedure CaricaReport(tipo:ReportTipo);
    function GotoNearestX( X: Integer ):Integer;
    function GotoNearestY( Y: Integer ):Integer;
    procedure CreaListaSelezioneMultipla;
    procedure DistruggiListaSelezioneMultipla;
    procedure ImpostazioniLinee;
    function GetMaxWidth:Integer;
  public
    { Public declarations }
    MuoviOggetto:Boolean;
    function PosizioneOggetto(nome:string):integer;
    procedure CaricaVettoreStampa(Source:TDatasource);
  end;

var
  C001FLayoutStampa: TC001FLayoutStampa;
  startx,starty:integer;

implementation

uses C001USizeStampa,C001UFiltroTabelle,C001UFiltroTabelleDtm,C001UStampa,C001UAllineaStampa,
     C001USettings, C001ULineSettings,C001UGroupSelection;

{$R *.DFM}

procedure TC001FLayoutStampa.SalvaOggettiStampa;
var I:Integer;
    S:String;

begin
  with C001FLayoutStampa do
     begin
       EliminaElementi(OGGETTO);
       for I:=1 to NOggetti do
          begin
            S :=OGGETTO+';'+VettStampa[I].NomeOggetto; // Nome
            if VettStampa[I].Tipo = (QRIntestazione) then
              S:=S + ';'+'QRLabel'
            else
              S:=S + ';'+'QRDBText';
            S:=S +';'+ VettStampa[I].Caption;  // caption
            try
              S:=S +';'+ VettStampa[I].DSource.Name; // Dsource
            except
              S:=S + ';';
            end;
            S:=S +';'+ VettStampa[I].DField; // DataField
            if VettStampa[I].Banda = (bNone) then
              S:=S +';'+ 'bNone'
            else
              if VettStampa[I].Banda = (bDettaglio) then
                S:=S +';'+ 'bDettaglio'               // Banda
              else
                if VettStampa[I].Banda = (bIntestazione) then
                  S:=S+';'+'bIntestazione'
                else
                  if VettStampa[I].Banda = (bGruppo) then
                    S:=S+';'+'bGruppo';
            S:=S + ';'+ inttostr(VettStampa[I].Height);
            S:=S + ';'+ inttostr(VettStampa[I].Width);
            S:=S + ';'+ inttostr(VettStampa[I].Left);
            S:=S + ';'+ inttostr(VettStampa[I].Top); // top
            if VettStampa[I].Font <> nil then
              begin
                S:=S + ';'+ IntToStr(VettStampa[I].Font.Color);
                S:=S + ';'+ Inttostr(VettStampa[I].Font.Height);
                S:=S + ';'+ Inttostr(VettStampa[I].Font.Size);
                S:=S + ';'+ VettStampa[I].Font.Name;
                S:=S + ';'+ FloatToStr(Variant(VettStampa[I].Font.Pitch));
                S:=S + ';'+ FontStyleToString(VettStampa[I].Font.Style);  // fontstyle
              end
            else
              begin
                S:=S + ';'+ ' ';
                S:=S + ';'+ ' ';
                S:=S + ';'+ ' ';
                S:=S + ';'+ ' ';
                S:=S + ';'+ ' ';
                S:=S + ';'+ ' ';
              end;
            S:=S + ';'+ IntToStr(VettStampa[I].Color);
            if VettStampa[I].Trasp then // Transparent
              S:=S +';'+ 'S'
            else
              S:=S +';'+ 'N';
            S:=S + ';'+ inttostr(VettStampa[I].ElencoX);
            S:=S + ';'+ inttostr(VettStampa[I].ElencoY);
            S:=S + ';'+ inttostr(VettStampa[I].SchedaX);
            S:=S + ';'+ inttostr(VettStampa[I].SchedaY);
            if VettStampa[I].ElencoBanda = (bNone) then
              S:=S + ';'+ 'bNone'
            else
              if VettStampa[I].ElencoBanda = (bDettaglio) then
                S:=S + ';'+ 'bDettaglio'
              else
                if VettStampa[I].ElencoBanda = (bIntestazione) then
                  S:=S + ';'+ 'bIntestazione';
            if VettStampa[I].SchedaBanda = (bNone) then
              S:=S + ';'+ 'bNone'
            else
              if VettStampa[I].SchedaBanda = (bDettaglio) then
                S:=S + ';'+ 'bDettaglio'
              else
                if VettStampa[I].SchedaBanda = (bIntestazione) then
                  S:=S + ';'+ 'bIntestazione';
            if VettStampa[I].Gruppo then
              S:=S + ';' + 'S'
            else
              S:=S + ';' + 'N';
            if VettStampa[I].SelGruppo then
              S:=S + ';' + 'S'
            else
              S:=S + ';' + 'N';
            S:=S + ';' + inttostr(VettStampa[I].NumeroBandaGruppo)+';';
            ListaSettaggi.Add(S);
          end;
    end;
end;

procedure TC001FLayoutStampa.FormCreate(Sender: TObject);
begin
  PgCtrlStampa.Activepage:=TabDettaglio;
  MuoviOggetto:=False;
  PagAttiva:=bNone;
  NumSelezionati:=0;
  PageControl1.ActivePage :=TabSheet1;
end;

procedure TC001FLayoutStampa.ImpostazioniLinee;
begin
  CkBLineaRec.Checked:=LineaRec.Enabled;
  CkBLineaInf.Checked:=LineaInf.Enabled;
  CkBLineaSup.Checked:=LineaSup.Enabled;
  CheckSpaziatura.Checked:=InterLineaAbilitata;
  SpSpaziatura.Value:=AltezzaInterLinea;
  if ConfigAttiva = '' then
    if StampaGruppo then
      begin
        CkBLineaInf.Checked:=LineaInf.Enabled;
        CkBLineaSup.Checked:=LineaSup.Enabled;
        CkBLineaInf.Enabled:=True;
        CkBLineaSup.Enabled:=True;
      end
    else
      begin
        CkBLineaInf.Checked:=False;
        CkBLineaSup.Checked:=False;
        CkBLineaInf.Enabled:=False;
        CkBLineaSup.Enabled:=False;
      end;
end;

procedure TC001FLayoutStampa.FormShow(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  DefWidth:=ScrBox1.Font.Size + 1;
  DefHeight:=2*DefWidth;
  if (C001FFiltroTabelle.DefaultFont = nil) then
    C001FFiltroTabelle.DefaultFont.Assign(ScrBox1.Font);
  RGrpTipo.OnClick:=nil;
  if Modalita = Elenco then
    RGrpTipo.ItemIndex:=0
  else
    RGrpTipo.ItemIndex:=1;
  RGrpTipo.OnClick:=RGrpTipoClick;
  if (C001FFiltroTabelle.VariazioneCampi) then
    NOggetti:=0;
  WindowState:=wsMaximized;
  SelColore:=clBlack;
  ListaOggetti:=TList.Create;
  CaricaVettoreStampa(C001FFiltroTabelleDtm.DataSource1);
  CreaComponenti;
  CaricaReport(Modalita);
  CaricaReport(Gruppo);
  CaricaCombo;
  CheckSingola.Checked:=True;
  CheckSingolaClick(CheckSingola);
  ImpostazioniLinee;
  CheckSeparate.Checked:=PagineSeparate;
  if StampaGruppo then
    begin
      TabOpzioni.TabVisible:=True;
      RGTipoGruppo.OnClick:=nil;
      RGTipoGruppo.ItemIndex:=TipoGruppo;
      RGTipoGruppo.OnClick:=RGTipoGruppoClick;
    end
  else
    TabOpzioni.TabVisible:=False;
  Screen.Cursor:=crDefault;
end;

// carica le impostazioni salvate per uno dei 2 report di default (Scheda/Elenco)
procedure TC001FLayoutStampa.CaricaReport(tipo:ReportTipo);
var i,idx:integer;
begin
  for i:=1 to NOggetti do
    begin
      idx:=FindListaOggetti(VettStampa[i].NomeOggetto);
        case tipo of
          Elenco:begin
                   if (VettStampa[I].Gruppo=False)and(VettStampa[I].SelGruppo=False) then
                     begin
                       VettStampa[i].Banda:=VettStampa[i].ElencoBanda;
                       VettStampa[i].Left:=VettStampa[i].ElencoX;
                       VettStampa[i].Top:=VettStampa[i].ElencoY;
                     end;
                 end;
          Scheda:begin
                   if (VettStampa[I].Gruppo=False)and(VettStampa[I].SelGruppo=False) then
                     begin
                       VettStampa[i].Banda:=VettStampa[i].SchedaBanda;
                       VettStampa[i].Left:=VettStampa[i].SchedaX;
                       VettStampa[i].Top:=VettStampa[i].SchedaY;
                     end;
                 end;
          Gruppo:begin
                   if (VettStampa[I].Gruppo)or(VettStampa[I].SelGruppo) then
                     begin
                       VettStampa[i].Left:=VettStampa[i].GruppoX;
                       VettStampa[i].Top:=VettStampa[i].GruppoY;
                       VettStampa[i].Banda:=bGruppo;
                     end;
                 end;
        end;

      if idx>=0 then
         begin
           TLabel(ListaOggetti.Items[idx]).Top:=VettStampa[i].Top;
           TLabel(ListaOggetti.Items[idx]).Left:=VettStampa[i].Left;
           TLabel(ListaOggetti.Items[idx]).ParentFont:=False;

           case VettStampa[i].Banda of
                  bDettaglio:TLabel(ListaOggetti.Items[idx]).Parent:=ScrBox1;
                  bIntestazione:TLabel(ListaOggetti.Items[idx]).Parent:=ScrBox2;
                  bNone:EliminaOggetto(VettStampa[i]);
                end;
         end
      else
         if VettStampa[i].Banda<>bNone then
            AggiungiOggetto(VettStampa[i]);
    end;
end;

// procedura che assegna le posizioni ai componenti per un Report di default a Scheda
procedure TC001FLayoutStampa.GeneraSchedaDefault;
var i,x,y,Blocco,IndiceMax,nCol:integer;
    IndiceColonna:variant;
    OffColonna:variant;
    ReDim:boolean;

  function Ottimizzato(var Col:integer):boolean;  // verifica se non vi sono blocchi vuoti
  var k:integer;
  begin
    result:=true;
    k:=1;
    //Modificato da Alberto il 2/08/97 - Orig:while (k<=VarArrayHighBound(OffColonna...
    while (k<=VarArrayHighBound(IndiceColonna{StatoColonna},1)) and (Result) do
    begin
      if OffColonna[k]>0{StatoColonna[k]<=1} then
      begin
        result:=false;
        Col:=k;
      end;
      k:=k+1;
    end;
  end;

  procedure CalcolaPrimaRiga(ReDim:boolean);  // Imposta il numero dei blocchi in base
  var VarApp:Variant;                         // alla prima linea
  begin
    //Modificato da Alberto il 22/08/97
    VarApp:=VarArrayCreate([1,VarArrayHighBound(IndiceColonna,1)],VarInteger);
    //var j:=1 to VarArrayHighBound(IndiceColonna,1) do
    VarApp:=IndiceColonna;
    i:=1;
    x:=DefLeft;
    y:=DefTop;
    while (i<TempNOggetti) and ( x+TempVettStampa[i].Width+DefWidth+TempVettStampa[i+1].Width
                               < C001FStampa.QRep.Page.Width ) do
    begin
      VarArrayReDim(IndiceColonna,(i+1) div 2);
      if ReDim then
      begin
        VarArrayReDim(OffColonna,(i+1) div 2);
        OffColonna[(i+1) div 2]:=0;
        IndiceColonna[(i+1) div 2]:=x;
      end
      else
        if ( ((i+1) div 2)<=VarArrayHighBound(OffColonna,1) ) and (OffColonna[(i+1) div 2] >0) then
        begin
          IndiceColonna[(i+1) div 2]:=OffColonna[(i+1) div 2];
          x:=OffColonna[(i+1) div 2];
        end
        else
          if ((i+1) div 2)<=VarArrayHighBound(OffColonna,1) then
            IndiceColonna[(i+1) div 2]:=x
          else
          begin
            IndiceColonna[(i+1) div 2]:=x;
            VarArrayReDim(OffColonna,(i+1) div 2);
            OffColonna[(i+1) div 2]:=0;
          end;
      //Modif. da Alberto il 22/08/97
      if (ReDim) or ((i + 3) div 2 > VarArrayHighBound(VarApp,1)) then
        x:=x+TempVettStampa[i].Width+DefWidth+TempVettStampa[i+1].Width+2*DefWidth
      else
        x:=VarApp[(i+3) div 2];
      i:=i+2;
    end;
  end;

  // Copio VettStampa nel Vettore di Appggio se Direction = True
  // altrimenti copio il Vettore di Appoggio in VettStampa.
  procedure AssegnaVettoreAppoggio(Direction:Boolean);
  var I,J,Ind:Integer;
  begin
    if Direction then
    begin
      J:=0;
      for I:=1 to NOggetti do
      begin
        if (VettStampa[I].Gruppo=False)and(VettStampa[I].SelGruppo=False) then
        begin
          inc(J,1);
          TempVettStampa[J]:=VettStampa[I];
        end;
      end;
      TempNOggetti:=J;
    end
    else
    begin
      for I:=1 to TempNOggetti do
      begin
        Ind:=PosizioneOggetto(TempVettStampa[i].NomeOggetto);
        if Ind <> -1 then
          VettStampa[Ind]:=TempVettStampa[I];
      end;
    end;
  end;


begin
  if not C001FFiltroTabelle.VariazioneCampi then exit;//Alberto 16/06/2004
  AssegnaVettoreAppoggio(True);
  nCol:=0;
  IndiceColonna:=VarArrayCreate([1,1],VarInteger);
  OffColonna:=VarArrayCreate([1,1],VarInteger);
  OffColonna[1]:=1;
  ReDim:=true;
  while not Ottimizzato(nCol) do    // ciclo in cui vengono impostati i campi nelle varie
    begin                           // righe in base ai blocchi definiti in precedenza
      CalcolaPrimaRiga(ReDim);
      ReDim:=false;
      OffColonna[nCol]:=0;
      nCol:=0;
      IndiceMax:=VarArrayHighBound(IndiceColonna,1);
      i:=1;
      Blocco:=1;
      x:=IndiceColonna[Blocco];
      while (i < TempNOggetti) do
        begin
          x:=IndiceColonna[Blocco];    // test se il campo stà nella pagina o se sono al blocco 1
          if ((x+TempVettStampa[i].Width+DefWidth+TempVettStampa[i+1].Width) < C001FStampa.QRep.Page.Width)
             or (Blocco=1) then
             begin
               TempVettStampa[i].SchedaBanda:=bDettaglio;
               TempVettStampa[i].SchedaX:=X;
               TempVettStampa[i].SchedaY:=Y;
               x:=x+TempVettStampa[i].Width+DefWidth;
               TempVettStampa[i+1].SchedaBanda:=bDettaglio;
               TempVettStampa[i+1].SchedaX:=x;
               TempVettStampa[i+1].SchedaY:=y;
               x:=x+TempVettStampa[i+1].Width+2*DefWidth;
               i:=i+2;
               if Blocco<IndiceMax then     // se non è sull'ultimo blocco
                  begin
                    if (x>IndiceColonna[Blocco+1]) then // se il campo precedente ha 'invaso'
                       begin                            // il blocco successivo
                         if x>OffColonna[Blocco+1] then
                             OffColonna[Blocco+1]:=x;
                         if (IndiceMax-Blocco>=2) then
                            Blocco:=Blocco+2 // salto il blocco successivo e vado a quello dopo
                         else
                            begin // vado a capo
                              Blocco:=1;
                              y:=y+(*2**)DefHeight;
                            end;
                       end
                    else
                       Blocco:=Blocco+1;    // si passa al blocco successivo
                  end
               else
                  begin // sono sull'ultimo blocco e vado a capo
                    Blocco:=1;
                    y:=y+(*2**)DefHeight;
                  end;
             end
          else
             begin  // non ci sta allora vado a capo
               Blocco:=1;
               y:=y+(*2**)DefHeight;
             end;
        end;
   end;
  AssegnaVettoreAppoggio(False);
end;

// procedura che assegna le posizioni ai componenti per un Report di default ad Elenco
procedure TC001FLayoutStampa.GeneraElencoDefault;
var i,x,y,k:integer;
begin
  x:=DefLeft;
  y:=DefTop;
  k:=1;
  with C001FFiltroTabelle do
    for i:=0 to ListaCampi.Count - 1 do
      begin
        RecCampi:=ListaCampi[I];
        if not VariazioneCampi then Continue;//Alberto 16/06/2004
        if (RecCampi.Selezionato) then
        begin
        if (RecCampi.Gruppo=False)and(RecCampi.SelGruppo=False) then
        if x+VettStampa[k].Width > C001FStampa.QRep.Page.Width then
           begin
             VettStampa[k].ElencoBanda:=bNone;
             VettStampa[k].ElencoX:=DefLeft;
             VettStampa[k].ElencoY:=DefTop + DefHeight * 5;
             VettStampa[k+1].ElencoBanda:=bNone;
             VettStampa[k+1].ElencoX:=DefLeft;
             VettStampa[k+1].ElencoY:=DefTop + DefHeight * 5;
           end
        else
          begin
            VettStampa[k].ElencoBanda:=bIntestazione;
            VettStampa[k].ElencoX:=x;
            VettStampa[k].ElencoY:=y;
            VettStampa[k+1].ElencoBanda:=bDettaglio;
            VettStampa[k+1].ElencoX:=x;
            VettStampa[k+1].ElencoY:=y;
            x:=x+VettStampa[k+1].Width+DefWidth;
          end;
        k:=k+2;
      end;
      end;
end;

// Larghezza massima tra i componenti da mettere nella banda di gruppo.
function TC001FLayoutStampa.GetMaxWidth:Integer;
var I:Integer;
    LabApp:TLabel;
begin
  Result:=0;
  LabApp:=TLabel.Create(C001FStampa);
  LabApp.Parent:=C001FStampa;
  for I:=1 to NOggetti do
     begin
       if (VettStampa[I].Gruppo)or(VettStampa[I].SelGruppo) then
         if VettStampa[I].Tipo = QRIntestazione then
           begin
           if (VettStampa[i].NumeroBandaGruppo >= 0) and (FontGruppo[VettStampa[i].NumeroBandaGruppo] <> nil) then
             begin
             VettStampa[I].Width:=Length(VettStampa[i].Caption) * FontGruppo[VettStampa[i].NumeroBandaGruppo].Size;
             LabApp.Font:=FontGruppo[VettStampa[i].NumeroBandaGruppo];
             VettStampa[I].Height:=LabApp.Canvas.TextHeight(VettStampa[i].Caption);
             end;
           if VettStampa[I].Width > Result then
             Result:=VettStampa[I].Width;
           end;
     end;
  LabApp.Free;
end;

// procedura che assegna le bande agli oggetti per la stampa di gruppo.
procedure TC001FLayoutStampa.GeneraGruppoDefault(AssegnaBanda:Boolean);

CONST SpazioLeft = 50;
var Ind,K,I,MaxWidth,CurrBanda:Integer;
    Coord:array[1..10] of TPoint;
begin
  MaxWidth:=GetMaxWidth;
  for I:=1 to 10 do
  begin
    if I = 1 then
      Coord[I].X:=DefLeft
    else
      Coord[I].X:=Coord[I-1].X + SpazioLeft;
    Coord[I].Y:=DefTop;
  end;
  with C001FFiltroTabelle do
  begin
    Ind:=0;
    K:=1;
    for i:=0 to ListaCampi.Count - 1 do
    begin
      RecCampi:=ListaCampi[I];
      if RecCampi.Selezionato then
      begin
        if (RecCampi.Gruppo)or(RecCampi.SelGruppo) then
        begin
          if (TipoGruppo = 1)and(RecCampi.Gruppo) then
            inc(Ind)
          else
          begin
            if (TipoGruppo=0) then
              Ind:=1;
          end;
          if True then
          //if (AssegnaBanda) then
          begin
            if RecCampi.Gruppo then
            begin
              RecCampi.NumBanda:=Ind;
              if VariazioneCampi then //Alberto 16/06/2004
              begin
                VettStampa[K].NumeroBandaGruppo:=Ind;
                VettStampa[K].Banda:=bGruppo;
                VettStampa[K+1].NumeroBandaGruppo:=Ind;
                VettStampa[K+1].Banda:=bGruppo;
              end;
            end
          else
          begin
            RecCampi.SelGruppo:=False;
            if VariazioneCampi then //Alberto 16/06/2004
            begin
              VettStampa[K].NumeroBandaGruppo:=-1;
              VettStampa[K].Banda:=bNone;
              VettStampa[K].SelGruppo:=False;
              VettStampa[K+1].NumeroBandaGruppo:=-1;
              VettStampa[K+1].SelGruppo:=False;
              VettStampa[K+1].Banda:=bNone;
            end;
          end;
        end;
        CurrBanda:=VettStampa[K].NumeroBandaGruppo;
        if CurrBanda <= 0 then
          Break;
        if TipoGruppo = 0 then
        begin
          if VariazioneCampi then //Alberto 16/06/2004
          begin
            VettStampa[k].GruppoBanda:=bGruppo;
            VettStampa[k].GruppoX:=DefLeft;
            VettStampa[k].GruppoY:=Coord[CurrBanda].Y;
            VettStampa[k+1].GruppoBanda:=bGruppo;
            VettStampa[k+1].GruppoX:=DefLeft+MaxWidth;
            VettStampa[k+1].GruppoY:= Coord[CurrBanda].Y ;
          end;
          if VettStampa[K].Height > VettStampa[K+1].Height then
            Coord[CurrBanda].Y:=Coord[CurrBanda].Y + VettStampa[K].Height
          else
            Coord[CurrBanda].Y:=Coord[CurrBanda].Y + VettStampa[K+1].Height;
        end
        else
          if Coord[CurrBanda].X+VettStampa[k].Width > C001FStampa.QRep.Page.Width then
          begin
            if VariazioneCampi then //Alberto 16/06/2004
            begin
              VettStampa[k].GruppoBanda:=bNone;
              VettStampa[k].GruppoX:=DefLeft;
              VettStampa[k].GruppoY:=DefTop + DefHeight * 5;
              VettStampa[k+1].GruppoBanda:=bNone;
              VettStampa[k+1].GruppoX:=DefLeft;
              VettStampa[k+1].GruppoY:=DefTop + DefHeight * 5;
            end;
          end
          else
          begin
            if VariazioneCampi then//Alberto 16/06/2004
            begin
              VettStampa[k].GruppoBanda:=bIntestazione;
              VettStampa[k].GruppoX:=Coord[CurrBanda].X;
              VettStampa[k].GruppoY:=Coord[CurrBanda].Y;
              VettStampa[k+1].GruppoBanda:=bDettaglio;
              VettStampa[k+1].GruppoX:=Coord[CurrBanda].X + VettStampa[k].Width+DefWidth;
              VettStampa[k+1].GruppoY:=Coord[CurrBanda].Y;
            end;
            if VettStampa[K].Height > VettStampa[K+1].Height then
              Coord[CurrBanda].Y:=Coord[CurrBanda].Y + VettStampa[K].Height
            else
              Coord[CurrBanda].Y:=Coord[CurrBanda].Y + VettStampa[K+1].Height;
          end;
        end;
        inc(K,2);
      end;
    end;
  end;
end;

// procedura che carica il VettoreStampa in base al dataset ricevuto come parametro
procedure TC001FLayoutStampa.CaricaVettoreStampa(Source:TDatasource);
var i,k:integer;
begin
  k:=1;
  with C001FFiltroTabelle do
  begin
    if (C001FFiltroTabelle.VariazioneCampi) or (NOggetti = 0) then
    begin
      for i:=0 to ListaCampi.Count - 1 do
      begin
        RecCampi:=ListaCampi[I];
        if RecCampi.Selezionato then
        begin
          if VettStampa[k].NomeOggetto <>'Int_'+Source.Dataset.FieldByName(RecCampi.Nome).FieldName then
          begin
            VettStampa[k].NomeOggetto:='Int_'+Source.Dataset.FieldByName(RecCampi.Nome).FieldName;
            VettStampa[k].Height:=DefHeight;
            VettStampa[k].Width:=DefWidth*Length(Source.Dataset.FieldByName(RecCampi.Nome).DisplayLabel);
            VettStampa[k].Trasp:=False;
            VettStampa[k].Color:=clWhite;
            VettStampa[k].Font:=C001FFiltroTabelle.DefaultFont;
          end;
          VettStampa[k].Caption:=Source.Dataset.FieldByName(RecCampi.Nome).DisplayLabel;
          VettStampa[k].Tipo:=QRIntestazione;
          VettStampa[k].DSource:=nil;
          VettStampa[k].DField:='';
          VettStampa[k].Banda:=bNone;
          VettStampa[k].Gruppo:=RecCampi.Gruppo;
          VettStampa[k].SelGruppo:=RecCampi.SelGruppo;
          VettStampa[k].NumeroBandaGruppo:=RecCampi.NumBanda;

          // Carico il campo QRDBTEXT
          if VettStampa[k+1].NomeOggetto <> 'Dett_'+Source.Dataset.FieldByName(RecCampi.Nome).FieldName then
          begin
            VettStampa[k+1].NomeOggetto:='Dett_'+Source.Dataset.FieldByName(RecCampi.Nome).FieldName;
            VettStampa[k+1].Height:=DefHeight;
            VettStampa[k+1].Width:=DefWidth*Source.Dataset.FieldByName(RecCampi.Nome).DisplayWidth;
            VettStampa[k+1].Trasp:=False;
            VettStampa[k+1].Color:=clWhite;
            VettStampa[k+1].Font:=C001FFiltroTabelle.DefaultFont;
          end;
          VettStampa[k+1].Caption:=Source.Dataset.FieldByName(RecCampi.Nome).DisplayLabel;
          VettStampa[k+1].Banda:=bNone;
          VettStampa[k+1].Tipo:=QRCampo;
          VettStampa[k+1].DSource:=Source;
          VettStampa[k+1].DField:=Source.Dataset.FieldByName(RecCampi.Nome).FieldName;
          VettStampa[k+1].Gruppo:=RecCampi.Gruppo;
          VettStampa[k+1].SelGruppo:=RecCampi.SelGruppo;
          VettStampa[k+1].NumeroBandaGruppo:=RecCampi.NumBanda;
          k:=k+2;
        end;
      end;
      //C001FFiltroTabelle.VariazioneCampi:=False;
      NOggetti:=K - 1;
    end;
    GeneraGruppoDefault(RiassegnaBandeGruppo);
    GeneraElencoDefault;
    GeneraSchedaDefault;
    C001FFiltroTabelle.VariazioneCampi:=False;
  end;
end;

procedure TC001FLayoutStampa.CreaComponenti;
var i:integer;
begin
  if ScrBox1.HorzScrollBar.Visible then
    ScrBox1.HorzScrollBar.Position:=0;
  if ScrBox2.HorzScrollBar.Visible then
    ScrBox2.HorzScrollBar.Position:=0;
  if ScrBox1.VertScrollBar.Visible then
    ScrBox1.VertScrollBar.Position:=0;
  if ScrBox2.VertScrollBar.Visible then
    ScrBox2.VertScrollBar.Position:=0;
  for i:= 1 to NOggetti do
    if (VettStampa[i].Banda=bDettaglio) or (VettStampa[i].Banda=bIntestazione) then
       AggiungiOggetto(VettStampa[i]);
end;

procedure TC001FLayoutStampa.AggiungiOggetto(RecStampa:Rec_Stampa);
var Oggetto:TLabel;
begin
   Oggetto:=TLabel.Create(C001FLayoutStampa);
   Oggetto.Autosize:=False;
   Oggetto.Name:=RecStampa.NomeOggetto;
   case RecStampa.Banda of
     bDettaglio:Oggetto.Parent:=ScrBox1;
     bIntestazione:Oggetto.Parent:=ScrBox2;
   end;
   Oggetto.Caption:=RecStampa.Caption;
   Oggetto.Top:=RecStampa.Top; //- TScrollBox(Oggetto.Parent).VertScrollBar.Position;
   Oggetto.Left:=RecStampa.Left; // - TScrollBox(Oggetto.Parent).HorzScrollBar.Position;
   Oggetto.Height:=RecStampa.Height;
   Oggetto.Width:=RecStampa.Width;
   Oggetto.Transparent:=RecStampa.Trasp;
   Oggetto.OnMouseDown:=OggettoMouseDown;
   Oggetto.OnMouseUp:=OggettoMouseUp;
   Oggetto.PopupMenu:=PopMenu;
   Oggetto.Color:=RecStampa.Color;
   Oggetto.Font.Assign(RecStampa.Font);
   ListaOggetti.Add(Oggetto);
end;

function TC001FLayoutStampa.PosizioneOggetto(nome:string):integer;
var i:integer;
begin
  i:=1;
  while (i<NOggetti) and (VettStampa[i].NomeOggetto<>nome) do i:=i+1;
  if VettStampa[i].NomeOggetto=nome then
     result:=i
  else
     result:=0;
end;

function TC001FLayoutStampa.FindListaOggetti(nome:string):integer;
var i:integer;
begin
  i:=0;
  while (i<ListaOggetti.Count-1) and (TLabel(ListaOggetti.Items[i]).name<>nome) do
    i:=i+1;
  if (ListaOggetti.Count<>0) and (TLabel(ListaOggetti.Items[i]).name=nome) then
     result:=i
  else
     result:=-1;
end;

procedure TC001FLayoutStampa.EliminaOggetto(var RecStampa:Rec_Stampa);
var idx:integer;
begin
   RecStampa.Banda:=bNone;
   RecStampa.Top:=DefTop + DefHeight * 5;
   RecStampa.Left:=DefLeft;
   idx:=FindListaOggetti(RecStampa.NomeOggetto);
   if Idx>=0 then
      begin
      TLabel(ListaOggetti.Items[idx]).Free;
      ListaOggetti.Delete(idx);
      end;
end;

procedure TC001FLayoutStampa.CaricaCombo;
var i:integer;
begin
  for i:= 1 to NOggetti do
      CmbOggetti.Items.Add(VettStampa[i].NomeOggetto);
  if CmbOggetti.Items.Count>0 then
     CmbOggetti.ItemIndex:=0;
end;

procedure TC001FLayoutStampa.ImpostaCmbOggetti(nome:string);
var i:integer;
begin
  i:=0;
  while (i<CmbOggetti.Items.Count-1) and (CmbOggetti.Items[i]<>nome) do
    inc(i);
  if CmbOggetti.Items[i]=nome then
     CmbOggetti.ItemIndex:=i;
end;


procedure TC001FLayoutStampa.CreaListaSelezioneMultipla;
begin
  ListaMultipla:=TList.Create;
end;

procedure TC001FLayoutStampa.DistruggiListaSelezioneMultipla;
var I:Integer;
begin
  if ListaMultipla <> nil then
    begin
      for I:=ListaMultipla.Count - 1 downto 0 do
         begin
           TLabel(ListaMultipla.Items[I]).Enabled:=True;
           TLabel(ListaMultipla.Items[I]).Free;
           ListaMultipla.Delete(I);
         end;
      ListaMultipla.Free;
      ListaMultipla:=nil;
    end;
end;

procedure TC001FLayoutStampa.OggettoMouseDown(Sender: TObject; Button: TMouseButton;
                                      Shift: TShiftState;X, Y: Integer);
begin
  if (Button = mbLeft)and(Shift = [ssShift,ssLeft]) then // gestione selezioni multiple
    begin
      MuoviOggetto:=False;
      Selezione:=True;
      Inc(NumSelezionati);
      if NumSelezionati = 1 then
        begin
          CreaListaSelezioneMultipla;
        end;
      ListaMultipla.Add(TLabel(Sender));
      TLabel(Sender).Enabled:=False;
    end
  else
    begin
      Selezione:=False;
      NumSelezionati:=0;
      DistruggiListaSelezioneMultipla;
      ImpostaCmbOggetti(TLabel(Sender).name);
      if Button <> mbLeft then exit;
      StartX:=x;
      StartY:=y;
      SelColore:=clGray;
      LastFontColor:=TLabel(Sender).Font.Color;
      TLabel(Sender).Font.Color:=SelColore;
    //  ImpostaCmbOggetti(TLabel(Sender).name);
      LTop.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
      LLeft.Caption:='X:' + IntToStr(TLabel(Sender).Left);
      TLabel(Sender).OnMouseMove:=OggettoMouseMove;
      MuoviOggetto:=True;
    end;
end;

procedure TC001FLayoutStampa.OggettoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if not(ssLeft in Shift) then exit;
  if not MuoviOggetto then exit;
  TLabel(Sender).Left:= TLabel(Sender).Left + ((x - StartX)div DefWidth)*DefWidth ;
  TLabel(Sender).Top:=  TLabel(Sender).Top + ((y - StartY)div DefWidth)*DefWidth ;
  LTop.Caption:='Y:' + IntToStr(TLabel(Sender).Top);
  LLeft.Caption:='X:' + IntToStr(TLabel(Sender).Left);
end;

procedure TC001FLayoutStampa.OggettoMouseUp(Sender: TObject; Button: TMouseButton;
                                    Shift: TShiftState; X, Y: Integer);
var idx:integer;
begin
  if (Button <> mbLeft)or(Selezione) then exit;
  MuoviOggetto:=False;
  TLabel(Sender).OnMouseMove:=nil;
  Idx:=PosizioneOggetto(CmbOggetti.text);
  TLabel(Sender).Left:=TLabel(Sender).Left+ ((x - StartX)div DefWidth)*DefWidth;
  TLabel(Sender).Top:=TLabel(Sender).Top+ ((y - StartY)div DefWidth)*DefWidth;
  VettStampa[Idx].Left:=TLabel(Sender).Left;
  VettStampa[Idx].Top:=TLabel(Sender).Top;
  case Modalita of
    Scheda:begin
             VettStampa[Idx].SchedaX:=VettStampa[Idx].Left;
             VettStampa[Idx].SchedaY:=VettStampa[Idx].Top;
           end;
    Elenco:begin
             VettStampa[Idx].ElencoX:=VettStampa[Idx].Left;
             VettStampa[Idx].ElencoY:=VettStampa[Idx].Top;
           end;
  end;
  TLabel(Sender).Font.Color:=LastFontColor;
  SelColore:=clBlack;
end;

procedure TC001FLayoutStampa.BtnAddClick(Sender: TObject);
var idx:integer;
begin
  Idx:=PosizioneOggetto(CmbOggetti.text);
  if Idx>0 then
     if (VettStampa[Idx].banda=bNone) then
       begin
         //ho le pagine separate
         if PagAttiva = bNone then
           begin
           if PgCtrlStampa.ActivePage=TabDettaglio then
              VettStampa[Idx].banda:=bDettaglio;
           if PgCtrlStampa.ActivePage=TabIntestazione then
              VettStampa[Idx].banda:=bIntestazione;
           end
         else
           //ho una pagina sola
           VettStampa[Idx].banda:=PagAttiva;
           case Modalita of
             Elenco:begin
                      VettStampa[Idx].ElencoBanda:=PagAttiva;
                      VettStampa[Idx].ElencoX:=VettStampa[Idx].Left;
                      VettStampa[Idx].ElencoY:=VettStampa[Idx].Top;
                    end;
             Scheda:begin
                      VettStampa[Idx].SchedaBanda:=PagAttiva;
                      VettStampa[Idx].SchedaX:=VettStampa[Idx].Left;
                      VettStampa[Idx].SchedaY:=VettStampa[Idx].Top;
                    end;
           end;
         AggiungiOggetto(VettStampa[Idx]);
       end;
end;

procedure TC001FLayoutStampa.BtnDelClick(Sender: TObject);
var idx:integer;
begin
  Idx:=PosizioneOggetto(CmbOggetti.text);
  if Idx>0 then
     if (VettStampa[Idx].banda<>bNone) then
        EliminaOggetto(VettStampa[Idx]);
  Case Modalita of
    Scheda:VettStampa[Idx].SchedaBanda:=bNone;
    Elenco:VettStampa[Idx].ElencoBanda:=bNone;
  end;
end;

procedure TC001FLayoutStampa.Font1Click(Sender: TObject);
var Idx,I:integer;
begin
  if NumSelezionati <> 0 then
    begin
      FontDlg.Font:= C001FFiltroTabelle.DefaultFont;
      if FontDlg.Execute then
        begin
          for I:=0 to ListaMultipla.Count-1 do
             begin
               TLabel(ListaMultipla.Items[I]).Font:=FontDlg.Font;
               Idx:=PosizioneOggetto(TLabel(ListaMultipla.Items[I]).Name);
               VettStampa[Idx].Font:=TLabel(ListaMultipla.Items[I]).Font
             end;
        end;
    end
  else
    begin
      Idx:=PosizioneOggetto(CmbOggetti.text);
      if VettStampa[Idx].Font<>nil then
         FontDlg.Font:= VettStampa[Idx].Font
      else
         FontDlg.Font:= C001FFiltroTabelle.DefaultFont;
      if FontDlg.Execute then
        begin
          TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]).Font:=FontDlg.Font;
          VettStampa[Idx].Font:=TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]).Font
        end;
    end;
end;

procedure TC001FLayoutStampa.Size1Click(Sender: TObject);
var Idx,I:integer;
    Oggetto:TLabel;
begin
  C001FSizeStampa:=TC001FSizeStampa.Create(nil);
  with C001FSizeStampa do
    try
    if NumSelezionati = 0 then
      Idx:=PosizioneOggetto(CmbOggetti.text)
    else
      Idx:=PosizioneOggetto(TLabel(ListaMultipla.Items[0]).Name);
    SizeLeft:=VettStampa[Idx].left;
    SizeTop:=VettStampa[Idx].top;
    SizeWidth:=VettStampa[Idx].width;
    SizeHeight:=VettStampa[Idx].height;
    if NumSelezionati <> 0 then
      GroupBox1.Enabled:=False;
    if (ShowModal=mrOk) then
      begin
        if NumSelezionati <> 0 then
          begin
            for I:=0 to ListaMultipla.Count-1 do
               begin
                 Idx:=PosizioneOggetto(TLabel(ListaMultipla.Items[I]).Name);
                 VettStampa[Idx].width:=SizeWidth;
                 VettStampa[Idx].height:=SizeHeight;
                 if VettStampa[Idx].DSource <> nil then
                   VettStampa[Idx].DSource.DataSet.FieldByName(VettStampa[Idx].DField).DisplayWidth:=SizeWidth div DefWidth;
                 Oggetto:=TLabel(ListaMultipla.Items[I]);
                 Oggetto.Width:=VettStampa[Idx].width;
                 Oggetto.Height:=VettStampa[Idx].height;
               end;
          end
        else
          begin
            VettStampa[Idx].left:=SizeLeft;
            VettStampa[Idx].top:=SizeTop;
            VettStampa[Idx].width:=SizeWidth;
            VettStampa[Idx].height:=SizeHeight;
            if VettStampa[Idx].DSource <> nil then
              VettStampa[Idx].DSource.DataSet.FieldByName(VettStampa[Idx].DField).DisplayWidth:=SizeWidth div DefWidth;
            Oggetto:=TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]);
            Oggetto.Left:=VettStampa[Idx].left;
            Oggetto.Top:=VettStampa[Idx].top;
            Oggetto.Width:=VettStampa[Idx].width;
            Oggetto.Height:=VettStampa[Idx].height;
          end;
      end;
    finally
      Free;
    end;
end;

procedure TC001FLayoutStampa.Colo1Click(Sender: TObject);
var Idx,I:Integer;
begin
  if NumSelezionati <> 0 then
    begin
      if ColorDlg.Execute then
        begin
          for I:=0 to ListaMultipla.Count-1 do
             begin
               Idx:=PosizioneOggetto(TLabel(ListaMultipla.Items[I]).Name);
               TLabel(ListaMultipla.Items[I]).Color:=ColorDlg.Color;
               VettStampa[Idx].Color:=TLabel(ListaMultipla.Items[I]).Color;
             end;
        end;
    end
  else
    begin
      Idx:=PosizioneOggetto(CmbOggetti.text);
      ColorDlg.Color:=VettStampa[Idx].Color;
      if ColorDlg.Execute then
        begin
          TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]).Color:=ColorDlg.Color;
          VettStampa[Idx].Color:=ColorDlg.Color;
        end;
    end;
end;

procedure TC001FLayoutStampa.Trasparente1Click(Sender: TObject);
var idx:integer;
begin
  Transparent1.Checked:=Not(Transparent1.Checked);
  Idx:=PosizioneOggetto(CmbOggetti.text);
  VettStampa[Idx].Trasp:=Transparent1.Checked;
//  if Not VettStampa[Idx].Trasp then
//    TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]).Color:=VettStampa[Idx].Color
//  else
//     TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]).Color:=clwhite;
  TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]).Transparent:=VettStampa[Idx].Trasp;
end;

procedure TC001FLayoutStampa.PopMenuPopup(Sender: TObject);
var idx:integer;
begin
   Idx:=PosizioneOggetto(CmbOggetti.text);
   Transparent1.checked:=VettStampa[Idx].Trasp;
end;

procedure TC001FLayoutStampa.BtnAllineaClick(Sender: TObject);
var yTop,xLeft,idx1,idx2:integer;
    Modo:integer;
    Oggetto1:TLabel;
begin
  C001FAllineaStampa:=TC001FAllineaStampa.Create(nil);
  with C001FAllineaStampa do
    try
      Idx1:=PosizioneOggetto(CmbOggetti.text);
      yTop:=VettSTampa[Idx1].Top;
      xLeft:=VettSTampa[Idx1].Left;
      Oggetto1:=TLabel(ListaOggetti.items[FindListaOggetti(CmbOggetti.text)]);
      CaricaListBox(VettStampa,NOggetti,VettStampa[Idx1]);
      if ShowModal=mrOk then
        begin
        Modo:=GetAlignType;
        Idx2:=PosizioneOggetto(GetAlignObjName);
        //Oggetto2:=TLabel(ListaOggetti.items[FindListaOggetti(GetAlignObjName)]);
        case Modo of
           aTop:begin
                yTop:=VettStampa[Idx2].Top+VettStampa[Idx2].Height;
                xLeft:=VettStampa[Idx2].Left;
                end;
           aLeft:begin
                 xLeft:=VettStampa[Idx2].Left+VettStampa[Idx2].Width;
                 yTop:=VettStampa[Idx2].Top;
                 end;
           aRight:begin
                  xLeft:=VettStampa[Idx2].Left-VettStampa[Idx1].Width;
                  yTop:=VettStampa[Idx2].Top;
                  end;
           aBottom:begin
                   yTop:=VettStampa[Idx2].Top-VettStampa[Idx1].Height;
                   xLeft:=VettStampa[Idx2].Left;
                   end;
           aTopLine:yTop:=VettStampa[Idx2].Top;
           aLeftSide:xLeft:=VettStampa[Idx2].Left;
           aRightSide:xLeft:=VettStampa[Idx2].Left+VettStampa[Idx2].Width-VettStampa[Idx1].Width;
           aBaseLine:yTop:=VettStampa[Idx2].Top+VettStampa[Idx2].Height-VettStampa[Idx1].Height;
        end;
        VettStampa[Idx1].Top:=yTop;
        VettStampa[Idx1].Left:=xLeft;
        Oggetto1.Top:=yTop;
        Oggetto1.Left:=xLeft;
        end;
      finally
        Free;
      end;
end;

procedure TC001FLayoutStampa.BtnFontsClick(Sender: TObject);
var i:integer;
begin
  FontDlg.Font.Assign(C001FFiltroTabelle.DefaultFont);
  if FontDlg.Execute then
    begin
      for i:=1 to NOggetti do
        begin
        VettStampa[i].Font.Assign(FontDlg.Font);
        if VettStampa[i].Banda <> bNone then
          TLabel(ListaOggetti.items[FindListaOggetti(VettStampa[i].NomeOggetto)]).Font:=FontDlg.Font;
        end;
      ScrBox1.Font.Assign(FontDlg.Font);
      ScrBox2.Font.Assign(FontDlg.Font);
      C001FFiltroTabelle.DefaultFont.Assign(FontDlg.Font);
    end;
end;

procedure TC001FLayoutStampa.CheckSingolaClick(Sender: TObject);
begin
  if CheckSingola.checked then
     begin
       ScrBox1.align:=alNone;
       ScrBox2.Align:=alNone;
       ScrBox2.Parent:=TabDettaglio;
       ScrBox2.Height:=150;
       ScrBox2.Align:=alTop;
       ScrBox1.align:=alClient;
       TabIntestazione.TabVisible:=false;
       TabDettaglio.Caption:='Intestazione/Dettaglio';
       PgCtrlStampa.Activepage:=TabDettaglio;
       PagAttiva:=bDettaglio;
     end
  else
     begin
       ScrBox2.Parent:=TabIntestazione;
       ScrBox1.Align:=alClient;
       ScrBox2.Align:=alClient;
       TabIntestazione.TabVisible:=true;
       TabDettaglio.Caption:='Dettaglio';
       PagAttiva:=bNone;
     end
end;

procedure TC001FLayoutStampa.ScrBox1Enter(Sender: TObject);
{Setto la scrollbox attiva se ho una sola pagina}
begin
  if PagAttiva = bNone then exit;
  if Sender = ScrBox1 then
    PagAttiva:=bDettaglio
  else
    PagAttiva:=bIntestazione;
end;

procedure TC001FLayoutStampa.BitBtn3Click(Sender: TObject);
{Impostazione stampante}
begin
  PrinterSetupDialog1.Execute;
  C001SettaQuickReport(C001FStampa.QRep);
end;

procedure TC001FLayoutStampa.BitBtn4Click(Sender: TObject);
{Rigenero i componenti: utile se si cambiano le impostazioni della pagina}
var i:SmallInt;
begin
  if ScrBox1.HorzScrollBar.Visible then
    ScrBox1.HorzScrollBar.Position:=0;
  if ScrBox2.HorzScrollBar.Visible then
    ScrBox2.HorzScrollBar.Position:=0;
  if ScrBox1.VertScrollBar.Visible then
    ScrBox1.VertScrollBar.Position:=0;
  if ScrBox2.VertScrollBar.Visible then
    ScrBox2.VertScrollBar.Position:=0;
  for i:=0 to ListaOggetti.Count - 1 do
    TLabel(ListaOggetti.Items[i]).Free;
  ListaOggetti.Clear;
  C001FFiltroTabelle.VariazioneCampi:=True;//Alberto 16/06/2004
  CaricaVettoreStampa(C001FFiltroTabelleDtm.DataSource1);
  CaricaReport(Modalita);
  C001FFiltroTabelle.VariazioneCampi:=False;//Alberto 16/06/2004
end;

procedure TC001FLayoutStampa.BtnStampaClick(Sender: TObject);
begin
  TipoGruppo:=RGTipoGruppo.ItemIndex;
  AllineaScrollBox;
  with C001FStampa do
    begin
      CreaReport(VettStampa,NOggetti);
      QRep.DataSet:=C001FFiltroTabelleDtM.DataSource1.DataSet;
      QrLblTitolo.Caption:=ETitolo.Text;
      Anteprima;
    end;
end;

procedure TC001FLayoutStampa.AllineaScrollBox;
{Risolve il problema delle posizioni dei controlli che sono relative alle ScrollBar
 se questi sono visibili}
var i,Idx:Integer;
begin
  if ScrBox1.HorzScrollBar.Visible then
    ScrBox1.HorzScrollBar.Position:=0;
  if ScrBox2.HorzScrollBar.Visible then
    ScrBox2.HorzScrollBar.Position:=0;
  if ScrBox1.VertScrollBar.Visible then
    ScrBox1.VertScrollBar.Position:=0;
  if ScrBox2.VertScrollBar.Visible then
    ScrBox2.VertScrollBar.Position:=0;
  for i:=1 to NOggetti do
    if VettStampa[i].banda <> bNone then
      begin
      Idx:=FindListaOggetti(VettStampa[i].NomeOggetto);
      if Idx >= 0 then
        begin
        VettStampa[I].Left:=TLabel(ListaOggetti.Items[Idx]).Left;
        VettStampa[I].Top:=TLabel(ListaOggetti.Items[Idx]).Top;
        end;
      end;
end;

procedure TC001FLayoutStampa.FormDestroy(Sender: TObject);
var I,NumeroGroup:Integer;
begin
  // per non perdere eventuali modifiche ogni volta che rientro in questa Form
  C001FFiltroTabelle.VariazioneCampi:=False;
  SalvaOggettiStampa;
  SalvaNumBandeGruppo(NUMBANDEGRUPPO,TipoGruppo);

  if TipoGruppo = 0 then  // calcolo il numero di bande di gruppo.
    NumeroGroup:=1
  else
    begin
      NumeroGroup:=0;
      for I:=1 to NOggetti do
         begin
           if VettStampa[I].NumeroBandaGruppo > NumeroGroup then
             NumeroGroup:=VettStampa[I].NumeroBandaGruppo;
         end;
    end;
  SalvaFontBandeGruppo(FONTBGRUPPO,NumeroGroup);
  SalvaPagineSeparate(CPAGINESEP,PagineSeparate);
  for i:=0 to ListaOggetti.Count - 1 do
    TLabel(ListaOggetti.Items[i]).Free;
  ListaOggetti.Clear;
  ListaOggetti.Free;
end;

procedure TC001FLayoutStampa.ScrBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
{Gestione del Drag&Drop dei componenti sulla maschera}
var i:SmallInt;
begin
  Accept:=False;
  if Source = CmbOggetti then
    begin
    i:=PosizioneOggetto(CmbOggetti.Text);
    if i >= 0 then
      Accept:=VettStampa[i].Banda = bNone;
    end;
end;

function TC001FLayoutStampa.GotoNearestX( X: Integer ):Integer;
begin
  Result:=(X div DefWidth)* DefWidth + (DefLeft-DefWidth);
end;

function TC001FLayoutStampa.GotoNearestY( Y: Integer ):Integer;
begin
  Result:=(Y div DefHeight)* DefHeight + (DefTop-DefHeight);
end;

procedure TC001FLayoutStampa.ScrBox1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
{Gestisco il rilascio dell'oggetto sulla ScrollBox}
var i:SmallInt;
begin
  i:=PosizioneOggetto(CmbOggetti.Text);
  if Sender = ScrBox1 then
    VettStampa[i].banda:=bDettaglio
  else
    VettStampa[i].banda:=bIntestazione;
  VettStampa[i].Top:=GotoNearestY(Y);
  VettStampa[i].Left:=GotoNearestX(X);
  case Modalita of
     Elenco:begin
                VettStampa[I].ElencoX:=VettStampa[i].Left;
                VettStampa[I].ElencoY:=VettStampa[i].Top;
              end;
     Scheda:begin
                VettStampa[I].SchedaX:=VettStampa[i].Left;
                VettStampa[I].SchedaY:=VettStampa[i].Top;
              end;
  end;
  if PagAttiva = bNone then
    begin
      if PgCtrlStampa.ActivePage=TabDettaglio then
        VettStampa[I].banda:=bDettaglio;
      if PgCtrlStampa.ActivePage=TabIntestazione then
        VettStampa[I].banda:=bIntestazione;
    end
  else
    //ho una pagina sola
    VettStampa[I].banda:=PagAttiva;
  AggiungiOggetto(VettStampa[I]);
end;

procedure TC001FLayoutStampa.RGrpTipoClick(Sender: TObject);
begin
  if RGrpTipo.ItemIndex= 0 then
     Modalita:=Elenco
  else
     Modalita:=Scheda;
  CaricaReport(Modalita);
  CaricaReport(Gruppo)
end;

procedure TC001FLayoutStampa.CheckSeparateClick(Sender: TObject);
begin
  PagineSeparate:=CheckSeparate.Checked;
end;

procedure TC001FLayoutStampa.CheckSpaziaturaClick(Sender: TObject);
begin
  if CheckSpaziatura.Checked then
    begin
      C001FStampa.QRBSpaziatura.Enabled:=True;
      CkBLineaRec.Enabled:=True;
    end
  else
    begin
      C001FStampa.QRBSpaziatura.Enabled:=False;
      CkBLineaRec.Checked:=False;
      CkBLineaRec.Enabled:=False;
    end;
  InterLineaAbilitata:=CheckSpaziatura.Checked;
end;

procedure TC001FLayoutStampa.SpSpaziaturaChange(Sender: TObject);
begin
  C001FStampa.QRBSpaziatura.Height:=SpSpaziatura.Value;
  AltezzaInterLinea:=SpSpaziatura.Value;
end;

procedure TC001FLayoutStampa.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TC001FLayoutStampa.ETitoloChange(Sender: TObject);
begin
  TitoloStampa:=ETitolo.Text;
end;

procedure TC001FLayoutStampa.ScrBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Shift = [ssLeft])and(Button = mbLeft) then
    begin
      NumSelezionati:=0;
      DistruggiListaSelezioneMultipla;
    end;
end;

procedure TC001FLayoutStampa.ScrBox2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Shift = [ssLeft])and(Button = mbLeft) then
    begin
      NumSelezionati:=0;
      DistruggiListaSelezioneMultipla;
    end;
end;

procedure TC001FLayoutStampa.RGTipoGruppoClick(Sender: TObject);
begin
  TipoGruppo:=RGTipoGruppo.ItemIndex;
  GeneraGruppoDefault(True);
  GeneraElencoDefault;
  GeneraSchedaDefault;
  CaricaReport(Modalita);
  CaricaReport(Gruppo);
end;

procedure TC001FLayoutStampa.CkBLineaRecClick(Sender: TObject);
begin
  LineaRec.Enabled:=CkBLineaRec.Checked;
  SpeedButton1.Enabled:=CkBLineaRec.Checked;
end;

procedure TC001FLayoutStampa.CkBLineaSupClick(Sender: TObject);
begin
  LineaSup.Enabled:=CkBLineaSup.Checked;
  SpeedButton2.Enabled:=CkBLineaSup.Checked;
end;

procedure TC001FLayoutStampa.CkBLineaInfClick(Sender: TObject);
begin
  LineaInf.Enabled:=CkBLineaInf.Checked;
  SpeedButton3.Enabled:=CkBLineaInf.Checked;
end;

procedure TC001FLayoutStampa.SpeedButton1Click(Sender: TObject);
begin
  C001FLineSettings.Altezza:=LineaRec.Altezza;
  C001FLineSettings.Tratteggio:= LineaRec.Tratteggio;
  C001FLineSettings.Allineamento:=LineaRec.Allineamento;
  C001FLineSettings.Larghezza:=LineaRec.Larghezza;
  C001FLineSettings.Caption:='Impostazione della linea separatrice dopo ogni record';
  if C001FLineSettings.ShowModal = mrOK then
    begin
      LineaRec.Tratteggio  :=C001FLineSettings.Tratteggio;
      LineaRec.Allineamento:=C001FLineSettings.Allineamento;
      LineaRec.Altezza     :=C001FLineSettings.Altezza;
      LineaRec.Larghezza   :=C001FLineSettings.Larghezza;
    end;
end;

procedure TC001FLayoutStampa.SpeedButton2Click(Sender: TObject);
begin
  C001FLineSettings.Altezza:=LineaSup.Altezza;
  C001FLineSettings.Tratteggio:= LineaSup.Tratteggio;
  C001FLineSettings.Allineamento:=LineaSup.Allineamento;
  C001FLineSettings.Larghezza:=LineaSup.Larghezza;
  C001FLineSettings.Caption:='Impostazione della linea separatrice di inizio gruppo';
  if C001FLineSettings.ShowModal = mrOK then
    begin
      LineaSup.Tratteggio  :=C001FLineSettings.Tratteggio;
      LineaSup.Allineamento:=C001FLineSettings.Allineamento;
      LineaSup.Altezza     :=C001FLineSettings.Altezza;
      LineaSup.Larghezza   :=C001FLineSettings.Larghezza;
    end;
end;

procedure TC001FLayoutStampa.SpeedButton3Click(Sender: TObject);
begin
  C001FLineSettings.Altezza:=LineaInf.Altezza;
  C001FLineSettings.Tratteggio:= LineaInf.Tratteggio;
  C001FLineSettings.Allineamento:=LineaInf.Allineamento;
  C001FLineSettings.Larghezza:=LineaInf.Larghezza;
  C001FLineSettings.Caption:='Impostazione della linea separatrice di fine gruppo';
  if C001FLineSettings.ShowModal = mrOK then
    begin
      LineaInf.Tratteggio  :=C001FLineSettings.Tratteggio;
      LineaInf.Allineamento:=C001FLineSettings.Allineamento;
      LineaInf.Altezza     :=C001FLineSettings.Altezza;
      LineaInf.Larghezza   :=C001FLineSettings.Larghezza;
    end;
end;

procedure TC001FLayoutStampa.SpeedButton4Click(Sender: TObject);
var I:Integer;
begin
  C001FGroupSelection.Inizializza;
  if C001FGroupSelection.ShowModal = mrOk then
    begin
      for I:=1 to NOggetti do
         EliminaOggetto(VettStampa[I]);
      NOggetti:=0;
      RiassegnaBandeGruppo:=False;
      FormShow(Self); // rigenero l' elenco,la scheda e carico il report.
    end;
end;


end.
