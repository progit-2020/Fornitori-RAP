alter table CSI004_INDFUNZIONE add ASSENZE_TOLLERATE varchar2(2000);
comment on column CSI004_INDFUNZIONE.ASSENZE_TOLLERATE is 'Elenca le causali di assenza di cui considerare le ore rese ai fini del calcolo dell''indennità di funzione';

alter table I005_MSGINFO modify MASCHERA varchar2(30);