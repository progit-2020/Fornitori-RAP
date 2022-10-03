inherited P130FPagamentiDtM: TP130FPagamentiDtM
  OldCreateOrder = True
  Height = 88
  Width = 87
  object selP130: TOracleDataSet
    SQL.Strings = (
      
        'SELECT P130.*,P130.ROWID FROM P130_PAGAMENTI P130 ORDER BY COD_P' +
        'AGAMENTO')
    Optimize = False
    OracleDictionary.DefaultValues = True
    Left = 16
    Top = 8
    object selP130COD_PAGAMENTO: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_PAGAMENTO'
      Required = True
      Size = 5
    end
    object selP130DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selP130MOD_PAGAMENTO: TStringField
      DisplayLabel = 'Modalit'#224' di pagamento record 10 tracciato SETIF/CBI'
      FieldName = 'MOD_PAGAMENTO'
      Size = 1
    end
  end
end
