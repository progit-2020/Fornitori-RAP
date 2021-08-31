create or replace function T050F_REVOCATA(pID integer) return varchar2 is
  Result varchar2(1);
  i      integer;
begin
  Result:='N';
  if pID is null then
    return(Result);
  end if;
  -- richiesta è revocata se ID_REVOCA è valorizzato
  -- e il record della revoca ha queste caratteristiche
  -- ELABORATO = 'N'
  -- AUTORIZZATA = 'S'
  select /*+ INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO)*/
         count(*) 
  into   i
  from   VT050_RICHIESTEASSENZA VT050R
  where  VT050R.TIPO_RICHIESTA = 'R'
  and    VT050R.ID_REVOCATO = pID
  and    VT050R.ELABORATO = 'N'
  and    exists (select 'x' from dual where nvl(T050F_AUTORIZZATA(VT050R.ID),'N') = 'S');
  if i > 0 then
    Result:='S';
  else
    Result:='N';
  end if;
  return(Result);
end;
/
