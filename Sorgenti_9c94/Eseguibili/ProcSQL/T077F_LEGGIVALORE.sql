create or replace function T077F_LEGGIVALORE(P_PROGRESSIVO in integer, P_DATA in date, P_DATO in varchar2, P_TIPO in varchar2) return varchar2 as
  result varchar2(50);
  wVALORE_MAN varchar2(50);
  wVALORE_AUT varchar2(50);
  wTIPO varchar2(1);
begin
  /*
  select T077.VALORE_AUT, T077.VALORE_MAN, I011.TIPO into wVALORE_AUT, wVALORE_MAN, wTIPO 
  from T077_DATISCHEDA T077, I011_DIZIONARIO_DATISCHEDA I011
  where T077.PROGRESSIVO = P_PROGRESSIVO
  and T077.DATA = P_DATA
  and T077.DATO = P_DATO
  and T077.DATO = I011.DATO(+);
  begin
    if wTIPO = 'N' then
      result:=wVALORE_AUT + wVALORE_MAN;
    elsif wTIPO = 'O' then
      result:=minutiore(oreminuti(wVALORE_AUT) + oreminuti(wVALORE_MAN));
    else 
      result:=nvl(wVALORE_MAN,wVALORE_AUT);
    end if;
  exception
    when others then
      result:=wVALORE_AUT;
  end;
  */
  select decode(P_TIPO,'A',T077.VALORE_AUT,
                       'M',T077.VALORE_MAN,
                       nvl(T077.VALORE_MAN,T077.VALORE_AUT))
  into result
  from T077_DATISCHEDA T077, I011_DIZIONARIO_DATISCHEDA I011
  where T077.PROGRESSIVO = P_PROGRESSIVO
  and T077.DATA = P_DATA
  and T077.DATO = P_DATO
  and T077.DATO = I011.DATO(+);

  return result;
exception
  when no_data_found then
    return null;
end;
/
