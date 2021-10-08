create or replace trigger MEDP_AFTERLOGON after logon on schema
begin
  execute immediate 'ALTER SESSION SET NLS_TERRITORY = AMERICA';
  execute immediate 'ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY"';
  execute immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."';
  execute immediate 'ALTER SESSION SET NLS_DATE_LANGUAGE = ITALIAN';
  execute immediate 'ALTER SESSION SET NLS_SORT = BINARY';
end;
/