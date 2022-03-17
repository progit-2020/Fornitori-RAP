inherited A066FValutaStrMW: TA066FValutaStrMW
  OldCreateOrder = True
  Height = 299
  Width = 530
  object QFasce: TOracleDataSet
    SQL.Strings = (
      'select distinct MAGGIORAZIONE '
      'from   T210_MAGGIORAZIONI'
      'order by 1')
    Optimize = False
    Left = 71
    Top = 28
  end
  object QLookup: TOracleDataSet
    Optimize = False
    Left = 68
    Top = 76
  end
  object selLivello: TOracleDataSet
    ReadBuffer = 50
    Optimize = False
    Left = 199
    Top = 12
  end
  object dsrLivello: TDataSource
    DataSet = selLivello
    Left = 248
    Top = 12
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      
        'select '#39'#LIQ#'#39' CODICE, '#39'Causale per liquidazione'#39' DESCRIZIONE, 1' +
        ' ORDINAMENTO'
      'from   dual'
      'union all'
      
        'select '#39'#B.O#'#39' CODICE, '#39'Banca ore maturata'#39' DESCRIZIONE, 2 ORDIN' +
        'AMENTO'
      'from   dual'
      'union all'
      'select CODICE, DESCRIZIONE, 3'
      'from   T275_CAUPRESENZE'
      'order by 3, 1')
    ReadBuffer = 200
    Optimize = False
    AfterOpen = selT275AfterOpen
    Left = 199
    Top = 76
  end
  object dsrT275: TDataSource
    DataSet = selT275
    Left = 248
    Top = 76
  end
end
