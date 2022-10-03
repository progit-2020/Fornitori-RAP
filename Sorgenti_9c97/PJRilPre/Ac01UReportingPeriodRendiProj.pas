unit Ac01UReportingPeriodRendiProj;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Data.DB;

type
  TAc01FReportingPeriodRendiProj = class(TForm)
    lblProgetto: TLabel;
    dlblProgetto: TDBText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    dgrdReportingPeriod: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ac01FReportingPeriodRendiProj: TAc01FReportingPeriodRendiProj;

implementation

{$R *.dfm}

uses Ac01UProgettiRendiProjDtM;

procedure TAc01FReportingPeriodRendiProj.FormCreate(Sender: TObject);
begin
  dlblProgetto.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT756;
  dgrdReportingPeriod.DataSource:=Ac01FProgettiRendiProjDtM.Ac01MW.dsrT756;
  with Ac01FProgettiRendiProjDtM.Ac01MW do
    if not selT756.ReadOnly then
    begin
      CreaReportingPeriod;
      selT756.Edit;
    end;
end;

procedure TAc01FReportingPeriodRendiProj.BitBtn1Click(Sender: TObject);
begin
  with Ac01FProgettiRendiProjDtM.Ac01MW do
    if dsrT756.State <> dsBrowse then
      selT756.Post;
end;

procedure TAc01FReportingPeriodRendiProj.BitBtn2Click(Sender: TObject);
begin
  with Ac01FProgettiRendiProjDtM.Ac01MW do
  begin
    if dsrT756.State <> dsBrowse then
      selT756.Cancel;
    if selT756.UpdatesPending then
      selT756.Session.CancelUpdates([selT756]);
  end;
end;

procedure TAc01FReportingPeriodRendiProj.FormClose(Sender: TObject; var Action: TCloseAction);
var MexCtrl:String;
begin
  if ModalResult = mrOk then
    MexCtrl:=Ac01FProgettiRendiProjDtM.Ac01MW.ControllaReportingPeriod;
  if MexCtrl <> '' then
  begin
    Action:=caNone;
    raise exception.Create(MexCtrl);
  end;
end;

end.
