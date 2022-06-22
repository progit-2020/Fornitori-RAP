object A059FContSquadreDtM1: TA059FContSquadreDtM1
  OldCreateOrder = True
  OnCreate = A059FContSquadreDtM1Create
  OnDestroy = A059FContSquadreDtM1Destroy
  Height = 74
  Width = 330
  object Q080: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T080.PROGRESSIVO,T080.ORARIO,T080.TURNO1EU,T080.TURNO2EU,' +
        'T080.TURNO1,T080.TURNO2 '
      '  FROM T080_PIANIFORARI T080, T430_STORICO T430 '
      ' WHERE T080.DATA = :DATA '
      '   AND T430.PROGRESSIVO = T080.PROGRESSIVO '
      '   AND T080.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE '
      '   AND T430.SQUADRA = :SQUADRA '
      '   :TIPOOPE')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00530051005500410044005200410005000000000000000000
      0000100000003A005400490050004F004F005000450001000000000000000000
      0000}
    Left = 16
    Top = 4
  end
  object Q081: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T081.PROGRESSIVO,T081.ORARIO,T081.TURNO1EU,T081.TURNO2EU,' +
        'T081.TURNO1,T081.TURNO2 '
      '  FROM T081_PROVVISORIO T081, T430_STORICO T430 '
      ' WHERE T081.DATA = :DATA '
      '   AND T430.PROGRESSIVO = T081.PROGRESSIVO '
      '   AND T081.DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE '
      '   AND T430.SQUADRA = :SQUADRA '
      '   :TIPOOPE'
      '   :FLAGAGG')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A0044004100540041000C000000000000000000
      0000100000003A00530051005500410044005200410005000000000000000000
      0000100000003A0046004C004100470041004700470001000000000000000000
      0000100000003A005400490050004F004F005000450001000000000000000000
      0000}
    Left = 48
    Top = 4
  end
  object Q040: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(PROGRESSIVO) FROM '
      '  T041_PROVVISORIO'
      '  WHERE'
      '  DATA = :DATA AND'
      '  PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000}
    Left = 80
    Top = 4
  end
  object Q041: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM'
      '  T041_PROVVISORIO'
      '  WHERE '
      '  DATA = :DATA AND'
      '  PROGRESSIVO = :PROGRESSIVO'
      '  :FLAGAGG')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0044004100540041000C000000000000000000
      0000180000003A00500052004F0047005200450053005300490056004F000300
      00000000000000000000100000003A0046004C00410047004100470047000100
      00000000000000000000}
    Left = 112
    Top = 4
  end
  object Q600Squadre: TOracleDataSet
    SQL.Strings = (
      'SELECT T600.* '
      '  FROM T600_SQUADRE T600'
      ' WHERE T600.CODICE BETWEEN :CODICE1 AND :CODICE2'
      ' ORDER BY T600.CODICE'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0043004F004400490043004500310005000000
      0000000000000000100000003A0043004F004400490043004500320005000000
      0000000000000000}
    Left = 160
    Top = 4
    object Q600SquadreCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T600_SQUADRE.CODICE'
      Size = 5
    end
    object Q600SquadreDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T600_SQUADRE.DESCRIZIONE'
      Size = 40
    end
    object Q600SquadreTOTMIN1: TIntegerField
      FieldName = 'TOTMIN1'
    end
    object Q600SquadreTOTMAX1: TIntegerField
      FieldName = 'TOTMAX1'
    end
    object Q600SquadreTOTMIN2: TIntegerField
      FieldName = 'TOTMIN2'
    end
    object Q600SquadreTOTMAX2: TIntegerField
      FieldName = 'TOTMAX2'
    end
    object Q600SquadreTOTMIN3: TIntegerField
      FieldName = 'TOTMIN3'
    end
    object Q600SquadreTOTMAX3: TIntegerField
      FieldName = 'TOTMAX3'
    end
    object Q600SquadreTOTMIN4: TIntegerField
      FieldName = 'TOTMIN4'
    end
    object Q600SquadreTOTMAX4: TIntegerField
      FieldName = 'TOTMAX4'
    end
    object Q600SquadreFESMIN1: TIntegerField
      FieldName = 'FESMIN1'
    end
    object Q600SquadreFESMAX1: TIntegerField
      FieldName = 'FESMAX1'
    end
    object Q600SquadreFESMIN2: TIntegerField
      FieldName = 'FESMIN2'
    end
    object Q600SquadreFESMAX2: TIntegerField
      FieldName = 'FESMAX2'
    end
    object Q600SquadreFESMIN3: TIntegerField
      FieldName = 'FESMIN3'
    end
    object Q600SquadreFESMAX3: TIntegerField
      FieldName = 'FESMAX3'
    end
    object Q600SquadreFESMIN4: TIntegerField
      FieldName = 'FESMIN4'
    end
    object Q600SquadreFESMAX4: TIntegerField
      FieldName = 'FESMAX4'
    end
  end
  object Q601: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T601_TIPIOPERATORE'
      'WHERE SQUADRA = :SQUADRA '
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00530051005500410044005200410005000000
      0000000000000000}
    Left = 212
    Top = 4
    object Q601SQUADRA: TStringField
      FieldName = 'SQUADRA'
      Origin = 'T601_TIPIOPERATORE.SQUADRA'
      Size = 5
    end
    object Q601CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T601_TIPIOPERATORE.CODICE'
      Size = 5
    end
    object Q601MIN1: TIntegerField
      FieldName = 'MIN1'
    end
    object Q601MAX1: TIntegerField
      FieldName = 'MAX1'
    end
    object Q601MIN2: TIntegerField
      FieldName = 'MIN2'
    end
    object Q601MAX2: TIntegerField
      FieldName = 'MAX2'
    end
    object Q601MIN3: TIntegerField
      FieldName = 'MIN3'
    end
    object Q601MAX3: TIntegerField
      FieldName = 'MAX3'
    end
    object Q601MIN4: TIntegerField
      FieldName = 'MIN4'
    end
    object Q601MAX4: TIntegerField
      FieldName = 'MAX4'
    end
  end
  object QT021: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T021.CODICE,T021.DECORRENZA,T021.TIPO_FASCIA,T021.ENTRATA' +
        ',T021.USCITA,T021.SIGLATURNI,T021.NUMTURNO'
      ' FROM T021_FASCEORARI T021, T020_ORARI T020'
      'WHERE T021.CODICE = T020.CODICE'
      '  AND T021.DECORRENZA = T020.DECORRENZA'
      
        '  AND T020.DECORRENZA = (SELECT MAX(DECORRENZA) FROM T020_ORARI ' +
        'WHERE CODICE = T020.CODICE) '
      '  AND T020.TIPOORA = '#39'E'#39
      '  AND T021.TIPO_FASCIA = '#39'PN'#39
      
        'ORDER BY T021.CODICE,T021.DECORRENZA,T021.TIPO_FASCIA,T021.ENTRA' +
        'TA,T021.USCITA')
    Optimize = False
    Left = 264
    Top = 5
  end
end
