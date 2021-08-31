create or replace procedure L133DieciGiorniDopo(p_progressivo in integer, p_data in date, p_ggmodif in out integer) is
  cursor c1(d date) is
    select T040.*,rowid from T040_GIUSTIFICATIVI T040 
    where PROGRESSIVO = p_progressivo 
    and DATA = d 
    --and TIPOGIUST = 'I'
    and T230F_CHECK_SCARICOPAGHE_FRUIZ(T040.CAUSALE,T040.DATA,T040.TIPOGIUST) = 'S'
    ;
  d date;
  c2 varchar2(5);
  gglav varchar2(1);
  ggfes varchar2(1);
  ggcalendario varchar2(2);
  causperiodi varchar2(500);
  numgg integer;
  numggnonlav integer;
  ggnonlav boolean;
  continua boolean;
begin
  d:=p_data + 1;
  continua:=true;
  numggnonlav:=0;
  ggnonlav:=false;
  p_ggmodif:=0;
  while continua loop
    continua:=false;
    for t1 in c1(d) loop
      select CODCAU3,CODCAU2,GSIGNIFIC into c2,causperiodi,ggcalendario from T265_CAUASSENZE where CODICE = t1.causale;
      if c2 is not null then
        if ggnonlav and (ggcalendario = 'GC') then
          ggnonlav:=false;
          exit;
        end if;
        ggnonlav:=false;
        continua:=true;
        if causperiodi is null then
          causperiodi:=t1.causale||','||c2;
        else
          causperiodi:=t1.causale||','||c2||','||causperiodi;
        end if;
        causperiodi:=''''||replace(causperiodi,',',''',''')||'''';
        L133DieciGiorniPrima(p_progressivo, d, ggcalendario, causperiodi, numgg);
        if d >= to_date('25062008','ddmmyyyy') and numgg < 10 then
          update T040_GIUSTIFICATIVI set CAUSALE = c2 where ROWID = t1.rowid;
          p_ggmodif:=p_ggmodif + 1;
          genera_periodi_assenza(p_progressivo, d, d, t1.causale, t1.tipogiust, to_char(t1.daore,'hh24.mi'), to_char(t1.aore,'hh24.mi'), 'C');
          genera_periodi_assenza(p_progressivo, d, d, c2, t1.tipogiust, to_char(t1.daore,'hh24.mi'), to_char(t1.aore,'hh24.mi'), 'I');
        end if;
      else
        begin
          select CODICE,CODCAU2,GSIGNIFIC into c2,causperiodi,ggcalendario from T265_CAUASSENZE where CODCAU3 = t1.causale;
        exception
          when others then c2:=null;
        end;
        if c2 is not null then
          if ggnonlav and (ggcalendario = 'GC') then
            ggnonlav:=false;
            exit;
          end if;
          ggnonlav:=false;
          continua:=true;
          if causperiodi is null then
            causperiodi:=t1.causale||','||c2;
          else
            causperiodi:=t1.causale||','||c2||','||causperiodi;
          end if;
          causperiodi:=''''||replace(causperiodi,',',''',''')||'''';
          L133DieciGiorniPrima(p_progressivo, d, ggcalendario, causperiodi, numgg);
          if d >= to_date('25062008','ddmmyyyy') and numgg >= 10 then
            update T040_GIUSTIFICATIVI set CAUSALE = c2 where ROWID = t1.rowid;
            p_ggmodif:=p_ggmodif + 1;
            genera_periodi_assenza(p_progressivo, d, d, t1.causale, t1.tipogiust, to_char(t1.daore,'hh24.mi'), to_char(t1.aore,'hh24.mi'), 'C');
            genera_periodi_assenza(p_progressivo, d, d, c2, t1.tipogiust, to_char(t1.daore,'hh24.mi'), to_char(t1.aore,'hh24.mi'), 'I');
          end if;
        end if;
      end if;
    end loop;
    ggnonlav:=false;
    --Se giorni di significatività non da calendario e il giorno non è lavorativo, si ignora l'interruzione allacciandosi al periodo successivo ai giorni non lavorativi
    if not continua /*and ggcalendario <> 'GC'*/ then
      select lavorativo,festivo into gglav,ggfes from v010_calendari where progressivo = p_progressivo and data = d;
      if gglav = 'N' or (ggfes = 'S' and ggcalendario <> 'GC') then
        continua:=true;
        numggnonlav:=numggnonlav + 1;
        ggnonlav:=true;
      end if;  
    end if;
    d:=d + 1;
    if d - p_data - numggnonlav > 10 then
      continua:=false;
    end if;
  end loop;
exception
  when no_data_found then
    null;
end;
/