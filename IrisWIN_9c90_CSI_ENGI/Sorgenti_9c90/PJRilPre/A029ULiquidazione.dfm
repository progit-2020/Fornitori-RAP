object A029FLiquidazione: TA029FLiquidazione
  OldCreateOrder = True
  OnCreate = A029FLiquidazioneCreate
  OnDestroy = A029FLiquidazioneDestroy
  Height = 97
  Width = 216
  object Q071Liq: TOracleDataSet
    SQL.Strings = (
      
        'SELECT PROGRESSIVO,DATA,MAGGIORAZIONE,CODFASCIA,ORESTRAORDLIQ,LI' +
        'QUIDNELMESE,ROWID'
      '  FROM T071_SCHEDAFASCE WHERE '
      '  PROGRESSIVO = :Progressivo AND'
      '  DATA = :Data AND'
      '  MAGGIORAZIONE = :Maggiorazione AND'
      '  CODFASCIA = :CodFascia'
      '  ORDER BY MAGGIORAZIONE,CODFASCIA')
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      000000000000000000001C0000003A004D0041004700470049004F0052004100
      5A0049004F004E004500040000000000000000000000140000003A0043004F00
      4400460041005300430049004100050000000000000000000000}
    CachedUpdates = True
    Left = 16
    Top = 12
    object Q071LiqPROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object Q071LiqDATA: TDateTimeField
      FieldName = 'DATA'
    end
    object Q071LiqMAGGIORAZIONE: TFloatField
      DisplayLabel = '% Magg.'
      DisplayWidth = 2
      FieldName = 'MAGGIORAZIONE'
    end
    object Q071LiqCODFASCIA: TStringField
      FieldName = 'CODFASCIA'
      Size = 5
    end
    object Q071LiqORESTRAORDLIQ: TStringField
      FieldName = 'ORESTRAORDLIQ'
      Size = 6
    end
    object Q071LiqLIQUIDNELMESE: TStringField
      FieldName = 'LIQUIDNELMESE'
      Size = 6
    end
  end
  object Q130: TOracleDataSet
    SQL.Strings = (
      
        'SELECT PROGRESSIVO,ANNO,SALDOORELAV,ORECOMPENSABILI,BANCA_ORE,RO' +
        'WID '
      'FROM T130_RESIDANNOPREC '
      'WHERE '
      'PROGRESSIVO = :PROGRESSIVO AND'
      'ANNO = :ANNO')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0041004E004E004F000300
      00000000000000000000}
    CachedUpdates = True
    Left = 64
    Top = 12
  end
  object selLiquidato: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  SELECT NVL(SUM(OREMINUTI(ORECOMP_LIQUIDATE) + OREMINUTI(BANCAO' +
        'RE_LIQ_VAR)),0) INTO :COMPLIQUIDATOANNO'
      '  FROM T070_SCHEDARIEPIL'
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DATA1 AND :DATA2;'
      ''
      
        '  SELECT NVL(SUM(OREMINUTI(LIQUIDNELMESE)),0) INTO :LIQUIDATOANN' +
        'O'
      '  FROM T071_SCHEDAFASCE'
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DATA1 AND :DATA2;'
      ''
      
        '  SELECT NVL(SUM(OREMINUTI(LIQUIDNELMESE)),0) INTO :LIQUIDATOMES' +
        'E'
      '  FROM T071_SCHEDAFASCE'
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA;'
      ''
      '  SELECT /*NVL(SUM(OREMINUTI(LIQUIDATO)),0)*/'
      
        '         NVL(SUM(OREMINUTI(DECODE(ORENORMALI||ABBATTE_BUDGET,'#39'AM' +
        #39',OREPRESENZA,LIQUIDATO))),0)'
      '  INTO :CAUSLIQUIDATOANNO'
      '  FROM T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275'
      '  WHERE '
      '  T074.CAUSALE = T275.CODICE AND'
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DATA1 AND :DATA2 AND'
      
        '  (ORENORMALI IN ('#39'B'#39','#39'D'#39') OR ORENORMALI = '#39'A'#39' AND ABBATTE_BUDGE' +
        'T <> '#39'N'#39');'
      ''
      '  SELECT /*NVL(SUM(OREMINUTI(LIQUIDATO)),0)*/'
      
        '         NVL(SUM(OREMINUTI(DECODE(ORENORMALI||ABBATTE_BUDGET,'#39'AM' +
        #39',OREPRESENZA,LIQUIDATO))),0)'
      '  INTO :CAUSLIQUIDATOMESE'
      '  FROM T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275'
      '  WHERE '
      '  T074.CAUSALE = T275.CODICE AND'
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA AND'
      
        '  (ORENORMALI IN ('#39'B'#39','#39'D'#39') /*OR ORENORMALI = '#39'A'#39' AND ABBATTE_BUD' +
        'GET IN ('#39'L'#39','#39'M'#39')*/);'
      ''
      '  SELECT NVL(SUM(OREMINUTI(OREPRESENZA)),0) INTO :CAUSRESOMESE'
      '  FROM T074_CAUSPRESFASCE T074, T275_CAUPRESENZE T275'
      '  WHERE '
      '  T074.CAUSALE = T275.CODICE AND'
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA AND'
      '  ORENORMALI IN ('#39'B'#39','#39'D'#39') AND NO_LIMITE_MENSILE_LIQ = '#39'S'#39';'
      ''
      
        '  SELECT NVL(SUM(OREMINUTI(ORESTRAORD)),0) INTO :STRAORDESTERNOA' +
        'NNO'
      '  FROM T075_STRESTERNO'
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA BETWEEN :DATA1 AND :DATA2;'
      ''
      
        '  SELECT NVL(SUM(OREMINUTI(ORESTRAORD)),0) INTO :STRAORDESTERNOM' +
        'ESE'
      '  FROM T075_STRESTERNO'
      '  WHERE '
      '  PROGRESSIVO = :PROGRESSIVO AND'
      '  DATA = :DATA;'
      ''
      
        '  SELECT NVL(SUM(ABS(LEAST(OREMINUTI(MINASS),0))),0) INTO :CAUSA' +
        'SSESTANNO FROM '
      '  ('
      '  SELECT T071.ORE1ASSEST MINASS'
      
        '  FROM T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAUGI' +
        'USTIF T305'
      '  WHERE '
      '  T070.CAUSALE1MINASS = T305.CODICE AND'
      '  T070.PROGRESSIVO = :PROGRESSIVO AND'
      '  T070.DATA BETWEEN :DATA1 AND :DATA2 AND'
      '  T071.PROGRESSIVO = T070.PROGRESSIVO AND'
      '  T071.DATA = T070.DATA AND'
      '  T305.LIMITE_LIQ = '#39'S'#39
      '  UNION ALL'
      '  SELECT T071.ORE2ASSEST MINASS'
      
        '  FROM T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAUGI' +
        'USTIF T305'
      '  WHERE '
      '  T070.CAUSALE2MINASS = T305.CODICE AND'
      '  T070.PROGRESSIVO = :PROGRESSIVO AND'
      '  T070.DATA BETWEEN :DATA1 AND :DATA2 AND'
      '  T071.PROGRESSIVO = T070.PROGRESSIVO AND'
      '  T071.DATA = T070.DATA AND'
      '  T305.LIMITE_LIQ = '#39'S'#39
      '  );'
      ''
      
        '  SELECT NVL(SUM(ABS(LEAST(OREMINUTI(MINASS),0))),0) INTO :CAUSA' +
        'SSESTMESE FROM '
      '  ('
      '  SELECT T071.ORE1ASSEST MINASS'
      
        '  FROM T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAUGI' +
        'USTIF T305'
      '  WHERE '
      '  T070.CAUSALE1MINASS = T305.CODICE AND'
      '  T070.PROGRESSIVO = :PROGRESSIVO AND'
      '  T070.DATA = :DATA AND'
      '  T071.PROGRESSIVO = T070.PROGRESSIVO AND'
      '  T071.DATA = T070.DATA AND'
      '  T305.LIMITE_LIQ = '#39'S'#39
      '  UNION ALL'
      '  SELECT T071.ORE2ASSEST MINASS'
      
        '  FROM T070_SCHEDARIEPIL T070, T071_SCHEDAFASCE T071, T305_CAUGI' +
        'USTIF T305'
      '  WHERE '
      '  T070.CAUSALE2MINASS = T305.CODICE AND'
      '  T070.PROGRESSIVO = :PROGRESSIVO AND'
      '  T070.DATA = :DATA AND'
      '  T071.PROGRESSIVO = T070.PROGRESSIVO AND'
      '  T071.DATA = T070.DATA AND'
      '  T305.LIMITE_LIQ = '#39'S'#39
      '  );'
      ''
      'end;')
    Optimize = False
    Variables.Data = {
      040000000E000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      00000000000000001C0000003A004C0049005100550049004400410054004F00
      4D00450053004500030000000400000000000000000000000A0000003A004400
      4100540041000C0000000000000000000000240000003A0043004F004D005000
      4C0049005100550049004400410054004F0041004E004E004F00030000000400
      000000000000000000001C0000003A004C004900510055004900440041005400
      4F0041004E004E004F0003000000040000000000000000000000260000003A00
      53005400520041004F0052004400450053005400450052004E004F0041004E00
      4E004F0003000000040000000000000000000000260000003A00530054005200
      41004F0052004400450053005400450052004E004F004D004500530045000300
      0000040000000000000000000000240000003A0043004100550053004C004900
      5100550049004400410054004F004D0045005300450003000000040000000000
      000000000000240000003A0043004100550053004C0049005100550049004400
      410054004F0041004E004E004F00030000000400000000000000000000001A00
      00003A0043004100550053005200450053004F004D0045005300450003000000
      0400000000000000000000001E0000003A004300410055005300410053005300
      45005300540041004E004E004F00030000000400000000000000000000001E00
      00003A0043004100550053004100530053004500530054004D00450053004500
      03000000040000000000000000000000}
    Left = 116
    Top = 12
  end
end
