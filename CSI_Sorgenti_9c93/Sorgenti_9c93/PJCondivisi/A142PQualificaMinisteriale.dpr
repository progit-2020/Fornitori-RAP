program A142PQualificaMinisteriale;

uses
  Forms,
  MidasLib,
  A142UQualificaMinisteriale in 'A142UQualificaMinisteriale.pas' {A142FQualificaMinisteriale},
  A142UQualificaMinisterialeDtM in 'A142UQualificaMinisterialeDtM.pas' {A142FQualificaMinisterialeDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA142FQualificaMinisteriale, A142FQualificaMinisteriale);
  Application.CreateForm(TA142FQualificaMinisterialeDtM, A142FQualificaMinisterialeDtM);
  Application.Run;
end.
