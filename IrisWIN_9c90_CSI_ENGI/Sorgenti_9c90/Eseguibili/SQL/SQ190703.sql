alter table T264_RESIDASSANN add FRUIZCOMPPREC_CUMULO_T varchar2(6);
comment on column T264_RESIDASSANN.FRUIZCOMPPREC_CUMULO_T is 'non usato - fruizioni da non conteggiare nel calcolo del cumulo T (competenze periodiche)';
	
alter table I001_LOGDATI modify VALORE_OLD varchar2(2000);
alter table I001_LOGDATI modify VALORE_NEW varchar2(2000);

alter table T430_STORICO modify ABCAUSALE1 varchar2(2000);
alter table T430_STORICO modify ABPRESENZA1 varchar2(2000);

alter table T430_STORICO modify ABCAUSALE1 varchar2(4000);
alter table T430_STORICO modify ABPRESENZA1 varchar2(4000);

alter table I000_BACKUP modify MASCHERA varchar2(30);
alter table I000_LOGINFO modify MASCHERA varchar2(30);

comment on column T265_CAUASSENZE.ABBATTE_STRIND is 'Obsoleto - rimpiazzato da T230.ABBATTE_STRIND';

alter table T230_CAUASSENZE_PARSTO add ABBATTE_STRIND varchar2(1) default 'N';
comment on column T230_CAUASSENZE_PARSTO.ABBATTE_STRIND is 'S=le ore causalizzate abbattono anche le ore liquidabili, l''indennità notturna, festiva e di presenza';

update T230_CAUASSENZE_PARSTO T230 set ABBATTE_STRIND = (select ABBATTE_STRIND from T265_CAUASSENZE where ID = T230.ID);
