unit A100UTipiPagamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, Grids, DBGrids, ExtCtrls, DBCtrls, StdCtrls, Mask,
  ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, System.Actions,
  A000UCostanti, A000UMessaggi;

type
  TA100FTipiPagamento = class(TR001FGestTab)
    GpbModalita: TGroupBox;
    Panel2: TPanel;
    dEdtCodice: TDBEdit;
    dEdtDescrizione: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBRadioGroup1: TDBRadioGroup;
    DBGrid1: TDBGrid;
    procedure DButtonStateChange(Sender: TObject);
    procedure TCancClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A100FTipiPagamento: TA100FTipiPagamento;
procedure OpenA100TipiPagamento();

implementation

uses A100UMISSIONIDTM;

{$R *.dfm}

procedure OpenA100TipiPagamento();
begin
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA100FTipiPagamento, A100FTipiPagamento);
  A100FTipiPagamento.dEdtCodice.DataSource:=A100FMISSIONIDTM.A100FMissioniMW.DM049;
  A100FTipiPagamento.dEdtDescrizione.DataSource:=A100FMISSIONIDTM.A100FMissioniMW.DM049;
  A100FTipiPagamento.DBRadioGroup1.DataSource:=A100FMISSIONIDTM.A100FMissioniMW.DM049;
  A100FTipiPagamento.DButton.DataSet:=A100FMISSIONIDTM.A100FMissioniMW.M049;

  try
    Screen.Cursor:=crDefault;
    A100FTipiPagamento.ShowModal;
  finally
    A100FTipiPagamento.Free;
  end;
end;

procedure TA100FTipiPagamento.DButtonStateChange(Sender: TObject);
begin
  inherited;
  GpbModalita.Enabled:=DButton.State=dsBrowse;
  dEdtCodice.Enabled:=DButton.State in [dsInsert, dsBrowse];
end;

procedure TA100FTipiPagamento.TCancClick(Sender: TObject);
begin
  If A100FMISSIONIDTM.A100FMissioniMW.M049CODICE.AsString=DEBIT then
    raise exception.Create(A000MSG_A100_ERR_PAG_DEBIT);
  inherited;
end;

end.
