object A090FAssenzeAnnoDtM1: TA090FAssenzeAnnoDtM1
  OldCreateOrder = True
  OnCreate = A090FAssenzeAnnoDtM1Create
  OnDestroy = A090FAssenzeAnnoDtM1Destroy
  Height = 132
  Width = 272
  object D010: TDataSource
    Left = 27
    Top = 10
  end
  object QPresenze: TOracleDataSet
    SQL.Strings = (
      'select T100.PROGRESSIVO, T100.DATA'
      '  from T100_TIMBRATURE T100'
      ' where T100.PROGRESSIVO  = :PROGRESSIVO '
      '   and T100.DATA between :DaData and :AData '
      '   and T100.FLAG in ('#39'O'#39','#39'I'#39')'
      ' group by T100.PROGRESSIVO, T100.DATA'
      ' order by T100.PROGRESSIVO, T100.DATA')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000}
    Left = 104
    Top = 12
    object QPresenzePROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T100_TIMBRATURE.PROGRESSIVO'
    end
    object QPresenzeDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T100_TIMBRATURE.DATA'
    end
  end
  object QGiustificativiAssenza: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      'DATA,CAUSALE,TIPOGIUST,DAORE,AORE '
      'FROM T040_GIUSTIFICATIVI'
      'WHERE PROGRESSIVO = :PROGRESSIVO AND'
      'DATA BETWEEN :DaData AND :AData'
      'ORDER BY DATA,CAUSALE')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      00000000000000000000}
    Left = 188
    Top = 12
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 28
    Top = 60
  end
end
