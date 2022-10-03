inherited A164FQuoteIncentiviDtM: TA164FQuoteIncentiviDtM
  OldCreateOrder = True
  Height = 268
  Width = 515
  object selT770: TOracleDataSet
    SQL.Strings = (
      
        'select t770.*, NVL(t765.DESCRIZIONE,'#39#39') DESCTIPOQUOTA, T770.ROWI' +
        'D'
      ' from T770_QUOTE T770,'
      
        '      (SELECT CODICE, DESCRIZIONE, DECORRENZA DECORRENZA765 FROM' +
        ' T765_TIPOQUOTE) T765'
      ' where T770.CODTIPOQUOTA = T765.CODICE'
      
        '   and t765.DECORRENZA765 = (SELECT MAX(DECORRENZA) FROM T765_TI' +
        'POQUOTE'
      '                     WHERE CODICE = T765.CODICE'
      '                       AND DECORRENZA <= T770.DECORRENZA)'
      
        'order by DATO1, DATO2, DATO3, CODTIPOQUOTA, CAUSALE,  DECORRENZA' +
        ' ')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000120000000A0000004400410054004F0031000100000000000A000000
      4400410054004F0032000100000000000A0000004400410054004F0033000100
      00000000140000004400450043004F005200520045004E005A00410001000000
      00001800000043004F0044005400490050004F00510055004F00540041000100
      000000000E00000049004D0050004F00520054004F000100000000000E000000
      4E0055004D005F004F0052004500010000000000200000005000450052004300
      5F0049004E0044004900560049004400550041004C0045000100000000002000
      000050004500520043005F005300540052005500540054005500520041004C00
      450001000000000016000000500045005200430045004E005400550041004C00
      45000100000000001E00000043004F004E005300490044004500520041005F00
      530041004C0044004F000100000000001600000053004F005300500045004E00
      440049005F00500054000100000000000E000000430041005500530041004C00
      45000100000000001C000000500045004E0041004C0049005A005A0041005A00
      49004F004E00450001000000000022000000560041004C00550054005F005300
      540052005500540054005500520041004C0045000100000000001E0000004400
      450043004F005200520045004E005A0041005F00460049004E00450001000000
      00001000000054004F0054004E004500540054004F0001000000000020000000
      5400490050004F005F005300540041004D00500041005100550041004E005400
      010000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    AfterScroll = selT770AfterScroll
    OnCalcFields = selT770CalcFields
    Left = 24
    Top = 16
    object selT770DATO1: TStringField
      DisplayLabel = 'Dato1'
      DisplayWidth = 10
      FieldName = 'DATO1'
      Required = True
    end
    object selT770DATO2: TStringField
      DisplayLabel = 'Dato2'
      DisplayWidth = 10
      FieldName = 'DATO2'
      Required = True
    end
    object selT770DATO3: TStringField
      DisplayLabel = 'Dato3'
      DisplayWidth = 10
      FieldName = 'DATO3'
      Required = True
    end
    object selT770DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT770DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Data fine'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object selT770CODTIPOQUOTA: TStringField
      DisplayLabel = 'Tipo quota'
      DisplayWidth = 10
      FieldName = 'CODTIPOQUOTA'
      Required = True
      Size = 5
    end
    object selT770D_TIPOQUOTA: TStringField
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_TIPOQUOTA'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CODTIPOQUOTA'
      Size = 50
      Lookup = True
    end
    object selT770CAUSALE: TStringField
      DisplayLabel = 'Assenza'
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT770D_CAUSALE: TStringField
      DisplayLabel = ' '
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 50
      Lookup = True
    end
    object selT770D_DATO3: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO3'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO3'
      Size = 40
      Lookup = True
    end
    object selT770D_DATO2: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO2'
      Size = 40
      Lookup = True
    end
    object selT770D_DATO1: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 40
      Lookup = True
    end
    object selT770IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      DisplayFormat = '###,###,###,##0.#####'
      EditFormat = ';###,###,###,##0.#####;'
    end
    object selT770NUM_ORE: TStringField
      DisplayLabel = 'Num.Ore'
      FieldName = 'NUM_ORE'
      EditMask = '!900:00;1;_'
      Size = 6
    end
    object selT770PERC_INDIVIDUALE: TFloatField
      DisplayLabel = '% Individuale'
      FieldName = 'PERC_INDIVIDUALE'
    end
    object selT770PERC_STRUTTURALE: TFloatField
      DisplayLabel = '% Strutturale'
      FieldName = 'PERC_STRUTTURALE'
    end
    object selT770PERCENTUALE: TFloatField
      DisplayLabel = '% Prop.'
      DisplayWidth = 5
      FieldName = 'PERCENTUALE'
      OnValidate = selT770PERCENTUALEValidate
    end
    object selT770CONSIDERA_SALDO: TStringField
      FieldName = 'CONSIDERA_SALDO'
      Size = 1
    end
    object selT770SOSPENDI_PT: TStringField
      FieldName = 'SOSPENDI_PT'
      Size = 1
    end
    object selT770PENALIZZAZIONE: TFloatField
      FieldName = 'PENALIZZAZIONE'
      Visible = False
    end
    object selT770VALUT_STRUTTURALE: TFloatField
      FieldName = 'VALUT_STRUTTURALE'
      Visible = False
    end
    object selT770TIPO_STAMPAQUANT: TStringField
      FieldName = 'TIPO_STAMPAQUANT'
      Size = 1
    end
    object selT770TOTNETTO: TFloatField
      FieldKind = fkCalculated
      FieldName = 'TOTNETTO'
      DisplayFormat = '###,###,###,##0.#####'
      Calculated = True
    end
    object selT770DESCTIPOQUOTA: TStringField
      FieldKind = fkInternalCalc
      FieldName = 'DESCTIPOQUOTA'
      Size = 500
    end
  end
  object dsrDato1: TDataSource
    Left = 88
    Top = 120
  end
  object dsrDato2: TDataSource
    Left = 168
    Top = 120
  end
  object dsrDato3: TDataSource
    Left = 256
    Top = 120
  end
  object dsrT765: TDataSource
    Left = 24
    Top = 120
  end
  object dsrT265: TDataSource
    Left = 327
    Top = 120
  end
end
