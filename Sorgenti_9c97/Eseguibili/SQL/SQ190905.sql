alter table USR_T072_DETTGG_TIPOI add ORARIO varchar2(5);
alter table USR_T072_DETTGG_TIPOI add DEBITO integer;

update T320_PIANLIBPROFESSIONE set ID_EVENTO_STR = null where ID_EVENTO_STR = 0;
	