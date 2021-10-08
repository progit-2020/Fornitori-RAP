program P050PArrotondamenti;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  P050UArrotondamenti in 'P050UArrotondamenti.pas' {P050FArrotondamenti},
  P050UArrotondamentiDtM in 'P050UArrotondamentiDtM.pas' {P050FArrotondamentiDtM: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  P050UArrotondamentiValute in 'P050UArrotondamentiValute.pas' {P050FArrotondamentiValute},
  P050UArrotondamentiValuteDtM in 'P050UArrotondamentiValuteDtM.pas' {P050FArrotondamentiValuteDtM: TDataModule},
  P050UArrotondamentiMW in '..\MWCondivisi\P050UArrotondamentiMW.pas' {P050FArrotondamentiMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := '';
  Application.CreateForm(TP050FArrotondamenti, P050FArrotondamenti);
  Application.CreateForm(TP050FArrotondamentiDtM, P050FArrotondamentiDtM);
  Application.Run;
end.
