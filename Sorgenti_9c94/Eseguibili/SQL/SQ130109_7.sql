ALTER TABLE SG302_INCAZIENDALI ADD VALORE_ECON NUMBER;
Comment on column SG302_INCAZIENDALI.VALORE_ECON is 'Valore economico di posizione mensile';

declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_7AddIRPEF.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_7AddIRPEF.sql');
end/*--NOLOG--*/;
/

-----
-- Inizio creazione nuovo dato annuale IPTIPOLSER
-----

declare 
  i integer;
  annociclo integer;

begin

select COUNT(*) into i from P002_TABANNUALI t where t.cod_tabannuale='IPCAUSCESS'
 and not exists (select 'x' from P002_TABANNUALI v where v.cod_tabannuale='IPTIPOLSER');
if i = 1 then

insert into p002_tabannuali
  (cod_tabannuale, descrizione, modificabile)
values
  ('IPTIPOLSER', 'Tipologie servizio INPDAP D.M.A.', 'N');


insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('IPTIPOLSER', '1', 1900, 'Comando o Distacco');
insert into p004_codicitabannuali
  (cod_tabannuale, cod_codicitabannuali, anno, descrizione)
values
  ('IPTIPOLSER', '2', 1900, 'Altro');

for annociclo in 2001..2013
loop
  insert into p004_codicitabannuali
  select cod_tabannuale, cod_codicitabannuali, annociclo, descrizione from p004_codicitabannuali t
    where t.cod_tabannuale='IPTIPOLSER' and t.anno=1900;
end loop;
  
end if;
end;
/

-----
-- Fine creazione nuovo dato annuale IPTIPOLSER
-----


-----
-- Inizio creazione nuovi dati per altra amministrazione su angrafica stipendiale 
-----

alter table P430_ANAGRAFICO add altra_amm VARCHAR2(1) default 'N';
alter table P430_ANAGRAFICO add cod_inpdaptipols_altra_amm VARCHAR2(5);
alter table P430_ANAGRAFICO add cod_fiscale_altra_amm VARCHAR2(20);
alter table P430_ANAGRAFICO add codice_inpdap_altra_amm VARCHAR2(5);

comment on column P430_ANAGRAFICO.altra_amm
  is 'Altra amministrazione: N=Nessuna, O=Servizio presso altra amministrazione, I=Personale di altra amministrazione';
comment on column P430_ANAGRAFICO.cod_inpdaptipols_altra_amm
  is 'Codice tipologia servizio altra amministrazione';
comment on column P430_ANAGRAFICO.cod_fiscale_altra_amm
  is 'Codice fiscale altra amministrazione';
comment on column P430_ANAGRAFICO.codice_inpdap_altra_amm
  is 'Codice indentificativo assegnato all''altra amministrazione dall''INPDAP';

--eliminazione V430 per forzare riaggiornamento da applicativo
declare
  c integer;
begin
  SELECT COUNT(*) into C FROM P001_TABP430 WHERE TABELLA = 'T030_ANAGRAFICO';
  if C > 0 then
    execute immediate 'drop view V430_STORICO';
  end if;  
end;
/
  
-----
-- Fine creazione nuovi dati per altra amministrazione su angrafica stipendiale 
-----

UPDATE P200_VOCI T SET T.DESCRIZIONE_STAMPA='Imponibile CPDEL dipendente-ente'
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='10010' AND T.COD_VOCE_SPECIALE='ENTE'
AND T.DESCRIZIONE_STAMPA='Imponibile CDELP dipendente-ente';

UPDATE P200_VOCI T SET T.DESCRIZIONE_STAMPA='Imponibile CPS dipendente-ente'
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='10020' AND T.COD_VOCE_SPECIALE='ENTE'
AND T.DESCRIZIONE_STAMPA='Imponibile CDS dipendente-ente';

UPDATE P200_VOCI T SET T.DESCRIZIONE_STAMPA='Ritenuta CPDEL dipendente-ente'
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='11010' AND T.COD_VOCE_SPECIALE='ENTE'
AND T.DESCRIZIONE_STAMPA='Ritenuta CDELP dipendente-ente';

-- CREAZIONE SINDACATI VARI
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12441';
CodVoceCopia:='12491';
DesVoceCopia:='ANIPA Associazione Naz. Informatici P.A.';
DesVoceCopiaSt:='ANIPA Associazione Naz. Informatici P.A.';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio ANIPA Associazione Naz. Informatici P.A.
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine ANIPA Associazione Naz. Informatici P.A.
-----

  end if;

-----
-- Inizio F.I.Te.La.B. Fed.It.Tecnici Lab. Biomed.
-----
  
CodVoceModello:='12441';
CodVoceCopia:='12496';
DesVoceCopia:='F.I.Te.La.B. Fed.It.Tecnici Lab. Biomed.';
DesVoceCopiaSt:='F.I.Te.La.B. Fed.It.Tecnici Lab. Biomed.';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine F.I.Te.La.B. Fed.It.Tecnici Lab. Biomed.
-----

  end if;

-----
-- Inizio S.V.I. Sindacato Veterinari Italiani
-----
  
CodVoceModello:='12771';
CodVoceCopia:='12751';
DesVoceCopia:='S.V.I. Sindacato Veterinari Italiani';
DesVoceCopiaSt:='S.V.I. Sindacato Veterinari Italiani';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDPSC' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDPSC' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine S.V.I. Sindacato Veterinari Italiani
-----

  end if;
end if;
end;
/

UPDATE t480_comuni t SET T.CITTA='MANIACE' WHERE T.CODCATASTALE='M283';

UPDATE t480_comuni t SET T.CITTA='CASTELLAVAZZO' WHERE T.CODCATASTALE='C146';

UPDATE t480_comuni t SET T.CITTA='SAN STINO DI LIVENZA' WHERE T.CODCATASTALE='I373';

