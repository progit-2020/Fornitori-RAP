ALTER TABLE T190_INTPAGHE ADD F215 VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T190_INTPAGHE ADD F225 VARCHAR2(1) DEFAULT 'N';
ALTER TABLE T190_INTPAGHE ADD P215 VARCHAR2(6);
ALTER TABLE T190_INTPAGHE ADD P225 VARCHAR2(6);

-- Create table 
create table T825_LIQUIDINDANNUO
(
  PROGRESSIVO NUMBER(38) not null,
  ANNO NUMBER(4) not null,
  LIQUIDABILE VARCHAR2(7)
)
  tablespace LAVORO
  pctfree 10
  pctused 70
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    pctincrease 0
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table T825_LIQUIDINDANNUO
  add constraint T825_PK primary key (PROGRESSIVO,ANNO)
  using index 
  tablespace INDICI
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
