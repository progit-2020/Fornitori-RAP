program P130PPagamenti;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  P130UPagamenti in 'P130UPagamenti.pas' {P130FPagamenti},
  P130UPagamentiDtM in 'P130UPagamentiDtM.pas' {P130FPagamentiDtM: TDataModule},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  P130UPagamentiMW in '..\MWCondivisi\P130UPagamentiMW.pas' {P130FPagamentiMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TP130FPagamenti, P130FPagamenti);
  Application.CreateForm(TP130FPagamentiDtM, P130FPagamentiDtM);
  Application.Run;
end.
