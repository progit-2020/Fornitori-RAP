unit A037UFiltroCodInterni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons, Menus, CheckLst, A000UCostanti, ExtCtrls, Variants,
  A037UScaricoPaghe;

type
  TA037FFiltroCodInterni = class(TForm)
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    lstFiltroCodInterni: TCheckListBox;
    Panel1: TPanel;
    btnConferma: TBitBtn;
    btnAnnulla: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    ListaCodiciOld,ListaCodiciNew:String;
  public
    { Public declarations }
  end;

var
  A037FFiltroCodInterni: TA037FFiltroCodInterni;

implementation

{$R *.DFM}

procedure TA037FFiltroCodInterni.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
    lstFiltroCodInterni.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TA037FFiltroCodInterni.btnConfermaClick(Sender: TObject);
var i: Integer;
begin
  ListaCodiciNew:='';
  for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
    if lstFiltroCodInterni.Checked[i] then
      ListaCodiciNew:=ListaCodiciNew + Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI)) + ',';
  if (A037FScaricoPaghe.cmbSel.Text <> '')
  and (ListaCodiciNew <> ListaCodiciOld) then
    if MessageDlg('Salvare le modifiche apportate sul filtro: ' + A037FScaricoPaghe.cmbSel.Text + '?', mtConfirmation, [mbYes,mbNo],0) = mrYes then
      A037FScaricoPaghe.actFiltro.Execute
    else
      Self.ModalResult:=mrCancel;
end;

procedure TA037FFiltroCodInterni.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i: Integer;
  Codice: String;
begin
  if Self.ModalResult <> mrOk then
  begin
    for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
      lstFiltroCodInterni.Checked[i]:=False;
    while Pos(',',ListaCodiciOld) > 0 do
    begin
      Codice:=Copy(ListaCodiciOld,1,Pos(',',ListaCodiciOld) - 1);
      for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
        if Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI)) = Codice then
        begin
          lstFiltroCodInterni.Checked[i]:=True;
          Break;
        end;
      ListaCodiciOld:=Copy(ListaCodiciOld,Pos(',',ListaCodiciOld) + 1);
    end;
  end;
end;

procedure TA037FFiltroCodInterni.FormCreate(Sender: TObject);
var
  i:Integer;
  Elemento: String;
begin
  Elemento:='%-' + IntToStr(LENGTH_CODINTERNI) + 's %s';
  for i:=1 to High(VettConst) do
  begin
    lstFiltroCodInterni.Items.Add(Format(Elemento,[VettConst[i].CodInt,VettConst[i].Descrizione]));
    lstFiltroCodInterni.Checked[i - 1]:=True;
  end;
end;

procedure TA037FFiltroCodInterni.FormShow(Sender: TObject);
var i: Integer;
begin
  ListaCodiciOld:='';
  for i:=0 to lstFiltroCodInterni.Items.Count - 1 do
    if lstFiltroCodInterni.Checked[i] then
      ListaCodiciOld:=ListaCodiciOld + Trim(Copy(lstFiltroCodInterni.Items[i],1,LENGTH_CODINTERNI)) + ',';
  btnConferma.SetFocus;
end;

end.
