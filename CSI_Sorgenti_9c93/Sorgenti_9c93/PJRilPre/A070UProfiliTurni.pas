unit A070UProfiliTurni;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, StdCtrls, Mask, DBCtrls, ActnList, ImgList, Db, Menus,
  ComCtrls, ToolWin, A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA070FProfiliTurni = class(TR001FGestTab)
    GrbParametri: TGroupBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dEdtCodice: TDBEdit;
    dEdtDescrizione: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    dEdtNUMMAXGGCONSECUTIVIDILAVORO: TDBEdit;
    dEdtNUMMINNOTTIPERGRUPPODINOTTI: TDBEdit;
    dEdtNUMMAXNOTTIPERGRUPPODINOTTI: TDBEdit;
    dEdtNUMRIPOSIDOPOTURNODINOTTE: TDBEdit;
    dEdtNUMGGTRADUETURNIDINOTTE: TDBEdit;
    dEdtNUMOKNOTTIPERCICLOFERIALE: TDBEdit;
    dEdtNUMOKNOTTIPERCICLOFESTIVO: TDBEdit;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A070FProfiliTurni: TA070FProfiliTurni;

procedure OpenA070ProfiliTurni(cod:string);

implementation

uses A070UProfiliTurniDtM1;

{$R *.DFM}

procedure OpenA070ProfiliTurni(cod:string);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA070ProfiliTurni') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
A070FProfiliTurni:=TA070FProfiliTurni.Create(nil);
with A070FProfiliTurni do
  try
    A070FProfiliTurniDtM1:=TA070FProfiliTurniDtM1.Create(nil);
    A070FProfiliTurniDtM1.D602.Locate('Codice',cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A070FProfiliTurniDtM1.Free;
    Free;
  end;
end;

procedure TA070FProfiliTurni.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A070FProfiliTurniDtM1.D602;
  inherited;
end;

end.
