create or replace function T020F_USO_RICALCOLO_DEBITO(P_PROGRESSIVO in integer, P_DATA1 in date, P_DATA2 in date) return varchar2 as
  result varchar2(1);
  c integer;
begin
  select count(*) into c
  from V010_CALENDARI V010, T430_STORICO T430, T220_PROFILIORARI T220, T221_PROFILISETTIMANA T221, T020_ORARI T020
  where V010.PROGRESSIVO = P_PROGRESSIVO
  --and   V010.DATA between P_DATA  - 6 and P_DATA - 1
  and   V010.DATA between P_DATA1  and P_DATA2
  and   T430.PROGRESSIVO = P_PROGRESSIVO
  and   V010.DATA between T430.DATADECORRENZA and T430.DATAFINE
  and   V010.DATA between T430.INIZIO and nvl(T430.FINE,V010.DATA)
  and   T220.CODICE = T430.PORARIO
  and   V010.DATA between T220.DECORRENZA and T220.DECORRENZA_FINE
  and   T221.CODICE = T220.CODICE
  and   T221.DECORRENZA = T220.DECORRENZA
  and   T020.CODICE = decode(to_char(V010.DATA - 1,'d'),1,T221.LUNEDI,2,T221.MARTEDI,3,T221.MERCOLEDI,4,T221.GIOVEDI,5,T221.VENERDI,6,T221.SABATO)
  and   T020.DECORRENZA = (select max(DECORRENZA) from T020_ORARI where CODICE = T020.CODICE and DECORRENZA <= V010.DATA)
  and   T020.RICALCOLO_DEBITO_GG = 'S'
  and   (T020.RICALCOLO_CAUS_NEG is not null or T020.RICALCOLO_CAUS_POS is not null);
  
  if c > 0 then
    result:='S';
  else
    result:='N';
  end if;
  return result;
end;
/