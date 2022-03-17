unit P130UPagamenti;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R001UGESTTAB, DB, Menus, Buttons, ExtCtrls, ComCtrls, StdCtrls, DBCtrls,
  Mask, ImgList, ToolWin, ActnList, A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi,
  OracleData, Variants, System.Actions;

type
  TP130FPagamenti = class(TR001FGestTab)
    lblCodice: TLabel;
    lblDescrizione: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    lblModPagamento: TLabel;
    dedtModPagamento: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  P130FPagamenti: TP130FPagamenti;

procedure OpenP130FPagamenti(Cod:String);

implementation

uses P130UPagamentiDtM;

{$R *.DFM}

procedure OpenP130FPagamenti(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenP130FPagamenti') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  P130FPagamenti:=TP130FPagamenti.Create(nil);
  P130FPagamentiDtM:=TP130FPagamentiDtM.Create(nil);
  P130FPagamentiDtM.selP130.SearchRecord('Cod_Pagamento',Cod,[srFromBeginning]);
  try
    P130FPagamenti.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    P130FPagamenti.Free;
    P130FPagamentiDtM.Free;
  end;
end;

end.
