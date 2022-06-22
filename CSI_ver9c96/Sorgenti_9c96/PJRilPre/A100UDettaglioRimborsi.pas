unit A100UDettaglioRimborsi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls, Menus, Db, L001Call,
  A000UMessaggi;

type
  TA100FDettaglioRimborsi = class(TForm)
    Panel1: TPanel;
    dGrdTipiPagamenti: TDBGrid;
    BtnChiudi: TBitBtn;
    PopupMenu1: TPopupMenu;
    mnuElimina: TMenuItem;
    Modalitdipagamento1: TMenuItem;
    N1: TMenuItem;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure mnuEliminaClick(Sender: TObject);
    procedure BtnChiudiClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Modalitdipagamento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    iPv_RecordCount:integer;
  public
    { Public declarations }
  end;

var
  A100FDettaglioRimborsi: TA100FDettaglioRimborsi;
procedure OpenA100DettaglioRimborsi();  

implementation

uses A100UMISSIONIDTM, A100UTipiPagamento, A100UMISSIONI;

{$R *.dfm}

procedure OpenA100DettaglioRimborsi();
begin
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA100FDettaglioRimborsi, A100FDettaglioRimborsi);
  try
    Screen.Cursor:=crDefault;
    A100FDettaglioRimborsi.ShowModal;
  finally
    A100FDettaglioRimborsi.Free;
  end;
end;

procedure TA100FDettaglioRimborsi.PopupMenu1Popup(Sender: TObject);
begin
  mnuElimina.Enabled:=A100FMISSIONIDTM.A100FMissioniMW.M051.ReadOnly=False;
end;

procedure TA100FDettaglioRimborsi.mnuEliminaClick(Sender: TObject);
begin
  with A100FMISSIONIDTM.A100FMissioniMW do
  begin
    if (M051.RecordCount > 0) then
    begin
      if (M051IMPORTO.AsCurrency >= 0) then
        M051.Delete
      else
        raise exception.Create(A000MSG_A100_ERR_CANC_DETT);
    end;
  end;
end;

procedure TA100FDettaglioRimborsi.FormCreate(Sender: TObject);
begin
  dGrdTipiPagamenti.DataSource:=A100FMISSIONIDTM.A100FMissioniMW.d051;
end;

procedure TA100FDettaglioRimborsi.FormActivate(Sender: TObject);
begin
  A100FDettaglioRimborsi.Caption:='<A100> Dettaglio rimborsi (' +  A100FMISSIONIDTM.A100FMissioniMW.Q050DESCRIZIONE.AsString + ')';
  iPv_RecordCount:=A100FMISSIONIDTM.A100FMissioniMW.M051.RecordCount;
  dGrdTipiPagamenti.Enabled:=A100FMissioni.frmToolbarFiglioRimb.actTFConferma.Enabled;
  dGrdTipiPagamenti.Columns[4].Visible:=Not(A100FMISSIONIDTM.A100FMissioniMW.Q050.FieldByName('COD_VALUTA_EST').IsNull);
end;

procedure TA100FDettaglioRimborsi.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=False;
  with A100FMISSIONIDTM do
  begin
    if A100FMissioniMW.M051.State in [dsEdit,dsInsert] then
      A100FMissioniMW.M051.Post;
    if (iPv_RecordCount > 0) and (A100FMissioniMW.M051.RecordCount = 0) then
    begin
      A100FMissioniMW.Q050.Edit;
      A100FMissioniMW.Q050IMPORTORIMBORSOSPESE.AsInteger:=0;
      A100FMissioniMW.Q050.Post;
    end;
  end;
  CanClose:=True;
end;

procedure TA100FDettaglioRimborsi.BtnChiudiClick(Sender: TObject);
begin
  Close;
end;

procedure TA100FDettaglioRimborsi.Modalitdipagamento1Click(Sender: TObject);
begin
  A100UTipiPagamento.OpenA100TipiPagamento;
end;

end.
