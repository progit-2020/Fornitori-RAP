program A077PGeneratoreStampe;

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
  R003USTAMPA in '..\Repositary\R003USTAMPA.pas' {R003FStampa},
  R003UGENERATORESTAMPEDTM in '..\Repositary\R003UGENERATORESTAMPEDTM.pas' {R003FGeneratoreStampeDtM: TDataModule},
  R003UGENERATORESTAMPE in '..\Repositary\R003UGENERATORESTAMPE.pas' {R003FGeneratoreStampe},
  R003UDatiCalcolati in '..\Repositary\R003UDatiCalcolati.pas' {R003FDatiCalcolati},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A077UGeneratoreStampeMW in '..\MWRilPre\A077UGeneratoreStampeMW.pas' {A077FGeneratoreStampeMW: TDataModule},
  R003UGeneratoreStampeMW in '..\Repositary\R003UGeneratoreStampeMW.pas' {R003FGeneratoreStampeMW: TDataModule},
  R600 in '..\MWRilPre\R600.pas' {R600DtM1: TDataModule},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Initialize;
  Application.CreateForm(TA077FGeneratoreStampe, A077FGeneratoreStampe);
  Application.CreateForm(TA077FGeneratoreStampeDtM, A077FGeneratoreStampeDtM);
  Application.CreateForm(TR003FDatiCalcolati, R003FDatiCalcolati);
  Application.Run;
end.
