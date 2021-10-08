unit A080USaldiAbbattuti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Variants;

type
  TA080FSaldiAbbattuti = class(TForm)
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A080FSaldiAbbattuti: TA080FSaldiAbbattuti;

implementation

uses A080UModConteDtM1;

{$R *.DFM}

end.
