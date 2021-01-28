unit A024ULimitiInd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, StdCtrls, ComCtrls, ToolWin, Mask, DBCtrls, Buttons,
  A024ULimitiIndDtm, ExtCtrls, Grids, DBGrids, OracleData;

type
  TA024FLimitiInd = class(TR004FGestStorico)
    dGridLimitiTesta: TDBGrid;
    pnlLimitiDett: TPanel;
    Splitter1: TSplitter;
    pnlLimitiDettTitolo: TPanel;
    Panel2: TPanel;
    dGridLimitiDett: TDBGrid;
    dscT166: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FLimitiInd:String;
    procedure PutLImitiInd(Valore:String);
  public
    { Public declarations }
    property LimitiInd:String read FLimitiInd write PutLimitiInd;
  end;

var
  A024FLimitiInd: TA024FLimitiInd;

implementation

{$R *.dfm}

procedure TA024FLimitiInd.DButtonStateChange(Sender: TObject);
begin
  inherited;
  if dscT166.DataSet <> nil then
    TOracleDataSet(dscT166.DataSet).ReadOnly:=Not(DButton.State in [dsEdit]);
end;

procedure TA024FLimitiInd.FormCreate(Sender: TObject);
begin
  inherited;
  A024FLimitiIndDtm:=TA024FLimitiIndDtm.Create(Self);
  LimitiInd:='VBSP';
  {*****ASSEGNAZIONE*****
   DataSource <= DataSet
   DBGrid <= DataSource}
  DButton.DataSet:=A024FLimitiIndDtm.selT165;
  dGridLimitiTesta.DataSource:=DButton;
  dscT166.DataSet:=A024FLimitiIndDtm.selT166;
  dGridLimitiDett.DataSource:=dscT166;
end;

procedure TA024FLimitiInd.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A024FLimitiIndDtm);
end;

procedure TA024FLimitiInd.PutLimitiInd(Valore:String);
begin
  FLimitiInd:=Valore;
  A024FLimitiIndDtm.LimitiInd:=Valore;
end;

end.
