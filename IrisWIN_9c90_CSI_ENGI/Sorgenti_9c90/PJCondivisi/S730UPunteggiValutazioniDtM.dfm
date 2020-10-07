inherited S730FPunteggiValutazioniDtM: TS730FPunteggiValutazioniDtM
  OldCreateOrder = True
  Height = 218
  Width = 329
  object selSG730: TOracleDataSet
    SQL.Strings = (
      'SELECT SG730.*, SG730.ROWID'
      'FROM   SG730_PUNTEGGI SG730'
      'ORDER BY SG730.DATO1, SG730.CODICE, SG730.DECORRENZA')
    Optimize = False
    OracleDictionary.DefaultValues = True
    AfterOpen = selSG730AfterOpen
    BeforePost = BeforePost
    AfterPost = AfterPost
    AfterScroll = selSG730AfterScroll
    OnNewRecord = OnNewRecord
    Left = 48
    Top = 32
    object selSG730DATO1: TStringField
      DisplayLabel = 'Cod.'
      FieldName = 'DATO1'
    end
    object selSG730DESC_DATO1: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 22
      FieldKind = fkLookup
      FieldName = 'DESC_DATO1'
      LookupDataSet = S730FPunteggiValutazioniMW.selDato1
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATO1'
      Size = 100
      Lookup = True
    end
    object selSG730DECORRENZA: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA'
    end
    object selSG730DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Scadenza'
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!99/99/0000;1;_'
    end
    object selSG730CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selSG730PUNTEGGIO: TFloatField
      DisplayLabel = 'Punteggio'
      FieldName = 'PUNTEGGIO'
      DisplayFormat = '0.00'
    end
    object selSG730DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 200
    end
    object selSG730CALCOLO_PFP: TStringField
      DisplayLabel = 'Calcolo PFP'
      FieldName = 'CALCOLO_PFP'
      Size = 1
    end
    object selSG730GIUSTIFICA: TStringField
      DisplayLabel = 'Richiedi giustificazione'
      FieldName = 'GIUSTIFICA'
      Size = 1
    end
    object selSG730ITEM_GIUDICABILE: TStringField
      DisplayLabel = 'Elemento giudicabile'
      FieldName = 'ITEM_GIUDICABILE'
      Size = 1
    end
  end
end
