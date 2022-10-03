program A134PAllineamentoClient;

uses
  Forms,
  A134UAllineamentoClient in 'A134UAllineamentoClient.pas' {A134FAllineamentoClient},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  A134UAllineamentoClientDtm in 'A134UAllineamentoClientDtm.pas' {A134FAllineamentoClientDtm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA134FAllineamentoClient, A134FAllineamentoClient);
  Application.CreateForm(TA134FAllineamentoClientDtm, A134FAllineamentoClientDtm);
  Application.Run;
end.
