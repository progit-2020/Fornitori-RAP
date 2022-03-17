object WR000FBaseDM: TWR000FBaseDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 431
  Width = 486
  object selaT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME FROM T033_LAYOUT')
    Optimize = False
    Left = 252
    Top = 8
  end
  object selT432: TOracleDataSet
    SQL.Strings = (
      'select T.*,ROWID '
      'from   T432_DATALAVORO T '
      'where  UTENTE = :UTENTE'
      '')
    ReadBuffer = 1
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 202
    Top = 8
  end
  object selAnagrafe: TOracleDataSet
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0044004100540041004C00410056004F005200
      4F000C00000000000000000000000E0000003A00460049004C00540052004F00
      010000000000000000000000}
    AfterOpen = selAnagrafeAfterOpen
    Left = 27
    Top = 9
  end
  object cdsAnagrafe: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 27
    Top = 56
  end
  object cdsI010: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 152
    Top = 55
  end
  object dsrAnagrafe: TDataSource
    AutoEdit = False
    DataSet = cdsAnagrafe
    Left = 26
    Top = 104
  end
  object selI015: TOracleDataSet
    SQL.Strings = (
      'select I015.* '
      'from   MONDOEDP.I015_TRADUZIONI_CAPTION I015'
      'where  I015.AZIENDA = :AZIENDA '
      'and    I015.LINGUA = :LINGUA'
      'and    I015.APPLICAZIONE = :APPLICAZIONE'
      'order by I015.MASCHERA, I015.COMPONENTE')
    ReadBuffer = 60
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A004C0049004E00470055004100050000000000
      0000000000001A0000003A004100500050004C004900430041005A0049004F00
      4E004500050000000000000000000000100000003A0041005A00490045004E00
      44004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    Left = 92
    Top = 8
  end
  object cdsI015: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 92
    Top = 55
  end
  object selI076: TOracleDataSet
    SQL.Strings = (
      'select TAG, IP, IP_ESTERNO, CONSENTITO'
      'from   MONDOEDP.I076_REGOLE_ACCESSO'
      'where  AZIENDA = :AZIENDA'
      'and    PROFILO = :PROFILO'
      '--and    APPLICAZIONE = :APPLICAZIONE'
      'order by TAG')
    ReadBuffer = 500
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000}
    ReadOnly = True
    Left = 208
    Top = 112
  end
end
