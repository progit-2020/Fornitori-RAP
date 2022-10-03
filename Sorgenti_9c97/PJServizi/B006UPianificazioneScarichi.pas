unit B006UPianificazioneScarichi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Variants;

type
  TB006FPianificazioneScarichi = class(TForm)
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B006FPianificazioneScarichi: TB006FPianificazioneScarichi;

implementation

uses R200UScaricoTimbratureDtM;

{$R *.DFM}

end.
