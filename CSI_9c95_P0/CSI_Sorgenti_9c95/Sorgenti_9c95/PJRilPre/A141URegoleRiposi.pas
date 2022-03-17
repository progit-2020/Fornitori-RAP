unit A141URegoleRiposi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  ExtCtrls, StdCtrls, CheckLst, Mask, DBCtrls, A000UCostanti, A000USessione,A000UInterfaccia,
  C180FunzioniGenerali, A016UCausAssenze;

type
  TA141FRegoleRiposi = class(TR001FGestTab)
    Panel2: TPanel;
    Panel5: TPanel;
    dCmbCodice: TDBLookupComboBox;
    DBEdit1: TDBEdit;
    lblRiposo: TLabel;
    lblRipComp: TLabel;
    LblSel1: TLabel;
    LblSel2: TLabel;
    lblRipMesePrec: TLabel;
    lblSel3: TLabel;
    dCmbCausale1: TDBLookupComboBox;
    dCmbCausale2: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    dCmbCausale3: TDBLookupComboBox;
    Panel4: TPanel;
    lstAssenze: TCheckListBox;
    Splitter1: TSplitter;
    lblCodice: TLabel;
    Label7: TLabel;
    drdgTipo: TDBRadioGroup;
    Panel3: TPanel;
    lstPresenze: TCheckListBox;
    Panel6: TPanel;
    Label1: TLabel;
    dChkPulizia: TDBCheckBox;
    dChkPersNonTurnista: TDBCheckBox;
    dChkGGNonLavTimbr: TDBCheckBox;
    drdgSmontoNotte: TDBRadioGroup;
    dChkNoReperibilita: TDBCheckBox;
    dChkLimiteSaldo: TDBCheckBox;
    dChkDomenica: TDBCheckBox;
    dChkGGNonLav: TDBCheckBox;
    dChkGGFest: TDBCheckBox;
    dChkGGCalend: TDBCheckBox;
    lblInterfaccia: TLabel;
    PopupMenu2: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Panel7: TPanel;
    Label2: TLabel;
    lblRiposoLavorato: TLabel;
    dcmbRiposoLavorato: TDBLookupComboBox;
    lblSelRiposoLavorato: TLabel;
    procedure dcmbRiposoLavoratoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dcmbRiposoLavoratoCloseUp(Sender: TObject);
    procedure dChkPersNonTurnistaClick(Sender: TObject);
    procedure drdgTipoClick(Sender: TObject);
    procedure dChkLimiteSaldoClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure dCmbCodiceKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DButtonStateChange(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure dCmbCausale3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dCmbCausale2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dCmbCausale1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dCmbCodiceKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dCmbCausale3CloseUp(Sender: TObject);
    procedure dCmbCausale2CloseUp(Sender: TObject);
    procedure dCmbCausale1CloseUp(Sender: TObject);
    procedure dCmbCodiceCloseUp(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure AbilitaComponenti;
  public
    { Public declarations }
  end;

var
  A141FRegoleRiposi: TA141FRegoleRiposi;

procedure OpenA141RegoleRiposi;

implementation

uses A141URegoleRiposiDtM;

{$R *.dfm}

procedure OpenA141RegoleRiposi;
{Inserimento automatico dei riposi}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA141RegoleRiposi') of
    'N','R':
      begin
        ShowMessage('Funzione non abilitata!');
        Exit;
      end;
  end;
  A141FRegoleRiposi:=TA141FRegoleRiposi.Create(nil);
  with A141FRegoleRiposi do
    try
      A141FRegoleRiposiDtM:=TA141FRegoleRiposiDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A141FRegoleRiposiDtM.Free;
      Free;
    end;
end;

procedure TA141FRegoleRiposi.FormShow(Sender: TObject);
begin
  inherited;
  with A141FRegoleRiposiDtM.selT275 do
  begin
    First;
    while not Eof do
    begin
      lstPresenze.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  with A141FRegoleRiposiDtM.selT265 do
  begin
    First;
    while not Eof do
    begin
      lstAssenze.Items.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
  lblCodice.Caption:='Codice ' + Parametri.CampiRiferimento.C16_INSRIPOSI;
  DButton.DataSet:=A141FRegoleRiposidTm.selT267;
  A141FRegoleRiposidTm.selT267.Open;
end;

procedure TA141FRegoleRiposi.dCmbCodiceCloseUp(Sender: TObject);
begin
  inherited;
  if A141FRegoleRiposiDtM.selInterfaccia.Active then
    if dCmbCodice.KeyValue <> Null then
      lblInterfaccia.Caption:=A141FRegoleRiposiDtM.selInterfaccia.FieldByName('DESCRIZIONE').AsString
    else
      lblInterfaccia.Caption:='';
end;

procedure TA141FRegoleRiposi.dCmbCausale1CloseUp(Sender: TObject);
begin
  inherited;
  if dCmbCausale1.KeyValue <> Null then
    LblSel1.Caption:=A141FRegoleRiposiDtM.QCausale1T265DESCRIZIONE.AsString
  else
    LblSel1.Caption:='';
end;

procedure TA141FRegoleRiposi.dCmbCausale2CloseUp(Sender: TObject);
begin
  inherited;
  if dCmbCausale2.KeyValue <> Null then
    LblSel2.Caption:=A141FRegoleRiposiDtM.QCausale2T265DESCRIZIONE.AsString
  else
    LblSel2.Caption:='';
end;

procedure TA141FRegoleRiposi.dCmbCausale3CloseUp(Sender: TObject);
begin
  inherited;
  if dCmbCausale3.KeyValue <> Null then
    LblSel3.Caption:=A141FRegoleRiposiDtM.QCausale3T265DESCRIZIONE.AsString
  else
    LblSel3.Caption:='';
end;

procedure TA141FRegoleRiposi.dCmbCodiceKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dCmbCodiceCloseUp(nil);
end;

procedure TA141FRegoleRiposi.dCmbCausale1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dCmbCausale1CloseUp(nil);
end;

procedure TA141FRegoleRiposi.dCmbCausale2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dCmbCausale2CloseUp(nil);
end;

procedure TA141FRegoleRiposi.dCmbCausale3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  dCmbCausale3CloseUp(nil);
end;

procedure TA141FRegoleRiposi.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  inherited;
  with (PopupMenu2.PopupComponent as TCheckListBox) do
    for i:=0 to Items.Count - 1 do
      Checked[i]:=Sender = Selezionatutto1;
end;

procedure TA141FRegoleRiposi.DButtonStateChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA141FRegoleRiposi.dCmbCodiceKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA141FRegoleRiposi.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  OpenA016CausAssenze((PopupMenu1.PopupComponent as TDBLookupComboBox).Text);
  with A141FRegoleRiposiDtM do
  begin
    QCausale1.DisableControls;
    QCausale1.Refresh;
    QCausale1.EnableControls;
    QCausale2.DisableControls;
    QCausale2.Refresh;
    QCausale2.EnableControls;
    QCausale3.DisableControls;
    QCausale3.Refresh;
    QCausale3.EnableControls;
    selT265.DisableControls;
    selT265.Refresh;
    selT265.EnableControls;
  end;
end;

procedure TA141FRegoleRiposi.dChkLimiteSaldoClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA141FRegoleRiposi.drdgTipoClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA141FRegoleRiposi.dChkPersNonTurnistaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TA141FRegoleRiposi.AbilitaComponenti;
var RW:Boolean;
begin
  drdgTipo.ReadOnly:=not (DButton.State in [dsInsert]);
  RW:=DButton.State in [dsInsert,dsEdit];
  if drdgTipo.ItemIndex = 0 then
    lblRiposo.Caption:='Riposo'
  else if drdgTipo.ItemIndex = 1 then
    lblRiposo.Caption:='Festività'
  else if drdgTipo.ItemIndex = 2 then
    lblRiposo.Caption:='Festivi infrasett.';
  lblRipComp.Enabled:=drdgTipo.ItemIndex = 0;
  dCmbCausale2.Enabled:=drdgTipo.ItemIndex = 0;
  if not dCmbCausale2.Enabled then
  begin
    dCmbCausale2.KeyValue:=Null;
    if (dCmbCausale2.Field <> nil) and RW then
      dCmbCausale2.Field.Value:=Null;
  end;
  dCmbCausale2CloseUp(nil);
  lblRipMesePrec.Enabled:=drdgTipo.ItemIndex = 0;
  dCmbCausale3.Enabled:=drdgTipo.ItemIndex = 0;
  if not dCmbCausale3.Enabled then
  begin
    dCmbCausale3.KeyValue:=Null;
    if (dCmbCausale3.Field <> nil) and RW then
      dCmbCausale3.Field.Value:=Null;
  end;
  dCmbCausale3CloseUp(nil);
  drdgSmontoNotte.Enabled:=drdgTipo.ItemIndex <> 2;
  if (not drdgSmontoNotte.Enabled) and RW then
    drdgSmontoNotte.Field.Value:='N';
  dChkPersNonTurnista.Enabled:=(drdgTipo.ItemIndex <> 2) and not dchkLimiteSaldo.Checked;
  if (not dChkPersNonTurnista.Enabled) and RW then
    dChkPersNonTurnista.Field.Value:='N';
  dChkGGNonLavTimbr.Enabled:=drdgTipo.ItemIndex <> 2;
  if (not dChkGGNonLavTimbr.Enabled) and RW then
    dChkGGNonLavTimbr.Field.Value:='N';
  dChkNoReperibilita.Enabled:=drdgTipo.ItemIndex <> 2;
  if (not dChkNoReperibilita.Enabled) and RW then
    dChkNoReperibilita.Field.Value:='N';
  dChkLimiteSaldo.Enabled:=drdgTipo.ItemIndex = 0;
  if (not dChkLimiteSaldo.Enabled) and RW then
    if dChkLimiteSaldo.Field <> nil then
      dChkLimiteSaldo.Field.Value:='N';
  lblRiposoLavorato.Enabled:=(drdgTipo.ItemIndex = 0) and dchkPersNonTurnista.Checked and (not dchkGGNonLavTimbr.Checked);
  dcmbRiposoLavorato.Enabled:=lblRiposoLavorato.Enabled;
  if not dcmbRiposoLavorato.Enabled then
  begin
    dcmbRiposoLavorato.KeyValue:=Null;
    if (dcmbRiposoLavorato.Field <> nil) and RW then
      dcmbRiposoLavorato.Field.Value:=Null;
  end;
  dcmbRiposoLavoratoCloseUp(nil);
  lblSelRiposoLavorato.Enabled:=lblRiposoLavorato.Enabled;
  dChkDomenica.Enabled:=drdgTipo.ItemIndex <> 2;
  if (not dChkDomenica.Enabled) and RW then
    dChkDomenica.Field.Value:='N';
  dChkGGNonLav.Enabled:=drdgTipo.ItemIndex <> 2;
  if (not dChkGGNonLav.Enabled) and RW then
    dChkGGNonLav.Field.Value:='N';
  dChkGGFest.Enabled:=drdgTipo.ItemIndex <> 2;
  if (not dChkGGFest.Enabled) and RW then
    dChkGGFest.Field.Value:='N';
  dChkGGCalend.Enabled:=drdgTipo.ItemIndex <> 2;
  if (not dChkGGCalend.Enabled) and RW then
    dChkGGCalend.Field.Value:='N';
  lstPresenze.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (drdgTipo.ItemIndex <> 2);
  if drdgTipo.ItemIndex = 2 then
  begin
    lstPresenze.PopupMenu.PopupComponent:=lstPresenze;
    lstPresenze.PopupMenu.Items[1].Click;
  end;
  lstAssenze.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (drdgTipo.ItemIndex <> 2);
  if drdgTipo.ItemIndex = 2 then
  begin
    lstAssenze.PopupMenu.PopupComponent:=lstAssenze;
    lstAssenze.PopupMenu.Items[1].Click;
  end;
end;

procedure TA141FRegoleRiposi.dcmbRiposoLavoratoCloseUp(Sender: TObject);
begin
  inherited;
  if dcmbRiposoLavorato.KeyValue <> Null then
    lblSelRiposoLavorato.Caption:=A141FRegoleRiposiDtM.QCausale1T265DESCRIZIONE.AsString
  else
    lblSelRiposoLavorato.Caption:='';
end;

procedure TA141FRegoleRiposi.dcmbRiposoLavoratoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbRiposoLavoratoCloseUp(Sender);
end;

end.
