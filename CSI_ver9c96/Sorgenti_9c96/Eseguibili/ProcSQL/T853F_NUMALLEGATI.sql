create or replace function T853F_NUMALLEGATI(P_ID in integer) return integer is
  Result integer;
begin
  select count(*)
  into   result
  from   T853_DOC_ALLEGATI T853
  where  T853.ID = P_ID;

  return result;
end T853F_NUMALLEGATI;
/