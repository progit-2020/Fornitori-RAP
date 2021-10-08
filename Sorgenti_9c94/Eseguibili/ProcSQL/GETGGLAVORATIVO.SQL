create or replace function GetGGLavorativo(Prog in integer,DataElab in date,ElencoCauAss in varchar2)
  return varchar2 is ggLavorativo varchar2(1);
  ggAssenza varchar2(1);  
  F varchar2(5);
  L varchar2(5);
  MonteOre varchar2(5);
  G number;
begin
  SELECT DECODE(NVL(TO_CHAR(MAX(T430.PROGRESSIVO)),'N'),'N','N','S') INTO ggLavorativo FROM T430_STORICO T430
-- Dipendente in servizio o indennità di maternita'
    WHERE T430.PROGRESSIVO = Prog AND DataElab BETWEEN T430.DATADECORRENZA AND T430.DATAFINE
    AND (DataElab BETWEEN T430.INIZIO AND NVL(T430.FINE,TO_DATE('31123999','DDMMYYYY')) OR
         DataElab BETWEEN T430.INIZIO_IND_MAT AND T430.FINE_IND_MAT)
    AND DataElab BETWEEN T430.INIZIO AND NVL(T430.FINE,TO_DATE('31123999','DDMMYYYY'))
    -- Esiste almeno una timbratura
    AND (EXISTS (SELECT 'X' FROM T100_TIMBRATURE T100 WHERE T100.PROGRESSIVO = T430.PROGRESSIVO
         AND DataElab = T100.DATA AND T100.FLAG IN('O','I')
        )
    -- Esiste almeno un giustificativo di presenza
    OR EXISTS (SELECT 'X' FROM T040_GIUSTIFICATIVI T040, T275_CAUPRESENZE T275 WHERE T040.PROGRESSIVO = T430.PROGRESSIVO
               AND DataElab = T040.DATA AND T040.CAUSALE = T275.CODICE)
    -- Esiste almento un'assenza con giorno lavorativo ai fini INPS attivo
    OR EXISTS (SELECT 'X' FROM T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265 WHERE T040.PROGRESSIVO = T430.PROGRESSIVO
               AND DataElab = T040.DATA AND ((T040.CAUSALE = T265.CODICE AND T265.GLAVINPS = 'S')
               OR INSTR(ElencoCauAss,'<'||T040.CAUSALE||'>')>0)
              )
   );
  if ggLavorativo = 'N' then
    SELECT DECODE(NVL(TO_CHAR(MAX(PROGRESSIVO)),'N'),'N','N','S') INTO ggAssenza 
      FROM T040_GIUSTIFICATIVI WHERE PROGRESSIVO = Prog AND DATA = DataElab;
    if ggAssenza = 'N' then
      GetCalendario(Prog,DataElab,F,L,G,MonteOre);
      if L = 'N' or F = 'S' then
        ggLavorativo:='N';
      else
        SELECT DECODE(NVL(TO_CHAR(MAX(T430.PROGRESSIVO)),'N'),'N','N','S') INTO ggLavorativo
        FROM T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISETTIMANA T221, T020_ORARI T020
        -- Dipendente in servizio o indennità di maternita'
        WHERE T430.PROGRESSIVO = Prog AND DataElab BETWEEN T430.DATADECORRENZA AND T430.DATAFINE
        AND DataElab BETWEEN T430.INIZIO AND NVL(T430.FINE,TO_DATE('31123999','DDMMYYYY'))
        AND T430.PORARIO = T220.CODICE AND DataElab BETWEEN T220.DECORRENZA AND T220.DECORRENZA_FINE
        AND T220.CODICE = T221.CODICE AND T220.DECORRENZA = T221.DECORRENZA AND T221.PROGRESSIVO = 1
        AND T221.LUNEDI = T020.CODICE AND T020.DECORRENZA <= (SELECT MAX(T020A.DECORRENZA) FROM T020_ORARI T020A 
                                                              WHERE T020A.CODICE = T020.CODICE AND T020A.DECORRENZA <= DataElab)
        AND NVL(T020.OBBLFAC,'*') <> 'O';
      end if;  
    end if;
  end if;  
  Return(ggLavorativo);
END GetGGLavorativo;
/
