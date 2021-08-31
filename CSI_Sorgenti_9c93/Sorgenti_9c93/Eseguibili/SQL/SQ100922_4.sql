UPDATE SG101_FAMILIARI S1
SET    NUMORD = NUMORD + 1
WHERE  PROGRESSIVO IN (SELECT PROGRESSIVO FROM SG101_FAMILIARI S2 WHERE NUMORD = 0);

ALTER TABLE T196_FILTROSCARICOPAGHE 
MODIFY CODVOCE VARCHAR2(10);

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i >= 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'UNIEMENS';
    if i = 0 then
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', -2, 'Sostituzione,Stringa,Stringa,Stringa', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', -1, '*,"5G01","<><><>","11/2010"', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 0, 'select LPAD(MATRICOLA,7,''0'') ||TO_CHAR(DATA,''YYYYMMDD'')||GGLAVORATO FLUSSO_UNIEMENS from ', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 1, '-- Calendario va impostato ad un qualsiasi codice di calendario generato', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 2, '-- ElencoCauAss inserire eventuale assenze da considerare lavorative nel formato <COD1><COD2>..<CODn>', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 3, '  (SELECT T030A.MATRICOLA,T011.DATA,SUBSTR(getgglavorativo(T030A.PROGRESSIVO,T011.DATA ,:ElencoCauAss),1,10) GGLAVORATO ', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 4, '     FROM T030_ANAGRAFICO T030A, T430_STORICO T430, T011_CALENDARI T011', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 5, '     WHERE T030A.PROGRESSIVO = T430.PROGRESSIVO ', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 6, '     AND T011.CODICE = :Calendario', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 7, '     AND T011.DATA BETWEEN TO_DATE(''01/''||:MeseElab,''dd/mm/yyyy'') AND LAST_DAY(TO_DATE(''01/''||:MeseElab,''dd/mm/yyyy''))', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 8, '     AND T011.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 9, '     AND T011.DATA BETWEEN T430.INIZIO AND NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY''))', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 10, '     AND T030A.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 11, '  )', 'RILPRE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('UNIEMENS', 12, 'order by LPAD(MATRICOLA,7,''0'') ||TO_CHAR(DATA,''YYYYMMDD'')', 'RILPRE');
    end if;
  end if;
end;
/

alter table T025_CONTMENSILI add BANCA_ORE_ESCLUSA_SALDI varchar2(1) default 'N';
comment on column T025_CONTMENSILI.BANCA_ORE_ESCLUSA_SALDI is 'N=la banca ore è inclusa nel saldo annuo compensabili, S=la banca ore è esclusa dai saldi';

alter table T048_ATTESTATIINPS add ELABORATO varchar2(1) default 'N';
comment on column T048_ATTESTATIINPS.ELABORATO is 'Record elaborato S=Elaborato, N=Non Elaborato';

UPDATE T048_ATTESTATIINPS T048 SET T048.ELABORATO = 'S';

create table T013_FESTIVITA_AGGIUNTIVE (
  CODICE varchar2(5),
  ANNO number(4),
  MESE number(2),
  GIORNO number(2)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T013_FESTIVITA_AGGIUNTIVE.CODICE is 'codice del calendario presente in T010_CALENDIMPOSTAZ';
comment on column T013_FESTIVITA_AGGIUNTIVE.ANNO is 'Parte anno della festività da aggiungere: se vale 0 si considerano tutti gli anni con stesso Mese e GIORNO';
comment on column T013_FESTIVITA_AGGIUNTIVE.MESE is 'Parte mese della festività da aggiungere';
comment on column T013_FESTIVITA_AGGIUNTIVE.GIORNO is 'Parte giorno della festività da aggiungere';

comment on column T010_CALENDIMPOSTAZ.PATRONO is 'Obsoleto, gestito in T013 con ANNO=0';

alter table T013_FESTIVITA_AGGIUNTIVE add constraint T013_PK primary key (CODICE,ANNO,MESE,GIORNO)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

insert into T013_FESTIVITA_AGGIUNTIVE 
  select CODICE,0,to_char(PATRONO,'mm'),to_char(PATRONO,'dd') from T010_CALENDIMPOSTAZ where PATRONO is not null;

insert into T013_FESTIVITA_AGGIUNTIVE 
  select CODICE,2011,3,17 from T010_CALENDIMPOSTAZ;

alter table T265_CAUASSENZE add FRUIZ_MAX_NUM number(8);
comment on column T265_CAUASSENZE.FRUIZ_MAX_NUM is 'numero massimo di volte in cui è possibile fruire la causale nel periodo di cumulo corrente';

alter table T670_REGOLEBUONI add FASCE_MATPOM_PMT varchar2(1) default 'N';
comment on column T670_REGOLEBUONI.FASCE_MATPOM_PMT is 'S=le fasce orarie del mattino e del pomeriggio vengono determinate dallo smonto mensa (PMT) se esistente';

ALTER TABLE T760_REGOLEINCENTIVI ADD TIPO_QUOTEQUANT VARCHAR2(1) DEFAULT 'G';
comment on column T760_REGOLEINCENTIVI.TIPO_QUOTEQUANT is 'Tipo di calcolo delle quote quantitative (Generali, Schede individuali)';
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO)
SELECT AZIENDA, 'C7_INCQUANTPROFILO' FROM MONDOEDP.I090_ENTI;
create table T761_INCQUANTPROFILI
( ANNO                                 NUMBER,
  CODICE                               VARCHAR2(20) not null,
  NUM_ORE                           VARCHAR2(6),
  IMPORTO                            NUMBER
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column T761_INCQUANTPROFILI.ANNO is 'Anno di riferimento';
comment on column T761_INCQUANTPROFILI.CODICE is 'Codice del dato anagrafico aziendale del profilo';
comment on column T761_INCQUANTPROFILI.NUM_ORE is 'Numero ore del profilo';
comment on column T761_INCQUANTPROFILI.IMPORTO is 'Importo orario del profilo';
alter table T761_INCQUANTPROFILI
  add constraint T761_PK primary key (ANNO, CODICE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T767_INCQUANTGRUPPO
(  ANNO            NUMBER not null,
  CODGRUPPO       VARCHAR2(10) not null,
  DESCRIZIONE     VARCHAR2(100),
  FILTRO_ANAGRAFE VARCHAR2(2000),
  CODTIPOQUOTA    VARCHAR2(5) not null,
  NUMORE_TOTALE     VARCHAR2(6),
  IMPORTO_TOTALE    NUMBER,
  TOLLERANZA NUMBER,
  DATARIF         DATE,
  STATO     VARCHAR2(1) DEFAULT 'A',
  PAG1_PERC  NUMBER,
  PAG1_MAX    VARCHAR2(6),
  PAG2_PERC  NUMBER,
  PAG2_MAX    VARCHAR2(6),
  PAG3_PERC  NUMBER,
  PAG3_MAX    VARCHAR2(6),
  PAG4_PERC  NUMBER,
  PAG4_MAX    VARCHAR2(6),
  PAG5_PERC  NUMBER,
  PAG5_MAX    VARCHAR2(6),
  PAG6_PERC  NUMBER,
  PAG6_MAX    VARCHAR2(6),
  PAG7_PERC  NUMBER,
  PAG7_MAX    VARCHAR2(6),
  PAG8_PERC  NUMBER,
  PAG8_MAX    VARCHAR2(6),
  PAG9_PERC  NUMBER,
  PAG9_MAX    VARCHAR2(6),
  PAG10_PERC  NUMBER,
  PAG10_MAX    VARCHAR2(6),
  PAG11_PERC  NUMBER,
  PAG11_MAX    VARCHAR2(6),
  PAG12_PERC  NUMBER,
  PAG12_MAX    VARCHAR2(6)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T767_INCQUANTGRUPPO modify FILTRO_ANAGRAFE VARCHAR2(4000);
comment on column T767_INCQUANTGRUPPO.ANNO  is 'Anno di riferimento';
comment on column T767_INCQUANTGRUPPO.CODGRUPPO  is 'Codice identificativo del gruppo di appartenenza';
comment on column T767_INCQUANTGRUPPO.FILTRO_ANAGRAFE  is 'Filtro anagrafico che identifica i dipendenti del gruppo';
comment on column T767_INCQUANTGRUPPO.CODTIPOQUOTA  is 'Codice identificativo del tipo quota';
comment on column T767_INCQUANTGRUPPO.NUMORE_TOTALE  is 'Numero ore massimo del gruppo';
comment on column T767_INCQUANTGRUPPO.IMPORTO_TOTALE  is 'Importo massimo del budget del gruppo';
comment on column T767_INCQUANTGRUPPO.TOLLERANZA  is 'Tolleranza positiva o negativa applicata ai massimi';
comment on column T767_INCQUANTGRUPPO.STATO is 'Stato: A=aperto, C=chiuso, M=in modifica';
comment on column T767_INCQUANTGRUPPO.PAG1_PERC  is 'Percentuale ore liquidabili a gennaio';
comment on column T767_INCQUANTGRUPPO.PAG1_MAX  is 'Numero massimo di ore liquidabili a gennaio';
comment on column T767_INCQUANTGRUPPO.PAG2_PERC  is 'Percentuale ore liquidabili a febbraio';
comment on column T767_INCQUANTGRUPPO.PAG2_MAX  is 'Numero massimo di ore liquidabili a febbraio';
alter table T767_INCQUANTGRUPPO
  add constraint T767_PK primary key (ANNO, CODGRUPPO, CODTIPOQUOTA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table T768_INCQUANTINDIVIDUALI
(  ANNO                NUMBER not null,
  CODGRUPPO           VARCHAR2(10) not null,
  CODTIPOQUOTA        VARCHAR2(5) not null,
  PROGRESSIVO         NUMBER(8) not null,
  COD_PROFILO  VARCHAR2(80),
  DESC_PROFILO VARCHAR2(1000), 
  PARTTIME         NUMBER,
  FLESSIBILITA    VARCHAR2(100),
  IMPORTO_ORARIO NUMBER,
  NUMORE_ASSEGNATE    VARCHAR2(6),
  TOTALE_ASSEGNATO NUMBER,
  NUMORE_ACCETTATE    VARCHAR2(6),
  TOTALE_ACCETTATO NUMBER,
  CONFERMATO    VARCHAR2(1) DEFAULT 'N',
  NOTE VARCHAR2(1000),
  NUMORE_PAGATE    VARCHAR2(6)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T768_INCQUANTINDIVIDUALI.ANNO is 'Anno di riferimento';
comment on column T768_INCQUANTINDIVIDUALI.CODGRUPPO is 'Codice identificativo del gruppo di appartenenza';
comment on column T768_INCQUANTINDIVIDUALI.CODTIPOQUOTA is 'Codice identificativo del tipo quota';
comment on column T768_INCQUANTINDIVIDUALI.PROGRESSIVO is 'Progressivo del dipendente';
comment on column T768_INCQUANTINDIVIDUALI.COD_PROFILO is 'Codice profilo del dipendente';
comment on column T768_INCQUANTINDIVIDUALI.DESC_PROFILO is 'Descrizione profilo del dipendente';
comment on column T768_INCQUANTINDIVIDUALI.PARTTIME is 'Part-time del dipendente';
comment on column T768_INCQUANTINDIVIDUALI.FLESSIBILITA is 'Condizioni di flessibilità part-time del dipendente';
comment on column T768_INCQUANTINDIVIDUALI.IMPORTO_ORARIO is 'Importo orario letto dal profilo';
comment on column T768_INCQUANTINDIVIDUALI.NUMORE_ASSEGNATE  is 'Numero ore lette da profilo e ricalcolate su gg.servizio e part-time';
comment on column T768_INCQUANTINDIVIDUALI.TOTALE_ASSEGNATO  is 'Importo orario per numero ore assegnate';
comment on column T768_INCQUANTINDIVIDUALI.NUMORE_ACCETTATE is 'Numero ore accettate dal dipendente';
comment on column T768_INCQUANTINDIVIDUALI.TOTALE_ACCETTATO  is 'Importo orario per numero ore accettate';
comment on column T768_INCQUANTINDIVIDUALI.CONFERMATO is 'Conferma o meno delle ore accettate';
comment on column T768_INCQUANTINDIVIDUALI.NOTE is 'Note aggiuntive';
comment on column T768_INCQUANTINDIVIDUALI.NUMORE_PAGATE is 'Numero ore liquidate';

alter table T768_INCQUANTINDIVIDUALI
  add constraint T768_PK primary key (ANNO, CODGRUPPO, CODTIPOQUOTA, PROGRESSIVO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);