unit P655UElencoDatiINPDAPMM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Variants;

type
  TP655FElencoDatiINPDAPMM = class(TForm)
    dgrdElencoCampi: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    procedure dgrdElencoCampiDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P655FElencoDatiINPDAPMM: TP655FElencoDatiINPDAPMM;

implementation

{$R *.DFM}

procedure TP655FElencoDatiINPDAPMM.dgrdElencoCampiDblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

end.
