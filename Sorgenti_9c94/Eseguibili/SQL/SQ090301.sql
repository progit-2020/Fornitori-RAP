UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '7.5',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

comment on column P500_CUDSETUP.FIRMA_ORGANO_CONTROLLO is 'Indica se prevista firma da parte di organi di controllo (0/1) - Non gestito';

comment on column T050_RICHIESTEASSENZA.ELABORATO is 'N = non elaborato, S = elaborato, E = elaborato con errori';

comment on column T105_RICHIESTETIMBRATURE.ELABORATO is 'N = non elaborato, S = elaborato, E = elaborato con errori';

INSERT INTO T545_TIPITURNO(CODICE,DESCRIZIONE,COMANDATO) VALUES('01C','Commento','S');
INSERT INTO T545_TIPITURNO(CODICE,DESCRIZIONE,COMANDATO) VALUES('01N','Commento','N');

UPDATE P660_FLUSSIREGOLE T
SET T.REGOLA_CALCOLO_MANUALE=
  SUBSTR(T.REGOLA_CALCOLO_MANUALE, 1, INSTR(T.REGOLA_CALCOLO_MANUALE,'ORDER BY') + 8)
  || 'P254.COD_CONTRATTO, P254.COD_VOCE, P254.COD_VOCE_SPECIALE, P442.DATA_COMPETENZA_A DESC'
WHERE T.NOME_FLUSSO='DMA' AND T.PARTE='F1' AND T.NUMERO='001';

UPDATE P660_FLUSSIREGOLE T SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE
WHERE T.NOME_FLUSSO='DMA' AND T.PARTE='F1' AND T.NUMERO='001';

update P201_ASSOGGETTAMENTI t set
    DECORRENZA_FINE =
    (select min(DECORRENZA) - 1 from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO and
     DECORRENZA > t.DECORRENZA)
  where
    DECORRENZA < (select max(DECORRENZA) from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO);
update P201_ASSOGGETTAMENTI t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where
    DECORRENZA = (select max(DECORRENZA) from P201_ASSOGGETTAMENTI where
     COD_CONTRATTO = t.COD_CONTRATTO and
     COD_VOCE_PADRE = t.COD_VOCE_PADRE and
     COD_VOCE_SPECIALE_PADRE = t.COD_VOCE_SPECIALE_PADRE and
     COD_VOCE_FIGLIO = t.COD_VOCE_FIGLIO and
     COD_VOCE_SPECIALE_FIGLIO = t.COD_VOCE_SPECIALE_FIGLIO);

ALTER TABLE P216_ACCORPAMENTOVOCI
  ENABLE CONSTRAINT P216_FK_P215;

UPDATE P200_VOCI T SET T.RIDOTTA_PARTTIME_VERT='S',T.RIDOTTA_PARTTIME_ORIZZ='S' WHERE T.TIPO='IM' AND T.COD_CONTRATTO<>'EDPON';

-- Limiti suddivisi sui conteggi mensili
alter table T025_CONTMENSILI modify PA_LIMITESALDOATT varchar2(7) default null;
comment on column T025_CONTMENSILI.PA_LIMITESALDOATT  is 'Limite massimo di ore dell''anno corrente residuabili sul nuovo anno';

alter table T025_CONTMENSILI add PA_LIMITESALDOPREC varchar2(7);
comment on column T025_CONTMENSILI.PA_LIMITESALDOPREC is 'Limite massimo di ore dell''anno precedente residuabili sul nuovo anno';

update T025_CONTMENSILI set PA_LIMITESALDOATT=decode(PA_LIMITESALDOATT,'S',PA_LIMITE,null), PA_LIMITE=decode(PA_LIMITESALDOATT,'S',null,PA_LIMITE);

-- Script per reimpostazione delle tabelle relative al budget straordinario
declare
  LIVELLO1  varchar2(30);
  i integer;
begin
  select COUNT(*) into i from T700_GERARCHIABUDGET where ORDINE > 1 order by ORDINE;
  if i > 0 then
    select CAMPO into LIVELLO1 from T700_GERARCHIABUDGET where ORDINE = 1;
    begin  
      execute immediate 'alter table T712_BUDGET' || LIVELLO1 || ' drop primary key';
    exception when others then null; end;
    execute immediate 'alter table T712_BUDGET' || LIVELLO1 || ' rename to T712_BUDGET' || LIVELLO1 || '_75';
    execute immediate 'create table T712_BUDGET' || LIVELLO1 || ' as select ANNO, CONTRATTO, ' || LIVELLO1 || ', BUDGET from T712_BUDGET' || LIVELLO1 || '_75';
    execute immediate 'alter table T712_BUDGET' || LIVELLO1 || ' add constraint T712' || LIVELLO1 || '_PK PRIMARY KEY (ANNO, CONTRATTO, ' || LIVELLO1 || ') using index TABLESPACE INDICI';
    delete from T700_GERARCHIABUDGET where ORDINE > 1;
    commit;
  end if;
end/*--NOLOG--*/;
/

INSERT INTO P452_DATIMENSILIDESC
SELECT 'PU13A','Tredicesima pagata su ultimo ced. chiuso','T',0,'S','P' FROM DUAL
WHERE NOT EXISTS
(SELECT 'X' FROM P452_DATIMENSILIDESC T WHERE T.COD_CAMPO='PU13A');

alter table P216_ACCORPAMENTOVOCI drop primary key;
drop index P216_PK;
alter table P216_ACCORPAMENTOVOCI
  add constraint P216_PK primary key (COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, COD_TIPOACCORPAMENTOVOCI, COD_CODICIACCORPAMENTOVOCI, DECORRENZA, IMPORTO_COLONNA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

UPDATE P150_SETUP SET COD_PAGAMENTO = '1' WHERE COD_PAGAMENTO IS NULL;
UPDATE P150_SETUP SET COD_VALUTA_BASE = 'EURO' WHERE COD_VALUTA_BASE IS NULL;
UPDATE P150_SETUP SET COD_VALUTA_STAMPA = 'EURO' WHERE COD_VALUTA_STAMPA IS NULL;
UPDATE P150_SETUP SET NUM_DEC_PERC = 2 WHERE NUM_DEC_PERC IS NULL;
UPDATE P150_SETUP SET NUM_DEC_QUANTITA = 2 WHERE NUM_DEC_QUANTITA IS NULL;
UPDATE P150_SETUP SET TIPO_ORE = 'OC' WHERE TIPO_ORE IS NULL;
COMMIT;
alter table P150_SETUP modify COD_PAGAMENTO not null;
alter table P150_SETUP modify COD_VALUTA_BASE not null;
alter table P150_SETUP modify COD_VALUTA_STAMPA not null;
alter table P150_SETUP modify NUM_DEC_PERC not null;
alter table P150_SETUP modify NUM_DEC_QUANTITA not null;
alter table P150_SETUP modify TIPO_ORE not null;

comment on column P150_SETUP.COD_VALUTA_BASE
  is 'Valuta utilizzata per i calcoli del cedolino';
comment on column P150_SETUP.COD_VALUTA_STAMPA
  is 'Valuta utilizzata per il netto del cedolino';
alter table P150_SETUP add COD_VALUTA_CONT VARCHAR2(10);
comment on column P150_SETUP.COD_VALUTA_CONT
  is 'Valuta utilizzata per la contabilita''';
alter table P150_SETUP add DECORRENZA_FINE DATE;

update P150_SETUP t set
    DECORRENZA_FINE =
    (select min(DECORRENZA) - 1 from P150_SETUP where DECORRENZA > t.DECORRENZA)
  where
    DECORRENZA < (select max(DECORRENZA) from P150_SETUP);
update P150_SETUP t set
    DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
  where
    DECORRENZA = (select max(DECORRENZA) from P150_SETUP);

comment on column P430_ANAGRAFICO.COD_VALUTA_STAMPA
  is 'Valuta utilizzata per il netto del cedolino';
alter table P430_ANAGRAFICO add COD_VALUTA_BASE VARCHAR2(10);
comment on column P430_ANAGRAFICO.COD_VALUTA_BASE
  is 'Valuta utilizzata per i calcoli del cedolino';

comment on column P441_CEDOLINO.COD_VALUTA_STAMPA
  is 'Valuta utilizzata per il netto del cedolino';
alter table P441_CEDOLINO add COD_VALUTA_BASE VARCHAR2(10);
comment on column P441_CEDOLINO.COD_VALUTA_BASE
  is 'Valuta utilizzata per i calcoli del cedolino';
alter table P441_CEDOLINO add DATA_CAMBIO_VALUTA DATE;
comment on column P441_CEDOLINO.DATA_CAMBIO_VALUTA
  is 'Data per cambio valuta';

UPDATE P441_CEDOLINO T SET T.COD_VALUTA_BASE=T.COD_VALUTA_STAMPA WHERE T.COD_VALUTA_BASE IS NULL;

comment on column P445_CEDOLINOTEMP.COD_VALUTA_STAMPA
  is 'Valuta utilizzata per il netto del cedolino';
alter table P445_CEDOLINOTEMP add COD_VALUTA_BASE VARCHAR2(10);
comment on column P445_CEDOLINOTEMP.COD_VALUTA_BASE
  is 'Valuta utilizzata per i calcoli del cedolino';
alter table P445_CEDOLINOTEMP add DATA_CAMBIO_VALUTA DATE;
comment on column P445_CEDOLINOTEMP.DATA_CAMBIO_VALUTA
  is 'Data per cambio valuta';

DELETE MONDOEDP.I091_DATIENTE WHERE TIPO = 'C1_QUALIFMINIST';
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO, DATO)
SELECT AZIENDA, 'C1_CEDOLINICONVALUTA', 'N' FROM MONDOEDP.I090_ENTI I
WHERE NOT EXISTS
(SELECT 'X' FROM MONDOEDP.I091_DATIENTE T WHERE T.AZIENDA=I.AZIENDA AND T.TIPO='C1_CEDOLINICONVALUTA');

--Comune di Torino
alter table T020_ORARI add XPARAM varchar2(500);

alter table T031_DATACARTELLINO add TIPO varchar2(1) default '0';
comment on column T031_DATACARTELLINO.TIPO is '0=Data di controllo sul cartellino interattivo, 1=Il periodo continuativo di assenza per causali con TipoCumulo=O viene interrotto da questa data';

update T031_DATACARTELLINO set TIPO = '0';

delete from t031_datacartellino where lpad(progressivo,8,'0')||data||tipo in
(select lpad(progressivo,8,'0')||data||tipo from t031_datacartellino group by progressivo,data,tipo having count(*) > 1);

alter table T031_DATACARTELLINO add constraint T031_PK primary key (PROGRESSIVO,DATA,TIPO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T265_CAUASSENZE add COPRI_GGNONLAV varchar2(1) default 'N';

comment on column T265_CAUASSENZE.COPRI_GGNONLAV is 'Se attivo, l''inserimento del periodo viene eventualmente anticipato ai gg non lav precedenti per collegarsi al periodo precedente';
comment on column T265_CAUASSENZE.GSIGNIFIC  is 'GC=Giorni di Calendario - GL=Giorni Lavorativi, GT=Giorni Lav. Turnisti, G6=Giorni da LUN a SAB, EF=Esclusi festivi Infrasett., DF=DOM.+festivi infrasett.';
comment on column T275_CAUPRESENZE.ABBATTE_BUDGET  is 'N=No, L=Ore Liquidate, M=Ore Liquidate, B=Banca ore';

alter table P200_VOCI add DECORRENZA_FINE DATE;
update P200_VOCI t
set DECORRENZA_FINE = (select min(DECORRENZA) - 1
                       from   P200_VOCI
                       where  COD_CONTRATTO = t.COD_CONTRATTO
                       and    COD_VOCE = t.COD_VOCE
                       and    COD_VOCE_SPECIALE = t.COD_VOCE_SPECIALE
                       and    DECORRENZA > t.DECORRENZA)
where DECORRENZA < (select max(DECORRENZA)
                    from   P200_VOCI
                    where  COD_CONTRATTO = t.COD_CONTRATTO
                    and    COD_VOCE = t.COD_VOCE
                    and    COD_VOCE_SPECIALE = t.COD_VOCE_SPECIALE);
update P200_VOCI t
set DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
where DECORRENZA = (select max(DECORRENZA)
                    from   P200_VOCI
                    where  COD_CONTRATTO = t.COD_CONTRATTO
                    and    COD_VOCE = t.COD_VOCE
                    and    COD_VOCE_SPECIALE = t.COD_VOCE_SPECIALE);


-- Create table
create table P280_SERVIZIPENSPREV
(
  PROGRESSIVO            NUMBER not null,
  DECORRENZA_INIZIO      DATE not null,
  DECORRENZA_FINE        DATE not null,
  TIPO_RECORD            VARCHAR2(1) not null,
  TIPO_DIPENDENTE        VARCHAR2(2) default 'RU',
  COD_TIPOIMPIEGO        VARCHAR2(5),
  COD_TIPOSERVIZIO       VARCHAR2(5),
  TIPO_PARTTIME          VARCHAR2(5),
  PERCENTUALE_PARTTIME   NUMBER,
  CASSA_PENS             VARCHAR2(1),
  CASSA_PREV             VARCHAR2(1),
  TFR                    VARCHAR2(1) default 'N',
  COD_MAGGIORAZIONI      VARCHAR2(10),
  COD_CUDINPDAPCAUSACESS VARCHAR2(5),
  CHIUSO                 VARCHAR2(1) default 'N' not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P280_SERVIZIPENSPREV.TIPO_RECORD
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column P280_SERVIZIPENSPREV.TIPO_DIPENDENTE
  is 'Tipo lavoratore: RU=Tempo indeterminato, IN=Tempo determinato';
comment on column P280_SERVIZIPENSPREV.COD_TIPOIMPIEGO
  is 'Codice tipo impiego';
comment on column P280_SERVIZIPENSPREV.COD_TIPOSERVIZIO
  is 'Codice tipo servizio';
comment on column P280_SERVIZIPENSPREV.TIPO_PARTTIME
  is 'Tipo part-time: O=Orizzontale, V=Verticale, C=Ciclico';
comment on column P280_SERVIZIPENSPREV.CASSA_PENS
  is 'Cassa pensionistica';
comment on column P280_SERVIZIPENSPREV.CASSA_PREV
  is 'Cassa previdenziale';
comment on column P280_SERVIZIPENSPREV.COD_MAGGIORAZIONI
  is 'Maggiorazioni';
comment on column P280_SERVIZIPENSPREV.COD_CUDINPDAPCAUSACESS
  is 'Motivo cessazione';
comment on column P280_SERVIZIPENSPREV.CHIUSO
  is 'Chiuso (S/N) se il periodo e'' stato chiuso';

alter table P280_SERVIZIPENSPREV
  add constraint P280_PK primary key (PROGRESSIVO, DECORRENZA_INIZIO, TIPO_RECORD)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P280_SERVIZIPENSPREV
  add constraint P280_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

-- Create table
create table P282_PERIODIRETR
(
  PROGRESSIVO       NUMBER not null,
  DECORRENZA_INIZIO DATE not null,
  DECORRENZA_FINE   DATE not null,
  TIPO_RECORD       VARCHAR2(1) not null,
  RETRIB_ANNUA      VARCHAR2(1) default 'S' not null,
  CHIUSO            VARCHAR2(1) default 'N' not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P282_PERIODIRETR.TIPO_RECORD
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column P282_PERIODIRETR.CHIUSO
  is 'Chiuso (S/N) se il periodo e'' stato chiuso';
-- Create/Recreate primary, unique and foreign key constraints
alter table P282_PERIODIRETR
  add constraint P282_PK primary key (PROGRESSIVO, DECORRENZA_INIZIO, TIPO_RECORD)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P282_PERIODIRETR
  add constraint P282_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

-- Create table
create table P284_IMPORTIRETR
(
  PROGRESSIVO                NUMBER not null,
  DECORRENZA_INIZIO          DATE not null,
  TIPO_RECORD                VARCHAR2(1) not null,
  COD_CONTRATTO              VARCHAR2(5) not null,
  COD_VOCE                   VARCHAR2(5) not null,
  COD_VOCE_SPECIALE          VARCHAR2(5) not null,
  COD_TIPOACCORPAMENTOVOCI   VARCHAR2(5) not null,
  COD_CODICIACCORPAMENTOVOCI VARCHAR2(5) not null,
  IMPORTO_INTERO             NUMBER default 0 not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P284_IMPORTIRETR.TIPO_RECORD
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column P284_IMPORTIRETR.COD_TIPOACCORPAMENTOVOCI
  is 'Tipo accorpamento per creazione voci INPDAP';
comment on column P284_IMPORTIRETR.COD_CODICIACCORPAMENTOVOCI
  is 'Numero voce INPDAP';
comment on column P284_IMPORTIRETR.IMPORTO_INTERO
  is 'Importo della voce prima della riduzione per Part-time';
-- Create/Recreate primary, unique and foreign key constraints
alter table P284_IMPORTIRETR
  add constraint P284_PK primary key (PROGRESSIVO, DECORRENZA_INIZIO, TIPO_RECORD, COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P284_IMPORTIRETR
  add constraint P284_FK_P282 foreign key (PROGRESSIVO, DECORRENZA_INIZIO, TIPO_RECORD)
  references P282_PERIODIRETR (PROGRESSIVO, DECORRENZA_INIZIO, TIPO_RECORD) on delete cascade;

alter table P254_VOCIPROGRAMMATE add COD_VALUTA_INIZ VARCHAR2(10);
comment on column P254_VOCIPROGRAMMATE.COD_VALUTA_INIZ
  is 'Valuta degli importi';

alter table P050_ARROTONDAMENTI add DECORRENZA_FINE DATE;
update P050_ARROTONDAMENTI t
set DECORRENZA_FINE = (select min(DECORRENZA) - 1
                       from   P050_ARROTONDAMENTI
                       where  COD_ARROTONDAMENTO = t.COD_ARROTONDAMENTO
                       and    COD_VALUTA = t.COD_VALUTA
                       and    DECORRENZA > t.DECORRENZA)
where DECORRENZA < (select max(DECORRENZA)
                    from   P050_ARROTONDAMENTI
                    where  COD_ARROTONDAMENTO = t.COD_ARROTONDAMENTO
                    and    COD_VALUTA = t.COD_VALUTA);
update P050_ARROTONDAMENTI t
set DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
where DECORRENZA = (select max(DECORRENZA)
                    from   P050_ARROTONDAMENTI
                    where  COD_ARROTONDAMENTO = t.COD_ARROTONDAMENTO
                    and    COD_VALUTA = t.COD_VALUTA);

alter table P442_CEDOLINOVOCI add COD_VALUTA_INIZ VARCHAR2(10);
alter table P442_CEDOLINOVOCI add IMPORTO_VALUTA_INIZ NUMBER;
comment on column P442_CEDOLINOVOCI.COD_VALUTA_INIZ
  is 'Valuta iniziale degli importi';
comment on column P442_CEDOLINOVOCI.IMPORTO_VALUTA_INIZ
  is 'Importo della voce nella valuta iniziale';

alter table P446_CEDOLINOTEMPVOCI add COD_VALUTA_INIZ VARCHAR2(10);
alter table P446_CEDOLINOTEMPVOCI add IMPORTO_VALUTA_INIZ NUMBER;
comment on column P446_CEDOLINOTEMPVOCI.COD_VALUTA_INIZ
  is 'Valuta iniziale degli importi';
comment on column P446_CEDOLINOTEMPVOCI.IMPORTO_VALUTA_INIZ
  is 'Importo della voce nella valuta iniziale';

alter table P032_CAMBI add DECORRENZA_FINE DATE;
update P032_CAMBI t
set DECORRENZA_FINE = (select min(DECORRENZA) - 1
                       from   P032_CAMBI
                       where  COD_VALUTA1 = t.COD_VALUTA1
                       and    COD_VALUTA2 = t.COD_VALUTA2
                       and    DECORRENZA > t.DECORRENZA)
where DECORRENZA < (select max(DECORRENZA)
                    from   P032_CAMBI
                    where  COD_VALUTA1 = t.COD_VALUTA1
                    and    COD_VALUTA2 = t.COD_VALUTA2);
update P032_CAMBI t
set DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
where DECORRENZA = (select max(DECORRENZA)
                    from   P032_CAMBI
                    where  COD_VALUTA1 = t.COD_VALUTA1
                    and    COD_VALUTA2 = t.COD_VALUTA2);

UPDATE p050_arrotondamenti t SET T.DESCRIZIONE='Eccesso 1 euro'
WHERE T.COD_ARROTONDAMENTO='E1000' AND T.COD_VALUTA='EURO';

UPDATE p050_arrotondamenti t SET T.DESCRIZIONE='Puro decimo di euro',T.VALORE=0.1
WHERE T.COD_ARROTONDAMENTO='P10' AND T.COD_VALUTA='EURO';

alter table T020_ORARI add MINIMISTR_COMP varchar2(1) default 'N';
comment on column T020_ORARI.MINIMISTR_COMP is 'S=i minuti sotto il minimo richiesto per ogni spezzone sono mantenuti nel compensabile, N=i minuti sotto il minimo richiesto per ogni spezzone sono persi';

update t020_orari set MAXGIOSTR = null where MAXGIOSTR is not null and oreminuti(MAXGIOSTR) = 0;

declare
  cursor c1 is
  select
    'comment on column '||
    table_name||'.'||
    column_name||
    ' is '''||
    replace(replace(comments,';',','),'''','''''')||'''' comando
  from user_col_comments where comments is not null
  and instr(comments,'=') > 0 and instr(comments,';') > 0
  union
  select
    'comment on column '||
    table_name||'.'||
    column_name||
    ' is '''||
    replace(replace(comments,' - ',', '),'''','''''')||'''' from user_col_comments where comments is not null
  and instr(comments,'=') > 0 and instr(comments,' - ') > 0;
begin
  for t1 in c1 loop
    begin
      execute immediate t1.comando;
    exception
      when others then null;
    end;
  end loop;
end;
/

ALTER TABLE P500_CUDSETUP
ADD DATA_INIZIO_CED VARCHAR2(50);
comment on column P500_CUDSETUP.DATA_INIZIO_CED is 'Campo contenente la data di inizio rapporto del dipendente per il cedolino';
UPDATE P500_CUDSETUP
SET DATA_INIZIO_CED = 'T430INIZIO'
WHERE DATA_INIZIO_CED IS NULL;

alter table T025_CONTMENSILI add BANCA_ORE_CONTR_LIQUIDAZ varchar2(1) default 'L';
update T025_CONTMENSILI set BANCA_ORE_CONTR_LIQUIDAZ = 'M';
comment on column T025_CONTMENSILI.BANCA_ORE_CONTR_LIQUIDAZ is 'M=i controlli in fase di liquidazione considerano la banca ore maturata, L=i controlli in fase di liquidazione considerano la banca ore liquidata';

alter table P252_VOCIAGGIUNTIVEIMPORTI add COD_VALUTA_INIZ varchar2(10);
comment on column P252_VOCIAGGIUNTIVEIMPORTI.COD_VALUTA_INIZ
  is 'Valuta degli importi';

alter table I500_DATILIBERI add SCADENZA varchar2(1) default 'N';
comment on column I500_DATILIBERI.SCADENZA is 'S=Gestione manuale della scadenza, N=Gestione automatica della scadenza';

comment on column T380_PIANIFREPERIB.BADGE is 'Dato obsoleto';
comment on column T380_PIANIFREPERIB.NOME is 'Dato obsoleto';

alter table T275_CAUPRESENZE add ARROT_RIEPGG varchar2(5);
comment on column T275_CAUPRESENZE.ARROT_RIEPGG is 'Arrotondamento da applicare al riepilogo giornaliero della causale';
alter table T275_CAUPRESENZE add ARROT_RIEPGG_ORENORM varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.ARROT_RIEPGG_ORENORM is 'S=il resto dell''arrotondamento viene mantenuto nelle ore normali, N=il resto dell''arrotondamento viene perso';
alter table T275_CAUPRESENZE add ARROT_RIEPGG_FASCE varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.ARROT_RIEPGG_FASCE is 'S=l''arrotondamento viene applicato anche all''interno delle fasce di maggiorazione, N=l''arrotondamento viene applicato al totale giornaliero';

alter table T305_CAUGIUSTIF add BANCAORE_NEGATIVA varchar2(1) default 'N';
comment on column T305_CAUGIUSTIF.BANCAORE_NEGATIVA is 'S=se l''assestamento fa diminuire la banca ore residua, la banca ore del mese può andare in negativo entro la disponibilità dell''anno corrente, T=se l''assestamento fa diminuire la banca ore residua, la banca ore del mese può andare in negativo entro la disponibilità dell''anno precedente e corrente, N=anche se l''assestamento manda in negativo il saldo del mese la banca ore non può scendere sotto lo 0';

alter table P212_PARAMETRISTIPENDI modify TIPO_RIDUZIONE_STIPENDIO default 'EP';
comment on column P212_PARAMETRISTIPENDI.TIPO_RIDUZIONE_STIPENDIO
  is 'Tipo calcolo per frazioni di mese: EP=Enti Pubblici, EI=Enti Internazionali';
UPDATE P212_PARAMETRISTIPENDI T SET T.TIPO_RIDUZIONE_STIPENDIO='EP' WHERE T.COD_PARAMETRISTIPENDI<>'EDPON';
UPDATE P212_PARAMETRISTIPENDI T SET T.TIPO_RIDUZIONE_STIPENDIO='EI' WHERE T.COD_PARAMETRISTIPENDI='EDPON';

-- Variazione descrizione T01 colonne 1 e 2 (31.12.2007)
UPDATE p552_contoannregole t SET T.DESCRIZIONE=REPLACE(T.DESCRIZIONE,'31.12.2006','31.12.2007')
WHERE T.ANNO=2008 AND T.COD_TABELLA='T01' AND T.RIGA=0 AND T.COLONNA IN (1,2);

UPDATE p552_contoannregole t SET T.REGOLA_CALCOLO_MANUALE=REPLACE(T.REGOLA_CALCOLO_MANUALE,'31.12.2006','31.12.2007')
WHERE T.ANNO=2008 AND T.COD_TABELLA='T01' AND T.RIGA=0 AND T.COLONNA=0;

UPDATE P200_VOCI T SET T.ECCEZIONI_SENSIBILI='a'
WHERE T.COD_VOCE='10208' AND T.COD_CONTRATTO IN('EDP','EDPSC');


DROP TABLE T761_OLD;
-- ******************    Regole incentivi    ******************************
CREATE TABLE T760_20090504 AS SELECT * FROM T760_REGOLEINCENTIVI;
DROP TABLE T760_REGOLEINCENTIVI;
create table T760_REGOLEINCENTIVI
(
  LIVELLO                      VARCHAR2(20) not null,
  ELENCOLIV                    VARCHAR2(100),
  TIPO                         VARCHAR2(1) default 'C',
  ABBATTIMENTO_MAX             NUMBER,
  PROPORZIONE_INCENTIVI        VARCHAR2(1) default '0',
  DECORRENZA                   DATE not null,
  PROPORZIONE_PARTTIME         VARCHAR2(1) default 'N'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column T760_REGOLEINCENTIVI.LIVELLO
  is 'Codice del dato anagrafico aziendale';
comment on column T760_REGOLEINCENTIVI.ELENCOLIV
  is 'Livelli validi';
comment on column T760_REGOLEINCENTIVI.TIPO
  is 'Tipo di calcolo ';
comment on column T760_REGOLEINCENTIVI.ABBATTIMENTO_MAX
  is 'Abbattimento massimo';
comment on column T760_REGOLEINCENTIVI.PROPORZIONE_INCENTIVI
  is 'Proporzione incentivi';
comment on column T760_REGOLEINCENTIVI.DECORRENZA
  is 'Decorrenza';
comment on column T760_REGOLEINCENTIVI.PROPORZIONE_PARTTIME
  is 'Considera o meno il proporzionamento sulla % di part-time';
alter table T760_REGOLEINCENTIVI
  add constraint T760_PK primary key (DECORRENZA, LIVELLO)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
INSERT INTO T760_REGOLEINCENTIVI (LIVELLO, ELENCOLIV, TIPO,
  ABBATTIMENTO_MAX, PROPORZIONE_INCENTIVI, DECORRENZA, PROPORZIONE_PARTTIME)
SELECT LIVELLO, ELENCOLIV, TIPO,
  ABBATTIMENTO_MAX, PROPORZIONE_INCENTIVI, DECORRENZA, PROPORZIONE_PARTTIME
  FROM T760_20090504;
COMMIT;
-- ***********************   Regole Quote  ************************************
CREATE TABLE T765_20090504 AS SELECT * FROM T765_TIPOQUOTE;
ALTER TABLE T765_TIPOQUOTE ADD DECORRENZA DATE;
comment on column T765_TIPOQUOTE.DECORRENZA
  is 'Decorrenza';
ALTER TABLE T765_TIPOQUOTE ADD CAUSALE_ASSESTAMENTO VARCHAR2(5);
comment on column T765_TIPOQUOTE.CAUSALE_ASSESTAMENTO
  is 'Causale di assestamento da utilizzare nel calcolo della quota quantitativa';
ALTER TABLE T765_TIPOQUOTE ADD VP_INTERA VARCHAR2(6);
comment on column T765_TIPOQUOTE.VP_INTERA
  is 'Voce paga per la quota intera';
ALTER TABLE T765_TIPOQUOTE ADD VP_PROPORZIONATA VARCHAR2(6);
comment on column T765_TIPOQUOTE.VP_PROPORZIONATA
  is 'Voce paga per la quota proporzionata';
ALTER TABLE T765_TIPOQUOTE ADD VP_NETTA VARCHAR2(6);
comment on column T765_TIPOQUOTE.VP_NETTA
  is 'Voce paga per la quota netta';
ALTER TABLE T765_TIPOQUOTE ADD VP_NETTARISP VARCHAR2(6);
comment on column T765_TIPOQUOTE.VP_NETTARISP
  is 'Voce paga per la quota netta con risparmio';
ALTER TABLE T765_TIPOQUOTE ADD VP_RISPARMIO VARCHAR2(6);
comment on column T765_TIPOQUOTE.VP_RISPARMIO
  is 'Voce paga per la quota di risparmio';
ALTER TABLE T765_TIPOQUOTE ADD VP_NORISPARMIO VARCHAR2(6);
comment on column T765_TIPOQUOTE.VP_NORISPARMIO
  is 'Voce paga per la quota senza risparmio';
ALTER TABLE T765_TIPOQUOTE ADD VP_QUANTITATIVA VARCHAR2(6);
comment on column T765_TIPOQUOTE.VP_QUANTITATIVA
  is 'Voce paga per la quota quantitativa';
UPDATE T765_TIPOQUOTE SET DECORRENZA = TO_DATE('01011900','DDMMYYYY');
ALTER TABLE T765_TIPOQUOTE MODIFY DECORRENZA NOT NULL;
alter table T770_QUOTE drop constraint T770_FK_T765;
alter table T775_QUOTEINDIVIDUALI drop constraint T775_FK_T765;
alter table T765_TIPOQUOTE drop primary key;
drop index T765_PK/*--NOLOG--*/;

alter table T765_TIPOQUOTE
  add constraint T765_PK primary key (CODICE,DECORRENZA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
declare
  cursor c1 is
    select t.*, t.rowid from t765_tipoquote t;
  cursor c2 is
    select distinct decorrenza, quota_scaricopaghe
      from t760_20090504
     where tipo = 'C'
       and ((quota_scaricopaghe = '4' and decorrenza >= to_date('01012008','ddmmyyyy'))
        or (quota_scaricopaghe = '3' and decorrenza < to_date('01012008','ddmmyyyy')));
  conta integer;
begin
-- trasformazione regole esistenti per Incentivi in base a storicizzazione tipologie scarico paghe
  for t1 in c1 loop
    for t2 in c2 loop
        if t2.decorrenza = t1.decorrenza then
          if t2.quota_scaricopaghe = '3' then
            update t765_tipoquote
               set descrizione = substr(descrizione,1,30) || '-INCENTIVI',
                   VP_NETTA = DECODE(TIPOQUOTA,'A','A','S') || '#I'
             where rowid = t1.rowid;
          else
            update t765_tipoquote
               set descrizione = substr(descrizione,1,30) || '-INCENTIVI',
                   VP_NETTARISP = DECODE(TIPOQUOTA,'A','A','S') || '#I',
                   VP_RISPARMIO = DECODE(TIPOQUOTA,'A','A','S') || '#IR'
             where rowid = t1.rowid;
          end if;
        end if;
        if t2.decorrenza <> t1.decorrenza then
          if t2.quota_scaricopaghe = '3' then
            INSERT INTO T765_TIPOQUOTE (CODICE,DECORRENZA, DESCRIZIONE,TIPOQUOTA,VP_NETTA)
            VALUES (T1.CODICE,T2.DECORRENZA, SUBSTR(T1.DESCRIZIONE,1,30) || '-INCENTIVI', T1.TIPOQUOTA, DECODE(T1.TIPOQUOTA,'A','A','S') || '#I');
          else
            INSERT INTO T765_TIPOQUOTE (CODICE,DECORRENZA, DESCRIZIONE,TIPOQUOTA,VP_NETTARISP, VP_RISPARMIO)
            VALUES (T1.CODICE,T2.DECORRENZA, SUBSTR(T1.DESCRIZIONE,1,30) || '-INCENTIVI', T1.TIPOQUOTA, DECODE(T1.TIPOQUOTA,'A','A','S') || '#I', DECODE(T1.TIPOQUOTA,'A','A','S') || '#IR');
          end if;
        end if;
    end loop;
  end loop;
-- inserimento regole per Risorse in base a Incentivi
  for t1 in c1 loop
    INSERT INTO T765_TIPOQUOTE (CODICE,DECORRENZA,DESCRIZIONE,TIPOQUOTA, VP_NETTA, VP_NETTARISP, VP_RISPARMIO)
    VALUES (T1.CODICE || 'R', T1.DECORRENZA, REPLACE(T1.DESCRIZIONE,'-INCENTIVI','-RISORSE') , T1.TIPOQUOTA, REPLACE(T1.VP_NETTA,'#I','#R'), REPLACE(T1.VP_NETTARISP,'#I','#R'), REPLACE(T1.VP_RISPARMIO,'#I','#R'));
  end loop;
  COMMIT;
end;
/
declare
  cursor c1 is
    select distinct decorrenza, quota_scaricopaghe
      from t760_20090504
     where tipo = 'D'
       and ((quota_scaricopaghe = '4' and decorrenza >= to_date('01012008','ddmmyyyy'))
        or (quota_scaricopaghe = '3' and decorrenza < to_date('01012008','ddmmyyyy')));
begin
  for t1 in c1 loop
    if t1.quota_scaricopaghe = '3' then
      INSERT INTO T765_TIPOQUOTE (CODICE,DECORRENZA, DESCRIZIONE,TIPOQUOTA,VP_NETTA)
      VALUES ('A#D',T1.DECORRENZA, 'ACCONTO GIORNI UTILI', 'A', 'A#I');
    else
      INSERT INTO T765_TIPOQUOTE (CODICE,DECORRENZA, DESCRIZIONE,TIPOQUOTA,VP_NETTARISP, VP_RISPARMIO)
      VALUES ('A#D',T1.DECORRENZA, 'ACCONTO GIORNI UTILI', 'A', 'A#I', 'A#IR');
    end if;
  end loop;
end;
/
-- **************************   Quote    ************************************
CREATE TABLE T770_20090504 AS SELECT * FROM T770_QUOTE;
DROP TABLE T770_QUOTE;
create table T770_QUOTE
(
  DATO1        VARCHAR2(20) default ' ' not null,
  DATO2        VARCHAR2(20) default ' ' not null,
  DATO3        VARCHAR2(20) default ' ' not null,
  CODTIPOQUOTA VARCHAR2(5) not null,
  DECORRENZA   DATE not null,
  IMPORTO      NUMBER,
  NUM_ORE      VARCHAR2(6),
  PERC_INDIVIDUALE      NUMBER DEFAULT 0,
  PERC_STRUTTURALE      NUMBER DEFAULT 100
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
alter table T770_QUOTE
  add constraint T770_PK primary key (DATO1, DATO2, DATO3, CODTIPOQUOTA, DECORRENZA)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
comment on column T770_QUOTE.DATO1
  is 'Codice del primo dato anagrafico aziendale';
comment on column T770_QUOTE.DATO2
  is 'Codice del secondo dato anagrafico aziendale';
comment on column T770_QUOTE.DATO3
  is 'Codice del terzo dato anagrafico aziendale';
comment on column T770_QUOTE.CODTIPOQUOTA
  is 'Codice identificativo del tipo quota';
comment on column T770_QUOTE.DECORRENZA
  is 'Decorrenza';
comment on column T770_QUOTE.IMPORTO
  is 'Importo della quota';
comment on column T770_QUOTE.NUM_ORE
  is 'Numero di ore della quota quantitativa';
comment on column T770_QUOTE.PERC_INDIVIDUALE
  is 'Percentuale di incidenza della quota individuale';
comment on column T770_QUOTE.PERC_STRUTTURALE
  is 'Percentuale di incidenza della quota strutturale';
declare
  cursor c1 is select * from T770_20090504;
begin
  for t1 in c1 loop
    if t1.incentivi <> 0 then
      insert into T770_QUOTE (DATO1, DATO2, DATO3, CODTIPOQUOTA, DECORRENZA, IMPORTO)
      values (T1.DATO1, T1.DATO2, T1.DATO3, T1.CODTIPOQUOTA, T1.DECORRENZA, T1.INCENTIVI);
    end if;
    if t1.risorse <> 0 then
      insert into T770_QUOTE (DATO1, DATO2, DATO3, CODTIPOQUOTA, DECORRENZA, IMPORTO)
      values (T1.DATO1, T1.DATO2, T1.DATO3, T1.CODTIPOQUOTA || 'R', T1.DECORRENZA, T1.RISORSE);
    end if;
    COMMIT;
  end loop;
end;
/
-- *****************   Quote individuali   ************************************
CREATE TABLE T775_20090504 AS SELECT * FROM T775_QUOTEINDIVIDUALI;
DROP TABLE T775_QUOTEINDIVIDUALI;
create table T775_QUOTEINDIVIDUALI
(
  PROGRESSIVO    NUMBER(8) not null,
  DECORRENZA     DATE not null,
  SCADENZA       DATE,
  CODTIPOQUOTA   VARCHAR2(5) not null,
  IMPORTO        NUMBER,
  PENALIZZAZIONE NUMBER(5,2),
  SALTAPROVA     VARCHAR2(1) default 'N',
  NUM_ORE        VARCHAR2(6),
  PERC_INDIVIDUALE      NUMBER DEFAULT 100,
  PERC_STRUTTURALE      NUMBER DEFAULT 100,
  CONSIDERA_SALDO VARCHAR2(1) default 'S'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
alter table T775_QUOTEINDIVIDUALI
  add constraint T775_PK primary key (PROGRESSIVO, DECORRENZA, CODTIPOQUOTA)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
comment on column T775_QUOTEINDIVIDUALI.PROGRESSIVO
  is 'Progressivo del dipendente';
comment on column T775_QUOTEINDIVIDUALI.DECORRENZA
  is 'Decorrenza';
comment on column T775_QUOTEINDIVIDUALI.SCADENZA
  is 'Scadenza';
comment on column T775_QUOTEINDIVIDUALI.CODTIPOQUOTA
  is 'Codice identificativo del tipo quota';
comment on column T775_QUOTEINDIVIDUALI.IMPORTO
  is 'Importo della quota';
comment on column T775_QUOTEINDIVIDUALI.PENALIZZAZIONE
  is 'Percentuale di penalizzazione';
comment on column T775_QUOTEINDIVIDUALI.SALTAPROVA
  is 'Salta il periodo di prova';
comment on column T775_QUOTEINDIVIDUALI.NUM_ORE
  is 'Numero di ore della quota quantitativa';
comment on column T775_QUOTEINDIVIDUALI.PERC_INDIVIDUALE
  is 'Percentuale di retribuzione della quota individuale diversa da 100';
comment on column T775_QUOTEINDIVIDUALI.PERC_STRUTTURALE
  is 'Percentuale di retribuzione della quota strutturale diversa da 100';
comment on column T775_QUOTEINDIVIDUALI.CONSIDERA_SALDO
  is 'Considera nella distribuzione del saldo';
declare
  cursor c1 is select * from T775_20090504;
begin
  for t1 in c1 loop
    insert into T775_QUOTEINDIVIDUALI (PROGRESSIVO, DECORRENZA, SCADENZA, CODTIPOQUOTA, IMPORTO, PENALIZZAZIONE, SALTAPROVA)
    values (T1.PROGRESSIVO, T1.DECORRENZA, T1.SCADENZA, T1.CODTIPOQUOTA, T1.INCENTIVI, T1.PENALIZZAZIONE, T1.SALTAPROVA);
    insert into T775_QUOTEINDIVIDUALI (PROGRESSIVO, DECORRENZA, SCADENZA, CODTIPOQUOTA, IMPORTO, PENALIZZAZIONE, SALTAPROVA)
    values (T1.PROGRESSIVO, T1.DECORRENZA, T1.SCADENZA, T1.CODTIPOQUOTA || 'R', T1.RISORSE, T1.PENALIZZAZIONE, T1.SALTAPROVA);
    COMMIT;
  end loop;
end;
/
-- ********************   Quote maturate   ************************************
CREATE TABLE T762_20090504 AS SELECT * FROM T762_INCENTIVIMATURATI;
DROP TABLE T762_INCENTIVIMATURATI;
create table T762_INCENTIVIMATURATI
(
  PROGRESSIVO NUMBER not null,
  ANNO        NUMBER not null,
  MESE        NUMBER not null,
  CODTIPOQUOTA   VARCHAR2(5) not null,
  TIPOIMPORTO    VARCHAR2(5) not null,
  IMPORTO        NUMBER,
  VARIAZIONI     NUMBER DEFAULT 0,
  GIORNI_ORE     NUMBER,
  TIPOCALCOLO    VARCHAR2(1)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column T762_INCENTIVIMATURATI.PROGRESSIVO
  is 'Progressivo dipendente';
comment on column T762_INCENTIVIMATURATI.ANNO
  is 'Anno di riferimento';
comment on column T762_INCENTIVIMATURATI.MESE
  is 'Mese di riferimento';
comment on column T762_INCENTIVIMATURATI.CODTIPOQUOTA
  is 'Codice quota';
comment on column T762_INCENTIVIMATURATI.TIPOIMPORTO
  is 'Tipologia di importo (intera,proporzionata,netta)';
comment on column T762_INCENTIVIMATURATI.IMPORTO
  is 'Importo quota';
comment on column T762_INCENTIVIMATURATI.VARIAZIONI
  is 'Variazioni manuali della quota';
comment on column T762_INCENTIVIMATURATI.GIORNI_ORE
  is 'Giorni/ore di maturazione';
comment on column T762_INCENTIVIMATURATI.TIPOCALCOLO
  is 'Tipologia di calcolo (C o D)';
alter table T762_INCENTIVIMATURATI
  add constraint T762_PK primary key (PROGRESSIVO, ANNO, MESE, CODTIPOQUOTA, TIPOIMPORTO)
  using index
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
declare
  cursor c1 is select * from t762_20090504;
begin
  for t1 in c1 loop
    insert into T762_INCENTIVIMATURATI (PROGRESSIVO, ANNO, MESE, CODTIPOQUOTA, TIPOIMPORTO, IMPORTO, VARIAZIONI, GIORNI_ORE, TIPOCALCOLO)
    values (T1.PROGRESSIVO, T1.ANNO, T1.MESE, T1.TIPOQUOTA, T1.TIPOIMPORTO, T1.QUOTA, T1.VARIAZIONI, T1.GIORNI, T1.TIPO);
    insert into T762_INCENTIVIMATURATI (PROGRESSIVO, ANNO, MESE, CODTIPOQUOTA, TIPOIMPORTO, IMPORTO, VARIAZIONI, GIORNI_ORE, TIPOCALCOLO)
    values (T1.PROGRESSIVO, T1.ANNO, T1.MESE, T1.TIPOQUOTA || 'R', T1.TIPOIMPORTO, T1.RISORSE, T1.VAR_RISORSE, T1.GIORNI, T1.TIPO);
    COMMIT;
  end loop;
end;
/
-- ***********   Trasformazione T193, T195   *********************************
CREATE TABLE T193_20090504 AS SELECT * FROM T193_VOCIPAGHE_PARAMETRI;
declare
  cursor c1 is
    select t190.codinterno, t193.*, t193.rowid
      from t190_interfacciapaghe t190, t193_vocipaghe_parametri t193
     where t190.codinterno in ('240','241','242','243','245','246','247','248')
       and t190.flag = 'S'
       and t190.codice = t193.cod_interfaccia
       and t190.voce_paghe = t193.voce_paghe
     order by codice, codinterno;
  numriga varchar2(50);
begin
  numriga:='';
  for t1 in c1 loop
    if numriga <> t1.rowid then
      update t193_vocipaghe_parametri
         set voce_paghe = decode(t1.codinterno,'240','A#I','241','S#I','242','A#R','243','S#R','245','A#IR','246','S#IR','247','A#RR','248','S#RR')
       where rowid = t1.rowid;
    else
      insert into t193_vocipaghe_parametri
      (cod_interfaccia, voce_paghe, decorrenza, voce_paghe_cedolino, voce_paghe_negativa,
       descrizione, dal, al, autoinc_dal, autoinc_al, arrotondamento)
      values
      (t1.cod_interfaccia, decode(t1.codinterno,'240','A#I','241','S#I','242','A#R','243','S#R','245','A#IR','246','S#IR','247','A#RR','248','S#RR'),
       t1.decorrenza, t1.voce_paghe_cedolino, t1.voce_paghe_negativa,
       t1.descrizione, t1.dal, t1.al, t1.autoinc_dal, t1.autoinc_al, t1.arrotondamento);
    end if;
    COMMIT;
    numriga:=t1.rowid;
  end loop;
end;
/
-- 240->Incentivi 242->Quota quantitativa 244->Penalizzazioni
CREATE TABLE T195_20090504 AS SELECT * FROM T195_VOCIVARIABILI;
UPDATE T195_VOCIVARIABILI SET COD_INTERNO = '240' WHERE COD_INTERNO = '241';
UPDATE T195_VOCIVARIABILI SET COD_INTERNO = '240' WHERE COD_INTERNO = '242';
UPDATE T195_VOCIVARIABILI SET COD_INTERNO = '240' WHERE COD_INTERNO = '243';
UPDATE T195_VOCIVARIABILI SET COD_INTERNO = '240' WHERE COD_INTERNO = '245';
UPDATE T195_VOCIVARIABILI SET COD_INTERNO = '240' WHERE COD_INTERNO = '246';
UPDATE T195_VOCIVARIABILI SET COD_INTERNO = '240' WHERE COD_INTERNO = '247';
UPDATE T195_VOCIVARIABILI SET COD_INTERNO = '240' WHERE COD_INTERNO = '248';
COMMIT;

CREATE TABLE T190_20090504 AS SELECT * FROM T190_INTERFACCIAPAGHE;
DELETE FROM T190_INTERFACCIAPAGHE WHERE CODINTERNO IN ('241','243','245','246','247','248');
UPDATE T190_INTERFACCIAPAGHE SET VOCE_PAGHE = '' WHERE CODINTERNO IN ('240','242');
UPDATE T190_INTERFACCIAPAGHE SET FLAG = 'N' WHERE CODINTERNO = '242';
COMMIT;

ALTER TABLE T765_TIPOQUOTE ADD ACCONTI VARCHAR2(20);
comment on column T765_TIPOQUOTE.ACCONTI
  is 'Acconti di riferimento per il calcolo del saldo C';

DECLARE
  CURSOR C1 IS
    SELECT T.*, T.ROWID
      FROM T765_TIPOQUOTE T
     WHERE TIPOQUOTA IN ('C')
       AND DESCRIZIONE LIKE '%-INCENTIVI';
  CURSOR C2 IS
    SELECT DISTINCT CODICE
      FROM T765_TIPOQUOTE
     WHERE TIPOQUOTA = 'A'
       AND DESCRIZIONE LIKE '%-INCENTIVI';
  S VARCHAR2(20);
BEGIN
  S:='';
  FOR T2 IN C2 LOOP
    IF S IS NOT NULL THEN
      S:=S || ',';
    END IF;
    S:=S || T2.CODICE;
  END LOOP;
  FOR T1 IN C1 LOOP
    UPDATE T765_TIPOQUOTE
       SET ACCONTI = S
     WHERE ROWID = T1.ROWID;
    COMMIT;
  END LOOP;
END;
/
DECLARE
  CURSOR C1 IS
    SELECT T.*, T.ROWID
      FROM T765_TIPOQUOTE T
     WHERE TIPOQUOTA IN ('C')
       AND DESCRIZIONE LIKE '%-RISORSE';
  CURSOR C2 IS
    SELECT DISTINCT CODICE
      FROM T765_TIPOQUOTE
     WHERE TIPOQUOTA = 'A'
       AND DESCRIZIONE LIKE '%-RISORSE';
  S VARCHAR2(20);
BEGIN
  S:='';
  FOR T2 IN C2 LOOP
    IF S IS NOT NULL THEN
      S:=S || ',';
    END IF;
    S:=S || T2.CODICE;
  END LOOP;
  FOR T1 IN C1 LOOP
    UPDATE T765_TIPOQUOTE
       SET ACCONTI = S
     WHERE ROWID = T1.ROWID;
    COMMIT;
  END LOOP;
END;
/
ALTER TABLE T769_INCENTIVIASSENZE ADD ASSENZE_AGGIUNTIVE VARCHAR2(100);
comment on column T769_INCENTIVIASSENZE.ASSENZE_AGGIUNTIVE
  is 'Assenze aggiuntive che rientrano nella franchigia';

ALTER TABLE T775_QUOTEINDIVIDUALI ADD PERCENTUALE NUMBER DEFAULT 100;
comment on column T775_QUOTEINDIVIDUALI.PERCENTUALE
  is 'Percentuale di proporzionamento quota incentivante';

ALTER TABLE T769_INCENTIVIASSENZE MODIFY GESTIONE_FRANCHIGIA DEFAULT 'A';
UPDATE T769_INCENTIVIASSENZE SET GESTIONE_FRANCHIGIA = 'A' WHERE GESTIONE_FRANCHIGIA = 'Z';

-- *************************** FINE INCENTIVI ******************************

create table T555_TIPOAPPARATI
(
  CODICE      VARCHAR2(5) not null,
  DESCRIZIONE VARCHAR2(40)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

alter table T555_TIPOAPPARATI
  add constraint T555_PK primary key (CODICE)
  using index tablespace INDICI storage(initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

alter table T550_APPARATI
  add constraint T550_FK_T555 foreign key (COD_APPARATO) references T555_TIPOAPPARATI (CODICE)/*--NOLOG--*/;

alter table T265_CAUASSENZE add RAPPORTI_UNITI varchar2(1) default 'A';
comment on column T265_CAUASSENZE.RAPPORTI_UNITI is 'A=come da Anagrafico, S=Rapporti uniti, N=Rapporti non uniti';

alter table T262_PROFASSANN add RAPPORTI_UNITI varchar2(1) default 'A';
comment on column T262_PROFASSANN.RAPPORTI_UNITI is 'A=come da Anagrafico, S=Rapporti uniti, N=Rapporti non uniti';

alter table T263_PROFASSIND add RAPPORTI_UNITI varchar2(1) default 'P';
comment on column T263_PROFASSIND.RAPPORTI_UNITI is 'A=come da Anagrafico, S=Rapporti uniti, N=Rapporti non uniti';

UPDATE P044_ENTIIRPEFFASCE T SET T.IMPORTO_DA=15000.01
WHERE T.TIPO_ADDIZIONALE='R' AND T.COD_ENTE='06' AND T.IMPORTO_DA=15001.01;

alter table SG101_FAMILIARI add DATANAS_PRESUNTA date;
update SG101_FAMILIARI set DATANAS_PRESUNTA = DATANAS;

alter table T265_CAUASSENZE add MATERNITA_OBBL varchar2(1) default 'N';
comment on column T265_CAUASSENZE.MATERNITA_OBBL is 'S=il periodo giustificato con questa causale può essere esteso se la data di nascita viene posticipata rispetto alla data presunta';

ALTER TABLE P215_CODICIACCORPAMENTOVOCI
MODIFY COD_CODICIACCORPAMENTOVOCI VARCHAR2(15);

ALTER TABLE P216_ACCORPAMENTOVOCI
MODIFY COD_CODICIACCORPAMENTOVOCI VARCHAR2(15);

ALTER TABLE P284_IMPORTIRETR
MODIFY COD_CODICIACCORPAMENTOVOCI VARCHAR2(15);

ALTER TABLE P092_CODICIINAIL
MODIFY (COD_ACCORP_RETR_TABELL VARCHAR2(30),COD_ACCORP_STR VARCHAR2(30));

alter table T275_CAUPRESENZE add E_IN_FLESSIBILITA varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.E_IN_FLESSIBILITA is 'Solo per causali in entrata posticipata, orari flessibili continuati e turni - S=l’entrata viene spostata al punto nominale aumentato della flessibilità disponibile';

alter table T275_CAUPRESENZE add AUTOGIUST_DALLEALLE varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.AUTOGIUST_DALLEALLE is 'N=il giustificativo di assenza viene inserito nella forma num.ore, S=il giustificativo di assenza viene inserito nella forma dalle..alle';

alter table T265_CAUASSENZE add TIMB_PM_DETRAZ varchar2(1) default 'N';
comment on column T265_CAUASSENZE.TIMB_PM_DETRAZ is 'S=il giustificativo fruito come dalle..alle può essere abbattuto dalla detrazione pausa mensa se interseca la fascia PMT';

alter table T275_CAUPRESENZE add COMP_CAUS_OREMAX varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.COMP_CAUS_OREMAX is 'S=le competenze maturate per le causali con tipo cumulo=S sono limitate al debito gg';

create table T268_CONCAT_PERIODI_GGNONLAV
(
  COD_OLD VARCHAR2(5),
  COD_NEW VARCHAR2(5),
  COD_INS VARCHAR2(5)
)
tablespace LAVORO storage(initial 256K next 256K pctincrease 0);
CREATE TABLE I005_MSGINFO (
     ID NUMBER(38),
     DATA DATE,
     MASCHERA VARCHAR2(10),
     AZIENDA VARCHAR2(30),
     OPERATORE VARCHAR(30))
TABLESPACE LAVORO STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

ALTER TABLE I005_MSGINFO
  ADD CONSTRAINT I005_UQ UNIQUE (ID)
USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

CREATE TABLE I006_MSGDATI(
    ID NUMBER(38),
    AZIENDA_MSG VARCHAR2(30),
    DATA_MSG DATE,
    TIPO VARCHAR2(1),
    MSG VARCHAR2(2000),
    PROGRESSIVO NUMBER(8)
) TABLESPACE LAVORO
STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

alter table I006_MSGDATI add constraint I005_FK_I006 foreign key (ID) references I005_MSGINFO (ID) on delete cascade;

create sequence I005_ID minvalue 1 start with 1 increment by 1 nocache;

comment on column I006_MSGDATI.TIPO is  'A=anomalia, I=informazione, B=riepiloghi bloccati';

UPDATE P552_CONTOANNREGOLE T
SET T.REGOLA_CALCOLO_MANUALE=
REPLACE(T.REGOLA_CALCOLO_MANUALE,'T043.COD_TIPOACCORPAMENTOASS = ''T11''','T043.COD_TIPOACCORPAMENTOASS = ''T11'' AND T043.COD_CODICIACCORPAMENTOASS<>''H''')
WHERE T.COD_TABELLA='TRIM01' AND T.RIGA=0 AND T.COLONNA=5 AND T.ANNO>=2008
AND T.REGOLA_CALCOLO_MANUALE LIKE '%T043.COD_TIPOACCORPAMENTOASS = ''T11''%'
AND T.REGOLA_CALCOLO_MANUALE NOT LIKE '%T043.COD_CODICIACCORPAMENTOASS<>''H''%';

UPDATE P004_CODICITABANNUALI T SET T.DESCRIZIONE='Ingresso per passaggio da altra Pubblica Amministrazione'
WHERE T.COD_TABANNUALE='ONTIPASSUN' AND T.ANNO=2009 AND T.COD_CODICITABANNUALI='1';
UPDATE P004_CODICITABANNUALI T SET T.DESCRIZIONE='Ingresso generico (per ogni altra causa diversa dalla precedente)'
WHERE T.COD_TABANNUALE='ONTIPASSUN' AND T.ANNO=2009 AND T.COD_CODICITABANNUALI='2';

UPDATE P004_CODICITABANNUALI T SET T.DESCRIZIONE='Uscita per quiescienza o passaggio a libera professione o dimissioni'
WHERE T.COD_TABANNUALE='ONTIPCESS' AND T.ANNO=2009 AND T.COD_CODICITABANNUALI='3';
UPDATE P004_CODICITABANNUALI T SET T.DESCRIZIONE='Uscita per passaggio ad altra Pubblica Amministrazione'
WHERE T.COD_TABANNUALE='ONTIPCESS' AND T.ANNO=2009 AND T.COD_CODICITABANNUALI='5';
UPDATE P004_CODICITABANNUALI T SET T.DESCRIZIONE='Uscita per invalidita'' o per inabilita'''
WHERE T.COD_TABANNUALE='ONTIPCESS' AND T.ANNO=2009 AND T.COD_CODICITABANNUALI='6';

alter table T002_QUERYPERSONALIZZATE modify POSIZ NUMBER(3);

alter table T911_DATIRIEPILOGO add CONV_VALUTA varchar2(1) default 'N';
comment on column T911_DATIRIEPILOGO.CONV_VALUTA is 'S=Indica se il dato è da convertire nella valuta specificata su Codici Serbatoio';

-- CREAZIONE NUOVI IMPORTI 730

update p260_mod730tipoimporti t set t.ordine_pagamento_incapiente=15
where t.anno=2009 and t.cod_tipoimporto='2ID';
update p260_mod730tipoimporti t set t.ordine_pagamento_incapiente=16
where t.anno=2009 and t.cod_tipoimporto='2IC';
insert into P260_MOD730TIPOIMPORTI
select anno, 'TSD', 'Imposta sost. lavoro straor. dichiarante', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11840', cod_voce_speciale, int_rate, '11841', cod_voce_speciale_int_rate, int_ritardo, '11842', cod_voce_speciale_int_ritardo, 13, attribuzione_dimessi
from p260_mod730tipoimporti t where t.anno=2009 and t.cod_tipoimporto='TTD' and not exists
(select 'X' from p260_mod730tipoimporti v where v.anno=2009 and v.cod_tipoimporto='TSD');
insert into P260_MOD730TIPOIMPORTI
select anno, 'TSC', 'Imposta sost. lavoro straor. coniuge', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11845', cod_voce_speciale, int_rate, '11846', cod_voce_speciale_int_rate, int_ritardo, '11847', cod_voce_speciale_int_ritardo, 14, attribuzione_dimessi
from p260_mod730tipoimporti t where t.anno=2009 and t.cod_tipoimporto='TTC' and not exists
(select 'X' from p260_mod730tipoimporti v where v.anno=2009 and v.cod_tipoimporto='TSC');


-- CREAZIONE NUOVE VOCI 730

declare
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin

-----
-- Inizio Trattenuta lavoro straor. dichiar. 730
-----

CodVoceModello:='11800';
CodVoceCopia:='11840';
DesVoceCopia:='Trattenuta lavoro straor. dichiar. 730';
DesVoceCopiaSt:='Trattenuta lavoro straor. dichiar. 730';

SELECT NVL(MAX(T.ID_VOCE),-1) INTO ID_P200 FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='BASE';

IF ID_P200 = -1 THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  INSERT INTO P201_ASSOGGETTAMENTI
  select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
  where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';
END IF;

-----
-- Fine Trattenuta lavoro straor. dichiar. 730
-----

-----
-- Inizio Int.rateizz.tratt.lavoro str.dichiar.730
-----

CodVoceModello:='11801';
CodVoceCopia:='11841';
DesVoceCopia:='Int.rateizz.tratt.lavoro str.dichiar.730';
DesVoceCopiaSt:='Int.rateizz.tratt.lavoro str.dichiar.730';

SELECT NVL(MAX(T.ID_VOCE),-1) INTO ID_P200 FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='BASE';

IF ID_P200 = -1 THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  INSERT INTO P201_ASSOGGETTAMENTI
  select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
  where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';
END IF;

-----
-- Fine Int.rateizz.tratt.lavoro str.dichiar.730
-----

-----
-- Inizio Int.ritardo tratt.lavoro str.dichiar.730
-----

CodVoceModello:='11802';
CodVoceCopia:='11842';
DesVoceCopia:='Int.ritardo tratt.lavoro str.dichiar.730';
DesVoceCopiaSt:='Int.ritardo tratt.lavoro str.dichiar.730';

SELECT NVL(MAX(T.ID_VOCE),-1) INTO ID_P200 FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='BASE';

IF ID_P200 = -1 THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  INSERT INTO P201_ASSOGGETTAMENTI
  select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
  where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';
END IF;

-----
-- Fine Int.ritardo tratt.lavoro str.dichiar.730
-----

-----
-- Inizio Trattenuta lavoro straor. coniuge 730
-----

CodVoceModello:='11800';
CodVoceCopia:='11845';
DesVoceCopia:='Trattenuta lavoro straor. coniuge 730';
DesVoceCopiaSt:='Trattenuta lavoro straor. coniuge 730';

SELECT NVL(MAX(T.ID_VOCE),-1) INTO ID_P200 FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='BASE';

IF ID_P200 = -1 THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  INSERT INTO P201_ASSOGGETTAMENTI
  select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
  where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';
END IF;

-----
-- Fine Trattenuta lavoro straor. coniuge 730
-----

-----
-- Inizio Int.rateizz.tratt.lavoro str.coniuge 730
-----

CodVoceModello:='11801';
CodVoceCopia:='11846';
DesVoceCopia:='Int.rateizz.tratt.lavoro str.coniuge 730';
DesVoceCopiaSt:='Int.rateizz.tratt.lavoro str.coniuge 730';

SELECT NVL(MAX(T.ID_VOCE),-1) INTO ID_P200 FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='BASE';

IF ID_P200 = -1 THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  INSERT INTO P201_ASSOGGETTAMENTI
  select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
  where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';
END IF;

-----
-- Fine Int.rateizz.tratt.lavoro str.coniuge 730
-----

-----
-- Inizio Int.ritardo tratt.lavoro str.coniuge 730
-----

CodVoceModello:='11802';
CodVoceCopia:='11847';
DesVoceCopia:='Int.ritardo tratt.lavoro str.coniuge 730';
DesVoceCopiaSt:='Int.ritardo tratt.lavoro str.coniuge 730';

SELECT NVL(MAX(T.ID_VOCE),-1) INTO ID_P200 FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='BASE';

IF ID_P200 = -1 THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  INSERT INTO P201_ASSOGGETTAMENTI
  select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
  where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';
END IF;

-----
-- Fine Int.ritardo tratt.lavoro str.coniuge 730
-----

end;

/

