create or replace package SELECT_APERTE is
  type t_badgeliberi is ref cursor;
  procedure GET_BADGE_USATI(C_BADGE IN OUT T_BADGELIBERI, DAL IN DATE, AL IN DATE);
  procedure B014Personalizzata(p in integer, dal in date, dato in varchar2, valore in varchar2, struttura in varchar2, sequenza in varchar2, rowid_riga in varchar2);
end SELECT_APERTE;
/