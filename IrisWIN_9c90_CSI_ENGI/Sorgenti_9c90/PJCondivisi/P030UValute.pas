unit P030UValute;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Menus, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls,
  R004UGestStorico, R004UGestStoricoDtM, ImgList, ToolWin, ActnList, OracleData,
  A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, Variants, System.Actions;

type
  TP030FValute = class(TR004FGestStorico)
    DataSource1: TDataSource;
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    lblAbbreviazione: TLabel;
    lblFormatoVisual: TLabel;
    lblNrDecimali: TLabel;
    dedtCodice: TDBEdit;
    dedtAbbreviazione: TDBEdit;
    dedtNumeroDecImpVoce: TDBEdit;
    dedtNrDecimali: TDBEdit;
    dedtDescrizione: TDBEdit;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P030FValute: TP030FValute;

procedure OpenP030FValute(Cod:String);

implementation

uses P030UValuteDtM;

{$R *.DFM}

procedure OpenP030FValute(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP030FValute') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TP030FValute,P030FValute);
  Application.CreateForm(TP030FValuteDtM,P030FValuteDtM);
  P030FValuteDtM.selP030.SearchRecord('COD_VALUTA',Cod,[srFromBeginning]);
  try
    Screen.Cursor:=crDefault;
    P030FValute.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P030FValute.Free;
    P030FValuteDtM.Free;
  end;
end;

procedure TP030FValute.FormShow(Sender: TObject);
begin
  inherited;
  VisioneCorrente1Click(nil);
end;

end.
