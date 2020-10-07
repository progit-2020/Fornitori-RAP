unit A017URaggrAsse;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione, A000UInterfaccia,
  C180FunzioniGenerali, Variants;

type
  TA017FRaggrAsse = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    EContASolare: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    grpResidui: TGroupBox;
    Label3: TLabel;
    lblRaggruppamentoResiduo: TLabel;
    lblRaggrResiduoPrec: TLabel;
    dedtMaxResiduo: TDBEdit;
    dcmbRaggruppamentoResiduo: TDBLookupComboBox;
    dcmbRaggrResiduoPrec: TDBLookupComboBox;
    dchkCumulaRaggrBase: TDBCheckBox;
    Label4: TLabel;
    dedtMaxResiduoCorr: TDBEdit;
    Label5: TLabel;
    dedtMaxResiduoPrec: TDBEdit;
    EResiduabile: TDBCheckBox;
    procedure dcmbRaggruppamentoResiduoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EResiduabileClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dcmbRaggruppamentoResiduoCloseUp(Sender: TObject);
    procedure dcmbRaggruppamentoResiduoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A017FRaggrAsse: TA017FRaggrAsse;

procedure OpenA017RaggrAsse(Cod:String);

implementation

uses A017URaggrAsseDtM1;

{$R *.DFM}

procedure OpenA017RaggrAsse(Cod:String);
{Raggruppamenti assenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA017RaggrAsse') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A017FRaggrAsse:=TA017FRaggrAsse.Create(nil);
  with A017FRaggrAsse do
  try
    A017FRaggrAsseDtM1:=TA017FRaggrAsseDtM1.Create(nil);
    DButton.DataSet:=A017FRaggrAsseDtM1.T260;
    DButton.DataSet.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A017FRaggrAsseDtM1.Free;
    Release;
  end;
end;

procedure TA017FRaggrAsse.EResiduabileClick(Sender: TObject);
begin
  if (DButton.State in [dsEdit,dsInsert]) and (not EResiduabile.Checked) then
  begin
    dedtMaxResiduo.Field.Clear;
    dcmbRaggruppamentoResiduo.Field.Clear;
    dcmbRaggrResiduoPrec.Field.Clear;
  end;
  (*
  Label3.Enabled:=EResiduabile.Checked;
  DBEdit3.Enabled:=EResiduabile.Checked;
  lblRaggruppamentoResiduo.Enabled:=EResiduabile.Checked;
  dcmbRaggruppamentoResiduo.Enabled:=EResiduabile.Checked;
  lblRaggrResiduoPrec.Enabled:=EResiduabile.Checked;
  dcmbRaggrResiduoPrec.Enabled:=EResiduabile.Checked;
  dchkCumulaRaggrBase.Enabled:=EResiduabile.Checked and (dcmbRaggruppamentoResiduo.KeyValue = null);
  if not dchkCumulaRaggrBase.Enabled then
    dchkCumulaRaggrBase.Checked:=False;
  lblTipiResiduiAC.Enabled:=EResiduabile.Checked;
  dcmbTipiResiduiAC.Enabled:=EResiduabile.Checked;
  *)
  R180AbilitaOggetti(grpResidui,EResiduabile.Checked);
  dchkCumulaRaggrBase.Enabled:=dchkCumulaRaggrBase.Enabled and (dcmbRaggruppamentoResiduo.KeyValue = null);
  if not dchkCumulaRaggrBase.Enabled then
    dchkCumulaRaggrBase.Checked:=False;
end;

procedure TA017FRaggrAsse.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A017FRaggrAsseDtM1.T260;
  EResiduabileClick(nil);
  inherited;
end;

procedure TA017FRaggrAsse.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = nil then
    dcmbRaggruppamentoResiduoCloseUp(nil);
end;

procedure TA017FRaggrAsse.dcmbRaggruppamentoResiduoCloseUp(Sender: TObject);
begin
  inherited;
  dchkCumulaRaggrBase.Enabled:=EResiduabile.Checked and (dcmbRaggruppamentoResiduo.KeyValue = null);
  if not dchkCumulaRaggrBase.Enabled then
    dchkCumulaRaggrBase.Checked:=False;
end;

procedure TA017FRaggrAsse.dcmbRaggruppamentoResiduoKeyDown(Sender: TObject;
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

procedure TA017FRaggrAsse.dcmbRaggruppamentoResiduoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  dcmbRaggruppamentoResiduoCloseUp(nil);
end;

end.
