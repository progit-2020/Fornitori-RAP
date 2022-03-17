update MONDOEDP.I090_ENTI set VERSIONEDB = '7.9',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

ALTER TABLE T950_STAMPACARTELLINO ADD CAUASS_NO_RIEPILOGO VARCHAR2(1000);
comment on column T950_STAMPACARTELLINO.CAUASS_NO_RIEPILOGO is
'Elenco delle causali di assenza da non visualizzare nel riepilogo';

-- CREATE TABLE T370_SALVA_CAMBIOORA
CREATE TABLE T370_SALVA_CAMBIOORA
(
  PROGRESSIVO NUMBER(38,2) NOT NULL,
  DATA        DATE NOT NULL,
  ORA         DATE NOT NULL,
  VERSO       VARCHAR2(1) NOT NULL,
  FLAG        VARCHAR2(1) NOT NULL,
  RILEVATORE  VARCHAR2(2),
  CAUSALE     VARCHAR2(5),
  ID_RIGA     VARCHAR2(40)
)
TABLESPACE LAVORO 
STORAGE 
(INITIAL 256K 
 NEXT 256K 
 PCTINCREASE 0);

ALTER TABLE T774_PESATUREINDIVIDUALI ADD GG_SERVIZIO NUMBER/*--NOLOG--*/;
ALTER TABLE T774_PESATUREINDIVIDUALI ADD DATAINIZIO DATE/*--NOLOG--*/;
ALTER TABLE T774_PESATUREINDIVIDUALI ADD DATAFINE DATE/*--NOLOG--*/;
ALTER TABLE T773_PESATUREGRUPPO MODIFY CODGRUPPO VARCHAR2(10) /*--NOLOG--*/;
ALTER TABLE T774_PESATUREINDIVIDUALI MODIFY CODGRUPPO VARCHAR2(10) /*--NOLOG--*/;
ALTER TABLE T773_PESATUREGRUPPO ADD DATARIF DATE/*--NOLOG--*/;
ALTER TABLE T773_PESATUREGRUPPO ADD ANNO NUMBER/*--NOLOG--*/;
ALTER TABLE T774_PESATUREINDIVIDUALI ADD ANNO NUMBER/*--NOLOG--*/;
alter table T773_PESATUREGRUPPO drop primary key/*--NOLOG--*/;
drop index T773_PK/*--NOLOG--*/;
alter table T773_PESATUREGRUPPO
  add constraint T773_PK primary key (ANNO, CODGRUPPO, CODTIPOQUOTA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0) /*--NOLOG--*/;
alter table T774_PESATUREINDIVIDUALI drop primary key/*--NOLOG--*/;
drop index T774_PK/*--NOLOG--*/;
alter table T774_PESATUREINDIVIDUALI
  add constraint T774_PK primary key (ANNO, CODGRUPPO, CODTIPOQUOTA, PROGRESSIVO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0) /*--NOLOG--*/;
ALTER TABLE T773_PESATUREGRUPPO DROP COLUMN DECORRENZA/*--NOLOG--*/;
ALTER TABLE T774_PESATUREINDIVIDUALI DROP COLUMN DECORRENZA/*--NOLOG--*/;

alter table p240_tipiassoggettamenti
modify (cod_tipoassoggettamento varchar2(10), descrizione varchar2(100));
alter table p430_anagrafico                   
modify cod_tipoassoggettamento varchar2(10);

update T914_SERBATOIFILTRO set FILTRO = 
replace(FILTRO,
        'CONTROLLO_RIPOSI(PROGRESSIVO4,Dataconteggio,'' '') <= ''11.00''',
        'CONTROLLO_RIPOSI(PROGRESSIVO4,Dataconteggio,'' '') <= 660')
where upper(FILTRO) like '%CONTROLLO_RIPOSI(%';

update T914_SERBATOIFILTRO set FILTRO = 
replace(FILTRO,
        'OREMINUTI(CONTROLLO_RIPOSI(PROGRESSIVO4,Dataconteggio,'' '')) <= OREMINUTI(''11.00'')',
        'CONTROLLO_RIPOSI(PROGRESSIVO4,Dataconteggio,'' '') <= 660')
where upper(FILTRO) like '%CONTROLLO_RIPOSI(%';

UPDATE P660_FLUSSIREGOLE SET REGOLA_CALCOLO_AUTOMATICA =
 REPLACE(REGOLA_CALCOLO_AUTOMATICA,'FROM T040_GIUSTIFICATIVI T040
WHERE T040.PROGRESSIVO=:PROGRESSIVO
      AND T040.DATA=:DATAELABORAZIONE',
'FROM T040_GIUSTIFICATIVI T040, T430_STORICO T430 WHERE T040.PROGRESSIVO=:PROGRESSIVO 
AND T040.PROGRESSIVO = T430.PROGRESSIVO AND T040.DATA=LEAST(:DATAELABORAZIONE,NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY'')))'),
REGOLA_CALCOLO_MANUALE =
 REPLACE(REGOLA_CALCOLO_MANUALE,'FROM T040_GIUSTIFICATIVI T040
WHERE T040.PROGRESSIVO=:PROGRESSIVO
      AND T040.DATA=:DATAELABORAZIONE',
'FROM T040_GIUSTIFICATIVI T040, T430_STORICO T430 WHERE T040.PROGRESSIVO=:PROGRESSIVO 
AND T040.PROGRESSIVO = T430.PROGRESSIVO AND T040.DATA=LEAST(:DATAELABORAZIONE,NVL(T430.FINE,TO_DATE(''31123999'',''DDMMYYYY'')))')
 WHERE NOME_FLUSSO = 'FLUPER' AND NUMERO = '027' AND PARTE = 'A'
 AND REGOLA_CALCOLO_MANUALE LIKE '%FROM T040_GIUSTIFICATIVI T040
WHERE T040.PROGRESSIVO=:PROGRESSIVO
      AND T040.DATA=:DATAELABORAZIONE%';

alter table P240_TIPIASSOGGETTAMENTI modify COD_TIPOASSOGGETTAMENTO VARCHAR2(10);
alter table P240_TIPIASSOGGETTAMENTI modify DESCRIZIONE VARCHAR2(100);

alter table P430_ANAGRAFICO modify COD_TIPOASSOGGETTAMENTO VARCHAR2(10);


-- *****************************************************************************
-- Regole D.M.A. per ENPDEDP
-- *****************************************************************************

update p660_flussiregole t
set t.regola_calcolo_manuale=
  (select v.regola_calcolo_manuale from p660_flussiregole v where v.nome_flusso=t.nome_flusso and v.decorrenza=t.decorrenza
     and v.parte=t.parte and v.numero='036')
where t.nome_flusso='DMA' and t.parte in ('E0','V1') and t.numero='041';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'11040','11190')
where t.nome_flusso='DMA' and t.parte in ('E0','V1') and t.numero='041';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'11045','11195')
where t.nome_flusso='DMA' and t.parte in ('E0','V1') and t.numero='041';

update p660_flussiregole t
set t.regola_calcolo_manuale=
  (select v.regola_calcolo_manuale from p660_flussiregole v where v.nome_flusso=t.nome_flusso and v.decorrenza=t.decorrenza
     and v.parte=t.parte and v.numero='027')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='029';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'9 CASSA','8 CASSA')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='029';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'= ''005''','= ''006''')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='029';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'= ''9''','= ''8''')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='029';

update p660_flussiregole t
set t.regola_calcolo_manuale=
  (select v.regola_calcolo_manuale from p660_flussiregole v where v.nome_flusso=t.nome_flusso and v.decorrenza=t.decorrenza
     and v.parte=t.parte and v.numero='028')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='030';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'= ''040''','= ''041''')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='030';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'= ''005''','= ''006''')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='030';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'9 CASSA','8 CASSA')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='030';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'= ''9''','= ''8''')
where t.nome_flusso='DMA' and t.parte = 'Z1' and t.numero='030';

update p660_flussiregole t
set t.regola_calcolo_automatica=t.regola_calcolo_manuale where t.nome_flusso='DMA';


-- *****************************************************************************
-- Regole CUD per ENPDEDP
-- *****************************************************************************

update p502_cudregole t
set t.regola_calcolo_manuale=
  (select v.regola_calcolo_manuale from p502_cudregole v where v.anno=t.anno
     and v.parte=t.parte and v.numero='023')
where t.anno = 2009 and t.parte = 'C21' and t.numero='024';

update p502_cudregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,',''9''',',''8''')
where t.anno = 2009 and t.parte = 'C21' and t.numero='024';

update p502_cudregole t
set t.regola_calcolo_manuale=
  (select v.regola_calcolo_manuale from p502_cudregole v where v.anno=t.anno
     and v.parte=t.parte and v.numero='032')
where t.anno = 2009 and t.parte = 'C21' and t.numero='034';

update p502_cudregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'IN (''039'')) DATIDMA','IN (''039'')
  AND EXISTS
  (SELECT ''X'' FROM P663_FLUSSIDATIINDIVIDUALI
       WHERE ID_FLUSSO = P663.ID_FLUSSO AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''006'' 
       AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD)
  AND EXISTS
  (SELECT ''X'' FROM P663_FLUSSIDATIINDIVIDUALI
       WHERE ID_FLUSSO = P663.ID_FLUSSO AND PROGRESSIVO = P663.PROGRESSIVO AND PARTE = P663.PARTE AND NUMERO = ''041'' 
       AND PROGRESSIVO_NUMERO = P663.PROGRESSIVO_NUMERO AND TIPO_RECORD = P663.TIPO_RECORD)
) DATIDMA')
where t.anno = 2009 and t.parte = 'C21' and t.numero='034';

update p502_cudregole t
set t.regola_calcolo_manuale=
  (select v.regola_calcolo_manuale from p502_cudregole v where v.anno=t.anno
     and v.parte=t.parte and v.numero='033')
where t.anno = 2009 and t.parte = 'C21' and t.numero='035';

update p502_cudregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'040','041')
where t.anno = 2009 and t.parte = 'C21' and t.numero='035';

update p502_cudregole t
set t.regola_calcolo_automatica=t.regola_calcolo_manuale;

insert into p205_quote
select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, '00380', cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
from p205_quote t
where t.cod_contratto='EDP' and t.cod_voce_da_quotare='15034' and t.cod_voce_speciale_da_quotare='BASE'
and t.cod_voce_in_quota='00375' and t.cod_voce_speciale_in_quota='BASE'
and not exists
(select 'x' from p205_quote v where v.cod_contratto=t.cod_contratto and v.cod_voce_da_quotare=t.cod_voce_da_quotare
and v.cod_voce_speciale_da_quotare=t.cod_voce_speciale_da_quotare
and v.cod_voce_in_quota='00380' and v.cod_voce_speciale_in_quota=t.cod_voce_speciale_in_quota)
and exists
(select 'x' from p200_voci z where z.cod_contratto=t.cod_contratto and z.cod_voce='00380'
and z.cod_voce_speciale='BASE' and z.descrizione like '%ufficiale di polizia%');

alter table MONDOEDP.I091_DATIENTE modify TIPO varchar2(40);

ALTER TABLE T770_QUOTE ADD DECORRENZA_FINE DATE;
UPDATE T770_QUOTE SET DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY');
ALTER TABLE T769_INCENTIVIASSENZE ADD CONTA_SOLO_GGINT VARCHAR2(1) DEFAULT 'N';

create table T065_RICHIESTESTRAORDINARI
(
  PROGRESSIVO         NUMBER(8),
  DATA                DATE,
  ID_CONGUAGLIO 	    NUMBER(8),
  TIPO                VARCHAR2(1),
  ORE_ECCED_CALC       VARCHAR2(6),
  DATA_RICHIESTA      DATE,
  ORE_ECCEDENTI       VARCHAR2(6),
  ORE_DACOMPENSARE    VARCHAR2(6),
  ORE_DALIQUIDARE     VARCHAR2(6),
  NOTE_RICHIESTA      VARCHAR2(1000),
  RESPONSABILE        VARCHAR2(30),
  DATA_AUTORIZZAZIONE DATE,
  ORE_ECCED_AUTORIZ   VARCHAR2(6),
  ORE_COMP_AUTORIZ    VARCHAR2(6),
  ORE_LIQ_AUTORIZ     VARCHAR2(6),
  NOTE_AUTORIZ        VARCHAR2(1000),
  STATO               VARCHAR2(1) default 'C'
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T065_RICHIESTESTRAORDINARI.DATA
  is 'Data del primo giorno del mese';
comment on column T065_RICHIESTESTRAORDINARI.ID_CONGUAGLIO 
  is 'Progressivo di univocità del conguaglio per dipendente e mese';
comment on column T065_RICHIESTESTRAORDINARI.TIPO
  is 'Tipo della richiesta C=Mese corrente, G=Conguaglio mesi precedenti';
comment on column T065_RICHIESTESTRAORDINARI.DATA_RICHIESTA
  is 'Data e ora di sistema in cui si registra la richiesta';
comment on column T065_RICHIESTESTRAORDINARI.ORE_ECCEDENTI
  is 'Ore eccedenti del mese';
comment on column T065_RICHIESTESTRAORDINARI.ORE_DACOMPENSARE
  is 'Ore richieste in compensazione';
comment on column T065_RICHIESTESTRAORDINARI.ORE_DALIQUIDARE
  is 'Ore richieste in liquidazione';
comment on column T065_RICHIESTESTRAORDINARI.NOTE_RICHIESTA
  is 'Note Richiesta';
comment on column T065_RICHIESTESTRAORDINARI.RESPONSABILE
  is 'Nome del Responsabile che ha autorizzato';
comment on column T065_RICHIESTESTRAORDINARI.DATA_AUTORIZZAZIONE
  is 'Data e ora di sistema in cui si registra l''autorizzazione';
comment on column T065_RICHIESTESTRAORDINARI.ORE_ECCED_AUTORIZ
  is 'Ore eccedenti autorizzate';
comment on column T065_RICHIESTESTRAORDINARI.ORE_LIQ_AUTORIZ
  is 'Ore liquidabili autorizzate';
comment on column T065_RICHIESTESTRAORDINARI.NOTE_AUTORIZ
  is 'Note Autorizzazione';
comment on column T065_RICHIESTESTRAORDINARI.STATO
  is 'C=Calcolato il riepilogo, R=Richiedibile, A=Autorizzabile, I=In autorizzazione, S=Autorizzato';

alter table T025_CONTMENSILI add ITER_AUTORIZZATIVO_STR varchar2(1) default '0';
comment on column T025_CONTMENSILI.ITER_AUTORIZZATIVO_STR is '0=No, 1=Banca ore';

alter table T065_RICHIESTESTRAORDINARI add constraint T065_PK primary key (PROGRESSIVO,DATA,ID_CONGUAGLIO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

insert into p130_pagamenti
select '5', 'Contanti' from dual
where not exists (select 'x' from p130_pagamenti t where t.cod_pagamento='5');

alter table T071_SCHEDAFASCE add BANCA_ORE varchar2(7);
comment on column T071_SCHEDAFASCE.BANCA_ORE is 'Banca ore maturata nel mese';

alter table T265_CAUASSENZE add CUMULO_FAM_GGDOPO varchar2(1) default 'S';
alter table T265_CAUASSENZE add FRUIZIONE_FAM_GGDOPO varchar2(1) default 'S';
comment on column T265_CAUASSENZE.CUMULO_FAMILIARI is 'Inizio del periodo di riferimento familiare. S=dalla data di nascita/adozione,D=dalla data di nascita,N=Nessun riferimento ai familiari';
comment on column T265_CAUASSENZE.FRUIZIONE_FAMILIARI is 'Inizio del periodo di riferimento familiare per la fruizione. S=dalla data di nascita/adozione,D=dalla data di nascita,N=Nessun riferimento ai familiari';
comment on column T265_CAUASSENZE.CUMULO_FAM_GGDOPO is 'Specifica se il cumulo deve partire dal giorno successivo alla data di nascita/adozione; significativo se CUMULO_FAMILIARI vale S oppure D';
comment on column T265_CAUASSENZE.FRUIZIONE_FAM_GGDOPO is 'Specifica se il periodo di fruzione deve partire dal giorno successivo alla data di nascita/adozione; significativo se FRUIZIONE_FAMILIARI vale S oppure D';

-- Create table
create table T713_BUDGETANNO
( CODGRUPPO        VARCHAR2(10) not null,
  TIPO             VARCHAR2(5) not null,
  DECORRENZA       DATE not null,
  DECORRENZA_FINE  DATE,
  ANNO             NUMBER not null,
  DESCRIZIONE      VARCHAR2(100),
  FILTRO_ANAGRAFE  VARCHAR2(4000) not null,
  ORE              VARCHAR2(10),
  IMPORTO          NUMBER)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
  
comment on column T713_BUDGETANNO.CODGRUPPO
  is 'Codice identificativo del gruppo di appartenenza';
comment on column T713_BUDGETANNO.TIPO
  is '#B.O#=Banca Ore, #LIQ#=Liquidabile, altro=causale di presenza';
comment on column T713_BUDGETANNO.DECORRENZA
  is 'Data inizio mese di decorrenza dei valori impostati nell''anno';
comment on column T713_BUDGETANNO.DECORRENZA_FINE
  is 'Data fine mese di validita'' dei valori impostati nell''anno';
comment on column T713_BUDGETANNO.ANNO
  is 'Anno di riferimento dei valori impostati';
comment on column T713_BUDGETANNO.FILTRO_ANAGRAFE
  is 'Filtro anagrafico che identifica i dipendenti del gruppo';
comment on column T713_BUDGETANNO.ORE
  is 'Ore annue di budget straordinario';
comment on column T713_BUDGETANNO.IMPORTO
  is 'Importo annuo di budget straordinario';
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table T713_BUDGETANNO
  add constraint T713_PK primary key (CODGRUPPO, TIPO, DECORRENZA)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- Create table
create table T714_BUDGETMESE
( CODGRUPPO               VARCHAR2(10) not null,
  TIPO                    VARCHAR2(5) not null,
  DECORRENZA              DATE not null,
  MESE                    NUMBER not null,
  ORE                     VARCHAR2(10),
  IMPORTO                 NUMBER,
  ORE_FRUITO              VARCHAR2(10),
  IMPORTO_FRUITO          NUMBER)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
  
comment on column T714_BUDGETMESE.CODGRUPPO
  is 'Codice identificativo del gruppo di appartenenza';
comment on column T714_BUDGETMESE.TIPO
  is '#B.O#=Banca Ore, #LIQ#=Liquidabile, altro=causale di presenza';
comment on column T714_BUDGETMESE.DECORRENZA
  is 'Data inizio mese di decorrenza dei valori impostati nell''anno';
comment on column T714_BUDGETMESE.MESE
  is 'Mese di riferimento dei valori impostati';
comment on column T714_BUDGETMESE.ORE
  is 'Ore mensili di budget straordinario';
comment on column T714_BUDGETMESE.IMPORTO
  is 'Importo mensile di budget straordinario';
comment on column T714_BUDGETMESE.ORE
  is 'Ore mensili di budget straordinario già fruite';
comment on column T714_BUDGETMESE.IMPORTO
  is 'Importo mensile di budget straordinario già fruito';
  
 -- Create/Recreate primary, unique and foreign key constraints 
alter table T714_BUDGETMESE
  add constraint T714_PK primary key (CODGRUPPO, TIPO, DECORRENZA, MESE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

DECLARE
  CURSOR C1 IS
    SELECT AZIENDA
    FROM MONDOEDP.I091_DATIENTE
    WHERE TIPO = 'C2_CONTRATTO'
    AND TRIM(DATO) IS NULL;
BEGIN
  FOR R1 IN C1 LOOP
    UPDATE MONDOEDP.I091_DATIENTE
    SET DATO = NULL
    WHERE TIPO = 'C2_FACOLTATIVO'
    AND AZIENDA = R1.AZIENDA;
  END LOOP;
END;
/

UPDATE MONDOEDP.I073_FILTROFUNZIONI
SET FUNZIONE = 'OpenA063FBudgetGenerazione',
    DESCRIZIONE = 'Generazione budget di straordinario'
WHERE GRUPPO = 'Budget straordinario'
AND TAG = '131';

UPDATE MONDOEDP.I073_FILTROFUNZIONI
SET FUNZIONE = 'OpenA064FBudgetStraordinario',
    DESCRIZIONE = 'Definizione budget annuale/mensile'
WHERE GRUPPO = 'Budget straordinario'
AND TAG = '132';

DECLARE
  CURSOR CT720 (sVALORE1 VARCHAR2, sVALORE2 VARCHAR2, sANNO VARCHAR2) IS
    SELECT MESE, BUDGET_MAN
    FROM  T720_BUDGETMENSILE
    WHERE CONTRATTO = sVALORE1
    AND   REPARTO = sVALORE2
    AND   ANNO = sANNO;

  CURSORE_DINAMICO_T712     INTEGER;
  CURS_T712                 INTEGER;

  C2_FACOLTATIVO      I091_DATIENTE.DATO%TYPE := NULL;
  sCAMPO1             I091_DATIENTE.DATO%TYPE := NULL;
  sCAMPO2             I091_DATIENTE.DATO%TYPE := NULL;
  sSQLT712            VARCHAR2(1000)          :='';
  sANNO               VARCHAR2(4)             :='';
  sVALORE1            VARCHAR2(100)           :='';
  sVALORE2            VARCHAR2(100)           :='';
  sBUDGET             VARCHAR2(10)            :='';
  sCODGRUPPO          VARCHAR2(100)           :='';
  nI                  NUMBER                  :=0;

  EXC_ESCI  EXCEPTION;
BEGIN
  BEGIN
    SELECT TRIM(DATO)
    INTO C2_FACOLTATIVO
    FROM MONDOEDP.I091_DATIENTE
    WHERE AZIENDA = :AZIENDA
    AND TIPO = 'C2_FACOLTATIVO';
    SELECT TRIM(DATO)
    INTO sCAMPO1
    FROM MONDOEDP.I091_DATIENTE
    WHERE AZIENDA = :AZIENDA
    AND TIPO = 'C2_CONTRATTO';
    SELECT TRIM(DATO)
    INTO sCAMPO2
    FROM MONDOEDP.I091_DATIENTE
    WHERE AZIENDA = :AZIENDA
    AND TIPO = 'C2_BUDGET';
  EXCEPTION
    WHEN OTHERS THEN
      C2_FACOLTATIVO:=NULL;
  END;
  IF NVL(C2_FACOLTATIVO,'#NULL#') = '#NULL#' THEN
    RAISE EXC_ESCI;
  END IF;

  sSQLT712:='SELECT ANNO, ' || sCAMPO1 ||', ' || sCAMPO2 ||', BUDGET FROM T712_BUDGET' || sCAMPO2 || ' ORDER BY ANNO, ' || sCAMPO1 ||', ' || sCAMPO2;
  CURSORE_DINAMICO_T712:=DBMS_SQL.OPEN_CURSOR;
  DBMS_SQL.PARSE(CURSORE_DINAMICO_T712,sSQLT712,DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T712,1,sANNO,4);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T712,2,sVALORE1,100);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T712,3,sVALORE2,100);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T712,4,sBUDGET,10);
  CURS_T712:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_T712);
  LOOP
    IF DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_T712)>0 THEN
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T712, 1, sANNO);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T712, 2, sVALORE1);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T712, 3, sVALORE2);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T712, 4, sBUDGET);
      sCODGRUPPO:=sVALORE2 || '_' || sVALORE1;
      IF LENGTH(sCODGRUPPO) > 10 THEN
        nI:=nI + 1;
        sCODGRUPPO:=LPAD(nI,10,'0');
      END IF;

      BEGIN
        INSERT INTO T713_BUDGETANNO
        (CODGRUPPO, TIPO, DECORRENZA, DECORRENZA_FINE, ANNO, DESCRIZIONE, FILTRO_ANAGRAFE, ORE, IMPORTO)
        VALUES
        (sCODGRUPPO,
        '#LIQ#',
        TO_DATE('0101'||sANNO,'DDMMYYYY'),
        TO_DATE('3112'||sANNO,'DDMMYYYY'),
        sANNO,
        'Ore liquidate per ' || sCAMPO2 || ': ' || sVALORE2 || ' - ' || sCAMPO1 || ': ' || sVALORE1,
        '(V430.T430' || sCAMPO1 || ' IN (''' || sVALORE1 || '''))  AND (V430.T430' || sCAMPO2 || ' IN (''' || sVALORE2 || ''')) ',
        MINUTIORE(OREMINUTI('0'||LTRIM(REPLACE(sBUDGET,' ','0'),'0'))),
        0);
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
      FOR RT720 IN CT720(sVALORE1,sVALORE2,sANNO) LOOP
        BEGIN
          INSERT INTO T714_BUDGETMESE
          (CODGRUPPO, TIPO, DECORRENZA, MESE, ORE, IMPORTO, ORE_FRUITO, IMPORTO_FRUITO)
          VALUES
          (sCODGRUPPO,
          '#LIQ#',
          TO_DATE('0101'||sANNO,'DDMMYYYY'),
          RT720.MESE,
          MINUTIORE(OREMINUTI('0'||LTRIM(REPLACE(RT720.BUDGET_MAN,' ','0'),'0'))),
          0,
          '0.00',
          0);
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
      END LOOP;
    ELSE
      EXIT;
    END IF;
  END LOOP;
  DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_T712);
  COMMIT;
EXCEPTION
  WHEN EXC_ESCI THEN
    NULL;
END/*--NOLOG--*/;
/

comment on column P551_CONTOANNFILE.FORMATO
  is 'Formato del campo: ''X''=Alfanumerico, ''N''=Numerico intero, ''NVx''= Numerico con x cifre decimali';

ALTER TABLE P022_CAAF MODIFY DESCRIZIONE VARCHAR2(60);

alter table T350_REGREPERIB add BLOCCA_MAX_MESE varchar2(1) default 'N';
comment on column T350_REGREPERIB.BLOCCA_MAX_MESE is 'S=non è possibile pianificare oltre il parametro PIANIF_MAX_MESE, N=è possibile pianificare oltre il parametro PIANIF_MAX_MESE';

create index T105_DATA_PROGRESSIVO on T105_RICHIESTETIMBRATURE (PROGRESSIVO,DATA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index T105_DATA on T105_RICHIESTETIMBRATURE (DATA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create bitmap index T105_BMI_ELABORATO on T105_RICHIESTETIMBRATURE (ELABORATO) tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;
create index T105_BMI_ELABORATO on T105_RICHIESTETIMBRATURE (ELABORATO) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index T050_PROGRESSIVO on T050_RICHIESTEASSENZA (PROGRESSIVO) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index T050_PROGRESSIVO_DAL on T050_RICHIESTEASSENZA (PROGRESSIVO,DAL) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create bitmap index T050_BMI_ELABORATO on T050_RICHIESTEASSENZA (ELABORATO) tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;
create index T050_BMI_ELABORATO on T050_RICHIESTEASSENZA (ELABORATO) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index I000_DATA on I000_LOGINFO (DATA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index I000_DATAOPERAZIONE on I000_LOGINFO (DATA, OPERAZIONE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index I000_DATAMASCHERA on I000_LOGINFO (DATA, MASCHERA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index I000_DATATABELLA on I000_LOGINFO (DATA, TABELLA) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T432_DATALAVORO add UTENTE varchar2(30);
update T432_DATALAVORO T432 
set    UTENTE = (select UTENTE 
                 from   MONDOEDP.I070_UTENTI 
                 where  PROGRESSIVO = T432.OPERATORE
                 and    AZIENDA = :AZIENDA);
delete from T432_DATALAVORO where UTENTE is null;
comment on column T432_DATALAVORO.OPERATORE 
  is 'Colonna obsoleta';
alter table T432_DATALAVORO drop primary key; 
drop index T432_PK/*--NOLOG--*/;
alter table T432_DATALAVORO modify OPERATORE null;
alter table T432_DATALAVORO
  add constraint T432_PK primary key (UTENTE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T050_RICHIESTEASSENZA modify RESPONSABILE varchar2(30);
alter table T065_RICHIESTESTRAORDINARI modify RESPONSABILE varchar2(30);
alter table T105_RICHIESTETIMBRATURE modify RESPONSABILE varchar2(30);

UPDATE P660_FLUSSIREGOLE P660
SET P660.REGOLA_CALCOLO_MANUALE=
'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO, SUM(IMPORTO) IMPORTO FROM
(
SELECT DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,
DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,
P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO 
FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258
WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO
AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)
AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')
AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')
AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')
AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')
AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''
UNION ALL
SELECT DECODE(P260.TIPO_ENTE,''R'',''R'',''C'',''S'') TIPO_RIGA, 
DECODE(P260.TIPO_ENTE,''R'',''381E'',
                      ''C'',DECODE(P260.COD_TIPOIMPORTO,''ACC'',''385E'',
                                                      ''ACD'',''385E'',
                                                            ''384E'')) COD_TRIBUTO, 
P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, 
DECODE(P260.COD_TIPOIMPORTO,''ACC'',P260.ANNO,''ACD'',P260.ANNO,P260.ANNO - 1) ANNO,
P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO
FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,
     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,
     T480_COMUNI T480, T482_REGIONI T482  
WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO
AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)
AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND
(
(P442.COD_VOCE = P260.COD_VOCE AND
P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR
(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND
P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR
(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND
P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)
) AND
TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND
P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND
P260.TIPO_ENTE IN (''C'',''R'') AND P264.PROGRESSIVO = P441.PROGRESSIVO AND
P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)
)
GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO
HAVING SUM(IMPORTO) <> 0
ORDER BY TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO'
WHERE P660.NOME_FLUSSO='F24EP' AND P660.DECORRENZA=TO_DATE('01012008','DDMMYYYY')
AND P660.PARTE='V' AND P660.NUMERO='009';

UPDATE P660_FLUSSIREGOLE P660 SET P660.REGOLA_CALCOLO_AUTOMATICA=P660.REGOLA_CALCOLO_MANUALE
WHERE P660.NOME_FLUSSO='F24EP';

alter table P130_PAGAMENTI add MOD_PAGAMENTO varchar2(1);
comment on column P130_PAGAMENTI.MOD_PAGAMENTO
  is 'Modalità di pagamento record 10 tracciato SETIF/CBI';

delete from MONDOEDP.T001_PARAMETRIFUNZIONI where PROGOPERATORE not in (select PROGRESSIVO from MONDOEDP.I070_UTENTI) and PROGOPERATORE >= 0;

declare
  cursor c1 is
    select AZIENDA,UTENTE,PROGRESSIVO from MONDOEDP.I070_UTENTI order by PROGRESSIVO;
  maxprog integer;
  oldprog integer;
begin
  oldprog:=-1;
  select max(PROGRESSIVO) into maxprog from MONDOEDP.I070_UTENTI;
  for t1 in c1 loop
    if t1.progressivo = oldprog then
      maxprog:=maxprog + 1;
      update MONDOEDP.I070_UTENTI set PROGRESSIVO = maxprog where AZIENDA = t1.AZIENDA and UTENTE = t1.UTENTE;
      insert into MONDOEDP.T001_PARAMETRIFUNZIONI select PROG,NOME,VALORE,maxprog from MONDOEDP.T001_PARAMETRIFUNZIONI where PROGOPERATORE = oldprog;
    else
      oldprog:=t1.progressivo;
    end if;
  end loop;
  update MONDOEDP.T035_PROGRESSIVO set PROPERATORI = (select max(PROGRESSIVO) from MONDOEDP.I070_UTENTI);
end;
/

create unique index MONDOEDP.I070_UQ on MONDOEDP.I070_UTENTI (PROGRESSIVO) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index T047_TIPO_OPER on T047_VISITEFISCALI (TIPO_EVENTO,OPERAZIONE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- Creazione ambiente su voci per gestione massimali contributivi

UPDATE P232_SCAGLIONI P232
SET P232.TIPO_APPLICAZIONE='Q', P232.COD_VOCE_CONGUAGLIO='10013', P232.COD_VOCE_SPECIALE_CONGUAGLIO='BASE'
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE';

UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=74505.62, P232.MASSIMALE2=135811.64
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01011900','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=76442.85, P232.MASSIMALE2=139342.65
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012001','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=78506.61, P232.MASSIMALE2=143105.04
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012002','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=80390.77, P232.MASSIMALE2=146539.56
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012003','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=82400.54, P232.MASSIMALE2=150203.05
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012004','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=84048.55, P232.MASSIMALE2=153207.11
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012005','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=85477.37, P232.MASSIMALE2=155811.63
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012006','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=87186.91, P232.MASSIMALE2=158927.86
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012007','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=88669.08, P232.MASSIMALE2=161629.63
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012008','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=91506.49, P232.MASSIMALE2=166801.8
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012009','DDMMYYYY');
UPDATE P232_SCAGLIONI P232 SET P232.MASSIMALE1=92147.03, P232.MASSIMALE2=167969.41
WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE IN ('11010','11020','11410')
AND P232.COD_VOCE_SPECIALE='BASE' AND P232.DECORRENZA=TO_DATE('01012010','DDMMYYYY');

declare 
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  EsisteVoce varchar2(10);
  ID_P200 integer;

begin

-----
-- Creazione voce 10013 copiandola da 10011
-----

CodVoceModello:='10011';
CodVoceCopia:='10013';
DesVoceCopia:='Abbattimento CPDEL/CPS supero massimale';  

SELECT NVL(MAX(T.COD_VOCE),'NO') INTO EsisteVoce
FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='10013' AND T.COD_VOCE_SPECIALE='BASE';

IF EsisteVoce ='NO' THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ',
  DesVoceCopia, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico,
  importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni,
  ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile,
  stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert,
  ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam,
  abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note,
  cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp,
  abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg,
  retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  -- Assoggettamenti
  INSERT INTO P201_ASSOGGETTAMENTI
  SELECT cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio,
  decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
  from P201_ASSOGGETTAMENTI t
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE= CodVoceModello AND T.Cod_Voce_Speciale_Padre='BASE'
  AND T.COD_VOCE_FIGLIO IN('10010','10015','10020','10025','10410','14100');
END IF;

end;
/

alter table T430_STORICO add INIZIO_IND_MAT date default null;
alter table T430_STORICO add FINE_IND_MAT date default null;
insert into t033_layout
  (nome, top, lft, caption, accesso, nomepagina, campodb)
select distinct 
  nome, 300, 600, 'Inizio ind.maternità', 'N', 'Dati Anagrafici', 'INIZIO_IND_MAT'
from T033_LAYOUT;

insert into t033_layout
  (nome, top, lft, caption, accesso, nomepagina, campodb)
select distinct 
  nome, 340, 600, 'Fine ind.maternità', 'N', 'Dati Anagrafici', 'FINE_IND_MAT'
from T033_LAYOUT;

-- Nuovi motivi uscita ONAOSI
update p004_codicitabannuali t set t.descrizione='Uscita per quiescienza'
where t.anno=2010 and t.cod_tabannuale='ONTIPCESS' and t.cod_codicitabannuali='3';
update p004_codicitabannuali t set t.descrizione='Scadenza del rapporto o uscita per passaggio ad altra Pubblica Amministrazione'
where t.anno=2010 and t.cod_tabannuale='ONTIPCESS' and t.cod_codicitabannuali='5';
insert into p004_codicitabannuali
select 'ONTIPCESS', '26', 2010, 'Uscita per dimissioni' from dual
where not exists
(select 'x' from p004_codicitabannuali t where t.anno=2010 and t.cod_tabannuale='ONTIPCESS' and t.cod_codicitabannuali='26')
and exists
(select 'x' from p002_tabannuali v where v.cod_tabannuale='ONTIPCESS');
insert into p004_codicitabannuali
select 'ONTIPCESS', '25', 2010, 'Cancellazione da ogni Ordine Sanitario italiano' from dual
where not exists
(select 'x' from p004_codicitabannuali t where t.anno=2010 and t.cod_tabannuale='ONTIPCESS' and t.cod_codicitabannuali='25')
and exists
(select 'x' from p002_tabannuali v where v.cod_tabannuale='ONTIPCESS');

alter table P206_ASSENZEINPDAP drop column ABBATTE_GGTFR;

-- Assoggettamento I.V.C all’ONAOSI
INSERT INTO P201_ASSOGGETTAMENTI
SELECT COD_CONTRATTO, COD_VOCE_PADRE, COD_VOCE_SPECIALE_PADRE, '10030', COD_VOCE_SPECIALE_FIGLIO,
       TO_DATE('01012008','DDMMYYYY'), ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE
FROM P201_ASSOGGETTAMENTI T
where T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE='00290'
AND T.COD_VOCE_FIGLIO='10010' AND T.COD_VOCE_SPECIALE_FIGLIO='BASE'
AND NOT EXISTS
  (SELECT 'X' FROM P201_ASSOGGETTAMENTI V WHERE V.COD_CONTRATTO=T.COD_CONTRATTO
   AND V.COD_VOCE_PADRE=T.COD_VOCE_PADRE AND V.COD_VOCE_SPECIALE_PADRE=T.COD_VOCE_SPECIALE_PADRE
   AND V.COD_VOCE_FIGLIO='10030');

update p660_flussiregole t set t.cod_arrotondamento='P1'
where t.nome_flusso='DMA' and t.parte = 'Z2' and t.numero='028';

-- Nuove regole per punto 043 quadri E0/V1 della D.M.A.
update p660_flussiregole t
set t.regola_calcolo_manuale=
  (select v.regola_calcolo_manuale from p660_flussiregole v where v.nome_flusso=t.nome_flusso and v.decorrenza=t.decorrenza
     and v.parte=t.parte and v.numero='027')
where t.nome_flusso='DMA' and t.parte in ('E0','V1') and t.numero='043';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'14110','14120')
where t.nome_flusso='DMA' and t.parte in ('E0','V1') and t.numero='043';

update p660_flussiregole t
set t.regola_calcolo_manuale=replace(t.regola_calcolo_manuale,'IMPORTO DATO','IMPORTO_INTERO DATO')
where t.nome_flusso='DMA' and t.parte in ('E0','V1') and t.numero='043';

update p660_flussiregole t
set t.regola_calcolo_automatica=t.regola_calcolo_manuale where t.nome_flusso='DMA';

-- Modify the last number 
declare
  cursor c1 is select rowid from t044_storicogiustificativi where id is null
    order by data_agg,data;
  IdVal integer;
begin
  IdVal:=1;
  for t1 in c1 loop
    select T044_ID.nextval into IdVal from dual;
    update t044_storicogiustificativi set id = IdVal where rowid = t1.rowid;
    commit;
  end loop; 
end;
/

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Quote_Dip_Voce';
    if i = 0 then
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', -2, ''Stringa,Data,Stringa'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', -1, ''"15100","31/05/2010",*'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 0, ''SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.DESCRIZIONE,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 1, ''       ABS(SUM(ROUND(P272.IMPORTO*(P205.ACCUMULO+P205.ACCUMULO_RATEO/12)/100/'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 2, ''       DECODE(P200.DIVISORE_QUOTE,NULL,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 3, ''              DECODE(P200.COD_MISURAQUANTITA,''''GG'''',P212.GIORNI_MESE,P212.ORE_MESE),P200.DIVISORE_QUOTE)'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 4, ''              ,5))) IMPORTO'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 5, ''FROM T030_ANAGRAFICO T030, P430_ANAGRAFICO P430, P272_RETRIBUZIONE_CONTRATTUALE P272,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 6, ''     P205_QUOTE P205, P200_VOCI P200, P212_PARAMETRISTIPENDI P212'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 7, ''WHERE T030.MATRICOLA=:Matricola AND P272.PROGRESSIVO=T030.PROGRESSIVO'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 8, ''AND P430.PROGRESSIVO=T030.PROGRESSIVO AND :DataCompetenza BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 9, ''AND P272.COD_CONTRATTO=P430.COD_CONTRATTO AND :DataCompetenza BETWEEN P272.DECORRENZA_INIZIO AND P272.DECORRENZA_FINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 10, ''AND P205.COD_CONTRATTO=P272.COD_CONTRATTO AND P205.COD_VOCE_IN_QUOTA=P272.COD_VOCE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 11, ''AND P205.COD_VOCE_SPECIALE_IN_QUOTA=P272.COD_VOCE_SPECIALE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 12, ''AND P200.COD_CONTRATTO=P205.COD_CONTRATTO AND P200.COD_VOCE=P205.COD_VOCE_DA_QUOTARE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 13, ''AND P200.COD_VOCE_SPECIALE=P205.COD_VOCE_SPECIALE_DA_QUOTARE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 14, ''AND :DataCompetenza BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 15, ''AND P212.COD_PARAMETRISTIPENDI=P430.COD_PARAMETRISTIPENDI AND :DataCompetenza BETWEEN P212.DECORRENZA AND P212.DECORRENZA_FINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 16, ''AND P200.COD_VOCE = :Cod_Voce AND P200.COD_VOCE_SPECIALE=''''BASE'''''', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Dip_Voce'', 17, ''GROUP BY T030.MATRICOLA,T030.COGNOME,T030.NOME,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.DESCRIZIONE'', ''PAGHE'')';
    end if;
  end if;
end;

/

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Quote_Str_Comparto';
    if i = 0 then
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', -2, ''Data'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', -1, ''"31/01/2010"'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 0, ''SELECT P220.COD_POSIZIONE_ECONOMICA,P220.DESCRIZIONE,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.DESCRIZIONE,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 1, ''       SUM(ROUND(P221.IMPORTO*(P205.ACCUMULO+P205.ACCUMULO_RATEO/12)/100/P212.ORE_MESE,5)) IMPORTO_ORARIO'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 2, ''FROM P220_LIVELLI P220, P221_LIVELLIIMPORTI P221, P205_QUOTE P205, P200_VOCI P200, P212_PARAMETRISTIPENDI P212'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 3, ''WHERE P220.COD_CONTRATTO=''''EDP'''' AND :DataCompetenza BETWEEN P220.DECORRENZA AND P220.DECORRENZA_FINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 4, ''AND P220.ID_LIVELLO=P221.ID_LIVELLO'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 5, ''AND P205.COD_CONTRATTO=P220.COD_CONTRATTO AND P205.COD_VOCE_IN_QUOTA=P221.COD_VOCE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 6, ''AND P205.COD_VOCE_SPECIALE_IN_QUOTA=P221.COD_VOCE_SPECIALE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 7, ''AND P200.COD_CONTRATTO=P205.COD_CONTRATTO AND P200.COD_VOCE=P205.COD_VOCE_DA_QUOTARE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 8, ''AND P200.COD_VOCE_SPECIALE=P205.COD_VOCE_SPECIALE_DA_QUOTARE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 9, ''AND :DataCompetenza BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 10, ''AND P212.COD_PARAMETRISTIPENDI=''''EDP'''' AND :DataCompetenza BETWEEN P212.DECORRENZA AND P212.DECORRENZA_FINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 11, ''AND P205.COD_VOCE_IN_QUOTA NOT IN (''''00025'''')'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 12, ''AND P200.COD_VOCE IN (''''01000'''',''''01002'''',''''01004'''')'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 13, ''GROUP BY P220.COD_POSIZIONE_ECONOMICA,P220.DESCRIZIONE,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.DESCRIZIONE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Quote_Str_Comparto'', 14, ''ORDER BY P220.COD_POSIZIONE_ECONOMICA,P200.COD_VOCE,P200.COD_VOCE_SPECIALE,P200.DESCRIZIONE'', ''PAGHE'')';
    end if;
  end if;
end;

/

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Cedolini_Consegna';
    if i = 0 then
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', -2, ''Data,Sostituzione'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', -1, ''"31/03/2010","SPED_CEDOLINI=''''W''''"'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 0, ''SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 1, ''       DECODE(P441.TIPO_CEDOLINO,''''NR'''',''''Normale'''',''''TR'''',''''Tredicesima'''',''''EX'''',''''Extra 27'''') TIPO_CEDOLINO,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 2, ''       P441.DATA_RETRIBUZIONE,P441.DATA_CONSEGNA'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 3, ''FROM T030_ANAGRAFICO T030, T430_STORICO T430, P441_CEDOLINO P441'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 4, ''WHERE T030.PROGRESSIVO=T430.PROGRESSIVO AND :DataCedolino BETWEEN T430.DATADECORRENZA AND T430.DATAFINE'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 5, ''AND T030.PROGRESSIVO=P441.PROGRESSIVO AND P441.DATA_CEDOLINO=:DataCedolino'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 6, ''AND P441.TIPO_CEDOLINO<>''''RP'''''', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 7, ''AND :FiltroDipConWeb'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Cedolini_Consegna'', 8, ''ORDER BY T030.COGNOME,T030.NOME,T030.MATRICOLA,P441.TIPO_CEDOLINO,P441.DATA_RETRIBUZIONE'', ''PAGHE'')';
    end if;
  end if;
end;

/

alter table P441_CEDOLINO add DATA_CONSEGNA DATE;
comment on column P441_CEDOLINO.DATA_CONSEGNA
  is 'Data consegna al dipendente';

comment on column T050_RICHIESTEASSENZA.TIPOGIUST is 'I = Giornata intera, M = Mezza giornata, N = Numero ore, D = Da ore / a ore ';
alter table T050_RICHIESTEASSENZA add TIPO_RICHIESTA varchar2(1) default 'D';
comment on column T050_RICHIESTEASSENZA.TIPO_RICHIESTA is 'P=Preventiva, D=Definitiva, R=Revoca';
alter table T050_RICHIESTEASSENZA add AUTORIZZ_PREV varchar2(1);
comment on column T050_RICHIESTEASSENZA.AUTORIZZ_PREV is 'Relativo ai records con TIPO_RICHIESTA = P: S = autorizzato, N = non autorizzato, '' = da esaminare';
alter table T050_RICHIESTEASSENZA add DATA_AUTORIZZ_PREV date;
comment on column T050_RICHIESTEASSENZA.DATA_AUTORIZZ_PREV is 'Data in cui è avvenuta l''autorizzazione della richiesta preventiva';
alter table T050_RICHIESTEASSENZA add NUMEROORE_PREV varchar2(5);
comment on column T050_RICHIESTEASSENZA.NUMEROORE_PREV is 'Numero ore / da ore della richiesta preventiva';
alter table T050_RICHIESTEASSENZA add AORE_PREV varchar2(5);
comment on column T050_RICHIESTEASSENZA.AORE_PREV is 'A ore della richiesta preventiva';
alter table T050_RICHIESTEASSENZA add ID number(38);
alter table T050_RICHIESTEASSENZA add ID_REVOCA number(38);
comment on column T050_RICHIESTEASSENZA.ID_REVOCA is 'ID della richiesta che revoca la presente';
create sequence T050_ID MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;
create index T050_IDRICH
  on T050_RICHIESTEASSENZA (ID) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T350_REGREPERIB add VP_MAX_MESE varchar2(6);
comment on column T350_REGREPERIB.VP_MAX_MESE is 'Voce paghe per i turni pianificati oltre il max mese indicato';
alter table T340_TURNIREPERIB add TURNI_OLTREMAX number(3);
comment on column T340_TURNIREPERIB.TURNI_OLTREMAX is 'Numero di turni interi pianificati oltre il max fattibile nel mese. Sono un di cui dei TURNIINTERI';
alter table T340_TURNIREPERIB add VP_TURNI_OLTREMAX varchar2(6);
comment on column T340_TURNIREPERIB.VP_TURNI_OLTREMAX is 'Voce paghe dei turni interi pianificati oltre il max nel mese';

alter table T350_REGREPERIB add GETTONE_CHIAMATA varchar2(1) default 'N';
comment on column T350_REGREPERIB.GETTONE_CHIAMATA is 'S=è prevista la maturazione di un gettone aggiuntivo se esiste la chiamata in reperibilità, N=Non è prevista la maturazione di alcun gettone aggiuntivo';
alter table T350_REGREPERIB add VP_GETTONE_CHIAMATA varchar2(6);
comment on column T350_REGREPERIB.VP_GETTONE_CHIAMATA is 'Voce paghe per i gettoni dovuti alla chiamata in reperibilità';
alter table T340_TURNIREPERIB add GETTONE_CHIAMATA number(3);
comment on column T340_TURNIREPERIB.GETTONE_CHIAMATA is 'Numero di gettoni relativi alla chiamata in turno';
alter table T340_TURNIREPERIB add VP_GETTONE_CHIAMATA varchar2(6);
comment on column T340_TURNIREPERIB.VP_GETTONE_CHIAMATA is 'Voce paghe dei gettoni relativi alla chiamata in turno';

create table T390_CHIAMATE_REPERIB (
DATA date,
PROGRESSIVO_OPER number(38),
PROGRESSIVO_REPER number(38),
ESITO varchar2(1),
NOTE varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T390_CHIAMATE_REPERIB add constraint T390_PK primary key (DATA,PROGRESSIVO_OPER,PROGRESSIVO_REPER) 
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T390_CHIAMATE_REPERIB.DATA is 'Data/ora della chiamata';
comment on column T390_CHIAMATE_REPERIB.PROGRESSIVO_OPER is 'Progressivo anagrafico dell''operatore che effettua la chiamata';
comment on column T390_CHIAMATE_REPERIB.PROGRESSIVO_REPER is 'Progressivo anagrafico del dipendente che viene chiamato';

create table T385_VINCOLI_REPERIB (
PROGRESSIVO number(38),
DECORRENZA date,
DECORRENZA_FINE date,
GIORNO varchar2(2),
TIPOLOGIA varchar2(1),
TURNI varchar2(1000),
DISPONIBILE varchar2(1),
BLOCCA_PIANIF varchar2(1)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T385_VINCOLI_REPERIB modify GIORNO default '*';
alter table T385_VINCOLI_REPERIB modify TIPOLOGIA default 'R';
alter table T385_VINCOLI_REPERIB modify DISPONIBILE default 'N';
alter table T385_VINCOLI_REPERIB modify BLOCCA_PIANIF default 'N';

alter table T385_VINCOLI_REPERIB add constraint T385_PK primary key (PROGRESSIVO,DECORRENZA,GIORNO,TIPOLOGIA)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
comment on column T385_VINCOLI_REPERIB.GIORNO is '*=tutti,FS=festivo,PF=prefestivo,1..7=gg settimana';
comment on column T385_VINCOLI_REPERIB.TIPOLOGIA is 'R=Reperibilità, G=Guardia';
comment on column T385_VINCOLI_REPERIB.DISPONIBILE is 'S=i turni indicati in TURNI sono pianificabili, N=i turni indicati in TURNI non sono pianificabili';
comment on column T385_VINCOLI_REPERIB.BLOCCA_PIANIF is 'S=il controllo sui turni non pianificabili è bloccante, N=il controllo sui turni non pianificabili è un avvertimento';

alter table T040_GIUSTIFICATIVI add ID_RICHIESTA number(38);
comment on column T040_GIUSTIFICATIVI.ID_RICHIESTA is 'T050.ID della richiesta del giustificativo';

alter table MONDOEDP.I150_PARSCARICOGIUST modify FORMATODATA varchar2(30);
comment on column MONDOEDP.I150_PARSCARICOGIUST.FORMATODATA
  is 'Formato Oracle delle date di inizio, fine periodo e familiare (è possibile indicare un formato comprensivo di ore/minuti)';

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from i500_datiliberi t where NOMECAMPO = 'INCARICO' and TABELLA = 'S';
    if i > 0 then
      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR075-055-2010'',''Dirigente ruolo amministrativo < 5 anni con struttura semplice (dec. 2010)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR075-055-2010'')';
      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''DR075-055-2010'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. ruolo amministr. < 5 anni con S.S. (dec. 2010)'',
        ''00212'', ''BASE'', 544.77, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''DR075-055-2010'')';
    end if;
  end if;
end;

/

ALTER TABLE SG308_INCINDENNITA ADD SCADENZA_IND DATE;
comment on column SG308_INCINDENNITA.SCADENZA_IND
  is 'Data in cui scade la maturazione dell''indennità di esclusività';

-- FONDI
create table P680_FONDIMACROCATEG
( COD_MACROCATEG VARCHAR2(5) not null,
  DESCRIZIONE    VARCHAR2(50))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0); 
comment on column P680_FONDIMACROCATEG.COD_MACROCATEG
  is 'Codice macrocategoria fondo (es. dirigenti medici, dirigenti non medici, personale non dirigente)';
comment on column P680_FONDIMACROCATEG.DESCRIZIONE
  is 'Descrizione';
alter table P680_FONDIMACROCATEG
  add constraint P680_PK primary key (COD_MACROCATEG)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table P682_FONDIRAGGR
( COD_RAGGR   VARCHAR2(10) not null,
  DESCRIZIONE VARCHAR2(500))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P682_FONDIRAGGR.COD_RAGGR
  is 'Codice raggruppamento fondo (es. retribuzione risultato medici e veterinari)';
comment on column P682_FONDIRAGGR.DESCRIZIONE
  is 'Descrizione';
alter table P682_FONDIRAGGR
  add constraint P682_PK primary key (COD_RAGGR)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table P684_FONDI
( COD_FONDO         VARCHAR2(15) not null,
  DECORRENZA_DA     DATE not null,
  DECORRENZA_A      DATE not null,
  DESCRIZIONE       VARCHAR2(500),
  COD_MACROCATEG    VARCHAR2(5),
  COD_RAGGR         VARCHAR2(10),
  DATA_COSTITUZ     DATE,
  FILTRO_DIPENDENTI VARCHAR2(500),
  DATA_ULTIMO_MONIT DATE)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P684_FONDI.COD_FONDO
  is 'Codice fondo';
comment on column P684_FONDI.DECORRENZA_DA
  is 'Data inizio competenza';
comment on column P684_FONDI.DECORRENZA_A
  is 'Data fine competenza';
comment on column P684_FONDI.DESCRIZIONE
  is 'Descrizione';
comment on column P684_FONDI.COD_MACROCATEG
  is 'Eventuale codice macrocategoria fondo';
comment on column P684_FONDI.COD_RAGGR
  is 'Eventuale codice raggruppamento fondo';
comment on column P684_FONDI.DATA_COSTITUZ
  is 'Data costituzione';
comment on column P684_FONDI.FILTRO_DIPENDENTI
  is 'Filtro dipendenti da inserire nel fondo';
comment on column P684_FONDI.DATA_ULTIMO_MONIT
  is 'Data ultimo monitoraggio';
alter table P684_FONDI
  add constraint P684_PK primary key (COD_FONDO, DECORRENZA_DA)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P684_FONDI
  add constraint P684_FK_P680 foreign key (COD_MACROCATEG)
  references P680_FONDIMACROCATEG (COD_MACROCATEG);
alter table P684_FONDI
  add constraint P684_FK_P682 foreign key (COD_RAGGR)
  references P682_FONDIRAGGR (COD_RAGGR);

create table P686_RISDESTGEN
( COD_FONDO     VARCHAR2(15) not null,
  DECORRENZA_DA DATE not null,
  CLASS_VOCE    VARCHAR2(1) not null,
  COD_VOCE_GEN  VARCHAR2(5) not null,
  DESCRIZIONE   VARCHAR2(200),
  TIPO_VOCE     VARCHAR2(50),
  ORDINE_STAMPA NUMBER)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P686_RISDESTGEN.COD_FONDO
  is 'Codice fondo';
comment on column P686_RISDESTGEN.DECORRENZA_DA
  is 'Data inizio competenza';
comment on column P686_RISDESTGEN.CLASS_VOCE
  is 'Classificazione voce di spesa: R=Risorsa, D=Destinzazione';
comment on column P686_RISDESTGEN.COD_VOCE_GEN
  is 'Codice risorsa/destinazione generale';
comment on column P686_RISDESTGEN.DESCRIZIONE
  is 'Descrizione risorsa/destinazione generale';
comment on column P686_RISDESTGEN.TIPO_VOCE
  is 'Tipo  risorsa/destinazione (es. fissa, variabile, accordo annuale)';
comment on column P686_RISDESTGEN.ORDINE_STAMPA
  is 'Ordine di stampa in riepilogo';
alter table P686_RISDESTGEN
  add constraint P686_PK primary key (COD_FONDO, DECORRENZA_DA, CLASS_VOCE, COD_VOCE_GEN)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P686_RISDESTGEN
  add constraint P686_FK_P684 foreign key (COD_FONDO, DECORRENZA_DA)
  references P684_FONDI (COD_FONDO, DECORRENZA_DA) on delete cascade;

create table P688_RISDESTDET
( COD_FONDO               VARCHAR2(15) not null,
  DECORRENZA_DA           DATE not null,
  CLASS_VOCE              VARCHAR2(1) not null,
  COD_VOCE_GEN            VARCHAR2(5) not null,
  COD_VOCE_DET            VARCHAR2(5) not null,
  DESCRIZIONE             VARCHAR2(200),
  DATA_RIFERIMENTO        DATE,
  QUANTITA                NUMBER,
  DATOBASE                NUMBER,
  MOLTIPLICATORE          NUMBER,
  IMPORTO                 NUMBER default 0 not null,
  COD_ARROTONDAMENTO      VARCHAR2(5),
  FILTRO_DIPENDENTI       VARCHAR2(500),
  CODICI_ACCORPAMENTOVOCI VARCHAR2(500))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P688_RISDESTDET.COD_FONDO
  is 'Codice fondo';
comment on column P688_RISDESTDET.DECORRENZA_DA
  is 'Data inizio competenza';
comment on column P688_RISDESTDET.CLASS_VOCE
  is 'Classificazione voce di spesa: R=Risorsa, D=Destinazione';
comment on column P688_RISDESTDET.COD_VOCE_GEN
  is 'Codice risorsa/destinazione generale';
comment on column P688_RISDESTDET.COD_VOCE_DET
  is 'Codice risorsa/destinazione dettagliata';
comment on column P688_RISDESTDET.DESCRIZIONE
  is 'Descrizione risorsa/destinazione dettagliata';
comment on column P688_RISDESTDET.DATA_RIFERIMENTO
  is 'Data riferimento risorsa. Richiesto solo se Class_Voce = R';
comment on column P688_RISDESTDET.QUANTITA
  is 'Può essere un numero unità, una percentuale o altro. Richiesto solo se Class_Voce = R';
comment on column P688_RISDESTDET.DATOBASE
  is 'Può essere un importo unitario, un monte salari o altro. Richiesto solo se Class_Voce = R';
comment on column P688_RISDESTDET.MOLTIPLICATORE
  is 'Ulteriore moltiplicatore (es. 1,08333 per rapportare a tredici mensilità). Richiesto solo se Class_Voce = R';
comment on column P688_RISDESTDET.IMPORTO
  is 'Importo totale risorsa/destinazione dettagliata';
comment on column P688_RISDESTDET.COD_ARROTONDAMENTO
  is 'Codice arrotondamento';
comment on column P688_RISDESTDET.FILTRO_DIPENDENTI
  is 'Eventuale filtro dipendenti alternativo a quello del fondo. Richiesto solo se Class_Voce = D';
comment on column P688_RISDESTDET.CODICI_ACCORPAMENTOVOCI
  is 'Accorpamento voci. Richiesto solo se Class_Voce = D';
alter table P688_RISDESTDET
  add constraint P688_PK primary key (COD_FONDO, DECORRENZA_DA, CLASS_VOCE, COD_VOCE_GEN, COD_VOCE_DET)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P688_RISDESTDET
  add constraint P688_FK_P686 foreign key (COD_FONDO, DECORRENZA_DA, CLASS_VOCE, COD_VOCE_GEN)
  references P686_RISDESTGEN (COD_FONDO, DECORRENZA_DA, CLASS_VOCE, COD_VOCE_GEN) on delete cascade;

create table P690_FONDISPESO
( COD_FONDO         VARCHAR2(15) not null,
  DECORRENZA_DA     DATE not null,
  CLASS_VOCE        VARCHAR2(1) not null,
  COD_VOCE_GEN      VARCHAR2(5) not null,
  COD_VOCE_DET      VARCHAR2(5) not null,
  DATA_RETRIBUZIONE DATE not null,
  COD_CONTRATTO     VARCHAR2(5) not null,
  COD_VOCE          VARCHAR2(5) not null,
  IMPORTO           NUMBER default 0 not null)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column P690_FONDISPESO.COD_FONDO
  is 'Codice fondo';
comment on column P690_FONDISPESO.DECORRENZA_DA
  is 'Data inizio competenza';
comment on column P690_FONDISPESO.CLASS_VOCE
  is 'Classificazione voce di spesa; fisso a D=Destinazione';
comment on column P690_FONDISPESO.COD_VOCE_GEN
  is 'Codice destinazione generale';
comment on column P690_FONDISPESO.COD_VOCE_DET
  is 'Codice destinazione dettagliata';
comment on column P690_FONDISPESO.DATA_RETRIBUZIONE
  is 'Anno e mese di retribuzione';
comment on column P690_FONDISPESO.IMPORTO
  is 'Importo speso o previsto';
alter table P690_FONDISPESO
  add constraint P690_PK primary key (COD_FONDO, DECORRENZA_DA, CLASS_VOCE, COD_VOCE_GEN, COD_VOCE_DET, DATA_RETRIBUZIONE, COD_CONTRATTO, COD_VOCE)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P690_FONDISPESO
  add constraint P690_FK_P688 foreign key (COD_FONDO, DECORRENZA_DA, CLASS_VOCE, COD_VOCE_GEN, COD_VOCE_DET)
  references P688_RISDESTDET (COD_FONDO, DECORRENZA_DA, CLASS_VOCE, COD_VOCE_GEN, COD_VOCE_DET) on delete cascade;

insert into MONDOEDP.I091_DATIENTE select AZIENDA,'C90_WEBRIGHEPAG', '15' from MONDOEDP.I090_ENTI/*--NOLOG--*/;

-- creazione tabella di appoggio per le voci variabili eliminate
create table T195_VOCIVARIABILIELIMINATE 
  tablespace LAVORO storage (initial 256K next 256K pctincrease 0)
  as select * from T195_VOCIVARIABILI where ROWNUM = 0;
alter table T195_VOCIVARIABILIELIMINATE add DATA_OPERAZIONE date;
create index T195E_IDX
  on T195_VOCIVARIABILIELIMINATE (DATA_OPERAZIONE,PROGRESSIVO,DATARIF,VOCEPAGHE,DATA_CASSA,DAL,OPERAZIONE) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table P448_CEDOLINOPARKVOCI add COD_VALUTA_INIZ VARCHAR2(10);
alter table P448_CEDOLINOPARKVOCI add IMPORTO_VALUTA_INIZ NUMBER;
comment on column P448_CEDOLINOPARKVOCI.COD_VALUTA_INIZ
  is 'Valuta iniziale degli importi';
comment on column P448_CEDOLINOPARKVOCI.IMPORTO_VALUTA_INIZ
  is 'Importo della voce nella valuta iniziale';


declare 
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  CreaVoce integer;
  ID_P200 integer;

begin

-----
-- Creazione voce 15115 copiandola da 15075
-----

CodVoceModello:='15075';
CodVoceCopia:='15115';
DesVoceCopia:='Aspettativa mandato politico non retrib.';  

SELECT COUNT(*) INTO CreaVoce
FROM P200_VOCI T WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE IN('15075','15115') AND T.COD_VOCE_SPECIALE='BASE';

IF CreaVoce = 1 THEN
  SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

  insert into p200_voci
  select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ',
  DesVoceCopia, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico,
  importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni,
  ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile,
  stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert,
  ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam,
  abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note,
  cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp,
  abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg,
  retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  -- Quote
  INSERT INTO P205_QUOTE
  SELECT cod_contratto, CodVoceCopia, cod_voce_speciale_da_quotare, cod_voce_in_quota,
         cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
  from P205_QUOTE t
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_DA_QUOTARE= CodVoceModello AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE';

  -- Assenze INPDAP
  INSERT INTO P206_ASSENZEINPDAP
  SELECT cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, elimina_sezione, 
         abbatte_ggutili, '2', cod_gestassic_noncoperte, cod_causasospensione, perc_asp_sindacale
  from P206_ASSENZEINPDAP t
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE= CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

  -- Descrizione voci con codice speciale 15075
  UPDATE P200_VOCI T
  SET T.DESCRIZIONE='Riduz. asp. non retr. politico/sindacale',
      T.DESCRIZIONE_STAMPA='Riduz. asp. non retr. politico/sindacale'
  WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_SPECIALE='15075';

END IF;

end;

/

insert into p205_quote
select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, '00380', cod_voce_speciale_in_quota,
       decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio from p205_quote t
where t.cod_contratto='EDP' and t.cod_voce_in_quota='00025' and t.accumulo=-100
and t.cod_voce_speciale_dettaglio is null and not exists
(select 'x' from p205_quote v where t.cod_contratto=v.cod_contratto and t.cod_voce_da_quotare=v.cod_voce_da_quotare
   and t.cod_voce_speciale_da_quotare=v.cod_voce_speciale_da_quotare and v.cod_voce_in_quota='00380'
   and t.cod_voce_speciale_in_quota=v.cod_voce_speciale_in_quota);

create table T325_RICHIESTESTR_GG (
  ID                   number(38) not null,
  PROGRESSIVO          number(8),
  DATA                 date,
  STATO                varchar2(1),
  DATA_RICHIESTA       date,
  NOTE1                varchar2(1000),
  NOTE2                varchar2(1000),
  RESPONSABILE         varchar2(30),
  DATA_AUTORIZZAZIONE  date,
  TIMBRATURE           varchar2(1000),
  ORE_LORDE            varchar2(6), -- +/-hh.mm
  ORE_CONTEGGIATE      varchar2(6), -- +/-hh.mm
  DEBITO               varchar2(5),
  DETR_MENSA           varchar2(5),
  RITARDO              varchar2(5)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T325_RICHIESTESTR_GG
  add constraint T325_PK primary key (ID)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T325_RICHIESTESTR_GG.ID
  is 'Identificativo univoco della richiesta';
comment on column T325_RICHIESTESTR_GG.STATO
  is 'Stato richiesta: I=Inserita, R=Richiesta, E=Elaborata, A=Annullata';
comment on column T325_RICHIESTESTR_GG.NOTE1
  is 'Note richiesta';
comment on column T325_RICHIESTESTR_GG.NOTE2
  is 'Note autorizzazione';
comment on column T325_RICHIESTESTR_GG.RESPONSABILE
  is 'Nome utente del responsabile che ha effettuato l''autorizzazione';
comment on column T325_RICHIESTESTR_GG.TIMBRATURE
  is 'Elenco delle timbrature effettive del giorno nel formato Vhh.mm(causale)-...';  
comment on column T325_RICHIESTESTR_GG.ORE_LORDE
  is 'Ore rese considerando anche quelle non autorizzate'; 
comment on column T325_RICHIESTESTR_GG.ORE_CONTEGGIATE
  is 'Ore effettivamente conteggiate';
comment on column T325_RICHIESTESTR_GG.DEBITO
  is 'Debito giornaliero';
comment on column T325_RICHIESTESTR_GG.DETR_MENSA
  is 'Detrazione pausa mensa';      

create index T325_PROGRESSIVO
  on T325_RICHIESTESTR_GG (PROGRESSIVO) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index T325_PROGR_DATA
  on T325_RICHIESTESTR_GG (PROGRESSIVO, DATA) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create sequence T325_ID MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE NOORDER NOCYCLE;

create table T326_RICHIESTESTR_SPEZ (
  ID                   number(38) not null,
  TIPO                 varchar2(1),
  ECCEDENZA            varchar2(5),
  SPEZ                 varchar2(11),
  CAUS_ORIG            varchar2(5),
  AUTORIZZAZIONE       varchar2(1),
  SPEZ_DALLE1         varchar2(5),
  SPEZ_ALLE1          varchar2(5),
  CAUS1               varchar2(5),
  SPEZ_DALLE2         varchar2(5),
  SPEZ_ALLE2          varchar2(5),
  CAUS2               varchar2(5),
  SPEZ_DALLE3         varchar2(5),
  SPEZ_ALLE3          varchar2(5),
  CAUS3               varchar2(5)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T326_RICHIESTESTR_SPEZ
  add constraint T326_PK primary key (ID, TIPO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T326_RICHIESTESTR_SPEZ
  add constraint T326_FK_T325 foreign key (ID)
  references T325_RICHIESTESTR_GG (ID) on delete cascade;

comment on column T326_RICHIESTESTR_SPEZ.ID
  is 'Identificativo della richiesta';
comment on column T326_RICHIESTESTR_SPEZ.TIPO
  is 'Tipologia dello spezzone: E = Entrata, U = Uscita';
comment on column T326_RICHIESTESTR_SPEZ.ECCEDENZA
  is 'Eccedenza oraria';
comment on column T326_RICHIESTESTR_SPEZ.SPEZ
  is 'Spezzone orario di riferimento dalle..alle';
comment on column T326_RICHIESTESTR_SPEZ.CAUS_ORIG
  is 'Causale richiesta originariamente dal dipendente';
comment on column T326_RICHIESTESTR_SPEZ.AUTORIZZAZIONE
  is 'S = Autorizzato,N = Non autorizzato,'' = da esaminare';
comment on column T326_RICHIESTESTR_SPEZ.SPEZ_DALLE1
  is 'Ora inizio suddivisione num. 1 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.SPEZ_ALLE1
  is 'Ora fine suddivisione num. 1 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.CAUS1
  is 'Causale suddivisione num. 1 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.SPEZ_DALLE2
  is 'Ora inizio suddivisione num. 2 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.SPEZ_ALLE2
  is 'Ora fine suddivisione num. 2 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.CAUS2
  is 'Causale suddivisione num. 2 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.SPEZ_DALLE3
  is 'Ora inizio suddivisione num. 3 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.SPEZ_ALLE3
  is 'Ora fine suddivisione num. 3 spezzone';  
comment on column T326_RICHIESTESTR_SPEZ.CAUS3
  is 'Causale suddivisione num. 3 spezzone';  

create table T085_RICHIESTECAMBIORARI
(
  PROGRESSIVO         NUMBER(8),
  DATA_RICHIESTA      DATE,
  DATA                DATE,
  TIPOGIORNO          VARCHAR2(1),
  ORARIO              VARCHAR2(5),
  TIPO_RICHIESTA      VARCHAR2(1),
  DATA_INVER          DATE,
  TIPOGIORNO_INVER    VARCHAR2(1),
  ORARIO_INVER        VARCHAR2(5),
  NOTE_RICHIESTA      VARCHAR2(1000),
  AUTORIZZAZIONE      VARCHAR2(1),
  RESPONSABILE        VARCHAR2(30),
  DATA_AUTORIZZAZIONE DATE,
  NOTE_AUTORIZ        VARCHAR2(1000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T085_RICHIESTECAMBIORARI.DATA_RICHIESTA
  is 'Data e ora di sistema in cui si registra la richiesta';
comment on column T085_RICHIESTECAMBIORARI.DATA
  is 'Giorno del cambio orario';
comment on column T085_RICHIESTECAMBIORARI.TIPOGIORNO
  is 'L=Lavorativo (bianco), N=Non lavorativo (verde) F=Festivo (giallo), T=Non lavorativo e festivo (azzurro) ';
comment on column T085_RICHIESTECAMBIORARI.ORARIO
  is 'Codice orario del giorno di richiesta cambio';
comment on column T085_RICHIESTECAMBIORARI.TIPO_RICHIESTA
  is 'I=Inversione giorno, C=Cambio orario, E=Inversione giorno e cambio orario';
comment on column T085_RICHIESTECAMBIORARI.DATA_INVER
  is 'Giorno con il quale invertire l''orario (forzato uguale a giorno richiesta se in base ai parametri aziendali non è possibile invertire i giorni)';
comment on column T085_RICHIESTECAMBIORARI.TIPOGIORNO_INVER
  is 'L=Lavorativo (bianco), N=Non lavorativo (verde) F=Festivo (giallo), T=Non lavorativo e festivo (azzurro) ';
comment on column T085_RICHIESTECAMBIORARI.ORARIO_INVER
  is 'Codice orario del giorno con il quale invertire l''orario';

comment on column T085_RICHIESTECAMBIORARI.NOTE_RICHIESTA
  is 'Note Richiesta';
comment on column T085_RICHIESTECAMBIORARI.AUTORIZZAZIONE
  is 'S = Autorizzato, N = Non autorizzato';
comment on column T085_RICHIESTECAMBIORARI.RESPONSABILE
  is 'Nome del Responsabile che ha autorizzato';
comment on column T085_RICHIESTECAMBIORARI.DATA_AUTORIZZAZIONE
  is 'Data e ora di sistema in cui si registra l''autorizzazione';
comment on column T085_RICHIESTECAMBIORARI.NOTE_AUTORIZ
  is 'Note Autorizzazione';

alter table T085_RICHIESTECAMBIORARI add constraint T085_PK primary key (PROGRESSIVO, DATA_RICHIESTA, DATA) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE T162_INDENNITA ADD SUPPL_5GGLAV VARCHAR2(1) DEFAULT 'N';
COMMENT ON COLUMN T162_INDENNITA.SUPPL_5GGLAV
  IS 'Indennità supplementare 5gg lavorativi: ogni gg in cui si rendono almeno 7.12 si matura 0,20 di indennità supplementare, ovvero 1 indennità supplementare ogni 5gg';
ALTER TABLE T072_SCHEDAINDPRES ADD INDSUPP_RESTO VARCHAR2(5);
COMMENT ON COLUMN T072_SCHEDAINDPRES.INDSUPP_RESTO
  IS 'Resto dell''indennità supplementare da considerare nel mese successivo';

alter table T162_INDENNITA add CAUPRES_RIEPORE varchar2(5);
comment on column T162_INDENNITA.CAUPRES_RIEPORE is 'Causale di presenza su cui si devono riepilogare mensilmente le ore rese relative a questa indennità';

-- attribuzione ID alle richieste di ass. non ancora elaborate
declare
  cursor c1 is 
    select t.*, rowid from T050_RICHIESTEASSENZA t
    where  ID is null
    and    ELABORATO = 'N'
    order by nvl(DATA_RICHIESTA,to_date('01011900','ddmmyyyy')), DAL, TIPOGIUST, nvl(NUMEROORE,'00.00');
  IdRich integer;
begin
  for t1 in c1 loop
    select T050_ID.nextval into IdRich from dual;
    update T050_RICHIESTEASSENZA 
    set    ID = IdRich
    where  rowid = t1.rowid;
    commit;
  end loop; 
end;
/
ALTER TABLE T390_CHIAMATE_REPERIB ADD UTENTE VARCHAR2(30) NOT NULL;
alter table T390_CHIAMATE_REPERIB drop primary key;
drop index T390_PK;
alter table T390_CHIAMATE_REPERIB
  add constraint T390_PK primary key (DATA,UTENTE,PROGRESSIVO_REPER) 
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
ALTER TABLE T390_CHIAMATE_REPERIB DROP COLUMN PROGRESSIVO_OPER;
comment on column T390_CHIAMATE_REPERIB.UTENTE is 'Operatore che effettua la chiamata';
