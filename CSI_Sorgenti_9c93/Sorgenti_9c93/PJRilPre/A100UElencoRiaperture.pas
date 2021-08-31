unit A100UElencoRiaperture;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, A000UMessaggi, C180FunzioniGenerali,
  A100UMissioniDtM, A100UMissioniMW ;

type
  TA100FElencoRiaperture = class(TForm)
    pnlPulsanti: TPanel;
    dgrdElenco: TDBGrid;
    Panel1: TPanel;
    btnChiudi: TBitBtn;
    procedure btnChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure OpenA100ElencoRiaperture(IdMissione:String);

var
  A100FElencoRiaperture: TA100FElencoRiaperture;

implementation

{$R *.dfm}

procedure OpenA100ElencoRiaperture(IdMissione:String);
var
  lA100FMissioniMW:TA100FMissioniMW;
begin
  Screen.Cursor:=crHourglass;
  try
    lA100FMissioniMW:=A100FMISSIONIDTM.A100FMissioniMW;
    lA100FMissioniMW.selLogRiaperture.Close;
    lA100FMissioniMW.selLogRiaperture.SetVariable('ID_MISSIONE',IdMissione);
    lA100FMissioniMW.selLogRiaperture.Open;
    if lA100FMissioniMW.selLogRiaperture.RecordCount > 0 then
    begin
      A100FElencoRiaperture:=TA100FElencoRiaperture.Create(nil);
      try
        A100FElencoRiaperture.dgrdElenco.DataSource:=lA100FMissioniMW.dsrLogRiaperture;
        A100FElencoRiaperture.ShowModal;
      finally
        FreeAndNil(A100FElencoRiaperture);
      end;
    end
    else
    begin
      R180MessageBox(A000MSG_A100_MSG_NO_RIAPERTURE,INFORMA);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA100FElencoRiaperture.btnChiudiClick(Sender: TObject);
begin
  Close;
end;

end.
