create or replace procedure T029P_GETRIENTRIPOMERIDIANI(P_PROGRESSIVO in integer, P_DATA in date, P_RIENTRI_TEORICI out integer, P_RIENTRI_REALI out integer) as
  W_GGLAVTEORICI integer;
  W_GGLAV integer;
begin
  P_RIENTRI_TEORICI:=0;
  P_RIENTRI_REALI:=0;
  --giorni lavorativi teorici da calendario
  select count(V010.DATA) into W_GGLAVTEORICI
  from V010_CALENDARI V010
  where V010.PROGRESSIVO = P_PROGRESSIVO
  and trunc(V010.DATA,'mm') = trunc(P_DATA,'mm')
  and V010.LAVORATIVO = 'S'
  and V010.FESTIVO = 'N';
  
  --rientri pomeridiani obbligatori in base ai teorici
  select nvl(max(T029.RIENTRI_OBBL),0) into P_RIENTRI_TEORICI
  from T430_STORICO T430, T029_RIENTRI_OBBLIGATORI T029 
  where T430.PROGRESSIVO = P_PROGRESSIVO
  and last_day(P_DATA) between T430.DATADECORRENZA and T430.DATAFINE
  and T029.CODICE = T430.PERSELASTICO
  and last_day(P_DATA) between T029.DECORRENZA and T029.DECORRENZA_FINE
  and T029.GG_LAVORATIVI <= W_GGLAVTEORICI;

  --giorni lavorativi effettivi
  select count(*) into W_GGLAV from (
  select V010.DATA --gg in servizio
  from V010_CALENDARI V010, T430_STORICO T430
  where V010.PROGRESSIVO = P_PROGRESSIVO
  and trunc(V010.DATA,'mm') = trunc(P_DATA,'mm')
  and V010.LAVORATIVO = 'S'
  and V010.FESTIVO = 'N'
  and V010.PROGRESSIVO = T430.PROGRESSIVO
  and V010.DATA between T430.DATADECORRENZA and T430.DATAFINE
  and V010.DATA between T430.INIZIO and nvl(T430.FINE,V010.DATA)
  and V010.DATA in (
  select /*+ unnest */ T040.DATA --giustificativi esclusi dalle assenze
  from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265
  where T040.PROGRESSIVO = P_PROGRESSIVO
  and trunc(T040.DATA,'mm') = trunc(P_DATA,'mm') 
  and T040.CAUSALE = T265.CODICE
  and T265.ESCLUSIONE = 'S'
  union
  select /*+ unnest */ T040.DATA --giustificativi di presenza
  from T040_GIUSTIFICATIVI T040, T275_CAUPRESENZE T275
  where T040.PROGRESSIVO = P_PROGRESSIVO
  and trunc(T040.DATA,'mm') = trunc(P_DATA,'mm') 
  and T040.CAUSALE = T275.CODICE
  union
  select /*+ unnest */ T100.DATA --timbrature
  from T100_TIMBRATURE T100
  where T100.PROGRESSIVO = P_PROGRESSIVO
  and trunc(T100.DATA,'mm') = trunc(P_DATA,'mm') 
  )
  minus
  select /*+ unnest */ T040.DATA --giustificativi di assenza a gg intera
  from T040_GIUSTIFICATIVI t040, T265_CAUASSENZE T265
  where T040.PROGRESSIVO = P_PROGRESSIVO
  and trunc(T040.DATA,'mm') = trunc(P_DATA,'mm') 
  and T040.TIPOGIUST = 'I'
  and T040.CAUSALE = T265.CODICE
  and T265.ESCLUSIONE = 'N'
  );
  
  --rientri pomeridiani obbligatori in base agli effettivi
  select nvl(max(T029.RIENTRI_OBBL),0) into P_RIENTRI_REALI
  from T430_STORICO T430, T029_RIENTRI_OBBLIGATORI T029 
  where T430.PROGRESSIVO = P_PROGRESSIVO
  and last_day(P_DATA) between T430.DATADECORRENZA and T430.DATAFINE
  and T029.CODICE = T430.PERSELASTICO
  and last_day(P_DATA) between T029.DECORRENZA and T029.DECORRENZA_FINE
  and T029.GG_LAVORATIVI <= W_GGLAV;
exception
  when no_data_found then
    null;
end;  
/
