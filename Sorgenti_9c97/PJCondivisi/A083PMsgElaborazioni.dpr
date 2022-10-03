program A083PMsgElaborazioni;

uses
  Forms,
  OracleMonitor,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A083UMsgElaborazioni in 'A083UMsgElaborazioni.pas' {A083FMsgElaborazioni},
  A083UMsgElaborazioniDtm in 'A083UMsgElaborazioniDtm.pas' {A083FMsgElaborazioniDtm: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  InputPeriodo in '..\Componenti\InputPeriodo.pas' {frmInputPeriodo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA083FMsgElaborazioni, A083FMsgElaborazioni);
  Application.CreateForm(TA083FMsgElaborazioniDtm, A083FMsgElaborazioniDtm);
  Application.Run;
end.
