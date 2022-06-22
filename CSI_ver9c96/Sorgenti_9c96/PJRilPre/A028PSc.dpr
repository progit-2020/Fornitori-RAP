program A028PSc;

uses
  Forms,
  A028USC in 'A028USC.pas' {A028FSc},
  A028UScVisual in 'A028UScVisual.pas' {A028FSCVisual},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  Rp502Pro in '..\MWRilPre\Rp502Pro.pas' {R502ProDtM1: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A028UScMW in '..\MWRilPre\A028UScMW.pas' {A028FScMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA028FSc, A028FSc);
  Application.Run;
end.
