create or replace function V010F_GGLAV_MESE(P_PROGRESSIVO in integer, P_DATA in date, P_DEFAULT in integer := null) return integer as
  result integer;
  wTipoPT varchar2(1);
  wPercPT number;
  wGGLavSett integer;
  wGGLavMancanti integer;
  wDataPrec date;
  wCalendPrec varchar2(5);
  
  cursor c1 is 
    select
      V010.DATA,V010.CODICE,decode(t010f_gglavorativo(V010.PROGRESSIVO,V010.DATA,'S','N','S'),'S',1,0) GGLAV,
      T430.INIZIO,T430.FINE
      --PROGRESSIVO,trunc(DATA,'MM'),data,lavorativo,festivo,decode(LAVORATIVO,'N',0,decode(FESTIVO,'S',0,1)),t010f_gglavorativo(PROGRESSIVO,DATA)
    from V010_CALENDARI V010, T430_STORICO T430
    where V010.PROGRESSIVO = P_PROGRESSIVO
    and V010.DATA between trunc(P_DATA,'MM') and last_day(P_DATA)
    and V010.PROGRESSIVO = T430.PROGRESSIVO
    and V010.DATA between T430.DATADECORRENZA and T430.DATAFINE
    order by V010.DATA;
  
begin
  result:=0;
  wDataPrec:=trunc(P_DATA);
  wCalendPrec:=null;
  
  for t1 in c1 loop
    if FALSE OR 
       t1.DATA between t1.INIZIO and nvl(t1.FINE,t1.DATA) then
      if t1.DATA > wDataPrec then
        select sum(decode(LAVORATIVO,'N',0,decode(FESTIVO,'S',0,1))) 
        into wGGLavMancanti
        from T011_CALENDARI
        where CODICE = nvl(wCalendPrec,t1.CODICE)
        and DATA between wDataPrec and t1.DATA - 1;
        result:=result + wGGLavMancanti;
      end if; 
      wDataPrec:=t1.DATA + 1;
      wCalendPrec:=t1.CODICE;
      result:=result + t1.GGLAV;
    end if;  
  end loop;
  
  if wCalendPrec is null then
    result:=P_DEFAULT;
  elsif wDataPrec <= last_day(P_DATA) then
    select sum(decode(LAVORATIVO,'N',0,decode(FESTIVO,'S',0,1))) 
    into wGGLavMancanti
    from T011_CALENDARI
    where CODICE = wCalendPrec
    and DATA between wDataPrec and last_day(P_DATA);
    result:=result + wGGLavMancanti;
  end if;  

  begin
    select
      GetPercPart(T430.PARTTIME, 'TIPO'),
      nvl(GetPercPart(T430.PARTTIME, 'PIANTA'),100),
      T010F_GETDATO(P_PROGRESSIVO,P_DATA,'G')
    into wTipoPT, wPercPT, wGGLavSett
    from T430_STORICO T430
    where T430.PROGRESSIVO = P_PROGRESSIVO
    and last_day(P_DATA) between T430.DATADECORRENZA and T430.DATAFINE
    and nvl(T430.TGESTIONE,'0') <> '1';

    if (wTipoPT = 'V') and (wPercPT > 0) and (wPercPT < 100) and (wGGLavSett >= 5) then
      result:=trunc(result * wPercPT / 100);
    end if;
  exception
    when no_data_found then
      null;
  end;

  return result;
end;
/
