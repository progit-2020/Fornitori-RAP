object R014FRestDM: TR014FRestDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 91
  Width = 135
  object selProg: TOracleQuery
    SQL.Strings = (
      'SELECT PROGRESSIVO , COGNOME, NOME'
      'FROM   T030_ANAGRAFICO '
      'WHERE  MATRICOLA = :MATRICOLA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004D00410054005200490043004F004C004100
      050000000000000000000000}
    Left = 40
    Top = 16
  end
end
