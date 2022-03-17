inherited B021FMancopPersMMDM: TB021FMancopPersMMDM
  OldCreateOrder = True
  Height = 81
  Width = 323
  object selMancopPersMM: TOracleDataSet
    SQL.Strings = (
      'select MATRICOLA, INIZIO, REPARTO, GGMALA, TIPOLOGIA'
      'from   USR_MANCOP_PERSMM where MESE_RIF = :DATA'
      'order by MATRICOLA,TIPOLOGIA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    ReadOnly = True
    Left = 120
    Top = 17
  end
  object scrUSR_MCP_PERSMM: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_MCP_PERSMM(:DATA);'
      'end;')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    Left = 232
    Top = 16
  end
end
