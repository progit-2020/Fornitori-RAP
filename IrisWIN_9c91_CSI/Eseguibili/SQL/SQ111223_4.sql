delete from MONDOEDP.I091_DATIENTE 
where TIPO in (
'C90_EMAIL_W010DIP','C90_EMAIL_W010RESP','C90_EMAIL_W018DIP','C90_EMAIL_W018RESP',
'C90_RICH_GIUST_PREV','C90_WEBVALIDAZSTRAORD','C90_W018AUTORIZZAUTO_VERSO','C90_T050REVOCHE',
'C2_CONTRATTO');

-- *****************************************************************************
-- CREAZIONE VOCE EDPSC-10230 Imponibile IRPEF per TFR
-- CREAZIONE VOCE EDPSC-11230 Ritenuta IRPEF per TFR
-- VARIAZIONE ASSOGGGETTAMENTO IRPEF VOCE EDPSC-01200 Premio di operosità (IRPEF TFR)
-- *****************************************************************************

declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);

begin
  CodVoceModello:='11230';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto='EDPSC' and v.cod_voce=t.cod_voce
       and v.cod_voce_speciale=t.cod_voce_speciale) and exists
    (select 'X' from P200_VOCI v where v.cod_contratto='EDPSC' and v.cod_voce='11220'
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 11230
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select 'EDPSC', CodVoceModello, cod_voce_speciale, decorrenza, ID_P200, Descrizione, Cod_Voce_Stampa, Descrizione_Stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Assoggettamenti
INSERT INTO P201_ASSOGGETTAMENTI
select 'EDPSC', CodVoceModello, COD_VOCE_SPECIALE_PADRE, COD_VOCE_FIGLIO, COD_VOCE_SPECIALE_FIGLIO, DECORRENZA, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE FROM P201_ASSOGGETTAMENTI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceModello AND T.COD_VOCE_SPECIALE_PADRE='BASE';

  end if;

  CodVoceModello:='10230';

  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto='EDPSC' and v.cod_voce=t.cod_voce
       and v.cod_voce_speciale=t.cod_voce_speciale) and exists
    (select 'X' from P200_VOCI v where v.cod_contratto='EDPSC' and v.cod_voce='10220'
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then
  
-----
-- Creazione voce copiandola da 10230
-----

SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select 'EDPSC', CodVoceModello, cod_voce_speciale, decorrenza, ID_P200, Descrizione, Cod_Voce_Stampa, Descrizione_Stampa, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-- Assoggettamenti
INSERT INTO P201_ASSOGGETTAMENTI
select 'EDPSC', CodVoceModello, COD_VOCE_SPECIALE_PADRE, COD_VOCE_FIGLIO, COD_VOCE_SPECIALE_FIGLIO, DECORRENZA, ASSOGGETTAMENTO, ASSOGGETTAMENTO13A, DECORRENZA_FINE FROM P201_ASSOGGETTAMENTI T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE_PADRE=CodVoceModello AND T.COD_VOCE_SPECIALE_PADRE='BASE';

  end if;

update p200_voci t
set t.descrizione='Premio di operosità (IRPEF TFR)', t.descrizione_stampa='Premio di operosita'' (IRPEF TFR)'
where t.cod_contratto='EDPSC' and t.cod_voce='01200' and t.cod_voce_speciale='BASE'
and t.descrizione like '%a tassazione sep.%';

update p201_assoggettamenti t set t.cod_voce_figlio='10230'
where t.cod_contratto='EDPSC' and t.cod_voce_padre='01200' and t.cod_voce_speciale_padre='BASE'
and t.cod_voce_figlio='10220' and exists
(select 'x' from p200_voci v where v.cod_contratto='EDPSC' and v.cod_voce='01200' and v.cod_voce_speciale='BASE'
and v.descrizione like '%(IRPEF TFR)%');

end if;
end;

/

-- Rimozione assoggettamenti ritenute voce 00165
declare 
  i integer;

begin

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDPSC' and T.COD_VOCE='00165' and T.COD_VOCE_SPECIALE='BASE'
    and upper(t.descrizione) like '%SOSTITUZIONE INCARICO SINDACALE PEDIATRI%';
  if i > 0 then
  
-- Assoggettamenti
DELETE P201_ASSOGGETTAMENTI T
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE_PADRE='00165' AND T.COD_VOCE_SPECIALE_PADRE='BASE'
AND T.COD_VOCE_FIGLIO IN ('10420','10500','12810') AND T.COD_VOCE_SPECIALE_FIGLIO='BASE';

  end if;

end if;
end;

/

alter table P500_CUDSETUP add PIVA_CED VARCHAR2(50);
comment on column P500_CUDSETUP.PIVA_CED
  is 'Campo contenente l''eventuale partita IVA del dipendente per il cedolino';

UPDATE T001_PARAMETRIFUNZIONI SET VALORE = '34' WHERE PROG = 'P500' AND NOME = 'DistanzaIndirizzo' AND lpad(VALORE,5,'0') <= lpad((34 + 15),5,'0')/*--NOLOG--*/;
UPDATE T001_PARAMETRIFUNZIONI SET VALORE = to_char(to_number(VALORE) - 15) WHERE PROG = 'P500' AND NOME = 'DistanzaIndirizzo' AND lpad(VALORE,5,'0') > lpad((34 + 15),5,'0')/*--NOLOG--*/;


---------
-- Creazione tabella Premio di Operosità
---------
create table P464_PREMIOOPEROSITA
( PROGRESSIVO           NUMBER not null,
  DECORRENZA_INIZIO     DATE not null,
  DECORRENZA_FINE       DATE not null,
  TIPO_RECORD           VARCHAR2(1) not null,
  ORE_SETTIMANALI       NUMBER not null,
  NUMERO_MESI           NUMBER not null,
  QUOTA_PREMIO_ORA_CORR NUMBER,
  PREMIO_OPEROSITA_CORR NUMBER,
  QUOTA_ESENTE          NUMBER,
  QUOTA_PREMIO_ORA_ARR  NUMBER,
  PREMIO_OPEROSITA_ARR  NUMBER)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column P464_PREMIOOPEROSITA.DECORRENZA_INIZIO
  is 'Inizio periodo di incarico valutabile per premio di operosita''';
comment on column P464_PREMIOOPEROSITA.DECORRENZA_FINE
  is 'Fine periodo di incarico valutabile per premio di operosita''';
comment on column P464_PREMIOOPEROSITA.TIPO_RECORD
  is 'Tipo record: A=Automatico, M=Manuale';
comment on column P464_PREMIOOPEROSITA.ORE_SETTIMANALI
  is 'Ore settimanali lavorate nel periodo';
comment on column P464_PREMIOOPEROSITA.NUMERO_MESI
  is 'Numero di mesi del periodo';
comment on column P464_PREMIOOPEROSITA.QUOTA_PREMIO_ORA_CORR
  is 'Quota premio ora/anno del periodo';
comment on column P464_PREMIOOPEROSITA.PREMIO_OPEROSITA_CORR
  is 'Premio di operosita'' maturato nel periodo';
comment on column P464_PREMIOOPEROSITA.QUOTA_ESENTE
  is 'Quota esente ai fini fiscali del periodo';
comment on column P464_PREMIOOPEROSITA.QUOTA_PREMIO_ORA_ARR
  is 'Quota premio ora/anno relativa agli arretrati contrattuali del periodo';
comment on column P464_PREMIOOPEROSITA.PREMIO_OPEROSITA_ARR
  is 'Premio di operosita'' relativo agli arretrati contrattuali maturato nel periodo';

alter table P464_PREMIOOPEROSITA
  add constraint P464_PK primary key (PROGRESSIVO, DECORRENZA_INIZIO, TIPO_RECORD)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);
alter table P464_PREMIOOPEROSITA
  add constraint P464_FK_T030 foreign key (PROGRESSIVO)
  references T030_ANAGRAFICO (PROGRESSIVO);

-- *****************************************************************************
-- AGGIORNAMENTO FASCE DI REDDIT0 2012 PER A.N.F.
-- *****************************************************************************

declare 
  AnnoNuovo integer;
  PercISTAT real;
  ID_P238 integer;
  
  CURSOR C1 IS  
  SELECT * FROM P236_TABELLEANF T WHERE T.DECORRENZA=TO_DATE('01072011','DDMMYYYY')
   AND NOT EXISTS (SELECT 'X' FROM P236_TABELLEANF V WHERE V.DECORRENZA=TO_DATE('01072012','DDMMYYYY'));
   
begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2012;
 
  -- IMPOSTARE QUI LA % ISTAT DI INCREMENTO DA APPLICARE PER IL NUOVO ANNO DA GESTIRE
  PercISTAT:=2.7;  

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

-- Variazione numero D048 UNIEMENS in D049
-- Inserimento nuovo elemento D048 - PercPartTimeMese
declare 
  i integer;

begin

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P670_XMLREGOLE t 
    where T.NOME_FLUSSO LIKE '%MENS' and T.NUMERO='D049';
  if i = 0 then
  
UPDATE P670_XMLREGOLE T SET T.NUMERO='D049'
    where T.NOME_FLUSSO LIKE '%MENS' and T.NUMERO='D048';

UPDATE P673_XMLDATIINDIVIDUALI T SET T.NUMERO='D049'
    where T.NUMERO='D048'
    and exists (SELECT 'x' FROM P672_XMLTESTATE V WHERE V.ID_FLUSSO=T.ID_FLUSSO
                AND V.NOME_FLUSSO LIKE '%MENS');

insert into P670_XMLREGOLE
select nome_flusso, decorrenza, 'D048', 'PercPartTimeMese', 'Percentuale di part-time lavorata nel mese', numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine
from p670_xmlregole T where T.NOME_FLUSSO LIKE '%MENS' and T.NUMERO='D047';

  end if;

end if;
end;

/