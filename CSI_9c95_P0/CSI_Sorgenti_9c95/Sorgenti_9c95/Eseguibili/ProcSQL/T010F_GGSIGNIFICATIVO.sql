create or replace function T010F_GGSIGNIFICATIVO(P_PROGRESSIVO in integer, P_DATA in date, P_GSIGNIFIC in varchar2) return varchar2 as
  W_TURNISTA varchar2(1);
  result varchar2(1);
BEGIN
  EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_TERRITORY = AMERICA';
  result:='N';
  select DECODE(TGESTIONE,'0','N','S') into W_TURNISTA from T430_STORICO where PROGRESSIVO = P_PROGRESSIVO and P_DATA between DATADECORRENZA and DATAFINE;
  
  --Giorni di Calendario
  IF P_GSIGNIFIC = 'GC' THEN
    result:='S';
  --Giorni Lavorativi + Giorni Lav. Turnisti per i non turnisti
  ELSIF P_GSIGNIFIC = 'GL' OR (P_GSIGNIFIC = 'GT' AND W_TURNISTA = 'N') THEN
    BEGIN
      SELECT 'N'
      INTO result
      FROM V010_CALENDARI
      WHERE PROGRESSIVO = P_PROGRESSIVO
      AND DATA = P_DATA
      AND (LAVORATIVO = 'N' OR FESTIVO = 'S');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        result:='S';
    END;
  --Giorni Lav. Turnisti per i turnisti
  ELSIF P_GSIGNIFIC = 'GT' AND W_TURNISTA = 'S' THEN
    result:=T010F_GGLAVORATIVO(P_PROGRESSIVO,P_DATA);
  --Giorni da LUN. a SAB.
  ELSIF P_GSIGNIFIC = 'G6' AND TO_CHAR(P_DATA,'D') <> '1' THEN
    result:='S';
  --Esclusi festivi infrasett.
  ELSIF P_GSIGNIFIC = 'EF' THEN
    BEGIN
      SELECT 'N'
      INTO result
      FROM V010_CALENDARI
      WHERE PROGRESSIVO = P_PROGRESSIVO
      AND DATA = P_DATA
      AND TO_CHAR(P_DATA,'D') <> '1'
      AND FESTIVO = 'S';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        result:='S';
    END;
  --DOM.+festivi infrasett.
  ELSIF P_GSIGNIFIC = 'DF' THEN
    IF TO_CHAR(P_DATA,'D') = '1' THEN
      result:='S';
    ELSE
      BEGIN
        SELECT 'S'
        INTO result
        FROM V010_CALENDARI
        WHERE PROGRESSIVO = P_PROGRESSIVO
        AND DATA = P_DATA
        AND TO_CHAR(P_DATA,'D') <> '1'
        AND FESTIVO = 'S';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          result:='N';
      END;
    END IF;
  END IF;
  return result;
EXCEPTION
  when no_data_found then
    return 'N';
END;
/