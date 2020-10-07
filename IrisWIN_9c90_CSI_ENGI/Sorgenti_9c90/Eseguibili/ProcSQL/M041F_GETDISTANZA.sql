create or replace function M041F_GETDISTANZA(pTIPO1 in varchar2, pLOCALITA1 in varchar2, pTIPO2 in varchar2, pLOCALITA2 in varchar2) return integer as
  result integer;
/*
  Date due località restituisce il numero di km leggendoli dalla M041_DISTANZE
  Se le tipologie pTIPO1 o pTIPO2 non sono indicate vengono ignorate
*/
  wKm    integer;
begin

  -- estrae la distanza indicata su M041
  -- verifica percorso LOCALITA1 -> LOCALITA2 oppure LOCALITA2 -> LOCALITA1
  select min(M041.CHILOMETRI)
  into   wKm
  from   M041_DISTANZE M041
  where  (M041.TIPO1 = nvl(pTIPO1,M041.TIPO1)
  and     M041.LOCALITA1 = pLOCALITA1
  and     M041.TIPO2 = nvl(pTIPO2,M041.TIPO2)
  and     M041.LOCALITA2 = pLOCALITA2)
  or     (M041.TIPO1 = nvl(pTIPO2,M041.TIPO1)
  and     M041.LOCALITA1 = pLOCALITA2
  and     M041.TIPO2 = nvl(pTIPO1,M041.TIPO2)
  and     M041.LOCALITA2 = pLOCALITA1);

  -- se la distanza non è presente restituisce 0
  if wKm is null then
    result:=0;
  else
    result:=wKm;
  end if;

  return (result);
end;
/