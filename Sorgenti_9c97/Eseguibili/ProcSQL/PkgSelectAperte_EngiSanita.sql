create or replace package SELECT_APERTE is
  type t_badgeliberi is ref cursor;
  procedure GET_BADGE_USATI(C_BADGE IN OUT T_BADGELIBERI, DAL IN DATE, AL IN DATE);
  procedure B014Personalizzata(p in integer, dal in date, dato in varchar2, valore in varchar2, struttura in varchar2, sequenza in varchar2, rowid_riga in varchar2);
end SELECT_APERTE;
/
create or replace package body SELECT_APERTE is
  procedure GET_BADGE_USATI(C_BADGE IN OUT T_BADGELIBERI, DAL IN DATE, AL IN DATE) is
  begin
    OPEN C_BADGE FOR
      SELECT DISTINCT BADGE FROM T430_STORICO WHERE
        DATADECORRENZA <= AL AND DATAFINE >= DAL;
  end;

  procedure B014Personalizzata(p in integer, dal in date, dato in varchar2, valore in varchar2, struttura in varchar2, sequenza in varchar2, rowid_riga in varchar2) is
  -- Usata nell'elaborazione dell'integrazione anagrafica - Versione per EngiSanità
  m varchar2(8);
  t430inizio date;
  t430fine date;
  dadata date;
  begin
    --'dal' corrisponde al dato di assunzione/cessazione, mentre la scadenza non è significativa
    --nel caso di GPA-DTCE, 'dato' può essere 00000000 (null) con il dal riferito alla precedente cessazione
    if dato in ('GPA-DTAS','GPA-DTCE') then
      --Gestione cessazione senza creare periodi storici
      if dato = 'GPA-DTCE' then
        if NVL(valore,'NULL') in ('','NULL') then
          UPDATE T430_STORICO T430 SET FINE = null WHERE
            PROGRESSIVO = p AND
            INIZIO = (SELECT MAX(INIZIO) FROM T430_STORICO WHERE PROGRESSIVO = T430.PROGRESSIVO AND INIZIO <= dal);
        else
          UPDATE T430_STORICO T430 SET FINE = dal WHERE
            PROGRESSIVO = p AND
            INIZIO = (SELECT MAX(INIZIO) FROM T430_STORICO WHERE PROGRESSIVO = T430.PROGRESSIVO AND INIZIO <= dal);
        end if;
      end if;
      --Gestione assunzione dopo aver creato il periodo storico
      if dato = 'GPA-DTAS' then
        begin
          dadata:=dal;
          creazione_storico(p,dadata,null);
          --Lettura inizio, fine validi nel periodo storico della nuova assunzione (dal)
          SELECT NVL(INIZIO,TO_DATE('31123999','DDMMYYYY')),NVL(FINE,TO_DATE('31123999','DDMMYYYY')) INTO t430inizio,t430fine FROM T430_STORICO WHERE 
          PROGRESSIVO = p AND 
          dal BETWEEN DATADECORRENZA AND DATAFINE;
          if dal <= t430fine then
            --correzione assunzione esistente, aggiorno tuti i periodi con INIZIO corrispondente al vecchio INIZIO
            UPDATE T430_STORICO SET INIZIO = dal WHERE
              PROGRESSIVO = p AND
              NVL(INIZIO,TO_DATE('31123999','DDMMYYYY')) = t430inizio;
          else
            --nuova assunzione
            UPDATE T430_STORICO SET INIZIO = dal WHERE
              PROGRESSIVO = p AND
              DATADECORRENZA >= dal AND (INIZIO IS NULL OR INIZIO < dal);
          end if;
        exception
          when no_data_found then
            null;
        end;
      end if;
      --Chiamata alla procedura Oracle standard di Allineamento Periodi Rapporto
      select matricola into m from t030_anagrafico where progressivo = p;
      allineaperiodirapporto(m);    
    end if;
  exception
    when no_data_found then
      null;
  end;
end SELECT_APERTE;
/
