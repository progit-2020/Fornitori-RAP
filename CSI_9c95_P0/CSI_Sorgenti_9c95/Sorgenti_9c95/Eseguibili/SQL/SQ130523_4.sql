declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130523_4AddIRPEF.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ130523_4AddIRPEF.sql');
end/*--NOLOG--*/;
/

-- Assenteismo e forza lavoro
alter table T151_ASSENTEISMO modify ass_familiari VARCHAR2(1) DEFAULT 'N';
comment on column T151_ASSENTEISMO.ass_familiari is 'Dettaglio familiari: Si/No';
alter table T151_ASSENTEISMO add ass_dettaglio VARCHAR2(1) DEFAULT 'N';
comment on column T151_ASSENTEISMO.ass_dettaglio is 'Dettaglio giustificativi: Si/No';
comment on column T151_ASSENTEISMO.esporta_xml is 'Esporta in formato xml: N=No,S=Tassi assenza,L=Legge 104/1992';
UPDATE T151_ASSENTEISMO SET ass_familiari = 'N';

--Impostazione descrizione voce EDPSC - 10441 a 'Variazione imponibile ENPAM/ENPAV'
UPDATE P200_VOCI t 
SET T.DESCRIZIONE='Variazione imponibile ENPAM/ENPAV', T.DESCRIZIONE_STAMPA='Variazione imponibile ENPAM/ENPAV'
WHERE T.COD_CONTRATTO='EDPSC' AND T.COD_VOCE='10411' AND T.COD_VOCE_SPECIALE='BASE'
AND UPPER(T.DESCRIZIONE) LIKE '%VARIAZIONE%' AND UPPER(T.DESCRIZIONE) LIKE '%ENPAM%'
AND UPPER(T.DESCRIZIONE) NOT LIKE '%ENPAV%' AND EXISTS
(SELECT 'X' FROM P201_ASSOGGETTAMENTI P WHERE P.COD_CONTRATTO=T.COD_CONTRATTO
AND P.COD_VOCE_PADRE=T.COD_VOCE AND P.COD_VOCE_SPECIALE_PADRE=T.COD_VOCE_SPECIALE
AND P.COD_VOCE_FIGLIO='10490' AND P.COD_VOCE_SPECIALE_FIGLIO=P.COD_VOCE_SPECIALE_PADRE);

