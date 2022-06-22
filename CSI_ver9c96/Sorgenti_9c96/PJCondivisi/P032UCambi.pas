unit P032UCambi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  C009UCopiaSu, R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, Variants,
  System.Actions;

type
  TP032FCambi = class(TR004FGestStorico)
    DataSource1: TDataSource;
    lblDaValuta: TLabel;
    lblAValuta: TLabel;
    lblCoeffCalcoli: TLabel;
    dlblDescrCodVal2: TDBText;
    dlblDescrCodVal1: TDBText;
    dcmbCodVal1: TDBLookupComboBox;
    dcmbCodVal2: TDBLookupComboBox;
    dedtCoeffCalcoli: TDBEdit;
    pmn_Valute: TPopupMenu;
    mnuNuovoelemento1: TMenuItem;
    procedure dcmbCodVal1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuNuovoelemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P032FCambi: TP032FCambi;

procedure OpenP032FCambi();

implementation

uses P032UCambiDtM, P030UValute;

{$R *.DFM}

procedure OpenP032FCambi();
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP032FCambi') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TP032FCambi, P032FCambi);
  Application.CreateForm(TP032FCambiDtM, P032FCambiDtM);
  try
    P032FCambi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P032FCambi.Free;
    P032FCambiDtM.Free;
  end;
end;

procedure TP032FCambi.FormShow(Sender: TObject);
begin
  inherited;
  CopiaDa1.Visible:=True;
  CopiaDa1.Enabled:=True;
  VisioneCorrente1Click(nil);
  dcmbCodVal1.ListSource:=P032FCambiDtM.P032FCambiMW.dsrP030;
  dcmbCodVal2.ListSource:=P032FCambiDtM.P032FCambiMW.dsrP030;
end;

procedure TP032FCambi.dcmbCodVal1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TP032FCambi.mnuNuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if pmn_Valute.PopupComponent is TDBLookupComboBox then
    OpenP030FValute(TDBLookupComboBox(pmn_Valute.PopupComponent).Field.AsString);
  P032FCambiDtm.P032FCambiMW.selP030.Refresh;
end;

end.
