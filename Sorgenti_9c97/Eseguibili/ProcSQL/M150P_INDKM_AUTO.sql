create procedure M150P_INDKM_AUTO(pID in integer, pINDKM in varchar2, pCOD_REGOLA in varchar2) as
  -- dati di residenza / sede lavoro
  wCodComuneRes           V430_STORICO.T430COMUNE%type;
  wCodComuneSedeP150      T480_COMUNI.CODICE%type;
  wCodComuneSede          T480_COMUNI.CODICE%type;
  wResidenzaDiversaDaSede varchar2(1);
  wDatoSede               varchar2(200);
  wEspr                   varchar2(200);
  -- km percorso
  wKmAndataOrig           integer;
  wKmAndata               integer;
  wKmRitornoOrig          integer;
  wKmRitorno              integer;
  wKmSedeDestinazione     integer;
  wKmPercorsi             integer;
  -- dati della richiesta
  wProgressivo            integer;
  wDataDa                 M140_RICHIESTE_MISSIONI.DATADA%type;
  wDataA                  M140_RICHIESTE_MISSIONI.DATAA%type;
  wTipoRegistrazione      M140_RICHIESTE_MISSIONI.TIPOREGISTRAZIONE%type;
  wPartenza               varchar2(2000);
  wDestinazione           varchar2(2000);
  wRientro                varchar2(2000);
  wPartenzaDesc           varchar2(2000);
  wDestinazioneDesc       varchar2(2000);
  wRientroDesc            varchar2(2000);
  wPartenzaStr            varchar2(500);
  wRientroStr             varchar2(500);
  wDescComuneRes          varchar2(2000);
  wDescComuneSede         varchar2(2000);
  -- importo rimborso
  wImportoUnitario        M021_TIPIINDENNITAKM.IMPORTO%type;
  wArrotondamento         M021_TIPIINDENNITAKM.ARROTONDAMENTO%type;
  -- dati arrotondamento
  wArr                    P050_ARROTONDAMENTI.VALORE%type;
  wTipoArr                P050_ARROTONDAMENTI.TIPO%type;
  wCodValuta              P050_ARROTONDAMENTI.COD_VALUTA%type;
  -- dati dell'indennità km
  wContaRecord            integer;
  wSogliaKmRimbAuto       integer;
  wNote                   M150_RICHIESTE_RIMBORSI.NOTE%type;
  wImporto                M150_RICHIESTE_RIMBORSI.RIMBORSO%type;
  wRimborso               M150_RICHIESTE_RIMBORSI.RIMBORSO%type;
begin
  -- controllo parametri
  if pID is null then
    raise_application_error(-20001,'Parametri: ID richiesta non specificato');
  end if;
  if pINDKM is null then
    raise_application_error(-20002,'Parametri: codice indennità km non specificato');
  end if;
  if pCOD_REGOLA is null then
    raise_application_error(-20003,'Parametri: codice regola missione non specificato');
  end if;

  -- estrae i dati significativi della richiesta di missione
  begin
    select PROGRESSIVO, DATADA, DATAA, TIPOREGISTRAZIONE, M140F_GETPARTENZA(ID),M140F_GETDESTINAZIONE(ID),M140F_GETRIENTRO(ID)--PARTENZA, DESTINAZIONE, RIENTRO
    into   wProgressivo, wDataDa, wDataA, wTipoRegistrazione, wPartenza, wDestinazione, wRientro
    from   M140_RICHIESTE_MISSIONI
    where  ID = pID;
  exception
    when NO_DATA_FOUND then
      raise_application_error(-20010,'ID richiesta ' || pID || ' non esistente');
  end;

  -- decodifica le informazioni del percorso trasferta
  wPartenzaDesc:=null;
  wDestinazioneDesc:=null;
  wRientroDesc:=null;
  begin
    if wPartenza is not null then
      wPartenzaDesc:=M041F_GETDESCLOCALITA(wPartenza);
    end if;
    if wDestinazione is not null then
      wDestinazioneDesc:=M041F_GETDESCLOCALITA(wDestinazione);
    end if;
    if wRientro is not null then
      wRientroDesc:=M041F_GETDESCLOCALITA(wRientro);
    end if;
  exception
    when others then
      null;
  end;

  -- estrae comune di residenza
  begin
    select V430.T430COMUNE
    into   wCodComuneRes
    from   V430_STORICO V430
    where  V430.T430Progressivo = wProgressivo
    and    wDataA between V430.T430DataDecorrenza and V430.T430DataFine;
  exception
    when NO_DATA_FOUND then
      raise_application_error(-20030,'Dati anagrafici del progressivo ' || wProgressivo || ' non trovati in data ' || to_char(wDataA,'dd/mm/yyyy'));
  end;
  wDescComuneRes:=M041F_GETDESCLOCALITA(wCodComuneRes);

  -- estrae il codice comune della sede di lavoro
  wCodComuneSede:=null;
  
  -- 1. comune sede lavoro su P150 
  begin
    select T480.CODICE, P150.COD_VALUTA_BASE
    into   wCodComuneSedeP150, wCodValuta
    from   P150_SETUP P150,
           T480_COMUNI T480
    where  wDataA between P150.DECORRENZA and P150.DECORRENZA_FINE
    and    P150.COD_COMUNE_INAIL = T480.CODCATASTALE;
  exception
    when NO_DATA_FOUND then
      wCodComuneSedeP150:=null;
  end;
  
  -- imposta cod valuta fisso
  if wCodValuta is null then
    wCodValuta:='EURO';
  end if;

  -- 2. se esiste C8_SEDE, e se è valorizzato per il progressivo corrente, 
  --    considerare il codice della T430.C8_SEDE, altrimenti il comune su P150.
  begin
    select dato
    into   wDatoSede
    from   mondoedp.i091_datiente
    where  azienda = t000f_getaziendacorrente()
    and    tipo = 'C8_SEDE';
    
    if wDatoSede is not null then
      wEspr:='select ' || wDatoSede || ' from T430_STORICO ' ||
             'where  PROGRESSIVO = :progressivo ' || 
             'and    :datarif between DATADECORRENZA and DATAFINE';
      execute immediate wEspr into wCodComuneSede using wProgressivo, wDataA;
    end if;
  exception
    when no_data_found then
      null;
  end;  
  -- estrae il comune da P150
  if wCodComuneSede is null then
    wCodComuneSede:=wCodComuneSedeP150;  
  end if;  
  wDescComuneSede:=M041F_GETDESCLOCALITA(wCodComuneSede);

  -- nota: si effettuano le considerazioni della distanza minima sede / residenza
  --       solo se il comune della sede è diverso da quello di residenza
  if (wCodComuneSede is not null) and
     (wCodComuneRes is not null) and
     (wCodComuneSede <> wCodComuneRes) then
    wResidenzaDiversaDaSede:='S';
  else
    wResidenzaDiversaDaSede:='N';
  end if;

  -- estrae i dati della regola missione
  begin
    select nvl(RIMB_KM_AUTO_MINIMO,0)
    into   wSogliaKmRimbAuto
    from   M010_PARAMETRICONTEGGIO
    where  DECORRENZA = (select max(DECORRENZA)
                         from   M010_PARAMETRICONTEGGIO
                         where  DECORRENZA <= wDataA
                         and    TIPO_MISSIONE = wTipoRegistrazione
                         and    CODICE = pCOD_REGOLA)
    and    TIPO_MISSIONE = wTipoRegistrazione
    and    CODICE = pCOD_REGOLA;
  exception
    when others then
      raise_application_error(-20040,'Errore durante la lettura della regola missione ' || pCOD_REGOLA || ' / tiporegistrazione ' || wTipoRegistrazione || ' in data ' || to_char(wDataA,'dd/mm/yyyy'));
  end;

  dbms_output.put_line('INFO REGOLA MISSIONE');
  dbms_output.put_line('  codice regola indicato:              ' || pCOD_REGOLA);

  -- se la residenza è diversa dalla sede di lavoro calcola distanza [sede - destinazione]
  if wResidenzaDiversaDaSede = 'S' then
    wKmSedeDestinazione:=M041F_GETDISTANZA(null,wCodComuneSede,null,wDestinazione);
  else
    wKmSedeDestinazione:=0;
  end if;

  -- informazioni sede lavoro e residenza
  dbms_output.put_line('INFO SEDE LAVORO E RESIDENZA');
  dbms_output.put_line('  comune sede di lavoro:               ' || nvl(wCodComuneSede,'[non indicato]') || ' - ' || nvl(wDescComuneSede,''));
  dbms_output.put_line('  comune residenza:                    ' || nvl(wCodComuneRes,'[non indicato]') || ' - ' || nvl(wDescComuneRes,''));

  -- informazioni percorso
  dbms_output.put_line('PERCORSO TRASFERTA');
  wPartenzaStr:='  partenza:                            ' || nvl(wPartenza,'null') || ' - ' || nvl(wPartenzaDesc,'null');
  if wPartenza = wCodComuneRes then
    wPartenzaStr:=wPartenzaStr || ' [partenza dal comune di residenza]';
  end if;
  dbms_output.put_line(wPartenzaStr);
  dbms_output.put_line('  destinazione:                        ' || nvl(wDestinazione,'null') || ' - ' || nvl(wDestinazioneDesc,'null'));
  wRientroStr:='  rientro:                             ' || nvl(wRientro,'null') || ' - ' || nvl(wRientroDesc,'null');
  if wRientro = wCodComuneRes then
    wRientroStr:=wRientroStr || ' [rientro al comune di residenza]';
  end if;
  dbms_output.put_line(wRientroStr);

  -- ANDATA
  dbms_output.put_line('ANDATA');
  -- calcola km fra partenza e destinazione
  if (wPartenza is null) or (wDestinazione is null) then
    wKmAndata:=0;
    dbms_output.put_line('  distanza andata:                     non calcolabile');
  else
    wKmAndataOrig:=M041F_GETDISTANZA(null,wPartenza,null,wDestinazione);
    dbms_output.put_line('  distanza andata:                     ' || wKmAndataOrig || ' km');
    wKmAndata:=wKmAndataOrig;

    -- se la partenza è dalla residenza verifica la distanza [sede lavoro - destinazione]
    if (wPartenza = wCodComuneRes) and
       (wResidenzaDiversaDaSede = 'S') then
      dbms_output.put_line('  nota: partenza dal comune di residenza (valutazione distanza minima)');
      dbms_output.put_line('  distanza andata (da sede lavoro):    ' || wKmSedeDestinazione || ' km');
      if (wKmSedeDestinazione > 0) and
         (wKmAndataOrig > wKmSedeDestinazione) then
        wKmAndata:=wKmSedeDestinazione;
        dbms_output.put_line('  ' || wKmSedeDestinazione || ' km < ' || wKmAndataOrig || ' km');
      end if;
    end if;
  end if;
  dbms_output.put_line('  distanza andata considerata:         ' || wKmAndata || ' km');

  -- RITORNO
  dbms_output.put_line('RITORNO');
  -- calcola km fra destinazione e rientro
  if (wDestinazione is null) or (wRientro is null) then
    wKmRitorno:=0;
    dbms_output.put_line('  distanza ritorno:                    non calcolabile');
  else
    wKmRitornoOrig:=M041F_GETDISTANZA(null,wRientro,null,wDestinazione);
    dbms_output.put_line('  distanza ritorno:                    ' || wKmRitornoOrig || ' km');
    wKmRitorno:=wKmRitornoOrig;

    -- se il rientro è alla residenza verifica la distanza [destinazione - sede lavoro]
    if (wRientro = wCodComuneRes) and
       (wResidenzaDiversaDaSede = 'S') then
      dbms_output.put_line('  nota: rientro al comune di residenza (valutazione distanza minima)');
      dbms_output.put_line('  distanza ritorno (a sede lavoro):    ' || wKmSedeDestinazione || ' km');
      if (wKmSedeDestinazione > 0) and
         (wKmRitornoOrig > wKmSedeDestinazione) then
        wKmRitorno:=wKmSedeDestinazione;
        dbms_output.put_line('  ' || wKmSedeDestinazione || ' km < ' || wKmRitornoOrig || ' km');
      end if;
    end if;
  end if;
  dbms_output.put_line('  distanza ritorno considerata:        ' || wKmRitorno || ' km');

  -- verifica esistenza codice indennità km
  begin
    select M021.IMPORTO, M021.ARROTONDAMENTO
    into   wImportoUnitario, wArrotondamento
    from   M021_TIPIINDENNITAKM M021
    where  M021.CODICE = pINDKM
    and    wDataA between M021.DECORRENZA and M021.DECORRENZA_FINE;
  exception
    when NO_DATA_FOUND then
      raise_application_error(-20050,'Codice di indennità km ' || pINDKM || ' inesistente');
  end;

  dbms_output.put_line('TOTALE PERCORSO');
  wKmPercorsi:=wKmAndata + wKmRitorno;
  dbms_output.put_line('  distanza totale:                     (' || wKmAndata || ' + ' || wKmRitorno || ') = ' || wKmPercorsi || ' km');
  
  if wKmPercorsi = 0 then
    -- nessun km -> nessun rimborso
    dbms_output.put_line('  0 km: nessun rimborso inserito');
  elsif wKmPercorsi < wSogliaKmRimbAuto then
    -- km < soglia -> nessun rimborso
    dbms_output.put_line('  ' || wKmPercorsi || ' km < soglia minima (' || wSogliaKmRimbAuto || ' km): nessun rimborso inserito');
  else
    -- km ok -> gestione rimborso
    dbms_output.put_line('  ' || wKmPercorsi || ' km >= soglia minima (' || wSogliaKmRimbAuto || ' km): avvio gestione rimborso automatico');

    -- imposta note
    wNote:=substr('Rimborso chilometrico automatico percorso ' || wPartenzaDesc || ' - ' || wDestinazioneDesc || ' - ' || wRientroDesc,1,2000);

    dbms_output.put_line('CALCOLO RIMBORSO');
    -- calcola il rimborso km in base ai km e alla tariffa
    dbms_output.put_line('  importo unitario indennità ' || pINDKM || ':    (' || to_char(wImportoUnitario,'99,990.00') || ') ' || wCodValuta || ' / km');
    wImporto:=wKmPercorsi * wImportoUnitario;
    dbms_output.put_line('  importo totale da arrotondare        (' || to_char(wImportoUnitario,'99,990.00') || ') ' || wCodValuta || ' * (' || wKmPercorsi || ' km) = (' || to_char(wImporto,'99,999.00') || ' ' || wCodValuta || ')');

    -- estrae i dati di arrotondamento dell'importo in base alla valuta e alla decorrenza
    begin
      select P050.VALORE, P050.TIPO
      into   wArr, wTipoArr
      from   P050_ARROTONDAMENTI P050
      where  P050.COD_ARROTONDAMENTO = wArrotondamento
      and    P050.COD_VALUTA = wCodValuta
      and    wDataA between P050.DECORRENZA and P050.DECORRENZA_FINE;
    exception
      when NO_DATA_FOUND then
        wArr:=1;
        wTipoArr:='P';
    end;
    dbms_output.put_line('  dati arrotondamento:                 (' || to_char(wArr,'99,990.00') || ') tipo ' || wTipoArr);

    -- applica l'arrotondamento specificato per determinare l'importo del rimborso
    wRimborso:=ARROTONDA(wImporto,wArr,wTipoArr);
    dbms_output.put_line('  importo totale arrotondato:          (' || to_char(wRimborso,'99,999.00') || ') ' || wCodValuta);

    dbms_output.put_line('AGGIORNAMENTO TABELLA M150_RICHIESTE_RIMBORSI');
    -- verifica se è necessario inserire o aggiornare il record di rimborso automatico
    select count(*)
    into   wContaRecord
    from   M150_RICHIESTE_RIMBORSI M150
    where  M150.ID = pID
    and    M150.INDENNITA_KM = 'S'
    and    M150.CODICE = pINDKM;

    begin
      if wContaRecord > 0 then
        dbms_output.put_line('  rimborso automatico già esistente: aggiornamento record');
        -- update
        update M150_RICHIESTE_RIMBORSI M150
        set    M150.KMPERCORSI = wKmPercorsi,
               M150.COD_VALUTA = wCodValuta,
               M150.RIMBORSO = wRimborso,
               M150.NOTE = wNote,
               M150.AUTOMATICO = 'S',
               M150.DATA_RIMBORSO = wDataDa
        where  M150.ID = pID
        and    M150.INDENNITA_KM = 'S'
        and    M150.CODICE = pINDKM;
      else
        dbms_output.put_line('  rimborso automatico non presente: inserimento record');
        -- insert
        insert into M150_RICHIESTE_RIMBORSI
          (ID, INDENNITA_KM, CODICE, DATA_RIMBORSO, KMPERCORSI, COD_VALUTA, RIMBORSO, NOTE, AUTOMATICO)
        values
          (pID, 'S', pINDKM, wDataDa, wKmPercorsi, wCodValuta, wRimborso, wNote, 'S');
      end if;

      -- commit
      commit;
    exception
      when OTHERS then
        if wContaRecord > 0 then
          raise_application_error(-20060,'Aggiornamento del rimborso automatico fallito: ('|| SQLCODE || ') ' || SQLERRM);
        else
          raise_application_error(-20065,'Inserimento del rimborso automatico fallito: ('|| SQLCODE || ') ' || SQLERRM);
        end if;
    end;
  end if;
end/*--NOLOG--*/;
/
