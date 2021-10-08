UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '7.1',PATCHDB = 0 WHERE AZIENDA = :AZIENDA;

ALTER TABLE P212_PARAMETRISTIPENDI modify TIPO_CALCOLO_IMPORTO13A default 'UM';

COMMENT ON COLUMN P212_PARAMETRISTIPENDI.TIPO_CALCOLO_IMPORTO13A
  is 'Tipo calcolo importo tredicesima: UM=considerando solo la retribuzione dell''ultimo mese; RM=considerando la retribuzione di tutti i mesi; UD=considerando 1/12 della retribuzione corrisposta nell''anno';

UPDATE p212_parametristipendi t SET T.TIPO_MATURAZIONE13A='GL',T.TIPO_CALCOLO_IMPORTO13A='UD',T.TIPO_ABBATTIMENTO13A='R' WHERE T.COD_PARAMETRISTIPENDI='EDPSC';

INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA, TIPO)
SELECT AZIENDA, 'C7_REGOLE' FROM MONDOEDP.I090_ENTI;
comment on column T760_REGOLEINCENTIVI.LIVELLO
  is 'Codice del dato anagrafico aziendale';
UPDATE T760_REGOLEINCENTIVI SET LIVELLO = '<UNICA>';
ALTER TABLE T760_REGOLEINCENTIVI DROP CONSTRAINT T760_PK;
alter table T760_REGOLEINCENTIVI
  add constraint T760_PK primary key (DECORRENZA,LIVELLO)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

-- ADD COLUMNS NROSOSP
   ALTER TABLE M060_ANTICIPI ADD NROSOSP NUMBER;

alter table I100_PARSCARICO add TIMB_NONTOLL_LOG varchar2(1) default 'S';
comment on column I100_PARSCARICO.TIMB_NONTOLL_LOG is 'Segnala anomalia se la timbratura è fuori periodo';
alter table I100_PARSCARICO add TIMB_NONTOLL_REG varchar2(1) default 'S';
comment on column I100_PARSCARICO.TIMB_NONTOLL_REG is 'Registra la timbratura se è fuori periodo';
alter table I100_PARSCARICO add  TIMB_NONTOLL_GGPREC number(8) default -1;
comment on column I100_PARSCARICO.TIMB_NONTOLL_GGPREC is 'Giorni precedenti alla data elaborazione';
alter table I100_PARSCARICO add  TIMB_NONTOLL_GGSUCC number(8) default -1;
comment on column I100_PARSCARICO.TIMB_NONTOLL_GGSUCC is 'Giorni successivi alla data elaborazione';

UPDATE p212_parametristipendi t SET T.TIPO_CALCOLO_IMPORTO13A='UD',T.TIPO_MATURAZIONE13A='GL',T.TIPO_ABBATTIMENTO13A='R' WHERE T.COD_PARAMETRISTIPENDI='EDPSC';

update T915_CODICISELEZIONATI set DATO = 'EDP___' || DATO where ID_SERBATOIO = '5' and length(DATO) = 11 and CODICE in (select CODICE from T910_RIEPILOGO where APPLICAZIONE = 'PAGHE');

update T910_RIEPILOGO set IMPOSTAZIONI = IMPOSTAZIONI || ',CONTRATTO_VOCI=EDP' where APPLICAZIONE = 'PAGHE' and INSTR(IMPOSTAZIONI,'CONTRATTO_VOCI') = 0;

create index T103_IDX on T103_TIMBRATURE_SCARTATE (PROGRESSIVO,DATA) 
tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table P430_ANAGRAFICO add MATR_PENSIONISTICA varchar2(10);
comment on column P430_ANAGRAFICO.MATR_PENSIONISTICA
  is 'Matricola pensionistica (es. posizione ENPAM)';

ALTER TABLE T600_SQUADRE ADD CAUS_RIPOSO VARCHAR2(5);
COMMENT ON COLUMN T600_SQUADRE.CAUS_RIPOSO IS 'Causale di riposo per il calcolo delle competenze annuali';
ALTER TABLE T600_SQUADRE ADD MIN_IND1 NUMBER(3);
COMMENT ON COLUMN T600_SQUADRE.MIN_IND1 IS 'Turni minimi nel periodo per maturazione indennità';
ALTER TABLE T600_SQUADRE ADD MIN_IND2 NUMBER(3);
COMMENT ON COLUMN T600_SQUADRE.MIN_IND2 IS 'Turni minimi nel periodo per maturazione indennità';
ALTER TABLE T600_SQUADRE ADD MIN_IND3 NUMBER(3);
COMMENT ON COLUMN T600_SQUADRE.MIN_IND3 IS 'Turni minimi nel periodo per maturazione indennità';
ALTER TABLE T600_SQUADRE ADD MIN_IND4 NUMBER(3);
COMMENT ON COLUMN T600_SQUADRE.MIN_IND4 IS 'Turni minimi nel periodo per maturazione indennità';
ALTER TABLE T600_SQUADRE ADD PERIODO_MATUR_IND NUMBER(2);
COMMENT ON COLUMN T600_SQUADRE.PERIODO_MATUR_IND IS 'Numero di mesi entro cui fare il controllo dei turni minimi per la maturazione indennità';
ALTER TABLE T600_SQUADRE ADD MIN_FESTIVITA_MESE NUMBER(1);
COMMENT ON COLUMN T600_SQUADRE.MIN_FESTIVITA_MESE IS 'Festività minime che devono essere riposate ogni mese';
ALTER TABLE T600_SQUADRE ADD PRIORITA_MINMAX VARCHAR2(4) DEFAULT 1234; 
COMMENT ON COLUMN T600_SQUADRE.PRIORITA_MINMAX
  IS 'Priorità di correzione per i massimi e i minimi dei turni';
alter table T620_TURNAZIND add PIANIF_DA_CALENDARIO varchar2(1) default 'N' not null;
comment on column T620_TURNAZIND.PIANIF_DA_CALENDARIO is 'N=Pianifica tutti i gioni  - S=Pianifica solo i gioni lavorativi da calendario';

alter table T950_STAMPACARTELLINO add CAUPRES_ESCLUSE varchar2(1000);
comment on column T950_STAMPACARTELLINO.CAUPRES_ESCLUSE is 'Elenco delle causali di presenza da non visualizzare sul cartellino';

alter table T305_CAUGIUSTIF add LIMITE_LIQ varchar2(1) default 'N';
comment on column T305_CAUGIUSTIF.LIMITE_LIQ is 'N=Le ore di assestamento non sono considerate nei limiti del liquidabile - S=Le ore di assestamento sono considerate nei limiti del liquidabile';

alter table T430_STORICO drop column ABCAUSALE2;
alter table T430_STORICO drop column ABCAUSALE3;
alter table T430_STORICO drop column ABCAUSALE4;
alter table T430_STORICO drop column ABCAUSALE5;
alter table T430_STORICO drop column ABCAUSALE6;
alter table T430_STORICO drop column ABPRESENZA2;
alter table T430_STORICO drop column ABPRESENZA3;
alter table T430_STORICO drop column ABPRESENZA4;
alter table T430_STORICO drop column ABPRESENZA5;
alter table T430_STORICO drop column ABPRESENZA6;
alter table T430_STORICO drop column ABPRESENZA7;
alter table T430_STORICO drop column ABPRESENZA8;

alter table T020_ORARI add DEBITO_RIPCOM varchar2(5);
comment on column T020_ORARI.DEBITO_RIPCOM is 'Debito giornaliero del turno con cui raffrontare il debito mensile da ore teoriche per ottenere i minuti di riposo compensativo maturati. Se nullo si utilizza il debito giornaliero da ore teoriche';

alter table T025_CONTMENSILI add CAUSRIPCOM_FASCE varchar2(5);
comment on column T025_CONTMENSILI.CAUSRIPCOM_FASCE is 'causale di presenza esclusa dalle ore normali per consentire il riepilogo dei riposi compensativi in fasce';

insert into MONDOEDP.I091_DATIENTE (select AZIENDA,'C19_STORIAINIZIOFINE', 'N' from MONDOEDP.I090_ENTI);

alter table P150_SETUP add CEDOLINO_WEB_DAL date;
alter table P150_SETUP add CEDOLINO_WEB_GG_EMISS number(2);
comment on column P150_SETUP.CEDOLINO_WEB_DAL  is 'Mese di inizio abilitazione cedolino web';
comment on column P150_SETUP.CEDOLINO_WEB_GG_EMISS  is 'Giorni di ritardo da data emissione per web';

insert into p070_misurequantita
  (cod_misuraquantita, descrizione, tipo)
values
  ('NORBR', 'Numero ore responsabile branca ambul.', 'QM');

ALTER TABLE P500_CUDSETUP
MODIFY CODICE_ATECO_DMA VARCHAR2(6);

alter table p500_cudsetup add 
(IND_DOM_POSTEL VARCHAR2(50),
 CAP_DOM_POSTEL VARCHAR2(50),
 COM_DOM_POSTEL VARCHAR2(50),
 PRV_DOM_POSTEL VARCHAR2(50),
 SEDE_SERVIZIO_CED VARCHAR2(50),
 UNITA_OP_CED VARCHAR2(50),
 QUALIFICA_CED VARCHAR2(50));
 
comment on column p500_cudsetup.IND_DOM_POSTEL is 'Campo contenente l''indirizzo di domicilio del dipendente per il file postel';
comment on column p500_cudsetup.CAP_DOM_POSTEL is 'Campo contenente il CAP di domicilio del dipendente per il file postel';
comment on column p500_cudsetup.COM_DOM_POSTEL is 'Campo contenente il comune di domicilio del dipendente per il file postel';
comment on column p500_cudsetup.PRV_DOM_POSTEL is 'Campo contenente la provincia di domicilio del dipendente per il file postel';
comment on column p500_cudsetup.SEDE_SERVIZIO_CED is 'Campo contenente la sede di servizio del dipendente per il cedolino';
comment on column p500_cudsetup.UNITA_OP_CED is 'Campo contenente l''unità operativa del dipendente per il cedolino';
comment on column p500_cudsetup.QUALIFICA_CED is 'Campo contenente la qualifica del dipendente per il cedolino';

ALTER TABLE SG506_PIANTADISTRIBUZIONE ADD NOTE VARCHAR2(1000);
ALTER TABLE SG508_STAMPAPIANTA ADD DETTAGLIO_ATTI VARCHAR2(1) DEFAULT 'N';
comment on column SG504_PIANTAORGANICA.DATA
  is 'Data atto';
comment on column SG504_PIANTAORGANICA.ATTO
  is 'Estremi atto';
comment on column SG504_PIANTAORGANICA.ID_PIANTA
  is 'Identificativo atto/struttura';
comment on column SG504_PIANTAORGANICA.NUMERO_POSTI
  is 'Posti previsti';
comment on column SG504_PIANTAORGANICA.PARTTIME
  is 'Posti previsti part-time';
comment on column SG504_PIANTAORGANICA.NOTE
  is 'Note';
comment on column SG504_PIANTAORGANICA.STRUTTURA_DEFAULT
  is '''S''=struttura di caricamento/visualizzazione,''N''=atto/delibera per posti previsti,''C''=atto per posti in fase di copertura';
comment on column SG504_PIANTAORGANICA.STRUTTURA_RIFERIMENTO
  is 'Identificativo struttura di caricamento/visualizzazione';
comment on column SG505_PIANTADETTAGLIO.ID_PIANTA
  is 'Identificativo atto/struttura';
comment on column SG505_PIANTADETTAGLIO.TIPO
  is 'Codice tipo movimento';
comment on column SG505_PIANTADETTAGLIO.NUMERO_POSTI
  is 'Numero posti previsti';
comment on column SG506_PIANTADISTRIBUZIONE.ID_PIANTA
  is 'Identificativo atto/struttura';
comment on column SG506_PIANTADISTRIBUZIONE.ID_RAMO
  is 'Identificativo ramo';
comment on column SG506_PIANTADISTRIBUZIONE.ID_PADRE
  is 'Identificativo nodo padre';
comment on column SG506_PIANTADISTRIBUZIONE.LIVELLO
  is 'Livello nodo';
comment on column SG506_PIANTADISTRIBUZIONE.NOME_CAMPO
  is 'Nome dato anagrafico';
comment on column SG506_PIANTADISTRIBUZIONE.VALORE_CAMPO
  is 'Valore dato anagrafico';
comment on column SG506_PIANTADISTRIBUZIONE.NUMERO_POSTI
  is 'Numero posti previsti/in fase di copertura';
comment on column SG506_PIANTADISTRIBUZIONE.NUMERO_CALCOLATI
  is 'Non utilizzato';
comment on column SG506_PIANTADISTRIBUZIONE.PERCORSO
  is 'Percorso nodo';
comment on column SG506_PIANTADISTRIBUZIONE.NUMERO_PERCENTUALE
  is 'Non utilizzato';
comment on column SG506_PIANTADISTRIBUZIONE.INIZIO
  is 'Inizio validità nodo';
comment on column SG506_PIANTADISTRIBUZIONE.FINE
  is 'Fine validità nodo';
comment on column SG506_PIANTADISTRIBUZIONE.NOTE
  is 'Note';

alter table T265_CAUASSENZE add CUMULO_TIPO_ORE varchar2(1) default '0';
comment on column T265_CAUASSENZE.CUMULO_TIPO_ORE is '0=Considera nel cumulo le ore fruite da giustificativo - 1=Considera nel cumulo le ore rese sul cartellino';

declare 
  FS varchar2(200);
begin
  FS:=null;
  select VALORE into FS from T001_PARAMETRIFUNZIONI where
  PROG = 'A074' and
  NOME = 'FILESEQUENZIALE' and
  PROGOPERATORE = (
    select max(A.PROGOPERATORE) from
    T001_PARAMETRIFUNZIONI A,
    T001_PARAMETRIFUNZIONI B where 
    A.PROG = 'A074' and
    A.NOME = 'CREAFILESEQ' and
    A.VALORE = 'S' and
    A.PROGOPERATORE = B.PROGOPERATORE and
    B.PROG = A.PROG and
    B.NOME = 'FILESEQUENZIALE' and
    B.VALORE is not null);
  if FS is not null then
    insert into T191_PARPAGHE 
      (CODICE,DESCRIZIONE,TIPOFILE,NOMEFILE,FORMATOORE,PRECISIONE,SEPARATOREDECIMALI,TIPODATA_FILE,RICREAZIONE_AUTOMATICA,TIPO_PARAMETRIZZAZIONE)
    values
      ('A074','ACQUISTO BUONI PASTO/TICKET','F',FS,'0','2','.','C','S','PAGHE');
    insert into T192_PARPAGHEDATI 
      (CODICE,POS,LUNG,DEF,TIPO,NOME,TIPO_PARAMETRIZZAZIONE) values ('A074','1','20','COGNOME','H','COGNOME','PAGHE');
    insert into T192_PARPAGHEDATI 
      (CODICE,POS,LUNG,DEF,TIPO,NOME,TIPO_PARAMETRIZZAZIONE) values ('A074','21','10','NOME','H','NOME','PAGHE');
    insert into T192_PARPAGHEDATI 
      (CODICE,POS,LUNG,DEF,TIPO,NOME,TIPO_PARAMETRIZZAZIONE) values ('A074','31','2',NULL,'8','VALORE','PAGHE');
    insert into T192_PARPAGHEDATI 
      (CODICE,POS,LUNG,DEF,TIPO,NOME,TIPO_PARAMETRIZZAZIONE) values ('A074','33','5',NULL,'3','MATRICOLA','PAGHE');
  end if;
exception
  when others then null;
end;
/

declare 
  cursor c1 is 
    select codice,decorrenza from t021_fasceorari
    minus
    select codice,decorrenza from t020_orari;
  cursor c2 is 
    select codice,decorrenza from t221_profilisettimana
    minus
    select codice,decorrenza from t220_profiliorari;
begin
  for t1 in c1 loop
    delete from t021_fasceorari where codice = t1.codice and decorrenza = t1.decorrenza;
  end loop;  
  for t1 in c2 loop
    delete from t221_profilisettimana where codice = t1.codice and decorrenza = t1.decorrenza;
  end loop;  
end;
/
alter table t021_fasceorari enable constraint t021_fk_t020;
alter table t221_profilisettimana enable constraint t221_fk_t220;

insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '001', 'Cognome', null, null, '001', 'AN', 50, 'N', 'N', null, null, 'S', 'I', null, null, 'S', null, null, null, null, 'COGNOME', null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '002', 'Nome', null, null, '002', 'AN', 50, 'N', 'N', null, null, 'S', 'I', null, null, 'S', null, null, null, null, 'NOME', null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '003', 'Codice fiscale della persona', null, null, '003', 'CF', 16, 'N', 'N', null, null, 'S', 'I', null, null, 'S', null, null, null, null, 'CODFISCALE', null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '004', 'Codice Ente', null, null, '004', 'NU', 3, 'N', 'S', null, null, 'S', 'I', 'SELECT ''980'' FROM DUAL', 'SELECT ''980'' FROM DUAL', 'S', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '005', 'Posizione attuale: profilo', null, null, '005', 'AN', 4, 'N', 'N', null, null, 'S', 'I', null, null, 'S', null, null, null, null, 'PROFILO', null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '006', 'Posizione attuale: disciplina/qualifica', null, null, '006', 'AN', 4, 'N', 'N', null, null, 'S', 'I', null, null, 'S', null, null, null, null, 'DISCIPLINA', null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '007', 'Posizione attuale: ruolo', null, null, '007', 'AN', 1, 'N', 'N', null, null, 'S', 'I', null, null, 'S', null, null, null, null, 'RUOLO_FLUPER', null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '008', 'Provider', null, null, '008', 'AN', 16, 'N', 'N', null, null, 'S', 'I', 'SELECT ''00202030144'' FROM DUAL', 'SELECT ''00202030144'' FROM DUAL', 'S', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '009', 'Anno di riferimento', null, null, '009', 'AN', 4, 'N', 'N', null, null, 'S', 'I', 'SELECT TO_CHAR(:DATAELABORAZIONE,''YYYY'') FROM DUAL', 'SELECT TO_CHAR(:DATAELABORAZIONE,''YYYY'') FROM DUAL', 'S', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '010', 'Punteggio Totale', null, null, '010', 'NU', 5, 'N', 'S', null, null, 'S', 'I', null, null, 'S', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '011', 'Filler', null, null, '011', 'AN', 96, 'N', 'N', null, null, 'S', 'I', null, null, 'S', null, null, null, null, null, null, null);
insert into P660_FLUSSIREGOLE (NOME_FLUSSO, DECORRENZA, PARTE, NUMERO, DESCRIZIONE, TIPO_RECORD, SEZIONE_FILE, NUMERO_FILE, FORMATO_FILE, LUNGHEZZA_FILE, FORMATO_ANNOMESE, NUMERICO, COD_ARROTONDAMENTO, FORMATO, OMETTI_VUOTO, TIPO_DATO, REGOLA_CALCOLO_AUTOMATICA, REGOLA_CALCOLO_MANUALE, REGOLA_MODIFICABILE, COMMENTO, FL_NUMERO_TREDICESIMA, FL_NUMERO_ARRCORR, FL_NUMERO_ARRPREC, NOME_DATO, CODICI_CAUSALI, FL_NUMERO_TREDPREC)
values ('CREDITI', to_date('01-01-2007', 'dd-mm-yyyy'), 'B', '012', 'Tipo record', null, null, '012', 'AN', 1, 'N', 'N', null, null, 'S', 'I', 'SELECT ''1'' FROM DUAL', 'SELECT ''1'' FROM DUAL', 'S', null, null, null, null, null, null, null);

