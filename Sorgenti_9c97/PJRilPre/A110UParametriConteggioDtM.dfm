inherited A110FParametriConteggioDtM: TA110FParametriConteggioDtM
  OldCreateOrder = True
  Height = 124
  Width = 144
  object M010: TOracleDataSet
    SQL.Strings = (
      'SELECT M010.*, M010.ROWID '
      '  FROM M010_PARAMETRICONTEGGIO M010'
      
        'ORDER BY M010.CODICE ASC, M010.TIPO_MISSIONE ASC, M010.DECORRENZ' +
        'A'
      '')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001C000000140000004400450043004F005200520045004E005A004100
      010000000000160000004400450053004300520049005A0049004F004E004500
      0100000000002A0000004F00520045004D0049004E0049004D00450050004500
      520049004E00440045004E004E00490054004100010000000000320000004C00
      49004D004900540045004F005200450052004500540052004900420055004900
      5400450049004E00540045005200450001000000000022000000410052005200
      4F0054004F004E00440041004D0045004E0054004F004F005200450001000000
      0000260000005000450052004300520045005400520049004200530055005000
      450052004F004F0052004500010000000000220000004D004100580047004900
      4F0052004E00490052004500540052004D004500530045000100000000002400
      0000500045005200430052004500540052004900420053005500500045005200
      4F0047004700010000000000320000004100520052004F005400540041005200
      490046004600410044004F0050004F0052004900440055005A0049004F004E00
      4500010000000000300000004100520052004F00540054004F00540049004D00
      50004F0052005400490044004100540049005000410047004800450001000000
      0000080000005400490050004F000100000000001E0000005200490044005500
      5A0049004F004E0045005F0050004100530054004F000100000000001E000000
      500045005200430052004500540052004900420050004100530054004F000100
      000000000C00000043004F0044004900430045000100000000001A0000005400
      490050004F005F004D0049005300530049004F004E0045000100000000002000
      0000540041005200490046004600410049004E00440045004E004E0049005400
      4100010000000000180000005400490050004F005F0054004100520049004600
      460041000100000000002200000043004F00440056004F004300450050004100
      470048004500530055005000480048000100000000002200000043004F004400
      56004F0043004500500041004700480045005300550050004700470001000000
      00002000000043004F004400520049004D0042004F00520053004F0050004100
      530054004F00010000000000200000004F0052004500520049004D0042004F00
      520053004F0050004100530054004F0001000000000028000000540041005200
      4900460046004100520049004D0042004F00520053004F005000410053005400
      4F00010000000000220000004F0052004500520049004D0042004F0052005300
      4F0050004100530054004F0032000100000000002A0000005400410052004900
      460046004100520049004D0042004F00520053004F0050004100530054004F00
      32000100000000002400000043004F00440056004F0043004500500041004700
      4800450049004E0054004500520041000100000000002600000043004F004400
      56004F0043004500500041004700480045005300550050004800480047004700
      0100000000002400000043004F0044004900430049005F0049004E0044004500
      4E004E004900540041004B004D000100000000001E00000043004F0044004900
      430049005F00520049004D0042004F00520053004900010000000000}
    Filtered = True
    AfterOpen = M010AfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterScroll = M010AfterScroll
    OnCalcFields = M010CalcFields
    OnFilterRecord = FiltroDizionario
    Left = 12
    Top = 14
    object M010CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 80
    end
    object M010TIPO_MISSIONE: TStringField
      FieldName = 'TIPO_MISSIONE'
      Required = True
      Size = 5
    end
    object M010DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object M010DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object M010OREMINIMEPERINDENNITA: TStringField
      FieldName = 'OREMINIMEPERINDENNITA'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object M010LIMITEORERETRIBUITEINTERE: TStringField
      DisplayWidth = 6
      FieldName = 'LIMITEORERETRIBUITEINTERE'
      EditMask = '!990:00;1;_'
      Size = 6
    end
    object M010ARROTONDAMENTOORE: TFloatField
      FieldName = 'ARROTONDAMENTOORE'
      LookupKeyFields = 'COD'
    end
    object M010PERCRETRIBSUPEROORE: TFloatField
      FieldName = 'PERCRETRIBSUPEROORE'
    end
    object M010MAXGIORNIRETRMESE: TFloatField
      FieldName = 'MAXGIORNIRETRMESE'
    end
    object COD: TFloatField
      FieldName = 'PERCRETRIBSUPEROGG'
    end
    object M010ARROTTARIFFADOPORIDUZIONE: TStringField
      FieldName = 'ARROTTARIFFADOPORIDUZIONE'
      Size = 5
    end
    object M010ARROTTOTIMPORTIDATIPAGHE: TStringField
      FieldName = 'ARROTTOTIMPORTIDATIPAGHE'
      Size = 5
    end
    object M010RIDUZIONE_PASTO: TStringField
      FieldName = 'RIDUZIONE_PASTO'
      Required = True
      Size = 1
    end
    object M010PERCRETRIBPASTO: TFloatField
      FieldName = 'PERCRETRIBPASTO'
    end
    object M010TARIFFAINDENNITA: TFloatField
      FieldName = 'TARIFFAINDENNITA'
    end
    object M010TIPO_TARIFFA: TStringField
      FieldName = 'TIPO_TARIFFA'
      Size = 1
    end
    object M010TIPO: TStringField
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object M010CODVOCEPAGHEINTERA: TStringField
      FieldName = 'CODVOCEPAGHEINTERA'
      Size = 6
    end
    object M010CODVOCEPAGHESUPHH: TStringField
      FieldName = 'CODVOCEPAGHESUPHH'
      Size = 6
    end
    object M010CODVOCEPAGHESUPGG: TStringField
      FieldName = 'CODVOCEPAGHESUPGG'
      Size = 6
    end
    object M010CODVOCEPAGHESUPHHGG: TStringField
      FieldName = 'CODVOCEPAGHESUPHHGG'
      Size = 6
    end
    object M010ORERIMBORSOPASTO: TStringField
      FieldName = 'ORERIMBORSOPASTO'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object M010TARIFFARIMBORSOPASTO: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO'
    end
    object M010ORERIMBORSOPASTO2: TStringField
      FieldName = 'ORERIMBORSOPASTO2'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object M010TARIFFARIMBORSOPASTO2: TFloatField
      FieldName = 'TARIFFARIMBORSOPASTO2'
    end
    object M010CODICI_INDENNITAKM: TStringField
      FieldName = 'CODICI_INDENNITAKM'
      Size = 500
    end
    object M010CODICI_RIMBORSI: TStringField
      FieldName = 'CODICI_RIMBORSI'
      Size = 500
    end
    object M010CalcArrotTariffaDopoRiduzione: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcArrotTariffaDopoRiduzione'
      Size = 40
      Calculated = True
    end
    object M010CalcArrotImportiDatiPaghe: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcArrotImportiDatiPaghe'
      Size = 40
      Calculated = True
    end
    object M010desc_tipomissione: TStringField
      FieldKind = fkLookup
      FieldName = 'desc_tipomissione'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO_MISSIONE'
      Size = 40
      Lookup = True
    end
    object M010desc_codice: TStringField
      FieldKind = fkLookup
      FieldName = 'desc_codice'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODICE'
      Size = 80
      Lookup = True
    end
    object M010MAXMESIRIMB: TFloatField
      FieldName = 'MAXMESIRIMB'
    end
    object M010DATARIF_VOCEPAGHE: TStringField
      FieldName = 'DATARIF_VOCEPAGHE'
      Size = 1
    end
    object M010IND_DA_TAB_TARIFFE: TStringField
      FieldName = 'IND_DA_TAB_TARIFFE'
      Size = 1
    end
    object M010CAUSALE_MISSIONE: TStringField
      FieldName = 'CAUSALE_MISSIONE'
      Size = 5
    end
    object M010CalcCausale: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcCausale'
      Size = 40
      Calculated = True
    end
    object M010GIUSTIF_HHMAX: TStringField
      FieldName = 'GIUSTIF_HHMAX'
      OnValidate = M010GIUSTIF_HHMAXValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object M010GIUSTIF_COPRE_DEBITOGG: TStringField
      FieldName = 'GIUSTIF_COPRE_DEBITOGG'
      Size = 1
    end
    object M010TIPO_RIMBORSOPASTO: TStringField
      FieldName = 'TIPO_RIMBORSOPASTO'
      Size = 1
    end
    object M010CODRIMBORSOPASTO: TStringField
      FieldName = 'CODRIMBORSOPASTO'
      Size = 5
    end
    object M010RIMB_KM_AUTO: TStringField
      FieldName = 'RIMB_KM_AUTO'
      Size = 1
    end
    object M010IND_KM_AUTO: TStringField
      FieldName = 'IND_KM_AUTO'
      Size = 5
    end
    object M010DESC_IND_KM_AUTO: TStringField
      FieldKind = fkLookup
      FieldName = 'DESC_IND_KM_AUTO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'IND_KM_AUTO'
      Size = 40
      Lookup = True
    end
    object M010RIMB_KM_AUTO_MINIMO: TIntegerField
      DisplayLabel = 'Soglia per rimborso automatico'
      FieldName = 'RIMB_KM_AUTO_MINIMO'
      MaxValue = 9999
    end
  end
  object dscCdsDistM013: TDataSource
    DataSet = cdsDistM013
    Left = 79
    Top = 62
  end
  object cdsDistM013: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'M013_CHIAVE'
        DataType = ftString
        Size = 95
      end
      item
        Name = 'DECORRENZA'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 78
    Top = 13
    Data = {
      4D0000009619E0BD0100000018000000020000000000030000004D000B4D3031
      335F4348494156450100490000000100055749445448020002005F000A444543
      4F5252454E5A4108000800000000000000}
  end
end
