update MONDOEDP.I090_ENTI set VERSIONEDB = '8.5',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T262_PROFASSANN modify UMISURA default 'G';
alter table T263_PROFASSIND modify UMISURA default 'G';
alter table T263_PROFASSIND modify AGGIORNABILE default 'N';
alter table I500_DATILIBERI modify TABELLA default 'S';
alter table I500_DATILIBERI modify FORMATO default 'S';
alter table I500_DATILIBERI modify STORICO default 'N';
alter table I500_DATILIBERI modify SCADENZA default 'N';

alter table I090_ENTI modify UTENTE default 'MONDOEDP';
alter table I090_ENTI modify STORIAINTERVENTO default 'N';
alter table I090_ENTI modify TSLAVORO default 'LAVORO';
alter table I090_ENTI modify TSINDICI default 'INDICI';

alter table T262_PROFASSANN modify ARRFAV default 'F';
alter table T262_PROFASSANN modify MG default 'S';
alter table T262_PROFASSANN modify PROPORZIONE default '1';
alter table T262_PROFASSANN modify SOMMA default 'S';

alter table T010_CALENDIMPOSTAZ modify LUNEDI default 'S';
alter table T010_CALENDIMPOSTAZ modify MARTEDI default 'S';
alter table T010_CALENDIMPOSTAZ modify MERCOLEDI default 'S';
alter table T010_CALENDIMPOSTAZ modify GIOVEDI default 'S';
alter table T010_CALENDIMPOSTAZ modify VENERDI default 'S';
alter table T010_CALENDIMPOSTAZ modify SABATO default 'N';
alter table T010_CALENDIMPOSTAZ modify DOMENICA default 'N';

alter table T061_PLUSORAANNUO modify TIPODEBITO default 'M';
alter table T061_PLUSORAANNUO modify TIPOPO default '0';
alter table T061_PLUSORAANNUO modify ORE1 default '00.00';
alter table T061_PLUSORAANNUO modify ORE2 default '00.00';
alter table T061_PLUSORAANNUO modify ORE3 default '00.00';
alter table T061_PLUSORAANNUO modify ORE4 default '00.00';
alter table T061_PLUSORAANNUO modify ORE5 default '00.00';
alter table T061_PLUSORAANNUO modify ORE6 default '00.00';
alter table T061_PLUSORAANNUO modify ORE7 default '00.00';
alter table T061_PLUSORAANNUO modify ORE8 default '00.00';
alter table T061_PLUSORAANNUO modify ORE9 default '00.00';
alter table T061_PLUSORAANNUO modify ORE10 default '00.00';
alter table T061_PLUSORAANNUO modify ORE11 default '00.00';
alter table T061_PLUSORAANNUO modify ORE12 default '00.00';

alter table T300_RAGGRGIUSTIF modify CODINTERNO default 'Z';

alter table T200_CONTRATTI modify TIPO default 'USL';
alter table T200_CONTRATTI modify INDTURNO default 'A';

alter table I100_PARSCARICO modify CORRENTE default 'N';
alter table I100_PARSCARICO modify TCP default 'N';
alter table I100_PARSCARICO modify BADGE default '0,0';
alter table I100_PARSCARICO modify EDBADGE default '0,0';
alter table I100_PARSCARICO modify ANNO default '0,0';
alter table I100_PARSCARICO modify MESE default '0,0';
alter table I100_PARSCARICO modify GIORNO default '0,0';
alter table I100_PARSCARICO modify ORE default '0,0';
alter table I100_PARSCARICO modify MINUTI default '0,0';
alter table I100_PARSCARICO modify SECONDI default '0,0';
alter table I100_PARSCARICO modify VERSO default '0,0';
alter table I100_PARSCARICO modify RILEVATORE default '0,0';
alter table I100_PARSCARICO modify CAUSALE default '0,0';
alter table I100_PARSCARICO modify ENTRATA default '1';
alter table I100_PARSCARICO modify USCITA default '0';
alter table I100_PARSCARICO modify TIPOSCARICO default '0';

alter table T191_PARPAGHE modify TIPOFILE default 'F';
alter table T191_PARPAGHE modify FORMATOORE default '0';
alter table T191_PARPAGHE modify PRECISIONE default '0';

alter table T192_PARPAGHEDATI modify TIPO default '0';

alter table T361_OROLOGI modify FUNZIONE default 'P';

alter table T450_TIPORAPPORTO modify TIPO default 'R';

alter table T162_INDENNITA modify TIPO default 'Z';
alter table T162_INDENNITA modify NUMTURNI default 0;

alter table I150_PARSCARICOGIUST modify CODICE_TIPOI default 'I';
alter table I150_PARSCARICOGIUST modify CODICE_TIPOM default 'M';
alter table I150_PARSCARICOGIUST modify CODICE_TIPOD default 'D';
alter table I150_PARSCARICOGIUST modify CODICE_TIPON default 'N';
alter table I150_PARSCARICOGIUST modify CORRENTE default 'N';

alter table T670_REGOLEBUONI modify PASTO_TICKET default 'B';
alter table T670_REGOLEBUONI modify NONLAVORATIVO default 'N';
alter table T670_REGOLEBUONI modify ORARISPEZZATI default 'N';
alter table T670_REGOLEBUONI modify OREMINIME default TO_DATE('01011900','DDMMYYYY');

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'DR065-055-2009','Dirigente ruolo amministrativo equiparato con struttura semplice (dec. 2009)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='DR065-055-2009');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR065-055-2009', DECORRENZA, 'Dir. ruolo amministr. equiparato con S.S. (dec. 2009)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',265.06,16.44) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR075-055-2009' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR065-055-2009');

      INSERT INTO I501INCARICO SELECT 'DR065-050-2010-S2009','Dirigente ruolo amministrativo equiparato con struttura complessa (dec. 2010-2012) - semplice (dec. 2009)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='DR065-050-2010-S2009');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR065-050-2010-S2009', DECORRENZA, 'Dir. ruolo amministr. equiparato con S.C. (dec. 2010-2012) - S.S. (dec. 2009)', COD_VOCE, COD_VOCE_SPECIALE,
             DECODE(P252.COD_VOCE,'00212',898.92,16.44) IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR075-050-2010-S2009' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR065-050-2010-S2009');

    end if;
  end if;
end;
/
                  
-- CREAZIONE SINDACATI VARI
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12446';
CodVoceCopia:='12451';
DesVoceCopia:='Conflavoratori a importo fisso';
DesVoceCopiaSt:='Conflavoratori a importo fisso';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Conflavoratori a importo fisso
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

DesVoceCopia:='Conflavoratori a importo fisso 13a';
DesVoceCopiaSt:='Conflavoratori a importo fisso 13a';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

-----
-- Fine Conflavoratori a importo fisso
-----

  end if;
end if;
end;
/


alter table MONDOEDP.I071_PERMESSI add T100_CANC_ORIGINALI varchar2(1) default 'S';
comment on column MONDOEDP.I071_PERMESSI.T100_CANC_ORIGINALI is 'S=è possibile eliminare timbrature originali, N=non si possono cancellare timbrature originali';
comment on column MONDOEDP.I071_PERMESSI.CANCELLA_TIMBRATURE is 'S=è possibile eliminare timbrature manuali, N=non si possono cancellare timbrature manuali';

update MONDOEDP.I071_PERMESSI set T100_CANC_ORIGINALI = CANCELLA_TIMBRATURE;

create index T430I_PROGRESSIVO on t430_storico (progressivo);
create index T050I_PROG_ELAB on t050_richiesteassenza (progressivo, elaborato);

alter index T050_PROGRESSIVO rename to T050I_PROGRESSIVO;
alter index T050_PROGRESSIVO_DAL rename to T050I_PROG_DAL;
alter index T050_ID_REVOCA rename to T050I_IDREVOCA;

alter table MONDOEDP.I021_LOG_JOB add AZIENDA varchar2(30);
comment on column MONDOEDP.I021_LOG_JOB.AZIENDA is 'Azienda sulla quale è stata eseguita l''elaborazione';
alter table MONDOEDP.I021_LOG_JOB add TIPO varchar2(50);
comment on column MONDOEDP.I021_LOG_JOB.TIPO is 'Nome dell''elaborazione, che ha registrato il messaggio di log';

create table I000_BACKUP as select * from I000_LOGINFO where id = -1;
create table I001_BACKUP as select * from I001_LOGDATI where id = -1;

DECLARE
  CURSOR C1 IS
    SELECT CODICE 
    FROM   T910_RIEPILOGO 
    WHERE  CODICE <> TRIM(CODICE)
    ORDER BY CODICE;
 
  wNewCod  varchar2(20);
  wConta   integer;
BEGIN
  FOR T1 IN C1 LOOP
    wNewCod:=TRIM(T1.CODICE);
    
    -- verifica il caso sfortunato per cui il codice trimmato è già presente
    SELECT COUNT(*) INTO wConta
    FROM   T910_RIEPILOGO 
    WHERE  CODICE = wNewCod;
    
    -- tentativo di sostituire lo spazio con un underscore
    IF wConta > 0 THEN
      wNewCod:=REPLACE(wNewCod,' ','_');
    END IF;  
    
    -- operazione "atomica" di sostituzione
    BEGIN
      UPDATE T910_RIEPILOGO SET CODICE = wNewCod WHERE CODICE = T1.CODICE;
      UPDATE T909_DATICALCOLATI SET CODICE_STAMPA = wNewCod WHERE CODICE_STAMPA = T1.CODICE;
      UPDATE T911_DATIRIEPILOGO SET CODICE = wNewCod WHERE CODICE = T1.CODICE;
      UPDATE T912_SORTRIEPILOGO SET CODICE = wNewCod WHERE CODICE = T1.CODICE;
      UPDATE T913_SERBATOIKEY SET CODICE = wNewCod WHERE CODICE = T1.CODICE;
      UPDATE T914_SERBATOIFILTRO SET CODICE = wNewCod WHERE CODICE = T1.CODICE;
      UPDATE T915_CODICISELEZIONATI SET CODICE = wNewCod WHERE CODICE = T1.CODICE;
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
    END; 
  END LOOP;
END;
/

ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DATA_DA DATE;
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DATA_A DATE;
UPDATE SG740_REGOLE_VALUTAZIONI SET DATA_DA = ADD_MONTHS(DECORRENZA,12), DATA_A = ADD_MONTHS(DECORRENZA,24) - 1 WHERE DATA_DA IS NULL;
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DATA_DA_OBIETTIVI DATE;
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DATA_A_OBIETTIVI DATE;
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD COD_DATO_ASSEGN_OBIETTIVI VARCHAR2(400);
UPDATE SG740_REGOLE_VALUTAZIONI SET COD_DATO_ASSEGN_OBIETTIVI = '--' WHERE COD_DATO_ASSEGN_OBIETTIVI IS NULL;
ALTER TABLE SG710_TESTATA_VALUTAZIONI ADD IMPORTO_INCENTIVO NUMBER(8,2);
ALTER TABLE SG710_TESTATA_VALUTAZIONI ADD ORE_INCENTIVO VARCHAR2(7);
ALTER TABLE SG710_TESTATA_VALUTAZIONI ADD ACCETTAZIONE_OBIETTIVI VARCHAR2(1);
ALTER TABLE SG701_AREE_VALUTAZIONI ADD AREA_LIBERA VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG701_AREE_VALUTAZIONI ADD PESO_VARIABILE_ITEMS VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG701_AREE_VALUTAZIONI ADD TIPO_PUNTEGGIO_ITEMS VARCHAR2(1) DEFAULT '0';
ALTER TABLE SG711_VALUTAZIONI_DIPENDENTE ADD PERC_VALUTAZIONE NUMBER(5,2);
ALTER TABLE SG711_VALUTAZIONI_DIPENDENTE ADD SOGLIA_PUNTEGGIO VARCHAR2(5);
ALTER TABLE T767_INCQUANTGRUPPO ADD NUMORE_MIN_DIRIGENTI VARCHAR2(9);
ALTER TABLE T767_INCQUANTGRUPPO ADD IMPORTO_MAX_DIRIGENTI NUMBER;
ALTER TABLE T767_INCQUANTGRUPPO ADD TIPO_DIPENDENTI VARCHAR2(1) DEFAULT 'C';
comment on column T767_INCQUANTGRUPPO.TIPO_DIPENDENTI is 'C=Comparto, D=Dirigenza';

alter table I005_MSGINFO nologging;
alter table I006_MSGDATI nologging;
alter table I000_LOGINFO nologging;
alter table I001_LOGDATI nologging;
alter table IA000_LOGINTEGRAZIONE nologging;
alter table T030_NOTRIGGER nologging;

alter table T010_CALENDIMPOSTAZ add IGNORAFEST_AUTO VARCHAR2(1)  default 'N';
alter table T010_CALENDIMPOSTAZ add NUMGG_LAV NUMBER(1);
comment on column T010_CALENDIMPOSTAZ.IGNORAFEST_AUTO is 'S=vengono ignorate le festività italiane proposte dalla procedura GENERA_CALENDARIO.GENERACAL';
comment on column T010_CALENDIMPOSTAZ.NUMGG_LAV is 'numero gg lavorativi';

alter table T040_GIUSTIFICATIVI add NOTE varchar2(10);
comment on column T040_GIUSTIFICATIVI.NOTE is 'note del giustificativo';

alter table T260_RAGGRASSENZE add MAXRESIDUO_CORR_TIPO VARCHAR2(1) default 'N';
comment on column T260_RAGGRASSENZE.MAXRESIDUO_CORR_TIPO is 'N=nessun limite, C=competenze correnti / 2';

-- Data competenza su voci programmate
ALTER TABLE P254_VOCIPROGRAMMATE ADD DATA_COMPETENZA_FISSA DATE;
ALTER TABLE P254_VOCIPROGRAMMATE ADD MESI_COMPETENZA_PREC NUMBER;
comment on column P254_VOCIPROGRAMMATE.DATA_COMPETENZA_FISSA
  is 'Data di competenza fissa';
comment on column P254_VOCIPROGRAMMATE.MESI_COMPETENZA_PREC
  is 'Numero di mesi precedenti alla data retribuzione per impostazione data di competenza';


comment on column T460_PARTTIME.TIPO is 'O=orizzontale, V=verticale, C=ciclico';
ALTER TABLE T265_CAUASSENZE MODIFY PARTTIME VARCHAR2(3);
UPDATE T265_CAUASSENZE
SET PARTTIME = 'OVC'
WHERE PARTTIME = 'E';

alter table T265_CAUASSENZE add COMPETENZE_PERSONALIZZATE varchar2(1) default 'N';
comment on column T265_CAUASSENZE.COMPETENZE_PERSONALIZZATE is 'S=competenze calcolate dalla procedura T265P_GETCOMPETENZE, N=competenze definite sulle regole della causale';

alter table T262_PROFASSANN add COMPETENZE_PERSONALIZZATE varchar2(1) default 'N';
comment on column T262_PROFASSANN.COMPETENZE_PERSONALIZZATE is 'S=competenze calcolate dalla procedura T265P_GETCOMPETENZE, N=competenze definite sulle regole del profilo';

alter table T265_CAUASSENZE add ARROT_ORE2GG varchar2(1) default 'N';
comment on column T265_CAUASSENZE.ARROT_ORE2GG is 'arrotondamento delle ore trasformate in giornate: N=nessuno, I=giornata intera, M=mezza giornata';

alter table T710_BUDGETANNUO drop constraint T710_PK;

drop index T710_PK;

create table T710_BUDGETESTERNO_ANNUO
(
  ANNO          number(4),
  CAPITOLO      varchar2(15),
  ARTICOLO      varchar2(15),
  COEL          varchar2(15),
  STANZIAMENTO  number,
  DISPONIBILITA number,
  VARIAZIONE    number,
  DECORRENZA_VARIAZIONE date,
  SCADENZA_VARIAZIONE date
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T710_BUDGETESTERNO_ANNUO
  add constraint T710_PK primary key (ANNO, CAPITOLO, ARTICOLO, COEL)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create table M143_DETTAGLIOGG (
  ID     number(38) not null,
  DATA   date not null,
  DALLE  varchar2(5) not null,
  ALLE   varchar2(5),
  NOTE   varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M143_DETTAGLIOGG.ID is 'Identificativo univoco della richiesta di riferimento';
comment on column M143_DETTAGLIOGG.DATA is 'Data di riferimento';
comment on column M143_DETTAGLIOGG.DALLE is 'Ora di inizio del periodo di servizio';
comment on column M143_DETTAGLIOGG.ALLE is 'Ora di fine del periodo di servizio';
comment on column M143_DETTAGLIOGG.NOTE is 'Note relative alla attività svolta';

alter table M143_DETTAGLIOGG 
  add constraint M143_PK primary key (ID, DATA, DALLE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table M143_DETTAGLIOGG
  add constraint M143_FK_M140 foreign key (ID)
  references M140_RICHIESTE_MISSIONI (ID) on delete cascade;

create table M043_DETTAGLIOGG (
  ID     number(38) not null,
  DATA   date not null,
  DALLE  varchar2(5) not null,
  ALLE   varchar2(5),
  NOTE   varchar2(2000)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column M043_DETTAGLIOGG.ID is 'Identificativo univoco della missione di riferimento';
comment on column M043_DETTAGLIOGG.DATA is 'Data di riferimento';
comment on column M043_DETTAGLIOGG.DALLE is 'Ora di inizio del periodo di servizio';
comment on column M043_DETTAGLIOGG.ALLE is 'Ora di fine del periodo di servizio';
comment on column M043_DETTAGLIOGG.NOTE is 'Note relative alla attività svolta';

alter table M043_DETTAGLIOGG 
  add constraint M043_PK primary key (ID, DATA, DALLE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table M040_MISSIONI
  add constraint M040_UQ unique (ID_MISSIONE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
alter table M043_DETTAGLIOGG
  add constraint M043_FK_M040 foreign key (ID)
  references M040_MISSIONI (ID_MISSIONE) on delete cascade;

-- Note su cedolino voci
ALTER TABLE P442_CEDOLINOVOCI ADD NOTE VARCHAR2(50);
comment on column P442_CEDOLINOVOCI.NOTE is 'Note, riferimenti, delibere, ecc.';
ALTER TABLE P193_VOCIVARIABILIINPUT ADD NOTE VARCHAR2(50);
comment on column P193_VOCIVARIABILIINPUT.NOTE is 'Note, riferimenti, delibere, ecc.';

-- Gestione beneficiario
DROP TABLE P012_ENTIEROGATORI;

create table P012_BENEFICIARI
( COD_BENEFICIARIO VARCHAR2(5) not null,
  DESCRIZIONE      VARCHAR2(40),
  CODICE_FISCALE   VARCHAR2(16),
  PARTITA_IVA      VARCHAR2(11),
  INDIRIZZO        VARCHAR2(40),
  COMUNE           VARCHAR2(6),
  CAP              VARCHAR2(5),
  IBAN             VARCHAR2(32)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table P012_BENEFICIARI
  add constraint P012_PK primary key (COD_BENEFICIARIO)
   using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

ALTER TABLE P200_VOCI ADD COD_BENEFICIARIO VARCHAR2(5);
comment on column P200_VOCI.COD_BENEFICIARIO is 'Codice beneficiario di riferimento';

ALTER TABLE P254_VOCIPROGRAMMATE  ADD COD_BENEFICIARIO VARCHAR2(5);
comment on column P254_VOCIPROGRAMMATE.COD_BENEFICIARIO is 'Codice beneficiario di riferimento';

alter table P200_VOCI
  add constraint P200_FK_P012 foreign key (COD_BENEFICIARIO)
  references P012_BENEFICIARI (COD_BENEFICIARIO);

alter table P254_VOCIPROGRAMMATE
  add constraint P254_FK_P012 foreign key (COD_BENEFICIARIO)
  references P012_BENEFICIARI (COD_BENEFICIARIO);

alter table P500_CUDSETUP modify CODICE_FORMA_GIUR_DMA VARCHAR2(4);

UPDATE P202_RAGGRUPPAMENTOASSOGG SET BLOCCATO = 'S';
UPDATE P200_VOCI SET PROTETTA = 'S';

ALTER TABLE P500_CUDSETUP ADD CODICE_FORMA_GIUR_DMA2 VARCHAR2(4) DEFAULT '2500';
comment on column P500_CUDSETUP.CODICE_FORMA_GIUR_DMA2 is 'Codice forma giuridica dell''ente per modello D.M.A. 2';

ALTER TABLE P500_CUDSETUP ADD COD_CONTRATTO_DMA2 VARCHAR2(4) DEFAULT 'SSNA';
comment on column P500_CUDSETUP.COD_CONTRATTO_DMA2 is 'Codice contratto per modello D.M.A. 2';

comment on column P670_XMLREGOLE.ATTRIBUTO
  is 'Eventuale attributo fisso dell''elemento o codice di servizio per altri flussi (es. F24EP)';

alter table T275_CAUPRESENZE add NO_ECCED_IN_FASCIA_CONS_ASS varchar2(1) default 'N';
update T275_CAUPRESENZE set NO_ECCED_IN_FASCIA_CONS_ASS = 'S';
comment on column T275_CAUPRESENZE.NO_ECCED_IN_FASCIA_CONS_ASS is 'S=considera le ore rese da assenza nella gestione di NO_ECCEDENZA_IN_FASCIA, N=non considera le ore rese da assenza nella gestione di NO_ECCEDENZA_IN_FASCIA';

UPDATE t480_comuni t SET T.CITTA='AGLIANO TERME' WHERE T.CODCATASTALE='A072';
UPDATE t480_comuni t SET T.CITTA='BIBBIENA' WHERE T.CODCATASTALE='A851';
UPDATE t480_comuni t SET T.CITTA='RIVANAZZANO TERME' WHERE T.CODCATASTALE='H336';
UPDATE t480_comuni t SET T.CITTA='SANT''AMBROGIO DI VALPOLICELLA' WHERE T.CODCATASTALE='I259';
UPDATE t480_comuni t SET T.CITTA='VENARIA REALE' WHERE T.CODCATASTALE='L727';

declare
  i integer;
begin
  select COUNT(*) into i from P660_FLUSSIREGOLE t where t.nome_flusso='DMA';
  if i > 0 then

  delete P660_FLUSSIREGOLE t where t.nome_flusso='DMA' and t.parte='E1' and t.numero in ('009','010','011');

insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('DMA', to_date('01-01-2005', 'dd-mm-yyyy'), 'E1', '009', 'Data della sospensione o cessazione della contribuzione', 'C', 'E1', '009', 'DT', null, 'N', 'N', null, null, 'S', 'I', 'SELECT P430.DATA_SOSP_CESS_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione', 'SELECT P430.DATA_SOSP_CESS_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('DMA', to_date('01-01-2005', 'dd-mm-yyyy'), 'E1', '010', 'Motivo di sospensione', 'C', 'E1', '010', 'NP', null, 'N', 'S', null, null, 'S', 'I', 'SELECT P430.COD_INPDAPMOTIVOSOSP_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione', 'SELECT P430.COD_INPDAPMOTIVOSOSP_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('DMA', to_date('01-01-2005', 'dd-mm-yyyy'), 'E1', '011', 'Tipo di cessazione', 'C', 'E1', '011', 'NP', null, 'N', 'S', null, null, 'S', 'I', 'SELECT P430.COD_INPDAPTIPOCESS_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione', 'SELECT P430.COD_INPDAPTIPOCESS_FPC DATO FROM P430_ANAGRAFICO P430' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND NVL(P430.DATA_SOSP_CESS_FPC,TO_DATE(''31123999'',''DDMMYYYY'')) <= :DataElaborazione', 'N', null, null, null, null, null, null, null);

  end if;
end;
/

alter table P670_XMLREGOLE modify DATO_RIEPILOGATIVO VARCHAR2(2);
comment on column P670_XMLREGOLE.DATO_RIEPILOGATIVO
  is 'Dato riepilogativo aziendale: N=No, S1=Riepilogativo INPS, S2=Riepilogativo INPDAP, S3=Altri importi Z2 INPDAP';

UPDATE p670_xmlregole t SET T.DATO_RIEPILOGATIVO='S1' WHERE T.DATO_RIEPILOGATIVO='S';

UPDATE P004_CODICITABANNUALI T SET T.DESCRIZIONE='Versamento'
WHERE T.COD_TABANNUALE='DMATIPOPAM' AND T.COD_CODICITABANNUALI='V';
UPDATE P004_CODICITABANNUALI T SET T.DESCRIZIONE='Rimborso'
WHERE T.COD_TABANNUALE='DMATIPOPAM' AND T.COD_CODICITABANNUALI='R';

UPDATE P004_CODICITABANNUALI t SET T.COD_CODICITABANNUALI='001'
WHERE T.COD_TABANNUALE='IPCCESSFPC' AND T.COD_CODICITABANNUALI='1';
UPDATE P004_CODICITABANNUALI t SET T.COD_CODICITABANNUALI='002'
WHERE T.COD_TABANNUALE='IPCCESSFPC' AND T.COD_CODICITABANNUALI='2';

UPDATE P004_CODICITABANNUALI t SET T.COD_CODICITABANNUALI='002'
WHERE T.COD_TABANNUALE='IPMSOSPFPC' AND T.COD_CODICITABANNUALI='2';
UPDATE P004_CODICITABANNUALI t SET T.COD_CODICITABANNUALI='003'
WHERE T.COD_TABANNUALE='IPMSOSPFPC' AND T.COD_CODICITABANNUALI='3';
DELETE P004_CODICITABANNUALI t
WHERE T.COD_TABANNUALE='IPMSOSPFPC' AND T.COD_CODICITABANNUALI='1';

UPDATE P430_ANAGRAFICO T SET T.COD_INPDAPTIPOCESS_FPC='001'
WHERE T.COD_INPDAPTIPOCESS_FPC='1';
UPDATE P430_ANAGRAFICO T SET T.COD_INPDAPTIPOCESS_FPC='002'
WHERE T.COD_INPDAPTIPOCESS_FPC='2';

UPDATE P430_ANAGRAFICO T SET T.COD_INPDAPMOTIVOSOSP_FPC='002'
WHERE T.COD_INPDAPMOTIVOSOSP_FPC='2';
UPDATE P430_ANAGRAFICO T SET T.COD_INPDAPMOTIVOSOSP_FPC='003'
WHERE T.COD_INPDAPMOTIVOSOSP_FPC='1' OR T.COD_INPDAPMOTIVOSOSP_FPC='3';

UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Gestione Unitaria delle Prestazioni Creditizie e Sociali'
WHERE T.COD_TABANNUALE='IPGESASSIC' AND T.COD_CODICITABANNUALI='9';

UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Lavoratore privo della vista - L. 113/85, art. 9 comma 1 - L. 120/91, art. 2'
WHERE T.COD_TABANNUALE='IPMAGGIOR' AND T.COD_CODICITABANNUALI='19';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Lavoratori sordomuti e invalidi (L. 388/2000, art. 80, comma 3)'
WHERE T.COD_TABANNUALE='IPMAGGIOR' AND T.COD_CODICITABANNUALI='42';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Servizio all''estero con compiti di cooperazione con paesi in via di sviluppo in sedi disagiate (L. 49/87, art. 23)'
WHERE T.COD_TABANNUALE='IPMAGGIOR' AND T.COD_CODICITABANNUALI='45';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Servizio all''estero con compiti di cooperazione con paesi in via di sviluppo in sedi particolarmente disagiate (L. 49/87, art. 23)'
WHERE T.COD_TABANNUALE='IPMAGGIOR' AND T.COD_CODICITABANNUALI='46';

UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Soppressione di posto - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='8';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Dimissioni volontarie'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='12';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Passaggio ad altra amministrazione (mobilita'')'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='13';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Fine ferma - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='15';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Dispensa dal servizio per inabilita'' assoluta e permanente a qualsiasi proficuo lavoro'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='17';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Superati limiti di eta'' - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='19';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Superati limiti di eta'' (in base a vigenti disposizioni di legge) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='20';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Scarso rendimento - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='21';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Provvedimento disciplinare - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='22';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Incapacita'' professionale - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='23';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Lavoro usurante (art. 1, comma 35, L. 335/95) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='24';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Trasformazione del rapporto di lavoro in tempo parziale (D.M. 331/97)'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='25';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Dimissioni volontarie (art. 59, comma 7, lettera c, L. 449/97) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='26';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Dimissioni volontarie (art. 59, comma 7, lettere a e b, L. 449/97) Precoci ecc. - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='27';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Cessazione per trasformazione o chiusura Ente - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='28';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Prosecuzione del rapporto di lavoro oltre i limiti di eta'' per il collocamento a riposo (L. 186/2004)'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='31';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Carica elettiva art. 86 L. 267/2000 (T.U. Enti locali) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='33';


INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '34', ANNO, 'Collocamento a riposo oltre i limiti di eta'' - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='34');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '35', ANNO, 'Trattamento di mobilita'' - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='35');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '36', ANNO, 'Aspettativa per mandato amministrativo d. lgs 267/2000 con onere amministrazione locale - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='36');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '37', ANNO, 'Aspettativa per mandato amministrativo d. lgs 267/2000 con onere carico iscritto (articolo 2, comma 24, della legge 24 dicembre 2007, n. 244) - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='37');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '38', ANNO, 'Aspettativa per Incarico di Direttore Generale di AA.SS.LL. e di Amministrazioni non utile ai fini pensionistici - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='38');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '39', ANNO, 'Aspettativa per mandato politico elettivo (art. 31, L. 300 del 1970) - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='39');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '40', ANNO, 'Aspettativa non retribuita per motivi sindacali (art. 31, L. 300 del 1970) - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='40');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '41', ANNO, 'Aspettativa per cooperazione paesi in via di sviluppo - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='41');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '42', ANNO, 'Sospensione cautelare - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='42');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '43', ANNO, 'C.I.G ordinaria - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='43');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '44', ANNO, 'C.I.G straordinaria - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='434');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '45', ANNO, 'C.I.G speciale - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPCAUSCESS' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPCAUSCESS' AND V.COD_CODICITABANNUALI='45');

UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Aspettativa per mandato politico elettivo (art. 31, L. 300 del 1970) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='2';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Aspettativa non retribuita per motivi sindacali (art. 31, L. 300 del 1970) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='3';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Servizio part-time - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='5';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Astensione dal lavoro per soccorso alpino (art. 1, comma 2 L. 162 del 1992) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='7';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Astensione facoltativa dal lavoro con retribuzione ridotta per maternita'' e per assistenza ai figli'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='9';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Astensione facoltativa senza retribuzione per assistenza ai figli dopo il terzo e fino all''ottavo anno di eta'' (L. 53 del 2000) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='10';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Astensione facoltativa dal lavoro per maternita'' con retribuzione ridotta all''80% - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='12';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Astensione dal lavoro per assistenza ai figli con retribuzione ridotta al 50% - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='13';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Astensione facoltativa senza retribuzione per assistenza ai figli entro il terzo anno di eta'' (L. 53 del 2000) - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='14';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Aspettativa servizio militare (art. 40 DPR. 130/69, DPR. 1092/73)'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='27';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Assenza dal lavoro per educazione e assistenza ai figli fino al sesto anno di eta'' (art. 1 comma 40 lett. a L. 335/95)'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='29';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Servizio non utile - solo D.M.A.'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='30';
UPDATE P004_CODICITABANNUALI t SET T.DESCRIZIONE='Servizio ed aspettativa non retribuita per motivi sindacali fruita in misura parziale'
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='32';

INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '42', ANNO, 'Astensione facoltativa senza retribuzione per assistenza ai figli utile coperta da contribuzione figurativa - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='42');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '43', ANNO, 'Aspettativa senza assegni per nomina a direttore generale utile ai fini trattamento quiescenza e previdenza - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='43');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '46', ANNO, 'Mandato amministrativo ex art. 81 d.lgs. 267/2000 con obbligo a carico amministrazione di appartenenza - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='46');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '47', ANNO, 'Esonero art. 72 D.L. 112/2008 - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='47');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '48', ANNO, 'Assenza dal lavoro per assistenza figli dal sesto anno di eta'', coniuge, genitori conviventi per condizioni previste ex. art. 3 L. 104/92 (art. 1 comma 40 lett. b L. 335/95) - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='48');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '49', ANNO, 'Congedo straordinario per assistenza soggetti con handicap grave ex. art. 42 comma 5 decreto legislativo 151/2001 - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='49');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '50', ANNO, 'Aspettativa senza assegni docenti universitari ai sensi degli art. 12 e 13 del DPR 382/1980 - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='50');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '51', ANNO, 'Sospensione cautelare dal servizio del personale militare ai sensi dell''art. 3 della legge 538/1961 e 24 della legge 469/1958 e successive modifiche - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='51');
INSERT INTO P004_CODICITABANNUALI
SELECT COD_TABANNUALE, '52', ANNO, 'Aspettativa per incarico di responsabilita'' di governo art. 6 DPR 1032/73 - solo D.M.A. 2' FROM P004_CODICITABANNUALI T
WHERE T.COD_TABANNUALE='IPTIPSERV' AND T.COD_CODICITABANNUALI='4' AND NOT EXISTS
(SELECT 'X' FROM P004_CODICITABANNUALI V
WHERE V.COD_TABANNUALE='IPTIPSERV' AND V.COD_CODICITABANNUALI='52');

DELETE P004_CODICITABANNUALI T
WHERE T.ANNO<2012 AND T.COD_TABANNUALE IN ('IPCAUSCESS','IPGESASSIC','IPMAGGIOR','IPTIPSERV');

INSERT INTO P004_CODICITABANNUALI
select T.COD_TABANNUALE,T.COD_CODICITABANNUALI,Q.ANNO,T.DESCRIZIONE from P004_CODICITABANNUALI T,
(
SELECT 1900 ANNO FROM DUAL
UNION SELECT 2001 FROM DUAL
UNION SELECT 2002 FROM DUAL
UNION SELECT 2003 FROM DUAL
UNION SELECT 2004 FROM DUAL
UNION SELECT 2005 FROM DUAL
UNION SELECT 2006 FROM DUAL
UNION SELECT 2007 FROM DUAL
UNION SELECT 2008 FROM DUAL
UNION SELECT 2009 FROM DUAL
UNION SELECT 2010 FROM DUAL
UNION SELECT 2011 FROM DUAL
) Q
WHERE T.ANNO=2012 AND T.COD_TABANNUALE IN ('IPCAUSCESS','IPGESASSIC','IPMAGGIOR','IPTIPSERV');

alter table P026_FONDIPREVCOMPL add cod_inpdap_comparto VARCHAR2(5);
comment on column P026_FONDIPREVCOMPL.cod_inpdap_comparto
  is 'Codice comparto fondo previdenza complementare per flusso DMA';

insert into p026_fondiprevcompl
select '21421OPT', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti optanti (ex TFS) - Prudenza',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21421'
from p026_fondiprevcompl t where t.cod_fpc='2142OPT';

insert into p026_fondiprevcompl
select '21422OPT', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti optanti (ex TFS) - Garanzia',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21422'
from p026_fondiprevcompl t where t.cod_fpc='2142OPT';

insert into p026_fondiprevcompl
select '21423OPT', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti optanti (ex TFS) - Dinamico',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21423'
from p026_fondiprevcompl t where t.cod_fpc='2142OPT';

insert into p026_fondiprevcompl
select '21421TFR', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti TFR - Prudenza',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21421'
from p026_fondiprevcompl t where t.cod_fpc='2142TFR';

insert into p026_fondiprevcompl
select '21422TFR', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti TFR - Garanzia',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21422'
from p026_fondiprevcompl t where t.cod_fpc='2142TFR';

insert into p026_fondiprevcompl
select '21423TFR', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti TFR - Dinamico',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21423'
from p026_fondiprevcompl t where t.cod_fpc='2142TFR';

insert into p026_fondiprevcompl
select '21421TFS', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti TFS (lavoratori Regione Valle d''Aosta ex Fondo cessazione servizio) - Prudenza',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21421'
from p026_fondiprevcompl t where t.cod_fpc='2142TFS';

insert into p026_fondiprevcompl
select '21422TFS', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti TFS (lavoratori Regione Valle d''Aosta ex Fondo cessazione servizio) - Garanzia',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21422'
from p026_fondiprevcompl t where t.cod_fpc='2142TFS';

insert into p026_fondiprevcompl
select '21423TFS', decorrenza, decorrenza_fine,
 'Fopadiva dipendenti TFS (lavoratori Regione Valle d''Aosta ex Fondo cessazione servizio) - Dinamico',
 cod_inpdap_fpc, cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef,
 '21423'
from p026_fondiprevcompl t where t.cod_fpc='2142TFS';

delete P026_FONDIPREVCOMPL t where t.cod_fpc in ('2142OPT','2142TFR','2142TFS')
and not exists
(select 'x' from p430_anagrafico v where v.cod_fpc=t.cod_fpc);

alter table P206_ASSENZEINPDAP add PERC_RETRIBUZIONE NUMBER;
comment on column P206_ASSENZEINPDAP.PERC_RETRIBUZIONE
  is 'Percentuale retribuzione';
alter table P206_ASSENZEINPDAP add note VARCHAR2(50);
comment on column P206_ASSENZEINPDAP.note
  is 'Note';
alter table P206_ASSENZEINPDAP add decorrenza_fine DATE;

UPDATE P206_ASSENZEINPDAP t SET T.NOTE='D.M.A.';

-- Aggiornamento decorrenza_fine 
declare cursor c1 is 
select B.DECORRENZA-1 DEC_FINE, A.* 
from P206_ASSENZEINPDAP A, P206_ASSENZEINPDAP B
where A.COD_CONTRATTO = B.COD_CONTRATTO
and A.COD_VOCE = B.COD_VOCE
and A.COD_VOCE_SPECIALE = B.COD_VOCE_SPECIALE
and B.DECORRENZA = (SELECT MIN(C.DECORRENZA) FROM P206_ASSENZEINPDAP C
                     WHERE C.COD_CONTRATTO = B.COD_CONTRATTO
                       AND C.COD_VOCE = B.COD_VOCE
                     AND C.COD_VOCE_SPECIALE = B.COD_VOCE_SPECIALE
                       AND C.DECORRENZA > A.DECORRENZA)
order by A.cod_contratto, A.cod_voce, A.cod_voce_speciale, A.decorrenza;
begin
  for t1 in c1 loop
    UPDATE P206_ASSENZEINPDAP
       SET DECORRENZA_FINE = T1.DEC_FINE
     WHERE COD_CONTRATTO = T1.COD_CONTRATTO
       AND COD_VOCE = T1.COD_VOCE
       AND COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE
       AND DECORRENZA = T1.DECORRENZA
       AND DECORRENZA_FINE IS NULL;
  end loop;
end;
/
UPDATE P206_ASSENZEINPDAP A
   SET DECORRENZA_FINE = TO_DATE('31/12/3999','DD/MM/YYYY')
 WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM P206_ASSENZEINPDAP
                      WHERE COD_CONTRATTO = A.COD_CONTRATTO
                        AND COD_VOCE = A.COD_VOCE
                        AND COD_VOCE_SPECIALE = A.COD_VOCE_SPECIALE)
   AND DECORRENZA_FINE IS NULL;

-- Appiattimento
declare 
  cursor c1 is 
  select distinct cod_contratto, cod_voce, cod_voce_speciale 
    from P206_ASSENZEINPDAP 
   order by cod_contratto, cod_voce, cod_voce_speciale;
  CONTA Integer;
begin
  for t1 in c1 loop
    select count(*) into CONTA from 
    (select distinct elimina_sezione, abbatte_ggutili, cod_tiposervizio,  
            cod_gestassic_noncoperte, cod_causasospensione, perc_asp_sindacale
      from P206_ASSENZEINPDAP P206 
     where COD_CONTRATTO = t1.COD_CONTRATTO
       and COD_VOCE = t1.COD_VOCE
       and COD_VOCE_SPECIALE = t1.COD_VOCE_SPECIALE);
    if CONTA = 1 then
      UPDATE P206_ASSENZEINPDAP
         SET DECORRENZA_FINE = TO_DATE('31123999','DDMMYYYY')
       WHERE COD_CONTRATTO = T1.COD_CONTRATTO
         AND COD_VOCE = T1.COD_VOCE
         AND COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE
         AND DECORRENZA = (SELECT MIN(DECORRENZA) FROM P206_ASSENZEINPDAP
                            WHERE COD_CONTRATTO = T1.COD_CONTRATTO
                              AND COD_VOCE = T1.COD_VOCE
                              AND COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE);
      DELETE FROM P206_ASSENZEINPDAP
       WHERE COD_CONTRATTO = T1.COD_CONTRATTO
         AND COD_VOCE = T1.COD_VOCE
         AND COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE
         AND DECORRENZA > (SELECT MIN(DECORRENZA) FROM P206_ASSENZEINPDAP
                            WHERE COD_CONTRATTO = T1.COD_CONTRATTO
                              AND COD_VOCE = T1.COD_VOCE
                              AND COD_VOCE_SPECIALE = T1.COD_VOCE_SPECIALE);
    end if; 
  end loop;
end;
/

UPDATE P206_ASSENZEINPDAP T SET T.DECORRENZA=TO_DATE('01012001','DDMMYYYY')
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='15032' AND T.COD_VOCE_SPECIALE='BASE'
AND T.DECORRENZA=TO_DATE('01012002','DDMMYYYY') AND T.DECORRENZA_FINE=TO_DATE('31123999','DDMMYYYY');

UPDATE P206_ASSENZEINPDAP T SET T.PERC_RETRIBUZIONE=30
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='15010' AND T.COD_VOCE_SPECIALE='BASE';

UPDATE P206_ASSENZEINPDAP T SET T.PERC_RETRIBUZIONE=0
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE IN('15030','15032','15036') AND T.COD_VOCE_SPECIALE='BASE';

UPDATE T909_DATICALCOLATI SET ESPRESSIONE = REPLACE(ESPRESSIONE,'MR_Rimborso','MR_Rimborsoriconosciuto') WHERE ID_SERBATOIO = 7 AND INSTR(ESPRESSIONE,'MR_Rimborso') > 0 AND INSTR(ESPRESSIONE,'MR_Rimborsoriconosciuto') = 0;
UPDATE T911_DATIRIEPILOGO SET NOME = 'MR_Rimborso riconosciuto' WHERE NOME = 'MR_Rimborso';
UPDATE T912_SORTRIEPILOGO SET NOME = 'MR_Rimborso riconosciuto' WHERE NOME = 'MR_Rimborso';
UPDATE T914_SERBATOIFILTRO SET FILTRO = REPLACE(FILTRO,'MR_Rimborso','MR_Rimborsoriconosciuto') WHERE ID_SERBATOIO = 7 AND INSTR(FILTRO,'MR_Rimborso') > 0 AND INSTR(FILTRO,'MR_Rimborsoriconosciuto') = 0;
