program A109PImmagini;

uses
  Forms,
  A109UImmagini in 'A109UImmagini.pas' {A109FImmagini},
  R004UGestStoricoDTM in '..\REPOSITARY\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A109UImmaginiDtM in 'A109UImmaginiDtM.pas' {A109FImmaginiDtM: TDataModule},
  A109UImmaginiMW in '..\MWRilPre\A109UImmaginiMW.pas' {A109FimmaginiMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA109FImmagini, A109FImmagini);
  Application.CreateForm(TA109FImmaginiDtM, A109FImmaginiDtM);
  Application.Run;
end.
