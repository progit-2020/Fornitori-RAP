create or replace function T000F_GETAZIENDACORRENTE return varchar2 as
  result varchar2(30);
begin
  select min(I090.AZIENDA) into result
  from MONDOEDP.I090_ENTI I090
  where upper(I090.UTENTE) = USER
  and I090.AGGIORNAMENTO_ABILITATO = 'S';

  return result;
exception
  when no_data_found then
    return result;
end;
/
