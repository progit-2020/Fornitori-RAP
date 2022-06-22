program A146PFotoDipendente;

uses
  Forms,
  A146UFotoDipendente in 'A146UFotoDipendente.pas' {A146FFotoDipendente},
  A146UFotoDipendenteDtM in 'A146UFotoDipendenteDtM.pas' {A146FFotoDipendenteDtM: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA146FFotoDipendente, A146FFotoDipendente);
  Application.CreateForm(TA146FFotoDipendenteDtM, A146FFotoDipendenteDtM);
  Application.Run;
end.
