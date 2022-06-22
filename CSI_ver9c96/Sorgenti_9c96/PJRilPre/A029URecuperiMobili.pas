unit A029URecuperiMobili;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, StdCtrls, ExtCtrls;

type
  TA029FRecuperiMobili = class(TForm)
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    lblCarenze: TLabel;
    lblSaldo: TLabel;
    lblSaldoAttuale: TLabel;
    grdRecuperiMobili: TStringGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A029FRecuperiMobili: TA029FRecuperiMobili;

implementation

{$R *.dfm}

end.
