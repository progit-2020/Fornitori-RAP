unit P050UArrotondamenti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ImgList, ToolWin, Grids, DBGrids, ActnList, OracleData,
  A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, Variants,
  System.Actions;

type
  TP050FArrotondamenti = class(TR001FGestTab)
    dbgArrotondamenti: TDBGrid;
    pmnNuovoArr: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Panel9: TPanel;
    Label1: TLabel;
    dedtCodice: TDBEdit;
    procedure FormActivate(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P050FArrotondamenti: TP050FArrotondamenti;

procedure OpenP050FArrotondamenti(Cod:String);

implementation

uses P050UArrotondamentiDtM, P050UArrotondamentiValute, P050UArrotondamentiValuteDtM;

{$R *.DFM}

procedure OpenP050FArrotondamenti(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP050FArrotondamenti') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourGlass;
  P050FArrotondamenti:=TP050FArrotondamenti.Create(nil);
  P050FArrotondamentiDtM:=TP050FArrotondamentiDtM.Create(nil);
  P050FArrotondamentiDtM.Q050K.SearchRecord('Cod_Arrotondamento',Cod,[srFromBeginning]);
  try
    screen.Cursor:=crDefault;
    P050FArrotondamenti.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P050FArrotondamenti.Free;
    P050FArrotondamentiDtM.Free;
  end;
end;

procedure TP050FArrotondamenti.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=P050FArrotondamentiDtM.Q050K;
  inherited;
end;

procedure TP050FArrotondamenti.Nuovoelemento1Click(Sender: TObject);
var s:String;
begin
  inherited;
  s:=dedtCodice.Text;
  ValuteArr(dedtCodice.Text);
  P050FArrotondamentiDtm.P050FArrotondamentiMW.Q050K:=P050FArrotondamentiDtm.Q050K;
  P050FArrotondamentiDtm.P050FArrotondamentiMW.Q050:=P050FArrotondamentiDtm.Q050;
  P050FArrotondamentiDtm.Q050K.Refresh;
  P050FArrotondamentiDtm.Q050.Refresh;
  P050FArrotondamentiDtm.Q050K.SearchRecord('COD_ARROTONDAMENTO',s,[srFromBeginning]);
end;

procedure TP050FArrotondamenti.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsInsert, dsEdit] then
    pmnNuovoArr.AutoPopup:=False
  else
    pmnNuovoArr.AutoPopup:=True;
end;

end.
