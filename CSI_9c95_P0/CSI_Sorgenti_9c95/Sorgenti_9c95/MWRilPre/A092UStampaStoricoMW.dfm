inherited A092FStampaStoricoMW: TA092FStampaStoricoMW
  Height = 77
  Width = 80
  object Q010S: TOracleDataSet
    SQL.Strings = (
      'select DISTINCT COLUMN_NAME,TABLE_NAME,NOME_LOGICO'
      'from cols, i010_campianagrafici'
      'where table_name in (:tabelle)'
      
        'and DECODE(TABLE_NAME,'#39'T430_STORICO'#39','#39'T430'#39' || COLUMN_NAME,'#39'P430' +
        #39' || COLUMN_NAME) = NOME_CAMPO'
      'and applicazione = :applicazione'
      'ORDER BY NOME_LOGICO')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0054004100420045004C004C00450001000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000}
    Left = 24
    Top = 12
  end
end
