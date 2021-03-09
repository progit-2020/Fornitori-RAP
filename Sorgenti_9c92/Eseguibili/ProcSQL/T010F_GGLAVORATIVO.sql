create or replace function T010F_GGLAVORATIVO(
  P_PROGRESSIVO in integer, 
  P_DATA in date, 
  P_SEMPRE_CALENDARIO in varchar2 := 'N', 
  P_NOPIANIF_CALENDARIO in varchar2 := 'N',
  P_NOPIANIF_T040T100 in varchar2 := 'N'
) return varchar2 as
  W_INIZIO   DATE;
  W_FINE     DATE;
  W_TURNISTA varchar2(1);
  W_ORARIO varchar2(5);
  wGiustLav integer;
  result varchar2(1);
begin
  begin
    select DECODE(T430.TGESTIONE,'1','S','N'),
           NVL(T430.INIZIO,TO_DATE('31123999','DDMMYYYY')),
           NVL(T430.FINE,TO_DATE('31123999','DDMMYYYY'))
      into W_TURNISTA, W_INIZIO, W_FINE
      from T430_STORICO T430
     where T430.PROGRESSIVO = P_PROGRESSIVO
       and P_DATA between T430.DATADECORRENZA and T430.DATAFINE;
  exception
    when NO_DATA_FOUND then
      W_TURNISTA:='N';
      W_INIZIO:=P_DATA + 1;
      W_FINE:=P_DATA - 1;
  end;
  if P_DATA < w_inizio or P_DATA > w_fine then
    result:='N';
  else
    if (P_SEMPRE_CALENDARIO = 'S') or (W_TURNISTA = 'N') then
      begin
        select 'N'
          into result
          from V010_CALENDARI
         where PROGRESSIVO = P_PROGRESSIVO
           and DATA = P_DATA
           and (LAVORATIVO = 'N' or FESTIVO = 'S');
      exception
        when NO_DATA_FOUND then
          result:='S';
      end;
    else
      begin
        select decode(count(*),0,'S','N')
          into result
          from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260
         where T040.PROGRESSIVO = P_PROGRESSIVO
           and T040.DATA = P_DATA
           and T040.TIPOGIUST = 'I'
           and T040.CAUSALE = T265.CODICE
           and T265.CODRAGGR = T260.CODICE
           and T260.CODINTERNO = 'H';
      exception
        when NO_DATA_FOUND then
          result:='S';
      end;
      if result = 'S' then
        begin
          select 'N'
           into result
           from T080_PIANIFORARI
          where PROGRESSIVO = P_PROGRESSIVO
            and DATA = P_DATA
            and TURNO1 = '0';
        exception
          when NO_DATA_FOUND then
            result:='S';
            if P_NOPIANIF_CALENDARIO = 'S' then --PARAMETRO DEFAULT = 'N'
              begin
                select max(ORARIO)
                 into W_ORARIO
                 from T080_PIANIFORARI
                where PROGRESSIVO = P_PROGRESSIVO
                  and DATA = P_DATA
                  and nvl(TURNO1,'nvl') <> '0';
                if W_ORARIO is not null then
                  result:='S';
                else
                  select 'N'
                    into result
                    from V010_CALENDARI
                   where PROGRESSIVO = P_PROGRESSIVO
                     and DATA = P_DATA
                     and (LAVORATIVO = 'N' or FESTIVO = 'S');
                end if;
              exception
                when NO_DATA_FOUND then
                  result:='S';
              end;
            elsif P_NOPIANIF_T040T100 = 'S' then
              -- verifico esistenza timbrature
              select decode(count(*),0,'N','S') into result from VT100_TIMB_DATAORA where PROGRESSIVO = P_PROGRESSIVO and DATA = P_DATA;
              if result = 'N' then
                select decode(count(*),0,'N','S') into result from VT105_RICHIESTETIMBRATURE where PROGRESSIVO = P_PROGRESSIVO and DATA = P_DATA and nvl(STATO,'S') <> 'N';
              end if;  
              -- verifico esistenza giustificativi
              if result = 'N' then
                select decode(sum(numero),0,'N','S') into result from (
                  select count(*) numero from T040_GIUSTIFICATIVI where PROGRESSIVO = P_PROGRESSIVO and DATA = P_DATA
                  union all
                  select count(*) numero from VT050_RICHIESTE_SENZAREVOCA where PROGRESSIVO = P_PROGRESSIVO and P_DATA between DAL and AL and nvl(STATO,'S') <> 'N'
                );  
                -- se ci sono giustificativi, verifico esistenza giustificativi che impattano su gg. lav.
                if result = 'S' then
                  select count(*) into wGiustLav from (
                    select CAUSALE from T040_GIUSTIFICATIVI where PROGRESSIVO = P_PROGRESSIVO and DATA = P_DATA
                    union 
                    select CAUSALE from VT050_RICHIESTE_SENZAREVOCA where PROGRESSIVO = P_PROGRESSIVO and P_DATA between DAL and AL and nvl(STATO,'S') <> 'N'
                    ) T040,
                    T265_CAUASSENZE T265
                  where T265.CODICE(+) = T040.CAUSALE
                  and   not (nvl(T265.GSIGNIFIC,'GL') = 'GC' and nvl(T265.GNONLAV,'A') not in ('A','B'));
                  
                  if wGiustLav = 0 then
                    select decode(LAVORATIVO,'N','N',decode(FESTIVO,'S','N'))
                      into result
                      from V010_CALENDARI
                     where PROGRESSIVO = P_PROGRESSIVO
                       and DATA = P_DATA;
                  end if;  
                end if;  
              end if;  
            end if;
        end;
      end if;
    end if;
  end if;
  return result;
end T010F_GGLAVORATIVO;
/
