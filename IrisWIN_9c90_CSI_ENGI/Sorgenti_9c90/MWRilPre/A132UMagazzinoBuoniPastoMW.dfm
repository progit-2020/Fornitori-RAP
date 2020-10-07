inherited A132FMagazzinoBuoniPastoMW: TA132FMagazzinoBuoniPastoMW
  OldCreateOrder = True
  Height = 100
  Width = 197
  object selT691_ID: TOracleDataSet
    SQL.Strings = (
      'select data_acquisto, data_scadenza'
      'from T691_MAGAZZINOBUONI'
      'where id_dal is not null '
      'and id_al is not null'
      'and :id_dal <= id_al'
      'and :id_al >= id_dal'
      'and (:idriga is null or rowid <> :idriga)')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A00490044005F00440041004C00030000000000
      0000000000000C0000003A00490044005F0041004C0003000000000000000000
      00000E0000003A00490044005200490047004100050000000000000000000000}
    Left = 136
    Top = 8
  end
  object selaT691: TOracleDataSet
    SQL.Strings = (
      
        'select data_scadenza, sum(buonipasto) tot_buonipasto, sum(ticket' +
        ') tot_ticket'
      'from T691_MAGAZZINOBUONI'
      'where data_acquisto between :data_acquisto1 and :data_acquisto2'
      'group by data_scadenza')
    Optimize = False
    Variables.Data = {
      04000000020000001E0000003A0044004100540041005F004100430051005500
      4900530054004F0031000C00000000000000000000001E0000003A0044004100
      540041005F0041004300510055004900530054004F0032000C00000000000000
      00000000}
    Left = 80
    Top = 8
  end
  object selT690: TOracleDataSet
    SQL.Strings = (
      
        'select t691.data_scadenza,sum(t690.buonipasto) tot_buonipasto,su' +
        'm(t690.ticket) tot_ticket '
      'from t690_acquistobuoni t690, t691_magazzinobuoni t691'
      'where t691.data_scadenza = :data_scadenza'
      
        'and t691.data_acquisto >= nvl(:dal,to_date('#39'01011900'#39','#39'ddmmyyyy'#39 +
        '))'
      'and t691.data_acquisto = nvl(:data_fornitura,t691.data_acquisto)'
      'and t691.data_acquisto = t690.data_magazzino'
      
        'and t690.data <= decode(:data_fornitura,null,:data_acquisto,to_d' +
        'ate('#39'31123999'#39','#39'ddmmyyyy'#39'))'
      'group by t691.data_scadenza')
    Optimize = False
    Variables.Data = {
      04000000040000001C0000003A0044004100540041005F005300430041004400
      45004E005A0041000C00000000000000000000001C0000003A00440041005400
      41005F0041004300510055004900530054004F000C0000000000000000000000
      1E0000003A0044004100540041005F0046004F0052004E004900540055005200
      41000C0000000000000000000000080000003A00440041004C000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    Left = 24
    Top = 8
  end
end
