unit P680UMacrocategorieFondi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ExtCtrls,
  ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, A000UCostanti, A000USessione, A000UInterfaccia,
  Oracle, OracleData;

type
  TP680FMacrocategorieFondi = class(TR001FGestTab)
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TInserClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P680FMacrocategorieFondi: TP680FMacrocategorieFondi;

  procedure OpenP680MacrocategorieFondi(Codice:String);

implementation

uses P680UMacrocategorieFondiDtM;

{$R *.dfm}

procedure OpenP680MacrocategorieFondi(Codice:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP680MacrocategorieFondi') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP680FMacrocategorieFondi, P680FMacrocategorieFondi);
  Application.CreateForm(TP680FMacrocategorieFondiDtM, P680FMacrocategorieFondiDtM);
  try
    Screen.Cursor:=crDefault;
    P680FMacrocategorieFondiDtM.selP680.SearchRecord('COD_MACROCATEG',Codice,[srFromBeginning]);
    P680FMacrocategorieFondi.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P680FMacrocategorieFondi.Free;
    P680FMacrocategorieFondiDtM.Free;
  end;
end;

procedure TP680FMacrocategorieFondi.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=P680FMacrocategorieFondiDtM.selP680;
end;

procedure TP680FMacrocategorieFondi.TInserClick(Sender: TObject);
begin
  inherited;
  dedtCodice.SetFocus;
end;

end.
