--PATCH 06 VERSIONE 7.9

--script per ricreare le righe sulla T001 per la gestione dei jobs di allineamento
declare 
  w_id_job      T001_PARAMETRIFUNZIONI.VALORE%TYPE:='';
  w_last_sec    T001_PARAMETRIFUNZIONI.VALORE%TYPE:='';
  w_id_job_ctrl T001_PARAMETRIFUNZIONI.VALORE%TYPE:='';
begin
  --:MESSAGGI:='';
  --verifico esistenza del job di allineamento
  BEGIN
    select JOB, NVL(SUBSTR(LAST_SEC,1,5),'00:00')
    INTO w_id_job, w_last_sec
    from user_jobs
    where UPPER(what) like UPPER('%allinea_per_job%');
    --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'JOB ALL: ' || w_id_job || ' - ' || w_last_sec;
    --aggiorno l'id...
    UPDATE T001_PARAMETRIFUNZIONI
    SET VALORE = w_id_job
    WHERE PROGOPERATORE = -1
    AND PROG = 'A044'
    AND NOME = 'ID_JOB';
    --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'JOB AGGIORNATI: ' || SQL%ROWCOUNT;
    IF SQL%ROWCOUNT = 0 THEN
      --...o lo inserisco
      INSERT INTO T001_PARAMETRIFUNZIONI
      (PROG, NOME, VALORE, PROGOPERATORE)
      VALUES
      ('A044','ID_JOB',w_id_job,-1);
      --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'JOB INSERITO: ' || w_id_job;
    END IF;    
    --aggiorno l'ora...
    UPDATE T001_PARAMETRIFUNZIONI
    SET VALORE = w_last_sec
    WHERE PROGOPERATORE = -1
    AND PROG = 'A044'
    AND NOME = 'ORA_JOB';
    --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'ORE AGGIORNATE: ' || SQL%ROWCOUNT;
    IF SQL%ROWCOUNT = 0 THEN
      --...o la inserisco
      INSERT INTO T001_PARAMETRIFUNZIONI
      (PROG, NOME, VALORE, PROGOPERATORE)
      VALUES
      ('A044','ORA_JOB',w_last_sec,-1);
      --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'ORE INSERITE: ' || w_last_sec;
    END IF;    
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
  --verifico esistenza del job di controllo
  BEGIN
    select JOB
    INTO w_id_job_ctrl
    from user_jobs
    where UPPER(what) like UPPER('%''A044''%');
    --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'JOB CTRL: ' || w_id_job_ctrl;
    --aggiorno l'id...
    UPDATE T001_PARAMETRIFUNZIONI
    SET VALORE = w_id_job_ctrl
    WHERE PROGOPERATORE = -1
    AND PROG = 'A044'
    AND NOME = 'ID_JOB_CTRL';
    --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'JOB AGGIORNATI: ' || SQL%ROWCOUNT;
    IF SQL%ROWCOUNT = 0 THEN  
      --...o lo inserisco
      INSERT INTO T001_PARAMETRIFUNZIONI
      (PROG, NOME, VALORE, PROGOPERATORE)
      VALUES
      ('A044','ID_JOB_CTRL',w_id_job_ctrl,-1);
      --:MESSAGGI:=:MESSAGGI || CHR(10) || CHR(13) || 'JOB INSERITO: ' || w_id_job_ctrl;
    END IF;    
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
  COMMIT;
end;
/

drop index T050_ID;
create index T050_IDRICH on T050_RICHIESTEASSENZA (ID) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

create index T050_ID_REVOCA on T050_RICHIESTEASSENZA (ID_REVOCA) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T162_INDENNITA add CAUPRES_RIEPORE varchar2(5);
comment on column T162_INDENNITA.CAUPRES_RIEPORE is 'Causale di presenza su cui si devono riepilogare mensilmente le ore rese relative a questa indennità';

UPDATE p200_voci t SET T.COD_CAUSALEIRPEF=NULL WHERE T.COD_CAUSALEIRPEF IS NOT NULL;

DELETE p080_causaliirpef t WHERE T.COD_CAUSALEIRPEF NOT IN ('1001','1002','1004','1040');

insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24100E', 'Ritenute sui redditi da lavoro dipendente ed assimilati');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24102E', 'Ritenute su emolumenti arretrati');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24104E', 'Ritenute sui redditi da lavoro autonomo');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24110E', 'Ritenute su indennità per cessazione di rapporto di lavoro');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24111E', 'Ritenute su conguaglio effettuato nei primi due mesi dell''anno successivo');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24118E', 'Interessi pagamento dilazionato importi rateizzabili irpef trattenuta dal sostituto d''imposta a seguito di assistenza fiscale');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24124E', 'Interessi pagamento dilazionato dell''addizionale regionale all''irpef trattenuta dal sostituto d''imposta a seguito di assistenza fiscale');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24125E', 'Interessi pagamento dilazionato dell''addizionale comunale all''irpef trattenuta dal sostituto d''imposta a seguito di assistenza fiscale');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24126E', 'Addizionale regionale all''irpef trattenuta dal sostituto d''imposta a seguito di assistenza fiscale');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24127E', 'Addizionale comunale all''irpef trattenuta dal sostituto d''imposta -mod. 730- acconto');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24128E', 'Addizionale comunale all''irpef trattenuta dal sostituto d''imposta -mod. 730-');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24129E', 'Acconto imposte sui redditi soggetti a tassazione separata trattenuto dal sostituto d''imposta');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24133E', 'Irpef in acconto trattenuta dal sostituto d''imposta');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24134E', 'Irpef a saldo trattenuta dal sostituto d''imposta');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24381E', 'Addizionale regionale Irpef trattenuta dai sostituti d’imposta');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24384E', 'Addizionale comunale Irpef trattenuta dai sostituti d’imposta -saldo');
insert into P080_CAUSALIIRPEF (COD_CAUSALEIRPEF, DESCRIZIONE)
values ('F24385E', 'Addizionale comunale Irpef trattenuta dai sostituti d’imposta- acconto');


update p200_voci t set t.cod_causaleirpef='F24102E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11220' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24110E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11230' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24104E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11500' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24134E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11800' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11801' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11802' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24134E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11805' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11806' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11807' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24133E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11810' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11811' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11812' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24133E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11815' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11817' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24133E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11820' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11821' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11822' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24133E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11825' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11827' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24134E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11840' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11841' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11842' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24134E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11845' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11846' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11847' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24127E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11850' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11851' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11852' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24127E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11855' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11856' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11857' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24129E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11865' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11866' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11867' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24126E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11871' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24124E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11872' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24124E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11873' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24128E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11875' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11876' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11877' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24129E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11882' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11883' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24118E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11884' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24126E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11886' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24124E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11887' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24124E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11888' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24128E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11890' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11891' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24125E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11892' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24100E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11905' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24100E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11906' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24381E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11910' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24381E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11911' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24384E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11912' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24384E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11913' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24384E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11920' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24384E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11921' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24100E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11922' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24381E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11923' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24381E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11924' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24100E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11925' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24100E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11926' and t.cod_voce_speciale='BASE';
update p200_voci t set t.cod_causaleirpef='F24100E' where t.cod_contratto IN ('EDP','EDPSC') and t.cod_voce='11927' and t.cod_voce_speciale='BASE';

alter table P260_MOD730TIPOIMPORTI add ANNO_IMPOSTA NUMBER(1) default -1;
comment on column P260_MOD730TIPOIMPORTI.ANNO_IMPOSTA
  is 'Anno di imposta rispetto a quello corrente';

UPDATE P260_MOD730TIPOIMPORTI T SET T.ANNO_IMPOSTA=0
WHERE T.COD_TIPOIMPORTO IN('ACC','ACD','1IC','1ID','2IC','2ID','ICC','ICD','IIC','IID','IRC','IRD','ITC','ITD','RIC','RID');

DELETE P660_FLUSSIREGOLE P660 WHERE P660.NOME_FLUSSO='F24EP' AND P660.PARTE='E';

insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '001', 'IRPEF', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''F'' TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11500BASE'',''104E'',' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali saldo e acconto' || chr(10) || 'SELECT DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, SUM(IMPORTO) IMPORTO FROM' || chr(10) || '(' || chr(10) || '-- IRPEF da competenze del mese' || chr(10) || 'SELECT ''F'' TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210BASE'',''100E'',''11220BASE'',''102E'',''11230BASE'',''110E'',''11500BASE'',''104E'',' || chr(10) || '       ''11210CONG'',DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),1,''111E'',''100E'')) COD_TRIBUTO,' || chr(10) || ''''' COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'DECODE(P442.COD_VOCE||P442.COD_VOCE_SPECIALE,''11210CONG'',' || chr(10) || '       DECODE(SIGN(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') - TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')),' || chr(10) || '              1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) - 1,TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))),' || chr(10) || '       TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY''))) ANNO,' || chr(10) || 'P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE||P442.COD_VOCE_SPECIALE IN (''11210BASE'',''11220BASE'',''11230BASE'',''11500BASE'',''11210CONG'')' || chr(10) || 'AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Addizionali saldo e acconto' || chr(10) || 'SELECT DECODE(P258.TIPO_ADDIZIONALE,''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'DECODE(P442.COD_VOCE,''11250'',''384E'',''11255'',''385E'',''11270'',''381E'') COD_TRIBUTO,' || chr(10) || 'P258.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE, P258.ANNO, P442.IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P258_ADDIZIONALIIRPEF P258' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO AND P441.PROGRESSIVO = P258.PROGRESSIVO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P258.ANNO = TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'')' || chr(10) || 'AND P258.TIPO_ADDIZIONALE = DECODE(P442.COD_VOCE,''11250'',''C'',''11255'',''C'',''11270'',''R'')' || chr(10) || 'AND P258.TIPO_VERSAMENTO = DECODE(P442.COD_VOCE,''11250'',''S'',''11255'',''A'',''11270'',''S'')' || chr(10) || 'AND P442.COD_VOCE IN (''11250'',''11255'',''11270'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'UNION ALL' || chr(10) || '-- Modello 730' || chr(10) || 'SELECT DECODE(P260.TIPO_ENTE,''N'',''F'',''R'',''R'',''C'',''S'') TIPO_RIGA,' || chr(10) || 'SUBSTR(P200.COD_CAUSALEIRPEF,4) COD_TRIBUTO,' || chr(10) || 'P264.COD_ENTE, ''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'P260.ANNO + P260.ANNO_IMPOSTA ANNO,' || chr(10) || 'P442.IMPORTO * DECODE(P200.IMPORTO_COLONNA,''C'',-1,''R'',1) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442, P200_VOCI P200,' || chr(10) || '     P260_MOD730TIPOIMPORTI P260, P264_MOD730IMPORTI P264,' || chr(10) || '     T480_COMUNI T480, T482_REGIONI T482' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.TIPO_RECORD = ''M'' AND P200.ID_VOCE = P442.ID_VOCE AND' || chr(10) || '(' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RATE AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RATE) OR' || chr(10) || '(P442.COD_VOCE = P260.COD_VOCE_INT_RITARDO AND' || chr(10) || 'P442.COD_VOCE_SPECIALE = P260.COD_VOCE_SPECIALE_INT_RITARDO)' || chr(10) || ') AND' || chr(10) || 'TO_CHAR(P442.DATA_COMPETENZA_A,''YYYY'') = P260.ANNO AND' || chr(10) || 'P260.ANNO = P264.ANNO AND P260.COD_TIPOIMPORTO = P264.COD_TIPOIMPORTO AND' || chr(10) || 'P264.PROGRESSIVO = P441.PROGRESSIVO AND' || chr(10) || 'P264.COD_ENTE = T480.CODCATASTALE(+) AND P264.COD_ENTE = T482.COD_REGIONE(+)' || chr(10) || ')' || chr(10) || 'GROUP BY TIPO_RIGA, COD_TRIBUTO, COD_ENTE, MESE, ANNO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || 'ORDER BY TIPO_RIGA, COD_ENTE, COD_TRIBUTO, ANNO', 'N', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('F24EP', to_date('01-01-2008', 'dd-mm-yyyy'), 'E', '002', 'IRAP', null, null, null, null, null, 'N', 'N', null, null, 'S', 'R', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''R'' TIPO_RIGA,''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || ')', 'SELECT TIPO_RIGA, COD_TRIBUTO, COD_ENTE CODICE, '''' ESTREMI_IDENT,' || chr(10) || '       MESE RIFERIMENTO_A, ANNO RIFERIMENTO_B, IMPORTO IMPORTO FROM' || chr(10) || '(' || chr(10) || 'SELECT ''R'' TIPO_RIGA,''380E'' COD_TRIBUTO,' || chr(10) || '  (SELECT T482.COD_IRPEF FROM P500_CUDSETUP P500, T481_PROVINCE T481, T482_REGIONI T482' || chr(10) || '     WHERE P500.ANNO = TO_CHAR(P441.DATA_CEDOLINO,''YYYY'') AND P500.PROVINCIA = T481.COD_PROVINCIA' || chr(10) || '     AND T481.COD_REGIONE = T482.COD_REGIONE)' || chr(10) || '  COD_ENTE,' || chr(10) || '''00'' || TO_CHAR(P441.DATA_CEDOLINO,''MM'') MESE,' || chr(10) || 'TO_NUMBER(TO_CHAR(P441.DATA_CEDOLINO,''YYYY'')) ANNO,' || chr(10) || 'SUM(P442.IMPORTO) IMPORTO' || chr(10) || 'FROM P441_CEDOLINO P441, P442_CEDOLINOVOCI P442' || chr(10) || 'WHERE P441.ID_CEDOLINO = P442.ID_CEDOLINO' || chr(10) || 'AND P441.DATA_CEDOLINO = :DataElaborazione AND P441.CHIUSO IN (:StatoCedolini)' || chr(10) || 'AND P442.COD_VOCE IN (''11100'',''11102'')' || chr(10) || 'AND P442.COD_VOCE_SPECIALE = ''BASE'' AND P442.TIPO_RECORD = ''M''' || chr(10) || 'GROUP BY P441.DATA_CEDOLINO' || chr(10) || 'HAVING SUM(IMPORTO) <> 0' || chr(10) || ')', 'N', null, null, null, null, null, null, null);