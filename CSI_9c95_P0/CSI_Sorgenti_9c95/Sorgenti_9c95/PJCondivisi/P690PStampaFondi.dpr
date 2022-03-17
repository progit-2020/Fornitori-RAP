program P690PStampaFondi;

uses
  Forms,
  P690UStampaFondi in 'P690UStampaFondi.pas' {P690FStampaFondi},
  R004UGESTSTORICODTM in '..\Repositary\R004UGESTSTORICODTM.pas' {R004FGestStoricoDtM: TDataModule},
  P690UStampaFondiDtM in 'P690UStampaFondiDtM.pas' {P690FStampaFondiDtM: TDataModule},
  P690UStampa in 'P690UStampa.pas' {P690FStampa},
  R002UQREP in '..\Repositary\R002UQREP.pas' {R002FQRep};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TP690FStampaFondi, P690FStampaFondi);
  Application.CreateForm(TP690FStampaFondiDtM, P690FStampaFondiDtM);
  Application.CreateForm(TR002FQRep, R002FQRep);
  Application.Run;
end.
