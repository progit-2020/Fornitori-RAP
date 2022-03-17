create or replace procedure M050P_CARICA_RIMBORSI_DAITER(pID in integer) as
  cursor c1 is
    select M040.ID_MISSIONE, M040.PROGRESSIVO, M040.MESESCARICO, M040.MESECOMPETENZA, M040.DATADA, M040.ORADA,
           M060.COD_VOCE, M060.IMPORTO, M060.ROWID
    from   M040_MISSIONI M040, M060_ANTICIPI M060
    where  M040.ID_MISSIONE = pID
    and    M040.ID_MISSIONE = M060.ID_MISSIONE
    and    M060.IMPORTO <> 0
    and    M060.STATO not in ('R','L');--escludo gli anticipi Recuperati e già Liquidati (in caso di riapertura della richiesta di missione)

  cursor c2 is
    select ID, TIPO, DATA, DALLE, ALLE, NOTE
    from   M143_DETTAGLIOGG
    where  ID = pID
    order by DATA, DALLE;
    
  cursor c3 is
    select M040.ID_MISSIONE, M040.PROGRESSIVO, M040.MESESCARICO, M040.MESECOMPETENZA, M040.DATADA, M040.ORADA, M020.TIPO_QUANTITA,
           M150.CODICE,min(M150.COD_VALUTA) COD_VALUTA, sum(nvl(M150.RIMBORSO_VARIATO,M150.RIMBORSO)) RIMBORSO 
    from   M040_MISSIONI M040, M150_RICHIESTE_RIMBORSI M150, M020_TIPIRIMBORSI M020
    where  M040.ID_MISSIONE = pID
    and    M040.ID_MISSIONE = M150.ID
    and    M150.CODICE = M020.CODICE
    and    M150.STATO = 'S'
    group by M040.ID_MISSIONE, M040.PROGRESSIVO, M040.MESESCARICO, M040.MESECOMPETENZA, M040.DATADA, M040.ORADA, M020.TIPO_QUANTITA, M150.CODICE;
  
  cursor c4 is
    select M040.ID_MISSIONE, M040.PROGRESSIVO, M040.MESESCARICO, M040.MESECOMPETENZA, M040.DATADA, M040.ORADA,
           M150.CODICE, sum(nvl(M150.KMPERCORSI_VARIATO,M150.KMPERCORSI)) KMPERCORSI, sum(nvl(M150.RIMBORSO_VARIATO,M150.RIMBORSO)) RIMBORSO
    from   M040_MISSIONI M040, M150_RICHIESTE_RIMBORSI M150, M021_TIPIINDENNITAKM M021
    where  M040.ID_MISSIONE = pID
    and    M040.ID_MISSIONE = M150.ID
    and    M150.CODICE = M021.CODICE
    and    M150.STATO = 'S'
    and    M040.DATAA between M021.DECORRENZA and M021.DECORRENZA_FINE
    group by M040.ID_MISSIONE, M040.PROGRESSIVO, M040.MESESCARICO, M040.MESECOMPETENZA, M040.DATADA, M040.ORADA, M150.CODICE;


  wCOUNT_A        integer;
  wMESECOMPETENZA date;
  wCONTA_PROC     integer;
  wSTATO          varchar2(1);
  wCODE           varchar2(100);
  wRIMB_DETT      varchar2(1);
  wTIPO_RIMBORSO  varchar2(5);
  wINCMMSCARICO       varchar2(1);
  wProgressivo        integer;
  wDataA              date;
  wDatoRegola         varchar2(30);
  wCodRegola          varchar2(200);
  wEspr               varchar2(2000);
  wDataRifVocePaghe   M010_PARAMETRICONTEGGIO.DATARIF_VOCEPAGHE%TYPE;
  wTipoRegistrazione  M140_RICHIESTE_MISSIONI.TIPOREGISTRAZIONE%TYPE;
begin
  -- se esistono rimborsi in stato "A" termina subito
  select count(*)
  into   wCOUNT_A
  from   M150_RICHIESTE_RIMBORSI M150,
         T850_ITER_RICHIESTE T850
  where  M150.ID = pID
  and    M150.STATO = 'A'
  and    T850.ID = M150.ID
  and    T850.ITER = 'M140'
  and    T850.TIPO_RICHIESTA = '5';

  if wCOUNT_A > 0 then
    return;
  end if;

  -- estrae il mese di competenza
  select add_months(max(DATARIF),1)
  into   wMESECOMPETENZA
  from   T195_VOCIVARIABILI
  where  COD_INTERNO in ('400','402','404','406','408','424','426','428');

  -- effettua pulizia iniziale
  --delete from M050_RIMBORSI where ID_MISSIONE = pID;
  --delete from M052_INDENNITAKM where ID_MISSIONE = pID;
  delete from M043_DETTAGLIOGG where ID = pID;
  delete from T040_GIUSTIFICATIVI where ID_RICHIESTA = pID;

  -- estrae il valore del parametro C8_W032_RIMBORSIDETT
  select nvl(max(DATO),'N')
  into   wRIMB_DETT
  from   MONDOEDP.I091_DATIENTE
  where  AZIENDA = t000f_getaziendacorrente()
  and    TIPO = 'C8_W032_RIMBORSIDETT';

  /************************************
   ***       R I M B O R S I        ***
   ************************************/
  -- inserisce le voci di rimborso, sommando i valori per ogni codice
  -- importante: cod_valuta non viene raggruppato per evitare problemi con la gestione win
  --             in pratica non è possibile indicare per lo stesso codice due valute diverse,
  --             perché in win questo scenario non è gestito
  for t3 in c3 loop
    select count(*) into wCOUNT_A from M050_RIMBORSI
    where ID_MISSIONE = pID and CODICERIMBORSOSPESE = t3.CODICE;
    if wCOUNT_A = 0 then
      insert into M050_RIMBORSI 
        (ID_MISSIONE, PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA,
         CODICERIMBORSOSPESE,COD_VALUTA_EST, IMPORTORIMBORSOSPESE, IMPORTOCOSTORIMBORSO)
      values
        (t3.ID_MISSIONE, t3.PROGRESSIVO, t3.MESESCARICO, t3.MESECOMPETENZA, t3.DATADA, t3.ORADA,
         t3.CODICE, t3.COD_VALUTA, decode(t3.TIPO_QUANTITA,'F',0,t3.RIMBORSO), t3.RIMBORSO);
    else
      /*in caso di riapertura dei rimborsi è possibile che il codice esista già, 
      per cui si deve sommare il nuovo rimborso a quello già esistente*/
      update M050_RIMBORSI
      set IMPORTORIMBORSOSPESE = IMPORTORIMBORSOSPESE + decode(t3.TIPO_QUANTITA,'F',0,t3.RIMBORSO), 
          IMPORTOCOSTORIMBORSO = IMPORTOCOSTORIMBORSO + t3.RIMBORSO
      where ID_MISSIONE = pID
      and   CODICERIMBORSOSPESE = t3.CODICE;
    end if;
  end loop;

  -- se il rimborso è dettagliato scrive i record di dettaglio su M051
  if wRIMB_DETT = 'S' then

    -- estrae il primo codice tipo pagamento con somma 'S'
    select min(CODICE)
    into   wTIPO_RIMBORSO
    from   M049_TIPOPAGAMENTO
    where  SOMMA = 'S';

    -- inserisce le voci di dettaglio per ogni codice rimborso
    insert into M051_DETTAGLIORIMBORSO (PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA,
                                        CODICERIMBORSOSPESE, PROGRIMBORSO, DATARIMBORSO,
                                        IMPORTO, TIPORIMBORSO, IMPORTO_VALEST)
      select M040.PROGRESSIVO, M040.MESESCARICO, M040.MESECOMPETENZA, M040.DATADA, M040.ORADA,
             M150.CODICE, M150.ID_RIMBORSO, M150.DATA_RIMBORSO,
             nvl(M150.RIMBORSO_VARIATO,M150.RIMBORSO), wTIPO_RIMBORSO, null
      from   M040_MISSIONI M040,
             M150_RICHIESTE_RIMBORSI M150,
             M020_TIPIRIMBORSI M020
      where  M040.ID_MISSIONE = pID
      and    M040.ID_MISSIONE = M150.ID
      and    M150.CODICE = M020.CODICE
      and    M150.STATO = 'S';
  end if;

  /************************************
   ***   I N D E N N I T A    K M   ***
   ************************************/
  -- inserisce le voci di indennità km, sommando i valori per ogni codice
  for t4 in c4 loop
    select count(*) into wCOUNT_A from M052_INDENNITAKM
    where ID_MISSIONE = pID and CODICEINDENNITAKM = t4.CODICE;
    if wCOUNT_A = 0 then
      insert into M052_INDENNITAKM 
        (ID_MISSIONE,PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICEINDENNITAKM, KMPERCORSI, IMPORTOINDENNITA)
      values
        (t4.ID_MISSIONE, t4.PROGRESSIVO, t4.MESESCARICO, t4.MESECOMPETENZA, t4.DATADA, t4.ORADA, t4.CODICE, t4.KMPERCORSI, t4.RIMBORSO);
    else
      /*in caso di riapertura dei rimborsi è possibile che il codice esista già, 
      per cui si deve sommare il nuovo rimborso a quello già esistente*/
      update M052_INDENNITAKM
      set KMPERCORSI = KMPERCORSI + t4.KMPERCORSI, 
          IMPORTOINDENNITA = IMPORTOINDENNITA + t4.RIMBORSO
      where ID_MISSIONE = pID
      and   CODICEINDENNITAKM = t4.CODICE;
    end if;
  end loop;

  -- TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
  -- aggiorna lo stato dei rimborsi importati da 'S' a 'I'
  update M150_RICHIESTE_RIMBORSI
  set    STATO = 'I'
  where  ID = pID
  and    STATO = 'S';
  -- TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine

  /************************************
   ***        A N T I C I P I       ***
   ************************************/
  -- inserisce le voci di anticipo
  for t1 in c1 loop
    begin
      insert into M050_RIMBORSI
        (ID_MISSIONE, PROGRESSIVO, MESESCARICO, MESECOMPETENZA, DATADA, ORADA, CODICERIMBORSOSPESE, IMPORTORIMBORSOSPESE, IMPORTOCOSTORIMBORSO)
      values
        (T1.ID_MISSIONE, T1.PROGRESSIVO, T1.MESESCARICO, T1.MESECOMPETENZA, T1.DATADA, T1.ORADA, T1.COD_VOCE, T1.IMPORTO, T1.IMPORTO);
      update M060_ANTICIPI set
        DATA_IMPOSTAZIONE_STATO = trunc(sysdate),
        STATO = 'P'
      where ROWID = T1.ROWID;
    exception
      when dup_val_on_index then
        null;
    end;
  end loop;

  /************************************
   ***     D E T T A G L I   G G    ***
   ************************************/
  -- inserisce i dettagli attività (servizio / viaggio)
  for t2 in c2 loop
    insert into M043_DETTAGLIOGG
      (ID, TIPO, DATA, DALLE, ALLE, NOTE)
    values
      (T2.ID, T2.TIPO, T2.DATA, T2.DALLE, T2.ALLE, replace(T2.NOTE,chr(13) || chr(10),' '));
  end loop;

  /************************************
   ***  P R O C E D U R E   U S R   ***
   ************************************/
  -- verifica l'esistenza della procedure personalizzata per il caricamento dei giustificativi
  select count(*)
  into   wCONTA_PROC
  from   user_procedures
  where  upper(object_name) = 'USR_M050P_CARICA_GIUST_DAITER';

  -- se la procedure esiste, la esegue ignorando eventuali eccezioni sollevate
  if wCONTA_PROC > 0 then
    begin
      wCODE:='BEGIN USR_M050P_CARICA_GIUST_DAITER(:id_missione); END;';
      execute immediate wCODE using in pID;
    exception
      when others then
        null;
    end;
  end if;

  -- imposta stato D = Da liquidare
  wSTATO:='D';

  -- impostazione mese di scarico, eccetto che nel caso che la missione sia già stata liquidata dove si mantiene il mesescarico precedente
  -- non si incrementa il mese scarico se la regola delle missioni sui parametri dello scarico paghe prevede che mese scarico venga mantenuto sempre uguale a mese missione
  wINCMMSCARICO:='S';
  begin
    --Estrae progressivo, data e tipo trasferta
    select M040.PROGRESSIVO, M040.DATAA, M040.TIPOREGISTRAZIONE into wProgressivo, wDataA, wTipoRegistrazione from M040_MISSIONI M040 where M040.ID_MISSIONE = pID;
    --Estrare campo di T430_STORICO utilizzato per le regole delle missioni
    select dato
    into   wDatoRegola
    from   mondoedp.i091_datiente
    where  azienda = t000f_getaziendacorrente()
    and    tipo = 'C8_MISSIONE';
    --Estrae il codice della regola della missione
    if wDatoRegola is not null then
      wEspr:='select ' || wDatoRegola || ' from T430_STORICO ' ||
             'where  PROGRESSIVO = :progressivo ' ||
             'and    :datarif between DATADECORRENZA and DATAFINE';
      execute immediate wEspr into wCodRegola using wProgressivo, wDataA;
    end if;
  exception
    when no_data_found then
      null;
  end;
  if wCodRegola is not null then
    select DATARIF_VOCEPAGHE into wDataRifVocePaghe from M010_PARAMETRICONTEGGIO M010 where M010.CODICE = wCodRegola and M010.TIPO_MISSIONE = wTipoRegistrazione
      and M010.DECORRENZA = (select max(M010A.DECORRENZA) from M010_PARAMETRICONTEGGIO M010A where M010A.CODICE = M010.CODICE and M010A.TIPO_MISSIONE = M010.TIPO_MISSIONE
                               and M010A.DECORRENZA <= wDataA);
    if wDataRifVocePaghe = 'C' then
      wINCMMSCARICO:='N';
    end if;
  end if;

  -- solo se la procedure non esiste aggiorno mese scarico
  if wINCMMSCARICO = 'S' then
    update M040_MISSIONI
    set    MESESCARICO = greatest(trunc(nvl(wMESECOMPETENZA,MESESCARICO),'mm'),MESESCARICO)
    where  ID_MISSIONE = pID
    and    nvl(STATO,'S') <> 'L';
  end if;

  -- abilitazione alla liquidazione della missione
  update M040_MISSIONI
  set    STATO = wSTATO --'D'
  where  ID_MISSIONE = pID;

  update T850_ITER_RICHIESTE
  set    TIPO_RICHIESTA = '6'
  where  ITER = 'M140'
  and    ID = pID
  and    TIPO_RICHIESTA <> 'A';

  -- TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
  update M140_RICHIESTE_MISSIONI
  set    MISSIONE_RIAPERTA = 'N'
  where  ID = pID;
  -- TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
end;
/