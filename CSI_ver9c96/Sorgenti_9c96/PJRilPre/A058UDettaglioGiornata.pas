unit A058UDettaglioGiornata;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids;

type
  TA058FDettaglioGiornata = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A058FDettaglioGiornata: TA058FDettaglioGiornata;

implementation

uses A058UPianifTurniDtM1;

{$R *.dfm}

procedure TA058FDettaglioGiornata.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(A058FDettaglioGiornata);
end;

end.
