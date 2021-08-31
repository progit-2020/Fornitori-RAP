alter table T380_PIANIFREPERIB ADD PRIORITA1 number(1);
comment on column T380_PIANIFREPERIB.PRIORITA1 is 'Priorita di chiamata per il turno 1';
alter table T380_PIANIFREPERIB ADD PRIORITA2 number(1);
comment on column T380_PIANIFREPERIB.PRIORITA2 is 'Priorita di chiamata per il turno 2';
alter table T380_PIANIFREPERIB ADD PRIORITA3 number(1);
comment on column T380_PIANIFREPERIB.PRIORITA3 is 'Priorita di chiamata per il turno 3';

alter table T390_CHIAMATE_REPERIB add DATA_TURNO date;
comment on column T390_CHIAMATE_REPERIB.DATA_TURNO is 'Data del turno pianificato per il dipendente';
alter table T390_CHIAMATE_REPERIB add TURNO varchar2(5);
comment on column T390_CHIAMATE_REPERIB.TURNO is 'Codice del turno pianificato per il dipendente';

insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO) select AZIENDA,'C29_CHIAMATEREP_FILTRO1' from MONDOEDP.I090_ENTI;
insert into MONDOEDP.I091_DATIENTE (AZIENDA,TIPO) select AZIENDA,'C29_CHIAMATEREP_FILTRO2' from MONDOEDP.I090_ENTI;

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      EXECUTE IMMEDIATE 'INSERT INTO I501INCARICO SELECT ''DR015-006-2010'',''Dirigente ruolo sanitario incarico lett. c) con struttura complessa (dec. 2010-2012)'' FROM DUAL WHERE NOT EXISTS (SELECT ''X'' FROM I501INCARICO T WHERE T.CODICE=''DR015-006-2010'')';
      EXECUTE IMMEDIATE 'INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI SELECT ''EDP'', ''INCARICO'', ''DR015-006-2010'', TO_DATE(''01012010'',''DDMMYYYY''),
        ''Dir. ruolo sanitario lett. c) con S.C. (dec. 2010-2012)'',
        ''00212'', ''BASE'', 663.55, ''SSSSSSSSSSSS'', TO_DATE(''31123999'',''DDMMYYYY''), ''''
           FROM DUAL WHERE NOT EXISTS
            (SELECT ''X'' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO=''EDP''
            AND T.NOME_VOCEAGGIUNTIVA=''INCARICO'' AND T.CODICE=''DR015-006-2010'')';

    end if;
  end if;
end;
/

-- Tolti i seguenti dati dalla visualizzazione del 730
comment on column P262_MOD730TESTATA.DATA_SOSP_IRPEF is 'Data sospensione IRPEF (non gestito)';
comment on column P262_MOD730TESTATA.DATA_SOSP_ADDIZ_REG is 'Data sosp.addiz.reg. (non gestito)';
comment on column P262_MOD730TESTATA.DATA_SOSP_ADDIZ_PROV is 'Data sosp.addiz.prov. (non gestito)';
comment on column P262_MOD730TESTATA.DATA_SOSP_ADDIZ_COM is 'Data sosp.addiz.com. (non gestito)';
comment on column P262_MOD730TESTATA.DATA_SOSP_TASS_SEP is 'Data sosp.tass.separata (non gestito)';

UPDATE t480_comuni t SET T.CITTA='DANTA DI CADORE' WHERE T.CODCATASTALE='D247';

-- Aggiunta la data di competenza su Contabilità
comment on column P590_CONTABREGOLE.DETTAGLIO_VOCI is 'Dettaglio voci individuale con competenza (S/N)';
ALTER TABLE P593_CONTABDATIINDIVIDUALI ADD DATA_COMPETENZA DATE;
comment on column P593_CONTABDATIINDIVIDUALI.DATA_COMPETENZA is 'Data competenza';
drop index P593_IDX;
create unique index P593_IDX on P593_CONTABDATIINDIVIDUALI (ID_CONTAB, PROGRESSIVO, CONTO, TIPO_RECORD, COD_CONTRATTO, COD_VOCE, COD_VOCE_SPECIALE, DATA_COMPETENZA)
  tablespace INDICI
  storage (initial 256K next 256K pctincrease 0);
  
alter table P430_ANAGRAFICO add PERC_DETRAZ_FAM_NUMEROSE VARCHAR2(1) default 'N';
comment on column P430_ANAGRAFICO.PERC_DETRAZ_FAM_NUMEROSE
  is 'Detrazione 100% famiglie numerose pur non avendo coniuge a carico (S/N)';

insert into p070_misurequantita
select 'NAZZD', 'Numero assistiti zone disagiatissime', 'QM' from dual
where not exists (select 'x' from p070_misurequantita t where t.cod_misuraquantita='NAZZD')
and exists (select 'x' from p070_misurequantita t where t.cod_misuraquantita='NAZOD');

declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ111223_5P042.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ111223_5P042.sql');
end/*--NOLOG--*/;
