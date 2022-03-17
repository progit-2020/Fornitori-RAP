create or replace procedure getprimogglav(progressivo in integer, data in date, primo_giorno in out date) as
  d date;
  f varchar2(1);
  l varchar2(1);
  gg number;
  ore varchar2(5);
  lavorativo boolean;
begin
  primo_giorno:=data;
  d:=data + 1;
  lavorativo:=false;
  while (to_char(d,'d') <> 2) and (not lavorativo) loop
    getcalendario(progressivo,d,f,l,gg,ore);
    lavorativo:=l = 'S'; --and f = 'N';
    d:=d + 1;
  end loop;
  if not lavorativo then
    d:=data - (to_char(data - 1,'d') - 1);
    while (d < data) and (not lavorativo) loop
      getcalendario(progressivo,d,f,l,gg,ore);
      lavorativo:=l = 'S'; --and f = 'N';
      if lavorativo then 
        primo_giorno:=d;
        exit;
      end if;
      d:=d + 1;
    end loop;
  end if;
end;
/
