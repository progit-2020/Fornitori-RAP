program A153PPartecipEventiStraord;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A153UPartecipEventiStraord in 'A153UPartecipEventiStraord.pas' {A153FPartecipEventiStraord},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A153UPartecipEventiStraordDtM in 'A153UPartecipEventiStraordDtM.pas' {A153FPartecipEventiStraordDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA153FPartecipEventiStraord, A153FPartecipEventiStraord);
  Application.CreateForm(TA153FPartecipEventiStraordDtM, A153FPartecipEventiStraordDtM);
  Application.Run;
end.
