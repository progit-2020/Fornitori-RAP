program A026PDatiLiberi;

uses
  Forms,
  A026UDatiLiberi in 'A026UDatiLiberi.pas' {A026FDatiLIberi},
  A026UDatiLiberiDtM1 in 'A026UDatiLiberiDtM1.pas' {A026FDatiLIberiDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A026UDatiLiberiMW in '..\MWRilPre\A026UDatiLiberiMW.pas' {A026FDatiLiberiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA026FDatiLIberi, A026FDatiLIberi);
  Application.CreateForm(TA026FDatiLIberiDtM1, A026FDatiLIberiDtM1);
  Application.Run;
end.
