unit C001USizeStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Variants;

type
  TC001FSizeStampa = class(TForm)
    BtnNo: TButton;
    Button5: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EditLeft: TEdit;
    EditTop: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EditWidth: TEdit;
    EditHeight: TEdit;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnNoClick(Sender: TObject);
    procedure EditLeftKeyPress(Sender: TObject; var Key: Char);
    procedure EditLeftChange(Sender: TObject);
    procedure EditTopChange(Sender: TObject);
    procedure EditWidthChange(Sender: TObject);
    procedure EditHeightChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SizeLeft:integer;
    SizeTop:integer;
    SizeHeight:integer;
    SizeWidth:integer;
  end;

var
  C001FSizeStampa: TC001FSizeStampa;

implementation

{$R *.DFM}

procedure TC001FSizeStampa.BtnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TC001FSizeStampa.BtnNoClick(Sender: TObject);
begin
  Close;
end;

procedure TC001FSizeStampa.EditLeftKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8]) then
   key:=#0;
end;

procedure TC001FSizeStampa.EditLeftChange(Sender: TObject);
begin
  try
    SizeLeft:=StrToInt(EditLeft.text);
  except
  end;
end;

procedure TC001FSizeStampa.EditTopChange(Sender: TObject);
begin
  try
    SizeTop:=StrToInt(EditTop.text);
  except
  end;
end;

procedure TC001FSizeStampa.EditWidthChange(Sender: TObject);
begin
  try
    SizeWidth:=StrToInt(EditWidth.text);
  except
  end;
end;

procedure TC001FSizeStampa.EditHeightChange(Sender: TObject);
begin
  try
    SizeHeight:=StrToInt(EditHeight.text);
  except
  end;
end;

procedure TC001FSizeStampa.FormShow(Sender: TObject);
begin
  EditLeft.text:=IntToStr(SizeLeft);
  EditTop.text:=IntToStr(SizeTop);
  EditWidth.text:=IntToStr(SizeWidth);
  EditHeight.text:=IntToStr(SizeHeight);
end;

end.
