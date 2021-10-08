unit A058UDettaglioTipiOperatori;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids;

type
  TA058FDettaglioTipiOperatori = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A058FDettaglioTipiOperatori: TA058FDettaglioTipiOperatori;

implementation

uses A058UPianifTurniDtM1, A058UPianifTurni;

{$R *.dfm}

procedure TA058FDettaglioTipiOperatori.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(A058FDettaglioTipiOperatori);
end;

procedure TA058FDettaglioTipiOperatori.FormShow(Sender: TObject);
begin
  A058FPianifTurniDtM1.selQ601.Close;
  A058FPianifTurniDtM1.selQ601.SetVariable('SQUADRA', A058FPianifTurni.dCmbSquadra.KeyValue);
  A058FPianifTurniDtM1.selQ601.Open;
end;

end.
