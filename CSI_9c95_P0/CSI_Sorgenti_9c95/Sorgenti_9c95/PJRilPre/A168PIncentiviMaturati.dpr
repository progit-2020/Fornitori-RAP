program A168PIncentiviMaturati;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A168UIncentiviMaturati in 'A168UIncentiviMaturati.pas' {A168FIncentiviMaturati},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A168UIncentiviMaturatiDtM in 'A168UIncentiviMaturatiDtM.pas' {A168FIncentiviMaturatiDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A168UIncentiviMaturatiMW in '..\MWRilPre\A168UIncentiviMaturatiMW.pas' {A168FIncentiviMaturatiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA168FIncentiviMaturati, A168FIncentiviMaturati);
  Application.CreateForm(TA168FIncentiviMaturatiDtM, A168FIncentiviMaturatiDtM);
  Application.Run;
end.
