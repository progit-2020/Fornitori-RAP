unit P050UArrotondamentiValute;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList,
  P030UValute, Variants, System.Actions;

type
  TP050FArrotondamentiValute = class(TR004FGestStorico)
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    dlblD_Valuta: TDBText;
    Label3: TLabel;
    dcbxValuta: TDBLookupComboBox;
    dedtValore: TDBEdit;
    dgrbTipo: TDBRadioGroup;
    pmnValute: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Label4: TLabel;
    dedtDescrizione: TDBEdit;
    edtCodArrotondamento: TEdit;
    procedure dcbxValutaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Cod:String;
  end;

var
  P050FArrotondamentiValute: TP050FArrotondamentiValute;

procedure ValuteArr(Codice:String);

implementation

uses P050UArrotondamentiValuteDtM, P050UArrotondamentiDtM;

{$R *.DFM}

procedure ValuteArr(Codice:String);
begin
  P050FArrotondamentiValute:=TP050FArrotondamentiValute.Create(nil);
  P050FArrotondamentiValute.Cod:=Codice;
  P050FArrotondamentiValute.edtCodArrotondamento.Text:=Codice;
  P050FArrotondamentiValuteDtM:=TP050FArrotondamentiValuteDtM.Create(nil);
  try
    P050FArrotondamentiValute.ShowModal;
  finally
    P050FArrotondamentiValute.Free;
    P050FArrotondamentiValuteDtM.Free;
  end;
end;

procedure TP050FArrotondamentiValute.FormShow(Sender: TObject);
begin
  inherited;
  dcbxValuta.ListSource:=P050FArrotondamentiDtM.P050FArrotondamentiMW.D030;
end;

procedure TP050FArrotondamentiValute.Nuovoelemento1Click(Sender: TObject);
begin
  inherited;
  if pmnValute.PopupComponent is TDBLookupComboBox then
    OpenP030FValute(TDBLookupComboBox(pmnValute.PopupComponent).Field.AsString);
  P050FArrotondamentiDtm.P050FArrotondamentiMW.Q030.Refresh;
end;

procedure TP050FArrotondamentiValute.dcbxValutaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
