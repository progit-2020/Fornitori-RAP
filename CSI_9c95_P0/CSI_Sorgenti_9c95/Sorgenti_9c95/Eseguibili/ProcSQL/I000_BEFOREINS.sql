create or replace trigger I000_BEFOREINS
BEFORE INSERT ON I000_LOGINFO
FOR EACH ROW
BEGIN
  :NEW.DATA:=SYSDATE;
END;
/