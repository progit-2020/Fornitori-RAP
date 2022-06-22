update MONDOEDP.I090_ENTI set VERSIONEDB = '8.4',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

INSERT INTO T033_LAYOUT
SELECT NOME, 1 TOP, 1 LFT, 'EMail account IrisWeb' CAPTION, 'N' ACCESSO, 'Dati Anagrafici' NOMEPAGINA, 'I060EMAIL' CAMPODB
FROM T033_LAYOUT T1 WHERE CAMPODB = 'MATRICOLA'
AND NOT EXISTS (SELECT 1 FROM T033_LAYOUT T2 WHERE T2.NOME = T1.NOME AND T2.CAMPODB = 'I060EMAIL');

alter table T020_ORARI add CAUSALI_ECCEDENZA varchar2(20);
comment on column T020_ORARI.CAUSALI_ECCEDENZA is 'Elenco delle causali di presenza in cui riepilogare l''eccedenza giornaliera liquidabile';

alter table T220_PROFILIORARI add PRIORITA_DOM_FEST varchar2(1) default 'N';
comment on column T220_PROFILIORARI.PRIORITA_DOM_FEST is 'S=nelle Domeniche viene scelto l''orario della Domenica invece che il Festivo';

alter table T326_RICHIESTESTR_SPEZ add DATA_SPEZ date;
comment on column T326_RICHIESTESTR_SPEZ.DATA_SPEZ is 'Data di riferimento dello spezzone per i conteggi';
update T326_RICHIESTESTR_SPEZ T326
set    DATA_SPEZ = (select DATA 
                    from   T325_RICHIESTESTR_GG
                    where  ID = T326.ID);

create table T027_SOGLIE_STR_INPUT (
  ID number(38),
  TIPOCARTELLINO varchar2(5),
  DECORRENZA date,
  DECORRENZA_FINE date,
  SELEZIONE_ANAGRAFE varchar2(2000),
  CAUSALI_GGLAV varchar2(200),
  CAUSALI_GGNONLAV varchar2(200)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T027_SOGLIE_STR_INPUT modify SELEZIONE_ANAGRAFE default '1=1';
alter table T027_SOGLIE_STR_INPUT add constraint T027_PK primary key (TIPOCARTELLINO,DECORRENZA,SELEZIONE_ANAGRAFE,CAUSALI_GGLAV) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T027_SOGLIE_STR_INPUT add constraint T027_UK unique (ID) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

comment on column T027_SOGLIE_STR_INPUT.TIPOCARTELLINO is 'T025.CODICE';
comment on column T027_SOGLIE_STR_INPUT.SELEZIONE_ANAGRAFE is 'condizione SQL sull''anagrafico per individuare i dipendenti interessati da questa regola';
comment on column T027_SOGLIE_STR_INPUT.CAUSALI_GGLAV is 'elenco causali da considerare per la suddivisione dello straordinario nei giorni lavorativi';
comment on column T027_SOGLIE_STR_INPUT.CAUSALI_GGNONLAV is 'elenco causali da considerare per la suddivisione dello straordinario nei giorni non lavorativi';

create sequence T027_ID minvalue 1 maxvalue 999999999999999999999999999 start with 1 increment by 1 nocache;

create table T028_SOGLIE_STR_OUTPUT (
  ID number(38),
  SOGLIA varchar2(7),
  CAUSALE_GGLAV varchar2(5),
  CAUSALE_GGNONLAV varchar2(5)
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table T028_SOGLIE_STR_OUTPUT add constraint T028_PK primary key (ID,SOGLIA) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table T028_SOGLIE_STR_OUTPUT add constraint T028_FK_T027 foreign key (ID) references T027_SOGLIE_STR_INPUT (ID) on delete cascade;

comment on column T028_SOGLIE_STR_OUTPUT.ID is 'T027.ID';
comment on column T028_SOGLIE_STR_OUTPUT.SOGLIA is 'Soglia dell''eccedenza oltre il debito mensile oraria o in percentuale entro la quale applicare la suddivisione nelle causali specificate';
comment on column T028_SOGLIE_STR_OUTPUT.CAUSALE_GGLAV is 'causale in cui riepilogare le ore provenienti da T027.CAUSALI_GGLAV';
comment on column T028_SOGLIE_STR_OUTPUT.CAUSALE_GGNONLAV is 'causale in cui riepilogare le ore provenienti da T027.CAUSALI_GGNONLAV';

create table T029_RIENTRI_OBBLIGATORI (
  CODICE VARCHAR2(5) not null,
  DECORRENZA DATE not null,
  GG_LAVORATIVI NUMBER not null,
  DECORRENZA_FINE DATE,
  RIENTRI_OBBL NUMBER not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
comment on column T029_RIENTRI_OBBLIGATORI.CODICE is 'Corrisponde al CODICE della tabella T025_CONTMENSILI';
comment on column T029_RIENTRI_OBBLIGATORI.GG_LAVORATIVI is 'Giorni lavorativi del mese a cui corrispondono i rientri obbligatori specificati nell''apposito campo';
comment on column T029_RIENTRI_OBBLIGATORI.RIENTRI_OBBL is 'Rientri obbligatori corrispondenti ai giorni lavorativi specificati nell''apposito campo';
alter table T029_RIENTRI_OBBLIGATORI add constraint T029_PK primary key (CODICE, DECORRENZA, GG_LAVORATIVI) 
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T025_CONTMENSILI add RECDEBITO_MAXTOLLERATO varchar2(7);
comment on column T025_CONTMENSILI.RECDEBITO_MAXTOLLERATO is 'Soglia massima di negativi tollerati oltre la quale scatta il recupero del debito sulle paghe';
alter table T025_CONTMENSILI add CAUS_RIENTRIOBBL varchar2(1000);
comment on column T025_CONTMENSILI.CAUS_RIENTRIOBBL is 'Causali di assenza utilizzabili per sostituire i rientri obbligatori non resi';
alter table SG651_PIANIFICAZIONECORSI drop column ORA_INIZIO_PAUSA;
alter table SG651_PIANIFICAZIONECORSI drop column ORA_FINE_PAUSA;
alter table SG651_PIANIFICAZIONECORSI add INIZIO2 VARCHAR2(5);
alter table SG651_PIANIFICAZIONECORSI add FINE2 VARCHAR2(5);

alter table T001_PARAMETRIFUNZIONI add UTENTE varchar2(30);
alter table T001_PARAMETRIFUNZIONI drop constraint T001_PK;
drop index T001_PK;
alter table T001_PARAMETRIFUNZIONI modify PROGOPERATORE null/*--NOLOG--*/;

update T001_PARAMETRIFUNZIONI set UTENTE = PROGOPERATORE;
alter table T001_PARAMETRIFUNZIONI add constraint T001_PK primary key (UTENTE,PROG,NOME) using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

declare
  cursor c1 is
    select distinct I070.PROGRESSIVO,I070.UTENTE 
    from T001_PARAMETRIFUNZIONI T001, MONDOEDP.I070_UTENTI I070
    where T001.PROGOPERATORE = I070.PROGRESSIVO
    and I070.AZIENDA = :AZIENDA;
begin
  for t1 in c1 loop
    update T001_PARAMETRIFUNZIONI set UTENTE = T1.UTENTE where PROGOPERATORE = T1.PROGRESSIVO;
  end loop;
  commit;
end;
/

alter table T025_CONTMENSILI add PA_RAGGR_LIMITESALDOATT varchar2(5);
alter table T025_CONTMENSILI add PA_RAGGR_LIMITESALDOPREC varchar2(5);
alter table T025_CONTMENSILI add PA_RAGGR_LIMITE varchar2(5);

comment on column T025_CONTMENSILI.PA_RAGGR_LIMITESALDOATT is 'Raggruppamento di assenza su cui caricare come competenze individuali annuali le ore derivate dall''applicazione del limite sull''anno attuale';
comment on column T025_CONTMENSILI.PA_RAGGR_LIMITESALDOPREC is 'Raggruppamento di assenza su cui caricare come competenze individuali annuali le ore derivate dall''applicazione del limite sull''anno precedente';
comment on column T025_CONTMENSILI.PA_RAGGR_LIMITE is 'Raggruppamento di assenza su cui caricare come competenze individuali annuali le ore derivate dall''applicazione del limite complessivo sull''anno';

ALTER TABLE P590_CONTABREGOLE ADD DETTAGLIO_VOCI VARCHAR2(1) DEFAULT 'N' NOT NULL;
comment on column P590_CONTABREGOLE.DETTAGLIO_VOCI is 'Dettaglio voci individuale (S/N)';

ALTER TABLE P593_CONTABDATIINDIVIDUALI ADD COD_CONTRATTO VARCHAR2(5);
ALTER TABLE P593_CONTABDATIINDIVIDUALI ADD COD_VOCE VARCHAR2(5);
ALTER TABLE P593_CONTABDATIINDIVIDUALI ADD COD_VOCE_SPECIALE VARCHAR2(5);
comment on column P593_CONTABDATIINDIVIDUALI.COD_CONTRATTO is 'Codice contratto';
comment on column P593_CONTABDATIINDIVIDUALI.COD_VOCE is 'Codice voce';
comment on column P593_CONTABDATIINDIVIDUALI.COD_VOCE_SPECIALE is 'Codice voce speciale';

ALTER TABLE P593_CONTABDATIINDIVIDUALI drop primary key;
drop index P593_PK;
create unique index P593_IDX on P593_CONTABDATIINDIVIDUALI (ID_CONTAB, PROGRESSIVO, CONTO, TIPO_RECORD, COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE)
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

delete from p205_quote t 
where t.cod_contratto='EDP' and t.cod_voce_da_quotare='00455' and t.cod_voce_speciale_da_quotare='BASE'
and t.cod_voce_in_quota='00130' and t.cod_voce_speciale_in_quota='BASE';

alter table P260_MOD730TIPOIMPORTI modify DESCRIZIONE VARCHAR2(50);

-- INIZIO CREAZIONE NUOVI IMPORTI 730 (cedolare secca locazioni e contributo solidarietà)

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
begin
  select COUNT(*) into i from P441_CEDOLINO where EXISTS (select 'X' from P260_MOD730TIPOIMPORTI t1 where T1.ANNO=2012 AND T1.COD_TIPOIMPORTO='RID');
  if i > 0 then
    select COUNT(*) into i from P260_MOD730TIPOIMPORTI t where T.ANNO=2012 AND T.COD_TIPOIMPORTO='TLD';
    if i = 0 then

update p260_mod730tipoimporti t set t.ordine_pagamento_incapiente=20
where t.anno=2012 and t.cod_tipoimporto='2ID';
update p260_mod730tipoimporti t set t.ordine_pagamento_incapiente=21
where t.anno=2012 and t.cod_tipoimporto='2IC';

insert into P260_MOD730TIPOIMPORTI
select anno, 'TLD', 'Trattenuta cedolare secca locazioni dichiarante', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11830', cod_voce_speciale, int_rate, '11831', cod_voce_speciale_int_rate, int_ritardo, '11832', cod_voce_speciale_int_ritardo, 15, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='TID';

insert into P260_MOD730TIPOIMPORTI
select anno, 'TLC', 'Trattenuta cedolare secca locazioni coniuge', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11835', cod_voce_speciale, int_rate, '11836', cod_voce_speciale_int_rate, int_ritardo, '11837', cod_voce_speciale_int_ritardo, 16, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='TIC';

insert into P260_MOD730TIPOIMPORTI
select anno, 'TOD', 'Trattenuta contributo solidarieta'' dichiarante', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11860', cod_voce_speciale, int_rate, '11861', cod_voce_speciale_int_rate, int_ritardo, '11862', cod_voce_speciale_int_ritardo, 19, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='TID';

insert into P260_MOD730TIPOIMPORTI
select anno, 'RLD', 'Rimborso cedolare secca locazioni dichiarante', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11907', cod_voce_speciale, int_rate, cod_voce_int_rate, cod_voce_speciale_int_rate, int_ritardo, cod_voce_int_ritardo, cod_voce_speciale_int_ritardo, ordine_pagamento_incapiente, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='RID';

insert into P260_MOD730TIPOIMPORTI
select anno, 'RLC', 'Rimborso cedolare secca locazioni coniuge', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11908', cod_voce_speciale, int_rate, cod_voce_int_rate, cod_voce_speciale_int_rate, int_ritardo, cod_voce_int_ritardo, cod_voce_speciale_int_ritardo, ordine_pagamento_incapiente, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='RIC';

insert into P260_MOD730TIPOIMPORTI
select anno, '1LD', 'Prima rata cedolare secca dichiarante', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11930', cod_voce_speciale, int_rate, '11931', cod_voce_speciale_int_rate, int_ritardo, '11932', cod_voce_speciale_int_ritardo, 17, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='1ID';

insert into P260_MOD730TIPOIMPORTI
select anno, '1LC', 'Prima rata cedolare secca coniuge', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11935', cod_voce_speciale, int_rate, '11936', cod_voce_speciale_int_rate, int_ritardo, '11937', cod_voce_speciale_int_ritardo, 18, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='1IC';

insert into P260_MOD730TIPOIMPORTI
select anno, '2LD', 'Seconda rata cedolare secca dichiarante', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11940', cod_voce_speciale, int_rate, cod_voce_int_rate, cod_voce_speciale_int_rate, int_ritardo, '11942', cod_voce_speciale_int_ritardo, 22, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='2ID';

insert into P260_MOD730TIPOIMPORTI
select anno, '2LC', 'Seconda rata cedolare secca coniuge', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11945', cod_voce_speciale, int_rate, cod_voce_int_rate, cod_voce_speciale_int_rate, int_ritardo, '11947', cod_voce_speciale_int_ritardo, 23, attribuzione_dimessi, anno_imposta
from p260_mod730tipoimporti t where t.anno=2012 and t.cod_tipoimporto='2IC';

-- CREAZIONE NUOVE VOCI 730 PER CONTRATTO EDP

-- Inizio Rimborso cedolare secca dichiarante 730

CodVoceModello:='11905';
CodVoceCopia:='11907';
DesVoceCopia:='Rimborso cedolare secca dichiarante 730';
DesVoceCopiaSt:='Rimborso cedolare secca dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Rimborso cedolare secca dichiarante 730

-- Inizio Rimborso cedolare secca coniuge 730

CodVoceModello:='11906';
CodVoceCopia:='11908';
DesVoceCopia:='Rimborso cedolare secca coniuge 730';
DesVoceCopiaSt:='Rimborso cedolare secca coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Rimborso cedolare secca coniuge 730

-- Inizio Trattenuta cedol. secca dichiarante 730

CodVoceModello:='11800';
CodVoceCopia:='11830';
DesVoceCopia:='Trattenuta cedol. secca dichiarante 730';
DesVoceCopiaSt:='Trattenuta cedol. secca dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Trattenuta cedol. secca dichiarante 730

-- Inizio Int. rateizz. tratt. cedol. dichiar. 730

CodVoceModello:='11801';
CodVoceCopia:='11831';
DesVoceCopia:='Int. rateizz. tratt. cedol. dichiar. 730';
DesVoceCopiaSt:='Int. rateizz. tratt. cedol. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. rateizz. tratt. cedol. dichiar. 730

-- Inizio Int. ritardo tratt. cedol. dichiar. 730

CodVoceModello:='11802';
CodVoceCopia:='11832';
DesVoceCopia:='Int. ritardo tratt. cedol. dichiar. 730';
DesVoceCopiaSt:='Int. ritardo tratt. cedol. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. ritardo tratt. cedol. dichiar. 730

-- Inizio Trattenuta cedol. secca coniuge 730

CodVoceModello:='11805';
CodVoceCopia:='11835';
DesVoceCopia:='Trattenuta cedol. secca coniuge 730';
DesVoceCopiaSt:='Trattenuta cedol. secca coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Trattenuta cedol. secca coniuge 730

-- Inizio Int. rateizz. tratt. cedol. coniuge 730

CodVoceModello:='11806';
CodVoceCopia:='11836';
DesVoceCopia:='Int. rateizz. tratt. cedol. coniuge 730';
DesVoceCopiaSt:='Int. rateizz. tratt. cedol. coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. rateizz. tratt. cedol. coniuge 730

-- Inizio Int. ritardo tratt. cedol. coniuge. 730

CodVoceModello:='11807';
CodVoceCopia:='11837';
DesVoceCopia:='Int. ritardo tratt. cedol. coniuge 730';
DesVoceCopiaSt:='Int. ritardo tratt. cedol. coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. ritardo tratt. cedol. coniuge 730

-- Inizio Prima rata cedolare dichiarante 730

CodVoceModello:='11810';
CodVoceCopia:='11930';
DesVoceCopia:='Prima rata cedolare dichiarante 730';
DesVoceCopiaSt:='Prima rata cedolare dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Prima rata cedolare dichiarante 730

-- Inizio Int.rateizz.prima rata cedol.dichiar.730

CodVoceModello:='11811';
CodVoceCopia:='11931';
DesVoceCopia:='Int.rateizz.prima rata cedol.dichiar.730';
DesVoceCopiaSt:='Int.rateizz.prima rata cedol.dichiar.730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.rateizz.prima rata cedol.dichiar.730

-- Inizio Int.ritardo prima rata cedol.dichiar.730

CodVoceModello:='11812';
CodVoceCopia:='11932';
DesVoceCopia:='Int.ritardo prima rata cedol.dichiar.730';
DesVoceCopiaSt:='Int.ritardo prima rata cedol.dichiar.730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo prima rata cedol.dichiar.730

-- Inizio Prima rata cedolare coniuge 730

CodVoceModello:='11820';
CodVoceCopia:='11935';
DesVoceCopia:='Prima rata cedolare coniuge 730';
DesVoceCopiaSt:='Prima rata cedolare coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Prima rata cedolare coniuge 730

-- Inizio Int.rateizz.prima rata cedol.coniuge 730

CodVoceModello:='11821';
CodVoceCopia:='11936';
DesVoceCopia:='Int.rateizz.prima rata cedol.coniuge 730';
DesVoceCopiaSt:='Int.rateizz.prima rata cedol.coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.rateizz.prima rata cedol.coniuge 730

-- Inizio Int.ritardo prima rata cedol.coniuge 730

CodVoceModello:='11822';
CodVoceCopia:='11937';
DesVoceCopia:='Int.ritardo prima rata cedol.coniuge 730';
DesVoceCopiaSt:='Int.ritardo prima rata cedol.coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo prima rata cedol.coniuge 730

-- Inizio Seconda rata cedolare dichiarante 730

CodVoceModello:='11815';
CodVoceCopia:='11940';
DesVoceCopia:='Seconda rata cedolare dichiarante 730';
DesVoceCopiaSt:='Seconda rata cedolare dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Seconda rata cedolare dichiarante 730

-- Inizio Int.ritardo sec. rata cedol. dichiar.730

CodVoceModello:='11817';
CodVoceCopia:='11942';
DesVoceCopia:='Int.ritardo sec. rata cedol. dichiar.730';
DesVoceCopiaSt:='Int.ritardo sec. rata cedol. dichiar.730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo sec. rata cedol. dichiar.730

-- Inizio Seconda rata cedolare coniuge 730

CodVoceModello:='11825';
CodVoceCopia:='11945';
DesVoceCopia:='Seconda rata cedolare coniuge 730';
DesVoceCopiaSt:='Seconda rata cedolare coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Seconda rata cedolare coniuge 730

-- Inizio Int.ritardo sec. rata cedol. coniuge 730

CodVoceModello:='11827';
CodVoceCopia:='11947';
DesVoceCopia:='Int.ritardo sec. rata cedol. coniuge 730';
DesVoceCopiaSt:='Int.ritardo sec. rata cedol. coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo sec. rata cedol. coniuge 730

-- Inizio Trattenuta solidarietà dichiarante 730

CodVoceModello:='11800';
CodVoceCopia:='11860';
DesVoceCopia:='Trattenuta solidarietà dichiarante 730';
DesVoceCopiaSt:='Trattenuta solidarieta'' dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Trattenuta solidarietà dichiarante 730

-- Inizio Int. rateizz. tratt. solid. dichiar. 730

CodVoceModello:='11801';
CodVoceCopia:='11861';
DesVoceCopia:='Int. rateizz. tratt. solid. dichiar. 730';
DesVoceCopiaSt:='Int. rateizz. tratt. solid. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. rateizz. tratt. solid. dichiar. 730

-- Inizio Int. ritardo tratt. solid. dichiar. 730

CodVoceModello:='11802';
CodVoceCopia:='11862';
DesVoceCopia:='Int. ritardo tratt. solid. dichiar. 730';
DesVoceCopiaSt:='Int. ritardo tratt. solid. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. Int. ritardo tratt. solid. dichiar. 730

      select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDPSC' and t.cod_voce='11800';
      if i > 0 then

-- CREAZIONE NUOVE VOCI 730 PER CONTRATTO EDPSC

-- Inizio Rimborso cedolare secca dichiarante 730

CodVoceModello:='11905';
CodVoceCopia:='11907';
DesVoceCopia:='Rimborso cedolare secca dichiarante 730';
DesVoceCopiaSt:='Rimborso cedolare secca dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Rimborso cedolare secca dichiarante 730

-- Inizio Rimborso cedolare secca coniuge 730

CodVoceModello:='11906';
CodVoceCopia:='11908';
DesVoceCopia:='Rimborso cedolare secca coniuge 730';
DesVoceCopiaSt:='Rimborso cedolare secca coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Rimborso cedolare secca coniuge 730

-- Inizio Trattenuta cedol. secca dichiarante 730

CodVoceModello:='11800';
CodVoceCopia:='11830';
DesVoceCopia:='Trattenuta cedol. secca dichiarante 730';
DesVoceCopiaSt:='Trattenuta cedol. secca dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Trattenuta cedol. secca dichiarante 730

-- Inizio Int. rateizz. tratt. cedol. dichiar. 730

CodVoceModello:='11801';
CodVoceCopia:='11831';
DesVoceCopia:='Int. rateizz. tratt. cedol. dichiar. 730';
DesVoceCopiaSt:='Int. rateizz. tratt. cedol. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. rateizz. tratt. cedol. dichiar. 730

-- Inizio Int. ritardo tratt. cedol. dichiar. 730

CodVoceModello:='11802';
CodVoceCopia:='11832';
DesVoceCopia:='Int. ritardo tratt. cedol. dichiar. 730';
DesVoceCopiaSt:='Int. ritardo tratt. cedol. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. ritardo tratt. cedol. dichiar. 730

-- Inizio Trattenuta cedol. secca coniuge 730

CodVoceModello:='11805';
CodVoceCopia:='11835';
DesVoceCopia:='Trattenuta cedol. secca coniuge 730';
DesVoceCopiaSt:='Trattenuta cedol. secca coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Trattenuta cedol. secca coniuge 730

-- Inizio Int. rateizz. tratt. cedol. coniuge 730

CodVoceModello:='11806';
CodVoceCopia:='11836';
DesVoceCopia:='Int. rateizz. tratt. cedol. coniuge 730';
DesVoceCopiaSt:='Int. rateizz. tratt. cedol. coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. rateizz. tratt. cedol. coniuge 730

-- Inizio Int. ritardo tratt. cedol. coniuge. 730

CodVoceModello:='11807';
CodVoceCopia:='11837';
DesVoceCopia:='Int. ritardo tratt. cedol. coniuge 730';
DesVoceCopiaSt:='Int. ritardo tratt. cedol. coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. ritardo tratt. cedol. coniuge 730

-- Inizio Prima rata cedolare dichiarante 730

CodVoceModello:='11810';
CodVoceCopia:='11930';
DesVoceCopia:='Prima rata cedolare dichiarante 730';
DesVoceCopiaSt:='Prima rata cedolare dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Prima rata cedolare dichiarante 730

-- Inizio Int.rateizz.prima rata cedol.dichiar.730

CodVoceModello:='11811';
CodVoceCopia:='11931';
DesVoceCopia:='Int.rateizz.prima rata cedol.dichiar.730';
DesVoceCopiaSt:='Int.rateizz.prima rata cedol.dichiar.730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.rateizz.prima rata cedol.dichiar.730

-- Inizio Int.ritardo prima rata cedol.dichiar.730

CodVoceModello:='11812';
CodVoceCopia:='11932';
DesVoceCopia:='Int.ritardo prima rata cedol.dichiar.730';
DesVoceCopiaSt:='Int.ritardo prima rata cedol.dichiar.730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo prima rata cedol.dichiar.730

-- Inizio Prima rata cedolare coniuge 730

CodVoceModello:='11820';
CodVoceCopia:='11935';
DesVoceCopia:='Prima rata cedolare coniuge 730';
DesVoceCopiaSt:='Prima rata cedolare coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Prima rata cedolare coniuge 730

-- Inizio Int.rateizz.prima rata cedol.coniuge 730

CodVoceModello:='11821';
CodVoceCopia:='11936';
DesVoceCopia:='Int.rateizz.prima rata cedol.coniuge 730';
DesVoceCopiaSt:='Int.rateizz.prima rata cedol.coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.rateizz.prima rata cedol.coniuge 730

-- Inizio Int.ritardo prima rata cedol.coniuge 730

CodVoceModello:='11822';
CodVoceCopia:='11937';
DesVoceCopia:='Int.ritardo prima rata cedol.coniuge 730';
DesVoceCopiaSt:='Int.ritardo prima rata cedol.coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo prima rata cedol.coniuge 730

-- Inizio Seconda rata cedolare dichiarante 730

CodVoceModello:='11815';
CodVoceCopia:='11940';
DesVoceCopia:='Seconda rata cedolare dichiarante 730';
DesVoceCopiaSt:='Seconda rata cedolare dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Seconda rata cedolare dichiarante 730

-- Inizio Int.ritardo sec. rata cedol. dichiar.730

CodVoceModello:='11817';
CodVoceCopia:='11942';
DesVoceCopia:='Int.ritardo sec. rata cedol. dichiar.730';
DesVoceCopiaSt:='Int.ritardo sec. rata cedol. dichiar.730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo sec. rata cedol. dichiar.730

-- Inizio Seconda rata cedolare coniuge 730

CodVoceModello:='11825';
CodVoceCopia:='11945';
DesVoceCopia:='Seconda rata cedolare coniuge 730';
DesVoceCopiaSt:='Seconda rata cedolare coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Seconda rata cedolare coniuge 730

-- Inizio Int.ritardo sec. rata cedol. coniuge 730

CodVoceModello:='11827';
CodVoceCopia:='11947';
DesVoceCopia:='Int.ritardo sec. rata cedol. coniuge 730';
DesVoceCopiaSt:='Int.ritardo sec. rata cedol. coniuge 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int.ritardo sec. rata cedol. coniuge 730

-- Inizio Trattenuta solidarietà dichiarante 730

CodVoceModello:='11800';
CodVoceCopia:='11860';
DesVoceCopia:='Trattenuta solidarietà dichiarante 730';
DesVoceCopiaSt:='Trattenuta solidarieta'' dichiarante 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Trattenuta solidarietà dichiarante 730

-- Inizio Int. rateizz. tratt. solid. dichiar. 730

CodVoceModello:='11801';
CodVoceCopia:='11861';
DesVoceCopia:='Int. rateizz. tratt. solid. dichiar. 730';
DesVoceCopiaSt:='Int. rateizz. tratt. solid. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. rateizz. tratt. solid. dichiar. 730

-- Inizio Int. ritardo tratt. solid. dichiar. 730

CodVoceModello:='11802';
CodVoceCopia:='11862';
DesVoceCopia:='Int. ritardo tratt. solid. dichiar. 730';
DesVoceCopiaSt:='Int. ritardo tratt. solid. dichiar. 730';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;

insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, '', ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-- Fine Int. Int. ritardo tratt. solid. dichiar. 730

      end if;

    end if;

  end if;

end;
/

-- FINE CREAZIONE NUOVI IMPORTI 730 (cedolare secca locazioni e contributo solidarietà)

insert into p216_accorpamentovoci
select 'EDP', '11510', 'BASE', 'TRIM', '01', TO_DATE('01011900','DDMMYYYY'), -100, 'C', TO_DATE('31123999','DDMMYYYY') from DUAL
WHERE NOT EXISTS
(select 'x' from p216_accorpamentovoci t where t.cod_contratto='EDP' and t.cod_voce='11510'
   and t.cod_voce_speciale='BASE' and t.cod_tipoaccorpamentovoci='TRIM'
   and t.cod_codiciaccorpamentovoci='01')
AND EXISTS
(select 'x' from p216_accorpamentovoci t where t.cod_tipoaccorpamentovoci='TRIM' and t.cod_codiciaccorpamentovoci='01');

alter table T065_RICHIESTESTRAORDINARI add CAUSALE varchar2(5);
comment on column T065_RICHIESTESTRAORDINARI.CAUSALE is 'Causale su cui riepilogare le ORE_CAUSALIZZATE';
alter table T065_RICHIESTESTRAORDINARI add ORE_CAUSALIZZATE varchar2(6);
comment on column T065_RICHIESTESTRAORDINARI.ORE_CAUSALIZZATE is 'Ore richieste in liquidazione su causale';

comment on column T025_CONTMENSILI.ITER_AUTORIZZATIVO_STR is '0=No, 1=Banca ore, 2=Straordinario annuo, 3=Straordinario annuo con causale';

alter table T670_REGOLEBUONI add REGOLA_RIENTRO_POMERIDIANO varchar2(1);
comment on column T670_REGOLEBUONI.REGOLA_RIENTRO_POMERIDIANO is 'S=la maturazione del buono è vincolata al riconoscimento del rientro pomeridiano da parte dei conteggi giornalieri';

alter table MONDOEDP.I061_PROFILI_DIPENDENTE add RICEZIONE_MAIL varchar2(1) default 'S';
comment on column MONDOEDP.I061_PROFILI_DIPENDENTE.RICEZIONE_MAIL is 'S=profilo abilitato a ricevere mail, N=profilio non abilitato a ricevere mail';

alter table T275_CAUPRESENZE add INTERSEZIONE_TIMBRATURE varchar2(1) default 'E';
comment on column T275_CAUPRESENZE.INTERSEZIONE_TIMBRATURE is 'E=Conteggia entrambi, T=Conteggia timbrature, G=Conteggia giustificativi';
comment on column T265_CAUASSENZE.INTERSEZIONE_TIMBRATURE is 'E=Conteggia entrambi, T=Conteggia timbrature, G=Conteggia giustificativi';

alter table SG740_REGOLE_VALUTAZIONI add AGGIORNA_DATA_COMPILAZIONE VARCHAR2(1) default 'N';
alter table SG740_REGOLE_VALUTAZIONI add COD_DATO_TIPO_STAMPA VARCHAR2(400);
alter table SG740_REGOLE_VALUTAZIONI add ABILITA_AREE_FORMATIVE VARCHAR2(1) default 'N';
alter table SG740_REGOLE_VALUTAZIONI add ABILITA_ACCETTAZIONE_VALUTATO VARCHAR2(1) default 'N';
alter table SG740_REGOLE_VALUTAZIONI add STAMPA_VARIAZIONI_5 VARCHAR2(1) default 'N';
update SG740_REGOLE_VALUTAZIONI set ABILITA_ACCETTAZIONE_VALUTATO = 'S';
update SG740_REGOLE_VALUTAZIONI set ABILITA_AREE_FORMATIVE = 'S';
alter table SG710_TESTATA_VALUTAZIONI add VALUTABILE VARCHAR2(1) default 'S';
alter table MONDOEDP.I071_PERMESSI add S710_MOD_VALUTATORE VARCHAR2(1) default 'N'/*--NOLOG--*/;

create table T860_ITER_STAMPACARTELLINI (
  ID               number(38) not null,
  PROGRESSIVO      number(38) not null,
  MESE_CARTELLINO  date       not null
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T860_ITER_STAMPACARTELLINI.ID is 'ID univoco della richiesta';
comment on column T860_ITER_STAMPACARTELLINI.PROGRESSIVO is 'Progressivo del dipendente';
comment on column T860_ITER_STAMPACARTELLINI.MESE_CARTELLINO is 'Mese di riferimento del cartellino (primo giorno del mese)';

alter table T860_ITER_STAMPACARTELLINI 
  add constraint T860_PK primary key (ID)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
create unique index T860_UQ_PROGR_MESE
  on T860_ITER_STAMPACARTELLINI (PROGRESSIVO, MESE_CARTELLINO) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index T860I_PROGR
  on T860_ITER_STAMPACARTELLINI (PROGRESSIVO) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

insert into MONDOEDP.I073_FILTROFUNZIONI (AZIENDA,PROFILO,APPLICAZIONE,TAG,FUNZIONE,GRUPPO,DESCRIZIONE,INIBIZIONE)
select AZIENDA,PROFILO,APPLICAZIONE,209,'OpenA008loginDipendente',GRUPPO,DESCRIZIONE,INIBIZIONE from MONDOEDP.I073_FILTROFUNZIONI 
where FUNZIONE = 'OpenA008Operatori' and :AZIENDA = 'AZIN'/*--NOLOG--*/;