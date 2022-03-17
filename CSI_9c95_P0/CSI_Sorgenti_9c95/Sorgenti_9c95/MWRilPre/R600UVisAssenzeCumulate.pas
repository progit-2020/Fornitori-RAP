unit R600UVisAssenzeCumulate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Variants, Menus, C180FunzioniGenerali;

type
  TR600FVisAssenzeCumulate = class(TForm)
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    StampaVideata1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Copiainexcel1: TMenuItem;
    procedure StampaVideata1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Copiainexcel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  R600FVisAssenzeCumulate: TR600FVisAssenzeCumulate;
  R600FVisPeriodiCumulati: TR600FVisAssenzeCumulate;

implementation

{$R *.DFM}

procedure TR600FVisAssenzeCumulate.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount:=8;
  StringGrid1.ColWidths[0]:=40;
  StringGrid1.ColWidths[2]:=55;
  StringGrid1.ColWidths[3]:=30;
  StringGrid1.ColWidths[5]:=40;
  StringGrid1.ColWidths[6]:=45;
  StringGrid1.ColWidths[7]:=74;
  StringGrid1.Cells[1,0]:='Data';
  StringGrid1.Cells[2,0]:='Causale';
  StringGrid1.Cells[3,0]:='Tipo';
  StringGrid1.Cells[4,0]:='Ore';
  StringGrid1.Cells[5,0]:='Valore';
  StringGrid1.Cells[6,0]:='Coniuge'; //Lorena 3/12/2002
  StringGrid1.Cells[7,0]:='Richiesta web';
end;

procedure TR600FVisAssenzeCumulate.Copiainexcel1Click(Sender: TObject);
begin
  R180StringGridCopyToClipboard(StringGrid1);
end;

procedure TR600FVisAssenzeCumulate.StampaVideata1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Self.Print;
end;

end.
