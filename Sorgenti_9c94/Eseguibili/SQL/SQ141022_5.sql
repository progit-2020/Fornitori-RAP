comment on column T265_CAUASSENZE.copri_ggnonlav
  is 'Consente di estendere l''inserimento ai gg non lav pregressi per collegarsi al periodo precedente, N=Non estende, E=Estende, S=estende solo se non si tratta di nuovo periodo';
  
  -- INIZIO CREAZIONE INCARICO DR020-015-2010

declare
  i integer;
begin
  select COUNT(*) into i from P441_CEDOLINO;
  if i > 0 then
    select COUNT(*) into i from P250_VOCIAGGIUNTIVE t where T.COD_CONTRATTO ='EDP' AND T.NOME_VOCEAGGIUNTIVA = 'INCARICO';
    if i > 0 then

      INSERT INTO I501INCARICO SELECT 'DR020-015-2010','Dirigente ruolo sanitario equiparato con incarico lett. c) (dec. 2010-2014)' FROM DUAL WHERE NOT EXISTS (SELECT 'X' FROM I501INCARICO T WHERE T.CODICE='DR020-015-2010');
      INSERT INTO P252_VOCIAGGIUNTIVEIMPORTI
      SELECT COD_CONTRATTO, NOME_VOCEAGGIUNTIVA, 'DR020-015-2010', DECORRENZA, 'Dir. ruolo sanitario equiparato con lett. c) (dec. 2010-2014)', COD_VOCE, COD_VOCE_SPECIALE,
             47.23 IMPORTO,
             EROGAZIONE_MESI, DECORRENZA_FINE, COD_VALUTA_INIZ
      FROM P252_VOCIAGGIUNTIVEIMPORTI P252
      WHERE P252.COD_CONTRATTO='EDP' AND P252.NOME_VOCEAGGIUNTIVA='INCARICO'
      AND P252.CODICE='DR020-010-2010' AND P252.COD_VOCE='00212' AND NOT EXISTS
                  (SELECT 'X' FROM P252_VOCIAGGIUNTIVEIMPORTI T WHERE T.COD_CONTRATTO='EDP'
                  AND T.NOME_VOCEAGGIUNTIVA='INCARICO' AND T.CODICE='DR020-015-2010');

    end if;
  end if;
end/*--NOLOG--*/;
/
-- FINE CREAZIONE INCARICO DR020-015-2010

update P670_XMLREGOLE P670 set P670.NUMERO='D039' where P670.NUMERO='D036';
update P673_XMLDATIINDIVIDUALI P673 set P673.NUMERO='D039' where P673.NUMERO='D036';

---------------------------
-- INIZIO NUOVE REGOLE UNIEMENS per creazione elemento RegimePost95
---------------------------
declare
  i integer;
begin
  select COUNT(*) into i from P670_XMLREGOLE t where t.Nome_Flusso='UNIEMENS';
  if i > 0 then

insert into P670_XMLREGOLE (nome_flusso, decorrenza, numero, elemento, descrizione, numero_padre, formato_file, numerico, cod_arrotondamento, formato, ometti_vuoto, regola_calcolo_automatica, regola_calcolo_manuale, regola_modificabile, commento, attributo, tipo_importo, dato_riepilogativo, decorrenza_fine)
values ('UNIEMENS', to_date('01-04-2010', 'dd-mm-yyyy'), 'D038', 'RegimePost95', 'Lavoratore soggetto a regime contributivo', 'A350', null, 'N', null, null, 'S', null, null, 'N', null, null, null, 'N', to_date('31-12-3999', 'dd-mm-yyyy'));

  end if;
end;
/

-- INSERIMENTO NUOVI PARAMETRI DELLA MASCHERA 'ELABORAZIONE CU' PRESI DA 'CERTIFICAZIONE R.A.' 
insert into T001_PARAMETRIFUNZIONI
select 'P504', NOME, VALORE, PROGOPERATORE, UTENTE 
from T001_PARAMETRIFUNZIONI t
where PROG = 'P718' and NOME in ('CODICIACC','COMPENSI');
