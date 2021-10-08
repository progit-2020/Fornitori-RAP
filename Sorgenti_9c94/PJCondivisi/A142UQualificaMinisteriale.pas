unit A142UQualificaMinisteriale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICO, Grids, DBGrids, ExtCtrls, Menus, DBCtrls, ImgList, Db,
  ComCtrls, ToolWin, StdCtrls, Mask, Buttons,
  A000UCostanti, A000USessione,A000UInterfaccia, A002UInterfacciaSt, C001UFiltroTabelle,
  C001UFiltroTabelleDtM, C001UScegliCampi, OracleData,
  ActnList, SelAnagrafe, Variants, System.Actions;

type
  TA142FQualificaMinisteriale = class(TR004FGestStorico)
    ScrollBox1: TScrollBox;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dgrdElenco: TDBGrid;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    dedtProgressivo: TDBEdit;
    lblProgressivo: TLabel;
    lblDebitoGg: TLabel;
    dedtDebitoGg: TDBEdit;
    dcmbMacroCategoria: TDBComboBox;
    lblMacroCategoria: TLabel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    procedure dcmbMacroCategoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A142FQualificaMinisteriale: TA142FQualificaMinisteriale;

procedure OpenA142QualificaMinisteriale(Cod:String);

implementation

uses A142UQualificaMinisterialeDtM;

{$R *.DFM}

procedure OpenA142QualificaMinisteriale(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA142FQualificaMinisteriale') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A142FQualificaMinisteriale:=TA142FQualificaMinisteriale.Create(nil);
  with A142FQualificaMinisteriale do
  try
    A142FQualificaMinisterialeDtM:=TA142FQualificaMinisterialeDtM.Create(nil);
    A142FQualificaMinisterialeDtM.selT470.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A142FQualificaMinisterialeDtM.Free;
    Free;
  end;
end;

procedure TA142FQualificaMinisteriale.dcmbMacroCategoriaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
    if (Sender as TDBComboBox).Field <> nil then
      if (Sender as TDBComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBComboBox).Field.Clear;
end;

end.
