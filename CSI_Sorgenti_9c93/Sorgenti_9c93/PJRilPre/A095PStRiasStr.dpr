program A095PStRiasStr;

uses
  Forms,
  MidasLib,
  A095UStRiasStr in 'A095UStRiasStr.pas' {A095FStRiasStr},
  A095UStRiasStrDtM1 in 'A095UStRiasStrDtM1.pas' {A095FStRiasStrDtM1: TDataModule},
  A095UStampa in 'A095UStampa.pas' {A095FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A095UStRiasStrMW in '..\MWRilPre\A095UStRiasStrMW.pas' {A095FStRiasStrMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TA095FStRiasStr, A095FStRiasStr);
  Application.CreateForm(TA095FStRiasStrDtM1, A095FStRiasStrDtM1);
  Application.Run;
end.
