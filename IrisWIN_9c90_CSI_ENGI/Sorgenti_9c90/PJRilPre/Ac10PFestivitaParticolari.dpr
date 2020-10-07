program Ac10PFestivitaParticolari;

uses
  Vcl.Forms,
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  Ac10UFestivitaParticolariDtm in 'Ac10UFestivitaParticolariDtm.pas' {Ac10FFestivitaParticolariDtm: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  Ac10UFestivitaParticolari in 'Ac10UFestivitaParticolari.pas' {Ac10FFestivitaParticolari},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  Ac10UFestivitaParticolariMW in '..\MWRilPre\Ac10UFestivitaParticolariMW.pas' {Ac10FFestivitaParticolariMW: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAc10FFestivitaParticolari, Ac10FFestivitaParticolari);
  Application.CreateForm(TAc10FFestivitaParticolariDtm, Ac10FFestivitaParticolariDtm);
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  Application.Run;
end.
