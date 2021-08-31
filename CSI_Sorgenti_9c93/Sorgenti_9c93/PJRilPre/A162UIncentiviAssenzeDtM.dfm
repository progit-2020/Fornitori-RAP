inherited A162FIncentiviAssenzeDtM: TA162FIncentiviAssenzeDtM
  OldCreateOrder = True
  Height = 372
  Width = 607
  object selT769: TOracleDataSet
    SQL.Strings = (
      'select T769.*, t769.rowid'
      'from t769_incentiviassenze t769'
      
        'order by dato1,dato2,dato3,cod_tipoaccorpcausali, cod_codiciacco' +
        'rpcausali, T769.CAUSALE, decorrenza, decorrenza_fine'
      '')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000120000000A0000004400410054004F0031000100000000000A000000
      4400410054004F0032000100000000000A0000004400410054004F0033000100
      00000000140000004400450043004F005200520045004E005A00410001000000
      00002200000050004500520043005F0041004200420041005400540049004D00
      45004E0054004F000100000000002600000050004500520043005F0041004200
      42005F004600520041004E004300480049004700490041000100000000001E00
      000046004F0052005A0041005F004100420042005F004700470049004E005400
      0100000000002A00000043004F0044005F005400490050004F00410043004300
      4F0052005000430041005500530041004C0049000100000000002E0000004300
      4F0044005F0043004F0044004900430049004100430043004F00520050004300
      41005500530041004C004900010000000000240000004600520041004E004300
      480049004700490041005F0041005300530045004E005A004500010000000000
      26000000470045005300540049004F004E0045005F004600520041004E004300
      480049004700490041000100000000002000000043004F004E00540041005F00
      460052005500490054004F005F004F0052004500010000000000220000005400
      490050004F005F0041004200420041005400540049004D0045004E0054004F00
      0100000000001E0000004400450043004F005200520045004E005A0041005F00
      460049004E0045000100000000000E000000430041005500530041004C004500
      0100000000002400000041005300530045004E005A0045005F00410047004700
      490055004E0054004900560045000100000000002C000000500052004F005000
      4F0052005A0049004F004E0045005F004600520041004E004300480049004700
      490041000100000000002000000043004F004E00540041005F0053004F004C00
      4F005F004700470049004E005400010000000000}
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    AfterScroll = selT769AfterScroll
    Left = 24
    Top = 16
    object selT769DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selT769DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Data fine'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'DD/MM/YYYY'
      EditMask = '!99/99/0000;1;_'
    end
    object selT769DATO1: TStringField
      DisplayLabel = 'Dato1'
      DisplayWidth = 10
      FieldName = 'DATO1'
      Required = True
    end
    object selT769D_DATO1: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO1'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 40
      Lookup = True
    end
    object selT769DATO2: TStringField
      DisplayLabel = 'Dato2'
      DisplayWidth = 10
      FieldName = 'DATO2'
      Required = True
    end
    object selT769D_DATO2: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO2'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO2'
      Size = 40
      Lookup = True
    end
    object selT769DATO3: TStringField
      DisplayLabel = 'Dato3'
      DisplayWidth = 10
      FieldName = 'DATO3'
      Required = True
    end
    object selT769D_DATO3: TStringField
      FieldKind = fkLookup
      FieldName = 'D_DATO3'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO3'
      Size = 40
      Lookup = True
    end
    object selT769CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Required = True
      Size = 5
    end
    object selT769D_CAUSALE: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE'
      Size = 100
      Lookup = True
    end
    object selT769COD_TIPOACCORPCAUSALI: TStringField
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selT769D_TIPOACCORP: TStringField
      FieldKind = fkLookup
      FieldName = 'D_TIPOACCORP'
      LookupKeyFields = 'COD_TIPOACCORPCAUSALI'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_TIPOACCORPCAUSALI'
      Size = 100
      Lookup = True
    end
    object selT769COD_CODICIACCORPCAUSALI: TStringField
      FieldName = 'COD_CODICIACCORPCAUSALI'
      Required = True
      Size = 5
    end
    object selT769D_CODICIACCORPCAUSALI: TStringField
      FieldKind = fkLookup
      FieldName = 'D_CODICIACCORPCAUSALI'
      LookupKeyFields = 'COD_CODICIACCORPCAUSALI'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_CODICIACCORPCAUSALI'
      Size = 200
      Lookup = True
    end
    object selT769TIPO_ABBATTIMENTO: TStringField
      FieldName = 'TIPO_ABBATTIMENTO'
      Size = 5
    end
    object selT769D_TIPOABBAT: TStringField
      FieldKind = fkLookup
      FieldName = 'D_TIPOABBAT'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO_ABBATTIMENTO'
      Size = 100
      Lookup = True
    end
    object selT769D_RISPARMIO: TStringField
      FieldKind = fkLookup
      FieldName = 'D_RISPARMIO'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'RISPARMIO_BILANCIO'
      KeyFields = 'TIPO_ABBATTIMENTO'
      Size = 1
      Lookup = True
    end
    object selT769GESTIONE_FRANCHIGIA: TStringField
      FieldName = 'GESTIONE_FRANCHIGIA'
      Size = 1
    end
    object selT769FRANCHIGIA_ASSENZE: TIntegerField
      FieldName = 'FRANCHIGIA_ASSENZE'
    end
    object selT769CONTA_FRUITO_ORE: TStringField
      FieldName = 'CONTA_FRUITO_ORE'
      Size = 1
    end
    object selT769FORZA_ABB_GGINT: TStringField
      FieldName = 'FORZA_ABB_GGINT'
      Size = 1
    end
    object selT769PERC_ABBATTIMENTO: TFloatField
      FieldName = 'PERC_ABBATTIMENTO'
      Required = True
    end
    object selT769PERC_ABB_FRANCHIGIA: TFloatField
      FieldName = 'PERC_ABB_FRANCHIGIA'
      Required = True
    end
    object selT769ASSENZE_AGGIUNTIVE: TStringField
      FieldName = 'ASSENZE_AGGIUNTIVE'
      Size = 100
    end
    object selT769PROPORZIONE_FRANCHIGIA: TStringField
      FieldName = 'PROPORZIONE_FRANCHIGIA'
      Size = 1
    end
    object selT769CONTA_SOLO_GGINT: TStringField
      FieldName = 'CONTA_SOLO_GGINT'
      Size = 1
    end
  end
  object dsrDato1: TDataSource
    Left = 64
    Top = 120
  end
  object dsrDato2: TDataSource
    Left = 128
    Top = 120
  end
  object dsrDato3: TDataSource
    Left = 192
    Top = 120
  end
  object dsrT255: TDataSource
    Left = 248
    Top = 122
  end
  object dsrT256: TDataSource
    Left = 304
    Top = 120
  end
  object dsrT766: TDataSource
    Left = 440
    Top = 120
  end
  object dsrT265: TDataSource
    Left = 368
    Top = 122
  end
end
