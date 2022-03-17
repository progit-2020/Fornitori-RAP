program A131PGestioneAnticipi;

uses
  Forms,
  A131UGestioneAnticipi in 'A131UGestioneAnticipi.pas' {A131FGestioneAnticipi},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A131UGestioneAnticipiDtm in 'A131UGestioneAnticipiDtm.pas' {A131FGestioneAnticipiDtm: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A131UGestioneAnticipiMW in '..\MWRilPre\A131UGestioneAnticipiMW.pas' {A131FGestioneAnticipiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA131FGestioneAnticipi, A131FGestioneAnticipi);
  Application.CreateForm(TA131FGestioneAnticipiDtm, A131FGestioneAnticipiDtm);
  Application.Run;
end.
