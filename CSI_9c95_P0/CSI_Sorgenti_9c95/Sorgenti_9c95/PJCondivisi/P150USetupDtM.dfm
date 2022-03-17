inherited P150FSetupDtM: TP150FSetupDtM
  OldCreateOrder = True
  Height = 75
  Width = 75
  object selP150: TOracleDataSet
    SQL.Strings = (
      'SELECT P150.*,P150.ROWID FROM P150_SETUP P150'
      'ORDER BY DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000B000000140000004400450043004F005200520045004E005A004100
      0100000000001A00000043004F0044005F0050004100470041004D0045004E00
      54004F000100000000001E00000043004F0044005F00560041004C0055005400
      41005F0042004100530045000100000000002200000043004F0044005F005600
      41004C005500540041005F005300540041004D00500041000100000000001800
      00004E0055004D005F004400450043005F005000450052004300010000000000
      2200000042004C004F00430043004F005F0044004500540052005F0049005200
      500045004600010000000000200000004E0055004D005F004400450043005F00
      5100550041004E00540049005400410001000000000010000000540049005000
      4F005F004F00520045000100000000002000000043004F0044005F0043004F00
      4D0055004E0045005F0049004E00410049004C00010000000000200000004300
      450044004F004C0049004E004F005F005700450042005F00440041004C000100
      000000002A0000004300450044004F004C0049004E004F005F00570045004200
      5F00470047005F0045004D00490053005300010000000000}
    OnCalcFields = selP150CalcFields
    Left = 16
    Top = 8
    object selP150DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selP150DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
    end
    object selP150COD_PAGAMENTO: TStringField
      DisplayLabel = 'Tipo pagamento'
      FieldName = 'COD_PAGAMENTO'
      Size = 5
    end
    object selP150DES_PAGAM: TStringField
      DisplayLabel = 'Descrizione tipo pagamento'
      FieldKind = fkCalculated
      FieldName = 'DES_PAGAM'
      Calculated = True
    end
    object selP150COD_VALUTA_BASE: TStringField
      DisplayLabel = 'Valuta calcoli cedolino'
      FieldName = 'COD_VALUTA_BASE'
      Size = 10
    end
    object selP150DES_BASE: TStringField
      FieldKind = fkCalculated
      FieldName = 'DES_BASE'
      Calculated = True
    end
    object selP150COD_VALUTA_STAMPA: TStringField
      DisplayLabel = 'Valuta netto cedolino'
      FieldName = 'COD_VALUTA_STAMPA'
      Size = 10
    end
    object selP150DES_STAMPA: TStringField
      FieldKind = fkCalculated
      FieldName = 'DES_STAMPA'
      Calculated = True
    end
    object selP150COD_VALUTA_CONT: TStringField
      DisplayLabel = 'Valuta contabilit'#224
      FieldName = 'COD_VALUTA_CONT'
      Size = 10
    end
    object selP150DES_CONT: TStringField
      FieldKind = fkCalculated
      FieldName = 'DES_CONT'
      Calculated = True
    end
    object selP150COD_COMUNE_INAIL: TStringField
      DisplayLabel = 'Comune sede lavoro'
      FieldName = 'COD_COMUNE_INAIL'
      Size = 4
    end
    object selP150D_COMUNE_INAIL: TStringField
      DisplayLabel = 'Descrizione comune'
      FieldKind = fkLookup
      FieldName = 'D_COMUNE_INAIL'
      LookupKeyFields = 'CODCATASTALE'
      LookupResultField = 'CITTA'
      KeyFields = 'COD_COMUNE_INAIL'
      Size = 40
      Lookup = True
    end
    object selP150NUM_DEC_PERC: TIntegerField
      DisplayLabel = 'Num. decimali percentuale'
      FieldName = 'NUM_DEC_PERC'
    end
    object selP150NUM_DEC_QUANTITA: TIntegerField
      DisplayLabel = 'Num. decimali quantit'#224
      FieldName = 'NUM_DEC_QUANTITA'
    end
    object selP150TIPO_ORE: TStringField
      DisplayLabel = 'Formato ore'
      FieldName = 'TIPO_ORE'
      Size = 2
    end
    object selP150BLOCCO_DETR_IRPEF: TStringField
      DisplayLabel = 'Blocco detrazioni IRPEF'
      FieldName = 'BLOCCO_DETR_IRPEF'
      Size = 1
    end
    object selP150ULTIMO_ANNO_RECUP: TIntegerField
      DisplayLabel = 'Ultimo anno recuperato'
      FieldName = 'ULTIMO_ANNO_RECUP'
    end
  end
end
