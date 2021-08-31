object A037FScaricoPagheDtM1: TA037FScaricoPagheDtM1
  OldCreateOrder = True
  OnCreate = A037FScaricoPagheDtM1Create
  OnDestroy = A037FScaricoPagheDtM1Destroy
  Height = 346
  Width = 693
  object DI010: TDataSource
    Left = 5
    Top = 4
  end
  object QEnte: TOracleDataSet
    Optimize = False
    Left = 217
    Top = 4
  end
  object Q210: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT T210.Codice,T210.Maggiorazione, T210.PStr_Nel_Me' +
        'se'
      'FROM T210_Maggiorazioni T210, T201_Maggiorazioni T201'
      
        'WHERE (T210.Codice = T201.Maggior1 OR T210.Codice = T201.Maggior' +
        '2 OR '
      
        '  T210.Codice = T201.Maggior3 OR T210.Codice = T201.Maggior4) AN' +
        'D'
      'T201.Codice = :Codice'
      'ORDER BY T210.Maggiorazione,T210.Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 137
    Top = 52
  end
end
