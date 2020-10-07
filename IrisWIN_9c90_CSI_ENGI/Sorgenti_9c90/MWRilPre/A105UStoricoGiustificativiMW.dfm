inherited A105FStoricoGiustificativiMW: TA105FStoricoGiustificativiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 333
  object selT044: TOracleDataSet
    SQL.Strings = (
      
        'SELECT NREC, OPERAZIONE,CAUSALE,'#39'N.D.'#39' FLAG,DATA,DATANAS,TIPOGIU' +
        'ST,DAORE,AORE,QUANTITA,QUANTITA*NREC TOT_QUANT FROM '
      
        '(SELECT ABS(SUM(NREC)) NREC,DECODE(SIGN(SUM(NREC)),1,'#39'Ins.'#39',0,'#39'I' +
        'ns.'#39',-1,'#39'Can.'#39') OPERAZIONE,CAUSALE,DATA,DATANAS,'
      '       TIPOGIUST,DAORE,AORE,'
      
        '       DECODE(TIPOGIUST,'#39'D'#39',OREMINUTI(TO_CHAR(AORE,'#39'HH24.MI'#39')) -' +
        ' OREMINUTI(TO_CHAR(DAORE,'#39'HH24.MI'#39')),'
      
        '              '#39'N'#39',OREMINUTI(TO_CHAR(DAORE,'#39'HH24.MI'#39')),1) QUANTIT' +
        'A FROM'
      '      ('
      
        '      SELECT COUNT(*) NREC,CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,' +
        'AORE,'#39'Ins.'#39' OPE FROM T044_STORICOGIUSTIFICATIVI T044 WHERE'
      '        T044.PROGRESSIVO = :Progressivo'
      '        AND T044.DATA BETWEEN :Data1 AND :Data2'
      
        '        AND EXISTS (SELECT '#39'X'#39' FROM T430_STORICO WHERE PROGRESSI' +
        'VO = T044.PROGRESSIVO'
      
        '                    AND T044.DATA BETWEEN INIZIO AND NVL(FINE,TO' +
        '_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')))'
      '        AND OPERAZIONE ='#39'I'#39
      
        'AND ((NVL(FLAG,'#39'Z'#39') IN (:StatoPaghe) AND :FiltroVoci = '#39'S'#39') OR :' +
        'FiltroVoci = '#39'N'#39')'
      '        GROUP BY CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE'
      '      UNION '
      
        '      SELECT (COUNT(*)*-1) NREC,CAUSALE,DATA,DATANAS,TIPOGIUST,D' +
        'AORE,AORE,'#39'Can.'#39'OPE FROM T044_STORICOGIUSTIFICATIVI T044 WHERE'
      '        T044.PROGRESSIVO = :Progressivo'
      '        AND T044.DATA BETWEEN :Data1 AND :Data2'
      
        '        AND EXISTS (SELECT '#39'X'#39' FROM T430_STORICO WHERE PROGRESSI' +
        'VO = T044.PROGRESSIVO'
      
        '                    AND T044.DATA BETWEEN INIZIO AND NVL(FINE,TO' +
        '_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')))'
      '        AND OPERAZIONE ='#39'C'#39
      
        'AND ((NVL(FLAG,'#39'Z'#39') IN (:StatoPaghe) AND :FiltroVoci = '#39'S'#39') OR :' +
        'FiltroVoci = '#39'N'#39')'
      '        GROUP BY CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE'
      '      )'
      '      WHERE CAUSALE IN (:ElencoCausali)'
      '      GROUP BY CAUSALE,DATA,DATANAS,TIPOGIUST,DAORE,AORE'
      '      HAVING ABS(SUM(NREC)) > 0 )'
      '  WHERE :RecordFisici = '#39'N'#39
      'UNION ALL'
      
        'SELECT 1 NREC, DECODE(OPERAZIONE,'#39'I'#39','#39'Ins.'#39','#39'C'#39','#39'Can.'#39') OPERAZIO' +
        'NE,CAUSALE,NVL(FLAG,'#39'Z'#39') FLAG,DATA,DATANAS,TIPOGIUST,DAORE,AORE,' +
        ' '
      
        '  DECODE(TIPOGIUST,'#39'D'#39',OREMINUTI(TO_CHAR(AORE,'#39'HH24.MI'#39')) - OREM' +
        'INUTI(TO_CHAR(DAORE,'#39'HH24.MI'#39')),'
      '    '#39'N'#39',OREMINUTI(TO_CHAR(DAORE,'#39'HH24.MI'#39')),1) QUANTITA,'
      
        '  DECODE(TIPOGIUST,'#39'D'#39',OREMINUTI(TO_CHAR(AORE,'#39'HH24.MI'#39')) - OREM' +
        'INUTI(TO_CHAR(DAORE,'#39'HH24.MI'#39')),'
      '    '#39'N'#39',OREMINUTI(TO_CHAR(DAORE,'#39'HH24.MI'#39')),1) TOT_QUANT FROM '
      '  T044_STORICOGIUSTIFICATIVI T044 WHERE '
      '  :RecordFisici = '#39'S'#39
      '  AND T044.PROGRESSIVO = :Progressivo'
      '  AND T044.DATA BETWEEN :Data1 AND :Data2'
      
        '  AND EXISTS (SELECT '#39'X'#39' FROM T430_STORICO WHERE PROGRESSIVO = T' +
        '044.PROGRESSIVO'
      
        '              AND T044.DATA BETWEEN INIZIO AND NVL(FINE,TO_DATE(' +
        #39'31123999'#39','#39'DDMMYYYY'#39')))'
      '  AND CAUSALE IN (:ElencoCausali)'
      ''
      
        'AND ((NVL(FLAG,'#39'Z'#39') IN (:StatoPaghe) AND :FiltroVoci = '#39'S'#39') OR :' +
        'FiltroVoci = '#39'N'#39')'
      ''
      'ORDER BY OPERAZIONE,CAUSALE,DATANAS,DATA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000007000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001C0000003A0045004C0045004E0043004F00430041005500
      530041004C0049000100000000000000000000001A0000003A00520045004300
      4F00520044004600490053004900430049000500000000000000000000001600
      00003A0053005400410054004F00500041004700480045000100000000000000
      00000000160000003A00460049004C00540052004F0056004F00430049000500
      00000000000000000000}
    Left = 44
    Top = 8
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE WHERE REGISTRA_ST' +
        'ORICO = '#39'S'#39
      'ORDER BY CODICE')
    ReadBuffer = 200
    Optimize = False
    Left = 116
    Top = 8
  end
  object insT044: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      
        '  CURSOR C1 IS SELECT T040.* FROM T040_GIUSTIFICATIVI T040, T265' +
        '_CAUASSENZE T265'
      '    WHERE T040.DATA BETWEEN :Data1 AND :Data2'
      '    AND T040.CAUSALE = T265.CODICE'
      '    AND T265.REGISTRA_STORICO = '#39'S'#39
      '    AND T040.PROGRESSIVO = :Prog'
      '    AND T040.CAUSALE IN (:ElencoCausali);'
      
        '  CURSOR C2 IS SELECT T044.* FROM T044_STORICOGIUSTIFICATIVI T04' +
        '4, T265_CAUASSENZE T265'
      '    WHERE T044.DATA BETWEEN :Data1 AND :Data2'
      '    AND T044.CAUSALE = T265.CODICE'
      '    AND T265.REGISTRA_STORICO = '#39'S'#39
      '    AND T044.PROGRESSIVO = :Prog'
      '    AND T044.CAUSALE IN (:ElencoCausali);'
      
        '  NRECORD NUMBER; -- Numero di record presenti in t040 per dipen' +
        'dente, causale, giorno, ...'
      '  NINSERT NUMBER; -- Numero di record insertiti in t044'
      '  NDELETE NUMBER; -- Numero di record cancellati in t044'
      '  NDAINS  NUMBER; -- Numero di record da inserire in t044'
      '  NDACAN  NUMBER; -- Numero di record da cancellare in t044'
      '  DATAAGG DATE;   -- Data di registrazione'
      '  I NUMBER;'
      '  CFLAG VARCHAR2(1);'
      '  CDATACEDOLINO DATE;'
      '  IdVal number;'
      'BEGIN'
      '  -- Primo ciclo su T040 '
      '  FOR T1 IN C1 LOOP'
      
        '    -- Calcolo il numero di record presenti in t040 per dipenden' +
        'te, causale, giorno, data di nascita, tipo giustificativo'
      
        '    -- Da ore e A ore; i record doppi possono essere inserimenti' +
        ' di piu'#39' ore singole per la stessa causale nel giorno'
      
        '    SELECT COUNT(*) INTO NRECORD FROM T040_GIUSTIFICATIVI T040 W' +
        'HERE'
      '      T040.PROGRESSIVO = T1.PROGRESSIVO'
      '      AND T040.CAUSALE = T1.CAUSALE'
      '      AND T040.DATA = T1.DATA'
      
        '      AND NVL(T040.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL' +
        '(T1.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND T040.TIPOGIUST = T1.TIPOGIUST'
      
        '      AND NVL(T040.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T' +
        '1.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      
        '      AND NVL(T040.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T1' +
        '.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'));'
      
        '    -- Calcolo il numero di record di inserimento presenti in t0' +
        '44'
      
        '    SELECT COUNT(*) INTO NINSERT FROM T044_STORICOGIUSTIFICATIVI' +
        ' T044 WHERE'
      '      T044.PROGRESSIVO = T1.PROGRESSIVO'
      '      AND T044.CAUSALE = T1.CAUSALE'
      '      AND T044.DATA = T1.DATA'
      
        '      AND NVL(T044.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL' +
        '(T1.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND T044.TIPOGIUST = T1.TIPOGIUST'
      
        '      AND NVL(T044.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T' +
        '1.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      
        '      AND NVL(T044.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T1' +
        '.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND OPERAZIONE = '#39'I'#39';'
      
        '    -- Calcolo il numero di record di cancellazioni presenti in ' +
        't044'
      
        '    SELECT COUNT(*) INTO NDELETE FROM T044_STORICOGIUSTIFICATIVI' +
        ' T044 WHERE'
      '      T044.PROGRESSIVO = T1.PROGRESSIVO'
      '      AND T044.CAUSALE = T1.CAUSALE'
      '      AND T044.DATA = T1.DATA'
      
        '      AND NVL(T044.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL' +
        '(T1.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND T044.TIPOGIUST = T1.TIPOGIUST'
      
        '      AND NVL(T044.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T' +
        '1.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      
        '      AND NVL(T044.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T1' +
        '.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND OPERAZIONE = '#39'C'#39';'
      '    NDAINS:=0;'
      '    NDACAN:=0;'
      
        '    -- Calcolo il numero di movimenti di inserimento da registra' +
        're in t044'
      '    IF NINSERT - NDELETE < NRECORD THEN'
      '      NDAINS:=NRECORD - (NINSERT - NDELETE);'
      '    END IF;         '
      
        '    -- Calcolo il numero di movimenti di cancellazione da regist' +
        'rare in t044'
      '    IF NINSERT - NDELETE > NRECORD THEN'
      '      NDACAN:=NINSERT - NRECORD - NDELETE;'
      '    END IF;'
      '    IF :DefDataRegistraz = '#39'S'#39' THEN'
      '      DATAAGG:=T1.DATA;'
      '    ELSE'
      '      DATAAGG:=:DataRegistrazione;'
      '    END IF;'
      '    IF :InsertRecord = '#39'S'#39' THEN'
      '      FOR I IN 1..NDAINS LOOP'
      '        IF :ImpAssenzaElab = '#39'S'#39' THEN'
      '          CFLAG:='#39'C'#39';'
      '          CDATACEDOLINO:=LAST_DAY(T1.DATA);'
      '        ELSE'
      '          CFLAG:='#39#39';'
      '          CDATACEDOLINO:='#39#39';'
      '        END IF;'
      '        select T044_ID.nextval into IdVal from dual;'
      '        INSERT INTO T044_STORICOGIUSTIFICATIVI'
      
        '          (PROGRESSIVO, DATA, CAUSALE, TIPOGIUST, DAORE, AORE, O' +
        'PERAZIONE, DATA_AGG, DATANAS, DATA_CEDOLINO, FLAG, ID)'
      '        VALUES'
      
        '          (T1.PROGRESSIVO, T1.DATA, T1.CAUSALE, T1.TIPOGIUST, T1' +
        '.DAORE, T1.AORE, '#39'I'#39',  '
      
        '           TO_DATE(TO_CHAR(DATAAGG,'#39'ddmmyyyy'#39')||TO_CHAR(SYSDATE,' +
        #39'hh24miss'#39'),'#39'ddmmyyyyhh24miss'#39'), T1.DATANAS, CDATACEDOLINO, CFLA' +
        'G, IdVal);'
      '        COMMIT;'
      '      END LOOP;'
      '    END IF;'
      '    IF :DeleteRecord = '#39'S'#39' THEN'
      '      FOR I IN 1..NDACAN LOOP'
      '        IF :ImpAssenzaElab = '#39'S'#39' THEN'
      '          CFLAG:='#39'C'#39';'
      '          CDATACEDOLINO:=LAST_DAY(T1.DATA);'
      '        ELSE'
      '          CFLAG:='#39#39';'
      '          CDATACEDOLINO:='#39#39';'
      '        END IF;'
      '        select T044_ID.nextval into IdVal from dual;'
      '        INSERT INTO T044_STORICOGIUSTIFICATIVI'
      
        '          (PROGRESSIVO, DATA, CAUSALE, TIPOGIUST, DAORE, AORE, O' +
        'PERAZIONE, DATA_AGG, DATANAS, DATA_CEDOLINO, FLAG, ID)'
      '        VALUES'
      
        '          (T1.PROGRESSIVO, T1.DATA, T1.CAUSALE, T1.TIPOGIUST, T1' +
        '.DAORE, T1.AORE, '#39'C'#39', '
      
        '           TO_DATE(TO_CHAR(DATAAGG,'#39'ddmmyyyy'#39')||TO_CHAR(SYSDATE,' +
        #39'hh24miss'#39'),'#39'ddmmyyyyhh24miss'#39'), T1.DATANAS, CDATACEDOLINO, CFLA' +
        'G, IdVal);'
      '        COMMIT;'
      '      END LOOP;'
      '    END IF;'
      '  END LOOP;'
      
        '  -- Secondo ciclo su T044 per gestire i record non piu'#39' present' +
        'i in T040 ma comunque da allineare in T044'
      '  FOR T2 IN C2 LOOP'
      
        '    -- Calcolo il numero di record presenti in t040 per dipenden' +
        'te, causale, giorno, data di nascita, tipo giustificativo'
      
        '    -- Da ore e A ore; i record doppi possono essere inserimenti' +
        ' di piu'#39' ore singole per la stessa causale nel giorno'
      
        '    SELECT COUNT(*) INTO NRECORD FROM T040_GIUSTIFICATIVI T040 W' +
        'HERE'
      '      T040.PROGRESSIVO = T2.PROGRESSIVO'
      '      AND T040.CAUSALE = T2.CAUSALE'
      '      AND T040.DATA = T2.DATA'
      
        '      AND NVL(T040.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL' +
        '(T2.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND T040.TIPOGIUST = T2.TIPOGIUST'
      
        '      AND NVL(T040.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T' +
        '2.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      
        '      AND NVL(T040.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T2' +
        '.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'));'
      
        '    -- Calcolo il numero di record di inserimento presenti in t0' +
        '44'
      
        '    SELECT COUNT(*) INTO NINSERT FROM T044_STORICOGIUSTIFICATIVI' +
        ' T044 WHERE'
      '      T044.PROGRESSIVO = T2.PROGRESSIVO'
      '      AND T044.CAUSALE = T2.CAUSALE'
      '      AND T044.DATA = T2.DATA'
      
        '      AND NVL(T044.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL' +
        '(T2.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND T044.TIPOGIUST = T2.TIPOGIUST'
      
        '      AND NVL(T044.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T' +
        '2.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      
        '      AND NVL(T044.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T2' +
        '.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND OPERAZIONE = '#39'I'#39';'
      
        '    -- Calcolo il numero di record di cancellazioni presenti in ' +
        't044'
      
        '    SELECT COUNT(*) INTO NDELETE FROM T044_STORICOGIUSTIFICATIVI' +
        ' T044 WHERE'
      '      T044.PROGRESSIVO = T2.PROGRESSIVO'
      '      AND T044.CAUSALE = T2.CAUSALE'
      '      AND T044.DATA = T2.DATA'
      
        '      AND NVL(T044.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL' +
        '(T2.DATANAS,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND T044.TIPOGIUST = T2.TIPOGIUST'
      
        '      AND NVL(T044.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T' +
        '2.DAORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      
        '      AND NVL(T044.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T2' +
        '.AORE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '      AND OPERAZIONE = '#39'C'#39';'
      '    NDACAN:=0;'
      
        '    -- Calcolo il numero di movimenti di cancellazione da regist' +
        'rare in t044'
      '    IF NINSERT - NDELETE > NRECORD THEN'
      '      NDACAN:=NINSERT - NRECORD - NDELETE;'
      '    END IF;'
      '    IF :DefDataRegistraz = '#39'S'#39' THEN'
      '      DATAAGG:=T2.DATA;'
      '    ELSE'
      '      DATAAGG:=:DataRegistrazione;'
      '    END IF;'
      '    IF :DeleteRecord = '#39'S'#39' THEN'
      '      FOR I IN 1..NDACAN LOOP'
      '        IF :ImpAssenzaElab = '#39'S'#39' THEN'
      '          CFLAG:='#39'C'#39';'
      '          CDATACEDOLINO:=LAST_DAY(T2.DATA);'
      '        ELSE'
      '          CFLAG:='#39#39';'
      '          CDATACEDOLINO:='#39#39';'
      '        END IF;'
      '        select T044_ID.nextval into IdVal from dual;'
      '        INSERT INTO T044_STORICOGIUSTIFICATIVI'
      
        '          (PROGRESSIVO, DATA, CAUSALE, TIPOGIUST, DAORE, AORE, O' +
        'PERAZIONE, DATA_AGG, DATANAS, DATA_CEDOLINO, FLAG, ID)'
      '        VALUES'
      
        '          (T2.PROGRESSIVO, T2.DATA, T2.CAUSALE, T2.TIPOGIUST, T2' +
        '.DAORE, T2.AORE, '#39'C'#39',  '
      
        '           TO_DATE(TO_CHAR(DATAAGG,'#39'ddmmyyyy'#39')||TO_CHAR(SYSDATE,' +
        #39'hh24miss'#39'),'#39'ddmmyyyyhh24miss'#39'), T2.DATANAS, CDATACEDOLINO, CFLA' +
        'G, IdVal);'
      '        COMMIT;'
      '      END LOOP;'
      '    END IF;'
      '  END LOOP;'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000090000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      1A0000003A0049004E0053004500520054005200450043004F00520044000500
      00000000000000000000240000003A0044004100540041005200450047004900
      53005400520041005A0049004F004E0045000C00000000000000000000001A00
      00003A00440045004C004500540045005200450043004F005200440005000000
      0000000000000000220000003A00440045004600440041005400410052004500
      4700490053005400520041005A000500000000000000000000000A0000003A00
      500052004F0047000300000000000000000000001E0000003A0049004D005000
      41005300530045004E005A00410045004C004100420005000000000000000000
      00001C0000003A0045004C0045004E0043004F00430041005500530041004C00
      4900010000000000000000000000}
    Left = 64
    Top = 64
  end
  object delT044: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T044_STORICOGIUSTIFICATIVI T044'
      '  WHERE T044.DATA BETWEEN :Data1 AND :Data2'
      '  AND T044.FLAG IS NULL'
      
        '  AND EXISTS (SELECT '#39'X'#39' FROM T265_CAUASSENZE WHERE CODICE = T04' +
        '4.CAUSALE AND REGISTRA_STORICO = '#39'N'#39')'
      '  AND PROGRESSIVO = :Prog'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00440041005400410031000C00000000000000
      000000000C0000003A00440041005400410032000C0000000000000000000000
      0A0000003A00500052004F004700030000000000000000000000}
    Left = 138
    Top = 69
  end
  object D010: TDataSource
    Left = 180
    Top = 8
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 244
    Top = 8
  end
end
