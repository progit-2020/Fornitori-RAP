inherited A136FComposizioneRelazioneMW: TA136FComposizioneRelazioneMW
  OldCreateOrder = True
  Height = 407
  Width = 627
  object cdsCampiRelazioni: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'VALOREPILOTATO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRIZIONEPILOTATO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'VALOREPILOTA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRIZIONEPILOTA'
        DataType = ftString
        Size = 500
      end>
    IndexDefs = <
      item
        Name = 'IND_PILOTATO'
        Fields = 'VALOREPILOTATO;VALOREPILOTA'
      end
      item
        Name = 'IND_PILOTA'
        Fields = 'VALOREPILOTA;VALOREPILOTATO'
      end>
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 24
    object cdsCampiRelazioniVALOREPILOTATO: TStringField
      FieldName = 'VALOREPILOTATO'
      Size = 50
    end
    object cdsCampiRelazioniVALOREPILOTA: TStringField
      FieldName = 'VALOREPILOTA'
      Size = 50
    end
  end
  object insI035: TOracleQuery
    SQL.Strings = (
      'INSERT INTO I035_RELAZIONI_DETTAGLIO'
      '(TABELLA, COLONNA, DECORRENZA, NUM, RELAZIONE)'
      'VALUES'
      '(:TABELLA, :COLONNA, :DECORRENZA, :NUM, :RELAZIONE)')
    Optimize = False
    Variables.Data = {
      0400000005000000100000003A0054004100420045004C004C00410005000000
      0000000000000000100000003A0043004F004C004F004E004E00410005000000
      0000000000000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000080000003A004E0055004D00030000000000
      000000000000140000003A00520045004C0041005A0049004F004E0045000500
      00000000000000000000}
    Left = 184
    Top = 24
  end
  object selI030a: TOracleDataSet
    SQL.Strings = (
      
        'SELECT I030.TABELLA, I030.COLONNA, I030.DECORRENZA, I030.DECORRE' +
        'NZA_FINE, I030.ORDINE, I030.TIPO, I030.TAB_ORIGINE'
      'FROM   I030_RELAZIONI_ANAGRAFE I030'
      'WHERE  I030.TIPO IN (:TIPO)'
      
        'AND    :DECORRENZA BETWEEN I030.DECORRENZA AND I030.DECORRENZA_F' +
        'INE'
      ':GESTIONE_STRUTTURA'
      'ORDER BY ORDINE, TABELLA, COLONNA, DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A005400490050004F0001000000000000000000
      0000160000003A004400450043004F005200520045004E005A0041000C000000
      0000000000000000260000003A00470045005300540049004F004E0045005F00
      530054005200550054005400550052004100010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000000E00000054004100420045004C004C004100010000000000
      0E00000043004F004C004F004E004E0041000100000000001400000044004500
      43004F005200520045004E005A0041000100000000001E000000440045004300
      4F005200520045004E005A0041005F00460049004E0045000100000000000C00
      00004F005200440049004E004500010000000000080000005400490050004F00
      010000000000}
    Left = 32
    Top = 144
  end
  object cdsStampa: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 392
    Top = 144
  end
  object selPilotatoStampa: TOracleDataSet
    Optimize = False
    Left = 160
    Top = 144
  end
  object selPilotaStampa: TOracleDataSet
    Optimize = False
    Left = 248
    Top = 144
  end
  object selI035a: TOracleDataSet
    SQL.Strings = (
      'select relazione'
      'from   i035_relazioni_dettaglio'
      'where  tabella = :tabella'
      'and    colonna = :colonna'
      'and    decorrenza = :decorrenza'
      'order by num')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0054004100420045004C004C00410005000000
      0000000000000000100000003A0043004F004C004F004E004E00410005000000
      0000000000000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 88
    Top = 144
  end
  object cdsAppoggio: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'VALOREPILOTATO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRIZIONEPILOTATO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'VALOREPILOTA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRIZIONEPILOTA'
        DataType = ftString
        Size = 500
      end>
    IndexDefs = <
      item
        Name = 'IND_PILOTATO'
        Fields = 'VALOREPILOTATO;VALOREPILOTA'
      end
      item
        Name = 'IND_PILOTA'
        Fields = 'VALOREPILOTA;VALOREPILOTATO'
      end>
    Params = <>
    StoreDefs = True
    Left = 328
    Top = 144
    object StringField7: TStringField
      DisplayLabel = 'Valore pilotato'
      FieldName = 'VALOREPILOTATO'
      Size = 50
    end
    object StringField8: TStringField
      DisplayLabel = 'Descrizione pilotato'
      FieldName = 'DESCRIZIONEPILOTATO'
      Visible = False
      Size = 500
    end
    object StringField10: TStringField
      DisplayLabel = 'Valore pilota'
      FieldName = 'VALOREPILOTA'
      Size = 50
    end
    object StringField11: TStringField
      DisplayLabel = 'Descrizione pilota'
      FieldName = 'DESCRIZIONEPILOTA'
      Visible = False
      Size = 500
    end
  end
  object DStampa: TDataSource
    DataSet = cdsStampa
    Left = 392
    Top = 200
  end
  object crea_X001: TOracleQuery
    Optimize = False
    Left = 160
    Top = 312
  end
  object selX001: TOracleDataSet
    Optimize = False
    Left = 208
    Top = 312
  end
  object cdsSpostaLivRel: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'VALOREPILOTATO'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRIZIONEPILOTATO'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'VALOREPILOTA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRIZIONEPILOTA'
        DataType = ftString
        Size = 500
      end>
    IndexDefs = <
      item
        Name = 'IND_PILOTATO'
        Fields = 'VALOREPILOTATO;VALOREPILOTA'
      end
      item
        Name = 'IND_PILOTA'
        Fields = 'VALOREPILOTA;VALOREPILOTATO'
      end>
    Params = <>
    StoreDefs = True
    Left = 464
    Top = 144
    object StringField9: TStringField
      DisplayLabel = 'Valore pilotato'
      FieldName = 'VALOREPILOTATO'
      Size = 50
    end
    object StringField12: TStringField
      DisplayLabel = 'Descrizione pilotato'
      FieldName = 'DESCRIZIONEPILOTATO'
      Visible = False
      Size = 500
    end
    object StringField13: TStringField
      DisplayLabel = 'Valore pilota'
      FieldName = 'VALOREPILOTA'
      Size = 50
    end
    object StringField14: TStringField
      DisplayLabel = 'Descrizione pilota'
      FieldName = 'DESCRIZIONEPILOTA'
      Visible = False
      Size = 500
    end
  end
  object selI030b: TOracleDataSet
    SQL.Strings = (
      'SELECT I030.ROWID, I030.*'
      'FROM   I030_RELAZIONI_ANAGRAFE I030'
      
        'ORDER BY I030.TABELLA, I030.ORDINE, I030.COLONNA, I030.DECORRENZ' +
        'A, I030.TIPO')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000060000000E00000054004100420045004C004C004100010000000000
      0E00000043004F004C004F004E004E0041000100000000001400000044004500
      43004F005200520045004E005A0041000100000000001E000000440045004300
      4F005200520045004E005A0041005F00460049004E0045000100000000000C00
      00004F005200440049004E004500010000000000080000005400490050004F00
      010000000000}
    OnCalcFields = selI030bCalcFields
    Left = 32
    Top = 312
    object selI030bTABELLA: TStringField
      DisplayLabel = 'Tabella'
      DisplayWidth = 25
      FieldName = 'TABELLA'
      Required = True
      Size = 40
    end
    object selI030bCOLONNA: TStringField
      DisplayLabel = 'Colonna'
      DisplayWidth = 25
      FieldName = 'COLONNA'
      Required = True
      Visible = False
      Size = 40
    end
    object selI030bDECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selI030bDECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selI030bORDINE: TIntegerField
      DisplayLabel = 'Ordine'
      DisplayWidth = 4
      FieldName = 'ORDINE'
      Required = True
    end
    object selI030bTIPO: TStringField
      DisplayLabel = 'Desc. tipo'
      FieldName = 'TIPO'
      Required = True
      Size = 1
    end
    object selI030bD_TIPO: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_TIPO'
      ReadOnly = True
      Size = 50
      Calculated = True
    end
    object selI030bTAB_ORIGINE: TStringField
      FieldName = 'TAB_ORIGINE'
      Size = 40
    end
    object selI030bCOL_ORIGINE: TStringField
      FieldKind = fkCalculated
      FieldName = 'COL_ORIGINE'
      Size = 40
      Calculated = True
    end
  end
  object selI035b: TOracleDataSet
    SQL.Strings = (
      'select relazione'
      'from   i035_relazioni_dettaglio'
      'where  tabella = :tabella'
      'and    colonna = :colonna'
      'and    decorrenza = :decorrenza'
      'order by num')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0054004100420045004C004C00410005000000
      0000000000000000100000003A0043004F004C004F004E004E00410005000000
      0000000000000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 88
    Top = 312
  end
  object cdsDatiDecFine: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DATO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TABELLA'
        DataType = ftString
        Size = 30
      end>
    IndexDefs = <
      item
        Name = 'INDICE'
        Fields = 'DATO;CODICE;TABELLA'
      end>
    IndexName = 'INDICE'
    Params = <>
    StoreDefs = True
    Left = 544
    Top = 144
  end
end
