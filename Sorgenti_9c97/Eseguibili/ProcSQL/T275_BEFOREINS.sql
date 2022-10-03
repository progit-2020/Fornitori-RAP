create or replace trigger T275_BEFOREINS 
before insert on T275_CAUPRESENZE
for each row
begin
  if :NEW.ID is null then
    select T275_ID.NEXTVAL into :NEW.ID from dual;
  end if;
end;
/

