create or replace trigger T265_BEFOREINS 
before insert on T265_CAUASSENZE
for each row
begin
  if :NEW.ID is null then
    select T265_ID.NEXTVAL into :NEW.ID from dual;
  end if;
end;
/
