UPDATE T020_ORARI SET PERLAV = 'L' WHERE PERLAV = ' ';

ALTER TABLE T020_ORARI ADD TIMBRATURAMENSA VARCHAR2(1);
UPDATE T020_ORARI SET TIMBRATURAMENSA  = 'N';

UPDATE T810_LIQUIDABILE SET CAMPO2 = '*' WHERE CAMPO2 = ' ';
UPDATE T811_RESIDUABILE SET CAMPO2 = '*' WHERE CAMPO2 = ' ';

ALTER TABLE T430_STORICO MODIFY PROGRESSIVO NUMBER(38);
ALTER TABLE T430_STORICO MODIFY BADGE NUMBER(38);

ALTER TABLE I070_OPERATORI ADD SBLOCCO VARCHAR2(1);
UPDATE I070_OPERATORI SET SBLOCCO = 'N';

ALTER TABLE T910_RIEPILOGO ADD CONTEGGIGIORNALIERI VARCHAR2(1);
ALTER TABLE T910_RIEPILOGO ADD DETTAGLIOGIORNALIERO VARCHAR2(1);
UPDATE T910_RIEPILOGO SET CONTEGGIGIORNALIERI = 'N';
UPDATE T910_RIEPILOGO SET DETTAGLIOGIORNALIERO = 'N';

ALTER TABLE T911_DATIRIEPILOGO ADD FORMATO VARCHAR2(40);