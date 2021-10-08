program A115PDatiLiberiStoricizzati;

uses
  Forms,
  MidasLib,
  R004UGestStorico in '..\Repositary\R004UGestStorico.pas' {R004FGestStorico},
  A115UDatiLiberiStoricizzati in 'A115UDatiLiberiStoricizzati.pas' {A115FDatiLiberiStoricizzati},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A115UDatiLiberiStoricizzatiDtM in 'A115UDatiLiberiStoricizzatiDtM.pas' {A115FDatiLiberiStoricizzatiDtM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA115FDatiLiberiStoricizzati, A115FDatiLiberiStoricizzati);
  Application.CreateForm(TA115FDatiLiberiStoricizzatiDtM, A115FDatiLiberiStoricizzatiDtM);
  Application.Run;
end.
