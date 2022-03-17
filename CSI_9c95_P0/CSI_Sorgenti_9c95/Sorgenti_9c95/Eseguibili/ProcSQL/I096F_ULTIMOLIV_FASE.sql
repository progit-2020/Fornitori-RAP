create or replace function I096F_ULTIMOLIV_FASE(pFASE in integer, pITER in varchar2, pCOD_ITER in varchar2) return integer as
  result integer;
begin
  select max(LIVELLO) into result
  from MONDOEDP.I096_LIVELLI_ITER_AUT 
  where AZIENDA = T000F_GETAZIENDACORRENTE 
  and ITER = pITER
  and COD_ITER = pCOD_ITER
  and nvl(FASE,0) = pFASE
  and OBBLIGATORIO = 'S';
  
  return result;
end;
/