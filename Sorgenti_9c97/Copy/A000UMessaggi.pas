unit A000UMessaggi;
(*
Nomenclature Constanti:
A000MSG[_x]_y_z_descrizione
  A000MSG : prefisso per tutte le costanti definite
  x:
   <Snnn> messaggio specifico per una unit
   dove Snnn è il codice unit - per es. A006, S101, W009. I WAnnn diventano Annn

  y:
    <ERR> : Messaggio di errore
    <MSG> : Messaggio informativo
    <DLG> : Richiesta di conferma tramite dialog

  z:
    <FMT> : Messaggio che contiene parametri (va usato in una format)
*)

interface

uses SysUtils;

resourcestring
  //messaggi di errore generici
  A000MSG_ERR_WEBSRV_CHIMATA_FALLITA       = 'Errore durante l''autenticazione sul servizio web!'#13#10'La chiamata al web service è fallita.';
  A000MSG_ERR_FMT_WEBSRV_RISP_ERRATA       = 'Errore durante l''autenticazione sul servizio web!'#13#10'Risposta del web service non interpretata'#13#10'(%s/%s)';
  A000MSG_ERR_FMT_WEBSRV_GENERICO          = 'Errore durante l''autenticazione sul servizio web!'#13#10'Motivo: %s/%s';
  A000MSG_ERR_WEBSRV_NO_NOME_UTENTE        = 'Errore durante l''autenticazione sul servizio web!'#13#10'Impossibile recuperare il nome utente';
  A000MSG_ERR_WEBSRV_RISP_NO_RICONOS       = 'Errore durante l''autenticazione sul servizio web!'#13#10'La risposta del web service non è stata riconosciuta!';

  A000MSG_ERR_DATA_VALIDA                  = 'Indicare una data valida!';
  A000MSG_ERR_CONN_FALLITA                 = 'Connessione fallita!';
  A000MSG_ERR_AZIENDA_NON_INDICATA         = 'Indicare l''azienda!';
  A000MSG_ERR_AZIENDA_INESISTENTE          = 'Azienda inesistente!';
  A000MSG_MSG_SEL_AZIENDA                  = 'Selezionare l''azienda';
  A000MSG_ERR_ALIAS_DB_ERRATO              = 'Database %s inesistente!';
  A000MSG_ERR_UTENTE_NON_INDICATO          = 'Indicare il nome utente!';
  A000MSG_ERR_UTENTE_INESISTENTE           = 'Utente inesistente!';
  A000MSG_ERR_AUT_DOM_FALLITA              = 'Autenticazione sul dominio fallita!';
  A000MSG_ERR_PSW_ERRATA                   = 'Password errata!';
  A000MSG_MSG_SEL_PROFILO                  = 'Selezionare il profilo';
  A000MSG_ERR_PROFILO_NON_TROVATO          = 'Profilo inesistente!';
  A000MSG_ERR_ACCESSO_NEGATO_NO_PSW        = 'Non è possibile accedere senza password!';
  A000MSG_MSG_ALLINEAMENTO_VERSIONE        = 'Attenzione!'#13#10'La versione del database (%s) non corrisponde alla versione del prodotto (%s).'#13#10'E'' necessario allineare la propria postazione di lavoro alla versione del database.'#13#10'Se il problema persiste contattare l''amministratore di sistema.';
  A000MSG_MSG_ACCESSO_INIBITO              = 'Attenzione!'#13#10'L''accesso all''applicativo è momentaneamente inibito per attività di amministrazione.'#13#10'Riprovare più tardi o contattare l''amministratore dell''applicativo.';
  A000MSG_MSG_USER_SCADUTA                 = 'Attenzione!'#13#10'E'' scaduto il periodo di validità di questo operatore. Contattare l''amministratore dell''applicativo';
  A000MSG_MSG_PSW_SCADUTA                  = 'La password è scaduta! Inserirne una nuova';

  A000MSG_ERR_FORM_CON_MODIFICHE           = 'Attenzione esistono Modifiche non confermate sulla funzione in oggetto.'#13#10'Confermare o annullare i dati.';
  A000MSG_ERR_LOGOUT_IMPEDITO              = 'Alcune schede non possono essere chiuse a causa di operazioni pendenti.'#13#10'Verificare le schede rimaste aperte.';

  A000MSG_ERR_MODIFICHE_PENDING            = 'Attenzione esistono Modifiche non confermate.'#13#10'Impossibile chiudere.';
  A000MSG_ERR_CHIAVE_DUPLICATA             = 'Chiave già esistente';
  A000MSG_ERR_PROFILO_UTILIZZATO           = '';
  A000MSG_ERR_SELEZIONARE_ELEMENTO         = 'E'' necessario selezionare un elemento della lista!';
  A000MSG_ERR_CANC_ESISTE_MOV_STORICO      = 'Esiste almeno un movimento storico associato al dato: impossibile procedere con la cancellazione!';
  A000MSG_ERR_MODIF_ESISTE_MOV_STORICO     = 'Esiste almeno un movimento storico associato al dato con decorrenza precedente a quella impostata: impossibile procedere con la modifica!';
  A000MSG_ERR_DECOR_SUP_SCAD               = 'Periodo storico errato: Decorrenza maggiore della Scadenza.';
  A000MSG_ERR_PERIODI_INTERSECANTI         = 'Periodi intersecanti!';
  A000MSG_ERR_DATE_INTERS_PERIODI          = 'Impossibile effettuare l''inserimento! Le date specificate intersecano periodi già esistenti!';
  A000MSG_ERR_RAGGR_INTERO_ANNO            = 'Se il raggruppamento è ad anno solare, il periodo deve comprendere un intero anno.';
  A000MSG_ERR_AGGIORNAMENTO_NON_ABIL       = 'Aggiornamento non abilitato!';
  A000MSG_ERR_PERIODO_ERRATO               = 'Il periodo indicato non è corretto';
  A000MSG_ERR_PERIODO_LUNGO                = 'Il periodo indicato è troppo lungo';
  A000MSG_ERR_ELIMINA_PROFILO              = 'Profilo utilizzato, impossibile eliminarlo.';
  A000MSG_ERR_MODIFICA_PROFILO             = 'Profilo utilizzato, impossibile modificarlo.';
  A000MSG_ERR_DECIMALI_GIORNI              = 'E'' ammesso solo .5 come parte decimale dei giorni!';
  A000MSG_ERR_MINUTI                       = 'I minuti devono essere minori di 60!';
  A000MSG_ERR_MINUTI_DIVISORI              = 'I minuti devono essere divisori di 60!';
  A000MSG_ERR_ORA_NON_VALIDA               = 'Formato ora non valido!';
  A000MSG_ERR_FUNZ_NON_ABILITATA           = 'Funzione non abilitata!';
  A000MSG_ERR_FUNZ_NON_ASSEGNATA           = 'Funzione non assegnata!';
  A000MSG_ERR_NO_DIP_INS                   = 'Inserimento impossibile!'#13#10'Nessun dipendente selezionato!';
  A000MSG_ERR_NO_DIP                       = 'Nessun dipendente selezionato!';
  A000MSG_ERR_GENERICO                     = 'Errore imprevisto';
  A000MSG_ERR_GIORNO_MESE                  = 'Giorno e mese non sono corretti!';
  A000MSG_ERR_DATA_ERRATA                  = 'La data e'' errata!';
  A000MSG_ERR_NO_LISTA_GIORNI              = 'Selezionare i giorni di riferimento!';
  A000MSG_ERR_DATE_INVERTITE               = 'Le date devono essere in successione cronologica!';
  A000MSG_ERR_DATE_RIFERIMENTO             = 'Le date di riferimento sono errate!';
  A000MSG_ERR_DATE_INSERITE                = 'Le date inserite non sono corrette.';
  A000MSG_ERR_CODICE_ASS_DUPLICATO         = 'Codice già esistente come causale di assenza!';
  A000MSG_ERR_CODICE_PRES_DUPLICATO        = 'Codice già esistente come causale di presenza!';
  A000MSG_ERR_CODICE_ESISTENTE             = 'Codice già esistente!';
  A000MSG_ERR_GIUST_CANC_NON_TROVATO       = 'Giustificativo da cancellare non trovato.';
  A000MSG_ERR_FRUIZ_INF_VINCOLI            = 'La fruizione è inferiore ai vincoli specificati.';
  A000MSG_ERR_FRUIZ_SUP_VINCOLI            = 'La fruizione è superiore ai vincoli specificati.';
  A000MSG_ERR_FMT_FRUIZ_ARR_VINCOLI        = 'La fruizione non è compatibile col valore di arrotondamento %s.';
  A000MSG_ERR_DECORR_NON_SUCC_SCAD         = 'La decorrenza non può essere successiva alla scadenza!';

  A000MSG_ERR_NO_INSERIMENTO               = 'Inserimento non consentito!';
  A000MSG_ERR_ABIL_ESTERNI                 = 'Attenzione! L''utente utilizzato non è abilitato alla modifica di dipendenti Esterni!';
  A000MSG_ERR_DECORRENZA_INVALIDA          = 'La data di decorrenza deve essere compresa tra il 1900 ed il 3999.';
  A000MSG_ERR_PERCENTUALE                  = 'La percentuale deve assumere valori compresi tra 0 e 100.';
  A000MSG_ERR_PWD_CARATTERI_NON_AMMESSI    = 'La password contiene caratteri non ammessi!';
  A000MSG_ERR_FILE_NON_CREATO              = 'File non creato.';
  A000MSG_ERR_FILE_INESISTENTE             = 'File inesistente';
  A000MSG_ERR_VISUALIZ_FILE                = 'Impossibile visualizzare il file. File inesistente.';
  A000MSG_ERR_FMT_APRI_FILE                = 'Impossibile aprire il file "%s"!';
  A000MSG_ERR_DATO_NON_VALIDO              = 'Dato non valido!';
  A000MSG_ERR_FMT_DATO_NON_VALORIZZATO     = 'Il dato ''%s'' deve essere valorizzato!';
  A000MSG_ERR_FMT_DATO_ELEM_LISTA          = 'Il dato ''%s'' non è valido! Selezionare un elemento dalla lista';
  A000MSG_ERR_DATO_SPAZI                   = 'Dato non valido: ci sono degli spazi!';
  A000MSG_ERR_OPERAZIONE_NON_ESEGUITA      = 'Operazione non eseguita!';
  A000MSG_ERR_DATO_BOOLEAN_ERRATO          = 'I valori consentiti sono S o N.';
  A000MSG_ERR_FUNZIONE_MANCANTE            = 'Funzione mancante!';
  A000MSG_ERR_OPERAZIONE_NON_CONSENTITA    = 'Operazione non consentita!';
  A000MSG_ERR_CREAZIONE_JSON               = 'Errore durante la creazione del JSON';
  A000MSG_ERR_DATA_DECORRENZA              = 'Data decorrenza non valida!';
  A000MSG_ERR_TAB_NON_COMPATIBILE          = 'file pdf inesistente!'#13#10'La stampa può essere vuota o la tabella di salvataggio non è compatibile.';
  A000MSG_ERR_RILEVATORE_DIZIONARIO        = 'Operazione non consentita su timbratura con rilevatore non abilitato';
  A000MSG_ERR_GRID_PENDING                 = 'Esistono Modifiche non confermate sulle griglie. Confermare o annullare i dati su queste prima di proseguire';
  A000MSG_ERR_NO_FILE                      = 'File non indicato!';

  A000MSG_ERR_FMT_ERRORE                   = 'Attenzione! Si è verificato un errore:'#13#10'%s';
  A000MSG_ERR_FMT_CREAZ_DIR                = 'Errore in fase di esportazione: impossibile creare directory "%s"';
  A000MSG_ERR_FMT_ELAB_ANOM                = 'Elaborazione terminata con anomalie: %s';
  A000MSG_ERR_FMT_DUPLICAZIONE             = 'Duplicazione fallita: %s';
  A000MSG_ERR_FMT_TROPPI_ELEM_SEL          = 'E'' possibile selezionare solo %s voce/i!';
  A000MSG_ERR_FMT_POCHI_ELEM_SEL           = 'E'' necessario selezionare almeno %s voce/i!';
  A000MSG_ERR_FMT_CARATTERI_SPECIALI       = '%s contiene caratteri non permessi: correggere!';
  A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO       = 'Il dato "%s" è obbligatorio!';
  A000MSG_ERR_FMT_MAGGIORE_ZERO            = 'La dimensione di "%s" deve essere maggiore di zero!';
  A000MSG_ERR_FMT_DATA_NON_VALIDA          = 'La data %s non è valida!';
  A000MSG_ERR_FMT_VALORE_NON_CORRETTO      = 'Il valore di "%s" non è corretto!';
  A000MSG_ERR_FMT_PERIODO_NON_CORRETTO     = 'Il periodo "%s" non è corretto!';
  A000MSG_ERR_FMT_LUNG_MAX                 = '"%s" può essere lungo al massimo %d caratteri!';
  A000MSG_ERR_FMT_MODIFICHE_FALLITE        = 'Modifiche fallite: %s';
  A000MSG_ERR_FMT_NON_ESISTENTE            = '%s non esistente!';
  A000MSG_ERR_FMT_GIA_ESISTENTE            = '%s già esistente!';
  A000MSG_ERR_FMT_ELEM_LISTA               = '%s non valida! Selezionare un elemento dalla lista';
  A000MSG_ERR_FMT_PWD_LUNGHEZZA            = 'La password deve essere di almeno %d caratteri!';
  A000MSG_ERR_FMT_PWD_MAIUSCOLE            = 'La password deve contenere almeno %d caratteri maiuscoli!';
  A000MSG_ERR_FMT_PWD_CIFRE                = 'La password deve contenere almeno %d cifre!';
  A000MSG_ERR_FMT_PWD_CARATTERI_SPECIALI   = 'La password deve contenere almeno %d caratteri speciali!';
  A000MSG_ERR_FMT_REG_FALLITA              = 'Registrazione fallita!'#13#10'%s';
  A000MSG_ERR_FMT_CAUS_ASS_INESISTENTE     = 'Causale di assenza inesistente: %s';
  A000MSG_ERR_FMT_VALORE_TROPPO_GRANDE     = 'Valore di ''%s'' troppo grande';
  //caption azioni/messagedlg
  A000MSG_MSG_CANCELLA                     = 'Cancella';
  A000MSG_MSG_MODIFICA                     = 'Modifica';
  A000MSG_MSG_ANNULLA                      = 'Annulla';
  A000MSG_MSG_APPLICA                      = 'Applica';
  A000MSG_MSG_INSERISCI                    = 'Inserisci';
  A000MSG_MSG_SALVAFILE                    = 'Salva file';
  A000MSG_MSG_SCHEDAANAGRAFICA             = 'Scheda anagrafica';
  A000MSG_MSG_INVIA                        = 'Invia messaggio';
  A000MSG_MSG_DEFINISCI                    = 'Definisci';
  A000MSG_MSG_REVOCA                       = 'Revoca';
  A000MSG_MSG_CANCELLAPERIODO              = 'Cancella periodo';
  A000MSG_MSG_AGGIORNA                     = 'Aggiorna';
  A000MSG_MSG_DUPLICA                      = 'Duplica';
  A000MSG_MSG_DETTAGLIO                    = 'Dettaglio';
  A000MSG_MSG_AVVISO                       = 'Avviso';
  A000MSG_MSG_ERRORE                       = 'Errore';
  A000MSG_MSG_INFORMAZIONE                 = 'Informazione';
  A000MSG_MSG_CONFERMA                     = 'Conferma';
  A000MSG_MSG_OK                           = 'OK';
  A000MSG_MSG_TERMINA                      = 'Termina';
  A000MSG_MSG_RIPROVA                      = 'Riprova';
  A000MSG_MSG_IGNORA                       = 'Ignora';
  A000MSG_MSG_SI                           = 'Si';
  A000MSG_MSG_NO                           = 'No';
  A000MSG_MSG_TUTTI                        = 'Tutti';
  A000MSG_MSG_SITUTTI                      = 'Si a tutti';
  A000MSG_MSG_NOTUTTI                      = 'No a tutti';
  A000MSG_MSG_DATA                         = 'Data';
  A000MSG_MSG_BLOCCA                       = 'Blocca';
  A000MSG_MSG_SBLOCCA                      = 'Sblocca';
  A000MSG_MSG_IMPORTA                      = 'Importa';

  //Messaggi informativi generici
  A000MSG_MSG_ACCESSO_IN_CORSO             = 'Accesso all''applicativo in corso';
  A000MSG_MSG_FMT_DALAL                    = 'dal %s al %s';
  A000MSG_MSG_ELABORAZIONE                 = 'Elaborazione';
  A000MSG_MSG_ACQUISIZIONE_TERMINATA       = 'Acquisizione terminata';
  A000MSG_MSG_CANCELLAZIONE_AVVENUTA       = 'Cancellazione avvenuta correttamente';
  A000MSG_MSG_SALVATAGGIO_AVVENUTO         = 'Salvataggio avvenuto correttamente';
  A000MSG_MSG_OPERAZIONE_COMPLETATA        = 'Operazione completata.';
  A000MSG_MSG_ELABORAZIONE_IN_CORSO        = 'Elaborazione in corso...';
  A000MSG_MSG_ELABORAZIONE_PDF_IN_CORSO    = 'Creazione del PDF per la stampa in corso...';
  A000MSG_MSG_ELABORAZIONE_XLS_IN_CORSO    = 'Creazione del file XLS in corso...';
  A000MSG_MSG_ELABORAZIONE_INTERROTTA      = 'Elaborazione interrotta dall''utente.';
  A000MSG_MSG_OPERAZIONE_INTERROTTA        = 'Operazione interrotta dall''operatore.';
  A000MSG_MSG_ELABORAZIONE_TERMINATA       = 'Elaborazione terminata';
  A000MSG_MSG_ELABORAZIONE_ANOMALIE        = 'Elaborazione terminata con anomalie.';
  A000MSG_MSG_ELABORAZIONE_SEGNALAZIONI    = 'Elaborazione terminata con segnalazioni.';
  A000MSG_MSG_ELABORAZIONE_STEP_FINALE     = 'Finalizzazione elaborazione';
  A000MSG_MSG_PDF_IN_CORSO                 = 'Creazione PDF in corso....ATTENDERE';
  A000MSG_MSG_MODIFICA_COMPLETATA          = 'Modifica effettuata con successo';
  A000MSG_MSG_ANAGRAFICHE                  = 'anagrafiche';
  A000MSG_MSG_NESSUN_DIP                   = 'Nessun dipendente';
  A000MSG_MSG_TUTTI_I_DIP                  = 'Tutti i dipendenti';
  A000MSG_MSG_OPERAZIONE_ANNULLATA         = 'Operazione annullata';
  A000MSG_MSG_CONTROLLI_IN_CORSO           = 'Controlli in corso...';
  A000MSG_MSG_REGISTRAZIONE_IN_CORSO       = 'Registrazione in corso...';

  A000MSG_MSG_PERIODO_RICHIESTE            = 'Periodo richieste';
  A000MSG_MSG_OGGI                         = 'oggi';
  A000MSG_MSG_IERI                         = 'ieri';
  A000MSG_MSG_DOMANI                       = 'domani';
  A000MSG_MSG_MESE                         = 'mese';
  A000MSG_MSG_ANNO                         = 'anno';
  A000MSG_MSG_DAL                          = 'dal';
  A000MSG_MSG_FINOAL                       = 'fino al';
  A000MSG_MSG_COMPLETO                     = 'completo';
  A000MSG_MSG_MATRICOLA                    = 'matricola';
  A000MSG_MSG_NOMINATIVO                   = 'nominativo';
  A000MSG_MSG_DATA_DECORRENZA              = 'Data di decorrenza';
  A000MSG_MSG_CODICE                       = 'Codice';
  A000MSG_MSG_DESCRIZIONE                  = 'Descrizione';
  A000MSG_MSG_CAUSALE                      = 'Causale';
  A000MSG_MSG_UM                           = 'U.M.';
  A000MSG_MSG_COMPETENZE                   = 'Competenze';
  A000MSG_MSG_RESIDUO                      = 'Residuo';
  A000MSG_MSG_FRUITO                       = 'Fruito';
  A000MSG_MSG_ORE                          = 'Ore';
  A000MSG_MSG_GIORNI                       = 'Giorni';
  A000MSG_MSG_PERIODO_STAMPA               = 'nel periodo di stampa';
  A000MSG_MSG_AL                           = 'al';
  A000MSG_MSG_PERIODO                      = 'periodo';
  A000MSG_MSG_TIPOLOGIA                    = 'tipologia';
  A000MSG_MSG_DATA_INIZIO                  = 'data inizio';
  A000MSG_MSG_DATA_FINE                    = 'data fine';
  A000MSG_MSG_ORA_INIZIO                   = 'ora inizio';
  A000MSG_MSG_ORA_FINE                     = 'ora fine';
  A000MSG_MSG_COD_TARIFFA                  = 'codice tariffa';
  A000MSG_MSG_COD_RIDUZIONE                = 'codice riduzione';
  A000MSG_MSG_PROTOCOLLO                   = 'protocollo';
  A000MSG_MSG_NOME                         = 'Nome';
  A000MSG_MSG_MESE_DA                      = 'Mese Da';
  A000MSG_MSG_MESE_A                       = 'Mese A';
  A000MSG_MSG_DATA_CHIUSURA                = 'Data chiusura';

  A000MSG_MSG_FMT_ELAB_TERMINATA           = 'Elaborazione terminata: %s';
  A000MSG_MSG_LIMITE_HISTORY               = 'Vi sono troppe schede attive.'#13#10'Chiudere quelle inutilizzate per poter aprire nuove schede.';
  A000MSG_MSG_UPLOAD_FALLITO               = 'upload fallito';
  A000MSG_ERR_FMT_DIM_ALLEGATO             = 'La dimensione dell''allegato non può superare'#13#10'il limite di %d MB!'#13#10'(il file selezionato è di %f MB)';

  //messaggi generici usati in IrisWEB
  A000MSG_ERR_DATE_STESSO_ANNO             = 'Le date devono essere riferite allo stesso anno!';
  A000MSG_ERR_DATA_INIZIO_PERIODO_VUOTA    = 'E'' necessario indicare la data di inizio del periodo!';
  A000MSG_ERR_DATA_INIZIO_PERIODO          = 'Indicare una data valida per l''inizio del periodo!';
  A000MSG_ERR_DATA_FINE_PERIODO_VUOTA      = 'E'' necessario indicare la data di fine periodo!';
  A000MSG_ERR_DATA_FINE_PERIODO            = 'Indicare una data valida per la fine del periodo!';
  A000MSG_MSG_NUM_ORE_FRUIZIONE            = 'Specificare il numero di ore di fruizione!';
  A000MSG_MSG_CHIUDI_SCHEDA                = 'Chiudi scheda';
  A000MSG_MSG_DURATA_FRUIZIONE             = 'Specificare la durata della fruizione (Da ore - A ore)!';
  A000MSG_MSG_SPECIFIC_FAMILIARE_RIF       = 'E'' necessario specificare il familiare di riferimento per questa causale!';
  A000MSG_ERR_FMT_CAUS_FAMILIARE           = 'Il familiare specificato non è associato alla causale %s.';
  A000MSG_ERR_FMT_CAUS_FAMILIARE2          = 'Il familiare specificato non è associato alla causale %s alla fine del periodo indicato.'#13#10'Vuoi continuare?';
  A000MSG_ERR_CAUS_FAMILIARE               = 'Familiare di riferimento non valido a fine periodo!';
  A000MSG_ERR_NO_INS_GG_INTERE             = 'Giustificativo non inseribile a giornate intere!';
  A000MSG_ERR_NO_INS_GG_MEZZE              = 'Giustificativo non inseribile a mezze giornate!';
  A000MSG_ERR_NO_INS_HH_NUMERO             = 'Giustificativo non inseribile in numero ore!';
  A000MSG_ERR_NO_INS_HH_DA_A               = 'Giustificativo non inseribile nella forma da ore - a ore!';
  A000MSG_MSG_ANOMALIE_R600                = '<R600> Anomalie rilevate';
  A000MSG_MSG_CONTINUA_ANOM                = 'Inserire il giustificativo nel giorno corrente?';
  A000MSG_ERR_FMT_FRUIZ_ORA_MAG_VINCOLI    = 'La fruizione oraria supera il debito giornaliero riconosciuto nel giorno %s';
  A000MSG_ERR_DATA_RIEP                    = 'Indicare una data valida per il conteggio del riepilogo!';
  A000MSG_ERR_CAUSALE_RIEP                 = 'Indicare una causale valida per il conteggio del riepilogo!';
  A000MSG_MSG_ANAGRA_NON_DISPONIBILE       = 'Anagrafico non disponibile nel periodo indicato!';
  A000MSG_MSG_NESSUNA_RICHIESTA            = 'Nessuna richiesta';
  A000MSG_MSG_NESSUN_ELEMENTO_DA_CANCELLARE= 'Nessun elemento da cancellare';
  A000MSG_MSG_ELAB_OK                      = 'Elaborazione terminata correttamente';
  A000MSG_MSG_ELAB_WARNING                 = 'Elaborazione terminata con avvertimenti'#13#10'%s';
  A000MSG_MSG_ELAB_ERRORE                  = 'Elaborazione terminata con errori';
  A000MSG_MSG_FMT_INIZIOCATENA             = 'Non è possibile inserire un giustificativo con la causale %s.'#13#10'Utilizzare la causale %s';
  A000MSG_MSG_RICERCACOMUNI                = 'Ricerca la città nella tabella dei Comuni';
  A000MSG_MSG_DECORRENZA_INIZIO_MESE       = 'Attenzione: la decorrenza è stata spostata all''inizio del mese specificato!';
  A000MSG_MSG_NO_MINORI_ZERO               = 'Non accetta valori minori di zero';

  //Paginazione medpIWDbGrid
  A000MSG_FMT_PAGIN_COUNT                  = '%d - %d di %d';
  A000MSG_FMT_PAGIN_COUNT_PAG              = 'Pag. %d di %d';
  A000MSG_FMT_PAGIN_COUNT_REC              = 'Record %d - %d di %d';
  A000MSG_PAGIN_PRIMA_PAG                  = 'Prima pagina';
  A000MSG_PAGIN_PRIMO_REC                  = 'Primo record';
  A000MSG_PAGIN_PAG_PREC                   = 'Pagina precedente';
  A000MSG_PAGIN_REC_PREC                   = 'Record precedenti';
  A000MSG_PAGIN_PAG_SUCC                   = 'Pagina successiva';
  A000MSG_PAGIN_REC_SUCC                   = 'Record successivi';
  A000MSG_PAGIN_ULTIMA_PAG                 = 'Ultima pagina';
  A000MSG_PAGIN_ULTIMI_REC                 = 'Ultimi record';

  //messaggi di conferma
  A000MSG_DLG_CANCELLAZIONE                = 'Eliminare il record?';
  A000MSG_DLG_CANCELLAZIONE_MASSIVA        = 'Confermi cancellazione?';
  A000MSG_DLG_STORIC_SUCC                  = 'Esistono delle storicizzazioni successive ma le modifiche verranno applicate solo sulla decorrenza corrente. Confermare?';
  A000MSG_DLG_DECOR_SENZA_STORIC           = 'Attenzione! E'' stata modificata la Decorrenza senza storicizzare. Confermare la modifica?';
  A000MSG_DLG_INSERIMENTO                  = 'Confermi l''inserimento del record?';
  A000MSG_DLG_INSERIMENTO_MASSIVO          = 'Confermi inserimento?';
  A000MSG_DLG_ELAB_ANOMALIE_VIS            = 'Elaborazione terminata con anomalie. Si desidera visualizzarle?';
  A000MSG_DLG_ELAB_SEGNALAZIONI_VIS        = 'Elaborazione terminata con segnalazioni. Si desidera visualizzarle?';
  A000MSG_DLG_INTEROMPERE_OPERAZIONE       = 'Si desidera interrompere l''operazione?';
  A000MSG_DLG_CONFERMA_ELABORAZIONE        = 'Procedere con l''elaborazione?';

  A000MSG_DLG_FMT_ELIMINARE_QUERY          = 'Eliminare la query "%s" ?';

  // messaggi per applicativi web
  A000MSG_MSG_FMT_BROWSER_SUPPORTATO       = 'Il browser attualmente in uso <b>(%s)</b> è pienamente supportato dall''applicativo web';
  A000MSG_ERR_FMT_BROWSER_NON_SUPPORTATO   = 'La versione del browser in uso <b>(%s)</b> è obsoleta e non garantisce le complete funzionalità dell''applicativo.<br>%s supporta i seguenti browser:<br/>%s';

  //messaggi specifici
  A000MSG_A002_ERR_DIP_IN_USO              = 'Dipendente già in uso da altro operatore e/o applicazione: non è possibile allineare i periodi storici.' + #13#10 +
                                             'Chiudere tutte le applicazioni dei vari operatori che interagiscono sul dipendente e riprovare.' ;

  A000MSG_A002_ERR_DEL_UNICA_DECORRENZA    = 'Non è possibile cancellare l''unico periodo storico rimasto per questo dipendente!';
  A000MSG_A002_ERR_DEL_INIZIO_RAPPORTO     = 'Attenzione! Impossibile effettuare la cancellazione.'#13#10'Nel periodo storico successivo l''inizio rapporto è antecedente alla decorrenza!';
  A000MSG_A002_ERR_MATERNITA_VALOR         = 'Inizio Ind.Maternità e Fine Ind.Maternità devono essere entrambe valorizzate o entrambe nulle.';
  A000MSG_A002_ERR_DATE_MATERNITA          = 'Fine Ind.Maternità dev''essere maggiore di Inizio Ind.Maternità.';
  A000MSG_A002_ERR_BADGE_SERVIZIO          = 'Impossibile specificare un''edizione badge BS perchè riservata ai badge di servizio!';

  A000MSG_A002_ERR_FMT_RAPP_INTERSECA      = 'Attenzione!'#13#10'Il periodo di rapporto del %s si interseca con altri periodi.'#13#10'Correggere la situazione.';
  A000MSG_A002_ERR_FMT_PERIODI_INV         = 'Attenzione!'#13#10'Il periodo di rapporto del %s è antecedente ad un altro inserito su di un periodo storico precedente.'#13#10'Correggere la situazione.';
  A000MSG_A002_ERR_FMT_DATE_INCONGR        = 'Attenzione!'#13#10'Nel periodo di servizio %s ci sono incongruenze con data decorrenza e data scadenza dei periodi storici.'#13#10 +
                                             'Il dato viene comunque salvato. Verificare e correggere opportunamente.';
  A000MSG_A002_ERR_FMT_CAMBIO_RAPP         = 'Attenzione!'#13#10'Il tipo rapporto del dipendente è passato da Ruolo a %s';
  A000MSG_A002_ERR_FMT_INT_MAT             = 'Attenzione!'#13#10'Il periodo di maturazione indennità maternità si interseca con i periodi:'#13#10'%s';
  A000MSG_A002_ERR_FMT_INT_MAT_RAPP        = 'Attenzione!'#13#10'Il periodo di maturazione indennità maternità si interseca con i periodi di rapporto:'#13#10'%s';
  A000MSG_A002_ERR_FMT_DEL_STIPENDIALI     = 'Attenzione! Impossibile effettuare la cancellazione.'#13#10 +
                                             'Esistono periodi storici stipendiali intersecanti il periodo dal %s al %s.'#13#10 +
                                             'Per effettuare le modifiche adeguare l''anagrafica stipendiale.';
  A000MSG_A002_ERR_FMT_CERCA_NO_CAMPO      = 'Nessun campo contiene il testo "%s"!';
  A000MSG_A002_ERR_FMT_INIZIO_ANTE         = 'La data di inizio rapporto (%s) non può essere antecedente alla data di decorrenza del primo periodo storico (%s)';

  A000MSG_A002_ERR_FMT_DECOR_FUORI_PER     = 'Attenzione! La decorrenza indicata (%s) è esterna al periodo storico utilizzato.'#13#10 +
                                             'Per effettuare le modifiche posizionarsi sul periodo storico corretto.';
  A000MSG_A002_ERR_FMT_DECOR_PRIMO_PER     = 'Attenzione! La decorrenza modificata (%s) è relativa al primo periodo storico e non può essere successiva al periodo storico stesso.';
  A000MSG_A002_ERR_FMT_DECOR_PRIMO_STIP    = 'Attenzione! La decorrenza modificata (%s) è relativa al primo periodo storico e, esistendo anche un periodo storico stipendiale, non può essere successiva al primo giorno del mese della data di prima assunzione (%s)';
  A000MSG_A002_ERR_FMT_DECOR_PRIMA_ASSUNZ  = 'Attenzione! La decorrenza modificata (%s) è relativa al primo periodo storico e non può essere successiva alla data di prima assunzione (%s)';
  A000MSG_A002_ERR_FMT_STIP_INTERSEC       = 'Attenzione! Esistono periodi storici stipendiali intersecanti il periodo dal %s al %s.'#13#10 +
                                             'Per effettuare le modifiche adeguare l''anagrafica stipendiale.';

  A000MSG_A002_ERR_FMT_BADGE_USATO         = 'Attenzione!'#13#10'Il badge risulta essere assegnato a:'#13#10'%s';

  A000MSG_A002_DLG_DATA_ASSUNZ_POST        = 'La data di assunzione è posteriore a quella di cessazione. Confermare?';
  A000MSG_A002_DLG_MODIFICA_DECOR          = 'Attenzione! E'' stata modificata la Decorrenza senza storicizzare. Confermare la modifica?';
  A000MSG_A002_DLG_FMT_CF_CAMBIATO         = 'Il codice fiscale è cambiato in %s: aggiornarlo automaticamente?';
  A000MSG_A002_DLG_FMT_CF_USATO            = 'Attenzione! Codice fiscale già in uso da: %s. Confermi l''inserimento?';

  A000MSG_A002_DLG_CDC_MANUALE             = 'Attenzione! Si vuole intervenire manualmente sui centri di costo percentualizzati che intersecano il periodo modificato?' + #13#10 +
                                             '<Si> Intervento manuale   <No> Nessun intervento';
  A000MSG_A002_DLG_CDC_AUTOMATICO          = 'Attenzione! Si vuole intervenire automaticamente sui centri di costo percentualizzati che intersecano il periodo modificato?' + #13#10 +
                                             '<Si> Intervento automatico   <No> Intervento manuale   <Annulla> Nessun intervento';

  A000MSG_A002_DLG_FMT_FIELD_SIZE          = 'La selezione effettuata supera la dimensione massima di %d caratteri.'#13#10'Impossibile registrare la selezione!';

  A000MSG_A004_DLG_NUOVO_PERIODO           = 'Trattandosi di nuovo periodo, si desidera comunque coprire i giorni non lavorativi precedenti?';
  A000MSG_A004_DLG_FMT_CONFERMA_DAL_AL     = 'Eseguire %s dal %s al %s?';
  A000MSG_A004_DLG_FMT_CONFERMA_DAL_NUMGG  = 'Eseguire %s dal %s per %d giorni?';
  A000MSG_A004_MSG_RICH_COMPENSATA_REVOCA  = 'La richiesta di giustificativo non è stata considerata'#13#10'poiché compensata da una corrispondente richiesta di revoca.';
  A000MSG_A004_MSG_RICH_COMPENSATA_GIUSTIF = 'La richiesta di revoca non è stata considerata'#13#10'poiché compensata da una corrispondente richiesta di giustificativo.';
  A000MSG_A004_DLG_CERT_PUBBLICA           = 'Attenzione:'#13#10'L''assenza può essere giustificata solo tramite certificazione rilasciata da struttura sanitaria pubblica.'#13#10'Confermare l''inserimento?';
  A000MSG_A004_MSG_NESSUN_GIUST_INSERITO   = 'Nessun giustificativo inserito!';
  A000MSG_A004_DLG_FMT_RIALLINEA           = 'Sono presenti %d giustificativi successivi all''operazione effettuata.'#13#10'Eseguire il riallineamento automatico delle causali concatenate?';
  A000MSG_A004_MSG_NO_CONIUGE              = 'Non esiste nessun genitore non dip. per cui inserire i giustificativi!';
  A000MSG_A004_MSG_NO_FAMILIARE            = 'Non esiste nessun familiare non dip. per cui inserire i giustificativi!';
  A000MSG_A004_MSG_NO_CAUSALE              = 'Selezionare la causale del giustificativo';
  A000MSG_A004_MSG_DAORE_VUOTO             = 'E'' necessario indicare il dato "Da ore / Num. ore"!';
  A000MSG_A004_MSG_DAORE_ERRATO            = 'Il dato "Da ore / Num. ore" è errato!';
  A000MSG_A004_MSG_AORE_VUOTO              = 'E'' necessario indicare il dato "A ore"!';
  A000MSG_A004_MSG_AORE_ERRATO             = 'Il dato "A ore" è errato!';
  A000MSG_A004_MSG_DAORE_AORE_ERRATO       = 'Il periodo "Da ore / A ore" è errato!';
  A000MSG_A004_MSG_RECAPITO_NON_MODIF      = 'La visita è già stata comunicata, il recapito non può essere più modificato.';
  A000MSG_A004_DLG_MED_LEG_AUTOMATICA      = 'La medicina legale non è stata indicata.'#13#10'Si desidera impostarla automaticamente?';
  A000MSG_A004_DLG_FMT_COMUNE_DIFF_MED_LEG = 'Il comune di %s è associato ad una medicina'#13#10'legale differente da quella selezionata.'#13#10'Vuoi continuare?';
  A000MSG_A004_DLG_FMT_SOVRASCRIVI_MED_LEG = 'Sovrascrivere la medicina legale attualmente indicata'#13#10'con quella associata al comune di %s?';
  A000MSG_A004_MSG_PRESENZA_ANOMALIE       = 'Attenzione!'#13#10'Sono state rilevate le seguenti anomalie ((*) se bloccante):';
  A000MSG_A004_MSG_GG_STOP_INS             = 'Inserimento impossibile nel giorno corrente.';
  A000MSG_A004_MSG_ALLINEAMENTO_FALLITO    = 'Fallito l''allineamento della tabella dei giustificativi, verificare la relativa procedura Oracle T040P_ALLINEA_CONGPARENTALI.';
  A000MSG_A004_ERR_GGCONSECUTIVI           = 'Per questa causale non è possibile eseguire l''operazione per più giorni consecutivi';

  A000MSG_A005_ERR_NO_DATI                 = 'Non ci sono dati liberi che l''operatore è autorizzato a gestire';

  A000MSG_A006_ERR_ENTRATA_USCITA          = 'Entrata ed Uscita devono essere in ordine cronologico!';
  A000MSG_A006_ERR_INIZIO_RIENTRO          = 'Inizio e Rientro devono essere in ordine cronologico!';
  A000MSG_A006_ERR_TIPO_ORARIO             = 'Il tipo orario non consente di inserire nuove fasce orarie di questa tipologia!';
  A000MSG_A006_ERR_NUMERO_TURNO            = 'Il numero del turno deve essere compreso tra 0 e 4!';
  A000MSG_A006_ERR_FMT_MODIF_CODICE        = 'Errore in fase di aggiornamento del dataset %s';
  A000MSG_A006_DLG_CONFERMA_REGISTRAZIONE  = 'Attenzione!'#13#10'Le modifiche apportate alle fasce non possono essere propagate sugli storici precedenti/successivi.'#13#10'Confermare la registrazione?';
  A000MSG_A006_DLG_CONFERMA_MODIFICA_COD   = 'Attenzione! La modifica del codice avverrà per tutte le storicizzazioni presenti.'#13#10'Confermare?';
  A000MSG_A006_ERR_FMT_ORDINE_FASCE_MG     = 'Le fasce di mezza giornata del mattino e del pomeriggio'#13#10'non sono in ordine cronologico!'#13#10'Fascia mattino MGM - uscita: %s'#13#10'Fascia pomeriggio MGP - entrata: %s';

  A000MSG_A008_ERR_FMT_CANC_AZIENDA        = 'Cancellazione dell''azienda %s annullata';
  A000MSG_A008_ERR_NO_CANC_AZIN            = 'L''azienda principale AZIN non può essere eliminata.';
  A000MSG_A008_ERR_NO_CANC_AZIENDA_CORR    = 'Non è possibile cancellare l''azienda su cui si è effettuato l''accesso.';
  A000MSG_A008_DLG_FMT_CANC_AZ_TITOLO      = 'Cancellazione azienda %s';
  A000MSG_A008_DLG_FMT_CANC_AZ_PROMPT      = 'E'' stata richiesta l''eliminazione dell''azienda %s.' + #13#10 +
                                             'Questa operazione non è reversibile.' + #13#10 +
                                             'Specificare il nome azienda per proseguire:';
  A000MSG_A008_MSG_FMT_CANC_AZ_AVVISO      = 'L''azienda %s sta per essere definitivamente cancellata. Questa operazione non potrà essere annullata e i dati relativi a questa azienda non potranno essere recuperati.' + #13#10 + 'Si è sicuri di voler procedere?';

  A000MSG_A009_DLG_FMT_DUPLIC              = 'Attenzione: non essendo stato specificato il codice voce speciale, verranno duplicate tutte le voci di pari decorrenza ' + Chr(10) +
                                             'appartenenti al contratto %s con codice voce %s lasciando invariato il codice voce speciale.' + Chr(10) +
                                             'Confermi l''operazione ? ';

  A000MSG_A009_DLG_FMT_ELIM_COMP           = 'Attenzione: dal profilo spariranno le competenze del raggruppamento %s . Continuare?';

  A000MSG_A011_ERR_CODICE_CATASTALE        = 'Il codice catastale deve essere univoco o vuoto!';
  A000MSG_A011_ERR_REGIONE_FISCALE         = 'Con questo codice IRPEF, esiste già una regione non significativa ai soli fini dell''addizionale IRPEF!';

  A000MSG_A012_ERR_NO_PERIODO              = 'Non è stato generato alcun periodo con questo calendario';

  A000MSG_A013_DLG_FMT_CONFERMA_AZIONE     = 'Si è sicuri di voler %s il calendario dal %s al %s';
  A000MSG_A013_ERR_DATA_PATRONO            = 'La data del Santo Patrono e'' errata!';
  A000MSG_A013_ERR_CALENDARIO_NON_GENERATO = 'Non e'' stato generato alcun calendario per questo dipendente';

  A000MSG_A015_MSG_FMT_PLUS_GIA_INSERITO   = 'Plus Orario del %s già inserito';

  A000MSG_A016_ERR_IMPOSSIBILE_CUMULARE    = 'Non si può cumulare a partire dalla causale corrente!';
  A000MSG_A016_ERR_TIPO_CUMULO_R           = 'Il tipo di cumulo R richiede l''attivazione di una modalità di recupero!';
  A000MSG_A016_ERR_NUM_GIORNI              = 'Il numero di giorni indicato deve essere maggiore o uguale a zero!';
  A000MSG_A016_ERR_PERIODO_CAUSALE         = 'E'' necessario specificare la causale del periodo di fruizione!';
  A000MSG_A016_ERR_CAUS_SUCCESSIVA         = 'La Causale successiva non può essere uguale alla Causale corrente!';
  A000MSG_A016_ERR_ARROTONDAMENTO          = 'L''arrotondamento deve essere divisore della fruizione minima!';
  A000MSG_A016_ERR_MAX_PER_LAVORATO        = 'I campi "Max per lavorato < 6h" e "Max per lavorato > 6h" devono essere entrambi valorizzati o entrambi vuoti!';
  A000MSG_A016_ERR_SUP6_MINORE_INF6        = 'Il campo "Max per lavorato < 6h" non può contenere un valore maggiore del campo "Max per lavorato > 6h"!';
  A000MSG_A016_ERR_CODICE_GIUST_DUPLICATO  = 'Codice già esistente come causale di giustificazione!';
  A000MSG_A016_ERR_MASSIMALE               = 'Il Massimale deve essere maggiore di 0!';
  A000MSG_A016_ERR_DURATANULLA             = 'Il campo durata non può essere nullo per il tipo cumulo B.';
  A000MSG_A016_MSG_REGISTRA_STORICO        = 'Attenzione: ai fini economici la variazione dell''indicatore "Registra nello storico" ha effetto solo sulle operazioni effettuate a partire da questo momento: verificare se occorre allineare le registrazioni pregresse';
  A000MSG_A016_MSG_ASSENZE_DA_VALIDARE     = 'Non è possibile deselezionare il campo Richiedi validazione in quanto esistono ancora delle assenze da validare.' + #13#10 +
                                             'Premendo su OK verranno visualizzate.';
  A000MSG_A016_DLG_RICHIEDI_VALIDAZIONE    = 'Attenzione: ai fini economici, l''attivazione di "Richiedi validazione" comporta il NON passaggio diretto sul cedolino delle assenze inserite, che dovranno quindi essere prima "validate". Verificare con l''ufficio stipendi. Si conferma comunque la modifica?' ;

  A000MSG_A016_MSG_NO_CAUSALI_COMP         = '(nessuna causale)';
  A000MSG_A016_MSG_NO_ELIMINA_STOR         = 'Il periodo selezionato è l''unico esistente. Non è possibile eliminarlo.';
  A000MSG_A016_ERR_T230_APERTO             = 'Errore interno: impossibile accedere alla causale. Il dataset non è chiuso.';
  A000MSG_A016_ERR_STORIA_T230             = 'Errore interno durante elaborazione storia dei dati storicizzati: il dataset per la tabella T230 non pronto per l''operazione.';
  A000MSG_A016_ERR_STORIA_GEN              = 'Errore durante l''elaborazione dello storico dati: %s';
  A000MSG_A016_ERR_COPIA_STORIA_NO_REC     = 'Copia fallita, la causale di origine non ha dati storicizzati!';
  A000MSG_A016_ERR_COPIA_STORIA_GEN        = 'Errore durante la copia dei parametri storicizzati: %s';
  A000MSG_A016_ERR_VALORGIOR_ORE_FISSE     = 'E'' necessario specificare le Ore di valorizzazione giornaliera.';

  A000MSG_A020_ERR_FASCIA_AUTORIZZAZIONE   = 'Specificare la fascia di autorizzazione!';
  A000MSG_A020_ERR_VALORI_TIPO_GIORNO      = 'I valori possibili sono: L(lavorativo), NL(non lavorativo), PF(pre-festivo), F(festivo/domenica), FF(solo festivo) e i singoli giorni da 1 a 7';
  A000MSG_A020_ERR_TIPO_GIORNO             = 'Tipo giorno non previsto!';
  A000MSG_A020_ERR_VALORI_AMMESSI_SN       = 'I valori ammessi sono S o N!';
  A000MSG_A020_ERR_FASCE_VOCI_PAGHE        = 'Le fasce orarie delle Voci Paghe specificate non sono corrette!';
  A000MSG_A020_MSG_NO_ELIMINA_STOR         = 'Il periodo selezionato è l''unico esistente. Non è possibile eliminarlo.';
  A000MSG_A020_ERR_STORIA_T235             = 'Errore interno durante elaborazione storia dei dati storicizzati: il dataset per la tabella T235 non pronto per l''operazione.';
  A000MSG_A020_ERR_T235_INCOERENTE         = 'Errore interno durante elaborazione storia dei dati storicizzati: dati incoerenti (la tabella contiene più di un record per il periodo storico specificato.)';
  A000MSG_A020_ERR_STORIA_GEN              = 'Errore durante l''elaborazione dello storico dati: %s';
  A000MSG_A020_ERR_COPIA_STORIA_GEN        = 'Errore durante la copia dei parametri storicizzati: %s';

  A000MSG_A022_ERR_IND_NOTTURNA_ARROT      = 'Indennità notturna:L''arrotondamento deve essere maggiore della tolleranza!';

  A000MSG_A023_DLG_CANC_TIMB               = 'Confermi la cancellazione della timbratura?';

  A000MSG_A023_MSG_FMT_NCAUS               = 'n. %s per la causale %s' + #13#10;
  A000MSG_A023_DLG_IMPORTA_RICH            = 'Confermi l''importazione di tutte le richieste visualizzate?';

  A000MSG_A023_DLG_FMT_RIALLINEA           = 'Sono presenti giustificativi successivi all''operazione effettuata:' + #13#10 +
                                             '%s ' + #13#10 +
                                             'Eseguire il riallineamento automatico delle causali concatenate?';

  A000MSG_A023_ERR_NO_CAUS                 = 'Manca il codice di causale!';
  A000MSG_A023_ERR_CAUS_NO_ELENCO          = 'Selezionare una causale tra quelle presenti in elenco!';
  A000MSG_A023_ERR_DAORE                   = 'Il dato "da ore/num.ore" è errato!';
  A000MSG_A023_ERR_AORE                    = 'Il dato "a ore" è errato!';
  A000MSG_A023_ERR_PERIODO                 = 'Il periodo "da ore/a ore" è errato!';
  A000MSG_A023_ERR_GIUST_NO_ORE            = 'Giustificativo non inseribile in num. ore!';
  A000MSG_A023_ERR_GIUST_NO_DA_A           = 'Giustificativo non inseribile da ore a ore!';
  A000MSG_A023_ERR_GIUST_NO_GIORN          = 'Giustificativo non inseribile a giornate intere!';
  A000MSG_A023_ERR_GIUST_NO_MG             = 'Giustificativo non inseribile a mezze giornate!';
  A000MSG_A023_ERR_GIUST_NO_FAMILIARE      = 'Specificare il familiare di riferimento!';
  A000MSG_A023_ERR_COMANDO_ALLTIMB         = 'Impossibile eseguire il comando';
  A000MSG_A023_ERR_NO_TIMB_DA_SCAMBIARE    = 'Nessuna timbratura da scambiare';
  A000MSG_A023_ERR_MOD_VISITA_FISCALE_N_S  = 'Impossibile modificare il giustificativo indicando una causale legata alla gestione delle visite fiscali!';
  A000MSG_A023_ERR_FMT_MOD_VISITA_FISCALE_S= 'Impossibile modificare un giustificativo legato alla gestione'#13#10'delle visite fiscali.'#13#10'Selezionare la voce di menu "%s" e procedere '#13#10'con la cancellazione e un nuovo inserimento';
  A000MSG_A023_ERR_NO_MOD_GIUST            = 'Per questa causale non è possibile effettuare una modifica diretta.'#13#10'Procedere con la cancellazione e un nuovo inserimento';

  A000MSG_A025_DLG_FMT_TURNO_ERRATO        = 'Il turno %s è errato!';
  A000MSG_A025_DLG_FMT_TURNO_NON_PREVISTO  = 'Il turno %s non è previsto in orario! Sono disponibili %s turni.';
  A000MSG_A025_DLG_FMT_CANCELLAZIONE       = 'Eseguire la cancellazione del periodo dal %s al %s ?';
  A000MSG_A025_DLG_FMT_ACQUISIZ_TURNI      = 'Verranno acquisiti i turni pianificati dal %s al %s per i dipendenti selezionati.'+ #13#10 + 'Continuare?';
  A000MSG_A025_DLG_FMT_ESEGUI_INSERIMENTO  = 'Eseguire l''inserimento nel periodo dal %s al %s ?';
  A000MSG_A025_ERR_PRIMO_TURNO             = 'E'' richiesto il 1° turno da pianificare!';
  A000MSG_A025_ERR_CODICE_ORARIO           = 'E'' richiesto il codice dell''orario da pianificare!';
  A000MSG_A025_ERR_COD_ORARIO_INDENNITA    = 'Sono richiesti o il codice Orario o il codice Indennità!';
  A000MSG_A025_ERR_MOTIV_PIANIF_ORARIO     = 'La Motivazione specificata richiede di pianificare l''orario.';
  A000MSG_A025_ERR_MOTIV_PIANIF            = 'La Motivazione specificata richiede che esista una pianificazione Non Operativa nel giorno pianificato.';
  A000MSG_A025_ERR_COD_INDENNITA           = 'Codice Indennità non valido!';
  A000MSG_A025_ERR_TURNO1                  = '1° turno non valido!';
  A000MSG_A025_ERR_TURNO1EU                = '1° turno E/U non valido!';
  A000MSG_A025_ERR_TURNO2                  = '2° turno non valido!';
  A000MSG_A025_ERR_TURNO2EU                = '2° turno E/U non valido!';
  A000MSG_A025_ERR_COD_ORARIO              = 'Codice Orario non valido!';
  A000MSG_A025_ERR_FMT_COD_NON_VALIDO      = 'Codice %s non valido!';

  A000MSG_A026_DLG_CANCELLA                = 'Attenzione! La cancellazione del dato libero non deve essere interrotta per nessun motivo.' + #13#10 +
                                             'Attendere il termine dell''elaborazione anche se l''applicativo sembra bloccato.' + #13#10 +
                                             'Confermare la cancellazione?';
  A000MSG_A026_DLG_FMT_CANCELLA            = 'Attenzione!'#13#10'Il dato libero è riferito alla funzione %s.' + #13#10 +
                                             'La sua eliminazione comporterà il mancato funzionamento del relativo modulo.' + #13#10 +
                                             'Confermare la cancellazione?';
  A000MSG_A026_DLG_DIMINIZ                 = 'Poichè il campo è stato diminuito, i dati verranno persi: Confermare?';
  A000MSG_A026_DLG_DIMINIZ_DESC            = 'Poichè la dimensione del campo descrizione è stata diminuita, il contenuto di quest''ultima verrà perso: Confermare?';

  A000MSG_A027_MSG_PARAMETRIZZAZIONE       = 'Parametrizzazione';
  A000MSG_A027_ERR_FMT_STAMPA              = 'La parametrizzazione di stampa selezionata include campi di intestazione non validi';
  A000MSG_A027_ERR_DATE_ANNO               = 'Le date devono essere riferite allo stesso anno!';
  A000MSG_A027_ERR_FMT_NON_PRIMA           = 'Non è possibile elaborare il cartellino prima del %s!';
  A000MSG_A027_ERR_FMT_CART_ANTEC          = 'Non è possibile elaborare il cartellino antecedente di %d mesi!';
  A000MSG_A027_ERR_FMT_CART_SUCC           = 'Non è possibile elaborare il cartellino successivo a %d mesi!';
  A000MSG_A027_ERR_NO_CART                 = 'Nessun cartellino disponibile nel periodo specificato!';

  A000MSG_A029_ERR_INDENNITA               = 'Indennità di presenza non valida!';
  A000MSG_A029_ERR_CAUS_PRES               = 'Causale di presenza non valida!';
  A000MSG_A029_ERR_CAUS_ASSESTAMENTO       = 'Specificare la causale di assestamento!';
  A000MSG_A029_ERR_DELETE_LIQUID           = 'Cancellazione impossibile: sono presenti delle liquidazioni!';
  A000MSG_A029_ERR_DELETE_ASSEST           = 'Cancellazione impossibile: sono presenti degli assestamenti!';
  A000MSG_A029_ERR_SCHEDA_PRESENTE         = 'Scheda riepilogativa già esistente!';
  A000MSG_A029_ERR_LIQ_BLOC                = 'Con la liquidazione bloccata per la Banca Ore non è possibile liquidare più della quantità liquidata precedentemente!';
  A000MSG_A029_ERR_STRAORD_EST             = 'Lo straordinario esterno non può superare quello fatto nel mese!';
  A000MSG_A029_ERR_DISP_LIQ                = 'Impossibile liquidare oltre la disponibilità';
  A000MSG_A029_ERR_CONTR_FASCE             = 'Contratto o fasce di maggiorazione non validi!';
  A000MSG_A029_ERR_LIQ_COMPL               = 'La liquidazione complessiva supera la disponibilità!';
  A000MSG_A029_ERR_ORE_LIQ                 = 'Ore da liquidare non corrette!';
  A000MSG_A029_ERR_SUPERO_LIQ              = 'La liquidazione richiesta supera quella disponibile!';
  A000MSG_A029_ERR_FMT_LIQ_FASCIA          = 'La liquidazione in fascia %s supera la disponibilità!';
  A000MSG_A029_ERR_FMT_DISP_ANN            = 'E'' stata superata la disponibilità individuale annuale!' + #13#10 +
                                             '%s >  %s ' + #13#10 +
                                             'Sono ancora disponibili %s ore';
  A000MSG_A029_ERR_FMT_DISP_MENS           = 'E'' stata superata la disponibilità individuale mensile!' + #13#10 +
                                             '%s >  %s ' + #13#10 +
                                             'Sono ancora disponibili %s ore';
  A000MSG_A029_DLG_GEST_BUDGET             = 'Si intende usare la gestione budgetaria per questa liquidazione?';
  A000MSG_A029_DLG_FMT_GEST_BUDGET         = 'Si stanno liquidando %s ore.' + #13#10 +
                                             'Si intende usare la gestione budgetaria per questa liquidazione?';
  A000MSG_A029_DLG_FMT_STR_INSUF           = 'Attenzione!' + #13#10 +
                                             'Straordinario insufficiente: %s';
  A000MSG_A029_ERR_RECORD_AUTOMATICO       = 'Non è consentito intervenire su un record di tipo automatico!';

  A000MSG_A032_DLG_RECUPERARE_FILE         = 'Recuperare i files selezionati?';
  A000MSG_A032_MSG_SCARICO_TERMINATO       = 'Scarico terminato';

  A000MSG_A033_ERR_NO_ANOM_SEL             = 'Nessuna anomalia selezionata!';

  A000MSG_A034_MSG_FORMULA_CORRETTA        = 'Formula corretta!';
  A000MSG_A034_ERR_NO_CODICE_PAGHE         = 'Specificare il codice paghe!';
  A000MSG_A034_ERR_FORMULA_VALORI          = 'La formula inserita estrae più valori! Verificare.';
  A000MSG_A034_ERR_FORMULA_VARIABILE       = 'è stata utilizzata una variabile non valida!';
  A000MSG_A034_ERR_DATA_INIZIO_VALIDITA    = 'Non è possibile indicare una data inizio validità antecedente la data di decorrenza!';
  A000MSG_A034_ERR_DATA_FINE_VALIDITA      = 'Non è possibile indicare una data fine validità antecedente la data di decorrenza!';
  A000MSG_A034_ERR_FMT_FORMULA_ERRORI      = 'La formula inserita contiene errori:'#13#10'%s';
  A000MSG_A034_DLG_ELIMINA_INTERFACCIA     = 'Eliminare l''interfaccia corrente?';

  A000MSG_A035_MSG_ALLINEA                 = 'Attenzione!'#13#10'Le modifiche effettuate, se non allineate con la struttura della tabella,' + #13#10 +
                                             'potrebbero causare errori in fase di elaborazione dati!';
  A000MSG_A035_ERR_FORMULA                 = 'Non è possibile inserire più di una virgola all''interno della formula';
  A000MSG_A035_DLG_PAR_ERR                 = 'Parametri scorretti, salvare ugualmente ?';
  A000MSG_A035_ERR_DARE_AVERE_RIGA         = 'Attenzione! Non è consentito selezionare insieme N. RIGHE DETT. D/A SU STESSA RIGA e N. RIGHE DETT. D/A SU DUE RIGHE.';
  A000MSG_A035_ERR_DATI_DARE_AVERE         = 'Attenzione! I dati IMPORTO e DARE_AVERE non possono essere utilizzati contemporaneamente a SEGNO IMP. DARE, IMPORTO_DARE, SEGNO IMP.AVERE e IMPORTO_AVERE.';
  A000MSG_A035_ERR_IMPORTO_DARE_AVERE      = 'Attenzione! E'' necessario selezionare anche DARE_AVERE se si sceglie IMPORTO.' + #13 +
                                             'In alternativa a DARE_AVERE/IMPORTO è possibile usare IMPORTO_DARE/IMPORTO_AVERE.';

  A000MSG_A037_ERR_BILANCIO                = 'Sono presenti liquidazioni superiori alla disponibilità di bilancio.' + #13#10 +
                                             'Non è possibile elaborare lo scarico alle paghe.';
  A000MSG_A037_ERR_NO_VOCI                 = 'Non è presente nessuna voce paghe!' + #13#10 +
                                             'Riaccedere allo scarico paghe e verificare il filtro voci paghe.';
  A000MSG_A037_ERR_FMT_DATA_CASSA_ANTE     = 'La Data di Cassa non può essere precedente a %s, mese dell''ultimo scarico';
  A000MSG_A037_DLG_FMT_DATA_ANTE_SCARICO   = 'La Data di Cassa (%s) è precedente al mese di scarico (%s). Continuare?';

  A000MSG_A037_ERR_NO_PARAMETRIZZAZIONE    = 'E''necessario selezionare una parametrizzazione' + #13#10+
                                             'per effettuare lo scarico paghe';
  A000MSG_A037_DLG_SCARICO_GIA_PRESENTE    = 'E'' già stato effetuato uno scarico con la Data di Cassa indicata!' + #13#10 +
                                             'Eseguire comunque lo scarico paghe?';
  A000MSG_A037_DLG_ESEGUIRE_SCARICO        = 'Eseguire lo scarico?';
  A000MSG_A037_DLG_SOVRASCRIVERE_FILTRO    = 'Il filtro indicato è già esistente. Si vuole sovrascrivere il vecchio filtro?';
  A000MSG_A037_DLG_FMT_SCARICO_FILTRO      = 'Lo scarico avverrà con il filtro voci: %s';
  A000MSG_A037_DLG_FMT_CREA_DIR            = 'Directory ''%s'' inesistente. Crearla?';
  A000MSG_A037_DLG_FMT_PATH_INESISTENTE    = 'Percorso file ''%s'' inesistente. Impossibile proseguire!';
  A000MSG_A037_DLG_FMT_RIPRISTINA          = 'ATTENZIONE!!'#13#10#13#10 +
                                             'DATI SALVATI PRECEDENTEMENTE:' + #13#10 +
                                             'Tabella Voci Variabili:' + #13#10 +
                                             'Righe: %d' + #13#10 +
                                             'Ultima data di riferimento: %s' + #13#10 +
                                             'Ultima data di cassa: %s' + #13#10 + #13#10 +
                                             'Eseguire il ripristino?' + #13#10;
  A000MSG_A037_DLG_FMT_ELIMINA_CASSA       = 'ATTENZIONE!!' + #13#10 + #13#10 +
                                             'Ultima data di cassa: %s' + #13#10 +
                                             'Voci scaricate riferite al periodo da %s a %s' + #13#10 +
                                             'Righe: %d' + #13#10 +
                                             'Eliminare questi dati dalla tabella delle Voci Variabili?' + #13#10;

  A000MSG_A037_DLG_FMT_SALVA_FILTRO        = 'ATTENZIONE!!' + #13#10 + #13#10 +
                                             'DATI ATTUALI:' + #13#10 +
                                             'Tabella Voci Variabili:' + #13#10 +
                                             'Righe: %d' + #13#10 +
                                             'Ultima data di riferimento: %s' + #13#10 +
                                             'Ultima data di cassa: %s' + #13#10 + #13#10 +
                                             'Eseguire il salvataggio?' + #13#10;
  A000MSG_A037_DLG_FMT_ELIMINA_FILTRO      = 'Eliminare il filtro %s?';

  A000MSG_A039_FMT_ALLINEAMENTO_RIEPILOGHI = 'Attenzione!' + #13#10 +
                                             'Non sarà possibile allineare automaticamente i riepiloghi di reperibilità %s.' + #13#10 +
                                             'Pertanto è necessario rieseguire i cartellini di reperibilità per tutti i dipendenti interessati dal turno modificato, in tutto il periodo di utilizzo.';
  A000MSG_A039_FMT_ALLINEAMENTO_ESEGUITO   = 'Allineamento eseguito %s.' + #13#10 +
                                             'Ricordarsi di eseguire la decodifica della voce paghe tramite l''apposita funzione in <A038> Voci variabili scaricate.';
  A000MSG_A039_DLG_FMT_AGGIORNAMENTO_TURNI = 'Aggiornare anche i seguenti turni con la nuova voce paghe [%s]?' + #13#10 +
                                             ' %s';
  A000MSG_A039_ERR_DURATA_TURNI            = 'Il valore è superiore alla durata effettiva del turno';
  A000MSG_A039_MSG_ALLINEAMENTO_IN_CORSO   = 'Allineamento turni riepilogati...';

  A000MSG_A040_ERR_DATA_ESTERNA_MESE       = 'La data specificata deve essere compresa nel mese di competenza!';
  A000MSG_A040_ERR_FMT_COD_NON_VALIDO      = '%s non valido!';
  A000MSG_A040_ERR_DLG_FMT_NO_RAGGR        = 'Il dipendente non ha raggruppamenti di %s abilitati in data %s!';
  A000MSG_A040_ERR_NO_TURNO_1              = 'E'' necessario specificare il 1° turno!';
  A000MSG_A040_ERR_NO_TURNO_2              = 'Pianificare prima il 2° turno!';
  A000MSG_A040_ERR_FMT_ESISTE_PIANIF       = 'Pianificazione già esistente in data %s!';
  A000MSG_A040_ERR_TURNO_RIPETUTO          = 'Il dipendente non può fare due volte lo stesso turno!';
  A000MSG_A040_DLG_FMT_TURNO_PIANIFICATO   = 'Il turno %s è già stato pianificato il %s per altri dipendenti.' + #13#10 +
                                             'Registrarlo ugualmente?';
  A000MSG_A040_DLG_FMT_TURNO_NON_DISP      = 'In data %s il turno %s non è disponibile nei vincoli di pianificazione';
  A000MSG_A040_DLG_FMT_TURNI_SOVRAPPOSTI   = 'I turni si sovrappongono %s' + #13#10 +
                                             '%s: %s - %s' + #13#10 +
                                             '%s: %s - %s';
  A000MSG_A040_DLG_FMT_CONFIGURAZIONE_KO   = 'Esistono pianificazioni %s configurate non correttamente %s.';
  A000MSG_A040_DLG_FMT_LIMITE_SUPERATO     = 'Il numero massimo di pianificazioni mensili indicato per il turno %s è stato superato.' + #13#10 +
                                             'Turni %s pianificati: %s' + #13#10 +
                                             'Limite turni %s: %d';
  A000MSG_A040_DLG_FMT_LIMITE_SUPERATO_ESCI= #13#10 + #13#10 +
                                             '<Yes> Pianifica in questo caso' + #13#10 +
                                             '<No> Non pianificare in questo caso' + #13#10 +
                                             '<Cancel> Termina elaborazione';
  A000MSG_A040_DLG_FMT_ACQUISIZ_TURNI      = 'Verranno acquisiti i turni pianificati nel mese di %s %s per i dipendenti selezionati.' + #13#10 + 'Continuare?';
  A000MSG_A040_DLG_FMT_CANCELLA_TURNI      = 'Eliminare i turni esistenti nel mese di %s %s per i dipendenti selezionati?';
  A000MSG_A040_DLG_FMT_ESISTE_ASSENZA      = 'Nel giorno %s è presente una giornata di assenza %s.' + #13#10 +
                                             'Pianificare ugualmente?';
  A000MSG_A040_DLG_FMT_ESISTE_ASSENZA_TUTTI= #13#10 + #13#10 +
                                             '<Yes> Pianifica in questo caso' + #13#10 +
                                             '<No> Non pianificare in questo caso' + #13#10 +
                                             '<No to All> Non pianificare in caso di assenza per tutti i successivi dipendenti selezionati' + #13#10 +
                                             '<Yes to All> Pianifica per tutti in caso di assenza per tutti i successivi dipendenti selezionati';
  A000MSG_A040_MSG_FMT_FORZA_TURNO_ASSENZA = 'Nel giorno %s è stato pianificato un turno anche se è presente una giornata di assenza %s.';

  A000MSG_A044_MSG_SCHEDULATO              = 'schedulato';
  A000MSG_A044_MSG_CREATO                  = 'creato';
  A000MSG_A044_MSG_FMT_JOB                 = 'Job %s.';
  A000MSG_A044_ERR_ORA_JOB                 = 'Specificare un orario per la schedulazione giornaliera del job!';
  A000MSG_A044_ERR_JOB_INESISTENTE         = 'Attenzione! Job inesistente!';
  A000MSG_A044_ERR_JOB_NON_CREATO          = 'Attenzione! Job non creato!';
  A000MSG_A044_ERR_DIP_IN_USO              = 'Dipendente già in uso da altro operatore e/o applicazione: non è possibile allineare i periodi storici.' + #13#10 +
                                             'Chiudere tutte le applicazioni dei vari operatori che interagiscono sul dipendente e riprovare.' ;
  A000MSG_A044_DLG_FMT_ESEC_JOB            = 'Job %s. Prossima esecuzione: %s';

  A000MSG_A045_ERR_ORDINE_DATE             = 'La data iniziale non può essere successiva a quella finale.';
  A000MSG_A045_ERR_SELEZ_QUALIFICA         = 'Selezionare almeno una qualifica dalla lista.';
  A000MSG_A045_ERR_CODICI_MANCANTI         = 'Indicare Codice Regione e Codice Azienda!';
  A000MSG_A045_ERR_FILE_ESPORTAZ           = 'Indicare il File di esportazione!';
  A000MSG_A045_ERR_QUALIF_MINISTERIALE_UP20= 'Codice qualifica ministeriale superiore ai 20 caratteri!';
  A000MSG_A045_ERR_QUALIF_MINISTERIALE_UP6 = 'Attenzione: codice qualifica ministeriale superiore ai 6 caratteri!';
  A000MSG_A045_ERR_ASSENZE_NON_CORRISPONDONO='Attenzione: nessuna assenza corrisponde ai filtri di ricerca indicati!';
  A000MSG_A045_DLG_STAMPA_ULTIMA_OPERAZ    = 'Attenzione: la stampa verrà eseguita sull''ultima elaborazione effettuata. Continuare?';
  A000MSG_A045_DLG_ANTEPRIMA_ULTIMA_OPERAZ = 'Attenzione: l''anteprima verrà eseguita sull''ultima elaborazione effettuata. Continuare?';
  A000MSG_A045_DLG_ESPORTAZ_ULTIMA_OPERAZ  = 'Attenzione: l''esportazione verrà eseguita sull''ultima elaborazione effettuata. Continuare?';
  A000MSG_A045_DLG_FMT_SOSTITUZIONE_FILE   = '%s : File già esistente. Sostituire il file?';

  A000MSG_A047_ERR_CAUSALE                 = 'Causale già esistente!';

  A000MSG_A050_ERR_FMT_OROLOGIO_DUPL       = 'Attenzione: esiste già l''orologio %s che ha lo stesso rilevatore!';
  A000MSG_A050_ERR_FMT_SCARICO             = 'Attenzione: specificare lo scarico di riferimento perchè esiste già l''orologio %s che ha lo stesso rilevatore con lo scarico %s !';

  A000MSG_A052_ERR_FMT_CAMPO_PRESENTE      = 'Campo %s già presente!';
  A000MSG_A052_ERR_PENDING                 = 'Attenzione: modifiche pendenti alla struttura della sezione.' + #13#10 +
                                             'Confermare o annullare i dati.';

  A000MSG_A056_ERR_TURNAZIONE              = 'Turnazione non valida!';
  A000MSG_A056_ERR_TURNAZ_INESISTENTE      = 'Turnazione inesistente o non valida!';
  A000MSG_A056_DLG_CANCELLAZIONE           = 'Confermi la cancellazione per tutti i dipendenti selezionati?';
  A000MSG_A056_DLG_INSERIMENTO             = 'Confermi l''assegnazione a tutti i dipendenti selezionati?';
  A000MSG_A056_DLG_ASSEGNAZ_AUTOMATICA     = 'Per i dipendenti selezionati, verranno cancellate le assegnazioni precedenti.' + #13#10 +
                                             'Continuare?';

  A000MSG_A057_DLG_CANCELLAZIONE           = 'Confermi la cancellazione ?';
  A000MSG_A057_ERR_SQUADRA_NON_SPECIFICATA = 'Non è stata specificato la squadra!';
  A000MSG_A057_ERR_ORARIO_NON_SPECIF       = 'Non è stato specificato l''orario!';
  A000MSG_A057_ERR_PIANIF_TURNO_DOPPIO     = 'Non si può pianificare 2 volte lo stesso turno!';
  A000MSG_A057_ERR_PIANIF_SEC_TURNO        = 'Non si può pianificare il secondo turno senza aver pianificato il primo!';
  A000MSG_A057_ERR_TURNO                   = 'Il turno deve essere compreso tra 1 e 99!';

  A000MSG_A058_ERR_PROFILO_ERRATO          = 'Profilo pianificazione inesistente!';
  A000MSG_A058_ERR_PROFILO_MANCANTE        = 'Non è stato selezionato alcun profilo pianificazione!';
  A000MSG_A058_ERR_SQUADRA_MANCANTE        = 'Non è stata selezionata alcuna squadra!';
  A000MSG_A058_ERR_PERIODO                 = 'Il periodo specificato non è valido!';
  A000MSG_A058_ERR_PERIODO_DATE            = 'Le date devono essere riferite allo stesso anno!';
  A000MSG_A058_ERR_REGISTRA_MODIFICHE      = 'Prima di rendere operativa la pianificazione corrente, occorre registrare le modifiche apportate!';
  A000MSG_A058_ERR_NO_PIANIFICAZIONE       = 'Impossibile proseguire nella pianificazione dei dipendenti selezionati.' + #13#10 + 'Nessun valore presente nella maschera ''<A056> Assegnazione turnazioni'' per il dipendente %s.';  
  A000MSG_A058_DLG_RENDI_OPERATIVA         = 'ATTENZIONE!' + #13#10 +
                                             'I dati relativi alla pianificazione operativa di tutti i dipendenti visualizzati saranno sovrascritti dai dati della pianificazione corrente.' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_DLG_CANC_PIANIF_PROG        = 'ATTENZIONE!' + #13#10 +
                                             'Verranno cancellati i dati di pianificazione di tutti i dipendenti visualizzati per la pianificazione operativa e non operativa.' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_DLG_CANC_PIANIF             = 'ATTENZIONE!' + #13#10 +
                                             'Verranno cancellati i dati di pianificazione di tutti i dipendenti visualizzati' + #13#10 +
                                             'Confermare l''operazione ?';
  A000MSG_A058_DLG_REG_PIANIF              = 'ATTENZIONE!' + #13#10 +
                                             'I dati di pianificazione saranno registrati anche sulla pianificazione iniziale e su quella corrente, sovrascrivendo eventuali altre informazioni già presenti e riferite al periodo ed ai dipendenti visualizzati.' + #13#10 +
                                             'Confermare l''operazione ?';											 
  A000MSG_A058_DLG_MODIFICHE_NON_SALVATE   = 'Le modifiche apportate non sono state salvate!' + #13#10 +
                                             'Proseguire nell''operazione?';
  A000MSG_A058_DLG_FMT_PIANIF_ESISTENTE    = 'La pianificazione esiste già per i seguenti dipendenti:' + #13#10 + '%s' + #13#10 +
                                             'La creazione di una nuova pianificazione non eliminerà quella esistente.' + #13#10 +
                                             'Continuare?';
  A000MSG_A058_MSG_FMT_COPIA_IN_CORSO      = 'Copia della pianificazione in corso: %s';

  A000MSG_A059_ERR_SQUADRE                 = 'Le squadre devono essere specificate in ordine alfabetico!';
  A000MSG_A059_ERR_SQUADRA_MANCANTE        = 'Non sono state specificate entrambe le squadre!';

  A000MSG_A060_DLG_FMT_ELIMINA_TIMBRATURE  = 'Attenzione!' + #13#10 +
                                             'Eliminare timbrature dal %s al %s ?';

  A000MSG_A061_ERR_SELEZIONE_MANCANTE      = 'Selezionare "Stampa dati individuali" o "Totali generali".';
  A000MSG_A061_ERR_CAUSALE                 = 'Nessuna causale selezionata';
  A000MSG_A061_MSG_INIZIO_REGISTRAZIONE    = 'Inizio registrazione:';
  A000MSG_A061_MSG_FINE_REGISTRAZIONE      = 'Fine registrazione:';
  A000MSG_A061_MSG_DALLA_DATA              = 'Dalla data:';
  A000MSG_A061_MSG_ALLA_DATA               = 'Alla data:';

  A000MSG_A062_DLG_FMT_QUERY_ESISTENTE     = 'Attenzione! La tabella T921%s è già esistente e verrà ricreata.' + #13#10 +
                                             'I dati contenuti nella tabella precedente andranno persi. Continuare?';
  A000MSG_A062_MSG_FMT_DATI_REGISTRATI     = 'I dati sono stati registrati nella tabella T921%s .';
  A000MSG_A062_MSG_QUERY_ESISTENTE         = 'Query già esistente!! Sovrascrivere?';
  A000MSG_A062_ERR_NOME_QUERY_MANCANTE     = 'Inserire il nome della query da salvare';
  A000MSG_A062_ERR_ACCESSO_NEGATO          = 'Accesso negato';
  A000MSG_A062_ERR_SCRIPT_INVALIDO         = 'Script non valido!';
  A000MSG_A062_ERR_QUERY_ESISTENTE         = 'Impossibile salvare %s!'#13#10'Esiste già una query con lo stesso nome!';
  A000MSG_A062_ERR_QUERY_NON_IN_LISTA      = 'Impossibile caricare %s!'#13#10'La query specificata non è presente nella lista di quelle disponibili per l''utente!';

  A000MSG_A063_ERR_PERIODO_CALCOLO_FRUITO  = 'Impostare correttamente il periodo per il calcolo del fruito!';
  A000MSG_A063_ERR_PERIODO_RIPORTO_RESIDUO = 'Impostare correttamente il periodo per il riporto del residuo!';
  A000MSG_A063_ERR_NO_BUDGET               = 'Selezionare almeno un budget di straordinario!';
  A000MSG_A063_ERR_ANNO_DUPLICAZIONE       = 'Selezionare un anno di duplicazione differente!';
  A000MSG_A063_DLG_ASSEGNA_BUDGET          = 'Attenzione! Proseguire con la sovrascrittura del budget mensile per i gruppi selezionati?';
  A000MSG_A063_DLG_CALCOLA_E_RIPORTA       = 'Attenzione! Proseguire con il riallineamento del fruito mensile e con il riporto del residuo sui mesi successivi per i gruppi selezionati?';
  A000MSG_A063_DLG_CALCOLA_FRUITO          = 'Attenzione! Proseguire con il riallineamento del fruito mensile per i gruppi selezionati?';
  A000MSG_A063_DLG_RIPORTA_RESIDUO         = 'Attenzione! Proseguire con il riporto del residuo sui mesi successivi per i gruppi selezionati?';
  A000MSG_A063_DLG_FMT_CONTROLLO_FA        = 'Attenzione! L''operazione potrebbe richiedere diversi minuti. Proseguire con il controllo della sovrapposizione dei filtri anagrafe dell''anno %s?';
  A000MSG_A063_DLG_FMT_DUPLICA_GRUPPI      = 'Attenzione! Proseguire con la duplicazione dei gruppi selezionati sull''anno %s?';
  A000MSG_A063_MSG_FMT_GRUPPO              = 'Cod. gruppo: %s, Tipo: %s, Periodo: %s. ';
  A000MSG_A063_ERR_NO_TROV_BUDGET          = 'Budget di straordinario non trovato';
  A000MSG_A063_ERR_FMT_MESE_ESTERNO        = 'Il mese di riferimento (%s) non è compreso nel periodo';
  A000MSG_A063_ERR_BUDGET_ESISTE           = 'Budget di straordinario già esistente nel periodo';
  A000MSG_A063_ERR_FMT_BUDGET_ESISTE_PERIODO = 'Budget di straordinario già esistente con Tipo: %s ma con Periodo: %s-%s';
  A000MSG_A063_ERR_INSERIMENTO             = 'Inserimento fallito';
  A000MSG_A063_ERR_FMT_DIP_2_GRUPPI        = 'Dipendente presente contemporaneamente in 2 gruppi: %s e %s dal %s al %s';

  A000MSG_A064_ERR_PERIODO                 = 'Impostare correttamente il periodo!';

  A000MSG_A067_ERR_NO_CAUSALE              = 'Non è stata specificata la causale correttiva!';

  A000MSG_A071_ERR_DATO_NON_SPECIF         = 'Dato non specificato!';

  A000MSG_A074_ERR_CAMPO_RIFERIMENTO       = 'Non è specificato il campo di riferimento sui parametri aziendali!';
  A000MSG_A074_ERR_PWD_FILE                = 'Password errata, impossibile creare il file sequenziale!';
  A000MSG_A074_ERR_PARAMETRIZZAZIONE       = 'Specificare una parametrizzazione valida o disattivare l''opzione ''Genera file per acquisto ticket''!';
  A000MSG_A074_ERR_FMT_CREATE_FILE         = 'Impossibile creare il file %s';
  A000MSG_A074_DLG_FILE_SEQUENZIALE        = 'Attenzione!' + #13#10 +
                                             'Si consigia di utilizzare l''opzione ''Genera file per acquisto ticket'' scegliendo la parametrizzazione ''A074'''+ #13#10 +
                                             'in quanto l''opzione ''Genera file sequenziale'' verrà dismessa nelle prossime versioni.' + #13#10 + #13#10 +
                                             'Per informazioni a riguardo chiedere al servizio di assistenza.' + #13#10 + #13#10 +
                                             'Continuare comunque con l''opzione ''Genera file sequenziale''?';
  A000MSG_A074_DLG_DISAB_AGGIORNAMENTO     = 'ATTENZIONE!' + #13#10 + #13#10 +
                                             'Poichè è stato richiesto l''elaborazione di un mese precedente' + #13#10 +
                                             'ad altri acquisti effettuati, l''aggiornameto sarà disabilitato.' + #13#10 + #13#10 +
                                             'Proseguire comunque?';
  A000MSG_A074_DLG_FMT_ELIMINA_ACQUISTO    = 'ATTENZIONE!' + #13#10 +
                                             'Sono presenti %d movimenti di acquisto relativi al mese di %s' + #13#10 +
                                             'Eliminarli?';


  A000MSG_A077_ERR_TAB_NON_COMPATIBILE         = 'file pdf inesistente!'#13#10'La stampa può essere vuota o la tabella di salvataggio non è compatibile.';
  A000MSG_A077_PARAM_STAMPA_NON_DISPONIB       = 'Stampa non disponibile: %s';

  A000MSG_A080_ERR_ORDINE_SERBATOI         = 'Specificare esattamente l''ordine di prelievo dai serbatoi!';
  A000MSG_A080_ERR_TIPI_APPLICAZIONE       = 'Le impostazioni dei tipi applicazione dei limiti mensili dell''eccedenza liquidabile e residuabile sono incompatibili!';
  A000MSG_A080_ERR_RESID_INFERIORE_LIMITE  = 'Il limite ore residuabili non può essere inferiore al minore dei limiti dell''anno prec. e dell''anno corr.!';
  A000MSG_A080_ERR_RESID_SUPERIORE_LIMITE  = 'Il limite ore residuabili non può essere superiore alla somma dei limiti dell''anno prec. e dell''anno corr.!';
  A000MSG_A080_DLG_NO_SALDI_MOBILI         = 'Attenzione!' + #13 +
                                             'Specificando più di un mese come riferimento al recupero del debito sulle paghe, è necessario attivare i Saldi Mobili.' + #13 +
                                             'Non facendolo, l''addebito sul mese di Gennaio sarà sempre riferito a Dicembre.' + #13 +
                                             'Confermare comunque?';
  A000MSG_A080_ERR_FMT_CAUS_COMP           = 'Le causali %s sono usate per compensare il saldo negativo mensile e annuale.';

  A000MSG_A082_DLG_RIPRISTINO              = 'Verrà ripristinata l''ultima situazione corretta rilevata dal sistema. Vuoi procedere?';
  A000MSG_A082_DLG_FMT_COPIA               = 'I centri di costo del dipendente %s %s ,' + #13#10 +
                                             'alla data di lavoro %s, verranno riportati sugli altri dipendenti selezionati.' + #13#10 +
                                             'Eventuali storicizzazioni esistenti verranno sovrascritte.' + #13#10 +
                                             'Proseguire l''operazione?';
  A000MSG_A082_ERR_NO_CDC                  = 'Non è specificato il campo Centro di costo percentualizzato in Gestione Aziende!';
  A000MSG_A082_ERR_FMT_ANOMALIE_PENDING    = 'Attenzione! La situazione attuale non è valida. Correggerla prima di abbandonarla%s!';
  A000MSG_A082_ERR_FMT_ANOMALIE_PENDING2   = ', eventualmente ripristinando la situazione corretta precedente tramite l''apposito pulsante';


  A000MSG_A082_ERR_FMT_PERIODI             = 'Attenzione! Sono state rilevate le seguenti anomalie.'#13#10#13#10'%s';

  A000MSG_A086_ERR_TIPO                    = 'Indicare il tipo di motivazione';
  A000MSG_A086_ERR_FMT_TIPO_VALORE         = 'Il tipo indicato non è valido: %s';
  A000MSG_A086_ERR_CODICE_DEFAULT          = 'Indicare S oppure N per il dato default';
  A000MSG_A086_ERR_CODICE_DEFAULT_MULT     = 'Impossibile attribuire più di un default!';

  A000MSG_A087_MSG_VISUALIZZA_FILE         = '<A087> Visualizzazione file di importazione XML';
  A000MSG_A087_MSG_IMPORT_TERMINATA        = 'Importazione terminata correttamente.';
  A000MSG_A087_MSG_ANOMALIE_BLOCCANTI      = 'Importazione terminata con anomalie bloccanti.';
  A000MSG_A087_MSG_ANOMALIE_NON_BLOCCANTI  = 'Importazione terminata correttamente con anomalie non bloccanti.';
  A000MSG_A087_MSG_NO_ANOMALIE             = 'Non sono state riscontrate anomalie.';
  A000MSG_A087_MSG_PERIODO_MAL_CANC_SI     = 'Periodo di malattia cancellato correttamente.';
  A000MSG_A087_MSG_PERIODO_MAL_CANC_NO     = 'Errore nella cancellazione del periodo di malattia.';
  A000MSG_A087_MSG_PERIODO_ANNULLATO       =  '%s periodo annullato correttamente';
  A000MSG_A087_MSG_CAPTION_ELENCO_COMUNI   = '<A087> Selezione del comune reperibilità';
  A000MSG_A087_MSG_DADATA                  = 'Dalla data:';
  A000MSG_A087_MSG_DIP_ESCLUSI             = 'Dipendenti esclusi dalla selezione';
  A000MSG_A087_MSG_NO_DIP_SELEZIONATI      = 'Nessun dipendente selezionato!';
  A000MSG_A087_MSG_NO_DATA_INI_NULLA       = 'La data di inizio malattia non può essere nulla!';
  A000MSG_A087_MSG_NO_DATA_FINE_NULLA      = 'La data di fine malattia non può essere nulla!';
  A000MSG_A087_MSG_DATA_INI_NON_VALIDA     = 'Data inizio malattia non valida!';
  A000MSG_A087_MSG_DATA_FINE_NON_VALIDA    = 'Data fine malattia non valida!';
  A000MSG_A087_MSG_PERIODO_INSERITO        = 'Periodo inserito correttamente';
  A000MSG_A087_MSG_PERIODO_ANNUNLLATO      = ': giustificativo annullato correttamente';
  A000MSG_A087_MSG_GIUSTIF_INSERITO        = '%s : giustificativo inserito correttamente';
  A000MSG_A087_MSG_IMPORT_TXT_TERMINATA    = 'Importazione file terminata senza anomalie.';
  A000MSG_A087_MSG_NO_CAUS_ASSOCIATA       = 'Nessuna causale associata per questo dipendente.';
  A000MSG_A087_MSG_NO_PROFILI_ABILITATI    = 'Non ci sono profili abilitati per questo dipendente!';
  A000MSG_A087_MSG_MATRICOLA_NON_TROVATA   = 'Matricola non trovata in anagrafico.';
  A000MSG_A087_MSG_TIMESTAMP_GIA_INSERITO  = 'Periodo dal %s al %s: comunicazione di malattia già registrata in precedenza.';
  A000MSG_A087_MSG_CDTSTXTFILE_CHIUSO      = 'CDtsTXTFile non attivo o vuoto.';
  A000MSG_A087_MSG_ANOMALIA_BLOCCANTE      = 'Anomalia bloccante: %s';
  A000MSG_A087_MSG_ANOMALIA_NON_BLOCCANTE  = 'Anomalia non bloccante: %s';
  A000MSG_A087_MSG_CODFISCALE_NON_TROVATO  = 'Codice fiscale del dipendente %s non trovato';
  A000MSG_A087_MSG_DIP_NON_SERVIZIO        = 'Dipendente non in servizio alla data %s';
  A000MSG_A087_MSG_DIP_NON_ASSOCIATO       = 'Dipendente non appartenente a nessun profilo.';
  A000MSG_A087_MSG_CODFISCALE_DOPPIO       = 'Codice fiscale %s associato a più di un dipendente in servizio alla data %s';
  A000MSG_A087_MSG_CAUS_NON_TROVATE        = 'Causali di assenza non trovate per il certificato numero %s';
  A000MSG_A087_MSG_PERIDO_GIA_INSERITO     = 'Periodo già inserito da un precedente certificato.';
  A000MSG_A087_MSG_GIUSTIF_RETT            = ': giustificativo rettificato correttamente.';
  A000MSG_A087_MSG_COMUNE_RES_NON_TROVATO  = '%s comune di residenza non trovato';
  A000MSG_A087_MSG_COMUNE_REP_NON_TROVATO  = '%s comune di reperibilità non trovato';
  A000MSG_A087_MSG_PERIODO_MAG_10GG        = 'Periodo di malattia superiore ai 10 giorni.';
  A000MSG_A087_MSG_CAUS_RIC_NON_INS        = 'Causale di ricovero non inserita.';
  A000MSG_A087_MSG_ID_ANNULL_NON_TROVATO   = 'Certificato numero %s da annullare non trovato';
  A000MSG_A087_MSG_ID_RETT_NON_TROVATO     = 'Certificato numero %s da rettificare non trovato';
  A000MSG_A087_MSG_PERIODO_RETTIFICATO     = '%s periodo rettificato correttamente.';
  A000MSG_A087_ERR_CAUS_SV_NON_SELEZIONATA = '%s Causale salvavita non selezionata!';
  A000MSG_A087_ERR_CAUS_SRV_NON_SEL        = '%s Causale di servizio non selezionata!';
  A000MSG_A087_ERR_CERT_DATA_INIZIO        = 'Certificato numero %s con data inizio malattia %s non valida';
  A000MSG_A087_ERR_CERT_DATA_FINE          = 'Certificato numero %s con data fine malattia %s non valida';
  A000MSG_A087_ERR_ID_INIZIO_MAGG_FINE     = 'Certificato numero %s con data inizio malattia successiva alla data fine malattia';
  A000MSG_A087_ERR_DIMISSIONI_1            = '%s La data inizio del certificato di dimissioni"%s" è diversa dalla data di ricovero.';
  A000MSG_A087_ERR_ESECUZIONE_QUERY        = 'Errore nell''esecuzione filtro %s: %s';
  A000MSG_A087_ERR_IMPORT_TXT_TERMINATA    = 'Sono state riscontrate anomalie durante l''importazione';
  A000MSG_A087_ERR_OPZIONI_1               = 'Impossibile selezionare più di un''opzione tra: Ricovero\Post-ricovero, Agevolazioni e Particolari cause di malattia.';
  A000MSG_A087_ERR_OPZIONI_2               = 'Impossibile specificare %s se la comunicazione è avvenuta per via telefonica.';
  A000MSG_A087_ERR_PROTOCOLLO_NULL_1       = 'Impossibile specificare Numero protocollo nullo se Data rilascio e/o Data consegna sono valorizzati.';
  A000MSG_A087_ERR_PROTOCOLLO_NULL_2       = 'Impossibile specificare Numero protocollo nullo se tipo comunicazione è uguale a Certificato medico e Data rilascio e/o Data consegna non sono valorizzati.';
  A000MSG_A087_ERR_PROTOCOLLO_NULL_3       = 'Attenzione non è possibile inserire più di 3 gioni senza numero di protocollo.';
  A000MSG_A087_ERR_CONSEGNA_NON_VALIDA     = 'Data di consegna non valida!';
  A000MSG_A087_ERR_RILASCIO_MIN_INIZIO     = 'La Data di di rilascio deve essere maggiore o uguale alla data di inizio malattia.';
  A000MSG_A087_ERR_CONSEGNA_MIN_RILASCIO   = 'La Data di consegna deve essere maggiore o uguale alla data di rilascio.';
  A000MSG_A087_ERR_RILASCIO_NON_VALIDO     = 'Data di rilascio non valida!';
  A000MSG_A087_ERR_FINE_MINORE_INIZIO      = 'La data fine malattia non può essere inferiore alla data di inizio!';
  A000MSG_A087_ERR_ANOMALIE_BLOCCANTI      = 'Sono state riscontrate anomalie bloccanti.';
  A000MSG_A087_ERR_ANOMALIE_NON_BLOCCANTI  = 'Sono state riscontrate anomalie non bloccanti.';
  A000MSG_A087_ERR_FMT_FILTROPROFILI       = 'E'' necessario attivare il profilo corretto: contattare il servizio di assistenza di %s.';
  A000MSG_A087_ERR_CONVERSIONE_DATA        = 'Errore conversione data!';
  A000MSG_A087_DLG_DIP_ESCLUSI             = 'Alcuni dipendenti sono esclusi dalla selezione.'#13#10'Visualizzarli?';
  A000MSG_A087_DLG_FMT_CAUSALE_DIVERSA     = 'Causale di malattia %s diversa dall''ultima causale utilizzata: %s' + #13#10 +
                                             'Continuare?';
  A000MSG_A087_DLG_CANCELLA_CAUSALE        = 'Verrà cancellato il periodo dal %s al %s per il dipendente %s %s.'#13#10'Continuare?';

  A000MSG_A088_ERR_FMT_DEL_CAT0            = 'La cancellazione della categoria %s non è consentita!';
  A000MSG_A088_ERR_FMT_DUP_CAT0            = 'La duplicazione della categoria %s non è consentita!';
  A000MSG_A088_ERR_FMT_DEL_CAT             = 'La categoria %s contiene dei dati.'#13#10'E'' necessario eliminarli prima di poter procedere con la cancellazione';
  A000MSG_A088_MSG_MOTIVAZIONE             = 'La motivazione selezionata è utilizzata';
  A000MSG_A088_MSG_IPOTESI                 = 'L''ipotesi selezionata è utilizzata';
  A000MSG_A088_MSG_DATO_LIBERO             = 'Il dato libero selezionato è utilizzato';
  A000MSG_A088_ERR_CODICE_CAT_NULLO        = 'Il codice della categoria non può essere nullo!';
  A000MSG_A088_ERR_FMT_DESC_CAT_NULLA      = 'La descrizione della categoria con codice %s non può essere nulla!';
  A000MSG_A088_ERR_CODICE_NULLO            = 'Il codice del dato libero non può essere nullo!';
  A000MSG_A088_ERR_FMT_DESC_NULLA          = 'La descrizione del dato con codice %s non può essere nulla!';
  A000MSG_A088_ERR_FMT_VALORI              = 'La lista di valori del dato %s'#13#10'deve contenere almeno due elementi separati da virgola!';
  A000MSG_A088_ERR_FMT_OBBLIGATORIO        = 'Indicare se il dato %s è obbligatorio (S), oppure no (N)';
  A000MSG_A088_ERR_FMT_FORMATO             = 'Selezionare il formato del dato %s:'#13#10'- S = stringa'#13#10'- N = numero'#13#10'- D = data (gg/mm/aaaa)';
  A000MSG_A088_ERR_FMT_RIGHE               = 'Indicare il numero di righe per il dato %s'#13#10'scegliendo un valore compreso fra 1 e 9';
  A000MSG_A088_ERR_FMT_LUNG_MAX            = 'Indicare una lunghezza max per il dato %s'#13#10'scegliendo un valore compreso fra 0 e 9999';
  A000MSG_A088_ERR_FMT_SELEZIONE_VALORI    = 'Per il dato %s'#13#10'è possibile indicare un solo valore fra:'#13#10'- %s'#13#10'- %s'#13#10'- %s';
  A000MSG_A088_ERR_FMT_ELENCO_FISSO        = 'Per il dato %s'#13#10'indicare il valore di Elenco fisso, scegliendo:'#13#10'- S se la scelta è limitata ai valori in elenco'#13#10'- N altrimenti';
  A000MSG_A088_ERR_CATEGORIA               = 'Indicare la categoria';
  A000MSG_A088_ERR_CATEGORIA_EDIT          = 'La modifica dei dati di questa categoria non è consentita!';
  A000MSG_A088_ERR_FMT_ORDINE              = 'La categoria %s deve avere un ordine maggiore o uguale a 1!';
  A000MSG_A088_ERR_FMT_DELETE              = '%s nelle richieste'#13#10 +
                                             'di trasferta effettuate dall''applicativo IrisWeb.'#13#10 +
                                             'Cancellazione impossibile!';
  A000MSG_A088_ERR_FMT_LIMITE_FASE_NULL    = 'Il dato %s'#13#10'della categoria %s'#13#10'non può essere nullo!';

  A000MSG_A089_ERR_TIPO_NON_DISPONIBILE    = 'Tipo non disponibile!';
  A000MSG_A089_ERR_PROP_TURNI_PCT          = 'La proporzione dei turni è espressa in percentuale!';
  A000MSG_A089_ERR_FMT_LEGAME_INDENNITA    = 'Impossibile stabilire un legame tra l''indennità corrente e l''indennità ''%s'' poichè si verrebbe a creare un ciclo ricorsivo!';

  A000MSG_A091_ERR_NO_CAUSALE              = 'Causale non specificata!';
  A000MSG_A091_ERR_ANNO                    = 'Anno non valido!';
  A000MSG_A091_ERR_MESE                    = 'Mese non valido!';
  A000MSG_A091_ERR_TROPPE_CAUSALI          = 'Selezionare solo una causale!';
  A000MSG_A091_DLG_NO_LIQUIDAZIONI         = 'Non esistono liquidazioni per i dipendenti selezionati';
  A000MSG_A091_DLG_FMT_ANNULLA_LIQ         = 'Verranno alterati i riepiloghi di %s per i dipendenti selezionati';

  A000MSG_A094_ERR_DATA                    = 'Anno o mese errati';
  A000MSG_A094_ERR_DATA_DECOR              = 'Sono ammesse date di decorrenza solo del primo gennaio di ogni anno';
  A000MSG_A094_ERR_CAMPO                   = 'Deve essere inserito il campo';
  A000MSG_A094_ERR_FMT_CAUSALE_BANCAORE    = 'La causale ''%s'' deve avere Banca ore = ''%s''';
  A000MSG_A094_ERR_FMT_BANCAORE            = 'Se Banca ore = ''S'' è possibile inserire solo la causale ''%s''';
  A000MSG_A094_ERR_FMT_NON_IN_ELENCO       = 'Valore di %s non tra quelli presenti in elenco';
  A000MSG_A094_ERR_TIPO_LIMITE_ERRATO      = 'Tipo limite può solo assumere i valori L o R.';
  A000MSG_A094_ERR_RAGGR_ANNO              = 'Ragguppamento non definito per l''anno indicato';

  A000MSG_A095_ERR_NO_LIQ                  = 'Non esistono liquidazioni per i dipendenti selezionati';
  A000MSG_A095_DLG_FMT_ANNULLA_LIQ         = 'Verranno alterati i riepiloghi di %s per i dipendenti selezionati. Continuare?';

  A000MSG_A096_ERR_CAUSALE_INESISTENTE     = 'Causale inesistente';
  A000MSG_A096_ERR_FMT_INTERSEZIONE        = 'Nel giorno %s la pianificazione %s-%s ne interseca una già esistente (%s %s-%s)!';

  A000MSG_A097_ERR_CAUSALE_INESISTENTE     = 'Causale inesistente';
  A000MSG_A097_ERR_DATA_ESTERNA            = 'La data deve essere interna al periodo di visualizzazione indicato!';
  A000MSG_A097_ERR_FMT_INTERSEZIONE        = 'Nel giorno %s la pianificazione %s-%s ne interseca una già esistente (%s %s-%s)!';
  A000MSG_A097_ERR_PERIODO_LUNGO           = 'Il periodo può essere al massimo di cinque anni';
  A000MSG_A097_ERR_PROFILO_NON_VALIDO      = 'Profilo non valido!';
  A000MSG_A097_DLG_FMT_CONFERMA            = 'Confermi %s dei turni di libera professione per tutti i dipendenti selezionati dal %s al %s?';

  A000MSG_A099_DLG_FMT_ESEGUI              = 'Eseguire il comando ''%s'' per tutte le tabelle selezionate?';
  A000MSG_A099_DLG_SCONSIGLIATA            = 'ATTENZIONE! Questa operazione è sconsigliata!'#13#10'Continuare comunque?';
  A000MSG_A099_MSG_INDICI                  = 'E'' necessario effettuare subito il rebuild degi indici per le tabelle spostate!';
  A000MSG_A099_DLG_FMT_DB                  = 'Eseguire il comando ''%s'' per il database %s?';

  A000MSG_A100_ERR_RIMBORSA                = 'La colonna ''Rimborsa'' ammette i valori ''S'' o ''N''.';
  A000MSG_A100_ERR_NO_DATA_RIMB            = 'Indicare la data del rimborso.';
  A000MSG_A100_ERR_DATA_RIMB_ANTE          = 'La data del rimborso non può essere precedente alla data di inzio missione.';
  A000MSG_A100_ERR_DATA_RIMB_POST          = 'La data del rimborso non può essere successiva alla data di fine missione.';
  A000MSG_A100_ERR_NO_MOD_PAG              = 'Indicare la modalità di pagamento.';
  A000MSG_A100_ERR_NO_IMP_RIMB             = 'Indicare l''importo del rimborso.';
  A000MSG_A100_ERR_IMP_RIMB_NEG            = 'L''importo del rimborso deve essere un valore positivo.';
  A000MSG_A100_ERR_FLAG_NO_RIMB_SOMMA      = 'Questa tipologia di codice rimborso non ammette ''Rimborsare'' uguale a ''S''';
  A000MSG_A100_ERR_FLAG_NO_RIMB_ZERO       = 'Questa tipologia di codice rimborso non ammette ''Imp. Rimb. (C)'' diversi da zero';
  A000MSG_A100_ERR_COD_RIMB_NO_ESISTE      = 'Il codice rimborso inserito non esiste nella tabella rimborsi.';
  A000MSG_A100_ERR_COD_RIMB_GIA_INS        = 'Codice rimborso già inserito!';
  A000MSG_A100_ERR_COD_VALUTA              = 'Il codice della valuta è errato!';
  A000MSG_A100_ERR_COEFF_CAMBIO            = 'Impossibile convertire l''importo, manca il coefficente di cambio!';
  A000MSG_A100_ERR_DATE_TRASFERTA_MESE_ANNO= 'Le date di trasferta devono appartenere allo stesso mese ed anno.';
  A000MSG_A100_ERR_INTERVALLO_DATE         = 'L''intervallo di date non è corretto.';
  A000MSG_A100_ERR_INTERVALLO_ORE          = 'L''intervallo di ore non è corretto.';
  A000MSG_A100_ERR_DATI_NON_SIGNIFICATIVI  = 'I dati inseriti non sono significativi!';
  A000MSG_A100_ERR_COD_RIMB_NON_ABIL       = 'Codice rimborso non abilitato per questa regola missione!';
  A000MSG_A100_ERR_DATA_DETT               = 'La data indicata per il dettaglio non è valida!';
  A000MSG_A100_ERR_DATA_DETT_MISSIONE      = 'La data indicata per il dettaglio deve essere compresa nel periodo della missione!';
  A000MSG_A100_ERR_NO_TIPO_DETT_MISSIONE   = 'Indicare il tipo di dettaglio!';
  A000MSG_A100_ERR_TIPO_DETT_MISSIONE      = 'Il tipo di dettaglio indicato non è valido!'#13#10'Indicare S (servizio attivo) oppure V (ore viaggio)';
  A000MSG_A100_ERR_TIPO_DETT_MISSIONE_1GG  = 'Non è consentito indicare ore di viaggio per una missione di un giorno solo!';
  A000MSG_A100_ERR_ORA_INIZIO_ATTIVITA     = 'L''ora di inizio dell''attività è precedente all''ora di inizio della missione!';
  A000MSG_A100_ERR_ORA_FINE_ATTIVITA       = 'L''ora di fine dell''attività è successiva all''ora di fine della missione!';
  A000MSG_A100_ERR_NO_DATA_ATTIVITA        = 'Indicare la data dell''attività!';
  A000MSG_A100_ERR_NO_ORA_INIZIO_ATTIVITA  = 'Indicare l''ora di inizio dell''attività!';
  A000MSG_A100_ERR_NO_ORA_FINE_ATTIVITA    = 'Indicare l''ora di fine dell''attività!';
  A000MSG_A100_ERR_PERIODO_ATTIVITA        = 'Il periodo dell''attività non è corretto!';
  //A000MSG_A100_ERR_NOTE_ATTIVITA           = 'Indicare le note dell''attività';
  A000MSG_A100_ERR_DETT_SCAGLIONI          = 'Impossibile dettagliare il riborso pasto, se la regola prevede gli scaglioni cumulativi.';
  A000MSG_A100_ERR_DETT_NO_CODICE          = 'Indicare il codice del rimborso.';
  A000MSG_A100_ERR_DETT_ANTICIPO           = 'Non è possibile dettagliare un anticipo.';
  A000MSG_A100_ERR_DETT_IMP_RIMB           = 'Cancellare l''importo del rimborso prima di procedere al dettaglio.';
  A000MSG_A100_ERR_CANC_DETT               = 'Non è possibile eliminare l''elemento selezionato in quanto è stato generato dal programma';
  A000MSG_A100_ERR_MOD_DETT                = 'Non è possibile modificare l''elemento selezionato in quanto è stato generato dal programma';
  A000MSG_A100_ERR_TRASFERTA_PRESENTE      = 'Impossibile confermare l''operazione: esiste già una trasferta riferita al dipendente in oggetto con mese competenza, data ed ora inizio uguali a quelli indicati.';
  A000MSG_A100_ERR_DATA_MISS_SUCC          = 'Attenzione!' + #13#10 +
                                             'La data missione è successiva al mese di scarico, continuare nell''inserimento?';
  A000MSG_A100_ERR_INS_TRASFERTA           = 'Inserimento impossibile!!!' + #13#10 +
                                             'Esiste già una trasferta riferita al dipendente in oggetto con mese scarico, mese competenza, data inizio ed ora inizio uguali a quelli della missione che si sta tentando di inserire.';
  A000MSG_A100_ERR_REGOLE_TRASFERTA        = 'Regole trasferte non specificate nella maschera <A008> Gestione Aziende.';
  A000MSG_A100_ERR_KM_AUTOR_NEG            = 'Il numero di km autorizzati non può essere negativo!';
  A000MSG_A100_ERR_IMP_AUTOR_NEG           = 'L''importo autorizzato non può essere negativo!';
  A000MSG_A100_ERR_STATO_RIMBORSO          = 'Lo stato indicato non è valido.' + #13#10 +
                                             'Indicare S per confermare il rimborso.';
  A000MSG_A100_ERR_PAG_DEBIT               = 'Non è possibile eliminare la modalità di pagamento selezionata poichè è utilizzata dal programma.';
  A000MSG_A100_MSG_ANOMALIE                = 'Sono state riscontrate delle anomalie in fase di gestione automatica del giustificativo!';
  A000MSG_A100_MSG_IMP_RICALC              = 'L''importo relativo all''indennità di trasferta è stato ricalcolato in funzione della riduzione relativa al rimborso pasto.';
  A000MSG_A100_MSG_IMP_RICALC_CANC         = 'L''importo relativo all''indennità di trasferta è stato ricalcolato in funzione della cancellazione del rimborso pasto.';
  A000MSG_A100_ERR_FMT_REGOLE              = 'Regole non trovate per il dipendente e la tipologia di trasferta selezionati alla data %s.';
  A000MSG_A100_ERR_FMT_PERIODO_ATT_INTERS  = 'Il periodo dell''attività indicato interseca'#13#10'un periodo già esistente [%s]';
  A000MSG_A100_ERR_PERIODO_ATT_DIVERSE     = 'Non è consentito inserire dettagli di servizio attivo'#13#10'e di viaggio nello stesso giorno!';
  A000MSG_A100_MSG_FMT_TRASFERTA_COMPRESA  = 'Esiste già %s trasferta/e comprese nel periodo indicato.'#13#10'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_COMPRENDE = 'Esiste già %s trasferta/e che comprende il periodo indicato.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_PERIODO   = 'Esiste già %s trasferta/e per il periodo indicato.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_PERIODO_PARZ = 'Esiste già %s trasferta/e che comprende in parte il periodo indicato.' + #13#10 +
                                               'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_DATA      = 'Esiste %s trasferta/e che inizia in data %s e termina in data %s.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_TERMINA   = 'Esiste già una trasferta che termina in data %s.' + #13#10 +
                                             'Si desidera continuare ugualmente?';
  A000MSG_A100_MSG_FMT_TRASFERTA_INIZIA    = 'Esiste già una trasferta che inizia in data %s.' + #13#10 +
                                             'Si desidera continuare ugualmente?';

  A000MSG_A100_MSG_COLLEGA_ANTICIPI        = 'Collegare la missione con questi Anticipi?' + #13#10#13#10;
  A000MSG_A100_MSG_FMT_ANTICIPO_COLL       = 'Codice: %s, Importo: $s €' + #13#10 +
                                             '------------------------------------------' + #13#10;
  A000MSG_A100_MSG_FMT_ANT_REGOLA          = 'L''Anticipo ''%s'' non può essere collegato con questa missione,' + #13#10 +
                                             'poichè la regola assegnata alla missione non lo permette.' + #13#10;
  A000MSG_A100_MSG_FMT_VOCE_NO_RIMB        = 'Cod. Voce: %s' +  #13#10 +
                                             'non è registrato come rimborso.' + #13#10 +
                                             '------------------------------------------' + #13#10;
  A000MSG_A100_MSG_ANT_GIA_INS             = 'Anticipo già inserito:' + #13#10#13#10;
  A000MSG_A100_MSG_FMT_SOSP                = 'Numero sospeso: %s, Data Missione: %s, Importo: %s €' + #13#10 +
                                             '------------------------------------------' + #13#10;

  A000MSG_A100_MSG_FMT_RICALCOLO           = 'Saranno ricalcolate le indennità chilometriche di tutte le missioni riferite ai dipendenti selezionati e con mese di scarico compreso tra: %s e %s.' + #13#10 +
                                             'Si desidera continuare ?';

  A000MSG_A100_MSG_KM_AUTOR                = 'Il numero di km autorizzati è maggiore di quello richiesto.' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_A100_MSG_IMP_AUTOR               = 'L''importo del rimborso autorizzato è maggiore di quello richiesto.' + #13#10 +
                                             'Vuoi continuare?';

  A000MSG_A100_MSG_NO_RIAPERTURE           = 'Nessuna informazione disponibile sulla riapertura della richiesta. Questa richiesta potrebbe non essere mai stata riaperta oppure non sono presenti dati sulle tabelle di log.';

  A000MSG_A104_ERR_NO_TRASF                = 'Nessuna trasferta trovata nel periodo indicato per i dipendenti selezionati.';

  A000MSG_A105_ERR_NO_CAUSALE              = 'Nessuna causale selezionata';

  A000MSG_A106_MSG_PARTENZA                = 'Località partenza';
  A000MSG_A106_MSG_DESTINAZIONE            = 'Località destinazione';
  A000MSG_A106_ERR_DUPLICAZIONE            = 'Inserimento non consentito.' + #13#10 +
                                             'Distanza chilometrica già esistente.';
  A000MSG_A106_ERR_CHILOMETRI              = 'Indicare una distanza chilometrica valida';
  A000MSG_A106_ERR_LOCALITA                = 'Indicare una destinazione diversa dalla partenza';

  A000MSG_A108_ERR_MESE                    = 'Il mese specificato non è corretto!';
  A000MSG_A108_ERR_FMT_INSERIMENTO         = '%s  %s';
  A000MSG_A108_ERR_FMT_ORE_SCOPERTE        = '%s  %s ore scoperte';

  A000MSG_A109_MSG_IMMAGINE_NON_VALIDA     = 'Attenzione! Il formato dell''immagine selezionata non è valido.' + #13#10 +
                                             'E'' possibile selezionare solo immagini bmp (bitmap).';
  A000MSG_A109_MSG_ELIMINA_IMG             = 'Eliminare l''immagine corrente?';

  A000MSG_A110_MSG_CODICE                  = 'Codice';
  A000MSG_A110_MSG_TIPO_MISSIONE           = 'Tipo missione';
  A000MSG_A110_MSG_DESC_REGOLA             = 'Descrizione regola';
  A000MSG_A110_MSG_TAR_IND_INT             = 'Tariffa di indennità intera';
  A000MSG_A110_MSG_ORE_MIN_IND             = 'Ore minime di indennità intera';
  A000MSG_A110_MSG_TIPO_TAR_IND_INT        = 'Tipo tariffa di indennità intera';
  A000MSG_A110_MSG_TIPO_ARR_ORE            = 'Tipo arrotondamento ore';
  A000MSG_A110_MSG_ARR_TOT_ORE             = 'Arrotondamento totale importi per dati paghe';
  A000MSG_A110_MSG_ARR_TAR_RID             = 'Arrotondamento tariffa dopo riduzione';
  A000MSG_A110_MSG_ORE_RETR_INT            = 'Limite delle ore retribuite intere';
  A000MSG_A110_MSG_LIM_GG_RET_MESE         = 'Limite dei giorni retribuiti interi nel mese;';
  A000MSG_A110_MSG_PERC_RIMB_PASTO         = 'Percentuale di retribuzione al rimborso del pasto';
  A000MSG_A110_MSG_PERC_SUP_ORE            = 'Percentuale di retribuzione dopo il supero ore';
  A000MSG_A110_MSG_PERC_SUP_GG             = 'Percentuale di retribuzione dopo il supero giorni';
  A000MSG_A110_MSG_SELEZIONATO             = 'Selezionato';
  A000MSG_A110_DLG_ALTRE_REGOLE            = 'Confermando l''operazione sui mesi di rimborso, si andranno a modificare ' + #13#10 +
                                             'anche le altre regole con la medesima data di decorrenza e codice missione.';
  A000MSG_A110_DLG_FMT_INTERSEC_DECORRENZA = 'Attenzione! La data decorrenza inserita interseca il periodo %s - %s.' + #13#10 +
                                             'Continuare?';
  A000MSG_A110_ERR_24H                     = 'Attenzione! Non è possbile inserire una soglia superiore alle 24 ore.';
  A000MSG_A110_ERR_INCOMPLETI              = 'Dati incompleti.';
  A000MSG_A110_ERR_ARROT_ORE               = 'Indicare un valore maggiore o uguale ad 1 per il campo arrotondamento ore!';
  A000MSG_A110_ERR_ARROT_ORE_DIV           = 'Il valore per l''arrotondamento dell'' ora deve essere maggiore o uguale a 1 o un divisore di 60.';
  A000MSG_A110_ERR_NOT_ASSIGNED            = 'Funzione lettura data decorrenza non impostata';
  A000MSG_A110_ERR_IND_KM                  = 'Indicare il codice di indennità km se si attiva il rimborso chilometrico automatico';

  A000MSG_A111_ERR_NO_DV                   = 'Impossibile specificare record DF senza record DV!';
  A000MSG_A111_ERR_FILTRO_ANAGRAFICO       = 'Filtro anagrafico non valido!';
  A000MSG_A111_ERR_CAMBIO_NUM_RECORD_DF    = 'Per il tipo record DF il numero record non può cambiare';
  A000MSG_A111_ERR_NUM_RECORD              = 'Numero record specificato invalido';
  A000MSG_A111_ERR_RECORD_ACCAVALLATI      = 'Posizione/Lunghezza invalidi (record DV accavallato a record DF)';
  A000MSG_A111_ERR_NOME_COLONNA_DUPLICATO  = 'Nome colonna non valido (duplicato)!';
  A000MSG_A111_ERR_INCONGRUENZA_DV_DF      = 'Incongruenza su colonne tra record DV e record DF!';
  A000MSG_A111_ERR_NOME_CAMPO_DUPLICATO    = 'Nomi campi non univoci';
  A000MSG_A111_ERR_CAMPI_ACCAVALLATI       = 'Posizione/Lunghezza invalidi (campi che si accavallano)';
  A000MSG_A111_ERR_CAMPI_NON_CONTIGUI      = 'Campi non contigui!';
  A000MSG_A111_ERR_AGG_CODICE              = 'AGGIORNAMENTO CODICE IN PARAMETRIZZAZIONE FALLITO';
  A000MSG_A111_ERR_TIPO_COLONNA_RECORD     = 'Tipo colonna specificato non valido per questo tipo record!';
  A000MSG_A111_ERR_LUNGHEZZA_DIVERSA       = 'Lunghezza specificata diversa dalla lunghezza del Formato!';
  A000MSG_A111_ERR_LUNGHEZZA_MINORE        = 'Lunghezza specificata minore della lunghezza del Default!';
  A000MSG_A111_ERR_TIPO_RECORD_FILE        = 'Tipo Record non valido per questo tipo di file!';
  A000MSG_A111_ERR_TIPO_RECORD             = 'Tipo Record non valido!';
  A000MSG_A111_ERR_TIPO_COLONNA            = 'Tipo Colonna non valido!';
  A000MSG_A111_ERR_POSIZIONE               = 'Posizione non valida!';
  A000MSG_A111_ERR_LUNGHEZZA               = 'Lunghezza non valida!';
  A000MSG_A111_ERR_NOME_COLONNA            = 'Nome colonna non valido!';
  A000MSG_A111_ERR_FORMATO                 = 'Formato non valido per questo tipo colonna!';
  A000MSG_A111_ERR_NO_FORMATO              = 'Colonna senza Formato specificato!';
  A000MSG_A111_ERR_SVUOTA_FORMATO          = 'Per questo tipo colonna il Formato non deve essere specificato!';
  A000MSG_A111_ERR_NO_DEFAULT              = 'Nei file elaborabili in batch per questo tipo colonna il Default deve essere specificato!';
  A000MSG_A111_ERR_DEFAULT                 = 'Valore di default non valido per questo tipo colonna!';
  A000MSG_A111_ERR_SVUOTA_DEFAULT          = 'Per questo tipo colonna il valore di Default non deve essere specificato!';

  A000MSG_A112_DLG_NO_ANAGRAFICHE          = 'ATTENZIONE: Nessuna anagrafica selezionata! Continuare?';
  A000MSG_A112_ERR_NO_SELEZIONE            = 'ATTENZIONE: Nessuna selezione disponibile!';
  A000MSG_A112_DLG_FMT_ESEGUI              = 'Eseguire l''elaborazione per %s anagrafiche?';
  A000MSG_A112_DLG_SOVRASCRIVI_MSG         = 'Attenzione: messaggio già esistente per la matricola selezionata! Sovrascrivere il messaggio?';
  A000MSG_A112_ERR_DEFAULT                 = 'Valore specificato non valido: scegliere tra la lista dei valori possibili!';
  A000MSG_A112_ERR_FMT_CARATTERI           = 'Il numero di caratteri disponibili è %s!';

  A000MSG_A116_ERR_ANNO_RIF_PREC           = 'L''anno di riferimento deve essere l''anno precedente o due anni precedenti rispetto alla data di liquidazione!';
  A000MSG_A116_DLG_FMT_CANCELLA            = 'Sei sicuro di voler procedere alla cancellazione delle liquidazioni/abbattimenti ore residue riferite all''anno %s effettuate a %s?';

  A000MSG_A117_ERR_ANNO_RIF_PREC           = 'L''anno di riferimento deve essere l''anno precedente o due anni precedenti rispetto alla data di liquidazione!';
  A000MSG_A117_ERR_ANNO_RIF_SUCC           = 'L''anno di riferimento deve essere antecedente all''anno della data di liquidazione!';
  A000MSG_A117_ERR_VARIAZ_ORE              = 'La variazione delle ore perse può essere solo negativa!';
  A000MSG_A117_ERR_LIQ_GIA_REGISTRATA      = 'Liquidazione già registrata; agire su diverso anno di riferimento o mese di liquidazione!';
  A000MSG_A117_ERR_NO_TIPOLOGIA            = 'Selezionare almeno una tipologia di trasferta!';

  A000MSG_A119_ERR_DATA_OBBL               = 'E'' necessario specificare la data';
  A000MSG_A119_ERR_FMT_DATA_ESISTENTE      = 'In archivio è già presente un altro evento'#13#10'di sciopero per il giorno %s.'#13#10'Impossibile confermare!';
  A000MSG_A119_ERR_DAORE_OBBL              = 'E'' necessario specificare il dato "da ore"';
  A000MSG_A119_ERR_AORE_OBBL               = 'E'' necessario specificare il dato "a ore"';
  A000MSG_A119_ERR_FMT_SELANAGRAFE         = 'La selezione anagrafica indicata non è valida:'#13#10'%s';
  A000MSG_A119_ERR_FMT_CAUS_TIPOFRUIZ      = 'La causale selezionata "%s" non è fruibile %s';
  A000MSG_A119_ERR_CANC                    = 'Sono presenti schede di notifica di adesione'#13#10'per l''evento di sciopero selezionato.'#13#10'Cancellazione impossibile!';
  A000MSG_A119_ERR_MOD                     = 'Sono presenti schede di notifica di adesione'#13#10'per l''evento di sciopero selezionato.'#13#10'Modifica impossibile!';
  A000MSG_A119_ERR_FMT_BLOCCO_RIEP         = 'Attenzione!'#13#10'Non è possibile effettuare l''importazione dei giustificativi,'#13#10'in quanto per i seguenti dipendenti è attivo il blocco'#13#10'dei riepiloghi [T040] per il mese di %s:'#13#10'%s';
  A000MSG_A119_ERR_FMT_TIPO_RICH           = 'Errore durante la lettura del tipo richiesta per ID = %d';

  A000MSG_A121_DLG_CANCELLA_PARTECIPANTI   = 'Attenzione: verranno cancellati anche partecipazioni e permessi dell''organismo selezionato! ' +  #13#10 +
                                             'Confermi cancellazione?';
  A000MSG_A121_DLG_CANCELLA_RECAPITI       = 'Attenzione: verranno cancellati anche recapiti, competenze, iscrizioni, partecipazioni e permessi del sindacato selezionato! ' + #13#10 +
                                             'Confermi cancellazione?';

  A000MSG_A122_ERR_COD_SINDACATO           = 'Codice sindacato non valido!';

  A000MSG_A123_ERR_COD_SINDACATO           = 'Codice sindacato non valido!';
  A000MSG_A123_ERR_COD_ORGANISMO           = 'Codice organismo non valido!';

  A000MSG_A124_MSG_NO_COMP_CONTRATTO       = 'Comp. non specificate sul contratto del dip.corrente!';
  A000MSG_A124_ERR_FMT_PERM_CANCELLATO     = 'Impossibile %s un permesso CANCELLATO!';
  A000MSG_A124_ERR_NO_DALLE                = 'Specificare il dato "Dalle ore"!';
  A000MSG_A124_ERR_NO_ALLE                 = 'Specificare il dato "Alle ore"!';
  A000MSG_A124_ERR_NO_DALLE_ALLE           = 'Specificare l''intervallo "Dalle ore" / "Alle ore"!';
  A000MSG_A124_ERR_NO_ORE                  = 'Specificare le "Ore" di permesso!';
  A000MSG_A124_ERR_NO_SINDACATO            = 'Specificare il "Sindacato"!';
  A000MSG_A124_ERR_NO_ORGANISMO            = 'Specificare l''"Organismo"!';
  A000MSG_A124_ERR_NO_NUM_PROTOCOLLO       = 'Specificare il numero protocollo!';
  A000MSG_A124_ERR_ALLE_MAGGIORE_DALLE     = '"Alle ore" deve essere superiore a "Dalle ore"!';
  A000MSG_A124_DLG_FMT_INS_PERMESSO        = 'Confermi l''inserimento del permesso per i dipendenti selezionati (%s)?';
  A000MSG_A124_MSG_FMT_PERMESSI_INSERITI   = 'Elaborazione terminata: sono stati inseriti %s permessi!';
  A000MSG_A124_DLG_FMT_STATO_CANC_PERMESSO = 'Confermi il passaggio allo stato CANCELLATO del permesso per i dipendenti selezionati (%s)?';
  A000MSG_A124_MSG_FMT_PERMESSI_STATO_CANC = 'Elaborazione terminata: sono stati aggiornati allo stato CANCELLATO %s permessi!';
  A000MSG_A124_DLG_FMT_CANC_PERMESSO       = 'Confermi la cancellazione del permesso per i dipendenti selezionati (%s)?';
  A000MSG_A124_MSG_FMT_PERMESSI_CANCELLATI = 'Elaborazione terminata: sono stati cancellati %s permessi!';
  A000MSG_A124_MSG_ANOMALIE                = 'Attenzione: sono state riscontrate delle anomalie durante l''elaborazione!' + #13#10 + '(Premere il pulsante Anomalie per visualizzarle)';
  A000MSG_A124_ERR_FMT_SINDACATO_NO_CAUS   = 'Il sindacato %s non è associato ad alcuna causale di assenza!';
  A000MSG_A124_ERR_COMP_SUPERATE           = 'Sono state superate le competenze del sindacato!';
  A000MSG_A124_ERR_INSERIMENTO             = 'Inserimento impossibile';
  A000MSG_A124_ERR_PERMESSO_ESISTE         = 'permesso già esistente alla data indicata!';
  A000MSG_A124_ERR_PERMESSO_INTERSECA      = 'intersezione con permesso già esistente!';

  A000MSG_A126_ERR_NO_RIEPILOGO            = 'Nessun riepilogo selezionato';
  A000MSG_A126_ERR_DATA_CASSA_ANTE         = 'Non si può utilizzare una data di cassa antecedente a quella effettiva!';
  A000MSG_A126_DLG_CASSA_SUCCESSIVA        = 'Selezionare la data di cassa successiva?';
  A000MSG_A126_DLG_CASSA_PRECEDENTE        = 'Selezionare la data di cassa antecedente?';
  A000MSG_A126_DLG_ANNULLA_CASSA           = 'ATTENZIONE!' + #13#10 +
                                             'Annullando la data di cassa utilizzata' + #13#10 +
                                             'sarà possibile modificarla direttamente in fase di Scarico Paghe.' + #13#10 +
                                             'Annullare la data di cassa?';
  A000MSG_A126_DLG_FMT_BLOCCO              = 'ATTENZIONE!' + #13#10 + #13#10 +
                                             'Verranno bloccati i riepiloghi specificati per tutti i dipendenti selezionati.' + #13#10 +
                                             'Al termine dell''operazione non sarà più possibile modificare i dati.' + #13#10 +
                                             'I record da inserire sono %s' + #13#10 +
                                             'Continuare?';
  A000MSG_A126_DLG_FMT_SBLOCCO             = 'ATTENZIONE!' + #13#10 + #13#10 +
                                             'Verranno sbloccati i riepiloghi specificati per tutti i dipendenti selezionati.' + #13#10 +
                                             'Al termine dell''operazione sarà nuovamente possibile modificare i dati.' + #13#10 +
                                             'I record da cancellare sono %s' + #13#10 +
                                             'Continuare?';
  A000MSG_A126_DLG_FMT_ELIMINA_DATA_CASSA  ='ATTENZIONE!!' + #13#10 + #13#10 +
                                            'Ultima data di cassa: %s' + #13#10 +
                                            'Voci scaricate riferite al periodo da %s a %s' + #13#10 +
                                            'Righe: %d' + #13#10 +
                                            'Eliminare questi dati dalla tabella delle Voci Variabili?' + #13#10;

  A000MSG_A128_ERR_DATA_ESTERNA_MESE       = 'La data specificata deve essere compresa nel mese di competenza!';
  A000MSG_A128_ERR_FMT_COD_NON_VALIDO      = '%s non valido!';
  A000MSG_A128_ERR_NO_TURNO_1              = 'E'' necessario specificare il 1° turno!';
  A000MSG_A128_ERR_ESISTE_PIANIFICAZIONE   = 'Pianificazione già esistente!';
  A000MSG_A128_ERR_TURNO_RIPETUTO          = 'Il dipendente non può fare due volte lo stesso turno!';
  A000MSG_A128_DLG_TURNO_NO_PARTTIME       = 'Confermi la pianificazione di un turno incompatibile con dipendente part-time?';
  A000MSG_A128_ERR_FMT_PATH_ERRATO         = 'Il percorso del file di acquisizione dei turni di prestazioni aggiuntive %s non è corretto o il file è inesistente.';
  A000MSG_A128_ERR_CREA_FILE_APPOGGIO      = 'Impossibile creare il file di appoggio!';
  A000MSG_A128_ERR_CREA_FILE_BACKUP        = 'Impossibile creare il file di salvataggio!';
  A000MSG_A128_ERR_FMT_DATO_ERRATO         = 'Dato non numerico o a zero nella colonna numero %s. Correggere.';
  A000MSG_A128_ERR_FMT_POSIZIONE_ERRATA    = 'La posizione nella colonna numero %s non è consecutiva alla definizione della colonna precedente. Correggere.';
  A000MSG_A128_ERR_FMT_ACQ_NO_MATRICOLA    = 'Riga n. %s : %s - Matricola non indicata.';
  A000MSG_A128_ERR_FMT_ACQ_NO_FMT_DATA     = 'Riga n. %s : %s - Formato della data errato.';
  A000MSG_A128_ERR_FMT_ACQ_DATA_INCOMPLETA = 'Riga n. %s : %s - Data incompleta.';
  A000MSG_A128_ERR_FMT_ACQ_DATA_ESTERNA    = 'Riga n. %s : %s - Data %s fuori dal periodo di acquisizione.';
  A000MSG_A128_ERR_FMT_ACQ_NO_TURNO        = 'Riga n. %s : %s - Codice turno non indicato.';
  A000MSG_A128_ERR_FMT_ACQ_TURNO_INESISTENTE = 'Riga n. %s : %s - Codice turno %s inesistente.';
  A000MSG_A128_ERR_FMT_ACQ_DIP_PARTTIME    = 'Riga n. %s : %s - Matricola %s dipendente part-time. Assegnato turno non compatibile. Verificare ed eventualmente rimuovere manualmente la pianificazione.';
  A000MSG_A128_ERR_FMT_ACQ_MATR_INESISTENTE = 'Riga n. %s : %s - La matricola %s non risulta presente in anagrafico.';
  A000MSG_A128_ERR_FMT_ACQ_TURNO_PIANIFICATO = 'Riga n. %s : %s - Per la matricola %s il turno %s risulta già pianificato nel giorno %s.';
  A000MSG_A128_ERR_FMT_ACQ_TROPPI_TURNI    = 'Riga n. %s : %s - Per la matricola %s esistono già due turni pianificati nel giorno %s.';

  A000MSG_A130_DLG_FMT_APPLICA_MODIFICHE   = 'Applicare le modifiche?'#13#10+
                                             'Dalla data: %s alla data %s: '+#13#10+
                                             'dalle ore: %s alle ore %s: ' + #13#10;
  A000MSG_A130_DLG_SALVA_INTESTAZIONE      = 'Salvare anche l''intestazione delle colonne?';

  A000MSG_A131_MSG_CASSA                   = 'cassa';
  A000MSG_A131_MSG_ANNO_MOVIMENTO          = 'anno movimento';
  A000MSG_A131_MSG_NUMERO_MOVIMENTO        = 'numero movimento';
  A000MSG_A131_MSG_DATA_MOVIMENTO          = 'data del movimento';
  A000MSG_A131_MSG_DATA_MISSIONE           = 'data della missione';
  A000MSG_A131_MSG_CODICE_VOCE             = 'codice voce';
  A000MSG_A131_DLG_FMT_STATO               = 'Attenzione, ponendo lo stato dell''anticipo a %s' + #13#10+
                                             ', successivamente non sarà più modificabile, a causa delle autorizzazioni dell''operatore.'+ #13#10 +
                                             'Continuare?';
  A000MSG_A131_DLG_COLLEGA                 = 'Collegare gli anticipi con la missione?';
  A000MSG_A131_ERR_FMT_COD_ANT             = 'Nessun anticipo con il codice  "%s," inesistente nell''array locale.';
  A000MSG_A131_ERR_FMT_ANT_REGOLA          = 'L''Anticipo "%s" non può essere collegato con questa missione,' + #13#10 +
                                             'poichè la regola assegnata alla missione non lo permette.';
  A000MSG_A131_ERR_FMT_ANT_RIMB            = 'Codice Voce "%s" non riconosciuto come rimborso.' + #13#10 +
                                             'Per collegarlo all''anticipo inserirlo prima dall'' apposita maschera "Tipi Rimborsi".';
  A000MSG_A131_ERR_FMT_ANT_NO_ANT          = 'Il collegamento con la missione non può avvenire, in quanto l''anticipo "%s" non è  classificato come tale.';
  A000MSG_A131_ERR_FMT_RIMB_GIA_SOMMA      = 'Rimborso "%s" già esistente!, l''importo è stato sommato al rimborso già esistente.';
  A000MSG_A131_ERR_NO_ANT                  = 'Non ci sono anticipi da inserire.';
  A000MSG_A131_ERR_NO_MISSIONE             = 'Selezionare la missione.';

  A000MSG_A133_MSG_COD_TARIFFA             = 'Codice tariffa';

  A000MSG_A136_MSG_COMPONI_PENDING         = 'Attenzione! La composizione relazione è stata modificata. Confermare o annullare le modifiche apportate!';
  A000MSG_A136_ERR_TAB_DIVERSE             = 'La tabella di origine non può essere diversa da quella del dato pilotato se la relazione è di tipo filtrato (F)!';
  A000MSG_A136_ERR_UTENTE_NO_TABELLA       = 'Profilo utente non abilitato alla creazione di una relazione con la tabella pilota(/origine) selezionata!';
  A000MSG_A136_ERR_UTENTE_NO_CAMPO         = 'Profilo utente non abilitato alla creazione di una relazione con il campo selezionato!';
  A000MSG_A136_ERR_TABELLA_COLONNA         = 'Impostare correttamente la tabella e la colonna di partenza oppure svuotarle entrambe!';
  A000MSG_A136_DLG_RELAZ_NO_STANDARD       = 'Attenzione! La relazione non è standard; non è quindi possibile procedere con l''abbinamento automatico. Continuare?';
  A000MSG_A136_DLG_RELAZ_NO_PILOTA         = 'Attenzione! Impossibile caricare i dati dalla colonna pilota specificata; non è quindi possibile procedere con l''abbinamento automatico. Continuare?';
  A000MSG_A136_DLG_VALORI_DUPLICATI        = 'Attenzione! Valori pilotati duplicati. Verranno persi alcuni abbinamenti. Continuare?';
//  A000MSG_A136_DLG_NO_DATI_PILOTA        = 'Attenzione! Impossibile caricare i dati dalla colonna pilota specificata; non è quindi possibile procedere con l''abbinamento automatico. Continuare?';
  A000MSG_A136_DLG_MODIFICHE               = 'Attenzione! Confermare le modifiche effettuate alla relazione?';

  A000MSG_A137_MSG_FMT_NO_LOC_PART         = '%10s - Dipendente senza località di partenza anagrafica';
  A000MSG_A137_MSG_FMT_NO_RILEVATORE       = '%10s - Timbrature senza rilevatore';
  A000MSG_A137_MSG_FMT_RIL_NO_LOC          = '%10s - Rilevatore %-2s senza dati per località';
  A000MSG_A137_MSG_FMT_DIST_NO_IMP         = '%10s - Km di distanza non impostati tra %-6s (%-13s) e %-6s (%-13s)';
  A000MSG_A137_MSG_NO_KM_PERCORSI          = 'Fine mese  - Km percorsi calcolati nel mese: 0';
  A000MSG_A137_MSG_FMT_GIA_ESISTE          = '%-8s %-40s %10s - Impossibile inserire la testata della trasferta perché esiste già un record con Mese scarico %s e Data/Ora inizio %s 00.00';
  A000MSG_A137_MSG_FMT_INS_IND_KM          = '%-8s %-40s %10s - Impossibile inserire l''indennità chilometrica';
  A000MSG_A137_MSG_FMT_UPD_IND_KM          = '%-8s %-40s %10s - Impossibile aggiornare l''indennità chilometrica';

  A000MSG_A141_ERR_FMT_GIUST_NO_GIORN      = 'Giustificativo %s non inseribile a giornate intere!';
  A000MSG_A141_DLG_NO_RIPOSO               = 'Attenzione: causale di Riposo con raggruppamento diverso da Riposo! Continuare?';
  A000MSG_A141_DLG_NO_RIPOSO_COMP          = 'Attenzione: causale di Riposo comp. con raggruppamento diverso da Riposo/Rip.comp.! Continuare?';

  A000MSG_A145_DLG_FMT_ANNULLAMENTO        = 'Confermi l''annullamento dell''ultima comunicazione' + #13#10 +
                                             'presente in archivio (%s)?';
  A000MSG_A145_DLG_COM_PREC_SYSDATE        = 'Attenzione:' + #13#10 +
                                             'La data della comunicazione indicata è antecedente a quella odierna.' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_A145_DLG_AGGIORNAMENTO           = 'Confermi l''aggiornamento?';
  A000MSG_A145_DLG_AGGIORNAMENTO_MED_LEG   = 'Attenzione:' + #13#10 +
                                             'La comunicazione sarà resa effettiva per la sola medicina legale selezionata.' + #13#10 +
                                             'Confermi l''aggiornamento?';
  A000MSG_A145_DLG_ESENZ_NON_LAV           = 'Attenzione: il periodo di assenza comprende giornate precedenti o successive a quelle non lavorative: confermi comunque l’esenzione?';

  A000MSG_A145_MSG_FMT_CONFERMA_ANNULLAMENTO='La comunicazione del %s è stata annullata!';
  A000MSG_A145_ERR_DATA_ELAB               = 'La data di elaborazione non è valida!';
  A000MSG_A145_ERR_TIPO_OPERAZIONE         = 'Selezionare almeno un tipo di operazione da elaborare!';
  A000MSG_A145_ERR_NO_LOGO_LARG            = 'Indicare la larghezza del logo in pixel!';
  A000MSG_A145_ERR_LOGO_LARG               = 'Indicare un valore valido per la larghezza del logo!';
  A000MSG_A145_ERR_NO_NUM_PROT             = 'Indicare il numero di protocollo!';
  A000MSG_A145_ERR_NO_LUOGO                = 'Indicare il luogo di stampa!';
  A000MSG_A145_ERR_DATA_INIZIO_PERIODO     = 'La data di inizio periodo non è valida!';
  A000MSG_A145_ERR_DATA_FINE_PERIODO       = 'La data di fine periodo non è valida!';
  A000MSG_A145_ERR_PERIODO                 = 'Il periodo indicato non è valido!';
  A000MSG_A145_ERR_COM_PRECEDENTE          = 'Impossibile creare una comunicazione in data precedente all''ultima' + #13#10 +
                                             'comunicazione effettuata (%s).';
  A000MSG_A145_ERR_NO_ASSENZA              = 'Nessuna assenza presente nel periodo indicato!';
  A000MSG_A145_ERR_NO_PERIODO_ASSENZA      = 'Nessun periodo di assenze da comunicare per la data indicata!';

  A000MSG_A145_ERR_FMT_ESTR_DOM            = 'Anomalia durante l''estrazione dei dati di domicilio:' + #13#10 +
                                              '%s/%s';

  A000MSG_A147_ERR_NO_TURNI                = 'Specificare i turni vincolanti!';
  A000MSG_A147_DATA_COMPRESA               = 'La data indicata deve essere compresa nel periodo del vincolo corrente!';
  A000MSG_A147_DLG_CANC_SELEZ              = 'Eliminare la pianificazione corrente da tutti i dipendenti selezionati?';
  A000MSG_A147_DLG_INS_SELEZ               = 'Copiare la pianificazione corrente sugli altri dipendenti selezionati?';

  A000MSG_A150_DLG_INSERISCI               = 'Confermi l''inserimento delle assenze selezionate ?';
  A000MSG_A150_DLG_CANCELLAZIONE           = 'Confermi la cancellazione di TUTTE le causali di assenza di questo accorpamento?';
  A000MSG_A150_ERR_ACCORPAMENTO_WEB        = 'Non è possibile creare più di un accorpamente WEB.';
  A000MSG_A150_ERR_CANC_ACCORPAMENTO       = 'Impossibile cancellare un accorpamento con causali di assenza specificate!';

  A000MSG_A151_MSG_ELAB_PRESENZE           = 'Elaborazione dati di presenza in corso...premere Esc per interrompere';
  A000MSG_A151_MSG_ELAB_ASSENZE            = 'Elaborazione dati di assenza in corso...premere Esc per interrompere';
  A000MSG_A151_MSG_ELAB_TOTALI             = 'Totalizzazione in corso...';
  A000MSG_A151_DLG_GENERA_TABELLA          = 'Confermi la generazione della tabella per il periodo indicato, per i dipendenti selezionati?';
  A000MSG_A151_ERR_FMT_DIP_NON_PRES        = 'Il dipendente non è presente nella tabella %s';
  A000MSG_A151_ERR_NO_STAMPA               = 'Specificare la stampa del generatore di stampe!';
  A000MSG_A151_ERR_NO_TIPO_ACCORP          = 'Specificare il tipo di accorpamento causali di assenza da considerare!';
  A000MSG_A151_ERR_NO_COD_ACCORP           = 'Specificare i codici accorpamento da considerare!';
  A000MSG_A151_ERR_NO_COLONNE              = 'Selezionare almeno una colonna di elaborazione!';
  A000MSG_A151_ERR_NO_RIGHE                = 'Selezionare almeno una riga di raggruppamento!';
  A000MSG_A151_ERR_FMT_RIGENERA_TABELLA    = 'La tabella %s non contiene dati riferiti al periodo indicato. Rigenerare la tabella!';
  A000MSG_A151_MSG_FINI_L104               = 'Ai fini della legge 104/1992, ';
  A000MSG_A151_ERR_FMT_NO_DATO_TABELLA     = 'Il dato %s non è presente nella tabella %s';
  A000MSG_A151_ERR_FMT_ESPRESSIONE_DATO    = 'L''espressione del dato %s non è valida';
  A000MSG_A151_MSG_DEBITO_0_ORE            = 'In data %s il dipendente ha un debito settimanale di zero ore';
  A000MSG_A151_MSG_0_GIORNI_LAVORATIVI     = 'In data %s il dipendente ha un numero di giorni lavorativi pari a zero';
  A000MSG_A151_MSG_TIPI_FRUIZIONE          = 'Il dipendente utilizza le causali sia a giorni che a ore';
  A000MSG_A151_ERR_FMT_PIU_GIORNATE_INTERE = 'In data %s il dipendente ha più di un giustificativo a giornata intera: ne verrà conteggiato solo uno';
  A000MSG_A151_ERR_FMT_GG_INTERA_E_ORE     = 'In data %s il dipendente ha giustificativi a giornata intera e a ore: verrà conteggiato solo quello a giornata intera';
  A000MSG_A151_ERR_FMT_GIUST_NO_FAMILIARE  = 'In data %s il dipendente ha giustificativi privi del riferimento al familiare';
  A000MSG_A151_ERR_FMT_FAMILIARE_NO_ESISTE = 'In data %s il dipendente ha giustificativi riferiti al familiare %s che non esiste nella relativa tabella dei familiari';
  A000MSG_A151_ERR_FMT_FAMILIARE_NO_DATO   = 'Sul familiare con data nascita %s occorre indicare %s';
  A000MSG_A151_ERR_FMT_FAMILIARE_CON_DATO  = 'Sul familiare con data nascita %s occorre pulire %s';
  A000MSG_A151_ERR_NO_FILE                 = 'Specificare il nome del file di esportazione!';
  A000MSG_A151_DLG_FILE_ESISTE             = 'Il file indicato per l''esportazione è già esistente. Proseguire comunque sostituendolo con i nuovi dati?';
  A000MSG_A151_ERR_FILE_IN_USO             = 'Impossibile procedere alla sostituzione del file. Verificare che il file non sia in uso';
  A000MSG_A151_DLG_FMT_GARANZIA_EXPORT     = 'Attenzione: il buon esito dell''esportazione in .xml %s è garantito esclusivamente con %s. Continuare comunque?';
  A000MSG_A151_DLG_FMT_DETTAGLIO_DATA_FAM  = 'Attenzione: con il dettaglio familiari, occorre verificare che la stampa %s abbia nel Dettaglio serbatoio il dato giornaliero ''Assenza:data familiare''. Continuare?';
  A000MSG_A151_DLG_NO_ID_MITTENTE          = 'Attenzione: ID Mittente non indicato! Il dato verrà valorizzato con il numero progressivo della riga. Continuare?';
  A000MSG_A151_DLG_EXPORT_1000_TASSI       = 'Attenzione: nella griglia risultato sono presenti più di 1000 tassi di assenza da esportare! Continuare comunque?';
  A000MSG_A151_ERR_FMT_NO_ID               = 'Attenzione: riga non elaborata. ID %s (%s) non valorizzato sulla riga %s';
  A000MSG_A151_ERR_FMT_ERR_GEN             = 'Attenzione: riga non valida in %s: %s';
  A000MSG_A151_ERR_FMT_RIGA_INVALIDA       = 'Attenzione: riga non valida. %s non valorizzato %s';
  A000MSG_A151_ERR_FMT_VALORI_DIVERSI      = 'Attenzione: riga non valida. %s diverso dai valori previsti (%s)';
  A000MSG_A151_ERR_GIUST_NO_FAMILIARE      = 'Attenzione: riga non valida. Giustificativi privi del riferimento al familiare';
  A000MSG_A151_MSG_FMT_CF_FAMILIARE        = ' per il familiare con cod.fiscale %s';
  A000MSG_A151_ERR_FMT_DATO_AZ_VUOTO       = 'Non è stato specificato il dato aziendale "%s"!';

  A000MSG_A153_ERR_FMT_DATA_ANTECEDENTE    = 'Il %s è antecedente al periodo di riferimento';
  A000MSG_A153_ERR_FMT_DATA_SUCCESSIVA     = 'Il %s è successivo al periodo di riferimento';

  A000MSG_Ac01_ERR_NO_COD_PROGETTO         = 'Indicare il codice del progetto!';
  A000MSG_Ac01_ERR_CHIUSURA_INCOMPLETA     = 'Valorizzare o svuotare entrambe le date del periodo di chiusura del progetto!';
  A000MSG_Ac01_ERR_CHIUSURA_FUORI_VALIDITA = 'Il periodo di chiusura del progetto non puo'' essere esterno a quello di validita''!';
  A000MSG_Ac01_ERR_SEQUENZA_T750           = 'Impossibile estrarre nuovo valore dalla sequenza T750_ID!';
  A000MSG_Ac01_ERR_SEQUENZA_T751           = 'Impossibile estrarre nuovo valore dalla sequenza T751_ID!';
  A000MSG_Ac01_ERR_SEQUENZA_T752           = 'Impossibile estrarre nuovo valore dalla sequenza T752_ID!';
  A000MSG_Ac01_MSG_ORE_ASSEGNATE           = 'Impossibile assegnare piu'' ore di quante previste!';
  A000MSG_Ac01_MSG_ORE_PREVISTE            = 'Impossibile prevedere meno ore di quante assegnate!';
  A000MSG_Ac01_ERR_NO_COD_ATTIVITA         = 'Indicare il codice dell''attivita''!';
  A000MSG_Ac01_ERR_NO_COD_TASK             = 'Indicare il codice del task!';
  A000MSG_Ac01_ERR_DUPLICA_TASK            = 'Non ci sono altre attivita'' su cui copiare il task selezionato!';
  A000MSG_Ac01_ERR_DUPLICA_DIPENDENTE      = 'Non ci sono altri task ai quali assegnare il dipendente selezionato!';
  A000MSG_Ac01_ERR_DEL_TUTTI_TASK          = 'Non e'' possibile cancellare tutti i task di un''attivita''!';
  A000MSG_Ac01_ERR_NO_DIP                  = 'Selezionare un dipendente!';
  A000MSG_Ac01_ERR_NO_INIZIO               = 'Indicare l''inizio del periodo!';
  A000MSG_Ac01_ERR_NO_FINE                 = 'Indicare la fine del periodo!';
  A000MSG_Ac01_ERR_PERIODO_ESTERNO         = 'Il periodo di validita'' del dipendente non puo'' essere esterno al periodo di validita'' del progetto!';
  A000MSG_Ac01_ERR_PERIODI_INTERSECANTI    = 'Il periodo indicato ne interseca uno gia'' esistente!';
  A000MSG_Ac01_ERR_CONFLITTO_PERIODI       = 'Il periodo specificato creerebbe dei conflitti col periodo di validita'' di alcuni dipendenti!' + #13#10 +
                                             'Annullare la modifica in corso per gestire individualmente la validita'' dei dipendenti che hanno dei periodi particolari.' + #13#10 +
                                             'Dopodiche'' modificare il periodo di validita'' del progetto.';
  A000MSG_Ac01_ERR_FMT_RICHIESTE           = 'Per %s' + #13#10 + '%s' + #13#10 + 'esistono rendicontazioni autorizzate o in attesa di autorizzazione nel periodo %s-%s!';
  A000MSG_Ac01_ERR_MANCA_REPORTING_PERIOD  = 'Indicare almeno un reporting period!';
  A000MSG_Ac01_ERR_INIZIO_REPORTING_PERIOD = 'La data Dal del primo reporting period non coincide con la data Dal del periodo di validità del progetto!';
  A000MSG_Ac01_ERR_FINE_REPORTING_PERIOD   = 'La data Al dell''ultimo reporting period non coincide con la data Al del periodo di validità del progetto!';
  A000MSG_Ac01_ERR_NO_COD_REPORTING_PERIOD = 'Indicare il codice del reporting period!';
  A000MSG_Ac01_ERR_DATA_VUOTA              = 'Indicare entrambe le date!';
  A000MSG_Ac01_ERR_BUCHI_REPORTING_PERIOD  = 'I reporting period non sono contigui!';

  A000MSG_Ac04_ERR_PERIODO_LUNGO           = 'Il periodo specificato non può essere superiore a 12 mesi!';

  A000MSG_Ac05_MSG_FINE_IMPORTAZIONE       = 'Importazione dei dati completata';
  A000MSG_Ac05_MSG_FINE_COLLEGAMENTO       = 'Collegamento rimborsi completato';
  A000MSG_Ac05_ERR_FILE_NON_ESISTE         = 'Il file da importare non esiste!';
  A000MSG_Ac05_ERR_TIPO_PAGAMENTO          = 'Selezionare il tipo pagamento!';
  A000MSG_Ac05_MSG_INIZIO_COLLEGAMENTO     = 'Inizio collegamento rimborsi';
  A000MSG_Ac05_ERR_ID_RICHIESTA_ANNULLATA  = 'Trovata richiesta annullata relativa al rimborso';
  A000MSG_Ac05_ERR_ID_MISSIONE_NON_TROV    = 'Non trovate né richiesta né missione relativa al rimborso';
  A000MSG_Ac05_ERR_PROTOCOLLO_PIU_RICHIESTE= 'Protocollo associato a più richieste';
  A000MSG_Ac05_ERR_PROTOCOLLO_PIU_MISSIONI = 'Protocollo associato a più missioni';
  A000MSG_Ac05_ERR_ID_RICHIESTA_INCOERENTE = 'ID missione relativo al rimborso non coerente con ID richiesta';
  A000MSG_Ac05_ERR_RIMBORSO_NON_TROV       = 'Codice rimborso non trovato';
  A000MSG_Ac05_ERR_IMPORTO                 = 'Importo non valido';
  A000MSG_Ac05_ERR_FMT_CAMPO               = 'Non è stato configurato il campo %s';
  A000MSG_Ac05_ERR_FMT_COLONNA             = 'Non è stata indicata la colonna del file excel relativa al campo %s';
  A000MSG_Ac05_ERR_FMT_COLONNA_NON_TROV    = 'Nel file excel non è presente la colonna %s associata al campo %s';
  A000MSG_Ac05_DLG_FMT_REG_RIMB_ESISTENTI  = 'Sono già stati collegati %s rimborsi (evidenziati nella griglia) su %s rimborsi collegabili.' + #13#10 +
                                             'Confermi il collegamento di TUTTI i rimborsi collegabili?' + #13#10 + #13#10 +
                                             '<Yes> Inserisci TUTTI i rimborsi collegabili' + #13#10 + '<No> Inserisci i rimborsi non ancora collegati e valuta singolarmente i rimborsi già collegati' + #13#10 + '<Cancel> Annulla operazione';
  A000MSG_Ac05_DLG_FMT_REG_RIMB_ESISTENTE  = 'Il seguente rimborso risulta già collegato:' + #13#10 + '%s' + #13#10 + 'Inserirlo comunque?';

  A000MSG_Ac06_ERR_PRIORITA                = 'Priorità di chiamata non valida! E'' possibile inserire uno dei seguenti valori: 1, 2 o 3';
  A000MSG_Ac06_DLG_CANCELLAZIONE           = 'Confermi la cancellazione%s?';
  A000MSG_Ac06_DLG_INSERIMENTO             = 'Confermi l''inserimento%s?';
  A000MSG_Ac06_DLG_TUTTI_DIP               = ' per tutti i dipendenti selezionati';
  A000MSG_Ac06_DLG_FMT_SOST_PRIORITA       = 'Per il dipendente %s in data %s è già stata impostata una diversa priorità.' + #13#10 +
                                             'Sostituirla?';
  A000MSG_Ac06_DLG_FMT_SOST_PRIORITA_TUTTI = #13#10 + #13#10 +
                                             '<Yes> Sovrascrivi con la nuova priorità' + #13#10 +
                                             '<No> Lascia la priorità precedentemente impostata' + #13#10 +
                                             '<Cancel> Interrompi l''operazione' + #13#10 +
                                             '<Yes to All> Sovrascrivi con la nuova priorità per tutti i successivi dipendenti selezionati';

  A000MSG_Ac07_ERR_CAMPO_RIFERIMENTO       = 'Non è specificato il campo di riferimento sui parametri aziendali!';
  A000MSG_Ac07_ERR_SEQUENZA_CSI004         = 'Impossibile estrarre nuovo valore dalla sequenza CSI004_ID!';

  A000MSG_Ac08_ERR_CAMPO_RIFERIMENTO       = 'Non è specificato il campo di riferimento sui parametri aziendali!';
  A000MSG_Ac08_ERR_DATE_STESSO_MESE        = 'Le date di elaborazione devono afferire allo stesso mese!';
  A000MSG_Ac08_ERR_NO_OPERAZIONE           = 'Indicare il tipo di operazione da effettuare!';
  A000MSG_Ac08_ERR_NO_INDPRES_ANAG         = 'Non è associata nessuna regola di indennità di presenza valida';
  A000MSG_Ac08_DLG_FMT_ELABORAZIONE        = 'Confermi %s dell''indennità di funzione dei %s dipendenti selezionati per il periodo %s-%s?';
  A000MSG_Ac08_ERR_FMT_NO_INDFUNZIONE_ANAG = 'Non è valorizzato il dato anagrafico %s!';
  A000MSG_Ac08_ERR_FMT_NO_REGOLA_CONTRATTO = 'Il contratto %s non è stato associato a %s %s nelle regole delle indennità di funzione!';
  A000MSG_Ac08_ERR_FMT_NO_REGOLA_FASCIA    = 'Non è stata specificata la regola di indennità di funzione per la fascia %s del contratto %s con %s %s!';
  A000MSG_Ac08_MSG_FMT_DATI_CANCELLATI     = 'I dati precedentemente registrati sono stati cancellati %s';

  A000MSG_Ac09_ERR_CAMPO_RIFERIMENTO       = 'Non è specificato il campo di riferimento sui parametri aziendali!';
  A000MSG_Ac09_ERR_DEL_UNICO_RECORD        = 'Non è possibile cancellare l''unico periodo rimasto! Se necessario, azzerare le ore.';
  A000MSG_Ac09_ERR_NO_INDFUNZIONE          = 'E'' necessario indicare il codice dell''indennità di funzione!';
  A000MSG_Ac09_ERR_FORMATO_ORE             = 'Indicare le ore di indennità nel formato HH.MM';
  A000MSG_Ac09_ERR_FORMATO_DISAGIO_SERALE  = 'Indicare le ore per disagio serale nel formato HH.MM';
  A000MSG_Ac09_ERR_DISAGIO_SUPERA_ORE      = 'Le ore per disagio serale non possono essere maggiori delle ore di indennità!';
  A000MSG_Ac09_ERR_FMT_SUPERA_ORE_CALC     = 'Non è possibile indicare più ore%s (%s) rispetto a quelle calcolate (%s)!';
  A000MSG_Ac09_ERR_FMT_SUPERA_DISAGIO_CALC = 'Non è possibile indicare più ore%s per disagio serale (%s) rispetto a quelle calcolate (%s)!';

  A000MSG_Ac11_ERR_ELABORAZIONE            = 'Impossibile avviare l''elaborazione! ';
  A000MSG_Ac11_ERR_SCELTA_EFFETTUATA       = 'E'' gia'' stata effettuata una scelta da parte dei dipendenti!';
  A000MSG_Ac11_ERR_PERIODO_INIZIATO        = 'E'' gia'' iniziato il periodo di scelta!';
  A000MSG_Ac11_ERR_DIP_2_FILTRI_ANAGRAFE   = 'Il dipendente rientra nel filtro anagrafe di piu'' regole!';
  A000MSG_Ac11_ERR_CARTELLINO_CHIUSO       = 'Il cartellino mensile e'' chiuso!';
  A000MSG_Ac11_ERR_FMT_PERIODO_NON_FINITO  = 'Il periodo di scelta (%s-%s) non e'' ancora finito!';
  A000MSG_Ac11_ERR_NO_SCELTA_EFFETTUATA    = 'Il dipendente senza obbligo di timbratura non ha effettuato la scelta in un giorno senza timbrature ne'' giustificativi!';
  A000MSG_Ac11_ERR_SCELTA_FRUIZIONE        = 'Scelta ''A - Fruizione'' non applicabile:';
  A000MSG_Ac11_ERR_TIMBRATURE              = 'Presenti timbrature';
  A000MSG_Ac11_ERR_PRESENZE                = 'Presenti causali di presenza';
  A000MSG_Ac11_ERR_ASSENZE_CON_ESCLUSIONE  = 'Presenti causali di assenza con Esclusione dalle ore rese da assenza';
  A000MSG_Ac11_ERR_NO_VALORE_OBBL_TIMB     = 'Non e'' stato indicato il valore che identifica i dipendenti con obbligo di timbratura!';
  A000MSG_Ac11_ERR_NO_REGOLA               = 'Regola non trovata!';
  A000MSG_Ac11_ERR_FMT_SCELTA_EXTRA_LISTA  = 'La scelta effettuata (%s) non rientra tra quelle possibili (%s)!';
  A000MSG_Ac11_ERR_SCELTA_COMPETENZE       = 'Scelta ''C - Aumenta competenza ferie'' incongruente con giorno senza timbrature ne'' giustificativi!';
  A000MSG_Ac11_ERR_FMT_ASS_NO_ESCLUSIONE   = 'Co-presenza di causale per la fruizione della festivita'' (%s) e di altre causali senza Esclusione dalle ore rese da assenza';

  A000MSG_A160_INCENTIVI_DATO_1            = 'Specificare il dato aziendale <INCENTIVI:DATO 1>';

  A000MSG_A162_ERR_PCT_ABBATT              = 'Attenzione! Le percentuali di abbattimento non possono superare il 100%.';

  A000MSG_A163_ERR_CODICE_MENO             = 'Attenzione! Non è possibile inserire un Tipo Quota con codice ''-''.';
  A000MSG_A163_ERR_CODICE_UNDERSCORE       = 'Attenzione! Non è possibile inserire un Tipo Quota con codice ''_''.';
  A000MSG_A163_ERR_IMP_CAMBIARE            = 'Per questo tipo quota è impossibile cambiare la tipologia!';
  A000MSG_A163_ERR_QUOTE_REGISTRATE        = 'Impossibile cambiare la tipologia perché per questo codice esistono già delle quote registrate!';
  A000MSG_A163_ERR_RIFERIMENTO             = 'Specificare almeno un acconto di riferimento!';
  A000MSG_A163_ERR_ASSESTAMENTO            = 'Specificare la causale di assestamento!';
  A000MSG_A163_ERR_PENALIZZAZIONE          = 'Impossibile specificare più di una quota di penalizzazione!';
  A000MSG_A163_ERR_IMP_CANCELLARE          = 'Impossibile cancellare questo tipo quota!';
  A000MSG_A163_ERR_IMP_CANCELLARE_REGIST   = 'Impossibile cancellare questo tipo quota perchè esistono già delle quote registrate!';
  A000MSG_A163_MSG_DECORRENZA_SPOSTATA     = 'Attenzione: la decorrenza verrà spostata all''inizio del mese specificato!'#13#10'Vuoi continuare?';

  A000MSG_A164_ERR_FMT_REGOLE_DATO         = 'Regole incentivi non esistenti per questo livello (%s)!';
  A000MSG_A164_ERR_PCT_INCIDENZA           = 'Attenzione: la somma delle percentuali di incidenza individuale e strutturale deve essere 100!';
  A000MSG_A164_ERR_PCT_O_IMP               = 'Indicare una percentuale o un importo di variazione significativo!';
  A000MSG_A164_ERR_QUOTA_O_CAUS            = 'Indicare ''tipo quota'' o ''causale di assenza''';
  A000MSG_A164_MSG_DECORRENZA_INIZIO_MESE  = 'Attenzione: la decorrenza è stata spostata all''inizio del mese specificato!';
  A000MSG_A164_MSG_FMT_AGG_GLOBALE         = 'Confermi l''aggiornamento/storicizzazione di TUTTE le quote ''%s %s'' ' + #13#10+
                                             'dal %s con %s rispetto alle attuali?';

  A000MSG_A166_DLG_FORZA_DEC_SCAD          ='Attenzione: la decorrenza e la scadenza sono diversi da inizio e fine mese. ' + #13#10 +
                                            'Questo è significativo SOLO se la quota indicata è DIVERSA rispetto alle quote generali spettanti. ' + #13#10 +
                                            'Se il dipendente è assunto/cessato in corso di mese oppure ha delle assenze non tollerate il PROPORZIONAMENTO è AUTOMATICO e ' + #13#10 +
                                            'FUNZIONA correttamente solo se decorrenza e scadenza coincidono con inizio e fine mese. Forzare questi ultimi a inizio e fine mese?';
  A000MSG_A166_DLG_FORZA_DEC               ='Attenzione: la decorrenza è diversa da inizio mese. ' + #13#10 +
                                            'Questo è significativo SOLO se la quota indicata è DIVERSA rispetto alle quote generali spettanti. ' + #13#10 +
                                            'Se il dipendente è assunto/cessato in corso di mese oppure ha delle assenze non tollerate il PROPORZIONAMENTO è AUTOMATICO e ' + #13#10 +
                                            'FUNZIONA correttamente solo se la decorrenza coincide con l''inizio del mese. Forzare quest''ultima a inizio mese?';
  A000MSG_A166_DLG_FORZA_SCAD              ='Attenzione: la scadenza è diversa da fine mese. ' + #13#10 +
                                            'Questo è significativo SOLO se la quota indicata è DIVERSA rispetto alle quote generali spettanti. ' + #13#10 +
                                            'Se il dipendente è assunto/cessato in corso di mese oppure ha delle assenze non tollerate il PROPORZIONAMENTO è AUTOMATICO e ' + #13#10 +
                                            'FUNZIONA correttamente solo se la scadenza coincide con la fine del mese. Forzare quest''ultima a fine mese? ';
  A000MSG_A166_DLG_FMT_ACQUISIZIONE        ='Confermi l''acquisizione delle quote ''%s %s'' ' + #13#10 +
                                            'per i %s dipendenti selezionati presenti sul file?';

  A000MSG_A166_ERR_FMT_REGOLE_INCENTIVI    ='Regole incentivi non esistenti per il livello (%s) di questo dipendente!';
  A000MSG_A166_ERR_QUOTE_QUANTITATIVE      = 'Impossibile specificare quote quantitative perchè vengono gestite attraverso le schede quantitative individuali (A172)!';
  A000MSG_A166_ERR_TIPO_QUOTA              = 'Indicare tipo quota!';


  A000MSG_A167_MSG_FMT_CONFERMA_CANC       = 'Confermi la cancellazione delle quote %s da %s a %s per TUTTI i dipendenti selezionati?';

  A000MSG_A169_ERR_PESI_BASE               = 'Attenzione: totale pesi base superiore al peso totale previsto!';
  A000MSG_A169_ERR_QUOTE_BASE              = 'Attenzione: totale quote base superiore alla quota totale prevista!';
  A000MSG_A169_ERR_PESI_CALCOLATI          = 'Attenzione: totale pesi calcolati superiore al peso totale previsto!';
  A000MSG_A169_ERR_QUOTE_ASSEGNATE         = 'Attenzione: totale quote assegnate superiore alla quota totale prevista!';
  A000MSG_A169_ERR_QUOTE_CALCOLATE         = 'Attenzione: totale quote calcolate superiore alla quota totale prevista!';
  A000MSG_A169_MSG_DIPENDENTI_CAMBIATI     = 'Attenzione: la situazione dei dipendenti potrebbe essere cambiata. ' + #13#10 +
                                             'Consigliamo di procedere con l''aggiornamento del gruppo dall''apposita funzione!';
  A000MSG_A169_MSG_DIPENDENTI_GRUPPO       = 'Il dipendente non è stato inserito perchè fa già parte del gruppo ';
  A000MSG_A169_MSG_PESO_MINIMO             = 'Indicare un peso individuale minimo significativo!';
  A000MSG_A169_MSG_PESO_INFERIORE          = 'Peso inferiore al minimo individuale previsto!';
  A000MSG_A169_MSG_PESO_SUPERIORE          = 'Peso superiore al massimo individuale previsto!';

  A000MSG_A170_ERR_ABIL_PES_SCHEDE         = 'Funzione (A169) Pesature individuali e/o (A172) Schede quantitative individuali non abilitate!';
  A000MSG_A170_ERR_GRUPPI_PESATURE         = 'Selezionare almeno un gruppo pesature da elaborare!';
  A000MSG_A170_ERR_GRUPPI_SCHEDE           = 'Selezionare almeno un gruppo schede da elaborare!';
  A000MSG_A170_ERR_ANNO_SCHEDE             = 'Indicare l''anno  delle schede da elaborare!';
  A000MSG_A170_ERR_DATA_RIF_SCHEDE         = 'Specificare una data di riferimento valida!';
  A000MSG_A170_ERR_ANNO_DATA_RIF_SCHEDE    = 'Specificare una data di riferimento compresa nel nuovo anno!';
  A000MSG_A170_ERR_TIPOLOGIA_QUOTA         = 'Specificare la tipologia quota!';
  A000MSG_A170_DLG_NO_MESE_PAGAMENTO       = 'Attenzione: non è stato specificato alcun mese di pagamento. Continuare comunque?';
  A000MSG_A170_DLG_FMT_CHIUSURA_PESATURE   = 'Confermi la chiusura dei gruppi pesature selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_RIAPERTURA_PESATURE = 'Confermi la riapertura dei gruppi pesature selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_AGGIORNA_PESATURE   = 'Confermi l''aggiornamento dei gruppi pesature selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_CHIUSURA_SCHEDE     = 'Confermi la chiusura dei gruppi schede selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_RIAPERTURA_SCHEDE   = 'Confermi la riapertura dei gruppi schede selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_AGGIORNA_SCHEDE     = 'Confermi l''aggiornamento dei gruppi schede selezionati per l''anno %s ?';
  A000MSG_A170_DLG_FMT_PASSAGGIO_ANNO_SCHEDE  ='Attenzione: verranno ribaltati i gruppi schede presenti nel %s sul nuovo anno %s. ' + #13#10 +
                                               'Eventuali gruppi già presenti nel %s verranno sovrascritti. Prima di procedere, CHIUDERE quelli che si vogliono mantenere intatti. Confermare l''operazione?';
  A000MSG_A170_DLG_FMT_GRUPPI_APERTI_SCHEDE= 'Attenzione: sono presenti %s gruppi aperti nell''anno %s che verranno sovrascritti. ' + #13#10 +
                                             'Continuare?';

  A000MSG_A172_MSG_GRUPPO_APERTO           = 'Gruppo aperto';
  A000MSG_A172_MSG_GRUPPO_CHIUSO           = 'Gruppo chiuso';
  A000MSG_A172_MSG_GRUPPO_MODIFICA         = 'Gruppo in modifica';
  A000MSG_A172_MSG_MODIFICA_NON_CONSENTITA = 'La modifica/cancellazione è consentita solamente per i gruppi in stato Aperto';
  A000MSG_A172_MSG_MODIFICA_DETAIL_NON_CONSENTITA = 'La modifica  è consentita solamente per i gruppi che non siano Chiusi';
  A000MSG_A172_MSG_DIPENDENTI_CAMBIATI     = 'Attenzione: la situazione dei dipendenti potrebbe essere cambiata. ' + #13#10 +
                                             'Consigliamo di eliminare il gruppo e ricrearlo con i nuovi parametri!';
  A000MSG_A172_ERR_ANNO_RIF                = 'Indicare l''anno di riferimento!';
  A000MSG_A172_ERR_DATA_RIF                = 'La data di riferimento deve essere compresa nell''anno di riferimento!';
  A000MSG_A172_ERR_TIPO_QUOTA              = 'Indicare il tipo quota!';
  A000MSG_A172_ERR_SUPERVISORE             = 'Indicare il supervisore di riferimento!';
  A000MSG_A172_ERR_NO_FILTRO_ANAG          = 'Indicare il filtro anagrafe!';
  A000MSG_A172_ERR_FILTRO_ANAG             = 'Filtro anagrafe non corretto!';
  A000MSG_A172_ERR_NO_CODGRUPPO            = 'Indicare il codice gruppo!';
  A000MSG_A172_ERR_TOT_ORE_ACCETTATE       = 'Attenzione: totale importo ore accettate superiore all''importo totale previsto!';
  A000MSG_A172_ERR_NUM_ORE_ASSEGNATE       = 'Num.ore assegnate non valide!';
  A000MSG_A172_ERR_MINUTI_ORE_ASSEGNATE    = 'I minuti delle ore assegnate devono essere minori di 60!';
  A000MSG_A172_ERR_NUM_ORE_ACCETTATE       = 'Num.ore accettate non valide!';
  A000MSG_A172_ERR_MINUTI_ORE_ACCETTATE    = 'I minuti delle ore accettate devono essere minori di 60!';
  A000MSG_A172_ERR_NUM_ORE_EXTRA           = 'Num.ore extra non valide!';
  A000MSG_A172_ERR_MINUTI_ORE_EXTRA        = 'I minuti delle ore extra devono essere minori di 60!';
  A000MSG_A172_ERR_GIA_FIRMATO             = 'Impossibile modificare i dati perchè il dipendente ha già firmato!';
  A000MSG_A172_ERR_NO_VALUTATORE           = 'Specificare il valutatore di riferimento!';
  A000MSG_A172_ERR_ORE_ACCETTATE_PROG_QUANT= 'Specificare le ore accettate quando vengono confermati i progetti quantitativi (punto 2 della flessibilità)!';
  A000MSG_A172_ERR_PROG_QUANT_ORE_ACCETTATE= 'Specificare la conferma dei progetti quantitativi (punto 2 della flessibilità) quando vengono accettate delle ore!';
  A000MSG_A172_ERR_NO_DESC_OBIETTIVO       = 'Specificare la descrizione dell''obiettivo!';
  A000MSG_A172_ERR_NO_PESO_OBIETTIVO       = 'Specificare il peso dell''obiettivo!';
  A000MSG_A172_ERR_PESO_OBIETTIVO4         = 'Il peso dell''obiettivo 4 non può essere inferiore a 40!';
  A000MSG_A172_ERR_FMT_SOMMA_PESI          = 'La somma totale dei pesi è %s ma non può essere diversa da 100!';

  A000MSG_A173_ERR_NO_FILE                 = 'Specificare il file contenente le ore di assestamento da importare!';
  A000MSG_A173_ERR_COLONNE_FILE            = 'Impossibile elaborare il file! Il file contiene un numero di colonne non corretto!';
  A000MSG_A173_ERR_FMT_ACQ_NO_ANNO         = 'Riga %s: %s Anno non corretto';
  A000MSG_A173_ERR_FMT_ACQ_NO_MESE         = 'Riga %s: %s Mese non corretto';
  A000MSG_A173_ERR_FMT_ACQ_NO_ORE          = 'Riga %s: %s Valore del campo ore non corretto, valori ammessi tra 0 e 999';
  A000MSG_A173_ERR_FMT_ACQ_NO_MINUTI       = 'Riga %s: %s Valore del campo minuti non corretto, valori ammessi tra 0 e 59';
  A000MSG_A173_ERR_FMT_ACQ_NO_CAUSALE      = 'Riga %s: %s Causale non esistente';
  A000MSG_A173_ERR_FMT_ACQ_NO_MATRICOLA    = 'Riga %s: %s Matricola non esistente';
  A000MSG_A173_ERR_FMT_ACQ_TROPPE_CAUSALI  = 'Riga %s: Matricola %s Mese %s/%s Elaborazione impedita dalla presenza di altre due causali di assestamento';
  A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_COMP = 'Riga %s: Matricola %s Mese %s/%s Le ore di abbattimento superano il saldo complessivo, l''operazione viene comunque effettuata';
  A000MSG_A173_ERR_FMT_ACQ_SUPERO_SALDO_CORR = 'Riga %s: Matricola %s Mese %s/%s Le ore di abbattimento superano il saldo anno corrente, l''operazione viene comunque effettuata';
  A000MSG_A173_ERR_FMT_CANC_NO_CAUSALE     = 'Riga %s: Matricola %s Mese %s/%s Cancellazione non avvenuta per l''assenza della causale di assestamento';
  A000MSG_A173_ERR_FMT_CANC_NO_ORE         = 'Riga %s: Matricola %s Mese %s/%s Cancellazione non avvenuta per l''assenza di corrispondenza del numero ore di assestamento';
  A000MSG_A173_ERR_FMT_ACQ_NO_SCHEDA_RIEP  = 'Riga %s: Matricola %s Mese %s/%s Elaborazione impedita dall''assenza della scheda riepilogativa';

  A000MSG_A183_MSG_FILTRO_CORRETTO         = 'Filtro Corretto!';
  A000MSG_A183_ERR_FMT_FILTRO              = 'Impossibile salvare il filtro!'#13#10'%s';
  A000MSG_A184_DLG_FMT_CANCELLA            = 'Attenzione!'#13#10'Il profilo ha delle funzioni attivate per i seguenti applicativi:'#13#10 +
                                             '%s'#13#10'Eliminare il record?';

  A000MSG_A186_ERR_FMT_DEFINIRE_FILTRO     = 'Definire un filtro %s: nessun login inserito';
  A000MSG_A186_ERR_FMT_ESPR_UT_PWD         = 'Le espressioni indicate per l''utente e la password non sono valide!'#13#10'%s';

  A000MSG_A186_DLG_FMT_TRIG_060            = '%s il trigger T030_AFTERINS_I060 ?';
  A000MSG_A186_DLG_FMT_ELIM_LOGIN          = 'Confermi l''eliminazione del login di accesso per i %s dipendenti selezionati?';
  A000MSG_A186_DLG_FMT_INS_LOGIN           = 'Confermi l''inserimento del login di accesso per i %s dipendenti selezionati?';
  A000MSG_A186_DLG_ELIM_PROFILI            = 'Confermi l''eliminazione dei profili con le impostazioni indicate per i login selezionati?';
  A000MSG_A186_DLG_VAL_DEFAULT             = 'Verranno applicati i valori di default specificati in Permessi, Filtro funzioni, Filtro dizionario.' + #13 + 'Confermare?';
  A000MSG_A186_DLG_FMT_UPD_PWD             = 'Confermi la modifica della password per i %s dipendenti selezionati?';
  A000MSG_A186_ERR_PWD_ERRATA              = 'La password attuale è errata';
  A000MSG_A186_ERR_FMT_LUNG_PWD            = 'La password deve essere di almeno %d caratteri!';
  A000MSG_A186_ERR_DLG_PWD                 = 'La nuova password non è stata confermata correttamente!';
  A000MSG_A186_ERR_NO_UTENTE               = 'Nessun utente selezionato a cui applicare il filtro.';

  A000MSG_A187_ERR_FMT_V_SESSION           = 'Attenzione! Probabilmente mancano i diritti di accesso alle viste ' + #13#10 +
                                             'V$SESSION e V$MYSTAT.' + #13#10 +
                                             'Non è pertanto possibile visualizzare le Sessioni attive.'#13#10'%s';
  A000MSG_A187_DLG_BLOCCO                  = 'Bloccare gli accessi a tutti gli utenti?';
  A000MSG_A187_DLG_SBLOCCO                 = 'Sbloccare gli accessi a tutti gli utenti?';
  A000MSG_A187_DLG_TERMINA_SESS            = 'Terminare la sessione selezionata?';
  A000MSG_A187_DLG_TERMINA_ALL_SESS        = 'Terminare tutte le sessioni?';

  A000MSG_A193_DLG_IMPORTA_RICH            = 'Confermi l''importazione di tutte le richieste visualizzate?';

  A000MSG_A197_ERR_LAYOUT_DEFAULT          = 'Impossibile rinominare/cancellare il layout DEFAULT';
  A000MSG_A197_ERR_LAYOUT_MEDP             = 'Impossibile creare il layout MONDOEDP';

  A000MSG_A197_ERR_LAYOUT_USO              = 'Impossibile rinominare/cancellare il layout poichè in uso';

  A000MSG_A198_MSG_SERBATOIO               = 'Serbatoio';
  A000MSG_A198_MSG_NOME                    = 'Nome';
  A000MSG_A198_MSG_ESPRESSIONE             = 'Espressione';

  A000MSG_A200_MSG_DLG_NUM_FILE_SELEZ      = 'File selezionati: %d';
  A000MSG_A200_MSG_DLG_DIM_FILE_SELEZ      = 'Dimensione totale: %s';
  A000MSG_A200_ERR_NO_NOMEFILE_PRED        = 'Specificare il nome di file di destinazione predefinito';
  A000MSG_A200_ERR_FMT_NOMEFILE_NO_TAG     = 'Il formato nome del file non contiene il tag %s';
  A000MSG_A200_ERR_B021_NON_RISPONDE       = 'Nessuna risposta dal servizio B021.';
  A000MSG_A200_ERR_NO_DATE_PERIODO         = 'Entrambe le date di riferimento devono essere valorizzate oppure vuote.';
  A000MSG_A200_DLG_FMT_AVVIO_IMPORT        = 'Importare %d file?';
  A000MSG_A200_DLG_FMT_CONFIRM_SOVRASCR    = 'È stato scelto di sovrascrivere i documenti esistenti della tipologia %s.' + #13#10 +
                                             'Tali documenti saranno cancellati se è presente un file da importare per il dipendente e non potranno essere recuperati.' + #13#10 +
                                             'Proseguire con l''importazione?';
  A000MSG_A200_MSG_IMPORTAZIONE            = 'Importazione di %s...';
  A000MSG_A200_ERR_SUPERO_MAX_DIM          = 'Il file %s supera la dimensione massima consentita e non è stato importato';
  A000MSG_A200_ERR_FMT_IMPORT_EXC          = 'Errore durante l''importazione di %s: %s';
  A000MSG_A200_MSG_IMPORT_OK               = 'Importazione completata correttamente.';
  A000MSG_A200_ERR_IMPORT_ANOM             = 'Si sono verificate anomalie durante l''importazione.';

  A000MSG_B007_ERR_SINTASSI                = 'Sintassi non corretta per il nuovo valore.' + #13#10 +
                                             'Per ulteriori informazioni consultare l''help in linea.';
  A000MSG_B007_ERR_VAL_OLD_NON_PREVISTO    = 'Valore esistente non previsto!';
  A000MSG_B007_ERR_VAL_NEW_EMPTY           = 'Specificare il nuovo valore!';
  A000MSG_B007_ERR_DATO_AGG_EMPTY          = 'Selezionare il dato da aggiornare!';
  A000MSG_B007_ERR_NO_VALORI               = 'Specificare i nuovi valori da assegnare!';
  A000MSG_B007_ERR_CORRISPONDENZA_SINGOLA  = 'Indicare una sola corrispondenza ''Valore esistente - Nuovo valore''!';
  A000MSG_B007_ERR_DEFAULT                 = 'Specificare un solo valore di default!';
  A000MSG_B007_ERR_FMT_CANC_TAB            = 'Cancellazione %s terminata con anomalie';
  A000MSG_B007_ERR_FMT_DIP_NO_DATI         = 'Dipendente privo di dati (rapporto di lavoro: %s - %s)';
  A000MSG_B007_ERR_FMT_DIP_TAB             = 'Dipendente presente in tabella %s ma non in %s - progressivo: %s';
  A000MSG_B007_ERR_NO_MATRICOLA            = 'Selezionare almeno una matricola da cancellare!';
  A000MSG_B007_ERR_NO_TABELLA              = 'Nessuna tabella selezionata';
  A000MSG_B007_ERR_NO_CAUSALE              = 'Nessuna causale selezionata';
  A000MSG_B007_ERR_DATI_RICODIFICA         = 'Dati di ricodifica mancanti';
  A000MSG_B007_ERR_NO_CAUSALE_ASS          = 'Nessuna causale di assenza indicata';
  A000MSG_B007_ERR_SOLO_UN_DIP             = 'Impossibile effettuare l''unificazione per più di un dipendente!';
  A000MSG_B007_ERR_DATI_ANAG_UNIF          = 'Specificare i dati anagrafici per cui unificare!';
  A000MSG_B007_ERR_NO_MATR_UNIF            = 'Selezionare almeno una matricola da unificare!';
  A000MSG_B007_ERR_INDICARE_FILE_SCRIPT    = 'Selezionare il file contenente lo script da eseguire!';

  A000MSG_B007_DLG_CANCELLA_OK             = 'Codice cancellato correttamente';
  A000MSG_B007_DLG_RIPRISTINA_OK           = 'Codice ripristinato correttamente';
  A000MSG_B007_DLG_FMT_CONFERMA_STORICIZZA = 'Attenzione: verranno aggiornati i dati per i dipendenti selezionati' + #13#10 +
                                             '%s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_PERIODO_STORICIZZA  = 'nel periodo dal %s al %s.';
  A000MSG_B007_DLG_FMT_DAL_STORICIZZA      = 'a partire dal %s.';
  A000MSG_B007_DLG_FMT_CANC_DATI_DIP       = 'Verranno cancellati tutti i dati relativi a n. %s dipendenti selezionati.' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_ALL_TIMB_DIP        = 'Attenzione!'#13#10'Verranno riallineate le timbrature'#13#10'dal %s al %s'#13#10'per i %d dipendenti selezionati.'#13#10'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_CANC_DATI           = 'Attenzione!!! Verranno cancellati i dati delle tabelle ' + #13#10 +
                                             '%s' + #13#10 +
                                             'dalla data %s alla data %s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_CANC_SCHEDE_ANAG    = 'Confermi la cancellazione delle %s matricole selezionate?';
  A000MSG_B007_DLG_FMT_CANC_GIUST          = 'Attenzione!!! Verranno cancellati i giustificativi ' + #13#10 +
                                             '%s ' +
                                             'dalla data %s alla data %s' + #13#10 +
                                             '%s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_RICODIFICA          = 'Attenzione!!! Verranno ricodificati i Giustificativi %s ' + #13#10 +
                                             'dalla causale %s alla causale %s ' + #13#10 +
                                             'dalla data %s alla data %s ' + #13#10 +
                                             '%s' + #13#10 +
                                             'Vuoi continuare?';
  A000MSG_B007_DLG_FMT_RIALL_GIUST         = 'Verrà effettuato il riallineamento dei giustificativi corrispondenti' + #13#10 +
                                             'a partire dal %s per le %s anagrafiche selezionate.' + #13#10 +
                                             'L''elaborazione non considererà i giustificativi legati ai  familiari. ' + #13#10 +
                                             'Vuoi continuare?';

  A000MSG_B007_DLG_FMT_UNIFICAZIONE        = 'Confermi l''unificazione delle %s matricole selezionate sulla matricola di partenza ''%s'' ?';
  A000MSG_B007_DLG_FMT_RIPRISTINA_CODICE   = 'Ripristinare il codice "%s" ?';
  A000MSG_B007_DLG_FMT_RIPRISTINA_CODICI   = 'Ripristinare i codici "%s" ?';
  A000MSG_B007_DLG_FMT_CANCELLA_CODICE     = 'Cancellare definitavemente il codice "%s" ?';
  A000MSG_B007_DLG_FMT_CANCELLA_CODICI     = 'Cancellare definitavemente i codici "%s" ?';
  A000MSG_B007_DLG_FMT_RIDEF_RIPRISTINA    = 'Nella tabella "%s" esiste già il valore "%s".' + #13#10 +
                                             'Ridefinire il codice?';
  A000MSG_B007_DLG_FMT_UNIF_SERVIZIO       = 'Attenzione: la matricola di partenza %s non è in servizio alla Data di lavoro, mentre ' +
                                             'la matricola selezionata %s ha un periodo di servizio più recente. Confermi lo stesso l''unificazione?';

  A000MSG_B007_MSG_TUTTE_CAUS              = ', le Timbrature, le Schede Riepil., i Residui ';
  A000MSG_B007_MSG_DALLA_DATA              = 'Dalla data';
  A000MSG_B007_MSG_ALLA_DATA               = 'Alla data';
  A000MSG_B007_MSG_ERR_AGG_STORICO         = 'Decorrenza %s non aggiornata: %s %s diverso dal valore esistente %s';
  A000MSG_B007_MSG_NUM_DIP                 = 'per i %s dipendenti selezionati';

  A000MSG_B007_MSG_FMT_TUTTI_DIP_AZ        = 'L''operazione riguarda TUTTI i dipendenti dell''azienda %s';
  A000MSG_B007_MSG_FMT_ERR_RICODIFICA_CAU  = 'Ricodifica causale su %s terminata con anomalie';
  A000MSG_B007_MSG_FMT_INI_RIALL_GIUST     = 'Inizio riallineamento giustificativi per n. %s anagrafiche';
  A000MSG_B007_MSG_FINE_RIALL_GIUST        = 'Fine riallineamento giustificativi';
  A000MSG_B007_MSG_DIP_MESSO_SERVIZIO      = 'ATTENZIONE: IL DIPENDENTE NON ERA IN SERVIZIO E ADESSO LO E'', CONTROLLARE!';
  A000MSG_B007_MSG_DIP_DISMESSO_SERVIZIO   = 'ATTENZIONE: IL DIPENDENTE ERA IN SERVIZIO E ADESSO NON LO E'' PIU'', CONTROLLARE!';
  A000MSG_B007_MSG_ANOM_PERIODI_SERVIZIO   = 'ATTENZIONE: ANOMALIE NEI PERIODI DI SERVIZIO, CONTROLLARE!';
  A000MSG_B007_MSG_PIU_PERIODI_SERVIZIO    = 'ATTENZIONE: PIU'' PERIODI DI SERVIZIO APERTI, CONTROLLARE!';
  A000MSG_B007_MSG_FMT_TAB_DIPENDENTE      = 'Elenco delle prime 5 tabelle in cui è presente il dipendente: %s';
  A000MSG_B007_MSG_FMT_CANC_ERRORE         = 'Cancellazione %s terminata con errore %s';
  A000MSG_B007_MSG_UNIF_PERIODI_INTERSECANTI='Unificazione impossibile: sono presenti periodi di servizio (assunz.,cessaz.) intersecanti';
  A000MSG_B007_MSG_UNIF_PRESENZA_442        = 'Unificazione impossibile: sono presenti record di P442 con origine ''P'' o ''C'' (data cedolino %s, data retribuzione %s) su cedolini di anni esistenti anche sulla matricola di partenza';
  A000MSG_B007_MSG_FMT_UNIF_ANNO            = 'Unificazione impossibile: sono già presenti record di P504 con stesso anno (%s)';
  A000MSG_B007_MSG_FMT_UNIF_PRESENZA_441    = 'Unificazione impossibile: sono già presenti record di P441 con stessa data cedolino (%s), data retribuzione (%s), tipo_cedolino %s e record di P442 con origine ''P'' o ''C''';
  A000MSG_B007_MSG_FMT_ERR_254              = 'Unificazione fallita: aggiornamento P254_VOCIPROGRAMMATE terminato con errore %s';
  A000MSG_B007_MSG_FMT_PERIODO_STORICO      = 'Unificazione fallita: creazione periodo storico %s - %s terminata con errore %s';
  A000MSG_B007_MSG_PERIODI_STIP_ANTE        = 'Unificazione fallita: ci sono più periodi stipendiali antecenti il primo periodo storico';
  A000MSG_B007_MSG_FMT_PERIODO_STIPENDIALE  = 'Unificazione fallita: creazione periodo stipendiale %s - %s terminata con errore %s';
  A000MSG_B007_MSG_FMT_AGG_PERIODO_STIPENDIALE  = 'Unificazione fallita: aggiornamento  periodo stipendiale %s - %s terminata con errore %s';
  A000MSG_B007_MSG_FMT_ALL_STORICI          = 'Allineamento periodi storici terminato con errore %s';
  A000MSG_B007_MSG_FMT_ALL_STIPENDIALI      = 'Allineamento periodi stipendiali terminato con errore %s';

  A000MSG_C021_ERR_FMT_ELIMINA_DOC        = 'Errore durante l''eliminazione del documento:'#13#10'%s';
  A000MSG_C021_ERR_FMT_SALVA_DOC          = 'Errore durante il salvataggio del documento:'#13#10'%s';

  A000MSG_C700_ERR_NO_SELEZIONE            = 'Specificare il nome della selezione';
  A000MSG_C700_ERR_SELEZIONE_INESISTENTE   = 'Selezione inesistente';
  A000MSG_C700_ERR_FMT_SEL_GIA_ESISTENTE   = 'Selezione ''%s'' già esistente: impossibile sovrascrivere!';
  A000MSG_C700_DLG_FMT_SEL_GIA_ESISTENTE   = 'Selezione ''%s'' già esistente: sovrascrivere?';

  //Messaggi dei progetti CONDIVISI

  A000MSG_P032_ERR_COEFF_INVALIDO          = 'Impostare un coefficiente di cambio significativo!';

  A000MSG_P050_ERR_COD_VALUTA              = 'Codice valuta obbligatorio!';
  A000MSG_P050_ERR_COD_ARROTONDAMENTO      = 'Impossibile procedere perchè esistono delle valute legate a questo codice arrotondamento!';

  A000MSG_P501_ERR_DATE_INCONGRUENTI       = 'Le date di inizio e fine periodo per la dichiarazione relativa alle detrazioni IRPEF devono essere entrambe valorizzate o svuotate!';
  A000MSG_P501_ERR_DATE_ORDINATE           = 'Le date di inizio e fine periodo per la dichiarazione relativa alle detrazioni IRPEF devono essere in ordine cronologico!';
  A000MSG_P501_ERR_FMT_DATE_RANGE          = 'Le date di inizio e fine periodo per la dichiarazione relativa alle detrazioni IRPEF devono essere interne all''anno %s !';
  A000MSG_P501_ERR_FILEPDF_INESISTENTE     = 'Il percorso dell''archivio PDF è inesistente!';

  //Messaggi dei progetti PAGHE
  A000MSG_P000_MSG_DATO_SALVATO            = 'Il dato viene comunque salvato.';
  A000MSG_P000_MSG_DATI_SALVATI            = 'I dati vengono comunque salvati.';
  A000MSG_P000_ERR_VOCE_INESISTENTE        = 'Voce non esistente!';
  A000MSG_P000_ERR_FMT_NUMERO_RATE         = 'Il numero di rate deve essere un valore intero compreso tra 1 e %s!';
  A000MSG_P000_ERR_FMT_DATO_MIN_ZERO       = 'Attenzione: %s deve essere maggiore di zero!';
  A000MSG_P000_ERR_FMT_QUERYVOCE           = 'Non esiste la voce Contratto=%s Voce=%s Decorrenza(cassa)=%s Decorrenza(competenza)=%s.';
  A000MSG_P000_ERR_PERIODO                 = 'La data finale deve essere maggiore o uguale alla data iniziale!';
  A000MSG_P000_ERR_FMT_VAL_NUMERICO        = '%s errato! Il valore inserito deve essere numerico!';

  A000MSG_P010_ERR_ABI_ESISTENTE           = 'ABI già esistente!';

  A000MSG_P042_DLG_FMT_SCAGLIONI           = 'Confermi l''inserimento degli scaglioni IRPEF %s?';
  A000MSG_P042_ERR_IMPORTI                 = 'L''importo "Da" non deve superare l''importo "A"!';
  A000MSG_P042_ERR_FASCE                   = 'Intersezione tra le fasce!';
  A000MSG_P042_ERR_ULTIMO_IMP              = 'L''ultimo importo "A" deve essere a zero!';
  A000MSG_P042_MSG_SUPERO_SOGLIA           = 'L''addizionale supera la soglia di %s%%.';

  A000MSG_P092_ERR_POSIZIONE               = 'Il campo Posizione deve rispettare il seguente formato: xxxxxxxx/xx';
  A000MSG_P092_ERR_MINIM_MASSIM            = 'Il minimale non deve superare il massimale!';
  A000MSG_P092_ERR_RETR_MINIMALE           = 'Specificare la retribuzione minimale giornaliera!';
  A000MSG_P092_ERR_ORE_MESE                = 'Specificare le ore del mese ad orario normale!';
  A000MSG_P092_ERR_ACC_VOCI                = 'Specificare l''accorpamento voci per il calcolo retribuzione orario tabellare!';
  A000MSG_P092_ERR_FMT_ORE_MIN_ZERO        = 'Attenzione: le ore %s devono essere maggiori di zero!';

  A000MSG_P214_MSG_CONTROLLO_OK            = 'Non sono state riscontrate anomalie durante il controllo delle voci';
  A000MSG_P214_DLG_FMT_CANCELLA            = 'Attenzione: la cancellazione comporta l''eliminazione dell''accorpamento contenente %s voci. Confermi l''operazione?';
  A000MSG_P214_DLG_FMT_INSVOCI             = 'Confermi l''inserimento delle voci selezionate?';
  A000MSG_P214_ERR_COD_CONTRATTO           = 'Specificare il codice del Contratto voci!';

  A000MSG_P254_ERR_PERIODICITA             = 'La periodicità della rata deve essere compresa tra 1 e 12!';
  A000MSG_P254_ERR_COMPETENZA              = 'Il mese fisso di competenza deve essere minore o uguale alla data di inizio!';
  A000MSG_P254_ERR_COMPETENZA_VOCE         = 'Mese fisso di competenza non inseribile per voce diversa da ''Retribuzione base'' o ''Altro''!';
  A000MSG_P254_ERR_MESIPREC_VOCE           = 'Numero mesi precedenti la data di retribuzione non inseribile per voce diversa da ''Retribuzione base'' o ''Altro''!';
  A000MSG_P254_ERR_COMPETENZA_QM           = 'Mese fisso di competenza non inseribile per voce con unità di misura di formato ''Quantità mensile''!';
  A000MSG_P254_ERR_MESIPREC_QM             = 'Numero mesi precedenti la data di retribuzione non inseribile per voce con unità di misura di formato ''Quantità mensile''!';
  A000MSG_P254_ERR_RATA                    = 'Attenzione: l''importo della rata è nullo!';
  A000MSG_P254_ERR_SALDATA                 = 'La voce programmata deve essere impostata come saldata!';
  A000MSG_P254_ERR_INCR_RATA               = 'Attenzione: l''importo massimo dell''incremento su ultima rata è da intendersi in valore assoluto e quindi inserire solo valori positivi!';
  A000MSG_P254_ERR_IMPORTO_INCR_RATA       = 'Attenzione: l''importo massimo dell''incremento su ultima rata non può superare l''importo della rata stessa!';
  A000MSG_P254_ERR_BENEFICIARIO            = 'Non è possibile specificare il beneficiario quando l''importo rata è zero!';
  A000MSG_P254_ERR_AMM_INPDAP              = 'Tutti i campi del piano ammortamento INPDAP sono obbligatori!';
  A000MSG_P254_MSG_COMPETENZA_ANNI         = '- impostata una competenza precedente superiore a due anni';
  A000MSG_P254_MSG_DATA_INIZIO             = '- la Data inizio non coincide con l''inizio del mese';
  A000MSG_P254_MSG_DATA_FINE               = '- la Data fine non coincide con la fine del mese';
  A000MSG_P254_MSG_PIANO_AMM               = '- la voce prevede un piano di ammortamento INPDAP per il modello D.M.A.';
  A000MSG_P254_MSG_MESI_PREC               = '- non è stato impostato il N. mesi precedenti data retribuzione al valore 1 come già effettuato per la matricola %s.' + #13#10 +
                                             'Sono possibili dei problemi nel calcolo della corretta competenza dei contributi.';
  A000MSG_P254_MSG_PERIODO                 = '- la voce è già prevista su un altro periodo intersecante la Data inizio - Data fine';
  A000MSG_P254_MSG_NUOVI_IMPORTI           = 'Attenzione: Importo rata a zero, non verrano aperte nuove posizioni per la voce.';

  A000MSG_P262_ERR_COD_CAAF                = 'Specificare il codice C.A.F.!';
  A000MSG_P262_ERR_DATA_RICEZIONE          = 'Specificare la data ricezione!';
  A000MSG_P262_ERR_PERC_MAG_100            = 'Attenzione: la percentuale di rimborso a Luglio deve essere minore di 100!';
  A000MSG_P262_ERR_PERC_VAL_RIMB           = 'La percentuale di rimborso a Luglio è valorizzabile solo per gli importi da rimborsare nel mese stesso!';
  A000MSG_P262_ERR_PERC_VAL_ASSFISC        = 'La percentuale di rimborso a Luglio è valorizzabile solo nel caso in cui non sia ancora iniziata l''assistenza fiscale dell''anno!';
  A000MSG_P262_ERR_IMP_INIZIALE            = 'l''Importo iniziale è uguale a zero';
  A000MSG_P262_ERR_FMT_DATO_AUTOMATICO     = '%s deve essere gestito automaticamente dal programma';
  A000MSG_P262_ERR_DIMESSO                 = 'è stata assegnata una voce di trattenuta ad un dimesso prima del 30 Giugno e pertanto non verrà inserita nel cedolino di Luglio.';

  A000MSG_P268_ERR_VOCE_NO_ELENCO          = 'L''inserimento di questa voce non è previsto!';
  A000MSG_P268_ERR_VOCE_DUPLICATA          = 'Voce già caricata!';
  A000MSG_P268_ERR_FMT_PERC_RITENUTA       = '- la ritenuta %s non corrisponde al %s%% di %s';
  A000MSG_P268_MSG_RITENUTE                = '- si ricorda che l''importo delle ritenute deve essere coerente con gli imponibili, in applicazione dei corretti scaglioni e percentuali';
  A000MSG_P268_ERR_FMT_VOCI_CONGUAGLIO     = '- ai fini del corretto conguaglio è obbligatorio inserire tutte le voci %s';
  A000MSG_P268_ERR_FMT_VOCI_IMPONIBILE     = 'Le voci %s devono avere tutte lo stesso imponibile!';
  A000MSG_P268_ERR_FMT_DATO_MIN_ZERO       = 'Il valore del dato ''%s'' deve essere maggiore o uguale a zero!';
  A000MSG_P268_ERR_DECOR_ANAG              = 'Verificare che la decorrenza sull''anagrafica stipendiale del dipendente sia antecedente al Mese cedolino inserito.';
  A000MSG_P268_ERR_GG_DETRAZ               = 'Esiste già il cedolino normale per Gennaio: impossibile caricare anche i giorni lavoro dipendente.' + #13#10 + 'Azzerarli';
  A000MSG_P268_ERR_CEDOLINO_GIA_ESISTENTE  = 'Esiste già il cedolino normale per il mese: impossibile caricare anche il cedolino del rapporto precedente.' + #13#10 +
                                             'Inserire quest''ultimo su Gennaio o sul mese precedente al primo cedolino elaborato nell''anno';
  A000MSG_P268_MSG_INS_DATI                = '- occorre inserire le addizionali IRPEF già pagate per l''anno corrente sulla relativa tabella specificando Tipo versamento a Saldo' + #13#10 +
                                             '- occorre inserire i familiari a carico con decorrenza da inizio anno';
  A000MSG_P268_MSG_CF_MANCANTE             = '- non avendo indicato il Codice fiscale del soggetto che ha corrisposto il reddito esso si intende prodotto all''interno dell''azienda stessa ' +
                                             'e, pertanto, non sarà oggetto di denuncia sui modelli CU e 770 nella sezione ''REDDITI EROGATI DA ALTRI SOGGETTI''';

  A000MSG_P450_ERR_MESE_RI13A              = 'Il numero manuale dei ratei annuali può essere inserito solo sul mese di dicembre!';
  A000MSG_P450_ERR_MESE_CIAAP              = 'Il conguaglio IRPEF anno precedente può essere inserito solo sui mesi di gennaio o febbraio!';
  A000MSG_P450_ERR_VALORE_RI13A            = 'Il numero manuale dei ratei annuali deve essere compreso tra 0 e 12!';
  A000MSG_P450_ERR_NUMERO_DECIMALI         = 'Numero di decimali superiore a quelli previsti!';
  A000MSG_P450_ERR_VALORE_TESTO            = 'Il valore inserito deve essere tra quelli previsti. Consultare la lista!';
  A000MSG_P450_ERR_VARIAZIONE_TESTO        = 'Variazione non prevista per campi non numerici!';

  A000MSG_P460_ERR_DATI_NULLI              = 'Inserire tutti i dati!';
  A000MSG_P460_DLG_FMT_INSCANC_PERIODO     = 'Effettuare %s delle quantità mensili per il periodo selezionato?';
  A000MSG_P460_ERR_PERIODO_COMPETENZA      = 'Il periodo di competenza dal/al risulta non interamente coperto dall''assunzione!';

  A000MSG_P652_MSG_NO_REGOLA               = 'Non esiste alcuna regola originale.';
  A000MSG_P652_ERR_NO_MODIFICA             = 'Modifica consentita solo per le regole impostate come ''Regola modificabile''';
  A000MSG_P652_DLG_RIPRISTINO_REGOLA       = 'Confermi il ripristino della regola di calcolo originale' + #13#10 +
                                             'sostituendo quella manuale ? ';

  A000MSG_P655_ERR_TIPO_RECORD_MANUALI     = 'Modifica dei dai consentita solo se indicati';
  A000MSG_P655_ERR_PARTE                   = 'Il valore indicato nel campo Parte non è valido. Selezionarne uno dalla lista!';
  A000MSG_P655_ERR_NUMERO                  = 'Il valore indicato nel campo Numero non è valido. Selezionarne uno dalla lista!';
  A000MSG_P655_ERR_ARROTONDAMENTO          = 'Manca l''arrotondamento: formattazione non effettuata';
  A000MSG_P655_ERR_CHIUSO                  = 'L''elaborato risulta già chiuso per cui non può essere cancellato';
  A000MSG_P655_DLG_FMT_CANCELLA            = 'Attenzione: la cancellazione comporta l''eliminazione della testata e dei dati elaborati ' + #13#10 +
                                             'di %s dipendenti . Confermi l''operazione ?';



  A000MSG_P656_ERR_FMT_NO_FORNIT_ANTE      = 'Non esiste fornitura da esportare relativa al mese %s';
  A000MSG_P656_ERR_FMT_FORNIT_GIA_ESISTENTE= 'Esiste già una fornitura chiusa riferita al %s! ' + #13#10 +
                                             'Impossibile proseguire con l''elaborazione';
  A000MSG_P656_ERR_FMT_FORNIT_NON_ESISTENTE= 'Non esiste fornitura aperta del %s! ' + #13#10 +
                                             'Impossibile proseguire con l''elaborazione';
  A000MSG_P656_ERR_MESE                    = '''Mese a'' deve esse successivo o uguale a ''Mese da''';
  A000MSG_P656_ERR_DATE_ANNO               = 'Le date indicate nei campi ''Mese da'' e ''Mese a'' devono essere riferite allo stesso anno.';
  A000MSG_P656_ERR_DEL_FILE                = 'Impossibile procedere alla sostituzione del file. Verificare che il file non sia in uso';
  A000MSG_P656_ERR_SCRIT_FILE              = 'Errore scrittura su file';

  A000MSG_P656_DLG_FMT_FORNIT_ANTE         = 'Esistono una o più forniture antecedenti a %s non chiuse! Proseguire comunque l''elaborazione del nuovo periodo?';
  A000MSG_P656_DLG_CHIUSURA                = 'Confermi l''operazione di chiusura della fornitura mensile?';
  A000MSG_P656_DLG_FILE_ESISTENTE          = 'Il file indicato per l''esportazione è già esistente. Proseguire comunque sostituendolo con i nuovi dati?';

  A000MSG_R101_MSG_PSW_SCADUTA             = 'La password è scaduta! Inserirne una nuova';

  A000MSG_R400_MSG_RILEVAZIONE_MESE        = 'RILEVAZIONE DEL MESE DI';
  A000MSG_R400_MSG_AGGIORNAMENTO_SCHEDA    = 'CON AGGIORNAMENTO DELLA SCHEDA RIEPILOGATIVA';

  A000MSG_S031_ERR_FMT_CANCFAM_GIUSTIF      = 'Impossibile eliminare il familiare!' + #13#10 +
                                              'Sono presenti %s giustificativi nel periodo compreso tra il %s e il %s.';
  A000MSG_S031_ERR_GRADO_NESSUNO            = 'Esiste già un familiare con grado di parentela ''Nessuno''!';
  A000MSG_S031_ERR_MATR_NULLA               = 'Specificare la matricola di riferimento del dipendente!';
  A000MSG_S031_ERR_MATR_NODIP               = 'La matricola specificata non è quella del dipendente selezionato!';
  A000MSG_S031_ERR_MATR_DIP                 = 'La matricola specificata non può essere quella del dipendente selezionato!';
  A000MSG_S031_ERR_FMT_CF_DOPPIO            = 'Codice fiscale già utilizzato per il familiare con numero ordine %s !';
  A000MSG_S031_ERR_FMT_GRADO                = 'Per la parentela ''%s'' occorre specificare un grado superiore o uguale a %s!';
  A000MSG_S031_ERR_IRPEF                    = 'Grado di parentela incompatibile con il tipo di detrazione IRPEF!';
  A000MSG_S031_ERR_PERC_NULLA               = 'Familiare con detrazione IRPEF ma percentuale di carico sul dipendente nulla!';
  A000MSG_S031_ERR_PERC_NON_NULLA           = 'Detrazione IRPEF per nessun familiare ma percentuale di carico sul dipendente valorizzata!';
  A000MSG_S031_ERR_ANF                      = 'Il familiare non può fare parte del nucleo per l''assegno!';
  A000MSG_S031_ERR_DATADOZ_NULLA            = 'Specificare la data di nascita o la data di adozione del familiare!';
  A000MSG_S031_ERR_DATANAS_NULLA            = 'Specificare la data di nascita del familiare!';
  A000MSG_S031_ERR_FMT_COMUNE_NULLO         = 'Specificare il comune di %s del familiare!';
  A000MSG_S031_ERR_CF_NULLO                 = 'Specificare il codice fiscale del familiare!';
  A000MSG_S031_ERR_FMT_M3G_NULLO            = 'Specificare il motivo terzo grado %s!';
  A000MSG_S031_ERR_AAREV_NULLO              = 'Specificare la data di revisione della disabilità del familiare!';
  A000MSG_S031_ERR_ALTERN_NULLA             = 'Specificare il tipo soggetto dell''alternativa!';
  A000MSG_S031_ERR_DISAB_NULLA              = 'Specificare il tipo di disabilità!';
  A000MSG_S031_ERR_DATA_ADOZ_NULLA          = 'E'' necessario indicare obbligatoriamente la data di adozione!';
  A000MSG_S031_ERR_FMT_PERIODO              = '%s deve essere maggiore o uguale %s!';
  A000MSG_S031_MSG_INIZIO_EFF               = 'L''inizio gravidanza effettivo non può essere successivo all''inizio scelto dal dipendente!';
  A000MSG_S031_ERR_ALLINEA                  = 'Allineamento dati fallito. Valori Originali non trovati.';
  A000MSG_S031_MSG_FMT_INCOMPATIBILE        = 'il grado di parentela potrebbe essere incompatibile con il %s';
  A000MSG_S031_MSG_FMT_NULLO                = '%s non indicato';
  A000MSG_S031_MSG_FMT_INIZIO_FUORI_PERIODO = '%s non è compreso nel periodo previsto (%s)';
  A000MSG_S031_MSG_DATA_PREADOZ             = 'La data di pre-adozione deve essere valorizzata solo se tipo adozione internazionale!';
  A000MSG_S031_DLG_FMT_DATA_DICHIARAZIONE   = 'Impostare la Data ultima dichiarazione familiari a carico al %s ?';
  A000MSG_S031_DLG_DATA_DICHIARAZIONE_VUOTA = 'Attenzione! Si sta svuotando la Data ultima dichiarazione familiari a carico per tutti i familiari del dipendente selezionato. Proseguire? ';

  A000MSG_S210_ERR_NO_FILE                 = 'Specificare il nome del file di esportazione!';
  A000MSG_S210_DLG_FILE_ESISTE             = 'Il file indicato per l''esportazione è già esistente. Proseguire comunque sostituendolo con i nuovi dati?';
  A000MSG_S210_ERR_FILE_IN_USO             = 'Impossibile procedere alla sostituzione del file. Verificare che il file non sia in uso';
  A000MSG_S210_ERR_LIMITE_ANAGRAFICHE      = 'Non è possibile esportare il curriculum di più di 50 dipendenti per volta. Limitare la selezione anagrafica.';
  A000MSG_S210_MSG_NO_INCARICO_ATTUALE     = 'Impossibile esportare il curriculum: incarico attuale non indicato!';

  A000MSG_S250_FMT_DATA_NO_SUCCESSIVA      = 'La %s non può essere successiva alla %s!';

  A000MSG_S715_ERR_NO_TIPO_QUOTA           = 'Selezionare almeno una tipologia quota per l''aggiornamento degli incentivi!';
  A000MSG_S715_ERR_NO_STATO_AVANZAMENTO    = 'Selezionare almeno uno stato avanzamento dall''elenco!';
  A000MSG_S715_DLG_FMT_CONFERMA_ESEGUI     = 'Attenzione! Sulle schede corrispondenti ai filtri selezionati verranno eseguite le seguenti azioni: %s ' + #13#10 +
                                             'Proseguire?';

  A000MSG_S730_ERR_DIST_SCALE_PUNT         = 'Impossibile accedere! Impostare a livello aziendale il dato anagrafico per la distinzione delle scale di punteggio!';

  A000MSG_S746_ERR_DATE_DA_VALORIZZARE     = 'Le date di inizio e fine periodo per la compilazione devono essere entrambe valorizzate!';
  A000MSG_S746_ERR_DATE_VAL_O_SVUO         = 'Le date di inizio e fine periodo per la richiesta di presa visione devono essere entrambe valorizzate o svuotate!';
  A000MSG_S746_ERR_ORDINE_DATE_RICH        = 'Le date di inizio e fine periodo per la richiesta di presa visione devono essere in ordine cronologico!';
  A000MSG_S746_ERR_ORDINE_DATE_COMP        = 'Le date di inizio e fine periodo per la compilazione devono essere in ordine cronologico!';
  A000MSG_S746_ERR_FMT_PERIODO_INTERNO     = 'Attenzione! Il periodo per la compilazione non è interno all''anno %s !';

  A000MSG_C018_ERR_STOP_DATA_ANTECEDENTE   = 'Non è possibile effettuare la richiesta prima del %s!';
  A000MSG_C018_MSG_NESSUN_ALLEGATO         = '(nessun allegato)';
  A000MSG_C018_ERR_PRESENZA_ALLEGATI       = 'La richiesta da eliminare ha documenti allegati.'#13#10'Cancellazione non consentita!';
  A000MSG_C018_ERR_FMT_CONDIZ_ALLEG        = 'Riconoscimento della gestione allegati per la struttura "%s" fallito: %s';
  A000MSG_C018_ERR_FMT_FLAG_CONDIZ_ALLEG   = 'Tipo di gestione allegati per la struttura "%s" non valido: %s'#13#10'Valori ammessi: N, F, O';
  A000MSG_C018_MSG_NOABIL_ALL_AUT          = 'l''autorizzatore può esclusivamente consultare gli allegati';
  A000MSG_C018_MSG_NOABIL_ALL_RIC_DA_AUT   = 'la richiesta è ancora da autorizzare';
  A000MSG_C018_MSG_FMT_NOABIL_ALL_RIC_AUT  = 'è %s la modifica degli allegati per le richieste autorizzate definitivamente';
  A000MSG_C018_MSG_NOABIL_ALL_RIC_NEG      = 'la richiesta è negata';
  A000MSG_C018_MSG_NOABIL_ALL_RIC_ANNULL   = 'la richiesta è annullata';

  A000MSG_WC018_MSG_FMT_RIEPILOGO_ITER     = 'Riepilogo Iter %s (%s)';
  A000MSG_WC018_MSG_RICHIESTA              = 'Richiesta';
  A000MSG_WC018_DLG_SALVA_NOTE             = 'Salvare le modifiche alle note?';
  A000MSG_WC018_MSG_NESSUNA_NOTA           = '(nessuna nota)';

  A000MSG_WC026_ERR_SELEZIONARE_DOC        = 'Selezionare il documento da allegare alla richiesta!';
  A000MSG_WC026_ERR_FMT_DOC_UPLOAD         = 'Errore durante l''upload del documento:'#13#10'%s';
  A000MSG_WC026_ERR_FMT_DOC_DOWNLOAD       = 'Errore durante il download del documento:'#13#10'%s';
  A000MSG_WC026_ERR_DOC_INESISTENTE        = 'Il documento allegato non esiste!';

  A000MSG_WC027_ERR_FMT_ELIMINA_DOC        = 'Errore durante l''eliminazione del documento:'#13#10'%s';
  A000MSG_WC027_ERR_FMT_SALVA_DOC          = 'Errore durante il salvataggio del documento:'#13#10'%s';

  A000MSG_R003_ERR_FORMATO_GIUST           = 'Formato non corretto: (C)odice o (D)escrizione';
  A000MSG_R003_ERR_FORMATO_DIM_GIUST       = 'Formato non corretto: inserire la dimensione dopo C/D';
  A000MSG_R003_ERR_FORMATO_TIMBR           = 'Formato non corretto: (T)imbratura (C)ausale (R)ilevatore (S)igla causale';
  A000MSG_R003_ERR_DUPLICA_TROPPO_LUNGO    = 'Codice nuova stampa troppo lungo!';
  A000MSG_R003_ERR_DUPLICA_ESISTENTE       = 'Codice nuova stampa già esistente!';
  A000MSG_R003_ERR_DUPLICA_VUOTO           = 'Codice nuova stampa non indicato!';
  A000MSG_R003_ERR_DATO_ESISTENTE          = 'Dato già esistente! Usare un altro nome';
  A000MSG_R003_ERR_NO_DATO_STAMPA          = 'Non è stato selezionato nessun dato da stampare: Impossibile proseguire!';
  A000MSG_R003_ERR_AREA_STAMPA_PENDING     = 'Esistono Modifiche non confermate sulle griglie di intestazione o dettaglio. Confermare o annullare i dati su queste';
  A000MSG_R003_ERR_DATE_NON_CORRETTE       = 'Date non corrette!';
  A000MSG_R003_ERR_DELETE_USATO            = 'Dato utilizzato nelle stampe: impossible cancellarlo!';

  A000MSG_R003_MSG_STAMPA_BLOCCATA         = 'Impossibile modificare/cancellare una stampa protetta';
  A000MSG_R003_MSG_NO_TABELLA              = 'Nome tabella da generare non indicato!';
  A000MSG_R003_MSG_SPECIFICARE_STAMPA      = 'Specificare la stampa da generare!';
  A000MSG_R003_MSG_PERIODO_MAGGIORE_2_ANNI = 'Il periodo specificato non può essere superiore ai 2 anni!';
  A000MSG_R003_MSG_CONFERMA_SOSTITUISCI    = 'Sostituire le occorrenze del dato col nuovo nome?';

  A000MSG_DATIBLOCCATI_ERR_FMT_DATI_NONMODIF  = '%s : [%s] dati non modificabili, riepilogo bloccato';

function A000TraduzioneEccezioni(Msg:String):String;

implementation

function A000TraduzioneEccezioni(Msg:String):String;
begin
  Result:=Msg;

  if (Pos('Field ',Result) = 1) then
  begin
    Result:=StringReplace(Result,'Field ','Il dato ',[]);
  end;
  Result:=StringReplace(Result,'The following exception occured' + #13#10,'',[]);
  Result:=StringReplace(Result,'must have a value','deve essere valorizzato',[]);
  Result:=StringReplace(Result,'is not a valid date and time','non è una data/ora valida',[]);
  Result:=StringReplace(Result,'is not a valid date','non è una data valida',[]);
  // daniloc. - aggiunto 01/12/2014
  Result:=StringReplace(Result,'is not a valid value for field ','non è un valore valido per il dato ',[]);
  Result:=StringReplace(Result,'The allowed range is ','Indicare un valore compreso fra ',[]);
  Result:=StringReplace(Result,' to ',' e ',[]);
end;

end.


