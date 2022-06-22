program A077PCOMServer;

uses
  Forms,
  MidasLib,
  R003USerbatoi in '..\Repositary\R003USerbatoi.pas',
  R003UFormato in '..\Repositary\R003UFormato.pas' {R003FFormato},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A077UGeneratoreStampe in 'A077UGeneratoreStampe.pas' {A077FGeneratoreStampe},
  A077UGeneratoreStampeDtM in 'A077UGeneratoreStampeDtM.pas' {A077FGeneratoreStampeDtM: TDataModule},
  A077UStampa in 'A077UStampa.pas' {A077FStampa},
  R003UStampa in '..\Repositary\R003UStampa.pas' {R003FStampa},
  R003UGENERATORESTAMPEDTM in '..\Repositary\R003UGENERATORESTAMPEDTM.pas' {R003FGeneratoreStampeDtM: TDataModule},
  R003UGeneratoreStampe in '..\Repositary\R003UGeneratoreStampe.pas' {R003FGeneratoreStampe},
  R003UDatiCalcolati in '..\Repositary\R003UDatiCalcolati.pas' {R003FDatiCalcolati},
  A077UCOMServer in 'A077UCOMServer.pas' {A077FCOMServer},
  A077PCOMServer_TLB in 'A077PCOMServer_TLB.pas',
  A077UCOMRemoteDtM in 'A077UCOMRemoteDtM.pas' {A077COMServer: TRemoteDataModule};

{$R *.TLB}

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA077FCOMServer, A077FCOMServer);
  Application.Run;
end.
