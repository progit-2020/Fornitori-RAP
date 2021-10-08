program A078PRichiestaAssistenza;

uses
  Forms,
  A078URichiestaAssistenzaDtM1 in 'A078URichiestaAssistenzaDtM1.pas' {A078FRichiestaAssistenzaDTM1: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A078URichiestaAssistenza in 'A078URichiestaAssistenza.pas' {A078FRichiestaAssistenza},
  A078UVisFile in 'A078UVisFile.pas' {A078FVisFile};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA078FRichiestaAssistenzaDTM1, A078FRichiestaAssistenzaDTM1);
  Application.CreateForm(TA078FRichiestaAssistenza, A078FRichiestaAssistenza);
  Application.Run;
end.
