object Ac06FPianifPrioritaChiamataDM: TAc06FPianifPrioritaChiamataDM
  OldCreateOrder = True
  OnCreate = Ac06FPianifPrioritaChiamataDMCreate
  OnDestroy = Ac06FPianifPrioritaChiamataDMDestroy
  Height = 78
  Width = 110
  object dsrT381: TDataSource
    AutoEdit = False
    DataSet = selT381
    Left = 60
    Top = 12
  end
  object selT381: TOracleDataSet
    SQL.Strings = (
      'SELECT T381.*, T381.ROWID '
      '  FROM T381_PIANIF_PRIORITACHIAMATA T381'
      ' WHERE PROGRESSIVO = :PROGRESSIVO'
      ' ORDER BY DATA DESC')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    CompressBLOBs = True
    Left = 16
    Top = 12
    object selT381PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T620_TURNAZIND.PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selT381DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Origin = 'T620_TURNAZIND.DATA'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT381PRIORITA: TIntegerField
      DisplayLabel = 'Priorit'#224
      DisplayWidth = 2
      FieldName = 'PRIORITA'
    end
  end
end
