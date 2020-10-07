unit A056UGrigliaCicli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls, Variants;

type
  TA056FGrigliaCicli = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CaricaGriglia(Turno1,Turno2,Orario,Causale:TStringList);
  end;

var
  A056FGrigliaCicli: TA056FGrigliaCicli;

implementation

{$R *.DFM}

procedure TA056FGrigliaCicli.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='N.Giorno';
  StringGrid1.Cells[1,0]:='Turno1';
  StringGrid1.Cells[2,0]:='Turno2';
  StringGrid1.Cells[3,0]:='Orario';
  StringGrid1.Cells[4,0]:='Assenza';
end;

procedure TA056FGrigliaCicli.CaricaGriglia(Turno1,Turno2,Orario,Causale:TStringList);
var i:Integer;
begin
  with StringGrid1 do
  begin
    RowCount:=Turno1.Count + 1;
    for i:=0 to Turno1.Count - 1 do
    begin
      Cells[0,i+1]:=IntToStr(i);
      Cells[1,i+1]:=Turno1[i];
      Cells[2,i+1]:=Turno2[i];
      Cells[3,i+1]:=Orario[i];
      Cells[4,i+1]:=Causale[i];
    end;
  end;
end;

procedure TA056FGrigliaCicli.StringGrid1DblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

end.
