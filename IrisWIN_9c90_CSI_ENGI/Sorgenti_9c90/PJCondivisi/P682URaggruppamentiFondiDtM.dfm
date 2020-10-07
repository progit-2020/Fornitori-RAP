inherited P682FRaggruppamentiFondiDtM: TP682FRaggruppamentiFondiDtM
  OldCreateOrder = True
  Height = 208
  Width = 291
  object selP682: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from P682_FONDIRAGGR t'
      'order by cod_raggr')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      040000000200000009000000434F445F52414747520100000000000B00000044
      45534352495A494F4E45010000000000}
    Left = 24
    Top = 16
    object selP682COD_RAGGR: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_RAGGR'
      Required = True
      Size = 10
    end
    object selP682DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 70
      FieldName = 'DESCRIZIONE'
      Size = 500
    end
  end
end
