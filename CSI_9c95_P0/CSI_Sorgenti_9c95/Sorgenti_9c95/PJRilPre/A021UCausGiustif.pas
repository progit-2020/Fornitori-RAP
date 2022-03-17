unit A021UCausGiustif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, Mask,
  DBCtrls, ActnList, ImgList, ToolWin, A019URaggrGiustif,
  A000UCostanti, A000USessione,A000UInterfaccia, A003UDataLavoroBis, C180FunzioniGenerali,
  Variants, System.Actions, System.ImageList;

type
  TA021FCausGiustif = class(TR001FGestTab)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    ScrollBox1: TScrollBox;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    DBEdit8: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit14: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBText1: TDBText;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    Label4: TLabel;
    ESigla: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    btnAssestAnnuo: TButton;
    DBCheckBox1: TDBCheckBox;
    dcbxInclusioneLimiteLiq: TDBCheckBox;
    dChkBancaNegativa: TDBCheckBox;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    btnDataMinAssest: TButton;
    procedure DBLookupComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EHMaxUnitarioChange(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAssestAnnuoClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnDataMinAssestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A021FCausGiustif: TA021FCausGiustif;

procedure OpenA021CausGiustif(Cod:String);

implementation

uses A021UCausGiustifDtM1, A021UAssestAnnuo;

{$R *.DFM}

procedure OpenA021CausGiustif(Cod:String);
{Causali di giustificazione}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA021CausGiustif') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A021FCausGiustif:=TA021FCausGiustif.Create(nil);
  with A021FCausGiustif do
  try
    A021FCausGiustifDtM1:=TA021FCausGiustifDtM1.Create(nil);
    DButton.DataSet:=A021FCausGiustifDtM1.T305;
    DButton.DataSet.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A021FCausGiustifDtM1.Free;
    Release;
  end;
end;

procedure TA021FCausGiustif.EHMaxUnitarioChange(Sender: TObject);
begin
  {Abblenco il campo se non contiene niente}
  if DButton.State in [dsInsert,dsEdit] then
    if (Trim((Sender as TDBEdit).Text) = '.') or (Trim((Sender as TDBEdit).Text) = '/') then
      (Sender as TDBEdit).Field.Clear;
end;

procedure TA021FCausGiustif.Nuovoelemento1Click(Sender: TObject);
{Dll di gestione Raggruppamenti giustificativi}
begin
  OpenA019RaggrGiustif(DBLookupComboBox1.Text);
  A021FCausGiustifDtM1.Q300.Close;
  A021FCausGiustifDtM1.Q300.Open;
end;

procedure TA021FCausGiustif.FormShow(Sender: TObject);
begin
  DButton.Dataset:=A021FCausGiustifDtM1.T305;
  inherited;
end;

procedure TA021FCausGiustif.btnAssestAnnuoClick(Sender: TObject);
begin
  A021FAssestAnnuo:=TA021FAssestAnnuo.Create(nil);
  with A021FAssestAnnuo do
  try
    if Trim(A021FCausGiustifDtM1.T305.FieldByName('ASSEST_ANNUO').AsString) <> '' then
    begin
      lstSerbatoi.Items.CommaText:=A021FCausGiustifDtM1.T305.FieldByName('ASSEST_ANNUO').AsString;
      chkAssestAnnuo.Checked:=True;
    end
    else
    begin
      lstSerbatoi.Items.CommaText:='CP,LP,CA,LA';
      chkAssestAnnuo.Checked:=False;
    end;
    if ShowModal = mrOK then
    begin
      if chkAssestAnnuo.Checked then
        A021FCausGiustifDtM1.T305.FieldByName('ASSEST_ANNUO').AsString:=lstSerbatoi.Items.CommaText
      else
        A021FCausGiustifDtM1.T305.FieldByName('ASSEST_ANNUO').Clear;
    end;
  finally;
    Release;
  end;
end;

procedure TA021FCausGiustif.DButtonStateChange(Sender: TObject);
begin
  inherited;
  btnAssestAnnuo.Enabled:=DButton.State in [dsEdit,dsInsert];
  btnDataMinAssest.Enabled:=DButton.State in [dsEdit,dsInsert];
end;

procedure TA021FCausGiustif.btnDataMinAssestClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  with A021FCausGiustifDtM1.T305 do
  begin
    D:=DataOut(FieldByName('DATA_MIN_ASSEST').AsDateTime,'','M');
    if not(FieldByName('DATA_MIN_ASSEST').IsNull and (D = EncodeDate(1899,12,30))) then
      FieldByName('DATA_MIN_ASSEST').AsDateTime:=R180InizioMese(D);
  end;
end;

procedure TA021FCausGiustif.DBLookupComboBox1KeyDown(Sender: TObject;
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
