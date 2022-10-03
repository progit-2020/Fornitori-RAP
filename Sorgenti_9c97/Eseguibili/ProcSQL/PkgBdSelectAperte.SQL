create or replace package body SELECT_APERTE is
  procedure GET_BADGE_USATI(C_BADGE IN OUT T_BADGELIBERI, DAL IN DATE, AL IN DATE) is
  begin
    OPEN C_BADGE FOR 
      SELECT DISTINCT BADGE FROM T430_STORICO WHERE 
              DATADECORRENZA <= AL AND DATAFINE >= DAL AND BADGE IS NOT NULL
      UNION
      SELECT DISTINCT BADGESERV FROM T435_BADGESERVIZIO WHERE
              TRUNC(DECORRENZA) <= AL AND TRUNC(NVL(SCADENZA,TO_DATE('31123999','DDMMYYYY'))) >= DAL AND BADGESERV IS NOT NULL;
  end;

  procedure B014Personalizzata(p in integer, dal in date, dato in varchar2, valore in varchar2, struttura in varchar2, sequenza in varchar2, rowid_riga in varchar2) is
  -- Usata nell'elaborazione dell'integrazione anagrafica
  m varchar2(8);
  begin
    /*insert into ia000_logintegrazione (messaggio) 
      select i_matricola || i_dal || i_al || inizio || fine || old_inizio || old_fine 
      from hrrap_rapporti_lavorativi where rowid = rowid_riga;*/
    select matricola into m from t030_anagrafico where progressivo = p;  
    allineaperiodirapporto(m);
  exception
    when no_data_found then
      m:=null;
  end;
end SELECT_APERTE;
/