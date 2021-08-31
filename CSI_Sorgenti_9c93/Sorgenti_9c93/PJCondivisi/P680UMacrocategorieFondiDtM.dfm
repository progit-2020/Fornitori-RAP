inherited P680FMacrocategorieFondiDtM: TP680FMacrocategorieFondiDtM
  OldCreateOrder = True
  Height = 202
  Width = 236
  object selP680: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from P680_FONDIMACROCATEG t'
      'order by cod_macrocateg')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001C00000043004F0044005F004D004100430052004F004300
      4100540045004700010000000000160000004400450053004300520049005A00
      49004F004E004500010000000000}
    Left = 32
    Top = 24
    object selP680COD_MACROCATEG: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_MACROCATEG'
      Required = True
      Size = 5
    end
    object selP680DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 50
    end
  end
end
