inherited A102FParScaricoGiustDtM: TA102FParScaricoGiustDtM
  OldCreateOrder = True
  Height = 149
  Width = 160
  object selI150: TOracleDataSet
    SQL.Strings = (
      'SELECT I150.*,I150.ROWID '
      '  FROM MONDOEDP.I150_PARSCARICOGIUST I150'
      ' ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000001C0000000C00000043004F0044004900430045000100000000001000
      00004E004F004D004500460049004C004500010000000000120000004D004100
      54005200490043004F004C0041000100000000000E0000004300410055005300
      41004C004500010000000000080000005400490050004F000100000000001000
      000043004F005200520045004E00540045000100000000000A00000042004100
      4400470045000100000000000A0000004F005200410044004100010000000000
      080000004F005200410041000100000000001800000043004F00440049004300
      45005F005400490050004F0049000100000000001800000043004F0044004900
      430045005F005400490050004F004D000100000000001800000043004F004400
      4900430045005F005400490050004F0044000100000000001800000043004F00
      44004900430045005F005400490050004F004E000100000000000C0000004100
      4E004E004F00440041000100000000000C0000004D0045005300450044004100
      01000000000010000000470049004F0052004E004F0044004100010000000000
      0A00000041004E004E004F0041000100000000000A0000004D00450053004500
      41000100000000000E000000470049004F0052004E004F004100010000000000
      0A0000004D0049004E0044004100010000000000080000004D0049004E004100
      0100000000001400000053004500500041005200410054004F00520045000100
      00000000120000004E0055004D00470049004F0052004E004900010000000000
      0C0000004400410054004100440041000100000000001600000046004F005200
      4D00410054004F00440041005400410001000000000016000000440045005300
      4300430041005500530041004C0045000100000000000E00000041005A004900
      45004E0044004100010000000000240000004D00410054005200490043004F00
      4C0041005F004E0055004D0045005200490043004100010000000000}
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterScroll = selI150AfterScroll
    OnNewRecord = selI150NewRecord
    Left = 20
    Top = 20
    object selI150CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
    end
    object selI150NOMEFILE: TStringField
      FieldName = 'NOMEFILE'
      Required = True
      Size = 100
    end
    object selI150CORRENTE: TStringField
      FieldName = 'CORRENTE'
      Required = True
      Size = 1
    end
    object selI150MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 80
    end
    object selI150BADGE: TStringField
      DisplayLabel = 'Badge'
      FieldName = 'BADGE'
      Size = 80
    end
    object selI150ANNODA: TStringField
      DisplayLabel = 'Anno da'
      FieldName = 'ANNODA'
      Size = 80
    end
    object selI150MESEDA: TStringField
      DisplayLabel = 'Mese da'
      FieldName = 'MESEDA'
      Size = 80
    end
    object selI150GIORNODA: TStringField
      DisplayLabel = 'Giorno da'
      FieldName = 'GIORNODA'
      Size = 80
    end
    object selI150ANNOA: TStringField
      DisplayLabel = 'Anno a'
      FieldName = 'ANNOA'
      Size = 80
    end
    object selI150MESEA: TStringField
      DisplayLabel = 'Mese a'
      FieldName = 'MESEA'
      Size = 80
    end
    object selI150GIORNOA: TStringField
      DisplayLabel = 'Giorno a'
      FieldName = 'GIORNOA'
      Size = 80
    end
    object selI150ORADA: TStringField
      DisplayLabel = 'Ora da'
      FieldName = 'ORADA'
      Size = 80
    end
    object selI150MINDA: TStringField
      DisplayLabel = 'Minuti da'
      FieldName = 'MINDA'
      Size = 80
    end
    object selI150ORAA: TStringField
      DisplayLabel = 'Ora a'
      FieldName = 'ORAA'
      Size = 80
    end
    object selI150MINA: TStringField
      DisplayLabel = 'Minuti a'
      FieldName = 'MINA'
      Size = 80
    end
    object selI150CAUSALE: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE'
      Required = True
      Size = 80
    end
    object selI150TIPO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO'
      Size = 80
    end
    object selI150DATADA: TStringField
      DisplayLabel = 'Data da'
      FieldName = 'DATADA'
      Size = 80
    end
    object selI150NUMGIORNI: TStringField
      DisplayLabel = 'Num.gg.'
      FieldName = 'NUMGIORNI'
      Size = 80
    end
    object selI150CODICE_TIPOI: TStringField
      FieldName = 'CODICE_TIPOI'
      Size = 5
    end
    object selI150CODICE_TIPOM: TStringField
      FieldName = 'CODICE_TIPOM'
      Size = 5
    end
    object selI150CODICE_TIPOD: TStringField
      FieldName = 'CODICE_TIPOD'
      Size = 5
    end
    object selI150CODICE_TIPON: TStringField
      FieldName = 'CODICE_TIPON'
      Size = 5
    end
    object selI150SEPARATORE: TStringField
      FieldName = 'SEPARATORE'
      Size = 1
    end
    object selI150FORMATODATA: TStringField
      FieldName = 'FORMATODATA'
      Size = 30
    end
    object selI150DESCCAUSALE: TStringField
      FieldName = 'DESCCAUSALE'
      Size = 1
    end
    object selI150AZIENDA: TStringField
      FieldName = 'AZIENDA'
      Size = 30
    end
    object selI150MATRICOLA_NUMERICA: TStringField
      FieldName = 'MATRICOLA_NUMERICA'
      Size = 1
    end
    object selI150TIPOFILE: TStringField
      FieldName = 'TIPOFILE'
      Size = 1
    end
    object selI150ID: TStringField
      DisplayLabel = 'Id'
      FieldName = 'ID'
      Size = 80
    end
    object selI150DATAA: TStringField
      DisplayLabel = 'Data a'
      FieldName = 'DATAA'
      Size = 80
    end
    object selI150TIPO_OPERAZIONE: TStringField
      DisplayLabel = 'Tipo operaz.'
      FieldName = 'TIPO_OPERAZIONE'
      Size = 80
    end
    object selI150FAMILIARE: TStringField
      DisplayLabel = 'Familiare'
      FieldName = 'FAMILIARE'
      Size = 80
    end
    object selI150MESSAGGIO: TStringField
      DisplayLabel = 'Messaggio'
      FieldName = 'MESSAGGIO'
      Size = 80
    end
    object selI150ELABORATO: TStringField
      DisplayLabel = 'Elaborato'
      FieldName = 'ELABORATO'
      Size = 80
    end
    object selI150DATA_ELABORAZIONE: TStringField
      DisplayLabel = 'Data elab.'
      FieldName = 'DATA_ELABORAZIONE'
      Size = 80
    end
    object selI150HHMMDA: TStringField
      DisplayLabel = 'HHMM da'
      FieldName = 'HHMMDA'
      Size = 80
    end
    object selI150HHMMA: TStringField
      DisplayLabel = 'HHMM a'
      FieldName = 'HHMMA'
      Size = 80
    end
    object selI150ANOMALIE_BLOCCANTI: TStringField
      FieldName = 'ANOMALIE_BLOCCANTI'
      Size = 1
    end
  end
  object selI090: TOracleDataSet
    SQL.Strings = (
      'SELECT AZIENDA '
      '  FROM MONDOEDP.I090_ENTI'
      ' WHERE AZIENDA <> '#39'AZIN'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000010000000E00000041005A00490045004E0044004100010000000000}
    Left = 75
    Top = 20
  end
  object dsrI090: TDataSource
    DataSet = selI090
    Left = 72
    Top = 72
  end
end
