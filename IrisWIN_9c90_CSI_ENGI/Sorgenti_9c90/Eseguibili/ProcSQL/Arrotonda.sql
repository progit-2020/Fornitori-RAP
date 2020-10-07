create or replace function Arrotonda(Dato in number, Valore in number, Tipo in varchar2) return number as
  Result number;
  Delta number;
begin
  if Valore = 0 then
    Result:=Dato;
    return Result;
  end if;
  begin
    Result:=Dato / Valore;
  exception
    when others then
      Result:=Dato;
      return Dato;
  end;
  Delta:=Power(10,-8);
  if Dato < 0 then
    Delta:= -Delta;
  end if;
  if Abs(result - Trunc(Result + Delta)) < Power(10,-8) then
    Result:=Round(Result) * Valore;
  else
    if Dato > 0 then
      --Dato da arrotondare positivo
      if Tipo = 'E' then
        --Eccesso
        Result:=Trunc(Result + 1);
      elsif Tipo = 'D' then
        --Difetto
        Result:=Trunc(Result);
      elsif Tipo = 'P' then
        --Puro
        Result:=Trunc(Result + 0.5 + Delta);
      elsif Tipo = 'P-' then
        --Puro ma per difetto sul .5
        if Result - Trunc(Result) = 0.5 then
          Result:=Trunc(Result);
        else
          Result:=Trunc(Result + 0.5);
        end if;
      end if;  
    else
      --Dato da arrotondare negativo
      if Tipo = 'E' then
        --Eccesso
        Result:=Trunc(Result);
      elsif Tipo = 'D' then
        --Difetto
        Result:=Trunc(Result - 1);
      elsif Tipo = 'P' then
        --Puro
        Result:=Trunc(Result - 0.5 + Delta);
      elsif Tipo = 'P-' then
        --Puro ma per difetto sul .5
        if Abs(Result) - Trunc(Abs(Result)) = 0.5 then
          Result:=Trunc(Result);
        else
          Result:=Trunc(Result - 0.5);
        end if;
      end if;    
    end if;
    Result:=Result * Valore;
  end if;
  return result;
end;
/