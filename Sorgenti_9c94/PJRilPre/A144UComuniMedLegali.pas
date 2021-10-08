unit A144UComuniMedLegali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, StdCtrls, Mask, DBCtrls, ActnList, ImgList, DB, Menus,
  ComCtrls, ToolWin, Grids, DBGrids, ExtCtrls,
  A000UCostanti, A000USessione, OracleData, A011UComuniProvinceRegioni, A143UMedicineLegali,
  System.Actions;

type
  TA144FComuniMedLegali = class(TR001FGestTab)
    dgrdComuniMedLegali: TDBGrid;
    pnlDatiAssociazione: TPanel;
    lblMedLegale: TLabel;
    dlblMedLegale: TDBText;
    dcmbMedLegale: TDBLookupComboBox;
    lblComune: TLabel;
    dcmbComune: TDBLookupComboBox;
    dedtComune: TDBEdit;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure dcmbMedLegaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A144FComuniMedLegali: TA144FComuniMedLegali;

procedure OpenA144ComuniMedLegali;
  
implementation

uses A144UComuniMedLegaliDtm;

{$R *.dfm}

{ procedura Open }
procedure OpenA144ComuniMedLegali;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA144ComuniMedLegali') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA144FComuniMedLegali, A144FComuniMedLegali);
  Application.CreateForm(TA144FComuniMedLegaliDtM, A144FComuniMedLegaliDtM);
  try
    Screen.Cursor:=crDefault;
    A144FComuniMedLegali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A144FComuniMedLegali.Free;
    A144FComuniMedLegaliDtM.Free;
  end;
end;

procedure TA144FComuniMedLegali.dcmbMedLegaleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  // gestione pulizia campo
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;

  // nel caso di cancellazione, pulisce anche i campi collegati
  if dcmbComune.Text = '' then
    A144FComuniMedLegaliDtM.selT486COD_COMUNE.AsString:='';
end;

procedure TA144FComuniMedLegali.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A144FComuniMedLegaliDtm.selT486;
  dcmbMedLegale.ListSource:=A144FComuniMedLegaliDtm.A144FComuniMedLegaliMW.dscT485;
end;

procedure TA144FComuniMedLegali.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if PopupMenu1.PopupComponent = dcmbMedLegale then
  begin
    // apre la gestione delle medicine legali
    with A144FComuniMedLegaliDtm.A144FComuniMedLegaliMW.selT485 do
    begin
      OpenA143MedicineLegali(FieldByName('CODICE').AsString);
      DisableControls;
      Refresh;
      EnableControls;
    end;
  end
  else if PopupMenu1.PopupComponent = dcmbComune then
  begin
    with A144FComuniMedLegaliDtm.A144FComuniMedLegaliMW.selT480 do
    begin
      OpenA011ComuniProvinceRegioni(FieldByName('CODICE').AsString,'C');
      DisableControls;
      Refresh;
      EnableControls;
    end;
  end;
end;

end.
