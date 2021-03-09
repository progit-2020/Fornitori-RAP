CREATE OR REPLACE TRIGGER SG101_AFTERUPD
  after update of datanas, dataadoz on sg101_familiari
  for each row
declare
  cod varchar2(5);
  comp varchar2(8);
  um varchar2(1);
  cf varchar2(1);
  d1 date;
  d2 date;
  dfine date;
  dc date;
  n integer;
  new_datanas date;
  old_datanas date;
  wCONTA_PROC     integer;
begin
  --Allineamento giustificativi riferiti a questo familiare
  if :OLD.DATAADOZ is not null then
    old_datanas:=:OLD.DATAADOZ;
  else
    old_datanas:=:OLD.DATANAS;
  end if;
  if :NEW.DATAADOZ is not null then
    new_datanas:=:NEW.DATAADOZ;
  else
    new_datanas:=:NEW.DATANAS;
  end if;
  if (new_datanas is not null and old_datanas is not null) and (new_datanas <> old_datanas) then
    UPDATE T040_GIUSTIFICATIVI SET
      DATANAS = NEW_DATANAS
      WHERE PROGRESSIVO = :OLD.PROGRESSIVO AND DATANAS = OLD_DATANAS;
    UPDATE T044_STORICOGIUSTIFICATIVI SET
      DATANAS = NEW_DATANAS
      WHERE PROGRESSIVO = :OLD.PROGRESSIVO AND DATANAS = OLD_DATANAS;
    UPDATE T046_GIUSTIFICATIVIFAMILIARI SET
      DATANAS = NEW_DATANAS
      WHERE PROGRESSIVO = :OLD.PROGRESSIVO AND DATANAS = OLD_DATANAS;
    UPDATE T050_RICHIESTEASSENZA SET
      DATANAS = NEW_DATANAS
      WHERE PROGRESSIVO = :OLD.PROGRESSIVO AND DATANAS = OLD_DATANAS;
  end if;
  --Verifica se esiste trigger specifico per allineamento della maternità obbligatoria  
  begin
    select count(*)
    into   wCONTA_PROC
    from   user_procedures
    where  upper(object_name) = 'USR_SG101_AFTERUPD_MATOB';
  exception
    when others then
      wCONTA_PROC:=0;
  end;
  if wCONTA_PROC > 0 then
    return;
  end if;
  --Allineamento maternità obbligatoria già inserita nel caso di parto posticipato
  if trunc(:OLD.DATANAS) >= trunc(:NEW.DATANAS) then
   return;
  end if;
  select min(T040.DATA),max(T040.DATA),min(T040.CAUSALE),min(T265.COMPETENZA1),min(T265.UMISURA),min(T265.CUMULO_FAMILIARI)
  into d1,d2,cod,comp,um,cf
  from T040_GIUSTIFICATIVI T040, T265_CAUASSENZE T265
  where T040.PROGRESSIVO = :OLD.PROGRESSIVO
  --and   T040.DATANAS = :NEW.DATANAS
  and   T040.DATA between add_months(trunc(:OLD.DATANAS),-3) and add_months(trunc(:OLD.DATANAS),5)
  and   T040.CAUSALE = T265.CODICE
  and   T265.MATERNITA_OBBL = 'S'
  having trunc(:OLD.DATANAS) between min(T040.DATA) and max(T040.DATA);
  n:=round((d2 - trunc(:OLD.DATANAS))/30);
  dfine:=add_months(trunc(:NEW.DATANAS),n);
  dc:=d2 + 1;
  new_datanas:=null;
  if cf = 'S' then
    if :NEW.DATAADOZ is not null then
      new_datanas:=:NEW.DATAADOZ;
    else
      new_datanas:=:NEW.DATANAS;
    end if;
  elsif cf = 'D' then
    new_datanas:=:NEW.DATANAS;
  end if;
  while dc <= dfine loop
    select sum(num) into n from(
      select count(*) num from T100_TIMBRATURE
      where  PROGRESSIVO = :OLD.PROGRESSIVO
      and    DATA = dc
      and    FLAG in ('O','I')
      union all
      select count(*) from T040_GIUSTIFICATIVI
      where  PROGRESSIVO = :OLD.PROGRESSIVO
      and    DATA = dc
      and    TIPOGIUST = 'I');
    if n = 0 then
      insert into T040_GIUSTIFICATIVI
        (PROGRESSIVO,DATA,CAUSALE,TIPOGIUST,PROGRCAUSALE,DATANAS)
      values
        (:OLD.PROGRESSIVO,dc,cod,'I',0,new_datanas);
    end if;
    dc:=dc + 1;
  end loop;
exception
  when others then
    null;
end SG101_AFTERUPD;
/