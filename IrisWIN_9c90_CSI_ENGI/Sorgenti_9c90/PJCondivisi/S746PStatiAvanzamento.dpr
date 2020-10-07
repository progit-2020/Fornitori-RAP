program S746PStatiAvanzamento;

uses
  Forms,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  S746UStatiAvanzamento in 'S746UStatiAvanzamento.pas' {S746FStatiAvanzamento},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  S746UStatiAvanzamentoDtM in 'S746UStatiAvanzamentoDtM.pas' {S746FStatiAvanzamentoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  S746UStatiAvanzamentoMW in '..\MWCondivisi\S746UStatiAvanzamentoMW.pas' {S746FStatiAvanzamentoMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TS746FStatiAvanzamento, S746FStatiAvanzamento);
  Application.CreateForm(TS746FStatiAvanzamentoDtM, S746FStatiAvanzamentoDtM);
  Application.Run;
end.
