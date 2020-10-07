create or replace function T380F_GETORETURNO_NOCHIAMATA(P_PROGRESSIVO in integer, P_DATA in date , P_TURNO in varchar2) return integer as
  result integer;
  WORAINIZIO integer; 
  WORAINIZIO1 integer; 
  WORAINIZIO2 integer;  
  WORAFINE integer; 
  WORAFINE1 integer; 
  WORAFINE2 integer;    
  WNUM_CHIAMATE1 integer; 
  WNUM_CHIAMATE2 integer;  
  WFESTIVO1 varchar2(1); 
  WFESTIVO2 varchar2(1);
  WLAVORATIVO1 varchar2(1); 
  WLAVORATIVO2 varchar2(1);
  WTGESTIONE varchar2(1);
begin
  result:=0;
  begin
    select OREMINUTI(TO_CHAR(T350.ORAINIZIO,'HH24.MI')),OREMINUTI(TO_CHAR(T350.ORAFINE,'HH24.MI')) 
      into WORAINIZIO, WORAFINE 
      from T350_REGREPERIB T350
     where T350.CODICE = P_TURNO;
  exception
    when NO_DATA_FOUND then
      return 0;
  end;
  WORAINIZIO1:=WORAINIZIO; 
  WORAFINE1:=WORAFINE;
  /*ESTRAZIONE PERSONALE TURNISTA SI/NO*/
  WTGESTIONE:='0';
  begin
    select decode(nvl(T430.TGESTIONE,'0'),1,'S','N') into WTGESTIONE
      from T430_STORICO T430
     where T430.PROGRESSIVO = P_PROGRESSIVO
       and P_DATA between T430.DATADECORRENZA and T430.DATAFINE
       and P_DATA between T430.INIZIO and NVL(T430.FINE,TO_DATE('31/12/3999','DD/MM/YYYY'));
  exception
    when NO_DATA_FOUND then
      return 0;
  end;  
  /*INIZIALIZZAZIONE VARIABILI WFESTIVO(1/2) E WLAVORATIVO(1/2)*/
  WFESTIVO1:='N'; 
  WFESTIVO2:='N';
  WLAVORATIVO1:='N'; 
  WLAVORATIVO2:='N';
  if WORAINIZIO >= WORAFINE then
    WORAFINE1:=1440;
    WORAINIZIO2:=0; 
    WORAFINE2:=WORAFINE;
  end if;  
  begin
    select V010.FESTIVO, V010.LAVORATIVO into WFESTIVO1, WLAVORATIVO1 
      from V010_CALENDARI V010 
     where V010.PROGRESSIVO = P_PROGRESSIVO 
       and V010.DATA = P_DATA;       
    if WTGESTIONE = 'S' then
      WLAVORATIVO1:=T010F_GGLAVORATIVO(P_PROGRESSIVO,P_DATA);
    end if;
            
    if WORAINIZIO >= WORAFINE then
      select V010.FESTIVO, V010.LAVORATIVO into WFESTIVO2, WLAVORATIVO2 
        from V010_CALENDARI V010
       where V010.PROGRESSIVO = P_PROGRESSIVO 
         and V010.DATA = P_DATA + 1;         
    end if;
    if WTGESTIONE = 'S' then
      WLAVORATIVO2:=T010F_GGLAVORATIVO(P_PROGRESSIVO,P_DATA);
    end if;
  exception
    when NO_DATA_FOUND then
      return 0;
  end;
  WNUM_CHIAMATE1:=0;
  WNUM_CHIAMATE2:=0;
  if (WFESTIVO1 = 'S') or (WLAVORATIVO1 = 'N') then    
    select count(*) into WNUM_CHIAMATE1 
      from T100_TIMBRATURE T100, T275_CAUPRESENZE T275, T270_RAGGRPRESENZE T270  
     where T100.PROGRESSIVO = P_PROGRESSIVO
       and T100.DATA = P_DATA
       and T100.FLAG in ('O','I')
       and T100.CAUSALE = T275.CODICE
       and T275.CODRAGGR = T270.CODICE
       and T270.CODINTERNO = 'C'
       and OREMINUTI(TO_CHAR(T100.ORA,'HH24.MI')) between WORAINIZIO1 and WORAFINE1;        
  end if;  
  if (WFESTIVO2 = 'S') or (WLAVORATIVO2 = 'N') then
    select count(*) into WNUM_CHIAMATE2 
      from T100_TIMBRATURE T100, T275_CAUPRESENZE T275, T270_RAGGRPRESENZE T270  
     where T100.PROGRESSIVO = P_PROGRESSIVO
       and T100.DATA = P_DATA + 1
       and T100.FLAG in ('O','I')
       and T100.CAUSALE = T275.CODICE
       and T275.CODRAGGR = T270.CODICE
       and T270.CODINTERNO = 'C'
       and OREMINUTI(TO_CHAR(T100.ORA,'HH24.MI')) between WORAINIZIO2 and WORAFINE2;       
  end if;   
  if ((WFESTIVO1 = 'S') or  (WLAVORATIVO1 = 'N') or     
     (WFESTIVO2 = 'S') or (WLAVORATIVO2 = 'N')) and
     (WNUM_CHIAMATE1 + WNUM_CHIAMATE2 = 0) then  
    result:=WORAFINE - WORAINIZIO;
  end if;  
  return result;
end T380F_GETORETURNO_NOCHIAMATA;
/
