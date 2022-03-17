CREATE OR REPLACE PACKAGE BODY GENERACALENDARIO AS

PROCEDURE CALCOLAPASQUA (ANNO IN INTEGER, GP IN OUT INTEGER, MP IN OUT INTEGER, GPT OUT INTEGER, MPT OUT INTEGER) IS
  SANNO INTEGER;
  DANNO INTEGER;
  VARCAL INTEGER;
  VARCAL1 INTEGER;
  VARCAL2 INTEGER;
  ANNO1 INTEGER;
  ANNO2 INTEGER;
  ANNO3 INTEGER;
  ANNO4 INTEGER;
  OPE INTEGER;
  OPE1 INTEGER;
  ERRE INTEGER;
  ERRE1 INTEGER;
BEGIN
  SANNO:=SUBSTR(TO_CHAR(ANNO),1,2);
  DANNO:=SUBSTR(TO_CHAR(ANNO),3,2);
  VARCAL:=TRUNC(ANNO / 19);
  ANNO1:=ANNO - VARCAL * 19;
  VARCAL:=TRUNC(SANNO / 30);
  ANNO2:=SANNO - VARCAL * 30;
  VARCAL:=TRUNC((SAnno - 15) / 25);
  Anno3:=(SAnno - 15) - VarCal * 25;
  VarCal:=TRUNC(SAnno / 4);
  VarCal1:=TRUNC(Anno3 / 3);
  VarCal2:=TRUNC((SAnno - 15) / 25);
  Ope1:=30 + Anno1 * 11 - Anno2 + VarCal + VarCal2 * 8 + VarCal1;
  VarCal:=TRUNC(Ope1 / 30);
  Ope:=Ope1 - VarCal * 30;
  if Ope <> 11 then
    if Ope > 11 then
      VarCal:=TRUNC(Anno / 19);
      Anno4:=VarCal * 19;
      if (Ope = 12) and (Anno4 > 10) then
        Ope:=13;
      END IF;
    else
      Ope:=Ope + 30;
    END IF;
  else
    Ope:=12;
  END IF;
  VarCal:=TRUNC(SAnno / 4);
  Anno4:=SAnno - VarCal * 4;
  VarCal:=TRUNC(DAnno / 4);
  Erre1:=DAnno + VarCal + Anno4 * 5 + Ope * 6;
  VarCal:=TRUNC(Erre1 / 7);
  Erre:=Erre1 - VarCal * 7;
  GP:=68 - Ope - Erre;
  MP:=3;
  if GP < 32 then
    if GP < 31 then
      GPT:=GP + 1;
      MPT:=MP;
    else
      GPT:=GP + 1 - 31;
      MPT:=4;
    END IF;
  else
    GP:=GP - 31;
    MP:=4;
    GPT:=GP + 1;
    MPT:=MP;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    MP:=0;
    GP:=0;
END CALCOLAPASQUA;

function GETFESTIVITA(DATAIN in date) return varchar2 is
  Result varchar2(1);
MESE integer;
GIORNO integer;
ANNO integer;
PASQUA boolean;
MPASQUA INTEGER;
GPASQUA INTEGER;
MPASQUETTA INTEGER;
GPASQUETTA INTEGER;
begin
  Result:='N';
  PASQUA:=FALSE;
  ANNO:=to_number(to_char(DATAIN,'YYYY'));
  MESE:=to_number(to_char(DATAIN,'MM'));
  GIORNO:=to_number(to_char(DATAIN,'DD'));
  -- Calcolo della Pasqua
  IF (NOT PASQUA) AND (MESE IN (3,4)) THEN
    PASQUA:=TRUE;
    CALCOLAPASQUA(ANNO,GPASQUA,MPASQUA,GPASQUETTA,MPASQUETTA);
  END IF;
  IF (PASQUA) AND (MESE = 5) THEN
    PASQUA:=FALSE;
  END IF;
  -- Pasqua o Pasquetta
  IF PASQUA THEN
    IF (MPASQUA = MESE) AND (GPASQUA = GIORNO) THEN
      Result:='S';
    END IF;
    IF (MPASQUETTA = MESE) AND (GPASQUETTA = GIORNO) THEN
      Result:='S';
    END IF;
  END IF;      
  if (MESE = 1) and (GIORNO in (1,6)) then
    Result:='S';
  elsif (MESE = 4) and (GIORNO = 25) then
    Result:='S';
  elsif (MESE = 5) and (GIORNO = 1) then
    Result:='S';
  elsif (MESE = 6) and (GIORNO = 2) and (ANNO >= 2001) then
    Result:='S';
  elsif (MESE = 8) and (GIORNO = 15) then
    Result:='S';
  elsif (MESE = 11) and (GIORNO = 1) then
    Result:='S';
  elsif (MESE = 12) and (GIORNO IN (8,25,26)) then
    Result:='S';
  end if;
  return(Result);
end GETFESTIVITA;

procedure GENERACAL(COD in varchar2, DAL in date, AL in date, CANCELLA varchar2) is
  TYPE TGIORNI IS TABLE OF VARCHAR2(1)
    INDEX BY BINARY_INTEGER;
  GIORNI TGIORNI;
  DATACORR DATE;
  NG INTEGER;
  ANNO INTEGER;
  MESE INTEGER;
  GIORNO INTEGER;
  FESTAGG integer;  
  FES VARCHAR2(1);
  LAV VARCHAR2(1);
  IGNORAFESTIVITA VARCHAR2(1);
  wNUMGG_LAV NUMBER(1);
BEGIN
  IF CANCELLA = 'S' THEN
    DELETE FROM T011_CALENDARI WHERE CODICE = COD AND DATA BETWEEN DAL AND AL;
  END IF;
  SELECT DOMENICA,LUNEDI,MARTEDI,MERCOLEDI,GIOVEDI,VENERDI,SABATO,NUMGG_LAV,IGNORAFEST_AUTO
    INTO GIORNI(1),GIORNI(2),GIORNI(3),GIORNI(4),GIORNI(5),GIORNI(6),GIORNI(7),wNUMGG_LAV,IGNORAFESTIVITA
    FROM T010_CALENDIMPOSTAZ 
   WHERE CODICE = COD;
  if wNUMGG_LAV is not null then
    NG:=wNUMGG_LAV;
  else   
    NG:=0;
    FOR I IN 1..7 LOOP
      IF GIORNI(I) = 'S' THEN
        NG:=NG + 1;
      END IF;
    END LOOP;
  end if;  
  DATACORR:=DAL;
  WHILE DATACORR <= AL LOOP
	FES:='N';
    ANNO:=TO_NUMBER(TO_CHAR(DATACORR,'YYYY'));
    MESE:=TO_NUMBER(TO_CHAR(DATACORR,'MM'));
    GIORNO:=TO_NUMBER(TO_CHAR(DATACORR,'DD'));
    LAV:=GIORNI(TO_NUMBER(TO_CHAR(DATACORR,'D'))); 
    if IGNORAFESTIVITA = 'N' then
      FES:=GETFESTIVITA(DATACORR); 
    end if;
    -- Santo Patrono
    select sum(x) into FESTAGG 
      from (select count(*) x
              from T013_FESTIVITA_AGGIUNTIVE
             where CODICE = COD
               and ANNO > 0
               and DATACORR = to_date(lpad(GIORNO,2,'0')||lpad(MESE,2,'0')||lpad(ANNO,4,'0'),'ddmmyyyy')
             union
            select count(*)
              from T013_FESTIVITA_AGGIUNTIVE
             where CODICE = COD
               and ANNO <= 0
               and DATACORR = to_date(lpad(GIORNO,2,'0')||lpad(MESE,2,'0')||to_char(DATACORR,'yyyy'),'ddmmyyyy'));
    if FESTAGG > 0 then
      FES:='S';
    end if;             
    BEGIN
      INSERT INTO T011_CALENDARI
        (CODICE,DATA,LAVORATIVO,FESTIVO,NUMGIORNI)
        VALUES
        (COD,DATACORR,LAV,FES,NG);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN NULL;
    END;
    DATACORR:=DATACORR + 1;
  END LOOP;
  COMMIT;
EXCEPTION
  WHEN NO_DATA_FOUND THEN NULL;
END GENERACAL;

END GENERACALENDARIO;
/