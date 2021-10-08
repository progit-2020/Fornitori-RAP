create or replace function T380F_REPERIBILE_DALLE_ALLE(P_PROGRESSIVO in integer, P_DATA in date) return varchar2 as
  cursor c1 is 
    select 
      DATA,
      oreminuti(to_char(ORAINIZIO,'hh24.mi')) INIZIO,
      oreminuti(to_char(ORAINIZIO,'hh24.mi')) FINE
    from (  
      select T380.DATA, T350.ORAINIZIO, T350.ORAFINE
      from T380_PIANIFREPERIB T380, T350_REGREPERIB T350
      where T380.PROGRESSIVO = P_PROGRESSIVO
      and T380.DATA between P_DATA - 1 and P_DATA
      and T380.TURNO1 = T350.CODICE
      union
      select T380.DATA, T350.ORAINIZIO, T350.ORAFINE
      from T380_PIANIFREPERIB T380, T350_REGREPERIB T350
      where T380.PROGRESSIVO = P_PROGRESSIVO
      and T380.DATA between P_DATA - 1 and P_DATA
      and T380.TURNO2 = T350.CODICE
      union
      select T380.DATA, T350.ORAINIZIO, T350.ORAFINE
      from T380_PIANIFREPERIB T380, T350_REGREPERIB T350
      where T380.PROGRESSIVO = P_PROGRESSIVO
      and T380.DATA between P_DATA - 1 and P_DATA
      and T380.TURNO3 = T350.CODICE
    ) order by DATA,ORAINIZIO;
    
  result varchar2(100);
  inizio varchar2(5);
  fine varchar2(5);
begin
  result:=null;
  for t1 in c1 loop
    inizio:=minutiore(t1.INIZIO);
    fine:=minutiore(t1.FINE);
    
    if t1.DATA < P_DATA and t1.INIZIO < t1.FINE then
      inizio:=null;
    elsif t1.DATA < P_DATA and t1.INIZIO >= t1.FINE then
      inizio:='00.00';
    elsif t1.DATA = P_DATA and t1.INIZIO >= t1.FINE then
      fine:='00.00';
    end if;
    
    if inizio is not null then
      if result is not null then
        result:=result||';';
      end if;
      result:=result||inizio||'-'||fine;
    end if;
  end loop;

  return result;
end;
/