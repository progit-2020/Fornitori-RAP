create or replace trigger MONDOEDP.I192_BEFOREINS
before insert on MONDOEDP.I192_MONITORSERVIZI_LOGSTATO
for each row
begin
  if :NEW.ID is null then
    select MONDOEDP.I192_ID.NEXTVAL into :NEW.ID from dual;
  end if;
end/*--NOLOG--*/;
/