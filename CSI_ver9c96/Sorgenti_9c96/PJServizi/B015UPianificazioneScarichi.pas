unit B015UPianificazioneScarichi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Variants;

type
  TB015FPianificazioneScarichi = class(TForm)
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B015FPianificazioneScarichi: TB015FPianificazioneScarichi;

implementation

uses R250UScaricoGiustificativiDtM;

{$R *.DFM}

end.
