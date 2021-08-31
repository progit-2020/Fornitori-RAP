create or replace function SG650F_ELENCO_EDIZIONI (PCodice in varchar2) return varchar2 is
  cursor c1 is
    SELECT distinct edizione, decorrenza
    FROM sg650_testatacorsi
    WHERE codice = PCodice
    ORDER BY edizione;
  Lista varchar2(5000);
begin
  for t1 in c1 loop
    if Lista is not null then
       Lista:=Lista || chr(13) || chr(10);
    end if;
    Lista:=Lista || 'Edizione ' || t1.edizione || ' ' || sg660f_elenco_date(PCodice,t1.edizione);
  end loop;
  return Lista;
end;
/
