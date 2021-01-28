unit A121URecapitiSindacati;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList, Grids,
  DBGrids,A000UCostanti, A000USessione, A000UInterfaccia, Variants, Spin, A011UComuniProvinceRegioni,
  System.Actions;

type
  TA121FRecapitiSindacati = class(TR004FGestStorico)
    pmnNew: TPopupMenu;
    NuovoElemento1: TMenuItem;
    Panel1: TPanel;
    Label1: TLabel;
    dEdtCodice: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    dEdtCognome: TDBEdit;
    Label11: TLabel;
    dEdtNome: TDBEdit;
    Label15: TLabel;
    dEdtEMail: TDBEdit;
    dEdtCellulare: TDBEdit;
    Label14: TLabel;
    dEdtTelUfficio: TDBEdit;
    Label13: TLabel;
    dEdtTelCasa: TDBEdit;
    Label12: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    dEdtIndirizzo: TDBEdit;
    Label6: TLabel;
    dEdtCap: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    dEdtTelefono: TDBEdit;
    Label9: TLabel;
    dEdtFax: TDBEdit;
    edtProgressivo: TSpinEdit;
    dCmbTipo: TDBComboBox;
    dEdtIstat: TDBEdit;
    Label2: TLabel;
    dEdtProvincia: TDBEdit;
    dCmbComune: TDBLookupComboBox;
    dEdtDescrizione: TDBEdit;
    Label16: TLabel;
    procedure dCmbComuneKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dCmbTipoChange(Sender: TObject);
    procedure dCmbTipoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure TRegisClick(Sender: TObject);
    procedure TCancClick(Sender: TObject);
  private
    { Private declarations }
  public
    Sindacato:String;
  end;

var
  A121FRecapitiSindacati: TA121FRecapitiSindacati;

procedure OpenA121RecapitiSindacati(Codice,Tipo:String;Progressivo:Integer);

implementation

uses A121URecapitiSindacatiDtM;

{$R *.DFM}
procedure OpenA121RecapitiSindacati(Codice,Tipo:String;Progressivo:Integer);
begin
  Application.CreateForm(TA121FRecapitiSindacati, A121FRecapitiSindacati);
  A121FRecapitiSindacati.Sindacato:=Codice;
  Application.CreateForm(TA121FRecapitiSindacatiDtM, A121FRecapitiSindacatiDtM);
  A121FRecapitiSindacatiDtM.selT241.SearchRecord('CODICE;TIPO_RECAPITO;PROG_RECAPITO',
    VarArrayOf([Codice,Tipo,Progressivo]),[srFromBeginning]);
  try
    A121FRecapitiSindacati.ShowModal;
  finally
    FreeAndNil(A121FRecapitiSindacati);
    FreeAndNil(A121FRecapitiSindacatiDtM)
  end;
end;

procedure TA121FRecapitiSindacati.FormShow(Sender: TObject);
begin
  inherited;
  dCmbComune.ListSource:=A121FRecapitiSindacatiDtM.A121MW.dsrT480;
  VisioneCorrente1Click(nil);
end;

procedure TA121FRecapitiSindacati.dCmbTipoChange(Sender: TObject);
begin
  inherited;
  with A121FRecapitiSindacatiDtM do
    if selT241.State = dsInsert then
    begin
      A121MW.selT241MaxProg.SetVariable('CODICE',Sindacato);
      A121MW.selT241MaxProg.SetVariable('TIPO',dCmbTipo.Text);
      A121MW.selT241MaxProg.Execute;
      edtProgressivo.Value:=StrToIntDef(VarToStr(A121MW.selT241MaxProg.Field(0)),0) + 1;
    end;
end;

procedure TA121FRecapitiSindacati.dCmbTipoDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A121FRecapitiSindacatiDtM.A121MW.D_TipoRecapito[Index].Item);
end;

procedure TA121FRecapitiSindacati.DButtonStateChange(Sender: TObject);
begin
  inherited;
  edtProgressivo.Enabled:=DButton.State in [dsInsert];
end;

procedure TA121FRecapitiSindacati.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  edtProgressivo.Enabled:=False;
end;

procedure TA121FRecapitiSindacati.NuovoElemento1Click(Sender: TObject);
begin
  inherited;
  OpenA011ComuniProvinceRegioni(A121FRecapitiSindacatiDtM.selT241.FieldByName('COMUNE').AsString,'');
end;

procedure TA121FRecapitiSindacati.TRegisClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA121FRecapitiSindacati.TCancClick(Sender: TObject);
begin
  inherited;
  actRefresh.Execute;
end;

procedure TA121FRecapitiSindacati.dCmbComuneKeyDown(Sender: TObject;
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
