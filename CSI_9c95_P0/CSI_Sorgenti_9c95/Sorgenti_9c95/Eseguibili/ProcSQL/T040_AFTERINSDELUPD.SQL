CREATE OR REPLACE TRIGGER T040_AFTERUPDINSDEL
  after delete or insert or update on t040_giustificativi
  for each row
declare
 regsto varchar2(1);
 validaz varchar2(1);
 vocepaghe varchar2(1);
 f varchar2(1);
 l varchar2(1);
 monteore varchar2(5);
 g number;
 oregg number;
 nore number;
 datanull date;
begin
  datanull:=to_date('0101900','ddmmyyyy');
  if deleting then
    select nvl(max(registra_storico),'N'),nvl(max(validazione),'N') 
    into regsto,validaz 
    from t265_cauassenze 
    where codice = :old.causale
    and T230F_CHECK_SCARICOPAGHE_FRUIZ(:old.causale,:old.data,:old.tipogiust) = 'S';
    if regsto = 'S' then
      insert into t044_storicogiustificativi
        (progressivo,data,causale,datanas,tipogiust,daore,aore,operazione,data_agg,id,
         ore_gg_medio)
      select :old.progressivo,:old.data,:old.causale,:old.datanas,:old.tipogiust,:old.daore,:old.aore,'C',sysdate,
        T044_ID.nextval,t044a.ore_gg_medio
      from t044_storicogiustificativi t044a where t044a.progressivo = :old.progressivo and t044a.data = :old.data
        and t044a.causale = :old.causale and t044a.tipogiust = :old.tipogiust and nvl(t044a.daore,datanull) = nvl(:old.daore,datanull)
        and nvl(t044a.aore,datanull) = nvl(:old.aore,datanull) and t044a.operazione = 'I'
        and t044a.data_agg = (select max(data_agg) from t044_storicogiustificativi t044b
          where t044b.progressivo = t044a.progressivo and t044b.data = t044a.data
          and t044b.causale = t044a.causale and t044b.tipogiust = t044a.tipogiust
          and nvl(t044b.daore,datanull) = nvl(t044a.daore,datanull) and nvl(t044b.aore,datanull) = nvl(t044a.aore,datanull) and t044b.operazione = 'I'
          and t044b.data_agg <= sysdate);
    end if;
  elsif inserting then
    oregg:=0;
    select decode(nvl(max(vocepaghe),' '),' ','N','S'),nvl(max(validazione),'N') into vocepaghe,validaz from t265_cauassenze where codice = :new.causale;
    if vocepaghe = 'S' and validaz = 'N' then
      getcalendario(:new.progressivo, :new.data,f,l,g,monteore);
      if g <> 0 then
        oregg:=oreminuti(monteore)/g;
      end if;
      if :new.tipogiust = 'D' then
        nore:=oreminuti(to_char(:new.aore,'hh24.mi')) - oreminuti(to_char(:new.daore,'hh24.mi'));
      else
        oregg:=0;
      end if;
    end if;
    insert into t044_storicogiustificativi
      (progressivo,data,causale,datanas,tipogiust,daore,aore,operazione,data_agg,id,
       ore_gg_medio)
    select :new.progressivo,:new.data,:new.causale,:new.datanas,:new.tipogiust,:new.daore,:new.aore,'I',sysdate,
      T044_ID.nextval,decode(oregg,0,null,round(nore/oregg,5))
      from t265_cauassenze 
      where codice = :new.causale 
      and registra_storico = 'S' 
      and T230F_CHECK_SCARICOPAGHE_FRUIZ(:new.causale,:new.data,:new.tipogiust) = 'S'
      and (nvl(validazione,'N') = 'N' or nvl(:new.scheda,'*') = 'V');
  elsif updating then
    if :old.data <> :new.data or :old.causale <> :new.causale or :old.tipogiust <> :new.tipogiust or :old.daore <> :new.daore or :old.aore <> :new.aore then
      select nvl(max(registra_storico),'N'),nvl(max(validazione),'N') into regsto,validaz from t265_cauassenze 
      where codice = :old.causale
      and T230F_CHECK_SCARICOPAGHE_FRUIZ(:old.causale,:old.data,:old.tipogiust) = 'S';
      if regsto = 'S' then
        insert into t044_storicogiustificativi
          (progressivo,data,causale,datanas,tipogiust,daore,aore,operazione,data_agg,id,
           ore_gg_medio)
          select :old.progressivo,:old.data,:old.causale,:old.datanas,:old.tipogiust,:old.daore,:old.aore,'C',sysdate,
            T044_ID.nextval,t044a.ore_gg_medio
          from t044_storicogiustificativi t044a where t044a.progressivo = :old.progressivo and t044a.data = :old.data
            and t044a.causale = :old.causale and t044a.tipogiust = :old.tipogiust and nvl(t044a.daore,datanull) = nvl(:old.daore,datanull)
            and nvl(t044a.aore,datanull) = nvl(:old.aore,datanull) and t044a.operazione = 'I'
            and (validaz = 'N' or nvl(:old.scheda,'*') = 'V')
            and t044a.data_agg = (select max(data_agg) from t044_storicogiustificativi t044b
              where t044b.progressivo = t044a.progressivo and t044b.data = t044a.data
              and t044b.causale = t044a.causale and t044b.tipogiust = t044a.tipogiust
              and nvl(t044b.daore,datanull) = nvl(t044a.daore,datanull) and nvl(t044b.aore,datanull) = nvl(t044a.aore,datanull) and t044b.operazione = 'I'
              and t044b.data_agg <= sysdate);
      end if;
      oregg:=0;
      select decode(nvl(max(vocepaghe),' '),' ','N','S') into vocepaghe from t265_cauassenze where codice = :new.causale;
      if vocepaghe = 'S' then
        getcalendario(:new.progressivo, :new.data,f,l,g,monteore);
        if g <> 0 then
          oregg:=oreminuti(monteore)/g;
        end if;
        if :new.tipogiust = 'D' then
          nore:=oreminuti(to_char(:new.aore,'hh24.mi')) - oreminuti(to_char(:new.daore,'hh24.mi'));
        else
          oregg:=0;
        end if;
      end if;
      insert into t044_storicogiustificativi
        (progressivo,data,causale,datanas,tipogiust,daore,aore,operazione,data_agg,
         id,ore_gg_medio)
        select :new.progressivo,:new.data,:new.causale,:new.datanas,:new.tipogiust,:new.daore,:new.aore,'I',sysdate,
          T044_ID.nextval,decode(oregg,0,null,round(nore/oregg,5))
          from t265_cauassenze 
          where codice = :new.causale 
          and registra_storico = 'S' 
          and T230F_CHECK_SCARICOPAGHE_FRUIZ(:new.causale,:new.data,:new.tipogiust) = 'S'
          and (nvl(validazione,'N') = 'N' or nvl(:new.scheda,'*') = 'V');
    end if;
    if nvl(:old.scheda,'*') <> nvl(:new.scheda,'*') and :new.scheda = 'V' then
      oregg:=0;
      select decode(nvl(max(vocepaghe),' '),' ','N','S') into vocepaghe from t265_cauassenze where codice = :new.causale;
      if vocepaghe = 'S' then
        getcalendario(:new.progressivo, :new.data,f,l,g,monteore);
        if g <> 0 then
          oregg:=oreminuti(monteore)/g;
        end if;
        if :new.tipogiust = 'D' then
          nore:=oreminuti(to_char(:new.aore,'hh24.mi')) - oreminuti(to_char(:new.daore,'hh24.mi'));
        else
          oregg:=0;
        end if;
      end if;
      insert into t044_storicogiustificativi
        (progressivo,data,causale,datanas,tipogiust,daore,aore,operazione,data_agg,
         id,ore_gg_medio)
        select :new.progressivo,:new.data,:new.causale,:new.datanas,:new.tipogiust,:new.daore,:new.aore,'I',sysdate,
          T044_ID.nextval,decode(oregg,0,null,round(nore/oregg,5))
          from t265_cauassenze 
          where codice = :new.causale 
          and registra_storico = 'S' 
          and T230F_CHECK_SCARICOPAGHE_FRUIZ(:new.causale,:new.data,:new.tipogiust) = 'S'
          and (nvl(validazione,'N') = 'N' or nvl(:new.scheda,'*') = 'V');
    end if;
  end if;
end T040_AFTERUPDINSDEL;
/
