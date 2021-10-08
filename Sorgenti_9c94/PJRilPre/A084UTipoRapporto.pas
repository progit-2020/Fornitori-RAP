unit A084UTipoRapporto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  A000UCostanti, A000USessione,A000UInterfaccia, StdCtrls, Mask, DBCtrls, ActnList, ImgList, ToolWin, Variants, System.Actions, System.ImageList;

type
  TA084FTipoRapporto = class(TR001FGestTab)
    Label1: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A084FTipoRapporto: TA084FTipoRapporto;

procedure OpenA084TipoRapporto(Cod:string);

implementation

uses A084UTipoRapportoDtM1;

{$R *.DFM}

procedure OpenA084TipoRapporto(Cod:string);
{Tipi di rapporto (Ruolo/Incaricato/Supplente/Prova)}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA084TipoRapporto') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A084FTipoRapporto:=TA084FTipoRapporto.Create(nil);
  with A084FTipoRapporto do
  try
    A084FTipoRapportoDtM1:=TA084FTipoRapportoDtM1.Create(nil);
    A084FTipoRapportoDtM1.Q450.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A084FTipoRapportoDtM1.Free;
    Release;
  end;
end;

procedure TA084FTipoRapporto.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A084FTipoRapportoDtM1.Q450;
  inherited;
end;

end.
