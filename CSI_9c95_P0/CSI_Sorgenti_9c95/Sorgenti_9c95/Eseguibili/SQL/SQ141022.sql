update MONDOEDP.I090_ENTI set VERSIONEDB = '9.3',PATCHDB = 0 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

ALTER TABLE T248_PERMESSISINDACALI MODIFY TIPO_PERMESSO DEFAULT 'D';

ALTER TABLE SG730_PUNTEGGI ADD ITEM_GIUDICABILE VARCHAR2(1) DEFAULT 'S';

ALTER TABLE SG746_STATI_AVANZAMENTO ADD CREA_AUTOVALUTAZIONE VARCHAR2(1) DEFAULT 'N';

ALTER TABLE MONDOEDP.I071_PERMESSI ADD S710_VALIDA_STATO VARCHAR2(1) DEFAULT 'N'/*--NOLOG--*/;

ALTER TABLE SG745_CONSEGNA_VALUTAZIONI ADD (TIPO_CONSEGNA VARCHAR2(2), MOTIVAZIONE VARCHAR2(500));
UPDATE SG745_CONSEGNA_VALUTAZIONI SET TIPO_CONSEGNA = 'PV' WHERE TIPO_CONSEGNA IS NULL;
ALTER TABLE SG745_CONSEGNA_VALUTAZIONI MODIFY TIPO_CONSEGNA NOT NULL;
ALTER TABLE SG745_CONSEGNA_VALUTAZIONI DROP PRIMARY KEY;
DROP INDEX SG745_PK/*--NOLOG--*/;
ALTER TABLE SG745_CONSEGNA_VALUTAZIONI
ADD CONSTRAINT SG745_PK PRIMARY KEY (TIPO_CONSEGNA, DATA, PROGRESSIVO, TIPO_VALUTAZIONE, STATO_AVANZAMENTO, UTENTE, PROG_UTENTE)
USING INDEX TABLESPACE INDICI STORAGE (INITIAL 256K NEXT 256K PCTINCREASE 0);

alter table T220_PROFILIORARI modify DESCRIZIONE varchar2(200);

comment on column T040_GIUSTIFICATIVI.SCHEDA is 'P=inseriti da pianificazione turni, V=validati se richiesta validazione da causale di assenza';
comment on column T040_GIUSTIFICATIVI.STAMPA is 'A=inseriti dal processo di autogiustificazione';

alter table M051_DETTAGLIORIMBORSO add STATO varchar2(1) default 'N';
comment on column M051_DETTAGLIORIMBORSO.STATO is 'N=Nessuno, V=Validato';

alter table M051_DETTAGLIORIMBORSO add NOTE varchar2(2000);
comment on column M051_DETTAGLIORIMBORSO.NOTE is 'note descrittive';

alter table M051_DETTAGLIORIMBORSO add IMPORTO_ORIGINALE number;
comment on column M051_DETTAGLIORIMBORSO.IMPORTO_ORIGINALE is 'importo originale precedente alle modifiche di controllo';

alter table M052_INDENNITAKM add STATO varchar2(1) default 'N';
comment on column M052_INDENNITAKM.STATO is 'N=Nessuno, V=Validato';

alter table M052_INDENNITAKM add NOTE varchar2(2000);
comment on column M052_INDENNITAKM.NOTE is 'note descrittive';

alter table M052_INDENNITAKM add KMPERCORSI_ORIGINALI number;
comment on column M052_INDENNITAKM.KMPERCORSI_ORIGINALI is 'km originali precedenti alle modifiche di controllo';

update m050_rimborsi m050
set id_missione = 
  (select id_missione from m040_missioni m040
   where m050.progressivo = m040.progressivo
   and   m050.mesescarico = m040.mesescarico
   and   m050.mesecompetenza = m040.mesecompetenza
   and   m050.datada = m040.datada
   and   m050.orada = m040.orada
)
where id_missione is null;

update m052_indennitakm m052
set id_missione = 
  (select id_missione from m040_missioni m040
   where m052.progressivo = m040.progressivo
   and   m052.mesescarico = m040.mesescarico
   and   m052.mesecompetenza = m040.mesecompetenza
   and   m052.datada = m040.datada
   and   m052.orada = m040.orada
)
where id_missione is null;

alter table T065_RICHIESTESTRAORDINARI add MIN_ORE_DALIQUIDARE varchar2(6);
comment on column T065_RICHIESTESTRAORDINARI.MIN_ORE_DALIQUIDARE is 'ore minime da richiedere in liquidazione: ORE_DALIQUIDARE deve essere >= MIN_ORE_DALIQUIDARE';

alter table T269_RELAZIONI_ATTESTATIINPS add caus_patgravi VARCHAR2(5);
alter table T269_RELAZIONI_ATTESTATIINPS drop column caus_emodialisi/*--NOLOG--*/;
alter table T269_RELAZIONI_ATTESTATIINPS drop column caus_sclero/*--NOLOG--*/;
alter table T269_RELAZIONI_ATTESTATIINPS add caus_gravidanza VARCHAR2(5);
comment on column T269_RELAZIONI_ATTESTATIINPS.caus_patgravi
  is 'Sclerosi e patologie documentate';
comment on column T269_RELAZIONI_ATTESTATIINPS.caus_gravidanza
  is 'Gravidanza';

alter table T048_ATTESTATIINPS add data_consegna date;
comment on column T048_ATTESTATIINPS.data_consegna
  is 'data alla quale il certificato medico risulta ricevuto/registrato dal datore di lavoro';
alter table T048_ATTESTATIINPS add causa_malattia varchar2(1);
comment on column T048_ATTESTATIINPS.causa_malattia
  is 'G=Gravidanza, S=Sclerosi e patologie documentate';    
alter table T048_ATTESTATIINPS add tipo_gestione varchar2(1) default 'A';
comment on column T048_ATTESTATIINPS.tipo_gestione
  is 'A=automatica(modulo di acquisizione certificato xml), M=manuale(inserimento giustificativi), T=autocertificazione(tramite comunicazione telefonica), E=autocertificazione(tramite e-mail), W=autocertificazione da APP(acquisita da file) ';
comment on column T048_ATTESTATIINPS.causale_mal
  is 'Causale di malattia utilizzata';  
alter table T048_ATTESTATIINPS add num_protocollo varchar2(10);
comment on column T048_ATTESTATIINPS.num_protocollo
  is 'Acquisizione file TXT: Numero di protocollo INPS';  
alter table T048_ATTESTATIINPS add NOTE varchar2(2000);
comment on column T048_ATTESTATIINPS.NOTE
  is 'Acquisizione file TXT: Numero di protocollo INPS';  
alter table T048_ATTESTATIINPS add tipo_registrazione VARCHAR2(1);
comment on column T048_ATTESTATIINPS.tipo_registrazione
  is 'Acquisizione file TXT: N = per nuova comunicazione, M = modifica di precedente comunicazione via app';  
alter table T048_ATTESTATIINPS add id_filetxt VARCHAR2(14);
comment on column T048_ATTESTATIINPS.id_filetxt
  is 'Acquisizione file TXT: identificativo univoco perido di malattia su file di testo';      

alter table T040_GIUSTIFICATIVI add id_certificato varchar2(10);
comment on column T040_GIUSTIFICATIVI.id_certificato
  is 'Protocollo identificativo certificato di malattia fornito dall''INPS (inserito o annullato)';
create sequence T048_IDCERTIFICATO
minvalue 1
maxvalue 999999999
start with 1
increment by 1
nocache;
alter table T265_CAUASSENZE modify vocepaghe2 VARCHAR2(10);
alter table T265_CAUASSENZE modify vocepaghe3 VARCHAR2(10);
alter table T265_CAUASSENZE modify vocepaghe4 VARCHAR2(10);
alter table T265_CAUASSENZE modify vocepaghe5 VARCHAR2(10);
alter table T265_CAUASSENZE modify vocepaghe6 VARCHAR2(10);

alter table T193_VOCIPAGHE_PARAMETRI add voce_paghe_secondaria VARCHAR2(10);
comment on column T193_VOCIPAGHE_PARAMETRI.voce_paghe_secondaria
  is 'Codice paghe aggiuntivo utilizzabile solo per decodifica in query di estrazione';
alter table T193_VOCIPAGHE_PARAMETRI add voce_paghe_secondh VARCHAR2(10);
comment on column T193_VOCIPAGHE_PARAMETRI.voce_paghe_secondh
  is 'Codice paghe aggiuntivo per voci passate ad ore utilizzabile solo per decodifica in query di estrazione'; 
alter table T193_VOCIPAGHE_PARAMETRI add voce_paghe_attributo VARCHAR2(10);
comment on column T193_VOCIPAGHE_PARAMETRI.voce_paghe_attributo
  is 'Attributo da aggiungersi alla voce nel file paghe, utilizzabile solo in query di estrazione';
alter table T193_VOCIPAGHE_PARAMETRI add stato_per_scarico varchar2(1) default '0';
comment on column T193_VOCIPAGHE_PARAMETRI.stato_per_scarico
  is 'Indica eventuali condizioni per scaricare la voce. Valori ammessi: 0=Scarica sempre la voce (attuale comportamento) 1=Scarica la voce solo se il mese è quadrato (Csi per voce normale) 2=Scarica la voce anche se il mese non è quadrato (Csi per giustificativo a discesa immediata) 3=Scarica la voce anche se il mese coincide con il mese di cassa (Csi per giustificativo a discesa immediata con valenza sul mese in corso)';
  
alter table SG101_FAMILIARI add tipo_adoz_affid varchar2(1);
alter table SG101_FAMILIARI add grav_inizio_teor date;
alter table SG101_FAMILIARI add grav_inizio_scelta date;
alter table SG101_FAMILIARI add grav_inizio_eff date;
alter table SG101_FAMILIARI add grav_fine date;
alter table SG101_FAMILIARI add data_preadoz date;
comment on column SG101_FAMILIARI.tipo_adoz_affid
  is 'Tipo adozione/affidamento: 1=adozione nazionale, 2=adozione internazionale, 3=affido residenziale, 4=affidamento';
comment on column SG101_FAMILIARI.grav_inizio_teor
  is 'Data inizio gravidanza terorico (solitamente 2 mesi prima della data presunta parto)';
comment on column SG101_FAMILIARI.grav_inizio_scelta
  is 'Data inizio gravidanza scelta dal dipendente';
comment on column SG101_FAMILIARI.grav_inizio_eff
  is 'Data inizio gravidanza effettiva (dopo ogni possibile causa di anticipo imposta dal medico)';
comment on column SG101_FAMILIARI.grav_fine
  is 'Data fine gravidanza';
comment on column SG101_FAMILIARI.data_preadoz
  is 'Data pre-adozione (inizio periodo passato all''estero assimilabile al pre-parto)';
    
comment on column T262_PROFASSANN.propggmm
  is 'G=Giornaliera, M=Mensile, R=in base ai Ratei mensili maturati';

--Script di adeguamento T040 per gestione inserimento periodi manuale
declare
  cursor c1 is
    select T040.*
      from T040_GIUSTIFICATIVI T040
     where T040.ID_RICHIESTA < 0
     order by T040.DATA;
  CCommit integer;
begin
  CCommit:=0;
  for T1 in C1 loop
    update T040_GIUSTIFICATIVI T040
       set T040.ID_CERTIFICATO = to_char(T040.ID_RICHIESTA * -1)
     where T040.PROGRESSIVO = T1.PROGRESSIVO
       and T040.DATA = T1.DATA
       and T040.CAUSALE = T1.CAUSALE
       and T040.PROGRCAUSALE = T1.PROGRCAUSALE
       and T040.ID_CERTIFICATO is null;    
    if CCommit > 100 then
      CCommit:=0;
      commit;
    else     
      CCommit:=CCommit + 1;
    end if;
  end loop;
  commit;
end;  
/

alter table T910_RIEPILOGO modify IMPOSTAZIONI varchar2(1000);
update T910_RIEPILOGO set IMPOSTAZIONI = replace(IMPOSTAZIONI,'CEDOLINI_RAPPLAVPREC=S','TIPOCED_NORMALE=S,TIPOCED_EXTRA27=S,TIPOCED_TREDICESIMA=S,TIPOCED_RAPLAVPREC=N') 
where APPLICAZIONE = 'PAGHE' and instr(IMPOSTAZIONI,'CEDOLINI_RAPPLAVPREC=S') > 0;
update T910_RIEPILOGO set IMPOSTAZIONI = replace(IMPOSTAZIONI,'CEDOLINI_RAPPLAVPREC=N','TIPOCED_NORMALE=S,TIPOCED_EXTRA27=S,TIPOCED_TREDICESIMA=S,TIPOCED_RAPLAVPREC=S') 
where APPLICAZIONE = 'PAGHE' and instr(IMPOSTAZIONI,'CEDOLINI_RAPPLAVPREC=N') > 0;

alter table MONDOEDP.I095_ITER_AUT add FILTRO_INTERFACCIA varchar2(1) default 'N'/*--NOLOG--*/;
comment on column MONDOEDP.I095_ITER_AUT.FILTRO_INTERFACCIA is 'S=COD_ITER disponibile nel filtro sulla Struttura in IrisWEB';

alter table T072_SCHEDAINDPRES add tipo_record varchar2(1) default 'A';
comment on column T072_SCHEDAINDPRES.tipo_record
  is 'Tipo record: A=Automatico, M=Manuale';
alter table T072_SCHEDAINDPRES drop constraint T072_PK/*--NOLOG--*/;
alter table T072_SCHEDAINDPRES drop primary key/*--NOLOG--*/;
drop index T072_PK/*--NOLOG--*/;
alter table T072_SCHEDAINDPRES
  add constraint T072_PK primary key (PROGRESSIVO, DATA, CODINDPRES, TIPO_RECORD)
  using index 
  tablespace INDICI
  storage (initial 256K next 1M pctincrease 0);

--tag 75 riutilizzato per nuova funzione W038
delete from MONDOEDP.I073_FILTROFUNZIONI where TAG = 75 and AZIENDA = 'AZIN';

alter table M140_RICHIESTE_MISSIONI add FLAG_PERCORSO varchar2(10) default 'ALTRO';
comment on column M140_RICHIESTE_MISSIONI.FLAG_PERCORSO is 'SEDE, DOMICILIO, ALTRO';

create table M141_PERCORSO_MISSIONE (
  ID        number(38),
  ORD       number(4),
  LOCALITA  varchar2(200),
  IND_KM    varchar2(1)
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table M141_PERCORSO_MISSIONE modify IND_KM default 'S';

comment on column M141_PERCORSO_MISSIONE.ID is 'Identificativo univoco della richiesta di riferimento';
comment on column M141_PERCORSO_MISSIONE.ORD is 'Numero di ordine della tappa';
comment on column M141_PERCORSO_MISSIONE.LOCALITA is 'Località della tappa';
comment on column M141_PERCORSO_MISSIONE.IND_KM is 'S=da considerare nel calcolo dell''ind.km, N=da non considerare nel calcolo dell''ind.km';

update M140_RICHIESTE_MISSIONI set FLAG_PERCORSO = 'ALTRO';

declare
  cursor c1 is 
    select m140.id, m140.partenza, m140.destinazione, m140.rientro
    from   m140_richieste_missioni m140
    order by m140.id;
begin
  for t1 in c1 loop
    insert into m141_percorso_missione (id, ord, localita, ind_km) values (t1.id, 1, t1.partenza, 'N');
    insert into m141_percorso_missione (id, ord, localita, ind_km) values (t1.id, 2, t1.destinazione, 'S');
    insert into m141_percorso_missione (id, ord, localita, ind_km) values (t1.id, 3, t1.rientro, 'S');        
    commit;
  end loop;
end;
/

create table AGG_930_M140 as select * from M140_RICHIESTE_MISSIONI;

comment on column M140_RICHIESTE_MISSIONI.PARTENZA is 'Obsoleto. Vedere tabella M141_PERCORSO_MISSIONE';
comment on column M140_RICHIESTE_MISSIONI.DESTINAZIONE is 'Obsoleto. Vedere tabella M141_PERCORSO_MISSIONE';
comment on column M140_RICHIESTE_MISSIONI.RIENTRO is 'Obsoleto. Vedere tabella M141_PERCORSO_MISSIONE';

alter table M140_RICHIESTE_MISSIONI drop column PARTENZA/*--NOLOG--*/;
alter table M140_RICHIESTE_MISSIONI drop column DESTINAZIONE/*--NOLOG--*/;
alter table M140_RICHIESTE_MISSIONI drop column RIENTRO/*--NOLOG--*/;

alter table M141_PERCORSO_MISSIONE
  add constraint M141_PK primary key (ID, ORD)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table M141_PERCORSO_MISSIONE
  add constraint M141_FK_M140 foreign key (ID)
  references M140_RICHIESTE_MISSIONI (ID) on delete cascade;  


-- Trasformata P210_CONTRATTI in tabella NON storicizzata

CREATE TABLE AGG_93_P210 AS SELECT * FROM P210_CONTRATTI;

DROP TABLE P210_CONTRATTI;

create table P210_CONTRATTI
( cod_contratto   VARCHAR2(5) not null,
  descrizione     VARCHAR2(40),
  note            VARCHAR2(2000))
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

alter table P210_CONTRATTI
  add constraint P210_PK primary key (COD_CONTRATTO)
  using index 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

INSERT INTO P210_CONTRATTI (COD_CONTRATTO, DESCRIZIONE, NOTE)
SELECT COD_CONTRATTO, DESCRIZIONE, NOTE FROM AGG_93_P210;

-- Modificato ANNO_REVISIONE dei familiari in DATA revisione

CREATE TABLE AGG_93_SG101 AS SELECT * FROM SG101_FAMILIARI;

UPDATE SG101_FAMILIARI SET ANNO_REVISIONE = '';

alter table SG101_FAMILIARI modify anno_revisione date;
comment on column SG101_FAMILIARI.anno_revisione
  is 'Data revisione disabilità (legge 104/1992)';
  
DECLARE
  CURSOR C1 IS
    SELECT PROGRESSIVO, NUMORD, DECORRENZA, TO_DATE('0101' || TO_CHAR(AGG.ANNO_REVISIONE),'DDMMYYYY') DATA_REVISIONE
      FROM AGG_93_SG101 AGG
     WHERE AGG.ANNO_REVISIONE IS NOT NULL;
BEGIN
  FOR T1 IN C1 LOOP
    UPDATE SG101_FAMILIARI SG101
       SET SG101.ANNO_REVISIONE = T1.DATA_REVISIONE
     WHERE SG101.PROGRESSIVO = T1.PROGRESSIVO
       AND SG101.NUMORD = T1.NUMORD
       AND SG101.DECORRENZA = T1.DECORRENZA;
  END LOOP;
END;
/

-- Add/modify columns 
alter table T482_REGIONI add fiscale VARCHAR2(1) default 'N' not null;
-- Add comments to the columns 
comment on column T482_REGIONI.fiscale
  is 'Regione significativa solo ai fini dell''addizionale IRPEF (S/N)';
