create or replace function CONCATENA_TESTO(ESPRESSIONE IN VARCHAR2, SEPARATORE IN VARCHAR2) return varchar2 is
  CURSORE_DINAMICO integer;
  CURSORE integer;
  COLONNA varchar2(2000);
  result varchar2(2000);
begin
  result:=null;

  CURSORE_DINAMICO:=dbms_sql.open_cursor;
  dbms_sql.parse(CURSORE_DINAMICO,ESPRESSIONE,dbms_sql.native);
  dbms_sql.define_column(CURSORE_DINAMICO,1,COLONNA,2000);
  CURSORE:=dbms_sql.execute(CURSORE_DINAMICO);
  loop
    if dbms_sql.fetch_rows(CURSORE_DINAMICO) > 0 then
      dbms_sql.column_value(CURSORE_DINAMICO, 1, COLONNA);
      if result is null then
        result:=substr(COLONNA,1,2000);
      else
        result:=substr(result || SEPARATORE || COLONNA,1,2000);
      end if;
    else
      exit;
    end if;
  end loop;
  dbms_sql.close_cursor(CURSORE_DINAMICO);

  return(result);
end CONCATENA_TESTO;
/