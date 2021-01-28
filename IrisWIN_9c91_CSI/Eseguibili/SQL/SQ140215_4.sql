-- Aggiungere un campo chiave per la testata flussi che preveda codice corso e edizione
alter table P662_FLUSSITESTATE add stringa_chiave varchar2(50);
comment on column P662_FLUSSITESTATE.stringa_chiave
  is 'Eventuali valori atti a mantenere univocita'''' della testata (usata nei corsi di formazione <cod_corso><edizione>)';

-- Aggiungere nuovo campo SPONSOR legato alla pianificazione del corso sul singolo partecipante
alter table SG651_PIANIFICAZIONECORSI add sponsor varchar2(100);
comment on column SG651_PIANIFICAZIONECORSI.sponsor
  is 'Identifica eventuali iniziative di finanziamento del corso per il partecipante separate dalla virgola quando sono piu'''' di una';

alter table M143_DETTAGLIOGG add TIPO varchar2(1) default 'S';
comment on column M143_DETTAGLIOGG.TIPO is 'Tipo di dettaglio: S=servizio attivo, V=ore viaggio';

alter table M043_DETTAGLIOGG add TIPO varchar2(1) default 'S';
comment on column M043_DETTAGLIOGG.TIPO is 'Tipo di dettaglio: S=servizio attivo, V=ore viaggio';

alter table M150_RICHIESTE_RIMBORSI add ID_RIMBORSO number(8) default 0 not null;

alter table M150_RICHIESTE_RIMBORSI drop constraint M150_PK;

drop index M150_PK /*--NOLOG--*/;

alter table M150_RICHIESTE_RIMBORSI
  add constraint M150_PK primary key (ID, INDENNITA_KM, CODICE, ID_RIMBORSO)
  using index tablespace INDICI storage (initial 256K next 1M minextents 1 maxextents unlimited);

insert into mondoedp.i091_datiente (AZIENDA,TIPO,DATO)
  select azienda,'C8_W032_RIMBORSIDETT','N' from mondoedp.i090_enti /*--NOLOG--*/;

delete from M051_DETTAGLIORIMBORSO M051 where not exists (select 'X' from M050_RIMBORSI where PROGRESSIVO = M051.PROGRESSIVO and MESESCARICO = M051.MESESCARICO and MESECOMPETENZA = M051.MESECOMPETENZA and DATADA = M051.DATADA and ORADA = M051.ORADA and CODICERIMBORSOSPESE = M051.CODICERIMBORSOSPESE);

alter table M051_DETTAGLIORIMBORSO
  add constraint M051_FK_M050 foreign key (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICERIMBORSOSPESE)
  references M050_RIMBORSI (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICERIMBORSOSPESE) on delete cascade;

