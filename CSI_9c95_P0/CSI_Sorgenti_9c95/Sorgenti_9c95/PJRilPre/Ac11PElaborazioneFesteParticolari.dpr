program Ac11PElaborazioneFesteParticolari;

uses
  Forms,
  MidasLib,
  Ac11UElaborazioneFesteParticolari in 'Ac11UElaborazioneFesteParticolari.pas' {Ac11FElaborazioneFesteParticolari},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  Ac11UElaborazioneFesteParticolariMW in '..\MWRilPre\Ac11UElaborazioneFesteParticolariMW.pas' {Ac11FElaborazioneFesteParticolariMW: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  {$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  {$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.CreateForm(TR004FGestStoricoDtM, R004FGestStoricoDtM);
  Application.CreateForm(TAc11FElaborazioneFesteParticolari, Ac11FElaborazioneFesteParticolari);
  Application.Run;
end.
