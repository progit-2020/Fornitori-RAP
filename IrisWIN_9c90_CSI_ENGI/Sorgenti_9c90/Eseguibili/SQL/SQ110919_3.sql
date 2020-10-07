
UPDATE t480_comuni t SET T.CITTA='SAN CESAREO' WHERE T.CODCATASTALE='M295';
UPDATE t480_comuni t SET T.CITTA='BASTIA UMBRA' WHERE T.CODCATASTALE='A710';

create index T265_CAUSALE_SUCCESSIVA on T265_CAUASSENZE (CAUSALE_SUCCESSIVA)
  tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;
create index T265_CODCAU3 on T265_CAUASSENZE (CODCAU3)
  tablespace INDICI storage (initial 256K next 256K pctincrease 0)/*--NOLOG--*/;


-- *********************************************************************************
-- IMPOSTAZIONE MASSIMALE NUOVI ISCRITTI E DIRETTORI PER CPDEL, CPS, ENPAM EX CONVENZIONATI
-- ****************  2012  ****************
-- *********************************************************************************

declare 
  AnnoNuovo integer;
  MassimaleIsc real;
  MassimaleDir real;

  CURSOR C1 IS  
  SELECT '11010' AS COD_VOCE, 'BASE' AS COD_VOCE_SPECIALE FROM DUAL UNION
  SELECT '11020', 'BASE' FROM DUAL UNION
  SELECT '11410', 'BASE' FROM DUAL;
begin
  -- IMPOSTARE QUI IL NUOVO ANNO DA GESTIRE
  AnnoNuovo:=2012;
  -- IMPOSTARE QUI I NUOVI MASSIMALI NUOVI ISCRITTI E DIRETTORI
  MassimaleIsc:=96149;
  MassimaleDir:=175265;

  FOR T1 IN C1 LOOP
    
    UPDATE P232_SCAGLIONI P232 SET MASSIMALE1=MassimaleIsc, MASSIMALE2=MassimaleDir WHERE P232.COD_CONTRATTO='EDP' AND P232.COD_VOCE=T1.COD_VOCE AND P232.COD_VOCE_SPECIALE=T1.COD_VOCE_SPECIALE AND P232.DECORRENZA=TO_DATE('0101'||TO_CHAR(AnnoNuovo),'DDMMYYYY');

  END LOOP;
 
end;
/

-- *********************************************************************************
-- IMPOSTAZIONE MASSIMALE INDENNITA ART.42 COMMA 5 DLGS 151/2001
-- ****************  2012  ****************
-- *********************************************************************************

update T002_QUERYPERSONALIZZATE  
set RIGA = '"31/01/2012","45472",*'
WHERE NOME IN ('PA_Ind_Art_42_Con_Tred','PA_Ind_Art_42_Senza_Tred')
and POSIZ = -1;

create bitmap index P663I_ID_FLUSSO_PARTE_NUMERO ON P663_FLUSSIDATIINDIVIDUALI (ID_FLUSSO,PARTE,NUMERO) tablespace INDICI/*--NOLOG--*/;

create index P663I_ID_FLUSSO_PARTE_NUMERO ON P663_FLUSSIDATIINDIVIDUALI (ID_FLUSSO,PARTE,NUMERO) tablespace INDICI/*--NOLOG--*/;

