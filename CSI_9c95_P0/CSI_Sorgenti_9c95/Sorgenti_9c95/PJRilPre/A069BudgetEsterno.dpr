program A069BudgetEsterno;

uses
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A069UBudgetEsternoDtm in 'A069UBudgetEsternoDtm.pas' {A069FBudgetEsternoDtm: TDataModule},
  A069UBudgetEsterno in 'A069UBudgetEsterno.pas' {A069FBudgetEsterno: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA069FBudgetEsterno, A069FBudgetEsterno);
  Application.CreateForm(TA069FBudgetEsternoDtm, A069FBudgetEsternoDtm);
  Application.Run;
end.
