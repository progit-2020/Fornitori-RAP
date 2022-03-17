unit A080UCausaliCompensabili;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, ExtCtrls, Variants;

type
  TA080FCausaliCompensabili = class(TForm)
    Panel1: TPanel;
    lstCausali: TListBox;
    dcmbCausali: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure dcmbCausaliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A080FCausaliCompensabili: TA080FCausaliCompensabili;

implementation

uses A080UModConteDtM1;

{$R *.DFM}

procedure TA080FCausaliCompensabili.FormShow(Sender: TObject);
begin
  dcmbCausali.ListSource.DataSet.First;
  dcmbCausali.KeyValue:=dcmbCausali.ListSource.DataSet.FieldByName('CODICE').AsString;
end;

procedure TA080FCausaliCompensabili.BitBtn1Click(Sender: TObject);
begin
  if dcmbCausali.KeyValue = null then exit;
  if lstCausali.Items.IndexOf(dcmbCausali.KeyValue) = -1 then
    lstCausali.Items.Add(dcmbCausali.KeyValue);
end;

procedure TA080FCausaliCompensabili.BitBtn2Click(Sender: TObject);
begin
  if lstCausali.ItemIndex >= 0 then
    lstCausali.Items.Delete(lstCausali.ItemIndex);
end;

procedure TA080FCausaliCompensabili.dcmbCausaliKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null; 
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then 
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

end.
