alter table M010_PARAMETRICONTEGGIO add RIMB_KM_AUTO varchar2(1) default 'N';
comment on column M010_PARAMETRICONTEGGIO.RIMB_KM_AUTO is 'S=generazione automatica rimborso km per il percorso specificato';

alter table M010_PARAMETRICONTEGGIO add IND_KM_AUTO varchar2(5);
comment on column M010_PARAMETRICONTEGGIO.IND_KM_AUTO  is 'Voce di indennita km per il rimborso automatico. Valido se RIMB_KM_AUTO = S';

alter table M010_PARAMETRICONTEGGIO add RIMB_KM_AUTO_MINIMO number(4);
comment on column M010_PARAMETRICONTEGGIO.RIMB_KM_AUTO_MINIMO is 'Soglia di km per avere diritto al rimborso chilometrico automatico. Valido se RIMB_KM_AUTO = S';

alter table M140_RICHIESTE_MISSIONI add PARTENZA varchar2(200);
comment on column M140_RICHIESTE_MISSIONI.PARTENZA is 'Luogo di partenza per la trasferta';

alter table M140_RICHIESTE_MISSIONI add DESTINAZIONE varchar2(200);
comment on column M140_RICHIESTE_MISSIONI.DESTINAZIONE is 'Luogo di destinazione della trasferta';

alter table M140_RICHIESTE_MISSIONI add RIENTRO varchar2(200);
comment on column M140_RICHIESTE_MISSIONI.RIENTRO is 'Luogo di rientro dalla trasferta';

update M140_RICHIESTE_MISSIONI set DESTINAZIONE = LOCALITA;

comment on column M140_RICHIESTE_MISSIONI.LOCALITA is 'Obsoleto'/*--NOLOG--*/;
alter table M140_RICHIESTE_MISSIONI drop column LOCALITA/*--NOLOG--*/;

alter table M150_RICHIESTE_RIMBORSI add AUTOMATICO varchar2(1) default 'N';
comment on column M150_RICHIESTE_RIMBORSI.AUTOMATICO is 'S=voce di rimborso richiesta automaticamente per indennità km,N=voce di rimborso richiesta manualmente';

-- Creazione interrogazione di servizio PA_DMA_2_Quadri_F1
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    DELETE from t002_querypersonalizzate t where t.nome = 'PA_DMA_2_Quadri_F1';

		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', -4, 'CHKINTESTAZIONE(S)CHKNORITORNOACAPO(S)', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', -2, 'Sostituzione,Data,Data', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', -1, '*,"31/01/2013","31/03/2013"', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', 0, 'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, P672.DATA_FINE_PERIODO DATA_CEDOLINO,P673.VALORE CASSA,', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', 1, '  (SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', 2, '   AND P673A.PROGRESSIVO=P673.PROGRESSIVO AND P673A.NUMERO=''G515''', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', 3, '   AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD) TIPO_PIANO,', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', 4, '  (SELECT P673A.VALORE FROM P673_XMLDATIINDIVIDUALI P673A WHERE P673A.ID_FLUSSO=P673.ID_FLUSSO', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 5, '   AND P673A.PROGRESSIVO=P673.PROGRESSIVO AND P673A.NUMERO=''G550''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 6, '   AND P673A.PROGRESSIVO_NUMERO=P673.PROGRESSIVO_NUMERO AND P673A.TIPO_RECORD=P673.TIPO_RECORD) IMPORTO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 7, 'FROM P672_XMLTESTATE P672, P673_XMLDATIINDIVIDUALI P673, T030_ANAGRAFICO T030', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 8, 'WHERE P672.NOME_FLUSSO=''UNIEMENS'' AND P672.DATA_FINE_PERIODO BETWEEN :MeseCedolino__Da AND :MeseCedolino_A', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 9, 'AND P673.ID_FLUSSO=P672.ID_FLUSSO AND P673.NUMERO=''G510'' AND P673.TIPO_RECORD=''M''', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 10, 'AND T030.PROGRESSIVO=P673.PROGRESSIVO', 'PAGHE');
    insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
    values ('PA_DMA_2_Quadri_F1', 11, 'AND P673.PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)', 'PAGHE');
		insert into T002_QUERYPERSONALIZZATE (nome, posiz, riga, applicazione)
		values ('PA_DMA_2_Quadri_F1', 12, 'ORDER BY T030.COGNOME, T030.NOME, P672.DATA_FINE_PERIODO, P673.PROGRESSIVO_NUMERO', 'PAGHE');

  end if;
end;
/

-- NUOVI DATI SUI FAMILIARI PER LA RILEVAZIONE LEGGE 104

ALTER TABLE SG101_FAMILIARI ADD DURATA_PA VARCHAR2(1);
comment on column SG101_FAMILIARI.DURATA_PA
  is 'Durata contratto pubblica amministrazione per cui lavora l''assistito: 1=Tempo indeterminato, 2=Tempo determinato';
comment on column SG101_FAMILIARI.NOME_PA
  is 'Denominazione pubblica amministrazione per cui lavora l''assistito';

ALTER TABLE SG101_FAMILIARI ADD ANNO_AVV NUMBER;
comment on column SG101_FAMILIARI.ANNO_AVV
  is 'Anno avvicinamento alla sede lavoro vicina al proprio domicilio';

ALTER TABLE SG101_FAMILIARI ADD ANNO_AVV_FAM NUMBER;
comment on column SG101_FAMILIARI.ANNO_AVV_FAM
  is 'Anno avvicinamento alla sede lavoro vicina al domicilio dell''assistito';

ALTER TABLE SG101_FAMILIARI ADD TIPO_DISABILITA VARCHAR2(1);
comment on column SG101_FAMILIARI.TIPO_DISABILITA
  is 'Tipo disabilità: 1=Rivedibile, 2=Non rivedibile, 3=Provvisorio';

ALTER TABLE SG101_FAMILIARI ADD ANNO_REVISIONE NUMBER;
comment on column SG101_FAMILIARI.ANNO_REVISIONE
  is 'Anno revisione disabilità';

ALTER TABLE SG101_FAMILIARI ADD MOTIVO_GRADO_3 VARCHAR2(1);
comment on column SG101_FAMILIARI.MOTIVO_GRADO_3
  is 'Motivo parentela di terzo grado';

ALTER TABLE SG101_FAMILIARI ADD ALTERNATIVA VARCHAR2(1);
comment on column SG101_FAMILIARI.ALTERNATIVA
  is 'Alternativa: 1=Genitore, 2=Coniuge, 3=Figlio, 4=Parente o affine fino al II grado, 5=Parente o affine fino al III grado, 6=Nessuno, 7=Affidatario';

ALTER TABLE SG101_FAMILIARI ADD NOME_PA_ALT VARCHAR2(100);
comment on column SG101_FAMILIARI.NOME_PA_ALT
  is 'Denominazione pubblica amministrazione per cui lavora l''alternativa';

ALTER TABLE SG101_FAMILIARI ADD MOTIVO_GRADO_3_ALT VARCHAR2(1);
comment on column SG101_FAMILIARI.MOTIVO_GRADO_3_ALT
  is 'Motivo parentela di terzo grado dell''alternativa';
