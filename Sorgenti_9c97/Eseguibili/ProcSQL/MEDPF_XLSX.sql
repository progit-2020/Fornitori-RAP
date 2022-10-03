create or replace function MEDPF_XLSX(P_TABELLA in varchar2,
                                      P_QUERY in varchar2 default '',
                                      P_HEADER in boolean default true,
                                      P_PATH in varchar2 default '',
                                      P_FILE in varchar2 default '') return blob as
/*
P_TABELLA: nome della tabella usata per la creazione del file
P_QUERY: in alternativa a P_TABELLA, query da eseguire il cui risultato viene usato per la creazine del file
P_HEADER: abilita/disabilita l'inserimento dell'intestazione nel file (nome delle colonne)
P_PATH: path in cui salvare il file
P_FILE: nome del file da salvare
-> se assenti P_PATH e P_FILE il file viene ritornato come blob dalla funzione, altrimenti ritorna NULL
*/
  idx integer;
  cursor c1(tabella varchar2) is
    select length(column_name) length from user_tab_columns where upper(table_name) = upper(tabella) order by column_id;
begin
  as_xlsx.clear_workbook;
  as_xlsx.new_sheet(p_sheetname => 'Foglio1');
  
  if P_HEADER then
    as_xlsx.set_row(1, p_fontId => as_xlsx.get_font('Calibri', p_bold => true), p_alignment => as_xlsx.get_alignment(p_horizontal => 'center') ) ;
    as_xlsx.freeze_rows; -- blocco la prima riga
  end if;
  
  if P_TABELLA is not null then
    idx:=1;
    for t1 in c1(P_TABELLA)
    loop
      as_xlsx.set_column_width(idx, t1.length+3, 1);
      idx:=idx+1;  
    end loop;
    as_xlsx.query2sheet(p_sql => 'select * from '||P_TABELLA||' order by 1', p_column_headers => P_HEADER, p_sheet => 1);
  elsif P_QUERY is not null then
    as_xlsx.query2sheet(p_sql => P_QUERY, p_column_headers => P_HEADER, p_sheet => 1);
  else
    raise_application_error(-20000,'E'' necessario specificare il nome di una tabella o una query SQL da eseguire');
  end if;

  if (P_PATH is not null) and (P_FILE is not null) then
    as_xlsx.save(P_PATH, P_FILE);
    return null;
  else
    return as_xlsx.finish;
  end if;
end;
/