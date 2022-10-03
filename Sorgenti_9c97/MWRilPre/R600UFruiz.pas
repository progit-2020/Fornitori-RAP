unit R600UFruiz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, Variants;

type
  TR600FFruiz = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    LNome: TLabel;
    Causale: TLabel;
    Riferimento: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  R600FFruiz: TR600FFruiz;

implementation

{$R *.DFM}

end.
