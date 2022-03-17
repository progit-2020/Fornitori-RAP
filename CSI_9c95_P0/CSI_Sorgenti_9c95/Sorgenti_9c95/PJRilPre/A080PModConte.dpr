program A080PModConte;

uses
  Forms,
  A080UModConteDtM1 in 'A080UModConteDtM1.pas' {A080FModConteDtM1: TDataModule},
  A080UModConte in 'A080UModConte.pas' {A080FModConte},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A080USaldiAbbattuti in 'A080USaldiAbbattuti.pas' {A080FSaldiAbbattuti},
  A080UCausaliCompensabili in 'A080UCausaliCompensabili.pas' {A080FCausaliCompensabili},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A080URientriObbligatoriDtM in 'A080URientriObbligatoriDtM.pas' {A080FRientriObbligatoriDtM: TDataModule},
  A080USoglieStraordinario in 'A080USoglieStraordinario.pas' {A080FSoglieStraordinario},
  A080USoglieStraordinarioDtM in 'A080USoglieStraordinarioDtM.pas' {A080FSoglieStraordinarioDtM: TDataModule},
  A080URientriObbligatori in 'A080URientriObbligatori.pas' {A080FRientriObbligatori},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA080FModConte, A080FModConte);
  Application.CreateForm(TA080FModConteDtM1, A080FModConteDtM1);
  Application.Run;
end.
