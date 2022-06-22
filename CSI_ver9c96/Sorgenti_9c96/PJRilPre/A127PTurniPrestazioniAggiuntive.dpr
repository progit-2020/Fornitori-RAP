program A127PTurniPrestazioniAggiuntive;

uses
  Forms,
  A127UTurniPrestazioniAggiuntive in 'A127UTurniPrestazioniAggiuntive.pas' {A127FTurniPrestazioniAggiuntive},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A127UTurniPrestazioniAggiuntiveDtm in 'A127UTurniPrestazioniAggiuntiveDtm.pas' {A127FTurniPrestazioniAggiuntiveDtm: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A127UTurniPrestazioniAggiuntiveMW in '..\MWRilPre\A127UTurniPrestazioniAggiuntiveMW.pas' {A127FTurniPrestazioniAggiuntiveMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA127FTurniPrestazioniAggiuntive, A127FTurniPrestazioniAggiuntive);
  Application.CreateForm(TA127FTurniPrestazioniAggiuntiveDtm, A127FTurniPrestazioniAggiuntiveDtm);
  Application.Run;
end.
