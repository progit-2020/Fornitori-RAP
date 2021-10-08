program P555PContoAnnuale;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGESTSTORICODTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  P555UContoAnnuale in 'P555UContoAnnuale.pas' {P555FContoAnnuale},
  P555UContoAnnualeDtM in 'P555UContoAnnualeDtM.pas' {P555FContoAnnualeDtM: TDataModule},
  P555UElencoDipendenti in 'P555UElencoDipendenti.pas' {P555FElencoDipendenti},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP555FContoAnnuale, P555FContoAnnuale);
  Application.CreateForm(TP555FContoAnnualeDtM, P555FContoAnnualeDtM);
  Application.Run;
end.
