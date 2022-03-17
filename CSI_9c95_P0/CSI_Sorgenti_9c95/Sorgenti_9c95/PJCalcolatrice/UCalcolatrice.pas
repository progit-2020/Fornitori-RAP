unit UCalcolatrice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, C180FunzioniGenerali, ExtCtrls, Variants;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    btnAdd: TButton;
    btnSub: TButton;
    btnUguale: TButton;
    btnAzzera: TButton;
    btnMolt: TButton;
    btnDiv: TButton;
    RadioGroup1: TRadioGroup;
    CheckBox1: TCheckBox;
    edtRisultato: TEdit;
    procedure btnAddClick(Sender: TObject);
    procedure btnSubClick(Sender: TObject);
    procedure btnUgualeClick(Sender: TObject);
    procedure btnAzzeraClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnMoltClick(Sender: TObject);
    procedure btnDivClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    Operazione:String;
    Risultato:Real;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Risultato:=0;
  Operazione:='';
  Edit1.Text:='00.00';
  edtRisultato.Text:='00.00';
end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
  btnUgualeClick(Sender);
  Operazione:='+';
end;

procedure TForm1.btnSubClick(Sender: TObject);
begin
  btnUgualeClick(Sender);
  Operazione:='-';
end;

procedure TForm1.btnMoltClick(Sender: TObject);
begin
  btnUgualeClick(Sender);
  Operazione:='*';
end;

procedure TForm1.btnDivClick(Sender: TObject);
begin
  btnUgualeClick(Sender);
  Operazione:='/';
end;

procedure TForm1.btnAzzeraClick(Sender: TObject);
begin
  Risultato:=0;
  Operazione:='';
  Edit1.Text:='00.00';
  edtRisultato.Text:='00.00';
end;

procedure TForm1.btnUgualeClick(Sender: TObject);
var App:Real;
begin
  if Pos('.',Edit1.Text) > 0 then
    App:=R180OreMinutiExt(Edit1.Text)
  else
    try
      App:=StrToFloat(Edit1.Text);
    except
      App:=0;
    end;

  if Operazione = '' then
  begin
    if Risultato = 0 then
      Risultato:=App;
  end
  else if Operazione = '+' then
    Risultato:=Risultato + App
  else if Operazione = '-' then
    Risultato:=Risultato - App
  else if Operazione = '*' then
    Risultato:=Risultato * App
  else if Operazione = '/' then
    Risultato:=Risultato / App;
  Edit1.Text:='';
  if RadioGroup1.ItemIndex = 0 then
    edtRisultato.Text:=R180MinutiOre(Trunc(Risultato))
  else
    edtRisultato.Text:=FloatToStr(Risultato);
  if Sender = btnUguale then
    Operazione:='';
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '+' then
    btnAddClick(btnAdd)
  else if Key = '-' then
    btnSubClick(btnSub)
  else if Key = '*' then
    btnMoltClick(btnMolt)
  else if Key = '/' then
    btnDivClick(btnDiv)
  else if Key in ['=',#13] then
    btnUgualeClick(btnUguale)
  else if Key = #27 then
    btnAzzeraClick(nil);
  if Key in ['+','-','=','*','/',#13,#27] then
      Key:=#0;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    Form1.FormStyle:=fsStayOnTop
  else
    Form1.FormStyle:=fsNormal;
end;

end.
