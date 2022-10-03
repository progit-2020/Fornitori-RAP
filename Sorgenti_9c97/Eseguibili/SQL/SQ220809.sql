update MONDOEDP.I090_ENTI set VERSIONEDB = '9c.9',PATCHDB = 7 where UTENTE = (select UTENTE from MONDOEDP.I090_ENTI where AZIENDA = :AZIENDA);

alter table T020_ORARI add SEPARA_TIMB_CONTEGGI varchar2(1) default 'N';
update T020_ORARI set SEPARA_TIMB_CONTEGGI = 'S' where nvl(XPARAM,'nvl') not like '%<PROLUNGA_TIMB_SPEZZATE>%';

alter table T235_CAUPRESENZE_PARSTO add ARROT_RIEPGG varchar2(5); 
alter table T235_CAUPRESENZE_PARSTO add ARROT_RIEPGG_FASCE varchar2(1) default 'N'; 
alter table T235_CAUPRESENZE_PARSTO add ARROT_RIEPGG_ORENORM varchar2(1) default 'N'; 
comment on column T235_CAUPRESENZE_PARSTO.ARROT_RIEPGG is 'arrotondamento da applicare al riepilogo giornaliero della causale';
comment on column T235_CAUPRESENZE_PARSTO.ARROT_RIEPGG_FASCE is 'S=l''arrotondamento viene applicato anche all''interno delle fasce di maggiorazione, N=l''arrotondamento viene applicato al totale giornaliero';
comment on column T235_CAUPRESENZE_PARSTO.ARROT_RIEPGG_ORENORM is 'S=il resto dell''arrotondamento viene mantenuto nelle ore normali, N=il resto dell''arrotondamento viene perso';

comment on column T275_CAUPRESENZE.ARROT_RIEPGG is 'Obsoleto - rimpiazzato da T235.ARROT_RIEPGG';
comment on column T275_CAUPRESENZE.ARROT_RIEPGG_FASCE is 'Obsoleto - rimpiazzato da T235.ARROT_RIEPGG_FASCE';
comment on column T275_CAUPRESENZE.ARROT_RIEPGG_ORENORM is 'Obsoleto - rimpiazzato da T235.ARROT_RIEPGG_ORENORM';

update T235_CAUPRESENZE_PARSTO T235 set ARROT_RIEPGG = (select ARROT_RIEPGG from T275_CAUPRESENZE where ID = T235.ID);
update T235_CAUPRESENZE_PARSTO T235 set ARROT_RIEPGG_FASCE = (select ARROT_RIEPGG_FASCE from T275_CAUPRESENZE where ID = T235.ID);
update T235_CAUPRESENZE_PARSTO T235 set ARROT_RIEPGG_ORENORM = (select ARROT_RIEPGG_ORENORM from T275_CAUPRESENZE where ID = T235.ID);

alter table T235_CAUPRESENZE_PARSTO add ARROT_RIEPGG_FINECONT varchar2(1) default 'N';
comment on column T235_CAUPRESENZE_PARSTO.ARROT_RIEPGG_FINECONT is 'N=l''arrotondamento viene applicato all''inizio dei riepiloghi giornalieri, prima della compensazione dei negativi, S=l''arrotondamento viene applicato alla fine dei riepiloghi giornalieri, dopo la compensazione dei negativi';

comment on column T265_CAUASSENZE.CUMULOGLOBALE is 'N=Nessuno, C=Genitori, F=Familiari, S=Campo anagrafico';

