create or replace trigger MONDOEDP.I190_BEFOREINS
before insert on MONDOEDP.I190_MONITORSERVIZI
for each row
begin
  if :NEW.ID is null then
    select MONDOEDP.I190_ID.NEXTVAL into :NEW.ID from dual;
  end if;
end;
/