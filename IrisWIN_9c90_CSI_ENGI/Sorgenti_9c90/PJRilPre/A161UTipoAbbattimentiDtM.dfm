inherited A161FTipoAbbattimentiDtM: TA161FTipoAbbattimentiDtM
  OldCreateOrder = True
  object selT766: TOracleDataSet
    SQL.Strings = (
      'select T766.*, T766.rowid from T766_INCENTIVITIPOABBAT T766'
      'order by codice')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000002400
      00005200490053005000410052004D0049004F005F00420049004C0041004E00
      430049004F00010000000000}
    Left = 56
    Top = 32
    object selT766CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT766DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT766RISPARMIO_BILANCIO: TStringField
      DisplayLabel = 'Risparmio'
      FieldName = 'RISPARMIO_BILANCIO'
      Size = 1
    end
  end
end
