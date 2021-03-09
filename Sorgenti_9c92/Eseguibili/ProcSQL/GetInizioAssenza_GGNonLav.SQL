create or replace procedure GETINIZIOASSENZA_GGNONLAV(P_PROGRESSIVO in integer, P_DATA in out date, P_CAUSNEW in out varchar2, P_CAUSALI in
varchar2) as
  i integer;
  d date;
  dal date;
  lav varchar2(1);
  causold varchar2(5);
  cc varchar2(1000);
  ic_new varchar2(5);
  ic_old varchar2(5);
begin
  dal:=P_DATA;
  d:=dal;
  lav:='N';
  d:=dal - 1;
  while d >= dal - 6 loop
    begin
      --verifico se non lavorativo da calendario
      select decode(LAVORATIVO,'S',decode(FESTIVO,'S','N','S'),'N')
      into lav
      from V010_CALENDARI
      where PROGRESSIVO = P_PROGRESSIVO and DATA = d;
    exception
      when others then
        P_DATA:=dal;
        exit;
    end;
    if lav = 'S' then
      --verifico se turnista, e se pianificato o giustificato un riposo (o rip.comp.)
      select
DECODE(MAX(NVL(T080.TURNO1,NVL(T260.CODINTERNO,T260B.CODINTERNO))),null,'S','N')
GGLAV into lav
      from T430_STORICO T430, T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260, T260_RAGGRASSENZE T260B, T080_PIANIFORARI T080
      where T430.PROGRESSIVO = P_PROGRESSIVO
      and   d between T430.DATADECORRENZA and T430.DATAFINE
      and   T430.TGESTIONE = '1'
      and   T430.PROGRESSIVO = T040.PROGRESSIVO(+)
      and   d = T040.DATA(+)
      and   T040.CAUSALE = T265.CODICE(+)
      and   T265.CODRAGGR = T260.CODICE(+)
      and   T260.CODINTERNO(+) = 'E'
      and   T265.CODRAGGR = T260B.CODICE(+)
      and   T260B.CODINTERNO(+) = 'H'
      and   T430.PROGRESSIVO = T080.PROGRESSIVO(+)
      and   d = T080.DATA(+)
      and   T080.TURNO1(+) = '0';
      if lav = 'S' then
        exit;
      end if;
    end if;
    select count(*) into i from T100_TIMBRATURE
    where PROGRESSIVO = P_PROGRESSIVO and DATA = d and FLAG in ('O','I');
    if i = 0 then
      select count(*) into i from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265, T260_RAGGRASSENZE T260
      where T040.PROGRESSIVO = P_PROGRESSIVO
      and   T040.DATA = d
      and   T040.CAUSALE = T265.CODICE
      and   T265.CODRAGGR = T260.CODICE
      and   T260.CODINTERNO not in ('E','H')
      --and   T265.CODICE not in ('RPA','RPP')
      and   T265.CODICE not in
             (select NVL(RICALCOLO_CAUS_NEG, '      ') from T020_ORARI
              union
              select NVL(RICALCOLO_CAUS_POS, '      ') from T020_ORARI);
    end if;
    if i > 0 then
      exit;
    end if;
    P_DATA:=d;
    d:=d - 1;
  end loop;
  if P_DATA < dal then
    select max(CAUSALE) into causold from T040_GIUSTIFICATIVI
    where PROGRESSIVO = P_PROGRESSIVO
      and DATA = P_DATA-1 and TIPOGIUST = 'I'
      and instr(','||P_CAUSALI||',',','||CAUSALE||',') > 0;
    if causold is null then
      P_DATA:=dal;
    else
      cc:=null;
      ic_new:=T265F_GETINIZIOCATENA(P_CAUSNEW,cc);
      cc:=null;
      ic_old:=T265F_GETINIZIOCATENA(causold,cc);
      if ic_new <> ic_old then
        begin
          select COD_INS into P_CAUSNEW from T268_CONCAT_PERIODI_GGNONLAV where COD_OLD = ic_old and COD_NEW = ic_new and COD_INS <> COD_NEW;
        exception
          when others then null;
        end;
      end if;
    end if;
  end if;
exception
  when others then null;
end;
/