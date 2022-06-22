create or replace function T430F_GETSEDELAVORO(pPROG in number, pDATARIF in date) return varchar2 is
  result         t480_comuni.codice%type;
  wDatoSede      mondoedp.i091_datiente.dato%type;
  wEspr          varchar2(2000);
/* 
  Restituisce il codice comune della sede di lavoro per il dipendente indicato
*/
begin
  -- la sede di lavoro è così determinata:
  --   a. se è impostato il parametro aziendale C8_SEDE,
  --      e se il corrispondente dato libero è valorizzato per il progressivo e la data di riferimento indicati,
  --      considerare questo valore
  --   b. altrimenti estrarre il valore dalla tabella p150_setup

  -- 1. verifica parametri
  -- progressivo
  if pPROG is null then
    raise_application_error(-20001,'Parametri: PROGRESSIVO dipendente non specificato');
  end if;
  -- data riferimento
  if pDATARIF is null then
    raise_application_error(-20002,'Parametri: DATA RIFERIMENTO non specificata');
  end if;

  -- 2. estrae il valore del dato libero anagrafico indicato in C8_SEDE
  result:=null;
  begin
    -- estrae parametro C8_SEDE
    select dato
    into   wDatoSede
    from   mondoedp.i091_datiente
    where  azienda = t000f_getaziendacorrente()
    and    tipo = 'C8_SEDE';

    -- se impostato, estrae il dato libero per il progressivo alla data di riferimento
    if wDatoSede is not null then
      wEspr:='select ' || wDatoSede || ' from t430_storico ' ||
             'where  progressivo = :progressivo ' ||
             'and    :datarif between datadecorrenza and datafine';
      execute immediate wEspr into result using pPROG, pDATARIF;
    end if;
  exception
    when no_data_found then
      null;
  end;

  -- 3. se il dato C8_SEDE è nullo, estrae il comune dalla tabella p150
  if result is null then
    begin
      select t480.codice
      into   result
      from   p150_setup p150,
             t480_comuni t480
      where  pDATARIF between p150.decorrenza and p150.decorrenza_fine
      and    p150.cod_comune_inail = t480.codcatastale;
    exception
      when no_data_found then
        null;
    end;
  end if;

  -- restituisce il comune identificato
  return result;
end;
/