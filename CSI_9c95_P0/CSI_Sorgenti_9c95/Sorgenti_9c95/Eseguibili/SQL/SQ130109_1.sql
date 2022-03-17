declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_1P042.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_1P042.sql');
end/*--NOLOG--*/;
/

alter table T048_ATTESTATIINPS add civico_rep VARCHAR2(15);
comment on column T048_ATTESTATIINPS.civico_rep
  is 'Numero civico indirizzo di reperibilita’’ del lavoratore';
alter table T048_ATTESTATIINPS add civico_dom varchar2(15);
comment on column T048_ATTESTATIINPS.civico_dom
  is 'Numero civico indirizzo di residenza/domicilio del lavoratore';
alter table T048_ATTESTATIINPS add ruolomedico varchar2(1);
comment on column T048_ATTESTATIINPS.ruolomedico
  is 'Ruolo del medico: S = SSN, P = Professionista privato';
alter table T048_ATTESTATIINPS add codstruttura_med varchar2(9);
comment on column T048_ATTESTATIINPS.codstruttura_med
  is 'Struttura di appartenenza del medico';
alter table T048_ATTESTATIINPS add giornatalavorata varchar2(1);
comment on column T048_ATTESTATIINPS.giornatalavorata
  is 'Il lavoratore dichiara di avere/non avere lavorato la giornata del ricovero';
alter table T048_ATTESTATIINPS add trauma varchar2(1);
comment on column T048_ATTESTATIINPS.trauma
  is 'Il ricovero è/non è dovuto ad un trauma';
alter table T048_ATTESTATIINPS add agevolazioni VARCHAR2(1);
comment on column T048_ATTESTATIINPS.agevolazioni
  is 'Agevolazioni: T = Terapia salvavita, C = Causa di servizio, I = Invalidità riconosciuta.';
alter table T048_ATTESTATIINPS add data_finepostric date;
comment on column T048_ATTESTATIINPS.data_finepostric
  is 'Solo per le dimissioni, se diverso DATA_FINE_MAL gestisto il post ricovero';
alter table T048_ATTESTATIINPS add tipo_ricovero VARCHAR2(1);
comment on column T048_ATTESTATIINPS.tipo_ricovero
  is 'R = Ricovero, H = Day hospital';
alter table T048_ATTESTATIINPS add causale_postric VARCHAR2(5);
comment on column T048_ATTESTATIINPS.causale_postric
  is 'Causale Post Ricovero';

UPDATE P552_CONTOANNREGOLE t
SET T.VALORE_COSTANTE=REPLACE(T.VALORE_COSTANTE,'SESSO=''M''','SESSO=''F''')
WHERE T.ANNO=2012 AND T.COD_TABELLA='T05' AND T.RIGA=0 AND T.COLONNA=10;

alter table P590_CONTABREGOLE modify codici_accorpamentovoci VARCHAR2(500);

-- *****************************************************************************
-- AGGIORNAMENTO FASCE DI REDDIT0 2013 PER A.N.F.
-- *****************************************************************************

declare 
  AnnoNuovo integer;
  PercISTAT real;
  ID_P238 integer;
  
  CURSOR C1 IS  
  SELECT * FROM P236_TABELLEANF T WHERE T.DECORRENZA=TO_DATE('01072012','DDMMYYYY')
   AND NOT EXISTS (SELECT 'X' FROM P236_TABELLEANF V WHERE V.DECORRENZA=TO_DATE('01072013','DDMMYYYY'));
   
begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2013;
 
  -- IMPOSTARE QUI LA % ISTAT DI INCREMENTO DA APPLICARE PER IL NUOVO ANNO DA GESTIRE
  PercISTAT:=3;  

  FOR T1 IN C1 LOOP

   SELECT P238_ID_TABELLAANF.NEXTVAL INTO ID_P238 FROM DUAL;
   
   INSERT INTO P236_TABELLEANF
     (COD_TABELLAANF, DECORRENZA, ID_TABELLAANF, DESCRIZIONE, DECORRENZA_FINE)
   VALUES
     (T1.COD_TABELLAANF, TO_DATE('0107'||TO_CHAR(AnnoNuovo),'DDMMYYYY'), ID_P238, T1.DESCRIZIONE, TO_DATE(31123999,'DDMMYYYY'));

   UPDATE P236_TABELLEANF SET DECORRENZA_FINE=TO_DATE('3006'||TO_CHAR(AnnoNuovo),'DDMMYYYY')
     WHERE ID_TABELLAANF=T1.ID_TABELLAANF;

   INSERT INTO P238_TABELLEANFSCAGLIONI
     SELECT ID_P238, IMPORTO_DA, ROUND(IMPORTO_A * (1 + PercISTAT / 100), 2),
     IMPORTO_COMPONENTI_1, IMPORTO_COMPONENTI_2, IMPORTO_COMPONENTI_3, IMPORTO_COMPONENTI_4, 
     IMPORTO_COMPONENTI_5, IMPORTO_COMPONENTI_6, IMPORTO_COMPONENTI_7, IMPORTO_COMPONENTI_8, IMPORTO_COMPONENTI_9 
     FROM P238_TABELLEANFSCAGLIONI WHERE ID_TABELLAANF=T1.ID_TABELLAANF;

   UPDATE P238_TABELLEANFSCAGLIONI P238
   SET P238.IMPORTO_DA=
     (SELECT MAX(P238A.IMPORTO_A)+0.01 FROM P238_TABELLEANFSCAGLIONI P238A WHERE
      P238.ID_TABELLAANF=P238A.ID_TABELLAANF AND P238A.IMPORTO_A<P238.IMPORTO_A)
   WHERE P238.ID_TABELLAANF=ID_P238 AND P238.IMPORTO_DA<>0;

  END LOOP;

end;

/

---------------------------
-- INIZIO INTEGRAZIONE REGOLE UNIEMENS per nodo AltraAmministrazione
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then
     DELETE P670_XMLREGOLE t WHERE t.NOME_FLUSSO='UNIEMENS' AND 
            ((numero BETWEEN 'F200' AND 'F245') OR (numero BETWEEN 'H200' AND 'H245'));

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F200', 'AltraAmministrazione', 'Personale in servizio presso altra amministrazione o di altra amministrazione', 'F015', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F205', 'ServizioPressoAltraAmministrazione', 'Personale in servizio presso altra amministrazione', 'F200', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F210', 'TipologiaServizio', 'Tipologia del servizio altra amministrazione', 'F205', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F215', 'Amministrazione', 'Informazioni sull''altra amministrazione', 'F205', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F220', 'CFAzienda', 'Codice fiscale sede di servizio altra amministrazione', 'F215', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F225', 'PRGAZIENDA', 'Progressivo azienda sede di servizio altra amministrazione', 'F215', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F230', 'DipendenteAltraAmministrazione', 'Personale di altra amministrazione', 'F200', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F235', 'TipologiaServizio', 'Tipologia del servizio di altra amministrazione', 'F230', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F240', 'CFAzienda', 'Codice fiscale di altra amministrazione', 'F230', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'F245', 'PRGAZIENDA', 'Progressivo azienda di altra amministrazione', 'F230', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H200', 'AltraAmministrazione', 'Personale in servizio presso altra amministrazione o di altra amministrazione', 'H015', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H205', 'ServizioPressoAltraAmministrazione', 'Personale in servizio presso altra amministrazione', 'H200', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H210', 'TipologiaServizio', 'Tipologia del servizio altra amministrazione', 'H205', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H215', 'Amministrazione', 'Informazioni sull''altra amministrazione', 'H205', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H220', 'CFAzienda', 'Codice fiscale sede di servizio altra amministrazione', 'H215', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H225', 'PRGAZIENDA', 'Progressivo azienda sede di servizio altra amministrazione', 'H215', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H230', 'DipendenteAltraAmministrazione', 'Personale di altra amministrazione', 'H200', null, 'N', null, null, 'N', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H235', 'TipologiaServizio', 'Tipologia del servizio di altra amministrazione', 'H230', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H240', 'CFAzienda', 'Codice fiscale di altra amministrazione', 'H230', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));
insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'H245', 'PRGAZIENDA', 'Progressivo azienda di altra amministrazione', 'H230', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

  end if;
end;
/

---------------------------
-- FINE INTEGRAZIONE REGOLE UNIEMENS per nodo AltraAmministrazione
---------------------------

-- Creazione interrogazione di servizio PA_DMA_2_Quadri_V1_7
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    DELETE from t002_querypersonalizzate t where t.nome = 'PA_DMA_2_Quadri_V1_7';

    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', -4, 'CHKINTESTAZIONE(N)CHKNORITORNOACAPO(N)', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', -2, 'Data', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', -1, '"31/01/2013"', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', 0, 'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, P673.ATTRIBUTO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', 1, 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, T030_ANAGRAFICO T030', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', 2, 'WHERE P672.ID_FLUSSO=P673.ID_FLUSSO AND P673.PROGRESSIVO=T030.PROGRESSIVO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', 3, 'AND P672.DATA_FINE_PERIODO=:MeseCedolino AND P673.TIPO_RECORD=''M''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', 4, 'AND P673.NUMERO=''E600'' AND P673.ATTRIBUTO LIKE ''CausaleVariazione=7%''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_V1_7', 5, 'ORDER BY T030.COGNOME, T030.NOME', 'PAGHE');

  end if;
end;
/

---------------------------
-- INIZIO Riduzione per assenza 15115 per voci 00208, 00217
---------------------------

declare 
  ID_P200 integer;

  CURSOR C1 IS
  select * from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE IN ('00208','00217')
AND T.COD_VOCE_SPECIALE='15030'
AND NOT EXISTS
(SELECT 'X' FROM P200_VOCI V WHERE V.COD_CONTRATTO=T.COD_CONTRATTO AND V.COD_VOCE=T.COD_VOCE AND V.COD_VOCE_SPECIALE='15115');

begin

FOR T1 IN C1 LOOP

    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
   
    INSERT INTO P200_VOCI
    select cod_contratto, cod_voce, '15115', decorrenza, ID_P200, 'Riduzione asp.non retr. mandato politico', cod_voce_stampa, 'Riduzione asp.non retr. mandato politico', protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo
    from p200_voci P200 WHERE p200.id_voce=t1.id_voce;

    INSERT INTO P201_ASSOGGETTAMENTI
    select cod_contratto, cod_voce_padre, '15115', cod_voce_figlio,
    cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
    FROM P201_ASSOGGETTAMENTI P201 WHERE p201.COD_CONTRATTO=t1.COD_CONTRATTO
         AND p201.cod_voce_padre=t1.cod_voce AND p201.cod_voce_speciale_padre='15030';

    INSERT INTO P216_ACCORPAMENTOVOCI
    select cod_contratto, cod_voce, '15115', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine
    from p216_accorpamentovoci T
    WHERE T.COD_CONTRATTO=t1.COD_CONTRATTO AND T.COD_VOCE=t1.cod_voce AND T.COD_VOCE_SPECIALE='15030';

    INSERT INTO P205_QUOTE
    select cod_contratto, cod_voce_da_quotare, cod_voce_speciale_da_quotare, t1.cod_voce, cod_voce_speciale_in_quota, decorrenza, accumulo, accumulo_rateo, cod_voce_speciale_dettaglio
    from p205_quote T
    WHERE T.COD_CONTRATTO=t1.COD_CONTRATTO AND T.COD_VOCE_DA_QUOTARE='15115' AND T.COD_VOCE_SPECIALE_DA_QUOTARE='BASE'
      AND T.COD_VOCE_IN_QUOTA='00010' AND T.COD_VOCE_SPECIALE_IN_QUOTA='BASE';

END LOOP;

end;

---------------------------
-- FINE Riduzione per assenza 15115 per voci 00208, 00217
---------------------------
/
