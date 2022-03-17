inherited S730FPunteggiValutazioniMW: TS730FPunteggiValutazioniMW
  OldCreateOrder = True
  Height = 245
  Width = 411
  object selSG730a: TOracleQuery
    SQL.Strings = (
      'select count(*) n_dec_intersecanti'
      'from   SG730_PUNTEGGI'
      'where  codice = :codice'
      'and    dato1 = :dato1'
      ':cond_rowid'
      'and    (   :decorrenza between decorrenza and decorrenza_fine'
      '        or :scadenza   between decorrenza and decorrenza_fine'
      
        '        or (:decorrenza < decorrenza and :scadenza > decorrenza_' +
        'fine))')
    Optimize = False
    Variables.Data = {
      0400000005000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000120000003A00530043004100440045004E00
      5A0041000C0000000000000000000000160000003A0043004F004E0044005F00
      52004F005700490044000100000000000000000000000C0000003A0044004100
      54004F0031000500000000000000000000000E0000003A0043004F0044004900
      43004500050000000000000000000000}
    Left = 32
    Top = 16
  end
  object selDato1: TOracleDataSet
    Optimize = False
    Left = 95
    Top = 16
  end
  object updSG730: TOracleQuery
    SQL.Strings = (
      'UPDATE SG730_PUNTEGGI'
      'SET CALCOLO_PFP = :CALCOLO_PFP,'
      '    PUNTEGGIO = DECODE(:CALCOLO_PFP,'#39'N'#39',NULL,PUNTEGGIO)'
      'WHERE DATO1 = :DATO1')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A004400410054004F0031000500000000000000
      00000000180000003A00430041004C0043004F004C004F005F00500046005000
      050000000000000000000000}
    Left = 32
    Top = 80
  end
  object dsrDato1: TDataSource
    DataSet = selDato1
    Left = 95
    Top = 80
  end
end
