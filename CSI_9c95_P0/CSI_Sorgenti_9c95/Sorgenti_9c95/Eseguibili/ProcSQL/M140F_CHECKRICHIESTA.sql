create function M140F_CHECKRICHIESTA (pID in integer, pLIVELLO in integer, pFASE in integer, pCHIUSURA in varchar2) return varchar2 as
  result varchar2(2000);
/*
  Questa function viene richiamata in fase di chiusura della richiesta di missione
  e serve per effettuare controlli personalizzati
  Restituire:
  - null 
    per indicare che i controlli sono andati a buon fine 
  - una stringa contenente il messaggio di errore per indicare una situazione anomala
    relativa ad un controllo personalizzato
*/
begin
  result:=null;

  return result;
end/*--NOLOG--*/;
/