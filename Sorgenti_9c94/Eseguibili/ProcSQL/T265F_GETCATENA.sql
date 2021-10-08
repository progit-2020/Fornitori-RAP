create or replace procedure T265F_GETCATENA(C in varchar2, CHAIN in out varchar2, CHAIN_L133 in out varchar2, C_CONSIDERATE in out varchar2) is
  CS   varchar2(5);
  CC3  varchar2(5);
  rCS  varchar2(500);
  rCC3 varchar2(500);
begin
  begin
    select CAUSALE_SUCCESSIVA,CODCAU3 into CS,CC3 
    from T265_CAUASSENZE
    where CODICE = C;
  exception
   when no_data_found then
     CS:=null;
     CC3:=null;
  end;

  if CS is not null then
    -- controllo causale già considerata per evitare cicli
    if INSTR(',' || C_CONSIDERATE || ',', ',' || CS || ',') > 0 then
      CHAIN:=C;
      CHAIN_L133:=CC3;
      return;
    end if;  
    C_CONSIDERATE:=C_CONSIDERATE || C || ',';
    
    T265F_GETCATENA(CS,rCS,rCC3,C_CONSIDERATE);
    CHAIN:=C||','||rCS;
    CHAIN_L133:=CC3||','||rCC3;
    return;
  else
    CHAIN:=C;
    CHAIN_L133:=CC3;
    return;
  end if;
end T265F_GETCATENA;
/
