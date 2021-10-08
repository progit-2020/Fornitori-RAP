unit A008URegoleAccessoIP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, Vcl.Grids, Vcl.DBGrids,
  System.Actions, Vcl.ActnList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ToolWin, System.ImageList;

type
  TA008FRegoleAccessoIP = class(TR001FGestTab)
    dgrdRegole: TDBGrid;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A008FRegoleAccessoIP: TA008FRegoleAccessoIP;

implementation

uses
  A008UOperatoriDtM1;

{$R *.dfm}

procedure TA008FRegoleAccessoIP.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A008FOperatoriDtM1.selI076;
end;

end.
