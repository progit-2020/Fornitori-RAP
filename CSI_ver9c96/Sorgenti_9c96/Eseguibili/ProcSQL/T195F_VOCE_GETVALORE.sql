create function T195F_VOCE_GETVALORE(P_PROGRESSIVO in integer, P_DATA_COMP in date, P_INTERFACCIA in varchar2, P_VOCE_ORIG in varchar2, P_VOCE in varchar2, P_VALORE in number) return number as
  result number;
begin
  result:=P_VALORE;

  return result;
end/*--NOLOG--*/;
/