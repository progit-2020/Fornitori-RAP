create or replace package body T080PCK_TURNO is

IDATA date;
INDCICLO integer;
FIRSTTIME boolean;
RET varchar2(5);
MYPART integer;
DATO_TROVATO boolean;
OUT_TURNO1 varchar2(5);
OUT_ORARIO varchar2(5);
OUT_TURNAZIONE varchar2(5);
OUT_PARTENZA number(38,2);

procedure GETCICLO(INCICLO in string, D_INIZIO date) is
  cursor C2(CCICLO in varchar2) is
    select T611.*
      from T611_CICLIGIORNALIERI T611
     where T611.CICLO = CCICLO
     order by T611.GIORNO;
begin
  if INCICLO is not null then
    for T2 in C2(INCICLO) loop
      if not FIRSTTIME or (INDCICLO >= MYPART) then
        if IDATA = D_INIZIO then
          RET:=T2.TURNO1;
          OUT_ORARIO:=T2.ORARIO;          
          DATO_TROVATO:=TRUE;
          OUT_PARTENZA:=INDCICLO;
          if OUT_TURNO1 = '99999' then
            OUT_TURNO1:=T2.TURNO1;
          end if;
          RETURN;
        end if;
        IDATA:=IDATA + 1;
      end if;
      INDCICLO:=INDCICLO + 1;
    end loop;
  end if;
end;

procedure GETDATO_GENERICO(INPROG in integer,INDATA in DATE) is
  cursor C1(TURNAZ in varchar2) is
    select T641.*
      from T641_MOLTTURNAZIONE T641
     where T641.TURNAZIONE = TURNAZ
     order by T641.TURNAZIONE, T641.ORDINE;
  MYTURNAZIONE varchar2(5);
  ori_IDATA date;
  ori_INDCICLO integer;
begin
  begin
    select T620.DATA, T620.TURNAZIONE, T620.PARTENZA into IDATA, MYTURNAZIONE, MYPART
      from T620_TURNAZIND T620
     where T620.PROGRESSIVO = INPROG
       and T620.DATA = (select max(DATA)
                          from T620_TURNAZIND
                         where PROGRESSIVO = T620.PROGRESSIVO
                           and DATA <= INDATA);
  exception
    when NO_DATA_FOUND then
    begin
      OUT_TURNO1:='99999';
      return;
    end;
  end;
  FIRSTTIME:=TRUE;
  /*New*/
  DATO_TROVATO:=FALSE;
  /*---*/
  while 1 = 1 loop
    INDCICLO:=1;
    ori_IDATA:=IDATA;
    ori_INDCICLO:=INDCICLO;
    /*Scorro tabella T641(turnazione dei cicli)*/
    for T1 in C1(MYTURNAZIONE) loop
      OUT_TURNAZIONE:=MYTURNAZIONE;
      /*Moltiplico turnazione in base ad un eventuale numero specificato
        nel campo multiplo*/
      for i in 1..T1.MULTIPLO loop
        /*Sviluppo ciclo n°1*/                  
        GETCICLO(T1.CICLO1,INDATA);
        if DATO_TROVATO and IDATA = INDATA then
          return;
        end if;
        /*Sviluppo ciclo n°2*/                          
        GETCICLO(T1.CICLO2,INDATA);
        if DATO_TROVATO and IDATA = INDATA then
          return;
        end if;
        /*Sviluppo ciclo n°3*/                          
        GETCICLO(T1.CICLO3,INDATA);
        if DATO_TROVATO and IDATA = INDATA then
          return;
        end if;
        /*Sviluppo ciclo n°4*/                          
        GETCICLO(T1.CICLO4,INDATA);
        if DATO_TROVATO and IDATA = INDATA then
          return;
        end if;
        /*Sviluppo ciclo n°5*/                          
        GETCICLO(T1.CICLO5,INDATA);
        if DATO_TROVATO and IDATA = INDATA then
          return;
        end if;        
      end loop;
    end loop;
    FIRSTTIME:=FALSE;
    if (ori_IDATA = IDATA) and (ori_INDCICLO = INDCICLO) then
      OUT_TURNO1:='99999';
      return;
    end if;
  end loop;
end;

function GETPARTENZA return number is
begin
  return OUT_PARTENZA;
end;

procedure GETNTURNO_PIANIF(INPROG in integer,INDATA in DATE,TIPO in varchar2) is
begin
  if TIPO = 'O' then
    begin
      select T080.TURNO1, T080.ORARIO into OUT_TURNO1, OUT_ORARIO
        from T080_PIANIFORARI T080
       where T080.PROGRESSIVO = INPROG
         and T080.DATA = INDATA;
    exception
      when NO_DATA_FOUND then
        null;
    end;
  elsif TIPO = 'N' then
    begin
      select T081.TURNO1, T081.ORARIO into OUT_TURNO1, OUT_ORARIO
        from T081_PROVVISORIO T081
       where T081.PROGRESSIVO = INPROG
         and T081.DATA = INDATA
         and T081.FLAGAGG in ('N','I');
    exception
      when NO_DATA_FOUND then
        null;
    end;
  end if;
end;

function GETORARIO(INPROG in integer,INDATA in DATE,INTIPO in varchar2) return varchar2 is
/*TIPO(tipo pianificazione):
      O = operativa
      N = non operativa*/
begin
  OUT_TURNO1:='99999';
  OUT_TURNAZIONE:=null;
  OUT_PARTENZA:=-1;
  OUT_ORARIO:='';
  GETNTURNO_PIANIF(INPROG,INDATA,INTIPO);
  if OUT_ORARIO is null then
    GETDATO_GENERICO(INPROG,INDATA);
  end if;
  return OUT_ORARIO;
end GETORARIO; 

function GETNTURNO(INPROG in integer,INDATA in DATE,INTIPO in varchar2) return varchar2 is
/*TIPO(tipo pianificazione):
      O = operativa
      N = non operativa*/
begin
  OUT_TURNO1:='99999';
  OUT_TURNAZIONE:=null;
  OUT_PARTENZA:=-1;
  OUT_ORARIO:='';
  GETNTURNO_PIANIF(INPROG,INDATA,INTIPO);
  if OUT_TURNO1 = '99999' then
    GETDATO_GENERICO(INPROG,INDATA);
  end if;
  return OUT_TURNO1;
end GETNTURNO;

procedure GETDATIGENERICI(INPROG in integer,INDATA in DATE) is
/*TIPO(tipo pianificazione):
      O = operativa
      N = non operativa*/
begin
  OUT_TURNO1:='99999';
  OUT_TURNAZIONE:=null;
  OUT_PARTENZA:=-1;
  GETDATO_GENERICO(INPROG,INDATA);
end GETDATIGENERICI;

function COPIATURNO(PROGORIG in integer, PROGDEST in integer, DATAINIZIO in date, DATAFINE in date) return varchar2 is
  MYDATAFINE date;
  T620COUNT integer;
begin
  MYDATAFINE:=DATAFINE + 1;
  select count(*) into T620COUNT
    from T620_TURNAZIND T620
   where T620.PROGRESSIVO = PROGDEST
     and T620.DATA = MYDATAFINE;
  if T620COUNT > 0 then
    return 'In data '||to_char(MYDATAFINE)||' è già presente una pianificazione.';
  end if;
  begin
    /*Data fine periodo copia*/
    GETDATIGENERICI(PROGDEST,MYDATAFINE);
    insert into T620_TURNAZIND(PROGRESSIVO,DATA,TURNAZIONE,PARTENZA)
    select PROGDEST, MYDATAFINE, OUT_TURNAZIONE, OUT_PARTENZA
      from T620_TURNAZIND T620
     where T620.PROGRESSIVO = PROGDEST
       and T620.DATA = (select max(DATA)
                         from T620_TURNAZIND
                        where PROGRESSIVO = T620.PROGRESSIVO
                          and DATA < MYDATAFINE);
  exception
    when OTHERS then
      return 'Si è verificato un errore in fase di inserimento in data '||MYDATAFINE;
  end;

  select count(*) into T620COUNT
    from T620_TURNAZIND T620
   where T620.PROGRESSIVO = PROGDEST
     and T620.DATA = DATAINIZIO;
  if T620COUNT > 0 then
    rollback;
    return 'In data '||MYDATAFINE||' è già presente una pianificazione.';
  end if;

  begin
    /*Data inizio periodo copia*/
    GETDATIGENERICI(PROGORIG,DATAINIZIO);
    insert into T620_TURNAZIND(PROGRESSIVO,DATA,TURNAZIONE,PARTENZA)
    select PROGDEST, DATAINIZIO, OUT_TURNAZIONE, OUT_PARTENZA
      from T620_TURNAZIND T620
     where T620.PROGRESSIVO = PROGDEST
       and T620.DATA = (select max(DATA)
                          from T620_TURNAZIND
                         where PROGRESSIVO = T620.PROGRESSIVO
                           and DATA < DATAINIZIO);
  exception
    when OTHERS then
    begin
      rollback;
      return 'Si è verificato un errore in fase di inserimento in data '||to_char(MYDATAFINE);
    end;
  end;
  return '';
end;
/*TIPO(tipo pianificazione):
      O = operativa
      N = non operativa*/
/*function GETNTURNO(INPROG in integer,INDATA in DATE,TIPO in varchar2) return varchar2 is
  cursor C1(TURNAZ in varchar2) is
    select T641.*
      from T641_MOLTTURNAZIONE T641
     where T641.TURNAZIONE = TURNAZ
     order by T641.TURNAZIONE, T641.ORDINE;
  I integer;
  --CICLO boolean;
  ori_IDATA date;
  ori_INDCICLO integer;
  MYTURNAZIONE varchar2(5);
begin
  if TIPO = 'O' then
    begin
      select T080.TURNO1 into RET
        from T080_PIANIFORARI T080
       where T080.PROGRESSIVO = INPROG
         and T080.DATA = INDATA;
      return RET;
    exception
      when NO_DATA_FOUND then
        null;
    end;
  elsif TIPO = 'N' then
    begin
      select T081.TURNO1 into RET
        from T081_PROVVISORIO T081
       where T081.PROGRESSIVO = INPROG
         and T081.DATA = INDATA
         and T081.FLAGAGG in ('N','I');
      return RET;
    exception
      when NO_DATA_FOUND then
        null;
    end;
  end if;

  begin
    select T620.DATA, T620.TURNAZIONE, T620.PARTENZA into IDATA, MYTURNAZIONE, MYPART
      from T620_TURNAZIND T620
     where T620.PROGRESSIVO = INPROG
       and T620.DATA = (select max(DATA)
                          from T620_TURNAZIND
                         where PROGRESSIVO = T620.PROGRESSIVO
                           and DATA <= INDATA);
  exception
    when NO_DATA_FOUND then
      return 999999;
  end;
  FIRSTTIME:=TRUE;
  while (1 = 1) loop
    INDCICLO:=1;
    ori_IDATA:=IDATA;
    ori_INDCICLO:=INDCICLO;
    for T1 in C1(MYTURNAZIONE) loop
      RET:='';
      for i in 1..T1.MULTIPLO loop
        GETCICLO(T1.CICLO1,INDATA);
        if (RET is not null) or (IDATA = INDATA) then
          return RET;
        end if;
        GETCICLO(T1.CICLO2,INDATA);
        if (RET is not null) or (IDATA = INDATA) then
          return RET;
        end if;
        GETCICLO(T1.CICLO3,INDATA);
        if (RET is not null) or (IDATA = INDATA) then
          return RET;
        end if;
        GETCICLO(T1.CICLO4,INDATA);
        if (RET is not null) or (IDATA = INDATA) then
          return RET;
        end if;
      end loop;
    end loop;
    FIRSTTIME:=FALSE;
    if (ori_IDATA = IDATA) and (ori_INDCICLO = INDCICLO) then
      return 999999;
    end if;
  end loop;
end GETNTURNO;*/

end T080PCK_TURNO;
