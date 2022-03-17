inherited A146FFotoDipendenteDtM: TA146FFotoDipendenteDtM
  OldCreateOrder = True
  object selT032: TOracleDataSet
    SQL.Strings = (
      'SELECT T032.*, T032.ROWID '
      '  FROM T032_FOTODIPENDENTE T032'
      ' WHERE T032.PROGRESSIVO = :PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = selT032BeforePost
    OnNewRecord = selT032NewRecord
    Left = 32
    Top = 8
    object selT032PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
    end
    object selT032FOTO: TBlobField
      FieldName = 'FOTO'
      BlobType = ftOraBlob
    end
    object selT032FILE_FOTO: TStringField
      FieldName = 'FILE_FOTO'
      Size = 200
    end
  end
  object DT032: TDataSource
    DataSet = selT032
    Left = 80
    Top = 8
  end
end
