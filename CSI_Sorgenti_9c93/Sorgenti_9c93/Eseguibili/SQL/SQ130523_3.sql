alter table T020_ORARI add CAUSALE_DISABIL_BLOCCANTE varchar2(1) default 'N';
comment on column T020_ORARI.CAUSALE_DISABIL_BLOCCANTE is 'S=la causale disabilitata in anagrafico genera anomalia bloccante';

alter table T850_ITER_RICHIESTE add RICHIEDENTE varchar2(30);
comment on column T850_ITER_RICHIESTE.RICHIEDENTE is 'utente che ha generato la richiesta';

-- Sistemazione commenti su SG101_FAMILIARI

comment on column SG101_FAMILIARI.gradopar
  is 'Grado parentela: NS=Nessuno/Sè stesso, CG=Coniuge, FG=Figlio/Figlia, GT=Genitore, FR=Fratello/Sorella, NP=Nipote, NF=Nipote equiparato Figlio, AL=Altro, AF=Affidato';
comment on column SG101_FAMILIARI.TIPO_DETRAZIONE
  is 'Tipo detrazione: ND=Nessuna, DC=Coniuge, DF=Figlio, DA=Altri';
comment on column SG101_FAMILIARI.comune
  is 'Comune di residenza del familiare (legge 104/1992)';
comment on column SG101_FAMILIARI.nome_pa
  is 'Denominazione pubblica amministrazione per cui lavora il familiare (legge 104/1992)';
comment on column SG101_FAMILIARI.durata_pa
  is 'Durata contratto pubblica amministrazione per cui lavora il familiare (legge 104/1992): 1=Tempo indeterminato, 2=Tempo determinato';
comment on column SG101_FAMILIARI.anno_avv
  is 'Anno avvicinamento alla sede lavoro più vicina al proprio domicilio (legge 104/1992)';
comment on column SG101_FAMILIARI.anno_avv_fam
  is 'Anno avvicinamento alla sede lavoro più vicina al domicilio del familiare (legge 104/1992)';
comment on column SG101_FAMILIARI.tipo_disabilita
  is 'Tipo disabilità (legge 104/1992): 1=Rivedibile, 2=Non rivedibile, 3=Provvisorio';
comment on column SG101_FAMILIARI.anno_revisione
  is 'Anno revisione disabilità (legge 104/1992)';
comment on column SG101_FAMILIARI.motivo_grado_3
  is 'Motivo parentela di terzo grado (legge 104/1992)';
comment on column SG101_FAMILIARI.alternativa
  is 'Alternativa (legge 104/1992): 1=Genitore, 2=Coniuge, 3=Figlio, 4=Parente o affine fino al II grado, 5=Parente o affine fino al III grado, 6=Nessuno, 7=Affidatario';
comment on column SG101_FAMILIARI.nome_pa_alt
  is 'Denominazione pubblica amministrazione per cui lavora l''alternativa (legge 104/1992)';
comment on column SG101_FAMILIARI.motivo_grado_3_alt
  is 'Motivo parentela di terzo grado dell''alternativa (legge 104/1992)';

-- Creazione interrogazione di servizio PA_Tredicesima_Dicembre
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    DELETE from t002_querypersonalizzate t where t.nome = 'PA_Tredicesima_Dicembre';

		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', -4, 'CHKINTESTAZIONE(S)CHKNORITORNOACAPO(S)', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', -2, 'Stringa', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', -1, '"2013"', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 0, 'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, P040.PERCENTUALE PT_PERC,', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 1, '       P442.COD_VOCE || '' '' || P442.COD_VOCE_SPECIALE VOCE,', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 2, '       TO_NUMBER(P442.QUANTITA,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') RATEI_TRED,', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 3, '  (SELECT SUM(P450.VALORE) FROM P450_DATIMENSILI P450 WHERE P450.PROGRESSIVO=P441.PROGRESSIVO', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 4, '   AND P450.COD_CAMPO=''GG13A'' AND TO_CHAR(P450.DATA_RETRIBUZIONE,''YYYY'')=:Anno', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 5, '   AND P450.TIPO_RECORD=''M'') GIORNI_TRED,', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 6, '   TO_NUMBER(P442.DATOBASE,''9G999G999G999D99999'',''nls_numeric_characters='''',.'''''') IMPORTO_INTERO,', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 7, '   P442.IMPORTO IMPORTO_TRED, ', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 8, '  (SELECT SUM(P442A.IMPORTO) FROM P442_CEDOLINOVOCI P442A WHERE P442A.ID_CEDOLINO=P442.ID_CEDOLINO', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 9, '   AND P442A.COD_CONTRATTO=P442.COD_CONTRATTO AND P442A.COD_VOCE=P442.COD_VOCE', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 10, '   AND P442A.COD_VOCE_SPECIALE<>P442.COD_VOCE_SPECIALE AND P442A.ORIGINE=''T''', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 11, '   AND P442A.TIPO_RECORD=P442.TIPO_RECORD) IMPORTO_RIDUZ   ', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 12, 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, T030_ANAGRAFICO T030, P430_ANAGRAFICO P430, P040_PARTTIME P040', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 13, 'WHERE T030.PROGRESSIVO=P441.PROGRESSIVO AND P430.PROGRESSIVO=P441.PROGRESSIVO', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 14, 'AND P442.DATA_COMPETENZA_A BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 15, 'AND P040.COD_PARTTIME(+)=P430.COD_PARTTIME AND P441.ID_CEDOLINO=P442.ID_CEDOLINO', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 16, 'AND TO_CHAR(P441.DATA_CEDOLINO,''YYYYMM'')=:Anno||''12''', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 17, 'AND P442.COD_CONTRATTO=''EDP'' AND P442.COD_VOCE IN(''00010'',''00025'') AND P442.COD_VOCE_SPECIALE=''TRED''', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 18, 'AND P442.TIPO_RECORD=''M''', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_Tredicesima_Dicembre', 19, 'ORDER BY T030.COGNOME, T030.NOME, T030.MATRICOLA', 'PAGHE');

  end if;
end;
/
  
-- Creazione interrogazione di servizio _VERIFICA_L104
declare
begin
  DELETE from t002_querypersonalizzate t where t.nome = '_VERIFICA_L104';

  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','-4','CHKINTESTAZIONE(S)CHKNORITORNOACAPO(S)','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','0','-- Elenco dipendenti con più di un familiare per il quale usufruiscono della legge 104','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','1','select t030.matricola, t030.cognome, t030.nome, sg101.numord, sg101.cognome cognome_fam, sg101.nome nome_fam, sg101.datanas','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','2','  from sg101_familiari sg101, t030_anagrafico t030','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','3',' where sg101.progressivo = t030.progressivo','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','4','   and sysdate between sg101.decorrenza and sg101.decorrenza_fine','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','5','   and sg101.progressivo in ','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','6','      (select t.progressivo from sg101_familiari t, t030_anagrafico a ','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','7','        where t.progressivo = a.progressivo','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','8','          and sysdate between t.decorrenza and t.decorrenza_fine','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','9','          and t.causali_abilitate like ''%104%''','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','10','        group by t.progressivo','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','11','        having count(*) > 1)','RILPRE');
  insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione) 
  values ('_VERIFICA_L104','12','order by t030.cognome, t030.nome, sg101.numord','RILPRE');

end;
/

-- Creazione sindacato EDP 12466 TRED

declare
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);
  CodVoceFiglio varchar2(5);
begin
  select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12466' AND T.COD_VOCE_SPECIALE='BASE'
     and exists (select 'x' from P200_VOCI t1 WHERE T1.COD_CONTRATTO=T.COD_CONTRATTO AND T1.COD_VOCE='12008' AND T1.COD_VOCE_SPECIALE='TRED');
  if i > 0 then
    select COUNT(*) into i from P200_VOCI t WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE='12466' AND T.COD_VOCE_SPECIALE='TRED';
    if i = 0 then
  
      CodVoceModello:='12008';
      CodVoceCopia:='12466';
      DesVoceCopia:='Fassid - SICUS 13a';
      DesVoceCopiaSt:='Fassid - SICUS 13a';

      SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
      insert into p200_voci
      select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' T', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='TRED';

      INSERT INTO P201_ASSOGGETTAMENTI
      select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
      where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='TRED';

      INSERT INTO P216_ACCORPAMENTOVOCI
      select cod_contratto, cod_voce, 'TRED', cod_tipoaccorpamentovoci, cod_codiciaccorpamentovoci, decorrenza, percentuale, importo_colonna, decorrenza_fine from p216_accorpamentovoci T
      WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceCopia AND T.COD_VOCE_SPECIALE='BASE';

    end if;
  end if;
end;
/

