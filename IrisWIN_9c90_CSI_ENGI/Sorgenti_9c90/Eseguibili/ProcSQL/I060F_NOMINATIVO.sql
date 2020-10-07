create or replace function I060F_NOMINATIVO(p_AZIENDA in varchar2, p_NOME_UTENTE in varchar2) return varchar2 as
  result varchar2(100);
begin
  select COGNOME||' '||NOME  into result
  from T030_ANAGRAFICO T030, MONDOEDP.I060_LOGIN_DIPENDENTE I060
  where I060.AZIENDA = p_AZIENDA 
  and I060.NOME_UTENTE = p_NOME_UTENTE
  and T030.MATRICOLA = I060.MATRICOLA;
  return result;
exception
  when no_data_found then
    return p_NOME_UTENTE;
end;
/
