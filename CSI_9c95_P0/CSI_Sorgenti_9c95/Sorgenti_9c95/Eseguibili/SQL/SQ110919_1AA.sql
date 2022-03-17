declare
  i integer;
begin
  select COUNT(*) into i from P042_ENTIIRPEF;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ110919_1Addizionali.sql');
  end if;
  select COUNT(*) into i from P502_CUDREGOLE;
  if i = 0 then
    insert into I050_SCRIPTSQL (NOME) values ('SQ110919_1CUD.sql');
  end if;
exception
  when others then
    insert into I050_SCRIPTSQL (NOME) values ('SQ110919_1Addizionali.sql');
    insert into I050_SCRIPTSQL (NOME) values ('SQ110919_1CUD.sql');
end/*--NOLOG--*/;
