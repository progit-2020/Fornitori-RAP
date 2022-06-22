create or replace procedure T250P_ANNULLA_RICHIESTA(P_ID in out integer, P_LIVELLO in out integer, P_STATO in out varchar2,
  P_RESPONSABILE in out varchar2, P_AUTORIZZ_AUTOMATICA in out varchar2) as
  wNoteT850   varchar2(200);
  wNoteT851   varchar2(200);
begin
  if P_STATO = 'N' then
    /*
      se autorizzazione è negata riporta la richiesta in uno stato modificabile dal richiedente
      1. pulisce lo stato finale sulla richiesta e la riporta in stato P = salvataggio parziale indicando la motivazione nelle note
      2. annulla tutte le autorizzazioni impostate sul livello attuale e sugli eventuali livelli precedenti
      3. annulla la negazione impostata
    */
    if P_LIVELLO is null then
      wNoteT850:='Richiesta modificabile in seguito ad annullamento';
      wNoteT851:='Autorizzazione rimossa in seguito ad annullamento';
    else
      wNoteT850:='Richiesta modificabile in seguito a negazione al livello ' || P_LIVELLO;
      wNoteT851:='Autorizzazione rimossa in seguito a negazione richiesta al livello ' || P_LIVELLO;
    end if;

    -- passaggio 1
    update T850_ITER_RICHIESTE
    set    STATO = null,
           TIPO_RICHIESTA = 'P',
           NOTE = wNoteT850
    where  ID = P_ID;

    -- passaggio 2
    update T851_ITER_AUTORIZZAZIONI
    set    STATO = null,
           NOTE = wNoteT851
    where  ID = P_ID
    and    LIVELLO <= nvl(P_LIVELLO,LIVELLO);

    -- passaggio 3
    P_STATO:=null;
    
  end if;
end;
/