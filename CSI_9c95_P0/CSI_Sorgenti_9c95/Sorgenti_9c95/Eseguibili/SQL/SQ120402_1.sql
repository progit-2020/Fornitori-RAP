comment on column P206_ASSENZEINPDAP.elimina_sezione
  is 'Elimina sezione INPDAP: S=Si, N=No, C=Periodo part-time ciclico';

update P200_VOCI t set t.descrizione='A.D.R. accordo regionale',t.descrizione_stampa='A.D.R. accordo regionale'
where t.cod_contratto='EDPSC' and t.cod_voce='00096' and t.descrizione like 'A.D.P%';

ALTER TABLE P670_XMLREGOLE MODIFY REGOLA_CALCOLO_AUTOMATICA VARCHAR2(4000);
ALTER TABLE P670_XMLREGOLE MODIFY REGOLA_CALCOLO_MANUALE VARCHAR2(4000);

insert into p026_fondiprevcompl
select '21641OPT', decorrenza, decorrenza_fine, 'Perseo dipendenti optanti (ex TFS) - Garantito', '2164', cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef, '21641'
from p026_fondiprevcompl t
where t.cod_fpc ='21421OPT' and not exists
(select 'x' from p026_fondiprevcompl v where v.cod_fpc='21641OPT');
insert into p026_fondiprevcompl
select '21641TFR', decorrenza, decorrenza_fine, 'Perseo dipendenti TFR - Garantito', '2164', cod_inpdapregimefineserv, perc_dipendente, perc_ente, perc_tfr_fpc, perc_max_dip_deduz_irpef, importo_max_anno_deduz_irpef, perc_max_reddito_deduz_irpef, '21641'
from p026_fondiprevcompl t
where t.cod_fpc ='21421TFR' and not exists
(select 'x' from p026_fondiprevcompl v where v.cod_fpc='21641TFR');

