unit A037UFiltroVoci;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Menus, C180FunzioniGenerali, Buttons, ExtCtrls,
  A037UScaricoPaghe;

type
  TA037FFiltroVoci = class(TForm)
    lstFiltroVoci: TCheckListBox;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
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
    ListaVociOld,ListaVociNew:String;
  public
    { Public declarations }
  end;

var
  A037FFiltroVoci: TA037FFiltroVoci;

implementation

{$R *.dfm}

uses A037UScaricoPagheDtM1;

procedure TA037FFiltroVoci.Selezionatutto1Click(Sender: TObject);
var i: Integer;
begin
  for i:=0 to lstFiltroVoci.Items.Count - 1 do
    lstFiltroVoci.Checked[i]:=Sender = Selezionatutto1;
end;

procedure TA037FFiltroVoci.btnConfermaClick(Sender: TObject);
var i: Integer;
begin
  ListaVociNew:='';
  for i:=0 to lstFiltroVoci.Items.Count - 1 do
    if lstFiltroVoci.Checked[i] then
      ListaVociNew:=ListaVociNew + Trim(Copy(lstFiltroVoci.Items[i],1,LENGHT_VOCIPAGHE)) + ',';
  if (A037FScaricoPaghe.cmbSel.Text <> '')
  and (ListaVociNew <> ListaVociOld) then
    if R180MessageBox('Salvare le modifiche apportate sul filtro: ' + A037FScaricoPaghe.cmbSel.Text + '?',DOMANDA) = mrYes then
      A037FScaricoPaghe.actFiltro.Execute
    else
      Self.ModalResult:=mrCancel;
end;

procedure TA037FFiltroVoci.FormClose(Sender: TObject; var Action: TCloseAction);
var i: Integer;
  Voce: String;
begin
  if Self.ModalResult <> mrOk then
  begin
    for i:=0 to lstFiltroVoci.Items.Count - 1 do
      lstFiltroVoci.Checked[i]:=False;
    while Pos(',',ListaVociOld) > 0 do
    begin
      Voce:=Copy(ListaVociOld,1,Pos(',',ListaVociOld) - 1);
      for i:=0 to lstFiltroVoci.Items.Count - 1 do
        if Trim(Copy(lstFiltroVoci.Items[i],1,LENGHT_VOCIPAGHE)) = Voce then
        begin
          lstFiltroVoci.Checked[i]:=True;
          Break;
        end;
      ListaVociOld:=Copy(ListaVociOld,Pos(',',ListaVociOld) + 1);
    end;
  end;
end;

procedure TA037FFiltroVoci.FormCreate(Sender: TObject);
var i: Integer;
  Elemento: String;
begin
  Elemento:='%-' + IntToStr(LENGHT_VOCIPAGHE) + 's %s';
  i:=0;
  with A037FScaricoPagheDtM1.A037FScaricoPagheMW do
  begin
    selT193Filtro.Open;
    selT193Filtro.First;
    while not selT193Filtro.Eof do
    begin
      lstFiltroVoci.Items.Add(Format(Elemento,[selT193Filtro.FieldByName('COD_VOCE').AsString,selT193Filtro.FieldByName('DESCRIZIONE').AsString]));
      lstFiltroVoci.Checked[i]:=True;
      selT193Filtro.Next;
      i:=i + 1;
    end;
    selT193Filtro.Close;
  end;
end;

procedure TA037FFiltroVoci.FormShow(Sender: TObject);
var i: Integer;
begin
  ListaVociOld:='';
  for i:=0 to lstFiltroVoci.Items.Count - 1 do
    if lstFiltroVoci.Checked[i] then
      ListaVociOld:=ListaVociOld + Trim(Copy(lstFiltroVoci.Items[i],1,LENGHT_VOCIPAGHE)) + ',';
  btnConferma.SetFocus;
end;

end.
