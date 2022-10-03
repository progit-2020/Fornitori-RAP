unit P150USetup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList,
  A000UCostanti, A000USessione,A000UInterfaccia,A000UMessaggi, P030UValute, P130UPagamenti, Variants, C180FUNZIONIGENERALI,
  Spin, System.Actions;

type
  TP150FSetup = class(TR004FGestStorico)
    DataSource1: TDataSource;
    lblPagamento: TLabel;
    dlblDPagamento: TDBText;
    lbl_ValutaCalcoli: TLabel;
    dlblValutaCalcolo: TDBText;
    lblValutaStampa: TLabel;
    dcbxPagamento: TDBLookupComboBox;
    dcbxValutaCalcolo: TDBLookupComboBox;
    dcbxValutaStampa: TDBLookupComboBox;
    pmnValute: TPopupMenu;
    MenuItem1: TMenuItem;
    pmnPagamenti: TPopupMenu;
    NuovoElemento1: TMenuItem;
    dlblValutaStampa: TDBText;
    dedtNumDecPerc: TDBEdit;
    lblNumDecPerc: TLabel;
    DBCheckBox1: TDBCheckBox;
    lblNumDecQuantita: TLabel;
    dedtNumDecQuantita: TDBEdit;
    drgpTipoOre: TDBRadioGroup;
    lblCodComuneINAIL: TLabel;
    dcmbDComuneINAIL: TDBLookupComboBox;
    dedtCodComuneINAIL: TDBEdit;
    lblUltAnnoRecup: TLabel;
    dedtUltAnnoRecup: TDBEdit;
    lblValutaContabilita: TLabel;
    dcbxValutaContabilita: TDBLookupComboBox;
    dlblValutaContabilita: TDBText;
    procedure dcbxPagamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuItem1Click(Sender: TObject);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P150FSetup: TP150FSetup;

procedure OpenP150FSetup;

implementation

uses P150USetupDtM,A003UDataLavoroBis;

{$R *.DFM}

procedure OpenP150FSetup;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP150FSetup') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourGlass;
  Application.CreateForm(TP150FSetup,P150FSetup);
  Application.CreateForm(TP150FSetupDtM,P150FSetupDtM);
  try
    Screen.Cursor:=crDefault;
    P150FSetup.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P150FSetup.Free;
    P150FSetupDtM.Free;
  end;
end;

procedure TP150FSetup.FormShow(Sender: TObject);
begin
  inherited;
  dcbxValutaCalcolo.ListSource:=P150FSetupDtM.P150FSetupMW.D030;
  dcbxValutaStampa.ListSource:=P150FSetupDtM.P150FSetupMW.D030;
  dcbxValutaContabilita.ListSource:=P150FSetupDtM.P150FSetupMW.D030;
  dcbxPagamento.ListSource:=P150FSetupDtM.P150FSetupMW.D130;

  VisioneCorrente1Click(nil);
  if Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S' then
  begin
    dcbxValutaContabilita.Visible:=False;
    lblValutaContabilita.Visible:=False;
    dlblValutaContabilita.Visible:=False;
  end;
end;

procedure TP150FSetup.MenuItem1Click(Sender: TObject);
begin
  if pmnValute.PopupComponent is TDBLookupComboBox then
    OpenP030FValute(TDBLookupComboBox(pmnValute.PopupComponent).Field.AsString);
  P150FSetupDtM.P150FSetupMW.Q030.Refresh;
end;

procedure TP150FSetup.NuovoElemento1Click(Sender: TObject);
begin
  OpenP130FPagamenti(dcbxPagamento.Text);
  P150FSetupDtM.P150FSetupMW.Q130.Refresh;
end;

procedure TP150FSetup.dcbxPagamentoKeyDown(Sender: TObject; var Key: Word;
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

end.
