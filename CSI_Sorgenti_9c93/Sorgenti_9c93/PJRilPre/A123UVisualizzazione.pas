unit A123UVisualizzazione;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, ComCtrls, DBCtrls, A000UCostanti, A000USessione, A000UInterfaccia,
  A121UOrganizzSindacali, Menus, DB;

type
  TA123FVisualizzazione = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    lblOrganizzazione: TLabel;
    dtpData: TDateTimePicker;
    Label2: TLabel;
    dCmbSindacato: TDBLookupComboBox;
    dTxtSindacato: TDBText;
    dCmbOrganismo: TDBLookupComboBox;
    dTxtOrganismo: TDBText;
    edtOrdina1: TEdit;
    edtOrdina2: TEdit;
    edtOrdina3: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    procedure dCmbOrganismoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dtpDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dtpDataCloseUp(Sender: TObject);
    procedure dCmbOrganismoCloseUp(Sender: TObject);
    procedure dCmbOrganismoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dCmbSindacatoCloseUp(Sender: TObject);
    procedure dCmbSindacatoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtOrdina1Change(Sender: TObject);
    procedure edtOrdina2Change(Sender: TObject);
    procedure edtOrdina3Change(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
  private
    procedure Aggiorna;
  public
    { Public declarations }
  end;

var
  A123FVisualizzazione: TA123FVisualizzazione;

procedure OpenA123Visualizzazione;

implementation

uses A123UPartecipazioniSindacatiDtM;

{$R *.dfm}

procedure OpenA123Visualizzazione;
begin
  try
    A123FVisualizzazione:=TA123FVisualizzazione.Create(nil);
    A123FVisualizzazione.ShowModal;
  finally
    FreeAndNil(A123FVisualizzazione);
  end;
end;

procedure TA123FVisualizzazione.FormShow(Sender: TObject);
begin
  DBGrid1.DataSource:=A123FPartecipazioniSindacatiDtM.A123MW.dsrT247A;
  dCmbOrganismo.ListSource:=A123FPartecipazioniSindacatiDtM.A123MW.dsrT245A;
  dTxtOrganismo.DataSource:=A123FPartecipazioniSindacatiDtM.A123MW.dsrT245A;
  dCmbSindacato.ListSource:=A123FPartecipazioniSindacatiDtM.A123MW.dsrT240A;
  dTxtSindacato.DataSource:=A123FPartecipazioniSindacatiDtM.A123MW.dsrT240A;
  dtpData.DateTime:=Parametri.DataLavoro;
  dtpDataCloseUp(nil);
  dTxtSindacato.Visible:=False;
  dTxtOrganismo.Visible:=False;
  Aggiorna;
end;

procedure TA123FVisualizzazione.Aggiorna;
var Elenco:TStringList;
begin
  Elenco:=TStringList.Create;
  Elenco.Clear;
  with A123FPartecipazioniSindacatiDtM.A123MW do
  begin
    selT247A.Close;
    selT247A.SetVariable('DATA',dtpData.Date);
    if Trim(dCmbSindacato.Text) <> '' then
      selT247A.SetVariable('FILTROSINDACATO',' AND T247.COD_SINDACATO = ''' + dCmbSindacato.Text + '''')
    else
      selT247A.SetVariable('FILTROSINDACATO','');
    if Trim(dCmbOrganismo.Text) <> '' then
      selT247A.SetVariable('FILTROORGANISMO',' AND T247.COD_ORGANISMO = ''' + dCmbOrganismo.Text + '''')
    else
      selT247A.SetVariable('FILTROORGANISMO','');
    if edtOrdina1.Text = '1' then
      Elenco.Add(' T247.COD_ORGANISMO, ');
    if edtOrdina1.Text = '2' then
      Elenco.Add(' T247.COD_ORGANISMO, ');
    if edtOrdina1.Text = '3' then
      Elenco.Add(' T247.COD_ORGANISMO, ');
    if edtOrdina2.Text = '1' then
      Elenco.Insert(0,' T247.COD_SINDACATO, ');
    if edtOrdina2.Text = '2' then
      if edtOrdina1.Text = '1' then
        Elenco.Add(' T247.COD_SINDACATO, ')
      else
        Elenco.Insert(0,' T247.COD_SINDACATO, ');
    if edtOrdina2.Text = '3' then
      Elenco.Add(' T247.COD_SINDACATO, ');
    if edtOrdina3.Text = '1' then
      Elenco.Insert(0,' T247.DADATA, ');
    if edtOrdina3.Text = '2' then
      Elenco.Insert(1,' T247.DADATA, ');
    if edtOrdina3.Text = '3' then
      Elenco.Add(' T247.DADATA, ');
    selT247A.SetVariable('ORDINAMENTO',Elenco.Text);
    selT247A.Open;
  end;
  FreeAndNil(Elenco);
end;

procedure TA123FVisualizzazione.dtpDataKeyUp(Sender: TObject;var Key: Word; Shift: TShiftState);
begin
  dtpDataCloseUp(nil);
end;

procedure TA123FVisualizzazione.dtpDataCloseUp(Sender: TObject);
begin
  with A123FPartecipazioniSindacatiDtM.A123MW.selT240A do
  begin
    DisableControls;
    Close;
    SetVariable('DATA',dtpData.Date);
    Open;
    EnableControls;
  end;
  with A123FPartecipazioniSindacatiDtM.A123MW.selT245A do
  begin
    DisableControls;
    Close;
    SetVariable('DATA',dtpData.Date);
    Open;
    EnableControls;
  end;
  Aggiorna;
end;

procedure TA123FVisualizzazione.dCmbOrganismoCloseUp(Sender: TObject);
begin
  dTxtOrganismo.Visible:=dCmbOrganismo.Text <> '';
  Aggiorna;
end;

procedure TA123FVisualizzazione.dCmbOrganismoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  dCmbOrganismoCloseUp(nil);
end;

procedure TA123FVisualizzazione.dCmbSindacatoCloseUp(Sender: TObject);
begin
  dTxtSindacato.Visible:=dCmbSindacato.Text <> '';
  Aggiorna;
end;

procedure TA123FVisualizzazione.dCmbSindacatoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dCmbSindacatoCloseUp(nil);
end;

procedure TA123FVisualizzazione.edtOrdina1Change(Sender: TObject);
begin
  Aggiorna;
end;

procedure TA123FVisualizzazione.edtOrdina2Change(Sender: TObject);
begin
  Aggiorna;
end;

procedure TA123FVisualizzazione.edtOrdina3Change(Sender: TObject);
begin
  Aggiorna;
end;

procedure TA123FVisualizzazione.Nuovoelemento1Click(Sender: TObject);
begin
  OpenA121OrganizzSindacali(A123FPartecipazioniSindacatiDtM.A123MW.selT247A.FieldByName('COD_SINDACATO').AsString);
end;

procedure TA123FVisualizzazione.dCmbOrganismoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
