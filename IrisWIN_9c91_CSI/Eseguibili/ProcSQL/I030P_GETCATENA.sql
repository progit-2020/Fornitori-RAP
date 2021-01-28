create or replace procedure I030P_GETCATENA(sTABELLA in varchar2, sCOLONNA in varchar2, sCHAIN in out varchar2) is
  CURSOR CI035 (p_tabella     I035_RELAZIONI_DETTAGLIO.tabella%TYPE,
                p_colonna     I035_RELAZIONI_DETTAGLIO.colonna%TYPE) IS
    SELECT DISTINCT I035.colonna
    FROM   I035_RELAZIONI_DETTAGLIO I035
    WHERE  I035.tabella = p_tabella
    AND    I035.relazione like '%<#>' || p_colonna || '<#>%';
begin
  IF INSTR(NVL(sCHAIN,'#NULL#'),'''' || sCOLONNA || ''',') = 0 THEN
    sCHAIN:=sCHAIN || '''' || sCOLONNA || ''',';
    FOR RI035 IN CI035 (sTABELLA,sCOLONNA) LOOP
      I030P_GETCATENA(sTABELLA,RI035.COLONNA,sCHAIN);
    END LOOP;
  END IF;
  return;
end I030P_GETCATENA;
/
