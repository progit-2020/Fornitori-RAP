create or replace function T050F_CANCELLATA(pID integer, pDATA date) return varchar2 is
  Result varchar2(1);
  i      integer;
begin
  Result:='N';
  if pID is null then
    return(Result);
  end if;
  -- richiesta è cancellata se esiste record di cancellazione o di revoca su T050 
  -- con queste caratteristiche:
  -- TIPO_RICHIESTA in 'C','R'
  -- ELABORATO = 'N'
  -- AUTORIZZATA = 'S'
  -- ID_REVOCATO = pID
  -- il parametro pDATA viene valutato solo per TIPO_RICHIESTA = 'C'
  select /*+ INDEX(T050_RICHIESTEASSENZA T050_BMI_ELABORATO)*/
         count(*) 
  into   i
  from   VT050_RICHIESTEASSENZA VT050
  where  VT050.TIPO_RICHIESTA in ('R','C')
  and    VT050.ID_REVOCATO = pID
  and    VT050.ELABORATO = 'N'
  and    decode(VT050.TIPO_RICHIESTA,'C',pDATA,VT050.DAL) between VT050.DAL and VT050.AL
  and    exists (select 'x' from dual where nvl(T050F_AUTORIZZATA(VT050.ID),'N') = 'S');
  if i > 0 then
    Result:='S';
  else
    Result:='N';
  end if;
  return(Result);
end;
/