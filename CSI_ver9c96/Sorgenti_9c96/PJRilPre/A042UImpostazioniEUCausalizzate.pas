unit A042UImpostazioniEUCausalizzate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons, Db, C004UParamForm, A000UCostanti, A000USessione,A000UInterfaccia, OracleData, Variants;

type
  TA042FImpostazioniEUCausalizzate = class(TForm)
    GroupBox2: TGroupBox;
    BtnClose: TBitBtn;
    Label2: TLabel;
    DbCmbPresenza: TDBLookupComboBox;
    DbLblDescPresenza: TDBText;
    procedure DbCmbPresenzaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A042FImpostazioniEUCausalizzate: TA042FImpostazioniEUCausalizzate;

procedure OpenA042ImpostazioniEUCausalizzate;

implementation

uses A042UStampaPreAssDtM1, A042UDialogStampa;

{$R *.DFM}

procedure OpenA042ImpostazioniEUCausalizzate;
begin
  try
    Application.CreateForm(TA042FImpostazioniEUCausalizzate, A042FImpostazioniEUCausalizzate);
    A042FImpostazioniEUCausalizzate.ShowModal;
  finally
    A042FImpostazioniEUCausalizzate.Free;
  end;
end;

procedure TA042FImpostazioniEUCausalizzate.FormActivate(Sender: TObject);
begin
  with A042FStampaPreAssDtM1 do
  begin
    A042MW.selT275.Filter:= 'CODICE <> ''**NC**''';
    A042MW.selT275.Filtered:=True;
    DbCmbPresenza.KeyValue:=A042MW.selT275.FieldbyName('Codice').AsString;
    if A042MW.SelT275.SearchRecord('Codice',A042FStampaPreAssDtM1.A042MW.sPb_CausaleEU, [srFromBeginning]) then
      DbCmbPresenza.KeyValue:=A042FStampaPreAssDtM1.A042MW.sPb_CausaleEU;
  end;
end;

procedure TA042FImpostazioniEUCausalizzate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  A042FStampaPreAssDtM1.A042MW.sPb_CausaleEU:=A042FStampaPreAssDtM1.A042MW.selT275.FieldByName('Codice').asString;
end;

procedure TA042FImpostazioniEUCausalizzate.FormCreate(Sender: TObject);
begin
  DbLblDescPresenza.DataSource:=A042FStampaPreAssDtM1.A042MW.dscT275;
  DbCmbPresenza.ListSource:=A042FStampaPreAssDtM1.A042MW.dscT275;
end;

procedure TA042FImpostazioniEUCausalizzate.DbCmbPresenzaKeyDown(Sender: TObject;
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
