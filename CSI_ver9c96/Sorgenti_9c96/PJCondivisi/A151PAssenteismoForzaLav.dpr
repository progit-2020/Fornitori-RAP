program A151PAssenteismoForzaLav;

uses
  Forms,
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A151UAssenteismoDtM in 'A151UAssenteismoDtM.pas' {A151FAssenteismoDtM: TDataModule},
  A151UGrigliaRisultato in 'A151UGrigliaRisultato.pas' {A151FGrigliaRisultato},
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A151UAssenteismo in 'A151UAssenteismo.pas' {A151FAssenteismo},
  A151UEsportaXml in 'A151UEsportaXml.pas' {A151FEsportaXml};

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TA151FAssenteismo, A151FAssenteismo);
  Application.CreateForm(TA151FAssenteismoDtM, A151FAssenteismoDtM);
  Application.Run;
end.
