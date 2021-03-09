-- Nuova funzione che lavora sulle 24 ore antecedenti a tutte le timbrature
create or replace function CONTROLLO_RIPOSI(prog in integer,data_conteggio in date,causali in string) return string is
  CURSOR C1 IS
    SELECT T.*,T.ROWID FROM T100_TIMBRATURE T
     WHERE PROGRESSIVO = PROG
     AND FLAG IN ('O','I')
     -- fleggato il filtro che facevo nella vers.beta dove consideravo solo le Entrate o le uscite 
     -- dopo le 13 se non ci sono poi problemi togliere questo commento
     -- AND (VERSO = 'E' OR (VERSO = 'U' AND TO_CHAR(ORA,'HH24') > '13'))
     AND (CAUSALE IS NULL OR INSTR(','||CAUSALI||',',','||CAUSALE||',') = 0)
     AND DATA = DATA_CONTEGGIO
     ORDER BY ORA,VERSO;
  CURSOR C2(PROGRE NUMBER, DATA_TIMB DATE, ORA_TIMB DATE) IS
    SELECT T.*,T.ROWID FROM T100_TIMBRATURE T
     WHERE PROGRESSIVO = PROGRE
     AND FLAG IN ('O','I')
     AND (CAUSALE IS NULL OR INSTR(','||CAUSALI||',',','||CAUSALE||',') = 0)
     AND (TO_DATE(TO_CHAR(DATA,'DDMMYYYY')||TO_CHAR(ORA,'HH24MI'),'DDMMYYYYHH24MI') >=
          TO_DATE(TO_CHAR(DATA_TIMB,'DDMMYYYY')||TO_CHAR(ORA_TIMB,'HH24MI'),'DDMMYYYYHH24MI') - 1)
     AND (TO_DATE(TO_CHAR(DATA,'DDMMYYYY')||TO_CHAR(ORA,'HH24MI'),'DDMMYYYYHH24MI') <=
          TO_DATE(TO_CHAR(DATA_TIMB,'DDMMYYYY')||TO_CHAR(ORA_TIMB,'HH24MI'),'DDMMYYYYHH24MI'))
     ORDER BY TO_DATE(TO_CHAR(DATA,'DDMMYYYY')||TO_CHAR(ORA,'HH24MI'),'DDMMYYYYHH24MI') DESC,VERSO DESC;
  INTERVALLO integer;
  INTERVALLO_TIMB integer;
  ORA_ENTRATA DATE;
  INT_COMODO integer;
  VERSO_ULT_TIMB VARCHAR2(1);
  DATA_ULT_TIMB DATE;
  ORA_ULT_TIMB DATE;
  ora1 varchar2(20);
  ora2 varchar2(20);
  orae varchar2(20);
BEGIN
  INTERVALLO:=1440;
  INT_COMODO:=0;
  ORA_ENTRATA:=NULL;
  VERSO_ULT_TIMB:='';
  --Scorro tutte le timbrature del giorno e per ognuna calcolo il massimo intervallo; tra tutti gli
  --intervalli massimi prendo il minimo in quanto basta che uno sia sotto le ore minime di riposo previsto
  FOR T1 IN C1 LOOP
    INTERVALLO_TIMB:=0;
    ora1:=TO_CHAR(T1.ORA,'HH24MI');
    IF T1.VERSO = 'E' THEN
      ORA_ENTRATA:=TO_DATE(TO_CHAR(T1.DATA,'DDMMYYYY')||TO_CHAR(T1.ORA,'HH24MI'),'DDMMYYYYHH24MI');
    END IF;
    orae:=TO_CHAR(ORA_ENTRATA,'HH24MI');
    --Scorro tutte le timbrature delle 24 ore precedenti
    FOR T2 IN C2(T1.PROGRESSIVO,T1.DATA,T1.ORA) LOOP
      ora2:=TO_CHAR(T2.ORA,'HH24MI');
      INT_COMODO:=0;
      IF T1.ROWID <> T2.ROWID THEN
        VERSO_ULT_TIMB:=T2.VERSO;
        DATA_ULT_TIMB:=T2.DATA;
        ORA_ULT_TIMB:=T2.ORA;
        IF T2.VERSO = 'U' AND ORA_ENTRATA IS NOT NULL THEN
          INT_COMODO:=(ORA_ENTRATA - TO_DATE(TO_CHAR(T2.DATA,'DDMMYYYY')||TO_CHAR(T2.ORA,'HH24MI'),'DDMMYYYYHH24MI')) * 1440;
          ORA_ENTRATA:=NULL;
        ELSE
          ORA_ENTRATA:=TO_DATE(TO_CHAR(T2.DATA,'DDMMYYYY')||TO_CHAR(T2.ORA,'HH24MI'),'DDMMYYYYHH24MI');
        END IF;
        orae:=TO_CHAR(ORA_ENTRATA,'HH24MI');
        IF INT_COMODO > INTERVALLO_TIMB THEN
          INTERVALLO_TIMB:=INT_COMODO;
        END IF;
      END IF;
    END LOOP;
    -- se non ci sono entrate nelle 24 ore precedenti, forzo l'intervallo minimo a 1 minuto per far
    -- comunque considerare questo periodo che in realtà è di lavoro continuato
    IF T1.VERSO = 'U' AND ORA_ENTRATA IS NULL THEN
      INT_COMODO:=1;
      IF INT_COMODO > INTERVALLO_TIMB THEN
        INTERVALLO_TIMB:=INT_COMODO;
      END IF;
    END IF;
    IF VERSO_ULT_TIMB = 'E' THEN
      INT_COMODO:=(TO_DATE(TO_CHAR(DATA_ULT_TIMB,'DDMMYYYY')||TO_CHAR(ORA_ULT_TIMB,'HH24MI'),'DDMMYYYYHH24MI')
                  - (TO_DATE(TO_CHAR(T1.DATA,'DDMMYYYY')||TO_CHAR(T1.ORA,'HH24MI'),'DDMMYYYYHH24MI') - 1)) * 1440;
      IF INT_COMODO > INTERVALLO_TIMB THEN
        INTERVALLO_TIMB:=INT_COMODO;
      END IF;
    END IF;
    IF INTERVALLO_TIMB = 0 THEN
      INTERVALLO_TIMB:=1440;
    END IF;
    --Imposto l'intervallo tra tutte le timbrature del giorno come il minore degli intervalli
    --calcolati per ogni timbratura
    IF INTERVALLO > INTERVALLO_TIMB THEN
      INTERVALLO:=INTERVALLO_TIMB;
    END IF;
  END LOOP;
  RETURN(MINUTIORE(INTERVALLO));
END CONTROLLO_RIPOSI;
/
