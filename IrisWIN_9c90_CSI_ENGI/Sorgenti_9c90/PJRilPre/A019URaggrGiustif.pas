unit A019URaggrGiustif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA019FRaggrGiustif = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A019FRaggrGiustif: TA019FRaggrGiustif;

procedure OpenA019RaggrGiustif(Cod:String);

implementation

uses A019URaggrGiustifDtM1;

{$R *.DFM}

procedure OpenA019RaggrGiustif(Cod:String);
{Raggruppamenti giustificativi}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA019RaggrGiustif') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A019FRaggrGiustif:=TA019FRaggrGiustif.Create(nil);
  with A019FRaggrGiustif do
  try
    A019FRaggrGiustifDtM1:=TA019FRaggrGiustifDtM1.Create(nil);
    DButton.DataSet:=A019FRaggrGiustifDtM1.T300;
    DButton.DataSet.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A019FRaggrGiustifDtM1.Free;
    Release;
  end;
end;

procedure TA019FRaggrGiustif.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A019FRaggrGiustifDtM1.T300;
  inherited;
end;

end.
