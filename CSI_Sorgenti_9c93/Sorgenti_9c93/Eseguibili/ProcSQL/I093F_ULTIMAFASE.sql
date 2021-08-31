create or replace function I093F_ULTIMAFASE(pITER in varchar2) return integer as
  result integer;
begin
  result:=0;
  if pITER = 'M140' then
    result:=1;
  elsif pITER = 'T065' then
    result:=2;
  end if;
  return result;
end;
/