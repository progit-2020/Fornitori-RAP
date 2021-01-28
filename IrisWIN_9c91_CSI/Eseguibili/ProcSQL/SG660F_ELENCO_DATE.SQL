create or replace function SG660F_ELENCO_DATE (PCodice in varchar2, PEdizione in varchar2) return varchar2 is
  cursor c1 is
    SELECT data_giorno
    FROM sg660_calendariocorsi
    WHERE cod_corso = PCodice AND edizione = PEdizione
    ORDER BY data_giorno;
  Lista varchar2(5000);
begin
  for t1 in c1 loop
    if Lista is not null then
       Lista:=Lista || ', ';
    end if;
    Lista:=Lista || to_char(t1.data_giorno,'dd/mm/yyyy');
  end loop;

  if instr(Lista,',') = 0 then
     Lista:='il ' || Lista;
  else
     Lista:='i giorni ' || Lista;
  end if;

  return Lista;
end;
/
