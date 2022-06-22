ALTER TABLE T001_PARAMETRIFUNZIONI ADD PROGOPERATORE NUMBER(8);
ALTER TABLE T001_PARAMETRIFUNZIONI DROP CONSTRAINT T001_PK;
INSERT INTO T001_PARAMETRIFUNZIONI (PROGOPERATORE,PROG,NOME,VALORE)
  SELECT PROGRESSIVO,T001.PROG,T001.NOME,T001.VALORE
  FROM I070_OPERATORI,T001_PARAMETRIFUNZIONI T001;
DELETE FROM T001_PARAMETRIFUNZIONI WHERE PROGOPERATORE IS NULL;
ALTER TABLE T001_PARAMETRIFUNZIONI ADD CONSTRAINT T001_PK
  PRIMARY KEY (PROGOPERATORE,PROG,NOME) USING INDEX TABLESPACE INDICI;