create or replace procedure T020P_STORICIZZA(P_DECORRENZA in date, P_CONDIZIONE in varchar2) as
  type type_lstTrigger is varray(10) of varchar2(30);
  lstTrigger type_lstTrigger := type_lstTrigger();
  i integer;

  wColonneT020 varchar2(32767);
  wValoriT020 varchar2(32767);
  wColonneT021 varchar2(32767);
  wValoriT021 varchar2(32767);
  wStat varchar2(32767);
  
  cursor c1(p_tabella varchar2) is 
    select COLUMN_NAME from COLS where TABLE_NAME = p_tabella order by COLUMN_ID;
  
  cursor c2 is 
    select TRIGGER_NAME from USER_TRIGGERS where TABLE_NAME in ('T020_ORARI','T021_FASCEORARI') and STATUS = 'ENABLED';
begin

  for t1 in c1('T020_ORARI') loop
    if wColonneT020 is not null then
      wColonneT020:=wColonneT020||',';
      wValoriT020:=wValoriT020||',';
    end if;  
    wColonneT020:=wColonneT020||t1.COLUMN_NAME;
    if t1.COLUMN_NAME = 'DECORRENZA' then
      wValoriT020:=wValoriT020||':DECORRENZA';
    else
      wValoriT020:=wValoriT020||t1.COLUMN_NAME;
    end if;  
  end loop;

  for t1 in c1('T021_FASCEORARI') loop
    if wColonneT021 is not null then
      wColonneT021:=wColonneT021||',';
      wValoriT021:=wValoriT021||',';
    end if;  
    wColonneT021:=wColonneT021||t1.COLUMN_NAME;
    if t1.COLUMN_NAME = 'DECORRENZA' then
      wValoriT021:=wValoriT021||':DECORRENZA';
    else
      wValoriT021:=wValoriT021||t1.COLUMN_NAME;
    end if;  
  end loop;

  i:=0;
  for t2 in c2 loop
    i:=i + 1;
    lstTrigger.Extend;
    lstTrigger(i):=t2.TRIGGER_NAME;
  end loop;
  
  for i in 1..lstTrigger.Count loop
    execute immediate 'alter trigger '||lstTrigger(i)||' disable';
  end loop;  
  
  begin    
    wStat:=
    'insert into T020_ORARI ('||wColonneT020||')
    select '||wValoriT020||'
    from T020_ORARI T020
    where '||P_CONDIZIONE||'
    and DECORRENZA <> :DECORRENZA
    and DECORRENZA = (select max(DECORRENZA) from T020_ORARI where CODICE = T020.CODICE and DECORRENZA <= :DECORRENZA)';

    wStat:=replace(wStat,':DECORRENZA','to_date('''||to_char(P_DECORRENZA,'ddmmyyyy')||''', ''ddmmyyyy'')');
    --dbms_output.put_line(wStat); 
    execute immediate wStat;
    
    wStat:=
    'insert into T021_FASCEORARI ('||wColonneT021||')
    select '||wValoriT021||'
    from T021_FASCEORARI T021
    where CODICE in (select CODICE from T020_ORARI T020 where DECORRENZA = (select max(DECORRENZA) from T020_ORARI where CODICE = T020.CODICE and DECORRENZA <= :DECORRENZA) and '||P_CONDIZIONE||')
    and DECORRENZA <> :DECORRENZA
    and DECORRENZA = (select max(DECORRENZA) from T021_FASCEORARI where CODICE = T021.CODICE and DECORRENZA <= :DECORRENZA)';

    wStat:=replace(wStat,':DECORRENZA','to_date('''||to_char(P_DECORRENZA,'ddmmyyyy')||''', ''ddmmyyyy'')');
    --dbms_output.put_line(wStat); 
    execute immediate wStat;
  exception  
    when others then 
      for i in 1..lstTrigger.Count loop
        execute immediate 'alter trigger '||lstTrigger(i)||' enable';
      end loop;  
      raise;
  end;  

  for i in 1..lstTrigger.Count loop
    execute immediate 'alter trigger '||lstTrigger(i)||' enable';
  end loop;  

end;  
/