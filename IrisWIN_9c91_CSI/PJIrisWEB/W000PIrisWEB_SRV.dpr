program W000PIrisWEB_SRV;

uses
  IWStart,
  UTF8ContentParser,
  MidasLib,
  L021Call in '..\Copy\L021Call.pas',
  A000UInterfaccia in '..\Copy\A000UInterfaccia.pas' {A000ServerController: TDataModule},
  A000Versione in '..\Copy\A000Versione.pas',
  R005UDataModuleMW in '..\Repositary\R005UDataModuleMW.pas' {R005FDataModuleMW: TDataModule},
  R012UWebAnagrafico in '..\Repositary\R012UWebAnagrafico.pas' {R012FWebAnagrafico: TIWAppForm},
  R013UIterBase in '..\Repositary\R013UIterBase.pas' {R013FIterBase: TIWAppForm},
  C017UEMailDtM in '..\Copy\C017UEMailDtM.pas' {C017FEMailDtM: TDataModule},
  C018UIterAutDM in '..\Copy\C018UIterAutDM.pas' {C018FIterAutDM: TDataModule},
  C180FunzioniGenerali in '..\Copy\C180FunzioniGenerali.pas',
  C190FunzioniGeneraliWeb in '..\Copy\C190FunzioniGeneraliWeb.pas',
  WC001ULegendaCalendarioFM in '..\Copy\WC001ULegendaCalendarioFM.pas' {WC001FLegendaCalendarioFM: TFrame},
  WC002UDatiAnagraficiFM in '..\Copy\WC002UDatiAnagraficiFM.pas' {WC002FDatiAnagraficiFM: TFrame},
  WC002UStoriaDipendenteFM in '..\Copy\WC002UStoriaDipendenteFM.pas' {WC002FStoriaDipendenteFM: TFrame},
  WC012UVisualizzaFileFM in '..\Copy\WC012UVisualizzaFileFM.pas' {WC012FVisualizzaFileFM: TFrame},
  WC018URiepilogoIterFM in '..\Copy\WC018URiepilogoIterFM.pas' {WC018FRiepilogoIterFM: TFrame},
  W001UIrisWebDtM in 'W001UIrisWebDtM.pas' {W001FIrisWebDtM: TDataModule},
  W001ULogin in 'W001ULogin.pas' {W001FLogin: TIWAppForm},
  W002UAnagrafeElenco in 'W002UAnagrafeElenco.pas' {W002FAnagrafeElenco: TIWAppForm},
  W002UAnagrafeScheda in 'W002UAnagrafeScheda.pas' {W002FAnagrafeScheda: TIWAppForm},
  W002URicercaAnagrafe in 'W002URicercaAnagrafe.pas' {W002FRicercaAnagrafe: TIWAppForm},
  W003UAnomalie in 'W003UAnomalie.pas' {W003FAnomalie: TIWAppForm},
  W004UReperibilita in 'W004UReperibilita.pas' {W004FReperibilita: TIWAppForm},
  W005UCartellino in 'W005UCartellino.pas' {W005FCartellino: TIWAppForm},
  W005UCartellinoDtm in 'W005UCartellinoDtm.pas' {W005FCartellinoDtm: TDataModule},
  W006UListaReperibili in 'W006UListaReperibili.pas' {W006FListaReperibili: TIWAppForm},
  W008UGiustificativi in 'W008UGiustificativi.pas' {W008FGiustificativi: TIWAppForm},
  W009UStampaCartellino in 'W009UStampaCartellino.pas' {W009FStampaCartellino: TIWAppForm},
  W009UStampaCartellinoDtm in 'W009UStampaCartellinoDtm.pas' {W009FStampaCartellinoDtm: TDataModule},
  W009UIterCartellinoDM in 'W009UIterCartellinoDM.pas' {W009FIterCartellinoDM: TDataModule},
  W010URichiestaAssenze in 'W010URichiestaAssenze.pas' {W010FRichiestaAssenze: TIWAppForm},
  W010UCalcoloCompetenzeFM in 'W010UCalcoloCompetenzeFM.pas' {W010FCalcoloCompetenzeFM: TFrame},
  W010URichiestaAssenzeDM in 'W010URichiestaAssenzeDM.pas' {W010FRichiestaAssenzeDM: TDataModule},
  W011UNotificheElaborazioni in 'W011UNotificheElaborazioni.pas' {W011FNotificheElaborazioni: TIWAppForm},
  W012UCurriculum in 'W012UCurriculum.pas' {W012FCurriculum: TIWAppForm},
  W013UPreferenze in 'W013UPreferenze.pas' {W013FPreferenze: TIWAppForm},
  W014UPianifCorsi in 'W014UPianifCorsi.pas' {W014FPianifCorsi: TIWAppForm},
  W015UServerStampe in 'W015UServerStampe.pas' {W015FServerStampe: TIWAppForm},
  W016UAccessiMensa in 'W016UAccessiMensa.pas' {W016FAccessiMensa: TIWAppForm},
  W017UStampaCedolino in 'W017UStampaCedolino.pas' {W017FStampaCedolino: TIWAppForm},
  W018URichiestaTimbrature in 'W018URichiestaTimbrature.pas' {W018FRichiestaTimbrature: TIWAppForm},
  W018URiepilogoEccedenzeFM in 'W018URiepilogoEccedenzeFM.pas' {W018FRiepilogoEccedenzeFM: TFrame},
  W018URichiestaTimbratureDM in 'W018URichiestaTimbratureDM.pas' {W018FRichiestaTimbratureDM: TDataModule},
  W019UGestioneDeleghe in 'W019UGestioneDeleghe.pas' {W019FGestioneDeleghe: TIWAppForm},
  W020UCambioProfilo in 'W020UCambioProfilo.pas' {W020FCambioProfilo: TIWAppForm},
  W021UStampaCUD in 'W021UStampaCUD.pas' {W021FStampaCUD: TIWAppForm},
  W022UDettaglioValutazioni in 'W022UDettaglioValutazioni.pas' {W022FDettaglioValutazioni: TIWAppForm},
  W022USchedaValutazioni in 'W022USchedaValutazioni.pas' {W022FSchedaValutazioni: TIWAppForm},
  W022USchedaValutazioniDtM in 'W022USchedaValutazioniDtM.pas' {W022FSchedaValutazioniDtM: TDataModule},
  W022URiepilogoSchedeFM in 'W022URiepilogoSchedeFM.pas' {W022FRiepilogoSchedeFM: TFrame},
  W023UPianifOrari in 'W023UPianifOrari.pas' {W023FPianifOrari: TIWAppForm},
  W024URichiestaStraordinari in 'W024URichiestaStraordinari.pas' {W024FRichiestaStraordinari: TIWAppForm},
  W024URichiestaStraordinariDM in 'W024URichiestaStraordinariDM.pas' {W024FRichiestaStraordinariDM: TDataModule},
  W025UCambioOrario in 'W025UCambioOrario.pas' {W025FCambioOrario: TIWAppForm},
  W025UCambioOrarioDM in 'W025UCambioOrarioDM.pas' {W025FCambioOrarioDM: TDataModule},
  W026URichiestaStrGG in 'W026URichiestaStrGG.pas' {W026FRichiestaStrGG: TIWAppForm},
  W026URichiestaStrGGDM in 'W026URichiestaStrGGDM.pas' {W026FRichiestaStrGGDM: TDataModule},
  W027UDetrazioniIRPEF in 'W027UDetrazioniIRPEF.pas' {W027FDetrazioniIRPEF: TIWAppForm},
  W028UChiamateReperibili in 'W028UChiamateReperibili.pas' {W028FChiamateReperibili: TIWAppForm},
  W029UPesatureIndividuali in 'W029UPesatureIndividuali.pas' {W029FPesatureIndividuali: TIWAppForm},
  W030UTabelloneTurni in 'W030UTabelloneTurni.pas' {W030FTabelloneTurni: TIWAppForm},
  W031USchedeQuantIndividuali in 'W031USchedeQuantIndividuali.pas' {W031FSchedeQuantIndividuali: TIWAppForm},
  W031USchedeQuantPosizionatiFM in 'W031USchedeQuantPosizionatiFM.pas' {W031FSchedeQuantPosizionatiFM: TFrame},
  W032URichiestaMissioni in 'W032URichiestaMissioni.pas' {W032FRichiestaMissioni: TIWAppForm},
  W032URichiestaMissioniDM in 'W032URichiestaMissioniDM.pas' {W032FRichiestaMissioniDM: TDataModule},
  W033UProspettoAssenze in 'W033UProspettoAssenze.pas' {W033FProspettoAssenze: TIWAppForm},
  W033UAutorizzazioneAssenzeFM in 'W033UAutorizzazioneAssenzeFM.pas' {W033FAutorizzazioneAssenzeFM: TFrame},
  W033ULegendaAssenzeFM in 'W033ULegendaAssenzeFM.pas' {W033FLegendaAssenzeFM: TFrame},
  W033UProspettoAssenzeDM in 'W033UProspettoAssenzeDM.pas' {W033FProspettoAssenzeDM: TDataModule},
  W028UChiamateReperibiliDM in 'W028UChiamateReperibiliDM.pas' {W028FChiamateReperibiliDM: TDataModule},
  W014URiepilogoProfiliFM in 'W014URiepilogoProfiliFM.pas' {W014FRiepilogoProfiliFM: TFrame},
  WR010UBase in '..\Repositary\WR010UBase.pas' {WR010FBase: TIWAppForm},
  R010UPaginaWeb in '..\Repositary\R010UPaginaWeb.pas' {R010FPaginaWeb: TIWAppForm},
  WR000UBaseDM in '..\Repositary\WR000UBaseDM.pas' {WR000FBaseDM: TDataModule},
  WC501UMenuIrisWebFM in '..\Copy\WC501UMenuIrisWebFM.pas' {WC501FMenuIrisWebFM: TFrame},
  IWRtlFix in '..\Copy\IWRtlFix.pas',
  W034UPubblicazioneDocumenti in 'W034UPubblicazioneDocumenti.pas' {W034FPubblicazioneDocumenti: TIWAppForm},
  W034UPubblicazioneDocumentiDM in 'W034UPubblicazioneDocumentiDM.pas' {W034FPubblicazioneDocumentiDM: TDataModule},
  WR206UMenuFM in '..\Repositary\WR206UMenuFM.pas' {WR206FMenuFM: TFrame},
  A118UPubblicazioneDocumentiMW in '..\MWRilPre\A118UPubblicazioneDocumentiMW.pas' {A118FPubblicazioneDocumentiMW: TDataModule},
  W010UCancPeriodoFM in 'W010UCancPeriodoFM.pas' {W010FCancPeriodoFM: TFrame},
  W032UMotivazioneFM in 'W032UMotivazioneFM.pas' {W032FMotivazioneFM: TFrame},
  W035UMessaggistica in 'W035UMessaggistica.pas' {W035FMessaggistica: TIWAppForm},
  W035UMessaggisticaDM in 'W035UMessaggisticaDM.pas' {W035FMessaggisticaDM: TDataModule},
  WR300UBaseDM in '..\Repositary\WR300UBaseDM.pas' {WR300FBaseDM: TIWUserSessionBase},
  WC700USelezioneAnagrafeDM in '..\Copy\WC700USelezioneAnagrafeDM.pas' {WC700FSelezioneAnagrafeDM: TIWUserSessionBase},
  WC700USelezioneAnagrafeFM in '..\Copy\WC700USelezioneAnagrafeFM.pas',
  WR200UBaseFM in '..\Repositary\WR200UBaseFM.pas' {WR200FBaseFM: TFrame},
  W002UModificaDatiFM in 'W002UModificaDatiFM.pas' {W002FModificaDatiFM: TFrame},
  WC000UServerAdmin in '..\Copy\WC000UServerAdmin.pas',
  W005UCartellinoFM in 'W005UCartellinoFM.pas' {W005FCartellinoFM: TFrame},
  A023UTimbratureMW in '..\MWRilPre\A023UTimbratureMW.pas' {A023FTimbratureMW: TDataModule},
  WC013UCheckListFM in '..\Copy\WC013UCheckListFM.pas' {WC013FCheckListFM: TFrame},
  W002UModificaDatiDM in 'W002UModificaDatiDM.pas' {W002FModificaDatiDM: TDataModule},
  A004UGiustifAssPresMW in '..\MWRilPre\A004UGiustifAssPresMW.pas' {A004FGiustifAssPresMW: TDataModule},
  W032UPercorsoFM in 'W032UPercorsoFM.pas' {W032FPercorsoFM: TFrame},
  WC000UConfigIni in '..\Copy\WC000UConfigIni.pas',
  A000UCostanti in '..\Copy\A000UCostanti.pas',
  WC000UErrLimiteSessioni in '..\Copy\WC000UErrLimiteSessioni.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:=(DebugHook <> 0);
  TIWStart.Execute(False);
end.

