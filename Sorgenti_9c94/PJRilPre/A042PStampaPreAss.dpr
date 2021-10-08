program A042PStampaPreAss;

uses
  Forms,
  MidasLib,
  A042UDialogStampa in 'A042UDialogStampa.pas' {A042FDialogStampa},
  A042UStampaPreAssDtM1 in 'A042UStampaPreAssDtM1.pas' {A042FStampaPreAssDtM1: TDataModule},
  A042UStampa in 'A042UStampa.pas' {A042FStampa},
  A042UStampaTab in 'A042UStampaTab.pas' {A042FStampaTab},
  SelAnagrafe in '..\Componenti\SelAnagrafe.pas' {frmSelAnagrafe: TFrame},
  A042UImpostazioniEUCausalizzate in 'A042UImpostazioniEUCausalizzate.pas' {A042FImpostazioniEUCausalizzate},
  A042UGrafico in 'A042UGrafico.pas' {A042FGrafico},
  A042UImpostazioniProspetto in 'A042UImpostazioniProspetto.pas' {A042FImpostazioniProspetto},
  A042UStampaEUCausalizzate in 'A042UStampaEUCausalizzate.pas' {A042FStampaEUCausalizzate: TQuickRep},
  A042UImpostazioniGrafico in 'A042UImpostazioniGrafico.pas' {A042FImpostazioniGrafico},
  A042UStampaProspetto in 'A042UStampaProspetto.pas' {A042FStampaProspetto: TQuickRep},
  A042UStampaGrafico in 'A042UStampaGrafico.pas' {A042FStampaGrafico: TQuickRep},
  A042UStampaPreAssMW in '..\MWRilPre\A042UStampaPreAssMW.pas' {A042FStampaPreAssMW: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TA042FDialogStampa, A042FDialogStampa);
  Application.CreateForm(TA042FStampaPreAssDtM1, A042FStampaPreAssDtM1);
  Application.Run;
end.
