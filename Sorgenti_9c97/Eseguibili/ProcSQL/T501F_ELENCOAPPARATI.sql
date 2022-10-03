create or replace function T501F_ELENCO_APPARATI(D DATE, P INTEGER) return varchar2 is
  cursor c1 is
    select T555.DESCRIZIONE || ' ' || T550.DESCRIZIONE APPARATO 
    from T501_PIANIFAPPARATI T501, T555_TIPOAPPARATI T555, T550_APPARATI T550  
    where DATA = D and PATTUGLIA = P and T501.TIPO = T555.CODICE and T501.CODICE = T550.CODICE
    order by T555.DESCRIZIONE, T550.DESCRIZIONE;
  Result varchar2(500);
begin
  Result:=null;
  for t1 in c1 loop
    if Result is null then
      Result:=t1.APPARATO;
    else
      Result:=Result || chr(13) || t1.APPARATO;
    end if;
  end loop;
  return(Result);
end T501F_ELENCO_APPARATI;
/