object A017FRaggrAsseDtM1: TA017FRaggrAsseDtM1
  OldCreateOrder = True
  OnCreate = A017FRaggrAsseDtM1Create
  OnDestroy = A017FRaggrAsseDtM1Destroy
  Height = 200
  Width = 421
  object T260: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T260.*,T260.ROWID FROM T260_RAGGRASSENZE T260 ORDER BY CO' +
        'DICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000090000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001400
      000043004F00440049004E005400450052004E004F0001000000000016000000
      43004F004E005400410053004F004C0041005200450001000000000016000000
      5200450053004900440055004100420049004C00450001000000000014000000
      4D00410058005200450053004900440055004F000100000000002C0000005200
      410047004700520055005000500041004D0045004E0054004F005F0052004500
      53004900440055004F0001000000000024000000520041004700470052005F00
      5200450053004900440055004F005F0050005200450043000100000000002200
      0000430055004D0055004C0041005F00520041004700470052005F0042004100
      53004500010000000000}
    Filtered = True
    BeforePost = T260BeforePost
    AfterPost = T260AfterPost
    BeforeDelete = T260BeforeDelete
    AfterDelete = T260AfterDelete
    OnFilterRecord = T260FilterRecord
    OnNewRecord = T260NewRecord
    Left = 12
    Top = 10
    object T260Codice: TStringField
      FieldName = 'Codice'
      Required = True
      Size = 5
    end
    object T260Descrizione: TStringField
      FieldName = 'Descrizione'
      Size = 40
    end
    object T260CodInterno: TStringField
      FieldName = 'CodInterno'
      Size = 1
    end
    object T260ContASolare: TStringField
      FieldName = 'ContASolare'
      Size = 1
    end
    object T260Residuabile: TStringField
      FieldName = 'Residuabile'
      Size = 1
    end
    object T260MAXRESIDUO: TStringField
      FieldName = 'MAXRESIDUO'
      EditMask = '!9999.99;1;_'
      Size = 8
    end
    object T260RAGGRUPPAMENTO_RESIDUO: TStringField
      FieldName = 'RAGGRUPPAMENTO_RESIDUO'
      Size = 5
    end
    object T260RAGGR_RESIDUO_PREC: TStringField
      FieldName = 'RAGGR_RESIDUO_PREC'
      Size = 5
    end
    object T260CUMULA_RAGGR_BASE: TStringField
      FieldName = 'CUMULA_RAGGR_BASE'
      Size = 1
    end
    object T260MAXRESIDUO_CORR: TStringField
      FieldName = 'MAXRESIDUO_CORR'
      EditMask = '!9999.99;1;_'
      Size = 8
    end
    object T260MAXRESIDUO_PREC: TStringField
      FieldName = 'MAXRESIDUO_PREC'
      EditMask = '!9999.99;1;_'
      Size = 8
    end
  end
  object selT260: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE from T260_RAGGRASSENZE'
      'order by CODICE')
    Optimize = False
    Left = 12
    Top = 56
  end
  object dsrT260: TDataSource
    DataSet = selT260
    Left = 56
    Top = 56
  end
  object selTipiResiduiAC: TOracleDataSet
    SQL.Strings = (
      'SELECT 0 ORDINE, '#39'N'#39' CODICE, '#39'Nessun limite'#39' DESCRIZIONE'
      'FROM DUAL'
      'UNION'
      
        'SELECT 1 ORDINE, '#39'C'#39' CODICE, '#39'Competenze correnti / 2'#39' DESCRIZIO' +
        'NE'
      'FROM DUAL'
      'ORDER BY 1')
    Optimize = False
    Left = 131
    Top = 12
  end
  object dsrTipiResiduiAC: TDataSource
    DataSet = selTipiResiduiAC
    Left = 131
    Top = 56
  end
end
