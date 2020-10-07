unit A008UListaGriglia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Variants, ExtCtrls;

type
  TA008FListaGriglia = class(TForm)
    Lista: TListBox;
    pnlPulsanti: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure ListaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A008FListaGriglia: TA008FListaGriglia;

implementation

{$R *.DFM}

procedure TA008FListaGriglia.ListaDblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

end.
