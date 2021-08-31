create or replace function CONTROLLO_RIPOSI(prog in integer,data_conteggio in date,causali_scart in string, causali_abb in string default '', causali_rep in varchar2 default '') return integer is
  cursor c1 is
    select T.*,T.ROWID from VT100_TIMB_DATAORA T
     where PROGRESSIVO = PROG
     and verso = 'E'
     and (CAUSALE is null or
          (instr(','||CAUSALI_SCART||',',','||CAUSALE||',') = 0 and
           instr(','||CAUSALI_ABB||',',','||CAUSALE||',') = 0)
         )
     and DATA = DATA_CONTEGGIO
     order by ORA;

  cursor c2(P_DATAORA DATE) is
    select T.*,T.ROWID from VT100_TIMB_DATAORA T
     where PROGRESSIVO = PROG
     and DATAORA >= DATA_CONTEGGIO - 1 and DATAORA < P_DATAORA
     order by DATAORA desc;

  cursor c3(d1 date, d2 date) is
     select T.* from VT380_REP_DATAORA T
     where PROGRESSIVO = PROG
     and DATA between trunc(d1)-1 and trunc(d2)
     and ORAINIZIO < d2 and ORAFINE > d1
     order by ORAINIZIO;

  intervallo number;
  abbattimento number;
  intervallo_max number;
  ultimo_verso varchar2(1);
  ultima_dataora date;
  ultima_causale varchar2(5);
  anomalia varchar2(1);
  int_i date;
  int_f date;
  uscita date;
begin
  intervallo_max:=0;
  intervallo:=1;
  --Ciclo sulle entrate fatte nel giorno
  for t1 in c1 loop
    intervallo:=1 + t1.DATAORA - t1.DATA;
    abbattimento:=0;
    anomalia:=null;
    ultimo_verso:='E';
    ultima_dataora:=t1.DATAORA;
    ultima_causale:=t1.CAUSALE;
    --Per ogni entrata ciclo sulle timbrature precedenti fino al giorno prima
    --calcolo l'intervallo dall'uscita precedente; poi nel giorno considererò l'intervallo massimo
    for t2 in c2(t1.DATAORA) loop
      if t2.VERSO = ultimo_verso then
        anomalia:='S';
        exit;
      end if;
      if t2.VERSO = 'U' then
        --se causale nulla o consentita, considero l'uscita e calcolo l'intervallo
        if t2.CAUSALE is null or ((instr(','||CAUSALI_SCART||',',','||t2.CAUSALE||',') = 0) and
                                  (instr(','||CAUSALI_ABB||',',','||t2.CAUSALE||',') = 0)) then
          intervallo:=t1.DATAORA - t2.DATAORA;
          exit;
        end if;
      else --Verso = 'E' e esiste causalizzazione, si valuta se l'intervallo E-U è coperto da turno di reperibilità
        int_i:=t2.DATAORA;
        int_f:=ultima_dataora;
        if (t2.CAUSALE is not null and (instr(','||CAUSALI_REP||',',','||t2.CAUSALE||',') > 0)) or
           (ultima_causale is not null and (instr(','||CAUSALI_REP||',',','||ultima_causale||',') > 0)) then
          for t3 in c3(int_i,int_f) loop
            int_i:=greatest(int_i,t3.orainizio);
            int_f:=least(int_f,t3.orafine);
          end loop;
        end if;
        --Verifico se il turno di reperibilità ha ristretto la coppia E-U, nel qual caso considero l'uscita dal servizio
        uscita:=null;
        if int_f = ultima_dataora and int_i > t2.DATAORA then
          uscita:=int_i;
        elsif int_f < ultima_dataora then
          uscita:=int_f;
        end if;
        --riconosco se l'intervallo fatto in turno deve abbattere l'intervallo di riposo o può essere scartato (in base alla causale)
        if ((ultima_causale is not null and instr(','||CAUSALI_ABB||',',','||ultima_causale||',') > 0) or
            (t2.CAUSALE is not null and instr(','||CAUSALI_ABB||',',','||t2.CAUSALE||',') > 0)) then
          abbattimento:=abbattimento + int_f - nvl(uscita,int_i);
        end if;
        --se l'intervallo è causalizzato, ma risulta spezzato per via del turno di reperibilità, allora 'uscita' è valorizzato con l'uscita calcolata utile al calcolo dell'intervallo
        if uscita is not null then
          intervallo:=t1.DATAORA - uscita;
          exit;
        end if;
      end if;
      --registro l'ultima timbratura per considerarla poi accoppiata alla prossima (se questa è un'uscita)
      ultimo_verso:=t2.VERSO;
      ultima_dataora:=t2.DATAORA;
      ultima_causale:=t2.CAUSALE;
    end loop;
    if anomalia is not null then
      exit;
    end if;
    intervallo:=intervallo - abbattimento;
    if intervallo > intervallo_max then
      intervallo_max:=intervallo;
    end if;
  end loop;
  --rifaccio il controllo sull'intervallo per gestire il caso in cui non ci siano timbrature valide nel giorno
  if intervallo > intervallo_max then
    intervallo_max:=intervallo;
  end if;
  if anomalia is not null then
    intervallo_max:=-1;
    return intervallo_max;
  else
    return trunc(intervallo_max*1440);
  end if;
end CONTROLLO_RIPOSI;
/
