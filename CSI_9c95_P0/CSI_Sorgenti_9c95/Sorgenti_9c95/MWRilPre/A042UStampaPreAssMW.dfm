inherited A042FStampaPreAssMW: TA042FStampaPreAssMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 212
  Width = 340
  object dscT275: TDataSource
    DataSet = selT275
    Left = 16
    Top = 61
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT ROWNUM AS NUMERO_RIGA, CODICE, DESCRIZIONE'
      
        '  FROM (SELECT '#39' '#39' AS CODICE1, '#39'**NC**'#39' AS CODICE, '#39'Ore non caus' +
        'alizzate'#39' AS DESCRIZIONE'
      '         FROM DUAL'
      '        UNION'
      '       SELECT CODICE AS CODICE1, CODICE, DESCRIZIONE '
      '         FROM T275_CAUPRESENZE'
      '        GROUP BY CODICE, DESCRIZIONE)')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001600
      00004E0055004D00450052004F005F005200490047004100010000000000}
    Left = 16
    Top = 8
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT ROWNUM AS NUMERO_RIGA, CODICE, DESCRIZIONE FROM('
      'SELECT CODICE, DESCRIZIONE FROM T265_CAUASSENZE'
      'GROUP BY CODICE, DESCRIZIONE)')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000003000000160000004E0055004D00450052004F005F00520049004700
      41000100000000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 80
    Top = 8
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 124
  end
  object QTimbrature: TOracleDataSet
    SQL.Strings = (
      'SELECT PROGRESSIVO,DATA,ORA,VERSO,CAUSALE'
      'FROM T100_TIMBRATURE T100'
      'WHERE '
      '  PROGRESSIVO  =:PROGRESSIVO AND'
      '  DATA = :DATA AND'
      '  FLAG IN ('#39'O'#39','#39'I'#39')'
      'ORDER BY ORA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 157
    Top = 8
    object QTimbraturePROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T100_TIMBRATURE.PROGRESSIVO'
    end
    object QTimbratureDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T100_TIMBRATURE.DATA'
    end
    object QTimbratureORA: TDateTimeField
      FieldName = 'ORA'
      Origin = 'T100_TIMBRATURE.PROGRESSIVO'
    end
    object QTimbratureVERSO: TStringField
      FieldName = 'VERSO'
      Origin = 'T100_TIMBRATURE.VERSO'
      Size = 1
    end
    object QTimbratureCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Origin = 'T100_TIMBRATURE.CAUSALE'
      Size = 5
    end
  end
  object QGiustificativi: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      
        'PROGRESSIVO,DATA,CAUSALE,DAORE,AORE,PROGRCAUSALE,TIPOGIUST,CODIC' +
        'E'
      'FROM T040_GIUSTIFICATIVI T040,T275_CAUPRESENZE T275'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND'
      '      DATA = :DATA AND'
      '      TIPOGIUST NOT IN ('#39'I'#39','#39'M'#39') AND'
      '      CAUSALE = T275.CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 156
    Top = 60
    object QGiustificativiPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T040_GIUSTIFICATIVI.PROGRESSIVO'
    end
    object QGiustificativiDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T040_GIUSTIFICATIVI.DATA'
    end
    object QGiustificativiCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Origin = 'T040_GIUSTIFICATIVI.CAUSALE'
      Size = 5
    end
    object QGiustificativiDAORE: TDateTimeField
      FieldName = 'DAORE'
      Origin = 'T040_GIUSTIFICATIVI.DAORE'
    end
    object QGiustificativiAORE: TDateTimeField
      FieldName = 'AORE'
      Origin = 'T040_GIUSTIFICATIVI.AORE'
    end
    object QGiustificativiPROGRCAUSALE: TFloatField
      FieldName = 'PROGRCAUSALE'
      Origin = 'T040_GIUSTIFICATIVI.PROGRCAUSALE'
    end
    object QGiustificativiTIPOGIUST: TStringField
      FieldName = 'TIPOGIUST'
      Origin = 'T040_GIUSTIFICATIVI.TIPOGIUST'
      Size = 1
    end
    object QGiustificativiCODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T275_CAUPRESENZE.CODICE'
      Size = 5
    end
  end
  object QGiustificativiAssenza: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'PROGRESSIVO,DATA,CAUSALE,TIPOGIUST,DAORE,AORE,T265.DESCRIZIONE'
      'FROM T040_GIUSTIFICATIVI T040,T265_CAUASSENZE T265'
      'WHERE T040.PROGRESSIVO = :PROGRESSIVO AND               '
      '      T040.DATA = :DATA AND'
      '      T040.CAUSALE = T265.CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 160
    Top = 124
    object QGiustificativiAssenzaPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T040_GIUSTIFICATIVI.PROGRESSIVO'
    end
    object QGiustificativiAssenzaDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T040_GIUSTIFICATIVI.DATA'
    end
    object QGiustificativiAssenzaCAUSALE: TStringField
      FieldName = 'CAUSALE'
      Origin = 'T040_GIUSTIFICATIVI.CAUSALE'
      Size = 5
    end
    object QGiustificativiAssenzaTIPOGIUST: TStringField
      FieldName = 'TIPOGIUST'
      Origin = 'T040_GIUSTIFICATIVI.TIPOGIUST'
      Size = 1
    end
    object QGiustificativiAssenzaDAORE: TDateTimeField
      FieldName = 'DAORE'
      Origin = 'T040_GIUSTIFICATIVI.DAORE'
    end
    object QGiustificativiAssenzaAORE: TDateTimeField
      FieldName = 'AORE'
      Origin = 'T040_GIUSTIFICATIVI.AORE'
    end
    object QGiustificativiAssenzaDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dscT265: TDataSource
    Left = 80
    Top = 64
  end
  object SelOrdinaArray: TOracleDataSet
    Optimize = False
    Left = 80
    Top = 120
  end
end
