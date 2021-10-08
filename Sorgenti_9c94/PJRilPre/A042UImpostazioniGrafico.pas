unit A042UImpostazioniGrafico;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, Buttons, Db, C004UParamForm, A000UCostanti, A000USessione,
  A000UInterfaccia, Variants;

type
  TA042FImpostazioniGrafico = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    BtnClose: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtColorePresenza: TEdit;
    BtnColorePresenza: TButton;
    ColorDialogPresenza: TColorDialog;
    Label4: TLabel;
    edtColoreAssenza: TEdit;
    ColorDialogAssenza: TColorDialog;
    BtnColoreAssenza: TButton;
    BtnSalvaPresenze: TBitBtn;
    BtnCancellaPresenze: TBitBtn;
    BtnSalvaAssenze: TBitBtn;
    BtnCancellaAssenze: TBitBtn;
    BtnImportaPresenze: TBitBtn;
    BtnImportaAssenze: TBitBtn;
    DbCmbPresenza: TDBLookupComboBox;
    DbCmbAssenza: TDBLookupComboBox;
    DbLblDescPresenza: TDBText;
    DbLblDescAssenza: TDBText;
    ChkCausaliNonAbbinate: TCheckBox;
    procedure DbCmbPresenzaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure BtnColorePresenzaClick(Sender: TObject);
    procedure BtnColoreAssenzaClick(Sender: TObject);
    procedure BtnSalvaPresenzeClick(Sender: TObject);
    procedure BtnCancellaPresenzeClick(Sender: TObject);
    procedure BtnCancellaAssenzeClick(Sender: TObject);
    procedure BtnImportaPresenzeClick(Sender: TObject);
    procedure BtnImportaAssenzeClick(Sender: TObject);
    procedure DbCmbPresenzaClick(Sender: TObject);
    procedure DbCmbAssenzaClick(Sender: TObject);
    procedure BtnSalvaAssenzeClick(Sender: TObject);
    procedure ChkCausaliNonAbbinateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A042FImpostazioniGrafico: TA042FImpostazioniGrafico;

procedure OpenA042ImpostazioniGrafico;

implementation

uses A042UStampaPreAssDtM1, A042UDialogStampa, A042UStampaPreAssMW;

{$R *.DFM}

procedure OpenA042ImpostazioniGrafico;
begin
  try
    Application.CreateForm(TA042FImpostazioniGrafico,A042FImpostazioniGrafico);
    A042FImpostazioniGrafico.ShowModal;
  finally
    A042FImpostazioniGrafico.Free;
  end;
end;

procedure TA042FImpostazioniGrafico.FormActivate(Sender: TObject);
begin
  with A042FStampaPreAssDtM1 do
  begin
    A042MW.selT275.First;
    A042MW.selT275.Filtered:=False;
    DbCmbPresenza.KeyValue:=A042MW.selT275.FieldbyName('Codice').AsString;
    DbCmbPresenzaClick(nil);
    A042MW.selT265.First;
    DbCmbAssenza.KeyValue:=A042MW.selT265.FieldbyName('Codice').AsString;
    DbCmbAssenzaClick(nil);
  end;
  chkCausaliNonAbbinate.Checked:=A042FStampaPreAssDtM1.A042MW.bPb_MostraCausaliNonAbbinate;
end;

procedure TA042FImpostazioniGrafico.FormCreate(Sender: TObject);
begin
  DbLblDescPresenza.DataSource:=A042FStampaPreAssDtM1.A042MW.dscT275;
  DbCmbPresenza.ListSource:=A042FStampaPreAssDtM1.A042MW.dscT275;
end;

procedure TA042FImpostazioniGrafico.BtnColorePresenzaClick(
  Sender: TObject);
begin
  with A042FDialogStampa do
  begin
    if ColorDialogPresenza.Execute then
    begin
      edtColorePresenza.Color:= ColorDialogPresenza.Color;
      A042FStampaPreAssDtM1.A042MW.aPb_CausaliPresenza[A042FStampaPreAssDtM1.A042MW.selT275.FieldByName('NUMERO_RIGA').asInteger - 1].xColore:=ColorDialogPresenza.Color;
    end;
  end;
end;

procedure TA042FImpostazioniGrafico.BtnColoreAssenzaClick(Sender: TObject);
begin
  with A042FDialogStampa do
  begin
    if ColorDialogAssenza.Execute then
    begin
      edtColoreAssenza.Color:= ColorDialogAssenza.Color;
      A042FStampaPreAssDtM1.A042MW.aPb_CausaliAssenza[A042FStampaPreAssDtM1.A042MW.selT265.FieldByName('NUMERO_RIGA').asInteger - 1].xColore:=ColorDialogAssenza.Color;
    end;
  end;
end;

procedure TA042FImpostazioniGrafico.BtnSalvaPresenzeClick(Sender: TObject);
var
  i:integer;
begin
  with A042FStampaPreAssDtM1.A042MW do
  begin
    SetLength(aPb_CausaliPresenzaDb,0);
    for i:=0 to High(aPb_CausaliPresenza) do
    begin
      SetLength(aPb_CausaliPresenzaDb, length(aPb_CausaliPresenzaDb) + 1);
      aPb_CausaliPresenzaDb[i].sCodice:=aPb_CausaliPresenza[i].sCodice;
      aPb_CausaliPresenzaDb[i].sDescrizione:=aPb_CausaliPresenza[i].sDescrizione;
      aPb_CausaliPresenzaDb[i].xColore:=aPb_CausaliPresenza[i].xColore;
    end;
  end;
end;

procedure TA042FImpostazioniGrafico.BtnCancellaPresenzeClick(
  Sender: TObject);
var
  i:integer;
begin
  with A042FStampaPreAssDtM1.A042MW do
  begin
    for i:=0 to High(aPb_CausaliPresenza) do
      aPb_CausaliPresenza[i].xColore:=clWhite;
  end;
  DbCmbPresenzaClick(nil);
end;

procedure TA042FImpostazioniGrafico.BtnCancellaAssenzeClick(
  Sender: TObject);
var
  i:integer;
begin
  with A042FStampaPreAssDtM1.A042MW do
  begin
    for i:=0 to High(aPb_CausaliAssenza) do
      aPb_CausaliAssenza[i].xColore:=clWhite;
  end;
  DbCmbAssenzaClick(nil);
end;

procedure TA042FImpostazioniGrafico.BtnImportaPresenzeClick(
  Sender: TObject);
var
  i:integer;
begin
  with A042FStampaPreAssDtM1.A042MW do
  begin
    SetLength(aPb_CausaliPresenza,0);
    for i:=0 to High(aPb_CausaliPresenzaDb) do
    begin
      SetLength(aPb_CausaliPresenza, length(aPb_CausaliPresenza) + 1);
      aPb_CausaliPresenza[i].sCodice:=aPb_CausaliPresenzaDb[i].sCodice;
      aPb_CausaliPresenza[i].sDescrizione:=aPb_CausaliPresenzaDb[i].sDescrizione;
      aPb_CausaliPresenza[i].xColore:=aPb_CausaliPresenzaDb[i].xColore;
    end;
  end;
  DbCmbPresenzaClick(nil);
end;

procedure TA042FImpostazioniGrafico.BtnImportaAssenzeClick(
  Sender: TObject);
var
  i:integer;
begin
  with A042FStampaPreAssDtM1.A042MW do
  begin
    SetLength(aPb_CausaliAssenza,0);
    for i:=0 to High(aPb_CausaliAssenzaDb) do
    begin
      SetLength(aPb_CausaliAssenza, length(aPb_CausaliAssenza) + 1);
      aPb_CausaliAssenza[i].sCodice:=aPb_CausaliAssenzaDb[i].sCodice;
      aPb_CausaliAssenza[i].sDescrizione:=aPb_CausaliAssenzaDb[i].sDescrizione;
      aPb_CausaliAssenza[i].xColore:=aPb_CausaliAssenzaDb[i].xColore;
    end;
  end;
  DbCmbAssenzaClick(nil);
end;

procedure TA042FImpostazioniGrafico.DbCmbPresenzaClick(Sender: TObject);
begin
  edtColorePresenza.Color:=A042FStampaPreAssDtM1.A042MW.aPb_CausaliPresenza[A042FStampaPreAssDtM1.A042MW.selT275.FieldByName('NUMERO_RIGA').asInteger - 1].xColore;
end;

procedure TA042FImpostazioniGrafico.DbCmbAssenzaClick(Sender: TObject);
begin
  edtColoreAssenza.Color:=A042FStampaPreAssDtM1.A042MW.aPb_CausaliAssenza[A042FStampaPreAssDtM1.A042MW.selT265.FieldByName('NUMERO_RIGA').asInteger - 1].xColore;
end;

procedure TA042FImpostazioniGrafico.BtnSalvaAssenzeClick(Sender: TObject);
var
  i:integer;
begin
  with A042FStampaPreAssDtM1.A042MW do
  begin
    SetLength(aPb_CausaliAssenzaDb,0);
    for i:=0 to High(aPb_CausaliAssenza) do
    begin
      SetLength(aPb_CausaliAssenzaDb, length(aPb_CausaliAssenzaDb) + 1);
      aPb_CausaliAssenzaDb[i].sCodice:=aPb_CausaliAssenza[i].sCodice;
      aPb_CausaliAssenzaDb[i].sDescrizione:=aPb_CausaliAssenza[i].sDescrizione;
      aPb_CausaliAssenzaDb[i].xColore:=aPb_CausaliAssenza[i].xColore;
    end;
  end;
end;

procedure TA042FImpostazioniGrafico.ChkCausaliNonAbbinateClick(
  Sender: TObject);
begin
  A042FStampaPreAssDtM1.A042MW.bPb_MostraCausaliNonAbbinate:=ChkCausaliNonAbbinate.Checked;
end;

procedure TA042FImpostazioniGrafico.DbCmbPresenzaKeyDown(Sender: TObject;
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
