program S750PParProtocollo;

uses
  Forms,
  S750UParProtocollo in 'S750UParProtocollo.pas' {S750FParProtocollo},
  S750UParProtocolloDtM in 'S750UParProtocolloDtM.pas' {S750FParProtocolloDtM: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S750UParProtocolloMW in '..\MWCondivisi\S750UParProtocolloMW.pas' {S750FParProtocolloMW: TDataModule};

{$R *.RES}


begin
  Application.Initialize;
  Application.CreateForm(TS750FParProtocollo, S750FParProtocollo);
  Application.CreateForm(TS750FParProtocolloDtM, S750FParProtocolloDtM);
  Application.Run;
end.
