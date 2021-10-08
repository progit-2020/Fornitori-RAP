unit A132UMagazzinoBuoniPasto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, A000UCostanti, A000USessione, A000UInterfaccia, A003UDataLavoroBis,
  System.Actions;

type
  TA132FMagazzinoBuoniPasto = class(TR001FGestTab)
    DBGrid1: TDBGrid;
    Riepilogomagazzinobuonipastoticket1: TMenuItem;
    procedure Riepilogomagazzinobuonipastoticket1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A132FMagazzinoBuoniPasto: TA132FMagazzinoBuoniPasto;

procedure OpenA132MagazzinoBuoniPasto;

implementation

{$R *.dfm}

uses A132UMagazzinoBuoniPastoDtM, A132UControllo;

procedure OpenA132MagazzinoBuoniPasto;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA132MagazzinoBuoniPasto') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A132FMagazzinoBuoniPasto:=TA132FMagazzinoBuoniPasto.Create(nil);
  with A132FMagazzinoBuoniPasto do
    try
      A132FMagazzinoBuoniPastoDtM:=TA132FMagazzinoBuoniPastoDtM.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A132FMagazzinoBuoniPastoDtM.Free;
      Free;
    end;
end;

procedure TA132FMagazzinoBuoniPasto.FormShow(Sender: TObject);
begin
  DButton.DataSet:=A132FMagazzinoBuoniPastoDtM.selT691;
end;

procedure TA132FMagazzinoBuoniPasto.Riepilogomagazzinobuonipastoticket1Click(
  Sender: TObject);
begin
  if DButton.State in [dsEdit,dsInsert] then
    DButton.DataSet.Cancel;
  A132FControllo:=TA132FControllo.Create(nil);
  with A132FControllo do
    try
      ShowModal;
    finally
      Release;
      A132FMagazzinoBuoniPastoDtM.selT691.Close;
      A132FMagazzinoBuoniPastoDtM.selT691.SetVariable('WHERE','');
      A132FMagazzinoBuoniPastoDtM.selT691.Open;
    end;
end;

end.
