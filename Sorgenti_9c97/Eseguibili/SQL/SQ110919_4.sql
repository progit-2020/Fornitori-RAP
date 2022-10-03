create index T430I_PDF on T430_STORICO (PROGRESSIVO,DATADECORRENZA,DATAFINE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index T470I_CDF on T470_QUALIFICAMINIST(CODICE,DECORRENZA,DECORRENZA_FINE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index T220I_DCF on T220_PROFILIORARI(CODICE,DECORRENZA,DECORRENZA_FINE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index P240I_DCF on P240_TIPIASSOGGETTAMENTI(COD_TIPOASSOGGETTAMENTO,COD_CONTRATTO,DECORRENZA,DECORRENZA_FINE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index P430I_PDF on p430_anagrafico (PROGRESSIVO,DECORRENZA,DECORRENZA_FINE) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
create index T850I_ITER_STATO on T850_ITER_RICHIESTE(ITER,STATO) tablespace INDICI storage (initial 256K next 256K pctincrease 0);
drop index i020_nome;
drop index t030_anagrafico0;
create index T030I_COGNOME on T030_ANAGRAFICO (COGNOME) tablespace indici storage (initial 256K next 256K pctincrease 0);
create index T030I_MATRICOLA on T030_ANAGRAFICO (MATRICOLA) tablespace indici storage (initial 256K next 256K pctincrease 0);
create bitmap index T030I_TIPO_PERSONALE on T030_ANAGRAFICO (TIPO_PERSONALE) tablespace indici storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;
create index T030I_TIPO_PERSONALE on T030_ANAGRAFICO (TIPO_PERSONALE) tablespace indici storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;

declare
cursor c1 is
  select 'create index '||substr('I501'||NOMECAMPO,1,26)||'_CDF on I501'||NOMECAMPO||' (CODICE,DECORRENZA,DECORRENZA_FINE) tablespace INDICI storage (initial 64K next 64K pctincrease 0)' cmd
  from I500_DATILIBERI where TABELLA = 'S' and STORICO = 'S' order by nomecampo;
begin
  for t1 in c1 loop
    execute immediate(t1.cmd);
  end loop;
end;
/