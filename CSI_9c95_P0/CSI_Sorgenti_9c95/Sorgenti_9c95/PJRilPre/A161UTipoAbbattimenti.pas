unit A161UTipoAbbattimenti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ExtCtrls, ActnList, ImgList, DB, Menus, ComCtrls,
  ToolWin, StdCtrls, Mask, DBCtrls, Grids, DBGrids, A000UInterfaccia, A000UCostanti, A000USessione,
  C180FunzioniGenerali, System.Actions;

type
  TA161FTipoAbbattimenti = class(TR001FGestTab)
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    dchkRisparmio: TDBCheckBox;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
    procedure dedtCodiceChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A161FTipoAbbattimenti: TA161FTipoAbbattimenti;

  procedure OpenA161TipoAbbattimenti;

implementation

uses A161UTipoAbbattimentiDtM;

{$R *.dfm}

procedure OpenA161TipoAbbattimenti;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA161TipoAbbattimenti') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA161FTipoAbbattimenti, A161FTipoAbbattimenti);
  Application.CreateForm(TA161FTipoAbbattimentiDtM, A161FTipoAbbattimentiDtM);
  try
    Screen.Cursor:=crDefault;
    A161FTipoAbbattimenti.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A161FTipoAbbattimenti.Free;
    A161FTipoAbbattimentiDtM.Free;
  end;
end;

procedure TA161FTipoAbbattimenti.dedtCodiceChange(Sender: TObject);
var n:Real;
begin
  inherited;
  try
    n:=StrToFloat(dedtCodice.Text);
    dedtCodice.Text:='';
    R180MessageBox('Impossibile specificare codici numerici!','ERRORE');
  except
  end;
end;

procedure TA161FTipoAbbattimenti.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A161FTipoAbbattimentiDtM.selT766;
  A161FTipoAbbattimentiDtM.selT766.Open;
end;

procedure TA161FTipoAbbattimenti.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodice.SetFocus;
end;

end.
