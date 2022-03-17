
program P656PElaborazioneFLUPER;

uses
  Forms,
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  P656UElaborazioneFLUPERDtM in 'P656UElaborazioneFLUPERDtM.pas' {P656FElaborazioneFLUPERDtM: TDataModule},
  P656UElaborazioneFLUPER in 'P656UElaborazioneFLUPER.pas' {P656FElaborazioneFLUPER},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P656UElaborazioneFluperMW in '..\MWCondivisi\P656UElaborazioneFluperMW.pas' {P656FElaborazioneFluperMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP656FElaborazioneFLUPERDtM, P656FElaborazioneFLUPERDtM);
  Application.CreateForm(TP656FElaborazioneFLUPER, P656FElaborazioneFLUPER);
  Application.Run;
end.
