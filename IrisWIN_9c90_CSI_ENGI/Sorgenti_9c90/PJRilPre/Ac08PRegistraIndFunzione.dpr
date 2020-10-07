program Ac08PRegistraIndFunzione;

uses
  Forms,
  OracleMonitor,
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  Ac08URegistraIndFunzioneMW in '..\MWRilPre\Ac08URegistraIndFunzioneMW.pas' {Ac08FRegistraIndFunzioneMW: TDataModule},
  Ac08URegistraIndFunzione in 'Ac08URegistraIndFunzione.pas' {Ac08FRegistraIndFunzione},
  Ac08URegistraIndFunzioneDM in 'Ac08URegistraIndFunzioneDM.pas' {Ac08FRegistraIndFunzioneDM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'C:\Iris_Delphi\Help\Iris.hlp';
  Application.CreateForm(TAc08FRegistraIndFunzione, Ac08FRegistraIndFunzione);
  Application.CreateForm(TAc08FRegistraIndFunzioneDM, Ac08FRegistraIndFunzioneDM);
  Application.Run;
end.
