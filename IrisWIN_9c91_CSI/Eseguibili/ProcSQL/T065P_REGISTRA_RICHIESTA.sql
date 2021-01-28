create or replace procedure T065P_REGISTRA_RICHIESTA(
  p_progressivo in integer,
  p_data in date,
  p_ore_eccedenti in out integer,
  p_min_ore_daliquidare in integer,
  p_min_ore_dacompensare in integer,
  p_id out integer) as
  cursor c1 is
    select T065.ID
    from T065_RICHIESTESTRAORDINARI T065, T850_ITER_RICHIESTE T850
    where T065.PROGRESSIVO = p_progressivo
    and T065.DATA = p_data
    and T065.ID_CONGUAGLIO >= 0
    and T850.ITER = 'T065'
    and T850.ID = T065.ID
    and T850.TIPO_RICHIESTA in ('C','R')
    ;
  c integer;
  T850ID number(38);
  w_ore_eccedenti varchar2(7);
  w_min_ore_daliquidare varchar2(7);
  w_min_ore_dacompensare varchar2(7);
  w_conguaglio varchar2(7);
  w_iter_autorizzativo varchar2(1);
  sum_ore_eccedenti integer;
  conguaglio integer;
 
  T065_NON_CONSENTITO_EXC exception;
  pragma exception_init(T065_NON_CONSENTITO_EXC, -20001);
begin
  p_id:=null;

  if p_data >= trunc(sysdate,'mm') then
  	return;
  end if;

  begin
    select nvl(T025.ITER_AUTORIZZATIVO_STR,'0') into w_iter_autorizzativo
    from T430_STORICO T430, T025_CONTMENSILI T025
    where T430.PROGRESSIVO = p_progressivo
    and last_day(p_data) between T430.DATADECORRENZA and T430.DATAFINE
    and T430.PERSELASTICO = T025.CODICE;
  exception
    when others then
      w_iter_autorizzativo:='0';
  end;
  if w_iter_autorizzativo = '0' then
    return;
  end if;
  --cancello i record che non sono ancora diventati attivi nell'iter autorizzativo
  /*delete from T065_RICHIESTESTRAORDINARI
    where PROGRESSIVO = p_progressivo and DATA = p_data and TIPO_RICHIESTA in ('C','R');*/
  for t1 in c1 loop
    delete from T065_RICHIESTESTRAORDINARI where ID = T1.ID;
    delete from T850_ITER_RICHIESTE where ITER = 'T065' and ID = T1.ID;
  end loop;

  --Verifico quali sono i valori presenti attualmente per il mese
  select nvl(sum(oreminuti(ORE_ECCED_CALC)),0)
  into sum_ore_eccedenti
  from T065_RICHIESTESTRAORDINARI
  where PROGRESSIVO = p_progressivo and DATA = p_data;
  --Si deve registrare la differenza tra i saldi attuali e quanto già in fase di richiesta
  conguaglio:=p_ore_eccedenti - sum_ore_eccedenti;
  if conguaglio <= 0 then
    return;
  end if;
  w_ore_eccedenti:=minutiore(p_ore_eccedenti);
  w_min_ore_daliquidare:=minutiore(p_min_ore_daliquidare);
  w_min_ore_dacompensare:=minutiore(p_min_ore_dacompensare);
  w_conguaglio:=minutiore(conguaglio);
  if length(w_ore_eccedenti) < 5 then
    w_ore_eccedenti:='0' || w_ore_eccedenti;
  end if;
  if length(w_min_ore_daliquidare) < 5 then
    w_min_ore_daliquidare:='0' || w_min_ore_daliquidare;
  end if;
  if length(w_min_ore_dacompensare) < 5 then
    w_min_ore_dacompensare:='0' || w_min_ore_dacompensare;
  end if;
  if length(w_conguaglio) < 5 then
    w_conguaglio:='0' || w_conguaglio;
  end if;
  select count(*) into c from T065_RICHIESTESTRAORDINARI
  where PROGRESSIVO = p_progressivo and DATA = p_data and ID_CONGUAGLIO = 0;
  --se non c'è nessun record relativo al mese corrente con iter autorizzativo già avviato:
  -- non c'è nessun record per il mese corrente (ID_CONGUAGLIO = 0, TIPO = C)
  -- devo cominciare l'iter autorizzativo
  if c = 0 then
    p_id:=0;
    select T850_ID.nextval into T850ID from dual;
    --insert into T065_RICHIESTESTRAORDINARI (ID,PROGRESSIVO,DATA,ID_CONGUAGLIO,TIPO,TIPO_RICHIESTA,DATA_RICHIESTA,ORE_ECCED_CALC,ORE_ECCEDENTI)
    --select T850_ID.nextval,T430.PROGRESSIVO,p_data,0,'C',decode(w_iter_autorizzativo,'1','C','2','R'),sysdate,w_ore_eccedenti, w_ore_eccedenti
    insert into T065_RICHIESTESTRAORDINARI (ID,PROGRESSIVO,DATA,ID_CONGUAGLIO,TIPO,ORE_ECCED_CALC,ORE_ECCEDENTI, MIN_ORE_DALIQUIDARE, MIN_ORE_DACOMPENSARE)
    select T850ID,T430.PROGRESSIVO,p_data,0,'C',w_ore_eccedenti, w_ore_eccedenti, w_min_ore_daliquidare, w_min_ore_dacompensare
    from T430_STORICO T430
    where T430.PROGRESSIVO = p_progressivo
    and last_day(p_data) between T430.DATADECORRENZA and T430.DATAFINE
    and w_iter_autorizzativo in ('1','2','3','4');

    insert into T850_ITER_RICHIESTE (ID,ITER,DATA,TIPO_RICHIESTA)
    select T850ID,'T065',sysdate,decode(w_iter_autorizzativo,'1','C','2','R','3','R','4','R')
    from T430_STORICO T430
    where T430.PROGRESSIVO = p_progressivo
    and last_day(p_data) between T430.DATADECORRENZA and T430.DATAFINE
    and w_iter_autorizzativo in ('1','2','3','4');

  elsif w_iter_autorizzativo = '1' then
    --ci sono già richieste iniziate, devo creare il record di conguaglio
    select max(ID_CONGUAGLIO) into p_id from T065_RICHIESTESTRAORDINARI
    where PROGRESSIVO = p_progressivo and DATA = p_data and TIPO = 'G';
    if p_id is null then
      p_id:=1;
    else
      p_id:=p_id + 1;
    end if;
    select T850_ID.nextval into T850ID from dual;
    --insert into T065_RICHIESTESTRAORDINARI (ID,PROGRESSIVO,DATA,ID_CONGUAGLIO,TIPO,TIPO_RICHIESTA,DATA_RICHIESTA,ORE_ECCED_CALC,ORE_ECCEDENTI)
    --select T850_ID.nextval,T430.PROGRESSIVO,p_data,p_id,'G','C',sysdate,w_conguaglio, w_conguaglio
    insert into T065_RICHIESTESTRAORDINARI (ID,PROGRESSIVO,DATA,ID_CONGUAGLIO,TIPO,ORE_ECCED_CALC,ORE_ECCEDENTI)
    select T850ID,T430.PROGRESSIVO,p_data,p_id,'G',w_conguaglio, w_conguaglio
    from T430_STORICO T430
    where T430.PROGRESSIVO = p_progressivo
    and last_day(p_data) between T430.DATADECORRENZA and T430.DATAFINE;

    insert into T850_ITER_RICHIESTE (ID,ITER,DATA,TIPO_RICHIESTA)
    select T850ID,'T065',sysdate,'C'
    from T430_STORICO T430
    where T430.PROGRESSIVO = p_progressivo
    and last_day(p_data) between T430.DATADECORRENZA and T430.DATAFINE;
  end if;
exception
  when T065_NON_CONSENTITO_EXC then null;
  when others then raise;
end;
/
