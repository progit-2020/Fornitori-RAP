object C700FSelezioneAnagrafeDtM: TC700FSelezioneAnagrafeDtM
  OldCreateOrder = True
  OnCreate = DataModule2Create
  OnDestroy = DataModuleDestroy
  Height = 136
  Width = 328
  object dscAnagrafe: TDataSource
    DataSet = selAnagrafe
    Left = 20
    Top = 8
  end
  object selAnagrafe: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000}
    AfterOpen = selAnagrafeAfterOpen
    AfterScroll = selAnagrafeAfterScroll
    Left = 212
    Top = 8
  end
  object selT003Nome: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME '
      'FROM   T003_SELEZIONIANAGRAFE'
      'ORDER BY NOME')
    ReadBuffer = 100
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 20
    Top = 52
  end
  object delT003: TOracleQuery
    SQL.Strings = (
      'DELETE FROM T003_SELEZIONIANAGRAFE WHERE NOME = :NOME')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 124
    Top = 52
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
    Left = 168
    Top = 52
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
    Left = 76
    Top = 52
  end
  object selDistinct: TOracleDataSet
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000}
    Left = 276
    Top = 8
  end
  object selbT033: TOracleDataSet
    SQL.Strings = (
      'SELECT decode(CAMPODB,'
      '              '#39'D_Comune'#39','#39'COMUNE'#39','
      '              '#39'D_COMUNE_DOM_BASE'#39','#39'COMUNE_DOM_BASE'#39','
      '              '#39'DescComune'#39','#39'CITTA'#39','
      '              '#39'D_ProvinciaNas'#39','#39'PROVINCIA'#39','
      '              '#39'D_Provincia'#39','#39'PROVINCIA'#39','
      '              '#39'D_PROVINCIA_DOM_BASE'#39','#39'PROVINCIA_DOM_BASE'#39','
      
        'CAMPODB) CAMPODB FROM T033_LAYOUT WHERE NOME = :Nome AND ACCESSO' +
        ' <> '#39'N'#39)
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 217
    Top = 51
  end
end
