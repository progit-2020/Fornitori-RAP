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
      'select '
      '  '#39'N'#39' RICHIESTA,'#39'S'#39' ELABORATO,'#39'S'#39' STATO,'
      '  DATA,CAUSALE,TIPOGIUST,'
      '  DAORE,AORE '
      'from T040_GIUSTIFICATIVI'
      'where 1=1'
      'and PROGRESSIVO = :PROGRESSIVO '
      'and DATA between :DaData and :AData'
      ''
      'union '
      ''
      'select '
      '  '#39'S'#39' RICHIESTA,T050.ELABORATO,T050.STATO,'
      '  V010.DATA,T050.CAUSALE,T050.TIPOGIUST,'
      
        '  decode(T050.NUMEROORE,null,to_date(null),to_date('#39'30121899'#39'||T' +
        '050.NUMEROORE,'#39'ddmmyyyyhh24.mi'#39')) DAORE,'
      
        '  decode(T050.AORE,null,to_date(null),to_date('#39'30121899'#39'||T050.A' +
        'ORE,'#39'ddmmyyyyhh24.mi'#39')) AORE '
      'from VT050_RICHIESTE_SENZAREVOCA T050, V010_CALENDARI V010'
      'where 1=1'
      'and :RICHIESTE_WEB <> '#39'N'#39
      'and V010.PROGRESSIVO = :PROGRESSIVO'
      'and V010.PROGRESSIVO = T050.PROGRESSIVO '
      'and V010.DATA between T050.DAL and T050.AL'
      'and T050.ELABORATO = '#39'N'#39'       --non sono elaborate'
      'and nvl(T050.STATO,'#39'R'#39') <> '#39'N'#39' --non sono negate'
      
        'and decode(T050.STATO,null,'#39'R'#39','#39'S'#39','#39'A'#39',T050.STATO) = :RICHIESTE_' +
        'WEB'
      'and V010.DATA between :DaData and :AData'
      ''
      'order by DATA,CAUSALE')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A0044004100440041005400
      41000C00000000000000000000000C0000003A00410044004100540041000C00
      000000000000000000001C0000003A0052004900430048004900450053005400
      45005F00570045004200050000000000000000000000}
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
