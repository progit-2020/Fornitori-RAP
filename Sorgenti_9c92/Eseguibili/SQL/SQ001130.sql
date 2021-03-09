ALTER TABLE T161_INDGRUPPO ADD CODICE2 VARCHAR2(20) DEFAULT '*';
ALTER TABLE T161_INDGRUPPO DROP CONSTRAINT T161_PK;
ALTER TABLE T161_INDGRUPPO ADD CONSTRAINT T161_PK
  PRIMARY KEY (CODICE,CODICE2) 
  USING INDEX 
  TABLESPACE INDICI
  STORAGE(INITIAL 128K NEXT 128K PCTINCREASE 0);
  