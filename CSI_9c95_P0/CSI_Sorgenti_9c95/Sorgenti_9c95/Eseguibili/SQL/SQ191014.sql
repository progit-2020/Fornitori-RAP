alter table MONDOEDP.I091_DATIENTE add ORDINE number(3);
comment on column MONDOEDP.I091_DATIENTE.ORDINE is 'Ordine di visualizzazione dei dati sull''applicativo';
	
alter table T230_CAUASSENZE_PARSTO add SCELTA_ORARIO varchar2(1) default 'N';
comment on column T230_CAUASSENZE_PARSTO.SCELTA_ORARIO is 'S=il giustificativo dalle..alle viene considerato insieme alle timbrature nella scelta dell''orario/turno migliore';

alter table T670_REGOLEBUONI add CONSIDERA_GGSUCC varchar2(1) default 'N';
comment on column T670_REGOLEBUONI.CONSIDERA_GGSUCC is 'S=nel caso di scavalco di mezzanotte ma senza conteggio della notte sull''entrata, si considera lo spezzone in Uscita del gg dopo.';