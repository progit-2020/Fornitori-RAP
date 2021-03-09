-- Add/modify columns 
alter table P504_CUDTESTATE add tipo_operazione VARCHAR2(1) default 'O' not null;
alter table P504_CUDTESTATE add certif_progr VARCHAR2(5);
alter table P504_CUDTESTATE add prot_tel_id_invio VARCHAR2(17);
alter table P504_CUDTESTATE add prot_tel_progr VARCHAR2(6);
-- Add comments to the columns 
comment on column P504_CUDTESTATE.tipo_operazione
  is 'Tipo operazione: O=invio ordinario, S=sostituzione, A=annullamento';
comment on column P504_CUDTESTATE.certif_progr
  is 'Progressivo certificazione assegnato nel file di invio';
comment on column P504_CUDTESTATE.prot_tel_id_invio
  is 'Protocollo assegnato dal servizio telematico: identificativo dell''invio';
comment on column P504_CUDTESTATE.prot_tel_progr
  is 'Protocollo assegnato dal servizio telematico: progressivo attribuito';
  
update P044_ENTIIRPEFFASCE P044 set P044.PERC=3.33
where P044.ANNO=2015 and P044.TIPO_ADDIZIONALE='R' and P044.COD_ENTE='08' and P044.IMPORTO_DA=15000.01;

update P042_ENTIIRPEF P042
set P042.NOTE='Le detrazioni per carichi di famiglia di cui all''art. 12 del TUIR sono maggiorate delle seguenti detrazioni regionali (teoriche):' || chr(10) || '€ 250,00 per ogni figlio portatore di handicap;' || chr(10) || '€ 100,00 per i contribuenti con piu'' di tre figli a carico, per ciascun figlio, a partire dal primo, compresi i figli naturali riconosciuti, i figli adottivi o affidati.' || chr(10) || 'Per determinare gli importi delle detrazioni effettivamente spettanti si applicheranno le disposizioni previste per le analoghe agevolazioni nazionali ai sensi dell’art. 12, comma 1, lettera c) e commi seguenti del TUIR.'
where P042.ANNO=2015 and P042.TIPO_ADDIZIONALE='R' and P042.COD_ENTE='13';

update P042_ENTIIRPEF P042
set P042.NOTE='Ai contribuenti con piu'' di tre figli a carico spetta una detrazione sull''addizionale regionale all''IRPEF di 20 euro per ciascun figlio, in proporzione alla percentuale e ai mesi di carico, a partire dal primo compresi i figli naturali riconosciuti, adottivi o affidati.' || chr(10) || 'La detrazione sopra descritta e'' aumentata di 375 euro per ogni figlio con diversa abilita'' ai sensi dell''art. 3 della legge 104/1992.' || chr(10) || 'Ai fini della spettanza e della ripartizione delle detrazioni si applicano le disposizioni previste dall''art. 12, comma 1, lettera c) e comma 2 del d.p.r. 917/1986.'
where P042.ANNO=2015 and P042.TIPO_ADDIZIONALE='R' and P042.COD_ENTE='14';

update P504_CUDTESTATE P504 set P504.ANNOTAZIONI=replace(P504.ANNOTAZIONI,'Tipologia reddito Borsita','Tipologia reddito Borsista')
where P504.ANNO=2014 AND P504.ANNOTAZIONI like '%Tipologia reddito Borsita%';

update P004_CODICITABANNUALI P004
set P004.DESCRIZIONE='Congedo per malattia bambino di eta'' inferiore ai tre anni con retribuzione assente - ex art.47, comma 1, d. lgs. n.151/2001 - solo D.M.A. 2'
where P004.COD_TABANNUALE='IPTIPSERV' AND P004.COD_CODICITABANNUALI='63';
	
