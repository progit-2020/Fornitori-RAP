inherited A049FStampaPastiMW: TA049FStampaPastiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 287
  object selT361: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T361_OROLOGI'
      'WHERE FUNZIONE IN ('#39'M'#39','#39'E'#39')')
    Optimize = False
    Left = 24
    Top = 12
    object selT361CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T361_OROLOGI.CODICE'
      Size = 2
    end
    object selT361DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T361_OROLOGI.DESCRIZIONE'
      Size = 40
    end
  end
  object dsr010: TDataSource
    Left = 124
    Top = 12
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 20
  end
end
