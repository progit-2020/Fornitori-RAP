create or replace function I090F_GETAZIENDACORRENTE return varchar2 as
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

drop function T000F_GETAZIENDACORRENTE/*--NOLOG--*/;
create or replace synonym T000F_GETAZIENDACORRENTE for I090F_GETAZIENDACORRENTE;
grant execute on T000F_GETAZIENDACORRENTE to public;