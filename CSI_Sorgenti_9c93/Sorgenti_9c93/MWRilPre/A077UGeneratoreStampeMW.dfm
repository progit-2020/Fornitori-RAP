inherited A077FGeneratoreStampeMW: TA077FGeneratoreStampeMW
  Height = 495
  Width = 677
  object Ins920_1: TOracleQuery
    Optimize = False
    Left = 20
    Top = 331
  end
  object Ins920_2: TOracleQuery
    Optimize = False
    Left = 80
    Top = 331
  end
  object Ins920_3: TOracleQuery
    Optimize = False
    Left = 140
    Top = 331
  end
  object Ins920_4: TOracleQuery
    Optimize = False
    Left = 200
    Top = 331
  end
  object Ins920_5: TOracleQuery
    Optimize = False
    Left = 260
    Top = 331
  end
  object Ins920_6: TOracleQuery
    Optimize = False
    Left = 324
    Top = 331
  end
  object Ins920_7: TOracleQuery
    Optimize = False
    Left = 384
    Top = 331
  end
  object Ins920_8: TOracleQuery
    Optimize = False
    Left = 452
    Top = 331
  end
  object Ins920_9: TOracleQuery
    Optimize = False
    Left = 512
    Top = 331
  end
  object Ins920_10: TOracleQuery
    Optimize = False
    Left = 576
    Top = 331
  end
  object Ins920_11: TOracleQuery
    Optimize = False
    Left = 20
    Top = 387
  end
  object Ins920_12: TOracleQuery
    Optimize = False
    Left = 80
    Top = 387
  end
  object Ins920_13: TOracleQuery
    Optimize = False
    Left = 140
    Top = 387
  end
  object Ins920_14: TOracleQuery
    Optimize = False
    Left = 200
    Top = 387
  end
  object Ins920_15: TOracleQuery
    Optimize = False
    Left = 260
    Top = 387
  end
  object Ins920_16: TOracleQuery
    Optimize = False
    Left = 321
    Top = 387
  end
  object Ins920_17: TOracleQuery
    Optimize = False
    Left = 385
    Top = 387
  end
  object Ins920_18: TOracleQuery
    Optimize = False
    Left = 449
    Top = 387
  end
  object Ins920_19: TOracleQuery
    Optimize = False
    Left = 513
    Top = 387
  end
  object Ins920_20: TOracleQuery
    Optimize = False
    Left = 577
    Top = 387
  end
  object Ins920_21: TOracleQuery
    Optimize = False
    Left = 17
    Top = 443
  end
  object Ins920_22: TOracleQuery
    Optimize = False
    Left = 81
    Top = 443
  end
  object Ins920_23: TOracleQuery
    Optimize = False
    Left = 136
    Top = 443
  end
  object Ins920_24: TOracleQuery
    Optimize = False
    Left = 200
    Top = 443
  end
  object Ins920_25: TOracleQuery
    Optimize = False
    Left = 256
    Top = 443
  end
  object selT162: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T162_INDENNITA'
      'ORDER BY CODICE')
    Optimize = False
    Left = 116
    Top = 156
  end
  object selM020: TOracleDataSet
    SQL.Strings = (
      'select '#39'A'#39'TIPO,CODICE,DESCRIZIONE from M020_TIPIRIMBORSI'
      'union'
      
        'select '#39'B'#39',CODICE,DESCRIZIONE from M021_TIPIINDENNITAKM where DE' +
        'CORRENZA_FINE = to_date('#39'31123999'#39','#39'DDMMYYYY'#39')'
      'order by TIPO,CODICE')
    Optimize = False
    Left = 21
    Top = 281
  end
  object seldistT195: TOracleDataSet
    SQL.Strings = (
      
        'SELECT nvl(VOCE_PAGHE_CEDOLINO,VOCE_PAGHE) VOCEPAGHE from T193_V' +
        'OCIPAGHE_PARAMETRI where nvl(VOCE_PAGHE_CEDOLINO,VOCE_PAGHE) is ' +
        'not null'
      'union'
      
        'SELECT VOCE_PAGHE_NEGATIVA from T193_VOCIPAGHE_PARAMETRI where V' +
        'OCE_PAGHE_NEGATIVA is not null'
      'order by 1')
    ReadBuffer = 50
    Optimize = False
    Left = 85
    Top = 281
  end
  object selT240: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T240_ORGANIZZAZIONISINDACALI T240'
      
        'WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T240_ORGANIZZAZI' +
        'ONISINDACALI WHERE CODICE = T240.CODICE)'
      'ORDER BY CODICE')
    ReadBuffer = 50
    Optimize = False
    Left = 138
    Top = 281
  end
  object selSG650: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  CODICE||'#39'#'#39'||EDIZIONE CODICE,'
      
        '  '#39'('#39'||TO_CHAR(DATA_INIZIO,'#39'DD/MM/YY'#39')||'#39') '#39'||TITOLO_CORSO DESCR' +
        'IZIONE,'
      '  DATA_INIZIO'
      'FROM SG650_TESTATACORSI '
      'ORDER BY CODICE,EDIZIONE')
    ReadBuffer = 1000
    Optimize = False
    Left = 197
    Top = 283
  end
  object selT241: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT DECODE(TIPO_RECAPITO,'#39'A'#39','#39'Aziendale'#39','#39'N'#39','#39'Nazion' +
        'ale'#39','#39'G'#39','#39'Generico'#39','#39'P'#39','#39'Provinciale'#39','#39'R'#39','#39'Regionale'#39',TIPO_RECAP' +
        'ITO) RECAPITO '
      'FROM T241_RECAPITISINDACATI'
      'ORDER BY 1')
    ReadBuffer = 10
    Optimize = False
    Left = 192
    Top = 157
  end
  object Ins920_26: TOracleQuery
    Optimize = False
    Left = 320
    Top = 443
  end
end
