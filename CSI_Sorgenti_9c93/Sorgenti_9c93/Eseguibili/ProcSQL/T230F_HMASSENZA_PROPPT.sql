create or replace function T230F_HMASSENZA_PROPPT(P_PROGRESSIVO in integer, P_DATA in date, P_CAUSALE in varchar2) return integer as
  result integer;
  wPARTTIME varchar2(3);
  wHMASSENZA_PROPPT varchar2(1);
begin
  select oreminuti(T230.HMASSENZA), T230.HMASSENZA_PROPPT
  into result, wHMASSENZA_PROPPT
  from T265_CAUASSENZE T265, T230_CAUASSENZE_PARSTO T230
  where T265.ID = T230.ID
  and T265.CODICE = P_CAUSALE
  and P_DATA between T230.DECORRENZA and T230.DECORRENZA_FINE;
  
  if (result > 0) and (wHMASSENZA_PROPPT = 'S') then
    --Leggo abilitazione delle proporzione sulla causale ed eventuali causali collegate per il controllo delle competenze
    select nvl(min(T265.PARTTIME),'N')
    into wPARTTIME
    from T265_CAUASSENZE T265
    where T265.PARTTIME <> 'N'
    and INTERSEZ_LISTE(T265.CODICE,P_CAUSALE||','||T230F_GETVALUE(P_CAUSALE,'CAUSALI_CHECKCOMPETENZE',P_DATA)) is not null;

    if (nvl(wPARTTIME,'N') <> 'N') then
      select result * nvl(max(T460.HHGIORNALIERE),100) / 100
      into result
      from T460_PARTTIME T460, T430_STORICO T430
      where T430.PROGRESSIVO = P_PROGRESSIVO
      and P_DATA between T430.DATADECORRENZA and T430.DATAFINE
      and T430.PARTTIME = T460.CODICE
      and instr(wPARTTIME,T460.TIPO) > 0;
    end if;
  end if;  
  
  return result;
exception
  when others then
    return 0;  
end;  
/