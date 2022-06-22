unit A002UCercaCampo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Buttons, DBCtrls, ExtCtrls, Variants, OracleData, Db,
  Menus;

type
  //Contiene i nomi dei campi e l'indicazione se devono essere colorati
  TElencoCampi = record
    Etichetta,
    NomeDato,
    Ridefinito,
    Pagina:String;
    PageIndex,
    iLayout,
    iLinkComp:Integer;
    Colore:boolean;
  end;

  TA002FCercaCampo = class(TForm)
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Grid: TStringGrid;
    btnStampa: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure btnStampaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure GridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ElencoCampi: array of TElencoCampi;
    Dato: String;
  end;

var
  A002FCercaCampo: TA002FCercaCampo;

implementation

{$R *.DFM}

procedure TA002FCercaCampo.FormCreate(Sender: TObject);
{Scrivo le intestazioni della colonna}
begin
  SetLength(ElencoCampi,0);
  Grid.Cells[0,0]:='Etichetta';
  Grid.Cells[1,0]:='Nome dato';
  Grid.Cells[2,0]:='Ridefinito';
  Grid.Cells[3,0]:='Pagina';
end;

procedure TA002FCercaCampo.GridDblClick(Sender: TObject);
begin
  Dato:=Grid.Cells[1,Grid.Row];
  A002FCercaCampo.Close;
end;

procedure TA002FCercaCampo.GridDrawCell(Sender: TObject; ACol,ARow: Integer; Rect: TRect; State: TGridDrawState);
var i: Integer;
begin
  if gdFixed in State then exit;
  if Length(ElencoCampi) = 0 then
    exit;
  for i:=1 to Grid.RowCount - 1 do
    if Grid.Cells[1,ARow] = ElencoCampi[i - 1].NomeDato then
      break;
  if ElencoCampi[i - 1].Colore then
  begin
    Grid.Canvas.Brush.Color:=$00FFFF80;
    Grid.Canvas.Font.Color:=clWindowText;
    Grid.Canvas.FillRect(Rect);
    Grid.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,Grid.Cells[Acol,ARow]);
  end;
end;

procedure TA002FCercaCampo.btnStampaClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Self.Print;
end;

end.
