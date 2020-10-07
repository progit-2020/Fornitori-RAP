update MONDOEDP.I090_ENTI set VERSIONEDB = '9.1',PATCHDB = 0 where UTENTE = 
(select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table P030_VALUTE modify (DECORRENZA_FINE null)/*--NOLOG--*/;

insert into P050_KARROTONDAMENTI 
select cod_arrotondamento from p050_arrotondamenti minus
select cod_arrotondamento from p050_karrotondamenti;

alter table P050_ARROTONDAMENTI
  add constraint P050_FK_P050K foreign key (COD_ARROTONDAMENTO)
  references P050_KARROTONDAMENTI (COD_ARROTONDAMENTO);

DELETE M066_RIDUZIONI M066
 WHERE NOT EXISTS (SELECT 'X' 
                     FROM M065_TARIFFE_INDENNITA M065
                    WHERE M066.CODICE = M065.CODICE 
                      AND M066.COD_TARIFFA = M065.COD_TARIFFA 
                      AND M066.DECORRENZA = M065.DECORRENZA);
commit;

alter table m066_riduzioni
  add constraint M066_FK_M065 foreign key (codice,cod_tariffa,decorrenza )
  references m065_tariffe_indennita (codice,cod_tariffa,decorrenza) on delete cascade;

alter table m041_distanze modify chilometri default 0;
alter table m041_distanze modify tipo1 default 'C';
alter table m041_distanze modify tipo2 default 'C';

alter table T025_CONTMENSILI add CAUSALI_COMPENSABILI_MENSILI varchar2(100);
comment on column T025_CONTMENSILI.CAUSALI_COMPENSABILI_MENSILI is 
  'causali escluse dalle normali il cui riepilogo mensile può essere usato per compensare il saldo mensile negativo';
  
comment on column T025_CONTMENSILI.CAUSALI_COMPENSABILI is 
  'causali escluse dalle normali il cui riepilogo annuale può essere usato per compensare il saldo annuale negativo';

alter table MONDOEDP.I100_PARSCARICO add CHIAVE varchar2(8) default '0,0';
comment on column MONDOEDP.I100_PARSCARICO.CHIAVE is 'Posizione e lunghezza del dato alternativo al badge per associare la timbratura al dipendente';

alter table MONDOEDP.I100_PARSCARICO add EXPR_CHIAVE varchar2(2000);
comment on column MONDOEDP.I100_PARSCARICO.EXPR_CHIAVE is 'Espressione SQL da applicare al campo chiave per determinare il progressivo del dipendente. Accetta le variabili :CHIAVE e :DATA';

alter table MONDOEDP.I101_TIMBIRREGOLARI add CHIAVE varchar2(20);
comment on column MONDOEDP.I101_TIMBIRREGOLARI.CHIAVE is 'Valore della chiave alternativa al badge';

alter table M025_MOTIVAZIONI add ORDINE number(4);
comment on column M025_MOTIVAZIONI.ORDINE is 'Ordine di visualizzazione del dato, all''interno della categoria';

alter table M025_MOTIVAZIONI add VALORI varchar2(2000);
comment on column M025_MOTIVAZIONI.VALORI is 'Se nullo, il dato sarà libero. Altrimenti indicare un elenco di valori separato da virgola che sarà visualizzato come menu a tendina';

alter table M025_MOTIVAZIONI add OBBLIGATORIO varchar2(1) default 'N';
comment on column M025_MOTIVAZIONI.OBBLIGATORIO is 'S=indicazione del dato obbligatoria,N=indicazione del dato facoltativa';

alter table M025_MOTIVAZIONI add RIGHE number(1) default 1;
comment on column M025_MOTIVAZIONI.RIGHE is 'Numero di righe per il dato libero. Se VALORI è null, può valere da 1 a 4. Altrimenti è impostato fisso a 1';

-- ordine di default
update M025_MOTIVAZIONI
set    ORDINE = decode(CODICE,
                       'TECEC',1,
                       'VABEN',2,
                       'COOPP',3,
                       'ATTPR',1,
                       'INTRG',2,
                       'RAPRC',3,
                       'STINF',4,
                       'VISCO',5,
                       0)
where  ORDINE is null;
commit;                       

-- nuovi elementi
insert into M025_MOTIVAZIONI (CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATORIO, RIGHE)
values ('MOTIV','Motivazioni','DET01',1,null,'S',3);
insert into M025_MOTIVAZIONI (CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATORIO, RIGHE)
values ('PRGEU','Progetto europeo','DET01',2,null,'N',3);

declare
begin
  if :AZIENDA in ('RAVDA','ZZVDA') then
    insert into M025_MOTIVAZIONI (CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATORIO, RIGHE)
    values ('FORMA','Formazione','DET01',3,null,'S',1);

    insert into M025_MOTIVAZIONI (CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATORIO, RIGHE)
    values ('CLASS','Classificazione','DET01',4,'Operatori dei servizi sociali,Vigili del fuoco e Corpo forestale','N',1);
    insert into M025_MOTIVAZIONI (CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATORIO, RIGHE)
    values ('TITCO','Titolo del corso','DET01',5,null,'N',2);
    insert into M025_MOTIVAZIONI (CODICE, DESCRIZIONE, CATEGORIA, ORDINE, VALORI, OBBLIGATORIO, RIGHE)
    values ('AGENZ','Agenzia','DET01',6,null,'N',1);
  end if;
end;
/

alter table M175_RICHIESTE_MOTIVAZIONI add VALORE varchar2(2000);
comment on column M175_RICHIESTE_MOTIVAZIONI.VALORE is 'Valore associato al dato libero';

create table AGG_91_M140 as select * from M140_RICHIESTE_MISSIONI;

declare
  cursor c1 is
    select ID, MOTIVAZIONI, PROGETTO_EUROPEO
    from   M140_RICHIESTE_MISSIONI;
begin
  for t1 in c1 loop
    -- motivazioni
    insert into M175_RICHIESTE_MOTIVAZIONI (ID, CODICE, VALORE)
    values (t1.ID, 'MOTIV', t1.MOTIVAZIONI);                      
    -- progetto europeo
    insert into M175_RICHIESTE_MOTIVAZIONI (ID, CODICE, VALORE)
    values (t1.ID, 'PRGEU', t1.PROGETTO_EUROPEO);
    commit;
  end loop;
exception
  when others then
    null;
end;
/         

-- se tutto ok tenta di droppare le colonne obsolete
comment on column M140_RICHIESTE_MISSIONI.MOTIVAZIONI is 'Obsoleto'/*--NOLOG--*/;
alter table M140_RICHIESTE_MISSIONI drop column MOTIVAZIONI/*--NOLOG--*/;
  
comment on column M140_RICHIESTE_MISSIONI.PROGETTO_EUROPEO is 'Obsoleto'/*--NOLOG--*/;
alter table M140_RICHIESTE_MISSIONI drop column PROGETTO_EUROPEO/*--NOLOG--*/;

drop table M012_DECOD_TIPIMISSIONE/*--NOLOG--*/;

alter table M011_TIPOMISSIONE add CONTENIMENTO varchar2(1);
comment on column M011_TIPOMISSIONE.CONTENIMENTO is 'S = missione soggetta a contenimento, N = missione non soggetta a contenimento';

-- Aggiornamento codice Istat di VIBO VALENTIA: inserimento nuovo codice 102047; update sulle tabelle e cancellazione vecchio codice 099733
INSERT INTO T480_COMUNI (CODICE, CITTA, CAP, PROVINCIA, CODCATASTALE) SELECT '102047','VIBO VALENTIA','89900','VV','F537' FROM DUAL WHERE '102047' NOT IN (SELECT CODICE FROM T480_COMUNI);
update P010_BANCHE set COD_COMUNE = '102047' where COD_COMUNE = '099733';
update P012_BENEFICIARI set COMUNE = '102047' where COMUNE = '099733';
update P430_ANAGRAFICO set COD_COMUNE_IRPEF = '102047' where COD_COMUNE_IRPEF = '099733';
update SG101_FAMILIARI set COMUNE = '102047' where COMUNE = '099733';
update SG101_FAMILIARI set COMNAS = '102047' where COMNAS = '099733';
update T030_ANAGRAFICO set COMUNENAS = '102047' where COMUNENAS = '099733';
update T047_VISITEFISCALI set COD_COMUNE = '102047' where COD_COMUNE = '099733';
update T241_RECAPITISINDACATI set COMUNE = '102047' where COMUNE = '099733';
update T430_STORICO set COMUNE = '102047' where COMUNE = '099733';
update T485_MEDICINELEGALI set COD_COMUNE = '102047' where COD_COMUNE = '099733';
update T486_COMUNI_MEDLEGALI set COD_COMUNE = '102047' where COD_COMUNE = '099733';
DELETE T480_COMUNI WHERE CODICE = '099733';

alter table T670_REGOLEBUONI add RIENTRO_MASSIMO_PM varchar2(5);
comment on column T670_REGOLEBUONI.RIENTRO_MASSIMO_PM is 'Ora di rientro dalla PM oltre la quale non si matura il buono';

alter table T275_CAUPRESENZE add CAUSCOMP_DEBITOGG varchar2(5);
comment on column T275_CAUPRESENZE.CAUSCOMP_DEBITOGG is 'T275.CODICE di una causale inclusa nelle ore normali, su cui riepilogare le ore rese con la causale corrente che mancano per ragiungere il debito gg';

alter table MONDOEDP.I090_ENTI add LOGIN_USR_ABILITATO varchar2(1) default 'N';
comment on column MONDOEDP.I090_ENTI.LOGIN_USR_ABILITATO is 'S=Il riconoscimento automatico dell''azienda considera gli operatori di I070 dell''azienda corrente, N=Il riconoscimento automatico dell''azienda non considera gli operatori di I070 dell''azienda corrente';
alter table MONDOEDP.I090_ENTI add LOGIN_DIP_ABILITATO varchar2(1) default 'N';
comment on column MONDOEDP.I090_ENTI.LOGIN_DIP_ABILITATO is 'S=Il riconoscimento automatico dell''azienda considera i dipendenti di I060 dell''azienda corrente, N=Il riconoscimento automatico dell''azienda non considera i dipendenti di I060 dell''azienda corrente';

update MONDOEDP.I073_FILTROFUNZIONI 
set TAG = decode(TAG,
                  21 ,595,
                  152,520,
                  153,517,
                  154,519,
                  158,514,
                  161,530,
                  181,572,
                  182,574,
                  183,571,
                  184,582,
                  185,583,
                  186,580,
                  187,584,
                  188,518,
                  200,543,
                 TAG)
where APPLICAZIONE in ('RILPRE','STAGIU')
and TAG in (21,152,153,154,158,161,181,182,183,184,185,186,187,188,200)
and :AZIENDA = 'AZIN';


-- Pulizia descrizione dei Comuni
CREATE TABLE AGG_91_T480 AS SELECT * FROM T480_COMUNI;
UPDATE T480_COMUNI SET CITTA = LTRIM(RTRIM(CITTA));

