ALTER TABLE T460_PARTTIME ADD INDPRES NUMBER;
ALTER TABLE T361_OROLOGI ADD CAUSMENSA VARCHAR2(5);
ALTER TABLE T020_ORARI ADD TUTTOCOMP VARCHAR2(1);
UPDATE T020_ORARI SET TUTTOCOMP = 'N';
ALTER TABLE T275_CAUPRESENZE ADD PIANIFREP VARCHAR2(1);
UPDATE T275_CAUPRESENZE SET PIANIFREP = 'N';

ALTER TABLE T025_CONTMENSILI ADD COMPPREC NUMBER(1);
ALTER TABLE T025_CONTMENSILI ADD LIQPREC NUMBER(1);
ALTER TABLE T025_CONTMENSILI ADD COMPATT NUMBER(1);
ALTER TABLE T025_CONTMENSILI ADD LIQATT NUMBER(1);
UPDATE T025_CONTMENSILI SET COMPPREC = 1,LIQPREC = 2,COMPATT = 3,LIQATT = 4
  WHERE CONTEGGIO = 4;
