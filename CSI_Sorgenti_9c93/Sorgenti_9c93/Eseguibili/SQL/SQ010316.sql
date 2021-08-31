ALTER TABLE T360_TERMENSA ADD CENA_DALLE  VARCHAR2(5);
ALTER TABLE T360_TERMENSA ADD CENA_ALLE VARCHAR2(5);
ALTER TABLE T375_ACCESSIMENSA ADD PRANZOCENA VARCHAR2(1) DEFAULT 'P';
ALTER TABLE T375_ACCESSIMENSA DROP CONSTRAINT T375_PK;
ALTER TABLE T375_ACCESSIMENSA ADD CONSTRAINT T375_PK
  PRIMARY KEY(PROGRESSIVO,DATA,CAUSALE,PRANZOCENA) 
  USING INDEX TABLESPACE INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    pctincrease 0
  );

