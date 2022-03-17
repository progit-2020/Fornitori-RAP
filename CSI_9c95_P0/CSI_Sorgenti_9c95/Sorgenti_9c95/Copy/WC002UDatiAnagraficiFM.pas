unit WC002UDatiAnagraficiFM;

interface

uses
  SysUtils, Classes, Controls, Forms, IWAppForm,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, R010UPAGINAWEB, IWCompButton, StrUtils,
  Variants, Db, W001UIrisWebDtM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  C190FunzioniGeneraliWeb, WC002UStoriaDipendenteFM, meIWGrid, meIWButton,
  IWCompJQueryWidget, IWCompGrids;

type
   TWC002FDatiAnagraficiFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQDatiAnagrafici: TIWJQueryWidget;
    grdDatiAnagrafici: TmeIWGrid;
    btnChiudi: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure grdDatiAnagraficiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdDatiAnagraficiCellClick(ASender: TObject; const ARow,
      AColumn: Integer);
  private
    Matricola:String;
    Progressivo:Integer;
    TestoDipendente:String;
    WC002FStoriaDipendenteFM:TWC002FStoriaDipendenteFM;
    procedure CaricaScheda;
  public
    SchedaCompleta:Boolean;
    ParMatricola:String;
    AllowClick:Boolean;
    procedure VisualizzaScheda;
  end;

implementation

{$R *.dfm}

uses A000UInterfaccia;

procedure TWC002FDatiAnagraficiFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

procedure TWC002FDatiAnagraficiFM.VisualizzaScheda;
var MOld:String;
begin
  MOld:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
  if WR000DM.cdsAnagrafe.Locate('MATRICOLA',ParMatricola,[]) then
  begin
    Matricola:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
    Progressivo:=WR000DM.cdsAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
    SchedaCompleta:=False;  //forzato FALSE Luca
    CaricaScheda;
    WR000DM.cdsAnagrafe.Locate('MATRICOLA',MOld,[]);
  end;

  //Massimo: necessario perchè se non esiste un testo allora non viene visualizzato il btnChiudi a video
  if TestoDipendente = '' then
    TestoDipendente:=' ';

  (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(jQDatiAnagrafici,Self.Width + 40,-1,EM2PIXEL * 50,TestoDipendente,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
end;

procedure TWC002FDatiAnagraficiFM.btnChiudiClick(Sender: TObject);
begin
  SetLength(WR000DM.CampoArr,0);
  Free;
end;

procedure TWC002FDatiAnagraficiFM.CaricaScheda;
var
  i,Row,c:Integer;
begin
  TestoDipendente:=Format('%s %s - %s %s - %s %s',[
    WR000DM.cdsAnagrafe.FieldByName('COGNOME').AsString,
    WR000DM.cdsAnagrafe.FieldByName('NOME').AsString,
    A000TraduzioneStringhe('MATRICOLA'),
    WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString,
    A000TraduzioneStringhe('BADGE'),
    WR000DM.cdsAnagrafe.FieldByName('T430BADGE').AsString
    ]);

  WR000DM.GetDatiAnagrafici(Row,SchedaCompleta);

  grdDatiAnagrafici.ColumnCount:=2;
  if DebugHook<> 0 then
    grdDatiAnagrafici.ColumnCount:=grdDatiAnagrafici.ColumnCount + 3;
  grdDatiAnagrafici.RowCount:=Row + 1;

  // intestazione
  c:=0;
  grdDatiAnagrafici.Cell[0,c].Text:='Dato';
  inc(c);
  grdDatiAnagrafici.Cell[0,c].Text:='Valore';
  if DebugHook <> 0 then
  begin
    inc(c);
    grdDatiAnagrafici.Cell[0,c].Text:='(**) Nome pagina';
    inc(c);
    grdDatiAnagrafici.Cell[0,c].Text:='(**) Top';
    inc(c);
    grdDatiAnagrafici.Cell[0,c].Text:='(**) Left';
  end;

  // popolamento tabella
  for i:=0 to Row - 1 do
  begin
    // dato
    c:=0;
    grdDatiAnagrafici.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].DisplayLabel;
    if AllowClick then
      grdDatiAnagrafici.Cell[i + 1,c].Clickable:=WR000DM.CampoArr[i].Clickable;
    // valore
    inc(c);
    grdDatiAnagrafici.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].AsString +
      IfThen(WR000DM.CampoArr[i].HasDesc,' (' + WR000DM.CampoArr[i].DescAsString + ')');
    if DebugHook <> 0 then
    begin
      // nome pagina
      inc(c);
      grdDatiAnagrafici.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].NomePagina;
      // top
      inc(c);
      grdDatiAnagrafici.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].Top.ToString;
      // left
      inc(c);
      grdDatiAnagrafici.Cell[i + 1,c].Text:=WR000DM.CampoArr[i].Left.ToString;
    end;
  end;
end;

procedure TWC002FDatiAnagraficiFM.grdDatiAnagraficiCellClick(ASender: TObject;
  const ARow, AColumn: Integer);
var
  Dato:string;
begin
  inherited;
  Dato:=StringReplace(WR000DM.CampoArr[ARow - 1].FieldName,'T430','',[]);
  WC002FStoriaDipendenteFM:=TWC002FStoriaDipendenteFM.Create(Self.Parent);
  WC002FStoriaDipendenteFM.VisualizzaScheda(Matricola,Dato,Progressivo);
end;

procedure TWC002FDatiAnagraficiFM.grdDatiAnagraficiRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  CssTemp:String;
begin
  // se l'elemento appartiene alla classe "invisibile" non viene disegnato
  if Pos('invisibile',ACell.Css) > 0 then
    Exit;

  // rimuove i css specifici della riga
  CssTemp:=StringReplace(Trim(ACell.Css),'riga_intestazione','',[rfReplaceAll]);
  CssTemp:=StringReplace(CssTemp,'riga_selezionata','',[rfReplaceAll]);
  CssTemp:=StringReplace(CssTemp,'riga_bianca','',[rfReplaceAll]);
  CssTemp:=StringReplace(CssTemp,'riga_colorata','',[rfReplaceAll]);
  CssTemp:=IfThen(CssTemp = '','',CssTemp + ' ');

  if ARow = 0 then
    // intestazione
    CssTemp:=CssTemp + 'riga_intestazione'
  else
    // dettaglio: alternazione colore sfondo
    CssTemp:=CssTemp + IfThen(ARow mod 2 = 0,'riga_colorata','riga_bianca');

  ACell.Css:=Trim(CssTemp);
end;

end.
