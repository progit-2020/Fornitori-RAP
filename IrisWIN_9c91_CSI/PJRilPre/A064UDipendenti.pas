unit A064UDipendenti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Menus, StdCtrls, Buttons, ExtCtrls, Clipbrd,
  C180FunzioniGenerali;

type
  TA064FDipendenti = class(TForm)
    dgrdRiepilogoAnagr: TDBGrid;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    Panel1: TPanel;
    BChiudi: TBitBtn;
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A064FDipendenti: TA064FDipendenti;

implementation

uses A064UBudgetStraordinarioDtM;

{$R *.dfm}

procedure TA064FDipendenti.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdRiepilogoAnagr,'S')
end;

procedure TA064FDipendenti.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdRiepilogoAnagr,'N')
end;

procedure TA064FDipendenti.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdRiepilogoAnagr,'C')
end;

procedure TA064FDipendenti.Copia2Click(Sender: TObject);
var S:String;
    i:Integer;
begin
  with dgrdRiepilogoAnagr.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdRiepilogoAnagr.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

end.
