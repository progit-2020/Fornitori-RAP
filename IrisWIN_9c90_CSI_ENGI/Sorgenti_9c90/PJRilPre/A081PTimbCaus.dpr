program A081PTimbCaus;

uses
  Forms,
  MidasLib,
  A081UTimbCaus in 'A081UTimbCaus.pas' {A081FTimbCaus},
  A081UTimbCausDtM1 in 'A081UTimbCausDtM1.pas' {A081FTimbCausDtM1: TDataModule},
  A081UStampa in 'A081UStampa.pas' {A081FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A081UTimbCausMW in '..\MWRilPre\A081UTimbCausMW.pas' {A081FTimbCausMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA081FTimbCaus, A081FTimbCaus);
  Application.CreateForm(TA081FTimbCausDtM1, A081FTimbCausDtM1);
  Application.Run;
end.
