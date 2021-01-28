drop table T430_APPOGGIO;
create table T430_APPOGGIO storage (PCTINCREASE 0 INITIAL 256K NEXT 256K) as select * from T430_STORICO where PROGRESSIVO = -1;
drop table P430_APPOGGIO;
create table P430_APPOGGIO storage (PCTINCREASE 0 INITIAL 256K NEXT 256K) as select * from P430_ANAGRAFICO where PROGRESSIVO = -1;

alter table P602_770REGOLE add COD_ARROTONDAMENTO_FILE VARCHAR2(5);
comment on column P602_770REGOLE.COD_ARROTONDAMENTO_FILE
  is 'Codice arrotondamento in fase di esportazione. Richiesto solo se dato numerico';

alter table SG101_FAMILIARI modify ULT_DETR_FIGLIO DEFAULT 'S';

alter table T050_RICHIESTEASSENZA add ELABORATO varchar2(1) default 'N';

alter table T080_PIANIFORARI add VALORGIOR varchar2(1);
comment on column T080_PIANIFORARI.VALORGIOR is 'A B C D E come per VALORGIOR di T265';

alter table T361_OROLOGI add tipo_localita varchar2(1) default 'C';
alter table T361_OROLOGI add cod_localita varchar2(6);
alter table T361_OROLOGI add indirizzo varchar2(60);
comment on column T361_OROLOGI.tipo_localita is 'Indica il tipo della località dell''orologio';
comment on column T361_OROLOGI.cod_localita is 'Indica il codice della località dell''orologio';
comment on column T361_OROLOGI.indirizzo is 'Indica l''indirizzo in cui è sito l''orologio';

create table I030_RELAZIONI_ANAGRAFE (
  TABELLA varchar2(40),
  COLONNA varchar2(40),
  DECORRENZA date,
  DECORRENZA_FINE date,
  ORDINE number(4),
  TIPO varchar2(1) default 'S',
  TAB_ORIGINE varchar2(40)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table I030_RELAZIONI_ANAGRAFE add constraint I030_PK primary key (TABELLA,COLONNA,DECORRENZA) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
comment on column I030_RELAZIONI_ANAGRAFE.TIPO is 'S=Assegnazione vincolata - L=Assegnazione libera - F=Assegnazione filtrata';
comment on column I030_RELAZIONI_ANAGRAFE.ORDINE is 'Indica in che ordine eseguire le operazioni di assegnazione';

create table I035_RELAZIONI_DETTAGLIO (
  TABELLA varchar2(40),
  COLONNA varchar2(40),
  DECORRENZA date,
  NUM number(4),
  RELAZIONE varchar2(2000)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table I035_RELAZIONI_DETTAGLIO add constraint I035_PK primary key (TABELLA,COLONNA,DECORRENZA,NUM) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table I035_RELAZIONI_DETTAGLIO add constraint I035_FK_I030 foreign key (TABELLA,COLONNA,DECORRENZA) references I030_RELAZIONI_ANAGRAFE (TABELLA,COLONNA,DECORRENZA) on delete cascade;

DECLARE
-- Questa procedura legge tutte le vecchie relazioni tra i dati liberi definite sulla
-- I500 e sulle varie I501 e le trasforma per inserirle sulle tabelle I030 e I035 per
-- adattarle alla nuova gestione.
  -- DICHIARAZIONE CURSORI
  -- CURSORE SUI DATI LIBERI RELAZIONATI
  CURSOR C1 IS
    SELECT *
    FROM   I500_DATILIBERI
    WHERE  RIFERIMENTO <> 'N'
    ORDER BY NOMECAMPO;

  DIN_CUR_I501  INTEGER         :=0 ;
  CUR_I501      INTEGER         :=0 ;
  DIN_CNT_I501  INTEGER         :=0 ;
  CNT_I501      INTEGER         :=0 ;
  DIN_DEC_I501  INTEGER         :=0 ;
  DEC_I501      INTEGER         :=0 ;
  --
  -- DICHIARAZIONE ARRAY
  TYPE DEC_REC_TYPE IS RECORD
    (INI_DEC DATE,
     FIN_DEC DATE);
  TYPE ARRAY_DECORRENZE IS TABLE OF DEC_REC_TYPE INDEX BY BINARY_INTEGER;
  DEC_ARR ARRAY_DECORRENZE;
  --
  -- DICHIARAZIONE VARIABILI
  SRELAZIONE      VARCHAR2(2000)  :='';
  SABBINAMENTI    VARCHAR2(2000)  :='';
  ESPRESSIONE     VARCHAR2(1000)  :='';
  CAMPOLINK       VARCHAR2(500)   :='';
  ALTRICAMPILINK  VARCHAR2(500)   :='';
  SPILOTATO       VARCHAR2(50)    :='';
  SPILOTA         VARCHAR2(50)    :='';
  VAL_PILOTATO    VARCHAR2(2000)  :='';
  VAL_PILOTA      VARCHAR2(2000)  :='';
  CND_PILOTATO    VARCHAR2(2000)  :='';
  CND_PILOTA      VARCHAR2(2000)  :='';
  I501_EOF        BOOLEAN         :=FALSE;
  I               INTEGER         :=0 ;
  K               INTEGER         :=0 ;
  N_DEC           INTEGER         :=0 ;
  N_NUM           INTEGER         :=0 ;
  N_COPPIE        INTEGER         :=0 ;
  D_DEC           DATE                ;
  NUM             INTEGER         :=0 ;
  CODICE          VARCHAR2(50)    :='';
  LINK            VARCHAR2(50)    :='';
  DECOR           DATE                ;
  -- DICHIARAZIONE ECCEZIONI
  NEXT_RECORD EXCEPTION;
-- INIZIO ELABORAZIONE
BEGIN
  -- CICLO SUI DATI LIBERI RELAZIONATI
  FOR T1 IN C1 LOOP
  BEGIN
    -- ESTRAGGO IL PRIMO CAMPO LINK
    IF NVL(INSTR(T1.NOMELINK,','),0) = 0 THEN
      CAMPOLINK:=T1.NOMELINK;
      ALTRICAMPILINK:='';
    ELSE
      CAMPOLINK:=SUBSTR(T1.NOMELINK,1,INSTR(T1.NOMELINK,',')-1);
      ALTRICAMPILINK:=SUBSTR(T1.NOMELINK,INSTR(T1.NOMELINK,',')+1);
    END IF;
    --
    WHILE CAMPOLINK IS NOT NULL LOOP
    BEGIN
      -- COSTRUISCO LA RELAZIONE IN BASE AL TIPO DI RELAZIONE
      -- RELAZIONE DI TIPO FILTRO
      IF T1.RIFERIMENTO = 'F' THEN
        -- SE IL DATO NON E' GESTITO A PERIODI STORICI
        IF T1.STORICO = 'N' THEN
          -- IMPOSTO LE DATE DI INIZIO E FINE PER L'UNICO PERIODO STORICO
          N_DEC:=1;
          DEC_ARR(1).INI_DEC:=TO_DATE('01/01/1900','DD/MM/YYYY');
          DEC_ARR(1).FIN_DEC:=TO_DATE('31/12/3999','DD/MM/YYYY');
          --
          ESPRESSIONE:='SELECT CODICE PILOTATO, '||CAMPOLINK||' PILOTA FROM I501'||T1.NOMECAMPO||' ORDER BY 2,1';
          DIN_CUR_I501:=DBMS_SQL.OPEN_CURSOR;
          DBMS_SQL.PARSE(DIN_CUR_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
          DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 1, SPILOTATO, 50);
          DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 2, SPILOTA, 50);
          CUR_I501:=DBMS_SQL.EXECUTE(DIN_CUR_I501);
          BEGIN
            -- INSERISCO I DATI GENERALI DELLA RELAZIONE
            INSERT INTO I030_RELAZIONI_ANAGRAFE
              (TABELLA
              ,COLONNA
              ,DECORRENZA
              ,DECORRENZA_FINE
              ,ORDINE
              ,TIPO
              ,TAB_ORIGINE)
            VALUES
              ('T430_STORICO'                       --- Tabella
              ,T1.NOMECAMPO                         --- Colonna
              ,DEC_ARR(1).INI_DEC                   --- Decorrenza
              ,DEC_ARR(1).FIN_DEC                   --- Decorrenza_fine
              ,0                                    --- Ordine
              ,T1.RIFERIMENTO                       --- Tipo
              ,'T430_STORICO');                     --- Tabella origine
            --
          EXCEPTION
            WHEN OTHERS THEN
              RAISE NEXT_RECORD;
          END;
          SRELAZIONE:='';
          I501_EOF:=FALSE;
          IF DBMS_SQL.FETCH_ROWS(DIN_CUR_I501)>0 THEN
            -- LETTURA DEI VALORI
            DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 1, SPILOTATO);
            DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 2, SPILOTA);
          ELSE
            I501_EOF:=TRUE;
          END IF;
          VAL_PILOTA:=SPILOTA;
          VAL_PILOTATO:='';
          I:=0;
          LOOP
            -- SCORRIMENTO SULLA I501 RELATIVA AL CAMPO PILOTATO
            IF (NVL(RTRIM(LTRIM(VAL_PILOTATO)),'#NULL#') <> ''''',') AND
               (NVL(VAL_PILOTA,'#NULL#') = NVL(SPILOTA,'#NULL#')) AND
               (I501_EOF = FALSE) AND
               (NVL(LENGTH(VAL_PILOTATO),0) < 750) THEN
              VAL_PILOTATO:=VAL_PILOTATO||''''||SPILOTATO||''',';
            ELSE
              IF RTRIM(LTRIM(VAL_PILOTATO)) <> ''''',' THEN
                CND_PILOTATO:='IN ('||SUBSTR(VAL_PILOTATO,1,LENGTH(VAL_PILOTATO)-1)||')';
              ELSE
                CND_PILOTATO:='IS NULL';
              END IF;
              IF RTRIM(LTRIM(VAL_PILOTA)) IS NULL THEN
                VAL_PILOTA:='NULL';
                CND_PILOTA:='IS NULL';
              ELSE
                VAL_PILOTA:=''''||VAL_PILOTA||'''';
                CND_PILOTA:='= '||VAL_PILOTA;
              END IF;
              IF SRELAZIONE IS NOT NULL THEN
                SRELAZIONE:=' UNION ';
              END IF;
              SRELAZIONE:=SRELAZIONE||'SELECT DISTINCT CODICE, DESCRIZIONE FROM I501'||T1.NOMECAMPO||' WHERE CODICE '||CND_PILOTATO||' AND <#>'||CAMPOLINK||'<#> '||CND_PILOTA;
              I:=I+1;
              -- INSERISCO IL TRONCONE DI RELAZIONE
              BEGIN
                INSERT INTO I035_RELAZIONI_DETTAGLIO
                  (TABELLA
                  ,COLONNA
                  ,DECORRENZA
                  ,NUM
                  ,RELAZIONE)
                VALUES
                  ('T430_STORICO'                   --- Tabella
                  ,T1.NOMECAMPO                     --- Colonna
                  ,DEC_ARR(1).INI_DEC               --- Decorrenza
                  ,I                                --- Num
                  ,SRELAZIONE);                     --- Relazione
              EXCEPTION
                WHEN OTHERS THEN
                  RAISE NEXT_RECORD;
              END;
              --
              IF I501_EOF = FALSE THEN
                VAL_PILOTA:=SPILOTA;
                VAL_PILOTATO:=''''||SPILOTATO||''',';
              END IF;
            END IF;
            IF I501_EOF = TRUE THEN
              EXIT;
            END IF;
            IF DBMS_SQL.FETCH_ROWS(DIN_CUR_I501)>0 THEN
              -- LETTURA DEI VALORI
              DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 1, SPILOTATO);
              DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 2, SPILOTA);
            ELSE
              I501_EOF:=TRUE;
            END IF;
          END LOOP;
          IF SRELAZIONE IS NOT NULL THEN
            SRELAZIONE:=' ORDER BY CODICE';
            I:=I+1;
            -- INSERISCO IL TRONCONE DI RELAZIONE
            BEGIN
              INSERT INTO I035_RELAZIONI_DETTAGLIO
                (TABELLA
                ,COLONNA
                ,DECORRENZA
                ,NUM
                ,RELAZIONE)
              VALUES
                ('T430_STORICO'                   --- Tabella
                ,T1.NOMECAMPO                     --- Colonna
                ,DEC_ARR(1).INI_DEC               --- Decorrenza
                ,I                                --- Num
                ,SRELAZIONE);                     --- Relazione
            EXCEPTION
              WHEN OTHERS THEN
                RAISE NEXT_RECORD;
            END;
          END IF;
          DBMS_SQL.CLOSE_CURSOR(DIN_CUR_I501);
        ELSE
        -- SE IL DATO E' GESTITO A PERIODI STORICI
          ESPRESSIONE:='SELECT COUNT(DISTINCT(A.'||CAMPOLINK||')) NUM FROM I501'||T1.NOMECAMPO||' A, '||
                       '(SELECT C.CODICE, COUNT(DISTINCT(C.DECORRENZA)) FROM I501'||T1.NOMECAMPO||' C GROUP BY C.CODICE HAVING COUNT(DISTINCT(C.DECORRENZA)) > 1) B '||
                       'WHERE A.CODICE = B.CODICE';
          DIN_CNT_I501:=DBMS_SQL.OPEN_CURSOR;
          DBMS_SQL.PARSE(DIN_CNT_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
          DBMS_SQL.DEFINE_COLUMN(DIN_CNT_I501, 1, N_NUM);
          CNT_I501:=DBMS_SQL.EXECUTE(DIN_CNT_I501);
          IF DBMS_SQL.FETCH_ROWS(DIN_CNT_I501)>0 THEN
            -- LETTURA DEL VALORE
            DBMS_SQL.COLUMN_VALUE(DIN_CNT_I501, 1, N_NUM);
            -- SE C'E' STATA QUALCHE STORICIZZAZIONE DEI DATI PILOTA
            IF N_NUM > 1 THEN
              ESPRESSIONE:='SELECT A.CODICE, A.'||CAMPOLINK||' LINK, MIN(A.DECORRENZA) DECOR FROM '||
                           '(SELECT DISTINCT C.CODICE, C.'||CAMPOLINK||' FROM I501'||T1.NOMECAMPO||' C, '||
                           ' (SELECT E.CODICE, COUNT(DISTINCT(E.DECORRENZA)) FROM I501'||T1.NOMECAMPO||' E GROUP BY E.CODICE HAVING COUNT(DISTINCT(E.DECORRENZA)) > 1) D '||
                           ' WHERE D.CODICE = C.CODICE) B, I501'||T1.NOMECAMPO||' A'||
                           ' WHERE B.CODICE = A.CODICE AND B.'||CAMPOLINK||' = A.'||CAMPOLINK||' GROUP BY A.CODICE, A.'||CAMPOLINK||' ORDER BY MIN(A.DECORRENZA)';
              DIN_DEC_I501:=DBMS_SQL.OPEN_CURSOR;
              DBMS_SQL.PARSE(DIN_DEC_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
              DBMS_SQL.DEFINE_COLUMN(DIN_DEC_I501, 1, CODICE, 50);
              DBMS_SQL.DEFINE_COLUMN(DIN_DEC_I501, 2, LINK, 50);
              DBMS_SQL.DEFINE_COLUMN(DIN_DEC_I501, 3, D_DEC);
              DEC_I501:=DBMS_SQL.EXECUTE(DIN_DEC_I501);
              N_DEC:=0;
              -- CICLO SULLE STORICIZZAZIONI DEL DATO PILOTA
              LOOP
                IF DBMS_SQL.FETCH_ROWS(DIN_DEC_I501)>0 THEN
                  -- LETTURA DEL VALORE
                  DBMS_SQL.COLUMN_VALUE(DIN_DEC_I501, 3, D_DEC);
                  -- SE E' IL PRIMO GIRO O E' CAMBIATA LA DECORRENZA
                  IF (N_DEC = 0) OR (D_DEC <> DEC_ARR(N_DEC).INI_DEC) THEN
                    -- INCREMENTO IL CONTATORE DELLE DECORRENZE
                    N_DEC:=N_DEC+1;
                    -- IMPOSTO LA DATA DI INIZIO DECORRENZA
                    DEC_ARR(N_DEC).INI_DEC:=D_DEC;
                    IF N_DEC > 1 THEN
                      -- IMPOSTO LA DATA DI FINE DECORRENZA PRECEDENTE SE SONO ALMENO AL SECONDO GIRO
                      DEC_ARR(N_DEC-1).FIN_DEC:=D_DEC-1;
                    END IF;
                  END IF;
                ELSE
                  -- IMPOSTO LA DATA DI FINE DECORRENZA SE SONO ALL'ULTIMO GIRO
                  DEC_ARR(N_DEC).FIN_DEC:=TO_DATE('31/12/3999','DD/MM/YYYY');
                  EXIT;
                END IF;
              END LOOP;
              DBMS_SQL.CLOSE_CURSOR(DIN_DEC_I501);
            ELSE
              -- IMPOSTO DATE DI INIZIO E FINE PER L'UNICO PERIODO STORICO
              DEC_ARR(1).INI_DEC:=TO_DATE('01/01/1900','DD/MM/YYYY');
              DEC_ARR(1).FIN_DEC:=TO_DATE('31/12/3999','DD/MM/YYYY');
              N_DEC:=1;
            END IF;
            -- CICLO PER OGNI DATA DECORRENZA
            FOR K IN 1..N_DEC LOOP
              ESPRESSIONE:='SELECT A.CODICE PILOTATO, A.'||CAMPOLINK||' PILOTA FROM I501'||T1.NOMECAMPO||' A WHERE A.DECORRENZA = '||
                           '(SELECT MAX(B.DECORRENZA) FROM I501'||T1.NOMECAMPO||' B WHERE NVL(A.CODICE,''#NULL#'') = NVL(B.CODICE,''#NULL#'') AND B.DECORRENZA BETWEEN :D_DA AND :D_A) '||
                           'GROUP BY A.CODICE, A.'||CAMPOLINK||' '||
                           'UNION '||
                           'SELECT A.CODICE PILOTATO, A.'||CAMPOLINK||' PILOTA FROM I501'||T1.NOMECAMPO||' A WHERE A.DECORRENZA < :D_DA AND A.DECORRENZA_FINE >= :D_A '||
                           'GROUP BY A.CODICE, A.'||CAMPOLINK||' '||
                           'ORDER BY 2,1';
              DIN_CUR_I501:=DBMS_SQL.OPEN_CURSOR;
              DBMS_SQL.PARSE(DIN_CUR_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
              DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 1, SPILOTATO, 50);
              DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 2, SPILOTA, 50);
              DBMS_SQL.BIND_VARIABLE(DIN_CUR_I501, 'D_DA', DEC_ARR(K).INI_DEC);
              DBMS_SQL.BIND_VARIABLE(DIN_CUR_I501, 'D_A', DEC_ARR(K).FIN_DEC);
              CUR_I501:=DBMS_SQL.EXECUTE(DIN_CUR_I501);
              -- INSERISCO I DATI GENERALI DELLA RELAZIONE
              BEGIN
                INSERT INTO I030_RELAZIONI_ANAGRAFE
                  (TABELLA
                  ,COLONNA
                  ,DECORRENZA
                  ,DECORRENZA_FINE
                  ,ORDINE
                  ,TIPO
                  ,TAB_ORIGINE)
                VALUES
                  ('T430_STORICO'                       --- Tabella
                  ,T1.NOMECAMPO                         --- Colonna
                  ,DEC_ARR(K).INI_DEC                   --- Decorrenza
                  ,DEC_ARR(K).FIN_DEC                   --- Decorrenza_fine
                  ,0                                    --- Ordine
                  ,T1.RIFERIMENTO                       --- Tipo
                  ,'T430_STORICO');                     --- Tabella origine
              EXCEPTION
                WHEN OTHERS THEN
                  RAISE NEXT_RECORD;
              END;
              --
              SRELAZIONE:='';
              I501_EOF:=FALSE;
              IF DBMS_SQL.FETCH_ROWS(DIN_CUR_I501)>0 THEN
                -- LETTURA DEI VALORI
                DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 1, SPILOTATO);
                DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 2, SPILOTA);
              ELSE
                I501_EOF:=TRUE;
              END IF;
              VAL_PILOTA:=SPILOTA;
              VAL_PILOTATO:='';
              I:=0;
              LOOP
                -- SCORRIMENTO SULLA I501 RELATIVA AL CAMPO PILOTATO
                IF (NVL(RTRIM(LTRIM(VAL_PILOTATO)),'#NULL#') <> ''''',') AND
                   (NVL(VAL_PILOTA,'#NULL#') = NVL(SPILOTA,'#NULL#')) AND
                   (I501_EOF = FALSE) AND
                   (NVL(LENGTH(VAL_PILOTATO),0) < 750) THEN
                  VAL_PILOTATO:=VAL_PILOTATO||''''||SPILOTATO||''',';
                ELSE
                  IF RTRIM(LTRIM(VAL_PILOTATO)) <> ''''',' THEN
                    CND_PILOTATO:='IN ('||SUBSTR(VAL_PILOTATO,1,LENGTH(VAL_PILOTATO)-1)||')';
                  ELSE
                    CND_PILOTATO:='IS NULL';
                  END IF;
                  IF RTRIM(LTRIM(VAL_PILOTA)) IS NULL THEN
                    VAL_PILOTA:='NULL';
                    CND_PILOTA:='IS NULL';
                  ELSE
                    VAL_PILOTA:=''''||VAL_PILOTA||'''';
                    CND_PILOTA:='= '||VAL_PILOTA;
                  END IF;
                  IF SRELAZIONE IS NOT NULL THEN
                    SRELAZIONE:=' UNION ';
                  END IF;
                  SRELAZIONE:=SRELAZIONE||'SELECT DISTINCT CODICE, DESCRIZIONE FROM I501'||T1.NOMECAMPO||' WHERE CODICE '||CND_PILOTATO||' AND <#>'||CAMPOLINK||'<#> '||CND_PILOTA;
                  I:=I+1;
                  -- INSERISCO IL TRONCONE DI RELAZIONE
                  BEGIN
                    INSERT INTO I035_RELAZIONI_DETTAGLIO
                      (TABELLA
                      ,COLONNA
                      ,DECORRENZA
                      ,NUM
                      ,RELAZIONE)
                    VALUES
                      ('T430_STORICO'                   --- Tabella
                      ,T1.NOMECAMPO                     --- Colonna
                      ,DEC_ARR(K).INI_DEC               --- Decorrenza
                      ,I                                --- Num
                      ,SRELAZIONE);                     --- Relazione
                  EXCEPTION
                    WHEN OTHERS THEN
                      RAISE NEXT_RECORD;
                  END;
                  IF I501_EOF = FALSE THEN
                    VAL_PILOTA:=SPILOTA;
                    VAL_PILOTATO:=''''||SPILOTATO||''',';
                  END IF;
                END IF;
                IF I501_EOF = TRUE THEN
                  EXIT;
                END IF;
                IF DBMS_SQL.FETCH_ROWS(DIN_CUR_I501)>0 THEN
                  -- LETTURA DEI VALORI
                  DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 1, SPILOTATO);
                  DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 2, SPILOTA);
                ELSE
                  I501_EOF:=TRUE;
                END IF;
              END LOOP;
              IF SRELAZIONE IS NOT NULL THEN
                SRELAZIONE:=' ORDER BY CODICE';
                I:=I+1;
                -- INSERISCO IL TRONCONE DI RELAZIONE
                BEGIN
                  INSERT INTO I035_RELAZIONI_DETTAGLIO
                    (TABELLA
                    ,COLONNA
                    ,DECORRENZA
                    ,NUM
                    ,RELAZIONE)
                  VALUES
                    ('T430_STORICO'                   --- Tabella
                    ,T1.NOMECAMPO                     --- Colonna
                    ,DEC_ARR(K).INI_DEC               --- Decorrenza
                    ,I                                --- Num
                    ,SRELAZIONE);                     --- Relazione
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE NEXT_RECORD;
                END;
              END IF;
              DBMS_SQL.CLOSE_CURSOR(DIN_CUR_I501);
            END LOOP;
          END IF;
          DBMS_SQL.CLOSE_CURSOR(DIN_CNT_I501);
        END IF;
      -- RELAZIONE DI TIPO VINCOLATO O LIBERO
      ELSIF T1.RIFERIMENTO IN ('S','L') THEN
        -- SE IL DATO NON E' GESTITO A PERIODI STORICI
        IF T1.STORICO = 'N' THEN
          -- IMPOSTO LE DATE DI INIZIO E FINE PER L'UNICO PERIODO STORICO
          N_DEC:=1;
          DEC_ARR(1).INI_DEC:=TO_DATE('01/01/1900','DD/MM/YYYY');
          DEC_ARR(1).FIN_DEC:=TO_DATE('31/12/3999','DD/MM/YYYY');
          --
          ESPRESSIONE:='SELECT CODICE PILOTA, '||CAMPOLINK||' PILOTATO FROM I501'||T1.NOMECAMPO||' ORDER BY 2,1';
          DIN_CUR_I501:=DBMS_SQL.OPEN_CURSOR;
          DBMS_SQL.PARSE(DIN_CUR_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
          DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 1, SPILOTA, 50);
          DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 2, SPILOTATO, 50);
          CUR_I501:=DBMS_SQL.EXECUTE(DIN_CUR_I501);
          -- INSERISCO I DATI GENERALI DELLA RELAZIONE
          BEGIN
            INSERT INTO I030_RELAZIONI_ANAGRAFE
              (TABELLA
              ,COLONNA
              ,DECORRENZA
              ,DECORRENZA_FINE
              ,ORDINE
              ,TIPO
              ,TAB_ORIGINE)
            VALUES
              ('T430_STORICO'                       --- Tabella
              ,CAMPOLINK                            --- Colonna
              ,DEC_ARR(1).INI_DEC                   --- Decorrenza
              ,DEC_ARR(1).FIN_DEC                   --- Decorrenza_fine
              ,0                                    --- Ordine
              ,T1.RIFERIMENTO                       --- Tipo
              ,'T430_STORICO');                     --- Tabella origine
          EXCEPTION
            WHEN OTHERS THEN
              RAISE NEXT_RECORD;
          END;
          --
          SRELAZIONE:='';
          SABBINAMENTI:='';
          N_COPPIE:=0;
          I:=0;
          LOOP
            -- SCORRIMENTO SULLA I501 RELATIVA AL CAMPO PILOTA
            IF DBMS_SQL.FETCH_ROWS(DIN_CUR_I501)>0 THEN
              -- LETTURA DEI VALORI
              DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 1, SPILOTA);
              DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 2, SPILOTATO);
              -- ABBINO I VALORI NELLA STRINGA DELLA RELAZIONE
              IF SPILOTATO IS NOT NULL THEN
                IF SPILOTA IS NULL THEN
                  SABBINAMENTI:=SABBINAMENTI||'NULL,';
                ELSE
                  SABBINAMENTI:=SABBINAMENTI||''''||SPILOTA||''',';
                END IF;
                SABBINAMENTI:=SABBINAMENTI||''''||SPILOTATO||''',';
                N_COPPIE:=N_COPPIE+1;
                IF (N_COPPIE = 100) OR (NVL(LENGTH(SABBINAMENTI),0) >= 750) THEN
                  SRELAZIONE:='DECODE(<#>'||T1.NOMECAMPO||'<#>,'||SUBSTR(SABBINAMENTI,1,LENGTH(SABBINAMENTI)-1)||') <#>D<#> <#>;<#>';
                  I:=I+1;
                  -- INSERISCO IL TRONCONE DI RELAZIONE
                  BEGIN
                    INSERT INTO I035_RELAZIONI_DETTAGLIO
                      (TABELLA
                      ,COLONNA
                      ,DECORRENZA
                      ,NUM
                      ,RELAZIONE)
                    VALUES
                      ('T430_STORICO'                   --- Tabella
                      ,CAMPOLINK                        --- Colonna
                      ,DEC_ARR(1).INI_DEC               --- Decorrenza
                      ,I                                --- Num
                      ,SRELAZIONE);                     --- Relazione
                  EXCEPTION
                    WHEN OTHERS THEN
                      RAISE NEXT_RECORD;
                  END;
                  N_COPPIE:=0;
                  SABBINAMENTI:='';
                END IF;
              END IF;
            ELSE
              EXIT;
            END IF;
          END LOOP;
          -- AGGIUNGO LA DECODE DEL CAMPO PILOTA
          IF SABBINAMENTI IS NOT NULL THEN
            SRELAZIONE:='DECODE(<#>'||T1.NOMECAMPO||'<#>,'||SUBSTR(SABBINAMENTI,1,LENGTH(SABBINAMENTI)-1)||') <#>D<#> <#>;<#>';
            I:=I+1;
            -- INSERISCO IL TRONCONE DI RELAZIONE
            BEGIN
              INSERT INTO I035_RELAZIONI_DETTAGLIO
                (TABELLA
                ,COLONNA
                ,DECORRENZA
                ,NUM
                ,RELAZIONE)
              VALUES
                ('T430_STORICO'                   --- Tabella
                ,CAMPOLINK                        --- Colonna
                ,DEC_ARR(1).INI_DEC               --- Decorrenza
                ,I                                --- Num
                ,SRELAZIONE);                     --- Relazione
            EXCEPTION
              WHEN OTHERS THEN
                RAISE NEXT_RECORD;
            END;
          END IF;
          DBMS_SQL.CLOSE_CURSOR(DIN_CUR_I501);
        ELSE
        -- SE IL DATO E' GESTITO A PERIODI STORICI
          ESPRESSIONE:='SELECT COUNT(DISTINCT(A.'||CAMPOLINK||')) NUM FROM I501'||T1.NOMECAMPO||' A, '||
                       '(SELECT C.CODICE, COUNT(DISTINCT(C.DECORRENZA)) FROM I501'||T1.NOMECAMPO||' C GROUP BY C.CODICE HAVING COUNT(DISTINCT(C.DECORRENZA)) > 1) B '||
                       'WHERE A.CODICE = B.CODICE';
          DIN_CNT_I501:=DBMS_SQL.OPEN_CURSOR;
          DBMS_SQL.PARSE(DIN_CNT_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
          DBMS_SQL.DEFINE_COLUMN(DIN_CNT_I501, 1, N_NUM);
          CNT_I501:=DBMS_SQL.EXECUTE(DIN_CNT_I501);
          IF DBMS_SQL.FETCH_ROWS(DIN_CNT_I501)>0 THEN
            -- LETTURA DEL VALORE
            DBMS_SQL.COLUMN_VALUE(DIN_CNT_I501, 1, N_NUM);
            -- SE C'E' STATA QUALCHE STORICIZZAZIONE DEI DATI PILOTA
            IF N_NUM > 1 THEN
              ESPRESSIONE:='SELECT A.CODICE, A.'||CAMPOLINK||' LINK, MIN(A.DECORRENZA) DECOR FROM '||
                           '(SELECT DISTINCT C.CODICE, C.'||CAMPOLINK||' FROM I501'||T1.NOMECAMPO||' C, '||
                           ' (SELECT E.CODICE, COUNT(DISTINCT(E.DECORRENZA)) FROM I501'||T1.NOMECAMPO||' E GROUP BY E.CODICE HAVING COUNT(DISTINCT(E.DECORRENZA)) > 1) D '||
                           ' WHERE D.CODICE = C.CODICE) B, I501'||T1.NOMECAMPO||' A'||
                           ' WHERE B.CODICE = A.CODICE AND B.'||CAMPOLINK||' = A.'||CAMPOLINK||' GROUP BY A.CODICE, A.'||CAMPOLINK||' ORDER BY MIN(A.DECORRENZA)';
              DIN_DEC_I501:=DBMS_SQL.OPEN_CURSOR;
              DBMS_SQL.PARSE(DIN_DEC_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
              DBMS_SQL.DEFINE_COLUMN(DIN_DEC_I501, 1, CODICE, 50);
              DBMS_SQL.DEFINE_COLUMN(DIN_DEC_I501, 2, LINK, 50);
              DBMS_SQL.DEFINE_COLUMN(DIN_DEC_I501, 3, D_DEC);
              DEC_I501:=DBMS_SQL.EXECUTE(DIN_DEC_I501);
              N_DEC:=0;
              -- CICLO SULLE STORICIZZAZIONI DEL DATO PILOTA
              LOOP
                IF DBMS_SQL.FETCH_ROWS(DIN_DEC_I501)>0 THEN
                  -- LETTURA DEL VALORE
                  DBMS_SQL.COLUMN_VALUE(DIN_DEC_I501, 3, D_DEC);
                  -- SE E' IL PRIMO GIRO O E' CAMBIATA LA DECORRENZA
                  IF (N_DEC = 0) OR (D_DEC <> DEC_ARR(N_DEC).INI_DEC) THEN
                    -- INCREMENTO IL CONTATORE DELLE DECORRENZE
                    N_DEC:=N_DEC+1;

                    -- IMPOSTO LA DATA DI INIZIO DECORRENZA
                    DEC_ARR(N_DEC).INI_DEC:=D_DEC;
                    IF N_DEC > 1 THEN
                      -- IMPOSTO LA DATA DI FINE DECORRENZA PRECEDENTE SE SONO ALMENO AL SECONDO GIRO
                      DEC_ARR(N_DEC-1).FIN_DEC:=D_DEC-1;
                    END IF;
                  END IF;
                ELSE
                  -- IMPOSTO LA DATA DI FINE DECORRENZA SE SONO ALL'ULTIMO GIRO
                  DEC_ARR(N_DEC).FIN_DEC:=TO_DATE('31/12/3999','DD/MM/YYYY');
                  EXIT;
                END IF;
              END LOOP;
              DBMS_SQL.CLOSE_CURSOR(DIN_DEC_I501);
            ELSE
              -- IMPOSTO DATE DI INIZIO E FINE PER L'UNICO PERIODO STORICO
              DEC_ARR(1).INI_DEC:=TO_DATE('01/01/1900','DD/MM/YYYY');
              DEC_ARR(1).FIN_DEC:=TO_DATE('31/12/3999','DD/MM/YYYY');
              N_DEC:=1;
            END IF;
            -- CICLO PER OGNI DATA DECORRENZA
            FOR K IN 1..N_DEC LOOP
              ESPRESSIONE:='SELECT A.CODICE PILOTA, A.'||CAMPOLINK||' PILOTATO FROM I501'||T1.NOMECAMPO||' A WHERE A.DECORRENZA = '||
                           '(SELECT MAX(B.DECORRENZA) FROM I501'||T1.NOMECAMPO||' B WHERE NVL(A.CODICE,''#NULL#'') = NVL(B.CODICE,''#NULL#'') AND B.DECORRENZA BETWEEN :D_DA AND :D_A) '||
                           'GROUP BY A.CODICE, A.'||CAMPOLINK||' '||
                           'UNION '||
                           'SELECT A.CODICE PILOTA, A.'||CAMPOLINK||' PILOTATO FROM I501'||T1.NOMECAMPO||' A WHERE A.DECORRENZA < :D_DA AND A.DECORRENZA_FINE >= :D_A '||
                           'GROUP BY A.CODICE, A.'||CAMPOLINK||' '||
                           'ORDER BY 2,1';
              DIN_CUR_I501:=DBMS_SQL.OPEN_CURSOR;
              DBMS_SQL.PARSE(DIN_CUR_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
              DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 1, SPILOTA, 50);
              DBMS_SQL.DEFINE_COLUMN(DIN_CUR_I501, 2, SPILOTATO, 50);
              DBMS_SQL.BIND_VARIABLE(DIN_CUR_I501, 'D_DA', DEC_ARR(K).INI_DEC);
              DBMS_SQL.BIND_VARIABLE(DIN_CUR_I501, 'D_A', DEC_ARR(K).FIN_DEC);
              CUR_I501:=DBMS_SQL.EXECUTE(DIN_CUR_I501);
              -- INSERISCO I DATI GENERALI DELLA RELAZIONE
              BEGIN
                INSERT INTO I030_RELAZIONI_ANAGRAFE
                  (TABELLA
                  ,COLONNA
                  ,DECORRENZA
                  ,DECORRENZA_FINE
                  ,ORDINE
                  ,TIPO
                  ,TAB_ORIGINE)
                VALUES
                  ('T430_STORICO'                       --- Tabella
                  ,CAMPOLINK                            --- Colonna
                  ,DEC_ARR(K).INI_DEC                   --- Decorrenza
                  ,DEC_ARR(K).FIN_DEC                   --- Decorrenza_fine
                  ,0                                    --- Ordine
                  ,T1.RIFERIMENTO                       --- Tipo
                  ,'T430_STORICO');                     --- Tabella origine
              EXCEPTION
                WHEN OTHERS THEN
                  RAISE NEXT_RECORD;
              END;
              --
              SRELAZIONE:='';
              SABBINAMENTI:='';
              N_COPPIE:=0;
              I:=0;
              LOOP
                -- SCORRIMENTO SULLA I501 RELATIVA AL CAMPO PILOTA
                IF DBMS_SQL.FETCH_ROWS(DIN_CUR_I501)>0 THEN
                  -- LETTURA DEI VALORI
                  DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 1, SPILOTA);
                  DBMS_SQL.COLUMN_VALUE(DIN_CUR_I501, 2, SPILOTATO);
                  -- ABBINO I VALORI NELLA STRINGA DELLA RELAZIONE
                  IF SPILOTATO IS NOT NULL THEN
                    IF SPILOTA IS NULL THEN
                      SABBINAMENTI:=SABBINAMENTI||'NULL,';
                    ELSE
                      SABBINAMENTI:=SABBINAMENTI||''''||SPILOTA||''',';
                    END IF;
                    SABBINAMENTI:=SABBINAMENTI||''''||SPILOTATO||''',';
                    N_COPPIE:=N_COPPIE+1;
                    IF (N_COPPIE = 100) OR (NVL(LENGTH(SABBINAMENTI),0) >= 750) THEN
                      SRELAZIONE:='DECODE(<#>'||T1.NOMECAMPO||'<#>,'||SUBSTR(SABBINAMENTI,1,LENGTH(SABBINAMENTI)-1)||') <#>D<#> <#>;<#>';
                      I:=I+1;
                      -- INSERISCO IL TRONCONE DI RELAZIONE
                      BEGIN
                        INSERT INTO I035_RELAZIONI_DETTAGLIO
                          (TABELLA
                          ,COLONNA
                          ,DECORRENZA
                          ,NUM
                          ,RELAZIONE)
                        VALUES
                          ('T430_STORICO'                   --- Tabella
                          ,CAMPOLINK                        --- Colonna
                          ,DEC_ARR(K).INI_DEC               --- Decorrenza
                          ,I                                --- Num
                          ,SRELAZIONE);                     --- Relazione
                      EXCEPTION
                        WHEN OTHERS THEN
                          RAISE NEXT_RECORD;
                      END;
                      N_COPPIE:=0;
                      SABBINAMENTI:='';
                    END IF;
                  END IF;
                ELSE
                  EXIT;
                END IF;
              END LOOP;
              -- AGGIUNGO LA DECODE DEL CAMPO PILOTA
              IF SABBINAMENTI IS NOT NULL THEN
                SRELAZIONE:='DECODE(<#>'||T1.NOMECAMPO||'<#>,'||SUBSTR(SABBINAMENTI,1,LENGTH(SABBINAMENTI)-1)||') <#>D<#> <#>;<#>';
                I:=I+1;
                -- INSERISCO IL TRONCONE DI RELAZIONE
                BEGIN
                  INSERT INTO I035_RELAZIONI_DETTAGLIO
                    (TABELLA
                    ,COLONNA
                    ,DECORRENZA
                    ,NUM
                    ,RELAZIONE)
                  VALUES
                    ('T430_STORICO'                   --- Tabella
                    ,CAMPOLINK                        --- Colonna
                    ,DEC_ARR(K).INI_DEC               --- Decorrenza
                    ,I                                --- Num
                    ,SRELAZIONE);                     --- Relazione
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE NEXT_RECORD;
                END;
              END IF;
              DBMS_SQL.CLOSE_CURSOR(DIN_CUR_I501);
            END LOOP;
          END IF;
          DBMS_SQL.CLOSE_CURSOR(DIN_CNT_I501);
        END IF;
      END IF;
      ---
      -- ESTRAGGO IL SUCCESSIVO CAMPO LINK
      IF NVL(INSTR(ALTRICAMPILINK,','),0) = 0 THEN
        CAMPOLINK:=ALTRICAMPILINK;
        ALTRICAMPILINK:='';
      ELSE
        CAMPOLINK:=SUBSTR(ALTRICAMPILINK,1,INSTR(ALTRICAMPILINK,',')-1);
        ALTRICAMPILINK:=SUBSTR(ALTRICAMPILINK,INSTR(ALTRICAMPILINK,',')+1);
      END IF;
      --
    EXCEPTION
      WHEN NEXT_RECORD THEN
        -- ESTRAGGO IL SUCCESSIVO CAMPO LINK
        IF NVL(INSTR(ALTRICAMPILINK,','),0) = 0 THEN
          CAMPOLINK:=ALTRICAMPILINK;
          ALTRICAMPILINK:='';
        ELSE
          CAMPOLINK:=SUBSTR(ALTRICAMPILINK,1,INSTR(ALTRICAMPILINK,',')-1);
          ALTRICAMPILINK:=SUBSTR(ALTRICAMPILINK,INSTR(ALTRICAMPILINK,',')+1);
        END IF;
        --
    END;
    END LOOP;
  EXCEPTION
    WHEN NEXT_RECORD THEN
      NULL;
  END;
  END LOOP;
  --COMMIT;
END;
/

create table T030_NOTRIGGER
(
  PROGRESSIVO NUMBER(8),
  ISTANTE     DATE
) tablespace LAVORO;

create table i020_dati_allineamento
(TIPO    VARCHAR2(1),
 TABELLA VARCHAR2(30),
 COLONNA VARCHAR2(100),
 VALORE  VARCHAR2(100)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column i020_dati_allineamento.TIPO is 'D=Dato storico - R=Relazione anagrafica';
comment on column i020_dati_allineamento.TABELLA is 'Tabella di riferimento';
comment on column i020_dati_allineamento.COLONNA is 'Colonna oggetto di storicizzazione';
comment on column i020_dati_allineamento.VALORE is 'Valore oggetto di storicizzazione';

-- Script per la creazione del job di allineamento dei dati anagrafici
declare
  n_p430 number    :=0;
  id_job number       ;
begin
  begin
    select valore
    into   id_job
    from   t001_parametrifunzioni
    where  progoperatore = -1
    and    prog = 'A044'
    and    nome = 'ID_JOB';
  exception
    when no_data_found then
      id_job:=-1;
  end;
  if id_job = -1 then
    sys.dbms_job.submit(job => id_job,
                        what => 'declare
begin
  allinea_per_job;
end;',
                        next_date => to_date(to_char(sysdate+1,'dd-mm-yyyy')||' 00.00.00', 'dd-mm-yyyy hh24.mi.ss'),
                        interval => 'sysdate + 1',
                        no_parse => TRUE);
    insert into t001_parametrifunzioni
      (prog,
       nome,
       valore,
       progoperatore)
    values
      ('A044',
       'ID_JOB',
       id_job,
       -1);
  end if;
  commit;
exception
  when others then
    rollback;
end;
/

-- Script per la creazione del job che ogni giorno imposta la data di esecuzione del job di allineamento dei dati anagrafici
declare
  id_job  number       ;
  ora_job varchar2(5);
begin
  begin
    select valore
    into   id_job
    from   t001_parametrifunzioni
    where  progoperatore = -1
    and    prog = 'A044'
    and    nome = 'ID_JOB_CTRL';
  exception
    when no_data_found then
      id_job:=-1;
  end;
  if id_job = -1 then
      sys.dbms_job.submit(job => id_job,
                          what => 'declare
errore  varchar2(100);
ora_job varchar2(5);
id_job  number;
begin
  begin
    select valore
    into   id_job
    from   t001_parametrifunzioni
    where  progoperatore = -1
    and    prog = ''A044''
    and    nome = ''ID_JOB'';
  exception
    when others then
      id_job:=0;
  end;
  if id_job > 0 then
    begin
      select valore
      into   ora_job
      from   t001_parametrifunzioni
      where  progoperatore = -1
      and    prog = ''A044''
      and    nome = ''ORA_JOB'';
    exception
      when others then
        ora_job:=''00.00'';
    end;
    if to_date(''01-01-1900 ''||to_char(sysdate,''hh24.mi'')||''.00'',''dd-mm-yyyy hh24.mi.ss'') <= to_date(''01-01-1900 ''||ora_job||''.00'',''dd-mm-yyyy hh24.mi.ss'') then
      sys.dbms_job.next_date(id_job,to_date(to_char(sysdate,''dd-mm-yyyy'')||'' ''||ora_job||''.00'', ''dd-mm-yyyy hh24.mi.ss''));
    else
      sys.dbms_job.next_date(id_job,to_date(to_char(sysdate+1,''dd-mm-yyyy'')||'' ''||ora_job||''.00'', ''dd-mm-yyyy hh24.mi.ss''));
    end if;
  end if;
end;',
                          next_date => to_date(to_char(sysdate+1,'dd-mm-yyyy')||' 00.00.00', 'dd-mm-yyyy hh24.mi.ss'),
                          interval => 'TRUNC(sysdate) + 1');
    insert into t001_parametrifunzioni
      (prog,
       nome,
       valore,
       progoperatore)
    values
      ('A044',
       'ID_JOB_CTRL',
       id_job,
       -1);
  end if;
  begin
    select valore
    into   ora_job
    from   t001_parametrifunzioni
    where  progoperatore = -1
    and    prog = 'A044'
    and    nome = 'ORA_JOB';
  exception
    when no_data_found then
      insert into t001_parametrifunzioni
        (prog,
         nome,
         valore,
         progoperatore)
      values
        ('A044',
         'ORA_JOB',
         '00.00',
         -1);
  end;
  commit;
exception
  when others then
    rollback;
end;
/

alter table T470_QUALIFICAMINIST add (DECORRENZA date, DECORRENZA_FINE date);
alter table T470_QUALIFICAMINIST drop primary key;
alter table T470_QUALIFICAMINIST add constraint T470_PK primary key (CODICE, DECORRENZA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

DECLARE
-- Questa procedura legge la tabella contenente il dato libero della qualifica
-- ministeriale e migra i dati sulla nuova tabella T470_QUALIFICAMINIST
  -- DICHIARAZIONE CURSORI
  -- CURSORE SUI DATI DELLA QUALIFICA MINISTERIALE
  CURSORE_DINAMICO_I501       INTEGER;
  CURS_I501                   INTEGER;
  --
  -- DICHIARAZIONE ARRAY
  --
  -- DICHIARAZIONE VARIABILI
  sNOMECAMPO        I500_DATILIBERI.NOMECAMPO%TYPE              :='';
  bDATOLIBERO       BOOLEAN                                         ;
  ESPRESSIONE       VARCHAR2(500)                               :='';
  vCODICE           T470_QUALIFICAMINIST.CODICE%TYPE            :='';
  vDESCRIZIONE      T470_QUALIFICAMINIST.DESCRIZIONE%TYPE       :='';
  vPROGRESSIVOQM    T470_QUALIFICAMINIST.PROGRESSIVOQM%TYPE     :='';
  vDEBITOGGQM       T470_QUALIFICAMINIST.DEBITOGGQM%TYPE        :='';
  vMACRO_CATEG_QM   T470_QUALIFICAMINIST.MACRO_CATEG_QM%TYPE    :='';
  --
  -- DICHIARAZIONE ECCEZIONI
  NEXT_RECORD EXCEPTION;
-- INIZIO ELABORAZIONE
BEGIN
  bDATOLIBERO:=FALSE;
  BEGIN
    SELECT NOMECAMPO
    INTO   sNOMECAMPO
    FROM   I500_DATILIBERI
    WHERE  TIPO = '1';
    bDATOLIBERO:=TRUE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    BEGIN
      SELECT DATO
      INTO   sNOMECAMPO
      FROM   MONDOEDP.I091_DATIENTE
      WHERE  TIPO = 'C1_QUALIFMINIST'
      AND    AZIENDA = :AZIENDA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        sNOMECAMPO:='';
    END;
  END;
  IF sNOMECAMPO IS NOT NULL THEN
    -- ESTRAGGO I DATI DELLA QUALIFICA MINISTERIALE
    IF bDATOLIBERO THEN
      ESPRESSIONE:='SELECT CODICE, DESCRIZIONE, PROGRESSIVOQM, DEBITOGGQM, MACRO_CATEG_QM FROM I501'||sNOMECAMPO;
    ELSE
      ESPRESSIONE:='SELECT CODICE, DESCRIZIONE, NULL, NULL, NULL FROM I501'||sNOMECAMPO;
    END IF;
    CURSORE_DINAMICO_I501:=DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CURSORE_DINAMICO_I501,ESPRESSIONE,DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I501,1,vCODICE,10);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I501,2,vDESCRIZIONE,100);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I501,3,vPROGRESSIVOQM);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I501,4,vDEBITOGGQM,5);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I501,5,vMACRO_CATEG_QM,10);
    CURS_I501:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_I501);
    LOOP
      IF DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_I501)>0 THEN
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I501, 1, vCODICE);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I501, 2, vDESCRIZIONE);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I501, 3, vPROGRESSIVOQM);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I501, 4, vDEBITOGGQM);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I501, 5, vMACRO_CATEG_QM);
        INSERT INTO T470_QUALIFICAMINIST
          (CODICE,
           DESCRIZIONE,
           PROGRESSIVOQM,
           DEBITOGGQM,
           MACRO_CATEG_QM,
           DECORRENZA,
           DECORRENZA_FINE)
        VALUES
          (vCODICE,
           vDESCRIZIONE,
           vPROGRESSIVOQM,
           vDEBITOGGQM,
           vMACRO_CATEG_QM,
           TO_DATE('01/01/1900','DD/MM/YYYY'),
           TO_DATE('31/12/3999','DD/MM/YYYY'));
      ELSE
        EXIT;
      END IF;
    END LOOP; -- FINE CURSORE_DINAMICO_I501 --
    DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_I501);
  END IF;
  --COMMIT;
END;
/

ALTER TABLE I035_RELAZIONI_DETTAGLIO
disable CONSTRAINT I035_FK_I030;
/

DECLARE
-- Questa procedura legge il vecchio dato libero della qualifica ministeriale
-- e aggiorna il nuovo campo QUALIFICAMINIST
  -- DICHIARAZIONE CURSORI
  -- CURSORE SUI DATI DELLA QUALIFICA MINISTERIALE
  CURSORE_DINAMICO_UPD_T430   INTEGER;
  CURS_T430                   INTEGER;
  --
  -- DICHIARAZIONE ARRAY
  --
  -- DICHIARAZIONE VARIABILI
  sNOMECAMPO        I500_DATILIBERI.NOMECAMPO%TYPE              :='';
  ESPRESSIONE       VARCHAR2(500)                               :='';
  --
  -- DICHIARAZIONE ECCEZIONI
  --
-- INIZIO ELABORAZIONE
BEGIN
  -- ESTRAGGO IL CAMPO CHE CONTIENE LA QUALIFICA MINISTERIALE
  BEGIN
    SELECT NOMECAMPO
    INTO   sNOMECAMPO
    FROM   I500_DATILIBERI
    WHERE  TIPO = '1';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
    BEGIN
      SELECT DATO
      INTO   sNOMECAMPO
      FROM   MONDOEDP.I091_DATIENTE
      WHERE  TIPO = 'C1_QUALIFMINIST'
      AND    AZIENDA = :AZIENDA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        sNOMECAMPO:='';
    END;
  END;
  IF sNOMECAMPO IS NOT NULL THEN
    -- AGGIORNO I DATI DELLA QUALIFICA MINISTERIALE SU T430
    ESPRESSIONE:='UPDATE T430_STORICO SET QUALIFICAMINIST = ' || sNOMECAMPO;
    CURSORE_DINAMICO_UPD_T430:=DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CURSORE_DINAMICO_UPD_T430,ESPRESSIONE,DBMS_SQL.NATIVE);
    CURS_T430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_UPD_T430);
    DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_UPD_T430);
    --
    -- ELIMINO L'EVENTUALE VISUALIZZAZIONE DEL NUOVO CAMPO
    DELETE T033_LAYOUT
    WHERE  CAMPODB = 'QUALIFICAMINIST';
    --
    -- INSERISCO LA VISUALIZZAZIONE DEL NUOVO CAMPO
    INSERT INTO T033_LAYOUT
      SELECT NOME, TOP, LFT, CAPTION, ACCESSO, NOMEPAGINA, 'QUALIFICAMINIST'
      FROM   T033_LAYOUT
      WHERE  CAMPODB = sNOMECAMPO;
    --
    -- AGGIORNO LA VISUALIZZAZIONE DEL NUOVO CAMPO
    UPDATE T033_LAYOUT
    SET    ACCESSO = 'N'
    WHERE  CAMPODB = sNOMECAMPO;
    --
    -- AGGIORNO IL NOME DEL CAMPO DELLA QUALIFICA MINISTERIALE NELLE RELAZIONI TRA DATI ANAGRAFICI
    UPDATE I030_RELAZIONI_ANAGRAFE
    SET    COLONNA = 'QUALIFICAMINIST'
    WHERE  COLONNA = sNOMECAMPO;
    --
    UPDATE I035_RELAZIONI_DETTAGLIO
    SET    COLONNA = 'QUALIFICAMINIST'
    WHERE  COLONNA = sNOMECAMPO;
    --
    UPDATE I035_RELAZIONI_DETTAGLIO
    SET    RELAZIONE = REPLACE(RELAZIONE,'<#>'||sNOMECAMPO||'<#>','<#>QUALIFICAMINIST<#>')
    WHERE  RELAZIONE LIKE '%<#>'||sNOMECAMPO||'<#>%';
    --
    -- AGGIORNO IL NOME DEL CAMPO DELLA QUALIFICA MINISTERIALE PER IL GENERATORE DI STAMPE
    UPDATE T909_DATICALCOLATI
    SET    ESPRESSIONE = REPLACE(ESPRESSIONE,SNOMECAMPO,'QUALIFICAMINIST');
    --
    UPDATE T911_DATIRIEPILOGO
    SET    NOME = REPLACE(NOME,SNOMECAMPO,'QUALIFICAMINIST');
    --
    UPDATE T912_SORTRIEPILOGO
    SET    NOME = REPLACE(NOME,SNOMECAMPO,'QUALIFICAMINIST');
    --
    UPDATE T914_SERBATOIFILTRO
    SET    FILTRO = REPLACE(FILTRO,SNOMECAMPO,'QUALIFICAMINIST');
    --
  END IF;
  --COMMIT;
END;
/

ALTER TABLE I035_RELAZIONI_DETTAGLIO
enable CONSTRAINT I035_FK_I030;
/

UPDATE P660_FLUSSIREGOLE T SET
T.REGOLA_CALCOLO_AUTOMATICA=REPLACE(T.REGOLA_CALCOLO_AUTOMATICA,'QUALIF_MINIST','QUALIFICAMINIST'),
T.REGOLA_CALCOLO_MANUALE=REPLACE(T.REGOLA_CALCOLO_MANUALE,'QUALIF_MINIST','QUALIFICAMINIST');
/

-- GESTIONE INCARICHI
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO)
SELECT AZIENDA, 'C20_INCARICOUNITAORG' FROM MONDOEDP.I090_ENTI;

create table SG300_INCCATEG
( COD_CATEG         VARCHAR2(5) not null,
  DECORRENZA        DATE not null,
  DECORRENZA_FINE   DATE,
  DESCRIZIONE       VARCHAR2(50),
  AREA              VARCHAR2(50),
  RIFERIMENTI_CONTR VARCHAR2(2000))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG300_INCCATEG.COD_CATEG
  is 'Codice categoria incarico (Ax,Bx,Cx,Dx)';
comment on column SG300_INCCATEG.DECORRENZA
  is 'Data decorrenza';
comment on column SG300_INCCATEG.DECORRENZA_FINE
  is 'Data decorrenza fine';

comment on column SG300_INCCATEG.DESCRIZIONE
  is 'Descrizione';
comment on column SG300_INCCATEG.AREA
  is 'Area (area medico-veterinaria; area dirigenza sanitaria; area dirigenza p.t.a.; comparto)';
comment on column SG300_INCCATEG.RIFERIMENTI_CONTR
  is 'Riferimenti contrattuali';
alter table SG300_INCCATEG
  add constraint SG300_PK primary key (COD_CATEG, DECORRENZA)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
ALTER TABLE SG300_INCCATEG MODIFY RIFERIMENTI_CONTR VARCHAR2(4000);


create table SG301_INCTIPO
( COD_TIPOINC        VARCHAR2(5) not null,
  DECORRENZA         DATE not null,
  DECORRENZA_FINE    DATE,
  DESCRIZIONE        VARCHAR2(500),
  COD_CATEG          VARCHAR2(5),
  VALORE_ECON        NUMBER,
  VALORE_ECON_VARIAZ NUMBER,
  DIRETTORE          VARCHAR2(30))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG301_INCTIPO.COD_TIPOINC
  is 'Codice tipo incarico';
comment on column SG301_INCTIPO.DECORRENZA
  is 'Data decorrenza';
comment on column SG301_INCTIPO.DECORRENZA_FINE
  is 'Data decorrenza fine';
comment on column SG301_INCTIPO.DESCRIZIONE
  is 'Descrizione';
comment on column SG301_INCTIPO.COD_CATEG
  is 'Codice categoria incarico';
comment on column SG301_INCTIPO.VALORE_ECON
  is 'Valore economico di posizione mensile';
comment on column SG301_INCTIPO.VALORE_ECON_VARIAZ
  is 'Valore economico teorico per definizione di quello effettivo in fase di simulazione per controllo del fondo';
comment on column SG301_INCTIPO.DIRETTORE
  is 'Tipo direttore: Nessuno/Dipartimento/Presidio/Distretto';
alter table SG301_INCTIPO
  add constraint SG301_PK primary key (COD_TIPOINC, DECORRENZA)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG302_INCAZIENDALI
( COD_UNITAORG     VARCHAR2(20) not null,
  COD_TIPOINC      VARCHAR2(5) not null,
  TITOLO_POSIZIONE VARCHAR2(500) not null,
  DECORRENZA       DATE not null,
  DECORRENZA_FINE  DATE,
  DESCRIZIONE      VARCHAR2(500),
  PROGRESSIVO_RESP NUMBER,
  NUMERO_INC       NUMBER DEFAULT 1)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG302_INCAZIENDALI.COD_UNITAORG
  is 'Codice unità organizzativa';
comment on column SG302_INCAZIENDALI.COD_TIPOINC
  is 'Codice tipo incarico';
comment on column SG302_INCAZIENDALI.TITOLO_POSIZIONE
  is 'Titolo Posizione';
comment on column SG302_INCAZIENDALI.DECORRENZA
  is 'Data decorrenza';
comment on column SG302_INCAZIENDALI.DECORRENZA_FINE
  is 'Data decorrenza fine';
comment on column SG302_INCAZIENDALI.DESCRIZIONE
  is 'Descrizione';
comment on column SG302_INCAZIENDALI.PROGRESSIVO_RESP
  is 'Progressivo responsabile';
comment on column SG302_INCAZIENDALI.NUMERO_INC
  is 'Numero incarichi previsti';
alter table SG302_INCAZIENDALI
  add constraint SG302_PK primary key (COD_UNITAORG, COD_TIPOINC, TITOLO_POSIZIONE, DECORRENZA)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG303_INCINDIVIDUALI
( PROGRESSIVO            NUMBER not null,
  COD_UNITAORG           VARCHAR2(20) not null,
  COD_TIPOINC            VARCHAR2(5) not null,
  TITOLO_POSIZIONE       VARCHAR2(500) not null,
  DATA_AFFIDAMENTO       DATE not null,
  DATA_SCADENZA          DATE,
  DATA_SOTTOSCRIZIONE    DATE,
  TIPO_ASSEGNAZIONE      VARCHAR2(1) DEFAULT 'C',
  MANSIONI_COMPETENZE    VARCHAR2(2000),
  MOTIVAZIONI            VARCHAR2(2000),
  OBIETTIVI_GENERALI     VARCHAR2(2000),
  RISORSE                VARCHAR2(2000),
  OSSERVAZIONI_DIRIGENTE VARCHAR2(2000),
  TIPOATTO               VARCHAR2(30),
  AUTORITA               VARCHAR2(40),
  NUMATTO                VARCHAR2(20),
  DATAATTO               DATE,
  DATAESEC               DATE,
  COD_COMMISSIONE        VARCHAR2(5),
  DATA_VALUTAZIONE       DATE,
  ESITO_VALUTAZIONE      VARCHAR2(2000),
  GIUDIZIO_VALUTAZIONE   VARCHAR2(2000),
  PROPOSTA_VALUTAZIONE   VARCHAR2(2000),
  ARTICOLO_REVOCA        VARCHAR2(2000),
  ANNOTAZIONI            VARCHAR2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG303_INCINDIVIDUALI.PROGRESSIVO
  is 'Progressivo dipendente';
comment on column SG303_INCINDIVIDUALI.COD_UNITAORG
  is 'Codice unità organizzativa';
comment on column SG303_INCINDIVIDUALI.COD_TIPOINC
  is 'Codice tipo incarico';
comment on column SG303_INCINDIVIDUALI.TITOLO_POSIZIONE
  is 'Titolo Posizione';
comment on column SG303_INCINDIVIDUALI.DATA_AFFIDAMENTO
  is 'Data affidamento';
comment on column SG303_INCINDIVIDUALI.DATA_SCADENZA
  is 'Data scadenza incarico';
comment on column SG303_INCINDIVIDUALI.DATA_SOTTOSCRIZIONE
  is 'Data sottoscrizione (se assente, l’incarico è a livello di proposta)';
comment on column SG303_INCINDIVIDUALI.TIPO_ASSEGNAZIONE
  is 'Tipo assegnazione: Prima assegnazione/Conferma';
comment on column SG303_INCINDIVIDUALI.MANSIONI_COMPETENZE
  is 'Mansioni e competenze';
comment on column SG303_INCINDIVIDUALI.MOTIVAZIONI
  is 'Motivazioni';
comment on column SG303_INCINDIVIDUALI.OBIETTIVI_GENERALI

  is 'Obiettivi generali';
comment on column SG303_INCINDIVIDUALI.RISORSE
  is 'Risorse';
comment on column SG303_INCINDIVIDUALI.OSSERVAZIONI_DIRIGENTE
  is 'Osservazioni del dirigente';
comment on column SG303_INCINDIVIDUALI.TIPOATTO
  is 'Tipo atto (delibera/determina)';
comment on column SG303_INCINDIVIDUALI.AUTORITA
  is 'Autorità atto';
comment on column SG303_INCINDIVIDUALI.NUMATTO
  is 'Numero atto';
comment on column SG303_INCINDIVIDUALI.DATAATTO
  is 'Data atto';
comment on column SG303_INCINDIVIDUALI.DATAESEC
  is 'Data esecutività atto';
comment on column SG303_INCINDIVIDUALI.COD_COMMISSIONE
  is 'Codice commissione valutazione';
comment on column SG303_INCINDIVIDUALI.DATA_VALUTAZIONE
  is 'Data valutazione';
comment on column SG303_INCINDIVIDUALI.ESITO_VALUTAZIONE
  is 'Esito valutazione';
comment on column SG303_INCINDIVIDUALI.GIUDIZIO_VALUTAZIONE
  is 'Giudizio finale scheda valutazione';
comment on column SG303_INCINDIVIDUALI.PROPOSTA_VALUTAZIONE
  is 'Proposta della commissione valutazione';
comment on column SG303_INCINDIVIDUALI.ARTICOLO_REVOCA
  is 'Articolo di revoca';
comment on column SG303_INCINDIVIDUALI.ANNOTAZIONI
  is 'Note';
alter table SG303_INCINDIVIDUALI
  add constraint SG303_PK primary key (PROGRESSIVO, COD_UNITAORG, COD_TIPOINC, TITOLO_POSIZIONE, DATA_AFFIDAMENTO)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY MANSIONI_COMPETENZE VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY MOTIVAZIONI VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY OBIETTIVI_GENERALI VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY RISORSE VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY OSSERVAZIONI_DIRIGENTE VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY ESITO_VALUTAZIONE VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY GIUDIZIO_VALUTAZIONE VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY PROPOSTA_VALUTAZIONE VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY ARTICOLO_REVOCA VARCHAR2(4000);
ALTER TABLE SG303_INCINDIVIDUALI MODIFY ANNOTAZIONI VARCHAR2(4000);

create table SG304_INCINDIVIDIMPORTI
( PROGRESSIVO       NUMBER not null,
  COD_UNITAORG      VARCHAR2(20) not null,
  COD_TIPOINC       VARCHAR2(5) not null,
  TITOLO_POSIZIONE  VARCHAR2(500) not null,
  DATA_AFFIDAMENTO  DATE not null,
  COD_CONTRATTO     VARCHAR2(5) not null,
  COD_VOCE          VARCHAR2(5) not null,
  COD_VOCE_SPECIALE VARCHAR2(5) not null,
  DECORRENZA        DATE not null,
  DECORRENZA_FINE   DATE,
  IMPORTO           NUMBER,
  VOCE_POSIZIONE    VARCHAR2(1) DEFAULT 'N')
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG304_INCINDIVIDIMPORTI.PROGRESSIVO
  is 'Progressivo dipendente';
comment on column SG304_INCINDIVIDIMPORTI.COD_UNITAORG
  is 'Codice unità organizzativa';
comment on column SG304_INCINDIVIDIMPORTI.COD_TIPOINC
  is 'Codice tipo incarico';
comment on column SG304_INCINDIVIDIMPORTI.TITOLO_POSIZIONE
  is 'Titolo Posizione';
comment on column SG304_INCINDIVIDIMPORTI.DATA_AFFIDAMENTO
  is 'Data affidamento';
comment on column SG304_INCINDIVIDIMPORTI.COD_CONTRATTO
  is 'Codice contratto';
comment on column SG304_INCINDIVIDIMPORTI.COD_VOCE
  is 'Codice voce';
comment on column SG304_INCINDIVIDIMPORTI.COD_VOCE_SPECIALE
  is 'Codice voce speciale';
comment on column SG304_INCINDIVIDIMPORTI.DECORRENZA
  is 'Data decorrenza';
comment on column SG304_INCINDIVIDIMPORTI.DECORRENZA_FINE
  is 'Data decorrenza fine';
comment on column SG304_INCINDIVIDIMPORTI.IMPORTO
  is 'Importo mensile';
comment on column SG304_INCINDIVIDIMPORTI.VOCE_POSIZIONE
  is 'Voce relativa alla posizione (S/N)';
alter table SG304_INCINDIVIDIMPORTI
  add constraint SG304_PK primary key (PROGRESSIVO, COD_UNITAORG, COD_TIPOINC, TITOLO_POSIZIONE, DATA_AFFIDAMENTO, COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG305_INCCOMMISSIONI
( COD_COMMISSIONE      VARCHAR2(5) not null,
  DESCRIZIONE          VARCHAR2(100),
  CATEGORIE_VALUTABILI VARCHAR2(200),
  COD_UNITAORG         VARCHAR2(20),
  TIPOATTO             VARCHAR2(30),
  AUTORITA             VARCHAR2(40),
  NUMATTO              VARCHAR2(20),
  DATAATTO             DATE,
  DATAESEC             DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG305_INCCOMMISSIONI.COD_COMMISSIONE
  is 'Codice commissione';
comment on column SG305_INCCOMMISSIONI.DESCRIZIONE
  is 'Descrizione';
comment on column SG305_INCCOMMISSIONI.CATEGORIE_VALUTABILI
  is 'Elenco codici categoria incarico valutabili';
comment on column SG305_INCCOMMISSIONI.COD_UNITAORG
  is 'Eventuale codice unità organizzativa valutabile';
comment on column SG305_INCCOMMISSIONI.TIPOATTO
  is 'Tipo atto (Delibera/determina)';
comment on column SG305_INCCOMMISSIONI.AUTORITA
  is 'Autorità atto';
comment on column SG305_INCCOMMISSIONI.NUMATTO
  is 'Numero atto';
comment on column SG305_INCCOMMISSIONI.DATAATTO
  is 'Data atto';
comment on column SG305_INCCOMMISSIONI.DATAESEC
  is 'Data esecutività atto';
alter table SG305_INCCOMMISSIONI
  add constraint SG305_PK primary key (COD_COMMISSIONE)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table SG306_INCCOMMCOMPONENTI
( COD_COMMISSIONE VARCHAR2(5) not null,
  PROGRESSIVO     NUMBER not null,
  PRESIDENTE      VARCHAR2(1) DEFAULT 'N',
  TITOLARE        VARCHAR2(1) DEFAULT 'N',
  TIPO_NOMINA     VARCHAR2(1) DEFAULT 'A')
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column SG306_INCCOMMCOMPONENTI.COD_COMMISSIONE
  is 'Codice commissione';
comment on column SG306_INCCOMMCOMPONENTI.PROGRESSIVO
  is 'Progressivo dipendente';
comment on column SG306_INCCOMMCOMPONENTI.PRESIDENTE
  is 'Presidente: S/N';
comment on column SG306_INCCOMMCOMPONENTI.TITOLARE
  is 'Titolare: S/N';
comment on column SG306_INCCOMMCOMPONENTI.TIPO_NOMINA
  is 'Tipo nomina: Aziendale/Sindacale';
alter table SG306_INCCOMMCOMPONENTI
  add constraint SG306_PK primary key (COD_COMMISSIONE, PROGRESSIVO)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T350_REGREPERIB add TIPOLOGIA varchar2(1) default 'R';
comment on column T350_REGREPERIB.TIPOLOGIA is 'R=Reperibilità - G=Guardia';

alter table T380_PIANIFREPERIB add TIPOLOGIA varchar2(1) default 'R';
comment on column T380_PIANIFREPERIB.TIPOLOGIA is 'R=Reperibilità - G=Guardia';
alter table T380_PIANIFREPERIB drop primary key;
alter table T380_PIANIFREPERIB add constraint T380_PK primary key (PROGRESSIVO,DATA,TIPOLOGIA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- CONVERSIONE DA VECCHIA GESTIONE INCARICHI

INSERT INTO SG301_INCTIPO (COD_TIPOINC,DESCRIZIONE,DECORRENZA,DECORRENZA_FINE)
SELECT SUBSTR(CODICE,1,5), SUBSTR(DESCRIZIONE,1,500), TO_DATE('01011900','DDMMYYYY'), TO_DATE('31123999','DDMMYYYY') FROM SG105_TIPOINCARICHI;

INSERT INTO SG303_INCINDIVIDUALI
              (PROGRESSIVO,COD_TIPOINC, DATA_AFFIDAMENTO, DATA_SOTTOSCRIZIONE, TITOLO_POSIZIONE,
               AUTORITA,TIPOATTO,NUMATTO,DATAATTO,DATAESEC,
               ANNOTAZIONI,DATA_SCADENZA,COD_UNITAORG)
SELECT progressivo, SUBSTR(nomecampo,1,5), datadecor, dataregistr, NVL(SG104.DESCRIZIONE,' '),
              autorita, tipoatto, numatto, dataatto, dataesec,
              note, datafine, NVL(SUBSTR(sede,1,20),' ')
 FROM SG100_PROVVEDIMENTO SG100, SG104_TIPOMOTIVAZIONI SG104
WHERE SG100.TIPO_PROVV = 'I'
   AND SG100.CAUSALE = SG104.CODICE (+);

CREATE TABLE SG100_20080417 AS SELECT * FROM SG100_PROVVEDIMENTO;
DELETE FROM SG100_PROVVEDIMENTO WHERE TIPO_PROVV = 'I';

INSERT INTO SG302_INCAZIENDALI (COD_TIPOINC, COD_UNITAORG, TITOLO_POSIZIONE, DECORRENZA, DECORRENZA_FINE)
SELECT DISTINCT COD_TIPOINC, COD_UNITAORG, TITOLO_POSIZIONE, TO_DATE('01011900','DDMMYYYY'), TO_DATE('31123999','DDMMYYYY') FROM SG303_INCINDIVIDUALI;

UPDATE MONDOEDP.I091_DATIENTE I091
SET DATO = (SELECT DATO FROM MONDOEDP.I091_DATIENTE
                          WHERE AZIENDA = I091.AZIENDA
                                AND TIPO = 'C14_PROVVSEDE')
WHERE TIPO = 'C20_INCARICOUNITAORG';

ALTER TABLE P092_CODICIINAIL add ORE_MESE NUMBER(5,2);
COMMENT ON COLUMN P092_CODICIINAIL.ORE_MESE
  is 'Ore lavorative del mese (opzionale)';
UPDATE P092_CODICIINAIL T  SET T.ORE_MESE=156 WHERE T.ORE_MESE IS NULL
AND T.ORE_SETTIMANA IS NOT NULL AND T.RETR_MINIMALE_GG IS NOT NULL;

alter table T200_CONTRATTI add ORE_LAVFASCE_CONASS varchar2(1) default 'N';
comment on column T200_CONTRATTI.ORE_LAVFASCE_CONASS is 'S=Le ore lavorate in fasce vengono passate alle paghe comprensive delle ore rese da assenza - N=Le ore lavorate in fasce NON vengono passate alle paghe comprensive delle ore rese da assenza';

alter table MONDOEDP.I090_ENTI add DOMINIO_USR varchar2(80);
comment on column MONDOEDP.I090_ENTI.DOMINIO_USR is 'Dominio per l''autenticazione degli utenti';
alter table MONDOEDP.I090_ENTI add DOMINIO_DIP varchar2(80);
comment on column MONDOEDP.I090_ENTI.DOMINIO_DIP is 'Dominio per l''autenticazione dei dipendenti in IrisWEB';

UPDATE P552_CONTOANNREGOLE T SET T.COD_ARROTONDAMENTO='P1' WHERE T.ANNO=2007 AND T.COD_TABELLA='T02'
AND T.RIGA=0 AND T.COLONNA>0;


alter table P272_RETRIBUZIONE_CONTRATTUALE
  drop constraint P272_PK cascade;
alter table P272_RETRIBUZIONE_CONTRATTUALE
  add constraint P272_PK primary key (PROGRESSIVO, COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DECORRENZA_INIZIO, ID_VOCE_PROGRAMMATA, TIPO_VOCE, ORIGINE)
  using index
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 24K
    minextents 1
    maxextents unlimited
  );

alter table T020_ORARI add TIMBRATURAMENSA_DETRAZIONE varchar2(5);
comment on column T020_ORARI.TIMBRATURAMENSA_DETRAZIONE is 'Detrazione alternativa quando scatta la timbratura forzata dovuta a timbratura di mensa';

alter table T020_ORARI add PMT_TIMB_MATURAMENSA varchar2(1) default 'N';
comment on column T020_ORARI.PMT_TIMB_MATURAMENSA is 'Riferito al riconoscimento dello stacco di mensa PMT: S=Vengono escluse le timbrature con causale che non matura mensa - N=vengono considerate tutte le timbrature';

alter table T265_CAUASSENZE add CM_DEBSETT varchar2(5);
comment on column T265_CAUASSENZE.CM_DEBSETT is 'Parametro per il tipo cumulo M: ore settimanali da rendere in alternativa al debito settimanale da anagrafico';

comment on column T265_CAUASSENZE.CQ_PROGRESSIVO is 'In caso di TipoCumulo=Q (maturazione dei primi riposi) e TipoCumulo=M (maturazione proporz.alle ore lavorate) indica la considerazione o meno della maturazione progressiva. Valori ammessi (S/N)';

alter table MONDOEDP.I071_PERMESSI add INSERISCI_TIMBRATURE varchar2(1) default 'S';
comment on column MONDOEDP.I071_PERMESSI.INSERISCI_TIMBRATURE is 'S=Si possono inserire timbrature manuali - N=Non si possono inserire timbrature manuali';

alter table T025_CONTMENSILI add PAR_CARTELLINO varchar2(5);
comment on column T025_CONTMENSILI.PAR_CARTELLINO is 'Parametrizzazione del cartellino usata in fase di stampa del cartellino';

alter table P430_ANAGRAFICO add RETRIB_MESE_PREC VARCHAR2(1) default 'N';
comment on column P430_ANAGRAFICO.RETRIB_MESE_PREC
  is 'Retribuzioni afferenti al mese precedente (S/N)';

alter table P201_ASSOGGETTAMENTI add DECORRENZA_FINE date;
update P201_ASSOGGETTAMENTI t set
    DECORRENZA_FINE =
    (select min(DECORRENZA) - 1 from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO and
     DECORRENZA > t.DECORRENZA)
  where
    DECORRENZA < (select max(DECORRENZA) from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO);
update P201_ASSOGGETTAMENTI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where
    DECORRENZA = (select max(DECORRENZA) from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO);


create index P605_IDX_PROG on P605_770DATIINDIVIDUALI (progressivo);

alter table P500_CUDSETUP modify CODICE_ISTAT_EMENS VARCHAR2(6);

update I060_LOGIN_DIPENDENTE set DATA_PW = trunc(SYSDATE) where DATA_PW is null;

alter table MONDOEDP.I060_LOGIN_DIPENDENTE add EMAIL VARCHAR2(200);
comment on column MONDOEDP.I060_LOGIN_DIPENDENTE.EMAIL is 'Email del responsabile per gestione ciclo autorizzativo assenze';
create table I061_PROFILI_DIPENDENTE
(
  AZIENDA VARCHAR2(30) not null,
  NOME_UTENTE VARCHAR2(30) not null,
  NOME_PROFILO VARCHAR2(30) not null,
  INIZIO_VALIDITA DATE,
  FINE_VALIDITA DATE,
  PERMESSI VARCHAR2(20),
  FILTRO_FUNZIONI VARCHAR2(20),
  FILTRO_ANAGRAFE VARCHAR2(20),
  FILTRO_DIZIONARIO VARCHAR2(20)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table I061_PROFILI_DIPENDENTE
  add constraint I061_PK primary key (AZIENDA, NOME_UTENTE, NOME_PROFILO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
-- Add/modify columns
alter table P212_PARAMETRISTIPENDI modify MESI_POSTICIPO13A NUMBER(2);

drop table t500_piantaorg;
drop table t501_piantadett;

CREATE TABLE T500_PIANIFSERVIZI (
  COMANDATO VARCHAR2(1),
  TIPO_TURNO VARCHAR2(20),
  DATA DATE,
  PATTUGLIA NUMBER(8),
  SERVIZIO VARCHAR2(20),
  DALLE VARCHAR2(5),
  ALLE VARCHAR2(5),
  CAUSALE VARCHAR2(5),
  NOTE VARCHAR2(2000),
  NOTE_SERVIZIO VARCHAR2(2000))
TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

comment on column T500_PIANIFSERVIZI.COMANDATO is 'S=Servizio comandato - N=Servizio normale';
comment on column T500_PIANIFSERVIZI.PATTUGLIA is 'Progressivo automatico';

ALTER TABLE T500_PIANIFSERVIZI ADD CONSTRAINT T500_PK PRIMARY KEY (DATA, PATTUGLIA)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

CREATE TABLE T501_PIANIFAPPARATI (
  DATA DATE,
  PATTUGLIA NUMBER(8),
  DALLE VARCHAR2(5),
  TIPO VARCHAR2(5),
  CODICE VARCHAR2(40)
) TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

ALTER TABLE T501_PIANIFAPPARATI ADD CONSTRAINT T501_PK PRIMARY KEY (DATA,PATTUGLIA,TIPO,CODICE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);
ALTER TABLE T501_PIANIFAPPARATI ADD CONSTRAINT T501_FK_T500 FOREIGN KEY (DATA,PATTUGLIA) REFERENCES T500_PIANIFSERVIZI (DATA,PATTUGLIA) ON DELETE CASCADE;

create table T502_PATTUGLIE (
  DATA date,
  PATTUGLIA number(8),
  CAMPO1 varchar2(20),
  CAMPO2 varchar2(20),
  PROGRESSIVO number(8)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T502_PATTUGLIE add constraint T502_PK primary key (DATA,PATTUGLIA,PROGRESSIVO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

CREATE TABLE T520_TEMPLATE_SERVIZI (
  DATA DATE,
  TIPO_TURNO VARCHAR2(20),
  COMANDATO VARCHAR2(1),
  NOME VARCHAR2(20)
) TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

ALTER TABLE T520_TEMPLATE_SERVIZI ADD CONSTRAINT T520_PK PRIMARY KEY (DATA,TIPO_TURNO,NOME) USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

CREATE TABLE T540_SERVIZI (
  CODICE VARCHAR2(20),
  DESCRIZIONE VARCHAR2(80),
  COLORE VARCHAR2(20) default 'clYellow',
  COLOREFONT  VARCHAR2(20) default 'clBlack'
) TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

ALTER TABLE T540_SERVIZI ADD CONSTRAINT T540_PK PRIMARY KEY (CODICE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

CREATE TABLE T550_APPARATI
(
  COD_APPARATO    VARCHAR2(5) NOT NULL,
  CODICE          VARCHAR2(40) NOT NULL,
  DECORRENZA      DATE NOT NULL,
  DECORRENZA_FINE DATE,
  DESCRIZIONE     VARCHAR2(80),
  STATO           VARCHAR2(1) DEFAULT 'D',
  FILTRO1         VARCHAR2(2000),
  FILTRO2         VARCHAR2(2000),
  FILTRO_SERVIZI  VARCHAR2(2000)
)
TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

COMMENT ON COLUMN T550_APPARATI.STATO IS 'D=DISPONIBILE - O=OCCUPATO - N=NON FUNZIONANTE';

ALTER TABLE T550_APPARATI ADD CONSTRAINT T550_PK PRIMARY KEY (COD_APPARATO, CODICE, DECORRENZA)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

CREATE TABLE T555_TIPOAPPARATI (
  CODICE VARCHAR2(5),
  DESCRIZIONE VARCHAR2(40)
) TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

ALTER TABLE T555_TIPOAPPARATI ADD CONSTRAINT T555_PK PRIMARY KEY (CODICE)
  USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);
ALTER TABLE T550_APPARATI ADD CONSTRAINT T550_FK_T555 FOREIGN KEY (COD_APPARATO) REFERENCES T555_TIPOAPPARATI (CODICE);

alter table T265_CAUASSENZE add VALIDAZIONE varchar2(1) default 'N';
comment on column T265_CAUASSENZE.VALIDAZIONE is 'S=segnalazione validazione sul tabellone turni';

alter table MONDOEDP.I071_PERMESSI add T040_VALIDAZIONE varchar2(1) default 'N';
comment on column MONDOEDP.I071_PERMESSI.T040_VALIDAZIONE is 'S=è consentita la validazione delle assenze - N=non è consentita la validazione delle assenze';

alter table MONDOEDP.I071_PERMESSI add SERVIZI_COMANDATI varchar2(1) default 'N';
comment on column MONDOEDP.I071_PERMESSI.SERVIZI_COMANDATI is 'S=è consentita la gestione dei servizi comandati - N=non è consentita la gestione dei servizi comandati';

comment on column P430_ANAGRAFICO.DETRAZ_LAVDIP
  is 'Altre detrazioni: S=Lavoro dipendente e assimilati, A=Altri redditi, N=Nessuna detrazione del tipo precedente';

UPDATE P200_VOCI T SET T.DESCRIZIONE='Detrazioni lav. dip./altri redd. a cong.', T.DESCRIZIONE_STAMPA='Detrazioni lav. dip./altri redd. a cong.'
WHERE T.COD_VOCE='13012' AND T.COD_VOCE_SPECIALE='CONG';
UPDATE P200_VOCI T SET T.DESCRIZIONE='Detrazioni per lavoro dip./altri redditi', T.DESCRIZIONE_STAMPA='Detrazioni per lavoro dip./altri redditi'
WHERE T.COD_VOCE='13010' AND T.COD_VOCE_SPECIALE='BASE';

alter table P236_TABELLEANF modify DESCRIZIONE VARCHAR2(300);

ALTER TABLE T101_ANOMALIE MODIFY ANOMALIA VARCHAR2(150);

ALTER TABLE T760_REGOLEINCENTIVI DROP COLUMN QUALIFICA;
ALTER TABLE T760_REGOLEINCENTIVI DROP COLUMN REPARTO;
ALTER TABLE T760_REGOLEINCENTIVI DROP COLUMN VOCEPAGHE;

UPDATE P201_ASSOGGETTAMENTI T SET T.DECORRENZA=TO_DATE('01011900','DDMMYYYY')
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE='10150'
AND T.COD_VOCE_SPECIALE_PADRE='ENTE' AND T.COD_VOCE_FIGLIO='11150' AND T.COD_VOCE_SPECIALE_FIGLIO='ENTE'
AND T.DECORRENZA=TO_DATE('31102004','DDMMYYYY');

UPDATE P200_VOCI T SET T.ECCEZIONI_SENSIBILI='ab'
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE IN('15095','15100','15102','15120','15122');

