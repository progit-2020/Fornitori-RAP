ALTER TABLE T265_CAUASSENZE ADD REGISTRA_STORICO VARCHAR2(1) DEFAULT 'N';

create table T044_STORICOGIUSTIFICATIVI
(
  PROGRESSIVO NUMBER(8) not null,
  DATA DATE not null,
  CAUSALE VARCHAR2(5) not null,
  TIPOGIUST VARCHAR2(1) not null,
  DAORE DATE,
  AORE DATE,
  OPERAZIONE VARCHAR2(1) not null,
  FLAG VARCHAR2(1),
  DATA_AGG DATE,
  DATANAS DATE
)
  tablespace LAVORO pctfree 10 pctused 80 initrans 1 maxtrans 255
  storage (initial 32K next 5M minextents 1 pctincrease 0);

create index T044_PROGRESSIVODATA on T044_STORICOGIUSTIFICATIVI (PROGRESSIVO,DATA)
  tablespace INDICI pctfree 10 initrans 2 maxtrans 255
  storage (initial 32K next 5M minextents 1 pctincrease 0);

