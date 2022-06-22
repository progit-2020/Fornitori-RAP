create or replace function T430F_GETDATO(P_PROGRESSIVO in integer, P_COLONNA in varchar2, P_DATA in date) return varchar2 as
/*restituisce il valorde della generica colonna di T430_STORICO alla data richiesta*/
  result varchar2(4000);
  wstat  varchar2(4000);
begin
  result:=null;
  wstat:='select '||P_COLONNA||' from T430_STORICO where PROGRESSIVO = :PROGRESSIVO and :DATA between DATADECORRENZA and DATAFINE'; 
  execute immediate wstat into result using in P_PROGRESSIVO,in P_DATA;
  return result;
exception
  when no_data_found then
    return null;
end;
/