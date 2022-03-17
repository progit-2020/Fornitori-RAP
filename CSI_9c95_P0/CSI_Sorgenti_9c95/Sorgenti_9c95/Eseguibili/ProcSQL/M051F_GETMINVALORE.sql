create or replace function M051F_GETMINVALORE(P_PROGRESSIVO in integer, P_CODICERIMBORSOSPESE in varchar2, P_MESESCARICO in date, P_MESECOMPETENZA in date, P_DATADA in date, P_ORADA in varchar2, P_DATO in varchar2) return varchar2 as
  result varchar2(2000);
  wNOTE varchar2(2000);
  wMINSTATO varchar2(1);
  wMAXSTATO varchar2(1);
begin
  result:=null;

  select min(NOTE),min(STATO),max(STATO)
  into wNOTE,wMINSTATO,wMAXSTATO
  from  M051_DETTAGLIORIMBORSO
  where PROGRESSIVO = P_PROGRESSIVO
  and   CODICERIMBORSOSPESE = P_CODICERIMBORSOSPESE
  and   MESESCARICO = P_MESESCARICO
  and   MESECOMPETENZA = P_MESECOMPETENZA
  and   DATADA = P_DATADA
  and   ORADA = P_ORADA;

  if P_DATO = 'NOTE' then
    result:=wNOTE;
  elsif P_DATO = 'STATO' then
    if (wMINSTATO = 'V') and (wMAXSTATO = 'V') then
      result:='Verificato';
    else
      result:='Da verificare';
    end if;
  end if;

  return result;
end;
/