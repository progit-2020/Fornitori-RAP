alter table T280_MESSAGGIWEB modify TITOLO varchar2(1000);
alter table T280_MESSAGGIWEB add EMAIL varchar2(1000);
comment on column T280_MESSAGGIWEB.EMAIL is 'Indirizzi di destinazione espliciti del messaggio di posta elettronica (se FLAG = 3)';
alter table T280_MESSAGGIWEB add EMAIL_CC varchar2(1000);
comment on column T280_MESSAGGIWEB.EMAIL_CC is 'Indirizzi di destinazione in CC espliciti del messaggio di posta elettronica (se FLAG = 3)';
alter table T280_MESSAGGIWEB add EMAIL_CCN varchar2(1000);
comment on column T280_MESSAGGIWEB.EMAIL_CCN is 'Indirizzi di destinazione in CCN espliciti del messaggio di posta elettronica (se FLAG = 3)';
alter table T280_MESSAGGIWEB add CATEGORIA varchar2(100);
comment on column T280_MESSAGGIWEB.CATEGORIA is 'Categoria libera a fini solamente descrittivi per indicare a cosa si riferisce il messaggio';

alter table T670_REGOLEBUONI add GGLAV_SEMPRE_CALENDARIO varchar2(1) default 'N';
comment on column T670_REGOLEBUONI.GGLAV_SEMPRE_CALENDARIO is 'S=riconosce il gg.lav. o riposo sempre da calendario anche per personale turnista, N=riconosce il gg.lav. o riposo in base alla pianificazione se personale turnista';
alter table T670_REGOLEBUONI add GGLAV_NOPIANIF_CALENDARIO varchar2(1) default 'N';
comment on column T670_REGOLEBUONI.GGLAV_NOPIANIF_CALENDARIO is 'Per personale turnista: S=se non esiste pianificazione riconosce il gg.lav. o riposo da calendario, N=non usa mai il calendario';
