unit B008UGeneraPassword;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, C180FunzioniGenerali, Variants;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn2Click(Sender: TObject);
var L:TStringList;
begin
  if Edit1.Text <> Edit2.Text then
    raise Exception.Create('La password non è specificata correttamente!');
  L:=TStringList.Create;
  try
    L.Add(R180Cripta(Edit1.Text,20111972));
    L.SaveToFile('IrisWIN.INI');
  finally
    L.Free;
  end;
  Close;
end;

end.
