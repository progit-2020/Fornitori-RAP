update MONDOEDP.I090_ENTI set VERSIONEDB = '8.0',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T162_INDENNITA add CAUPRES_RIEPORE varchar2(5);
comment on column T162_INDENNITA.CAUPRES_RIEPORE is 'Causale di presenza su cui si devono riepilogare mensilmente le ore rese relative a questa indennità';

create table MONDOEDP.I015_TRADUZIONI_CAPTION (
  AZIENDA        varchar2(30)  not null,
  LINGUA         varchar2(20)  not null,
  APPLICAZIONE   varchar2(6)   not null,
  MASCHERA       varchar2(40)  not null,
  COMPONENTE     varchar2(80)  not null,
  CAPTION        varchar2(500) not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table MONDOEDP.I015_TRADUZIONI_CAPTION
  add constraint I015_PK primary key (AZIENDA, LINGUA, APPLICAZIONE, MASCHERA, COMPONENTE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table MONDOEDP.I015_TRADUZIONI_CAPTION modify LINGUA default 'INGLESE';
alter table MONDOEDP.I015_TRADUZIONI_CAPTION modify APPLICAZIONE default 'W000';

create table SG120_FAMILIARIDIPGEN
(  PROGRESSIVO     NUMBER(8) not null,
  DATA_AGG        DATE not null,
  DETRAZ_LAVDIP   VARCHAR2(1),
  COD_STATOCIVILE VARCHAR2(5),
  CONFERMA        VARCHAR2(1) default 'N' not null)
  tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column SG120_FAMILIARIDIPGEN.DATA_AGG
  is 'Data aggiornamento effettuato dal dipendente';
comment on column SG120_FAMILIARIDIPGEN.DETRAZ_LAVDIP
  is 'Altre detrazioni: S=Lavoro dipendente e assimilati, N=Nessuna detrazione del tipo precedente';
comment on column SG120_FAMILIARIDIPGEN.CONFERMA
  is 'Conferma (S/N) se i dati sono stati confermati dal dipendente';

alter table SG120_FAMILIARIDIPGEN
  add constraint SG120_PK primary key (PROGRESSIVO, DATA_AGG)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table SG120_FAMILIARIDIPGEN
  add constraint SG120_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

create table SG122_FAMILIARIDIPDET
(  PROGRESSIVO          NUMBER(8) not null,
  DATA_AGG             DATE not null,
  TIPO_FAM             VARCHAR2(3) not null,
  NUMORD               NUMBER default -1 not null,
  COGNOME              VARCHAR2(30),
  NOME                 VARCHAR2(30),
  CARICO               VARCHAR2(1),
  DATA_CARICO_DA       DATE,
  DATA_CARICO_A        DATE,
  PERC_CARICO          NUMBER,
  MANCA_CONIUGE        VARCHAR2(1),
  DETR_FIGLIO_HANDICAP VARCHAR2(1),
  DATANAS              DATE,
  CODFISCALE           VARCHAR2(16))
  tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column SG122_FAMILIARIDIPDET.DATA_AGG
  is 'Data aggiornamento effettuato dal dipendente';
comment on column SG122_FAMILIARIDIPDET.TIPO_FAM
  is 'Tipo familiare: CG=Coniuge, FGx=Figlio x  con x da 1 a 6, ALx=Altro familiare x  con x da 1 a 3';
comment on column SG122_FAMILIARIDIPDET.CARICO
  is 'Fiscalmente a carico (S/N)';
comment on column SG122_FAMILIARIDIPDET.DATA_CARICO_DA
  is 'Data decorrenza del carico fiscale; se non fiscalmente a carico coincide con l''inizio anno';
comment on column SG122_FAMILIARIDIPDET.DATA_CARICO_A
  is 'Data scadenza del carico fiscale; se non fiscalmente a carico coincide con la fine anno';
comment on column SG122_FAMILIARIDIPDET.MANCA_CONIUGE
  is 'Primo figlio in assenza di coniuge (S/N)';
comment on column SG122_FAMILIARIDIPDET.DETR_FIGLIO_HANDICAP
  is 'Ulteriore detrazione per figlio portatore di handicap (S/N)';

alter table SG122_FAMILIARIDIPDET
  add constraint SG122_PK primary key (PROGRESSIVO, DATA_AGG, TIPO_FAM)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table SG122_FAMILIARIDIPDET
  add constraint SG122_FK_SG120 foreign key (PROGRESSIVO, DATA_AGG)
  references SG120_FAMILIARIDIPGEN (PROGRESSIVO, DATA_AGG) on delete cascade;

ALTER TABLE P500_CUDSETUP ADD FAM_DATA_DA DATE;
ALTER TABLE P500_CUDSETUP ADD FAM_DATA_A DATE;
ALTER TABLE P500_CUDSETUP ADD FAM_STATO_CIVILE VARCHAR2(1) DEFAULT 'N';
ALTER TABLE P500_CUDSETUP ADD FAM_PATH_ISTRUZIONI VARCHAR2(1000);
ALTER TABLE P500_CUDSETUP ADD FAM_NOTE VARCHAR2(2000);
ALTER TABLE P500_CUDSETUP MODIFY FAM_NOTE VARCHAR2(4000);

comment on column P500_CUDSETUP.FAM_DATA_DA
  is 'Data inizio abilitazione all''accesso web per la dichiarazione detrazioni IRPEF';
comment on column P500_CUDSETUP.FAM_DATA_A
  is 'Data fine abilitazione all''accesso web per la dichiarazione detrazioni IRPEF';
comment on column P500_CUDSETUP.FAM_STATO_CIVILE
  is 'Richiesta stato civile nella dichiarazione detrazioni IRPEF';
comment on column P500_CUDSETUP.FAM_PATH_ISTRUZIONI
  is 'Percorso delle eventuali istruzioni relative alla dichiarazione detrazioni IRPEF';
comment on column P500_CUDSETUP.FAM_NOTE
  is 'Eventuali note finali relative alla dichiarazione detrazioni IRPEF';

alter table SG101_FAMILIARI add
(DATA_ULT_FAM_CAR     DATE);
comment on column SG101_FAMILIARI.DATA_ULT_FAM_CAR
  is 'Data ultima dichiarazione familiari a carico';

ALTER TABLE SG101_FAMILIARI DROP COLUMN ULT_DETR_FIGLIO/*--NOLOG--*/;

alter table T020_ORARI add SPEZZNONCAUS_SCARTOECC varchar2(1) default 'N';
comment on column T020_ORARI.SPEZZNONCAUS_SCARTOECC is 'S=Se lo spezzone supera l''eccedenza gg viene limitato nella Gestione Mensile,  N=Lo spezzone non causalizzato non viene mai limitato';
update T020_ORARI set SPEZZNONCAUS_SCARTOECC = 'S' where instr(XPARAM,'<TC_SCARTOECCEDENZA>') > 0;
update T020_ORARI set XPARAM = replace(XPARAM,'<TC_SCARTOECCEDENZA>','');

alter table T020_ORARI add FLEXDOPOMEZZANOTTE varchar2(1) default 'N';
comment on column T020_ORARI.FLEXDOPOMEZZANOTTE is 'Gestione flex su turno notturno: S=Attiva il riconoscimento del turno notturno pianificato il gg prec. anche per turni conteggiati sull''entrata,  N=Il riconoscimento del turno notturno del gg.prec avviene solo se il conteggio del turno notturno è spezzato sui 2 gg';
update T020_ORARI set FLEXDOPOMEZZANOTTE = 'S' where instr(XPARAM,'<TC_FLEXDOPOMEZZ>') > 0;
update T020_ORARI set XPARAM = replace(XPARAM,'<TC_FLEXDOPOMEZZ>','');

alter table T020_ORARI add  INTERSEZ_AUTOGIUST varchar2(1) default 'N';
comment on column T020_ORARI.INTERSEZ_AUTOGIUST is 'S=Gestione particolare dei giustificativi dalle..alle che si intersecano con timbrature caus.escl.dalle normali, in modo da conteggiare solo queste ultime, N=Le ore vengono conteggiate normalmente secondo il parametro di intersezione tra giustificativi e timbrature delle causali di assenza';
update T020_ORARI set INTERSEZ_AUTOGIUST = 'S' where instr(XPARAM,'<TC_AUTOGIUST_STR>') > 0;
update T020_ORARI set XPARAM = replace(XPARAM,'<TC_AUTOGIUST_STR>','');

alter table T020_ORARI add RIPCOM_GGNONLAV varchar2(1) default 'N';
comment on column T020_ORARI.RIPCOM_GGNONLAV is 'S=Il riposo compensativo può essere maturato anche sui giorni non lavorativi,  N=Il riposo compensativo matura solo sui giorni lavorativi';
update T020_ORARI set RIPCOM_GGNONLAV = 'S' where instr(XPARAM,'<CRV_RIPCOM>') > 0;
update T020_ORARI set XPARAM = replace(XPARAM,'<CRV_RIPCOM>','');

alter table T020_ORARI add PMT_NOTIMBCONSECUTIVE varchar2(1) default 'N';
comment on column T020_ORARI.PMT_NOTIMBCONSECUTIVE is 'S=La PMT non viene gestita tra 2 timbrature consecutive, che vengono invece viste come un''unica timbratura,  N=La PMT può attivarsi anche tra 2 timbrature consecutive';
update T020_ORARI set PMT_NOTIMBCONSECUTIVE = 'S' where instr(XPARAM,'<CRV_STACCO_PMT>') > 0;
update T020_ORARI set XPARAM = replace(XPARAM,'<CRV_STACCO_PMT>','');

alter table T020_ORARI add PMT_USCITARIT varchar2(1) default 'N';
comment on column T020_ORARI.PMT_USCITARIT is 'S=La PMT non viene gestita tra 2 timbrature consecutive, che vengono invece viste come un''unica timbratura,  N=La PMT può attivarsi anche tra 2 timbrature consecutive';
update T020_ORARI set PMT_USCITARIT = 'S' where instr(XPARAM,'<CRV_PMT_URIT>') > 0;
update T020_ORARI set XPARAM = replace(XPARAM,'<CRV_PMT_URIT>','');

ALTER TABLE T390_CHIAMATE_REPERIB ADD UTENTE VARCHAR2(30) NOT NULL/*--NOLOG--*/;
alter table T390_CHIAMATE_REPERIB drop primary key/*--NOLOG--*/;
drop index T390_PK/*--NOLOG--*/;
alter table T390_CHIAMATE_REPERIB
  add constraint T390_PK primary key (DATA,UTENTE,PROGRESSIVO_REPER) 
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0) /*--NOLOG--*/;
ALTER TABLE T390_CHIAMATE_REPERIB DROP COLUMN PROGRESSIVO_OPER/*--NOLOG--*/;
comment on column T390_CHIAMATE_REPERIB.UTENTE is 'Operatore che effettua la chiamata'/*--NOLOG--*/;

ALTER TABLE SG302_INCAZIENDALI ADD INCSUP_TIPOINC VARCHAR2(5);
ALTER TABLE SG302_INCAZIENDALI ADD INCSUP_TITOLO VARCHAR2(500);
ALTER TABLE SG302_INCAZIENDALI ADD TIPO_POSIZIONE VARCHAR2(200);
comment on column SG302_INCAZIENDALI.INCSUP_TIPOINC is 'Codice del tipo incarico superiore da cui dipende il corrente';
comment on column SG302_INCAZIENDALI.INCSUP_TITOLO is 'Titolo posizione dell''incarico superiore da cui dipende il corrente';
comment on column SG302_INCAZIENDALI.TIPO_POSIZIONE is 'Tipologia di posizione prevista';
ALTER TABLE SG303_INCINDIVIDUALI ADD TIPO_POSIZIONE VARCHAR2(200);
comment on column SG303_INCINDIVIDUALI.TIPO_POSIZIONE is 'Tipologia di posizione prevista (valorizzata in automatico)';
ALTER TABLE SG307_INCSTAMPE ADD FLAG_GERARCHIA VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE ADD TPPOS_STAMPA VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE ADD TPPOS_FILTRO VARCHAR2(2000);
ALTER TABLE SG307_INCSTAMPE MODIFY TPPOS_FILTRO VARCHAR2(4000);
ALTER TABLE SG307_INCSTAMPE ADD FLAG_NUMLIVELLI VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY FLAG_TOTALE DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY UO_STAMPA DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY UO_SALTOPAG DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY TPINC_STAMPA DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY TPINC_SALTOPAG DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY POSIZ_STAMPA DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY POSIZ_SALTOPAG DEFAULT 'N';
ALTER TABLE SG307_INCSTAMPE MODIFY DIP_STAMPA DEFAULT 'N';
comment on column SG307_INCSTAMPE.FLAG_GERARCHIA is 'Stampa gerarchia dipendenze';
comment on column SG307_INCSTAMPE.FLAG_NUMLIVELLI is 'Stampa la numerazione dei livelli';
comment on column SG307_INCSTAMPE.FLAG_TOTALE is 'Stampa totali generali';
comment on column SG307_INCSTAMPE.TPPOS_STAMPA is 'Riporta in stampa la tipologia posizione';
comment on column SG307_INCSTAMPE.TPPOS_FILTRO is 'Elenco tipologie posizione da stampare';
comment on column SG307_INCSTAMPE.UO_STAMPA is 'Riporta in stampa l''unità operativa';
comment on column SG307_INCSTAMPE.UO_SALTOPAG is 'Effettua il salto pagina per unità operativa';
comment on column SG307_INCSTAMPE.UO_FILTRO is 'Elenco unità operative da stampare';
comment on column SG307_INCSTAMPE.TPINC_STAMPA is 'Riporta in stampa il tipo incarico';
comment on column SG307_INCSTAMPE.TPINC_SALTOPAG is 'Effettua il salto pagina per tipo incarico';
comment on column SG307_INCSTAMPE.TPINC_FILTRO is 'Elenco tipi incarichi da stampare';
comment on column SG307_INCSTAMPE.POSIZ_STAMPA is 'Riporta in stampa il titolo posizione';
comment on column SG307_INCSTAMPE.POSIZ_SALTOPAG is 'Effettua il salto pagina per titolo posizione';
comment on column SG307_INCSTAMPE.POSIZ_FILTRO is 'Elenco titoli posizione da stampare';
comment on column SG307_INCSTAMPE.DIP_STAMPA is 'Riporta in stampa i dati anagrafici del dipendente';
comment on column SG307_INCSTAMPE.DIP_DATI is 'Elenco dati anagrafici da stampare';

alter table T070_SCHEDARIEPIL add RIPOSINONFRUITIORE varchar2(7);
comment on column T070_SCHEDARIEPIL.RIPOSINONFRUITIORE is 'Residuo in ore delle causale specificata in T025_CONTMENSILI.RIPOSO_NONFRUITO';

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV115-110-2010'',''Dirigente veterinario incarico lett. c) con struttura semplice (dec. 2010)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV115-110-2010'')';
      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''MV115-110-2010'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. veterinario lett. c) con S.S. (dec. 2010)'',
        ''00212'', ''BASE'', 387.61, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''MV115-110-2010'')';

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV025-016-2010'',''Dirigente medico incarico lett. c) con struttura complessa area territorio (dec. 2010)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV025-016-2010'')';
      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''MV025-016-2010'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. medico lett. c) con S.C. territorio (dec. 2010)'',
        ''00212'', ''BASE'', 642.03, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''MV025-016-2010'')';

    end if;
  end if;
end;
/

ALTER TABLE T774_PESATUREINDIVIDUALI ADD QUOTA_ASSEGNATA NUMBER;
comment on column T774_PESATUREINDIVIDUALI.QUOTA_ASSEGNATA
  is 'Importo della quota assegnata calcolato automaticamente come quota individ. x peso individ.';
ALTER TABLE T774_PESATUREINDIVIDUALI ADD OBIETTIVI_ASSEGNATI VARCHAR2(1) DEFAULT 'N';
comment on column T774_PESATUREINDIVIDUALI.OBIETTIVI_ASSEGNATI 
  is 'Indicazione di Obiettivi Assegnati';
ALTER TABLE T773_PESATUREGRUPPO ADD CHIUSO VARCHAR2(1) DEFAULT 'N';
comment on column T773_PESATUREGRUPPO.CHIUSO
  is 'Indicazione di Chiusura (S/N)';

create index T050_ID_REVOCA on T050_RICHIESTEASSENZA (ID_REVOCA) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T275_CAUPRESENZE add CAUSALIZZA_TIMB_INTERSECANTI varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.CAUSALIZZA_TIMB_INTERSECANTI is 'N=la fruizione dalle..alle si comporta come un normale giustificativo, S=la fruizione dalle..alle forza la causalizzazione delle timbrature intersecanti, ricadendo nella gestione della libera professione';

-- Correzione codice catastale e addizionali comunali di Torrenova e Ragalna

declare
  i integer;
  j integer;
begin
  select COUNT(*) into i from t480_comuni t where t.codcatastale='M287'and upper(ltrim(rtrim(t.citta)))='RAGALNA';
  select COUNT(*) into j from t480_comuni t where t.codcatastale='M286'and upper(ltrim(rtrim(t.citta)))='RAGALNA';
  if i = 0 and j =1 then

      update t480_comuni t set t.codcatastale='tmp1' where t.codcatastale='M286';
      update t480_comuni t set t.codcatastale='M286' where t.codcatastale='M287';
      update t480_comuni t set t.codcatastale='M287', t.citta='RAGALNA' where t.codcatastale='tmp1';

      delete p042_entiirpef t where t.tipo_addizionale='C' and t.cod_ente='M286';

      insert into p042_entiirpef
      select anno, tipo_addizionale, 'M286', ritenuta_scaglioni, ritenuta_perc, ritenuta_progressiva_scaglioni
      from p042_entiirpef t where t.tipo_addizionale='C' and t.cod_ente='M287';

      update p044_entiirpeffasce t set t.cod_ente='M286' where t.tipo_addizionale='C' and t.cod_ente='M287';

      delete p042_entiirpef t where t.tipo_addizionale='C' and t.cod_ente='M287';

  end if;
end;

/

ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD LOGO_LARGHEZZA NUMBER(3);
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD LOGO_ALTEZZA   NUMBER(3);
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DATO_STAMPA_6  VARCHAR2(30);
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DESC_LUNGA_1   VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DESC_LUNGA_3   VARCHAR2(1) DEFAULT 'N';
ALTER TABLE SG740_REGOLE_VALUTAZIONI ADD DESC_LUNGA_5   VARCHAR2(1) DEFAULT 'N';

DECLARE
  W_DATO MONDOEDP.I091_DATIENTE.DATO%TYPE :='';
BEGIN
  BEGIN
    SELECT DATO
    INTO W_DATO 
    FROM MONDOEDP.I091_DATIENTE
    WHERE AZIENDA = :AZIENDA
    AND TIPO = 'C21_VALUTAZIONI_LIV1';
  EXCEPTION
    WHEN OTHERS THEN
      W_DATO:='';
  END;
  INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO, DATO)
  VALUES (:AZIENDA, 'C21_VALUTAZIONI_PNT1', W_DATO);
END/*--NOLOG--*/;
/

ALTER TABLE SG730_PUNTEGGI ADD DATO1       VARCHAR2(20) DEFAULT '*';
ALTER TABLE SG730_PUNTEGGI ADD CALCOLO_PFP VARCHAR2(1)  DEFAULT 'S';

alter table SG730_PUNTEGGI drop primary key/*--NOLOG--*/;

drop index SG730_PK/*--NOLOG--*/;

alter table SG730_PUNTEGGI
  add constraint SG730_PK primary key (DATO1, DECORRENZA, PUNTEGGIO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- Creazione sindacato EDP 12371 TRED

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  CodVoceFiglio varchar2(5);
begin
  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12371' AND T.COD_VOCE_SPECIALE='BASE';
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12371' AND T.COD_VOCE_SPECIALE='TRED';
    if i = 0 then
  
      CodVoceModello:='12008';
      CodVoceCopia:='12371';
      DesVoceCopia:='Fedir Sanità a importo fisso 13a';
      DesVoceCopiaSt:='Fedir Sanita'' a importo fisso 13a';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

    end if;
  end if;
end;
/

ALTER TABLE T085_RICHIESTECAMBIORARI ADD SOLO_NOTE VARCHAR2(1) DEFAULT 'N';

-- Creazione sindacato EDP 12146 TRED

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
begin
  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12146' AND T.COD_VOCE_SPECIALE='BASE';
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12146' AND T.COD_VOCE_SPECIALE='TRED';
    if i = 0 then
  
      CodVoceModello:='12008';
      CodVoceCopia:='12146';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, descrizione, CodVoceCopia || ' T', descrizione_stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

      update p200_voci t set
        t.descrizione=(SELECT V.DESCRIZIONE || ' 13a' FROM P200_VOCI V 
                       WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE=CodVoceCopia AND V.COD_VOCE_SPECIALE='BASE'),
        t.descrizione_stampa=(SELECT V.DESCRIZIONE_STAMPA || ' 13a' FROM P200_VOCI V 
                       WHERE V.COD_CONTRATTO='EDP' AND V.COD_VOCE=CodVoceCopia AND V.COD_VOCE_SPECIALE='BASE')
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='TRED';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

    end if;
  end if;
end;
/

create table SG512_ORDINADATI
(ID_PIANTA          NUMBER not null,
 NOME_CAMPO         VARCHAR2(20) not null,
 DECORRENZA DATE not null,
 VALORE_CAMPO    VARCHAR2(80) not null,
 ORDINE_STAMPA NUMBER
)
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);
comment on column SG512_ORDINADATI.ID_PIANTA
  is 'Identificativo della pianta organica';
comment on column SG512_ORDINADATI.NOME_CAMPO
  is 'Nome del dato anagrafico della pianta organica';
comment on column SG512_ORDINADATI.VALORE_CAMPO
  is 'Valore del codice del dato anagrafico della pianta organica';
comment on column SG512_ORDINADATI.ORDINE_STAMPA
  is 'Ordinamento del valore del dato anagrafico nella stampa';
comment on column SG512_ORDINADATI.DECORRENZA
  is 'Decorrenza dell''ordinamento';
alter table SG512_ORDINADATI
  add constraint SG512_PK primary key (ID_PIANTA, NOME_CAMPO, VALORE_CAMPO, DECORRENZA)
  using index 
  tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

alter table T361_OROLOGI add SCARICO varchar2(20);
alter table T361_OROLOGI add RILEVATORE varchar2(10);
comment on column T361_OROLOGI.SCARICO
  is 'Nome della parametrizzazione di scarico timbrature da cui decodificare il rilevatore. Se vuoto vale per tutte le configurazioni';
comment on column T361_OROLOGI.RILEVATORE
  is 'Rilevatore presente sul file di scarico che verrà ricodificato con il contenuto del campo CODICE. Se vuoto non determina ricodifica';

CREATE TABLE T048_ATTESTATIINPS
(
  PROGRESSIVO         NUMBER(38,2) NOT NULL,
  DATA_REGISTRAZIONE  DATE NOT NULL,
  OPERATORE           VARCHAR2(20) NOT NULL,
  CAUSALE_MAL         VARCHAR2(5) NOT NULL,
  TIPO_ELEMENTO       VARCHAR2(1) NOT NULL,
  ID_CERTIFICATO      VARCHAR2(10) NOT NULL,
  COD_FISCALE_AZIENDA VARCHAR2(16),
  MATRICOLA_INPS      VARCHAR2(10),
  COD_SEDE_INPDAP     VARCHAR2(10),
  COD_FISCALE_MED     VARCHAR2(16),
  COGNOME_MED         VARCHAR2(24),
  NOME_MED            VARCHAR2(20),
  COD_REGIONE         VARCHAR2(3),
  COD_ASL             VARCHAR2(3),
  COD_FISCALE         VARCHAR2(16),
  COGNOME             VARCHAR2(24),
  NOME                VARCHAR2(20),
  SESSO               VARCHAR2(1),
  DATA_NAS            DATE,
  CODCATASTALE_NAS    VARCHAR2(4),
  PROV_NAS            VARCHAR2(2),
  VIA_DOM             VARCHAR2(35),
  CAP_DOM             VARCHAR2(5),
  CODCATASTALE_DOM    VARCHAR2(4),
  PROV_DOM            VARCHAR2(2),
  COGNOME_REP         VARCHAR2(24),
  VIA_REP             VARCHAR2(35),
  CAP_REP             VARCHAR2(5),
  CODCATASTALE_REP    VARCHAR2(4),
  PROV_REP            VARCHAR2(2),
  DATA_RILASCIO       DATE,
  DATA_INIZIO_MAL     DATE,
  DATA_FINE_MAL       DATE,
  COD_DIAGNOSI        VARCHAR2(10),
  TESTO_DIAGNOSI      VARCHAR2(200),
  TIPO_CERTIFICATO    VARCHAR2(1),
  ID_CERTIFICATO_RETT VARCHAR2(10)
)
TABLESPACE LAVORO STORAGE(INITIAL 256K NEXT 256K PCTINCREASE 0);
	
comment on column T048_ATTESTATIINPS.DATA_REGISTRAZIONE is 'Data di registrazione, comprensiva di ore e minuti';
comment on column T048_ATTESTATIINPS.CAUSALE_MAL is 'Causale di malattia utlizzata';
comment on column T048_ATTESTATIINPS.TIPO_ELEMENTO is 'Tipo dell''elemento: I=Attestato di inserimento o rettifica, C=Attestato di annullamento';
comment on column T048_ATTESTATIINPS.ID_CERTIFICATO is 'Protocollo identificativo certificato di malattia fornito dall''INPS (inserito o annullato)';
comment on column T048_ATTESTATIINPS.COD_FISCALE_AZIENDA is 'Codice fiscale dell''azienda';
comment on column T048_ATTESTATIINPS.MATRICOLA_INPS is 'Matricola assegnata dall''INPS all''ente';
comment on column T048_ATTESTATIINPS.COD_SEDE_INPDAP is 'Progressivo INPDAP';
comment on column T048_ATTESTATIINPS.COD_FISCALE_MED is 'Codice fiscale del medico';
comment on column T048_ATTESTATIINPS.COGNOME_MED is 'Cognome del medico';
comment on column T048_ATTESTATIINPS.NOME_MED is 'Nome del medico';
comment on column T048_ATTESTATIINPS.COD_REGIONE is 'Codice regione ASL di appartenenza';
comment on column T048_ATTESTATIINPS.COD_ASL is 'Codice ASL di appartenenza';
comment on column T048_ATTESTATIINPS.COD_FISCALE is 'Codice fiscale del lavoratore';
comment on column T048_ATTESTATIINPS.COGNOME is 'Cognome del lavoratore';
comment on column T048_ATTESTATIINPS.NOME is 'Nome del lavoratore';
comment on column T048_ATTESTATIINPS.SESSO is 'Sesso del lavoratore';
comment on column T048_ATTESTATIINPS.DATA_NAS is 'Data nascita del lavoratore';
comment on column T048_ATTESTATIINPS.CODCATASTALE_NAS is 'Codice comune nascita del lavoratore';
comment on column T048_ATTESTATIINPS.PROV_NAS is 'Provincia nascita del lavoratore';
comment on column T048_ATTESTATIINPS.VIA_DOM is 'Indirizzo domicilio abituale del lavoratore';
comment on column T048_ATTESTATIINPS.CAP_DOM is 'CAP domicilio abituale del lavoratore';
comment on column T048_ATTESTATIINPS.CODCATASTALE_DOM is 'Codice comune domicilio abituale del lavoratore';
comment on column T048_ATTESTATIINPS.PROV_DOM is 'Provincia domicilio abituale del lavoratore';
comment on column T048_ATTESTATIINPS.COGNOME_REP is 'Cognome di riferimento presso il quale il lavoratore è reperibile';
comment on column T048_ATTESTATIINPS.VIA_REP is 'Indirizzo reperibilità del lavoratore';
comment on column T048_ATTESTATIINPS.CAP_REP is 'CAP reperibilità del lavoratore';
comment on column T048_ATTESTATIINPS.CODCATASTALE_REP is 'Codice comune reperibilità del lavoratore';
comment on column T048_ATTESTATIINPS.PROV_REP is 'Provincia reperibilità del lavoratore';
comment on column T048_ATTESTATIINPS.DATA_RILASCIO is 'Data di rilascio del certificato';
comment on column T048_ATTESTATIINPS.DATA_INIZIO_MAL is 'Data inizio malattia';
comment on column T048_ATTESTATIINPS.DATA_FINE_MAL is 'Data fine malattia';
comment on column T048_ATTESTATIINPS.COD_DIAGNOSI is 'Codice diagnosi se prevista dalla legge';
comment on column T048_ATTESTATIINPS.TESTO_DIAGNOSI is 'Testo diagnosi se previsto dalla legge';
comment on column T048_ATTESTATIINPS.TIPO_CERTIFICATO is 'Tipo certificato: I=Inizio, C=Continuazione, R=Ricaduta';
comment on column T048_ATTESTATIINPS.ID_CERTIFICATO_RETT is 'Protocollo identificativo certificato di malattia originario in caso di rettifica';

alter table T048_ATTESTATIINPS
  add constraint T048_PK primary key (TIPO_ELEMENTO, ID_CERTIFICATO)
  using index tablespace INDICI storage(initial 256K next 256K pctincrease 0);

alter table T048_ATTESTATIINPS
  add constraint T048_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

create index T040_ID_RICHIESTA on T040_GIUSTIFICATIVI (ID_RICHIESTA) tablespace INDICI;

alter table MONDOEDP.I071_PERMESSI add ELIMINA_STORICI varchar2(1) default 'S';
comment on column MONDOEDP.I071_PERMESSI.ELIMINA_STORICI is 'S=è possibile eliminare le storicizzazioni della T430_STORICO, N=non è possibile eliminare le storicizzazioni della T430_STORICO';

-- ADDIZIONALI REGIONALI LIGURIA
update p044_entiirpeffasce t set t.importo_a=30000
where t.anno=2010 and t.tipo_addizionale='R' and t.cod_ente='09' and t.importo_da=0;

update p044_entiirpeffasce t set t.importo_da=30000.01
where t.anno=2010 and t.tipo_addizionale='R' and t.cod_ente='09' and t.importo_a=0;

-- ADDIZIONALI REGIONALI BOLZANO
update p042_entiirpef t set t.ritenuta_scaglioni='S',t.ritenuta_perc=0
where t.anno>=2010 and t.tipo_addizionale='R' and t.cod_ente='03';

insert into p044_entiirpeffasce
select 2010,'R','03',0,12500,0 from dual
where not exists
(select 'x' from p044_entiirpeffasce t where t.anno=2010 and t.tipo_addizionale='R' and t.cod_ente='03' and t.importo_da=0)/*--NOLOG--*/;

insert into p044_entiirpeffasce
select 2010,'R','03',12500.01,0,0.9 from dual
where not exists
(select 'x' from p044_entiirpeffasce t where t.anno=2010 and t.tipo_addizionale='R' and t.cod_ente='03' and t.importo_a=0)/*--NOLOG--*/;

insert into p044_entiirpeffasce
select 2011,'R','03',0,12500,0 from dual
where not exists
(select 'x' from p044_entiirpeffasce t where t.anno=2011 and t.tipo_addizionale='R' and t.cod_ente='03' and t.importo_da=0)/*--NOLOG--*/;

insert into p044_entiirpeffasce
select 2011,'R','03',12500.01,0,0.9 from dual
where not exists
(select 'x' from p044_entiirpeffasce t where t.anno=2011 and t.tipo_addizionale='R' and t.cod_ente='03' and t.importo_a=0)/*--NOLOG--*/;

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from i500_datiliberi t where NOMECAMPO = 'INCARICO' and TABELLA = 'S';
    if i > 0 then
      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV035-011-2010'',''Dirigente medico < 5 anni con struttura complessa area chirurgica'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV035-011-2010'')';

      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''MV035-011-2010'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. medico < 5 anni con S.C. chirurgica (dec. 2010)'',
        ''00212'', ''BASE'', 1188.4, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''MV035-011-2010'')';
      EXECUTE IMMEDIATE 'UPDATE I501INCARICO T SET T.DESCRIZIONE=''Dirigente medico < 5 anni con struttura complessa area chirurgica (dec. 2010)'' WHERE T.CODICE=''MV035-011-2010''';
    end if;
  end if;
end;
/

-- Modifica scheda riepilogativa per indennita’ di presenza negative
alter table T072_SCHEDAINDPRES modify INDPRES VARCHAR2(5);
comment on column T072_SCHEDAINDPRES.INDPRES
  is 'Valore formattato -99,d oppure 99,d. Il negativo serve per stornare ind.precedenti';
-- Gestione dell’equlibrio turni bimestrale 
alter table T162_INDENNITA add nmesi_equiturni number default 1;
comment on column T162_INDENNITA.nmesi_equiturni
  is 'Periodicita'' mesi per controllo equilibrio turni. Valori ammessi: 1=Mensile,2=Bimestrale fisso (gen.-feb.,mar.apr.,....,nov.-dic.)';

alter table T134_ORELIQUIDATEANNIPREC add OREPERSE varchar2(1) default 'N';
comment on column T134_ORELIQUIDATEANNIPREC.OREPERSE is 
  'N=il movimento si riferisce ai normali residui dell''ANNO, S=il movimento si riferisce alle ore perse totalizzate nell''ANNO';

-- Creazione voce EDP e EDPSC 13151 BASE

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
begin
  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='13150' AND T.COD_VOCE_SPECIALE='BASE';
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='13151' AND T.COD_VOCE_SPECIALE='BASE';
    if i = 0 then
  
      CodVoceModello:='13150';
      CodVoceCopia:='13151';
      DesVoceCopia:='Credito riconosciuto famiglie numerose';
      DesVoceCopiaSt:='Credito riconosciuto famiglie numerose';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    end if;
  end if;

  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='13150' AND T.COD_VOCE_SPECIALE='BASE';
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='13151' AND T.COD_VOCE_SPECIALE='BASE';
    if i = 0 then
  
      CodVoceModello:='13150';
      CodVoceCopia:='13151';
      DesVoceCopia:='Credito riconosciuto famiglie numerose';
      DesVoceCopiaSt:='Credito riconosciuto famiglie numerose';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
      WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

    end if;
  end if;
 end;
/

delete from T432_DATALAVORO T432
where  UTENTE in (select NOME_UTENTE from MONDOEDP.I060_LOGIN_DIPENDENTE where AZIENDA = :AZIENDA minus 
select utente from MONDOEDP.I070_UTENTI where AZIENDA = :AZIENDA)
and    not exists (select 'x' from MONDOEDP.I061_PROFILI_DIPENDENTE where AZIENDA = :AZIENDA and NOME_UTENTE = T432.UTENTE and FILTRO_ANAGRAFE is not null);

alter table T265_CAUASSENZE add GLAVINPS varchar2(1) default 'N';
comment on column T265_CAUASSENZE.GLAVINPS is 'Giorno lavorativo ai fini INPS';

alter table P673_XMLDATIINDIVIDUALI add ATTRIBUTO VARCHAR2(20);
comment on column P673_XMLDATIINDIVIDUALI.ATTRIBUTO
  is 'Eventuale attributo dell''elemento';

alter table T910_RIEPILOGO modify APPLICAZIONE varchar2(70);

alter table T275_CAUPRESENZE add ARROT_MODORA varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.ARROT_MODORA is 'S=le timbrature causalizzate vengono arrotondate con le regole del modello orario, N=le timbrature causalizzate non vengono toccate dagli arrotondamenti del modello orario';

alter table T275_CAUPRESENZE add TIMB_PM_DETRAZ varchar2(1) default 'N';
comment on column T275_CAUPRESENZE.TIMB_PM_DETRAZ is 'S=il riepilogo giornaliero può essere abbattuto dalla detrazione pausa mensa se ci sono fruizioni che intersecano la fascia PMT';

update T275_CAUPRESENZE set E_IN_FLESSIBILITA = 'N' where TIPOCONTEGGIO in ('B','C');

update T011_CALENDARI set FESTIVO = 'S' where DATA = to_date('17032011','ddmmyyyy');
update T012_CALENDINDIVID set FESTIVO = 'S' where DATA = to_date('17032011','ddmmyyyy');

drop index T050_IDRICH /*--NOLOG--*/;

create unique index T050_IDRICH on T050_RICHIESTEASSENZA (ID)
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from i500_datiliberi t where NOMECAMPO = 'INCARICO' and TABELLA = 'S';
    if i > 0 then
      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''MV030-011-2010-S2002'',''Dirigente medico equiparato con struttura complessa area chirurgica (dec. 2010) - semplice (dec. 2002)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''MV030-011-2010-S2002'')';

      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''MV030-011-2010-S2002'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. medico equiparato con S.C. chirurgica (dec. 2010) - S.S. (dec. 2002)'',
        ''00212'', ''BASE'', 657.10, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''MV030-011-2010-S2002'' AND T.COD_VOCE=''00212'')';
      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''MV030-011-2010-S2002'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. medico equiparato con S.C. chirurgica (dec. 2010) - S.S. (dec. 2002)'',
        ''00208'', ''BASE'', 253.74, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''MV030-011-2010-S2002'' AND T.COD_VOCE=''00208'')';

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR071-073-2010'',''Dirigente ruolo tecnico < 5 anni con struttura semplice (dec. 2010)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR071-073-2010'')';

      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''DR071-073-2010'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. ruolo tecnico < 5 anni con S.S. (dec. 2010)'',
        ''00212'', ''BASE'', 541.03, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''DR071-073-2010'' AND T.COD_VOCE=''00212'')';
    end if;
  end if;
end;
/

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Detraz_Irpef_Familiari';
    if i = 0 then
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', -1, ''"2011"'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', -2, ''Stringa'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 0, ''SELECT MATRICOLA, COGNOME, NOME, FINE_SERVIZIO, DATA_ULTIMA_DICHIAR,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 1, ''       DECODE(DATA_ULTIMA_DICHIAR,'''''''','''''''',MODALITA_DICHIAR) MODALITA_DICHIAR FROM'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 2, ''('', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 3, ''SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 4, ''  DECODE(TO_CHAR(MAX(NVL(T430.FINE,TO_DATE(''''31123999'''',''''DDMMYYYY''''))),''''DD/MM/YYYY''''),''''31/12/3999'''','''''''',TO_CHAR(MAX(T430.FINE),''''DD/MM/YYYY'''')) FINE_SERVIZIO,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 5, ''  DECODE(MAX(NVL(TO_CHAR(SG101.DATA_ULT_FAM_CAR,''''YYYY''''),''''3999'''')),:Anno,MAX(SG101.DATA_ULT_FAM_CAR),'''''''') DATA_ULTIMA_DICHIAR,'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 6, ''  DECODE(MAX(NVL(SG120.CONFERMA,''''N'''')),''''N'''',''''OPERATORE'''',''''WEB'''') MODALITA_DICHIAR'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 7, ''  FROM SG101_FAMILIARI SG101, T030_ANAGRAFICO T030, T430_STORICO T430, SG120_FAMILIARIDIPGEN SG120'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 8, ''WHERE T030.PROGRESSIVO = SG101.PROGRESSIVO AND T430.PROGRESSIVO = SG101.PROGRESSIVO AND SG120.PROGRESSIVO(+) = SG101.PROGRESSIVO'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 9, ''AND :ANNO BETWEEN TO_CHAR(T430.DATADECORRENZA,''''YYYY'''') AND TO_CHAR(T430.DATAFINE,''''YYYY'''')'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 10, ''AND NVL(TO_CHAR(T430.FINE,''''YYYY''''),''''3999'''') >= :Anno'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 11, ''AND :ANNO BETWEEN TO_CHAR(SG101.DECORRENZA,''''YYYY'''') AND TO_CHAR(SG101.DECORRENZA_FINE,''''YYYY'''')'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 12, ''AND SG101.TIPO_DETRAZIONE <> ''''ND'''''', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 13, ''AND NVL(TO_CHAR(SG120.DATA_AGG(+),''''YYYY''''),:Anno) = :Anno AND SG120.CONFERMA(+) = ''''S'''''', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 14, ''GROUP BY T030.MATRICOLA, T030.COGNOME, T030.NOME'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 15, '')'', ''PAGHE'')';
      EXECUTE IMMEDIATE 'insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values (''PA_Detraz_Irpef_Familiari'', 16, ''ORDER BY COGNOME, NOME, MATRICOLA'', ''PAGHE'')';
    end if;
  end if;
end;
/
