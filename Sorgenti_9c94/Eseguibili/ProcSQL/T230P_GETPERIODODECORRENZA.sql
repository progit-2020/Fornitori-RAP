create or replace procedure T230P_GETPERIODODECORRENZA(P_CAUSALE in varchar2, P_DATA in date, P_DECORRENZA out date, P_DECORRENZA_FINE out date) as
begin
  select DECORRENZA,DECORRENZA_FINE 
  into P_DECORRENZA,P_DECORRENZA_FINE 
  from VT230_CAUASSENZE_PARSTO 
  where CODICE = P_CAUSALE
  and trunc(P_DATA) between DECORRENZA and DECORRENZA_FINE;
exception
  when no_data_found then
    P_DECORRENZA:=null;
    P_DECORRENZA_FINE:=null;        
end;
/