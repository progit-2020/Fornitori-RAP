update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 6 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

create table MONDOEDP.AGG_9C95_I073_TAG114_167 as select * from MONDOEDP.I073_FILTROFUNZIONI where TAG in (114,167)/*--NOLOG--*/;
update MONDOEDP.I073_FILTROFUNZIONI set FUNZIONE = 'OpenA005DatiLiberi' where TAG = 114;

delete from MONDOEDP.I073_FILTROFUNZIONI where TAG = 167 and nvl(FUNZIONE,'nvl') <> 'OpenA115IterAutorizzativi';
insert into MONDOEDP.I073_FILTROFUNZIONI (AZIENDA, PROFILO, APPLICAZIONE, TAG, FUNZIONE, GRUPPO, DESCRIZIONE, INIBIZIONE)
  select AZIENDA, PROFILO, APPLICAZIONE, 167, 'OpenA115IterAutorizzativi', 'Interfacce/IrisWeb', 'Iter autorizzativi', INIBIZIONE from MONDOEDP.I073_FILTROFUNZIONI where TAG = 84
  and (AZIENDA, PROFILO, APPLICAZIONE, 167) not in (select AZIENDA, PROFILO, APPLICAZIONE, TAG from MONDOEDP.I073_FILTROFUNZIONI);
  
alter table M020_TIPIRIMBORSI add FLAG_NON_RIMBORSABILE varchar2(1) default 'N';
comment on column M020_TIPIRIMBORSI.FLAG_NON_RIMBORSABILE is 'S=l''importo corrispondente viene conteggiato solo ai fini del costo della missione ma non partecipa ai rimborsi';
