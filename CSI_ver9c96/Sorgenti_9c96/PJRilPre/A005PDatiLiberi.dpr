program A005PDatiLiberi;

uses
  Forms,
  MidasLib,
  OracleMonitor,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A005UDatiLiberi in 'A005UDatiLiberi.pas' {A115FDatiLiberiStoricizzati},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A005UDatiLiberiDM in 'A005UDatiLiberiDM.pas' {A115FDatiLiberiStoricizzatiDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA115FDatiLiberiStoricizzati, A115FDatiLiberiStoricizzati);
  Application.CreateForm(TA115FDatiLiberiStoricizzatiDtM, A115FDatiLiberiStoricizzatiDtM);
  Application.Run;
end.
