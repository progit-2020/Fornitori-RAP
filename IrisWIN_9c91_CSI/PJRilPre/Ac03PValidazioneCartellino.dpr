program Ac03PValidazioneCartellino;

uses
  Vcl.Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  Ac03UValidazioneCartellino in 'Ac03UValidazioneCartellino.pas' {Ac03FValidazioneCartellino},
  Ac03UValidazioneCartellinoDtM in 'Ac03UValidazioneCartellinoDtM.pas' {Ac03FValidazioneCartellinoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  C018UIterAutDM in '..\Copy\C018UIterAutDM.pas' {C018FIterAutDM: TDataModule},
  L021Call in '..\Copy\L021Call.pas';

{$R *.res}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  {$WARN SYMBOL_PLATFORM ON}

  Application.Initialize;
  Application.MainFormOnTaskbar:=True;
  Application.CreateForm(TAc03FValidazioneCartellino, Ac03FValidazioneCartellino);
  Application.CreateForm(TAc03FValidazioneCartellinoDtM, Ac03FValidazioneCartellinoDtM);
  Application.Run;
end.
