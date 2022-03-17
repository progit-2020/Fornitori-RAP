UPDATE MONDOEDP.I090_ENTI SET VERSIONEDB = '5.5.7' WHERE AZIENDA = :AZIENDA;

ALTER TABLE T670_REGOLEBUONI MODIFY PRESENZA VARCHAR2(600);
ALTER TABLE T670_REGOLEBUONI MODIFY INIBMATURAZIONE VARCHAR2(600);
ALTER TABLE T670_REGOLEBUONI MODIFY FORZAMATURAZIONE VARCHAR2(600);

ALTER TABLE T090_PLUSORAINDIV ADD DESCRIZIONE VARCHAR2(40);

ALTER TABLE T248_PERMESSISINDACALI DROP CONSTRAINT T248_PK;

alter table T248_PERMESSISINDACALI
  add constraint T248_PK primary key (PROGRESSIVO,DATA,ABBATTE_COMPETENZE,COD_SINDACATO,COD_ORGANISMO,STATO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  ( initial 160K minextents 1);

create table SG656_RESIDUOCREDITI
(
  PROGRESSIVO NUMBER(8) not null,
  ANNO        NUMBER(4) not null,
  CREDITI     NUMBER(8)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255 
  noparallel
  storage
  (
    initial 64K
    minextents 1
  );
alter table SG656_RESIDUOCREDITI
  add constraint SG656_PK primary key (PROGRESSIVO,ANNO)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );

ALTER TABLE P430_ANAGRAFICO ADD PROFESSIONE_ONAOSI VARCHAR2(2);
COMMENT ON COLUMN P430_ANAGRAFICO.PROFESSIONE_ONAOSI IS
  'Professione ONAOSI: M=Medici, F=Farmacisti, V=Veterinari, O=Odontoiatri';
COMMENT ON COLUMN P430_ANAGRAFICO.TIPO_DIPENDENTE IS
  'Tipo dipendente: RU=Tempo indeterminato, IN=Tempo determinato, ER=Erede, BO=Borsista, CO=Co.Co.Co., PS=Parasubordinato, LU=L.S.U., LA=Lav.autonomo';

alter table SG508_STAMPAPIANTA modify FLAG_TOTALE default 'N';
alter table SG508_STAMPAPIANTA modify FLAG_PERCENTUALIZZAPT default 'N';
alter table SG508_STAMPAPIANTA add DETTAGLIO_DIPENDENTI varchar2(1) default 'N' not null;
alter table SG509_DETTAGLIOSTAMPA add FONT_STYLE varchar2(30);
alter table SG509_DETTAGLIOSTAMPA add FONT_NAME varchar2(30);
alter table SG509_DETTAGLIOSTAMPA add FONT_SIZE number(2);
alter table SG509_DETTAGLIOSTAMPA add FONT_COLOR number;
alter table SG509_DETTAGLIOSTAMPA add TABULAZIONE number default 0 not null;
alter table SG509_DETTAGLIOSTAMPA add FLAG_SALTOPAGINA varchar2(1) default 'N' not null;

alter table T265_CAUASSENZE add CQ_PROGRESSIVO varchar2(1) default 'N';
alter table T265_CAUASSENZE add CQ_FESTIVI varchar2(1) default 'N';
alter table T265_CAUASSENZE add CQ_GGNONLAV varchar2(1) default 'N';

COMMENT ON COLUMN T265_CAUASSENZE.UMCUMULO IS
  'In caso di TipoCumulo=Q indica i parametri di maturazione primi riposi: A=Domeniche da inizio anno M=Domeniche del mese In tutti gli altri casi indica l''unità di misura del cumulo: A=Anni M=Mesi';

COMMENT ON COLUMN T265_CAUASSENZE.CQ_PROGRESSIVO IS
  'In caso di TipoCumulo=Q, indica ai fini della maturazione dei primi riposi, indica la considerazione o meno della maturazione progressiva. Valori ammessi (S/N).';

COMMENT ON COLUMN T265_CAUASSENZE.CQ_FESTIVI IS
  'In caso di TipoCumulo=Q, ai fini della maturazione dei primi riposi, indica la considerazione o meno dei festivi infrasettimanali. Valori ammessi (S/N).';

COMMENT ON COLUMN T265_CAUASSENZE.CQ_GGNONLAV IS
  'In caso di TipoCumulo=Q, ai fini della maturazione dei primi riposi, indica la considerazione o meno dei giorni non lavorativi. Valori ammessi (S/N).';

alter table T020_ORARI add COPERTURA_CARENZA varchar2(1) default 'N';

alter table SG100_PROVVEDIMENTO DROP constraint SG100_PK;
update SG100_PROVVEDIMENTO set DATAREGISTR = DATADECOR where DATAREGISTR is null;
alter table SG100_PROVVEDIMENTO add constraint SG100_PK primary key (PROGRESSIVO,NOMECAMPO,DATADECOR,DATAREGISTR)
  using index 
  tablespace INDICI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
  );

create table T280_MESSAGGIWEB
(
  PROGRESSIVO NUMBER(8),
  DATA        DATE,
  MITTENTE    VARCHAR2(20),
  TESTO       VARCHAR2(2000)
)
tablespace LAVORO
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (initial 64K  minextents 1);

-- MISSIONI/TRASFERTE
alter table M030_TARIFFAORARIA add ORERIMBORSO2 varchar2(5);
alter table M030_TARIFFAORARIA add TARIFFARIMBORSO2 number;
comment on column M030_TARIFFAORARIA.ORERIMBORSO
  is 'Primo limite dopo cui scatta il rimborso pasto';
comment on column M030_TARIFFAORARIA.TARIFFARIMBORSO
  is 'Tariffa massima del rimborso pasto al supero del primo limite';
comment on column M030_TARIFFAORARIA.ORERIMBORSO2
  is 'Secondo limite dopo cui scatta il rimborso pasto';
comment on column M030_TARIFFAORARIA.TARIFFARIMBORSO2
  is 'Tariffa massima del rimborso pasto al supero del secondo limite';

alter table M010_PARAMETRICONTEGGIO add RIDUZIONE_PASTO varchar2(1) default 'N' not null;
alter table M010_PARAMETRICONTEGGIO add PERCRETRIBPASTO number;
comment on column M010_PARAMETRICONTEGGIO.RIDUZIONE_PASTO
  is 'Indica se applicare la riduzione dell''indennità al riconoscimento del rimborso pasto';
comment on column M010_PARAMETRICONTEGGIO.PERCRETRIBPASTO
  is 'Percentuale di retribuzione in caso di rimborso del pasto';

declare
  cursor c1 is
    select progoperatore,valore from t001_parametrifunzioni t
    where prog = 'A041' and nome = 'RIP1' and valore is not null;
  mat varchar2(1);
  matprog varchar2(1);
  fest varchar2(1);
  ggnonlav varchar2(1);
begin   
  for t1 in c1 loop
    begin
      select valore into mat from t001_parametrifunzioni where prog = 'A041' and progoperatore = t1.progoperatore and nome = 'MATURAZIONE';
    exception when others then mat:=null; end;
    begin
      select valore into matprog from t001_parametrifunzioni where prog = 'A041' and progoperatore = t1.progoperatore and nome = 'MATURAZPROG';
    exception when others then mat:=null; end;
    begin
      select valore into fest from t001_parametrifunzioni where prog = 'A041' and progoperatore = t1.progoperatore and nome = 'FESTIVISETTIMANALI';
    exception when others then mat:=null; end;
    begin
      select valore into ggnonlav from t001_parametrifunzioni where prog = 'A041' and progoperatore = t1.progoperatore and nome = 'GGNONLAVORATIVI';
    exception when others then mat:=null; end;
    update t265_cauassenze set
      tipocumulo = 'Q',
      umcumulo = decode(mat,'0','M','A'),
      cq_progressivo = matprog,
      cq_festivi = fest,
      cq_ggnonlav = ggnonlav
    where codice = t1.valore;
    
    update t260_raggrassenze set
      contasolare = 'N'
    where codice = (select codraggr from t265_cauassenze where codice = t1.valore);
  end loop;
  commit;
end;
/