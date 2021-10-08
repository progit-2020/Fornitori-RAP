object A014FPlusOrarioDtM1: TA014FPlusOrarioDtM1
  OldCreateOrder = True
  OnCreate = A014FPlusOrarioDtM1Create
  OnDestroy = A014FPlusOrarioDtM1Destroy
  Height = 85
  Width = 217
  object D060: TDataSource
    DataSet = T060
    Left = 96
    Top = 8
  end
  object T061: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T061.*,T061.ROWID FROM T061_PLUSORAANNUO T061 ORDER BY AN' +
        'NO,CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = T061BeforePost
    AfterPost = T061AfterDelete
    BeforeDelete = T061BeforeDelete
    AfterDelete = T061AfterDelete
    OnNewRecord = T061NewRecord
    Left = 20
    Top = 8
    object T061Anno: TFloatField
      FieldName = 'Anno'
      Required = True
      MaxValue = 3000.000000000000000000
      MinValue = 1000.000000000000000000
    end
    object T061Codice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object T061TipoPO: TStringField
      FieldName = 'TipoPO'
      Required = True
      Size = 1
    end
    object T061TipoDebito: TStringField
      FieldName = 'TipoDebito'
      Required = True
      Size = 1
    end
    object T061Ore1: TStringField
      FieldName = 'Ore1'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore2: TStringField
      FieldName = 'Ore2'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore3: TStringField
      FieldName = 'Ore3'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore4: TStringField
      FieldName = 'Ore4'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore5: TStringField
      FieldName = 'Ore5'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore6: TStringField
      FieldName = 'Ore6'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore7: TStringField
      FieldName = 'Ore7'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore8: TStringField
      FieldName = 'Ore8'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore9: TStringField
      FieldName = 'Ore9'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore10: TStringField
      FieldName = 'Ore10'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore11: TStringField
      FieldName = 'Ore11'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061Ore12: TStringField
      FieldName = 'Ore12'
      Required = True
      OnValidate = BDET061Ore1Validate
      EditMask = '!999:99;1;_'
      Size = 6
    end
    object T061TipoGest1: TStringField
      FieldName = 'TipoGest1'
      Size = 1
    end
    object T061TipoGest2: TStringField
      FieldName = 'TipoGest2'
      Size = 1
    end
    object T061TipoGest3: TStringField
      FieldName = 'TipoGest3'
      Size = 1
    end
    object T061TipoGest4: TStringField
      FieldName = 'TipoGest4'
      Size = 1
    end
    object T061TipoGest5: TStringField
      FieldName = 'TipoGest5'
      Size = 1
    end
    object T061TipoGest6: TStringField
      FieldName = 'TipoGest6'
      Size = 1
    end
    object T061TipoGest7: TStringField
      FieldName = 'TipoGest7'
      Size = 1
    end
    object T061TipoGest8: TStringField
      FieldName = 'TipoGest8'
      Size = 1
    end
    object T061TipoGest9: TStringField
      FieldName = 'TipoGest9'
      Size = 1
    end
    object T061TipoGest10: TStringField
      FieldName = 'TipoGest10'
      Size = 1
    end
    object T061TipoGest11: TStringField
      FieldName = 'TipoGest11'
      Size = 1
    end
    object T061TipoGest12: TStringField
      FieldName = 'TipoGest12'
      Size = 1
    end
    object T061D_Codice: TStringField
      FieldKind = fkLookup
      FieldName = 'D_Codice'
      LookupDataSet = T060
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'Codice'
      Size = 40
      Lookup = True
    end
  end
  object T060: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T060_PLUSORARIO ORDER BY CODICE')
    Optimize = False
    Left = 68
    Top = 8
    object T060CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object T060DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
end
