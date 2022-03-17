unit A093UVideo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, ExtCtrls, Menus, C005UDatiAnagrafici, Variants;

type
  TA093FVideo = class(TForm)
    grdAnagra: TDBGrid;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    grdDettaglio: TDBGrid;
    Splitter2: TSplitter;
    PopupMenu1: TPopupMenu;
    Datianagrafici1: TMenuItem;
    procedure Datianagrafici1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A093FVideo: TA093FVideo;

implementation

uses A093UOperazioniDtM1;
{$R *.DFM}

procedure TA093FVideo.Datianagrafici1Click(Sender: TObject);
var P:Integer;
begin
  P:=0;
  if PopupMenu1.PopupComponent = grdAnagra then
    P:=grdAnagra.DataSource.DataSet.FieldByName('Progressivo').AsInteger
  else if (PopupMenu1.PopupComponent = grdDettaglio) and
          (UpperCase(grdDettaglio.DataSource.DataSet.FieldByName('Colonna').AsString) = 'PROGRESSIVO') then
  begin
    P:=StrToIntDef(grdDettaglio.DataSource.DataSet.FieldByName('Valore_Old').AsString,0);
    if P = 0 then
      P:=StrToIntDef(grdDettaglio.DataSource.DataSet.FieldByName('Valore_New').AsString,0);
  end;
  if P = 0 then exit;
  C005DataVisualizzazione:=Date;
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  try
    C005FDatiAnagrafici.ShowDipendente(P);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

end.
