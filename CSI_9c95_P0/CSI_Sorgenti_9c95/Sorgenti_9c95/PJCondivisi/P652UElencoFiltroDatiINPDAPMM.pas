unit P652UElencoFiltroDatiINPDAPMM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, checklst, Buttons, Menus, Variants;

type
  TP652FElencoFiltroDatiINPDAPMM = class(TForm)
    clbListaDati: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    pmnFiltroDati: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure Selezionatutto1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P652FElencoFiltroDatiINPDAPMM: TP652FElencoFiltroDatiINPDAPMM;

implementation

{$R *.DFM}

procedure TP652FElencoFiltroDatiINPDAPMM.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with (pmnFiltroDati.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
end;

end.
