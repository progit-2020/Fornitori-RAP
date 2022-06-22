
UPDATE t480_comuni t SET T.CITTA='FARINI' WHERE T.CODCATASTALE='D502';

UPDATE p004_codicitabannuali t SET T.DESCRIZIONE=REPLACE(T.DESCRIZIONE,'nel 2010','nel 2011')
WHERE T.ANNO=2011 AND T.COD_TABANNUALE='770CAUSPAG' AND T.COD_CODICITABANNUALI='W';

-- Creazione interrogazione di servizio PA_Arrotondamenti_Sospesi
declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from t002_querypersonalizzate t where t.nome = 'PA_Arrotondamenti_Sospesi';
    if i = 0 then
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',-4,'CHKINTESTAZIONE(N)CHKNORITORNOACAPO(N)','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',0,'SELECT T030.MATRICOLA, T030.COGNOME, T030.NOME, T430.FINE,','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',1,'      P441.DATA_CEDOLINO, P442.COD_VOCE, ''Arrotondamento'' DESCRIZIONE, P442.IMPORTO ','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',2,'FROM  T030_ANAGRAFICO T030, T430_STORICO T430, P441_CEDOLINO P441, P442_CEDOLINOVOCI P442','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',3,'WHERE T030.PROGRESSIVO = T430.PROGRESSIVO','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',4,'  AND T030.PROGRESSIVO = P441.PROGRESSIVO','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',5,'  AND P441.ID_CEDOLINO = P442.ID_CEDOLINO','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',6,'  AND P441.DATA_CEDOLINO = (SELECT MAX(DATA_CEDOLINO) FROM P441_CEDOLINO','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',7,'                             WHERE PROGRESSIVO = P441.PROGRESSIVO','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',8,'                               AND P441.CHIUSO = ''S'')','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',9,'  AND SYSDATE BETWEEN T430.DATADECORRENZA AND T430.DATAFINE','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',10,'  AND P441.CHIUSO = ''S''','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',11,'  AND P442.TIPO_RECORD = ''M''','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',12,'  AND P442.COD_CONTRATTO = ''EDP''','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',13,'  AND P442.COD_VOCE = ''04990''','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',14,'  AND P442.COD_VOCE_SPECIALE = ''BASE''','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',15,'  AND P442.IMPORTO > 1','PAGHE');
      insert into T002_QUERYPERSONALIZZATE (NOME, POSIZ, RIGA, APPLICAZIONE) values ('PA_Arrotondamenti_Sospesi',16,'ORDER BY IMPORTO DESC, COGNOME, NOME','PAGHE');
    end if;
  end if;
end;
/

comment on column SG101_FAMILIARI.GRADOPAR
  is 'Grado parentela: CG=Coniuge, FG=Figlio/Figlia, GT=Genitore, FR=Fratello/Sorella, NP=Nipote, NF=Nipote equiparato Figlio, AL=Altro';

delete p216_accorpamentovoci t where t.cod_tipoaccorpamentovoci='CU770'
and t.cod_codiciaccorpamentovoci in ('Solid_Redd','Solid_Oneri');

delete p215_codiciaccorpamentovoci t where t.cod_tipoaccorpamentovoci='CU770'
and t.cod_codiciaccorpamentovoci in ('Solid_Redd','Solid_Oneri');

-- Variazione codici tributo F24EP per interessi ritardo trattenute da 730
update p200_voci t set t.cod_causaleirpef='F24134E' 
where t.cod_contratto in ('EDP','EDPSC') and t.cod_voce in ('11802','11807');

update p200_voci t set t.cod_causaleirpef='F24133E' 
where t.cod_contratto in ('EDP','EDPSC') and t.cod_voce in ('11812','11817','11822','11827');

update p200_voci t set t.cod_causaleirpef='F24143E' 
where t.cod_contratto in ('EDP','EDPSC') and t.cod_voce in ('11842','11847');

update p200_voci t set t.cod_causaleirpef='F24127E' 
where t.cod_contratto in ('EDP','EDPSC') and t.cod_voce in ('11852','11857');

update p200_voci t set t.cod_causaleirpef='F24129E' 
where t.cod_contratto in ('EDP','EDPSC') and t.cod_voce in ('11867','11884');

update p200_voci t set t.cod_causaleirpef='F24126E' 
where t.cod_contratto in ('EDP','EDPSC') and t.cod_voce in ('11873','11888');

update p200_voci t set t.cod_causaleirpef='F24128E' 
where t.cod_contratto in ('EDP','EDPSC') and t.cod_voce in ('11877','11892');

alter table T020_ORARI add ARRSCOSTR_SOTTOSOGLIA varchar2(5);
comment on column T020_ORARI.ARRSCOSTR_SOTTOSOGLIA is 'arrotondamento applicato all''eccedenza sotto la soglia, se mantenuta nel compensabile';