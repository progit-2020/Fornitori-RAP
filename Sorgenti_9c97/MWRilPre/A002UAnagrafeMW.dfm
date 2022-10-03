inherited A002FAnagrafeMW: TA002FAnagrafeMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 403
  Width = 867
  object updP430: TOracleQuery
    SQL.Strings = (
      'UPDATE P430_ANAGRAFICO T1'
      'SET DECORRENZA = :DATA_NEW'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DECORRENZA = (SELECT MIN(DECORRENZA)'
      '                  FROM P430_ANAGRAFICO'
      '                  WHERE PROGRESSIVO = T1.PROGRESSIVO)')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A0044004100540041005F004E00450057000C00
      00000000000000000000180000003A00500052004F0047005200450053005300
      490056004F00030000000000000000000000}
    Left = 40
    Top = 147
  end
  object UpdT430_IndMat: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  UPDATE T430_STORICO T430 '
      '     SET INIZIO_IND_MAT = :INIZIO_IND_MAT '
      '   WHERE PROGRESSIVO = :PROGRESSIVO '
      '     AND INIZIO_IND_MAT = :INIZIO_IND_MAT_OLD'
      '     AND (:ROWID IS NULL OR ROWID <> :ROWID);'
      ''
      '  UPDATE T430_STORICO '
      '     SET FINE_IND_MAT = :FINE_IND_MAT '
      '   WHERE PROGRESSIVO = :PROGRESSIVO '
      '     AND FINE_IND_MAT = :FINE_IND_MAT_OLD'
      '     AND (:ROWID IS NULL OR ROWID <> :ROWID);'
      ''
      'END;')
    Optimize = False
    Variables.Data = {
      04000000060000001E0000003A0049004E0049005A0049004F005F0049004E00
      44005F004D00410054000C0000000000000000000000180000003A0050005200
      4F0047005200450053005300490056004F000300000000000000000000002600
      00003A0049004E0049005A0049004F005F0049004E0044005F004D0041005400
      5F004F004C0044000C00000000000000000000001A0000003A00460049004E00
      45005F0049004E0044005F004D00410054000C00000000000000000000002200
      00003A00460049004E0045005F0049004E0044005F004D00410054005F004F00
      4C0044000C00000000000000000000000C0000003A0052004F00570049004400
      050000000000000000000000}
    Left = 128
    Top = 147
  end
  object GetNuovaMatricola: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :Matricola:=GetNuovaMatricola;'
      'exception'
      '  when others then'
      '    :Matricola:=null;'
      'end;')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004D00410054005200490043004F004C004100
      030000000000000000000000}
    Left = 528
    Top = 146
  end
  object QBadgeLibero: TOracleDataSet
    SQL.Strings = (
      'begin'
      '  SELECT_APERTE.GET_BADGE_USATI(:BADGE,:DAL,:AL);'
      'end;'
      '')
    Optimize = False
    Variables.Data = {
      04000000030000000C0000003A00420041004400470045007400000000000000
      00000000080000003A00440041004C000C000000000000000000000006000000
      3A0041004C000C0000000000000000000000}
    Left = 616
    Top = 146
  end
  object selT010: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione '
      'from T010_CalendImpostaz '
      'order by CODICE')
    Optimize = False
    Filtered = True
    AfterOpen = selT010AfterOpen
    OnFilterRecord = FiltroDizionario
    Left = 40
    Top = 218
  end
  object dsrT010: TDataSource
    AutoEdit = False
    DataSet = selT010
    Left = 40
    Top = 266
  end
  object selT220: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T220_PROFILIORARI T220'
      'WHERE :DATA BETWEEN DECORRENZA AND DECORRENZA_FINE'
      'ORDER BY CODICE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Filtered = True
    AfterOpen = selT010AfterOpen
    OnFilterRecord = FiltroDizionario
    Left = 344
    Top = 218
  end
  object dsrT261: TDataSource
    AutoEdit = False
    DataSet = selT261
    Left = 400
    Top = 266
  end
  object dsrT220: TDataSource
    AutoEdit = False
    DataSet = selT220
    Left = 344
    Top = 266
  end
  object selT261: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T261_DescprofAss'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    AfterOpen = selT010AfterOpen
    OnFilterRecord = FiltroDizionario
    Left = 400
    Top = 218
  end
  object selT025: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T025_ContMensili'
      'order by CODICE')
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 104
    Top = 218
  end
  object dsrT025: TDataSource
    AutoEdit = False
    DataSet = selT025
    Left = 104
    Top = 266
  end
  object selCodFisc: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT T030.COGNOME, T030.NOME'
      '  FROM T030_ANAGRAFICO T030, T430_STORICO T430'
      ' WHERE T030.PROGRESSIVO = T430.PROGRESSIVO'
      
        '   AND NVL(:INIZIO,TO_DATE('#39'31/12/3999'#39','#39'DD/MM/YYYY'#39')) < NVL(T43' +
        '0.FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))'
      '   AND NVL(:FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) > T430.INIZIO'
      '   AND T030.CODFISCALE = :CODFISC'
      '   AND T030.PROGRESSIVO <> NVL(:PROG,-1)'
      '  ORDER BY T030.COGNOME, T030.NOME')
    Optimize = False
    Variables.Data = {
      0400000004000000100000003A0043004F004400460049005300430005000000
      00000000000000000E0000003A0049004E0049005A0049004F000C0000000000
      0000000000000A0000003A00460049004E0045000C0000000000000000000000
      0A0000003A00500052004F004700030000000000000000000000}
    Left = 648
    Top = 82
  end
  object selT430_IntIndMat: TOracleDataSet
    SQL.Strings = (
      '/*CONTROLLO INTERSEZIONI TRA PERIODI INDENNITA'#39' DI MATERNITA'#39' */'
      'SELECT DISTINCT T430.INIZIO_IND_MAT, T430.FINE_IND_MAT '
      '  FROM T430_STORICO T430'
      ' WHERE T430.PROGRESSIVO = :PROGRESSIVO '
      '   AND T430.INIZIO_IND_MAT <> :INIZIO_IND_MAT_OLD'
      '   AND T430.FINE_IND_MAT <> :FINE_IND_MAT_OLD'
      '   AND :INIZIO_IND_MAT <= T430.FINE_IND_MAT '
      '   AND :FINE_IND_MAT >= T430.INIZIO_IND_MAT')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000260000003A0049004E0049005A004900
      4F005F0049004E0044005F004D00410054005F004F004C0044000C0000000000
      000000000000220000003A00460049004E0045005F0049004E0044005F004D00
      410054005F004F004C0044000C00000000000000000000001E0000003A004900
      4E0049005A0049004F005F0049004E0044005F004D00410054000C0000000000
      0000000000001A0000003A00460049004E0045005F0049004E0044005F004D00
      410054000C0000000000000000000000}
    Left = 40
    Top = 82
  end
  object selI060: TOracleDataSet
    SQL.Strings = (
      'select email'
      'from mondoedp.i060_login_dipendente'
      'where azienda = :azienda'
      'and matricola = :matricola'
      'order by nome_utente')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000}
    Left = 40
    Top = 16
  end
  object selT600: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione '
      'from T600_Squadre'
      'ORDER BY CODICE')
    ReadBuffer = 10
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 808
    Top = 218
  end
  object dsrT600: TDataSource
    AutoEdit = False
    DataSet = selT600
    Left = 808
    Top = 266
  end
  object selI500: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM I500_DATILIBERI ORDER BY PROGRESSIVO')
    ReadBuffer = 100
    Optimize = False
    Left = 96
    Top = 16
  end
  object selT485: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE from T485_MEDICINELEGALI '
      'order by CODICE')
    ReadBuffer = 1000
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 752
    Top = 218
  end
  object dsrT485: TDataSource
    AutoEdit = False
    DataSet = selT485
    Left = 752
    Top = 266
  end
  object selT430_IntPRapp: TOracleDataSet
    SQL.Strings = (
      
        '/*CONTROLLO INTERSEZIONI TRA PERIODI RAPPORTO E PERIODI INDENNIT' +
        'A'#39' MATERNITA'#39'*/'
      
        'SELECT DISTINCT DECODE(T430.INIZIO,:INIZIO_OLD,:INIZIO,T430.INIZ' +
        'IO) AS INIZIO,'
      
        '                DECODE(T430.FINE,:FINE_OLD,:FINE,T430.FINE) AS F' +
        'INE,'
      
        '                DECODE(T430.INIZIO_IND_MAT,:INIZIO_IND_MAT_OLD,:' +
        'INIZIO_IND_MAT,T430.INIZIO_IND_MAT), '
      
        '                DECODE(T430.FINE_IND_MAT,:FINE_IND_MAT_OLD,:FINE' +
        '_IND_MAT,T430.FINE_IND_MAT)'
      '  FROM T430_STORICO T430'
      ' WHERE T430.PROGRESSIVO = :PROGRESSIVO '
      
        '   AND ((DECODE(T430.INIZIO,:INIZIO_OLD,:INIZIO,T430.INIZIO) <= ' +
        'NVL(:FINE_IND_MAT,TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39'))'
      
        '   AND NVL(DECODE(T430.FINE,:FINE_OLD,:FINE,T430.FINE),TO_DATE('#39 +
        '31123999'#39','#39'DDMMYYYY'#39')) >= NVL(:INIZIO_IND_MAT,TO_DATE('#39'01011900'#39 +
        ','#39'DDMMYYYY'#39')))'
      
        '    OR (:INIZIO <= NVL(DECODE(T430.FINE_IND_MAT,:FINE_IND_MAT_OL' +
        'D,:FINE_IND_MAT,T430.FINE_IND_MAT),TO_DATE('#39'01011900'#39','#39'DDMMYYYY'#39 +
        '))'
      
        '   AND NVL(:FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= NVL(DECODE(T' +
        '430.INIZIO_IND_MAT,:INIZIO_IND_MAT_OLD,:INIZIO_IND_MAT,T430.INIZ' +
        'IO_IND_MAT),TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')+1)))')
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001E0000003A0049004E0049005A004900
      4F005F0049004E0044005F004D00410054000C00000000000000000000001A00
      00003A00460049004E0045005F0049004E0044005F004D00410054000C000000
      0000000000000000260000003A0049004E0049005A0049004F005F0049004E00
      44005F004D00410054005F004F004C0044000C00000000000000000000002200
      00003A00460049004E0045005F0049004E0044005F004D00410054005F004F00
      4C0044000C0000000000000000000000160000003A0049004E0049005A004900
      4F005F004F004C0044000500000000000000000000000E0000003A0049004E00
      49005A0049004F00050000000000000000000000120000003A00460049004E00
      45005F004F004C0044000500000000000000000000000A0000003A0046004900
      4E004500050000000000000000000000}
    Left = 136
    Top = 82
  end
  object selT470: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE from T470_QUALIFICAMINIST'
      'where :DATA between DECORRENZA and DECORRENZA_FINE'
      'order by CODICE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    AfterOpen = selT010AfterOpen
    Left = 688
    Top = 218
  end
  object dsrT470: TDataSource
    AutoEdit = False
    DataSet = selT470
    Left = 688
    Top = 266
  end
  object selT460: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T460_PartTime'
      'order by CODICE')
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 624
    Top = 218
  end
  object dsrT460: TDataSource
    AutoEdit = False
    DataSet = selT460
    Left = 624
    Top = 266
  end
  object selT450: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione,Tipo from T450_TipoRapporto'
      'order by CODICE')
    ReadBuffer = 10
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 560
    Top = 218
  end
  object dsrT450: TDataSource
    AutoEdit = False
    DataSet = selT450
    Left = 560
    Top = 266
  end
  object selT270: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T270_RaggrPresenze'
      'order by CODICE')
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 512
    Top = 218
  end
  object dsrT270: TDataSource
    AutoEdit = False
    DataSet = selT270
    Left = 728
    Top = 24
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T265_CauAssenze'
      'where Fruibile = '#39'N'#39
      'order by CODICE')
    Optimize = False
    Left = 456
    Top = 218
  end
  object dsrT265: TDataSource
    AutoEdit = False
    DataSet = selT265
    Left = 776
    Top = 24
  end
  object selP430_count: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) ANAGRAFICHE_STIPENDIALI '
      'FROM P430_ANAGRAFICO'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DECORRENZA BETWEEN :DATA_OLD AND :DATA_NEW')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000120000003A0044004100540041005F00
      4F004C0044000C0000000000000000000000120000003A004400410054004100
      5F004E00450057000C0000000000000000000000}
    Left = 344
    Top = 16
  end
  object selT430_Decorrenze: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT DATADECORRENZA '
      'FROM T430_STORICO WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY 1')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 232
    Top = 82
  end
  object selT200: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T200_Contratti'
      'order by CODICE')
    ReadBuffer = 10
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 280
    Top = 218
  end
  object dsrT200: TDataSource
    AutoEdit = False
    DataSet = selT200
    Left = 280
    Top = 266
  end
  object selT163: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T163_CODICIINDENNITA'
      'order by CODICE')
    ReadBuffer = 50
    Optimize = False
    Filtered = True
    AfterOpen = selT010AfterOpen
    OnFilterRecord = FiltroDizionario
    Left = 224
    Top = 218
  end
  object dsrT163: TDataSource
    AutoEdit = False
    DataSet = selT163
    Left = 224
    Top = 266
  end
  object selT060: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T060_PlusOrario'
      'order by CODICE')
    ReadBuffer = 10
    Optimize = False
    AfterOpen = selT010AfterOpen
    Left = 168
    Top = 218
  end
  object dsrT060: TDataSource
    AutoEdit = False
    DataSet = selT060
    Left = 168
    Top = 266
  end
  object selT035: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,T.ROWID FROM T035_PROGRESSIVO T')
    ReadBuffer = 2
    Optimize = False
    AfterOpen = selT035AfterOpen
    Left = 272
    Top = 16
  end
  object selVerificaBadge: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT '#39'Badge  ordinario: '#39' TIPOBADGE, '
      '                NOME,COGNOME,MATRICOLA,'
      
        '                GREATEST(T430.DATADECORRENZA,NVL(T430.INIZIO,T43' +
        '0.DATADECORRENZA)) DATADECORRENZA,'
      
        '                LEAST(T430.DATAFINE,NVL(T430.FINE,T430.DATAFINE)' +
        ') DATAFINE '
      'FROM :UTENTE.T430_STORICO T430, :UTENTE.T030_ANAGRAFICO T030 '
      'WHERE T030.PROGRESSIVO = T430.PROGRESSIVO '
      'AND T430.BADGE = :BADGE '
      'AND T030.PROGRESSIVO <> :PROGRESSIVO'
      
        'AND GREATEST(T430.DATADECORRENZA,NVL(T430.INIZIO,T430.DATADECORR' +
        'ENZA)) <= :AL'
      'AND LEAST(T430.DATAFINE,NVL(T430.FINE,T430.DATAFINE)) >= :DAL'
      'UNION'
      'SELECT DISTINCT '#39'Badge di servizio: '#39' TIPOBADGE, '
      '                NOME,COGNOME,MATRICOLA,'
      
        '                DECORRENZA,NVL(T435.SCADENZA,TO_DATE('#39'31123999'#39',' +
        #39'DDMMYYYY'#39')) '
      
        'FROM :UTENTE.T435_BADGESERVIZIO T435, :UTENTE.T030_ANAGRAFICO T0' +
        '30 '
      'WHERE T030.PROGRESSIVO = T435.PROGRESSIVO '
      'AND T030.PROGRESSIVO <> :PROGRESSIVO'
      'AND T435.BADGESERV = :BADGE'
      'AND T435.DECORRENZA <= :AL'
      'AND NVL(T435.SCADENZA,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= :DAL'
      'ORDER BY COGNOME,NOME')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      04000000050000000C0000003A00420041004400470045000300000000000000
      00000000060000003A0041004C000C0000000000000000000000080000003A00
      440041004C000C0000000000000000000000180000003A00500052004F004700
      5200450053005300490056004F000300000000000000000000000E0000003A00
      5500540045004E0054004500010000000000000000000000}
    Left = 724
    Top = 82
  end
  object updFine: TOracleQuery
    SQL.Strings = (
      'update t430_storico set fine = :fine where '
      '  progressivo = :progressivo and '
      '  inizio = :inizio and'
      '  (:storicizza ='#39'S'#39' or rowid <> :rigaid)')
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A00460049004E0045000C00
      000000000000000000000E0000003A0049004E0049005A0049004F000C000000
      00000000000000000E0000003A00520049004700410049004400050000000000
      000000000000160000003A00530054004F0052004900430049005A005A004100
      050000000000000000000000}
    Left = 272
    Top = 147
  end
  object selT433: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT DECORRENZA, DECORRENZA_FINE'
      'FROM T433_CDC_PERCENT'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DECORRENZA <= :DATAFINE_MOD'
      'AND DECORRENZA_FINE >= :DATADECORRENZA_MOD')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000001A0000003A0044004100540041004600
      49004E0045005F004D004F0044000C0000000000000000000000260000003A00
      44004100540041004400450043004F005200520045004E005A0041005F004D00
      4F0044000C0000000000000000000000}
    Left = 408
    Top = 15
  end
  object selT433_count: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(DISTINCT(DECORRENZA)) SUCCESSIVE'
      'FROM T433_CDC_PERCENT'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'AND DECORRENZA > :DECORRENZA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004400450043004F005200
      520045004E005A0041000C0000000000000000000000}
    Left = 480
    Top = 15
  end
  object updT433: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  UPDATE T433_CDC_PERCENT'
      '  SET DECORRENZA_FINE = :DATADECORRENZA_MOD - 1'
      '  WHERE PROGRESSIVO = :PROGRESSIVO'
      
        '  AND :DATADECORRENZA_MOD - 1 BETWEEN DECORRENZA AND DECORRENZA_' +
        'FINE;'
      '  DELETE T433_CDC_PERCENT'
      '  WHERE PROGRESSIVO = :PROGRESSIVO'
      '  AND DECORRENZA >= :DATADECORRENZA_MOD;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000260000003A0044004100540041004400
      450043004F005200520045004E005A0041005F004D004F0044000C0000000000
      000000000000}
    Left = 333
    Top = 148
  end
  object UpdT430Mat: TOracleQuery
    SQL.Strings = (
      'UPDATE T430_STORICO T430'
      '   SET T430.INIZIO_IND_MAT = NULL, '
      '       T430.FINE_IND_MAT = NULL'
      ' WHERE T430.PROGRESSIVO = :PROGRESSIVO '
      '   AND T430.DATADECORRENZA  > (SELECT MAX(FINE_IND_MAT)'
      '                                 FROM T430_STORICO '
      
        '                                WHERE PROGRESSIVO = T430.PROGRES' +
        'SIVO '
      '                                  AND FINE_IND_MAT IS NOT NULL)')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 208
    Top = 147
  end
  object scrT430: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  Allinea_Periodi_Storici(:Progressivo,1,:Errore,'#39#39');'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000}
    Left = 389
    Top = 146
  end
  object scrP430: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      '  p integer;'
      'BEGIN'
      
        '  select progressivo into p from p430_anagrafico where progressi' +
        'vo = :progressivo;'
      
        '  Allinea_Periodi_Stipendi(:Progressivo,:Errore,:Aggiorna_asseg_' +
        'auto_libera);'
      'EXCEPTION'
      '  when others then null;'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000360000003A0041004700470049004F005200
      4E0041005F00410053005300450047005F004100550054004F005F004C004900
      4200450052004100050000000000000000000000}
    Left = 445
    Top = 146
  end
  object selT430_InizioFine: TOracleDataSet
    SQL.Strings = (
      'SELECT MIN(INIZIO) INIZIO FROM T430_STORICO T430'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  INIZIO IS NOT NULL AND'
      '  EXISTS '
      '  (SELECT '#39'X'#39' FROM T430_STORICO WHERE '
      '   PROGRESSIVO = T430.PROGRESSIVO AND'
      '   INIZIO IS NOT NULL AND'
      '   (INIZIO <> T430.INIZIO OR '
      
        '    NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) <> NVL(T430.FINE,TO' +
        '_DATE('#39'31123999'#39','#39'DDMMYYYY'#39'))) AND'
      '   INIZIO <= NVL(T430.FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) AND'
      '   NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) >= T430.INIZIO)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 335
    Top = 82
  end
  object selT430_PeriodiInvertiti: TOracleDataSet
    SQL.Strings = (
      'SELECT MIN(INIZIO) INIZIO FROM T430_STORICO T430'
      'WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  FINE IS NOT NULL AND'
      '  EXISTS '
      '  (SELECT '#39'X'#39' FROM T430_STORICO WHERE '
      '   PROGRESSIVO = T430.PROGRESSIVO AND'
      '   INIZIO > T430.FINE AND'
      '   DATADECORRENZA <= T430.DATADECORRENZA)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 551
    Top = 82
  end
  object selT430_DatePeriodi: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MAX(DATADECORRENZA) DECORRENZA,MAX(DATAFINE) DATA_FINE,IN' +
        'IZIO,FINE FROM T430_STORICO T'
      '  WHERE NVL(FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) > '
      
        '    (SELECT MAX(DATAFINE) FROM T430_STORICO T1 WHERE T1.PROGRESS' +
        'IVO = T.PROGRESSIVO'
      
        '       AND NVL(T1.FINE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')) = NVL(T.F' +
        'INE,TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')))'
      '  AND PROGRESSIVO = :Progressivo'
      '  GROUP BY INIZIO,FINE')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 435
    Top = 82
  end
  object selT033_campoDecode: TOracleDataSet
    SQL.Strings = (
      'SELECT decode(CAMPODB,'
      '              '#39'D_Comune'#39','#39'COMUNE'#39','
      '              '#39'D_COMUNE_DOM_BASE'#39','#39'COMUNE_DOM_BASE'#39','
      '              '#39'DescComune'#39','#39'CITTA'#39','
      '              '#39'D_ProvinciaNas'#39','#39'PROVINCIA'#39','
      '              '#39'D_Provincia'#39','#39'PROVINCIA'#39','
      '              '#39'D_PROVINCIA_DOM_BASE'#39','#39'PROVINCIA_DOM_BASE'#39','
      
        'CAMPODB) CAMPODB FROM T033_LAYOUT WHERE NOME = :Nome AND ACCESSO' +
        ' <> '#39'N'#39)
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 176
    Top = 16
  end
  object scrT030NoTrigger: TOracleQuery
    SQL.Strings = (
      'begin'
      '  if :INSERISCI = '#39'S'#39' then'
      
        '    insert into T030_NOTRIGGER (PROGRESSIVO,ISTANTE) values (:PR' +
        'OGRESSIVO,:ISTANTE);'
      '  else'
      
        '    delete from T030_NOTRIGGER where PROGRESSIVO = :PROGRESSIVO ' +
        'and ISTANTE = :ISTANTE;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A0049004E005300450052004900530043004900
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F00030000000000000000000000100000003A00490053005400
      41004E00540045000C0000000000000000000000}
    Left = 704
    Top = 151
  end
  object selI030: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   i030_relazioni_anagrafe i030'
      'where  i030.tabella = '#39'T430_STORICO'#39
      'order by i030.ordine, i030.colonna, i030.decorrenza')
    Optimize = False
    Filtered = True
    OnFilterRecord = selI030FilterRecord
    Left = 48
    Top = 329
  end
  object selI035: TOracleDataSet
    SQL.Strings = (
      'SELECT I035.*'
      'FROM   I035_RELAZIONI_DETTAGLIO I035'
      'WHERE'#9'I035.TABELLA = '#39'T430_STORICO'#39
      'ORDER BY I035.TABELLA, I035.COLONNA, I035.DECORRENZA, I035.NUM')
    Optimize = False
    Left = 112
    Top = 329
  end
  object selCOLS: TOracleDataSet
    SQL.Strings = (
      'SELECT TABLE_NAME, COLUMN_NAME, NULLABLE, DATA_DEFAULT'
      'FROM   COLS'
      
        'WHERE  TABLE_NAME IN ('#39'T030_ANAGRAFICO'#39','#39'T430_STORICO'#39','#39'P430_ANA' +
        'GRAFICO'#39')')
    ReadBuffer = 100
    Optimize = False
    Left = 168
    Top = 329
  end
  object selI090_GruppoBadge: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'1'#39' ORD, :AZIENDA AZIENDA, :UTENTE UTENTE'
      'FROM DUAL'
      'UNION'
      'SELECT '#39'2'#39' ORD, AZIENDA, UTENTE'
      'FROM MONDOEDP.I090_ENTI'
      'WHERE GRUPPO_BADGE = :GRUPPO'
      'AND AZIENDA <> :AZIENDA'
      'AND UTENTE <> :UTENTE'
      'ORDER BY ORD, UTENTE')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      0000000000000E0000003A00470052005500500050004F000500000000000000
      00000000}
    Left = 280
    Top = 329
  end
end
