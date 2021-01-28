object A012FCalendariDtM1: TA012FCalendariDtM1
  OldCreateOrder = True
  OnCreate = A004FCalendariDtM1Create
  OnDestroy = A012FCalendariDtM1Destroy
  Height = 137
  Width = 356
  object Q010: TOracleDataSet
    SQL.Strings = (
      'select T010.*, T010.ROWID '
      '  from T010_CALENDIMPOSTAZ T010'
      ' order by T010.CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    Filtered = True
    AfterInsert = Q010AfterInsert
    BeforePost = Q010BeforePost
    AfterPost = Q010AfterPost
    AfterCancel = Q010AfterCancel
    BeforeDelete = Q010BeforeDelete
    AfterDelete = Q010AfterDelete
    AfterScroll = Q010AfterScroll
    OnFilterRecord = Q010FilterRecord
    Left = 8
    Top = 4
    object Q010CODICE: TStringField
      FieldName = 'CODICE'
      Size = 5
    end
    object Q010DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q010LUNEDI: TStringField
      FieldName = 'LUNEDI'
      Size = 1
    end
    object Q010MARTEDI: TStringField
      FieldName = 'MARTEDI'
      Size = 1
    end
    object Q010MERCOLEDI: TStringField
      FieldName = 'MERCOLEDI'
      Size = 1
    end
    object Q010GIOVEDI: TStringField
      FieldName = 'GIOVEDI'
      Size = 1
    end
    object Q010VENERDI: TStringField
      FieldName = 'VENERDI'
      Size = 1
    end
    object Q010SABATO: TStringField
      FieldName = 'SABATO'
      Size = 1
    end
    object Q010DOMENICA: TStringField
      FieldName = 'DOMENICA'
      Size = 1
    end
    object Q010IGNORAFESTIVITA: TStringField
      FieldName = 'IGNORAFEST_AUTO'
      Size = 1
    end
    object Q010NUMGG_LAV: TIntegerField
      FieldName = 'NUMGG_LAV'
      OnValidate = Q010NUMGG_LAVValidate
    end
  end
  object Q011: TOracleDataSet
    SQL.Strings = (
      'SELECT T011.*,T011.ROWID FROM T011_CALENDARI T011'
      '  WHERE CODICE = :Codice'
      '  AND DATA BETWEEN :DAL AND :AL'
      '  ORDER BY DATA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000080000003A00440041004C000C00000000000000000000000600
      00003A0041004C000C0000000000000000000000}
    BeforePost = Q011BeforePost
    Left = 48
    Top = 4
  end
  object CancQ011: TOracleQuery
    SQL.Strings = (
      'begin'
      '  DELETE FROM T011_CALENDARI WHERE CODICE = :Codice;'
      '  DELETE FROM T013_FESTIVITA_AGGIUNTIVE where CODICE = :CODICE;'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 160
    Top = 4
  end
  object GeneraCal: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  GENERACALENDARIO.GENERACAL(:COD, :DAL, :AL, '#39'S'#39');'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000080000003A0043004F004400050000000000000000000000
      080000003A00440041004C000C0000000000000000000000060000003A004100
      4C000C0000000000000000000000}
    Left = 276
    Top = 4
  end
  object UpdQ011: TOracleQuery
    SQL.Strings = (
      'UPDATE T011_CALENDARI SET'
      'CODICE = :NEWCODICE WHERE CODICE = :OLDCODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A004E004500570043004F004400490043004500
      050000000000000000000000140000003A004F004C00440043004F0044004900
      43004500050000000000000000000000}
    Left = 212
    Top = 4
  end
  object selT013: TOracleDataSet
    SQL.Strings = (
      'SELECT T013.*,T013.ROWID FROM T013_FESTIVITA_AGGIUNTIVE T013'
      '  WHERE CODICE = :Codice'
      '  ORDER BY ANNO,MESE,GIORNO')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    AutoCalcFields = False
    CachedUpdates = True
    BeforePost = selT013BeforePost
    Left = 104
    Top = 4
    object selT013CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selT013ANNO: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 6
      FieldName = 'ANNO'
      MaxValue = 3999
    end
    object selT013MESE: TIntegerField
      DisplayLabel = 'Mese'
      DisplayWidth = 6
      FieldName = 'MESE'
      MaxValue = 12
      MinValue = 1
    end
    object selT013GIORNO: TIntegerField
      DisplayLabel = 'Giorno'
      DisplayWidth = 6
      FieldName = 'GIORNO'
      MaxValue = 31
      MinValue = 1
    end
  end
  object dsrT013: TDataSource
    DataSet = selT013
    Left = 104
    Top = 56
  end
end
