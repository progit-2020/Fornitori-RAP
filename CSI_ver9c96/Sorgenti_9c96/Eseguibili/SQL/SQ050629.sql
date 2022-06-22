alter table SG650_CORSIECM modify TITOLO_CORSO VARCHAR2(500);
alter table SG650_CORSIECM modify DOCENTE VARCHAR2(500);
alter table SG650_CORSIECM modify NOTE VARCHAR2(500);

CREATE TABLE SG509_20050718 AS SELECT * FROM SG509_DETTAGLIOSTAMPA;
UPDATE SG509_DETTAGLIOSTAMPA SET VALORI = NULL;
ALTER TABLE SG509_DETTAGLIOSTAMPA MODIFY VALORI LONG;
UPDATE SG509_DETTAGLIOSTAMPA T1
   SET VALORI = (SELECT VALORI FROM SG509_20050718 
                  WHERE CODICE_STAMPA = T1.CODICE_STAMPA
                    AND TIPO_CAMPO = T1.TIPO_CAMPO
                    AND LIVELLO = T1.LIVELLO);


drop table P266_MOD1ONAOSI;
-- Create table
create table P266_MODONAOSI
(
  PROGRESSIVO           NUMBER not null,
  DATA_FINE_PERIODO    DATE not null,
  DATA_EVENTO           DATE not null,
  TIPO_EVENTO           VARCHAR2(5) not null,
  CONTRIBUTO_PRECEDENTE NUMBER default 0 not null,
  CONTRIBUTO_MESE1      NUMBER default 0 not null,
  CONTRIBUTO_MESE2      NUMBER default 0 not null,
  CONTRIBUTO_MESE3      NUMBER default 0 not null,
  CONTRIBUTO_MESE4      NUMBER default 0 not null,
  CONTRIBUTO_MESE5      NUMBER default 0 not null,
  CONTRIBUTO_MESE6      NUMBER default 0 not null,
  CREDITO_PRECEDENTE    NUMBER default 0 not null,
  CONTRIBUTO_DOVUTO     NUMBER default 0 not null
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
-- Add comments to the columns 
comment on column P266_MODONAOSI.DATA_FINE_PERIODO
  is 'Anno e mese di fine periodo elaborato';
comment on column P266_MODONAOSI.DATA_EVENTO
  is 'Data in cui si è verificato l''evento: primo giorno del semestre se tipo evento = 0';
comment on column P266_MODONAOSI.TIPO_EVENTO
  is 'Codice dell''evento: 0 se non si sono verificati eventi';
comment on column P266_MODONAOSI.CONTRIBUTO_PRECEDENTE
  is 'Contributo su arretrati retributivi contrattuali';
comment on column P266_MODONAOSI.CONTRIBUTO_MESE1
  is 'Contributo trattenuto nel primo mese del semestre';
comment on column P266_MODONAOSI.CONTRIBUTO_MESE2
  is 'Contributo trattenuto nel secondo mese del semestre';
comment on column P266_MODONAOSI.CONTRIBUTO_MESE3
  is 'Contributo trattenuto nel terzo mese del semestre';
comment on column P266_MODONAOSI.CONTRIBUTO_MESE4
  is 'Contributo trattenuto nel quarto mese del semestre';
comment on column P266_MODONAOSI.CONTRIBUTO_MESE5
  is 'Contributo trattenuto nel quinto mese del semestre';
comment on column P266_MODONAOSI.CONTRIBUTO_MESE6
  is 'Contributo trattenuto nel sesto mese del semestre';
comment on column P266_MODONAOSI.CREDITO_PRECEDENTE
  is 'Eventuale credito relativo ai semestri precedenti';
comment on column P266_MODONAOSI.CONTRIBUTO_DOVUTO
  is 'Contributo dovuto nel semestre comprensivo di regolarizzazioni per periodi precedenti';

-- Create/Recreate primary, unique and foreign key constraints 
alter table P266_MODONAOSI
  add constraint P266_PK primary key (PROGRESSIVO, DATA_FINE_PERIODO, DATA_EVENTO, TIPO_EVENTO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    minextents 1
  );
alter table P266_MODONAOSI
  add constraint P266_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

ALTER TABLE P430_ANAGRAFICO ADD COD_ONAOSITIPOASS VARCHAR2(5);
ALTER TABLE P430_ANAGRAFICO ADD COD_ONAOSITIPOCESS VARCHAR2(5);
ALTER TABLE P430_ANAGRAFICO ADD DATA_ISCRIZIONE_ALBO DATE;
ALTER TABLE P430_ANAGRAFICO ADD NUMERO_ISCRIZIONE_ALBO VARCHAR2(10);
ALTER TABLE P430_ANAGRAFICO ADD PROVINCIA_ALBO VARCHAR2(2);
comment on column P430_ANAGRAFICO.COD_ONAOSITIPOASS
  is 'Codice tipo assunzione per ONAOSI';
comment on column P430_ANAGRAFICO.COD_ONAOSITIPOCESS
  is 'Codice tipo cessazione per ONAOSI';
comment on column P430_ANAGRAFICO.DATA_ISCRIZIONE_ALBO
  is 'Data iscrizione albo';
comment on column P430_ANAGRAFICO.NUMERO_ISCRIZIONE_ALBO
  is 'Numero iscrizione albo';
comment on column P430_ANAGRAFICO.PROVINCIA_ALBO
  is 'Provincia albo';
