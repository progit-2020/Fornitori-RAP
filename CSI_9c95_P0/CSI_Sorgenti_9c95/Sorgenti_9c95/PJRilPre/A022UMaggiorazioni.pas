unit A022UMaggiorazioni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, DB, Variants;

type
  TA022FMaggiorazioni = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    EMaggiorazioni: TDBLookupComboBox;
    procedure EMaggiorazioniKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A022FMaggiorazioni: TA022FMaggiorazioni;

implementation

uses A022UContrattiDtM1;

{$R *.DFM}

procedure TA022FMaggiorazioni.DBGrid1DblClick(Sender: TObject);
{Se faccio doppio click sulla griglia carico automaticamente il LookupComboBox}
begin
  with A022FContrattiDtM1.T210 do
    EMaggiorazioni.KeyValue:=FieldByName('Codice').AsString;
end;

procedure TA022FMaggiorazioni.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = 13) then
    DBGrid1DblClick(Sender);
end;

procedure TA022FMaggiorazioni.EMaggiorazioniKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
