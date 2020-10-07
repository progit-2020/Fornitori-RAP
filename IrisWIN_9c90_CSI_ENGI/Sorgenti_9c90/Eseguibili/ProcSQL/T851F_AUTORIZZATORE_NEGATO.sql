create or replace function T851F_AUTORIZZATORE_NEGATO(P_ID in varchar2) return varchar2 as
  result varchar2(30);
begin
  result:=null;
  
  select max(T851.RESPONSABILE) into result
  from T851_ITER_AUTORIZZAZIONI T851
  where T851.ID = P_ID
  and   T851.LIVELLO = 
        (select max(LIVELLO) 
         from T851_ITER_AUTORIZZAZIONI 
         where ID = T851.ID and STATO = 'N');
  
  return result;
end;
/