declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ140215_5AddIRPEF.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ140215_5AddIRPEF.sql');
end/*--NOLOG--*/;
/

insert into t480_comuni
select '064121','MONTORO','83025','AV','M330' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M330');
	
insert into t480_comuni
select '020071','BORGO VIRGILIO','46034','MN','M340' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M340');

---------------------------
-- Inizio assoggettamento a gestione separata INPS e INAIL per voce 02932 Incentivi direttori
---------------------------

declare
  i integer;

begin

  select COUNT(*) into i from P200_VOCI t where t.cod_contratto='EDP'
    and t.cod_voce='02932' and t.cod_voce_speciale='BASE' and upper(t.descrizione)like '%INCENT%' and upper(t.descrizione)like '%DIRETTORI%';

if i > 0 then

  INSERT INTO P201_ASSOGGETTAMENTI
  select 'EDP', '02932', 'BASE', '10060', 'BASE', to_date('01011900','ddmmyyyy'), 100, 0, to_date('31123999','ddmmyyyy') from DUAL
  where not exists
    (select 'x' FROM P201_ASSOGGETTAMENTI t where t.cod_contratto='EDP' and t.cod_voce_padre='02932' and t.cod_voce_speciale_padre='BASE'
     and t.cod_voce_figlio='10060' and t.cod_voce_speciale_figlio='BASE');

  INSERT INTO P201_ASSOGGETTAMENTI
  select 'EDP', '02932', 'BASE', '10065', 'BASE', to_date('01011900','ddmmyyyy'), 100, 0, to_date('31123999','ddmmyyyy') from DUAL
  where not exists
    (select 'x' FROM P201_ASSOGGETTAMENTI t where t.cod_contratto='EDP' and t.cod_voce_padre='02932' and t.cod_voce_speciale_padre='BASE'
     and t.cod_voce_figlio='10065' and t.cod_voce_speciale_figlio='BASE');

  INSERT INTO P201_ASSOGGETTAMENTI
  select 'EDP', '02932', 'BASE', '10110', 'BASE', to_date('01011900','ddmmyyyy'), 100, 0, to_date('31123999','ddmmyyyy') from DUAL
  where not exists
    (select 'x' FROM P201_ASSOGGETTAMENTI t where t.cod_contratto='EDP' and t.cod_voce_padre='02932' and t.cod_voce_speciale_padre='BASE'
     and t.cod_voce_figlio='10110' and t.cod_voce_speciale_figlio='BASE');

  INSERT INTO P201_ASSOGGETTAMENTI
  select 'EDP', '02932', 'BASE', '10120', 'BASE', to_date('01011900','ddmmyyyy'), 100, 0, to_date('31123999','ddmmyyyy') from DUAL
  where not exists
    (select 'x' FROM P201_ASSOGGETTAMENTI t where t.cod_contratto='EDP' and t.cod_voce_padre='02932' and t.cod_voce_speciale_padre='BASE'
     and t.cod_voce_figlio='10120' and t.cod_voce_speciale_figlio='BASE');

  INSERT INTO P201_ASSOGGETTAMENTI
  select 'EDP', '02932', 'BASE', '10130', 'BASE', to_date('01011900','ddmmyyyy'), 100, 0, to_date('31123999','ddmmyyyy') from DUAL
  where not exists
    (select 'x' FROM P201_ASSOGGETTAMENTI t where t.cod_contratto='EDP' and t.cod_voce_padre='02932' and t.cod_voce_speciale_padre='BASE'
     and t.cod_voce_figlio='10130' and t.cod_voce_speciale_figlio='BASE');

end if;

end;
/

---------------------------
-- Fine assoggettamento a gestione separata INPS e INAIL per voce 02932 Incentivi direttori
---------------------------

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
CodVoceCopia:='12468';
DesVoceCopia:='Fesica Confsal a importo fisso';
DesVoceCopiaSt:='Fesica Confsal a importo fisso';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Fesica Confsal a importo fisso
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

DesVoceCopia:='Fesica Confsal a importo fisso 13a';
DesVoceCopiaSt:='Fesica Confsal a importo fisso 13a';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

-----
-- Fine Fesica Confsal a importo fisso
-----

  end if;

-----
-- Inizio FIALS quota naz. a importo fisso
-----

CodVoceModello:='12038';
CodVoceCopia:='12048';
DesVoceCopia:='FIALS quota naz. a importo fisso';
DesVoceCopiaSt:='FIALS quota naz. a importo fisso';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

DesVoceCopia:='FIALS quota naz. a importo fisso 13a';
DesVoceCopiaSt:='FIALS quota naz. a importo fisso 13a';

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, '', importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';


-----
-- Fine FIALS quota naz. a importo fisso
-----
  end if;

end if;
end;
/

----------------------
-- Aggiunto TIPO_CONTAB alla gestione della contabilità
----------------------
CREATE TABLE AGG_925_P590 AS SELECT * FROM P590_CONTABREGOLE;

DROP TABLE P590_CONTABREGOLE;

create table P590_CONTABREGOLE
( tipo_contab             VARCHAR2(10) default 'GENERALE' not null, 
  conto                   VARCHAR2(60) not null,
  decorrenza              DATE not null,
  decorrenza_fine         DATE,
  descrizione             VARCHAR2(200),
  dare_avere              VARCHAR2(1) not null,
  cod_arrotondamento      VARCHAR2(5),
  codici_accorpamentovoci VARCHAR2(500) not null,
  cambio_segno            VARCHAR2(1) default 'N' not null,
  filtro_dipendenti       VARCHAR2(500) not null,
  filtro_data_competenza  VARCHAR2(2) default 'TT' not null,
  id_conto                VARCHAR2(60) not null,
  dettaglio_voci          VARCHAR2(1) default 'N' not null
)
tablespace LAVORO
  storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P590_CONTABREGOLE.dare_avere
  is 'Dare o Avere (D/A)';
comment on column P590_CONTABREGOLE.cod_arrotondamento
  is 'Codice arrotondamento';
comment on column P590_CONTABREGOLE.codici_accorpamentovoci
  is 'Accorpamento voci da inserire nel conto';
comment on column P590_CONTABREGOLE.cambio_segno
  is 'Cambio del segno dell''importo (S/N)';
comment on column P590_CONTABREGOLE.filtro_dipendenti
  is 'Filtro dipendenti da inserire nel conto';
comment on column P590_CONTABREGOLE.filtro_data_competenza
  is 'Data competenza delle voci da inserire nel conto: TT=Qualsiasi, AC=Anno corrente, AP=Anni precedenti';
comment on column P590_CONTABREGOLE.id_conto
  is 'Identificativo del conto sulla procedura di contabilita''';
comment on column P590_CONTABREGOLE.dettaglio_voci
  is 'Dettaglio voci individuale con competenza (S/N)';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P590_CONTABREGOLE
  add constraint P590_PK primary key (TIPO_CONTAB, CONTO, DECORRENZA, DARE_AVERE, CODICI_ACCORPAMENTOVOCI, CAMBIO_SEGNO, FILTRO_DIPENDENTI, FILTRO_DATA_COMPETENZA)
  using index 
  tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

INSERT INTO P590_CONTABREGOLE
SELECT 'GENERALE', T.* FROM AGG_925_P590 T;

CREATE TABLE AGG_925_P592 AS SELECT * FROM P592_CONTABTESTATE;

ALTER TABLE P593_CONTABDATIINDIVIDUALI DROP CONSTRAINT P593_FK_P592;

DROP TABLE P592_CONTABTESTATE;

-- Create table
create table P592_CONTABTESTATE
( tipo_contab             VARCHAR2(10) default 'GENERALE' not null, 
  data_fine_mese DATE not null,
  id_contab      NUMBER not null,
  chiuso         VARCHAR2(1) default 'N',
  data_chiusura  DATE
)
tablespace LAVORO
  storage (initial 256K next 256K pctincrease 0);
-- Add comments to the columns 
comment on column P592_CONTABTESTATE.data_fine_mese
  is 'Data di fine mese elaborato';
comment on column P592_CONTABTESTATE.chiuso
  is 'Chiuso (S/N)';
comment on column P592_CONTABTESTATE.data_chiusura
  is 'Data chiusura del flusso';
-- Create/Recreate primary, unique and foreign key constraints 
alter table P592_CONTABTESTATE
  add constraint P592_PK primary key (ID_CONTAB)
  using index 
  tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);

INSERT INTO P592_CONTABTESTATE
SELECT 'GENERALE', T.* FROM AGG_925_P592 T;

alter table P593_CONTABDATIINDIVIDUALI
  add constraint P593_FK_P592 foreign key (ID_CONTAB)
  references P592_CONTABTESTATE (ID_CONTAB) on delete cascade;
  
UPDATE P200_VOCI t SET T.ECCEZIONI_SENSIBILI='a'
where t.cod_contratto='EDP' and t.cod_voce in ('11017','11027') and t.cod_voce_speciale='CONG';

----------------------
-- Cancellazione nodi G022 UNIEMENS senza padre
----------------------
CREATE TABLE AGG_925_P673 AS SELECT * FROM P673_XMLDATIINDIVIDUALI;

DELETE from P673_XMLDATIINDIVIDUALI P673
where P673.Id_Flusso in (select P672.Id_Flusso from p672_xmltestate P672
                          where P672.Data_Fine_Periodo = to_date('31072014','ddmmyyyy')
                             or P672.Data_Fine_Periodo = to_date('31082014','ddmmyyyy'))
  AND P673.TIPO_RECORD = 'M' AND P673.NUMERO = 'G022'
  and P673.ID_FLUSSO || P673.PROGRESSIVO || P673.TIPO_RECORD || P673.numero_padre || P673.progressivo_numero_padre not in 
      (select A.ID_FLUSSO || A.PROGRESSIVO || A.TIPO_RECORD || A.numero || A.progressivo_numero
         from P673_XMLDATIINDIVIDUALI A
        where A.Id_Flusso = P673.Id_Flusso
          and A.Progressivo = P673.Progressivo
          and A.Tipo_Record = P673.Tipo_Record);

-- INIZIO CREAZIONE INCARICO MV035-006-2010

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'MV035-006-2010','Dirigente medico < 5 anni con struttura complessa area medicina (dec. 2010-2014)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='MV035-006-2010');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'MV035-006-2010', DECORRENZA, 'Dir. medico < 5 anni con S.C. chirurgica (dec. 2010-2014)', COD_VOCE, COD_VOCE_SPECIALE,
             1071.35 IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='MV035-011-2010' AND P252.COD_VOCE='00212' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='MV035-006-2010');

    end if;
  end if;
end/*--NOLOG--*/;
/
-- FINE CREAZIONE INCARICO MV035-006-2010

insert into t480_comuni
select '051040','CASTELFRANCO PIANDISCO''','52026','AR','M322' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M322');

insert into t480_comuni
select '013251','COLVERDE','22041','CO','M336' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M336');

insert into t480_comuni
select '097091','VERDERIO','23879','LC','M337' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M337');

insert into t480_comuni
select '046036','FABBRICHE DI VERGEMOLI','55021','LU','M319' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M319');

insert into t480_comuni
select '051041','PRATOVECCHIO STIA','52015','AR','M329' from dual
where not exists
(select * from T480_COMUNI t where t.codcatastale='M329');

update t480_comuni t set t.citta='BUJA' where t.codcatastale='B259';

------------------------------------------------------------------
-- Previsti campi per nuovo tracciato bonifici in formato SEPA
ALTER TABLE P500_CUDSETUP MODIFY COD_SIA VARCHAR2(8);
comment on column P500_CUDSETUP.COD_SIA
  is 'Codice SIA o CUC della banca ordinante le disposizioni di pagamento';

ALTER TABLE P500_CUDSETUP ADD COD_IBAN VARCHAR2(32);
comment on column P500_CUDSETUP.COD_IBAN
  is 'Codice IBAN della banca ordinante le disposizioni di pagamento';



