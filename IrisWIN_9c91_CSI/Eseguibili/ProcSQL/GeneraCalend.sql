CREATE OR REPLACE PACKAGE GENERACALENDARIO AS
  function GETFESTIVITA(DATAIN in date) return varchar2;
  procedure GENERACAL(COD in varchar2, DAL in date, AL in date, CANCELLA varchar2);
END GENERACALENDARIO;
/
