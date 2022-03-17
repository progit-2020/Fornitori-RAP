inherited A002FAnagrafeVista: TA002FAnagrafeVista
  Left = 237
  Top = 157
  Caption = 'A002FAnagrafeVista'
  ClientHeight = 582
  ClientWidth = 634
  ExplicitWidth = 650
  ExplicitHeight = 641
  PixelsPerInch = 96
  TextHeight = 13
  inherited Splitter1: TSplitter
    Top = 533
    Width = 634
    ExplicitTop = 536
    ExplicitWidth = 634
  end
  inherited Splitter3: TSplitter
    Top = 85
    Height = 448
    ExplicitTop = 85
    ExplicitHeight = 432
  end
  inherited DBGrid1: TDBGrid
    Top = 85
    Width = 466
    Height = 448
  end
  inherited TVAzienda: TTreeView
    Top = 85
    Height = 448
    ExplicitTop = 85
    ExplicitHeight = 448
  end
  inherited Panel6: TPanel
    Top = 534
    Width = 634
    ExplicitTop = 534
    ExplicitWidth = 634
    inherited MSelect: TMemo
      Width = 607
      ExplicitWidth = 607
    end
  end
  object ToolBar2: TToolBar [5]
    Left = 0
    Top = 27
    Width = 634
    Height = 29
    ButtonWidth = 26
    Caption = 'ToolBar2'
    EdgeBorders = [ebLeft, ebTop, ebRight]
    Flat = False
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Wrapable = False
    object ToolButton25: TToolButton
      Left = 0
      Top = 0
      Action = actCartellinoInterattivo
    end
    object ToolButton31: TToolButton
      Left = 26
      Top = 0
      Action = actGiustificativi
    end
    object ToolButton50: TToolButton
      Left = 52
      Top = 0
      Action = actSchedaRiepilogativa
    end
    object ToolButton41: TToolButton
      Left = 78
      Top = 0
      Width = 8
      Caption = 'ToolButton41'
      Style = tbsSeparator
    end
    object ToolButton71: TToolButton
      Left = 86
      Top = 0
      Action = actInserimentoGiustificativi
    end
    object ToolButton44: TToolButton
      Left = 112
      Top = 0
      Action = actInserimentoRiposi
    end
    object ToolButton33: TToolButton
      Left = 138
      Top = 0
      Action = actStampaAnomalie
    end
    object ToolButton54: TToolButton
      Left = 164
      Top = 0
      Action = actStampaCartellino
    end
    object ToolButton42: TToolButton
      Left = 190
      Top = 0
      Action = actLiquidazioneOreCausalizzate
    end
    object ToolButton22: TToolButton
      Left = 216
      Top = 0
      Width = 10
      Caption = 'ToolButton22'
      Style = tbsSeparator
    end
    object ToolButton55: TToolButton
      Left = 226
      Top = 0
      Action = actScaricoPaghe
    end
    object ToolButton24: TToolButton
      Left = 252
      Top = 0
      Width = 9
      Caption = 'ToolButton24'
      Style = tbsSeparator
    end
    object ToolButton26: TToolButton
      Left = 261
      Top = 0
      Action = actGeneratoreStampe
    end
    object ToolButton69: TToolButton
      Left = 287
      Top = 0
      Action = actInterrogazioniServizio
    end
    object ToolButton67: TToolButton
      Left = 313
      Top = 0
      Action = actElencoPresentiAssenti
    end
    object ToolButton68: TToolButton
      Left = 339
      Top = 0
      Action = actAssenzeIndividuali
    end
    object ToolButton66: TToolButton
      Left = 365
      Top = 0
      Width = 8
      Caption = 'ToolButton66'
      ImageIndex = 81
      Style = tbsSeparator
    end
    object ToolButton19: TToolButton
      Left = 373
      Top = 0
      Action = actModelliOrario
    end
    object ToolButton20: TToolButton
      Left = 399
      Top = 0
      Action = actProfiliOrario
    end
    object ToolButton53: TToolButton
      Left = 425
      Top = 0
      Action = actProfiliAssenze
    end
    object ToolButton52: TToolButton
      Left = 451
      Top = 0
      Action = actCausaliAssenza
    end
    object ToolButton51: TToolButton
      Left = 477
      Top = 0
      Action = actCausaliPresenza
    end
    object ToolButton43: TToolButton
      Left = 503
      Top = 0
      Width = 8
      Caption = 'ToolButton43'
      Style = tbsSeparator
    end
    object ToolButton58: TToolButton
      Left = 511
      Top = 0
      Action = actAcquisizioneTimbrature
    end
    object ToolButton59: TToolButton
      Left = 537
      Top = 0
      Action = actTimbratureIrregolari
    end
  end
  object ToolBar3: TToolBar [6]
    Left = 0
    Top = 56
    Width = 634
    Height = 29
    Caption = 'ToolBar3'
    EdgeBorders = [ebLeft, ebTop, ebRight]
    Flat = False
    Images = ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Wrapable = False
    object ToolButton23: TToolButton
      Left = 0
      Top = 0
      Action = actPianificazioneTurniGuardia
    end
    object ToolButton28: TToolButton
      Left = 23
      Top = 0
      Action = actPianificazioneTurniRep
    end
    object ToolButton29: TToolButton
      Left = 46
      Top = 0
      Action = actCartellinoReperibilita
    end
    object ToolButton30: TToolButton
      Left = 69
      Top = 0
      Action = actRiepilogoReperibilita
    end
    object ToolButton27: TToolButton
      Left = 92
      Top = 0
      Width = 8
      Caption = 'ToolButton27'
      ImageIndex = 99
      Style = tbsSeparator
    end
    object ToolButton45: TToolButton
      Left = 100
      Top = 0
      Action = actTimbratureMensa
    end
    object ToolButton32: TToolButton
      Left = 123
      Top = 0
      Action = actCartolinaAM
    end
    object ToolButton34: TToolButton
      Left = 146
      Top = 0
      Action = actRiepilogoMensileAM
    end
    object ToolButton38: TToolButton
      Left = 169
      Top = 0
      Width = 8
      Caption = 'ToolButton38'
      Style = tbsSeparator
    end
    object ToolButton35: TToolButton
      Left = 177
      Top = 0
      Action = actCartolinaBM
    end
    object ToolButton40: TToolButton
      Left = 200
      Top = 0
      Action = actRiepilogoMensileBM
    end
    object ToolButton48: TToolButton
      Left = 223
      Top = 0
      Action = actGestioneAcquisto
    end
    object ToolButton39: TToolButton
      Left = 246
      Top = 0
      Width = 8
      Caption = 'ToolButton39'
      Style = tbsSeparator
    end
    object ToolButton36: TToolButton
      Left = 254
      Top = 0
      Action = actCartolinaIncentivi
    end
    object ToolButton37: TToolButton
      Left = 277
      Top = 0
      Action = actRiepilogoMensileIncentivi
    end
    object ToolButton18: TToolButton
      Left = 300
      Top = 0
      Width = 8
      Caption = 'ToolButton18'
      Style = tbsSeparator
    end
    object ToolButton21: TToolButton
      Left = 308
      Top = 0
      Action = actLimitiMensiliBS
    end
    object ToolButton17: TToolButton
      Left = 331
      Top = 0
      Action = actLiquidazioneAutomaticaBS
    end
    object ToolButton46: TToolButton
      Left = 354
      Top = 0
      Width = 8
      Caption = 'ToolButton46'
      Style = tbsSeparator
    end
    object ToolButton47: TToolButton
      Left = 362
      Top = 0
      Action = actMissioniRegistrazione
    end
    object ToolButton49: TToolButton
      Left = 385
      Top = 0
      Action = actMissioniStampa
    end
    object ToolButton56: TToolButton
      Left = 408
      Top = 0
      Width = 8
      Caption = 'ToolButton56'
      Style = tbsSeparator
    end
    object ToolButton57: TToolButton
      Left = 416
      Top = 0
      Action = actPianificazioneTI
    end
    object ToolButton60: TToolButton
      Left = 439
      Top = 0
      Width = 8
      Caption = 'ToolButton60'
      Style = tbsSeparator
    end
    object ToolButton61: TToolButton
      Left = 447
      Top = 0
      Action = actSindacatiOrganizzazioni
    end
    object ToolButton62: TToolButton
      Left = 470
      Top = 0
      Action = actSindacatiIscrizioni
    end
    object ToolButton63: TToolButton
      Left = 493
      Top = 0
      Action = actSindacatiPartecipazioni
    end
    object ToolButton64: TToolButton
      Left = 516
      Top = 0
      Action = actSindacatiPermessi
    end
    object ToolButton70: TToolButton
      Left = 539
      Top = 0
      Width = 8
      Caption = 'ToolButton70'
      Style = tbsSeparator
    end
    object ToolButton72: TToolButton
      Left = 547
      Top = 0
      Action = actProgettiRendiProj
    end
    object ToolButton73: TToolButton
      Left = 570
      Top = 0
      Width = 8
      Caption = 'ToolButton73'
      Style = tbsSeparator
    end
    object ToolButton74: TToolButton
      Left = 578
      Top = 0
      Action = actElaborazioneFesteParticolari
    end
  end
  inherited StatusBar: TStatusBar
    Top = 563
    Width = 634
    ExplicitTop = 563
    ExplicitWidth = 634
  end
  inherited ToolBar1: TToolBar
    Width = 634
    Wrapable = False
    ExplicitWidth = 634
    inherited ToolButton11: TToolButton
      Visible = False
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 292
    Top = 97
    object Ambiente1: TMenuItem [2]
      Caption = 'Ambiente'
      object TabelleDatiLiberi1: TMenuItem
        Caption = 'Tabelle dati liberi'
        object Datiliberi2: TMenuItem
          Action = actDatiLiberiNonStorici
        end
        object Datiliberistoricizzati1: TMenuItem
          Action = actDatiLiberiStoricizzati
        end
      end
      object Comuni1: TMenuItem
        Action = actComuni
      end
      object Plusorario1: TMenuItem
        Action = actPlusOrario
      end
      object actQualificaMinisteriale1: TMenuItem
        Action = actQualificaMinisteriale
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object Indennitdipresenza1: TMenuItem
        Action = actIndennitaPresenza
      end
      object Indennitpergruppi1: TMenuItem
        Action = actIndennitaGruppi
      end
      object Regoleindennitdifunzione1: TMenuItem
        Action = actRegoleIndFunzione
      end
      object Modelliorario1: TMenuItem
        Action = actModelliOrario
      end
      object Profiliorario1: TMenuItem
        Action = actProfiliOrario
      end
      object Tipologiecartellini1: TMenuItem
        Action = actTipologieCartellini
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object Calendari1: TMenuItem
        Action = actCalendari
      end
      object Parttime1: TMenuItem
        Action = actPartTime
      end
      object Tiporapporto1: TMenuItem
        Action = actTipiRapporto
      end
      object Contratti1: TMenuItem
        Action = actContratti
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object Profiliassenze1: TMenuItem
        Action = actProfiliAssenze
      end
      object Causali1: TMenuItem
        Caption = 'Causali'
        object Causalidiassenza1: TMenuItem
          Action = actCausaliAssenza
        end
        object Raggruppamentidiassenza1: TMenuItem
          Action = actRaggruppamentiAssenza
        end
        object Accorpamentocausalidiassenza1: TMenuItem
          Action = actAccorpamentiCausali
        end
        object N21: TMenuItem
          Caption = '-'
        end
        object Causalidipresenza1: TMenuItem
          Action = actCausaliPresenza
        end
        object Raggruppamentidipresenza1: TMenuItem
          Action = actRaggruppamentiPresenza
        end
        object N22: TMenuItem
          Caption = '-'
        end
        object Causalidigiustificazione1: TMenuItem
          Action = actCausaliGiustificazione
        end
        object Raggruppamentidigiustificazione1: TMenuItem
          Action = actRaggruppamentiGiustificazione
        end
      end
      object Compensazionedebitoautomatica2: TMenuItem
        Tag = 163
        Action = actCompensazioneAutomaticaRegole
      end
      object Regoleinserimentoriposi1: TMenuItem
        Action = actRegoleRiposi
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object Parametrizzazionecartellino1: TMenuItem
        Action = actParametrizzazioneCartellino
      end
      object Raggruppamentiinterrogazionidiservizio1: TMenuItem
        Action = actRaggrInterrogazioni
      end
      object Gestioneimmagini1: TMenuItem
        Tag = 164
        Action = actGestioneImmagini
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Datieconomici1: TMenuItem
        Caption = 'Dati economici'
        object SetUp1: TMenuItem
          Action = actCUDSetup
        end
        object Setupvalute1: TMenuItem
          Action = actSetupValute
        end
        object Valute1: TMenuItem
          Action = actValute
        end
        object Arrotondamentivalute1: TMenuItem
          Action = actArrotondamentiValute
        end
        object Cambivalute1: TMenuItem
          Action = actCambiValute
          Caption = 'Cambi valute'
        end
      end
    end
    object Personale1: TMenuItem [3]
      Caption = 'Personale'
      object Cartellinointerattivo1: TMenuItem
        Action = actCartellinoInterattivo
      end
      object actGiustificativi1: TMenuItem
        Action = actGiustificativi
      end
      object Pianiforariindennit1: TMenuItem
        Action = actPianificazione
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Schedariepilogativa1: TMenuItem
        Action = actSchedaRiepilogativa
      end
      object Residuiannoprecedente1: TMenuItem
        Action = actResiduiAnnoPrecedente
      end
      object Assestamentooreanniprecedenti1: TMenuItem
        Tag = 168
        Action = actAssestamentoOreAnniPrec
      end
      object Indennitdifunzione1: TMenuItem
        Action = actIndFunzione
      end
      object N10: TMenuItem
        Caption = '-'
        Hint = '-'
      end
      object Profiloassenze1: TMenuItem
        Action = actProfiloAssenzeIndividuale
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object Calendarioindividuale1: TMenuItem
        Action = actCalendarioIndividuale
      end
      object Plusorarioindividuale1: TMenuItem
        Action = actPlusOrarioIndividuale
      end
      object Familiari1: TMenuItem
        Action = actFamiliari
      end
    end
    object Elaborazioni1: TMenuItem [4]
      Caption = 'Elaborazioni'
      object Inserimentoriposi1: TMenuItem
        Action = actInserimentoRiposi
      end
      object Inserimentogiustificativi1: TMenuItem
        Action = actInserimentoGiustificativi
      end
      object Stampaanomalie1: TMenuItem
        Action = actStampaAnomalie
      end
      object Stampacartellino1: TMenuItem
        Action = actStampaCartellino
      end
      object Sicurezzariepiloghi1: TMenuItem
        Action = actSicurezzaRiepiloghi
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object Liquidazioneorecausalizzate1: TMenuItem
        Action = actLiquidazioneOreCausalizzate
      end
      object Liquidazioneoreanniprecedenti1: TMenuItem
        Tag = 169
        Action = actLiqOreAnniPrec
      end
      object Importazioneassestamentoore1: TMenuItem
        Tag = 208
        Action = actImportazioneAssestamentoOre
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Inserimentoautomaticoassenze1: TMenuItem
        Action = actInserimentoAutomaticoAssenze
      end
      object Compensazionedebitoautomatica1: TMenuItem
        Tag = 54
        Action = actCompensazioneAutomatica
      end
      object Calcoloindennitdifunzione1: TMenuItem
        Action = actRegistraIndFunzione
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object Passaggiodianno1: TMenuItem
        Action = actPassaggioAnno
      end
      object actStoricoGiustificativi1: TMenuItem
        Action = actStoricoGiustificativi
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object Elencopresentiassenti1: TMenuItem
        Action = actElencoPresentiAssenti
      end
      object Elencoassenzeindividuali1: TMenuItem
        Action = actAssenzeIndividuali
      end
      object Prenotazionepasti1: TMenuItem
        Action = actPrenotazionePasti
      end
      object Schedaannualeassenze1: TMenuItem
        Action = actSchedaAnnualeAssenze
      end
      object Statisticaministerialeassenze1: TMenuItem
        Action = actStatisticaMinisterialeAssenze
      end
      object Gestioneacquisto1: TMenuItem
        Action = actGeneratoreStampe
      end
      object Elencomovimentistorici1: TMenuItem
        Action = actElencoStorici
      end
      object Stampatimbratureoriginali1: TMenuItem
        Action = actStampaTimbratureOriginali
      end
      object Interrogazionidiservizio1: TMenuItem
        Action = actInterrogazioniServizio
      end
    end
    object Interfacce1: TMenuItem [5]
      Caption = 'Interfacce'
      object Timbrature1: TMenuItem
        Caption = 'Timbrature'
        object Scaricotimbrature1: TMenuItem
          Action = actAcquisizioneTimbrature
        end
        object Timbratureirregolari1: TMenuItem
          Action = actTimbratureIrregolari
        end
        object TimbratureScartate1: TMenuItem
          Action = actTimbratureScartate
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object Badgediservizio1: TMenuItem
          Action = actBadgeServizio
        end
        object Cambiooralegalesolare1: TMenuItem
          Action = actCambioOraLegaleSolare
        end
        object Gestioneorologi1: TMenuItem
          Action = actOrologi
        end
        object Parametrizzazionescarico1: TMenuItem
          Action = actParametrizzazioneAcquisizioneTimbr
        end
      end
      object Scaricopaghe1: TMenuItem
        Caption = 'Scarico paghe'
        object Scaricopaghe2: TMenuItem
          Action = actScaricoPaghe
        end
        object Vocivariabiliscaricate1: TMenuItem
          Action = actVociVariabiliScaricate
        end
        object N25: TMenuItem
          Caption = '-'
        end
        object Impostazioneinterfaccia1: TMenuItem
          Action = actInterfacciaPaghe
        end
        object Parametrizzazionescaricopaghe1: TMenuItem
          Action = actParametrizzazioneScaricoPaghe
        end
      end
      object Giustificativiassenza1: TMenuItem
        Caption = 'Giustificativi assenza'
        object Scaricotimbrature2: TMenuItem
          Action = actAcquisizioneGiustificativi
        end
        object N26: TMenuItem
          Caption = '-'
        end
        object Parametrizzazionescarico2: TMenuItem
          Action = actParametrizzazioneAcquisizioneGiust
        end
      end
      object IrisWeb1: TMenuItem
        Caption = 'IrisWeb'
        object Riepilogoiterautorizzativi1: TMenuItem
          Action = actRiepilogoIterAutorizzativi
        end
        object Motivazionirichiestetimbrature1: TMenuItem
          Action = actMotivazioniRichieste
        end
        object actPubblicazioneDocumenti1: TMenuItem
          Tag = 210
          Action = actPubblicazioneDocumenti
        end
        object Validazionecartellino1: TMenuItem
          Tag = 100005
          Action = actValidazioneCartellino
        end
      end
    end
    object Moduliopzionali1: TMenuItem [6]
      Caption = 'Moduli accessori'
      object Reperibilit1: TMenuItem
        Caption = 'Reperibilit'#224'/guardia'
        object Regoleturni1: TMenuItem
          Action = actRegoleTurniRep
        end
        object Vincolipianificazioneguardia1: TMenuItem
          Action = actVincoliGuardia
        end
        object Vincolipianificazionereperibilit1: TMenuItem
          Action = actVincoliReperibilita
        end
        object Prioritdichiamatareperibilit1: TMenuItem
          Action = actPianifPrioritaChiamata
        end
        object Pianificazioneturniguardia1: TMenuItem
          Action = actPianificazioneTurniGuardia
        end
        object Pianificazioneturni2: TMenuItem
          Action = actPianificazioneTurniRep
        end
        object Cartellinoreperibilit1: TMenuItem
          Action = actCartellinoReperibilita
        end
        object Riepilogoturnireperibilit1: TMenuItem
          Action = actRiepilogoReperibilita
          Caption = 'Riepilogo mensile reperibilit'#224
        end
        object Gestioneturnisostitutivi1: TMenuItem
          Action = actTurniRepSostitutivi
        end
      end
      object Visitefiscali1: TMenuItem
        Caption = 'Visite fiscali'
        object Medicinelegali1: TMenuItem
          Action = actMedicineLegali
        end
        object Associazionecomunimedicinelegali1: TMenuItem
          Action = actComuniMedLegali
        end
        object Comunicazionevisitefiscali1: TMenuItem
          Action = actComunicazioneVisiteFiscali
        end
        object N2: TMenuItem
          Caption = '-'
        end
        object Importazionecertificatidimalattia1: TMenuItem
          Action = actImpAttestatiMal
          HelpContext = 70
        end
        object ProfiliimportazionecertificatiINPS1: TMenuItem
          Action = actProfiliAttestatiMal
        end
      end
      object Liberaprofessione1: TMenuItem
        Caption = 'Libera professione'
        object Definizioneprofili1: TMenuItem
          Action = actDefinizioneProfiliLP
        end
        object Pianificazioneattivit1: TMenuItem
          Action = actPianificazioneAttivitaLP
        end
      end
      object Prestazioniaggiuntive1: TMenuItem
        Caption = 'Prestazioni aggiuntive'
        object Regoleturni2: TMenuItem
          Action = actRegoleTurniPrestAgg
        end
        object ImportazionePianificazioneturni1: TMenuItem
          Action = actPianifPrestAgg
        end
      end
      object Pianificazioneturni1: TMenuItem
        Caption = 'Pianificazione orari'
        object Squadre1: TMenuItem
          Action = actSquadre
        end
        object Cicli1: TMenuItem
          Action = actCicli
        end
        object Turnazioni1: TMenuItem
          Action = actTurnazioni
        end
        object Turnazioniindividuali1: TMenuItem
          Action = actTurnazioniIndividuali
        end
        object Spostamentidisquadra1: TMenuItem
          Action = actSpostamentiSquadra
        end
        object Parametrizzazionipianificazione1: TMenuItem
          Action = actParPianifTurni
        end
        object Pianificazione1: TMenuItem
          Action = actPianificazioneTI
        end
        object Controllopianificazione1: TMenuItem
          Action = actControlloPianificazione
        end
        object Situazionegiornaliera1: TMenuItem
          Action = actSituazioneGiornaliera
        end
      end
      object Pianificazioneservizi2: TMenuItem
        Caption = 'Pianificazione servizi'
        Visible = False
        object urni1: TMenuItem
          Action = actApparati
        end
        object Servizi1: TMenuItem
          Action = actServizi
        end
        object Pianificazioneservizi1: TMenuItem
          Action = actPianifServizi
        end
      end
      object Budgetstraordinario1: TMenuItem
        Caption = 'Budget straordinario'
        object GestioneBudget1: TMenuItem
          Action = actGestioneBudget
        end
        object AllineamentoBudget1: TMenuItem
          Action = actAllineamentoBudget
        end
        object Stampaanomalie2: TMenuItem
          Action = actStampaSituazioneBudget
        end
        object Gestionemonetizzazione1: TMenuItem
          Action = actGestioneMonetizzazione
        end
        object actBudgetEsterno1: TMenuItem
          Action = actBudgetEsterno
        end
        object N32: TMenuItem
          Caption = '-'
        end
        object Limitimensili1: TMenuItem
          Action = actLimitiMensiliBS
        end
        object Liquidazionecollettiva2: TMenuItem
          Action = actLiquidazioneAutomaticaBS
        end
        object N31: TMenuItem
          Caption = '-'
        end
        object Eventistraordinari1: TMenuItem
          Action = actEventiStraord
        end
        object Partecipazioneeventistraordinari1: TMenuItem
          Action = actPartecipEventiStraord
        end
      end
      object RendicontazioneProgetti1: TMenuItem
        Caption = 'Rendicontazione progetti'
        object Progetti1: TMenuItem
          Action = actProgettiRendiProj
        end
        object Limitiindividuali1: TMenuItem
          Action = actLimitiRendiProj
        end
        object Stamparendicontazione1: TMenuItem
          Action = actStampaRendiProj
        end
      end
      object Festivitaparticolari1: TMenuItem
        Caption = 'Festivit'#224' particolari'
        object Regolefestivitparticolari1: TMenuItem
          Action = actRegoleFestivitaParicolari
        end
        object Elaborazionefestivitparticolari1: TMenuItem
          Action = actElaborazioneFesteParticolari
        end
      end
      object Contegiopasti1: TMenuItem
        Caption = 'Accessi mensa'
        object Regole1: TMenuItem
          Action = actRegoleAM
        end
        object Timbraturemensa1: TMenuItem
          Action = actTimbratureMensa
        end
        object Cartolina1: TMenuItem
          Action = actCartolinaAM
        end
        object Riepilogomensile1: TMenuItem
          Action = actRiepilogoMensileAM
        end
      end
      object Buonimensaticket1: TMenuItem
        Caption = 'Buoni pasto/ticket'
        object Regole2: TMenuItem
          Action = actRegoleBM
        end
        object Cartolina2: TMenuItem
          Action = actCartolinaBM
        end
        object Gestionemagazzino1: TMenuItem
          Action = actGestioneMagazzino
        end
        object Gestioneacquisto2: TMenuItem
          Action = actGestioneAcquisto
        end
        object Riepilogomensile2: TMenuItem
          Action = actRiepilogoMensileBM
        end
      end
      object Incentivi1: TMenuItem
        Caption = 'Incentivi'
        object Regoleincentivi1: TMenuItem
          Action = actRegoleIncentivi
        end
        object ipologieabbattimenti1: TMenuItem
          Action = actTipoAbbattimenti
        end
        object Abbattimentoassenze1: TMenuItem
          Action = actAbbattimentoAssenze
        end
        object N24: TMenuItem
          Caption = '-'
        end
        object ipologiequote1: TMenuItem
          Action = actTipoQuote
        end
        object Quoteannuali1: TMenuItem
          Action = actQuoteIncentivanti
        end
        object Quoteindividuali1: TMenuItem
          Action = actQuoteIndividuali
        end
        object Scaglioniperassegnazioneparttimeincentivi1: TMenuItem
          Action = actScaglioniPT
        end
        object Scaglioniggeffettiviincentivi1: TMenuItem
          Action = actScaglioniGgEffettivi
        end
        object N30: TMenuItem
          Caption = '-'
        end
        object PesatureIndividuali1: TMenuItem
          Action = actPesatureIndividuali
        end
        object Schedequantitativeindividuali1: TMenuItem
          Action = actIncQuantIndividuali
        end
        object Gestionegruppipesature1: TMenuItem
          Action = actGestioneGruppi
        end
        object N29: TMenuItem
          Caption = '-'
        end
        object Cartolina3: TMenuItem
          Action = actCartolinaIncentivi
        end
        object Riepilogomensile3: TMenuItem
          Action = actRiepilogoMensileIncentivi
        end
      end
      object Messaggisticaorologi1: TMenuItem
        Caption = 'Messaggistica orologi'
        object Definizionestrutture1: TMenuItem
          Tag = 165
          Action = actMsgOrologiStrutture
        end
        object Creazionemessaggi1: TMenuItem
          Tag = 166
          Action = actMsgOrologiCreazione
        end
      end
      object Flussistatistici1: TMenuItem
        Caption = 'Flussi statistici'
        object RegolefornituraFLUPER1: TMenuItem
          Action = actFLUPERRegole
        end
        object ElaborazionefornituraFLUPER1: TMenuItem
          Action = actFLUPERCalcolo
        end
        object FornituraFLUPER1: TMenuItem
          Action = actFLUPERDati
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object Parametrizzazioneestrazioni1: TMenuItem
          Tag = 170
          Action = actFlussiParametrizzazioneEstrazione
        end
        object Estrazion1: TMenuItem
          Tag = 171
          Action = actFlussiEstrazioneDati
        end
      end
      object Contoannuale1: TMenuItem
        Caption = 'Conto annuale'
        object Regole4: TMenuItem
          Action = actContoAnnRegole
        end
        object ElaborazioneContoAnnuale1: TMenuItem
          Action = actCalcolaContoAnnuale
        end
        object Contoannuale2: TMenuItem
          Action = actContoAnnuale
        end
        object Risorseresiduedelcontoannuale1: TMenuItem
          Action = actContoAnnRisRes
        end
      end
      object AssenteismoScioperi1: TMenuItem
        Caption = 'Assenteismo/Scioperi'
        object AssenteismoeForzaLavoro1: TMenuItem
          Action = actAssenteismo
        end
        object actPartecipazioneScioperi1: TMenuItem
          Action = actPartecipazioneScioperi
        end
      end
      object Missionitrasferte1: TMenuItem
        Caption = 'Gestione trasferte'
        object Regole3: TMenuItem
          Action = actMissioniRegole
        end
        object ariffeMissioni1: TMenuItem
          Action = actTariffeMissioni
        end
        object Tipirimborsi1: TMenuItem
          Action = actMissioniTipiRimborsi
        end
        object Distanzechilometriche1: TMenuItem
          Action = actDistanzeChilometriche
        end
        object Tariffaoraria1: TMenuItem
          Action = actMissioniIndennitaKm
        end
        object Regoleitermissioni1: TMenuItem
          Action = actDatiLiberiIterMissioni
        end
        object Gestioneanticipi1: TMenuItem
          Action = actGestioneAnticipi
        end
        object miCalcoloSpeseAccesso: TMenuItem
          Action = actCalcoloSpeseAccesso
        end
        object Registrazionemissioni1: TMenuItem
          Action = actMissioniRegistrazione
        end
        object Stampa1: TMenuItem
          Action = actMissioniStampa
        end
      end
      object Sindacati1: TMenuItem
        Caption = 'Sindacati'
        object Organizzazionisindacali1: TMenuItem
          Tag = 55
          Action = actSindacatiOrganizzazioni
        end
        object Iscrizioniaisindacati1: TMenuItem
          Tag = 56
          Action = actSindacatiIscrizioni
        end
        object Partecipazioniaisindacati1: TMenuItem
          Tag = 57
          Action = actSindacatiPartecipazioni
        end
        object Permessisindacali1: TMenuItem
          Tag = 58
          Action = actSindacatiPermessi
        end
      end
      object Valutazioni1: TMenuItem
        Caption = 'Valutazioni'
        object Regolevalutazioni1: TMenuItem
          Tag = 350
          Action = actRegoleValutazioni
        end
        object Statiavanzamentovalutazioni1: TMenuItem
          Tag = 354
          Action = actStatiAvanzamentoVal
        end
        object Areevalutazioni1: TMenuItem
          Tag = 342
          Action = actAreeValutazioni
        end
        object Profiliaree1: TMenuItem
          Tag = 345
          Action = actProfiliAree
        end
        object Legamivalutatoredipendente1: TMenuItem
          Tag = 343
          Action = actValutatoriDipendente
        end
        object Punteggivalutazioni1: TMenuItem
          Tag = 340
          Action = actPunteggiValutazioni
        end
        object Scaglioniperassegnazionedegliincentivi1: TMenuItem
          Tag = 353
          Action = actScaglioniIncentivi
        end
        object Parametrizzazioneprotocollazione1: TMenuItem
          Tag = 355
          Action = actParametrizzazioneProtocollo
        end
        object Stampaschedevalutazioni1: TMenuItem
          Tag = 347
          Action = actStampaValutazioni
        end
      end
      object Fondi1: TMenuItem
        Caption = 'Fondi'
        object Macrocategoriefondi1: TMenuItem
          Tag = 607
          Action = actMacrocategorieFondi
        end
        object Raggruppamentifondi1: TMenuItem
          Tag = 608
          Action = actRaggruppamentiFondi
        end
        object Definizionefondi1: TMenuItem
          Tag = 609
          Action = actDefinizioneFondi
        end
        object Calcolofondi1: TMenuItem
          Tag = 610
          Action = actCalcoloFondi
        end
        object Macrocategoriefondi2: TMenuItem
          Tag = 611
          Action = actMonitoraggioFondi
        end
        object Stampafondi1: TMenuItem
          Tag = 612
          Action = actStampaFondi
        end
      end
    end
  end
  inherited actlstBase: TActionList
    inherited actCdcPercent: TAction
      Tag = 162
    end
  end
  object actlstPersonale: TActionList [16]
    Left = 180
    Top = 196
    object actCartellinoInterattivo: TAction
      Tag = 7
      Category = 'Personale'
      Caption = 'Cartellino interattivo'
      Hint = 'Cartellino interattivo'
      ImageIndex = 30
      OnExecute = actPersonaleExecute
    end
    object actGiustificativi: TAction
      Tag = 2
      Category = 'Personale'
      Caption = 'Giustificativi ass./pres.'
      Hint = 'Giustificativi ass./pres.'
      ImageIndex = 54
      OnExecute = actPersonaleExecute
    end
    object actPianificazione: TAction
      Tag = 8
      Category = 'Personale'
      Caption = 'Pianificazioni giornaliere'
      Hint = 'Pianificazioni giornaliere'
      OnExecute = actPersonaleExecute
    end
    object actSchedaRiepilogativa: TAction
      Tag = 10
      Category = 'Personale'
      Caption = 'Scheda riepilogativa'
      Hint = 'Scheda riepilogativa'
      ImageIndex = 49
      OnExecute = actPersonaleExecute
    end
    object actResiduiAnnoPrecedente: TAction
      Tag = 11
      Category = 'Personale'
      Caption = 'Residui anno precedente'
      Hint = 'Residui anno precedente'
      OnExecute = actPersonaleExecute
    end
    object actAssestamentoOreAnniPrec: TAction
      Tag = 168
      Category = 'Personale'
      Caption = 'Assestamento ore anni precedenti'
      Hint = 'Assestamento ore anni precedenti'
      OnExecute = actPersonaleExecute
    end
    object actIndFunzione: TAction
      Tag = 100011
      Category = 'Personale'
      Caption = 'Indennit'#224' di funzione'
      Hint = 'Indennit'#224' di funzione'
      ImageIndex = 166
      OnExecute = actPersonaleExecute
    end
    object actProfiloAssenzeIndividuale: TAction
      Tag = 4
      Category = 'Personale'
      Caption = 'Competenze assenze individuali'
      Hint = 'Competenze assenze individuali'
      OnExecute = actPersonaleExecute
    end
    object actCalendarioIndividuale: TAction
      Tag = 1
      Category = 'Personale'
      Caption = 'Calendario individuale'
      Hint = 'Calendario individuale'
      OnExecute = actPersonaleExecute
    end
    object actPlusOrarioIndividuale: TAction
      Tag = 3
      Category = 'Personale'
      Caption = 'Debiti aggiuntivi individuali'
      Hint = 'Debiti aggiuntivi individuali'
      OnExecute = actPersonaleExecute
    end
    object actInserimentoRiposi: TAction
      Tag = 17
      Category = 'Raggruppamenti'
      Caption = 'Inserimento automatico riposi'
      Hint = 'Inserimento automatico riposi'
      ImageIndex = 65
      OnExecute = actPersonaleExecute
    end
    object actInserimentoGiustificativi: TAction
      Tag = 47
      Category = 'Raggruppamenti'
      Caption = 'Inserimento giustificativi collettivi'
      Hint = 'Inserimento giustificativi collettivi'
      ImageIndex = 154
      OnExecute = actPersonaleExecute
    end
    object actStampaAnomalie: TAction
      Tag = 12
      Category = 'Raggruppamenti'
      Caption = 'Stampa anomalie'
      Hint = 'Stampa anomalie'
      ImageIndex = 35
      OnExecute = actPersonaleExecute
    end
    object actStampaCartellino: TAction
      Tag = 9
      Category = 'Raggruppamenti'
      Caption = 'Cartellino mensile'
      Hint = 'Cartellino mensile'
      ImageIndex = 70
      OnExecute = actPersonaleExecute
    end
    object actElencoPresentiAssenti: TAction
      Tag = 18
      Category = 'Raggruppamenti'
      Caption = 'Stampe analitiche presenze/assenze'
      Hint = 'Stampe analitiche presenze/assenze'
      ImageIndex = 147
      OnExecute = actPersonaleExecute
    end
    object actAssenzeIndividuali: TAction
      Tag = 30
      Category = 'Raggruppamenti'
      Caption = 'Elenco assenze individuali'
      Hint = 'Elenco assenze individuali'
      ImageIndex = 146
      OnExecute = actPersonaleExecute
    end
    object actSchedaAnnualeAssenze: TAction
      Tag = 41
      Category = 'Raggruppamenti'
      Caption = 'Scheda annuale assenze'
      Hint = 'Scheda annuale assenze'
      OnExecute = actPersonaleExecute
    end
    object actStatisticaMinisterialeAssenze: TAction
      Tag = 595
      Category = 'Raggruppamenti'
      Caption = 'Statistica ministeriale assenze'
      Hint = 'Statistica ministeriale assenze'
      OnExecute = actPersonaleExecute
    end
    object actGeneratoreStampe: TAction
      Tag = 139
      Category = 'Raggruppamenti'
      Caption = 'Generatore di stampe'
      Hint = 'Generatore di stampe'
      ImageIndex = 40
      OnExecute = actPersonaleExecute
    end
    object actElencoStorici: TAction
      Tag = 42
      Category = 'Raggruppamenti'
      Caption = 'Elenco movimenti storici'
      Hint = 'Elenco movimenti storici'
      OnExecute = actPersonaleExecute
    end
    object actStampaTimbratureOriginali: TAction
      Tag = 26
      Category = 'Raggruppamenti'
      Caption = 'Stampa timbrature originali'
      Hint = 'Stampa timbrature originali'
      OnExecute = actPersonaleExecute
    end
    object actInterrogazioniServizio: TAction
      Tag = 31
      Category = 'Raggruppamenti'
      Caption = 'Interrogazioni di servizio'
      Hint = 'Interrogazioni di servizio'
      ImageIndex = 142
      OnExecute = actPersonaleExecute
    end
    object actLiquidazioneOreCausalizzate: TAction
      Tag = 48
      Category = 'Raggruppamenti'
      Caption = 'Liquidazione ore causalizzate'
      Hint = 'Liquidazione ore causalizzate'
      ImageIndex = 82
      OnExecute = actPersonaleExecute
    end
    object actLiqOreAnniPrec: TAction
      Tag = 169
      Category = 'Raggruppamenti'
      Caption = 'Liquidazione ore anni precedenti'
      Hint = 'Liquidazione ore anni precedenti'
      OnExecute = actPersonaleExecute
    end
    object actInserimentoAutomaticoAssenze: TAction
      Tag = 38
      Category = 'Raggruppamenti'
      Caption = 'Inserimento automatico assenze'
      Hint = 'Inserimento automatico assenze'
      OnExecute = actPersonaleExecute
    end
    object actFamiliari: TAction
      Tag = 303
      Category = 'Personale'
      Caption = 'Familiari'
      Hint = 'Familiari'
      ImageIndex = 94
      OnExecute = actPersonaleExecute
    end
    object actPassaggioAnno: TAction
      Tag = 37
      Category = 'Raggruppamenti'
      Caption = 'Passaggio di anno'
      Hint = 'Passaggio di anno'
      OnExecute = actPersonaleExecute
    end
    object actStoricoGiustificativi: TAction
      Tag = 6
      Category = 'Raggruppamenti'
      Caption = 'Storico giustificativi'
      Hint = 'Storico giustificativi'
      OnExecute = actPersonaleExecute
    end
    object actCompensazioneAutomatica: TAction
      Tag = 54
      Category = 'Raggruppamenti'
      Caption = 'Compensazione giornaliera automatica'
      Hint = 'Compensazione giornaliera automatica'
      OnExecute = actPersonaleExecute
    end
    object actSicurezzaRiepiloghi: TAction
      Tag = 59
      Category = 'Raggruppamenti'
      Caption = 'Sicurezza riepiloghi'
      Hint = 'Sicurezza riepiloghi'
      OnExecute = actPersonaleExecute
    end
    object actImportazioneAssestamentoOre: TAction
      Tag = 208
      Category = 'Raggruppamenti'
      Caption = 'Importazione assestamento ore'
      Hint = 'Importazione assestamento ore'
      OnExecute = actPersonaleExecute
    end
    object actRegistraIndFunzione: TAction
      Tag = 100010
      Category = 'Raggruppamenti'
      Caption = 'Calcolo indennit'#224' di funzione'
      Hint = 'Calcolo indennit'#224' di funzione'
      ImageIndex = 165
      OnExecute = actPersonaleExecute
    end
  end
  object actlstAmbiente: TActionList [17]
    Left = 208
    Top = 196
    object actDatiLiberiNonStorici: TAction
      Tag = 114
      Caption = 'Dati liberi non storicizzati'
      Hint = 'Dati liberi non storicizzati'
      OnExecute = actAmbienteExecute
    end
    object actPlusOrario: TAction
      Tag = 102
      Caption = 'Debiti aggiuntivi'
      Hint = 'Debiti aggiuntivi'
      OnExecute = actAmbienteExecute
    end
    object actQualificaMinisteriale: TAction
      Tag = 191
      Caption = 'Qualifiche ministeriali'
      Hint = 'Qualifiche ministeriali'
      OnExecute = actAmbienteExecute
    end
    object actIndennitaPresenza: TAction
      Tag = 112
      Caption = 'Indennit'#224' di presenza'
      Hint = 'Indennit'#224' di presenza'
      OnExecute = actAmbienteExecute
    end
    object actIndennitaGruppi: TAction
      Tag = 138
      Caption = 'Indennit'#224' di presenza associate'
      Hint = 'Indennit'#224' di presenza associate'
      OnExecute = actAmbienteExecute
    end
    object actRegoleIndFunzione: TAction
      Tag = 100009
      Caption = 'Regole indennit'#224' di funzione'
      Hint = 'Regole indennit'#224' di funzione'
      OnExecute = actAmbienteExecute
    end
    object actModelliOrario: TAction
      Tag = 103
      Caption = 'Modelli orario'
      Hint = 'Modelli orario'
      ImageIndex = 34
      OnExecute = actAmbienteExecute
    end
    object actProfiliOrario: TAction
      Tag = 113
      Caption = 'Profili orario'
      Hint = 'Profili orario'
      ImageIndex = 29
      OnExecute = actAmbienteExecute
    end
    object actTipologieCartellini: TAction
      Tag = 142
      Caption = 'Tipologie cartellini'
      Hint = 'Tipologie cartellini'
      OnExecute = actAmbienteExecute
    end
    object actCalendari: TAction
      Tag = 101
      Caption = 'Calendari'
      Hint = 'Calendari'
      OnExecute = actAmbienteExecute
    end
    object actAccorpamentiCausali: TAction
      Tag = 196
      Caption = 'Accorpamenti causali di assenza'
      Hint = 'Accorpamenti causali di assenza'
      OnExecute = actAmbienteExecute
    end
    object actPartTime: TAction
      Tag = 144
      Caption = 'Part-time'
      Hint = 'Part-time'
      OnExecute = actAmbienteExecute
    end
    object actTipiRapporto: TAction
      Tag = 143
      Caption = 'Tipi di rapporto'
      Hint = 'Tipi di rapporto'
      OnExecute = actAmbienteExecute
    end
    object actContratti: TAction
      Tag = 111
      Caption = 'Contratti'
      Hint = 'Contratti'
      OnExecute = actAmbienteExecute
    end
    object actProfiliAssenze: TAction
      Tag = 104
      Caption = 'Profili assenze annuali'
      Hint = 'Profili assenze annuali'
      ImageIndex = 63
      OnExecute = actAmbienteExecute
    end
    object actParametrizzazioneCartellino: TAction
      Tag = 125
      Caption = 'Parametrizzazione stampa del cartellino'
      Hint = 'Parametrizzazione stampa del cartellino'
      OnExecute = actAmbienteExecute
    end
    object actCausaliAssenza: TAction
      Tag = 105
      Caption = 'Causali di assenza'
      Hint = 'Causali di assenza'
      ImageIndex = 37
      OnExecute = actAmbienteExecute
    end
    object actCausaliPresenza: TAction
      Tag = 107
      Caption = 'Causali di presenza'
      Hint = 'Causali di presenza'
      ImageIndex = 36
      OnExecute = actAmbienteExecute
    end
    object actCausaliGiustificazione: TAction
      Tag = 109
      Caption = 'Causali di giustificazione'
      Hint = 'Causali di giustificazione'
      OnExecute = actAmbienteExecute
    end
    object actRaggruppamentiAssenza: TAction
      Tag = 106
      Caption = 'Raggruppamenti di assenza'
      Hint = 'Raggruppamenti di assenza'
      OnExecute = actAmbienteExecute
    end
    object actRaggruppamentiPresenza: TAction
      Tag = 108
      Caption = 'Raggruppamenti di presenza'
      Hint = 'Raggruppamenti di presenza'
      OnExecute = actAmbienteExecute
    end
    object actRaggruppamentiGiustificazione: TAction
      Tag = 110
      Caption = 'Raggruppamenti di giustificazione'
      Hint = 'Raggruppamenti di giustificazione'
      OnExecute = actAmbienteExecute
    end
    object actSetupValute: TAction
      Tag = 520
      Caption = 'Configurazione dati economici'
      Hint = 'Configurazione dati economici'
      OnExecute = actAmbienteExecute
    end
    object actValute: TAction
      Tag = 517
      Caption = 'Valute'
      Hint = 'Valute'
      OnExecute = actAmbienteExecute
    end
    object actArrotondamentiValute: TAction
      Tag = 519
      Caption = 'Arrotondamenti valute'
      Hint = 'Arrotondamenti valute'
      OnExecute = actAmbienteExecute
    end
    object actComuni: TAction
      Tag = 530
      Caption = 'Enti locali'
      Hint = 'Enti locali'
      OnExecute = actAmbienteExecute
    end
    object actCompensazioneAutomaticaRegole: TAction
      Tag = 163
      Caption = 'Regole compensazione giornaliera'
      Hint = 'Regole compensazione giornaliera'
      OnExecute = actAmbienteExecute
    end
    object actGestioneImmagini: TAction
      Tag = 164
      Caption = 'Loghi aziendali'
      Hint = 'Loghi aziendali'
      OnExecute = actAmbienteExecute
    end
    object actDatiLiberiStoricizzati: TAction
      Tag = 167
      Caption = 'Dati liberi storicizzati'
      Hint = 'Dati liberi storicizzati'
      OnExecute = actAmbienteExecute
    end
    object actRegoleRiposi: TAction
      Tag = 176
      Caption = 'Regole inserimento riposi'
      Hint = 'Regole inserimento riposi'
      OnExecute = actAmbienteExecute
    end
    object actCambiValute: TAction
      Tag = 518
      Caption = 'actCambiValute'
      OnExecute = actAmbienteExecute
    end
    object actCUDSetup: TAction
      Tag = 543
      Caption = 'Configurazione dati aziendali'
      Hint = 'Configurazione dati aziendali'
      OnExecute = actAmbienteExecute
    end
    object actRaggrInterrogazioni: TAction
      Tag = 52
      Caption = 'Raggruppamenti interrogazioni di servizio'
      Hint = 'Raggruppamenti interrogazioni di servizio'
      OnExecute = actAmbienteExecute
    end
  end
  object actlstInterfacce: TActionList [18]
    Left = 180
    Top = 236
    object actInterfacciaPaghe: TAction
      Tag = 121
      Category = 'ScaricoPaghe'
      Caption = 'Attivazione voci variabili'
      Hint = 'Attivazione voci variabili'
      OnExecute = actInterfacceExecute
    end
    object actParametrizzazioneScaricoPaghe: TAction
      Tag = 122
      Category = 'ScaricoPaghe'
      Caption = 'Regole scarico paghe'
      Hint = 'Regole scarico paghe'
      OnExecute = actInterfacceExecute
    end
    object actScaricoPaghe: TAction
      Tag = 13
      Category = 'ScaricoPaghe'
      Caption = 'Scarico paghe'
      Hint = 'Scarico paghe'
      ImageIndex = 62
      OnExecute = actInterfacceExecute
    end
    object actVociVariabiliScaricate: TAction
      Tag = 14
      Category = 'ScaricoPaghe'
      Caption = 'Voci variabili scaricate'
      Hint = 'Voci variabili scaricate'
      OnExecute = actInterfacceExecute
    end
    object actOrologi: TAction
      Tag = 124
      Category = 'AcquisizioneTimbrature'
      Caption = 'Orologi di timbratura'
      Hint = 'Orologi di timbratura'
      OnExecute = actInterfacceExecute
    end
    object actParametrizzazioneAcquisizioneTimbr: TAction
      Tag = 119
      Category = 'AcquisizioneTimbrature'
      Caption = 'Regole acquisizione timbrature'
      Hint = 'Regole acquisizione timbrature'
      OnExecute = actInterfacceExecute
    end
    object actAcquisizioneTimbrature: TAction
      Tag = 120
      Category = 'AcquisizioneTimbrature'
      Caption = 'Acquisizione timbrature'
      Hint = 'Acquisizione timbrature'
      ImageIndex = 81
      OnExecute = actInterfacceExecute
    end
    object actTimbratureIrregolari: TAction
      Tag = 130
      Category = 'AcquisizioneTimbrature'
      Caption = 'Timbrature irregolari'
      Hint = 'Timbrature irregolari'
      ImageIndex = 80
      OnExecute = actInterfacceExecute
    end
    object actParametrizzazioneAcquisizioneGiust: TAction
      Tag = 159
      Category = 'AcquisizioneGiustificativi'
      Caption = 'Regole acquisizione giustificativi'
      Hint = 'Regole acquisizione giustificativi'
      OnExecute = actInterfacceExecute
    end
    object actAcquisizioneGiustificativi: TAction
      Tag = 160
      Category = 'AcquisizioneGiustificativi'
      Caption = 'Acquisizione giustificativi'
      Hint = 'Acquisizione giustificativi'
      OnExecute = actInterfacceExecute
    end
    object actBadgeServizio: TAction
      Tag = 172
      Category = 'AcquisizioneTimbrature'
      Caption = 'Badge di servizio'
      Hint = 'Badge di servizio'
      OnExecute = actInterfacceExecute
    end
    object actCambioOraLegaleSolare: TAction
      Tag = 178
      Category = 'AcquisizioneTimbrature'
      Caption = 'Cambio ora legale/solare'
      Hint = 'Cambio ora legale/solare'
      OnExecute = actInterfacceExecute
    end
    object actTimbratureScartate: TAction
      Tag = 189
      Category = 'AcquisizioneTimbrature'
      Caption = 'Timbrature scartate'
      Hint = 'Timbrature scartate'
      OnExecute = actInterfacceExecute
    end
    object actMotivazioniRichieste: TAction
      Tag = 203
      Category = 'IrisWeb'
      Caption = 'Causali per iter autorizzativi'
      Hint = 'Causali per iter autorizzativi'
      OnExecute = actInterfacceExecute
    end
    object actPubblicazioneDocumenti: TAction
      Tag = 210
      Category = 'IrisWeb'
      Caption = 'Pubblicazione documenti'
      Hint = 'Pubblicazione documenti'
      OnExecute = actInterfacceExecute
    end
    object actValidazioneCartellino: TAction
      Tag = 100005
      Category = 'IrisWeb'
      Caption = 'Validazione cartellino'
      Hint = 'Validazione cartellino'
      OnExecute = actInterfacceExecute
    end
    object actRiepilogoIterAutorizzativi: TAction
      Tag = 214
      Category = 'IrisWeb'
      Caption = 'Riepilogo iter autorizzativi'
      OnExecute = actInterfacceExecute
    end
  end
  object actlstModuliOpzionali: TActionList [19]
    Left = 208
    Top = 236
    object actRegoleIncentivi: TAction
      Tag = 145
      Category = 'Incentivi'
      Caption = 'Regole incentivi'
      Hint = 'Regole incentivi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actTipoAbbattimenti: TAction
      Tag = 198
      Category = 'Incentivi'
      Caption = 'Tipologie di abbattimento incentivi'
      Hint = 'Tipologie di abbattimento incentivi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actAbbattimentoAssenze: TAction
      Tag = 174
      Category = 'Incentivi'
      Caption = 'Abbattimento incentivi per assenze'
      Hint = 'Abbattimento incentivi per assenze'
      OnExecute = actModuliOpzionaliExecute
    end
    object actRegoleTurniRep: TAction
      Tag = 123
      Category = 'Reperibilita'
      Caption = 'Regole turni di reperibilit'#224'/guardia'
      Hint = 'Regole turni di reperibilit'#224'/guardia'
      OnExecute = actModuliOpzionaliExecute
    end
    object actVincoliGuardia: TAction
      Tag = 69
      Category = 'Reperibilita'
      Caption = 'Vincoli pianificazione guardia'
      Hint = 'Vincoli pianificazione guardia'
      OnExecute = actModuliOpzionaliExecute
    end
    object actVincoliReperibilita: TAction
      Tag = 68
      Category = 'Reperibilita'
      Caption = 'Vincoli pianificazione reperibilit'#224
      Hint = 'Vincoli pianificazione reperibilit'#224
      OnExecute = actModuliOpzionaliExecute
    end
    object actPianifPrioritaChiamata: TAction
      Tag = 100008
      Category = 'Reperibilita'
      Caption = 'Priorit'#224' di chiamata reperibilit'#224
      Hint = 'Priorit'#224' di chiamata reperibilit'#224
      OnExecute = actModuliOpzionaliExecute
    end
    object actQuoteIncentivanti: TAction
      Tag = 146
      Category = 'Incentivi'
      Caption = 'Quote di incentivazione'
      Hint = 'Quote di incentivazione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actTipoQuote: TAction
      Tag = 199
      Category = 'Incentivi'
      Caption = 'Tipologie quote'
      Hint = 'Tipologie quote'
      OnExecute = actModuliOpzionaliExecute
    end
    object actPianificazioneTurniGuardia: TAction
      Tag = 63
      Category = 'Reperibilita'
      Caption = 'Pianificazione turni guardia'
      Hint = 'Pianificazione turni guardia'
      ImageIndex = 129
      OnExecute = actModuliOpzionaliExecute
    end
    object actPianificazioneTurniRep: TAction
      Tag = 16
      Category = 'Reperibilita'
      Caption = 'Pianificazione turni reperibilit'#224
      Hint = 'Pianificazione turni reperibilit'#224
      ImageIndex = 41
      OnExecute = actModuliOpzionaliExecute
    end
    object actPesatureIndividuali: TAction
      Tag = 173
      Category = 'Incentivi'
      Caption = 'Pesature individuali'
      Hint = 'Pesature individuali'
      OnExecute = actModuliOpzionaliExecute
    end
    object actCartellinoReperibilita: TAction
      Tag = 19
      Category = 'Reperibilita'
      Caption = 'Cartolina reperibilit'#224
      Hint = 'Cartolina reperibilit'#224
      ImageIndex = 74
      OnExecute = actModuliOpzionaliExecute
    end
    object actRiepilogoReperibilita: TAction
      Tag = 15
      Category = 'Reperibilita'
      Caption = 'Riepilogo turni di reperibilit'#224
      Hint = 'Riepilogo turni di reperibilit'#224
      ImageIndex = 78
      OnExecute = actModuliOpzionaliExecute
    end
    object actTurniRepSostitutivi: TAction
      Tag = 32
      Category = 'Reperibilita'
      Caption = 'Turni di reperibilit'#224' sostitutivi'
      Hint = 'Turni di reperibilit'#224' sostitutivi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actCicli: TAction
      Tag = 126
      Category = 'Turni'
      Caption = 'Cicli'
      Hint = 'Cicli'
      OnExecute = actModuliOpzionaliExecute
    end
    object actTurnazioni: TAction
      Tag = 127
      Category = 'Turni'
      Caption = 'Turnazioni dei cicli'
      Hint = 'Turnazioni dei cicli'
      OnExecute = actModuliOpzionaliExecute
    end
    object actSquadre: TAction
      Tag = 128
      Category = 'Turni'
      Caption = 'Squadre'
      Hint = 'Squadre'
      OnExecute = actModuliOpzionaliExecute
    end
    object actTurnazioniIndividuali: TAction
      Tag = 22
      Category = 'Turni'
      Caption = 'Assegnazione turnazioni'
      Hint = 'Assegnazione turnazioni'
      OnExecute = actModuliOpzionaliExecute
    end
    object actSpostamentiSquadra: TAction
      Tag = 23
      Category = 'Turni'
      Caption = 'Spostamenti di squadra'
      Hint = 'Spostamenti di squadra'
      OnExecute = actModuliOpzionaliExecute
    end
    object actPianificazioneTI: TAction
      Tag = 24
      Category = 'Turni'
      Caption = 'Pianificazione tabellone'
      Hint = 'Pianificazione tabellone'
      ImageIndex = 91
      OnExecute = actModuliOpzionaliExecute
    end
    object actControlloPianificazione: TAction
      Tag = 25
      Category = 'Turni'
      Caption = 'Controllo pianificazione'
      Hint = 'Controllo pianificazione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actSituazioneGiornaliera: TAction
      Tag = 33
      Category = 'Turni'
      Caption = 'Situazione giornaliera dei turni'
      Hint = 'Situazione giornaliera dei turni'
      OnExecute = actModuliOpzionaliExecute
    end
    object actGestioneBudget: TAction
      Tag = 132
      Category = 'BudgetStraordinario'
      Caption = 'Gestione del budget'
      Hint = 'Gestione del budget'
      OnExecute = actModuliOpzionaliExecute
    end
    object actAllineamentoBudget: TAction
      Tag = 131
      Category = 'BudgetStraordinario'
      Caption = 'Allineamento del budget'
      Hint = 'Allineamento del budget'
      ImageIndex = 119
      OnExecute = actModuliOpzionaliExecute
    end
    object actStampaSituazioneBudget: TAction
      Tag = 133
      Category = 'BudgetStraordinario'
      Caption = 'Stampa situazione del budget'
      Hint = 'Stampa situazione del budget'
      OnExecute = actModuliOpzionaliExecute
    end
    object actGestioneMonetizzazione: TAction
      Tag = 134
      Category = 'BudgetStraordinario'
      Caption = 'Monetizzazione ore di straordinario'
      Hint = 'Monetizzazione ore di straordinario'
      OnExecute = actModuliOpzionaliExecute
    end
    object actLiquidazioneCollettiva: TAction
      Tag = 135
      Category = 'BudgetStraordinario'
      Caption = 'Liquidazione del budget'
      Hint = 'Liquidazione del budget'
      OnExecute = actModuliOpzionaliExecute
    end
    object actLimitiMensiliBS: TAction
      Tag = 43
      Category = 'BudgetStraordinario'
      Caption = 'Limiti mensili delle eccedenze orarie'
      Hint = 'Limiti mensili delle eccedenze orarie'
      ImageIndex = 84
      OnExecute = actModuliOpzionaliExecute
    end
    object actLiquidazioneAutomaticaBS: TAction
      Tag = 44
      Category = 'BudgetStraordinario'
      Caption = 'Liquidazione automatica straordinario'
      Hint = 'Liquidazione automatica straordinario'
      ImageIndex = 83
      OnExecute = actModuliOpzionaliExecute
    end
    object actRipartizioneStr: TAction
      Tag = 52
      Category = 'BudgetStraordinario'
      Caption = 'Ripartizione straordinario'
      Hint = 'Ripartizione straordinario'
      OnExecute = actModuliOpzionaliExecute
    end
    object actRegoleAM: TAction
      Tag = 129
      Category = 'AccessiMensa'
      Caption = 'Regole accessi mensa'
      Hint = 'Regole accessi mensa'
      OnExecute = actModuliOpzionaliExecute
    end
    object actTimbratureMensa: TAction
      Tag = 27
      Category = 'AccessiMensa'
      Caption = 'Timbrature di mensa'
      Hint = 'Timbrature di mensa'
      ImageIndex = 87
      OnExecute = actModuliOpzionaliExecute
    end
    object actCartolinaAM: TAction
      Tag = 28
      Category = 'AccessiMensa'
      Caption = 'Cartolina accessi mensa'
      Hint = 'Cartolina accessi mensa'
      ImageIndex = 72
      OnExecute = actModuliOpzionaliExecute
    end
    object actRiepilogoMensileAM: TAction
      Tag = 29
      Category = 'AccessiMensa'
      Caption = 'Riepilogo accessi mensa'
      Hint = 'Riepilogo accessi mensa'
      ImageIndex = 79
      OnExecute = actModuliOpzionaliExecute
    end
    object actPrenotazionePasti: TAction
      Tag = 141
      Category = 'AccessiMensa'
      Caption = 'Elenco timbrature causalizzate'
      Hint = 'Elenco timbrature causalizzate'
      OnExecute = actModuliOpzionaliExecute
    end
    object actRegoleBM: TAction
      Tag = 137
      Category = 'BuoniPasto'
      Caption = 'Regole di gestione buoni pasto/ticket'
      Hint = 'Regole di gestione buoni pasto/ticket'
      OnExecute = actModuliOpzionaliExecute
    end
    object actRiepilogoMensileBM: TAction
      Tag = 34
      Category = 'BuoniPasto'
      Caption = 'Riepilogo buoni pasto/ticket'
      Hint = 'Riepilogo buoni pasto/ticket'
      ImageIndex = 76
      OnExecute = actModuliOpzionaliExecute
    end
    object actGestioneAcquisto: TAction
      Tag = 35
      Category = 'BuoniPasto'
      Caption = 'Riepilogo acquisto buoni pasto/ticket'
      Hint = 'Riepilogo acquisto buoni pasto/ticket'
      ImageIndex = 86
      OnExecute = actModuliOpzionaliExecute
    end
    object actCartolinaBM: TAction
      Tag = 36
      Category = 'BuoniPasto'
      Caption = 'Cartolina buoni pasto/ticket'
      Hint = 'Cartolina buoni pasto/ticket'
      ImageIndex = 75
      OnExecute = actModuliOpzionaliExecute
    end
    object actQuoteIndividuali: TAction
      Tag = 62
      Category = 'Incentivi'
      Caption = 'Quote individuali'
      Hint = 'Quote individuali'
      OnExecute = actModuliOpzionaliExecute
    end
    object actCartolinaIncentivi: TAction
      Tag = 39
      Category = 'Incentivi'
      Caption = 'Cartolina incentivi'
      Hint = 'Cartolina incentivi'
      ImageIndex = 73
      OnExecute = actModuliOpzionaliExecute
    end
    object actRiepilogoMensileIncentivi: TAction
      Tag = 40
      Category = 'Incentivi'
      Caption = 'Riepilogo incentivi'
      Hint = 'Riepilogo incentivi'
      ImageIndex = 77
      OnExecute = actModuliOpzionaliExecute
    end
    object actDefinizioneProfiliLP: TAction
      Tag = 150
      Category = 'LiberaProfessione'
      Caption = 'Profili libera professione'
      Hint = 'Profili libera professione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actPianificazioneAttivitaLP: TAction
      Tag = 46
      Category = 'LiberaProfessione'
      Caption = 'Pianificazione libera professione'
      Hint = 'Pianificazione libera professione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMissioniRegole: TAction
      Tag = 155
      Category = 'Missioni'
      Caption = 'Regole trasferte'
      Hint = 'Regole trasferte'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMissioniTipiRimborsi: TAction
      Tag = 156
      Category = 'Missioni'
      Caption = 'Tipi rimborsi'
      Hint = 'Tipi rimborsi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMissioniRegistrazione: TAction
      Tag = 49
      Category = 'Missioni'
      Caption = 'Registrazione trasferte'
      Hint = 'Registrazione trasferte'
      ImageIndex = 89
      OnExecute = actModuliOpzionaliExecute
    end
    object actMissioniStampa: TAction
      Tag = 53
      Category = 'Missioni'
      Caption = 'Stampa trasferte'
      Hint = 'Stampa trasferte'
      ImageIndex = 88
      OnExecute = actModuliOpzionaliExecute
    end
    object actMsgOrologiStrutture: TAction
      Tag = 165
      Category = 'MessaggiOrologi'
      Caption = 'Parametrizzazione interfacce messaggi'
      Hint = 'Parametrizzazione interfacce messaggi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMsgOrologiCreazione: TAction
      Tag = 166
      Category = 'MessaggiOrologi'
      Caption = 'Generazione messaggi'
      Hint = 'Generazione messaggi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actFlussiEstrazioneDati: TAction
      Tag = 171
      Category = 'Fluper'
      Caption = 'Estrazione dati'
      Hint = 'Estrazione dati'
      OnExecute = actModuliOpzionaliExecute
    end
    object actFlussiParametrizzazioneEstrazione: TAction
      Tag = 170
      Category = 'Fluper'
      Caption = 'Parametrizzazione estrazione dati'
      Hint = 'Parametrizzazione estrazione dati'
      OnExecute = actModuliOpzionaliExecute
    end
    object actSindacatiOrganizzazioni: TAction
      Tag = 55
      Category = 'Sindacati'
      Caption = 'Organizzazioni sindacali'
      Hint = 'Organizzazioni sindacali'
      ImageIndex = 95
      OnExecute = actModuliOpzionaliExecute
    end
    object actSindacatiIscrizioni: TAction
      Tag = 56
      Category = 'Sindacati'
      Caption = 'Iscrizioni ai sindacati'
      Hint = 'Iscrizioni ai sindacati'
      ImageIndex = 96
      OnExecute = actModuliOpzionaliExecute
    end
    object actSindacatiPartecipazioni: TAction
      Tag = 57
      Category = 'Sindacati'
      Caption = 'Partecipazioni ai sindacati'
      Hint = 'Partecipazioni ai sindacati'
      ImageIndex = 97
      OnExecute = actModuliOpzionaliExecute
    end
    object actSindacatiPermessi: TAction
      Tag = 58
      Category = 'Sindacati'
      Caption = 'Permessi sindacali'
      Hint = 'Permessi sindacali'
      ImageIndex = 98
      OnExecute = actModuliOpzionaliExecute
    end
    object actRegoleTurniPrestAgg: TAction
      Tag = 60
      Category = 'PrestazioniAggiuntive'
      Caption = 'Regole prestazioni aggiuntive'
      Hint = 'Regole prestazioni aggiuntive'
      OnExecute = actModuliOpzionaliExecute
    end
    object actPianifPrestAgg: TAction
      Tag = 61
      Category = 'PrestazioniAggiuntive'
      Caption = 'Pianificazione prestazioni aggiuntive'
      Hint = 'Pianificazione prestazioni aggiuntive'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMissioniIndennitaKm: TAction
      Tag = 157
      Category = 'Missioni'
      Caption = 'Indennit'#224' chilometriche'
      Hint = 'Indennit'#224' chilometriche'
      OnExecute = actModuliOpzionaliExecute
    end
    object actDistanzeChilometriche: TAction
      Tag = 175
      Category = 'Missioni'
      Caption = 'Distanze chilometriche'
      Hint = 'Distanze chilometriche'
      OnExecute = actModuliOpzionaliExecute
    end
    object actGestioneAnticipi: TAction
      Tag = 177
      Category = 'Missioni'
      Caption = 'Gestione anticipi'
      Hint = 'Gestione anticipi'
      ImageIndex = 90
      OnExecute = actModuliOpzionaliExecute
    end
    object actGestioneMagazzino: TAction
      Tag = 179
      Category = 'BuoniPasto'
      Caption = 'Magazzino buoni pasto/ticket'
      Hint = 'Magazzino buoni pasto/ticket'
      OnExecute = actModuliOpzionaliExecute
    end
    object actTariffeMissioni: TAction
      Tag = 180
      Category = 'Missioni'
      Caption = 'Tariffe trasferte'
      Hint = 'Tariffe trasferte'
      OnExecute = actModuliOpzionaliExecute
    end
    object actFLUPERRegole: TAction
      Tag = 571
      Category = 'Fluper'
      Caption = 'Regole fornitura FLUPER'
      Hint = 'Regole fornitura FLUPER'
      OnExecute = actModuliOpzionaliExecute
    end
    object actFLUPERDati: TAction
      Tag = 572
      Category = 'Fluper'
      Caption = 'Fornitura FLUPER'
      Hint = 'Fornitura FLUPER'
      ImageIndex = 128
      OnExecute = actModuliOpzionaliExecute
    end
    object actFLUPERCalcolo: TAction
      Tag = 574
      Category = 'Fluper'
      Caption = 'Elaborazione fornitura FLUPER'
      Hint = 'Elaborazione fornitura FLUPER'
      ImageIndex = 127
      OnExecute = actModuliOpzionaliExecute
    end
    object actContoAnnRegole: TAction
      Tag = 580
      Category = 'ContoAnnuale'
      Caption = 'Regole conto annuale'
      Hint = 'Regole conto annuale'
      OnExecute = actModuliOpzionaliExecute
    end
    object actContoAnnRisRes: TAction
      Tag = 584
      Category = 'ContoAnnuale'
      Caption = 'Risorse residue conto annuale'
      Hint = 'Risorse residue conto annuale'
      OnExecute = actModuliOpzionaliExecute
    end
    object actContoAnnuale: TAction
      Tag = 582
      Category = 'ContoAnnuale'
      Caption = 'Conto annuale'
      Hint = 'Conto annuale'
      OnExecute = actModuliOpzionaliExecute
    end
    object actCalcolaContoAnnuale: TAction
      Tag = 583
      Category = 'ContoAnnuale'
      Caption = 'Elaborazione conto annuale'
      Hint = 'Elaborazione conto annuale'
      OnExecute = actModuliOpzionaliExecute
    end
    object actApparati: TAction
      Tag = 193
      Category = 'ServiziVigili'
      Caption = 'Apparati'
      Hint = 'Apparati'
      Visible = False
      OnExecute = actModuliOpzionaliExecute
    end
    object actServizi: TAction
      Tag = 192
      Category = 'ServiziVigili'
      Caption = 'Servizi'
      Hint = 'Servizi'
      Visible = False
      OnExecute = actModuliOpzionaliExecute
    end
    object actPianifServizi: TAction
      Tag = 194
      Category = 'ServiziVigili'
      Caption = 'Pianificazione Servizi'
      Hint = 'Pianificazione Servizi'
      Visible = False
      OnExecute = actModuliOpzionaliExecute
    end
    object actCalcoloSpeseAccesso: TAction
      Tag = 195
      Category = 'Missioni'
      Caption = 'Calcolo spese di accesso'
      Hint = 'Calcolo spese di accesso'
      OnExecute = actModuliOpzionaliExecute
    end
    object actAssenteismo: TAction
      Tag = 197
      Category = 'AssenteismoScioperi'
      Caption = 'Assenteismo e Forza Lavoro'
      Hint = 'Assenteismo e Forza Lavoro'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMedicineLegali: TAction
      Tag = 64
      Category = 'Visite fiscali'
      Caption = 'Medicine legali'
      Hint = 'Medicine legali'
      OnExecute = actModuliOpzionaliExecute
    end
    object actComuniMedLegali: TAction
      Tag = 65
      Category = 'Visite fiscali'
      Caption = 'Associazione comuni - medicine legali'
      Hint = 'Associazione comuni - medicine legali'
      OnExecute = actModuliOpzionaliExecute
    end
    object actComunicazioneVisiteFiscali: TAction
      Tag = 66
      Category = 'Visite fiscali'
      Caption = 'Comunicazione visite fiscali'
      Hint = 'Comunicazione visite fiscali'
      OnExecute = actModuliOpzionaliExecute
    end
    object actRegoleValutazioni: TAction
      Tag = 350
      Category = 'Valutazioni'
      Caption = 'Regole valutazioni'
      Hint = 'Regole valutazioni'
      OnExecute = actModuliOpzionaliExecute
    end
    object actStatiAvanzamentoVal: TAction
      Tag = 354
      Category = 'Valutazioni'
      Caption = 'Stati avanzamento valutazioni'
      Hint = 'Stati avanzamento valutazioni'
      OnExecute = actModuliOpzionaliExecute
    end
    object actAreeValutazioni: TAction
      Tag = 342
      Category = 'Valutazioni'
      Caption = 'Aree ed elementi di valutazione'
      Hint = 'Aree ed elementi di valutazione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actProfiliAree: TAction
      Tag = 345
      Category = 'Valutazioni'
      Caption = 'Profili valutazioni'
      Hint = 'Profili valutazioni'
      OnExecute = actModuliOpzionaliExecute
    end
    object actValutatoriDipendente: TAction
      Tag = 343
      Category = 'Valutazioni'
      Caption = 'Legami individuali valutatori'
      Hint = 'Legami individuali valutatori'
      OnExecute = actModuliOpzionaliExecute
    end
    object actPunteggiValutazioni: TAction
      Tag = 340
      Category = 'Valutazioni'
      Caption = 'Punteggi valutazioni'
      Hint = 'Punteggi valutazioni'
      OnExecute = actModuliOpzionaliExecute
    end
    object actScaglioniIncentivi: TAction
      Tag = 353
      Category = 'Valutazioni'
      Caption = 'Scaglioni valutazioni per incentivi'
      Hint = 'Scaglioni valutazioni per incentivi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actParametrizzazioneProtocollo: TAction
      Tag = 355
      Category = 'Valutazioni'
      Caption = 'Parametrizzazione protocollazione'
      Hint = 'Parametrizzazione protocollazione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actStampaValutazioni: TAction
      Tag = 347
      Category = 'Valutazioni'
      Caption = 'Elaborazione schede di valutazione'
      Hint = 'Elaborazione schede di valutazione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMacrocategorieFondi: TAction
      Tag = 607
      Category = 'Fondi'
      Caption = 'Macrocategorie fondi'
      Hint = 'Macrocategorie fondi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actRaggruppamentiFondi: TAction
      Tag = 608
      Category = 'Fondi'
      Caption = 'Raggruppamenti fondi'
      Hint = 'Raggruppamenti fondi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actDefinizioneFondi: TAction
      Tag = 609
      Category = 'Fondi'
      Caption = 'Definizione fondi'
      Hint = 'Definizione fondi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actCalcoloFondi: TAction
      Tag = 610
      Category = 'Fondi'
      Caption = 'Calcolo consumi mensili fondi'
      Hint = 'Calcolo consumi mensili fondi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actMonitoraggioFondi: TAction
      Tag = 611
      Category = 'Fondi'
      Caption = 'Monitoraggio fondi'
      Hint = 'Monitoraggio fondi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actStampaFondi: TAction
      Tag = 612
      Category = 'Fondi'
      Caption = 'Stampa fondi'
      Hint = 'Stampa fondi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actGestioneGruppi: TAction
      Tag = 204
      Category = 'Incentivi'
      Caption = 'Gruppi pesature/schede'
      Hint = 'Gruppi pesature/schede'
      OnExecute = actModuliOpzionaliExecute
    end
    object actImpAttestatiMal: TAction
      Tag = 70
      Category = 'Visite fiscali'
      Caption = 'Importazione certificati di malattia'
      Hint = 'Importazione certificati di malattia'
      OnExecute = actModuliOpzionaliExecute
    end
    object actIncQuantIndividuali: TAction
      Tag = 206
      Category = 'Incentivi'
      Caption = 'Schede quantitative individuali'
      Hint = 'Schede quantitative individuali'
      OnExecute = actModuliOpzionaliExecute
    end
    object actScaglioniPT: TAction
      Tag = 205
      Category = 'Incentivi'
      Caption = 'Scaglioni part-time incentivi'
      Hint = 'Scaglioni part-time incentivi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actBudgetEsterno: TAction
      Category = 'BudgetStraordinario'
      Caption = 'Budget esterno annuo'
      Hint = 'Budget esterno annuo'
      OnExecute = actModuliOpzionaliExecute
    end
    object actScaglioniGgEffettivi: TAction
      Tag = 211
      Category = 'Incentivi'
      Caption = 'Scaglioni gg. effettivi incentivi'
      Hint = 'Scaglioni gg. effettivi incentivi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actEventiStraord: TAction
      Tag = 212
      Category = 'BudgetStraordinario'
      Caption = 'Eventi straordinari'
      Hint = 'Eventi straordinari'
      OnExecute = actModuliOpzionaliExecute
    end
    object actPartecipEventiStraord: TAction
      Tag = 71
      Category = 'BudgetStraordinario'
      Caption = 'Partecipazione eventi straordinari'
      Hint = 'Partecipazione eventi straordinari'
      OnExecute = actModuliOpzionaliExecute
    end
    object actParPianifTurni: TAction
      Tag = 213
      Category = 'Turni'
      Caption = 'Profili di pianificazione'
      Hint = 'Profili di pianificazione'
      OnExecute = actModuliOpzionaliExecute
    end
    object actProfiliAttestatiMal: TAction
      Tag = 72
      Category = 'Visite fiscali'
      Caption = 'Profili importazione certificati INPS'
      Hint = 'Profili importazione certificati INPS'
      OnExecute = actModuliOpzionaliExecute
    end
    object actDatiLiberiIterMissioni: TAction
      Tag = 207
      Category = 'Missioni'
      Caption = 'Dati liberi iter missioni'
      Hint = 'Dati liberi iter missioni'
      OnExecute = actInterfacceExecute
    end
    object actPartecipazioneScioperi: TAction
      Tag = 21
      Category = 'AssenteismoScioperi'
      Caption = 'Partecipazione scioperi'
      Hint = 'Partecipazione scioperi'
      OnExecute = actModuliOpzionaliExecute
    end
    object actProgettiRendiProj: TAction
      Tag = 100001
      Category = 'RendicontazioneProgetti'
      Caption = 'Progetti'
      Hint = 'Progetti'
      ImageIndex = 163
      OnExecute = actModuliOpzionaliExecute
    end
    object actLimitiRendiProj: TAction
      Tag = 100002
      Category = 'RendicontazioneProgetti'
      Caption = 'Limiti individuali'
      Hint = 'Limiti individuali'
      OnExecute = actModuliOpzionaliExecute
    end
    object actRegoleFestivitaParicolari: TAction
      Tag = 100003
      Category = 'Festivit'#224' particolari'
      Caption = 'Regole festivit'#224' particolari'
      Hint = 'Regole festivit'#224' particolari'
      OnExecute = actModuliOpzionaliExecute
    end
    object actElaborazioneFesteParticolari: TAction
      Tag = 100004
      Category = 'Festivit'#224' particolari'
      Caption = 'Elaborazione festivit'#224' particolari'
      Hint = 'Elaborazione festivit'#224' particolari'
      ImageIndex = 164
      OnExecute = actModuliOpzionaliExecute
    end
    object actStampaRendiProj: TAction
      Tag = 100006
      Category = 'RendicontazioneProgetti'
      Caption = 'Stampa rendicontazione'
      Hint = 'Stampa rendicontazione'
      OnExecute = actModuliOpzionaliExecute
    end
  end
end
