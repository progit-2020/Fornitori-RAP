program A034PIntPaghe;

uses
  Forms,
  A034UIntPaghe in 'A034UIntPaghe.pas' {A034FIntPaghe},
  A034UIntPagheDTM1 in 'A034UIntPagheDTM1.pas' {A034FINTPAGHEDTM1: TDataModule},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A034UParametriAvanzatiDtM in 'A034UParametriAvanzatiDtM.pas' {A034FParametriAvanzatiDtM: TDataModule},
  A034UParametriAvanzati in 'A034UParametriAvanzati.pas' {A034FParametriAvanzati},
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A034UIntPagheMW in '..\MWRilPre\A034UIntPagheMW.pas' {A034FIntPagheMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas',
  A034UParametriAvanzatiMW in '..\MWRilPre\A034UParametriAvanzatiMW.pas' {A034FParametriAvanzatiMW: TDataModule},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA034FIntPaghe, A034FIntPaghe);
  Application.CreateForm(TA034FINTPAGHEDTM1, A034FINTPAGHEDTM1);
  Application.Run;
end.
