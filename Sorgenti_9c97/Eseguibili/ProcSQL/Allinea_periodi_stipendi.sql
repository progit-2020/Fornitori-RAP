CREATE OR REPLACE PROCEDURE 
ALLINEA_PERIODI_STIPENDI (PROGIRIS                  IN  NUMBER                ,     -- progressivo del dipendente
                         ERRORE                     OUT VARCHAR2              ,     -- eventuale errore occorso
                         AGGIORNA_ASSEG_AUTO_LIBERA IN  VARCHAR2              ,     -- specifica se sovrascrivere il campo gi� valorizzato nelle relazioni di tipo libero
                         ESEGUI_TUTTE_RELAZIONI     IN  VARCHAR2 DEFAULT 'N'  ,     -- specifica se considerare tutte le relazioni o solo quelle eventualmente modificate
                         PRE_ALLINEA_ESEGUITA       IN  VARCHAR2 DEFAULT 'N'  ,     -- se vale 'S' serve a non eseguire la PreAllineaPeriodiStipendi per ogni dipendente
                         sCAMPI_NOT_NULL            IN  VARCHAR2 DEFAULT NULL ,     -- contiene l'elenco dei valori di default dei campi not null
                         sESP_CUR_REL               IN  VARCHAR2 DEFAULT NULL ,     -- contiene la condizione per ricalcolare solo le relazioni modificate
                         sDECORRENZE                IN  VARCHAR2 DEFAULT NULL ,     -- contiene il massimo dettaglio delle decorrenze per creare i periodi storici
                         CAMPI_SEL                  IN  VARCHAR2 DEFAULT NULL ,     -- contiene l'elenco dei campi da estrarre per l'appiattimento dei record
                         TAB_FROM                   IN  VARCHAR2 DEFAULT NULL ,     -- contiene l'elenco delle tabelle per l'appiattimento dei record
                         COND_WHERE                 IN  VARCHAR2 DEFAULT NULL ) AS  -- contiene l'elenco delle condizioni per l'appiattimento dei record
-- Questa procedura richiamata per ogni dipendente crea un periodo storico per ogni decorrenza dei dati storici,
-- aggiorna le relazioni per ognuno di essi e infine verifica se i dati del periodo successivo sono uguali
-- a quelli del precedente unificando in questo caso i due periodi
  -- DICHIARAZIONE CURSORI
  CURSOR CLOCK (p_prog INTEGER) IS
    SELECT decorrenza
    FROM   P430_ANAGRAFICO
    WHERE  progressivo = p_prog
    FOR UPDATE NOWAIT;
  CURSOR CT430 (p_prog INTEGER) IS
    SELECT datadecorrenza
    FROM   T430_STORICO
    WHERE  progressivo = p_prog;
  CURSOR CP430 (p_prog       INTEGER,
                p_decorrenza I030_RELAZIONI_ANAGRAFE.decorrenza%TYPE,
                p_scadenza   I030_RELAZIONI_ANAGRAFE.decorrenza_fine%TYPE) IS
    SELECT rowid, decorrenza, decorrenza_fine
    FROM   P430_ANAGRAFICO
    WHERE  progressivo = p_prog
    AND    decorrenza between p_decorrenza and p_scadenza
    ORDER BY decorrenza;
  CURSOR CI035 (p_tabella     I035_RELAZIONI_DETTAGLIO.tabella%TYPE,
                p_colonna     I035_RELAZIONI_DETTAGLIO.colonna%TYPE,
                p_decorrenza  I035_RELAZIONI_DETTAGLIO.decorrenza%TYPE) IS
    SELECT I035.relazione, I035.num
    FROM   I035_RELAZIONI_DETTAGLIO I035
    WHERE  I035.tabella = p_tabella
    AND    I035.colonna = p_colonna
    AND    I035.decorrenza = p_decorrenza
    ORDER BY I035.num;
  CURSORE_DINAMICO_I030       INTEGER;
  CURS_I030                   INTEGER;
  CURSORE_DINAMICO_SEL_REL    INTEGER;
  CURS_SEL_REL                INTEGER;
  CURSORE_DINAMICO_UPD_REL    INTEGER;
  CURS_UPD_REL                INTEGER;
  CURSORE_DINAMICO_P430       INTEGER;
  CURS_P430                   INTEGER;
  CURSORE_DINAMICO_V430       INTEGER;
  CURS_V430                   INTEGER;
  --
  -- DICHIARAZIONE ARRAY
  TYPE CAMPI_NOT_NULL_TYPE IS RECORD
    (x430_colonna   VARCHAR2(100),
     data_default   VARCHAR2(100));
  TYPE ARRAY_CAMPI_NOT_NULL IS TABLE OF CAMPI_NOT_NULL_TYPE INDEX BY BINARY_INTEGER;
  CAMPI_NOT_NULL_ARR ARRAY_CAMPI_NOT_NULL;
  --
  -- DICHIARAZIONE VARIABILI
  I                           INTEGER         :=0 ;
  ESPRESSIONE                 VARCHAR2(32767) :='';
  SRELAZIONE                  VARCHAR2(32767) :='';
  SRELAZIONE_ORI              VARCHAR2(32767) :='';
  sAPPOGGIO                   VARCHAR2(32767) :='';
  wDECORRENZE                 VARCHAR2(32767) :='';
  wCAMPI_NOT_NULL             VARCHAR2(32767) :='';
  wESP_CUR_REL                VARCHAR2(32767) :='';
  I030_TABELLA                VARCHAR2(30)    :='';
  I030_COLONNA                VARCHAR2(30)    :='';
  I030_TAB_ORIGINE            VARCHAR2(30)    :='';
  I030_TIPO                   VARCHAR2(1)     :='';
  S_APP_DEC                   VARCHAR2(32767) :='';
  S_APP_CNN                   VARCHAR2(32767) :='';
  OLDCAMPO                    VARCHAR2(1000)  :='';
  NEWCAMPO                    VARCHAR2(1000)  :='';
  VALORE                      VARCHAR2(100)   :='';
  wCAMPI_SEL                  VARCHAR2(32767) :='';
  wTAB_FROM                   VARCHAR2(32767) :='';
  wCOND_WHERE                 VARCHAR2(32767) :='';
  NROWID                      VARCHAR2(20)    :='';
  NROWIDUPDATE                VARCHAR2(20)    :='';
  NROWIDLOCK                  VARCHAR2(20)    :='';
  VALOREDATI1                 VARCHAR2(10000) :='';
  VALOREDATIOLD               VARCHAR2(10000) :='';
  cursor_name                 INTEGER         :=0 ;
  rows_processed              INTEGER         :=0 ;
  PART                        INTEGER         :=0 ;
  ARR                         INTEGER         :=0 ;
  CONTINUA_ESTR_RELAZIONE     BOOLEAN             ;
  CONTINUA_ESTR_RELAZIONE_ORI BOOLEAN             ;
  I030_DECORRENZA             DATE                ;   -- inizio decorrenza estratta dal cursore sulle relazioni
  I030_SCADENZA               DATE                ;   -- fine   decorrenza estratta dal cursore sulle relazioni
  DECO_MIN                    DATE                ;   -- minima decorrenza della T430
  DEC_STO                     DATE                ;   -- decorrenza per la creazione dello storico
  dDEC_INI                    DATE                ;   -- inizio decorrenza ricavata dal cursore su P430 al massimo dettaglio
  dDECINIZ                    DATE                ;   -- inizio decorrenza per l'appiattimento dei record senza storicizzazioni
  dDECFINE                    DATE                ;   -- fine   decorrenza per l'appiattimento dei record senza storicizzazioni
  ULTIMAdFINE                 DATE                ;   -- fine   decorrenza per l'appiattimento dei record senza storicizzazioni
  dFINE_PREC                  DATE                ;   -- fine   decorrenza per l'appiattimento dei record senza storicizzazioni
  dDECORRENZA                 DATE                ;   -- inizio decorrenza per allineare la prima data degli Stipendi con la prima delle Presenze

  PROCEDURE RECUPERA_RELAZIONE IS
  BEGIN
    CONTINUA_ESTR_RELAZIONE:=FALSE;
    SRELAZIONE:='';
    -- RICAVO L'SQL DELLA RELAZIONE
    FOR RI035 IN CI035 (I030_TABELLA,
                        I030_COLONNA,
                        I030_DECORRENZA) LOOP
      CONTINUA_ESTR_RELAZIONE:=FALSE;
      IF RI035.NUM > PART AND RI035.NUM <= ARR THEN
        SRELAZIONE:=SRELAZIONE||' '||RI035.RELAZIONE;
      ELSIF RI035.NUM > PART AND RI035.NUM > ARR THEN
        PART:=PART + 20;
        ARR:=ARR + 20;
        CONTINUA_ESTR_RELAZIONE:=TRUE;
        EXIT;
      END IF;
    END LOOP; -- FINE CI035 --
    SRELAZIONE:=RTRIM(LTRIM(SRELAZIONE));
    IF SRELAZIONE IS NOT NULL THEN
      WHILE INSTR(SRELAZIONE,'<#>') > 0 LOOP
        sAPPOGGIO:=SUBSTR(SRELAZIONE,INSTR(SRELAZIONE,'<#>')+3);
        OLDCAMPO:=SUBSTR(sAPPOGGIO,1,INSTR(sAPPOGGIO,'<#>')-1);
        IF OLDCAMPO = ';' THEN
          NEWCAMPO:=' UNION SELECT ';
        ELSIF OLDCAMPO = 'W' THEN
          NEWCAMPO:=' FROM '||I030_TAB_ORIGINE||' T1 WHERE T1.PROGRESSIVO = '||TO_CHAR(PROGIRIS);
          IF I030_TAB_ORIGINE = 'T430_STORICO' THEN
            NEWCAMPO:=NEWCAMPO||' AND :dDEC_INI BETWEEN T1.DATADECORRENZA AND T1.DATAFINE AND ';
          ELSE
            NEWCAMPO:=NEWCAMPO||' AND :dDEC_INI BETWEEN T1.DECORRENZA AND T1.DECORRENZA_FINE AND ';
          END IF;
        ELSIF OLDCAMPO = 'D' THEN
          NEWCAMPO:=' FROM '||I030_TAB_ORIGINE||' T1 WHERE T1.PROGRESSIVO = '||TO_CHAR(PROGIRIS);
          IF I030_TAB_ORIGINE = 'T430_STORICO' THEN
            NEWCAMPO:=NEWCAMPO||' AND :dDEC_INI BETWEEN T1.DATADECORRENZA AND T1.DATAFINE ';
          ELSE
            NEWCAMPO:=NEWCAMPO||' AND :dDEC_INI BETWEEN T1.DECORRENZA AND T1.DECORRENZA_FINE ';
          END IF;
        ELSE
          NEWCAMPO:='T1.'||OLDCAMPO;
        END IF;
        SRELAZIONE:=REPLACE(SRELAZIONE,'<#>'||OLDCAMPO||'<#>',NEWCAMPO);
      END LOOP; -- FINE RICERCA <#> --
      IF NVL(SUBSTR(SRELAZIONE,LENGTH(SRELAZIONE)-13,14),'#NULL#') = ' UNION SELECT ' THEN
        SRELAZIONE:=SUBSTR(SRELAZIONE,1,LENGTH(SRELAZIONE)-14);
      END IF;
      IF LENGTH(SRELAZIONE) > 0 THEN
        IF SUBSTR(SRELAZIONE,1,6) <> 'SELECT' THEN
          SRELAZIONE:='SELECT '||SRELAZIONE;
        END IF;
        IF INSTR(SRELAZIONE,' FROM ') = 0 THEN
          SRELAZIONE:=SRELAZIONE||' FROM '||I030_TAB_ORIGINE||' T1 WHERE T1.PROGRESSIVO = '||TO_CHAR(PROGIRIS);
          IF I030_TAB_ORIGINE = 'T430_STORICO' THEN
            NEWCAMPO:=NEWCAMPO||' AND :dDEC_INI BETWEEN T1.DATADECORRENZA AND T1.DATAFINE ';
          ELSE
            NEWCAMPO:=NEWCAMPO||' AND :dDEC_INI BETWEEN T1.DECORRENZA AND T1.DECORRENZA_FINE ';
          END IF;
        END IF;
      END IF;
      SRELAZIONE:=RTRIM(LTRIM(SRELAZIONE));
    END IF;
  END;
-- INIZIO ELABORAZIONE
BEGIN
  -- Imposto condizione di non errore nella varibile di output
  ERRORE:='';
  -- TENTO DI LOCKARE TUTTE LE DECORRENZE DEL DIPENDENTE SU P430
  BEGIN
    FOR TLOCK IN CLOCK (PROGIRIS) LOOP
      NULL;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      -- Imposto condizione di errore per dipendente occupato
      ERRORE:='OC';
      ROLLBACK;
      GOTO FINE_AGGIORNAMENTO;
  END;
  -- CHIUDO GLI EVENTUALI BUCHI TRA LE DECORRENZE DI P430
  FOR RP430 IN CP430 (PROGIRIS,TO_DATE('01011900','DDMMYYYY'),TO_DATE('31123999','DDMMYYYY')) LOOP
    IF NROWIDUPDATE IS NOT NULL THEN
      IF dFINE_PREC <> RP430.DECORRENZA - 1 THEN
        UPDATE P430_ANAGRAFICO SET DECORRENZA_FINE = RP430.DECORRENZA - 1 WHERE ROWID = NROWIDUPDATE;
      END IF;
    END IF;
    NROWIDUPDATE:=RP430.ROWID;
    dFINE_PREC:=RP430.DECORRENZA_FINE;
  END LOOP; -- FINE CP430 --
  IF NROWIDUPDATE IS NOT NULL THEN
    UPDATE P430_ANAGRAFICO SET DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY') WHERE ROWID = NROWIDUPDATE;
  END IF;
  -- INIZIALIZZO LE VARIABILI IN BASE AI PARAMETRI
  wCAMPI_NOT_NULL:=sCAMPI_NOT_NULL;
  wESP_CUR_REL:=sESP_CUR_REL;
  wDECORRENZE:=sDECORRENZE;
  wCAMPI_SEL:=CAMPI_SEL;
  wTAB_FROM:=TAB_FROM;
  wCOND_WHERE:=COND_WHERE;
  -- RICHIAMO LA PRE_ALLINEA SE NON � GI� STATO FATTO
  IF PRE_ALLINEA_ESEGUITA = 'N' THEN
    PRE_ALLINEA_PERIODI_STIPENDI(wCAMPI_NOT_NULL,wESP_CUR_REL,wDECORRENZE,wCAMPI_SEL,wTAB_FROM,wCOND_WHERE);
  END IF;
  -- VERIFICO SE CONSIDERARE TUTTE LE RELAZIONI O SOLO QUELLE EVENTUALMENTE MODIFICATE
  IF ESEGUI_TUTTE_RELAZIONI = 'S' THEN
    wESP_CUR_REL:='';
  END IF;
  -- CICLO SULLE DECORRENZE DELLA T430
  FOR RT430 IN CT430 (PROGIRIS) LOOP
    -- CREO UNO STORICO PER OGNI DECORRENZA DELLA T430
    IF NVL(INSTR(wDECORRENZE,TO_CHAR(RT430.DATADECORRENZA,'DDMMYYYY') || ','),0) = 0 THEN
      wDECORRENZE:=wDECORRENZE || TO_CHAR(RT430.DATADECORRENZA,'DDMMYYYY') || ',';
    END IF;
  END LOOP; -- FINE CT430 --
  IF wDECORRENZE IS NOT NULL THEN
    -- SELEZIONO LA MINIMA DECORRENZA DI P430
    BEGIN
      SELECT  MIN(DECORRENZA)
      INTO    DECO_MIN
      FROM    P430_ANAGRAFICO
      WHERE   PROGRESSIVO = PROGIRIS;
    EXCEPTION
      WHEN OTHERS THEN
        DECO_MIN:=TO_DATE('01011900','DDMMYYYY');
    END;
    -- CREO LE DECORRENZE RICAVATE
    S_APP_DEC:=wDECORRENZE;
    WHILE INSTR(S_APP_DEC,',') > 0 LOOP
      DEC_STO:=TO_DATE(SUBSTR(S_APP_DEC,1,8),'DDMMYYYY');
      IF DEC_STO > DECO_MIN THEN
        CREAZIONE_STORICO_STIPENDI(PROGIRIS,DEC_STO,NULL);
      END IF;
      S_APP_DEC:=SUBSTR(S_APP_DEC,10);
    END LOOP;
  END IF;
  -- RECUPERO I CAMPI NOT NULL
  S_APP_CNN:=wCAMPI_NOT_NULL;
  I:=0;
  WHILE INSTR(S_APP_CNN,',') > 0 LOOP
    I:=I+1;
    CAMPI_NOT_NULL_ARR(I).X430_COLONNA:=SUBSTR(S_APP_CNN,1,INSTR(S_APP_CNN,'-')-1);
    S_APP_CNN:=SUBSTR(S_APP_CNN,INSTR(S_APP_CNN,'-')+1);
    CAMPI_NOT_NULL_ARR(I).DATA_DEFAULT:=SUBSTR(S_APP_CNN,1,INSTR(S_APP_CNN,',')-1);
    S_APP_CNN:=SUBSTR(S_APP_CNN,INSTR(S_APP_CNN,',')+1);
  END LOOP;
  -- CICLO SULLE RELAZIONI DI TIPO VINCOLATO E LIBERO
  ESPRESSIONE:='SELECT I030.tabella, I030.colonna, I030.decorrenza, I030.decorrenza_fine scadenza, I030.tab_origine, I030.tipo' ||
               ' FROM I030_RELAZIONI_ANAGRAFE I030 WHERE I030.tabella = :p_tabella AND I030.tipo IN (''L'',''S'')' ||
               wESP_CUR_REL || ' ORDER BY I030.ordine, I030.tabella, I030.colonna, I030.decorrenza';
  CURSORE_DINAMICO_I030:=DBMS_SQL.OPEN_CURSOR;
  BEGIN--CURSORE_DINAMICO_I030
  DBMS_SQL.PARSE(CURSORE_DINAMICO_I030,ESPRESSIONE,DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,1,I030_TABELLA,30);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,2,I030_COLONNA,30);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,3,I030_DECORRENZA);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,4,I030_SCADENZA);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,5,I030_TAB_ORIGINE,30);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,6,I030_TIPO,1);
  DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_I030,'p_tabella','P430_ANAGRAFICO');
  CURS_I030:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_I030);
  LOOP
    IF DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_I030)>0 THEN
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 1, I030_TABELLA);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 2, I030_COLONNA);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 3, I030_DECORRENZA);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 4, I030_SCADENZA);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 5, I030_TAB_ORIGINE);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 6, I030_TIPO);
      --
      PART:=0;
      ARR:=20;
      RECUPERA_RELAZIONE; -- IMPOSTA SRELAZIONE
      -- ESTRAGGO IL VALORE CON L'SQL CHE HO RICAVATO
      IF SRELAZIONE IS NOT NULL THEN
        SRELAZIONE_ORI:=SRELAZIONE;
        CONTINUA_ESTR_RELAZIONE_ORI:=CONTINUA_ESTR_RELAZIONE;
        -- PREPARO IL CURSORE DINAMICO PER NON ESEGUIRE TUTTE LE VOLTE OPEN E PARSE
        CURSORE_DINAMICO_SEL_REL:=DBMS_SQL.OPEN_CURSOR;
        BEGIN --CURSORE_DINAMICO_SEL_REL
        DBMS_SQL.PARSE(CURSORE_DINAMICO_SEL_REL,SRELAZIONE,DBMS_SQL.NATIVE);
        DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_SEL_REL,1,VALORE,100);
        -- CICLO SULLE DECORRENZE DELLA P430 (ORMAI AL MASSIMO DETTAGLIO)
        FOR RP430 IN CP430 (PROGIRIS,I030_DECORRENZA,I030_SCADENZA) LOOP
          dDEC_INI:=RP430.DECORRENZA;
          BEGIN
            -- SE PER LA DECORRENZA PRECEDENTE AVEVO MODIFICATO IL CURSORE, REIMPOSTO IL TESTO ORIGINALE
            IF SRELAZIONE_ORI <> SRELAZIONE THEN
              SRELAZIONE:=SRELAZIONE_ORI;
              DBMS_SQL.PARSE(CURSORE_DINAMICO_SEL_REL,SRELAZIONE,DBMS_SQL.NATIVE);
              DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_SEL_REL,1,VALORE,100);
              CONTINUA_ESTR_RELAZIONE:=CONTINUA_ESTR_RELAZIONE_ORI;
              PART:=20;
              ARR:=40;
            END IF;
            -- CICLO SUGLI SPEZZONI DELLA RELAZIONE FINCH� TROVO IL VALORE DA AGGIORNARE OPPURE FINISCO LE RIGHE
            LOOP -- INIZIO CONTINUA_ESTR_RELAZIONE --
              DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_SEL_REL,'dDEC_INI',dDEC_INI);
              CURS_SEL_REL:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_SEL_REL);
              IF DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_SEL_REL)>0 THEN
                DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_SEL_REL, 1, VALORE);
                IF CONTINUA_ESTR_RELAZIONE = FALSE OR VALORE IS NOT NULL THEN
                  IF VALORE IS NULL THEN
                    -- IMPOSTO LA VARIABILE A NULL PER L'AGGIORNAMENTO
                    VALORE:='NULL';
                    -- VERIFICO SE QUESTO CAMPO DEVE ESSERE VALORIZZATO E QUAL E' IL VALORE DI DEFAULT
                    FOR I IN 1..CAMPI_NOT_NULL_ARR.COUNT LOOP
                      IF CAMPI_NOT_NULL_ARR(I).X430_COLONNA = I030_COLONNA THEN
                      -- SE IL CAMPO DEVE ESSERE VALORIZZATO ASSEGNO IL VALORE DI DEFAULT
                        VALORE:=CAMPI_NOT_NULL_ARR(I).DATA_DEFAULT;
                        EXIT;
                      END IF;
                    END LOOP;
                  ELSE
                    VALORE:=''''||REPLACE(VALORE,'''','''''')||'''';
                  END IF;
                ELSE
                  -- RECUPERO IL TESTO DELLA RELAZIONE DALLE RIGHE SUCCESSIVE DI I035 E LO ASSEGNO AL CURSORE DINAMICO
                  RECUPERA_RELAZIONE; -- IMPOSTA SRELAZIONE
                  IF SRELAZIONE IS NOT NULL THEN
                    DBMS_SQL.PARSE(CURSORE_DINAMICO_SEL_REL,SRELAZIONE,DBMS_SQL.NATIVE);
                    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_SEL_REL,1,VALORE,100);
                  END IF;
                END IF;
              ELSE
                -- SE ADDIRITTURA NON TROVO LA RIGA DI I030_TAB_ORIGINE, IMPOSTO LA VARIABILE A NULL PER L'AGGIORNAMENTO
                VALORE:='NULL';
              END IF;
              EXIT WHEN VALORE IS NOT NULL;
            END LOOP; -- FINE CONTINUA_ESTR_RELAZIONE --
            -- ESEGUO L'AGGIORNAMENTO CON IL VALORE CHE HO ESTRATTO
            ESPRESSIONE:='UPDATE '||I030_TABELLA||
                        ' SET '||I030_COLONNA||' = '||VALORE||
                        ' WHERE PROGRESSIVO = '||TO_CHAR(PROGIRIS)||
                        ' AND DECORRENZA = :dDEC_INI';
            IF I030_TIPO = 'L' AND NVL(AGGIORNA_ASSEG_AUTO_LIBERA,'N') = 'N' THEN
              ESPRESSIONE:=ESPRESSIONE || ' AND '||I030_COLONNA||' IS NULL';
            END IF;
            CURSORE_DINAMICO_UPD_REL:=DBMS_SQL.OPEN_CURSOR;
            BEGIN
              DBMS_SQL.PARSE(CURSORE_DINAMICO_UPD_REL,ESPRESSIONE,DBMS_SQL.NATIVE);
              DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_UPD_REL,'dDEC_INI',dDEC_INI);
              CURS_UPD_REL:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_UPD_REL);
            EXCEPTION
              WHEN OTHERS THEN
                NULL;
            END;
            DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_UPD_REL);
          EXCEPTION
            WHEN OTHERS THEN
              -- SE NON RIESCO AD EFFETTUARE L'ESTRAZIONE DEL VALORE O L'AGGIORNAMENTO DELLA TABELLA PASSO AL RECORD SUCCESSIVO
              NULL;
          END;
        END LOOP; -- FINE CP430 --
        EXCEPTION
          WHEN OTHERS THEN NULL;
        END; --CURSORE_DINAMICO_SEL_REL  
        DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_SEL_REL);
      END IF;
    ELSE
      EXIT;
    END IF;
  END LOOP; -- FINE CURSORE_DINAMICO_I030 --
  EXCEPTION
    WHEN OTHERS THEN NULL;
  END;--CURSORE_DINAMICO_I030
  DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_I030);
  --
  -- eseguo selezione di P430_ANAGRAFICO concatenando tutti i campi tranne decorrenza e decorrenza_fine
  ESPRESSIONE:='SELECT DISTINCT P430.ROWID, P430.DECORRENZA, P430.DECORRENZA_FINE, ' || wCAMPI_SEL || ' FROM P430_ANAGRAFICO P430' || wTAB_FROM ||' WHERE P430.PROGRESSIVO = :PROGIRIS' || wCOND_WHERE || ' ORDER BY P430.DECORRENZA';
  -- cursore che legge i periodi storici
  CURSORE_DINAMICO_P430:=DBMS_SQL.OPEN_CURSOR;
  BEGIN
  DBMS_SQL.PARSE(CURSORE_DINAMICO_P430,ESPRESSIONE,DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_P430,1,NROWID,20);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_P430,2,dDECINIZ);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_P430,3,dDECFINE);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_P430,4,VALOREDATI1,5000);
  DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_P430, 'PROGIRIS', PROGIRIS);
  CURS_P430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_P430);
  NROWIDUPDATE:='';
  VALOREDATIOLD:='';
  ULTIMAdFINE:=NULL;
  dFINE_PREC:=NULL;
  LOOP
    -- scorrimento sui record dei periodi storici
    IF DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_P430)>0 THEN
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_P430, 1, NROWID);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_P430, 2, dDECINIZ);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_P430, 3, dDECFINE);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_P430, 4, VALOREDATI1);
      -- se non e' stata fatta ancora nessuna lettura precedente
      IF (NROWID <> NROWIDUPDATE) AND (dFINE_PREC IS NOT NULL) AND (dDECINIZ <> dFINE_PREC + 1) THEN
        UPDATE P430_ANAGRAFICO SET DECORRENZA = dFINE_PREC + 1 WHERE ROWID = NROWID;
      END IF;
      dFINE_PREC:=dDECFINE;
      IF VALOREDATIOLD IS NULL THEN
        -- memorizzo dati da confrontare e rowid del periodo storico di cui aggiornare datafine
        VALOREDATIOLD:=VALOREDATI1;
        NROWIDUPDATE:=NROWID;
      ELSIF NROWID <> NROWIDUPDATE then -- la condizione di diversit� dei RowId (rafforzata dalla Distinct nel cursore) serve a gestire l'eventuale bug di prodotto cartesiano
        IF VALOREDATI1 = VALOREDATIOLD THEN
          -- memorizzo la data di fine che servira' per aggiornare il primo periodo
          -- storico precedente con i dati uguali
          ULTIMAdFINE:=dDECFINE;
          -- cancello il periodo storico con dati uguali al precedente
          DELETE P430_ANAGRAFICO WHERE ROWID = NROWID;
        ELSE
          IF ULTIMAdFINE IS NOT NULL THEN
            -- se esiste un record precedente con dati uguali aggiorno la data fine
            UPDATE P430_ANAGRAFICO SET DECORRENZA_FINE = ULTIMAdFINE WHERE ROWID = NROWIDUPDATE;
            ULTIMAdFINE:=NULL;
          END IF;
          -- salvo il valore dei dati letti per nuovo confronto
          VALOREDATIOLD:=VALOREDATI1;
          -- reimposto il rowid che sara' eventualmente da updatare
          NROWIDUPDATE:=NROWID;
        END IF;
      END IF;
    ELSE
      EXIT;
    END IF;
  END LOOP;
  IF ULTIMAdFINE IS NOT NULL THEN
    -- se esiste un record precedente con dati uguali aggiorno la data fine
    UPDATE P430_ANAGRAFICO SET DECORRENZA_FINE = ULTIMAdFINE WHERE ROWID = NROWIDUPDATE;
  END IF;
  UPDATE P430_ANAGRAFICO SET DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY') WHERE
    PROGRESSIVO = PROGIRIS AND DECORRENZA = (SELECT MAX(DECORRENZA) FROM P430_ANAGRAFICO WHERE
    PROGRESSIVO = PROGIRIS);
  EXCEPTION
    WHEN OTHERS THEN NULL;
  END; --CURSORE_DINAMICO_P430
  DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_P430);
  --
   -- Forzo la prima decorrenza al minimo tra t430datadecorrenza e p430decorrenza
  SELECT NVL(MIN(LEAST(T430.DATADECORRENZA,TRUNC(P430.DECORRENZA,'MM'))),MIN(T430.DATADECORRENZA)) INTO dDECORRENZA
    FROM T430_STORICO T430, P430_ANAGRAFICO P430
    WHERE T430.PROGRESSIVO = PROGIRIS AND P430.PROGRESSIVO(+) = T430.PROGRESSIVO;
  UPDATE P430_ANAGRAFICO P430 SET DECORRENZA = TO_DATE('01'||TO_CHAR(dDECORRENZA,'MMYYYY'),'DDMMYYYY') WHERE P430.PROGRESSIVO = PROGIRIS
    AND P430.DECORRENZA = (SELECT MIN(DECORRENZA) FROM P430_ANAGRAFICO WHERE PROGRESSIVO = P430.PROGRESSIVO);
  -- TENTO DI LOCKARE LA DECORRENZA DEL DIPENDENTE SU P430 PER AGGIORNARLA
  BEGIN
    NROWIDLOCK:='';
    SELECT ROWID
    INTO   NROWIDLOCK
    FROM   T430_STORICO T430
    WHERE  PROGRESSIVO = PROGIRIS
    AND    DATADECORRENZA = (SELECT MIN(DATADECORRENZA)
                             FROM   T430_STORICO
                             WHERE  PROGRESSIVO = T430.PROGRESSIVO)
    FOR UPDATE NOWAIT;
    -- SE SONO RIUSCITO A LOCKARE LA DECORRENZA DEL DIPENDENTE SU P430 LA AGGIORNO
    UPDATE T430_STORICO T430 SET DATADECORRENZA = TO_DATE('01'||TO_CHAR(dDECORRENZA,'MMYYYY'),'DDMMYYYY') WHERE T430.PROGRESSIVO = PROGIRIS
      AND T430.DATADECORRENZA = (SELECT MIN(DATADECORRENZA) FROM T430_STORICO WHERE PROGRESSIVO = T430.PROGRESSIVO);
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
<<FINE_AGGIORNAMENTO>>
  --Gestione V430 materializzata
  begin
    select count(*) into i from tabs where TABLE_NAME = 'V430_STORICO';
    if i = 1 then
      CURSORE_DINAMICO_V430:=DBMS_SQL.OPEN_CURSOR;
      ESPRESSIONE:='delete from V430_STORICO where T430PROGRESSIVO = ' || PROGIRIS;
      DBMS_SQL.PARSE(CURSORE_DINAMICO_V430,ESPRESSIONE,DBMS_SQL.NATIVE);
      CURS_V430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_V430);
      ESPRESSIONE:='insert into V430_STORICO select * from V430_STORICO_VIEW where T430PROGRESSIVO = ' || PROGIRIS;
      DBMS_SQL.PARSE(CURSORE_DINAMICO_V430,ESPRESSIONE,DBMS_SQL.NATIVE);
      CURS_V430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_V430);
      DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_V430);
    end if;
  exception
    when others then null;
  end;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
END;
/