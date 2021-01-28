create or replace procedure ALLINEA_PERIODI_STORICI (
  PROGIRIS                   in  number               ,     -- progressivo del dipendente
  FLAG                       in  number               ,     -- obsoleto, non utilizzato
  ERRORE                     out varchar2             ,     -- eventuale errore occorso
  AGGIORNA_ASSEG_AUTO_LIBERA in  varchar2             ,     -- specifica se sovrascrivere il campo già valorizzato nelle relazioni di tipo libero
  ESEGUI_TUTTE_RELAZIONI     in  varchar2 default 'N' ,     -- specifica quali relazioni considerare (S=tutte, A=solo quelle pilotate da altra tabella, N=solo quelle eventualmente modificate)
  PRE_ALLINEA_ESEGUITA       in  varchar2 default 'N' ,     -- se vale 'S' serve a non eseguire la PreAllineaPeriodiStorici per ogni dipendente
  sCAMPI_NOT_NULL            in  varchar2 default null,     -- contiene l'elenco dei valori di default dei campi not null
  sESP_CUR_REL               in  varchar2 default null,     -- contiene la condizione per ricalcolare solo le relazioni modificate
  sDECORRENZE                in  varchar2 default null,     -- contiene il massimo dettaglio delle decorrenze per creare i periodi storici
  CAMPI_SEL                  in  varchar2 default null,     -- contiene l'elenco dei campi da estrarre per l'appiattimento dei record
  TAB_FROM                   in  varchar2 default null,     -- contiene l'elenco delle tabelle per l'appiattimento dei record
  COND_WHERE                 in  varchar2 default null,     -- contiene l'elenco delle condizioni per l'appiattimento dei record
  P_DAL                      in  date     default null,
  P_AL                       in  date     default null
) as  
/* 
 Questa procedura richiamata per ogni dipendente crea un periodo storico per ogni decorrenza dei dati storici,
 aggiorna le relazioni per ognuno di essi e infine verifica se i dati del periodo successivo sono uguali
 a quelli del precedente unificando in questo caso i due periodi.
*/  

  cursor CLOCK is
    select datadecorrenza
    from   T430_STORICO
    where  progressivo = PROGIRIS
    for update nowait;
  cursor CP430 is
    select decorrenza
    from   P430_ANAGRAFICO
    where  progressivo = PROGIRIS
    and    decorrenza between nvl(P_DAL,PCK_CONST.DATA_NUL) and nvl(P_AL,PCK_CONST.DATA_INF);
  cursor CT430 (p_decorrenza I030_RELAZIONI_ANAGRAFE.decorrenza%TYPE,
                p_scadenza   I030_RELAZIONI_ANAGRAFE.decorrenza_fine%TYPE) is
    select rowid, datadecorrenza, datafine
    from   T430_STORICO
    where  progressivo = PROGIRIS
    and    datadecorrenza between p_decorrenza and p_scadenza
    order by datadecorrenza;
  cursor CI035 (p_tabella     I035_RELAZIONI_DETTAGLIO.tabella%TYPE,
                p_colonna     I035_RELAZIONI_DETTAGLIO.colonna%TYPE,
                p_decorrenza  I035_RELAZIONI_DETTAGLIO.decorrenza%TYPE) is
    select I035.relazione, I035.num
    from   I035_RELAZIONI_DETTAGLIO I035
    where  I035.tabella = p_tabella
    and    I035.colonna = p_colonna
    and    I035.decorrenza = p_decorrenza
    order by I035.num;
  CURSORE_DINAMICO_I030       integer;
  CURS_I030                   integer;
  CURSORE_DINAMICO_SEL_REL    integer;
  CURS_SEL_REL                integer;
  CURSORE_DINAMICO_UPD_REL    integer;
  CURS_UPD_REL                integer;
  CURSORE_DINAMICO_T430       integer;
  CURS_T430                   integer;
  CURSORE_DINAMICO_V430       integer;
  CURS_V430                   integer;
  --
  -- DICHIARAZIONE ARRAY
  type CAMPI_NOT_NULL_TYPE is record
    (x430_colonna   varchar2(100),
     data_default   varchar2(100));
  type ARRAY_CAMPI_NOT_NULL is table of CAMPI_NOT_NULL_TYPE index by binary_integer;
  CAMPI_NOT_NULL_ARR ARRAY_CAMPI_NOT_NULL;
  --
  -- DICHIARAZIONE VARIABILI
  I                           integer         :=0 ;
  ESPRESSIONE                 varchar2(32767) :='';
  SRELAZIONE                  varchar2(32767) :='';
  SRELAZIONE_ORI              varchar2(32767) :='';
  sAPPOGGIO                   varchar2(32767) :='';
  wDECORRENZE                 varchar2(32767) :='';
  wCAMPI_NOT_NULL             varchar2(32767) :='';
  wESP_CUR_REL                varchar2(32767) :='';
  I030_TABELLA                varchar2(30)    :='';
  I030_COLONNA                varchar2(30)    :='';
  I030_TAB_ORIGINE            varchar2(30)    :='';
  I030_TIPO                   varchar2(1)     :='';
  S_APP_DEC                   varchar2(32767) :='';
  S_APP_CNN                   varchar2(32767) :='';
  OLDCAMPO                    varchar2(1000)  :='';
  NEWCAMPO                    varchar2(1000)  :='';
  VALORE                      varchar2(100)   :='';
  wCAMPI_SEL                  varchar2(32767) :='';
  wTAB_FROM                   varchar2(32767) :='';
  wCOND_WHERE                 varchar2(32767) :='';
  wCONSIDERA_REL_ALTRA_TAB    varchar2(1)     :='';
  NROWID                      varchar2(20)    :='';
  NROWIDUPDATE                varchar2(20)    :='';
  NROWIDLOCK                  varchar2(20)    :='';
  VALOREDATI1                 varchar2(32767) :='';
  VALOREDATIOLD               varchar2(32767) :='';
  PART                        integer         :=0 ;
  ARR                         integer         :=0 ;
  CONTINUA_ESTR_RELAZIONE     boolean             ;
  CONTINUA_ESTR_RELAZIONE_ORI boolean             ;
  I030_DECORRENZA             date                ;   -- inizio decorrenza estratta dal cursore sulle relazioni
  I030_SCADENZA               date                ;   -- fine   decorrenza estratta dal cursore sulle relazioni
  DECO_MIN                    date                ;   -- minima decorrenza della T430
  DEC_STO                     date                ;   -- decorrenza per la creazione dello storico
  dDEC_INI                    date                ;   -- inizio decorrenza ricavata dal cursore su P430 al massimo dettaglio
  dDECFINE                    date                ;   -- fine   decorrenza per l'appiattimento dei record senza storicizzazioni
  ULTIMAdFINE                 date                ;   -- fine   decorrenza per l'appiattimento dei record senza storicizzazioni
  dFINE_PREC                  date                ;   -- fine   decorrenza per l'appiattimento dei record senza storicizzazioni
  dDECORRENZA                 date                ;   -- inizio decorrenza per allineare la prima data degli Stipendi con la prima delle Presenze
  dISTANTE                    date                ;

  procedure RECUPERA_RELAZIONE is
  begin
    CONTINUA_ESTR_RELAZIONE:=false;
    SRELAZIONE:='';
    -- RICAVO L'SQL DELLA RELAZIONE
    for RI035 IN CI035 (I030_TABELLA,
                        I030_COLONNA,
                        I030_DECORRENZA) loop
      CONTINUA_ESTR_RELAZIONE:=false;
      if RI035.NUM > PART and RI035.NUM <= ARR then
        SRELAZIONE:=SRELAZIONE||' '||RI035.RELAZIONE;
      elsif RI035.NUM > PART and RI035.NUM > ARR then
        PART:=PART + 20;
        ARR:=ARR + 20;
        CONTINUA_ESTR_RELAZIONE:=true;
        exit;
      end if;
    end loop; -- FINE CI035 --
    SRELAZIONE:=RTRIM(LTRIM(SRELAZIONE));
    if SRELAZIONE is not null then
      while INSTR(SRELAZIONE,'<#>') > 0 loop
        sAPPOGGIO:=SUBSTR(SRELAZIONE,INSTR(SRELAZIONE,'<#>')+3);
        OLDCAMPO:=SUBSTR(sAPPOGGIO,1,INSTR(sAPPOGGIO,'<#>')-1);
        if OLDCAMPO = 'DECORRENZA' then
          NEWCAMPO:='T1.'||'DATADECORRENZA';
        elsif OLDCAMPO = 'DECORRENZA_FINE' then
          NEWCAMPO:='T1.'||'DATAFINE';
        elsif OLDCAMPO = ';' then
          NEWCAMPO:=' UNION select ';
        elsif OLDCAMPO = 'W' then
          NEWCAMPO:=' from '||I030_TAB_ORIGINE||' T1 where T1.PROGRESSIVO = '||TO_CHAR(PROGIRIS);
          if I030_TAB_ORIGINE = 'T430_STORICO' then
            NEWCAMPO:=NEWCAMPO||' and :dDEC_INI BETWEEN T1.DATADECORRENZA and T1.DATAFINE and ';
          else
            NEWCAMPO:=NEWCAMPO||' and :dDEC_INI BETWEEN T1.DECORRENZA and T1.DECORRENZA_FINE and ';
          end if;
        elsif OLDCAMPO = 'D' then
          NEWCAMPO:=' from '||I030_TAB_ORIGINE||' T1 where T1.PROGRESSIVO = '||TO_CHAR(PROGIRIS);
          if I030_TAB_ORIGINE = 'T430_STORICO' then
            NEWCAMPO:=NEWCAMPO||' and :dDEC_INI BETWEEN T1.DATADECORRENZA and T1.DATAFINE ';
          else
            NEWCAMPO:=NEWCAMPO||' and :dDEC_INI BETWEEN T1.DECORRENZA and T1.DECORRENZA_FINE ';
          end if;
        else
          NEWCAMPO:='T1.'||OLDCAMPO;
        end if;
        SRELAZIONE:=replace(SRELAZIONE,'<#>'||OLDCAMPO||'<#>',NEWCAMPO);
      end loop; -- FINE RICERCA <#> --
      if NVL(SUBSTR(SRELAZIONE,LENGTH(SRELAZIONE)-13,14),'#null#') = ' UNION select ' then
        SRELAZIONE:=SUBSTR(SRELAZIONE,1,LENGTH(SRELAZIONE)-14);
      end if;
      if LENGTH(SRELAZIONE) > 0 then
        if SUBSTR(SRELAZIONE,1,6) <> 'select' then
          SRELAZIONE:='select '||SRELAZIONE;
        end if;
        if INSTR(SRELAZIONE,' from ') = 0 then
          SRELAZIONE:=SRELAZIONE||' from '||I030_TAB_ORIGINE||' T1 where T1.PROGRESSIVO = '||TO_CHAR(PROGIRIS);
          if I030_TAB_ORIGINE = 'T430_STORICO' then
            NEWCAMPO:=NEWCAMPO||' and :dDEC_INI BETWEEN T1.DATADECORRENZA and T1.DATAFINE ';
          else
            NEWCAMPO:=NEWCAMPO||' and :dDEC_INI BETWEEN T1.DECORRENZA and T1.DECORRENZA_FINE ';
          end if;
        end if;
      end if;
      SRELAZIONE:=RTRIM(LTRIM(SRELAZIONE));
    end if;
  end;
-- INIZIO ELABORAZIONE
begin
  select min(sysdate) into dISTANTE from DUAL;
  insert into T030_NOTRIGGER (PROGRESSIVO,ISTANTE) values (PROGIRIS,dISTANTE);
  -- Imposto condizione di non errore nella varibile di output
  ERRORE:='';
  -- TENTO DI LOCKARE TUTTE LE DECORRENZE DEL DIPENDENTE SU T430
  begin
    for TLOCK IN CLOCK loop
      null;
    end loop;
  exception
    when others then
      -- Imposto condizione di errore per dipendente occupato
      ERRORE:='OC';
      rollback;
      goto FINE_AGGIORNAMENTO;
  end;
  -- CHIUDO GLI EVENTUALI BUCHI TRA LE DECORRENZE DI T430
  for RT430 IN CT430(PCK_CONST.DATA_NUL,PCK_CONST.DATA_INF) loop
    if NROWIDUPDATE is not null then
      if dFINE_PREC <> RT430.DATADECORRENZA - 1 then
        --dbms_output.put_line('update T430_STORICO set DATAFINE = RT430.DATADECORRENZA - 1 where ROWID = NROWIDUPDATE;');
        update T430_STORICO set DATAFINE = RT430.DATADECORRENZA - 1 where ROWID = NROWIDUPDATE;
      end if;
    end if;
    NROWIDUPDATE:=RT430.ROWID;
    dFINE_PREC:=RT430.DATAFINE;
  end loop; -- FINE CT430 --
  if NROWIDUPDATE is not null then
    --dbms_output.put_line('update T430_STORICO set DATAFINE = 31/12/3999 where ROWID = NROWIDUPDATE;');
    update T430_STORICO set DATAFINE = PCK_CONST.DATA_INF where ROWID = NROWIDUPDATE;
  end if;
  -- INIZIALIZZO LE VARIABILI IN BASE AI PARAMETRI
  wCAMPI_NOT_NULL:=sCAMPI_NOT_NULL;
  wESP_CUR_REL:=sESP_CUR_REL;
  wDECORRENZE:=sDECORRENZE;
  wCAMPI_SEL:=CAMPI_SEL;
  wTAB_FROM:=TAB_FROM;
  wCOND_WHERE:=COND_WHERE;
  if ESEGUI_TUTTE_RELAZIONI = 'S' then
    wCONSIDERA_REL_ALTRA_TAB:=NULL;
  elsif ESEGUI_TUTTE_RELAZIONI = 'A' then
    wCONSIDERA_REL_ALTRA_TAB:='S';
  elsif ESEGUI_TUTTE_RELAZIONI = 'N' then
    wCONSIDERA_REL_ALTRA_TAB:='N';
  end if;

  -- SELEZIONO LA MINIMA DECORRENZA DI T430
  begin
    select  min(DATADECORRENZA)
    into    DECO_MIN
    from    T430_STORICO
    where   PROGRESSIVO = PROGIRIS;
  exception
    when others then
      DECO_MIN:=TO_DATE('01011900','DDMMYYYY');
  end;
  
  -- RICHIAMO LA PRE_ALLINEA SE NON È GIÀ STATO FATTO
  if PRE_ALLINEA_ESEGUITA = 'N' then
    PRE_ALLINEA_PERIODI_STORICI(wCAMPI_NOT_NULL, wESP_CUR_REL, wDECORRENZE, wCAMPI_SEL, wTAB_FROM, wCOND_WHERE, wCONSIDERA_REL_ALTRA_TAB, -1, 'S', 'N');
  end if;
  -- SVUOTO IL FILTRO SE DEVO CONSIDERARE TUTTE LE RELAZIONI
  if ESEGUI_TUTTE_RELAZIONI = 'S' then
    wESP_CUR_REL:='';
  end if;
  
  if nvl(wESP_CUR_REL,'nvl') <> ' and 1 = 2 ' then
    -- CICLO SULLE DECORRENZE DELLA P430
    for RP430 IN CP430 loop
      -- CREO UNO STORICO PER OGNI DECORRENZA DELLA P430
      if NVL(INSTR(wDECORRENZE,TO_CHAR(RP430.DECORRENZA,'DDMMYYYY') || ','),0) = 0 then
        wDECORRENZE:=wDECORRENZE || TO_CHAR(RP430.DECORRENZA,'DDMMYYYY') || ',';
      end if;
    end loop; -- FINE CP430 --
    
    --Creazione periodi storici per ogni decorrenza individuata
    if wDECORRENZE is not null then
      -- CREO LE DECORRENZE RICAVATE
      S_APP_DEC:=wDECORRENZE;
      while INSTR(S_APP_DEC,',') > 0 loop
        DEC_STO:=TO_DATE(SUBSTR(S_APP_DEC,1,8),'DDMMYYYY');
        if DEC_STO between greatest(DECO_MIN,nvl(P_DAL,PCK_CONST.DATA_NUL)) and nvl(P_AL,PCK_CONST.DATA_INF) then
          --dbms_output.put_line('CREAZIONE_STORICO(PROGIRIS,DEC_STO,null);');  
          CREAZIONE_STORICO(PROGIRIS,DEC_STO,null);
        end if;
        S_APP_DEC:=SUBSTR(S_APP_DEC,10);
      end loop;
    end if;
    
    -- RECUPERO I CAMPI not null
    S_APP_CNN:=wCAMPI_NOT_NULL;
    I:=0;
    while INSTR(S_APP_CNN,',') > 0 loop
      I:=I+1;
      CAMPI_NOT_NULL_ARR(I).X430_COLONNA:=SUBSTR(S_APP_CNN,1,INSTR(S_APP_CNN,'-')-1);
      S_APP_CNN:=SUBSTR(S_APP_CNN,INSTR(S_APP_CNN,'-')+1);
      CAMPI_NOT_NULL_ARR(I).DATA_DEFAULT:=SUBSTR(S_APP_CNN,1,INSTR(S_APP_CNN,',')-1);
      S_APP_CNN:=SUBSTR(S_APP_CNN,INSTR(S_APP_CNN,',')+1);
    end loop;
  end if;  
  -- CICLO SULLE RELAZIONI DI TIPO VINCOLATO E LIBERO
  ESPRESSIONE:='select I030.tabella, I030.colonna, I030.decorrenza, I030.decorrenza_fine scadenza, I030.tab_origine, I030.tipo' ||
               ' from I030_RELAZIONI_ANAGRAFE I030 where I030.tabella = :p_tabella and I030.tipo IN (''L'',''S'')';
  if P_DAL is not null or P_AL is not null then
    ESPRESSIONE:=ESPRESSIONE||' and I030.decorrenza <= to_date('''||to_char(nvl(P_AL,PCK_CONST.DATA_INF),'ddmmyyyy')||''',''ddmmyyyy'')';
    ESPRESSIONE:=ESPRESSIONE||' and I030.decorrenza_fine >= to_date('''||to_char(nvl(P_DAL,PCK_CONST.DATA_NUL),'ddmmyyyy')||''',''ddmmyyyy'')';
  end if;  
  ESPRESSIONE:=ESPRESSIONE||wESP_CUR_REL||' order by I030.ordine, I030.tabella, I030.colonna, I030.decorrenza';
  CURSORE_DINAMICO_I030:=DBMS_SQL.OPEN_CURSOR;
  begin --CURSORE_DINAMICO_I030
    --dbms_output.put_line('I030: '||ESPRESSIONE);  
    DBMS_SQL.PARSE(CURSORE_DINAMICO_I030,ESPRESSIONE,DBMS_SQL.NATIVE);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,1,I030_TABELLA,30);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,2,I030_COLONNA,30);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,3,I030_DECORRENZA);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,4,I030_SCADENZA);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,5,I030_TAB_ORIGINE,30);
    DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_I030,6,I030_TIPO,1);
    DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_I030,'p_tabella','T430_STORICO');
    CURS_I030:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_I030);
    loop
      if DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_I030) > 0 then
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 1, I030_TABELLA);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 2, I030_COLONNA);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 3, I030_DECORRENZA);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 4, I030_SCADENZA);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 5, I030_TAB_ORIGINE);
        DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_I030, 6, I030_TIPO);
        --
        PART:=0;
        ARR:=20;
        RECUPERA_RELAZIONE; -- IMPOSTA SRELAZIONE
        -- ESTRAGGO IL VALORE CON L'SQL CHE HO RICAVATO
        if SRELAZIONE is not null then
          SRELAZIONE_ORI:=SRELAZIONE;
          CONTINUA_ESTR_RELAZIONE_ORI:=CONTINUA_ESTR_RELAZIONE;
          -- PREPARO IL CURSORE DINAMICO PER NON ESEGUIRE TUTTE LE VOLTE OPEN E PARSE
          CURSORE_DINAMICO_SEL_REL:=DBMS_SQL.OPEN_CURSOR;
          begin--CURSORE_DINAMICO_SEL_REL
          --dbms_output.put_line('SEL_REL: '||SRELAZIONE);  
          DBMS_SQL.PARSE(CURSORE_DINAMICO_SEL_REL,SRELAZIONE,DBMS_SQL.NATIVE);
          DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_SEL_REL,1,VALORE,100);
          -- CICLO SULLE DECORRENZE DELLA T430 (ORMAI AL MASSIMO DETTAGLIO)
          for RT430 IN CT430 (I030_DECORRENZA,I030_SCADENZA) loop
            dDEC_INI:=RT430.DATADECORRENZA;
            begin
              -- SE PER LA DECORRENZA PRECEDENTE AVEVO MODIFICATO IL CURSORE, REIMPOSTO IL TESTO ORIGINALE
              if SRELAZIONE_ORI <> SRELAZIONE then
                SRELAZIONE:=SRELAZIONE_ORI;
                --dbms_output.put_line('SEL_REL2: '||SRELAZIONE);  
                DBMS_SQL.PARSE(CURSORE_DINAMICO_SEL_REL,SRELAZIONE,DBMS_SQL.NATIVE);
                DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_SEL_REL,1,VALORE,100);
                CONTINUA_ESTR_RELAZIONE:=CONTINUA_ESTR_RELAZIONE_ORI;
                PART:=20;
                ARR:=40;
              end if;
              -- CICLO SUGLI SPEZZONI DELLA RELAZIONE FINCHÉ TROVO IL VALORE DA AGGIORNARE OPPURE FINISCO LE RIGHE
              loop -- INIZIO CONTINUA_ESTR_RELAZIONE --
                DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_SEL_REL,'dDEC_INI',dDEC_INI);
                CURS_SEL_REL:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_SEL_REL);
                if DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_SEL_REL)>0 then
                  DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_SEL_REL, 1, VALORE);
                  if (not CONTINUA_ESTR_RELAZIONE) or (VALORE is not null) then
                    if VALORE is null then
                      -- IMPOSTO LA VARIABILE A null PER L'AGGIORNAMENTO
                      VALORE:='null';
                      -- VERIFICO SE QUESTO CAMPO DEVE ESSERE VALORIZZATO E QUAL E' IL VALORE DI DEFAULT
                      for I IN 1..CAMPI_NOT_NULL_ARR.COUNT loop
                        if CAMPI_NOT_NULL_ARR(I).X430_COLONNA = I030_COLONNA then
                        -- SE IL CAMPO DEVE ESSERE VALORIZZATO ASSEGNO IL VALORE DI DEFAULT
                          VALORE:=CAMPI_NOT_NULL_ARR(I).DATA_DEFAULT;
                          exit;
                        end if;
                      end loop;
                    else
                      VALORE:=''''||replace(VALORE,'''','''''')||'''';
                    end if;
                  else
                    -- RECUPERO IL TESTO DELLA RELAZIONE DALLE RIGHE SUCCESSIVE DI I035 E LO ASSEGNO AL CURSORE DINAMICO
                    RECUPERA_RELAZIONE; -- IMPOSTA SRELAZIONE
                    if SRELAZIONE is not null then
                      --dbms_output.put_line('SEL_REL3: '||SRELAZIONE);  
                      DBMS_SQL.PARSE(CURSORE_DINAMICO_SEL_REL,SRELAZIONE,DBMS_SQL.NATIVE);
                      DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_SEL_REL,1,VALORE,100);
                    end if;
                  end if;
                else
                  -- SE ADDIRITTURA NON TROVO LA RIGA DI I030_TAB_ORIGINE, IMPOSTO LA VARIABILE A null PER L'AGGIORNAMENTO
                  VALORE:='null';
                end if;
                exit when VALORE is not null;
              end loop; -- FINE CONTINUA_ESTR_RELAZIONE --
              -- ESEGUO L'AGGIORNAMENTO CON IL VALORE CHE HO ESTRATTO
              ESPRESSIONE:='update '||I030_TABELLA||
                          ' set '||I030_COLONNA||' = '||VALORE||
                          ' where PROGRESSIVO = '||TO_CHAR(PROGIRIS)||
                          ' and DATADECORRENZA = :dDEC_INI';
              if I030_TIPO = 'L' and NVL(AGGIORNA_ASSEG_AUTO_LIBERA,'N') = 'N' then
                ESPRESSIONE:=ESPRESSIONE || ' and '||I030_COLONNA||' is null';
              end if;
              CURSORE_DINAMICO_UPD_REL:=DBMS_SQL.OPEN_CURSOR;
              begin
                --dbms_output.put_line('UPD_REL: '||ESPRESSIONE);  
                DBMS_SQL.PARSE(CURSORE_DINAMICO_UPD_REL,ESPRESSIONE,DBMS_SQL.NATIVE);
                DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_UPD_REL,'dDEC_INI',dDEC_INI);
                CURS_UPD_REL:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_UPD_REL);
              exception
                when others then
                  null;
              end;
              DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_UPD_REL);
            exception
              -- SE NON RIESCO AD EFFETTUARE L'ESTRAZIONE DEL VALORE O L'AGGIORNAMENTO DELLA TABELLA PASSO AL RECORD SUCCESSIVO
              when others then null;
            end;
          end loop; -- FINE CT430 --
          exception
            when others then null;
          end;--CURSORE_DINAMICO_SEL_REL
          DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_SEL_REL);
        end if;
      else
        exit;
      end if;
    end loop; -- FINE CURSORE_DINAMICO_I030 --
  exception
    when others then null;
  end;--CURSORE_DINAMICO_I030
  DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_I030);
  
  -- RICHIAMO ANCORA LA PRE_ALLINEA PER GESTIRE LE DECORRENZE DEI DATI STORICIZZATI
  if PRE_ALLINEA_ESEGUITA = 'N' then
    wDECORRENZE:=null;
    PRE_ALLINEA_PERIODI_STORICI(wCAMPI_NOT_NULL, wESP_CUR_REL, wDECORRENZE, wCAMPI_SEL, wTAB_FROM, wCOND_WHERE, wCONSIDERA_REL_ALTRA_TAB, PROGIRIS, 'N', 'S');

    --Creazione periodi storici per ogni decorrenza individuata
    if wDECORRENZE is not null then
      -- CREO LE DECORRENZE RICAVATE
      S_APP_DEC:=wDECORRENZE;
      while INSTR(S_APP_DEC,',') > 0 loop
        DEC_STO:=TO_DATE(SUBSTR(S_APP_DEC,1,8),'DDMMYYYY');
        --if DEC_STO > DECO_MIN then
        if DEC_STO between greatest(DECO_MIN,nvl(P_DAL,PCK_CONST.DATA_NUL)) and nvl(P_AL,PCK_CONST.DATA_INF) then
          --dbms_output.put_line('CREAZIONE_STORICO(PROGIRIS,DEC_STO,null);');  
          CREAZIONE_STORICO(PROGIRIS,DEC_STO,null);
        end if;
        S_APP_DEC:=SUBSTR(S_APP_DEC,10);
      end loop;
    end if;
  end if;
  
  -- Appiattimento storici uguali
  -- eseguo selezione di T430_STORICO concatenando tutti i campi tranne datadecorrenza e datafine
  ESPRESSIONE:='select DISTINCT T430.ROWID, T430.DATAFINE, ' || wCAMPI_SEL || ' from T430_STORICO T430' || wTAB_FROM ||' where T430.PROGRESSIVO = :PROGIRIS';
  if P_DAL is not null or P_AL is not null then
    ESPRESSIONE:=ESPRESSIONE||' and T430.DATADECORRENZA <= to_date('''||to_char(nvl(P_AL,PCK_CONST.DATA_INF),'ddmmyyyy')||''',''ddmmyyyy'')';
    ESPRESSIONE:=ESPRESSIONE||' and T430.DATAFINE >= to_date('''||to_char(nvl(P_DAL,PCK_CONST.DATA_NUL),'ddmmyyyy')||''',''ddmmyyyy'')';
  end if;  
  ESPRESSIONE:=ESPRESSIONE||wCOND_WHERE || ' order by T430.DATAFINE';
  -- cursore che legge i periodi storici
  CURSORE_DINAMICO_T430:=DBMS_SQL.OPEN_CURSOR;
  begin --CURSORE_DINAMICO_T430
  --dbms_output.put_line('T430: '||ESPRESSIONE);    
  DBMS_SQL.PARSE(CURSORE_DINAMICO_T430,ESPRESSIONE,DBMS_SQL.NATIVE);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T430,1,NROWID,20);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T430,2,dDECFINE);
  DBMS_SQL.DEFINE_COLUMN(CURSORE_DINAMICO_T430,3,VALOREDATI1,5000);
  DBMS_SQL.BIND_VARIABLE(CURSORE_DINAMICO_T430, 'PROGIRIS', PROGIRIS);
  CURS_T430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_T430);
  NROWIDUPDATE:='';
  VALOREDATIOLD:='';
  ULTIMAdFINE:=null;
  loop
    -- scorrimento sui record dei periodi storici
    if DBMS_SQL.FETCH_ROWS(CURSORE_DINAMICO_T430)>0 then
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T430, 1, NROWID);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T430, 2, dDECFINE);
      DBMS_SQL.COLUMN_VALUE(CURSORE_DINAMICO_T430, 3, VALOREDATI1);
      -- se non e' stata fatta ancora nessuna lettura precedente
      if VALOREDATIOLD is null then
        -- memorizzo dati da confrontare e rowid del periodo storico di cui aggiornare datafine
        VALOREDATIOLD:=VALOREDATI1;
        NROWIDUPDATE:=NROWID;
      elsif NROWID <> NROWIDUPDATE then -- la condizione di diversità dei RowId (rafforzata dalla Distinct nel cursore) serve a gestire l'eventuale bug di prodotto cartesiano
        if VALOREDATI1 = VALOREDATIOLD then
          -- memorizzo la data di fine che servira' per aggiornare il primo periodo
          -- storico precedente con i dati uguali
          ULTIMAdFINE:=dDECFINE;
          -- cancello il periodo storico con dati uguali al precedente
          --dbms_output.put_line('delete T430_STORICO where ROWID = NROWID;');
          delete T430_STORICO where ROWID = NROWID;
        else
          if ULTIMAdFINE is not null then
            -- se esiste un record precedente con dati uguali aggiorno la data fine
            --dbms_output.put_line('update T430_STORICO set DATAFINE = ULTIMAdFINE where ROWID = NROWIDUPDATE');
            update T430_STORICO set DATAFINE = ULTIMAdFINE where ROWID = NROWIDUPDATE;
            ULTIMAdFINE:=null;
          end if;
          -- salvo il valore dei dati letti per nuovo confronto
          VALOREDATIOLD:=VALOREDATI1;
          -- reimposto il rowid che sara' eventualmente da updatare
          NROWIDUPDATE:=NROWID;
        end if;
      end if;
    else
      exit;
    end if;
  end loop;
  if ULTIMAdFINE is not null then
    -- se esiste un record precedente con dati uguali aggiorno la data fine
    --dbms_output.put_line('update T430_STORICO set DATAFINE = ULTIMAdFINE where ROWID = NROWIDUPDATE');
    update T430_STORICO set DATAFINE = ULTIMAdFINE where ROWID = NROWIDUPDATE;
  end if;
  exception
    when others then null;
  end; --CURSORE_DINAMICO_T430
  DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_T430);
  --
   -- Forzo la prima decorrenza al minimo tra t430datadecorrenza e p430decorrenza
  select NVL(MIN(LEAST(T430.DATADECORRENZA,TRUNC(P430.DECORRENZA,'MM'))),MIN(T430.DATADECORRENZA)) into dDECORRENZA
    from T430_STORICO T430, P430_ANAGRAFICO P430
    where T430.PROGRESSIVO = PROGIRIS and P430.PROGRESSIVO(+) = T430.PROGRESSIVO;
  --dbms_output.put_line('update T430_STORICO T430 set DATADECORRENZA = dDECORRENZA where PROGRESSIVO = PROGIRIS and...');  
  update T430_STORICO T430 set DATADECORRENZA = dDECORRENZA where PROGRESSIVO = PROGIRIS
    and DATADECORRENZA = (select MIN(DATADECORRENZA) from T430_STORICO where PROGRESSIVO = T430.PROGRESSIVO);
  -- TENTO DI LOCKARE LA DECORRENZA DEL DIPENDENTE SU P430 PER AGGIORNARLA
  begin
    NROWIDLOCK:='';
    select ROWID
    into   NROWIDLOCK
    from   P430_ANAGRAFICO P430
    where  PROGRESSIVO = PROGIRIS
    and    DECORRENZA = (select MIN(DECORRENZA)
                         from   P430_ANAGRAFICO
                         where  PROGRESSIVO = P430.PROGRESSIVO)
    for update nowait;
    -- SE SONO RIUSCITO A LOCKARE LA DECORRENZA DEL DIPENDENTE SU P430 LA AGGIORNO
    update P430_ANAGRAFICO P430 set DECORRENZA = dDECORRENZA where P430.PROGRESSIVO = PROGIRIS
      and P430.DECORRENZA = (select MIN(DECORRENZA) from P430_ANAGRAFICO where PROGRESSIVO = P430.PROGRESSIVO);
  exception
    when others then
      null;
  end;
<<FINE_AGGIORNAMENTO>>
  delete from T030_NOTRIGGER where PROGRESSIVO = PROGIRIS and ISTANTE = dISTANTE;
  --Gestione V430 materializzata
  begin
    select count(*) into i from tabs where TABLE_NAME = 'V430_STORICO';
    if i = 1 then
      CURSORE_DINAMICO_V430:=DBMS_SQL.OPEN_CURSOR;
      ESPRESSIONE:='delete from V430_STORICO where T430PROGRESSIVO = ' || PROGIRIS;
      DBMS_SQL.PARSE(CURSORE_DINAMICO_V430,ESPRESSIONE,DBMS_SQL.NATIVE);
      CURS_V430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_V430);
      ESPRESSIONE:='insert into V430_STORICO select * from V430_STORICO_VIEW where T430PROGRESSIVO = ' || PROGIRIS;
      DBMS_SQL.PARSE(CURSORE_DINAMICO_V430,ESPRESSIONE,DBMS_SQL.NATIVE);
      CURS_V430:=DBMS_SQL.EXECUTE(CURSORE_DINAMICO_V430);
      DBMS_SQL.CLOSE_CURSOR(CURSORE_DINAMICO_V430);
    end if;
  exception
    when others then null;
  end;
  commit;
exception
  when others then
    rollback;
    delete from T030_NOTRIGGER where PROGRESSIVO = PROGIRIS and ISTANTE = dISTANTE;
    commit;
end;
/
