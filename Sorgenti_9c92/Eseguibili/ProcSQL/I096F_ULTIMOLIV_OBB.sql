create or replace function I096F_ULTIMOLIV_OBB(pITER in varchar2, pCOD_ITER in varchar2) return integer as
  result integer;
begin
  select max(LIVELLO) into result
  from MONDOEDP.I096_LIVELLI_ITER_AUT
  where AZIENDA = T000F_GETAZIENDACORRENTE
  and ITER = pITER
  and COD_ITER = pCOD_ITER
  and OBBLIGATORIO = 'S';

  return result;
end;
/