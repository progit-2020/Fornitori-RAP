create or replace package T080PCK_TURNO is

  -- Created : 08/03/2013 14:47:43
  -- Public function and procedure declarations
  function GETORARIO(INPROG in integer,INDATA in DATE,INTIPO in varchar2) return varchar2;  
  function GETNTURNO(INPROG in integer,INDATA in DATE,INTIPO in varchar2) return varchar2;
  function COPIATURNO(PROGORIG in integer, PROGDEST in integer, DATAINIZIO in date, DATAFINE in date) return varchar2;
  --
  procedure GETDATO_GENERICO(INPROG in integer,INDATA in DATE);
  function GETPARTENZA return number;
end T080PCK_TURNO;