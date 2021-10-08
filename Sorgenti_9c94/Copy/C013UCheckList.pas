unit C013UCheckList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, checklst, Buttons, Menus, Variants, C180FunzioniGenerali;

type
  TC013FCheckList = class(TForm)
    clbListaDati: TCheckListBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    pmnFiltroDati: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure Selezionatutto1Click(Sender: TObject);
    procedure clbListaDatiClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMinElem, FMaxElem: Integer;
    function GetMinElem: Integer;
    procedure SetMinElem(Val: Integer);
    function GetMaxElem: Integer;
    procedure SetMaxElem(Val: Integer);
    procedure AbilitaPopupMenu;
    const MIN_ELEM_INI: Integer = 0;
    const MAX_ELEM_INI: Integer = System.MaxInt;
  public
    { Public declarations }
    property MinElem: Integer read GetMinElem write SetMinElem;
    property MaxElem: Integer read GetMaxElem write SetMaxElem;
  end;

var
  C013FCheckList: TC013FCheckList;

implementation

{$R *.DFM}

procedure TC013FCheckList.FormCreate(Sender: TObject);
begin
  FMinElem:=MIN_ELEM_INI;
  FMaxElem:=MAX_ELEM_INI;
  clbListaDati.OnClickCheck:=nil;
end;

procedure TC013FCheckList.AbilitaPopupMenu;
begin
  Selezionatutto1.Enabled:=(FMaxElem = MAX_ELEM_INI);
  Deselezionatutto1.Enabled:=(FMinElem = MIN_ELEM_INI);
  Invertiselezione1.Enabled:=(FMinElem = MIN_ELEM_INI) and (FMaxElem = MAX_ELEM_INI);
end;

function TC013FCheckList.GetMinElem: Integer;
begin
  Result:=FMinElem;
end;

procedure TC013FCheckList.SetMinElem(Val: Integer);
begin
  if Val < MIN_ELEM_INI then
    FMinElem:=MIN_ELEM_INI
  else if Val > FMaxElem then
    FMinElem:=FMaxElem
  else
    FMinElem:=Val;

  if (FMinElem = MIN_ELEM_INI) and
     (FMaxElem = MAX_ELEM_INI) then
  begin
    clbListaDati.OnClickCheck:=nil;
    AbilitaPopupMenu;
    Exit;
  end;

  clbListaDati.OnClickCheck:=clbListaDatiClickCheck;
  AbilitaPopupMenu;
end;

function TC013FCheckList.GetMaxElem: Integer;
begin
  Result:=FMaxElem;
end;

procedure TC013FCheckList.SetMaxElem(Val: Integer);
begin
  if Val > MAX_ELEM_INI then
    FMaxElem:=MAX_ELEM_INI
  else if Val < FMinElem then
    FMaxElem:=FMinElem
  else
    FMaxElem:=Val;

  if (FMinElem = MIN_ELEM_INI) and
     (FMaxElem = MAX_ELEM_INI) then
  begin
    clbListaDati.OnClickCheck:=nil;
    AbilitaPopupMenu;
    Exit;
  end;

  clbListaDati.OnClickCheck:=clbListaDatiClickCheck;
  AbilitaPopupMenu;
end;

procedure TC013FCheckList.clbListaDatiClickCheck(Sender: TObject);
var
  i, conta, index: Integer;
begin
  if (MinElem = MIN_ELEM_INI) and (MaxElem = MAX_ELEM_INI) then
    Exit;

  index:=TCheckListBox(Sender).ItemIndex;
  conta:=0;
  for i:=0 to TCheckListBox(Sender).Items.Count - 1 do
    if TCheckListBox(Sender).Checked[i] then
    begin
      conta:=conta + 1;
      // verifica limite superiore
      if conta > MaxElem then
      begin
        R180MessageBox('E'' consentito selezionare un massimo di ' + IntToStr(MaxElem) + ' voci!',INFORMA);
        TCheckListBox(Sender).Checked[index]:=False;
        Exit;
      end;
    end;

    // verifica limite inferiore
    if conta < MinElem then
    begin
      if MinElem = 1 then
        R180MessageBox('E'' necessario selezionare almeno una voce!',INFORMA)
      else
        R180MessageBox('E'' necessario selezionare almeno ' + IntToStr(MinElem) + ' voci!',INFORMA);
      TCheckListBox(Sender).Checked[index]:=True;
      Exit;
    end;
end;

procedure TC013FCheckList.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  with (pmnFiltroDati.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
    begin
      if Header[i] then
        Continue;
      if Sender = SelezionaTutto1 then
        Checked[i]:=True
      else if Sender = DeselezionaTutto1 then
        Checked[i]:=False
      else if Sender = InvertiSelezione1 then
        Checked[i]:=not Checked[i];
    end;
end;

end.
