inherited A040FPianifRepMW: TA040FPianifRepMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 250
  Width = 559
  object D350: TDataSource
    DataSet = Q350
    Left = 44
    Top = 12
  end
  object Q350: TOracleDataSet
    SQL.Strings = (
      'SELECT T350.*, ROWID FROM T350_REGREPERIB T350'
      'WHERE TIPOLOGIA = :TIPOLOGIA'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 16
    Top = 12
    object Q350CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 5
    end
    object Q350DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Size = 40
    end
    object Q350ORAINIZIO: TDateTimeField
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
    end
    object Q350ORAFINE: TDateTimeField
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
    end
    object Q350TIPOORE: TStringField
      FieldName = 'TIPOORE'
      Origin = 'T350_REGREPERIB.TIPOORE'
      Size = 1
    end
    object Q350ORENORMALI: TDateTimeField
      FieldName = 'ORENORMALI'
      Origin = 'T350_REGREPERIB.ORENORMALI'
    end
    object Q350ORECOMPRESENZA: TDateTimeField
      FieldName = 'ORECOMPRESENZA'
      Origin = 'T350_REGREPERIB.ORECOMPRESENZA'
    end
    object Q350TIPOTURNO: TStringField
      FieldName = 'TIPOTURNO'
      Origin = 'T350_REGREPERIB.TIPOTURNO'
      Size = 1
    end
    object Q350RAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Origin = 'T350_REGREPERIB.RAGGRUPPAMENTO'
    end
    object Q350PIANIF_MAX_MESE: TIntegerField
      FieldName = 'PIANIF_MAX_MESE'
    end
    object Q350PIANIF_MAX_MESE_TURNI_INTERI: TStringField
      FieldName = 'PIANIF_MAX_MESE_TURNI_INTERI'
      Size = 1
    end
    object Q350ORE_MIN_INDENNITA: TStringField
      FieldName = 'ORE_MIN_INDENNITA'
      Size = 5
    end
    object Q350TURNO_INTERO: TStringField
      FieldName = 'TURNO_INTERO'
      Size = 5
    end
    object Q350BLOCCA_MAX_MESE: TStringField
      FieldName = 'BLOCCA_MAX_MESE'
      Size = 1
    end
  end
  object Q350Opposto: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T350_REGREPERIB'
      'WHERE TIPOLOGIA <> :TIPOLOGIA'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 101
    Top = 12
    object StringField1: TStringField
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 5
    end
    object StringField2: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Size = 40
    end
    object DateTimeField1: TDateTimeField
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
    end
    object StringField3: TStringField
      FieldName = 'TIPOORE'
      Origin = 'T350_REGREPERIB.TIPOORE'
      Size = 1
    end
    object DateTimeField3: TDateTimeField
      FieldName = 'ORENORMALI'
      Origin = 'T350_REGREPERIB.ORENORMALI'
    end
    object DateTimeField4: TDateTimeField
      FieldName = 'ORECOMPRESENZA'
      Origin = 'T350_REGREPERIB.ORECOMPRESENZA'
    end
    object StringField4: TStringField
      FieldName = 'TIPOTURNO'
      Origin = 'T350_REGREPERIB.TIPOTURNO'
      Size = 1
    end
    object StringField5: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Origin = 'T350_REGREPERIB.RAGGRUPPAMENTO'
    end
  end
  object Q270: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE '
      'FROM T270_RAGGRPRESENZE'
      'WHERE CODINTERNO = :CODINTERNO')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0043004F00440049004E005400450052004E00
      4F00050000000000000000000000}
    Left = 259
    Top = 12
  end
  object QControllo: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM T380_PIANIFREPERIB '
      'WHERE '
      '  DATA = :DATA AND'
      '  PROGRESSIVO <> :PROGRESSIVO AND'
      '  TIPOLOGIA = :TIPOLOGIA AND'
      '  (TURNO1 IN (:T1,:T2,:T3) OR'
      '   TURNO2 IN (:T1,:T2,:T3) OR'
      '   TURNO3 IN (:T1,:T2,:T3))')
    Optimize = False
    Variables.Data = {
      0400000006000000060000003A00540031000500000000000000000000000600
      00003A00540032000500000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000060000003A0054003300
      050000000000000000000000140000003A005400490050004F004C004F004700
      49004100050000000000000000000000}
    Left = 368
    Top = 12
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT CAUSALE FROM T040_GIUSTIFICATIVI WHERE'
      'PROGRESSIVO = :PROGRESSIVO AND'
      'DATA = :DATA '
      'AND TIPOGIUST = '#39'I'#39)
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 416
    Top = 12
  end
  object Q430Contratto: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T430.CONTRATTO, T200.DESCRIZIONE, T430.ABPRESENZA1, T200.' +
        'REPERIBILITA'
      'FROM   T430_STORICO T430, T200_CONTRATTI T200'
      'WHERE  T430.PROGRESSIVO = :PROGRESSIVO'
      'AND    T430.DATADECORRENZA <= :DATA'
      'AND    T430.DATAFINE >= :DATA '
      'AND    T430.CONTRATTO = T200.CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 478
    Top = 12
  end
  object selT380a: TOracleDataSet
    SQL.Strings = (
      'select T380.TURNO1, T380.TURNO2, T380.TURNO3'
      'from   t380_pianifreperib T380'
      'where  T380.progressivo = :PROGRESSIVO'
      'and    T380.data = :DATA'
      'and    T380.tipologia <> :TIPOLOGIA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000A0000003A00440041005400
      41000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000140000004400410054004F004C0049004200450052004F000100
      000000000C0000005400550052004E004F003300010000000000}
    UpdatingTable = 'T380_PIANIFREPERIB '
    Left = 84
    Top = 75
  end
  object dsrDatoLibero: TDataSource
    DataSet = selDatoLibero
    Left = 241
    Top = 75
  end
  object selDatoLibero: TOracleDataSet
    ReadBuffer = 200
    Optimize = False
    Left = 168
    Top = 75
  end
  object cdsParametri: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Turno1'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Turno2'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Turno3'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'DatoLibero'
        DataType = ftString
        Size = 40
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 352
    Top = 75
    object cdsParametriTurno1: TStringField
      FieldName = 'Turno1'
      Size = 5
    end
    object cdsParametriTurno2: TStringField
      FieldName = 'Turno2'
      Size = 5
    end
    object cdsParametriTurno3: TStringField
      FieldName = 'Turno3'
      Size = 5
    end
    object cdsParametriDatoLibero: TStringField
      FieldName = 'DatoLibero'
      Size = 40
    end
  end
  object dsrParametri: TDataSource
    DataSet = cdsParametri
    Left = 420
    Top = 75
  end
  object insT380: TOracleQuery
    SQL.Strings = (
      'insert into T380_PIANIFREPERIB'
      
        '  (DATA, PROGRESSIVO, BADGE, NOME, TURNO1, PRIORITA1, TURNO2, PR' +
        'IORITA2, TURNO3, PRIORITA3, DATOLIBERO,TIPOLOGIA)'
      'values'
      
        '  (:DATA, :PROGRESSIVO, :BADGE, :NOME, :TURNO1, :PRIORITA1, :TUR' +
        'NO2, :PRIORITA2, :TURNO3, :PRIORITA3, :DATOLIBERO, :TIPOLOGIA)')
    Optimize = False
    Variables.Data = {
      040000000C0000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      000000000000000000000C0000003A0042004100440047004500030000000000
      0000000000000A0000003A004E004F004D004500050000000000000000000000
      0E0000003A005400550052004E004F0031000500000000000000000000000E00
      00003A005400550052004E004F00320005000000000000000000000016000000
      3A004400410054004F004C0049004200450052004F0005000000000000000000
      00000E0000003A005400550052004E004F003300050000000000000000000000
      140000003A005400490050004F004C004F004700490041000500000000000000
      00000000140000003A005000520049004F005200490054004100310003000000
      0000000000000000140000003A005000520049004F0052004900540041003200
      030000000000000000000000140000003A005000520049004F00520049005400
      41003300030000000000000000000000}
    Left = 22
    Top = 139
  end
  object delT380: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T380_PIANIFREPERIB '
      'WHERE  PROGRESSIVO = :PROGRESSIVO '
      'AND    DATA = :DATA '
      'AND    TIPOLOGIA = :TIPOLOGIA'
      '       :WHERE')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000C0000003A0057004800450052004500010000000000
      000000000000140000003A005400490050004F004C004F004700490041000500
      00000000000000000000}
    Left = 84
    Top = 139
  end
  object selT385: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T385.*, V010.FESTIVO DTFESTIVO, V010A.FESTIVO DTPREFESTIV' +
        'O, TO_CHAR(:DATA - 1,'#39'D'#39') DTGIORNO'
      
        'FROM T385_VINCOLI_REPERIB T385, V010_CALENDARI V010, V010_CALEND' +
        'ARI V010A'
      'WHERE T385.PROGRESSIVO = :PROGRESSIVO '
      '  AND T385.TIPOLOGIA = :TIPO'
      '  AND :DATA BETWEEN T385.DECORRENZA AND T385.DECORRENZA_FINE'
      '  AND V010.PROGRESSIVO = :PROGRESSIVO '
      '  AND V010.DATA = :DATA'
      '  AND V010A.PROGRESSIVO = :PROGRESSIVO '
      '  AND V010A.DATA = :DATA + 1'
      
        'ORDER BY DECODE(T385.GIORNO,'#39'*'#39',0,'#39'PF'#39',8,'#39'FS'#39',9,T385.GIORNO) DES' +
        'C')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000000A0000003A005400490050004F000500000000000000
      00000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000140000004400410054004F004C0049004200450052004F000100
      000000000C0000005400550052004E004F003300010000000000}
    UpdatingTable = 'T380_PIANIFREPERIB '
    Left = 169
    Top = 135
  end
  object selSumTurniAtt: TOracleQuery
    SQL.Strings = (
      
        '-- nota: DATARIF serve unicamente a leggere il codice contratto ' +
        'nel periodo storico corretto'
      
        '--       il contratto '#232' utilizzato per reperire la durata del tu' +
        'rno di reperibilit'#224' se il turno_intero '
      '--       non '#232' specificato sulle regole'
      'select sum(rapporto), sum(contatore) from'
      '('
      
        'select t350.orainizio,t350.orafine,nvl(t350.turno_intero,t200.re' +
        'peribilita) turno_intero,'
      
        '       decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t350_regreperib t350, t430_storico t430, t200_contratti t' +
        '200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t350.codice = :TURNO1'
      'and    t430.progressivo = :PROGRESSIVO'
      'and    :DATARIF between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select t350.orainizio,t350.orafine,nvl(t350.turno_intero,t200.re' +
        'peribilita) turno_intero,'
      
        '       decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t350_regreperib t350, t430_storico t430, t200_contratti t' +
        '200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t350.codice = :TURNO2'
      'and    t430.progressivo = :PROGRESSIVO'
      'and    :DATARIF between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select t350.orainizio,t350.orafine,nvl(t350.turno_intero,t200.re' +
        'peribilita) turno_intero,'
      
        '       decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t350_regreperib t350, t430_storico t430, t200_contratti t' +
        '200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t350.codice = :TURNO3'
      'and    t430.progressivo = :PROGRESSIVO'
      'and    :DATARIF between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      ')')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000006000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041005200
      490046000C00000000000000000000000E0000003A005400550052004E004F00
      31000500000000000000000000000E0000003A005400550052004E004F003200
      0500000000000000000000000E0000003A005400550052004E004F0033000500
      00000000000000000000140000003A005400490050004F004C004F0047004900
      4100050000000000000000000000}
    Left = 108
    Top = 196
  end
  object selT380SumTurniMese: TOracleQuery
    SQL.Strings = (
      'select sum(rapporto), sum(contatore) from'
      '('
      
        'select decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t380_pianifreperib t380, t350_regreperib t350, t430_stori' +
        'co t430, t200_contratti t200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t380.progressivo = :PROGRESSIVO'
      'and    t380.data between :DATADA and :DATAA'
      ':FILTRO'
      'and    t380.turno1 = t350.codice'
      'and    t380.progressivo = t430.progressivo'
      'and    t380.data between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t380_pianifreperib t380, t350_regreperib t350, t430_stori' +
        'co t430, t200_contratti t200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t380.progressivo = :PROGRESSIVO'
      'and    t380.data between :DATADA and :DATAA'
      ':FILTRO'
      'and    t380.turno2 = t350.codice'
      'and    t380.progressivo = t430.progressivo'
      'and    t380.data between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      'union all'
      
        'select decode(oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        '),'
      '              0,0,'
      '              (oreminuti(to_char(t350.orafine,'#39'hh24.mi'#39')) - '
      '               oreminuti(to_char(t350.orainizio,'#39'hh24.mi'#39')) +'
      '               decode(sign(t350.orafine - t350.orainizio),'
      '                      0,1440,'
      '                      -1,1440,'
      '                      0)) /'
      
        '              oreminuti(nvl(t350.turno_intero,t200.reperibilita)' +
        ')) rapporto,'
      '       1 contatore'
      
        'from   t380_pianifreperib t380, t350_regreperib t350, t430_stori' +
        'co t430, t200_contratti t200'
      'where  t350.tipologia = :TIPOLOGIA'
      'and    t380.progressivo = :PROGRESSIVO'
      'and    t380.data between :DATADA and :DATAA'
      ':FILTRO'
      'and    t380.turno3 = t350.codice'
      'and    t380.progressivo = t430.progressivo'
      'and    t380.data between t430.datadecorrenza and t430.datafine'
      'and    t430.contratto = t200.codice'
      ')')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      0400000005000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100540041004400
      41000C00000000000000000000000C0000003A00440041005400410041000C00
      000000000000000000000E0000003A00460049004C00540052004F0001000000
      0000000000000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Left = 204
    Top = 196
  end
  object selT381: TOracleDataSet
    SQL.Strings = (
      'select DATA, PRIORITA'
      'from T381_PIANIF_PRIORITACHIAMATA T381'
      'where PROGRESSIVO = :PROGRESSIVO'
      'and DATA = (select max(DATA) '
      '            from T381_PIANIF_PRIORITACHIAMATA T381A'
      '            where T381A.PROGRESSIVO = T381.PROGRESSIVO'
      '            and T381A.DATA <= :DATA)')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000140000004400410054004F004C0049004200450052004F000100
      000000000C0000005400550052004E004F003300010000000000}
    UpdatingTable = 'T380_PIANIFREPERIB '
    Left = 364
    Top = 139
  end
  object selT380b: TOracleDataSet
    SQL.Strings = (
      'select COUNT(DISTINCT(DATA)) N_GG_PIANIF'
      'from T380_PIANIFREPERIB T380'
      'where TIPOLOGIA = :TIPOLOGIA'
      'and PROGRESSIVO = :PROGRESSIVO'
      'and DATA between :DINI and :DFIN')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000180000003A00500052004F004700520045005300
      5300490056004F000300000000000000000000000A0000003A00440049004E00
      49000C00000000000000000000000A0000003A004400460049004E000C000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0500000006000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000140000004400410054004F004C0049004200450052004F000100
      000000000C0000005400550052004E004F003300010000000000}
    UpdatingTable = 'T380_PIANIFREPERIB '
    Left = 420
    Top = 139
  end
end
