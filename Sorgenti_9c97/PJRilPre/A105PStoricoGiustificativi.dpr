program A105PStoricoGiustificativi;

uses
  Forms,
  MidasLib,
  A105UStoricoGiustificativi in 'A105UStoricoGiustificativi.pas' {A105FStoricoGiustificativi},
  A105UStampa in 'A105UStampa.pas' {A105FStampa},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A105UStoricoGiustificativiMW in '..\MWRilPre\A105UStoricoGiustificativiMW.pas' {A105FStoricoGiustificativiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA105FStoricoGiustificativi, A105FStoricoGiustificativi);
  Application.Run;
end.
