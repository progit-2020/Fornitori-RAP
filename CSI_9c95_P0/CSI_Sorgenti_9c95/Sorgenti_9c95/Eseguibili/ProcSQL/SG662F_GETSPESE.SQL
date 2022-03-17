create or replace function SG662F_GETSPESE(CODICE in varchar2, PDecorrenza in date) return varchar2 as
  spesa number;
begin
  select sum(nvl(COSTO,0)) into spesa 
  from SG662_COSTICORSI 
  where COD_CORSO = CODICE and DECORRENZA = PDecorrenza and TIPO_COSTO = 'G';
  return(to_char(spesa,'999G999G990D99'));
end;
/
