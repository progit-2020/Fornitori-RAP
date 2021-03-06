ALTER TABLE T760_REGOLEINCENTIVI ADD FILE_ISTRUZIONI VARCHAR2(100);
comment on column T760_REGOLEINCENTIVI.FILE_ISTRUZIONI is 'Nome del file delle istruzioni';

ALTER TABLE T768_INCQUANTINDIVIDUALI ADD DATO1 VARCHAR2(20);
ALTER TABLE T768_INCQUANTINDIVIDUALI ADD DATO2 VARCHAR2(20);
ALTER TABLE T768_INCQUANTINDIVIDUALI ADD DATO3 VARCHAR2(20);
ALTER TABLE T768_INCQUANTINDIVIDUALI DROP COLUMN COD_PROFILO;
ALTER TABLE T768_INCQUANTINDIVIDUALI DROP COLUMN DESC_PROFILO;
ALTER TABLE T768_INCQUANTINDIVIDUALI ADD TOTQUOTAQUAL NUMBER;
comment on column T768_INCQUANTINDIVIDUALI.TOTQUOTAQUAL is 'Importo totale (acconto+saldo) della quota qualitativa proporzionata di riferimento';
ALTER TABLE T768_INCQUANTINDIVIDUALI ADD INF_OBIETTIVI VARCHAR2(1) DEFAULT 'S';
comment on column T768_INCQUANTINDIVIDUALI.INF_OBIETTIVI is 'Informato su obiettivi (Si, No)';
ALTER TABLE T768_INCQUANTINDIVIDUALI ADD ACCETT_VALUTAZIONE VARCHAR2(1) DEFAULT 'S';
comment on column T768_INCQUANTINDIVIDUALI.ACCETT_VALUTAZIONE is 'Accetto valutazione (Si, No)';
ALTER TABLE T768_INCQUANTINDIVIDUALI ADD PROG_VALUTATORE NUMBER;
comment on column T768_INCQUANTINDIVIDUALI.PROG_VALUTATORE is 'Progressivo del valutatore';

ALTER TABLE T767_INCQUANTGRUPPO ADD SUPERVISIONE VARCHAR2(1) DEFAULT 'N';
comment on column T767_INCQUANTGRUPPO.SUPERVISIONE is 'Supervisione (Si, No)';
ALTER TABLE T767_INCQUANTGRUPPO ADD PROG_SUPERVISORE NUMBER;
comment on column T767_INCQUANTGRUPPO.PROG_SUPERVISORE is 'Progressivo del supervisore';

UPDATE SG101_FAMILIARI SG101
SET COGNOME = UPPER(COGNOME),
    NOME = UPPER(NOME)
WHERE EXISTS (SELECT 1 
              FROM SG120_FAMILIARIDIPGEN SG120
              WHERE SG120.PROGRESSIVO = SG101.PROGRESSIVO
              AND CONFERMA = 'S'
              AND EXISTS (SELECT 1
                          FROM SG122_FAMILIARIDIPDET SG122
                          WHERE SG122.PROGRESSIVO = SG120.PROGRESSIVO
                          AND SG122.DATA_AGG = SG120.DATA_AGG
                          AND SG122.NUMORD = SG101.NUMORD));

alter table P552_CONTOANNREGOLE modify VALORE_COSTANTE VARCHAR2(500);

alter table T691_MAGAZZINOBUONI add ID_DAL number(12);
alter table T691_MAGAZZINOBUONI add ID_AL number(12);
alter table T691_MAGAZZINOBUONI add DIM_BLOCCHETTO number(4);
comment on column T691_MAGAZZINOBUONI.ID_DAL is 'id del primo blocchetto';
comment on column T691_MAGAZZINOBUONI.ID_AL is 'id dell''ultimo blocchetto';
comment on column T691_MAGAZZINOBUONI.DIM_BLOCCHETTO is 'numero di buoni per ogni blocchetto';

alter table T690_ACQUISTOBUONI add ID_BLOCCHETTI varchar2(100);
comment on column T690_ACQUISTOBUONI.ID_BLOCCHETTI is 'elenco degli id dei buoni acquistati';
