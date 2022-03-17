program A130POraLegaleSolare;

uses
  Forms,
  HtmlHelpViewer,
  A130UOraLegaleSolare in 'A130UOraLegaleSolare.pas' {A130FOraLegaleSolare},
  A130UOraLegaleSolareDtM in 'A130UOraLegaleSolareDtM.pas' {A130FOraLegaleSolareDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  C013UCheckList in '..\Copy\C013UCheckList.pas' {C013FCheckList},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA130FOraLegaleSolare, A130FOraLegaleSolare);
  Application.CreateForm(TA130FOraLegaleSolareDtM, A130FOraLegaleSolareDtM);
  Application.CreateForm(TR004FGestStoricoDtM, R004FGestStoricoDtM);
  Application.Run;
end.
