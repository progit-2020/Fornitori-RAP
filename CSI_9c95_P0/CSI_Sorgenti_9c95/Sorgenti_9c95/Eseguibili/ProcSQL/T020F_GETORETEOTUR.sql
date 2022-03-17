create or replace function T020F_GETORETEOTUR(P_PROGRESSIVO in integer, P_DATA in date, P_ORARIO in varchar2) return varchar2 as
  result  varchar2(5);
  wOrario varchar2(5) := null;
  wTurno  varchar2(5) := null;
begin
  begin
    select ORARIO,decode(TURNO1,'0',nvl(TURNO2,TURNO1),TURNO1) 
    into wOrario, wTurno
    from T080_PIANIFORARI
    where PROGRESSIVO = P_PROGRESSIVO
    and DATA = P_DATA;
  exception
    when others then null;    
  end;  

  if wTurno is not null then
    result:=GetDatoOrario(wOrario,P_DATA,'PN',wTurno,'ORETEOTUR');
  elsif nvl(wOrario,P_ORARIO) is not null then
    select ORETEOR into result
    from T020_ORARI 
    where CODICE = nvl(wOrario,P_ORARIO)
    and P_DATA between DECORRENZA and t020f_getdecorrenzafine(CODICE,DECORRENZA);
    if result is null then
      result:=GetDatoOrario(nvl(wOrario,P_ORARIO),P_DATA,'PN',1,'ORETEOTUR');    
    end if;  
  end if;

  return result;
exception
  when others then
    return null;
end;
/