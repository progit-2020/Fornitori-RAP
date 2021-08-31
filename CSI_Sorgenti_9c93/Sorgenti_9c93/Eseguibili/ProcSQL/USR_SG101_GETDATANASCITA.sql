create or replace function USR_SG101_GETDATANASCITA(P_PROG in integer, P_DATA_FAMILIARE in date) return date is
  result date;
/*
   estrae la data di nascita del familiare indicato
  (la data familiare può essere la data di adozione oppure di nascita)  
*/  
begin
  begin
    select max(DATANAS)
    into   result
    from   SG101_FAMILIARI
    where  PROGRESSIVO = P_PROG
    and    (DATAADOZ = P_DATA_FAMILIARE or DATANAS = P_DATA_FAMILIARE);
  exception
    when others then
      result:=null;
  end;

  return result;
end;
/
