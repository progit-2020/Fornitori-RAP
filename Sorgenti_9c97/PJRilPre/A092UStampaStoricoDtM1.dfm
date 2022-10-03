object A092FStampaStoricoDtM1: TA092FStampaStoricoDtM1
  OldCreateOrder = True
  OnCreate = A092FStampaStoricoDtM1Create
  OnDestroy = A092FStampaStoricoDtM1Destroy
  Height = 88
  Width = 180
  object Q430: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM V430_STORICO'
      'WHERE T430PROGRESSIVO = :Prog '
      'ORDER BY T430DATADECORRENZA   ')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A00500052004F00470003000000000000000000
      0000}
    Left = 28
    Top = 12
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 100
    Top = 12
  end
end
