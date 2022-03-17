inherited A150FAccorpamentoCausaliDtM: TA150FAccorpamentoCausaliDtM
  OldCreateOrder = True
  Height = 120
  Width = 137
  object selT256: TOracleDataSet
    SQL.Strings = (
      'SELECT T256.*,T256.ROWID'
      'FROM T256_CODICIACCORPCAUSALI T256'
      'ORDER BY COD_TIPOACCORPCAUSALI, COD_CODICIACCORPCAUSALI')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000003000000160000004400450053004300520049005A0049004F004E00
      45000100000000002A00000043004F0044005F005400490050004F0041004300
      43004F0052005000430041005500530041004C0049000100000000002E000000
      43004F0044005F0043004F0044004900430049004100430043004F0052005000
      430041005500530041004C004900010000000000}
    BeforeDelete = BeforeDelete
    AfterScroll = selT256AfterScroll
    Left = 13
    Top = 17
    object selT256COD_TIPOACCORPCAUSALI: TStringField
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selT256COD_CODICIACCORPCAUSALI: TStringField
      FieldName = 'COD_CODICIACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selT256DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT256D_TIPOACCORPCAUSALI: TStringField
      FieldKind = fkLookup
      FieldName = 'D_TIPOACCORPCAUSALI'
      LookupDataSet = selT255
      LookupKeyFields = 'COD_TIPOACCORPCAUSALI'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_TIPOACCORPCAUSALI'
      Size = 500
      Lookup = True
    end
  end
  object selT255: TOracleDataSet
    SQL.Strings = (
      'SELECT T255.*,T255.ROWID '
      '  FROM T255_TIPOACCORPCAUSALI T255'
      ' ORDER BY T255.COD_TIPOACCORPCAUSALI')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000002000000160000004400450053004300520049005A0049004F004E00
      45000100000000002A00000043004F0044005F005400490050004F0041004300
      43004F0052005000430041005500530041004C004900010000000000}
    BeforePost = selT255BeforePost
    Left = 71
    Top = 16
    object selT255COD_TIPOACCORPCAUSALI: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selT255DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT255TIPO: TStringField
      DisplayWidth = 8
      FieldName = 'TIPO'
      Size = 5
    end
  end
  object dsrT255: TDataSource
    AutoEdit = False
    DataSet = selT255
    Left = 70
    Top = 64
  end
end
