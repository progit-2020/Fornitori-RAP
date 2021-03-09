create or replace function I060F_MATRICOLA(p_NOME_UTENTE in varchar2, p_AZIENDA in varchar2 := null ) return varchar2 as
  result varchar2(8);
begin
  select min(I060.MATRICOLA) into result
  from MONDOEDP.I060_LOGIN_DIPENDENTE I060
  where I060.AZIENDA = nvl(p_AZIENDA,i090f_getaziendacorrente)
  and I060.NOME_UTENTE = p_NOME_UTENTE;
  return result;
exception
  when no_data_found then
    return null;
end;
/