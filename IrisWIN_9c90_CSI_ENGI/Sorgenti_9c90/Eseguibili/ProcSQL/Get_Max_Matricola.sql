create or replace function GETNUOVAMATRICOLA return integer is
  cursor c1 is
    select matricola from t030_anagrafico;
  MaxMat integer;
begin
  MaxMat:=0;
  for t1 in c1 loop
    begin
      if to_number(t1.matricola) > MaxMat then
        MaxMat:=t1.matricola;
      end if;
    exception
      when others then null;
    end;
  end loop;
  return(MaxMat + 1);
end;
/
