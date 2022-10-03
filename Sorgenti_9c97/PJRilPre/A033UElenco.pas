unit A033UElenco;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, checklst, Buttons, ExtCtrls, Menus, Variants;

type
  TA033FElenco = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Anomalie1: TCheckListBox;
    Anomalie2: TCheckListBox;
    Anomalie3: TCheckListBox;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A033FElenco: TA033FElenco;

implementation

{$R *.DFM}

procedure TA033FElenco.FormCreate(Sender: TObject);
begin
  Anomalie1.Align:=alClient;
  Anomalie2.Align:=alClient;
  Anomalie3.Align:=alClient;
end;

procedure TA033FElenco.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with (PopupMenu1.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=Sender = SelezionaTutto1;
end;

end.
