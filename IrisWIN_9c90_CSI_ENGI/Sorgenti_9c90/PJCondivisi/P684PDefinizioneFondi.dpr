program P684PDefinizioneFondi;

uses
  Forms,
  P684UDefinizioneFondi in 'P684UDefinizioneFondi.pas' {P684FDefinizioneFondi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P684UDefinizioneFondiDtM in 'P684UDefinizioneFondiDtM.pas' {P684FDefinizioneFondiDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  P684UGenerale in 'P684UGenerale.pas' {P684FGenerale},
  P684UDettaglioDestin in 'P684UDettaglioDestin.pas' {P684FDettaglioDestin},
  P684UDettaglioRisorse in 'P684UDettaglioRisorse.pas' {P684FDettaglioRisorse},
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  P684UGrigliaDett in 'P684UGrigliaDett.pas' {P684FGrigliaDett},
  P684UDataRif in 'P684UDataRif.pas' {P684FDataRif};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP684FDefinizioneFondi, P684FDefinizioneFondi);
  Application.CreateForm(TP684FDefinizioneFondiDtM, P684FDefinizioneFondiDtM);
  Application.Run;
end.
