unit A002UAnagrafeVista;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActnList, ImgList, Menus, ExtCtrls, ComCtrls,
  ToolWin, StdCtrls, Buttons, Grids, DBGrids,
  A000UCostanti, A000USessione,A000UInterfaccia,
  A002UAnagrafeVistaPadre,A004UGiustifAssPres,
  A005UTabelle,A006UModelliOrario,A007UProfiliOrari,A009UProfiliAsse,
  A010UProfAsseInd,A011UComuniProvinceRegioni,A012UCalendari,A013UCalendIndiv,A014UPlusOrario,
  A015UPlusOraIndiv,A016UCausAssenze,A017URaggrAsse,A018URaggrPres,A019URaggrGiustif,
  A020UCausPresenze,A021UCausGiustif,A022UContratti,A023UTimbrature,A024UIndPresenza,
  A025UPianif,A027UCarMen, A029USchedaRiepil,
  A030UResidui,A031UParScarico,A032UScarico,A033UStampaAnomalie,A034UIntPaghe,A035UParScarico,
  A036UTurniRep,A037UScaricoPaghe,A038UVociVariabili,A039URegReperib,A040UPianifRep,
  A041UInsRiposi,A042UDialogStampa,A043UDialogStampa,
  A045UDialogStampa,A046UTerMensa,A047UTimbMensa,A048UPastiMese,A049UDialogStampa,
  A050UOrologi,A051UTimbOrig,A052UParCar,A053USquadre,A054UCicliTurni,
  A055UTurnazioni,A056UTurnazInd,A057USpostSquadra,A058UPianifTurni,A059UContSquadre, A174UParPianifTurni,
  A060UTimbIrregolari,A061UDettAssenze,A062UQueryServizio,A063UBudgetGenerazione,A064UBudgetStraordinario,
  A065UStampaBudget,A066UValutaStr,A067URepSostB,A068UTurniGior, A069UBudgetEsterno,(*A069ULiquidProp,*)
  A071URegoleBuoni,A072UBuoniMese,A073UAcquistoBuoni,A074URiepilogoBuoni,
  A075UFineAnno,A076UIndGruppo,A077UGeneratoreStampe,A079UAssenzeAuto,
  A080UModConte,A081UTimbCaus,A084UTipoRapporto,
  A085UPartTime,A086UMotivazioniRichieste,A087UImpAttestatiMal,A088UDatiLiberiIterMissioni,
  A090UAssenzeAnno,A091ULiquidPresenze,A092UStampaStorico,A094USkLimitiStr,
  A095UStRiasStr,A096UProfiliLibProf,A097UPianifLibProf,
  A100UMissioni,(*A101URipartizioneStr,*)A102UParScaricoGiust,A103UScaricoGiust,A104UDialogStampa,
  A105UStoricoGiustificativi,A106UDistanzeTrasferta,A107UInsAssAutoRegole,A108UInsAssAuto,A109UImmagini,
  A110UParametriConteggio,A111UParmessaggi,A112UInvioMessaggi,A113UParestrazioniStampe,A114UEstrazioniStampe,
  A115UDatiLiberiStoricizzati,A116ULiquidazioneOreAnniPrec,A117UOreLiquidateAnniPrec,
  A118UPubblicazioneDocumenti, A119UPartecipazioneScioperi,
  A120UTipiRimborsi,A121UOrganizzSindacali,A122UIscrizioniSindacati,A123UPartecipazioniSindacati,A124UPermessiSindacali,
  A125UBadgeServizio,A126UBloccoRiepiloghi,A127UTurniPrestazioniAggiuntive,A128UPianPrestazioniAggiuntive,A129UIndennitaKm,
  A130UOraLegaleSolare,A131UGestioneAnticipi,A132UMagazzinoBuoniPasto,A133UTariffeMissioni,
  A135UTimbratureScartate,A137UCalcoloSpeseAccesso, (*A138UTurniApparati, A139UPianifServizi, A140UTurniServizi,*)
  A141URegoleRiposi,A142UQualificaMinisteriale,A143UMedicineLegali, A144UComuniMedLegali,
  A148UProfiliImportazioneCertificatiINPS,
  A150UAccorpamentoCausali,A151UAssenteismo,A152UEventiStraord,A153UPartecipEventiStraord,
  A160URegoleIncentivi,A161UTipoAbbattimenti,A162UIncentiviAssenze,A163UTipoQuote,A164UQuoteIncentivi,
  A166UQuoteIndividuali,A167URegistraIncentivi,A168UIncentiviMaturati,A169UPesatureIndividuali,
  A170UGestioneGruppi,A172USchedeQuantIndividuali,A173UImportAssestamento,
  A145UComunicazioneVisiteFiscali,A147URepVincoliIndividuali,
  Ac01UProgettiRendiProj,Ac02ULimitiRendiProj,Ac03UValidazioneCartellino,Ac04UStampaRendiProj,Ac06UPianifPrioritaChiamata,Ac07URegoleIndFunzione,Ac08URegistraIndFunzione,Ac09UIndFunzione,
  Ac10UFestivitaParticolari,Ac11UElaborazioneFesteParticolari,
  C180FunzioniGenerali,C700USelezioneAnagrafe,
  P030UValute, P050UArrotondamenti, P150USetup, P032UCambi,
  P552URegoleContoAnnuale, P553URisorseResidueContoAnnuale, P554UElaborazioneContoAnnuale, P555UContoAnnuale,
  P680UMacrocategorieFondi, P682URaggruppamentiFondi, P684UDefinizioneFondi, P686UCalcoloFondi, P688UMonitoraggioFondi, P690UStampaFondi,
  P652UINPDAPMMRegole, P655UDatiINPDAPMM, P656UElaborazioneFLUPER, P501UCUDSetup,
  S700UAreeValutazioni, S706UValutatoriDipendente, S746UStatiAvanzamento, S750UParProtocollo,
  S715UDialogStampa, S720UProfiliAree, S730UPunteggiValutazioni, S735UPunteggiFasceIncentivi, S740URegoleValutazioni,
  S031UFAmiliari, Variants, SelAnagrafe, System.Actions, A101URaggrInterrogazioni,
  Data.DB, System.ImageList;

type
  TA002FAnagrafeVista = class(TA002FAnagrafeVistaPadre)
    actlstPersonale: TActionList;
    actGeneratoreStampe: TAction;
    actAssenzeIndividuali: TAction;
    actSchedaAnnualeAssenze: TAction;
    actElencoStorici: TAction;
    actInterrogazioniServizio: TAction;
    actlstAmbiente: TActionList;
    actDatiLiberiNonStorici: TAction;
    actCalendari: TAction;
    actPartTime: TAction;
    actTipiRapporto: TAction;
    Personale1: TMenuItem;
    Ambiente1: TMenuItem;
    Scaricopaghe1: TMenuItem;
    Moduliopzionali1: TMenuItem;
    Elaborazioni1: TMenuItem;
    Causali1: TMenuItem;
    Reperibilit1: TMenuItem;
    Pianificazioneturni1: TMenuItem;
    Budgetstraordinario1: TMenuItem;
    Contegiopasti1: TMenuItem;
    Buonimensaticket1: TMenuItem;
    Incentivi1: TMenuItem;
    Liberaprofessione1: TMenuItem;
    actCartellinoInterattivo: TAction;
    actGiustificativi: TAction;
    actPianificazione: TAction;
    actSchedaRiepilogativa: TAction;
    actResiduiAnnoPrecedente: TAction;
    actProfiloAssenzeIndividuale: TAction;
    actCalendarioIndividuale: TAction;
    actPlusOrarioIndividuale: TAction;
    actInserimentoRiposi: TAction;
    actInserimentoGiustificativi: TAction;
    actStampaAnomalie: TAction;
    actStampaCartellino: TAction;
    actElencoPresentiAssenti: TAction;
    actStatisticaMinisterialeAssenze: TAction;
    actStampaTimbratureOriginali: TAction;
    actLiquidazioneOreCausalizzate: TAction;
    actInserimentoAutomaticoAssenze: TAction;
    actPlusOrario: TAction;
    actIndennitaPresenza: TAction;
    actIndennitaGruppi: TAction;
    actModelliOrario: TAction;
    actProfiliOrario: TAction;
    actTipologieCartellini: TAction;
    actContratti: TAction;
    actProfiliAssenze: TAction;
    actParametrizzazioneCartellino: TAction;
    actCausaliAssenza: TAction;
    actCausaliPresenza: TAction;
    actCausaliGiustificazione: TAction;
    actRaggruppamentiAssenza: TAction;
    actRaggruppamentiPresenza: TAction;
    actRaggruppamentiGiustificazione: TAction;
    actlstInterfacce: TActionList;
    actInterfacciaPaghe: TAction;
    actParametrizzazioneScaricoPaghe: TAction;
    actScaricoPaghe: TAction;
    actVociVariabiliScaricate: TAction;
    actlstModuliOpzionali: TActionList;
    actRegoleTurniRep: TAction;
    actPianificazioneTurniRep: TAction;
    actCartellinoReperibilita: TAction;
    actTurniRepSostitutivi: TAction;
    actCicli: TAction;
    actTurnazioni: TAction;
    actSquadre: TAction;
    actTurnazioniIndividuali: TAction;
    actSpostamentiSquadra: TAction;
    actPianificazioneTI: TAction;
    actControlloPianificazione: TAction;
    actSituazioneGiornaliera: TAction;
    actAllineamentoBudget: TAction;
    actGestioneBudget: TAction;
    actStampaSituazioneBudget: TAction;
    actGestioneMonetizzazione: TAction;
    actLiquidazioneCollettiva: TAction;
    actLimitiMensiliBS: TAction;
    actLiquidazioneAutomaticaBS: TAction;
    actRegoleAM: TAction;
    actTimbratureMensa: TAction;
    actCartolinaAM: TAction;
    actRiepilogoMensileAM: TAction;
    actPrenotazionePasti: TAction;
    actRegoleBM: TAction;
    actRiepilogoMensileBM: TAction;
    actGestioneAcquisto: TAction;
    actCartolinaBM: TAction;
    actRegoleIncentivi: TAction;
    actQuoteIncentivanti: TAction;
    actCartolinaIncentivi: TAction;
    actRiepilogoMensileIncentivi: TAction;
    actDefinizioneProfiliLP: TAction;
    actPianificazioneAttivitaLP: TAction;
    Passaggiodianno1: TMenuItem;
    Gestioneorologi1: TMenuItem;
    Parametrizzazionescarico1: TMenuItem;
    Scaricotimbrature1: TMenuItem;
    Timbratureirregolari1: TMenuItem;
    Cartellinointerattivo1: TMenuItem;
    actGiustificativi1: TMenuItem;
    Pianiforariindennit1: TMenuItem;
    Schedariepilogativa1: TMenuItem;
    Residuiannoprecedente1: TMenuItem;
    Riepilogoturnireperibilit1: TMenuItem;
    Profiloassenze1: TMenuItem;
    Calendarioindividuale1: TMenuItem;
    Plusorarioindividuale1: TMenuItem;
    Inserimentoriposi1: TMenuItem;
    Inserimentogiustificativi1: TMenuItem;
    Stampaanomalie1: TMenuItem;
    Stampacartellino1: TMenuItem;
    Elencopresentiassenti1: TMenuItem;
    Elencoassenzeindividuali1: TMenuItem;
    Schedaannualeassenze1: TMenuItem;
    Statisticaministerialeassenze1: TMenuItem;
    Gestioneacquisto1: TMenuItem;
    Elencomovimentistorici1: TMenuItem;
    Stampatimbratureoriginali1: TMenuItem;
    Interrogazionidiservizio1: TMenuItem;
    Liquidazioneorecausalizzate1: TMenuItem;
    Inserimentoautomaticoassenze1: TMenuItem;
    Plusorario1: TMenuItem;
    Indennitdipresenza1: TMenuItem;
    Indennitpergruppi1: TMenuItem;
    Modelliorario1: TMenuItem;
    Profiliorario1: TMenuItem;
    Tipologiecartellini1: TMenuItem;
    Calendari1: TMenuItem;
    Parttime1: TMenuItem;
    Tiporapporto1: TMenuItem;
    Contratti1: TMenuItem;
    Profiliassenze1: TMenuItem;
    Parametrizzazionecartellino1: TMenuItem;
    Causalidiassenza1: TMenuItem;
    Raggruppamentidiassenza1: TMenuItem;
    Causalidigiustificazione1: TMenuItem;
    Causalidipresenza1: TMenuItem;
    Raggruppamentidipresenza1: TMenuItem;
    Raggruppamentidigiustificazione1: TMenuItem;
    Impostazioneinterfaccia1: TMenuItem;
    Parametrizzazionescaricopaghe1: TMenuItem;
    Scaricopaghe2: TMenuItem;
    Vocivariabiliscaricate1: TMenuItem;
    Regoleturni1: TMenuItem;
    Pianificazioneturni2: TMenuItem;
    Cartellinoreperibilit1: TMenuItem;
    Gestioneturnisostitutivi1: TMenuItem;
    Cicli1: TMenuItem;
    Turnazioni1: TMenuItem;
    Squadre1: TMenuItem;
    Turnazioniindividuali1: TMenuItem;
    Spostamentidisquadra1: TMenuItem;
    Pianificazione1: TMenuItem;
    Controllopianificazione1: TMenuItem;
    Situazionegiornaliera1: TMenuItem;
    AllineamentoBudget1: TMenuItem;
    GestioneBudget1: TMenuItem;
    Stampaanomalie2: TMenuItem;
    Gestionemonetizzazione1: TMenuItem;
    Limitimensili1: TMenuItem;
    Liquidazionecollettiva2: TMenuItem;
    Regole1: TMenuItem;
    Timbraturemensa1: TMenuItem;
    Cartolina1: TMenuItem;
    Riepilogomensile1: TMenuItem;
    Prenotazionepasti1: TMenuItem;
    Regole2: TMenuItem;
    Riepilogomensile2: TMenuItem;
    Gestioneacquisto2: TMenuItem;
    Cartolina2: TMenuItem;
    Regoleincentivi1: TMenuItem;
    Quoteannuali1: TMenuItem;
    Cartolina3: TMenuItem;
    Riepilogomensile3: TMenuItem;
    Definizioneprofili1: TMenuItem;
    Pianificazioneattivit1: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton22: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton33: TToolButton;
    actRiepilogoReperibilita: TAction;
    ToolButton50: TToolButton;
    ToolButton51: TToolButton;
    ToolButton52: TToolButton;
    ToolButton53: TToolButton;
    ToolButton31: TToolButton;
    ToolButton54: TToolButton;
    ToolButton55: TToolButton;
    ToolButton58: TToolButton;
    ToolButton59: TToolButton;
    ToolBar3: TToolBar;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton32: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton40: TToolButton;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton41: TToolButton;
    ToolButton43: TToolButton;
    ToolButton44: TToolButton;
    ToolButton42: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton21: TToolButton;
    actFamiliari: TAction;
    Familiari1: TMenuItem;
    ToolButton45: TToolButton;
    actSetupValute: TAction;
    actValute: TAction;
    actArrotondamentiValute: TAction;
    N8: TMenuItem;
    Setupvalute1: TMenuItem;
    Valute1: TMenuItem;
    Arrotondamentivalute1: TMenuItem;
    Missionitrasferte1: TMenuItem;
    actMissioniRegole: TAction;
    actMissioniTipiRimborsi: TAction;
    actMissioniRegistrazione: TAction;
    Regole3: TMenuItem;
    Tariffaoraria1: TMenuItem;
    Tipirimborsi1: TMenuItem;
    Registrazionemissioni1: TMenuItem;
    ToolButton46: TToolButton;
    ToolButton47: TToolButton;
    actRipartizioneStr: TAction;
    Interfacce1: TMenuItem;
    Timbrature1: TMenuItem;
    Giustificativiassenza1: TMenuItem;
    Parametrizzazionescarico2: TMenuItem;
    Scaricotimbrature2: TMenuItem;
    actOrologi: TAction;
    actParametrizzazioneAcquisizioneTimbr: TAction;
    actAcquisizioneTimbrature: TAction;
    actTimbratureIrregolari: TAction;
    actParametrizzazioneAcquisizioneGiust: TAction;
    actAcquisizioneGiustificativi: TAction;
    N5: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    actPassaggioAnno: TAction;
    actMissioniStampa: TAction;
    Stampa1: TMenuItem;
    actComuni: TAction;
    Comuni1: TMenuItem;
    actStoricoGiustificativi: TAction;
    actStoricoGiustificativi1: TMenuItem;
    ToolButton48: TToolButton;
    N4: TMenuItem;
    actCompensazioneAutomatica: TAction;
    actCompensazioneAutomaticaRegole: TAction;
    Compensazionedebitoautomatica1: TMenuItem;
    Compensazionedebitoautomatica2: TMenuItem;
    actGestioneImmagini: TAction;
    Gestioneimmagini1: TMenuItem;
    actMsgOrologiStrutture: TAction;
    actMsgOrologiCreazione: TAction;
    Messaggisticaorologi1: TMenuItem;
    Definizionestrutture1: TMenuItem;
    Creazionemessaggi1: TMenuItem;
    Datieconomici1: TMenuItem;
    actDatiLiberiStoricizzati: TAction;
    TabelleDatiLiberi1: TMenuItem;
    Datiliberi2: TMenuItem;
    Datiliberistoricizzati1: TMenuItem;
    actLiqOreAnniPrec: TAction;
    actAssestamentoOreAnniPrec: TAction;
    Liquidazioneoreanniprecedenti1: TMenuItem;
    Assestamentooreanniprecedenti1: TMenuItem;
    Flussistatistici1: TMenuItem;
    Parametrizzazioneestrazioni1: TMenuItem;
    Estrazion1: TMenuItem;
    actFlussiParametrizzazioneEstrazione: TAction;
    actFlussiEstrazioneDati: TAction;
    actSindacatiOrganizzazioni: TAction;
    actSindacatiIscrizioni: TAction;
    actSindacatiPartecipazioni: TAction;
    actSindacatiPermessi: TAction;
    Sindacati1: TMenuItem;
    Organizzazionisindacali1: TMenuItem;
    Iscrizioniaisindacati1: TMenuItem;
    Partecipazioniaisindacati1: TMenuItem;
    Permessisindacali1: TMenuItem;
    actSicurezzaRiepiloghi: TAction;
    Sicurezzariepiloghi1: TMenuItem;
    actBadgeServizio: TAction;
    Badgediservizio1: TMenuItem;
    actRegoleTurniPrestAgg: TAction;
    actPianifPrestAgg: TAction;
    Prestazioniaggiuntive1: TMenuItem;
    Regoleturni2: TMenuItem;
    ImportazionePianificazioneturni1: TMenuItem;
    actMissioniIndennitaKm: TAction;
    ToolButton49: TToolButton;
    actQuoteIndividuali: TAction;
    Quoteindividuali1: TMenuItem;
    ToolButton56: TToolButton;
    ToolButton57: TToolButton;
    ToolButton60: TToolButton;
    ToolButton61: TToolButton;
    ToolButton62: TToolButton;
    ToolButton63: TToolButton;
    ToolButton64: TToolButton;
    actAbbattimentoAssenze: TAction;
    Abbattimentoassenze1: TMenuItem;
    actDistanzeChilometriche: TAction;
    Distanzechilometriche1: TMenuItem;
    Regoleinserimentoriposi1: TMenuItem;
    actRegoleRiposi: TAction;
    Gestioneanticipi1: TMenuItem;
    actGestioneAnticipi: TAction;
    actCambioOraLegaleSolare: TAction;
    Cambiooralegalesolare1: TMenuItem;
    actGestioneMagazzino: TAction;
    Gestionemagazzino1: TMenuItem;
    ariffeMissioni1: TMenuItem;
    actTariffeMissioni: TAction;
    actFLUPERRegole: TAction;
    actFLUPERDati: TAction;
    actFLUPERCalcolo: TAction;
    N18: TMenuItem;
    RegolefornituraFLUPER1: TMenuItem;
    ElaborazionefornituraFLUPER1: TMenuItem;
    FornituraFLUPER1: TMenuItem;
    Contoannuale1: TMenuItem;
    Regole4: TMenuItem;
    actContoAnnRegole: TAction;
    actContoAnnRisRes: TAction;
    actContoAnnuale: TAction;
    actCalcolaContoAnnuale: TAction;
    Contoannuale2: TMenuItem;
    Risorseresiduedelcontoannuale1: TMenuItem;
    ElaborazioneContoAnnuale1: TMenuItem;
    ToolButton27: TToolButton;
    actCambiValute: TAction;
    Cambivalute1: TMenuItem;
    actTimbratureScartate: TAction;
    TimbratureScartate1: TMenuItem;
    actPianificazioneTurniGuardia: TAction;
    Pianificazioneturniguardia1: TMenuItem;
    ToolButton23: TToolButton;
    actQualificaMinisteriale: TAction;
    actQualificaMinisteriale1: TMenuItem;
    urni1: TMenuItem;
    Servizi1: TMenuItem;
    Pianificazioneservizi1: TMenuItem;
    actApparati: TAction;
    actServizi: TAction;
    actPianifServizi: TAction;
    actCalcoloSpeseAccesso: TAction;
    miCalcoloSpeseAccesso: TMenuItem;
    actAssenteismo: TAction;
    Accorpamentocausalidiassenza1: TMenuItem;
    actAccorpamentiCausali: TAction;
    actMedicineLegali: TAction;
    Visitefiscali1: TMenuItem;
    Medicinelegali1: TMenuItem;
    actComuniMedLegali: TAction;
    actComunicazioneVisiteFiscali: TAction;
    Associazionecomunimedicinelegali1: TMenuItem;
    Comunicazionevisitefiscali1: TMenuItem;
    actTipoAbbattimenti: TAction;
    ipologieabbattimenti1: TMenuItem;
    actTipoQuote: TAction;
    ipologiequote1: TMenuItem;
    N24: TMenuItem;
    N29: TMenuItem;
    actCUDSetup: TAction;
    SetUp1: TMenuItem;
    Pianificazioneservizi2: TMenuItem;
    ToolButton66: TToolButton;
    ToolButton67: TToolButton;
    ToolButton68: TToolButton;
    ToolButton69: TToolButton;
    actMotivazioniRichieste: TAction;
    IrisWeb1: TMenuItem;
    Motivazionirichiestetimbrature1: TMenuItem;
    actRegoleValutazioni: TAction;
    actAreeValutazioni: TAction;
    actProfiliAree: TAction;
    actValutatoriDipendente: TAction;
    actPunteggiValutazioni: TAction;
    actStampaValutazioni: TAction;
    Valutazioni1: TMenuItem;
    Stampaschedevalutazioni1: TMenuItem;
    Punteggivalutazioni1: TMenuItem;
    Legamivalutatoredipendente1: TMenuItem;
    Profiliaree1: TMenuItem;
    Areevalutazioni1: TMenuItem;
    Regolevalutazioni1: TMenuItem;
    actScaglioniIncentivi: TAction;
    Scaglioniperassegnazionedegliincentivi1: TMenuItem;
    actPesatureIndividuali: TAction;
    PesatureIndividuali1: TMenuItem;
    actMacrocategorieFondi: TAction;
    actRaggruppamentiFondi: TAction;
    actDefinizioneFondi: TAction;
    actCalcoloFondi: TAction;
    actMonitoraggioFondi: TAction;
    actStampaFondi: TAction;
    Fondi1: TMenuItem;
    Macrocategoriefondi1: TMenuItem;
    Raggruppamentifondi1: TMenuItem;
    Definizionefondi1: TMenuItem;
    Calcolofondi1: TMenuItem;
    Macrocategoriefondi2: TMenuItem;
    Stampafondi1: TMenuItem;
    actVincoliReperibilita: TAction;
    actVincoliGuardia: TAction;
    Vincolipianificazionereperibilit1: TMenuItem;
    Vincolipianificazioneguardia1: TMenuItem;
    ToolButton71: TToolButton;
    actGestioneGruppi: TAction;
    Gestionegruppipesature1: TMenuItem;
    actImpAttestatiMal: TAction;
    N2: TMenuItem;
    Importazionecertificatidimalattia1: TMenuItem;
    actIncQuantIndividuali: TAction;
    Schedequantitativeindividuali1: TMenuItem;
    N30: TMenuItem;
    actScaglioniPT: TAction;
    Scaglioniperassegnazioneparttimeincentivi1: TMenuItem;
    actImportazioneAssestamentoOre: TAction;
    Importazioneassestamentoore1: TMenuItem;
    actBudgetEsterno: TAction;
    actBudgetEsterno1: TMenuItem;
    actStatiAvanzamentoVal: TAction;
    Statiavanzamentovalutazioni1: TMenuItem;
    actPubblicazioneDocumenti: TAction;
    actPubblicazioneDocumenti1: TMenuItem;
    actScaglioniGgEffettivi: TAction;
    Scaglioniggeffettiviincentivi1: TMenuItem;
    actParametrizzazioneProtocollo: TAction;
    Parametrizzazioneprotocollazione1: TMenuItem;
    actEventiStraord: TAction;
    actPartecipEventiStraord: TAction;
    Eventistraordinari1: TMenuItem;
    Partecipazioneeventistraordinari1: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    actParPianifTurni: TAction;
    Parametrizzazionipianificazione1: TMenuItem;
    actProfiliAttestatiMal: TAction;
    ProfiliimportazionecertificatiINPS1: TMenuItem;
    actDatiLiberiIterMissioni: TAction;
    Regoleitermissioni1: TMenuItem;
    actPartecipazioneScioperi: TAction;
    AssenteismoScioperi1: TMenuItem;
    AssenteismoeForzaLavoro1: TMenuItem;
    actPartecipazioneScioperi1: TMenuItem;
    actProgettiRendiProj: TAction;
    actLimitiRendiProj: TAction;
    RendicontazioneProgetti1: TMenuItem;
    Progetti1: TMenuItem;
    Limitiindividuali1: TMenuItem;
    ToolButton70: TToolButton;
    ToolButton72: TToolButton;
    actRegoleFestivitaParicolari: TAction;
    Festivitaparticolari1: TMenuItem;
    Regolefestivitparticolari1: TMenuItem;
    actElaborazioneFesteParticolari: TAction;
    ToolButton73: TToolButton;
    ToolButton74: TToolButton;
    Elaborazionefestivitparticolari1: TMenuItem;
    actValidazioneCartellino: TAction;
    Validazionecartellino1: TMenuItem;
    actStampaRendiProj: TAction;
    Stamparendicontazione1: TMenuItem;
    actRaggrInterrogazioni: TAction;
    Raggruppamentiinterrogazionidiservizio1: TMenuItem;
    actPianifPrioritaChiamata: TAction;
    Prioritdichiamatareperibilit1: TMenuItem;
    actRegoleIndFunzione: TAction;
    Regoleindennitdifunzione1: TMenuItem;
    actIndFunzione: TAction;
    Calcoloindennitdifunzione1: TMenuItem;
    actRegistraIndFunzione: TAction;
    Indennitdifunzione1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure actPersonaleExecute(Sender: TObject);
    procedure actAmbienteExecute(Sender: TObject);
    procedure actInterfacceExecute(Sender: TObject);
    procedure actModuliOpzionaliExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A002FAnagrafeVista: TA002FAnagrafeVista;

implementation

uses A002UAnagrafeDtM1;

{$R *.DFM}

procedure TA002FAnagrafeVista.FormShow(Sender: TObject);
begin
  inherited;
  actRicostruzioneAnagrafico.Enabled:=not(A002FAnagrafeDtM1.AbilAnagra = aaNone);
  actAggiornaAnagrafe.Enabled:=Parametri.CampiRiferimento.C5_IntegrazAnag = 'T';
  actRegoleIndFunzione.Visible:=Parametri.CampiRiferimento.C3_Indennita_Funzione <> '';
  actRegistraIndFunzione.Visible:=Parametri.CampiRiferimento.C3_Indennita_Funzione <> '';
  actIndFunzione.Visible:=Parametri.CampiRiferimento.C3_Indennita_Funzione <> '';
end;

procedure TA002FAnagrafeVista.actPersonaleExecute(Sender: TObject);
begin
  //Alberto: uso HelpContext come flag per evitare di lanciare 2 volte la stessa azione col doppio click
  if (Sender as TAction).HelpContext = -1 then
    exit;
  (Sender as TAction).HelpContext:=-1;
  try
    GetDatiDipendente(Sender);
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    if Sender = actCalendarioIndividuale then
      OpenA013CalendIndiv(PProgressivo)
    else if Sender = actGiustificativi then
      OpenA004GiustifAssPres(PProgressivo,'','','','','','',0,False)
    else if Sender = actPlusOrarioIndividuale then
      OpenA015PlusOraIndiv(PProgressivo)
    else if Sender = actFamiliari then
      OpenS031Familiari(PProgressivo)
    else if Sender = actProfiloAssenzeIndividuale then
      OpenA010ProfAsseInd(PProgressivo)
    else if Sender = actCartellinoInterattivo then
      OpenA023Timbrature(PProgressivo,R180InizioMese(DataLavoro))
    else if Sender = actPianificazione then
      OpenA025Pianif(PProgressivo,'','','',DataLavoro,False)
    else if Sender = actStampaCartellino then
      OpenA027CarMen(PProgressivo,DataLavoro)
    else if Sender = actSicurezzaRiepiloghi then
      OpenA126BloccoRiepiloghi(PProgressivo,'',0,0)
    else if Sender = actSchedaRiepilogativa then
      OpenA029SchedaRiepil(PProgressivo,DataLavoro)
    else if Sender = actResiduiAnnoPrecedente then
      OpenA030Residui(PProgressivo,DataLavoro,True)
    else if Sender = actAssestamentoOreAnniPrec then
      OpenA117OreLiquidateAnniPrec(PProgressivo,DataLavoro)
    else if Sender = actStampaAnomalie then
      OpenA033StampaAnomalie(PProgressivo,0,0)
    else if Sender = actInserimentoRiposi then
      OpenA041InsRiposi(PProgressivo)
    else if Sender = actElencoPresentiAssenti then
      OpenA042StampaPreAsse(PProgressivo)
    else if Sender = actStatisticaMinisterialeAssenze then
      OpenA045StatAssenze(PProgressivo)
    else if Sender = actStampaTimbratureOriginali then
      OpenA051TimbOrig(PProgressivo)
    else if Sender = actAssenzeIndividuali then
      OpenA061DettAssenze(PProgressivo)
    else if Sender = actInterrogazioniServizio then
      OpenA062QueryServizio('','')
    else if Sender = actInserimentoAutomaticoAssenze then
      OpenA079AssenzeAuto(PProgressivo)
    else if Sender = actSchedaAnnualeAssenze then
      OpenA090AssenzeAnno(PProgressivo)
    else if Sender = actElencoStorici then
      OpenA092StampaStorico(PProgressivo)
    else if Sender = actInserimentoGiustificativi then
      OpenA004GiustifGruppo(PProgressivo)
    else if Sender = actLiquidazioneOreCausalizzate then
      OpenA091LiquidPresenze(PProgressivo)
    else if Sender = actLiqOreAnniPrec then
      OpenA116LiquidazioneOreAnniPrec(PProgressivo)
    else if Sender = actImportazioneAssestamentoOre then
      OpenA173FImportAssestamento
    else if Sender = actGeneratoreStampe then
      OpenA077GeneratoreStampe(PProgressivo)
    else if Sender = actPassaggioAnno then
      OpenA075FineAnno(PProgressivo)
    else if Sender = actStoricoGiustificativi then
      OpenA105StoricoGiustificativi(PProgressivo)
    else if Sender = actCompensazioneAutomatica then
      OpenA108InsAssAuto(PProgressivo)
    else if Sender = actRegistraIndFunzione then
      OpenAc08RegistraIndFunzione(PProgressivo,0,0)
    else if Sender = actIndFunzione then
      OpenAc09IndFunzione(PProgressivo,0,0);
  finally
    (Sender as TAction).HelpContext:=0;
    if C700FSelezioneAnagrafe = nil then
    begin
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
    end;
  end;
end;

procedure TA002FAnagrafeVista.actAmbienteExecute(Sender: TObject);
begin
  if Sender = actDatiLiberiNonStorici then
    OpenA005Tabelle('','')
  else if Sender = actDatiLiberiStoricizzati then
    OpenA115DatiLiberiStoricizzati('','')
  else if Sender = actComuni then
    OpenA011ComuniProvinceRegioni('','C')
  else if Sender = actCalendari then
  begin
    OpenA012Calendari('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT010.Refresh;
  end
  else if Sender = actPartTime then
  begin
    OpenA085PartTime('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT460.Refresh;
  end
  else if Sender = actTipiRapporto then
  begin
    OpenA084TipoRapporto('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT450.Refresh;
  end
  else if Sender = actPlusOrario then
  begin
    OpenA014PlusOrario('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT060.Refresh;
  end
  else if Sender = actQualificaMinisteriale then
    OpenA142QualificaMinisteriale('')
  else if Sender = actModelliOrario then
    OpenA006ModelliOrario('')
  else if Sender = actProfiliAssenze then
  begin
    OpenA009ProfiliAsse('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT261.Refresh;
  end
  else if Sender = actCausaliAssenza then
  begin
    OpenA016CausAssenze('');
    with A002FAnagrafeDtM1 do
    begin
      A002FAnagrafeMW.selT265.Refresh;
      ListaAssenze.Clear;
      while not A002FAnagrafeMW.selT265.Eof do
      begin
        ListaAssenze.Add(Format('%-5s %s',[A002FAnagrafeMW.selT265.FieldByName('Codice').AsString,A002FAnagrafeMW.selT265.FieldByName('Descrizione').AsString]));
        A002FAnagrafeMW.selT265.Next;
      end;
    end;
  end
  else if Sender = actRaggruppamentiAssenza then
    OpenA017RaggrAsse('')
  else if Sender = actAccorpamentiCausali then
    OpenA150AccorpamentoCausali('','')
  else if Sender = actCausaliPresenza then
  begin
    OpenA020CausPresenze('');
    with A002FAnagrafeDtM1 do
    begin
      A002FAnagrafeMW.selT270.Refresh;
      ListaPresenze.Clear;
      while not A002FAnagrafeMW.selT270.Eof do
      begin
        ListaPresenze.Add(Format('%-5s %s',[A002FAnagrafeMW.selT270.FieldByName('Codice').AsString,A002FAnagrafeMW.selT270.FieldByName('Descrizione').AsString]));
        A002FAnagrafeMW.selT270.Next;
      end;
    end;
  end
  else if Sender = actRaggruppamentiPresenza then
  begin
    OpenA018Raggrpres('');
    with A002FAnagrafeDtM1 do
    begin
      A002FAnagrafeMW.selT270.Refresh;
      ListaPresenze.Clear;
      while not A002FAnagrafeMW.selT270.Eof do
      begin
        ListaPresenze.Add(Format('%-5s %s',[A002FAnagrafeMW.selT270.FieldByName('Codice').AsString,A002FAnagrafeMW.selT270.FieldByName('Descrizione').AsString]));
        A002FAnagrafeMW.selT270.Next;
      end;
    end;
  end
  else if Sender = actCausaliGiustificazione then
    OpenA021CausGiustif('')
  else if Sender = actRaggruppamentiGiustificazione then
    OpenA019RaggrGiustif('')
  else if Sender = actContratti then
  begin
    OpenA022Contratti('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT200.Refresh;
  end
  else if Sender = actIndennitaPresenza then
  begin
    OpenA024IndPresenza('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT163.Refresh;
  end
  else if Sender = actProfiliOrario then
  begin
    OpenA007ProfiliOrari('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT220.Refresh;
  end
  else if Sender = actParametrizzazioneCartellino then
    OpenA052ParCar('')
  else if Sender = actRaggrInterrogazioni then
    OpenA101RaggrInterrogazioni('')
  else if Sender = actGestioneImmagini then
    OpenA109Immagini
  else if Sender = actIndennitaGruppi then
    OpenA076IndGruppo
  else if Sender = actTipologieCartellini then
  begin
    OpenA080ModConte('');
    A002FAnagrafeDtM1.A002FAnagrafeMW.selT025.Refresh;
  end
  else if Sender = actCompensazioneAutomaticaRegole then
    OpenA107InsAssAutoRegole
  else if Sender = actRegoleRiposi then
    OpenA141RegoleRiposi
  else if Sender = actSetupValute then
    OpenP150FSetup
  else if Sender = actValute then
    OpenP030FValute('')
  else if Sender = actArrotondamentiValute then
    OpenP050FArrotondamenti('')
  else if Sender = actCambiValute then
    OpenP032FCambi
  else if Sender = actCUDSetup then
    OpenP501FCUDSetup
  else if Sender = actRegoleIndFunzione then
    OpenAc07RegoleIndFunzione;
end;

procedure TA002FAnagrafeVista.actInterfacceExecute(Sender: TObject);
begin
  //Alberto: uso HelpContext come flag per evitare di lanciare 2 volte la stessa azione col doppio click
  if (Sender as TAction).HelpContext = -1 then
    exit;
  (Sender as TAction).HelpContext:=-1;
  try
    GetDatiDipendente(Sender);
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    if Sender = actInterfacciaPaghe then
      OpenA034IntPaghe
    else if Sender = actParametrizzazioneScaricoPaghe then
      OpenA035ParScarico('','PAGHE')
    else if Sender = actScaricoPaghe then
      OpenA037ScaricoPaghe(PProgressivo)
    else if Sender = actVociVariabiliScaricate then
      OpenA038VociVariabili(PProgressivo)
    else if Sender = actOrologi then
      OpenA050Orologi('')
    else if Sender = actBadgeServizio then
      OpenA125BadgeServizio(PProgressivo)
    else if Sender = actParametrizzazioneAcquisizioneTimbr then
      OpenA031ParScarico('')
    else if Sender = actAcquisizioneTimbrature then
      OpenA032Scarico
    else if Sender = actTimbratureIrregolari then
      OpenA060TimbIrregolari
    else if Sender = actParametrizzazioneAcquisizioneGiust then
      OpenA102ParScaricoGiust('')
    else if Sender = actAcquisizioneGiustificativi then
      OpenA103ScaricoGiust
    else if Sender = actCambioOraLegaleSolare then
      OpenA130OraLegaleSolare(PProgressivo)
    else if Sender = actTimbratureScartate then
      OpenA135FTimbratureScartate(PProgressivo)
    else if Sender = actMotivazioniRichieste then
      OpenA086MotivazioniRichieste('','')
    else if Sender = actDatiLiberiIterMissioni then
      OpenA088DatiLiberiIterMissioni('')
    else if Sender = actPubblicazioneDocumenti then
      OpenA118PubblicazioneDocumenti
    else if Sender = actValidazioneCartellino then
      OpenAc03FValidazioneCartellino(PProgressivo,R180InizioMese(DataLavoro));
  finally
    (Sender as TAction).HelpContext:=0;
    if C700FSelezioneAnagrafe = nil then
    begin
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
    end;
  end;
end;

procedure TA002FAnagrafeVista.actModuliOpzionaliExecute(Sender: TObject);
begin
  //Alberto: uso HelpContext come flag per evitare di lanciare 2 volte la stessa azione col doppio click
  if (Sender as TAction).HelpContext = -1 then
    exit;
  (Sender as TAction).HelpContext:=-1;
  try
    GetDatiDipendente(Sender);
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    if Sender = actRegoleTurniRep then
      OpenA039RegReperib('')
    else if Sender = actPianificazioneTurniGuardia then
      OpenA040PianifRep(PProgressivo,'GUARDIA')
    else if Sender = actPianificazioneTurniRep then
      OpenA040PianifRep(PProgressivo,'REPERIB')
    else if Sender = actCartellinoReperibilita then
      OpenA043StampaRep(PProgressivo)
    else if Sender = actRiepilogoReperibilita then
      OpenA036TurniRep(PProgressivo)
    else if Sender = actTurniRepSostitutivi then
      OpenA067RepSostB(PProgressivo)
    else if Sender = actVincoliGuardia then
      OpenA147RepVincoliIndividuali(PProgressivo,'GUARDIA')
    else if Sender = actVincoliReperibilita then
      OpenA147RepVincoliIndividuali(PProgressivo,'REPERIB')
    else if Sender = actPianifPrioritaChiamata then
      OpenAc06PianifPrioritaChiamata(PProgressivo)
    else if Sender = actCicli then
      OpenA054CicliTurni('')
    else if Sender = actTurnazioni then
      OpenA055Turnazioni('')
    else if Sender = actSquadre then
      OpenA053Squadre('')
    else if Sender = actTurnazioniIndividuali then
      OpenA056TurnazInd(PProgressivo)
    else if Sender = actSpostamentiSquadra then
      OpenA057SpostSquadra(PProgressivo)
    else if Sender = actPianificazioneTI then
      OpenA058PianifTurni(PProgressivo)
    else if Sender = actParPianifTurni then
      OpenA174ParPianifTurni
    else if Sender = actControlloPianificazione then
      OpenA059ContSquadre
    else if Sender = actSituazioneGiornaliera then
      OpenA068TurniGior(PProgressivo)
    else if Sender = actBudgetEsterno then
      OpenA069BudgetEsterno
    else if Sender = actRegoleAM then
      OpenA046TerMensa
    else if Sender = actTimbratureMensa then
      OpenA047TimbMensa(PProgressivo)
    else if Sender = actCartolinaAM then
      OpenA049StampaPasti(PProgressivo)
    else if Sender = actRiepilogoMensileAM then
      OpenA048PastiMese(PProgressivo)
    else if Sender = actPrenotazionePasti then
      OpenA081TimbCaus(PProgressivo)
    else if Sender = actRegoleBM then
      OpenA071RegoleBuoni
    else if Sender = actRiepilogoMensileBM then
      OpenA072BuoniMese(PProgressivo)
    else if Sender = actGestioneAcquisto then
      OpenA073AcquistoBuoni(PProgressivo)
    else if Sender = actCartolinaBM then
      OpenA074RiepilogoBuoni(PProgressivo)
    else if Sender = actGestioneMagazzino then
      OpenA132MagazzinoBuoniPasto
    else if Sender = actRegoleIncentivi then
      OpenA160RegoleIncentivi
    else if Sender = actTipoAbbattimenti then
      OpenA161TipoAbbattimenti
    else if Sender = actAbbattimentoAssenze then
      OpenA162IncentiviAssenze
    else if Sender = actScaglioniPT then
      OpenS735FPunteggiFasceIncentivi('I')
    else if Sender = actScaglioniGgEffettivi then
      OpenS735FPunteggiFasceIncentivi('G')
    else if Sender = actTipoQuote then
      OpenA163TipoQuote
    else if Sender = actQuoteIncentivanti then
      OpenA164QuoteIncentivi
    else if Sender = actQuoteIndividuali then
      OpenA166QuoteIndividuali(PProgressivo)
    else if Sender = actPesatureIndividuali then
      OpenA169PesatureIndividuali
//  else if Sender = actIncQuantProfili then
//    OpenA171IncQuantProfili
    else if Sender = actIncQuantIndividuali then
      OpenA172SchedeQuantIndividuali
    else if Sender = actGestioneGruppi then
      OpenA170GestioneGruppi
    else if Sender = actCartolinaIncentivi then
      OpenA167RegistraIncentivi(PProgressivo)
    else if Sender = actRiepilogoMensileIncentivi then
      OpenA168IncentiviMaturati(PProgressivo)
    else if Sender = actAllineamentoBudget then
      OpenA063FBudgetGenerazione('','',Parametri.DataLavoro)
    else if Sender = actGestioneBudget then
      OpenA064FBudgetStraordinario
    else if Sender = actStampaSituazioneBudget then
      OpenA065StampaBudget('','',Parametri.DataLavoro)
    else if Sender = actGestioneMonetizzazione then
      OpenA066ValutaStr
    else if Sender = actLimitiMensiliBS then
      OpenA094LimitiStr(PProgressivo,Parametri.DataLavoro)
    else if Sender = actLiquidazioneAutomaticaBS then
      OpenA095StRiasStr(PProgressivo)
    else if Sender = actEventiStraord then
      OpenA152EventiStraord('')
    else if Sender = actPartecipEventiStraord then
      OpenA153PartecipEventiStraord(PProgressivo,'')
    else if Sender = actProgettiRendiProj then
      OpenAc01FProgettiRendiProj
    else if Sender = actLimitiRendiProj then
      OpenAc02FLimitiRendiProj(PProgressivo,0,0)
    else if Sender = actStampaRendiProj then
      OpenAc04FStampaRendiProj(PProgressivo)
    else if Sender = actRegoleFestivitaParicolari then
      OpenAC10FestivitaParticolari
    else if Sender = actElaborazioneFesteParticolari then
      OpenAc11FElaborazioneFesteParticolari(PProgressivo,'',Parametri.DataLavoro)
    else if Sender = actDefinizioneProfiliLP then
      OpenA096ProfiliLibProf('')
    else if Sender = actPianificazioneAttivitaLP then
      OpenA097PianifLibProf(PProgressivo,Parametri.DataLavoro)
    else if Sender = actMissioniRegole then
      OpenA110ParametriConteggio
    else if Sender = actDistanzeChilometriche then
      OpenA106DistanzeTrasferta
    else if Sender = actMissioniTipiRimborsi then
      OpenA120TipiRimborsi('')
    else if Sender = actMissioniIndennitaKm then
      OpenA129IndennitaKm
    else if Sender = actCalcoloSpeseAccesso then
      OpenA137FCalcoloSpeseAccesso(PProgressivo)
    else if Sender = actMissioniRegistrazione then
      OpenA100Missioni(PProgressivo)
    else if Sender = actGestioneAnticipi then
      OpenA131GestioneAnticipi(PProgressivo,0)
    else if Sender = actMissioniStampa then
      OpenA104StampaMissioni(PProgressivo)
    else if Sender = actMsgOrologiStrutture then
      OpenA111ParMessaggi('')
    else if Sender = actMsgOrologiCreazione then
      OpenA112InvioMessaggi(PProgressivo)
    else if Sender = actFlussiParametrizzazioneEstrazione then
      OpenA113ParEstrazioniStampe('')
    else if Sender = actFlussiEstrazioneDati then
      OpenA114EstrazioniStampe
    else if Sender = actFLUPERRegole then
      OpenP652FINPDAPMMRegole(FLUSSO_FLUPER)
    else if Sender = actFLUPERDati then
      OpenP655FDatiINPDAPMM(PProgressivo,FLUSSO_FLUPER)
    else if Sender = actFLUPERCalcolo then
      OpenP656FElaborazioneFLUPER(PProgressivo)
    else if Sender = actSindacatiOrganizzazioni then
      OpenA121OrganizzSindacali('')
    else if Sender = actSindacatiIscrizioni then
      OpenA122IscrizioniSindacati(PProgressivo)
    else if Sender = actSindacatiPartecipazioni then
      OpenA123PartecipazioniSindacati(PProgressivo)
    else if Sender = actSindacatiPermessi then
      OpenA124PermessiSindacali(PProgressivo)
    else if Sender = actRegoleTurniPrestAgg then
      OpenA127TurniPrestazioniAggiuntive('')
    else if Sender = actPianifPrestAgg then
      OpenA128PianPrestazioniAggiuntive(PProgressivo)
    else if Sender = actTariffeMissioni then
      OpenA133TariffeMissioni(PProgressivo)
    else if Sender = actContoAnnRegole then
      OpenP552RegoleContoAnnuale
    else if Sender = actContoAnnRisRes then
      OpenP553FRisorseResidueContoAnnuale
    else if Sender = actCalcolaContoAnnuale then
      OpenP554FElaborazioneContoAnnuale(PProgressivo)
    else if Sender = actContoAnnuale then
      OpenP555FContoAnnuale(PProgressivo)
    else if Sender = actAssenteismo then
      OpenA151AssenteismoForzaLav(PProgressivo)
    else if Sender = actMacrocategorieFondi then
      OpenP680MacrocategorieFondi('')
    else if Sender = actRaggruppamentiFondi then
      OpenP682RaggruppamentiFondi('')
    else if Sender = actDefinizioneFondi then
      OpenP684DefinizioneFondi
    else if Sender = actCalcoloFondi then
      OpenP686CalcoloFondi
    else if Sender = actMonitoraggioFondi then
      OpenP688MonitoraggioFondi
    else if Sender = actStampaFondi then
      OpenP690StampaFondi
    (*else if Sender = actServizi then
      OpenA140TurniServizi
    else if Sender = actApparati then
      OpenA138TurniApparati
    else if Sender = actPianifServizi then
      OpenA139PianifServizi*)
    else if Sender = actMedicineLegali then
      OpenA143MedicineLegali('')
    else if Sender = actComuniMedLegali then
      OpenA144ComuniMedLegali
    else if Sender = actComunicazioneVisiteFiscali then
      OpenA145ComunicazioneVisiteFiscali
    else if Sender = actImpAttestatiMal then
      OpenA087ImpAttestatiMal
    else if Sender = actProfiliAttestatiMal then
      OpenA148ProfiliImportazioneCertificatiINPS
    else if Sender = actRegoleValutazioni then
      OpenS740FRegoleValutazioni
    else if Sender = actStatiAvanzamentoVal then
      OpenS746FStatiAvanzamento
    else if Sender = actAreeValutazioni then
      OpenS700FAreeValutazioni(DataLavoro,'','')
    else if Sender = actProfiliAree then
      OpenS720FProfiliAree
    else if Sender = actValutatoriDipendente then
      OpenS706FValutatoriDipendente(PProgressivo,0,DataLavoro)
    else if Sender = actPunteggiValutazioni then
      OpenS730FPunteggiValutazioni('','',DataLavoro)
    else if Sender = actScaglioniIncentivi then
      OpenS735FPunteggiFasceIncentivi('V')
    else if Sender = actParametrizzazioneProtocollo then
      OpenS750FParProtocollo('')
    else if Sender = actStampaValutazioni then
      OpenS715FStampaValutazioni(PProgressivo,DataLavoro,DataLavoro,'V')
    else if Sender = actPartecipazioneScioperi then
      OpenA119Scioperi;
  finally
    (Sender as TAction).HelpContext:=0;
    if C700FSelezioneAnagrafe = nil then
    begin
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe;
    end;
  end;
end;

end.
