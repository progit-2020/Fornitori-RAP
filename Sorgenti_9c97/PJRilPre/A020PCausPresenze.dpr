program A020PCausPresenze;

uses
  Forms,
  A020UCausPresenze in 'A020UCausPresenze.pas' {A020FCausPresenze},
  A020UCausPresenzeDtM1 in 'A020UCausPresenzeDtM1.pas' {A020FCausPresenzeDtM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A020UCausPresenzeMW in '..\MWRilPre\A020UCausPresenzeMW.pas' {A020FCausPresenzeMW: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A020UCausPresenzeStorico in 'A020UCausPresenzeStorico.pas' {A020FCausPresStorico},
  A020UCausPresenzeStoricoDtM1 in 'A020UCausPresenzeStoricoDtM1.pas' {A020FCausPresenzeStoricoDtM1: TDataModule},
  A020UCausPresenzeStoricoMW in '..\MWRilPre\A020UCausPresenzeStoricoMW.pas' {A020FCausPresenzeStoricoMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA020FCausPresenze, A020FCausPresenze);
  Application.CreateForm(TA020FCausPresenzeDtM1, A020FCausPresenzeDtM1);
  Application.Run;
end.
