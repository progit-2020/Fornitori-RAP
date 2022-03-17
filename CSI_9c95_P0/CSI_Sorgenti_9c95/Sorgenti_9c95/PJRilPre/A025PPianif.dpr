program A025PPianif;

uses
  Forms,
  A025UPianif in 'A025UPianif.pas' {A025FPianif},
  A025UPianifDtM1 in 'A025UPianifDtM1.pas' {A025FPianifDtM1: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A025UPianifMW in '..\MWRilPre\A025UPianifMW.pas' {A025FPianifMW: TDataModule},
  ToolbarFiglio in '..\Componenti\ToolbarFiglio.pas' {frmToolbarFiglio: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA025FPianif, A025FPianif);
  Application.CreateForm(TA025FPianifDtM1, A025FPianifDtM1);
  Application.Run;
end.
