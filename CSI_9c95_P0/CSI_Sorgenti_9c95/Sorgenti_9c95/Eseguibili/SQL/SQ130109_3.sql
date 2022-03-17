ALTER TABLE T800_CAMPILIMITI MODIFY TIPOLIMITE DEFAULT 'L';

alter table T282_MESSAGGI add ID_ORIGINALE number(38);
comment on column T282_MESSAGGI.ID_ORIGINALE is 'Identificativo del messaggio originale. Usato per indicare il messaggio a cui si sta rispondendo';

create table T285_UTENTI_DEST (
  ID             number(38),
  UTENTE         varchar2(30),
  DATA_LETTURA   date,
  DATA_RICEZIONE date
)
tablespace LAVORO storage (initial 256K next 256K pctincrease 0);

comment on column T285_UTENTI_DEST.ID is 'Identificativo del messaggio di riferimento';
comment on column T285_UTENTI_DEST.UTENTE is 'Operatore IrisWin destinatario';
comment on column T285_UTENTI_DEST.DATA_LETTURA is 'Data di lettura del messaggio da parte del destinatario. Utilizzabile da parte del destinatario';
comment on column T285_UTENTI_DEST.DATA_RICEZIONE is 'Data di ricezione del messaggio da parte del destinatario. E'' visibile al mittente.';

alter table T285_UTENTI_DEST
  add constraint T285_PK primary key (ID, UTENTE)
  using index tablespace INDICI storage (initial 256K next 256K pctincrease 0);

alter table T285_UTENTI_DEST
  add constraint T285_FK_T282 foreign key (ID)
  references T282_MESSAGGI (ID) on delete cascade;

create index T282I_ID_ORIGINALE
  on T282_MESSAGGI (ID_ORIGINALE) 
  tablespace INDICI storage (initial 256K next 256K pctincrease 0);

---------------------------
-- INIZIO NUOVE REGOLE 770 per punto 493B - Dati riepilogativi - Clausola
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P602_770REGOLE t where t.Anno=2012;
  if i > 0 then
     DELETE P602_770REGOLE t WHERE t.Anno=2012 AND t.NUMERO IN('493B');

insert into P602_770REGOLE (anno, parte, numero, tipo_record, sezione_file, formato_file, parte_cud, numero_cud, descrizione, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, formato_annomese, numero_file, cod_arrotondamento_file)
values (2012, 'B', '493B', 'G', 'DB', 'AN', null, null, 'Dati riepilogativi - Clausola', 'N', null, null, 'S', null, null, 'N', null, 'N', 'B93', null);

  end if;
end;
/

UPDATE P602_770REGOLE t SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

---------------------------
-- FINE NUOVE REGOLE 770 per punto 493B - Dati riepilogativi - Clausola
---------------------------

---------------------------
-- INIZIO NUOVE REGOLE UNIEMENS per elemento AnnoMeseDecorrenzaContrib
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then
     DELETE P670_XMLREGOLE t WHERE t.NOME_FLUSSO='UNIEMENS' AND t.NUMERO IN('G022');

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-10-2012', 'dd-mm-yyyy'), 'G022', 'AnnoMeseDecorrenzaContrib', 'Decorrenza della contribuzione al fondo pensione', 'G005', 'D7', 'N', null, null, 'S', 'SELECT TO_CHAR(MIN(P254.DATA_INIZIO),''MM/YYYY'') DATO' || chr(10) || 'FROM P430_ANAGRAFICO P430, P254_VOCIPROGRAMMATE P254' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P254.PROGRESSIVO = P430.PROGRESSIVO' || chr(10) || 'AND RPAD(P254.COD_VOCE,6,'' '')||P254.COD_VOCE_SPECIALE IN (''10080 BASE'')' || chr(10) || 'AND P430.DATA_DOMANDA_FPC <= :DataElaborazione' || chr(10) || 'AND LAST_DAY(P430.DATA_DOMANDA_FPC) <= LAST_DAY(P254.DATA_INIZIO)' || chr(10) || 'AND :DataElaborazione <= LAST_DAY(P254.DATA_INIZIO)' || chr(10) || '', 'SELECT TO_CHAR(MIN(P254.DATA_INIZIO),''MM/YYYY'') DATO' || chr(10) || 'FROM P430_ANAGRAFICO P430, P254_VOCIPROGRAMMATE P254' || chr(10) || 'WHERE P430.PROGRESSIVO = :Progressivo AND :DataElaborazione BETWEEN P430.DECORRENZA AND P430.DECORRENZA_FINE' || chr(10) || 'AND P254.PROGRESSIVO = P430.PROGRESSIVO' || chr(10) || 'AND RPAD(P254.COD_VOCE,6,'' '')||P254.COD_VOCE_SPECIALE IN (''10080 BASE'')' || chr(10) || 'AND P430.DATA_DOMANDA_FPC <= :DataElaborazione' || chr(10) || 'AND LAST_DAY(P430.DATA_DOMANDA_FPC) <= LAST_DAY(P254.DATA_INIZIO)' || chr(10) || 'AND :DataElaborazione <= LAST_DAY(P254.DATA_INIZIO)' || chr(10) || '', 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

  end if;
end;
/

UPDATE P670_XMLREGOLE t SET T.REGOLA_CALCOLO_AUTOMATICA=T.REGOLA_CALCOLO_MANUALE;

---------------------------
-- FINE NUOVE REGOLE UNIEMENS per elemento AnnoMeseDecorrenzaContrib
---------------------------

comment on column T048_ATTESTATIINPS.ruolomedico
  is 'Ruolo del medico: S = SSN, P = Professionista privato';

