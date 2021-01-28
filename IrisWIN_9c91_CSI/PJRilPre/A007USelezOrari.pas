unit A007USelezOrari;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Buttons, ExtCtrls, Variants;

type
  TA007FSelezOrari = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBLookupListBox1: TDBLookupListBox;
    procedure DBLookupListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A007FSelezOrari: TA007FSelezOrari;

implementation

uses A007UProfiliOrariDtM1;

{$R *.DFM}

procedure TA007FSelezOrari.DBLookupListBox1DblClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.
