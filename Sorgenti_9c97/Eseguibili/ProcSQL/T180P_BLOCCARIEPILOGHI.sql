create or replace procedure T180P_BLOCCARIEPILOGHI(P_PROGRESSIVO IN INTEGER, P_RIEPILOGO IN VARCHAR2, P_DAL IN DATE, P_AL IN DATE, P_UTENTE IN VARCHAR2 DEFAULT NULL) as
  cursor c1 is 
    select t.*, t.rowid from t180_datibloccati t
    where progressivo = P_PROGRESSIVO
      and riepilogo = P_RIEPILOGO
      and dal <= add_months(P_AL,1) and al >= add_months(P_DAL,-1)
    order by dal,al;
  Aggiornato boolean;
  d date;
  wConto integer;
begin
  Aggiornato:=False;
-- Inserimento blocchi su riepiloghi annuali  
  if P_RIEPILOGO in ('T130','T131','T264','T692') then
    d:=P_DAL;
    while d <= P_AL loop
      if to_char(d,'mm') = 1 then
        begin
          insert into t180_datibloccati (progressivo,dal,al,riepilogo,stato)
          values (P_PROGRESSIVO,d,d,P_RIEPILOGO,'C');
        exception
          when dup_val_on_index then null;
        end;
      end if;
      d:=add_months(d,1);
    end loop;
    raise no_data_found;
  end if;
  
-- Aggiornamento data fine periodo (al) su blocchi con periodi intersecanti P_DAL e P_AL (P_DAL ricade nel mezzo)
-- Es. P_DAL=01/07/2004 P_AL=31/08/2004    periodo interessato dal 01/01/2004 al 31/07/2004
  update t180_datibloccati set al = P_AL where
  progressivo = P_PROGRESSIVO and
  riepilogo = P_RIEPILOGO and
  P_DAL between dal and add_months(al,1) and P_AL > al;
  if sql%rowcount >= 1 then
    Aggiornato:=True;
  end if;
  
-- Aggiornamento data inizio periodo (dal) su blocchi con periodi intersecanti P_DAL e P_AL (P_AL ricade nel mezzo)
-- Es. P_DAL=01/07/2004 P_AL=31/08/2004    periodo interessato dal 01/08/2004 al 31/12/2004
  begin
    update t180_datibloccati set dal = P_DAL where
    progressivo = P_PROGRESSIVO and
    riepilogo = P_RIEPILOGO and
    P_AL between add_months(dal,-1) and al and P_DAL < dal;
    if sql%rowcount >= 1 then
      Aggiornato:=True;
    end if;
  exception
    when dup_val_on_index then null;
  end;
  
-- Aggiornamento data inizio periodo (dal) e data fine periodo (al) su blocchi compresi nel periodo P_DAL P_AL
-- Es. P_DAL=01/07/2004 P_AL=30/09/2004    periodo interessato dal 01/08/2004 al 31/08/2004
  begin
    update t180_datibloccati set dal = P_DAL, al=P_AL where
    progressivo = P_PROGRESSIVO and
    riepilogo = P_RIEPILOGO and
    dal >= P_DAL and al <= P_AL;
    if sql%rowcount >= 1 then
      Aggiornato:=True;
  end if;
  exception
    when dup_val_on_index then null;
  end;

-- Inserimento periodi che non sono stati aggiornati
  if not Aggiornato then
    begin
      insert into t180_datibloccati (progressivo,dal,al,riepilogo,stato)
      values (P_PROGRESSIVO,P_DAL,P_AL,P_RIEPILOGO,'C');
    exception
      when dup_val_on_index then null;
    end;
  end if;

-- Compattamento periodi contigui: per ogni record viene aggiornata la data fine periodo (al) con la massima data fine periodo 
-- dei periodi che hanno la data inizio compresa nel periodo del record stesso
  for t1 in c1 loop
    update t180_datibloccati t180 set 
     al = (select max(al) from t180_datibloccati 
           where progressivo = t180.progressivo and riepilogo = t180.riepilogo and 
           dal between t180.dal and t180.al)
     where rowid = t1.rowid;
  end loop;
  
-- Cancellazione periodi che sono già compresi in altri 
  delete from t180_datibloccati t180 where 
  progressivo = P_PROGRESSIVO and riepilogo = P_RIEPILOGO and
  exists 
  (select 'x' from t180_datibloccati where 
  progressivo = P_PROGRESSIVO and riepilogo = P_RIEPILOGO and
  rowid <> t180.rowid and
  dal <= t180.dal and al >= t180.al);

-- Aggiorno stato delle richieste di straordinario da Calcolato a Richiedibile
  if P_RIEPILOGO = 'T070' then
    update t850_iter_richieste
    set tipo_richiesta = 'R'
    where iter = 'T065'
    and tipo_richiesta = 'C'
    and id in (select /*+ UNNEST */ id 
               from t065_richiestestraordinari 
               where progressivo = P_PROGRESSIVO
               and data between P_DAL and P_AL);
  end if;

-- Traccia della prevalidazione e apertura dell'iter di validazione cartellino  
  if P_RIEPILOGO in ('T860A','T860') then
    d:=P_DAL;
    while d <= P_AL loop
      select count(*) into wConto from T070_SCHEDARIEPIL where PROGRESSIVO = P_PROGRESSIVO and DATA = d;
      if wConto > 0 then
      	 if (P_RIEPILOGO = 'T860A') and (T077F_LEGGIVALORE(P_PROGRESSIVO, d, 'BLOCCO_T860A', 'M') is null) then
           T077P_SCRIVIVALORE(P_PROGRESSIVO, d, 'M', 'BLOCCO_T860A', to_char(sysdate,'dd/mm/yyyy hh24.mi'));
           if P_UTENTE is not null then
             T077P_SCRIVIVALORE(P_PROGRESSIVO, d, 'M', 'BLOCCO_T860A_USR', P_UTENTE);
           end if;
         elsif (P_RIEPILOGO = 'T860') and (T077F_LEGGIVALORE(P_PROGRESSIVO, d, 'BLOCCO_T860', 'M') is null) then
         	 T077P_SCRIVIVALORE(P_PROGRESSIVO, d, 'M', 'BLOCCO_T860', to_char(sysdate,'dd/mm/yyyy hh24.mi'));
           if P_UTENTE is not null then
             T077P_SCRIVIVALORE(P_PROGRESSIVO, d, 'M', 'BLOCCO_T860_USR', P_UTENTE);
           end if;
        end if;
      end if;
      d:=add_months(d,1);
    end loop;
  end if;
exception
  when others then null;
end;
/