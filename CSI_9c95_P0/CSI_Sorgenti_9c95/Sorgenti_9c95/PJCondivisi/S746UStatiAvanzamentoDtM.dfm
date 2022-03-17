inherited S746FStatiAvanzamentoDtM: TS746FStatiAvanzamentoDtM
  OldCreateOrder = True
  Height = 165
  Width = 266
  object SG746: TOracleDataSet
    SQL.Strings = (
      'SELECT SG746.*, SG746.ROWID'
      'FROM SG746_STATI_AVANZAMENTO SG746'
      'ORDER BY CODREGOLA, CODICE, DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    AfterOpen = SG746AfterOpen
    BeforePost = BeforePost
    AfterScroll = SG746AfterScroll
    OnNewRecord = SG746NewRecord
    Left = 24
    Top = 16
    object SG746DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      FieldName = 'DECORRENZA'
      OnValidate = SG746DECORRENZAValidate
    end
    object SG746DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Decorrenza fine'
      FieldName = 'DECORRENZA_FINE'
    end
    object SG746CODICE: TIntegerField
      FieldName = 'CODICE'
      OnValidate = SG746CODICEValidate
    end
    object SG746CODREGOLA: TStringField
      FieldName = 'CODREGOLA'
      OnValidate = SG746CODICEValidate
      Size = 5
    end
    object SG746DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      OnValidate = SG746CODICEValidate
      Size = 100
    end
    object SG746MODIFICABILE: TStringField
      FieldName = 'MODIFICABILE'
      Size = 1
    end
    object SG746CODSTAMPA: TIntegerField
      FieldName = 'CODSTAMPA'
    end
    object SG746DATA_DA: TDateTimeField
      DisplayLabel = 'Inizio periodo compilazione'
      FieldName = 'DATA_DA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG746DATA_A: TDateTimeField
      DisplayLabel = 'Fine periodo compilazione'
      FieldName = 'DATA_A'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG746DATA_DA_RICHIESTA_VISIONE: TDateTimeField
      DisplayLabel = 'Inizio periodo richiesta presa visione'
      FieldName = 'DATA_DA_RICHIESTA_VISIONE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG746DATA_A_RICHIESTA_VISIONE: TDateTimeField
      DisplayLabel = 'Fine periodo richiesta presa visione'
      FieldName = 'DATA_A_RICHIESTA_VISIONE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object SG746VAL_INTERM_MODIFICABILE: TStringField
      DisplayLabel = 'Val. interm. modificabile'
      FieldName = 'VAL_INTERM_MODIFICABILE'
      Size = 1
    end
    object SG746VAL_INTERM_OBBLIGATORIA: TStringField
      DisplayLabel = 'Val. interm. obbligatoria'
      FieldName = 'VAL_INTERM_OBBLIGATORIA'
      Size = 1
    end
    object SG746CREA_AUTOVALUTAZIONE: TStringField
      DisplayLabel = 'Duplicabile in autovalutazione'
      FieldName = 'CREA_AUTOVALUTAZIONE'
      Size = 1
    end
  end
end
