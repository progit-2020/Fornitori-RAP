program P030PValute;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  P030UValute in 'P030UValute.pas' {P030FValute},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P030UValuteDtM in 'P030UValuteDtM.pas' {P030FValuteDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P030UValuteMW in '..\MWCondivisi\P030UValuteMW.pas' {P030FValuteMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP030FValute, P030FValute);
  Application.CreateForm(TP030FValuteDtM, P030FValuteDtM);
  Application.Run;
end.
