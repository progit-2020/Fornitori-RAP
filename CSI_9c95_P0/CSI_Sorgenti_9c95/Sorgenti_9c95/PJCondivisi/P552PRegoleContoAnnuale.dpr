program P552PRegoleContoAnnuale;

uses
  Forms,
  P552URegoleContoAnnuale in 'P552URegoleContoAnnuale.pas' {P552FRegoleContoAnnuale},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P552URegoleContoAnnualeDtM in 'P552URegoleContoAnnualeDtM.pas' {P552FRegoleContoAnnualeDtM: TDataModule},
  P552UDettaglioRegoleContoAnn in 'P552UDettaglioRegoleContoAnn.pas' {P552FDettaglioRegoleContoAnn},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  P552UEsportazioneFile in 'P552UEsportazioneFile.pas' {P552FEsportazioneFile},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TP552FRegoleContoAnnuale, P552FRegoleContoAnnuale);
  Application.CreateForm(TP552FRegoleContoAnnualeDtM, P552FRegoleContoAnnualeDtM);
  Application.Run;
end.
