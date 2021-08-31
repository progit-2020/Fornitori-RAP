-- Create table
create table T259_CONTROLLI_CAUASSENZE
(
  codice  VARCHAR2(5) not null,
  tipo_controllo  VARCHAR2(1) not null,
  sex_fruitore VARCHAR2(1) not null,
  cau_incompatibile	VARCHAR2(5) not null,
  sex_cau_incomp VARCHAR2(1) not null,
  includi_fam  VARCHAR2(1) not null
) tablespace LAVORO storage (initial 256K next 256K pctincrease 0);
-- Create/Recreate primary, unique and foreign key constraints 
alter table T259_CONTROLLI_CAUASSENZE
  add constraint T259_PK primary key (CODICE, TIPO_CONTROLLO, SEX_FRUITORE, CAU_INCOMPATIBILE, SEX_CAU_INCOMP)
using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);
  
comment on column T259_CONTROLLI_CAUASSENZE.tipo_controllo
  is 'A=Stesso giorno per stesso figlio, B=Stesso mese per stesso figlio';
comment on column T259_CONTROLLI_CAUASSENZE.sex_fruitore
  is 'M=Maschile, F=Femminile, I=Ininfluente';
comment on column T259_CONTROLLI_CAUASSENZE.cau_incompatibile
  is 'Causale di assenza che risulta incompatibile';
comment on column T259_CONTROLLI_CAUASSENZE.sex_cau_incomp
  is 'M=Maschile, F=Femminile, I=Ininfluente';
comment on column T259_CONTROLLI_CAUASSENZE.includi_fam
  is 'S=Includi assenze del familiare, N=Solo assenze del dipendente, F=Solo assenze del familiare';
  
alter table T265_CAUASSENZE add oregg_max_inf6 varchar2(5);
alter table T265_CAUASSENZE add oregg_max_sup6 varchar2(5);

comment on column T265_CAUASSENZE.oregg_max_inf6
  is 'Ore massime giornaliere fruibili dal dipendente nel caso di ore lavorative inferiori a 6';
comment on column T265_CAUASSENZE.oregg_max_sup6
  is 'Ore massime giornaliere fruibili dal dipendente cumulate con il coniuge nel caso di almeno 6 ore lavorative';

alter table MONDOEDP.I095_ITER_AUT add DESCRIZIONE varchar2(80);
comment on column MONDOEDP.I095_ITER_AUT.DESCRIZIONE is 'Descrizione della struttura';

comment on column T048_ATTESTATIINPS.causa_malattia
  is 'G=Gravidanza, S=Sclerosi e patologie documentate';    

alter table SG509_DETTAGLIOSTAMPA add FLAG_NASCONDICODICI varchar2(1) default 'N';
alter table SG509_DETTAGLIOSTAMPA add FLAG_NASCONDIDATOTOT varchar2(1) default 'N';
alter table SG509_DETTAGLIOSTAMPA add FLAG_NASCONDIINTTOT varchar2(1) default 'N';

update MONDOEDP.I100_PARSCARICO set SECONDI = '0,0' where trim(SECONDI) <> '99,99' and :AZIENDA = 'AZIN';

declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ141022_2AddIRPEF.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ141022_2AddIRPEF.sql');
end/*--NOLOG--*/;
/

-- Abbattimento voce EDP-00365 in caso di aspettativa sindacale non retribuita
insert into P205_QUOTE
select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, '00365', cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio, cod_voce_speciale_dettaglio13a
from P205_QUOTE P205 
where P205.COD_CONTRATTO='EDP' and P205.COD_VOCE_DA_QUOTARE='15075' and P205.COD_VOCE_SPECIALE_DA_QUOTARE='BASE'
and P205.COD_VOCE_IN_QUOTA='00010' and P205.COD_VOCE_SPECIALE_IN_QUOTA='BASE'
and not exists
(select 'x' from P205_QUOTE P205A where P205A.COD_CONTRATTO=P205.COD_CONTRATTO
and P205A.COD_VOCE_DA_QUOTARE=P205.COD_VOCE_DA_QUOTARE and P205A.COD_VOCE_SPECIALE_DA_QUOTARE=P205.COD_VOCE_SPECIALE_DA_QUOTARE
and P205A.COD_VOCE_IN_QUOTA='00365' and P205A.COD_VOCE_SPECIALE_IN_QUOTA=P205.COD_VOCE_SPECIALE_IN_QUOTA)
and exists
(select 'x' from P200_VOCI P200 where P200.COD_CONTRATTO=P205.COD_CONTRATTO
and P200.COD_VOCE='00365' AND P200.COD_VOCE_SPECIALE='BASE'
and upper(P200.DESCRIZIONE) like '%RISCHIO%');

-- INIZIO Gestione Integrazione cedolare secca coniuge 730

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

  cursor C1 is  
  select T.COD_CONTRATTO from P200_VOCI T where T.COD_VOCE='11929' and T.COD_VOCE_SPECIALE='BASE'
  and exists 
  (select 'X' from P260_MOD730TIPOIMPORTI V where V.ANNO=2014 and V.COD_TIPOIMPORTO='ILD'
   and V.COD_VOCE=T.COD_VOCE and V.COD_VOCE_SPECIALE=T.COD_VOCE_SPECIALE);

begin
  select count(*) into i from P441_CEDOLINO where exists (select 'X' from P260_MOD730TIPOIMPORTI t1 where T1.ANNO=2014 and T1.COD_TIPOIMPORTO='ILD');
  if i > 0 then
    select count(*) into i from P260_MOD730TIPOIMPORTI t where T.ANNO=2014 and T.COD_TIPOIMPORTO='ILC';
    if i = 0 then

    insert into P260_MOD730TIPOIMPORTI
    select anno, 'ILC', 'Integrazione cedolare secca coniuge', tipo_ente, tipo_importo, mese_iniziale, max_numero_rate, '11928', cod_voce_speciale, int_rate, cod_voce_int_rate, cod_voce_speciale_int_rate, int_ritardo, cod_voce_int_ritardo, cod_voce_speciale_int_ritardo, ordine_pagamento_incapiente, attribuzione_dimessi, anno_imposta
    from p260_mod730tipoimporti t where t.anno=2014 and t.cod_tipoimporto='ILD';

    CodVoceModello:='11929';
    CodVoceCopia:='11928';
    DesVoceCopia:='Integrazione cedol.secca coniuge 730';
    DesVoceCopiaSt:='Integrazione cedol.secca coniuge 730';

    for T1 in C1 loop
      select P200_ID_VOCE.NEXTVAL into ID_P200 from DUAL;

      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
      WHERE T.COD_CONTRATTO=T1.cod_contratto AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

      insert into P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto=T1.cod_contratto and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

    end loop;

      end if;

  end if;

end;
/

-- FINE Gestione Integrazione cedolare secca coniuge 730

update T480_COMUNI T480 set T480.CITTA='BELLAGIO (comune soppresso)' where T480.CODCATASTALE='A744';

insert into t480_comuni
select '013250','BELLAGIO','22021','CO','M335' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M335');

insert into t480_comuni
select '050040','CASCIANA TERME LARI','56035','PI','M327' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M327');

insert into t480_comuni
select '012142','MACCAGNO CON PINO E VEDDASCA','21061','VA','M339' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M339');

insert into t480_comuni
select '013252','TREMEZZINA','22016','CO','M341' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M341');

create table P480_TFRCOEFFICIENTI
(
  data_coefficiente DATE not null,
  coefficiente      NUMBER not null
)
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

comment on column P480_TFRCOEFFICIENTI.coefficiente
  is 'Tasso di rivalutazione mensile del TFR';

alter table P480_TFRCOEFFICIENTI
  add constraint P480_PK primary key (DATA_COEFFICIENTE)
  using index tablespace INDICI 
    storage (initial 256K next 256K pctincrease 0);

create table P482_TFRMATURATO
(
  progressivo             NUMBER not null,
  data_retribuzione       DATE not null,
  tipo_record             VARCHAR2(1) not null,
  chiuso                  VARCHAR2(1) default 'N' not null,
  importo_maturato        NUMBER default 0 not null,
  importo_aggiuntivo      NUMBER default 0 not null,
  importo_rival_anno_prec NUMBER default 0 not null,
  importo_liquidato       NUMBER default 0 not null
)
tablespace LAVORO
storage (initial 256K next 256K pctincrease 0);

comment on column P482_TFRMATURATO.tipo_record
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column P482_TFRMATURATO.chiuso
  is 'Chiuso (S/N) se il mese è stato chiuso';
comment on column P482_TFRMATURATO.importo_maturato
  is 'Importo maturato nel mese';
comment on column P482_TFRMATURATO.importo_aggiuntivo
  is 'Importo aggiuntivo manuale maturato nel mese';
comment on column P482_TFRMATURATO.importo_rival_anno_prec
  is 'Importo rivalutazione anno precedente';
comment on column P482_TFRMATURATO.importo_liquidato
  is 'Importo liquidato';

alter table P482_TFRMATURATO
  add constraint P482_PK primary key (PROGRESSIVO, DATA_RETRIBUZIONE, TIPO_RECORD)
  using index tablespace INDICI 
    storage (initial 256K next 256K pctincrease 0);

alter table P482_TFRMATURATO
  add constraint P482_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

-- Previsto nuovo dato mensile
INSERT INTO P452_DATIMENSILIDESC
SELECT 'MATFR', 'Maturazione TFR', 'T', 0, 'S', 'A' FROM DUAL
WHERE NOT EXISTS 
  (SELECT 'X' FROM P452_DATIMENSILIDESC T WHERE T.COD_CAMPO='MATFR');

update P214_TIPOACCORPAMENTOVOCI P214 set P214.DESCRIZIONE='Accorpamenti CU, 770 e normative varie'
where P214.COD_TIPOACCORPAMENTOVOCI='CU770';