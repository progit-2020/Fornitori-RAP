program A118PPubblicazioneDocumenti;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A118UPubblicazioneDocumenti in 'A118UPubblicazioneDocumenti.pas' {A118FPubblicazioneDocumenti},
  A118UPubblicazioneDocumentiDtM in 'A118UPubblicazioneDocumentiDtM.pas' {A118FPubblicazioneDocumentiDtM: TDataModule},
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A118UPubblicazioneDocumentiMW in '..\MWRilPre\A118UPubblicazioneDocumentiMW.pas' {A118FPubblicazioneDocumentiMW: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA118FPubblicazioneDocumenti, A118FPubblicazioneDocumenti);
  Application.CreateForm(TA118FPubblicazioneDocumentiDtM, A118FPubblicazioneDocumentiDtM);
  Application.Run;
end.
