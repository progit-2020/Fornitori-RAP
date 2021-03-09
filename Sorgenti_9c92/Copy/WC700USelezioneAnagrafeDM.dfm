inherited WC700FSelezioneAnagrafeDM: TWC700FSelezioneAnagrafeDM
  OldCreateOrder = True
  Height = 185
  Width = 341
  object selAnagrafe: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    AfterScroll = selAnagrafeAfterScroll
    Left = 188
    Top = 24
  end
  object dscAnagrafe: TDataSource
    DataSet = selAnagrafe
    Left = 20
    Top = 8
  end
  object selDistinct: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Left = 124
    Top = 16
  end
  object selT003Nome: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME '
      'FROM   T003_SELEZIONIANAGRAFE'
      'ORDER BY NOME')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = selT003NomeFilterRecord
    Left = 28
    Top = 92
  end
  object selT003: TOracleDataSet
    SQL.Strings = (
      'SELECT RIGA FROM T003_SELEZIONIANAGRAFE '
      'WHERE NOME = :NOME'
      'ORDER BY POSIZIONE')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 100
    Top = 92
  end
  object insT003: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T003_SELEZIONIANAGRAFE '
      ' (NOME,POSIZIONE,RIGA)'
      'VALUES'
      ' (:NOME,:POSIZIONE,:RIGA)')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A004E004F004D00450005000000000000000000
      0000140000003A0050004F00530049005A0049004F004E004500030000000000
      0000000000000A0000003A005200490047004100050000000000000000000000}
    Left = 232
    Top = 92
  end
  object delT003: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T003_SELEZIONIANAGRAFE WHERE NOME = :NOME')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 164
    Top = 92
  end
end
