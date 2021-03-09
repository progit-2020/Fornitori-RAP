inherited P030FValuteDtM: TP030FValuteDtM
  OldCreateOrder = True
  Height = 86
  Width = 168
  object selP030: TOracleDataSet
    SQL.Strings = (
      'SELECT P030.*,P030.ROWID FROM P030_VALUTE P030'
      'ORDER BY COD_VALUTA, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000001400000043004F0044005F00560041004C00550054004100
      010000000000140000004400450043004F005200520045004E005A0041000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      000000001A000000410042004200520045005600490041005A0049004F004E00
      4500010000000000200000004E0055004D005F004400450043005F0049004D00
      50005F0056004F0043004500010000000000200000004E0055004D005F004400
      450043005F0049004D0050005F0055004E0049005400010000000000}
    Left = 16
    Top = 8
    object selP030DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selP030DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selP030COD_VALUTA: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selP030DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
    end
    object selP030ABBREVIAZIONE: TStringField
      DisplayLabel = 'Abbreviazione'
      FieldName = 'ABBREVIAZIONE'
      Size = 3
    end
    object selP030NUM_DEC_IMP_VOCE: TIntegerField
      DisplayLabel = 'Nr. dec. min. imp. voce'
      FieldName = 'NUM_DEC_IMP_VOCE'
    end
    object selP030NUM_DEC_IMP_UNIT: TIntegerField
      DisplayLabel = 'Nr. dec. min. imp. unitario'
      FieldName = 'NUM_DEC_IMP_UNIT'
    end
  end
end
