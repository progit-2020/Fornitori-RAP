inherited B022FUtilityGestDocumentaleMW: TB022FUtilityGestDocumentaleMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 238
  Width = 254
  object seqT960: TOracleQuery
    SQL.Strings = (
      'select T960_ID.nextval ID'
      'from dual')
    Optimize = False
    Left = 24
    Top = 16
  end
  object insT960: TOracleQuery
    SQL.Strings = (
      
        'insert into T960_DOCUMENTI_INFO(ID,                             ' +
        '   '
      '                                NOME_UTENTE,'
      '                                UTENTE,'
      '                                PROGRESSIVO,'
      '                                TIPOLOGIA,'
      '                                UFFICIO,'
      '                                NOME_FILE,'
      '                                EXT_FILE,'
      '                                DIMENSIONE,'
      '                                PERIODO_DAL,'
      '                                PERIODO_AL,'
      '                                NOTE,'
      
        '                                PATH_STORAGE,                   ' +
        '             '
      '                                ACCESSO_PORTALE)'
      'values('
      '  :ID,'
      '  :NOME_UTENTE,'
      '  :UTENTE,'
      '  :PROGRESSIVO,'
      '  :TIPOLOGIA,'
      '  :UFFICIO,'
      '  :NOME_FILE,'
      '  :EXT_FILE,'
      '  :DIMENSIONE,'
      '  :PERIODO_DAL,'
      '  :PERIODO_AL,'
      '  :NOTE,'
      '  :PATH_STORAGE,'
      '  :ACCESSO_PORTALE'
      ')')
    Optimize = False
    Variables.Data = {
      040000000E000000060000003A00490044000300000000000000000000001800
      00003A004E004F004D0045005F005500540045004E0054004500050000000000
      0000000000000E0000003A005500540045004E00540045000500000000000000
      00000000180000003A00500052004F0047005200450053005300490056004F00
      030000000000000000000000140000003A005400490050004F004C004F004700
      49004100050000000000000000000000100000003A0055004600460049004300
      49004F00050000000000000000000000140000003A004E004F004D0045005F00
      460049004C004500050000000000000000000000120000003A00450058005400
      5F00460049004C004500050000000000000000000000160000003A0044004900
      4D0045004E00530049004F004E00450003000000000000000000000018000000
      3A0050004500520049004F0044004F005F00440041004C000100000000000000
      00000000160000003A0050004500520049004F0044004F005F0041004C000100
      000000000000000000000A0000003A004E004F00540045000500000000000000
      000000001A0000003A0050004100540048005F00530054004F00520041004700
      4500050000000000000000000000200000003A00410043004300450053005300
      4F005F0050004F005200540041004C004500050000000000000000000000}
    Left = 88
    Top = 16
  end
  object selT960ByProgTipol: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.ROWID'
      'from T960_DOCUMENTI_INFO T'
      'where PROGRESSIVO = :PROGRESSIVO and TIPOLOGIA = :TIPOLOGIA')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A005400490050004F004C00
      4F00470049004100050000000000000000000000}
    Left = 160
    Top = 16
  end
  object selT962: TOracleDataSet
    SQL.Strings = (
      'select T962.CODICE, T962.DESCRIZIONE, T962.CODICE_DEFAULT'
      'from   T962_TIPO_DOCUMENTI T962'
      'order by T962.DESCRIZIONE')
    ReadBuffer = 100
    Optimize = False
    Left = 23
    Top = 96
  end
  object dsrT962: TDataSource
    DataSet = selT962
    Left = 95
    Top = 96
  end
  object selT963: TOracleDataSet
    SQL.Strings = (
      'select T963.CODICE, T963.DESCRIZIONE, T963.CODICE_DEFAULT'
      'from   T963_UFFICIO_DOCUMENTI T963'
      'order by T963.DESCRIZIONE')
    ReadBuffer = 100
    Optimize = False
    Left = 23
    Top = 160
  end
  object dsrT963: TDataSource
    DataSet = selT963
    Left = 95
    Top = 160
  end
end
