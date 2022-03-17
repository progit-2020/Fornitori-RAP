object A057FSpostSquadraDtM1: TA057FSpostSquadraDtM1
  OldCreateOrder = True
  OnCreate = A057FSpostSquadraDtM1Create
  OnDestroy = A057FSpostSquadraDtM1Destroy
  Height = 89
  Width = 246
  object D630: TDataSource
    AutoEdit = False
    DataSet = Q630
    Left = 168
    Top = 8
  end
  object D600: TDataSource
    AutoEdit = False
    DataSet = Q600
    Left = 36
    Top = 8
  end
  object D020: TDataSource
    AutoEdit = False
    DataSet = Q020
    Left = 104
    Top = 8
  end
  object Q600: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T600_SQUADRE'
      'ORDER BY CODICE')
    Optimize = False
    Left = 8
    Top = 8
  end
  object Q020: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,MAX(DESCRIZIONE) DESCRIZIONE FROM T020_ORARI'
      'WHERE TIPOORA = '#39'E'#39
      'GROUP BY CODICE')
    Optimize = False
    Left = 76
    Top = 8
  end
  object Q630: TOracleDataSet
    SQL.Strings = (
      'SELECT T630.*,T630.ROWID FROM T630_SPOSTSQUADRA T630'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      'ORDER BY DATA,SQUADRA')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    ReadOnly = True
    CachedUpdates = True
    Left = 140
    Top = 8
    object Q630PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T630_SPOSTSQUADRA.PROGRESSIVO'
      Visible = False
    end
    object Q630DATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'T630_SPOSTSQUADRA.DATA'
      DisplayFormat = 'dd/mm/yyyy'
    end
    object Q630SQUADRA: TStringField
      FieldName = 'SQUADRA'
      Origin = 'T630_SPOSTSQUADRA.SQUADRA'
      Size = 5
    end
    object Q630ORARIO: TStringField
      FieldName = 'ORARIO'
      Origin = 'T630_SPOSTSQUADRA.ORARIO'
      Size = 5
    end
    object Q630TURNO1: TStringField
      DisplayWidth = 2
      FieldName = 'TURNO1'
      Origin = 'T630_SPOSTSQUADRA.TURNO1'
      Size = 2
    end
    object Q630TURNO2: TStringField
      DisplayWidth = 2
      FieldName = 'TURNO2'
      Origin = 'T630_SPOSTSQUADRA.TURNO2'
      Size = 2
    end
  end
end
