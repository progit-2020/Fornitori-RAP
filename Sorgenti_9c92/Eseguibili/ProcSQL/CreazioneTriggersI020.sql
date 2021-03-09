-- TRIGGER RELAZIONI
CREATE OR REPLACE TRIGGER I035_AFTINSDEL
  after delete or insert on I035_RELAZIONI_DETTAGLIO
  for each row
declare
  w_tabella  VARCHAR2(30) :='';
  w_colonna  VARCHAR2(30) :='';
  n_trov number :=0;
begin
  if deleting then
    w_tabella:=:old.tabella;
    w_colonna:=:old.colonna;
  elsif inserting then
    w_tabella:=:new.tabella;
    w_colonna:=:new.colonna;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'R'
  and   tabella = w_tabella
  and   colonna = w_colonna;
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('R',
     w_tabella,
     w_colonna,
     NULL);
  end if;
end I035_AFTINSDEL;
/

-- TRIGGER PROFILO ORARIO
CREATE OR REPLACE TRIGGER T220_AFTINSDEL
  after delete or insert on T220_PROFILIORARI
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.codice;
  elsif inserting then
    w_codice:=:new.codice;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'T430_STORICO'
  and   colonna = 'PORARIO'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'T430_STORICO',
     'PORARIO',
     w_codice);
   end if;
end T220_AFTINSDEL;
/

-- TRIGGER QUALIFICA MINISTERIALE
CREATE OR REPLACE TRIGGER T470_AFTINSDEL
  after delete or insert on T470_QUALIFICAMINIST
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.codice;
  elsif inserting then
    w_codice:=:new.codice;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'T430_STORICO'
  and   colonna = 'QUALIFICAMINIST'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'T430_STORICO',
     'QUALIFICAMINIST',
     w_codice);
   end if;
end T470_AFTINSDEL;
/

-- TRIGGER CODICI VALUTA
CREATE OR REPLACE TRIGGER P030_AFTINSDEL
  after delete or insert on P030_VALUTE
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_valuta;
  elsif inserting then
    w_codice:=:new.cod_valuta;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_VALUTA_STAMPA'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_VALUTA_STAMPA',
     w_codice);
   end if;
end P030_AFTINSDEL;
/

-- TRIGGER CODICI INPS
CREATE OR REPLACE TRIGGER P090_AFTINSDEL
  after delete or insert on P090_CODICIINPS
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_codiceinps;
  elsif inserting then
    w_codice:=:new.cod_codiceinps;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_CODICEINPS'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_CODICEINPS',
     w_codice);
   end if;
end P090_AFTINSDEL;
/

-- TRIGGER CODICI INAIL
CREATE OR REPLACE TRIGGER P092_AFTINSDEL
  after delete or insert on P092_CODICIINAIL
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_codiceinail;
  elsif inserting then
    w_codice:=:new.cod_codiceinail;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_CODICEINAIL'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_CODICEINAIL',
     w_codice);
   end if;
end P092_AFTINSDEL;
/

-- TRIGGER CODICI INQUADRAMENTO INPDAP
CREATE OR REPLACE TRIGGER P094_AFTINSDEL
  after delete or insert on P094_INQUADRINPDAP
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_inquadrinpdap;
  elsif inserting then
    w_codice:=:new.cod_inquadrinpdap;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_INQUADRINPDAP'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_INQUADRINPDAP',
     w_codice);
   end if;
end P094_AFTINSDEL;
/

-- TRIGGER CODICI INQUADRAMENTO INPS
CREATE OR REPLACE TRIGGER P096_AFTINSDEL
  after delete or insert on P096_INQUADRINPS
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_inquadrinps;
  elsif inserting then
    w_codice:=:new.cod_inquadrinps;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_INQUADRINPS'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_INQUADRINPS',
     w_codice);
   end if;
end P096_AFTINSDEL;
/

-- TRIGGER CODICI PARAMETRI STIPENDI
CREATE OR REPLACE TRIGGER P212_AFTINSDEL
  after delete or insert on P212_PARAMETRISTIPENDI
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_parametristipendi;
  elsif inserting then
    w_codice:=:new.cod_parametristipendi;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_PARAMETRISTIPENDI'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_PARAMETRISTIPENDI',
     w_codice);
   end if;
end P212_AFTINSDEL;
/

-- TRIGGER CODICI TABELLE ANF
CREATE OR REPLACE TRIGGER P236_AFTINSDEL
  after delete or insert on P236_TABELLEANF
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_tabellaanf;
  elsif inserting then
    w_codice:=:new.cod_tabellaanf;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_TABELLAANF'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_TABELLAANF',
     w_codice);
   end if;
end P236_AFTINSDEL;
/

-- TRIGGER CODICI LIVELLI
CREATE OR REPLACE TRIGGER P220_AFTINSDEL
  after delete or insert on P220_LIVELLI
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_posizione_economica||'-'||:old.cod_contratto;
  elsif inserting then
    w_codice:=:new.cod_posizione_economica||'-'||:new.cod_contratto;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_POSIZIONE_ECONOMICA||''-''||P430.COD_CONTRATTO'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_POSIZIONE_ECONOMICA||''-''||P430.COD_CONTRATTO',
     w_codice);
   end if;
end P220_AFTINSDEL;
/

-- TRIGGER CODICI TIPI ASSOGGETTAMENTI
CREATE OR REPLACE TRIGGER P240_AFTINSDEL
  after delete or insert on P240_TIPIASSOGGETTAMENTI
  for each row
declare
  w_codice VARCHAR2(100) :='';
  n_trov NUMBER :=0;
begin
  if deleting then
    w_codice:=:old.cod_tipoassoggettamento||'-'||:old.cod_contratto;
  elsif inserting then
    w_codice:=:new.cod_tipoassoggettamento||'-'||:new.cod_contratto;
  end if;
  select count(*)
  into  n_trov
  from  i020_dati_allineamento
  where tipo = 'D'
  and   tabella = 'P430_ANAGRAFICO'
  and   colonna = 'COD_TIPOASSOGGETTAMENTO||''-''||P430.COD_CONTRATTO'
  and   NVL(valore,'#NULL#') = NVL(w_codice,'#NULL#');
  if n_trov = 0 then
    insert into i020_dati_allineamento
    (tipo,
     tabella,
     colonna,
     valore)
    values
    ('D',
     'P430_ANAGRAFICO',
     'COD_TIPOASSOGGETTAMENTO||''-''||P430.COD_CONTRATTO',
     w_codice);
   end if;
end P240_AFTINSDEL;
/

DECLARE
  CURSOR CI500 IS
    SELECT NOMECAMPO
    FROM   I500_DATILIBERI
    WHERE  TABELLA = 'S'
    AND    STORICO = 'S';
  CURSORE_DINAMICO_CREA_TRG    INTEGER;
  CURS_CREA_TRG                INTEGER;
  ESPRESSIONE VARCHAR2(4000);
  ESISTE_TABELLA VARCHAR2(1);
  NEXT_RECORD EXCEPTION;
BEGIN
  FOR RI500 IN CI500 LOOP
  BEGIN
    BEGIN
      SELECT 'S'
      INTO  ESISTE_TABELLA
      FROM  TABS
      WHERE TABLE_NAME = 'I501' || RI500.NOMECAMPO;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ESISTE_TABELLA:='N';
        RAISE NEXT_RECORD;
    END;
    ESPRESSIONE:=
'CREATE OR REPLACE TRIGGER I501' || RI500.NOMECAMPO || '_AFTINSDEL' ||'
  AFTER DELETE OR INSERT ON I501' || RI500.NOMECAMPO || '
  FOR EACH ROW
DECLARE
  W_CODICE varchar2(100) :='''';
  N_TROV number :=0;
BEGIN
  IF DELETING THEN
    W_CODICE:=:OLD.CODICE;
  ELSIF INSERTING THEN
    W_CODICE:=:NEW.CODICE;
  END IF;
  SELECT COUNT(*)
  INTO  N_TROV
  FROM  I020_DATI_ALLINEAMENTO
  WHERE TIPO = ''D''
  AND   TABELLA = ''T430_STORICO''
  AND   COLONNA = ''' || RI500.NOMECAMPO || '''
  AND   NVL(VALORE,''#NULL#'') = NVL(W_CODICE,''#NULL#'');
  IF N_TROV = 0 THEN
    INSERT INTO I020_DATI_ALLINEAMENTO
    (TIPO,
     TABELLA,
     COLONNA,
     VALORE)
    VALUES
    (''D'',
     ''T430_STORICO'',
     ''' || RI500.NOMECAMPO || ''',
     W_CODICE);
   END IF;
END I501' || RI500.NOMECAMPO || '_AFTINSDEL' ||';';
    CURSORE_DINAMICO_CREA_TRG:=DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CURSORE_DINAMICO_CREA_TRG,ESPRESSIONE,DBMS_SQL.NATIVE);
    CURS_CREA_TRG:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_CREA_TRG);
    DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_CREA_TRG);
  EXCEPTION
    WHEN NEXT_RECORD THEN
      NULL;
  END;
  END LOOP;
END;
/
