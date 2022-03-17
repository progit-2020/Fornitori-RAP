program A170PGestioneGruppi;

uses
  Forms,
  A170UGestioneGruppi in 'A170UGestioneGruppi.pas' {A170FGestioneGruppi},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A170UGestioneGruppiDtM in 'A170UGestioneGruppiDtM.pas' {A170FGestioneGruppiDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A170UGestioneGruppiMW in '..\MWRilPre\A170UGestioneGruppiMW.pas' {A170FGestioneGruppiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA170FGestioneGruppi, A170FGestioneGruppi);
  Application.CreateForm(TA170FGestioneGruppiDtM, A170FGestioneGruppiDtM);
  Application.Run;
end.
