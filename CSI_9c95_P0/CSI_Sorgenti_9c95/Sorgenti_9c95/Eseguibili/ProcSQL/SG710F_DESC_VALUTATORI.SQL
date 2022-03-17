CREATE OR REPLACE FUNCTION SG710F_DESC_VALUTATORI(progressivi_valutatori in varchar2) return varchar2 as
  Result varchar2(4000) := '';
  S      SG710_TESTATA_VALUTAZIONI.progressivi_valutatori%TYPE := '';
  P      T030_ANAGRAFICO.progressivo%TYPE := 0;
  D      varchar2(100) := '';
BEGIN
  Result:=null;
  S:=progressivi_valutatori||',';
  WHILE INSTR(S,',') > 0 LOOP
    P:=TO_NUMBER(TRIM(SUBSTR(S,1,INSTR(S,',') - 1)));
    BEGIN
      SELECT '(' || MATRICOLA || ') ' || COGNOME || ' ' || NOME
      INTO D
      FROM T030_ANAGRAFICO
      WHERE PROGRESSIVO = P;
    EXCEPTION
      WHEN OTHERS THEN
        D:='';
    END;
    IF D IS NOT NULL THEN
      IF Result IS NOT NULL THEN
        Result:=Result || '; ';
      END IF;
      Result:=Result || D;
    END IF;
    S:=SUBSTR(S,INSTR(S,',') + 1);
  END LOOP;
  return(Result);
END;
/
