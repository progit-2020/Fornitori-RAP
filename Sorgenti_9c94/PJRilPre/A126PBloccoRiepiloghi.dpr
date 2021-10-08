program A126PBloccoRiepiloghi;

uses
  Forms,
  MidasLib,
  A126UBloccoRiepiloghi in 'A126UBloccoRiepiloghi.pas' {A126FBloccoRiepiloghi},
  A126UBloccoRiepiloghiDtM1 in 'A126UBloccoRiepiloghiDtM1.pas' {A126FBloccoRiepiloghiDtM1: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A126UBloccoRiepiloghiMW in '..\MWRilPre\A126UBloccoRiepiloghiMW.pas' {A126FBloccoRiepiloghiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA126FBloccoRiepiloghi, A126FBloccoRiepiloghi);
  Application.CreateForm(TA126FBloccoRiepiloghiDtM1, A126FBloccoRiepiloghiDtM1);
  Application.Run;
end.
