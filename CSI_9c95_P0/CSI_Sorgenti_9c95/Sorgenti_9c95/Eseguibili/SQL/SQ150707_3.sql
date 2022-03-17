alter table SG101_FAMILIARI add REG_DATANAS varchar2(1) default 'N';
comment on column SG101_FAMILIARI.REG_DATANAS is 'S=la data di nascita è stata effettivamente registrata dall''operatore, N=la data di nascita è solo quella presunta';

alter table SG101_FAMILIARI add NOTE_INDIVIDUALI varchar2(300);
comment on column SG101_FAMILIARI.NOTE_INDIVIDUALI is 'Indica eventuali note relative al familiare, riportate nella scheda dei dati anagrafici';

alter table SG101_FAMILIARI add PART_FRUIZ_MATERNITA varchar2(1);
comment on column SG101_FAMILIARI.PART_FRUIZ_MATERNITA is 'Indica se è gestita la fruizione particolare dei congedi parentali per genitore unico. A=genitore unico';

insert into I011_DIZIONARIO_DATISCHEDA (DATO,TIPO,DESCRIZIONE,ORDINAMENTO)
values ('BLOCCO_T860A','D','Prevalidazione iter del cartellino',5);

insert into I011_DIZIONARIO_DATISCHEDA (DATO,TIPO,DESCRIZIONE,ORDINAMENTO)
values ('BLOCCO_T860','D','Apertura iter validazione del cartellino',6);

alter table T280_MESSAGGIWEB modify MITTENTE varchar2(30);
alter table I000_LOGINFO modify OPERATORE varchar2(30);
alter table I000_BACKUP modify OPERATORE varchar2(30);

create sequence MONDOEDP.BC22_ID_FLUSSO minvalue 1 maxvalue 999999 start with 900001 increment by 1 nocache;
