unit A150UTipoAccorpamentoCausali;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin,
  Oracle, OracleData, StdCtrls, Mask, DBCtrls, ExtCtrls, Grids, DBGrids;

type
  TA150FTipoAccorpamentoCausali = class(TR001FGestTab)
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    dbRdgTipoAccorpamento: TDBRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A150FTipoAccorpamentoCausali: TA150FTipoAccorpamentoCausali;

  procedure OpenA150TipoAccorpamentoCausali(Cod:String);

implementation

uses A150UAccorpamentoCausaliDtM;

{$R *.dfm}

procedure OpenA150TipoAccorpamentoCausali(Cod:String);
begin
  Application.CreateForm(TA150FTipoAccorpamentoCausali, A150FTipoAccorpamentoCausali);
  try
    A150FAccorpamentoCausaliDtM.selT255.SearchRecord('COD_TIPOACCORPCAUSALI',Cod,[srFromBeginning]);
    A150FTipoAccorpamentoCausali.ShowModal;
  finally
    FreeAndNil(A150FTipoAccorpamentoCausali);
  end;
end;

procedure TA150FTipoAccorpamentoCausali.FormShow(Sender: TObject);
begin
  inherited;
  DButton.Dataset:=A150FAccorpamentoCausaliDtM.selT255;
end;

procedure TA150FTipoAccorpamentoCausali.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodice.SetFocus;
end;

end.
