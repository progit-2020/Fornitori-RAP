declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_4P042.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130109_4P042.sql');
end/*--NOLOG--*/;
/

alter table sg710_testata_valutazioni add (valutazione_intermedia varchar2(500), esito_valutazione_intermedia varchar2(1)) /*--NOLOG--*/;
alter table sg746_stati_avanzamento add (val_interm_modificabile varchar2(1) default 'S', val_interm_obbligatoria varchar2(1) default 'N') /*--NOLOG--*/;
alter table sg746_stati_avanzamento modify val_interm_modificabile default 'S'; /*--Ad Aosta_Regione era già stato creato con default 'N'--*/

alter table sg745_consegna_valutazioni add prog_utente number(8);
update sg745_consegna_valutazioni sg745
set prog_utente = NVL((select t030.progressivo
                    from mondoedp.i060_login_dipendente i060, t030_anagrafico t030
                    where i060.nome_utente = sg745.utente
                    and i060.azienda = :azienda
                    and t030.matricola = i060.matricola),-1)
where prog_utente is null;
alter table sg745_consegna_valutazioni drop primary key/*--NOLOG--*/;
alter table sg745_consegna_valutazioni drop constraint SG745_PK/*--NOLOG--*/;
alter table sg745_consegna_valutazioni add constraint SG745_PK primary key (DATA,PROGRESSIVO,TIPO_VALUTAZIONE,STATO_AVANZAMENTO,UTENTE,PROG_UTENTE);

-- CREAZIONE SINDACATI VARI
declare 
  i integer;
  ID_P200 integer;
  CodVoceModello varchar2(5);
  CodVoceCopia varchar2(5);
  DesVoceCopia varchar2(40);
  DesVoceCopiaSt varchar2(40);

begin
CodVoceModello:='12441';
CodVoceCopia:='12486';
DesVoceCopia:='S.M.O. sind. medici osp. a importo fisso';
DesVoceCopiaSt:='S.M.O. sind. medici osp. a importo fisso';

select COUNT(*) into i from P441_CEDOLINO;
if i > 0 then
  select COUNT(*) into i from P200_VOCI t 
    where T.COD_CONTRATTO ='EDP' and T.COD_VOCE=CodVoceModello and T.COD_VOCE_SPECIALE='BASE'
    and not exists
    (select 'X' from P200_VOCI v where v.cod_contratto=t.cod_contratto and v.cod_voce=CodVoceCopia
       and v.cod_voce_speciale=t.cod_voce_speciale);
  if i > 0 then

-----
-- Inizio S.M.O. sind. medici osp. a importo fisso
-----
  
SELECT P200_ID_VOCE.NEXTVAL INTO ID_P200 FROM DUAL;
  
insert into p200_voci
select cod_contratto, CodVoceCopia, cod_voce_speciale, decorrenza, ID_P200, DesVoceCopia, CodVoceCopia || ' ', DesVoceCopiaSt, protetta, tipo, rid_mese_ass_cess, cassa_competenza, voce_importo, importo_automatico, importo_automatico_tipo, importo, importo_colonna, voce_quantita, cod_misuraquantita, ritenuta_massimali_scaglioni, ritenuta_perc, imponibile_minimali, cod_arrotondamento, perc_matura13a, mostra_video, confronto_mensile, stampa_cedolino, stampa_competenza, stampa_competenza_quote, cod_causaleirpef, ridotta_parttime_vert, ridotta_parttime_orizz, no_cedolino_normale, forza_ggcalcolo_quote, abbatte_ggminimali, abbatte_ggdetraz_caricofam, abbatte_ggdetraz_lavdip, abbatte_gganf, cumulo_annuale_cedolone, cod_raggruppamento, perc_abbatte13a, note, cumulo_in_calcolo, cod_voce_link_assog, cod_voce_speciale_link_assog, divisore_quote, abbatte_gginp, abbatte_ggina, programmata, oneri_detrazioni, eccezioni_sensibili, cod_raggruppamento_assogg, retribuzione_contrattuale, ritenuta_anagrafica, decorrenza_fine, cod_beneficiario, importo_massimo from p200_voci T
WHERE T.COD_CONTRATTO='EDP' AND T.COD_VOCE=CodVoceModello AND T.COD_VOCE_SPECIALE='BASE';

INSERT INTO P201_ASSOGGETTAMENTI
select cod_contratto, CodVoceCopia, cod_voce_speciale_padre, cod_voce_figlio, cod_voce_speciale_figlio, decorrenza, assoggettamento, assoggettamento13a, decorrenza_fine from p201_assoggettamenti t
where t.cod_contratto='EDP' and t.cod_voce_padre=CodVoceModello and t.cod_voce_speciale_padre='BASE';

-----
-- Fine S.M.O. sind. medici osp. a importo fisso
-----

  end if;
end if;
end;
/

