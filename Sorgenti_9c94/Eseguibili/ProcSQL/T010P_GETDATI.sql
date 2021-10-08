create or replace procedure T010P_GETDATI(P_PROGRESSIVO in number, P_DATA in date, F out varchar2, L out varchar2, G out integer, MONTEORE out varchar2) as
  wCALEND varchar2(5);
begin
  select ORARIO,CALENDARIO into MONTEORE,wCALEND
    from T430_STORICO where PROGRESSIVO = P_PROGRESSIVO and P_DATA between DATADECORRENZA and DATAFINE;
  begin
    G:=null;
    select T010.NUMGG_LAV into G from T010_CALENDIMPOSTAZ T010 where CODICE = wCALEND;
    select FESTIVO,LAVORATIVO, nvl(G,NUMGIORNI)
      into F,L,G
      from T012_CALENDINDIVID where PROGRESSIVO = P_PROGRESSIVO and DATA = P_DATA;
  exception
    when NO_DATA_FOUND then
      select FESTIVO,LAVORATIVO, nvl(G,NUMGIORNI)
        into F,L,G
        from T011_CALENDARI where CODICE = wCALEND and DATA = P_DATA;
  end;
exception
  when NO_DATA_FOUND then
    L:='';
    F:='';
    G:=0;
end;
/
drop procedure GetCalendario/*--NOLOG--*/;
create or replace synonym GetCalendario for T010P_GETDATI;
