program A101PRaggrInterrogazioni;

uses
  Vcl.Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A101URaggrInterrogazioni in 'A101URaggrInterrogazioni.pas' {A101FRaggrInterrogazioni},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A101URaggrInterrogazioniDtm in 'A101URaggrInterrogazioniDtm.pas' {A101FRaggrInterrogazioniDtm: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame},
  A101URaggrInterrogazioniMW in '..\MWRilPre\A101URaggrInterrogazioniMW.pas' {A101FRaggrInterrogazioniMW: TDataModule};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA101FRaggrInterrogazioniDtm, A101FRaggrInterrogazioniDtm);
  Application.CreateForm(TA101FRaggrInterrogazioni, A101FRaggrInterrogazioni);
  Application.CreateForm(TA101FRaggrInterrogazioniMW, A101FRaggrInterrogazioniMW);
  Application.Run;
end.
