unit A047UAccessoManuale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Buttons, Variants;

type
  TA047FAccessoManuale = class(TForm)
    Label1: TLabel;
    rgpPasto: TRadioGroup;
    cmbCausali: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    cmbRilevatori: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Causale,PranzoCena,Rilevatore:String;
  end;

var
  A047FAccessoManuale: TA047FAccessoManuale;

implementation

uses A047UTimbMensaDtM1;

{$R *.DFM}

procedure TA047FAccessoManuale.FormShow(Sender: TObject);
var i:Integer;
begin
  cmbCausali.Items.Clear;
  cmbCausali.Items.Add(Format('%-5s %s',['*','Senza causale']));
  with A047FTimbMensaDtM1.A047FTimbMensaMW.Q305 do
  begin
    First;
    while not Eof do
    begin
      cmbCausali.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  cmbRilevatori.Items.Clear;
  cmbRilevatori.Items.Add(Format('   %s',['Senza rilevatore']));
  with A047FTimbMensaDtM1.A047FTimbMensaMW.QOrologi do
  begin
    First;
    while not Eof do
    begin
      cmbRilevatori.Items.Add(Format('%-2s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
  if PranzoCena = 'P' then
    rgpPasto.ItemIndex:=0
  else
    rgpPasto.ItemIndex:=1;
  for i:=0 to cmbCausali.Items.Count - 1 do
    if Trim(Copy(cmbCausali.Items[i],1,5)) = Causale then
    begin
      cmbCausali.ItemIndex:=i;
      Break;
    end;
  for i:=0 to cmbRilevatori.Items.Count - 1 do
    if Trim(Copy(cmbRilevatori.Items[i],1,2)) = Rilevatore then
    begin
      cmbRilevatori.ItemIndex:=i;
      Break;
    end;
end;

procedure TA047FAccessoManuale.BitBtn1Click(Sender: TObject);
begin
  Causale:=Trim(Copy(cmbCausali.Items[cmbCausali.ItemIndex],1,5));
  Rilevatore:=Trim(Copy(cmbRilevatori.Items[cmbRilevatori.ItemIndex],1,2));
  if rgpPasto.ItemIndex = 0 then
    PranzoCena:='P'
  else
    PranzoCena:='C';
end;

end.
