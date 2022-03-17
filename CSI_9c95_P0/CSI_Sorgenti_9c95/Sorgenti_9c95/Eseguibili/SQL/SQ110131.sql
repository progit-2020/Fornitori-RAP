update MONDOEDP.I090_ENTI set VERSIONEDB = '8.1',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

DECLARE
  TOT_DIP NUMBER :=0;
  MIN_MB  NUMBER :=0;
BEGIN
  SELECT COUNT(DISTINCT(PROGRESSIVO))
  INTO TOT_DIP
  FROM T430_STORICO 
  WHERE TRUNC(SYSDATE) BETWEEN INIZIO AND NVL(FINE,TRUNC(SYSDATE) + 1);
  IF TOT_DIP < 100 THEN
    MIN_MB:=100;
  ELSIF TOT_DIP < 2000 THEN
    MIN_MB:=300;
  ELSE
    MIN_MB:=500;
  END IF;
  UPDATE MONDOEDP.I091_DATIENTE
  SET DATO = MIN_MB
  WHERE AZIENDA = :AZIENDA
  AND TIPO = 'C27_TABLESPACE_FREE';
  IF SQL%ROWCOUNT = 0 THEN
  BEGIN
    INSERT INTO MONDOEDP.I091_DATIENTE 
    (AZIENDA, TIPO, DATO)
    VALUES 
    (:AZIENDA, 'C27_TABLESPACE_FREE', MIN_MB);
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
  END IF;
END;
/

comment on column P200_VOCI.STAMPA_CEDOLINO
  is 'Stampa su cedolino: S=Si'', N=No, D=Si'' se importo diverso da zero';

comment on column P552_CONTOANNREGOLE.TIPO_TABELLA_RIGHE
  is 'Tipologia righe tabella: 0=Qualifica ministeriale, 1=Altro dato libero, 2=Accorpamento voci, 3=Funzione Oracle';

ALTER TABLE SG101_FAMILIARI ADD NUMGRADO VARCHAR2(2);
comment on column SG101_FAMILIARI.NUMGRADO
  is 'Numero del grado di parentela: 1=Primo grado, 2=Secondo grado, 3=Terzo grado';
ALTER TABLE SG101_FAMILIARI ADD TIPOPAR VARCHAR2(1);
comment on column SG101_FAMILIARI.TIPOPAR
  is 'Tipo di parentela: P=Parente, A=Affine';
UPDATE SG101_FAMILIARI SET NUMGRADO = '1' WHERE GRADOPAR = 'FG';
UPDATE SG101_FAMILIARI SET TIPOPAR = 'P' WHERE GRADOPAR = 'FG';
UPDATE SG101_FAMILIARI SET NUMGRADO = '1' WHERE GRADOPAR = 'GT';
UPDATE SG101_FAMILIARI SET TIPOPAR = 'P' WHERE GRADOPAR = 'GT';
UPDATE SG101_FAMILIARI SET NUMGRADO = '2' WHERE GRADOPAR = 'FR';
UPDATE SG101_FAMILIARI SET TIPOPAR = 'P' WHERE GRADOPAR = 'FR';
UPDATE SG101_FAMILIARI SET NUMGRADO = '2' WHERE GRADOPAR = 'NP';
UPDATE SG101_FAMILIARI SET TIPOPAR = 'P' WHERE GRADOPAR = 'NP';

update p004_codicitabannuali t set t.descrizione=replace(t.descrizione, ' nel 2009 ', ' nel 2010 ')
where t.cod_tabannuale='770CAUSPAG' and t.cod_codicitabannuali='W' and t.anno=2010;

-- Creazione sindacato FIMMG Medici penitenziari AMAPI 12 mesi a importo fisso
declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  RitenutaCopia Number;
  CodVoceFiglio varchar2(5);
begin
  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12071' AND T.COD_VOCE_SPECIALE='BASE';
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12421' AND T.COD_VOCE_SPECIALE='BASE';
    if i = 0 then
  
      CodVoceModello:='12071';
      CodVoceCopia:='12421';
      DesVoceCopia:='FIMMG Medici penitenziari AMAPI';
      DesVoceCopiaSt:='FIMMG Medici penitenziari AMAPI';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

    end if;
  end if;
end;
/

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'MV025-006-2010-S2002','Dirigente medico incarico lett. c) con struttura complessa area medicina (dec. 2010) - semplice (dec. 2002)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='MV025-006-2010-S2002');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT 'EDP', 'INCARICO', 'MV025-006-2010-S2002', TO_DATE('01012010','DDMMYYYY'),
        'Dir. medico lett. c) con S.C. medicina (dec. 2010) - S.S. (dec. 2002)',
        '00208', 'BASE', 159.72, 'SSSSSSSSSSSS', TO_DATE('31123999','DDMMYYYY'), ''
           FROM DUAL WHERE NOT EXISTS
            (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
            AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-006-2010-S2002' AND T.COD_VOCE='00208');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT 'EDP', 'INCARICO', 'MV025-006-2010-S2002', TO_DATE('01012010','DDMMYYYY'),
        'Dir. medico lett. c) con S.C. medicina (dec. 2010) - S.S. (dec. 2002)',
        '00212', 'BASE', 540.05, 'SSSSSSSSSSSS', TO_DATE('31123999','DDMMYYYY'), ''
           FROM DUAL WHERE NOT EXISTS
            (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
            AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV025-006-2010-S2002' AND T.COD_VOCE='00212');

    end if;
  end if;
end;
/

update i501incarico t
set t.descrizione=replace(t.descrizione,'dec. 2010)','dec. 2010-2012)')
where t.descrizione like '%dec. 2010)%';

update p252_vociaggiuntiveimporti t
set t.descrizione=replace(t.descrizione,'dec. 2010)','dec. 2010-2012)')
where t.cod_contratto='EDP' and t.nome_voceaggiuntiva='INCARICO'
and t.descrizione like '%dec. 2010)%' and t.descrizione not like ('%-2012%');

alter table T430_STORICO add MEDICINA_LEGALE varchar2(10);
comment on column T430_STORICO.MEDICINA_LEGALE is 'Codice della medicina legale di competenza (ridefinisce le informazioni Postel sulla P500)';

insert into t033_layout
  (NOME,TOP,LFT,CAPTION,ACCESSO,NOMEPAGINA,CAMPODB)
select distinct NOME,211,8,'Medicina legale','S','Presenze/Assenze','MEDICINA_LEGALE'
from t033_layout;

alter table T047_VISITEFISCALI add MEDICINA_LEGALE varchar2(10);
comment on column T430_STORICO.MEDICINA_LEGALE is 'Codice della medicina legale di competenza';

insert into T001_PARAMETRIFUNZIONI (PROG, NOME, VALORE, PROGOPERATORE)
select 'A145', 'PROLUNGAMENTO','S',PROGOPERATORE
from   T001_PARAMETRIFUNZIONI
where  PROG = 'A145' 
and    NOME = 'INSERIMENTO'
and    VALORE = 'S';

alter table MONDOEDP.I061_PROFILI_DIPENDENTE add ULTIMO_ACCESSO date;
alter table MONDOEDP.I061_PROFILI_DIPENDENTE add ULTIMO_INVIO_MAIL date; 
comment on column MONDOEDP.I061_PROFILI_DIPENDENTE.ULTIMO_ACCESSO
  is 'Ora dell''ultimo accesso effettuato dall''utente';
comment on column MONDOEDP.I061_PROFILI_DIPENDENTE.ULTIMO_INVIO_MAIL
  is 'Ora dell''ultimo invio della mail di notifica all''utente';
insert into MONDOEDP.I091_DATIENTE select AZIENDA,'C90_EMAIL_RESP_OTTIMIZZATA', 'N' from MONDOEDP.I090_ENTI/*--NOLOG--*/;

DELETE MONDOEDP.I091_DATIENTE WHERE TIPO = 'C7_INCQUANTPROFILO';
ALTER TABLE T768_INCQUANTINDIVIDUALI ADD NUMORE_EXTRA VARCHAR2(6);
comment on column T768_INCQUANTINDIVIDUALI.NUMORE_EXTRA is 'Numero di ore extra budget';
ALTER TABLE T768_INCQUANTINDIVIDUALI DROP COLUMN PROG_VALUTATORE;
ALTER TABLE T770_QUOTE ADD TIPO_STAMPAQUANT VARCHAR2(1) DEFAULT '0';
comment on column T770_QUOTE.TIPO_STAMPAQUANT is 'Tipo di scheda quantitativa individuale da stampare (lato web)';
ALTER TABLE T768_INCQUANTINDIVIDUALI DROP COLUMN TOTQUOTAQUAL;
RENAME T761_INCQUANTPROFILI TO T761_OLD;
create table SG715_VALUT_POSIZIONATI
( PROGRESSIVO NUMBER not null,
  ANNO NUMBER not null,
  OBIETTIVO1 VARCHAR2(1000),
  PESO1 NUMBER,
  OBIETTIVO2 VARCHAR2(1000),
  PESO2 NUMBER,
  OBIETTIVO3 VARCHAR2(1000),
  PESO3 NUMBER,
  OBIETTIVO4 VARCHAR2(1000),
  PESO4 NUMBER)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
alter table SG715_VALUT_POSIZIONATI
  add constraint SG715_PK primary key (PROGRESSIVO,ANNO)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE T065_RICHIESTESTRAORDINARI ADD VALIDATORE VARCHAR2(30);
ALTER TABLE T065_RICHIESTESTRAORDINARI ADD DATA_VALIDAZIONE DATE;
ALTER TABLE T065_RICHIESTESTRAORDINARI ADD ORE_ECCED_VALID VARCHAR2(6);
ALTER TABLE T065_RICHIESTESTRAORDINARI ADD ORE_COMP_VALID VARCHAR2(6);
ALTER TABLE T065_RICHIESTESTRAORDINARI ADD ORE_LIQ_VALID VARCHAR2(6);
ALTER TABLE T065_RICHIESTESTRAORDINARI ADD NOTE_VALID VARCHAR2(1000);

comment on column T065_RICHIESTESTRAORDINARI.VALIDATORE
  is 'Nome del Validatore che ha validato';
comment on column T065_RICHIESTESTRAORDINARI.DATA_VALIDAZIONE
  is 'Data e ora di sistema in cui si registra la validazione';
comment on column T065_RICHIESTESTRAORDINARI.ORE_ECCED_VALID
  is 'Ore eccedenti validate';
comment on column T065_RICHIESTESTRAORDINARI.ORE_COMP_VALID
  is 'Ore compensabili validate';
comment on column T065_RICHIESTESTRAORDINARI.ORE_LIQ_VALID
  is 'Ore liquidabili validate';
comment on column T065_RICHIESTESTRAORDINARI.NOTE_VALID
  is 'Note Validazione';
comment on column T065_RICHIESTESTRAORDINARI.STATO
  is 'C=Calcolato il riepilogo, R=Richiedibile, A=Autorizzabile, V=Validato, I=In autorizzazione, S=Autorizzato';

insert into MONDOEDP.I091_DATIENTE select AZIENDA,'C90_EMAIL_SENDER_INDIRIZZO', 'irisweb@mondoedp.com' from MONDOEDP.I090_ENTI/*--NOLOG--*/;

alter table MONDOEDP.I091_DATIENTE MODIFY DATO VARCHAR2(200);
insert into MONDOEDP.I091_DATIENTE select AZIENDA,'C90_NOMEPROFILODELEGA', ':PROFILO' from MONDOEDP.I090_ENTI/*--NOLOG--*/;


ALTER TABLE T070_SCHEDARIEPIL ADD BANCAORE_LIQ_VAR VARCHAR2(7) DEFAULT '00.00';
comment on column T070_SCHEDARIEPIL.BANCAORE_LIQ_VAR is 'Variazione della banca ore liquidata';

alter table SG650_TESTATACORSI drop constraint SG650_PK;
drop index SG650_PK/*--NOLOG--*/;
alter table SG650_TESTATACORSI add constraint SG650_PK primary key (CODICE,EDIZIONE,DECORRENZA) using index tablespace INDICI;

update SG650_TESTATACORSI set DECORRENZA_FINE = DATA_FINE where DATA_FINE is not null;

delete from SG660_CALENDARIOCORSI where COD_CORSO not in (select CODICE from SG650_TESTATACORSI);
alter table SG660_CALENDARIOCORSI drop constraint SG660_PK;
drop index SG660_PK/*--NOLOG--*/;
alter table SG660_CALENDARIOCORSI add EDIZIONE varchar2(5); 
update SG660_CALENDARIOCORSI SG660 set EDIZIONE = (select min(EDIZIONE) from SG650_TESTATACORSI where CODICE = SG660.COD_CORSO and DECORRENZA = SG660.DECORRENZA);
alter table SG660_CALENDARIOCORSI add constraint SG660_PK primary key (COD_CORSO,EDIZIONE,NUMERO_GIORNO,DATA_GIORNO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table SG660_CALENDARIOCORSI modify DECORRENZA null/*--NOLOG--*/;

delete from SG651_PIANIFICAZIONECORSI where COD_CORSO not in (select CODICE from SG650_TESTATACORSI);
alter table SG651_PIANIFICAZIONECORSI drop constraint SG651_PK;
drop index SG651_PK/*--NOLOG--*/;
alter table SG651_PIANIFICAZIONECORSI add EDIZIONE varchar2(5); 
update SG651_PIANIFICAZIONECORSI SG651 set EDIZIONE = (select min(EDIZIONE) from SG650_TESTATACORSI where CODICE = SG651.COD_CORSO and DECORRENZA = SG651.DECORRENZA);
alter table SG651_PIANIFICAZIONECORSI add constraint SG651_PK primary key (COD_CORSO,EDIZIONE,PROGRESSIVO,NUMERO_GIORNO,DATA_CORSO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table SG651_PIANIFICAZIONECORSI modify DECORRENZA null/*--NOLOG--*/;

delete from SG662_COSTICORSI where COD_CORSO not in (select CODICE from SG650_TESTATACORSI);
alter table SG662_COSTICORSI drop constraint SG662_PK;
drop index SG662_PK/*--NOLOG--*/;
alter table SG662_COSTICORSI add EDIZIONE varchar2(5); 
update SG662_COSTICORSI SG662 set EDIZIONE = (select min(EDIZIONE) from SG650_TESTATACORSI where CODICE = SG662.COD_CORSO and DECORRENZA = SG662.DECORRENZA);
alter table SG662_COSTICORSI add constraint SG662_PK primary key (COD_CORSO,EDIZIONE,CODTIPOCOSTO,TIPO_COSTO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table SG662_COSTICORSI modify DECORRENZA null/*--NOLOG--*/;

delete from SG664_DOCENTI where COD_CORSO not in (select CODICE from SG650_TESTATACORSI);
alter table SG664_DOCENTI drop constraint SG664_PK;
drop index SG664_PK/*--NOLOG--*/;
alter table SG664_DOCENTI add EDIZIONE varchar2(5); 
update SG664_DOCENTI SG664 set EDIZIONE = (select min(EDIZIONE) from SG650_TESTATACORSI where CODICE = SG664.COD_CORSO and DECORRENZA = SG664.DECORRENZA);
alter table SG664_DOCENTI add constraint SG664_PK primary key (COD_CORSO,EDIZIONE,PROGRESSIVO,TIPO) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table SG664_DOCENTI modify DECORRENZA null/*--NOLOG--*/;

alter table T950_STAMPACARTELLINO add TIMBRATURE_MANUALI varchar2(1) default 'S';
comment on column T950_STAMPACARTELLINO.TIMBRATURE_MANUALI is 'S=timbrature manuali evidenziate in grassetto e minuscolo, N=timbrature manuali non evidenziate';

-- Voce 00455 (Congedo ordinario) resa dipendente da quote
update p200_voci t 
set t.importo_automatico='S', t.importo_automatico_tipo='Q', t.voce_quantita='S',
t.cod_misuraquantita='GG', t.stampa_competenza_quote='S', t.divisore_quote=26,
t.ridotta_parttime_vert='S', t.ridotta_parttime_orizz='S'
where t.cod_contratto='EDP' and t.cod_voce='00455' and t.cod_voce_speciale='BASE'
and t.importo_automatico='N';

insert into p205_quote
select cod_contratto, '00455', cod_voce_speciale_da_quotare, cod_voce_in_quota, cod_voce_speciale_in_quota, decorrenza, accumulo,
0 accumulo_rateo, cod_voce_speciale_dettaglio from p205_quote t 
where t.cod_contratto='EDP' and t.cod_voce_da_quotare='15100' and t.cod_voce_speciale_da_quotare='BASE'
and not exists
(select 'x' from p205_quote t1 where t1.cod_contratto=t.cod_contratto and t1.cod_voce_da_quotare='00455'
and t1.cod_voce_speciale_da_quotare=t.cod_voce_speciale_da_quotare and t1.cod_voce_in_quota=t.cod_voce_in_quota
and t1.cod_voce_speciale_in_quota=t.cod_voce_speciale_in_quota and t1.decorrenza=t.decorrenza);

update p205_quote t set t.accumulo_rateo=100
where t.cod_contratto='EDP' and t.cod_voce_da_quotare='00455' and t.cod_voce_speciale_da_quotare='BASE'
and exists
(select 'x' from p200_voci t1 where t1.cod_contratto=t.cod_contratto and t1.cod_voce=t.cod_voce_in_quota
and t1.cod_voce_speciale=t.cod_voce_speciale_in_quota and t1.perc_matura13a=100);

-- Creazione interrogazione di servizio PA_Ind_Art_42
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Ind_Art_42';
    if i = 0 then
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', -2, 'Data,Numero,Stringa', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', -1, '"31/01/2011","44276,33",*', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 0, 'SELECT T030.MATRICOLA,T030.COGNOME,T030.NOME,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 1, '       ROUND(LEAST(SUM(P272.IMPORTO+P272.IMPORTO*P200.PERC_MATURA13A/12/100),:MassimaleAnnuo/1.238/12)/30,5) IMPORTO_GG_IND_ART_42', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 2, 'FROM T030_ANAGRAFICO T030, P430_ANAGRAFICO P430, P272_RETRIBUZIONE_CONTRATTUALE P272,', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 3, '     P205_QUOTE P205, P200_VOCI P200', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 4, 'WHERE T030.MATRICOLA=:Matricola', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 5, 'AND P430.PROGRESSIVO=T030.PROGRESSIVO AND :DataCompetenza BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 6, 'AND P272.PROGRESSIVO=T030.PROGRESSIVO AND P272.COD_CONTRATTO=P430.COD_CONTRATTO', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 7, 'AND :DataCompetenza BETWEEN P272.DECORRENZA_INIZIO AND P272.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 8, 'AND P205.COD_CONTRATTO=P272.COD_CONTRATTO AND P205.COD_VOCE_DA_QUOTARE=''15034''', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 9, 'AND P205.COD_VOCE_SPECIALE_DA_QUOTARE=''BASE'' AND P205.COD_VOCE_IN_QUOTA=P272.COD_VOCE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 10, 'AND P205.COD_VOCE_SPECIALE_IN_QUOTA=P272.COD_VOCE_SPECIALE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 11, 'AND P200.COD_CONTRATTO=P205.COD_CONTRATTO AND P200.COD_VOCE=P205.COD_VOCE_IN_QUOTA', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 12, 'AND P200.COD_VOCE_SPECIALE=P205.COD_VOCE_SPECIALE_IN_QUOTA', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 13, 'AND :DataCompetenza BETWEEN P200.DECORRENZA AND P200.DECORRENZA_FINE', 'PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Ind_Art_42', 14, 'GROUP BY T030.MATRICOLA,T030.COGNOME,T030.NOME', 'PAGHE');
    end if;
  end if;
end;
/

alter table T690_ACQUISTOBUONI add DATA_MAGAZZINO date;
update T690_ACQUISTOBUONI T690 
set DATA_MAGAZZINO = (select max(DATA_ACQUISTO) from T691_MAGAZZINOBUONI where DATA_SCADENZA = T690.DATA_SCADENZA and T690.DATA between DATA_ACQUISTO and DATA_SCADENZA)
where DATA_SCADENZA is not null;

update T911_DATIRIEPILOGO set NOME = 'FORNITURABUONIPASTOACQUISTATI' where NOME = 'SCADENZABUONIPASTOACQUISTATI';
update T912_SORTRIEPILOGO set NOME = 'FORNITURABUONIPASTOACQUISTATI' where NOME = 'SCADENZABUONIPASTOACQUISTATI';
update T914_SERBATOIFILTRO set FILTRO = replace(FILTRO,'SCADENZABUONIPASTOACQUISTATI','FORNITURABUONIPASTOACQUISTATI') where instr(FILTRO,'SCADENZABUONIPASTOACQUISTATI') > 0;
update T909_DATICALCOLATI set ESPRESSIONE = replace(ESPRESSIONE,'SCADENZABUONIPASTOACQUISTATI','FORNITURABUONIPASTOACQUISTATI') where instr(ESPRESSIONE,'SCADENZABUONIPASTOACQUISTATI') > 0;

ALTER TABLE T767_INCQUANTGRUPPO MODIFY NUMORE_TOTALE VARCHAR2(9);

update t480_comuni set cap = '14013' where codice = '005026';
update t480_comuni set cap = '14044' where codice = '005032';
update t480_comuni set cap = '14054' where codice = '005041';
update t480_comuni set cap = '14013' where codice = '005045';
update t480_comuni set cap = '14026' where codice = '005051';
update t480_comuni set cap = '14031' where codice = '005056';
update t480_comuni set cap = '14051' where codice = '005060';
update t480_comuni set cap = '14048' where codice = '005074';
update t480_comuni set cap = '14026' where codice = '005086';
update t480_comuni set cap = '14042' where codice = '005095';
update t480_comuni set cap = '14058' where codice = '005105';
update t480_comuni set cap = '14020' where codice = '005107';
update t480_comuni set cap = '14049' where codice = '005111';
update t480_comuni set cap = '15026' where codice = '006031';
update t480_comuni set cap = '15054' where codice = '006067';
update t480_comuni set cap = '15056' where codice = '006083';
update t480_comuni set cap = '12070' where codice = '004098';
update t480_comuni set cap = '12052' where codice = '004148';
update t480_comuni set cap = '12077' where codice = '004178';
update t480_comuni set cap = '12050' where codice = '004226';
update t480_comuni set cap = '14022' where codice = '005002';
update t480_comuni set cap = '14046' where codice = '005010';
update t480_comuni set cap = '14010' where codice = '005018';
update t480_comuni set cap = '13010' where codice = '002066';
update t480_comuni set cap = '13046' where codice = '002067';
update t480_comuni set cap = '13034' where codice = '002070';
update t480_comuni set cap = '13045' where codice = '002072';
update t480_comuni set cap = '13020' where codice = '002078';
update t480_comuni set cap = '13047' where codice = '002088';
update t480_comuni set cap = '13012' where codice = '002104';
update t480_comuni set cap = '13026' where codice = '002111';
update t480_comuni set cap = '28064' where codice = '003083';
update t480_comuni set cap = '28064' where codice = '003138';
update t480_comuni set cap = '28010' where codice = '003140';
update t480_comuni set cap = '12074' where codice = '004021';
update t480_comuni set cap = '25082' where codice = '017023';
update t480_comuni set cap = '25050' where codice = '017054';
update t480_comuni set cap = '25074' where codice = '017087';
update t480_comuni set cap = '25050' where codice = '017094';
update t480_comuni set cap = '25040' where codice = '017124';
update t480_comuni set cap = '25078' where codice = '017140';
update t480_comuni set cap = '25040' where codice = '017175';
update t480_comuni set cap = '25048' where codice = '017181';
update t480_comuni set cap = '27040' where codice = '018002';
update t480_comuni set cap = '27010' where codice = '018006';
update t480_comuni set cap = '27040' where codice = '018020';
update t480_comuni set cap = '11020' where codice = '007017';
update t480_comuni set cap = '11020' where codice = '007019';
update t480_comuni set cap = '11010' where codice = '007057';
update t480_comuni set cap = '18035' where codice = '008002';
update t480_comuni set cap = '18020' where codice = '008003';
update t480_comuni set cap = '18020' where codice = '008005';
update t480_comuni set cap = '18020' where codice = '008012';
update t480_comuni set cap = '18022' where codice = '008018';
update t480_comuni set cap = '18027' where codice = '008019';
update t480_comuni set cap = '18027' where codice = '008020';
update t480_comuni set cap = '18017' where codice = '008021';
update t480_comuni set cap = '18023' where codice = '008023';
update t480_comuni set cap = '18013' where codice = '008025';
update t480_comuni set cap = '18013' where codice = '008026';
update t480_comuni set cap = '18013' where codice = '008028';
update t480_comuni set cap = '18020' where codice = '008030';
update t480_comuni set cap = '18035' where codice = '008032';
update t480_comuni set cap = '18020' where codice = '008033';
update t480_comuni set cap = '18032' where codice = '008040';
update t480_comuni set cap = '24040' where codice = '016063';
update t480_comuni set cap = '24026' where codice = '016067';
update t480_comuni set cap = '24060' where codice = '016068';
update t480_comuni set cap = '24020' where codice = '016080';
update t480_comuni set cap = '24060' where codice = '016094';
update t480_comuni set cap = '24069' where codice = '016130';
update t480_comuni set cap = '24030' where codice = '016143';
update t480_comuni set cap = '24020' where codice = '016175';
update t480_comuni set cap = '24010' where codice = '016229';
update t480_comuni set cap = '24060' where codice = '016244';
update t480_comuni set cap = '18024' where codice = '008046';
update t480_comuni set cap = '18020' where codice = '008048';
update t480_comuni set cap = '18026' where codice = '008049';
update t480_comuni set cap = '18036' where codice = '008053';
update t480_comuni set cap = '18036' where codice = '008058';
update t480_comuni set cap = '18026' where codice = '008066';
update t480_comuni set cap = '17011' where codice = '009004';
update t480_comuni set cap = '17051' where codice = '009006';
update t480_comuni set cap = '17057' where codice = '009009';
update t480_comuni set cap = '17028' where codice = '009010';
update t480_comuni set cap = '17054' where codice = '009011';
update t480_comuni set cap = '17052' where codice = '009012';
update t480_comuni set cap = '17045' where codice = '009014';
update t480_comuni set cap = '17057' where codice = '009017';
update t480_comuni set cap = '17056' where codice = '009023';
update t480_comuni set cap = '17017' where codice = '009026';
update t480_comuni set cap = '17058' where codice = '009027';
update t480_comuni set cap = '17027' where codice = '009031';
update t480_comuni set cap = '17053' where codice = '009033';
update t480_comuni set cap = '17045' where codice = '009036';
update t480_comuni set cap = '17013' where codice = '009040';
update t480_comuni set cap = '17037' where codice = '009043';
update t480_comuni set cap = '17024' where codice = '009044';
update t480_comuni set cap = '17043' where codice = '009047';
update t480_comuni set cap = '17042' where codice = '009051';
update t480_comuni set cap = '17047' where codice = '009052';
update t480_comuni set cap = '17044' where codice = '009058';
update t480_comuni set cap = '17055' where codice = '009061';
update t480_comuni set cap = '17048' where codice = '009063';
update t480_comuni set cap = '17032' where codice = '009066';
update t480_comuni set cap = '16040' where codice = '010042';
update t480_comuni set cap = '19033' where codice = '011011';
update t480_comuni set cap = '21020' where codice = '012023';
update t480_comuni set cap = '21020' where codice = '012095';
update t480_comuni set cap = '21020' where codice = '012116';
update t480_comuni set cap = '22010' where codice = '013092';
update t480_comuni set cap = '22010' where codice = '013130';
update t480_comuni set cap = '22040' where codice = '013153';
update t480_comuni set cap = '22010' where codice = '013218';
update t480_comuni set cap = '23010' where codice = '014002';
update t480_comuni set cap = '23020' where codice = '014028';
update t480_comuni set cap = '23024' where codice = '014035';
update t480_comuni set cap = '23020' where codice = '014042';
update t480_comuni set cap = '20864' where codice = '108001';
update t480_comuni set cap = '20886' where codice = '108002';
update t480_comuni set cap = '20847' where codice = '108003';
update t480_comuni set cap = '20862' where codice = '108004';
update t480_comuni set cap = '20090' where codice = '015011';
update t480_comuni set cap = '20825' where codice = '108005';
update t480_comuni set cap = '20080' where codice = '015015';
update t480_comuni set cap = '20882' where codice = '108006';
update t480_comuni set cap = '20881' where codice = '108007';
update t480_comuni set cap = '20842' where codice = '108008';
update t480_comuni set cap = '20853' where codice = '108009';
update t480_comuni set cap = '20813' where codice = '108010';
update t480_comuni set cap = '20836' where codice = '108011';
update t480_comuni set cap = '20861' where codice = '108012';
update t480_comuni set cap = '20080' where codice = '015035';
update t480_comuni set cap = '20875' where codice = '108013';
update t480_comuni set cap = '20874' where codice = '108051';
update t480_comuni set cap = '20080' where codice = '015042';
update t480_comuni set cap = '20857' where codice = '108014';
update t480_comuni set cap = '20867' where codice = '108052';
update t480_comuni set cap = '20841' where codice = '108015';
update t480_comuni set cap = '20866' where codice = '108016';
update t480_comuni set cap = '20873' where codice = '108017';
update t480_comuni set cap = '20816' where codice = '108018';
update t480_comuni set cap = '20070' where codice = '015071';
update t480_comuni set cap = '20811' where codice = '108019';
update t480_comuni set cap = '20815' where codice = '108020';
update t480_comuni set cap = '20863' where codice = '108021';
update t480_comuni set cap = '20872' where codice = '108053';
update t480_comuni set cap = '20856' where codice = '108022';
update t480_comuni set cap = '20832' where codice = '108023';
update t480_comuni set cap = '20070' where codice = '015101';
update t480_comuni set cap = '20833' where codice = '108024';
update t480_comuni set cap = '20824' where codice = '108025';
update t480_comuni set cap = '20823' where codice = '108054';
update t480_comuni set cap = '20855' where codice = '108026';
update t480_comuni set cap = '20812' where codice = '108027';
update t480_comuni set cap = '20851' where codice = '108028';
update t480_comuni set cap = '20846' where codice = '108029';
update t480_comuni set cap = '20821' where codice = '108030';
update t480_comuni set cap = '20883' where codice = '108031';
update t480_comuni set cap = '20826' where codice = '108032';
update t480_comuni set cap = '20900' where codice = '108033';
update t480_comuni set cap = '20835' where codice = '108034';
update t480_comuni set cap = '20834' where codice = '108035';
update t480_comuni set cap = '20876' where codice = '108036';
update t480_comuni set cap = '20060' where codice = '015177';
update t480_comuni set cap = '20838' where codice = '108037';
update t480_comuni set cap = '20877' where codice = '108055';
update t480_comuni set cap = '20885' where codice = '108038';
update t480_comuni set cap = '20070' where codice = '015202';
update t480_comuni set cap = '20831' where codice = '108039';
update t480_comuni set cap = '20822' where codice = '108040';
update t480_comuni set cap = '20845' where codice = '108041';
update t480_comuni set cap = '20884' where codice = '108042';
update t480_comuni set cap = '20060' where codice = '015219';
update t480_comuni set cap = '20844' where codice = '108043';
update t480_comuni set cap = '20865' where codice = '108044';
update t480_comuni set cap = '20814' where codice = '108045';
update t480_comuni set cap = '20854' where codice = '108046';
update t480_comuni set cap = '20837' where codice = '108047';
update t480_comuni set cap = '20843' where codice = '108048';
update t480_comuni set cap = '20080' where codice = '015236';
update t480_comuni set cap = '20852' where codice = '108049';
update t480_comuni set cap = '20871' where codice = '108050';
update t480_comuni set cap = '20070' where codice = '015244';
update t480_comuni set cap = '24010' where codice = '016027';
update t480_comuni set cap = '27040' where codice = '018025';
update t480_comuni set cap = '27040' where codice = '018026';
update t480_comuni set cap = '27010' where codice = '018043';
update t480_comuni set cap = '27010' where codice = '018071';
update t480_comuni set cap = '27040' where codice = '018082';
update t480_comuni set cap = '27042' where codice = '018124';
update t480_comuni set cap = '27040' where codice = '018125';
update t480_comuni set cap = '27010' where codice = '018127';
update t480_comuni set cap = '27053' where codice = '018174';
update t480_comuni set cap = '27010' where codice = '018185';
update t480_comuni set cap = '27017' where codice = '018188';
update t480_comuni set cap = '26010' where codice = '019011';
update t480_comuni set cap = '26010' where codice = '019024';
update t480_comuni set cap = '38028' where codice = '022154';
update t480_comuni set cap = '38050' where codice = '022157';
update t480_comuni set cap = '38059' where codice = '022165';
update t480_comuni set cap = '38011' where codice = '022170';
update t480_comuni set cap = '38012' where codice = '022186';
update t480_comuni set cap = '38050' where codice = '022202';
update t480_comuni set cap = '38049' where codice = '022212';
update t480_comuni set cap = '38057' where codice = '022216';
update t480_comuni set cap = '38059' where codice = '022221';
update t480_comuni set cap = '37015' where codice = '023077';
update t480_comuni set cap = '36045' where codice = '024003';
update t480_comuni set cap = '36047' where codice = '024065';
update t480_comuni set cap = '36024' where codice = '024069';
update t480_comuni set cap = '36021' where codice = '024117';
update t480_comuni set cap = '32016' where codice = '025020';
update t480_comuni set cap = '39030' where codice = '021063';
update t480_comuni set cap = '39029' where codice = '021095';
update t480_comuni set cap = '39020' where codice = '021103';
update t480_comuni set cap = '39030' where codice = '021109';
update t480_comuni set cap = '39040' where codice = '021114';
update t480_comuni set cap = '39040' where codice = '021116';
update t480_comuni set cap = '38011' where codice = '022004';
update t480_comuni set cap = '38049' where codice = '022023';
update t480_comuni set cap = '38028' where codice = '022030';
update t480_comuni set cap = '38011' where codice = '022076';
update t480_comuni set cap = '38087' where codice = '022100';
update t480_comuni set cap = '38069' where codice = '022124';
update t480_comuni set cap = '38024' where codice = '022136';
update t480_comuni set cap = '38079' where codice = '022138';
update t480_comuni set cap = '34072' where codice = '031005';
update t480_comuni set cap = '34076' where codice = '031011';
update t480_comuni set cap = '34011' where codice = '032001';
update t480_comuni set cap = '43056' where codice = '034041';
update t480_comuni set cap = '31024' where codice = '026052';
update t480_comuni set cap = '31017' where codice = '026054';
update t480_comuni set cap = '31040' where codice = '026060';
update t480_comuni set cap = '31020' where codice = '026091';
update t480_comuni set cap = '30020' where codice = '027015';
update t480_comuni set cap = '30025' where codice = '027016';
update t480_comuni set cap = '30025' where codice = '027040';
update t480_comuni set cap = '35046' where codice = '028074';
update t480_comuni set cap = '33048' where codice = '030024';
update t480_comuni set cap = '33029' where codice = '030047';
update t480_comuni set cap = '33029' where codice = '030089';
update t480_comuni set cap = '26020' where codice = '019104';
update t480_comuni set cap = '39010' where codice = '021002';
update t480_comuni set cap = '39036' where codice = '021006';
update t480_comuni set cap = '39030' where codice = '021009';
update t480_comuni set cap = '39052' where codice = '021015';
update t480_comuni set cap = '39053' where codice = '021023';
update t480_comuni set cap = '39027' where codice = '021027';
update t480_comuni set cap = '81035' where codice = '061050';
update t480_comuni set cap = '81013' where codice = '061056';
update t480_comuni set cap = '81040' where codice = '061059';
update t480_comuni set cap = '81040' where codice = '061061';
update t480_comuni set cap = '81017' where codice = '061066';
update t480_comuni set cap = '81020' where codice = '061067';
update t480_comuni set cap = '81040' where codice = '061069';
update t480_comuni set cap = '81051' where codice = '061071';
update t480_comuni set cap = '81042' where codice = '061072';
update t480_comuni set cap = '81049' where codice = '061079';
update t480_comuni set cap = '81016' where codice = '061080';
update t480_comuni set cap = '81044' where codice = '061093';
update t480_comuni set cap = '81041' where codice = '061100';
update t480_comuni set cap = '81030' where codice = '061103';
update t480_comuni set cap = '82030' where codice = '062004';
update t480_comuni set cap = '82011' where codice = '062005';
update t480_comuni set cap = '82018' where codice = '062012';
update t480_comuni set cap = '82027' where codice = '062015';
update t480_comuni set cap = '82024' where codice = '062017';
update t480_comuni set cap = '82037' where codice = '062019';
update t480_comuni set cap = '82010' where codice = '062022';
update t480_comuni set cap = '82011' where codice = '062032';
update t480_comuni set cap = '82011' where codice = '062048';
update t480_comuni set cap = '82034' where codice = '062062';
update t480_comuni set cap = '82034' where codice = '062063';
update t480_comuni set cap = '82018' where codice = '062066';
update t480_comuni set cap = '82030' where codice = '062068';
update t480_comuni set cap = '82026' where codice = '062072';
update t480_comuni set cap = '82021' where codice = '062078';
update t480_comuni set cap = '80077' where codice = '063037';
update t480_comuni set cap = '40060' where codice = '037025';
update t480_comuni set cap = '40045' where codice = '037029';
update t480_comuni set cap = '40051' where codice = '037035';
update t480_comuni set cap = '47043' where codice = '040016';
update t480_comuni set cap = '61040' where codice = '041004';
update t480_comuni set cap = '61026' where codice = '041005';
update t480_comuni set cap = '61021' where codice = '041017';
update t480_comuni set cap = '61026' where codice = '041022';
update t480_comuni set cap = '61024' where codice = '041032';
update t480_comuni set cap = '00030' where codice = '058119';
update t480_comuni set cap = '00054' where codice = '058120';
update t480_comuni set cap = '04013' where codice = '059027';
update t480_comuni set cap = '81059' where codice = '061008';
update t480_comuni set cap = '81050' where codice = '061011';
update t480_comuni set cap = '81016' where codice = '061025';
update t480_comuni set cap = '81023' where codice = '061028';
update t480_comuni set cap = '81014' where codice = '061034';
update t480_comuni set cap = '81050' where codice = '061036';
update t480_comuni set cap = '81044' where codice = '061039';
update t480_comuni set cap = '81042' where codice = '061040';
update t480_comuni set cap = '61049' where codice = '041041';
update t480_comuni set cap = '61023' where codice = '041048';
update t480_comuni set cap = '61013' where codice = '041060';
update t480_comuni set cap = '62035' where codice = '043001';
update t480_comuni set cap = '62020' where codice = '043004';
update t480_comuni set cap = '62035' where codice = '043005';
update t480_comuni set cap = '62039' where codice = '043010';
update t480_comuni set cap = '62024' where codice = '043016';
update t480_comuni set cap = '62035' where codice = '043017';
update t480_comuni set cap = '62035' where codice = '043018';
update t480_comuni set cap = '62025' where codice = '043019';
update t480_comuni set cap = '62022' where codice = '043020';
update t480_comuni set cap = '62036' where codice = '043027';
update t480_comuni set cap = '62014' where codice = '043036';
update t480_comuni set cap = '62021' where codice = '043040';
update t480_comuni set cap = '62025' where codice = '043050';
update t480_comuni set cap = '62039' where codice = '043056';
update t480_comuni set cap = '63095' where codice = '044001';
update t480_comuni set cap = '63075' where codice = '044002';
update t480_comuni set cap = '63824' where codice = '109001';
update t480_comuni set cap = '63857' where codice = '109002';
update t480_comuni set cap = '63083' where codice = '044005';
update t480_comuni set cap = '63096' where codice = '044006';
update t480_comuni set cap = '63838' where codice = '109003';
update t480_comuni set cap = '63828' where codice = '109004';
update t480_comuni set cap = '63063' where codice = '044010';
update t480_comuni set cap = '63082' where codice = '044011';
update t480_comuni set cap = '63072' where codice = '044012';
update t480_comuni set cap = '63081' where codice = '044013';
update t480_comuni set cap = '63079' where codice = '044014';
update t480_comuni set cap = '63087' where codice = '044015';
update t480_comuni set cap = '63067' where codice = '044016';
update t480_comuni set cap = '63064' where codice = '044017';
update t480_comuni set cap = '63837' where codice = '109005';
update t480_comuni set cap = '63900' where codice = '109006';
update t480_comuni set cap = '63084' where codice = '044020';
update t480_comuni set cap = '63086' where codice = '044021';
update t480_comuni set cap = '63816' where codice = '109007';
update t480_comuni set cap = '63066' where codice = '044023';
update t480_comuni set cap = '63844' where codice = '109008';
update t480_comuni set cap = '63823' where codice = '109009';
update t480_comuni set cap = '63832' where codice = '109010';
update t480_comuni set cap = '63085' where codice = '044027';
update t480_comuni set cap = '63834' where codice = '109011';
update t480_comuni set cap = '63061' where codice = '044029';
update t480_comuni set cap = '63842' where codice = '109012';
update t480_comuni set cap = '63077' where codice = '044031';
update t480_comuni set cap = '63068' where codice = '044032';
update t480_comuni set cap = '63835' where codice = '109013';
update t480_comuni set cap = '63069' where codice = '044034';
update t480_comuni set cap = '63855' where codice = '109014';
update t480_comuni set cap = '63062' where codice = '044036';
update t480_comuni set cap = '63858' where codice = '109015';
update t480_comuni set cap = '63094' where codice = '044038';
update t480_comuni set cap = '63846' where codice = '109016';
update t480_comuni set cap = '63833' where codice = '109017';
update t480_comuni set cap = '63812' where codice = '109018';
update t480_comuni set cap = '63841' where codice = '109019';
update t480_comuni set cap = '63853' where codice = '109020';
update t480_comuni set cap = '63088' where codice = '044044';
update t480_comuni set cap = '63076' where codice = '044045';
update t480_comuni set cap = '63852' where codice = '109021';
update t480_comuni set cap = '63825' where codice = '109022';
update t480_comuni set cap = '63815' where codice = '109023';
update t480_comuni set cap = '63813' where codice = '109024';
update t480_comuni set cap = '63847' where codice = '109025';
update t480_comuni set cap = '63836' where codice = '109026';
update t480_comuni set cap = '63843' where codice = '109027';
update t480_comuni set cap = '63826' where codice = '109028';
update t480_comuni set cap = '63073' where codice = '044054';
update t480_comuni set cap = '63851' where codice = '109029';
update t480_comuni set cap = '63092' where codice = '044056';
update t480_comuni set cap = '63827' where codice = '109030';
update t480_comuni set cap = '63848' where codice = '109031';
update t480_comuni set cap = '63845' where codice = '109032';
update t480_comuni set cap = '63822' where codice = '109033';
update t480_comuni set cap = '63821' where codice = '109034';
update t480_comuni set cap = '63831' where codice = '109035';
update t480_comuni set cap = '63065' where codice = '044063';
update t480_comuni set cap = '63093' where codice = '044064';
update t480_comuni set cap = '63071' where codice = '044065';
update t480_comuni set cap = '63074' where codice = '044066';
update t480_comuni set cap = '63854' where codice = '109036';
update t480_comuni set cap = '63811' where codice = '109037';
update t480_comuni set cap = '63839' where codice = '109038';
update t480_comuni set cap = '63856' where codice = '109039';
update t480_comuni set cap = '63078' where codice = '044071';
update t480_comuni set cap = '63814' where codice = '109040';
update t480_comuni set cap = '63091' where codice = '044073';
update t480_comuni set cap = '55034' where codice = '046019';
update t480_comuni set cap = '51010' where codice = '047021';
update t480_comuni set cap = '51013' where codice = '047022';
update t480_comuni set cap = '50050' where codice = '048008';
update t480_comuni set cap = '50036' where codice = '048046';
update t480_comuni set cap = '56012' where codice = '050004';
update t480_comuni set cap = '56034' where codice = '050012';
update t480_comuni set cap = '56040' where codice = '050013';
update t480_comuni set cap = '56043' where codice = '050018';
update t480_comuni set cap = '56028' where codice = '050032';
update t480_comuni set cap = '52041' where codice = '051016';
update t480_comuni set cap = '06041' where codice = '054010';
update t480_comuni set cap = '02045' where codice = '057031';
update t480_comuni set cap = '80040' where codice = '063092';
update t480_comuni set cap = '86021' where codice = '070003';
update t480_comuni set cap = '86025' where codice = '070059';
update t480_comuni set cap = '76016' where codice = '110005';
update t480_comuni set cap = '76017' where codice = '110007';
update t480_comuni set cap = '76015' where codice = '110010';
update t480_comuni set cap = '76123' where codice = '110001';
update t480_comuni set cap = '76121' where codice = '110002';
update t480_comuni set cap = '76011' where codice = '110003';
update t480_comuni set cap = '76012' where codice = '110004';
update t480_comuni set cap = '76013' where codice = '110006';
update t480_comuni set cap = '76014' where codice = '110008';
update t480_comuni set cap = '76125' where codice = '110009';
update t480_comuni set cap = '73040' where codice = '075077';
update t480_comuni set cap = '64043' where codice = '067023';
update t480_comuni set cap = '65025' where codice = '068040';
update t480_comuni set cap = '66044' where codice = '069002';
update t480_comuni set cap = '66043' where codice = '069017';
update t480_comuni set cap = '66040' where codice = '069019';
update t480_comuni set cap = '98057' where codice = '083049';
update t480_comuni set cap = '85034' where codice = '076031';
update t480_comuni set cap = '85050' where codice = '076081';
update t480_comuni set cap = '85032' where codice = '076087';
update t480_comuni set cap = '88055' where codice = '079002';
update t480_comuni set cap = '88060' where codice = '079008';
update t480_comuni set cap = '88067' where codice = '079024';
update t480_comuni set cap = '88067' where codice = '079025';
update t480_comuni set cap = '88040' where codice = '079048';
update t480_comuni set cap = '88044' where codice = '079072';
update t480_comuni set cap = '88067' where codice = '079088';
update t480_comuni set cap = '88050' where codice = '079089';
update t480_comuni set cap = '88021' where codice = '079108';
update t480_comuni set cap = '88025' where codice = '079114';
update t480_comuni set cap = '88060' where codice = '079118';
update t480_comuni set cap = '88069' where codice = '079143';
update t480_comuni set cap = '89030' where codice = '080001';
update t480_comuni set cap = '89038' where codice = '080056';
update t480_comuni set cap = '07030' where codice = '090088';
update t480_comuni set cap = '08016' where codice = '091011';
update t480_comuni set cap = '08020' where codice = '091104';
update t480_comuni set cap = '09040' where codice = '092036';
update t480_comuni set cap = '09040' where codice = '092064';
update t480_comuni set cap = '09020' where codice = '092088';
update t480_comuni set cap = '09034' where codice = '092101';
update t480_comuni set cap = '09030' where codice = '092108';
update t480_comuni set cap = '09042' where codice = '092109';
update t480_comuni set cap = '33098' where codice = '093003';
update t480_comuni set cap = '33090' where codice = '093011';
update t480_comuni set cap = '33092' where codice = '093012';
update t480_comuni set cap = '33075' where codice = '093018';
update t480_comuni set cap = '33092' where codice = '093026';
update t480_comuni set cap = '33098' where codice = '093039';
update t480_comuni set cap = '86091' where codice = '094003';
update t480_comuni set cap = '86097' where codice = '094015';
update t480_comuni set cap = '86071' where codice = '094036';
update t480_comuni set cap = '86092' where codice = '094040';
update t480_comuni set cap = '86096' where codice = '094045';
update t480_comuni set cap = '86095' where codice = '094047';
update t480_comuni set cap = '86097' where codice = '094049';
update t480_comuni set cap = '09070' where codice = '095002';
update t480_comuni set cap = '09090' where codice = '095003';
update t480_comuni set cap = '09091' where codice = '095004';
update t480_comuni set cap = '09080' where codice = '095005';
update t480_comuni set cap = '09092' where codice = '095006';
update t480_comuni set cap = '09081' where codice = '095007';
update t480_comuni set cap = '09080' where codice = '095008';
update t480_comuni set cap = '09080' where codice = '095009';
update t480_comuni set cap = '09090' where codice = '095010';
update t480_comuni set cap = '09070' where codice = '095011';
update t480_comuni set cap = '09090' where codice = '095012';
update t480_comuni set cap = '09070' where codice = '095013';
update t480_comuni set cap = '09080' where codice = '095014';
update t480_comuni set cap = '09070' where codice = '095015';
update t480_comuni set cap = '09080' where codice = '095016';
update t480_comuni set cap = '09082' where codice = '095017';
update t480_comuni set cap = '09073' where codice = '095019';
update t480_comuni set cap = '09094' where codice = '095025';
update t480_comuni set cap = '09088' where codice = '095037';
update t480_comuni set cap = '09093' where codice = '095042';
update t480_comuni set cap = '09088' where codice = '095059';
update t480_comuni set cap = '09080' where codice = '095064';
update t480_comuni set cap = '09098' where codice = '095065';
update t480_comuni set cap = '09070' where codice = '095066';
update t480_comuni set cap = '09079' where codice = '095067';
update t480_comuni set cap = '09080' where codice = '095068';
update t480_comuni set cap = '09099' where codice = '095069';
update t480_comuni set cap = '09090' where codice = '095070';
update t480_comuni set cap = '09084' where codice = '095071';
update t480_comuni set cap = '09080' where codice = '095072';
update t480_comuni set cap = '09090' where codice = '095073';
update t480_comuni set cap = '09070' where codice = '095074';
update t480_comuni set cap = '09070' where codice = '095075';
update t480_comuni set cap = '09080' where codice = '095078';
update t480_comuni set cap = '13861' where codice = '096001';
update t480_comuni set cap = '13811' where codice = '096002';
update t480_comuni set cap = '13871' where codice = '096003';
update t480_comuni set cap = '13900' where codice = '096004';
update t480_comuni set cap = '13841' where codice = '096005';
update t480_comuni set cap = '13872' where codice = '096006';
update t480_comuni set cap = '13862' where codice = '096007';
update t480_comuni set cap = '13821' where codice = '096008';
update t480_comuni set cap = '13821' where codice = '096009';
update t480_comuni set cap = '13891' where codice = '096010';
update t480_comuni set cap = '13812' where codice = '096011';
update t480_comuni set cap = '13878' where codice = '096012';
update t480_comuni set cap = '13864' where codice = '096013';
update t480_comuni set cap = '13866' where codice = '096014';
update t480_comuni set cap = '13851' where codice = '096015';
update t480_comuni set cap = '13881' where codice = '096016';
update t480_comuni set cap = '13852' where codice = '096017';
update t480_comuni set cap = '13882' where codice = '096018';
update t480_comuni set cap = '13863' where codice = '096019';
update t480_comuni set cap = '13836' where codice = '096020';
update t480_comuni set cap = '13864' where codice = '096021';
update t480_comuni set cap = '13853' where codice = '096022';
update t480_comuni set cap = '13865' where codice = '096023';
update t480_comuni set cap = '13893' where codice = '096024';
update t480_comuni set cap = '13881' where codice = '096025';
update t480_comuni set cap = '13894' where codice = '096026';
update t480_comuni set cap = '13874' where codice = '096027';
update t480_comuni set cap = '13895' where codice = '096028';
update t480_comuni set cap = '13853' where codice = '096029';
update t480_comuni set cap = '13887' where codice = '096030';
update t480_comuni set cap = '13873' where codice = '096031';
update t480_comuni set cap = '13866' where codice = '096032';
update t480_comuni set cap = '13831' where codice = '096033';
update t480_comuni set cap = '13816' where codice = '096034';
update t480_comuni set cap = '13888' where codice = '096035';
update t480_comuni set cap = '13874' where codice = '096037';
update t480_comuni set cap = '13895' where codice = '096038';
update t480_comuni set cap = '13896' where codice = '096039';
update t480_comuni set cap = '13897' where codice = '096040';
update t480_comuni set cap = '13898' where codice = '096041';
update t480_comuni set cap = '13843' where codice = '096042';
update t480_comuni set cap = '13844' where codice = '096043';
update t480_comuni set cap = '13812' where codice = '096044';
update t480_comuni set cap = '13814' where codice = '096046';
update t480_comuni set cap = '13875' where codice = '096047';
update t480_comuni set cap = '13833' where codice = '096048';
update t480_comuni set cap = '13899' where codice = '096049';
update t480_comuni set cap = '13867' where codice = '096050';
update t480_comuni set cap = '13854' where codice = '096051';
update t480_comuni set cap = '13812' where codice = '096052';
update t480_comuni set cap = '13845' where codice = '096053';
update t480_comuni set cap = '13883' where codice = '096054';
update t480_comuni set cap = '13815' where codice = '096055';
update t480_comuni set cap = '13816' where codice = '096056';
update t480_comuni set cap = '13884' where codice = '096057';
update t480_comuni set cap = '13885' where codice = '096058';
update t480_comuni set cap = '13876' where codice = '096059';
update t480_comuni set cap = '13812' where codice = '096060';
update t480_comuni set cap = '13841' where codice = '096061';
update t480_comuni set cap = '13834' where codice = '096062';
update t480_comuni set cap = '13817' where codice = '096063';
update t480_comuni set cap = '13868' where codice = '096064';
update t480_comuni set cap = '13823' where codice = '096065';
update t480_comuni set cap = '13811' where codice = '096066';
update t480_comuni set cap = '13844' where codice = '096067';
update t480_comuni set cap = '13818' where codice = '096068';
update t480_comuni set cap = '13884' where codice = '096069';
update t480_comuni set cap = '13835' where codice = '096070';
update t480_comuni set cap = '13855' where codice = '096071';
update t480_comuni set cap = '13847' where codice = '096072';
update t480_comuni set cap = '13825' where codice = '096073';
update t480_comuni set cap = '13847' where codice = '096074';
update t480_comuni set cap = '13824' where codice = '096075';
update t480_comuni set cap = '13871' where codice = '096076';
update t480_comuni set cap = '13856' where codice = '096077';
update t480_comuni set cap = '13868' where codice = '096078';
update t480_comuni set cap = '13877' where codice = '096079';
update t480_comuni set cap = '13886' where codice = '096080';
update t480_comuni set cap = '13887' where codice = '096081';
update t480_comuni set cap = '13888' where codice = '096082';
update t480_comuni set cap = '13848' where codice = '096083';
update t480_comuni set cap = '23821' where codice = '097001';
update t480_comuni set cap = '23881' where codice = '097002';
update t480_comuni set cap = '23841' where codice = '097003';
update t480_comuni set cap = '23811' where codice = '097004';
update t480_comuni set cap = '23890' where codice = '097005';
update t480_comuni set cap = '23891' where codice = '097006';
update t480_comuni set cap = '23816' where codice = '097007';
update t480_comuni set cap = '23822' where codice = '097008';
update t480_comuni set cap = '23842' where codice = '097009';
update t480_comuni set cap = '23883' where codice = '097010';
update t480_comuni set cap = '23892' where codice = '097011';
update t480_comuni set cap = '23885' where codice = '097012';
update t480_comuni set cap = '23801' where codice = '097013';
update t480_comuni set cap = '23802' where codice = '097014';
update t480_comuni set cap = '23831' where codice = '097015';
update t480_comuni set cap = '23880' where codice = '097016';
update t480_comuni set cap = '23893' where codice = '097017';
update t480_comuni set cap = '23817' where codice = '097018';
update t480_comuni set cap = '23884' where codice = '097019';
update t480_comuni set cap = '23870' where codice = '097020';
update t480_comuni set cap = '23861' where codice = '097021';
update t480_comuni set cap = '23862' where codice = '097022';
update t480_comuni set cap = '23823' where codice = '097023';
update t480_comuni set cap = '23886' where codice = '097024';
update t480_comuni set cap = '23813' where codice = '097025';
update t480_comuni set cap = '23845' where codice = '097026';
update t480_comuni set cap = '23832' where codice = '097027';
update t480_comuni set cap = '23894' where codice = '097028';
update t480_comuni set cap = '23814' where codice = '097029';
update t480_comuni set cap = '23824' where codice = '097030';
update t480_comuni set cap = '23843' where codice = '097031';
update t480_comuni set cap = '23824' where codice = '097032';
update t480_comuni set cap = '23848' where codice = '097033';
update t480_comuni set cap = '23805' where codice = '097034';
update t480_comuni set cap = '23825' where codice = '097035';
update t480_comuni set cap = '23851' where codice = '097036';
update t480_comuni set cap = '23846' where codice = '097037';
update t480_comuni set cap = '23852' where codice = '097038';
update t480_comuni set cap = '23898' where codice = '097039';
update t480_comuni set cap = '23815' where codice = '097040';
update t480_comuni set cap = '23835' where codice = '097041';
update t480_comuni set cap = '23900' where codice = '097042';
update t480_comuni set cap = '23827' where codice = '097043';
update t480_comuni set cap = '23871' where codice = '097044';
update t480_comuni set cap = '23864' where codice = '097045';
update t480_comuni set cap = '23826' where codice = '097046';
update t480_comuni set cap = '23832' where codice = '097047';
update t480_comuni set cap = '23807' where codice = '097048';
update t480_comuni set cap = '23873' where codice = '097049';
update t480_comuni set cap = '23817' where codice = '097050';
update t480_comuni set cap = '23847' where codice = '097051';
update t480_comuni set cap = '23804' where codice = '097052';
update t480_comuni set cap = '23874' where codice = '097053';
update t480_comuni set cap = '23876' where codice = '097054';
update t480_comuni set cap = '23811' where codice = '097055';
update t480_comuni set cap = '23895' where codice = '097056';
update t480_comuni set cap = '23848' where codice = '097057';
update t480_comuni set cap = '23887' where codice = '097058';
update t480_comuni set cap = '23854' where codice = '097059';
update t480_comuni set cap = '23865' where codice = '097060';
update t480_comuni set cap = '23875' where codice = '097061';
update t480_comuni set cap = '23877' where codice = '097062';
update t480_comuni set cap = '23833' where codice = '097063';
update t480_comuni set cap = '23837' where codice = '097064';
update t480_comuni set cap = '23818' where codice = '097065';
update t480_comuni set cap = '23888' where codice = '097066';
update t480_comuni set cap = '23828' where codice = '097067';
update t480_comuni set cap = '23855' where codice = '097068';
update t480_comuni set cap = '23834' where codice = '097069';
update t480_comuni set cap = '23819' where codice = '097070';
update t480_comuni set cap = '23899' where codice = '097071';
update t480_comuni set cap = '23849' where codice = '097072';
update t480_comuni set cap = '23888' where codice = '097073';
update t480_comuni set cap = '23889' where codice = '097074';
update t480_comuni set cap = '23844' where codice = '097075';
update t480_comuni set cap = '23896' where codice = '097076';
update t480_comuni set cap = '23835' where codice = '097077';
update t480_comuni set cap = '23867' where codice = '097078';
update t480_comuni set cap = '23837' where codice = '097079';
update t480_comuni set cap = '23806' where codice = '097080';
update t480_comuni set cap = '23836' where codice = '097081';
update t480_comuni set cap = '23857' where codice = '097082';
update t480_comuni set cap = '23868' where codice = '097083';
update t480_comuni set cap = '23829' where codice = '097084';
update t480_comuni set cap = '23838' where codice = '097085';
update t480_comuni set cap = '23808' where codice = '097086';
update t480_comuni set cap = '23879' where codice = '097087';
update t480_comuni set cap = '23878' where codice = '097088';
update t480_comuni set cap = '23822' where codice = '097089';
update t480_comuni set cap = '23897' where codice = '097090';
update t480_comuni set cap = '26834' where codice = '098001';
update t480_comuni set cap = '26821' where codice = '098002';
update t480_comuni set cap = '26811' where codice = '098003';
update t480_comuni set cap = '26812' where codice = '098004';
update t480_comuni set cap = '26851' where codice = '098005';
update t480_comuni set cap = '26822' where codice = '098006';
update t480_comuni set cap = '26823' where codice = '098007';
update t480_comuni set cap = '26852' where codice = '098008';
update t480_comuni set cap = '26831' where codice = '098009';
update t480_comuni set cap = '26841' where codice = '098010';
update t480_comuni set cap = '26842' where codice = '098011';
update t480_comuni set cap = '26853' where codice = '098012';
update t480_comuni set cap = '26843' where codice = '098013';
update t480_comuni set cap = '26823' where codice = '098014';
update t480_comuni set cap = '26866' where codice = '098015';
update t480_comuni set cap = '26844' where codice = '098016';
update t480_comuni set cap = '26824' where codice = '098017';
update t480_comuni set cap = '26832' where codice = '098018';
update t480_comuni set cap = '26845' where codice = '098019';
update t480_comuni set cap = '26833' where codice = '098020';
update t480_comuni set cap = '26854' where codice = '098021';
update t480_comuni set cap = '26846' where codice = '098022';
update t480_comuni set cap = '26842' where codice = '098023';
update t480_comuni set cap = '26834' where codice = '098024';
update t480_comuni set cap = '26835' where codice = '098025';
update t480_comuni set cap = '26861' where codice = '098026';
update t480_comuni set cap = '26832' where codice = '098027';
update t480_comuni set cap = '26813' where codice = '098028';
update t480_comuni set cap = '26862' where codice = '098029';
update t480_comuni set cap = '26814' where codice = '098030';
update t480_comuni set cap = '26900' where codice = '098031';
update t480_comuni set cap = '26855' where codice = '098032';
update t480_comuni set cap = '26843' where codice = '098033';
update t480_comuni set cap = '26825' where codice = '098034';
update t480_comuni set cap = '26847' where codice = '098035';
update t480_comuni set cap = '26866' where codice = '098036';
update t480_comuni set cap = '26815' where codice = '098037';
update t480_comuni set cap = '26843' where codice = '098038';
update t480_comuni set cap = '26833' where codice = '098039';
update t480_comuni set cap = '26836' where codice = '098040';
update t480_comuni set cap = '26837' where codice = '098041';
update t480_comuni set cap = '26863' where codice = '098042';
update t480_comuni set cap = '26864' where codice = '098043';
update t480_comuni set cap = '26816' where codice = '098044';
update t480_comuni set cap = '26854' where codice = '098045';
update t480_comuni set cap = '26857' where codice = '098046';
update t480_comuni set cap = '26848' where codice = '098047';
update t480_comuni set cap = '26817' where codice = '098048';
update t480_comuni set cap = '26865' where codice = '098049';
update t480_comuni set cap = '26866' where codice = '098050';
update t480_comuni set cap = '26849' where codice = '098051';
update t480_comuni set cap = '26826' where codice = '098052';
update t480_comuni set cap = '26856' where codice = '098053';
update t480_comuni set cap = '26867' where codice = '098054';
update t480_comuni set cap = '26858' where codice = '098055';
update t480_comuni set cap = '26838' where codice = '098056';
update t480_comuni set cap = '26827' where codice = '098057';
update t480_comuni set cap = '26828' where codice = '098058';
update t480_comuni set cap = '26859' where codice = '098059';
update t480_comuni set cap = '26818' where codice = '098060';
update t480_comuni set cap = '26839' where codice = '098061';
update t480_comuni set cap = '47814' where codice = '099001';
update t480_comuni set cap = '47841' where codice = '099002';
update t480_comuni set cap = '47853' where codice = '099003';
update t480_comuni set cap = '47855' where codice = '099004';
update t480_comuni set cap = '47843' where codice = '099005';
update t480_comuni set cap = '47836' where codice = '099006';
update t480_comuni set cap = '47854' where codice = '099007';
update t480_comuni set cap = '47834' where codice = '099008';
update t480_comuni set cap = '47837' where codice = '099009';
update t480_comuni set cap = '47854' where codice = '099010';
update t480_comuni set cap = '47833' where codice = '099011';
update t480_comuni set cap = '47824' where codice = '099012';
update t480_comuni set cap = '47838' where codice = '099013';
update t480_comuni set cap = '47835' where codice = '099015';
update t480_comuni set cap = '47832' where codice = '099016';
update t480_comuni set cap = '47842' where codice = '099017';
update t480_comuni set cap = '47822' where codice = '099018';
update t480_comuni set cap = '47825' where codice = '099019';
update t480_comuni set cap = '47826' where codice = '099020';
update t480_comuni set cap = '59025' where codice = '100001';
update t480_comuni set cap = '59015' where codice = '100002';
update t480_comuni set cap = '59013' where codice = '100003';
update t480_comuni set cap = '59016' where codice = '100004';
update t480_comuni set cap = '59100' where codice = '100005';
update t480_comuni set cap = '59021' where codice = '100006';
update t480_comuni set cap = '59024' where codice = '100007';
update t480_comuni set cap = '89832' where codice = '102001';
update t480_comuni set cap = '89818' where codice = '102005';
update t480_comuni set cap = '89823' where codice = '102010';
update t480_comuni set cap = '89841' where codice = '102012';
update t480_comuni set cap = '89843' where codice = '102013';
update t480_comuni set cap = '89863' where codice = '102018';
update t480_comuni set cap = '89843' where codice = '102020';
update t480_comuni set cap = '89823' where codice = '102022';
update t480_comuni set cap = '89819' where codice = '102023';
update t480_comuni set cap = '89824' where codice = '102024';
update t480_comuni set cap = '89861' where codice = '102026';
update t480_comuni set cap = '89812' where codice = '102027';
update t480_comuni set cap = '89834' where codice = '102028';
update t480_comuni set cap = '89853' where codice = '102034';
update t480_comuni set cap = '89843' where codice = '102036';
update t480_comuni set cap = '89831' where codice = '102039';
update t480_comuni set cap = '89831' where codice = '102040';
update t480_comuni set cap = '89861' where codice = '102044';
update t480_comuni set cap = '89834' where codice = '102046';
update t480_comuni set cap = '89867' where codice = '102050';
update t480_comuni set cap = '28811' where codice = '103003';
update t480_comuni set cap = '28899' where codice = '103004';
update t480_comuni set cap = '28812' where codice = '103005';
update t480_comuni set cap = '28871' where codice = '103007';
update t480_comuni set cap = '28813' where codice = '103009';
update t480_comuni set cap = '28832' where codice = '103010';
update t480_comuni set cap = '28851' where codice = '103011';
update t480_comuni set cap = '28833' where codice = '103013';
update t480_comuni set cap = '28873' where codice = '103014';
update t480_comuni set cap = '28814' where codice = '103015';
update t480_comuni set cap = '28822' where codice = '103017';
update t480_comuni set cap = '28825' where codice = '103020';
update t480_comuni set cap = '28845' where codice = '103028';
update t480_comuni set cap = '28853' where codice = '103029';
update t480_comuni set cap = '28863' where codice = '103031';
update t480_comuni set cap = '28823' where codice = '103033';
update t480_comuni set cap = '28836' where codice = '103034';
update t480_comuni set cap = '28883' where codice = '103035';
update t480_comuni set cap = '28893' where codice = '103038';
update t480_comuni set cap = '28864' where codice = '103046';
update t480_comuni set cap = '28891' where codice = '103048';
update t480_comuni set cap = '28887' where codice = '103050';
update t480_comuni set cap = '28885' where codice = '103053';
update t480_comuni set cap = '28886' where codice = '103054';
update t480_comuni set cap = '28866' where codice = '103056';
update t480_comuni set cap = '28803' where codice = '103057';
update t480_comuni set cap = '28896' where codice = '103059';
update t480_comuni set cap = '28804' where codice = '103061';
update t480_comuni set cap = '28843' where codice = '103063';
update t480_comuni set cap = '28838' where codice = '103064';
update t480_comuni set cap = '28868' where codice = '103067';
update t480_comuni set cap = '28819' where codice = '103074';
update t480_comuni set cap = '28844' where codice = '103075';

alter table T260_RAGGRASSENZE add CUMULA_RAGGR_BASE varchar2(1) default 'N';
comment on column T260_RAGGRASSENZE.CUMULA_RAGGR_BASE is 'S=il residuo viene cumulato con eventuali altri residui dove lo stesso raggruppamento è specificato in RAGGR_RESIDUO,  N=il residuo non viene calcolato se il raggruppamento è usato in RAGGR_RESIDUO'; 
