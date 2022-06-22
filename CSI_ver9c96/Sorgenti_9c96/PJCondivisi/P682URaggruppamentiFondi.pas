unit P682URaggruppamentiFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, StdCtrls, Mask, DBCtrls, ExtCtrls, A000UCostanti, A000USessione, A000UInterfaccia,
  Oracle, OracleData;

type
  TP682FRaggruppamentiFondi = class(TR001FGestTab)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P682FRaggruppamentiFondi: TP682FRaggruppamentiFondi;

  procedure OpenP682RaggruppamentiFondi(Codice:String);

implementation

uses P682URaggruppamentiFondiDtM;

{$R *.dfm}

procedure OpenP682RaggruppamentiFondi(Codice:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP682RaggruppamentiFondi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP682FRaggruppamentiFondi, P682FRaggruppamentiFondi);
  Application.CreateForm(TP682FRaggruppamentiFondiDtM, P682FRaggruppamentiFondiDtM);
  try
    Screen.Cursor:=crDefault;
    P682FRaggruppamentiFondiDtM.selP682.SearchRecord('COD_RAGGR',Codice,[srFromBeginning]);
    P682FRaggruppamentiFondi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P682FRaggruppamentiFondi.Free;
    P682FRaggruppamentiFondiDtM.Free;
  end;
end;

procedure TP682FRaggruppamentiFondi.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=P682FRaggruppamentiFondiDtM.selP682;
end;

procedure TP682FRaggruppamentiFondi.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodice.SetFocus;
end;

end.
