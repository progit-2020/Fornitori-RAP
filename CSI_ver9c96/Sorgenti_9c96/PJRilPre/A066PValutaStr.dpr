program A066PValutaStr;

uses
  Forms,
  A066UValutaStrDtM1 in 'A066UValutaStrDtM1.pas' {A066FValutaStrDtM1: TDataModule},
  A066UDialog in 'A066UDialog.pas' {A066FDialog},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  A066UStampa in 'A066UStampa.pas' {A066FStampa},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A066UValutaStr in 'A066UValutaStr.pas' {A066FValutaStr},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A066UValutaStrMW in '..\MWRilPre\A066UValutaStrMW.pas' {A066FValutaStrMW: TDataModule};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA066FValutaStr, A066FValutaStr);
  Application.CreateForm(TA066FValutaStrDtM1, A066FValutaStrDtM1);
  Application.Run;
end.
