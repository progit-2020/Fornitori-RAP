create or replace trigger CSI004_BEFOREINS
before insert on CSI004_INDFUNZIONE
for each row
begin
  if :NEW.ID is null then
    select CSI004_ID.NEXTVAL into :NEW.ID from dual;
  end if;
end;
/
