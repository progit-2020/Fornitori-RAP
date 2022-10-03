create or replace function T265F_GETINIZIOCATENA(C in varchar2, C_CONSIDERATE in out varchar2) return varchar2 is
  COD varchar2(5);
begin
  COD:=null;
    select min(CODICE) into COD
    from T265_CAUASSENZE
    where CODCAU3 = C
    and   CODICE <> C;

  if COD is null then
      select min(CODICE) into COD
      from T265_CAUASSENZE 
      where CAUSALE_SUCCESSIVA = C; 
      
      if COD is not null then
        -- controllo causale già considerata per evitare cicli
        if INSTR(',' || C_CONSIDERATE || ',', ',' || COD || ',') > 0 then
          return null;
        end if;
        C_CONSIDERATE:=C_CONSIDERATE || C || ','; 
      end if;  
  end if;
  if COD is not null then
    -- controllo causale già considerata per evitare cicli
    if INSTR(',' || C_CONSIDERATE || ',', ',' || COD || ',') > 0 then
      return null;
    end if;
    C_CONSIDERATE:=C_CONSIDERATE || C || ','; 
    return T265F_GETINIZIOCATENA(COD,C_CONSIDERATE);
  else
    return C;
  end if;
end T265F_GETINIZIOCATENA;
/
