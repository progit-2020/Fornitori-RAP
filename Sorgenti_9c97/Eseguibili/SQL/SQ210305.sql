update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 2 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T850_ITER_RICHIESTE add CONDIZ_ALLEGATI VARCHAR2(1) default 'N';
comment on column T850_ITER_RICHIESTE.condiz_allegati is 'null/N=allegati non previsti, F=allegati facoltativi, O=allegati obbligatori';
	
alter table T960_DOCUMENTI_INFO add cf_familiare VARCHAR2(16);
comment on column T960_DOCUMENTI_INFO.cf_familiare is 'Codice fiscale familiare a cui si riferisce il documento (SG101.CODFISCALE)';

alter table T960_DOCUMENTI_INFO add path_storage VARCHAR2(1000) default 'DB';
comment on column T960_DOCUMENTI_INFO.path_storage is 'Path su cui è registrato il file. DB=registrato su tabella di database T961';
  
alter table T960_DOCUMENTI_INFO add provenienza VARCHAR2(1) default 'I';
comment on column T960_DOCUMENTI_INFO.provenienza is 'I=interna: il file è registrato col nome = ID, E=esterna: il file è registrato col nome = NOME_FILE.EXT_FILE';

alter table T960_DOCUMENTI_INFO add hash VARCHAR2(100);
comment on column T960_DOCUMENTI_INFO.hash is 'Hash codificato come stringa Base64 del documento caricato in T961';

alter table T230_CAUASSENZE_PARSTO add CONDIZIONE_ALLEGATI varchar2(1) default 'I';
comment on column T230_CAUASSENZE_PARSTO.CONDIZIONE_ALLEGATI is 'Condizione sugli allegati alle richieste: I=da Iter, N=No, O=Obbligatori, F=Facoltativi';

declare
  cursor c1 is SELECT * FROM MONDOEDP.I070_UTENTI I070 where UTENTE = 'SYSMAN' and not exists (select 'x' from MONDOEDP.I070_UTENTI where AZIENDA = I070.AZIENDA and utente = 'MONDOEDP') order by AZIENDA;
  wProg integer;
begin
  select PROPERATORI into wProg from MONDOEDP.T035_PROGRESSIVO;
  for t1 in c1 loop
    wProg:=wProg + 1;
    insert into MONDOEDP.I070_UTENTI (AZIENDA,UTENTE, PROGRESSIVO, PASSWD, PERMESSI, FILTRO_FUNZIONI)
    values (t1.AZIENDA,'MONDOEDP',wProg,'6C653B654F4A5952515D',t1.PERMESSI,t1.FILTRO_FUNZIONI);
  end loop;
  update MONDOEDP.T035_PROGRESSIVO set PROPERATORI = wProg;
  update MONDOEDP.I070_UTENTI T set DATA_PW = trunc(sysdate) where UTENTE = 'MONDOEDP';
  commit;
end;    
/

comment on column T280_MESSAGGIWEB.FLAG is '0=elaborazione ok, 1=elaborazione fallita, 2=richiesta non autorizzata, 3=messaggi per email, 4=elaborazione ok (richiesta compensata)'; 
update T280_MESSAGGIWEB set FLAG = '4' where FLAG = '3' and nvl(LOG,'(inviata email)') <> '(inviata email)';
alter table T280_MESSAGGIWEB modify TESTO varchar2(4000);
alter table T280_MESSAGGIWEB modify LOG varchar2(4000);

alter table T020_ORARI add POSTICIPA_CAUS_TIMB_INTERSEC varchar2(1) default 'N';
comment on column T020_ORARI.POSTICIPA_CAUS_TIMB_INTERSEC is 'S=Posticipa dopo l''applicazione delle fasce di causalizzazione (z540) l''esecuzione della routine di causalizzazione delle timbrature intersecanti i giustificativi e la lib.professione (z550)';
update T020_ORARI set POSTICIPA_CAUS_TIMB_INTERSEC = 'S';
