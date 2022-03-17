create or replace procedure T077P_SCRIVIVALORE(P_PROGRESSIVO in integer, P_DATA in date, P_TIPO in varchar2, P_DATO in varchar2, P_VALORE in varchar2) as
begin
  update T077_DATISCHEDA set 
    VALORE_AUT = decode(P_TIPO,'A',P_VALORE,VALORE_AUT),
    VALORE_MAN = decode(P_TIPO,'M',P_VALORE,VALORE_MAN)
  where PROGRESSIVO = P_PROGRESSIVO
  and DATA = P_DATA
  and DATO = P_DATO;

  if sql%rowcount = 0 then
    insert into T077_DATISCHEDA
      (PROGRESSIVO,DATA,DATO,VALORE_AUT,VALORE_MAN)
    values
      (P_PROGRESSIVO,P_DATA,P_DATO,decode(P_TIPO,'A',P_VALORE,null),decode(P_TIPO,'M',P_VALORE,null));
  end if;  
end;  
/
