inherited Ac10FFestivitaParticolariMW: TAc10FFestivitaParticolariMW
  OldCreateOrder = True
  Height = 205
  Width = 342
  object selT265: TOracleDataSet
    SQL.Strings = (
      'select T265.CODICE, T265.DESCRIZIONE'
      '  from T265_CAUASSENZE T265'
      ' where T265.UM_INSERIMENTO = '#39'S'#39
      '       :FILTROCAUS'
      ' order by T265.CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A00460049004C00540052004F00430041005500
      5300010000000000000000000000}
    Left = 24
    Top = 8
  end
  object dsrSelT265: TDataSource
    DataSet = selT265
    Left = 24
    Top = 56
  end
  object selT265_All: TOracleDataSet
    SQL.Strings = (
      'select T265.CODICE, T265.DESCRIZIONE'
      '  from T265_CAUASSENZE T265'
      ' where T265.UM_INSERIMENTO = '#39'S'#39
      '       :FILTROCAUS'
      ' order by T265.CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A00460049004C00540052004F00430041005500
      5300010000000000000000000000}
    Left = 88
    Top = 8
  end
  object dsrSelT265_All: TDataSource
    DataSet = selT265_All
    Left = 88
    Top = 56
  end
end
