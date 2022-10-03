alter table T262_PROFASSANN add FRUIZ_MAX_NUM_GG number(3);
comment on column T262_PROFASSANN.FRUIZ_MAX_NUM_GG is 'numero massimo di volte in cui è possibile fruire a giornate le causali appartenenti a CODRAGGR nel periodo di cumulo corrente';

--correzione sequenze T265_ID e T275_ID
--inizio
alter table T235_CAUPRESENZE_PARSTO disable constraint T235_FK_T275;

declare
  wNextID number;
  cursor c1 is
    SELECT ID from t275_caupresenze 
    where ID >= wNextID 
    order by ID;
begin
  select LAST_NUMBER into wNextID 
  from user_SEQUENCES 
  where SEQUENCE_NAME = 'T275_ID';
  
  for t1 in c1 loop
    select T275_ID.NEXTVAL into wNextID from dual;
    update T275_CAUPRESENZE set ID = wNextID where ID = t1.ID;
    update T235_CAUPRESENZE_PARSTO set ID = wNextID where ID = t1.ID;
  end loop;  
end;  
/

alter table T235_CAUPRESENZE_PARSTO enable constraint T235_FK_T275;

declare
  wMaxID number;
begin
  select max(ID) into wMaxID from T265_CAUASSENZE; 
  execute immediate 'drop sequence T265_ID';
  execute immediate 'create sequence T265_ID minvalue 1 maxvalue 999999999999999999999999999 start with '||(wMAXID+1)||' increment by 1 nocache';
end;
/
--fine

INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO) SELECT AZIENDA,'C90_EMAIL_RESP_OGGETTO','Notifica presenza richieste da autorizzare' FROM MONDOEDP.I090_ENTI;
INSERT INTO MONDOEDP.I091_DATIENTE (AZIENDA,TIPO,DATO) SELECT AZIENDA,'C90_EMAIL_RESP_TESTO','Si avvisa che sono presenti richieste in attesa di autorizzazione.' FROM MONDOEDP.I090_ENTI;
