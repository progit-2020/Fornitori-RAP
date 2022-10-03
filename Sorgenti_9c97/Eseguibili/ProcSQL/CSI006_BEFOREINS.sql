create or replace trigger CSI006_BEFOREINS
before insert on CSI006_CART_INDFUNZIONE
for each row
begin
  if :NEW.ID is null then
    select CSI006_ID.NEXTVAL into :NEW.ID from dual;
  end if;
end;
/
