create or replace function SG450F_POSTILETTO (P_PROGR IN integer,P_DATA IN date,P_AZIENDA IN varchar2, P_NOME IN varchar2) RETURN varchar2 IS
  CURSORE_DINAMICO_T430 INTEGER;
  CURS_T430             INTEGER;
  Result                varchar2(80);
  w_colonna             MONDOEDP.I091_DATIENTE.DATO%type;
  w_valore              varchar2(100);
  w_estrazione          varchar2(50);
begin
  Result:='';
  if (p_progr   is null)
  or (p_data    is null)
  or (p_azienda is null)
  or (p_nome    is null) then
      return(Result);
  end if;
  begin
      select I091.dato
      into   w_colonna
      from   MONDOEDP.I091_DATIENTE I091
      where  I091.azienda = p_azienda
      and    I091.tipo    = 'C17_POSTILETTO';
  exception
      when NO_DATA_FOUND then
           return(Result);
  end;
  if w_colonna IS NULL then
           return(Result);
  end if;
  CURSORE_DINAMICO_T430:=DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(CURSORE_DINAMICO_T430,'select T430.'||w_colonna||' from T430_STORICO T430 where T430.progressivo = '||p_progr||' and TO_DATE('''||TO_CHAR(p_data,'DD/MM/YYYY')||''',''DD/MM/YYYY'') between T430.datadecorrenza and T430.datafine',DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T430,1,w_valore,20);
  --DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_T430, 'PROGIRIS', PROGIRIS);
  CURS_T430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_T430);
  if DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_T430)>0 then
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T430, 1,w_valore);
  else
      dbms_sql.close_cursor(CURSORE_DINAMICO_T430);
      return(Result);
  end if;
  dbms_sql.close_cursor(CURSORE_DINAMICO_T430);
  
  if p_nome = 'POSTI_LETTO_DH' then
      begin
          select SG450.posti_letto_dh
          into   w_estrazione
          from   sg450_postiletto SG450
          where  SG450.codice = w_valore
          and    p_data between SG450.decorrenza and SG450.decorrenza_fine;
      exception
          when no_data_found then
              return(Result);
      end;
  end if;
  if p_nome = 'POSTI_LETTO' then
      begin
          select SG450.posti_letto
          into   w_estrazione
          from   sg450_postiletto SG450
          where  SG450.codice = w_valore
          and    p_data between SG450.decorrenza and SG450.decorrenza_fine;
      exception
          when no_data_found then
              return(Result);
      end;
  end if;
  if p_nome = 'COORDINATORI' then
      begin
          select SG450.coordinatori
          into   w_estrazione
          from   sg450_postiletto SG450
          where  SG450.codice = w_valore
          and    p_data between SG450.decorrenza and SG450.decorrenza_fine;
      exception
          when no_data_found then
              return(Result);
      end;
  end if;
  Result:=w_estrazione;
  return(Result);
end;
/