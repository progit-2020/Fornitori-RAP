create or replace function L133ServeCertificPubbl(p_progressivo in integer, p_data1 in date, p_data2 in date) return varchar2 is
  cursor c1 is
    select data from t040_giustificativi t040
    where progressivo = p_progressivo
      and data between greatest(trunc(p_data1,'yyyy'),to_date('25062008','ddmmyyyy')) and p_data1 - 1
      and causale in (select codice from t265_cauassenze where codcau3 is not null
                      union
                      select codcau3 from t265_cauassenze)
    order by data;
  d date;
  ip date;
  np integer;
  r varchar2(1);
begin
  np:=0;
  d:=null;
  ip:=null;
  r:='N';
  --Verifica se il periodo in inserimento è maggiore di 10 giorni
  if p_data2 - p_data1 >= 10 then
    r:='S';
    return r;
  end if;
  for t1 in c1 loop
    if d is null then
      ip:=t1.data;
    end if;
    if (d is not null) and (t1.data > d + 1) then
      ip:=t1.data;
    end if;
    d:=t1.data;
    --Verifica se l'ultimo periodo si collega a quello in inserimento, e il totale è un periodo di oltre 10 giorni
    if (d = p_data1 - 1) and (p_data2 - ip >= 10) then
      r:='S';
      exit;
    end if;
  end loop;
  return r;
end;
/