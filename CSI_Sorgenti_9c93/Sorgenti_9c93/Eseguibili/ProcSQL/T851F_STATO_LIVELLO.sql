create or replace function T851F_STATO_LIVELLO(P_ID in integer, P_LIVELLO in integer) return varchar2 as
  result varchar2(1);
begin
  select max(T851.STATO)
  into   result
  from   T850_ITER_RICHIESTE T850,
         T851_ITER_AUTORIZZAZIONI T851
  where  T850.ID = P_ID
  and    T851.ID = T850.ID
  and    T851.LIVELLO = P_LIVELLO;

  return result;
end;
/