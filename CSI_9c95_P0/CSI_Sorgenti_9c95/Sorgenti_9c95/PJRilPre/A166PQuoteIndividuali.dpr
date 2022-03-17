program A166PQuoteIndividuali;

uses
  Forms,
  R001UGESTTAB in '..\Repositary\R001UGESTTAB.pas' {R001FGestTab},
  A166UQuoteIndividuali in 'A166UQuoteIndividuali.pas' {A166FQuoteIndividuali},
  R004UGestStoricoDTM in '..\Repositary\R004UGestStoricoDTM.pas' {R004FGestStoricoDtM: TDataModule},
  A166UQuoteIndividualiDtM in 'A166UQuoteIndividualiDtM.pas' {A166FQuoteIndividualiDtM: TDataModule},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A166UAcquisizione in 'A166UAcquisizione.pas' {A166FAcquisizione},
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  A166UQuoteIndividualiMW in '..\MWRilPre\A166UQuoteIndividualiMW.pas' {A166FQuoteIndividualiMW: TDataModule},
  A000UMessaggi in '..\Copy\A000UMessaggi.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TA166FQuoteIndividuali, A166FQuoteIndividuali);
  Application.CreateForm(TA166FQuoteIndividualiDtM, A166FQuoteIndividualiDtM);
  Application.Run;
end.
