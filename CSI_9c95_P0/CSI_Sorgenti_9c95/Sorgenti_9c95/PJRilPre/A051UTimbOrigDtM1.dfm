object A051FTimbOrigDtM1: TA051FTimbOrigDtM1
  OldCreateOrder = True
  OnCreate = A051FTimbOrigDtM1Create
  OnDestroy = A051FTimbOrigDtM1Destroy
  Height = 72
  Width = 253
  object D010: TDataSource
    Left = 16
    Top = 8
  end
  object QTimbrature: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM   T100_TIMBRATURE T100'
      'WHERE  PROGRESSIVO = :PROGRESSIVO '
      'AND    DATA BETWEEN :DATAI AND :DATAF '
      'AND    FLAG IN (:FLAG)'
      'ORDER BY DATA,ORA,VERSO')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041004900
      0C00000000000000000000000C0000003A00440041005400410046000C000000
      00000000000000000A0000003A0046004C004100470001000000000000000000
      0000}
    Left = 92
    Top = 8
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 164
    Top = 8
  end
end
