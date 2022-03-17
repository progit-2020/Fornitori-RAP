create or replace procedure T031P_PULISCI_NUOVO_PERIODO(P_PROGRESSIVO in integer, P_DATA in date, P_CAUSALE in varchar2, P_PROGRCAUSALE in integer) as
  pragma autonomous_transaction;
  X integer;
begin
  select count(*) into X
  from T040_GIUSTIFICATIVI t040, T265_CAUASSENZE T265
  where T040.PROGRESSIVO = P_PROGRESSIVO and T040.DATA = P_DATA
  and T040.CAUSALE = T265.CODICE
  and T265.TIPOCUMULO in ('I','O')
  and (T040.CAUSALE,T040.PROGRCAUSALE) not in (select P_CAUSALE,P_PROGRCAUSALE from DUAL);
  if X = 0 then
    delete from T031_DATACARTELLINO where PROGRESSIVO = P_PROGRESSIVO and DATA = P_DATA and TIPO = '1';
    commit;
  end if;
end;
/