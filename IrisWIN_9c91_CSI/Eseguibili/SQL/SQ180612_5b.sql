alter table T670_REGOLEBUONI add INTERVALLO_INTERNO_PMT varchar2(1) default 'S';
update T670_REGOLEBUONI set INTERVALLO_INTERNO_PMT = 'N';
comment on column T670_REGOLEBUONI.INTERVALLO_INTERNO_PMT is 'S=come intervallo di pausa mensa si considera solo la parte intersecante la fascia PMT, N=come intervallo di pausa mensa si considera l''intero stacco che tocca la fascia PMT';


