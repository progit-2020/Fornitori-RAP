create or replace package I025PCK_CESTINO is
  function GetID return varchar2;  
  function CancLogica(Tabella varchar2, ValoreOld varchar2, Operatore varchar2) return varchar2;  
  function Ripristino(IDRipristino varchar2, Tabella varchar2, MyValore varchar2) return varchar2;
  function CancFisica(IDRipristino varchar2, Tabella varchar2) return varchar2;    
  function CheckValore(Tabella varchar2, Valore varchar2) return varchar2;
  function GeneraCodice(Tabella varchar2) return varchar2;
end I025PCK_CESTINO;
/
