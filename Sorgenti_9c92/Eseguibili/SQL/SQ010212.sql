ALTER TABLE T410_PASTI ADD CAUSALE VARCHAR2(5) DEFAULT '*';
RENAME T410_PASTI TO T410_OLD;
create table T410_PASTI
(
  PROGRESSIVO NUMBER(38,2) not null,
  ANNO NUMBER(38,2) not null,
  MESE NUMBER(38,2) not null,
  CAUSALE VARCHAR2(5) default '*' not null,
  PASTI NUMBER(38,2),
  PASTI2 NUMBER(8)  
)
  tablespace LAVORO
  pctfree 5
  pctused 80
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );
INSERT INTO T410_PASTI (PROGRESSIVO,ANNO,MESE,CAUSALE,PASTI,PASTI2)
  SELECT PROGRESSIVO,ANNO,MESE,CAUSALE,PASTI,PASTI2 FROM T410_OLD;
alter table T410_PASTI
  add constraint T410_PK primary key (PROGRESSIVO,ANNO,MESE,CAUSALE)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );

ALTER TABLE T360_TERMENSA ADD CAUSALE VARCHAR2(1) DEFAULT 'N';