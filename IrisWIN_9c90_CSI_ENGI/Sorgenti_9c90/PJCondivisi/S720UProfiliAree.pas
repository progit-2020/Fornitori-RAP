unit S720UProfiliAree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls,
  ToolWin, Mask, DBCtrls, Buttons, Grids, DBGrids, ExtCtrls,
  A000UCostanti, A000USessione, A000UInterfaccia, System.Actions;

type
  TS720FProfiliAree = class(TR004FGestStorico)
    Panel1: TPanel;
    dgrdProfiliAree: TDBGrid;
    lblDato1: TLabel;
    lblDato2: TLabel;
    lblDato3: TLabel;
    lblCodArea: TLabel;
    dtxtDescDato1: TDBText;
    dcmbDato1: TDBLookupComboBox;
    dcmbDato2: TDBLookupComboBox;
    dcmbDato3: TDBLookupComboBox;
    dcmbCodArea: TDBLookupComboBox;
    dtxtDescDato2: TDBText;
    dtxtDescDato3: TDBText;
    dtxtDescArea: TDBText;
    lblDecorrenzaFine: TLabel;
    dedtDecorrenzaFine: TDBEdit;
    lblDato4: TLabel;
    dtxtDescDato4: TDBText;
    dcmbDato4: TDBLookupComboBox;
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TInserClick(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  S720FProfiliAree: TS720FProfiliAree;

  procedure OpenS720FProfiliAree;

implementation

{$R *.dfm}

uses
  S720UProfiliAreeDtM;

procedure OpenS720FProfiliAree;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS720FProfiliAree') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TS720FProfiliAree, S720FProfiliAree);
  Application.CreateForm(TS720FProfiliAreeDtM, S720FProfiliAreeDtM);
  try
    Screen.Cursor:=crDefault;
    S720FProfiliAree.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S720FProfiliAree.Free;
    S720FProfiliAreeDtM.Free;
  end;
end;

procedure TS720FProfiliAree.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  S720FProfiliAreeDtM.selSG720.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
  dedtDecorrenza.SetFocus;
end;

procedure TS720FProfiliAree.KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
      begin
        (Sender as TDBLookupComboBox).Field.DataSet.FieldByName((Sender as TDBLookupComboBox).Field.KeyFields).Clear;
        (Sender as TDBLookupComboBox).Field.FocusControl;
      end
      else
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TS720FProfiliAree.TInserClick(Sender: TObject);
begin
  inherited;
  dedtDecorrenza.SetFocus;
end;

end.
