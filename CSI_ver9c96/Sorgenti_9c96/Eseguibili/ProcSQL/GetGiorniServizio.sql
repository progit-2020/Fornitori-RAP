create or replace procedure GetGiorniServizio(Prog  in number, InizioCumulo in out date, FineCumulo in date, Raggrup in varchar2, GS in out number, TR in out varchar2) as
  cursor c1 is 
    select distinct inizio,nvl(fine,to_date('31123999','ddmmyyyy')) fine, nvl(t450.tipo,'TI') tipo
    from t430_storico t430, t450_tiporapporto t450
    where 
    progressivo = Prog and
    t430.tiporapporto = t450.codice(+) and 
    inizio <= FineCumulo and nvl(Fine,InizioCumulo) >= InizioCumulo and
    t430.datadecorrenza = 
      (select max(datadecorrenza) from t430_storico where 
       progressivo = t430.progressivo and inizio = t430.inizio
       /* and datadecorrenza <= t430.inizio*/
       and datadecorrenza <= FineCumulo)
    order by inizio;
  PRIMO boolean; 
  TRCORR varchar2(2);
  NA number;
  NATOT number;
begin
  GS:=0;
  TR:='TI';
  -- Lettura del tipo di rapporto valido al FineCumulo
  begin
    select nvl(t450.tipo,'TI') into TR
    from t430_storico t430,t450_tiporapporto t450
    where 
    t430.progressivo = Prog and
    t430.tiporapporto = t450.codice(+) and
    t430.inizio =
      (select max(inizio) from t430_storico where 
       progressivo = t430.progressivo and 
       inizio <= FineCumulo and nvl(Fine,add_months(FineCumulo,-12) + 1) >= add_months(FineCumulo,-12) + 1)
    and
    t430.datadecorrenza = 
      (select max(datadecorrenza) from t430_storico where 
       progressivo = t430.progressivo and 
       inizio = t430.inizio and 
       datadecorrenza <= FineCumulo);
  exception
    when no_data_found then
      TR:='TI';
  end;
  -- Se tempo determinato si sposta InizioCumulo un anno prima di FineCumulo
  if TR in ('I','S') then
    TR:='TD';
    InizioCumulo:=add_months(FineCumulo,-12) + 1;
  else
    TR:='TI';
  end if;
  NATOT:=0;
  PRIMO:=true;
  -- Se tempo determinato cumulo i giorni di servizio tra InizioCumulo e FineCumulo
  for t1 in c1 loop
    TRCORR:=t1.tipo;  
    if TRCORR in ('I','S') then
      TRCORR:='TD';
    else
      TRCORR:='TI';
    end if;
    if TR = TRCORR then
      if PRIMO and (t1.inizio > InizioCumulo) then
        InizioCumulo:=t1.inizio;
      end if;    
      PRIMO:=false;
      if TR = 'TD' then
        if t1.inizio < InizioCumulo then
          t1.inizio:=InizioCumulo;
        end if;
        if t1.fine > FineCumulo then
          t1.fine:=FineCumulo;
        end if;
        --Lettura dei giorni di assenza che non devono essere considerati come lavorativi
        select nvl(sum(decode(tipogiust,'I',1,'M',0.5)),0) into NA
        from T040_GIUSTIFICATIVI
        where progressivo = Prog
          and data between t1.inizio and t1.fine 
          and causale in 
              (select codice from t265_cauassenze where ABBATTE_GGSERV_TEMPODET = 'S');
        GS:=GS + Trunc(t1.fine) - Trunc(t1.inizio) + 1 - NA;
      end if;
    end if;
  end loop;
  --GS:=GS - NATOT;
end GetGiorniServizio;
/
