inherited S715FStampaValutazioniMW: TS715FStampaValutazioniMW
  OldCreateOrder = True
  Height = 336
  Width = 786
  object selSG746: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT CODREGOLA, CODICE, DESCRIZIONE :CAMPI_AGG'
      'FROM SG746_STATI_AVANZAMENTO'
      
        'WHERE NVL(:DATARIF,DECORRENZA) BETWEEN DECORRENZA AND DECORRENZA' +
        '_FINE'
      'ORDER BY CODREGOLA, CODICE, DESCRIZIONE')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0044004100540041005200490046000C000000
      0000000000000000140000003A00430041004D00500049005F00410047004700
      010000000000000000000000}
    Left = 616
    Top = 16
  end
  object selSG750: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM SG750_PARPROTOCOLLO'
      'WHERE (CODICE = :CODICE OR :CODICE IS NULL)'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 664
    Top = 16
  end
  object selSG751: TOracleDataSet
    SQL.Strings = (
      'SELECT *'
      'FROM SG751_PARPROTOCOLLODATI'
      'WHERE (CODICE = :CODICE OR :CODICE IS NULL)'
      'ORDER BY CODICE, ORDINE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 712
    Top = 16
  end
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select * from t765_tipoquote T765'
      'where tipoquota in ('#39'I'#39','#39'V'#39','#39'C'#39','#39'D'#39')'
      '  and decorrenza = (select max(decorrenza) from t765_tipoquote'
      '                     where codice = T765.codice)'
      'order by codice'
      '')
    Optimize = False
    Left = 111
    Top = 208
  end
end
