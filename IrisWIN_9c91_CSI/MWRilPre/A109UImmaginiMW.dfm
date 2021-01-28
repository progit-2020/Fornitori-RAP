inherited A109FimmaginiMW: TA109FimmaginiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object selT004: TOracleDataSet
    SQL.Strings = (
      'SELECT T.*,ROWID FROM T004_IMMAGINI T')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000080000005400490050004F00010000000000100000004900
      4D004D004100470049004E004500000000000000}
    Left = 12
    Top = 12
    object selT004TIPO: TStringField
      FieldName = 'TIPO'
      Required = True
      Size = 10
    end
    object selT004IMMAGINE: TBlobField
      FieldName = 'IMMAGINE'
      BlobType = ftOraBlob
    end
  end
end
