program A024PIndPresenza;

uses
  Forms,
  A000UInterfaccia,
  A024UIndPresenza in 'A024UIndPresenza.pas' {A024FIndPresenza},
  A024UIndPresenzaDtM1 in 'A024UIndPresenzaDtM1.pas' {A024FIndPresenzaDtM1: TDataModule},
  A024URegoleIndennita in 'A024URegoleIndennita.pas' {A024FRegoleIndennita},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDTM},
  C600USelAnagrafe in '..\Copy\C600USelAnagrafe.pas' {C600frmSelAnagrafe: TFrame},
  A024ULimitiInd in 'A024ULimitiInd.pas' {A024FLimitiInd},
  A024ULimitiIndDtm in 'A024ULimitiIndDtm.pas' {A024FLimitiIndDtm: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A024UIndPresenzaMW in '..\MWRilPre\A024UIndPresenzaMW.pas' {A024FIndPresenzaMW: TDataModule};

{$R *.RES}

begin
  Parametri.Applicazione:='RILPRE';
  Application.Initialize;
  Application.CreateForm(TA024FIndPresenza, A024FIndPresenza);
  Application.CreateForm(TA024FIndPresenzaDtM1, A024FIndPresenzaDtM1);
  Application.Run;
end.
