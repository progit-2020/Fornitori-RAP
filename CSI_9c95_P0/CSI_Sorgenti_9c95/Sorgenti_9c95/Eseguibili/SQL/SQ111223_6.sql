alter table P500_CUDSETUP add CODICE_AZIENDA_INPGI VARCHAR2(5);
comment on column P500_CUDSETUP.CODICE_AZIENDA_INPGI
  is 'Codice INPGI dell''azienda';

-----
-- F24EP con gestione INPGI
-----

declare
  i integer;
begin
  select COUNT(*) into i from P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP' and t.parte='E';
  if i > 0 then
     DELETE P660_FLUSSIREGOLE t where t.Nome_Flusso='F24EP' and t.parte='P';

insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'P', '001', 'INPGI dipendenti', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, '''' CODICE, COD_AZIENDA ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''P'' TIPO_RIGA, SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,10) COD_TRIBUTO,' || chr(10) || '  (SELECT P500.CODICE_AZIENDA_INPGI FROM P500_CUDSETUP P500' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))' || chr(10) || '  COD_AZIENDA,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO*P216.PERCENTUALE/100) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P442.ID_VOCE = P200.ID_VOCE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P216.COD_CONTRATTO = P200.COD_CONTRATTO AND P216.COD_VOCE = P200.COD_VOCE AND P216.COD_VOCE_SPECIALE = P200.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''CU770'' AND SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,1,9) = ''F24INPGI-''' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'AND PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO, P216.COD_CODICIACCORPAMENTOVOCI' || chr(10) || 'HAVING SUM(P442.IMPORTO*P216.PERCENTUALE/100) <> 0' || chr(10) || ')', 'SELECT TIPO_RIGA, COD_TRIBUTO, '''' CODICE, COD_AZIENDA ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''P'' TIPO_RIGA, SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,10) COD_TRIBUTO,' || chr(10) || '  (SELECT P500.CODICE_AZIENDA_INPGI FROM P500_CUDSETUP P500' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))' || chr(10) || '  COD_AZIENDA,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO*P216.PERCENTUALE/100) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200, P216_ACCORPAMENTOVOCI P216' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P442.ID_VOCE = P200.ID_VOCE' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P216.COD_CONTRATTO = P200.COD_CONTRATTO AND P216.COD_VOCE = P200.COD_VOCE AND P216.COD_VOCE_SPECIALE = P200.COD_VOCE_SPECIALE' || chr(10) || 'AND P442.DATA_COMPETENZA_A BETWEEN P216.DECORRENZA AND P216.DECORRENZA_FINE' || chr(10) || 'AND P216.COD_TIPOACCORPAMENTOVOCI = ''CU770'' AND SUBSTR(P216.COD_CODICIACCORPAMENTOVOCI,1,9) = ''F24INPGI-''' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'AND PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO, P216.COD_CODICIACCORPAMENTOVOCI' || chr(10) || 'HAVING SUM(P442.IMPORTO*P216.PERCENTUALE/100) <> 0' || chr(10) || ')', 'N', null, null, null, null, null, null, null);

update p660_flussiregole t set t.regola_calcolo_automatica=t.regola_calcolo_manuale where t.Nome_Flusso='F24EP';

  end if;
end;
/

insert into P215_CODICIACCORPAMENTOVOCI
select 'CU770', 'F24INPGI-C001', 'Contributi obbligatori correnti INPGI' from DUAL
where exists (select 'x' from P214_TIPOACCORPAMENTOVOCI P214
              where P214.COD_TIPOACCORPAMENTOVOCI='CU770')
and not exists (select 'x' from P215_CODICIACCORPAMENTOVOCI P215
                where P215.COD_TIPOACCORPAMENTOVOCI='CU770' and P215.COD_CODICIACCORPAMENTOVOCI='F24INPGI-C001');
                
--------------------------                
-- TORINO_ITC pensioni
--------------------------

create table P292_MEMBER
( PROGRESSIVO            NUMBER not null,
  ANNO                   NUMBER not null,
  CHIUSO                 VARCHAR2(1) default 'N' not null,
  COUNTRYCODE            VARCHAR2(3),
  PERSONALNO             VARCHAR2(6),
  GRADE                  VARCHAR2(6),
  STEP                   VARCHAR2(2),
  PENSIONNO              VARCHAR2(8),
  CATEGORY               VARCHAR2(1),
  CLASS                  VARCHAR2(1) default '$' not null,
  SURNAME                VARCHAR2(20),
  DATEENTRY              DATE,
  DATEDEPARTURE          DATE,
  OFFICENUMBER           VARCHAR2(2),
  LANGUAGEALLOWANCE      NUMBER default 0 not null,
  LASTUPDATED            DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P292_MEMBER.CHIUSO is 'Chiuso (S/N) se il periodo e'' stato chiuso';
comment on column P292_MEMBER.COUNTRYCODE is 'Codice paese: 497=Paese dei dip. con CONTRACT ''P'', 498=Paese dei dip. con CONTRACT ''G'')';
comment on column P292_MEMBER.PERSONALNO is 'Matricola dipendente preceduta da 7';
comment on column P292_MEMBER.GRADE is 'Posizione economica';
comment on column P292_MEMBER.STEP is 'Livello';
comment on column P292_MEMBER.PENSIONNO is 'Matricola pensionistica dipendente (UNJSPF code)';
comment on column P292_MEMBER.SURNAME is 'Cognome e nome dipendente';
comment on column P292_MEMBER.DATEENTRY is 'Data di inizio iscrizione alla pensione';
comment on column P292_MEMBER.DATEDEPARTURE is 'Data di fine iscrizione alla pensione';
comment on column P292_MEMBER.LANGUAGEALLOWANCE is 'Conoscenza lingue';
comment on column P292_MEMBER.LASTUPDATED is 'Ultimo aggiornamento';

alter table P292_MEMBER
  add constraint P292_PK primary key (PROGRESSIVO, ANNO)
  using index tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table P292_MEMBER
  add constraint P292_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

create table P293_CONTRIBUTION
( PROGRESSIVO            NUMBER not null,
  ANNO                   NUMBER not null,
  CHIUSO                 VARCHAR2(1) default 'N' not null,
  PERSONALNO             VARCHAR2(6),
  PAYROLLMONTH           DATE,
  CURRENCYCODE           VARCHAR2(3),
  AMOUNT                 NUMBER,
  CALCULATEDAMOUNT       NUMBER default 0 not null,
  DIFFERENCE             NUMBER default 0 not null,
  AMOUNTDOL              NUMBER default 0 not null,
  CALCULATEDAMOUNTDOL    NUMBER default 0 not null,
  DIFFERENCEDOL          NUMBER default 0 not null,
  RATE                   NUMBER default 0 not null,
  YEARREPORTED           DATE,
  LASTUPDATED            DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P293_CONTRIBUTION.CHIUSO is 'Chiuso (S/N) se il periodo e'' stato chiuso';
comment on column P293_CONTRIBUTION.PERSONALNO is 'Matricola dipendente preceduta da 7';
comment on column P293_CONTRIBUTION.PAYROLLMONTH is 'Mese di competenza';
comment on column P293_CONTRIBUTION.CURRENCYCODE is 'Codice valuta per i calcoli del cedolino: 401=euro nella valuta utilizzata, 252=dollari';
comment on column P293_CONTRIBUTION.AMOUNT is 'Importo ritenuta';
comment on column P293_CONTRIBUTION.YEARREPORTED is 'Inizio anno';
comment on column P293_CONTRIBUTION.LASTUPDATED is 'Ultimo aggiornamento';

alter table P293_CONTRIBUTION
  add constraint P293_PK primary key (PROGRESSIVO, ANNO, PAYROLLMONTH)
  using index tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table P293_CONTRIBUTION
  add constraint P293_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);
alter table P293_CONTRIBUTION
  add constraint P293_FK_P292 foreign key (PROGRESSIVO,ANNO)
  references P292_MEMBER (PROGRESSIVO,ANNO);

create table P294_RETROACTIVEDETAIL
( PROGRESSIVO            NUMBER not null,
  ANNO                   NUMBER not null,
  CHIUSO                 VARCHAR2(1) default 'N' not null,
  PERSONALNO             VARCHAR2(6),
  PAYROLLMONTH           DATE,
  DATEFROM               DATE,
  DATETO                 DATE,
  CURRENCYCODE           VARCHAR2(3),
  RETROAMOUNT            NUMBER,
  RETROAMOUNTLPS         NUMBER default 0 not null,
  RETROAMOUNTDOL         NUMBER default 0 not null,
  RETROAMOUNTDOLLPS      NUMBER default 0 not null,
  RETRORATE              NUMBER default 0 not null,
  YEARREPORTED           DATE,
  LASTUPDATED            DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P294_RETROACTIVEDETAIL.CHIUSO is 'Chiuso (S/N) se il periodo e'' stato chiuso';
comment on column P294_RETROACTIVEDETAIL.PERSONALNO is 'Matricola dipendente preceduta da 7';
comment on column P294_RETROACTIVEDETAIL.PAYROLLMONTH is 'Mese cedolino';
comment on column P294_RETROACTIVEDETAIL.DATEFROM is 'Inizio competenza';
comment on column P294_RETROACTIVEDETAIL.DATETO is 'Fine competenza';
comment on column P294_RETROACTIVEDETAIL.CURRENCYCODE is 'Codice valuta per i calcoli del cedolino: 401=euro nella valuta utilizzata, 252=dollari';
comment on column P294_RETROACTIVEDETAIL.RETROAMOUNT is 'Importo ritenuta';
comment on column P294_RETROACTIVEDETAIL.YEARREPORTED is 'Inizio anno';
comment on column P294_RETROACTIVEDETAIL.LASTUPDATED is 'Ultimo aggiornamento';

alter table P294_RETROACTIVEDETAIL
  add constraint P294_PK primary key (PROGRESSIVO, ANNO, PAYROLLMONTH, DATEFROM)
  using index tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table P294_RETROACTIVEDETAIL
  add constraint P294_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);
alter table P294_RETROACTIVEDETAIL
  add constraint P294_FK_P292 foreign key (PROGRESSIVO,ANNO)
  references P292_MEMBER (PROGRESSIVO,ANNO);

create table P295_LEAVEWITHOUTPAY
( PROGRESSIVO            NUMBER not null,
  ANNO                   NUMBER not null,
  CHIUSO                 VARCHAR2(1) default 'N' not null,
  PERSONALNO             VARCHAR2(6),
  SEQUENCENO             NUMBER,
  DATEFROM               DATE,
  DATETO                 DATE,
  PERCENTAGE             NUMBER,
  LEAVECODE              VARCHAR2(1),
  YEARREPORTED           DATE,
  LASTUPDATED            DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P295_LEAVEWITHOUTPAY.CHIUSO is 'Chiuso (S/N) se il periodo e'' stato chiuso';
comment on column P295_LEAVEWITHOUTPAY.PERSONALNO is 'Matricola dipendente preceduta da 7';
comment on column P295_LEAVEWITHOUTPAY.SEQUENCENO is 'Numero progressivo all''interno della stessa matricola';
comment on column P295_LEAVEWITHOUTPAY.DATEFROM is 'Inizio evento';
comment on column P295_LEAVEWITHOUTPAY.DATETO is 'Fine evento';
comment on column P295_LEAVEWITHOUTPAY.PERCENTAGE is 'Percentuale di part-time se leave code=4, 0 negli altri casi';
comment on column P295_LEAVEWITHOUTPAY.LEAVECODE is 'Codice evento: 4, 6, J (LEAVE code)';
comment on column P295_LEAVEWITHOUTPAY.YEARREPORTED is 'Inizio anno';
comment on column P295_LEAVEWITHOUTPAY.LASTUPDATED is 'Ultimo aggiornamento';

alter table P295_LEAVEWITHOUTPAY
  add constraint P295_PK primary key (PROGRESSIVO, ANNO,SEQUENCENO)
  using index tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table P295_LEAVEWITHOUTPAY
  add constraint P295_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);
alter table P295_LEAVEWITHOUTPAY
  add constraint P295_FK_P292 foreign key (PROGRESSIVO,ANNO)
  references P292_MEMBER (PROGRESSIVO,ANNO);

create table P296_PENSIONABLESALARY
( PROGRESSIVO            NUMBER not null,
  ANNO                   NUMBER not null,
  CHIUSO                 VARCHAR2(1) default 'N' not null,
  PERSONALNO             VARCHAR2(6),
  EFFECTIVEDATE          DATE,
  PENSIONAMOUNT          NUMBER,
  CURRENCYCODE           VARCHAR2(3),
  YEARREPORTED           DATE,
  YEAROPENINGSALARY      DATE,
  PERCENTAGE             NUMBER,
  RATE                   NUMBER,
  PENSIONAMOUNTDOL       NUMBER,
  GRADE                  VARCHAR2(6),
  STEP                   VARCHAR2(2),
  LANGUAGEALLOWANCE      NUMBER default 0 not null,
  LASTUPDATED            DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P296_PENSIONABLESALARY.CHIUSO is 'Chiuso (S/N) se il periodo e'' stato chiuso';
comment on column P296_PENSIONABLESALARY.PERSONALNO is 'Matricola dipendente preceduta da 7';
comment on column P296_PENSIONABLESALARY.EFFECTIVEDATE is 'Data evento';
comment on column P296_PENSIONABLESALARY.PENSIONAMOUNT is 'Imponibile pensionistico annuale';
comment on column P296_PENSIONABLESALARY.CURRENCYCODE is 'Codice valuta per i calcoli del cedolino: 401=euro nella valuta utilizzata, 252=dollari';
comment on column P296_PENSIONABLESALARY.YEARREPORTED is 'Inizio anno';
comment on column P296_PENSIONABLESALARY.GRADE is 'Posizione economica';
comment on column P296_PENSIONABLESALARY.STEP is 'Livello';
comment on column P296_PENSIONABLESALARY.LANGUAGEALLOWANCE is 'Conoscenza lingue';
comment on column P296_PENSIONABLESALARY.LASTUPDATED is 'Ultimo aggiornamento';

alter table P296_PENSIONABLESALARY
  add constraint P296_PK primary key (PROGRESSIVO, ANNO,EFFECTIVEDATE,YEARREPORTED)
  using index tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table P296_PENSIONABLESALARY
  add constraint P296_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);
alter table P296_PENSIONABLESALARY
  add constraint P296_FK_P292 foreign key (PROGRESSIVO,ANNO)
  references P292_MEMBER (PROGRESSIVO,ANNO);


-----
-- Nuovi incarichi
-----

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'MV115-106-2010-S2002','Dirigente veterinario incarico lett. c) con struttura complessa (dec. 2010-2012) - semplice (dec. 2002)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='MV115-106-2010-S2002');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT 'EDP', 'INCARICO', 'MV115-106-2010-S2002', TO_DATE('01012010','DDMMYYYY'),
        'Dir. veterinario lett. c) con S.C. (dec. 2010-2012) - S.S. (dec. 2002)',
        '00208', 'BASE', 129.98, 'SSSSSSSSSSSS', TO_DATE('31123999','DDMMYYYY'), ''
           FROM DUAL WHERE NOT EXISTS
            (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
            AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV115-106-2010-S2002' AND T.COD_VOCE='00208');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT 'EDP', 'INCARICO', 'MV115-106-2010-S2002', TO_DATE('01012010','DDMMYYYY'),
        'Dir. veterinario lett. c) con S.C. (dec. 2010-2012) - S.S. (dec. 2002)',
        '00212', 'BASE', 512.04, 'SSSSSSSSSSSS', TO_DATE('31123999','DDMMYYYY'), ''
           FROM DUAL WHERE NOT EXISTS
            (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
            AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV115-106-2010-S2002' AND T.COD_VOCE='00212');

      INSERT INTO I501INCARICO SELECT 'MV115-106-2010-S2007','Dirigente veterinario incarico lett. c) con struttura complessa (dec. 2010-2012) - semplice (dec. 2007)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='MV115-106-2010-S2007');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT 'EDP', 'INCARICO', 'MV115-106-2010-S2007', TO_DATE('01012010','DDMMYYYY'),
        'Dir. veterinario lett. c) con S.C. (dec. 2010-2012) - S.S. (dec. 2007)',
        '00208', 'BASE', 107.52, 'SSSSSSSSSSSS', TO_DATE('31123999','DDMMYYYY'), ''
           FROM DUAL WHERE NOT EXISTS
            (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
            AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV115-106-2010-S2007' AND T.COD_VOCE='00208');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT 'EDP', 'INCARICO', 'MV115-106-2010-S2007', TO_DATE('01012010','DDMMYYYY'),
        'Dir. veterinario lett. c) con S.C. (dec. 2010-2012) - S.S. (dec. 2007)',
        '00212', 'BASE', 534.50, 'SSSSSSSSSSSS', TO_DATE('31123999','DDMMYYYY'), ''
           FROM DUAL WHERE NOT EXISTS
            (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
            AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV115-106-2010-S2007' AND T.COD_VOCE='00212');

    end if;
  end if;
end;
/

UPDATE t480_comuni t SET T.CITTA='SAN STINO DI LIVENZA' WHERE T.CODCATASTALE='I373';
update t480_comuni t set t.citta='CERRETTO LANGHE' WHERE T.CODCATASTALE='C530';
