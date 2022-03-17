unit C001UAllineaStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, C001StampaLib, Variants;

type
  TC001FAllineaStampa = class(TForm)
    ListBoxOggetti: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    LblOggetto: TLabel;
    Label3: TLabel;
    BtnOk: TButton;
    Button2: TButton;
    CmbAllinea: TComboBox;
    procedure CmbAllineaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    Chiudi:boolean;
  public
    { Public declarations }
    procedure CaricaListBox(var Vett:ArrayStampa;Num:integer;RecStampa:Rec_Stampa);
    function GetAlignType:integer;
    function GetAlignObjName:string;
  end;

var
  C001FAllineaStampa: TC001FAllineaStampa;

implementation

{$R *.DFM}

procedure TC001FAllineaStampa.CaricaListBox(var Vett:ArrayStampa;Num:integer;RecStampa:Rec_Stampa);
var i:integer;
begin
  LblOggetto.caption:=RecStampa.NomeOggetto;
  ListBoxOggetti.Clear;
  for i:=1 to Num do
      if (Vett[i].Banda=RecStampa.Banda) and
         (Vett[i].NomeOggetto<>RecStampa.NomeOggetto) Then
           ListBoxOggetti.Items.Add(Vett[i].NomeOggetto);
  CmbAllinea.ItemIndex:=-1;
end;

procedure TC001FAllineaStampa.CmbAllineaKeyPress(Sender: TObject; var Key: Char);
begin
  Key:=#0;
end;

procedure TC001FAllineaStampa.BtnOkClick(Sender: TObject);
begin

  if CmbAllinea.ItemIndex<0 then
     begin
       showmessage('Errore. Nessun tipo di allineamento è stato selezionato!');
       Chiudi:=false;
     end
  else
     if ListBoxOggetti.ItemIndex<0 then
        begin
          showmessage('Errore. Non è stato selezionato l''oggetto a cui allineare!');
          Chiudi:=false;
        end
     else
        Chiudi:=true;
end;

procedure TC001FAllineaStampa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Chiudi then
     Action:=caNone;
end;

procedure TC001FAllineaStampa.Button2Click(Sender: TObject);
begin
  Chiudi:=true;
end;

function TC001FAllineaStampa.GetAlignType:integer;
begin
  result:=aTop;
  case CmbAllinea.ItemIndex of
   0:result:=aTop;
   1:result:=aLeft;
   2:result:=aRight;
   3:result:=aBottom;
   4:result:=aTopLine;
   5:result:=aBaseLine;
   6:result:=aLeftSide;
   7:result:=aRightSide;
  end;
end;

function TC001FAllineaStampa.GetAlignObjName:string;
begin
  Result:=ListBoxOggetti.Items[ListBoxOggetti.ItemIndex];
end;

end.

