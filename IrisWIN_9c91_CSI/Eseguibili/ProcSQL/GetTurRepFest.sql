create or replace function GETTURREPFEST(prog_in in integer, datadal_in in date, dataal_in in date) return number as
  cursor c1 is 
  select t380.data, t380.turno1, t350.orainizio orainizio1, t350.orafine orafine1,
    t380.turno2, t350b.orainizio orainizio2, t350b.orafine orafine2,
    t380.turno3, t350c.orainizio orainizio3, t350c.orafine orafine3
    from t380_pianifreperib t380, t350_regreperib t350, t350_regreperib t350b, t350_regreperib t350c
    where t380.progressivo = prog_in and t380.data between datadal_in and dataal_in
    and t380.turno1 = t350.codice(+) and t380.turno2 = t350b.codice(+) and t380.turno3 = t350c.codice(+)
    order by data;
  f varchar2(1);
  l varchar2(1);
  monteore varchar2(5);
  g number;
  dataelab date;
  nturrep number;
begin
  execute immediate 'ALTER SESSION SET NLS_TERRITORY = AMERICA';
  execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"';
  execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."';
  execute immediate 'ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN';
  execute immediate 'ALTER SESSION SET NLS_SORT = BINARY';
  nturrep:=0;
  dataelab:=to_date('01011900','ddmmyyyy');
  for t1 in c1 loop
    if t1.data > dataelab then
      dataelab:=t1.data;
      getcalendario(prog_in,dataelab,f,l,g,monteore);
      -- Individuo i festivi e le domeniche
      if (f = 'S') or (to_char(dataelab,'D') = '1') then
        nturrep:=nturrep + 1;
      end if;
      if dataelab < dataal_in and ((t1.orafine1 < t1.orainizio1) or (t1.orafine2 < t1.orainizio2) or (t1.orafine3 < t1.orainizio3)) then
        dataelab:=dataelab + 1;
        getcalendario(prog_in,dataelab,f,l,g,monteore);
        -- Individuo i festivi e le domeniche
        if (f = 'S') or (to_char(dataelab,'D') = '1') then
          nturrep:=nturrep + 1;
        end if;
      end if;
    end if;
  end loop;
  return nturrep; 
end GETTURREPFEST;