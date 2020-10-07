inherited A079FAssenzeAutoMW: TA079FAssenzeAutoMW
  OldCreateOrder = True
  Height = 73
  Width = 129
  object AssenzeAuto: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  ASSENZEAUTO(:PROG, :DAL, :AL);'
      'END;')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A00500052004F00470003000000000000000000
      0000080000003A00440041004C000C0000000000000000000000060000003A00
      41004C000C0000000000000000000000}
    Left = 52
    Top = 10
  end
end
