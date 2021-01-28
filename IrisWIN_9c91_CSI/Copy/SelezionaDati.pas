unit SelezionaDati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Variants;

type
  TFSelezionaDati = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button5: TBitBtn;
    Button6: TBitBtn;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    procedure ScambiaSelezionati(list1,list2:TListBox);
    procedure ScambiaTutti(btn2,btn3:tbutton;list1,list2:tlistbox);
    procedure ClikkaLista(list1:tlistbox;btn1,btn2:Tbutton);
  public
    { Public declarations }
  end;

var
  FSelezionaDati: TFSelezionaDati;

implementation

{$R *.DFM}

procedure TFSelezionaDati.ScambiaSelezionati(list1,list2:TListBox);
var i:integer;
    elementi:integer;
begin
     elementi:=list1.items.count;
     if list1.selcount < 1 then
        showmessage('Nessun campo selezionato')
     else begin
        i:=0;
        while i<=(elementi-1) do
            if list1.selected[i] then begin
               if list2.items.indexof
                  (list1.items[i])=(-1)then
                   list2.items.AddObject(list1.items[i],List1.Items.Objects[i]);
               list1.items.delete(i);
               elementi:=elementi-1;
               end else i:=i+1;
     end;
     Button1.Enabled:=False;
     Button2.Enabled:=ListBox1.Items.Count>0;
     Button3.Enabled:=ListBox2.Items.Count>0;
     Button4.Enabled:=False;
end;

procedure TFSelezionaDati.ScambiaTutti(btn2,btn3:tbutton;list1,list2:tlistbox);
var i:integer;
begin
     for i:=1 to list1.items.count do
         list2.items.AddObject(list1.items[i-1],List1.Items.Objects[i-1]);
     btn2.enabled:=false;
     btn3.enabled:=true;
     list1.items.clear;
end;

procedure TFSelezionaDati.ClikkaLista(list1:tlistbox;btn1,btn2:Tbutton);
begin
  btn1.enabled:=List1.Selcount>0;
  Button2.Enabled:=ListBox1.Items.Count>0;
  Button3.Enabled:=ListBox2.Items.Count>0;
end;

procedure TFSelezionaDati.Button2Click(Sender: TObject);
begin
     ScambiaTutti(button2,button3,listbox1,listbox2);
end;

procedure TFSelezionaDati.Button3Click(Sender: TObject);
begin
     ScambiaTutti(button3,button2,listbox2,listbox1);
end;

procedure TFSelezionaDati.ListBox1Click(Sender: TObject);
begin
     ClikkaLista(listbox1,button1,button2);
end;

procedure TFSelezionaDati.ListBox2Click(Sender: TObject);
begin
  ClikkaLista(listbox2,button4,button3);
end;

procedure TFSelezionaDati.Button1Click(Sender: TObject);
begin
  ScambiaSelezionati(listbox1,listbox2);
end;

procedure TFSelezionaDati.Button4Click(Sender: TObject);
begin
     ScambiaSelezionati(listbox2,listbox1);
end;


procedure TFSelezionaDati.FormActivate(Sender: TObject);
begin
  button1.enabled:=false;
  button2.enabled:=ListBox1.Items.Count>0;
  button3.enabled:=false;
  button4.enabled:=ListBox2.Items.Count>0;
end;

end.
