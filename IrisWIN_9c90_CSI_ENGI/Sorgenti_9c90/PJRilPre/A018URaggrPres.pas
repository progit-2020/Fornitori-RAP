unit A018URaggrPres;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ActnList, ImgList, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA018FRaggrPres = class(TR001FGestTab)
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup2: TDBRadioGroup;
    DBRadioGroup3: TDBRadioGroup;
    DBRadioGroup4: TDBRadioGroup;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A018FRaggrPres: TA018FRaggrPres;

procedure OpenA018RaggrPres(Cod:String);

implementation

uses A018URaggrPresDtM1;

{$R *.DFM}

procedure OpenA018RaggrPres(Cod:String);
{Raggruppamenti presenze}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA018RaggrPres') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A018FRaggrPres:=TA018FRaggrPres.Create(nil);
  with A018FRaggrPres do
  try
    A018FRaggrPresDtM1:=TA018FRaggrPresDtM1.Create(nil);
    DButton.DataSet:=A018FRaggrPresDtM1.T270;
    DButton.DataSet.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A018FRaggrPresDtM1.Free;
    Release;
  end;
end;

procedure TA018FRaggrPres.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A018FRaggrPresDtM1.T270;
  inherited;
end;

end.
