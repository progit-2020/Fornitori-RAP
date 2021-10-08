create or replace function T265F_GETCATENACOMPLETA(CAUS in varchar2, TIPO in varchar2) return varchar2 is
/*
Data la causale indicata e il tipo di output desiderato restituisce la catena in cui
la causale stessa è compresa.

Parametri
- Caus:   causale di cui si desidera la catena
- Tipo:   indica il tipo di estrazione
          i valori ammessi sono:
          'T': tutte le causali (incluse quelle ridotte di Brunetta)
          'N': solo causali non ridotte
          'R': solo causali ridotte

Valore restituito
- elenco delle causali facenti parte della catena separate da virgola
*/
  r          varchar2(1000);
  chain      varchar2(500);
  chain_l133 varchar2(500);
  temp1      varchar2(500);
  temp2      varchar2(500);
begin
  chain:=null;
  chain_l133:=null;
  temp1:=null;
  temp2:=null;
  t265f_getcatena(t265f_getiniziocatena(CAUS,temp1),chain,chain_l133,temp2);

  if TIPO = 'T'  then
    -- T = tutte le causali
    if chain_l133 is null then
      r:=chain;
    else
      r:=chain || ',' || chain_l133;
    end if;
  elsif TIPO = 'N' then
    -- N = solo le causali non ridotte
    r:=chain;
  elsif TIPO = 'R' then
    -- R = solo le causali ridotte
    r:=chain_l133;
  else
    -- Tipo non valido
    return null;
  end if;
  
  -- pulizia delle virgole doppie
  while instr(r,',,') > 0
  loop
     r:=replace(r,',,',',');
  end loop;
  
  return r; 
end T265F_GETCATENACOMPLETA;
/
