unit A062UAccessoDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TA062FAccessoDB = class(TForm)
    edtUserName: TEdit;
    edtPassWord: TEdit;
    lblUserName: TLabel;
    lblPassWord: TLabel;
    btnOk: TBitBtn;
    btnAbort: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A062FAccessoDB: TA062FAccessoDB;

implementation

{$R *.dfm}

end.
