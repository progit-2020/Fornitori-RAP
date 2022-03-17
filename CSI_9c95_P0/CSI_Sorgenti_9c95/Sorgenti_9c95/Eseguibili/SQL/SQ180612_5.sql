alter table T670_REGOLEBUONI add ASSENZE_DIMINUZIONE_INCLUSE varchar2(2000); 
comment on column T670_REGOLEBUONI.ASSENZE_DIMINUZIONE_INCLUSE is 'Elenco delle causali di assenza che Diminuiscono / Lasciano inalterate le ore sul cartellino ma le rendono come ore rese ai fini della maturazione';

alter table M140_RICHIESTE_MISSIONI add PROTOCOLLO_MANUALE varchar2(1) default 'N';
comment on column M140_RICHIESTE_MISSIONI.PROTOCOLLO_MANUALE is 'S=il campo M140.PROTOCOLLO deve essere immesso manualmente in fase di richiesta, e non dalla sequenza, N=il campo M140.PROTOCOLLO viene valorizzato dalla sequenza M140_PROTOCOLLO';
