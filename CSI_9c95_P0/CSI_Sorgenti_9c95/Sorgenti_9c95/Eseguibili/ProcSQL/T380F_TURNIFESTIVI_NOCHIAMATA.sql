create or replace function T380F_TURNIFESTIVI_NOCHIAMATA(PROG_IN in integer, DATADA_IN in date, DATAA_IN in date) return integer as
  result integer;
  cursor C1 is
    select T380.* 
      from T380_PIANIFREPERIB T380 
     where T380.PROGRESSIVO = PROG_IN
       and T380.DATA between DATADA_IN and DATAA_IN
       and T380.TIPOLOGIA = 'R';
begin
  execute immediate 'ALTER SESSION SET NLS_TERRITORY = AMERICA';
  execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"';
  execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."';
  execute immediate 'ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN';
  execute immediate 'ALTER SESSION SET NLS_SORT = BINARY';
  result:=0;
  for T1 in C1 LOOP
    if T1.TURNO1 is not null then
       result:=result + T380F_GETORETURNO_NOCHIAMATA(T1.PROGRESSIVO,T1.DATA,T1.TURNO1);
    end if;  
    if T1.TURNO2 is not null then
       result:=result + T380F_GETORETURNO_NOCHIAMATA(T1.PROGRESSIVO,T1.DATA,T1.TURNO2);      
    end if;  
    if T1.TURNO3 is not null then
       result:=result + T380F_GETORETURNO_NOCHIAMATA(T1.PROGRESSIVO,T1.DATA,T1.TURNO3);
    end if;  
  end loop;
  return(result);
end T380F_TURNIFESTIVI_NOCHIAMATA;
/
