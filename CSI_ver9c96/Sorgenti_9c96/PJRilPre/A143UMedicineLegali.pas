unit A143UMedicineLegali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  DBCtrls, StdCtrls, Mask, Grids, DBGrids, ExtCtrls,
  A000UCostanti, A000USessione, A011UComuniProvinceRegioni, OracleData;

type
  TA143FMedicineLegali = class(TR001FGestTab)
    dgrdMedicineLegali: TDBGrid;
    pnlDatiMedicinaLegale: TPanel;
    Label1: TLabel;
    dedtCodice: TDBEdit;
    Label3: TLabel;
    dcmbComune: TDBLookupComboBox;
    dedtComune: TDBEdit;
    dedtCap: TDBEdit;
    Label5: TLabel;
    Label2: TLabel;
    dedtDescrizione: TDBEdit;
    Label4: TLabel;
    dedtIndirizzo: TDBEdit;
    Label6: TLabel;
    dedtTelefono: TDBEdit;
    Label7: TLabel;
    dedtEmail: TDBEdit;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure dcmbComuneKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A143FMedicineLegali: TA143FMedicineLegali;
  procedure OpenA143MedicineLegali(Codice: String);

implementation

uses A143UMedicineLegaliDtm;

{$R *.dfm}

{ procedura Open }
procedure OpenA143MedicineLegali(Codice: String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA143MedicineLegali') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA143FMedicineLegali, A143FMedicineLegali);
  Application.CreateForm(TA143FMedicineLegaliDtm, A143FMedicineLegaliDtM);
  A143FMedicineLegaliDtm.selT485.SearchRecord('CODICE',Codice,[srFromBeginning]);
  try
    Screen.Cursor:=crDefault;
    A143FMedicineLegali.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A143FMedicineLegali.Free;
    A143FMedicineLegaliDtM.Free;
  end;
end;

procedure TA143FMedicineLegali.DButtonStateChange(Sender: TObject);
begin
  inherited;
  A143FMedicineLegali.dedtCodice.ReadOnly:= (DButton.State in [dsEdit]);
end;

procedure TA143FMedicineLegali.dcmbComuneKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
  begin
    A143FMedicineLegaliDtM.selT485COD_COMUNE.AsString:='';
    A143FMedicineLegaliDtM.selT485CAP.AsString:='';
  end;
end;

procedure TA143FMedicineLegali.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A143FMedicineLegaliDtm.selT485;
  inherited;
end;

procedure TA143FMedicineLegali.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  with A143FMedicineLegaliDtm.selT480 do
  begin
    OpenA011ComuniProvinceRegioni(FieldByName('CODICE').AsString,'C');
    DisableControls;
    Refresh;
    EnableControls;
  end;
end;

end.
