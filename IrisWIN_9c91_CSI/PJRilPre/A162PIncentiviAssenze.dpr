program A162PIncentiviAssenze;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A162UIncentiviAssenze in 'A162UIncentiviAssenze.pas' {A162FIncentiviAssenze},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A162UIncentiviAssenzeDtM in 'A162UIncentiviAssenzeDtM.pas' {A162FIncentiviAssenzeDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A162UIncentiviAssenzeMW in '..\MWRilPre\A162UIncentiviAssenzeMW.pas' {A162FIncentiviAssenzeMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA162FIncentiviAssenze, A162FIncentiviAssenze);
  Application.CreateForm(TA162FIncentiviAssenzeDtM, A162FIncentiviAssenzeDtM);
  Application.Run;
end.
