ALTER TABLE T390_CHIAMATE_REPERIB ADD UTENTE VARCHAR2(30) NOT NULL;
alter table T390_CHIAMATE_REPERIB drop primary key;
drop index T390_PK/*--NOLOG--*/;
alter table T390_CHIAMATE_REPERIB
  add constraint T390_PK primary key (DATA,UTENTE,PROGRESSIVO_REPER) 
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
ALTER TABLE T390_CHIAMATE_REPERIB DROP COLUMN PROGRESSIVO_OPER;
comment on column T390_CHIAMATE_REPERIB.UTENTE is 'Operatore che effettua la chiamata';
