unit C001URicerca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, StdCtrls, Buttons, Variants;

type
  TC001FRicerca = class(TForm)
    Grid: TStringGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    chkFiltro: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  C001FRicerca: TC001FRicerca;

implementation

{$R *.DFM}

procedure TC001FRicerca.FormCreate(Sender: TObject);
begin
  Grid.Cells[0,0]:='Nome dato';
  Grid.Cells[1,0]:='Valore';
end;
procedure TC001FRicerca.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13) and (Shift = []) then
    ModalResult:=mrOK;
end;

end.
 
