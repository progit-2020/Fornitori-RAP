program A051PTimbOrig;

uses
  Forms,
  MidasLib,
  A051UTimbOrig in 'A051UTimbOrig.pas' {A051FTimbOrig},
  A051UTimbOrigDtM1 in 'A051UTimbOrigDtM1.pas' {A051FTimbOrigDtM1: TDataModule},
  A051UStampa in 'A051UStampa.pas' {A051FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A051UTimbOrigMW in '..\MWRilPre\A051UTimbOrigMW.pas' {A051FTimbOrigMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA051FTimbOrig, A051FTimbOrig);
  Application.CreateForm(TA051FTimbOrigDtM1, A051FTimbOrigDtM1);
  Application.Run;
end.
