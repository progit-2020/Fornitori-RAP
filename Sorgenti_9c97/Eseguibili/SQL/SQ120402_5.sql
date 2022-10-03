-- CREAZIONE VOCE Ritenuta L. 166/91 fondo prev.comp. ente
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='11085';
CodVoceCopia:='11086';
DesVoceCopia:='Ritenuta L. 166/91 fondo prev.comp. ente';
DesVoceCopiaSt:='Ritenuta L. 166/91 fondo prev.comp. ente';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio Ritenuta L. 166/91 fondo prev.comp. ente 
-----
  
    SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
    insert into p200_voci
    select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, 0.1, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario from p200_voci T
    WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

-----
-- Fine Ritenuta L. 166/91 fondo prev.comp. ente
-----

  end if;
end if;
end;

/

insert into p201_assoggettamenti
select cod_contratto, cod_voce_padre, cod_voce_speciale_padre, '11086', cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine
from p201_assoggettamenti t where t.cod_contratto='EDP' and t.cod_voce_padre='10080' and t.cod_voce_speciale_padre='BASE'
and t.cod_voce_figlio='11085' and t.cod_voce_speciale_figlio='BASE'
and exists
(select 'x' from p200_voci v where v.cod_contratto=t.cod_contratto and v.cod_voce='11086' and v.cod_voce_speciale='BASE')
and not exists
(select 'x' from p201_assoggettamenti t1 where t1.cod_contratto=t.cod_contratto
and t1.cod_voce_padre=t.cod_voce_padre and t1.cod_voce_speciale_padre=t.cod_voce_speciale_padre
and t1.cod_voce_figlio='11086' and t1.cod_voce_speciale_figlio=t.cod_voce_speciale_figlio);

-- Aggiornamento accorpamento voci DMA per fondo previdenza complementare
declare 
  i integer;

begin

select COUNT(*) into i from P214_TIPOACCORPAMENTOVOCI T WHERE T.COD_TIPOACCORPAMENTOVOCI='DMA';
if i > 0 then

insert into P215_CODICIACCORPAMENTOVOCI
select 'DMA','0570','FONDO PREVIDENZA COMPLEMENTARE' from dual
where not exists
(select 'x' from P215_CODICIACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='DMA' and t.cod_codiciaccorpamentovoci='0570');

insert into P215_CODICIACCORPAMENTOVOCI
select 'DMA','0580','CONTRIBUTO L. 166/91' from dual
where not exists
(select 'x' from P215_CODICIACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='DMA' and t.cod_codiciaccorpamentovoci='0580');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','11080','BASE','DMA','0570',to_date('01011900','ddmmyyyy'),100,'R',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='DMA' and t.cod_codiciaccorpamentovoci='0570'
and t.cod_contratto='EDP' and t.cod_voce='11080' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='11080' and t.cod_voce_speciale='BASE');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','11085','BASE','DMA','0570',to_date('01011900','ddmmyyyy'),100,'E',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='DMA' and t.cod_codiciaccorpamentovoci='0570'
and t.cod_contratto='EDP' and t.cod_voce='11085' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='11085' and t.cod_voce_speciale='BASE');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','11082','BASE','DMA','0570',to_date('01011900','ddmmyyyy'),100,'R',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='DMA' and t.cod_codiciaccorpamentovoci='0570'
and t.cod_contratto='EDP' and t.cod_voce='11082' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='11082' and t.cod_voce_speciale='BASE');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','11087','BASE','DMA','0570',to_date('01011900','ddmmyyyy'),100,'E',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='DMA' and t.cod_codiciaccorpamentovoci='0570'
and t.cod_contratto='EDP' and t.cod_voce='11087' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='11087' and t.cod_voce_speciale='BASE');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','11086','BASE','DMA','0580',to_date('01011900','ddmmyyyy'),100,'E',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='DMA' and t.cod_codiciaccorpamentovoci='0580'
and t.cod_contratto='EDP' and t.cod_voce='11086' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='11086' and t.cod_voce_speciale='BASE');

end if;
end;

/

-- Modifica commento per nuovo valore tipo abbattimento tredicesima 
comment on column P212_PARAMETRISTIPENDI.tipo_abbattimento13a
  is 'Tipo abbatimento 13a in caso di assenza: C=Complessivo mese se percentualizzando i giorni di assenza i giorni utili non superano la meta'' dei giorni contrattuali, A=Complessivo anno i giorni di assenza vengono totalizzati nell''''anno al fine di abbattere i ratei quando raggiungono la meta'' dei giorni contrattuali, R=Rapportato ai giorni di assenza, P=Rapportato ai giorni di assenza con abbattimento giornaliero dei ratei';

alter table I015_TRADUZIONI_CAPTION modify COMPONENTE varchar2(2000);
alter table I015_TRADUZIONI_CAPTION modify CAPTION varchar2(2000);

alter table T950_STAMPACARTELLINO add CARTELLINI_VALIDATI varchar2(1) default 'I';
comment on column T950_STAMPACARTELLINO.CARTELLINI_VALIDATI is 'I=ininfluente, N=utilizzabile solo se non esiste la voce "T860" sulla T180, S=utilizzabile solo se esiste la voce "T860" sulla T180';

-- Aggiornamento accorpamento voci UNIEM per Stipendio e RIA DMA2
declare 
  i integer;

begin

select COUNT(*) into i from P214_TIPOACCORPAMENTOVOCI T WHERE T.COD_TIPOACCORPAMENTOVOCI='UNIEM';
if i > 0 then

insert into P215_CODICIACCORPAMENTOVOCI
select 'UNIEM','DMA2-STIP','Stipendio tabellare D.M.A. 2' from dual
where not exists
(select 'x' from P215_CODICIACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='DMA2-STIP');

insert into P215_CODICIACCORPAMENTOVOCI
select 'UNIEM','DMA2-RIA','Retrib. individuale anzianita'' D.M.A. 2' from dual
where not exists
(select 'x' from P215_CODICIACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='DMA2-RIA');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','00010','BASE','UNIEM','DMA2-STIP',to_date('01011900','ddmmyyyy'),100,'C',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='DMA2-STIP'
and t.cod_contratto='EDP' and t.cod_voce='00010' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='00010' and t.cod_voce_speciale='BASE');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','00025','BASE','UNIEM','DMA2-STIP',to_date('01011900','ddmmyyyy'),100,'C',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='DMA2-STIP'
and t.cod_contratto='EDP' and t.cod_voce='00025' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='00025' and t.cod_voce_speciale='BASE');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','00114','BASE','UNIEM','DMA2-STIP',to_date('01011900','ddmmyyyy'),100,'C',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='DMA2-STIP'
and t.cod_contratto='EDP' and t.cod_voce='00114' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='00114' and t.cod_voce_speciale='BASE');

insert into P216_ACCORPAMENTOVOCI
select 'EDP','00030','BASE','UNIEM','DMA2-RIA',to_date('01011900','ddmmyyyy'),100,'C',to_date('31123999','ddmmyyyy') from dual
where not exists
(select 'x' FROM P216_ACCORPAMENTOVOCI t where t.cod_tipoaccorpamentovoci='UNIEM' and t.cod_codiciaccorpamentovoci='DMA2-RIA'
and t.cod_contratto='EDP' and t.cod_voce='00030' and t.cod_voce_speciale='BASE')
and exists
(select 'x' FROM P200_VOCI t where t.cod_contratto='EDP' and t.cod_voce='00030' and t.cod_voce_speciale='BASE');

end if;
end;

/

