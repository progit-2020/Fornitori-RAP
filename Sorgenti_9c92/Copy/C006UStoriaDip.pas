unit C006UStoriaDip;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Buttons, DBCtrls, ExtCtrls, Variants, OracleData, Db,
  Menus, C180FunzioniGenerali;

type
  //Contiene i nomi dei campi e l'indicazione se devono essere colorati
  TElencoStorici = record
    NomeCampo:String;
    Colore:boolean;
  end;

  TC006FStoriaDip = class(TForm)
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Grid: TStringGrid;
    btnStampa: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    pmnuVaiADecorrenza: TPopupMenu;
    Posizionasullostoricoselezionato1: TMenuItem;
    N1: TMenuItem;
    CopiainExcel1: TMenuItem;
    procedure btnStampaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure Posizionasullostoricoselezionato1Click(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sP,TipoDato:String;
    ElencoStorici: array of TElencoStorici;
    AbilitaMenu, SpostaStorico: Boolean;
  end;

var
  C006FStoriaDip: TC006FStoriaDip;

implementation

{$R *.DFM}

procedure TC006FStoriaDip.FormCreate(Sender: TObject);
{Scrivo le intestazioni della colonna}
begin
  Grid.Cells[0,0]:='Dato';
  Grid.Cells[1,0]:='Decorrenza';
  Grid.Cells[2,0]:='Termine';
  Grid.Cells[3,0]:='Valore';
  Grid.ColWidths[0]:=220;
  Grid.ColWidths[1]:=70;
  Grid.ColWidths[2]:=70;
  Grid.ColWidths[4]:=350;
  TipoDato:='';
end;

procedure TC006FStoriaDip.FormShow(Sender: TObject);
var
  i: Integer;
  NoDesc:Boolean;
begin
  pmnuVaiADecorrenza.Items[0].Enabled:=AbilitaMenu;

  NoDesc:=True;
  if TipoDato <> '' then
  begin
    for i:=0 to Grid.RowCount - 1 do
    begin
      NoDesc:=Grid.Cells[4,i] = '';
      if not NoDesc then
        Break;
    end;
    if (TipoDato = 'INIZIO') or (TipoDato = 'INIZIO_IND_MAT') then
      Grid.Cells[4,0]:='Fine'
    else if NoDesc then
      Grid.Cells[4,0]:=''
    else
      Grid.Cells[4,0]:='Descrizione';
  end;

end;

procedure TC006FStoriaDip.GridDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var i: Integer;
begin
  if gdFixed in State then exit;
  if Length(ElencoStorici) = 0 then
    exit;
  for i:=1 to Grid.RowCount do
    if Grid.Cells[0,ARow] = ElencoStorici[i].NomeCampo then
      break;
  if ElencoStorici[i].Colore then
  begin
    Grid.Canvas.Brush.Color:=$00FFFF80;
    Grid.Canvas.Font.Color:=clWindowText;
    Grid.Canvas.FillRect(Rect);
    Grid.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,Grid.Cells[Acol,ARow]);
  end;
end;

procedure TC006FStoriaDip.Posizionasullostoricoselezionato1Click(Sender: TObject);
begin
  SpostaStorico:=True;
  C006FStoriaDip.Close;
end;

procedure TC006FStoriaDip.CopiainExcel1Click(Sender: TObject);
begin
  R180StringGridCopyToClipboard(Grid);
end;

procedure TC006FStoriaDip.btnStampaClick(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Self.Print;
end;

end.
