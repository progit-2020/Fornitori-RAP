create or replace function I091F_GETDATO(P_TIPO in varchar2) return varchar2 as
  result MONDOEDP.I091_DATIENTE.DATO%type;
begin
  select max(DATO) into result
  from MONDOEDP.I091_DATIENTE 
  where AZIENDA = T000F_GETAZIENDACORRENTE
  and TIPO = P_TIPO;

  return result;  
end;
/