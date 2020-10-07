object A078FRichiestaAssistenzaDTM1: TA078FRichiestaAssistenzaDTM1
  OldCreateOrder = True
  OnCreate = DtM1Create
  OnDestroy = DtM1Destroy
  Height = 198
  Width = 279
  object EsportaDipendente: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  ESPORTADIPENDENTE(:M, :DAL, :AL);'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000040000003A004D0005000000000000000000000008000000
      3A00440041004C000C0000000000000000000000060000003A0041004C000C00
      00000000000000000000}
    Left = 40
    Top = 8
  end
  object selVersion: TOracleQuery
    SQL.Strings = (
      'select BANNER'
      'from V$VERSION '
      'where BANNER like '#39'Oracle%'#39)
    Optimize = False
    Left = 36
    Top = 60
  end
  object SelTab: TOracleDataSet
    SQL.Strings = (
      '')
    Optimize = False
    Left = 120
    Top = 8
  end
  object SelPrimaryKey: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM('
      
        'SELECT T2.COLUMN_NAME NameKey, T1.TABLE_NAME TableName FROM USER' +
        '_CONSTRAINTS T1,USER_IND_COLUMNS T2, COLS'
      'WHERE CONSTRAINT_TYPE = '#39'P'#39' AND T1.TABLE_NAME = :NomeTab AND'
      
        #9'T1.CONSTRAINT_NAME = T2.INDEX_NAME AND cols.table_name=t1.table' +
        '_name AND cols.column_name=t2.column_name AND (Cols.Data_type='#39'V' +
        'ARCHAR2'#39
      
        #9'OR cols.column_name = '#39'PROGRESSIVO'#39') AND ((cols.column_name <> ' +
        #39'FLAG'#39') or (t1.table_name <> '#39'T100_TIMBRATURE'#39')) '
      
        #9'AND ((Cols.column_name <> '#39'VERSO'#39') or (cols.table_name <> '#39'T100' +
        '_TIMBRATURE'#39')) and ((Cols.Table_name <> '#39'T221_PROFILISETTIMANA'#39')' +
        ' or (Cols.Column_name <> '#39'PROGRESSIVO'#39')))')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004E004F004D00450054004100420005000000
      0D000000543433305F53544F5249434F0000000000}
    Left = 120
    Top = 56
  end
  object DtsI500: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM (SELECT NOMECAMPO FROM I500_DATILIBERI)')
    Optimize = False
    Left = 192
    Top = 8
    object DtsI500NOMECAMPO: TStringField
      FieldName = 'NOMECAMPO'
    end
  end
  object DtsT360T760: TOracleDataSet
    Optimize = False
    Left = 192
    Top = 56
  end
  object selI091: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      '  FROM MONDOEDP.I091_DATIENTE I091'
      ' WHERE I091.AZIENDA=:AZIENDA')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 37
    Top = 107
  end
end
