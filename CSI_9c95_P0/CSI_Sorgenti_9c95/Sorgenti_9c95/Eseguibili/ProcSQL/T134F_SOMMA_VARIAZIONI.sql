create or replace function T134F_SOMMA_VARIAZIONI(p_progressivo in integer, p_anno in integer, p_oreperse in varchar2) return integer is
  s integer;
begin
  select sum(oreminuti(nvl(ORE_LIQUIDATE,'00.00')) - oreminuti(nvl(VARIAZIONE_ORE,'00.00'))) into s from T134_ORELIQUIDATEANNIPREC where PROGRESSIVO = p_progressivo and ANNO = p_anno and OREPERSE = p_oreperse;
  return(s);
end;
/