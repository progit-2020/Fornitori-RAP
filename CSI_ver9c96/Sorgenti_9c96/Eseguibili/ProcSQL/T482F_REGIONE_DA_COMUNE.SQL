create or replace function T482F_REGIONE_DA_COMUNE (PCodCatastale in varchar2) return varchar2 is
  regione varchar2(40);
begin
  select T482.DESCRIZIONE into regione
    from T480_COMUNI T480, T481_PROVINCE T481, T482_REGIONI T482
    where T480.CODCATASTALE=PCodCatastale and T480.PROVINCIA=T481.COD_PROVINCIA and T481.COD_REGIONE=T482.COD_REGIONE;
  return regione;
exception
  when others then
    return '';
end;
/
