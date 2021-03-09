program A016PCausAssenze;

uses
  SysUtils,
  Forms,
  R001UGESTTAB in '..\REPOSITARY\R001UGESTTAB.pas' {R001FGestTab},
  A016UCausAssenze in 'A016UCausAssenze.pas' {A016FCausAssenze},
  A016UCausAssenzeDtM1 in 'A016UCausAssenzeDtM1.pas' {A016FCausAssenzeDtM1: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A016UCausAssenzeMW in '..\MWRilPre\A016UCausAssenzeMW.pas' {A016FCausAssenzeMW: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A016UCausAssenzeStorico in 'A016UCausAssenzeStorico.pas' {A016FCausAssenzeStorico},
  A016UCausAssenzeStoricoDM in 'A016UCausAssenzeStoricoDM.pas' {A016FCausAssenzeStoricoDM: TDataModule},
  A016UCausAssenzeStoricoMW in '..\MWRilPre\A016UCausAssenzeStoricoMW.pas' {A016FCausAssenzeStoricoMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA016FCausAssenze, A016FCausAssenze);
  Application.CreateForm(TA016FCausAssenzeDtM1, A016FCausAssenzeDtM1);
  Application.Run;
end.
