create or replace trigger I051_BEFOREUPD
  before update on I051_SQL_CUSTOM  
  for each row
begin
  :NEW.TIMESTAMP:=sysdate;
end;
/