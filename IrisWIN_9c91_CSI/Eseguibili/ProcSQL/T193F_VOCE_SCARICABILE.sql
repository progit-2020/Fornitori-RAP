create function T193F_VOCE_SCARICABILE(P_PROGRESSIVO in integer, P_DATA_COMP in date, P_DATA_CASSA in date, P_INTERFACCIA in varchar2, P_VOCE in varchar2, P_VOCE_CEDOLINO in varchar2) return varchar2 as
  result varchar2(1);
begin
  result:='S';

  return result;
end/*--NOLOG--*/;
/