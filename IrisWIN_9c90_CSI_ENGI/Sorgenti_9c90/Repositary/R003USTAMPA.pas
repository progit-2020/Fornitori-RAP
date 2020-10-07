unit R003UStampa;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R002UQREP, Qrctrls, quickrpt, ExtCtrls, C180FunzioniGenerali, StdCtrls,
  R003USerbatoi, QRExport, C001StampaLib, Variants, QRWebFilt, QRPDFFilt,
  Printers, A000UInterfaccia, Oracle, OracleData;

type
  TRecIdLog = record
    Evento,Elemento:String;
    ID:Integer;
  end;

  TIdLog = class
    Log:array of TRecIdLog;
    ID:Integer;
    function GetID(Evento,Elemento:String):Integer;
    procedure Resetta;
  end;

  TR003FStampa = class(TR002FQRep)
    BColonne: TQRBand;
    BRigaTabella: TQRBand;          
    BSommario: TQRBand;
    BIntestazione: TQRGroup;
    BTotali: TQRBand;
    BGruppoProg: TQRGroup;
    BDettaglio: TQRBand;
    BIntestazioneColonne: TQRChildBand;
    BPaginaIntestazione: TQRChildBand;
    procedure QRepApplyPrinterSettings(Sender: TObject; var Cancel: Boolean;
      DevMode: Pointer);
    procedure FormDestroy(Sender: TObject);
    procedure BIntestazioneBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BSommarioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BTotaliBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BRigaTabellaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure BGruppoProgBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure BColonneBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BandaAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure BIntestazioneAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure TitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure BColonneAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
  private
    { Private declarations }
    NumOrdine,NumeroDati,MaxDati:Integer;
    PageHeight,SpazioDisponibile:Extended;
    CoordinateSpostate:array of TPoint;
    BandaInStampa,FooterStampato:String;
    BSommarioChild: TQRBand;
    IdLog:TIdLog;
    DatiLog:String;
    CorrezFileExport:Integer;
    QRepTextHeight:Boolean;
    function FormattaOra(S,F:String):String;
    procedure DistruggiComponenti(Sender:TQRCustomBand);
    function GetHeight(Sender:TQRCustomBand):Integer;
    procedure OrdinaLista(L:TList);
    procedure SpostaComponenti(Sender:TQRCustomBand; Componente:TQRLabel; H,OS:Integer);
    procedure QuickSort(L:TList; iLo,iHi:Integer);
    procedure OttimizzaSpazio(Sender:TQRCustomBand);
    procedure CreaQRShape(Sender:TQRCustomBand; P:Integer);
    procedure SeparaColonne(Sender:TQRCustomBand);
    function AncoraDaSpostare(x,y:Integer):Boolean;
    procedure ChildBandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ChildBandAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure BDettaglioSpaccato(Sender: TQRCustomBand; PrintBand: Boolean);
    procedure BTotaliSpaccato(Sender: TQRCustomBand);
    procedure BSommarioSpaccato(Sender: TQRCustomBand);
    procedure InizializzaBandaSpaccata(Sender: TQRCustomBand);
    procedure GetSpazioDisponibile;
    procedure BSommarioChildBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure BTotaliChildBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure ScriviLog(Evento,Elemento:String; PrintBand:Boolean);
    procedure AddBandaTestoAggiuntivo(Sender: TQRCustomBand; Testo:String);
  protected
    function GetVariazioneFormato(S,Dato,Lista:String; PosVal:Integer):String;
    function NumeroLinee(S:String):Integer;
  public
    { Public declarations }
    procedure CreazioneReport;
  end;

var
  R003FStampa: TR003FStampa;

implementation

uses R003UGeneratoreStampeDtM,R003UGeneratoreStampeMW, R003UGeneratoreStampe;

{$R *.DFM}

procedure TIdLog.Resetta;
begin
  SetLength(Log,0);
  ID:=-1;
end;

function TIdLog.GetID(Evento,Elemento:String):Integer;
var i,p:Integer;
begin
  Result:=-1;
  p:=-1;
  for i:=0 to High(Log) do
    if (Log[i].Evento = Evento) and (Log[i].Elemento = Elemento) then
    begin
      p:=i;
      Break;
    end;
  if p = -1 then
  begin
    SetLength(Log,Length(Log) + 1);
    p:=High(Log);
    Log[p].Evento:=Evento;
    Log[p].Elemento:=Elemento;
    Log[p].ID:=-1;
  end;
  inc(ID);
  inc(Log[p].ID);
  Result:=Log[p].ID;
end;

procedure TR003FStampa.FormCreate(Sender: TObject);
begin
  inherited;
  // parametri di configurazione applicativi web su file.ini
  // nel caso di richiamo da COM il parametro use standard printer è impostato a true, diversamente a false
  {
  if (R003FGeneratoreStampe.TipoModulo = 'COM') and (Pos('USE_STANDARD_PRINTER',UpperCase(R180GetRegistro(HKEY_LOCAL_MACHINE,'W001','PARAMETRI_AVANZATI',''))) > 0) then
    QRep.PrinterSettings.UseStandardprinter:=True;
  }
  QRep.PrinterSettings.UseStandardprinter:=R003FGeneratoreStampe.ComObj_UseStandardPrinter;
  // parametri di configurazione applicativi web su file.fine

  R003FStampa:=Self;
  BSommarioChild:=TQRBand.Create(Self);
  BSommarioChild.BeforePrint:=BSommarioChildBeforePrint;
  IdLog:=TIdLog.Create;
  CorrezFileExport:=0;//StrToIntDef(R180GetRegistro(HKEY_CURRENT_USER,'R003','CorrezFileExport','0'),0);
  QRepTextHeight:=True;//R180GetRegistro(HKEY_CURRENT_USER,'R003','QRepTextHeight','N') = 'S';
end;

procedure TR003FStampa.CreazioneReport;
var i,P:Integer;
    L:TQRLabel;
    QRCB:TQRChildBand;
    procedure CreaTotali(i,P:Integer; Sender:TScrollBox);
    var TC:Integer;
    begin
      //Totali parziali
      L:=TQRLabel(BTotali.AddPrintable(TQRLabel));
      L.AutoSize:=False;
      L.WordWrap:=False;
      L.Top:=TLabel(Sender.Components[i]).Top;
      L.Left:=TLabel(Sender.Components[i]).Left;
      L.Height:=TLabel(Sender.Components[i]).Height;
      L.Width:=TLabel(Sender.Components[i]).Width;
      L.Tag:=0;
      L.Hint:=TLabel(Sender.Components[i]).Caption;
      if (BColonne.Enabled) and not(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].F in [0,4]) then
        L.Alignment:=taRightJustify;
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QT:=L;
      if R003FGeneratoreStampe.DBCheckBox3.Checked then
        CreaQRShape(BTotali,L.Left + L.Width);
      //Totali generali
      L:=TQRLabel(BSommario.AddPrintable(TQRLabel));
      L.AutoSize:=False;
      L.WordWrap:=False;
      L.Top:=TLabel(Sender.Components[i]).Top;
      L.Left:=TLabel(Sender.Components[i]).Left;
      L.Height:=TLabel(Sender.Components[i]).Height;
      L.Width:=TLabel(Sender.Components[i]).Width;
      L.Tag:=0;
      L.Hint:=TLabel(Sender.Components[i]).Caption;
      if (BColonne.Enabled) and not(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].F in [0,4]) then
        L.Alignment:=taRightJustify;
      if R003FGeneratoreStampe.DBCheckBox3.Checked then
        CreaQRShape(BSommario,L.Left + L.Width);
      with R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW do
      begin
        DatiStampa[P].QS:=L;
        for TC:=0 to High(TabelleCollegate) do
          if (TabelleCollegate[TC].M = Dati[DatiStampa[P].N].M) then
          begin
            TabelleCollegate[TC].Totalizzato:=True;
            Break;
          end;
      end;
    end;
begin
  DistruggiComponenti(BColonne);
  DistruggiComponenti(BIntestazioneColonne);
  DistruggiComponenti(BPaginaIntestazione);
  DistruggiComponenti(BIntestazione);
  DistruggiComponenti(BDettaglio);
  DistruggiComponenti(BTotali);
  DistruggiComponenti(BSommario);
  DistruggiComponenti(BSommarioChild);
  InizializzaBandaSpaccata(BDettaglio);
  InizializzaBandaSpaccata(BTotali);
  InizializzaBandaSpaccata(BSommario);
  if Titolo.ChildBand <> BPaginaIntestazione then
  begin
    QRCB:=Titolo.ChildBand;
    BPaginaIntestazione.ParentBand:=Titolo;
    FreeAndNil(QRCB);
  end;
  QRep.Font.Assign(R003FGeneratoreStampe.Intestazione.Font);
  BIntestazione.Font.Name:=QRep.Font.Name;
  BIntestazione.Font.Size:=QRep.Font.Size;
  BDettaglio.Font.Name:=QRep.Font.Name;
  BDettaglio.Font.Size:=QRep.Font.Size;
  BColonne.Font.Name:=QRep.Font.Name;
  BColonne.Font.Size:=QRep.Font.Size;
  BTotali.Font.Name:=QRep.Font.Name;
  BTotali.Font.Size:=QRep.Font.Size;
  BSommario.Font.Name:=QRep.Font.Name;
  BSommario.Font.Size:=QRep.Font.Size;
  BSommarioChild.Font.Name:=QRep.Font.Name;
  BSommarioChild.Font.Size:=QRep.Font.Size;
  BColonne.Enabled:=R003FGeneratoreStampe.DBRadioGroup1.ItemIndex = 0;
  BColonne.Height:=0;
  BIntestazione.Height:=0;
  BGruppoProg.Height:=0;
  BRigaTabella.Height:=0;
  BDettaglio.Height:=0;
  BTotali.Height:=0;
  BSommario.Height:=0;
  BSommarioChild.Height:=0;
  for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate) do
    R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.TabelleCollegate[i].Totalizzato:=False;
  with R003FGeneratoreStampe do
  begin
    for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa) do
    begin
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[i].QI:=nil;
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[i].QD:=nil;
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[i].QT:=nil;
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[i].QS:=nil;
    end;
    for i:=0 to Intestazione.ComponentCount - 1 do
    begin
      P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.EsisteDatoStampa(Identificatore(TLabel(Intestazione.Components[i]).Hint));
      L:=TQRLabel(BIntestazione.AddPrintable(TQRLabel));
      L.AutoSize:=False;
      L.WordWrap:=False;
      L.Top:=TLabel(Intestazione.Components[i]).Top;
      L.Left:=TLabel(Intestazione.Components[i]).Left;
      L.Height:=TLabel(Intestazione.Components[i]).Height;
      L.Width:=TLabel(Intestazione.Components[i]).Width;
      L.Tag:=TLabel(Intestazione.Components[i]).Tag;
      L.Hint:=TLabel(Intestazione.Components[i]).Caption;
      L.Name:=Identificatore(TLabel(Intestazione.Components[i]).Hint);
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QI:=L;
      if L.Tag = 0 then
        CreaTotali(i,P,Intestazione);
    end;
    for i:=0 to Dettaglio.ComponentCount - 1 do
    begin
      P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.EsisteDatoStampa(Identificatore(TLabel(Dettaglio.Components[i]).Hint));
      if BColonne.Enabled then
      begin
        L:=TQRLabel(BColonne.AddPrintable(TQRLabel));
        L.AutoSize:=False;
        L.WordWrap:=False;
        if (R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].F in [1,2]) and (BColonne.Enabled) then
          L.Alignment:=taRightJustify;
        L.Top:=TLabel(Dettaglio.Components[i]).Top;
        L.Left:=TLabel(Dettaglio.Components[i]).Left;
        L.Height:=TLabel(Dettaglio.Components[i]).Height;
        L.Width:=TLabel(Dettaglio.Components[i]).Width;
        L.Caption:=TLabel(Dettaglio.Components[i]).Caption;
        L.Hint:=L.Caption;
        if DBCheckBox3.Checked then
          CreaQRShape(BColonne,L.Left + L.Width);
      end;
      L:=TQRLabel(BDettaglio.AddPrintable(TQRLabel));
      L.AutoSize:=False;
      L.WordWrap:=False;
      L.Top:=TLabel(Dettaglio.Components[i]).Top;
      L.Left:=TLabel(Dettaglio.Components[i]).Left;
      L.Height:=TLabel(Dettaglio.Components[i]).Height;
      L.Width:=TLabel(Dettaglio.Components[i]).Width;
      L.Tag:=TLabel(Dettaglio.Components[i]).Tag;
      if (R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].F in [1,2]) and (BColonne.Enabled) then
        L.Alignment:=taRightJustify;
      L.Hint:=TLabel(Dettaglio.Components[i]).Caption;
      L.Name:=Identificatore(TLabel(Dettaglio.Components[i]).Hint);
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD:=L;
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].Lbl:=TLabel(Dettaglio.Components[i]);
      R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].Lbl.Canvas.Font.Assign(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].Lbl.Font);
      if L.Tag = 0 then
        CreaTotali(i,P,Dettaglio);
      if DBCheckBox3.Checked then
        CreaQRShape(BDettaglio,L.Left + L.Width);
    end;
    BIntestazione.Expression:='';
    for i:=0 to High(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento) do
      if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[i].Rottura then
      begin
        if BIntestazione.Expression <> '' then
          BIntestazione.Expression:=BIntestazione.Expression + ' + ';
        //Gestione dei dati numerici: devono essere convertiti in stringa con STR(x)
        if (Identificatore(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[i].Nome) = 'PROGRESSIVO') or (Identificatore(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[i].Nome) = 'T430BADGE') then
          BIntestazione.Expression:=BIntestazione.Expression + 'STR(cds920.' + Identificatore(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[i].Nome) + ')'
        else
          BIntestazione.Expression:=BIntestazione.Expression + 'cds920.' + Identificatore(R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.Ordinamento[i].Nome);
      end;
    //Gestione Interna del dato MISURAASSENZE (non specificato dall'utente)
    //Creo il componente TQRLabel che verrà usato nel DettaglioBeforePrint
    P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.EsisteDatoStampa('MISURAASSENZE');
    if P >= 0 then
      if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD = nil then
      begin
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD:=TQRLabel(BDettaglio.AddPrintable(TQRLabel));
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD.Enabled:=False;
      end;
    //Gestione Interna del dato CODICEASSENZE (non specificato dall'utente)
    //Creo il componente TQRLabel che verrà usato nel DettaglioBeforePrint
    P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.EsisteDatoStampa('CODICEASSENZE');
    if P >= 0 then
      if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD = nil then
      begin
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD:=TQRLabel(BDettaglio.AddPrintable(TQRLabel));
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD.Enabled:=False;
      end;
    //Gestione Interna del dato DATACONTEGGIO (non specificato dall'utente)
    //Creo il componente TQRLabel che verrà usato nel DettaglioBeforePrint
    P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.EsisteDatoStampa('DATACONTEGGIO');
    if P >= 0 then
      if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD = nil then
      begin
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD:=TQRLabel(BDettaglio.AddPrintable(TQRLabel));
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD.Enabled:=False;
      end;
    //Gestione Interna del dato VP_MISURA (non specificato dall'utente)                                x
    //Creo il componente TQRLabel che verrà usato nel DettaglioBeforePrint
    P:=R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.EsisteDatoStampa('VP_MISURA');
    if P >= 0 then
      if R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD = nil then
      begin
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD:=TQRLabel(BDettaglio.AddPrintable(TQRLabel));
        R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.DatiStampa[P].QD.Enabled:=False;
      end;
  end;
  BDettaglio.Frame.DrawBottom:=R003FGeneratoreStampe.DBCheckBox2.Checked;
  BTotali.Frame.DrawTop:=not R003FGeneratoreStampe.DBCheckBox1.Checked;
  BIntestazione.ForceNewPage:=R003FGeneratoreStampe.DBCheckBox4.Checked;
  BIntestazione.Enabled:=BIntestazione.Expression <> '';
  BPaginaIntestazione.Enabled:=False;
  if R003FGeneratoreStampe.TestoIntestazione <> '' then
    AddBandaTestoAggiuntivo(Titolo,R003FGeneratoreStampe.TestoIntestazione);
  BIntestazioneColonne.Enabled:=False;
  //BTotali.Enabled:=(BTotali.ControlCount > 0) and BIntestazione.Enabled and R003FGeneratoreStampe.dchkTotParziali.Checked;
  //BSommario.Enabled:=(BSommario.ControlCount > 0) and R003FGeneratoreStampe.dchkTotRiepilogo.Checked;
  BSommario.Enabled:=(BSommario.ControlCount > 0) and (R003FGeneratoreStampe.dchkTotRiepilogo.Checked or R003FGeneratoreStampe.dchkTotGenerali.Checked);
  BSommarioChild.Enabled:=BSommario.Enabled;
  if R003FGeneratoreStampe.TestoFineStampa <> '' then
    BSommario.Enabled:=True;
  BIntestazione.Tag:=GetHeight(BIntestazione);
  BColonne.Tag:=GetHeight(BColonne);
  BDettaglio.Tag:=GetHeight(BDettaglio);
  if (BTotali.ControlCount > 0) and BIntestazione.Enabled and R003FGeneratoreStampe.dchkTotParziali.Checked then
    BTotali.Tag:=GetHeight(BTotali)
  else
    BTotali.Tag:=0;
  BSommario.Tag:=GetHeight(BSommario);
  BSommarioChild.Tag:=GetHeight(BSommarioChild);
  BIntestazione.Height:=BIntestazione.Tag;
  BColonne.Height:=BColonne.Tag;
  BDettaglio.Height:=BDettaglio.Tag;
  BTotali.Height:=BTotali.Tag;
  BSommario.Height:=BSommario.Tag;
  BSommarioChild.Height:=BSommarioChild.Tag;
  //In base al valore del check "dChkIntestazioneCol" abilito la banda figlia di BIntestazione,
  //cioè BIntestazioneColonne
  if R003FGeneratoreStampe.dChkIntestazioneCol.Checked then
  begin
    begin
      //BColonne.Enabled:=False;
      BIntestazioneColonne.Enabled:=True;
      BIntestazioneColonne.Font.Assign(BColonne.Font);
      BIntestazioneColonne.Tag:=BColonne.Tag;
      BIntestazioneColonne.Height:=BColonne.Height;
      for P:=BColonne.ControlCount - 1 downto 0 do
        BColonne.Controls[P].Parent:=BIntestazioneColonne;
    end;
  end;
end;

function TR003FStampa.GetHeight(Sender:TQRCustomBand):Integer;
var i:Integer;
begin
  Result:=0;
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if not(Sender.Controls[i] is TQRLabel) then Continue;
    if Result < (TQRLabel(Sender.Controls[i]).Top + TQRLabel(Sender.Controls[i]).Height) then
      Result:=TQRLabel(Sender.Controls[i]).Top + TQRLabel(Sender.Controls[i]).Height + 1;
  end;
end;

procedure TR003FStampa.CreaQRShape(Sender:TQRCustomBand; P:Integer);
var S:TQRShape;
begin
  S:=TQRShape(Sender.AddPrintable(TQRShape));
  S.Shape:=qrsVertLine;
  S.Left:=P + 1;
  S.Top:=0;
  S.Width:=1;
  S.Height:=0;
end;

procedure TR003FStampa.QRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  inherited;
  NumOrdine:=0;
  FooterStampato:='S';
  R003FGeneratoreStampeDtM.R003FGeneratoreStampeMW.InizializzaTotali(1);
  IdLog.Resetta;
end;

procedure TR003FStampa.BColonneBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if Sender = BColonne then
    PrintBand:=not BIntestazioneColonne.Enabled;
  if PrintBand then
    SeparaColonne(Sender);
end;

procedure TR003FStampa.BColonneAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
var P:Integer;
begin
  inherited;
  if BPaginaIntestazione.Enabled then
  begin
    for P:=BPaginaIntestazione.ControlCount - 1 downto 0 do
      BPaginaIntestazione.Controls[P].Parent:=BIntestazione;
    BIntestazione.Height:=BIntestazione.Tag;
    BPaginaIntestazione.Enabled:=False;
    for P:=BColonne.ControlCount - 1 downto 0 do
      BColonne.Controls[P].Parent:=BIntestazioneColonne;
    //BColonne.Enabled:=False;
    BIntestazioneColonne.Enabled:=True;
  end;
end;

procedure TR003FStampa.SeparaColonne(Sender:TQRCustomBand);
var i:Integer;
begin
  for i:=0 to Sender.ControlCount - 1 do
    if (Sender.Controls[i] is TQRShape) then
      (Sender.Controls[i] as TQRShape).Height:=Sender.Height;
end;

procedure TR003FStampa.BIntestazioneBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
    S:String;
begin
  R003FGeneratoreStampedtm.R003FGeneratoreStampeMW.InizializzaTotali(0);
  NumOrdine:=0;
  with R003FGeneratoreStampedtm.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
    begin
      if DatiStampa[i].QI = nil then Continue;
      case DatiStampa[i].F of
        0,4:S:=QRep.DataSet.FieldByName(DatiStampa[i].D).AsString;
        1:S:=R180FormattaNumero(QRep.DataSet.FieldByName(DatiStampa[i].D).AsString,Dati[DatiStampa[i].N].Fmt);
        2:S:=FormattaOra(R180MinutiOre(QRep.DataSet.FieldByName(DatiStampa[i].D).AsInteger),Dati[DatiStampa[i].N].Fmt);
        3:if (QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime = 0) or
             (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
            S:=''
          else if Dati[DatiStampa[i].N].Fmt <> '' then
            S:=FormatDateTime(Dati[DatiStampa[i].N].Fmt,QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime)
          else
            S:=FormatDateTime('dd/mm/yyyy',QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime);
      end;
      //if (DatiRiep[DatiStampa[i].N].R <> 1) and (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
      if (Dati[DatiStampa[i].N].R <> 1) and (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
        S:=R003FGeneratoreStampe.ValoreNullo;
      if Trim(DatiStampa[i].QI.Hint) <> '' then
        DatiStampa[i].QI.Caption:=DatiStampa[i].QI.Hint(* + ':'*) + S
      else
        DatiStampa[i].QI.Caption:=S;
    end;
  end;
end;

procedure TR003FStampa.BIntestazioneAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  FooterStampato:='N';
end;

procedure TR003FStampa.BGruppoProgBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  PrintBand:=False;
  R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.InizializzaVariabili(True);
end;

procedure TR003FStampa.BRigaTabellaBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i,j:Integer;
    V,DatiK,KeyTot:String;
    Valido:Boolean;
  procedure CumulaValori;
  var F,P:Integer;
      S:String;
  begin
    F:=R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.DatiStampa[i].F;
    P:=Pos('<NC>',DatiK);
    if P > 0 then
    begin
      S:=Copy(DatiK,P + 4,Length(DatiK));
      if Pos('<NC>',S) > 0 then
        with TStringList.Create do
        try
          CommaText:=Copy(S,1,Length(S) - 5);
          if IndexOf(IntToStr(i)) >= 0 then
            F:=0;
        finally
          Free;
        end;
    end;
    with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
    begin
      //Alberto 15/03/2007: gestione dei dati annuali che non devono cumularsi sui periodi storici dello stesso dipendente
      if PeriodiStorici and
         (F in [1,2]) and
         (QRep.DataSet.FieldByName('PROGRESSIVO').AsInteger = R003FGeneratoreStampeDtM.cds920ProgressivoPrec) and
         ((UpperCase(DatiStampa[i].D) = 'SALDOANNOPRECEDENTE') or (UpperCase(DatiStampa[i].D) = 'SALDOANNOTOTALE')) then
        F:=0;
      if F = DatiStampa[i].F then
        R003FGeneratoreStampeDtM.PutValore(i,DatiStampa[i].V,V,DatiK,KeyTot,DatiStampa[i].F,not QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull)
      else
      begin
        if QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull then
          V:='0';
        R003FGeneratoreStampeDtM.PutValore(i,DatiStampa[i].V,V,DatiK,KeyTot,F,True);
      end;
    end;
  end;
begin
  PrintBand:=False;
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
    for i:=0 to High(DatiStampa) do
    begin
      Valido:=True;
      DatiK:='';
      KeyTot:='';
      if DatiStampa[i].TC >= 0 then
      begin
        if TabelleCollegate[DatiStampa[i].TC].NomeKey <> '' then
          DatiK:=QRep.DataSet.FieldByName(TabelleCollegate[DatiStampa[i].TC].NomeKey).AsString;
        if TabelleCollegate[DatiStampa[i].TC].KeyTotale <> '' then
          KeyTot:=QRep.DataSet.FieldByName(TabelleCollegate[DatiStampa[i].TC].KeyTotale).AsString;
        if QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull then
        begin
          Valido:=False;
          for j:=0 to High(DatiStampa) do
            if (j <> i) and (DatiStampa[j].TC = DatiStampa[i].TC) and (not QRep.DataSet.FieldByName(DatiStampa[j].D).IsNull) then
            begin
              Valido:=True;
              Continue;
            end;
        end;
      end;
      case DatiStampa[i].F of
        0,1,2,4:V:=QRep.DataSet.FieldByName(DatiStampa[i].D).AsString;
        3:if (QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime = 0) or
             (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
            V:=''
          else if Dati[DatiStampa[i].N].Fmt <> '' then
            V:=FormatDateTime(Dati[DatiStampa[i].N].Fmt,QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime)
          else
            V:=FormatDateTime('dd/mm/yyyy',QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime);
      end;
      if DatiStampa[i].V = nil then
        DatiStampa[i].V:=TList.Create;
      if DatiStampa[i].VP = nil then
        DatiStampa[i].VP:=TList.Create;
      if DatiStampa[i].VT = nil then
        DatiStampa[i].VT:=TList.Create;
      if Valido then
        CumulaValori;
    end;
end;

function TR003FStampa.AncoraDaSpostare(x,y:Integer):Boolean;
var i:Integer;
begin
  Result:=True;
  for i:=0 to High(CoordinateSpostate) do
    if (x = CoordinateSpostate[i].x) and (y = CoordinateSpostate[i].y) then
    begin
      Result:=False;
      Break;
    end;
end;

procedure TR003FStampa.GetSpazioDisponibile;
begin
  PageHeight:=QRep.Page.Length - QRep.Page.TopMargin - QRep.Page.BottomMargin;
  SpazioDisponibile:=QRep.Page.Length - QRep.Page.BottomMargin - QRep.CurrentY;
  //Il before print delle child band su una nuova pagina non riconosce ancora
  //le bande di titolo,colonne e intestazioni, quindi devo considerarle esplicitamente
  if SpazioDisponibile <= 0 then
  begin
    SpazioDisponibile:=PageHeight - Titolo.Size.Height - BColonne.Size.Height;
    if BPaginaIntestazione.Enabled then
      SpazioDisponibile:=SpazioDisponibile - BPaginaIntestazione.Size.Height;
    if BIntestazione.Enabled then
      SpazioDisponibile:=SpazioDisponibile - BIntestazione.Size.Height;
    if BIntestazioneColonne.Enabled then
      SpazioDisponibile:=SpazioDisponibile - BIntestazioneColonne.Size.Height;
  end;
end;

procedure TR003FStampa.ChildBandBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
begin
  ScriviLog('ChildBandBeforePrint',Sender.Name,PrintBand);
  //Sposto i componenti dalla banda madre su quella corrente
  Sender.Font.Assign(TQRChildBand(Sender).ParentBand.Font);
  for i:=TQRChildBand(Sender).ParentBand.ControlCount - 1 downto 0 do
    TQRChildBand(Sender).ParentBand.Controls[i].Parent:=Sender;
  if BandaInStampa = 'BDETTAGLIO' then
    BDettaglioSpaccato(Sender,True)
  else if BandaInStampa = 'BTOTALI' then
    BTotaliSpaccato(Sender)
  else if BandaInStampa = 'BSOMMARIO' then
    BSommarioSpaccato(Sender);
end;

procedure TR003FStampa.ChildBandAfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
{Se non ho più child, scorro all'indietro le ChildBand fino alla banda madre
 e sposto i componenti dall'ultima ChildBand alla banda madre}
var i:Integer;
    QRB:TQRCustomBand;
begin
  QRB:=Sender;
  if not QRB.HasChild then
  begin
    while (QRB is TQRChildBand) do
      QRB:=TQRChildBand(QRB).ParentBand;
    for i:=Sender.ControlCount - 1 downto 0 do
      Sender.Controls[i].Parent:=QRB;
    if BandaInStampa = 'BTOTALI' then
      FooterStampato:='S';
  end;
  if BandaInStampa = 'BDETTAGLIO' then
    QRB.ForceNewPage:=False;
end;

procedure TR003FStampa.InizializzaBandaSpaccata(Sender: TQRCustomBand);
var QRB:TQRCustomBand;
{Eliminazione delle eventuali ChildBand create dinamicamente per spaccare i dati di dettaglio}
begin
  QRB:=Sender;
  try
    while QRB.HasChild do
      QRB:=QRB.ChildBand;
    repeat
      if QRB is TQRChildBand then
        QRB:=TQRChildBand(QRB).ParentBand;
      QRB.HasChild:=False;
    until QRB = Sender;
  except
  end;
end;

procedure TR003FStampa.BDettaglioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
begin
  InizializzaBandaSpaccata(Sender);
  (*Questo blocco può rimanere qui*)
  inc(NumOrdine);
  NumeroDati:=0;
  MaxDati:= -1;
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
    begin
      //Leggo il numero massimo di dati molteplici
      if (DatiStampa[i].TC >= 0) and (DatiStampa[i].V.Count - 1 > MaxDati) then
        MaxDati:=DatiStampa[i].V.Count - 1;
      //Ordinamento dei dati molteplici in base alla chiave
      if (DatiStampa[i].TC >= 0) and (TabelleCollegate[DatiStampa[i].TC].Ordinato) then
        OrdinaLista(DatiStampa[i].V);
      //Totalizzazione dei dati singoli
      if (DatiStampa[i].TC = -1) and (DatiStampa[i].F in [1,2]) then
      begin
        if DatiStampa[i].QT <> nil then
          DatiStampa[i].TP:=DatiStampa[i].TP + QRep.DataSet.FieldByName(DatiStampa[i].D).AsFloat;
        if DatiStampa[i].QS <> nil then
        begin
          DatiStampa[i].TG:=DatiStampa[i].TG + QRep.DataSet.FieldByName(DatiStampa[i].D).AsFloat;
          DatiStampa[i].TSG:=DatiStampa[i].TSG + QRep.DataSet.FieldByName(DatiStampa[i].D).AsFloat;
        end;
        if (DatiStampa[i].F in [1,2]) and (QRep.DataSet.FieldByName(DatiStampa[i].D).AsFloat <> 0) then
        begin
          inc(DatiStampa[i].NumOrdP);
          inc(DatiStampa[i].NumOrdG);
        end;
      end;
    end;
  end;
  PrintBand:=not R003FGeneratoreStampe.DBCheckBox1.Checked;
  BandaInStampa:='BDETTAGLIO';
  ScriviLog('BDettaglioBeforePrint',Sender.Name,PrintBand);
  BDettaglioSpaccato(Sender,PrintBand);
end;

procedure TR003FStampa.BDettaglioSpaccato(Sender: TQRCustomBand; PrintBand: Boolean);
var i,j,P,DiffHeight,InizHeight:Integer;
    RI:Byte;
    S:String;
    x:Extended;
begin
  GetSpazioDisponibile;
  SetLength(CoordinateSpostate,0);
  Sender.Height:=Sender.Tag;
  DatiLog:='';
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
    begin
      if (DatiStampa[i].QD <> nil) and (DatiStampa[i].Lbl <> nil) then
      begin
        DatiStampa[i].QD.Top:=DatiStampa[i].Lbl.Top;
        DatiStampa[i].QD.Caption:='';
        if DatiStampa[i].TC >= 0 then
          DatiStampa[i].QD.Height:=0;
      end;
    end;
    //Dati non molteplici
    for i:=0 to High(DatiStampa) do
    begin
      if (DatiStampa[i].TC = -1) and (DatiStampa[i].QD <> nil) and (not Dati[DatiStampa[i].N].Ripetuto) then
      begin
        case DatiStampa[i].F of
          0,4:S:=QRep.DataSet.FieldByName(DatiStampa[i].D).AsString;
          1:S:=R180FormattaNumero(QRep.DataSet.FieldByName(DatiStampa[i].D).AsString,R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
          2:S:=FormattaOra(R180MinutiOre(QRep.DataSet.FieldByName(DatiStampa[i].D).AsInteger),R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
          3:if (QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime = 0) or
               (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
              S:=''
            else if Dati[DatiStampa[i].N].Fmt <> '' then
              S:=FormatDateTime(R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt,QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime)
            else
              S:=FormatDateTime('dd/mm/yyyy',QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime);
        end;
        //NUMORDINE
        if UpperCase(DatiStampa[i].D) = 'NUMORDINE' then
          S:=IntToStr(NumOrdine);
        //if (DatiRiep[DatiStampa[i].N].R <> 1) and (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
        if (Dati[DatiStampa[i].N].R <> 1) and (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
          S:=R003FGeneratoreStampe.ValoreNullo;
        if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex = 0) or (Trim(DatiStampa[i].QD.Hint) = '') then
          DatiStampa[i].QD.Caption:=S
        else
          DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Hint(* + ':'*) + S;
      end;
    end;
    //Dati molteplici
    P:=NumeroDati;
    NumeroDati:= -1;
    for j:=P to MaxDati do
    begin
      for i:=0 to High(DatiStampa) do
        if ((DatiStampa[i].TC >= 0) or R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Ripetuto) and (DatiStampa[i].QD <> nil) then
        begin
          //Se il dato prevede meno righe di j lo salto dopo aver inizializzato la Label
          if (DatiStampa[i].TC >= 0) and (j >= DatiStampa[i].V.Count) then Continue;
          RI:=0;
          if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex <> 0) and (Trim(DatiStampa[i].QD.Hint) <> '') then
          begin
            if j = P then DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Hint(* + ':'*);
            RI:=1;
          end;
          if (DatiStampa[i].TC >= 0) then
          begin
            //Totalizzazioni parziali e di sommario
            R003FGeneratoreStampeDtM.PutValore(i,DatiStampa[i].VP,TValore(DatiStampa[i].V[j]).Val,TValore(DatiStampa[i].V[j]).KeyTot,TValore(DatiStampa[i].V[j]).KeyTot,DatiStampa[i].F,True);
            R003FGeneratoreStampeDtM.PutValore(i,DatiStampa[i].VT,TValore(DatiStampa[i].V[j]).Val,TValore(DatiStampa[i].V[j]).KeyTot,TValore(DatiStampa[i].V[j]).KeyTot,DatiStampa[i].F,True);
          end;
          if (j > P) or (RI = 1) then //DatiStampa[i].QD.Caption <> '' then
            DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Caption + #13;
          try
            if (DatiStampa[i].TC >= 0) then
            begin
              case DatiStampa[i].F of
                0,3,4:S:=IfThen(R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt = 'Mantenere ritorni a capo',
                                TValore(DatiStampa[i].V[j]).Val,
                                StringReplace(TValore(DatiStampa[i].V[j]).Val,#13#10,' ',[rfReplaceAll]));
                          //TValore(DatiStampa[i].V[j]).Val;
                         //StringReplace(TValore(DatiStampa[i].V[j]).Val,#13#10,' ',[rfReplaceAll]);
                    1:S:=R180FormattaNumero(TValore(DatiStampa[i].V[j]).Val,R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
                    2:S:=FormattaOra(R180MinutiOre(StrToInt(TValore(DatiStampa[i].V[j]).Val)),R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
              end;
            end
            else
            begin
              case DatiStampa[i].F of
                0,4:S:=QRep.DataSet.FieldByName(DatiStampa[i].D).AsString;
                1:S:=R180FormattaNumero(QRep.DataSet.FieldByName(DatiStampa[i].D).AsString,R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
                2:S:=FormattaOra(R180MinutiOre(QRep.DataSet.FieldByName(DatiStampa[i].D).AsInteger),R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
                3:if (QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime = 0) or
                     (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
                    S:=''
                  else if R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt <> '' then
                    S:=FormatDateTime(R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt,QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime)
                  else
                    S:=FormatDateTime('dd/mm/yyyy',QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime);
              end;
              //NUMORDINE
              if UpperCase(DatiStampa[i].D) = 'NUMORDINE' then
                S:=IntToStr(NumOrdine);
              if (R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].R <> 1) and (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
                S:=R003FGeneratoreStampe.ValoreNullo;
            end;
            S:=GetVariazioneFormato(S,DatiStampa[i].D,'V',j);
          except
            S:='***';
          end;
          //Non considero i componenti QD creati internamente (MisuraAssenze - DataConteggio)
          if DatiStampa[i].QD.Enabled then
          begin
            if j = P then
            begin
              DiffHeight:=0;
              InizHeight:=DatiStampa[i].Lbl.Height;
            end
            else
            begin
              DiffHeight:=DatiStampa[i].QD.Height;
              InizHeight:=0;
            end;
            DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Caption + Copy(S,1,DatiStampa[i].QD.Width div DatiStampa[i].Lbl.Canvas.TextWidth(' '));
            //DatiStampa[i].QD.Height:=DatiStampa[i].Lbl.Canvas.TextHeight(' ') * (j - P + 1 + RI) + 2;
            DatiStampa[i].QD.Height:=QRep.TextHeight(DatiStampa[i].Lbl.Font,' ') * (j - P + 1 + RI) + 2;
            //!!!
            if QRep.Exporting and (CorrezFileExport > 0) then
              DatiStampa[i].QD.Height:=DatiStampa[i].QD.Height + CorrezFileExport;
            //!!!
            DiffHeight:=DatiStampa[i].QD.Height - DiffHeight;
            if DiffHeight < 0 then
              DiffHeight:=DatiStampa[i].QD.Height;
            if AncoraDaSpostare(DatiStampa[i].QD.Top,DatiStampa[i].QD.Height) then
              //SpostaComponenti(Sender,DatiStampa[i].QD.Top,DatiStampa[i].QD.Height,DatiStampa[i].Lbl.Height);
              SpostaComponenti(Sender,TQRLabel(DatiStampa[i].QD),DiffHeight,InizHeight);
            Sender.Height:=GetHeight(Sender);
          end;
          if DatiLog <> '' then
            DatiLog:=DatiLog + #13#10;
          DatiLog:=DatiLog + Format('%s: (j=%d, i=%d) %s',[DatiStampa[i].Lbl.Caption,j,i,Trim(StringReplace(StringReplace(DatiStampa[i].QD.Caption,#13#10,' ',[rfReplaceAll]),#13,' ',[rfReplaceAll]))]);
        end;
      if Sender.Height > 0 then
        x:=QRep.TextHeight(Sender.Font,' ') * Sender.Size.Height / Sender.Height
      else
        x:=0;
      if PrintBand and
         (j < MaxDati) and
         (Round(Sender.Size.Height + x) > SpazioDisponibile) then
      begin
        NumeroDati:=j + 1;
        Break;
      end;
    end;

    {
    //Dati non molteplici
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].TC = -1) and (DatiStampa[i].QD <> nil) then
      begin
        case DatiStampa[i].F of
          0,4:S:=QRep.DataSet.FieldByName(DatiStampa[i].D).AsString;
          1:S:=R180FormattaNumero(QRep.DataSet.FieldByName(DatiStampa[i].D).AsString,Dati[DatiStampa[i].N].Fmt);
          2:S:=FormattaOra(R180MinutiOre(QRep.DataSet.FieldByName(DatiStampa[i].D).AsInteger),Dati[DatiStampa[i].N].Fmt);
          3:if (QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime = 0) or
               (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
              S:=''
            else if Dati[DatiStampa[i].N].Fmt <> '' then
              S:=FormatDateTime(Dati[DatiStampa[i].N].Fmt,QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime)
            else
              S:=FormatDateTime('dd/mm/yyyy',QRep.DataSet.FieldByName(DatiStampa[i].D).AsDateTime);
        end;
        //NUMORDINE
        if UpperCase(DatiStampa[i].D) = 'NUMORDINE' then
          S:=IntToStr(NumOrdine);
        //if (DatiRiep[DatiStampa[i].N].R <> 1) and (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
        if (Dati[DatiStampa[i].N].R <> 1) and (QRep.DataSet.FieldByName(DatiStampa[i].D).IsNull) then
          S:=ValoreNullo;
        if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex = 0) or (Trim(DatiStampa[i].QD.Hint) = '') then
          DatiStampa[i].QD.Caption:=S
        else
          DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Hint(* + ':'*) + S;
      end;
    //Dati molteplici
    P:=NumeroDati;
    NumeroDati:= -1;
    for j:=P to MaxDati do
    begin
      for i:=0 to High(DatiStampa) do
        if (DatiStampa[i].TC >= 0) and (DatiStampa[i].QD <> nil) then
        begin
          //Se il dato prevede meno righe di j lo salto dopo aver inizializzato la Label
          if j >= DatiStampa[i].V.Count then Continue;
          RI:=0;
          if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex <> 0) and (Trim(DatiStampa[i].QD.Hint) <> '')then
          begin
            if j = P then DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Hint(* + ':'*);
            RI:=1;
          end;
          //Totalizzazioni parziali e di sommario
          R003FGeneratoreStampeDtM.PutValore(i,DatiStampa[i].VP,TValore(DatiStampa[i].V[j]).Val,TValore(DatiStampa[i].V[j]).KeyTot,TValore(DatiStampa[i].V[j]).KeyTot,DatiStampa[i].F,True);
          R003FGeneratoreStampeDtM.PutValore(i,DatiStampa[i].VT,TValore(DatiStampa[i].V[j]).Val,TValore(DatiStampa[i].V[j]).KeyTot,TValore(DatiStampa[i].V[j]).KeyTot,DatiStampa[i].F,True);
          if (j > P) or (RI = 1) then //DatiStampa[i].QD.Caption <> '' then
            DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Caption + #13;
          try
            case DatiStampa[i].F of
              0,3,4:S:=IfThen(Dati[DatiStampa[i].N].Fmt = 'Mantenere ritorni a capo',
                              TValore(DatiStampa[i].V[j]).Val,
                              StringReplace(TValore(DatiStampa[i].V[j]).Val,#13#10,' ',[rfReplaceAll]));
                        //TValore(DatiStampa[i].V[j]).Val;
                       //StringReplace(TValore(DatiStampa[i].V[j]).Val,#13#10,' ',[rfReplaceAll]);
                  1:S:=R180FormattaNumero(TValore(DatiStampa[i].V[j]).Val,Dati[DatiStampa[i].N].Fmt);
                  2:S:=FormattaOra(R180MinutiOre(StrToInt(TValore(DatiStampa[i].V[j]).Val)),Dati[DatiStampa[i].N].Fmt);
            end;
            S:=GetVariazioneFormato(S,DatiStampa[i].D,'V',j);
          except
            S:='***';
          end;
          //Non considero i componenti QD creati internamente (MisuraAssenze - DataConteggio)
          if DatiStampa[i].QD.Enabled then
          begin
            if j = P then
            begin
              DiffHeight:=0;
              InizHeight:=DatiStampa[i].Lbl.Height;
            end
            else
            begin
              DiffHeight:=DatiStampa[i].QD.Height;
              InizHeight:=0;
            end;
            DatiStampa[i].QD.Caption:=DatiStampa[i].QD.Caption + Copy(S,1,DatiStampa[i].QD.Width div DatiStampa[i].Lbl.Canvas.TextWidth(' '));
            //DatiStampa[i].QD.Height:=DatiStampa[i].Lbl.Canvas.TextHeight(' ') * (j - P + 1 + RI) + 2;
            DatiStampa[i].QD.Height:=QRep.TextHeight(DatiStampa[i].Lbl.Font,' ') * (j - P + 1 + RI) + 2;
            DiffHeight:=DatiStampa[i].QD.Height - DiffHeight;
            if DiffHeight < 0 then
              DiffHeight:=DatiStampa[i].QD.Height;
            if AncoraDaSpostare(DatiStampa[i].QD.Top,DatiStampa[i].QD.Height) then
              //SpostaComponenti(Sender,DatiStampa[i].QD.Top,DatiStampa[i].QD.Height,DatiStampa[i].Lbl.Height);
              SpostaComponenti(Sender,TQRLabel(DatiStampa[i].QD),DiffHeight,InizHeight);
            Sender.Height:=GetHeight(Sender);
          end;
        end;
      x:=QRep.TextHeight(Sender.Font,' ') * Sender.Size.Height / Sender.Height;
      if PrintBand and
         (j < MaxDati) and
         (Round(Sender.Size.Height + x) > SpazioDisponibile) then
      begin
        NumeroDati:=j + 1;
        Break;
      end;
    end;
    }
  end;
  SeparaColonne(Sender);
  ScriviLog('BDettaglioSpaccato',Sender.Name,PrintBand);
  //Abilito eventualmente la BandChild
  if (NumeroDati > 0) and PrintBand then
  begin
    Sender.HasChild:=True;
    Sender.ChildBand.Tag:=Sender.Tag;
    Sender.ChildBand.BeforePrint:=ChildBandBeforePrint;
    Sender.ChildBand.AfterPrint:=ChildBandAfterPrint;
  end;
end;

function TR003FStampa.NumeroLinee(S:String):Integer;
var i:Integer;
begin
  Result:=1;
  for i:=1 to Length(S) do
    if S[i] = #13 then
      inc(Result);
end;

procedure TR003FStampa.BTotaliBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
begin
  if Sender.Tag = 0 then
    exit;
  InizializzaBandaSpaccata(Sender);
  NumeroDati:=0;
  MaxDati:= -1;
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
    for i:=0 to High(DatiStampa) do
    begin
      //Leggo il numero massimo di dati molteplici
      if (DatiStampa[i].TC >= 0) and (DatiStampa[i].VP.Count - 1 > MaxDati) then
        MaxDati:=DatiStampa[i].VP.Count - 1;
      //Ordinamento dei dati molteplici in base alla chiave
      if (DatiStampa[i].TC >= 0) and (TabelleCollegate[DatiStampa[i].TC].Ordinato) then
        OrdinaLista(DatiStampa[i].VP);
    end;
  BandaInStampa:='BTOTALI';
  ScriviLog('BTotaliBeforePrint',Sender.Name,PrintBand);
  BTotaliSpaccato(Sender);
end;

procedure TR003FStampa.BTotaliSpaccato(Sender: TQRCustomBand);
var i,j,P,DiffHeight,InizHeight:Integer;
    RI:Byte;
    S:String;
    x:Extended;
begin
  GetSpazioDisponibile;
  SetLength(CoordinateSpostate,0);
  Sender.Height:=Sender.Tag;
  DatiLog:='';
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].QT <> nil) and (DatiStampa[i].Lbl <> nil) then
      begin
        DatiStampa[i].QT.Top:=DatiStampa[i].Lbl.Top;
        DatiStampa[i].QT.Caption:='';
        if DatiStampa[i].TC >= 0 then
          DatiStampa[i].QT.Height:=0;
      end;
    //Dati non molteplici
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].TC = -1) and (DatiStampa[i].QT <> nil) then
      begin
        case DatiStampa[i].F of
          0,3:S:=TValore(DatiStampa[i].V[0]).Val;
          1:S:=R180FormattaNumero(FloatToStr(DatiStampa[i].TP),Dati[DatiStampa[i].N].Fmt);
          2:S:=FormattaOra(R180MinutiOre(Trunc(DatiStampa[i].TP)),Dati[DatiStampa[i].N].Fmt);
        end;
        //Contatore
        if (Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (DatiStampa[i].NumOrdP > 0)) then
          S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),DatiStampa[i].NumOrdP]);
        if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex = 0) or (Trim(DatiStampa[i].QT.Hint) = '') then
          DatiStampa[i].QT.Caption:=S
        else
          DatiStampa[i].QT.Caption:=DatiStampa[i].QT.Hint(* + ':'*) + S;
      end;
    //Dati molteplici
    P:=NumeroDati;
    NumeroDati:= -1;
    for j:=P to MaxDati do
    begin
      for i:=0 to High(DatiStampa) do
        if (DatiStampa[i].TC >= 0) and (DatiStampa[i].QT <> nil) then
        begin
          //Se il dato prevede meno righe di j lo salto dopo aver inizializzato la Label
          if j >= DatiStampa[i].VP.Count then Continue;
          RI:=0;
          if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex <> 0) and (Trim(DatiStampa[i].QT.Hint) <> '') then
          begin
            if j = P then DatiStampa[i].QT.Caption:=DatiStampa[i].QT.Hint(* + ':'*);
            RI:=1;
          end;
          if (j > P) or (RI = 1) then //DatiStampa[i].QT.Caption <> '' then
            DatiStampa[i].QT.Caption:=DatiStampa[i].QT.Caption + #13;
          try
            case DatiStampa[i].F of
              0,3,4:S:=IfThen(Dati[DatiStampa[i].N].Fmt = 'Mantenere ritorni a capo',
                              TValore(DatiStampa[i].VP[j]).Val,
                              StringReplace(TValore(DatiStampa[i].VP[j]).Val,#13#10,' ',[rfReplaceAll]));
                       //TValore(DatiStampa[i].VP[j]).Val;
                       //StringReplace(TValore(DatiStampa[i].VP[j]).Val,#13#10,' ',[rfReplaceAll]);
                  1:S:=R180FormattaNumero(TValore(DatiStampa[i].VP[j]).Val,Dati[DatiStampa[i].N].Fmt);
                  2:S:=FormattaOra(R180MinutiOre(StrToInt(TValore(DatiStampa[i].VP[j]).Val)),Dati[DatiStampa[i].N].Fmt);
            end;
            S:=GetVariazioneFormato(S,DatiStampa[i].D,'VP',j);
          except
            S:='***';
          end;
          //Contatore
          if (Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (TValore(DatiStampa[i].VP[j]).NumOrd > 0)) then
            S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),TValore(DatiStampa[i].VP[j]).NumOrd]);
          if j = P then
          begin
            DiffHeight:=0;
            InizHeight:=DatiStampa[i].Lbl.Height;
          end
          else
          begin
            DiffHeight:=DatiStampa[i].QT.Height;
            InizHeight:=0;
          end;
          DatiStampa[i].QT.Caption:=DatiStampa[i].QT.Caption + Copy(S,1,DatiStampa[i].QT.Width div DatiStampa[i].Lbl.Canvas.TextWidth(' '));
          if QRepTextHeight then
            DatiStampa[i].QT.Height:=QRep.TextHeight(DatiStampa[i].Lbl.Font,' ') * (j - P + 1 + RI) + 2
          else
            DatiStampa[i].QT.Height:=DatiStampa[i].Lbl.Canvas.TextHeight(' ') * (j - P + 1 + RI) + 2;
          //!!!
          if QRep.Exporting and (CorrezFileExport > 0) then
            DatiStampa[i].QT.Height:=DatiStampa[i].QT.Height + CorrezFileExport;
          //!!!
          DiffHeight:=DatiStampa[i].QT.Height - DiffHeight;
          if DiffHeight < 0 then
            DiffHeight:=DatiStampa[i].QT.Height;
          if AncoraDaSpostare(DatiStampa[i].QT.Top,DatiStampa[i].QT.Height) then
            //SpostaComponenti(Sender,DatiStampa[i].QT.Top,DatiStampa[i].QT.Height,DatiStampa[i].Lbl.Height);
            SpostaComponenti(Sender,DatiStampa[i].QT,DiffHeight,InizHeight);
          OttimizzaSpazio(Sender);
          Sender.Height:=GetHeight(Sender);
          if DatiLog <> '' then
            DatiLog:=DatiLog + #13#10;
          DatiLog:=DatiLog + Format('%s: (j=%d, i=%d) %s',[DatiStampa[i].Lbl.Caption,j,i,Trim(StringReplace(StringReplace(DatiStampa[i].QT.Caption,#13#10,' ',[rfReplaceAll]),#13,' ',[rfReplaceAll]))]);
        end;
      if Sender.Height > 0 then
        x:=QRep.TextHeight(Sender.Font,' ') * Sender.Size.Height / Sender.Height
      else
        x:=0;
      if (j < MaxDati) and
         (Round(Sender.Size.Height + x) > SpazioDisponibile) then
      begin
        NumeroDati:=j + 1;
        Break;
      end;
    end;
  end;
  SeparaColonne(Sender);
  ScriviLog('BTotaliSpaccato',Sender.Name,True);
  //Abilito eventualmente la BandChild
  if NumeroDati > 0 then
  begin
    Sender.HasChild:=True;
    Sender.ChildBand.Tag:=Sender.Tag;
    Sender.ChildBand.BeforePrint:=ChildBandBeforePrint;
    Sender.ChildBand.AfterPrint:=ChildBandAfterPrint;
  end
  //Nuova banda dei totali non dettagliata, come il sommario generale
  else if R003FGeneratoreStampe.dchkTotGenerali.Checked and (R003FGeneratoreStampe.KeyCumuloTotaleCount > 0) then
  begin
    Sender.HasChild:=True;
    Sender.ChildBand.Font.Assign(Sender.Font);
    Sender.ChildBand.Tag:=Sender.Tag;
    Sender.ChildBand.Frame.DrawTop:=True;
    Sender.ChildBand.Frame.DrawBottom:=True;
    Sender.ChildBand.BeforePrint:=BTotaliChildBeforePrint;
    Sender.ChildBand.AfterPrint:=ChildBandAfterPrint;
  end;
end;

procedure TR003FStampa.BSommarioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Integer;
begin
  InizializzaBandaSpaccata(Sender);
  NumeroDati:=0;
  MaxDati:= -1;
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
  begin
    if R003FGeneratoreStampe.dchkSaltoPaginaTotali.Checked and R003FGeneratoreStampe.dchkTotRiepilogo.Checked then
      QRep.NewPage;
    for i:=0 to High(DatiStampa) do
    begin
      //Leggo il numero massimo di dati molteplici
      if (DatiStampa[i].TC >= 0) and (DatiStampa[i].VT.Count - 1 > MaxDati) then
        MaxDati:=DatiStampa[i].VT.Count - 1;
      //Ordinamento dei dati molteplici in base alla chiave
      if (DatiStampa[i].TC >= 0) and (TabelleCollegate[DatiStampa[i].TC].Ordinato) then
        OrdinaLista(DatiStampa[i].VT);
    end;
  end;
  BandaInStampa:='BSOMMARIO';
  ScriviLog('BSommarioBeforePrint',Sender.Name,PrintBand);
  BSommarioSpaccato(Sender);
  //La banda di sommario può essere stata abilitata per consentire di stampare i totali generali anche senza avere i totali di riepilogo
  if not R003FGeneratoreStampe.dchkTotRiepilogo.Checked then
    PrintBand:=False;
end;

procedure TR003FStampa.BSommarioSpaccato(Sender: TQRCustomBand);
var i,j,P,DiffHeight,InizHeight:Integer;
    RI:Byte;
    S:String;
    x:Extended;
begin
  GetSpazioDisponibile;
  SetLength(CoordinateSpostate,0);
  Sender.Height:=Sender.Tag;
  DatiLog:='';
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].QS <> nil) and (DatiStampa[i].Lbl <> nil) then
      begin
        DatiStampa[i].QS.Top:=DatiStampa[i].Lbl.Top;
        DatiStampa[i].QS.Caption:='';
        if DatiStampa[i].TC >= 0 then
          DatiStampa[i].QS.Height:=0;
      end;
    //Dati non molteplici
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].TC = -1) and (DatiStampa[i].QS <> nil) then
      begin
        case DatiStampa[i].F of
          0,3:S:=TValore(DatiStampa[i].V[0]).Val;
          1:S:=R180FormattaNumero(FloatToStr(DatiStampa[i].TG),Dati[DatiStampa[i].N].Fmt);
          2:S:=FormattaOra(R180MinutiOre(Trunc(DatiStampa[i].TG)),Dati[DatiStampa[i].N].Fmt);
        end;
        //Contatore
        if (Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (DatiStampa[i].NumOrdG > 0)) then
          S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),DatiStampa[i].NumOrdG]);
        if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex = 0) or (Trim(DatiStampa[i].QS.Hint) = '') then
          DatiStampa[i].QS.Caption:=S
        else
          DatiStampa[i].QS.Caption:=DatiStampa[i].QS.Hint(* + ':'*) + S;
      end;
    //Dati molteplici
    P:=NumeroDati;
    NumeroDati:= -1;
    for j:=P to MaxDati do
    begin
      for i:=0 to High(DatiStampa) do
        if (DatiStampa[i].TC >= 0) and (DatiStampa[i].QS <> nil) then
        begin
          //Se il dato prevede meno righe di j lo salto dopo aver inizializzato la Label
          if j >= DatiStampa[i].VT.Count then Continue;
          RI:=0;
          if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex <> 0) and (Trim(DatiStampa[i].QS.Hint) <> '') then
          begin
            if j = P then DatiStampa[i].QS.Caption:=DatiStampa[i].QS.Hint(* + ':'*);
            RI:=1;
          end;
          if (j > P) or (RI = 1) then //DatiStampa[i].QS.Caption <> '' then
            DatiStampa[i].QS.Caption:=DatiStampa[i].QS.Caption + #13;
          try
            case DatiStampa[i].F of
              0,3,4:S:=IfThen(Dati[DatiStampa[i].N].Fmt = 'Mantenere ritorni a capo',
                              TValore(DatiStampa[i].VT[j]).Val,
                              StringReplace(TValore(DatiStampa[i].VT[j]).Val,#13#10,' ',[rfReplaceAll]));
                       //TValore(DatiStampa[i].VT[j]).Val;
                       //StringReplace(TValore(DatiStampa[i].VT[j]).Val,#13#10,' ',[rfReplaceAll]);
                  1:S:=R180FormattaNumero(TValore(DatiStampa[i].VT[j]).Val,Dati[DatiStampa[i].N].Fmt);
                  2:S:=FormattaOra(R180MinutiOre(StrToInt(TValore(DatiStampa[i].VT[j]).Val)),Dati[DatiStampa[i].N].Fmt);
            end;
            S:=GetVariazioneFormato(S,DatiStampa[i].D,'VT',j);
          except
            S:='***';
          end;
          //Contatore
          if (Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (TValore(DatiStampa[i].VT[j]).NumOrd > 0)) then
            S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),TValore(DatiStampa[i].VT[j]).NumOrd]);
          if j = P then
          begin
            DiffHeight:=0;
            InizHeight:=DatiStampa[i].Lbl.Height;
          end
          else
          begin
            DiffHeight:=DatiStampa[i].QS.Height;
            InizHeight:=0;
          end;
          DatiStampa[i].QS.Caption:=DatiStampa[i].QS.Caption + Copy(S,1,DatiStampa[i].QS.Width div DatiStampa[i].Lbl.Canvas.TextWidth(' '));
          if QRepTextHeight then
            DatiStampa[i].QS.Height:=QRep.TextHeight(DatiStampa[i].Lbl.Font,' ') * (j - P + 1 + RI) + 2
          else
            DatiStampa[i].QS.Height:=DatiStampa[i].Lbl.Canvas.TextHeight(' ') * (j - P + 1 + RI) + 2;
          //!!!
          if QRep.Exporting and (CorrezFileExport > 0) then
            DatiStampa[i].QS.Height:=DatiStampa[i].QS.Height + CorrezFileExport;
          //!!!
          DiffHeight:=DatiStampa[i].QS.Height - DiffHeight;
          if DiffHeight < 0 then
            DiffHeight:=DatiStampa[i].QS.Height;
          if AncoraDaSpostare(DatiStampa[i].QS.Top,DatiStampa[i].QS.Height) then
            //SpostaComponenti(Sender,DatiStampa[i].QS.Top,DatiStampa[i].QS.Height,DatiStampa[i].Lbl.Height);
            SpostaComponenti(Sender,DatiStampa[i].QS,DiffHeight,InizHeight);
          OttimizzaSpazio(Sender);
          Sender.Height:=GetHeight(Sender);
          if DatiLog <> '' then
            DatiLog:=DatiLog + #13#10;
          DatiLog:=DatiLog + Format('%s: (j=%d, i=%d) %s',[DatiStampa[i].Lbl.Caption,j,i,Trim(StringReplace(StringReplace(DatiStampa[i].QS.Caption,#13#10,' ',[rfReplaceAll]),#13,' ',[rfReplaceAll]))]);
        end;
      if Sender.Height > 0 then
        x:=QRep.TextHeight(Sender.Font,' ') * Sender.Size.Height / Sender.Height
      else
        x:=0;
      if (j < MaxDati) and
         (Round(Sender.Size.Height + x) > SpazioDisponibile) then
      begin
        NumeroDati:=j + 1;
        Break;
      end;
    end;
  end;
  SeparaColonne(Sender);
  ScriviLog('BSommarioSpaccato',Sender.Name,True);
  //Abilito eventualmente la BandChild
  if (NumeroDati > 0) and R003FGeneratoreStampe.dchkTotRiepilogo.Checked then
  begin
    Sender.HasChild:=True;
    Sender.ChildBand.Tag:=Sender.Tag;
    Sender.ChildBand.BeforePrint:=ChildBandBeforePrint;
    Sender.ChildBand.AfterPrint:=ChildBandAfterPrint;
  end
  else if R003FGeneratoreStampe.dchkTotGenerali.Checked then
  begin
    Sender.HasChild:=True;
    Sender.ChildBand.Font.Assign(Sender.Font);
    Sender.ChildBand.Tag:=Sender.Tag;
    Sender.ChildBand.Frame.DrawTop:=True;
    Sender.ChildBand.Frame.DrawBottom:=True;
    Sender.ChildBand.BeforePrint:=BSommarioChildBeforePrint;
    Sender.ChildBand.AfterPrint:=ChildBandAfterPrint;
  end;
  if (not Sender.HasChild) and (R003FGeneratoreStampe.TestoFineStampa <> '') then
    AddBandaTestoAggiuntivo(Sender,R003FGeneratoreStampe.TestoFineStampa);
end;

procedure TR003FStampa.BSommarioChildBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i,j,Contatore,DiffHeight,InizHeight:Integer;
    S:String;
    x:Extended;
begin
  PrintBand:=False;
  for i:=TQRChildBand(Sender).ParentBand.ControlCount - 1 downto 0 do
    TQRChildBand(Sender).ParentBand.Controls[i].Parent:=Sender;
  //GetSpazioDisponibile;
  //SetLength(CoordinateSpostate,0);
  Sender.Height:=Sender.Tag;
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].QS <> nil) and (DatiStampa[i].Lbl <> nil) then
      begin
        DatiStampa[i].QS.Top:=DatiStampa[i].Lbl.Top;
        DatiStampa[i].QS.Caption:='';
        //if DatiStampa[i].TC >= 0 then
        DatiStampa[i].QS.Height:=0;
      end;
    //Dati non molteplici
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].TC = -1) and (DatiStampa[i].QS <> nil) then
      begin
        case DatiStampa[i].F of
          0,3:S:='';//TValore(DatiStampa[i].V[0]).Val;
          1:S:=R180FormattaNumero(FloatToStr(DatiStampa[i].TG),R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
          2:S:=FormattaOra(R180MinutiOre(Trunc(DatiStampa[i].TG)),R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
        end;
        //Contatore
        if (R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (DatiStampa[i].NumOrdG > 0)) then
          S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),DatiStampa[i].NumOrdG]);
        if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex = 0) or (Trim(DatiStampa[i].QS.Hint) = '') then
          DatiStampa[i].QS.Caption:=S
        else
          DatiStampa[i].QS.Caption:=DatiStampa[i].QS.Hint(* + ':'*) + S;
      end;
    //Dati molteplici
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].TC >= 0) and (DatiStampa[i].QS <> nil) then
      begin
        S:='';
        x:=0;
        Contatore:=0;
        if DatiStampa[i].F in [1,2] then
        begin
          for j:=0 to DatiStampa[i].VT.Count - 1 do
          begin
            x:=x + StrToFloat(TValore(DatiStampa[i].VT[j]).Val);
            inc(Contatore,TValore(DatiStampa[i].VT[j]).NumOrd);
          end;
          case DatiStampa[i].F of
            1:S:=R180FormattaNumero(FloatToStr(x),R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
            2:S:=FormattaOra(R180MinutiOre(Trunc(x)),R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Fmt);
          end;
          PrintBand:=True;
          //S:=GetVariazioneFormato(S,DatiStampa[i].D,'VT',j);
        end;
        //Contatore
        if (R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW.Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (Contatore > 0)) then
          S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),Contatore]);
        DiffHeight:=0;
        InizHeight:=DatiStampa[i].Lbl.Height;
        DatiStampa[i].QS.Caption:=DatiStampa[i].QS.Caption + Copy(S,1,DatiStampa[i].QS.Width div DatiStampa[i].Lbl.Canvas.TextWidth(' '));
        //DatiStampa[i].QS.Height:=DatiStampa[i].Lbl.Canvas.TextHeight(' ') (** (j - P + 1 + RI)*) + 2;
        if QRepTextHeight then
          DatiStampa[i].QS.Height:=QRep.TextHeight(DatiStampa[i].Lbl.Font,' ')  + 2
        else
          DatiStampa[i].QS.Height:=DatiStampa[i].Lbl.Canvas.TextHeight(' ') (** (j - P + 1 + RI)*) + 2;
        DiffHeight:=DatiStampa[i].QS.Height - DiffHeight;
        if DiffHeight < 0 then
          DiffHeight:=DatiStampa[i].QS.Height;
        if AncoraDaSpostare(DatiStampa[i].QS.Top,DatiStampa[i].QS.Height) then
          SpostaComponenti(Sender,DatiStampa[i].QS,DiffHeight,InizHeight);
        OttimizzaSpazio(Sender);
        Sender.Height:=GetHeight(Sender);
      end;
  end;
  SeparaColonne(Sender);
end;

procedure TR003FStampa.AddBandaTestoAggiuntivo(Sender: TQRCustomBand; Testo:String);
var QRM:TQRMemo;
    QRB1,QRB2:TQRChildBand;
begin
  if Sender.HasChild and (Sender.ChildBand = BPaginaIntestazione) then
  begin
    QRB1:=Sender.ChildBand;
    QRB1.HasChild:=True;
    QRB2:=QRB1.ChildBand;
    QRB2.ParentBand:=Sender;
    QRB1.ParentBand:=QRB2;
  end
  else
  begin
    Sender.HasChild:=True;
    QRB2:=Sender.ChildBand;
  end;
  QRB2.Enabled:=True;
  QRB2.Frame.DrawTop:=True;
  QRB2.Frame.DrawBottom:=True;
  QRB2.Font.Assign(Sender.Font);
  QRB2.Font.Style:=QRB2.Font.Style - [fsBold];

  QRM:=TQRMemo(QRB2.AddPrintable(TQRMemo));
  QRB2.Height:=QRM.Height + 4;
  QRM.Lines.Text:=Testo;
  QRM.Top:=2;
  QRM.Left:=2;
  QRM.AutoSize:=True;
  QRM.AutoStretch:=True;
  QRM.WordWrap:=False;
end;

procedure TR003FStampa.BTotaliChildBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i,j,Contatore,DiffHeight,InizHeight:Integer;
    S:String;
    x:Extended;
begin
  PrintBand:=False;
  for i:=TQRChildBand(Sender).ParentBand.ControlCount - 1 downto 0 do
    TQRChildBand(Sender).ParentBand.Controls[i].Parent:=Sender;
  //GetSpazioDisponibile;
  //SetLength(CoordinateSpostate,0);
  Sender.Height:=Sender.Tag;
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].QT <> nil) and (DatiStampa[i].Lbl <> nil) then
      begin
        DatiStampa[i].QT.Top:=DatiStampa[i].Lbl.Top;
        DatiStampa[i].QT.Caption:='';
        //if DatiStampa[i].TC >= 0 then
        DatiStampa[i].QT.Height:=0;
      end;
    //Dati non molteplici
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].TC = -1) and (DatiStampa[i].QT <> nil) then
      begin
        case DatiStampa[i].F of
          0,3:S:='';//TValore(DatiStampa[i].V[0]).Val;
          1:S:=R180FormattaNumero(FloatToStr(DatiStampa[i].TP),Dati[DatiStampa[i].N].Fmt);
          2:S:=FormattaOra(R180MinutiOre(Trunc(DatiStampa[i].TP)),Dati[DatiStampa[i].N].Fmt);
        end;
        //Contatore
        if (Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (DatiStampa[i].NumOrdG > 0)) then
          S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),DatiStampa[i].NumOrdG]);
        if (R003FGeneratoreStampe.DBRadioGroup1.ItemIndex = 0) or (Trim(DatiStampa[i].QT.Hint) = '') then
          DatiStampa[i].QT.Caption:=S
        else
          DatiStampa[i].QT.Caption:=DatiStampa[i].QT.Hint(* + ':'*) + S;
      end;
    //Dati molteplici
    for i:=0 to High(DatiStampa) do
      if (DatiStampa[i].TC >= 0) and (DatiStampa[i].QT <> nil) then
      begin
        S:='';
        x:=0;
        Contatore:=0;
        if DatiStampa[i].F in [1,2] then
        begin
          for j:=0 to DatiStampa[i].VP.Count - 1 do
          begin
            x:=x + StrToFloat(TValore(DatiStampa[i].VP[j]).Val);
            inc(Contatore,TValore(DatiStampa[i].VP[j]).NumOrd);
          end;
          case DatiStampa[i].F of
            1:S:=R180FormattaNumero(FloatToStr(x),Dati[DatiStampa[i].N].Fmt);
            2:S:=FormattaOra(R180MinutiOre(Trunc(x)),Dati[DatiStampa[i].N].Fmt);
          end;
          PrintBand:=True;
          //S:=GetVariazioneFormato(S,DatiStampa[i].D,'VP',j);
        end;
        //Contatore
        if (Dati[DatiStampa[i].N].Cont = 1) and ((S <> '') or (Contatore > 0)) then
          S:=S + Format(' (%*d)',[Length(IntToStr(QRep.DataSet.RecordCount)),Contatore]);
        DiffHeight:=0;
        InizHeight:=DatiStampa[i].Lbl.Height;
        DatiStampa[i].QT.Caption:=DatiStampa[i].QT.Caption + Copy(S,1,DatiStampa[i].QT.Width div DatiStampa[i].Lbl.Canvas.TextWidth(' '));
        if QRepTextHeight then
          DatiStampa[i].QT.Height:=QRep.TextHeight(DatiStampa[i].Lbl.Font,' ')  + 2
        else
          DatiStampa[i].QT.Height:=DatiStampa[i].Lbl.Canvas.TextHeight(' ') (** (j - P + 1 + RI)*) + 2;
        DiffHeight:=DatiStampa[i].QT.Height - DiffHeight;
        if DiffHeight < 0 then
          DiffHeight:=DatiStampa[i].QT.Height;
        if AncoraDaSpostare(DatiStampa[i].QT.Top,DatiStampa[i].QT.Height) then
          SpostaComponenti(Sender,DatiStampa[i].QT,DiffHeight,InizHeight);
        OttimizzaSpazio(Sender);
        Sender.Height:=GetHeight(Sender);
      end;
  end;
  SeparaColonne(Sender);
end;

procedure TR003FStampa.BandaAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  if Sender.Name = 'BTotali' then
  begin
    if not Sender.HasChild then
      FooterStampato:='S';
    if Sender.Tag = 0 then
      exit;
  end;
  Sender.Height:=Sender.Tag;
  if QRep.CurrentY > (QRep.Page.Length - QRep.Page.BottomMargin - Sender.Size.Height) then
    QRep.NewColumn;
end;

function TR003FStampa.GetVariazioneFormato(S,Dato,Lista:String; PosVal:Integer):String;
{Se il Dato è soggetto a una variazione di formato in base al valore di VariazioniFormato.Colonna,
 viene restituito il valore trasformato}
var i:Integer;
    Val:String;
begin
  Result:=S;
  with R003FGeneratoreStampeDtm.R003FGeneratoreStampeMW do
    for i:=0 to High(VariazioniFormato) do
      if UpperCase(VariazioniFormato[i].Dato) = UpperCase(Dato) then
      begin
        if Lista = 'V' then
          Val:=TValore(DatiStampa[EsisteDatoStampa(VariazioniFormato[i].Colonna)].V[PosVal]).Val
        else if Lista = 'VP' then
          Val:=TValore(DatiStampa[EsisteDatoStampa(VariazioniFormato[i].Colonna)].VP[PosVal]).Val
        else if Lista = 'VT' then
          Val:=TValore(DatiStampa[EsisteDatoStampa(VariazioniFormato[i].Colonna)].VT[PosVal]).Val;
        with TStringList.Create do
        try
          CommaText:=VariazioniFormato[i].Formati;
          if Values[Val] = '2' then
          try
            Result:=R180MinutiOre(StrToInt(S));
          except
          end;
        finally
          Free;
        end;
        Break;
      end;
end;

function TR003FStampa.FormattaOra(S,F:String):String;
{0=N - 0=S - S=, - S=; - F=C - F=M}
var Separatore:String;
begin
  Result:=S;
  F:=UpperCase(F);
  Separatore:={$IFNDEF VER210}FormatSettings.{$ENDIF}TimeSeparator;
  if (Pos('0=N',F) > 0) and (R180OreMinutiExt(S) = 0) then
  begin
    Result:='';
    exit;
  end;
  if Pos('F=C',F) > 0 then
  begin
    Result:=StringReplace(Format('%5.2f',[R180OreMinutiExt(S)/60]),' ','0',[rfReplaceAll]);
    Separatore:={$IFNDEF VER210}FormatSettings.{$ENDIF}DecimalSeparator;
  end;
  if Pos('F=M',F) > 0 then
    Result:=IntToStr(R180OreMinutiExt(S));
  if Pos('S=',F) > 0 then
    Result:=StringReplace(Result,Separatore,Copy(F,Pos('S=',F) + 2,1),[]);
end;

procedure TR003FStampa.OrdinaLista(L:TList);
begin
  if L.Count > 1 then
    QuickSort(L,0,L.Count - 1);
end;

procedure TR003FStampa.QuickSort(L:TList; iLo,iHi:Integer);
{Implementeazione Quick Sort per ordinamento dati multipli}
var Lo,Hi:Integer;
    Mid:String;
    T:TValore;
begin
  Lo:=iLo;
  Hi:=iHi;
  Mid:=TValore(L[(Lo + Hi) div 2]).Key;
  repeat
    while TValore(L[Lo]).Key < Mid do Inc(Lo);
    while TValore(L[Hi]).Key > Mid do Dec(Hi);
    if Lo <= Hi then
    begin
      T:=TValore(L[Lo]);
      L[Lo]:=L[Hi];
      L[Hi]:=T;
      Inc(Lo);
      Dec(Hi);
    end;
  until Lo > Hi;
  if Hi > iLo then QuickSort(L,iLo,Hi);
  if Lo < iHi then QuickSort(L,Lo,iHi);
end;

procedure TR003FStampa.SpostaComponenti(Sender:TQRCustomBand; Componente:TQRLabel; H,OS:Integer);
var i:Integer;
begin
  if AncoraDaSpostare(Componente.Top,Componente.Height) then
  begin
    SetLength(CoordinateSpostate,High(CoordinateSpostate) + 2);
    CoordinateSpostate[High(CoordinateSpostate)].x:=Componente.Top;
    CoordinateSpostate[High(CoordinateSpostate)].y:=Componente.Height;
  end;
  for i:=0 to Sender.ControlCount - 1 do
    if Sender.Controls[i] is TQRLabel then
      if (TQRLabel(Sender.Controls[i]).Top > Componente.Top) then
      begin
        TQRLabel(Sender.Controls[i]).Top:=H + TQRLabel(Sender.Controls[i]).Top - OS;
        if AncoraDaSpostare(TQRLabel(Sender.Controls[i]).Top,TQRLabel(Sender.Controls[i]).Height) then
        begin
          SetLength(CoordinateSpostate,High(CoordinateSpostate) + 2);
          CoordinateSpostate[High(CoordinateSpostate)].x:=TQRLabel(Sender.Controls[i]).Top;
          CoordinateSpostate[High(CoordinateSpostate)].y:=TQRLabel(Sender.Controls[i]).Height;
        end;
      end;
end;

procedure TR003FStampa.TitoloBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var P:Integer;
begin
  inherited;
  if (FooterStampato = 'N') and BIntestazione.Enabled and (BIntestazione.Tag > 0) then
    if R003FGeneratoreStampe.dChkIntestazioneCol.Checked then
    begin
      BPaginaIntestazione.Enabled:=True;
      BPaginaIntestazione.Font.Assign(BIntestazione.Font);
      BPaginaIntestazione.Tag:=BIntestazione.Tag;
      BPaginaIntestazione.Height:=BIntestazione.Height;
      for P:=BIntestazione.ControlCount - 1 downto 0 do
        BIntestazione.Controls[P].Parent:=BPaginaIntestazione;
      BIntestazione.Height:=0;

      for P:=BIntestazioneColonne.ControlCount - 1 downto 0 do
        BIntestazioneColonne.Controls[P].Parent:=BColonne;
      //BColonne.Enabled:=True;
      BIntestazioneColonne.Enabled:=False;
    end;
end;

procedure TR003FStampa.OttimizzaSpazio(Sender:TQRCustomBand);
var i,Min:Integer;
begin
  Min:=High(Integer);
  for i:=0 to Sender.ControlCount - 1 do
    if Sender.Controls[i] is TQRLabel then
      if TQRLabel(Sender.Controls[i]).Top < Min then
        Min:=TQRLabel(Sender.Controls[i]).Top;
  if Min > 0 then
    for i:=0 to Sender.ControlCount - 1 do
      if Sender.Controls[i] is TQRLabel then
        TQRLabel(Sender.Controls[i]).Top:=TQRLabel(Sender.Controls[i]).Top - Min;
end;

procedure TR003FStampa.DistruggiComponenti(Sender:TQRCustomBand);
var i:Integer;
    Temp:TControl;
begin
  for i:=Sender.ControlCount - 1 downto 0 do
    if (Sender.Controls[i] is TQRLabel) or (Sender.Controls[i] is TQRShape) then
    begin
      Temp:=Sender.Controls[i];
      Sender.RemoveControl(Temp);
      Temp.Free;
    end;
end;

procedure TR003FStampa.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(IdLog);
  InizializzaBandaSpaccata(BDettaglio);
  InizializzaBandaSpaccata(BTotali);
  InizializzaBandaSpaccata(BSommario);
  DistruggiComponenti(BColonne);
  DistruggiComponenti(BIntestazioneColonne);
  DistruggiComponenti(BPaginaIntestazione);
  DistruggiComponenti(BIntestazione);
  DistruggiComponenti(BDettaglio);
  DistruggiComponenti(BTotali);
  DistruggiComponenti(BSommario);
  DistruggiComponenti(BSommarioChild);
  FreeAndNil(BSommarioChild);
end;

procedure TR003FStampa.QRepApplyPrinterSettings(Sender: TObject;
  var Cancel: Boolean; DevMode: Pointer);
begin
  //PDevMode(DevMode).dmDefaultSource:=UserBinCode;
  //PDevMode(DevMode).dmCollate := UserCollateCode;
end;

procedure TR003FStampa.ScriviLog(Evento,Elemento:String; PrintBand:Boolean);
var TipoExp:String;
begin
  EXIT;
  if R180GetRegistro(HKEY_CURRENT_USER,'R003','Log','N') <> 'S' then
    exit;
  if QRep.Exporting then
    TipoExp:=QRep.ExportFilter.FileName
  else
    TipoExp:='';
  with TOracleQuery.Create(nil) do
  try
    Session:=SessioneOracle;
    //BandaInStampa,NumeroDati,SpazioDisponibile,PrintBand
    SQL.Add('insert into tmp_t910_log (id,id_stampa,data,stampa,export,evento,elemento,elem_id,BandaInStampa,NumeroDati,SpazioDisponibile,PrintBand,dati)');
    SQL.Add('values (tmp_t910_id.nextval,:id_stampa,sysdate,:stampa,:export,:evento,:elemento,:elem_id,:BandaInStampa,:NumeroDati,:SpazioDisponibile,:PrintBand,:dati)');
    DeclareVariable('id_stampa',otInteger);
    DeclareVariable('stampa',otString);
    DeclareVariable('export',otString);
    DeclareVariable('evento',otString);
    DeclareVariable('elemento',otString);
    DeclareVariable('elem_id',otInteger);
    DeclareVariable('BandaInStampa',otString);
    DeclareVariable('NumeroDati',otInteger);
    DeclareVariable('SpazioDisponibile',otFloat);
    DeclareVariable('PrintBand',otString);
    DeclareVariable('dati',otString);
    SetVariable('stampa',R003FGeneratoreStampeDtM.Q910.FieldByName('CODICE').AsString);
    SetVariable('export',TipoExp);
    SetVariable('evento',Evento);
    SetVariable('elemento',Elemento);
    SetVariable('elem_id',IdLog.GetID(Evento,Elemento));
    SetVariable('id_stampa',IdLog.ID);
    SetVariable('BandaInStampa',BandaInStampa);
    SetVariable('NumeroDati',NumeroDati);
    SetVariable('SpazioDisponibile',SpazioDisponibile);
    SetVariable('PrintBand',IfThen(PrintBand,'S','N'));
    SetVariable('dati',Copy(DatiLog,1,2000));
    Execute;
  finally
    Free;
    DatiLog:='';
  end;
end;

end.
