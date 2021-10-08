UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.4' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T911_DATIRIEPILOGO MODIFY FORMATO VARCHAR2(500);

------------------------------------------------------------------------
-- 					CREDITI FORMATIVI - inizio
------------------------------------------------------------------------
UPDATE SG651_PIANIFICAZIONECORSI SET NUMERO_CREDITI = 0 WHERE NUMERO_CREDITI IS NULL;
alter table SG651_PIANIFICAZIONECORSI modify NUMERO_CREDITI default 0 not null;

create table SG655_PROFILICREDITI
(
  CODICE         VARCHAR2(80) not null,
  ANNO           NUMBER(4) not null,
  DESCRIZIONE    VARCHAR2(40),
  NUMERO_CREDITI NUMBER(4) default 0 not null,
  ASSENZE        VARCHAR2(500),
  PRESENZE       VARCHAR2(500),
  MINIMO         NUMBER(4) default 0 not null,
  MASSIMO        NUMBER(4) default 100 not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 32K
    next 256K
    minextents 1
    pctincrease 1
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SG655_PROFILICREDITI
  add constraint SG655_PK primary key (CODICE,ANNO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 32K
    next 256K
    minextents 1
    pctincrease 1
  );
------------------------------------------------------------------------
-- 					CREDITI FORMATIVI - fine
------------------------------------------------------------------------
