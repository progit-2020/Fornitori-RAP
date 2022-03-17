program A176PRiepilogoIterAutorizzativi;

uses
  Vcl.Forms,
  OracleMonitor,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A176URiepilogoIterAutorizzativi in 'A176URiepilogoIterAutorizzativi.pas' {A176FRiepilogoIterAutorizzativi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A176URiepilogoIterAutorizzativiDM in 'A176URiepilogoIterAutorizzativiDM.pas' {A176FRiepilogoIterAutorizzativiDM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A176URiepilogoIterAutorizzativiMW in '..\MWRilPre\A176URiepilogoIterAutorizzativiMW.pas' {A176FRiepilogoIterAutorizzativiMW: TDataModule},
  C023UInfoDati in '..\Copy\C023UInfoDati.pas' {C023FInfoDati},
  A176UGestioneIterAutorizzativi in 'A176UGestioneIterAutorizzativi.pas' {A176FGestioneIterAutorizzativi},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA176FRiepilogoIterAutorizzativiDM, A176FRiepilogoIterAutorizzativiDM);
  Application.CreateForm(TA176FRiepilogoIterAutorizzativi, A176FRiepilogoIterAutorizzativi);
  Application.Run;
end.
