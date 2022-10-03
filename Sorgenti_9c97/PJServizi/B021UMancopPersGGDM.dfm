inherited B021FMancopPersGGDM: TB021FMancopPersGGDM
  OldCreateOrder = True
  Height = 81
  Width = 331
  inherited selProg: TOracleQuery
    SQL.Strings = (
      'SELECT PROGRESSIVO, COGNOME, NOME'
      'FROM   T030_ANAGRAFICO '
      'WHERE  MATRICOLA = :MATRICOLA')
  end
  object selMancopPersGG: TOracleDataSet
    SQL.Strings = (
      
        'select MATRICOLA, UNITA_OPERATIVA, FIGURA, PROFILO, COMPETENZA, ' +
        'INIZIO, FINE '
      'from   USR_MANCOP_PERSGG'
      
        'order by COMPETENZA, MATRICOLA, UNITA_OPERATIVA, FIGURA, PROFILO' +
        ', INIZIO')
    ReadBuffer = 1000
    Optimize = False
    ReadOnly = True
    Left = 120
    Top = 17
  end
  object scrUSR_MCP_PERSGG: TOracleQuery
    SQL.Strings = (
      'begin'
      '  USR_MCP_PERSGG(:DATA);'
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
