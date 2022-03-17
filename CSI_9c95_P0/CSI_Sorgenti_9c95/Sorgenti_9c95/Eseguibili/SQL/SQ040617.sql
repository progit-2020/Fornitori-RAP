UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.8' WHERE AZIENDA = :AZIENDA;

ALTER TABLE MONDOEDP.IA000_LOGINTEGRAZIONE MODIFY UTENTE VARCHAR2(50);

ALTER TABLE T305_CAUGIUSTIF ADD ASSEST_ANNUO VARCHAR2(11);

ALTER TABLE P254_VOCIPROGRAMMATE ADD IMPORTO_DETR NUMBER DEFAULT 0;

COMMENT ON COLUMN P254_VOCIPROGRAMMATE.IMPORTO_DETR IS
  'Importo da detrarre dall''importo totale';

ALTER TABLE T275_CAUPRESENZE ADD RESIDUO_LIQUIDABILE VARCHAR2(1) DEFAULT 'S';
ALTER TABLE T275_CAUPRESENZE ADD CAUS_FUORI_TURNO VARCHAR2(5);

ALTER TABLE T020_ORARI ADD ARR_ECCED_FASCE VARCHAR2(5);

ALTER TABLE T280_MESSAGGIWEB ADD TITOLO VARCHAR2(100);
ALTER TABLE T280_MESSAGGIWEB ADD FLAG VARCHAR2(1) DEFAULT '0';
COMMENT ON COLUMN T280_MESSAGGIWEB.FLAG IS  '0=Normale, 1=Importante';

RENAME T180_DATIBLOCCATI TO T180_20040722;
ALTER TABLE T180_20040722 DROP PRIMARY KEY;

-- Create table
create table T180_DATIBLOCCATI
(
  PROGRESSIVO NUMBER(8) not null,
  DAL        DATE not null,
  AL          DATE not null,
  RIEPILOGO   VARCHAR2(5) not null,
  STATO       VARCHAR2(1) default 'C' not null
)
tablespace LAVORO
  pctfree 10 pctused 60
  storage (initial 32K  next 1M minextents 1);

-- Add comments to the columns 
comment on column T180_DATIBLOCCATI.RIEPILOGO
  is 'T040=Giustificativi, T070=Scheda riepilogativa, T071A=Assestamento T071S=Straordinario, T074=Liquidazione presenze, T134=Liquidazione ore anni prec., T080=Pianificazione, T100=Timbrature, T340=Reperibilita, T410=Accessi mensa, T680=Buoni pasto, T690=Acquisto buoni, T762=Incentivi, T130=Residui saldi, T131=Residui presenze, T264=Residui assenze, T692=Residuo buoni';
comment on column T180_DATIBLOCCATI.STATO
  is 'C=Chiuso, A=Aperto';
-- Create/Recreate primary, unique and foreign key constraints 

alter table T180_DATIBLOCCATI
  add constraint T180_PK primary key (PROGRESSIVO,DAL,RIEPILOGO,STATO)
  using index 
  tablespace INDICI
  pctfree 10 
  storage (initial 32K next 1M minextents 1);

declare 
  cursor c1 is 
    select * from t180_20040722
    order by progressivo, riepilogo, data;
  dadata date;
  adata date;
  OldProg integer;
  OldRiep string(10);
begin
  OldProg:=0;
  OldRiep:='';
  adata:=trunc(sysdate);
  for t1 in c1 loop
    if (OldProg <> t1.progressivo or OldRiep <> t1.riepilogo or t1.data <> add_months(adata,1)) then
      if OldProg > 0 then
        insert into t180_datibloccati (progressivo,dal,al,riepilogo,stato)
        values (OldProg,dadata,adata,OldRiep,'C');
        commit;
      end if;
      OldProg:=t1.progressivo;
      OldRiep:=t1.riepilogo;
      dadata:=t1.data;
      adata:=t1.data;
    else
      adata:=t1.data;
    end if;  
  end loop;
  if OldProg > 0 then
    insert into t180_datibloccati (progressivo,dal,al,riepilogo,stato)
    values (OldProg,dadata,adata,OldRiep,'C');
    commit;
  end if;
end;
/

ALTER TABLE P200_VOCI ADD RETRIBUZIONE_CONTRATTUALE VARCHAR2(1) DEFAULT 'N' NOT NULL;
COMMENT ON COLUMN P200_VOCI.RETRIBUZIONE_CONTRATTUALE IS
  'La voce viene registrata nella gestione retribuzione contrattuale';

/*
Storico retribuzione contrattuale del dipendente
Integrità referenziali: T030_ANAGRAFICO
*/
CREATE TABLE P272_RETRIBUZIONE_CONTRATTUALE (
  PROGRESSIVO NUMBER,
  COD_CONTRATTO VARCHAR2(5),
  COD_VOCE VARCHAR2(5),
  COD_VOCE_SPECIALE VARCHAR2(5),
  DECORRENZA DATE,
  DECORRENZA_FINE DATE,
  IMPORTO NUMBER,
  IMPORTO_INTERO NUMBER,
  ORIGINE VARCHAR2(1) NOT NULL,
  STATO VARCHAR2(1) DEFAULT 'A' NOT NULL,
  CONSTRAINT P272_PK PRIMARY KEY (PROGRESSIVO,COD_CONTRATTO,COD_VOCE,COD_VOCE_SPECIALE,DECORRENZA)
  USING INDEX STORAGE (pctincrease 0 initial 16K next 512K)
  TABLESPACE INDICI pctfree 10
)
STORAGE (pctincrease 0 initial 16K next 512K)
TABLESPACE LAVORO pctfree 10 pctused 40;

COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.IMPORTO IS
  'Importo della voce gia'' ridotto per Part-time';
COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.IMPORTO_INTERO IS
  'Importo della voce prima della riduzione per Part-time';
COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.ORIGINE IS
  'Origine della voce: R=da Recupero dati, C=da Calcolo';
COMMENT ON COLUMN P272_RETRIBUZIONE_CONTRATTUALE.STATO IS
  'Stato della voce: A=Aggiornabile, B=Bloccata';

ALTER TABLE P272_RETRIBUZIONE_CONTRATTUALE ADD CONSTRAINT P272_FK_T030
  FOREIGN KEY (PROGRESSIVO) REFERENCES T030_ANAGRAFICO;

ALTER TABLE I071_PERMESSI ADD A094_MESE VARCHAR2(1) DEFAULT 'S';
ALTER TABLE I071_PERMESSI ADD A094_ANNO VARCHAR2(1) DEFAULT 'S';
ALTER TABLE I071_PERMESSI ADD A094_RAGGR VARCHAR2(1) DEFAULT 'S';

ALTER TABLE MONDOEDP.I100_PARSCARICO ADD AZIENDE VARCHAR2(150);
ALTER TABLE MONDOEDP.I101_TIMBIRREGOLARI ADD AZIENDE VARCHAR2(150);