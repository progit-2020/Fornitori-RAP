create or replace procedure L133DieciGiorniPrima(p_progressivo in integer, p_data in date, p_gsignific in varchar2, p_causperiodi in varchar2, p_numgg in out integer) is
  x integer;
  numgglav integer;
  numggnonlav integer;
  d date;
  gglav varchar2(1);
  ggfes varchar2(1);
  istruzione varchar2(1000);
  curs1 integer;
  curs2 integer;
begin
  x:=0;
  d:=p_data - 1;
  --Ricerca di quanto allungare il periodo se i giorni di significatività non sono da calendario
  if p_gsignific <> ('GC') then
    numgglav:=0;
    while (numgglav < 10) and (d >= to_date('25062008','ddmmyyyy')) loop
      begin
        select LAVORATIVO,FESTIVO into gglav,ggfes from V010_CALENDARI where PROGRESSIVO = p_progressivo and DATA = d;
      exception
        when others then
          gglav:='S';
          ggfes:='N';
      end;
      if gglav = 'S' and ggfes = 'N' then
        numgglav:=numgglav + 1;
      else
        --Se il giorno è non lavorativo, verifico comunque di non aver inserito altre causali su giorni di calendario che contribuiscano al periodo
        select count(*) into numggnonlav from t040_giustificativi t040, t265_cauassenze t265
         where t265.codice = t040.causale 
           and t265.gsignific = 'GC'
           and t040.progressivo = p_progressivo 
           and t040.data = d 
           and T230F_CHECK_SCARICOPAGHE_FRUIZ(t040.causale,t040.data,t040.tipogiust) = 'S'
           and instr(p_causperiodi,''''||t040.causale||'''') > 0;
        if numggnonlav = 0 then
          x:=x + 1;
        end if;
      end if;
      d:=d - 1;
    end loop;
  end if;
  --Lettura dei giorni di assenza nel periodo
  istruzione:='select count(distinct DATA) from T040_GIUSTIFICATIVI T040'|| 
              ' where PROGRESSIVO = '||p_progressivo||
              ' and CAUSALE in ('||p_causperiodi||') and DATA between :d - 10 - '||x||' and :d - 1'||
              ' and T230F_CHECK_SCARICOPAGHE_FRUIZ(T040.CAUSALE,T040.DATA,T040.TIPOGIUST) = ''S''';
  curs1:=dbms_sql.open_cursor;
  dbms_sql.parse(curs1,istruzione,dbms_sql.native);
  dbms_sql.define_column(curs1,1,p_numgg);
  dbms_sql.bind_variable(curs1,'d',p_data);
  curs2:=dbms_sql.execute(curs1);
  if dbms_sql.fetch_rows(curs1) > 0 then
    dbms_sql.column_value(curs1,1,p_numgg);
  end if;
  dbms_sql.close_cursor(curs1);
end;
/