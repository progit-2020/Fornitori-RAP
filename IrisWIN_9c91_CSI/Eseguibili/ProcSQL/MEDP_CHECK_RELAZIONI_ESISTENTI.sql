create or replace function MEDP_CHECK_RELAZIONI_ESISTENTI
 (P_MASCHERA in varchar2, P_TABELLA in varchar2, P_CHIAVE in varchar2, 
  P_DECORRENZA in date, P_SCADENZA in date) 
  return varchar2 is
  RESULT varchar2(2000);

  COLONNA varchar2(50);
  COLONNA_SUCC varchar2(50);
  MYSQL varchar2(500);
  MYCOUNT number;
  MYDECORRENZA date;
  MYSCADENZA date;
  MYDECORRENZA_SUCC date;
  /*   (Campo:'COMUNE';Tabella:'T480_COMUNI';Codice:'CODICE';Storico:'N'),
       (Campo:'CONTRATTO';Tabella:'T200_CONTRATTI';Codice:'CODICE';Storico:'N'),
       (Campo:'PERSELASTICO';Tabella:'T025_CONTMENSILI';Codice:'CODICE';Storico:'N'),
       (Campo:'PLUSORA';Tabella:'T060_PLUSORARIO';Codice:'CODICE';Storico:'N'),
       (Campo:'CALENDARIO';Tabella:'T010_CALENDIMPOSTAZ';Codice:'CODICE';Storico:'N'),
       (Campo:'IPRESENZA';Tabella:'T163_CODICIINDENNITA';Codice:'CODICE';Storico:'N'),
       (Campo:'PORARIO';Tabella:'T220_PROFILIORARI';Codice:'CODICE';Storico:'S'),
       (Campo:'PASSENZE';Tabella:'T261_DESCPROFASS';Codice:'CODICE';Storico:'N'),
       (Campo:'SQUADRA';Tabella:'T600_SQUADRE';Codice:'CODICE';Storico:'N'),
       (Campo:'TIPORAPPORTO';Tabella:'T450_TIPORAPPORTO';Codice:'CODICE';Storico:'N'),
       (Campo:'PARTTIME';Tabella:'T460_PARTTIME';Codice:'CODICE';Storico:'N'),
       (Campo:'QUALIFICAMINIST';Tabella:'T470_QUALIFICAMINIST';Codice:'CODICE';Storico:'S'),
       (Campo:'MEDICINA_LEGALE';Tabella:'T485_MEDICINELEGALI';Codice:'CODICE';Storico:'N'),
       (Campo:'COMUNE_DOM_BASE';Tabella:'T480_COMUNI';Codice:'CODICE';Storico:'N'),    */

  /* ?  Campo:'ORARIO';Tabella:'T020_ORARI';Codice:'CODICE';Storico:'S'),              */
begin
  RESULT:='';
  
  -- Errore parametri non passati
  if (P_TABELLA is null) or (P_CHIAVE is null) then
    RESULT:='E1';
  else 
    --gestione tabelle legate a T430_STORICO
    if substr(P_TABELLA,1,4) = 'I501' then
      COLONNA:= substr(P_TABELLA, 5);
    elsif substr(P_TABELLA,1,4) = 'T010' then
      COLONNA:='CALENDARIO';   
    elsif substr(P_TABELLA,1,4) = 'T025' then
      COLONNA:='PERSELASTICO';  
    elsif substr(P_TABELLA,1,4) = 'T060' then
      COLONNA:='PLUSORA';   
    elsif substr(P_TABELLA,1,4) = 'T163' then
      COLONNA:='IPRESENZA';  
    elsif substr(P_TABELLA,1,4) = 'T200' then
      COLONNA:='CONTRATTO';
    elsif substr(P_TABELLA,1,4) = 'T220' then
      COLONNA:='PORARIO';   
    elsif substr(P_TABELLA,1,4) = 'T261' then
      COLONNA:='PASSENZE'; 
    elsif substr(P_TABELLA,1,4) = 'T450' then
      COLONNA:='TIPORAPPORTO';   
    elsif substr(P_TABELLA,1,4) = 'T460' then
      COLONNA:='PARTTIME';   
    elsif substr(P_TABELLA,1,4) = 'T470' then
      COLONNA:='QUALIFICAMINIST';   
    elsif substr(P_TABELLA,1,4) = 'T480' then /* COMUNE e COMUNE_DOM_BASE */
      COLONNA:='COMUNE';   
      COLONNA_SUCC:='COMUNE_DOM_BASE';
    elsif substr(P_TABELLA,1,4) = 'T485' then
      COLONNA:='MEDICINA_LEGALE';   
    elsif substr(P_TABELLA,1,4) = 'T600' then
      COLONNA:='SQUADRA';   
    end if;  

    if COLONNA is not null then
      MYDECORRENZA:=P_DECORRENZA;
      MYSCADENZA:=P_SCADENZA;
      if MYDECORRENZA > '01/01/1900' or MYSCADENZA < PCK_CONST.DATA_INF then
        --se record storicizzato verifico se è la prima decorrenza
        MYSQL:='select count(*) from '||P_TABELLA||' where CODICE = :P_CHIAVE and DECORRENZA < :MYDECORRENZA';
        execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA; 
        if MYCOUNT = 0 then
          --prima decorrenza
          MYSQL:='select min(DECORRENZA) from '||P_TABELLA||' where CODICE = :P_CHIAVE and DECORRENZA > :MYDECORRENZA';
          execute immediate MYSQL into MYDECORRENZA_SUCC using P_CHIAVE, MYDECORRENZA; 
          if MYDECORRENZA_SUCC is null then
            MYSCADENZA:=PCK_CONST.DATA_INF;
          else
            MYSCADENZA:=MYDECORRENZA_SUCC - 1; 
          end if;  
        else
          --non siamo sulla prima decorrenza, quindi la cancellazione è consentita
          return(null);
        end if;  
      end if;  
      
      MYSQL:='select count(distinct('||COLONNA||')) from T430_STORICO where '||COLONNA||'=:P_CHIAVE and DATADECORRENZA <= :SCADENZA and DATAFINE >= :DECORRENZA';
      execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYSCADENZA, MYDECORRENZA;
      if MYCOUNT > 0 then
        RESULT:='Tabella: T430_STORICO - Colonna: '||COLONNA||' - Valore: '||P_CHIAVE; 
      elsif COLONNA_SUCC is not null then
        MYSQL:='select count(distinct('||COLONNA_SUCC||')) from T430_STORICO where '||COLONNA_SUCC||'=:P_CHIAVE and DATADECORRENZA <= :SCADENZA and DATAFINE >= :DECORRENZA';
        execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYSCADENZA, MYDECORRENZA;
        if MYCOUNT > 0 then
          RESULT:='Tabella: T430_STORICO - Colonna: '||COLONNA_SUCC||' - Valore: '||P_CHIAVE; 
        end if;  
      end if;
    end if;
    
    --verifico altre relazioni su tabelle <> da T430_STORICO
    if RESULT is null then
      -- T020_ORARI
      if substr(P_TABELLA,1,4) = 'T020' then
        MYDECORRENZA:=P_DECORRENZA;
        MYSCADENZA:=P_SCADENZA;
        if MYDECORRENZA > '01/01/1900' or MYSCADENZA < PCK_CONST.DATA_INF then
          --se record storicizzato verifico se è la prima decorrenza
          MYSQL:='select count(*) from '||P_TABELLA||' where CODICE = :P_CHIAVE and DECORRENZA < :MYDECORRENZA';
          execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA; 
          if MYCOUNT = 0 then
            --prima decorrenza
            MYSQL:='select min(DECORRENZA) from '||P_TABELLA||' where CODICE = :P_CHIAVE and DECORRENZA > :MYDECORRENZA';
            execute immediate MYSQL into MYDECORRENZA_SUCC using P_CHIAVE, MYDECORRENZA; 
            if MYDECORRENZA_SUCC is null then
              MYSCADENZA:=PCK_CONST.DATA_INF;
            else
              MYSCADENZA:=MYDECORRENZA_SUCC - 1; 
            end if;  
          else
            --non siamo sulla prima decorrenza, quindi la cancellazione è consentita
            return(null);
          end if;  
        end if;  
        -- controllo esistenza su T080_PIANIFORARI
        MYSQL:='select count(distinct(ORARIO)) from T080_PIANIFORARI where ORARIO=:P_CHIAVE and DATA between :DECORRENZA and :SCADENZA';
        execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
        if MYCOUNT > 0 then
          RESULT:='Tabella: T080_PIANIFORARI - Colonna: ORARIO - Valore: '||P_CHIAVE; 
        -- controllo esistenza su T221_PROFILISETTIMANA
        else
          MYSQL:='select count(distinct(LUNEDI)) from T221_PROFILISETTIMANA where LUNEDI=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
          execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
          if MYCOUNT > 0 then
            RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: LUNEDI - Valore: '||P_CHIAVE; 
          else
            MYSQL:='select count(distinct(MARTEDI)) from T221_PROFILISETTIMANA where MARTEDI=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
            execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
            if MYCOUNT > 0 then
              RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: MARTEDI - Valore: '||P_CHIAVE; 
            else
              MYSQL:='select count(distinct(MERCOLEDI)) from T221_PROFILISETTIMANA where MERCOLEDI=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
              execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
              if MYCOUNT > 0 then
                RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: MERCOLEDI - Valore: '||P_CHIAVE; 
              else
                MYSQL:='select count(distinct(MERCOLEDI)) from T221_PROFILISETTIMANA where MERCOLEDI=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
                execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
                if MYCOUNT > 0 then
                  RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: MERCOLEDI - Valore: '||P_CHIAVE; 
                else
                  MYSQL:='select count(distinct(GIOVEDI)) from T221_PROFILISETTIMANA where GIOVEDI=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
                  execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
                  if MYCOUNT > 0 then
                    RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: GIOVEDI - Valore: '||P_CHIAVE; 
                  else
                    MYSQL:='select count(distinct(VENERDI)) from T221_PROFILISETTIMANA where VENERDI=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
                    execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
                    if MYCOUNT > 0 then
                      RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: VENERDI - Valore: '||P_CHIAVE; 
                    else
                      MYSQL:='select count(distinct(SABATO)) from T221_PROFILISETTIMANA where SABATO=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
                      execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
                      if MYCOUNT > 0 then
                        RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: SABATO - Valore: '||P_CHIAVE; 
                      else
                        MYSQL:='select count(distinct(DOMENICA)) from T221_PROFILISETTIMANA where DOMENICA=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
                        execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
                        if MYCOUNT > 0 then
                          RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: DOMENICA - Valore: '||P_CHIAVE; 
                        else
                          MYSQL:='select count(distinct(NONLAV)) from T221_PROFILISETTIMANA where NONLAV=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
                          execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
                          if MYCOUNT > 0 then
                            RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: NONLAV - Valore: '||P_CHIAVE; 
                          else
                            MYSQL:='select count(distinct(FESTIVO)) from T221_PROFILISETTIMANA where FESTIVO=:P_CHIAVE and DECORRENZA between :DECORRENZA and :SCADENZA';
                            execute immediate MYSQL into MYCOUNT using P_CHIAVE, MYDECORRENZA, MYSCADENZA;
                            if MYCOUNT > 0 then
                              RESULT:='Tabella: T221_PROFILISETTIMANA - Colonna: FESTIVO - Valore: '||P_CHIAVE; 
                            end if;  
                          end if;  
                        end if;  
                      end if;  
                    end if;  
                  end if;  
                end if;  
	            end if;  
            end if;  
          end if;  
        end if;
      -- T265_CAUASSENZE
      elsif substr(P_TABELLA,1,4) = 'T265' then 
        -- controllo esistenza su T040_GIUSTIFICATIVI
        MYSQL:='select count(distinct(CAUSALE)) from T040_GIUSTIFICATIVI where CAUSALE=:P_CHIAVE';
        execute immediate MYSQL into MYCOUNT using P_CHIAVE;
        if MYCOUNT > 0 then
          RESULT:='Tabella: T040_GIUSTIFICATIVI - Colonna: CAUSALE - Valore: '||P_CHIAVE; 
        end if;
      -- T275_CAUPRESENZE 
      elsif substr(P_TABELLA,1,4) = 'T275' then 
        -- controllo esistenza su T040_GIUSTIFICATIVI
        MYSQL:='select count(distinct(CAUSALE)) from T040_GIUSTIFICATIVI where CAUSALE=:P_CHIAVE';
        execute immediate MYSQL into MYCOUNT using P_CHIAVE;
        if MYCOUNT > 0 then
          RESULT:='Tabella: T040_GIUSTIFICATIVI - Colonna: CAUSALE - Valore: '||P_CHIAVE; 
        else
          -- controllo esistenza su T073_SCHEDACAUSPRES
          MYSQL:='select count(distinct(CAUSALE)) from T073_SCHEDACAUSPRES where CAUSALE=:P_CHIAVE';
          execute immediate MYSQL into MYCOUNT using P_CHIAVE;
          if MYCOUNT > 0 then
            RESULT:='Tabella: T073_SCHEDACAUSPRES - Colonna: CAUSALE - Valore: '||P_CHIAVE; 
          else  
            -- controllo esistenza su T100_TIMBRATURE
            MYSQL:='select count(distinct(CAUSALE)) from T100_TIMBRATURE where CAUSALE=:P_CHIAVE';
            execute immediate MYSQL into MYCOUNT using P_CHIAVE;
            if MYCOUNT > 0 then
              RESULT:='Tabella: T100_TIMBRATURE - Colonna: CAUSALE - Valore: '||P_CHIAVE; 
            end if;
          end if;
        end if;
      end if;
    end if;  
    
  end if;
  
  return(RESULT);
end MEDP_CHECK_RELAZIONI_ESISTENTI;
/