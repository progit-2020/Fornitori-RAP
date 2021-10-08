unit WC002UStoriaDipendenteFM;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent, IWApplication,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, R010UPaginaWeb,
  IWCompButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  C190FunzioniGeneraliWeb, W001UIrisWebDtM, C006UStoriaDati, IWAppForm,
  meIWGrid, meIWButton, IWCompJQueryWidget, IWCompGrids;

type
  TWC002FStoriaDipendenteFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    JQStoriaDipendente: TIWJQueryWidget;
    grdStoriaDipendente: TmeIWGrid;
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure grdStoriaDipendenteRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    C006:TC006FStoriaDati;
    TestoDipendente:String;
    procedure CaricaScheda;
  public
    procedure VisualizzaScheda(M,Dato:String;Progressivo:Integer);
  end;

implementation

uses A000UInterfaccia;
{$R *.dfm}

procedure TWC002FStoriaDipendenteFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TWC002FStoriaDipendenteFM.grdStoriaDipendenteRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  (Self.Parent as TR010FPaginaWeb).RenderCell(ACell, ARow, AColumn, True, True);
end;

procedure TWC002FStoriaDipendenteFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
end;

procedure TWC002FStoriaDipendenteFM.VisualizzaScheda(M,Dato:String;Progressivo:Integer);
var MOld:String;
begin
  MOld:=WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString;
  if WR000DM.cdsAnagrafe.Locate('MATRICOLA',M,[]) then
  begin
    C006:=TC006FStoriaDati.Create(GGetWebApplicationThreadVar);
    C006.GetStoriaDato(Progressivo,dato);
    CaricaScheda;
    FreeAndNil(C006);
    Show;
    WR000DM.cdsAnagrafe.Locate('MATRICOLA',MOld,[]);

    (Self.Parent as TR010FPaginaWeb).VisualizzajQMessaggio(JQStoriaDipendente,Self.Width + 40,-1, EM2PIXEL * 50,TestoDipendente,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
  end;
end;

procedure TWC002FStoriaDipendenteFM.CaricaScheda;
var
  i:Integer;
begin
  TestoDipendente:=Format('%s %s - %s %s - %s %s',[
    WR000DM.cdsAnagrafe.FieldByName('COGNOME').AsString,
    WR000DM.cdsAnagrafe.FieldByName('NOME').AsString,
    A000TraduzioneStringhe('MATRICOLA'),
    WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString,
    A000TraduzioneStringhe('BADGE'),
    WR000DM.cdsAnagrafe.FieldByName('T430BADGE').AsString
    ]);

  grdStoriaDipendente.ColumnCount:=5;
  grdStoriaDipendente.RowCount:=C006.StoriaDipendente.Count + 1;
  grdStoriaDipendente.Cell[0,0].Text:='Dato';
  grdStoriaDipendente.Cell[0,1].Text:='Decorrenza';
  grdStoriaDipendente.Cell[0,2].Text:='Termine';
  grdStoriaDipendente.Cell[0,3].Text:='Valore';
  grdStoriaDipendente.Cell[0,4].Text:='';
  for i:=0 to C006.StoriaDipendente.Count - 1 do
  begin
    grdStoriaDipendente.Cell[i + 1,0].Text:=RecStoria(C006.StoriaDipendente[i]).NomeCampo;
    grdStoriaDipendente.Cell[i + 1,1].Text:=RecStoria(C006.StoriaDipendente[i]).DataDec;
    if RecStoria(C006.StoriaDipendente[i]).Fine = EncodeDate(3999,12,31) then
      grdStoriaDipendente.Cell[i + 1,2].Text:='Corrente'
    else
      grdStoriaDipendente.Cell[i + 1,2].Text:=RecStoria(C006.StoriaDipendente[i]).DataFine;
    grdStoriaDipendente.Cell[i + 1,3].Text:=RecStoria(C006.StoriaDipendente[i]).Valore;
    grdStoriaDipendente.Cell[i + 1,4].Text:=RecStoria(C006.StoriaDipendente[i]).Descrizione;
  end;
end;

end.