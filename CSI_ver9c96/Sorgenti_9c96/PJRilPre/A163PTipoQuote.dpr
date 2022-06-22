program A163PTipoQuote;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A163UTipoQuoteDtM in 'A163UTipoQuoteDtM.pas' {A163FTipoQuoteDtM: TDataModule},
  A163UTipoQuote in 'A163UTipoQuote.pas' {A163FTipoQuote},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A163UTipoQuoteMW in '..\MWRilPre\A163UTipoQuoteMW.pas' {A163FTipoQuoteMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA163FTipoQuote, A163FTipoQuote);
  Application.CreateForm(TA163FTipoQuoteDtM, A163FTipoQuoteDtM);
  Application.Run;
end.
