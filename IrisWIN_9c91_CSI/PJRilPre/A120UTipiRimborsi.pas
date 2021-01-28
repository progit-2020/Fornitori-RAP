unit A120UTipiRimborsi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGestTab, ActnList, ImgList, Db, Menus, ComCtrls, ToolWin, StdCtrls,
  ExtCtrls, DBCtrls, Mask, OracleData, Oracle, A000UCostanti, A000USessione,A000UInterfaccia,
  P050UArrotondamenti, Variants, System.Actions, Vcl.Grids, Vcl.DBGrids;

type
  TA120FTIPIRIMBORSI = class(TR001FGestTab)
    Panel2: TPanel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtCodiceVociPaghe: TDBEdit;
    LblCodice: TLabel;
    LblDescrizione: TLabel;
    LblCodiceVociPaghe: TLabel;
    GroupBox1: TGroupBox;
    LblCodiceVociPagheIndennitaSupplementare: TLabel;
    LblPercentualePerIndennitaSupplementare: TLabel;
    LblArrotondamentoPerIndennitaSupplementare: TLabel;
    dLblArrotondamentoPerIndennitaSupplementare: TDBText;
    dedtPercentualePerIndennitaSupplementare: TDBEdit;
    dedtCodiceVociPagheIndennitaSupplementare: TDBEdit;
    dcmbArrotondamentoPerIndennitaSupplementare: TDBLookupComboBox;
    dchkScaricoPaghe: TDBCheckBox;
    dchkEsistenza: TDBCheckBox;
    dchkScarico: TDBCheckBox;
    pmnTipiRimborsi: TPopupMenu;
    NuovoElemento1: TMenuItem;
    dchkAnticipo: TDBCheckBox;
    dcmbTipoRimb: TDBComboBox;
    lblTipoRimb: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    dcmbTipoQuantita: TDBComboBox;
    Label2: TLabel;
    dedtPercAnticipo: TDBEdit;
    lblNoteFisse: TLabel;
    dedtNoteFisse: TDBEdit;
    dchkFlagMotivazione: TDBCheckBox;
    dchkFlagTarga: TDBCheckBox;
    Label3: TLabel;
    dchkFlagMezzoProprio: TDBCheckBox;
    gpbTipiExcelImp: TGroupBox;
    dgrdTipiExcelImp: TDBGrid;
    procedure dcmbArrotondamentoPerIndennitaSupplementareKeyDown(
      Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure NuovoElemento1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dcmbTipoQuantitaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure dcmbTipoRimbClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  D_TipoQuantita: array[0..3] of string = ({} '',
                                           {I}'Importo',
                                           {F}'Flag',
                                           {Q}'Quantità');
var
  A120FTIPIRIMBORSI: TA120FTIPIRIMBORSI;

  procedure OpenA120TipiRimborsi(Cod:String);

implementation

uses A120UTipiRimborsiDtM;

{$R *.DFM}

procedure OpenA120TipiRimborsi(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA120TipiRimborsi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA120FTipiRimborsi,A120FTIPIRIMBORSI);
  Application.CreateForm(TA120FTipiRimborsiDtm,A120FTIPIRIMBORSIDtm);
  A120FTIPIRIMBORSIDtm.M020.SearchRecord('CODICE',Cod,[srFromBeginning]);
  try
    Screen.Cursor:=crDefault;
    A120FTipiRimborsi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A120FTipiRimborsi.Free;
    A120FTipiRimborsiDtM.Free;
  end;
end;

procedure TA120FTIPIRIMBORSI.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A120FTipiRimborsiDtM.m020;
  dcmbArrotondamentoPerIndennitaSupplementare.ListSource:=A120FTIPIRIMBORSIDtm.A120FTipiRimborsiMW.DsrP050;
  inherited;
end;

procedure TA120FTIPIRIMBORSI.FormShow(Sender: TObject);
begin
  inherited;
  // popola tipi rimborso
  dcmbTipoRimb.Items.Add('');
  dcmbTipoRimb.Items.Add(M020TIPO_PASTO);
  dcmbTipoRimb.Items.Add(M020TIPO_MEZZO);
  dcmbTipoRimb.Items.Add(M020TIPO_PEDAGGIO);
end;

procedure TA120FTIPIRIMBORSI.NuovoElemento1Click(Sender: TObject);
begin
  inherited;
  if pmnTipiRimborsi.PopupComponent is TDBLookupComboBox then
    OpenP050FArrotondamenti(TDBLookupComboBox(pmnTipiRimborsi.PopupComponent).Field.AsString);
  A120FTIPIRIMBORSIDTM.A120FTipiRimborsiMW.selP050.Refresh;
end;

procedure TA120FTIPIRIMBORSI.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dcmbTipoRimb.Enabled:=DButton.State <> dsBrowse;
  dcmbTipoQuantita.Enabled:=DButton.State <> dsBrowse;
  dchkFlagMezzoProprio.Enabled:=(DButton.Dataset.FieldByName('TIPO').AsString = M020TIPO_MEZZO);
  A120FTipiRimborsiDtM.A120FTipiRimborsiMW.selCSI003.ReadOnly:=DButton.State = dsBrowse;
end;

procedure TA120FTIPIRIMBORSI.dcmbArrotondamentoPerIndennitaSupplementareKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TA120FTIPIRIMBORSI.dcmbTipoQuantitaDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  TDBComboBox(Control).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,D_TipoQuantita[Index]);
end;

procedure TA120FTIPIRIMBORSI.dcmbTipoRimbClick(Sender: TObject);
begin
  inherited;
  dchkFlagMezzoProprio.Enabled:=dcmbTipoRimb.Text = M020TIPO_MEZZO;
  if not dchkFlagMezzoProprio.Enabled then
    dchkFlagMezzoProprio.Checked:=False;
end;

end.
