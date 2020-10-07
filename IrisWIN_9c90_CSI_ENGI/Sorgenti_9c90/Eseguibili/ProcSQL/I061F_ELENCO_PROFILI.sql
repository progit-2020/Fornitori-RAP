create or replace function I061F_ELENCO_PROFILI(A IN VARCHAR2,U IN VARCHAR2) return varchar2 is
  cursor c1 is
    select NOME_PROFILO
    from MONDOEDP.I061_PROFILI_DIPENDENTE I061
    where AZIENDA = A and NOME_UTENTE = U
    order by NOME_PROFILO;
  Result varchar2(500);
  wL     integer;
begin
  Result:=null;
  wL:=0;
  for t1 in c1 loop
    -- controllo limite lunghezza risultato
    if wL + Length(t1.NOME_PROFILO) + 1 > 500 then
      exit;
    end if;
    
    if Result is null then
      Result:=t1.NOME_PROFILO;
    else
      Result:=Result || ',' || t1.NOME_PROFILO;
    end if;
    wL:=length(Result);
  end loop;
  return(Result);
end I061F_ELENCO_PROFILI;
/
