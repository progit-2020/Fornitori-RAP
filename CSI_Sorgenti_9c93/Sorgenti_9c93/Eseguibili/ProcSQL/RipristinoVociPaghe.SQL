CREATE OR REPLACE PROCEDURE RIPRISTINOVOCIPAGHE AS
  CURSOR C195 IS SELECT ROWID FROM T195_VOCIVARIABILI;
  CURSOR C195B IS SELECT ROWID FROM T195_BACKUP;
  P NUMBER;
  NC NUMBER;
BEGIN
  NC:=2000;
  P:=0;
  --se va in errore il comando seguente, si deve dare eseguire "grant create any table to mondoedp;" come system/sys
  execute immediate('create table BCK_T195_'||to_char(sysdate,'yyyymmddhh24mi')||' as select * from T195_VOCIVARIABILI');
  FOR T195 IN C195 LOOP
    P:=P + 1;
    DELETE FROM T195_VOCIVARIABILI WHERE ROWID = T195.ROWID;
    IF P = NC THEN
      COMMIT;
      P:=0;
    END IF;
  END LOOP;
  COMMIT;
  P:=0;
  FOR T195B IN C195B LOOP
    P:=P + 1;
    INSERT INTO T195_VOCIVARIABILI SELECT * FROM T195_BACKUP WHERE ROWID = T195B.ROWID;
    IF P = NC THEN
      COMMIT;
      P:=0;
    END IF;
  END LOOP;
  COMMIT;
END;
/