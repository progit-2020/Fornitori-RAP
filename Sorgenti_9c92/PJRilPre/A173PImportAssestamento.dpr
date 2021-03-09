program A173PImportAssestamento;

uses
  Forms,
  A173UImportAssestamento in 'A173UImportAssestamento.pas' {A173FImportAssestamento},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A173UImportAssestamentoMW in '..\MWRilPre\A173UImportAssestamentoMW.pas' {A173FImportAssestamentoMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA173FImportAssestamento, A173FImportAssestamento);
  Application.Run;
end.
