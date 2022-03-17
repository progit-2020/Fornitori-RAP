program A099PUtilityDB;

uses
  Forms,
  A099UUtilityDB in 'A099UUtilityDB.pas' {A099FUtilityDB},
  A099UUtilityDBMW in '..\MWRilPre\A099UUtilityDBMW.pas' {A099FUtilityDBMW: TDataModule},
  A099UUtilityDBDtM1 in 'A099UUtilityDBDtM1.pas' {A099FUtilityDBDtM1: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA099FUtilityDB, A099FUtilityDB);
  Application.CreateForm(TA099FUtilityDBDtM1, A099FUtilityDBDtM1);
  Application.Run;
end.
