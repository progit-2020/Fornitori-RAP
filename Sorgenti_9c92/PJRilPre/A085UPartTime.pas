unit A085UPartTime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, Db, Menus, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids,
  A000UCostanti, A000USessione,A000UInterfaccia, StdCtrls, Mask, DBCtrls, ActnList, ImgList, ToolWin, Variants,
  System.Actions;

type
  TA085FPartTime = class(TR001FGestTab)
    pnlPrincipale: TPanel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label1: TLabel;
    DBEdit3: TDBEdit;
    Label6: TLabel;
    DBEdit4: TDBEdit;
    lblDescrizioneEstesa: TLabel;
    dedtDescrizioneEstesa: TDBEdit;
    Label9: TLabel;
    DBEdit9: TDBEdit;
    lblValorGG: TLabel;
    DBEdit10: TDBEdit;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A085FPartTime: TA085FPartTime;

procedure OpenA085PartTime(Cod:String);

implementation

uses A085UPartTimeDtM1;

{$R *.DFM}

procedure OpenA085PartTime(Cod:String);
{Tabella Part-time}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA085PartTime') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A085FPartTime:=TA085FPartTime.Create(nil);
  with A085FPartTime do
  try
    A085FPartTimeDtM1:=TA085FPartTimeDtM1.Create(nil);
    A085FPartTimeDtM1.Q460.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A085FPartTimeDtM1.Free;
    Release;
  end;
end;

procedure TA085FPartTime.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A085FPartTimeDtM1.Q460;
  inherited;
end;

end.
