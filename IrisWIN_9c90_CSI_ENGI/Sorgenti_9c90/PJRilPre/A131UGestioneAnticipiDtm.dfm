inherited A131FGestioneAnticipiDtm: TA131FGestioneAnticipiDtm
  OldCreateOrder = True
  Height = 258
  Width = 267
  object selM060: TOracleDataSet
    SQL.Strings = (
      'SELECT M060.*,M140.PROTOCOLLO,M060.ROWID'
      'FROM M060_ANTICIPI M060, M140_RICHIESTE_MISSIONI M140 '
      'WHERE M060.PROGRESSIVO = :PROGRESSIVO'
      'AND M060.ID_MISSIONE = M140.ID(+)'
      'ORDER BY DATA_MISSIONE DESC')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    OracleDictionary.DefaultValues = True
    BeforeEdit = BeforeEdit
    BeforePost = BeforePostNoStorico
    AfterPost = AfterPost
    AfterDelete = AfterDelete
    AfterScroll = selM060AfterScroll
    OnCalcFields = selM060CalcFields
    OnNewRecord = selM060NewRecord
    Left = 16
    Top = 10
    object selM060DATA_MISSIONE: TDateTimeField
      DisplayLabel = 'Data missione'
      DisplayWidth = 10
      FieldName = 'DATA_MISSIONE'
      EditMask = '!00/00/0000;1;_'
    end
    object selM060PROTOCOLLO: TStringField
      DisplayLabel = 'Protocollo'
      DisplayWidth = 12
      FieldName = 'PROTOCOLLO'
      Size = 10
    end
    object selM060CASSA: TStringField
      DisplayLabel = 'Cassa'
      FieldName = 'CASSA'
      Visible = False
      Size = 10
    end
    object selM060DATA_MOVIMENTO: TDateTimeField
      DisplayLabel = 'Data movimento'
      FieldName = 'DATA_MOVIMENTO'
      Visible = False
      EditMask = '!00/00/0000;1;_'
    end
    object selM060ANNO_MOVIMENTO: TStringField
      DisplayLabel = 'Anno movimento'
      FieldName = 'ANNO_MOVIMENTO'
      Visible = False
      Size = 4
    end
    object selM060NROSOSP: TFloatField
      DisplayLabel = 'Num.sospeso'
      FieldName = 'NROSOSP'
      Visible = False
    end
    object selM060NUM_MOVIMENTO: TFloatField
      DisplayLabel = 'Num.movimento'
      FieldName = 'NUM_MOVIMENTO'
      Visible = False
    end
    object selM060COD_VOCE: TStringField
      DisplayLabel = 'Voce'
      DisplayWidth = 8
      FieldName = 'COD_VOCE'
    end
    object selM060DESC_CODVOCE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'DESC_CODVOCE'
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VOCE'
      Size = 100
      Lookup = True
    end
    object selM060QUANTITA: TFloatField
      DisplayLabel = 'Quantit'#224
      DisplayWidth = 5
      FieldName = 'QUANTITA'
    end
    object selM060IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      DisplayWidth = 5
      FieldName = 'IMPORTO'
    end
    object selM060FLAG_TOTALIZZATORE: TStringField
      DisplayLabel = 'Incl.importo totale'
      DisplayWidth = 1
      FieldName = 'FLAG_TOTALIZZATORE'
    end
    object selM060D_STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'D_STATO'
      Calculated = True
    end
    object selM060STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 5
      FieldName = 'STATO'
      Visible = False
    end
    object selM060DATA_IMPOSTAZIONE: TDateTimeField
      FieldName = 'DATA_IMPOSTAZIONE_STATO'
      Visible = False
      EditMask = '!00/00/0000;1;_'
    end
    object selM060NOTE: TStringField
      FieldName = 'NOTE'
      Visible = False
      Size = 500
    end
    object selM060PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selM060ITA_EST: TStringField
      FieldName = 'ITA_EST'
      Visible = False
      Size = 1
    end
    object selM060ID_MISSIONE: TIntegerField
      FieldName = 'ID_MISSIONE'
      Visible = False
    end
  end
  object dscM060: TDataSource
    Left = 16
    Top = 56
  end
  object dscM040: TDataSource
    OnDataChange = dscM040DataChange
    Left = 73
    Top = 52
  end
end
