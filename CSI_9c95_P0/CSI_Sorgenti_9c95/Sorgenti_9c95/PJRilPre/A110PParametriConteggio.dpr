program A110PParametriConteggio;

uses
  Forms,
  A110UParametriConteggioDtM in 'A110UParametriConteggioDtM.pas' {A110FParametriConteggioDtM: TDataModule},
  R004UGestStorico in '..\REPOSITARY\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A110UParametriConteggio in 'A110UParametriConteggio.pas' {A110FParametriConteggio},
  A110USoglieRimborsiPasto in 'A110USoglieRimborsiPasto.pas' {A110FSoglieRimborsiPasto},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A110UParametriConteggioMW in '..\MWRilPre\A110UParametriConteggioMW.pas' {A110FParametriConteggioMW: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA110FParametriConteggio, A110FParametriConteggio);
  Application.CreateForm(TA110FParametriConteggioDtM, A110FParametriConteggioDtM);
  Application.CreateForm(TR001FGestTab, R001FGestTab);
  Application.Run;
end.
