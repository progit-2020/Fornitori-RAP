inherited A153FPartecipEventiStraordDtM: TA153FPartecipEventiStraordDtM
  OldCreateOrder = True
  Height = 125
  Width = 235
  object selT724: TOracleDataSet
    SQL.Strings = (
      'select T724.*,rowid from T724_EVENTI_STR_INDIVIDUALI T724'
      'where PROGRESSIVO = :PROGRESSIVO'
      'order by ID desc, DAL desc')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    BeforePost = BeforePostNoStorico
    OnNewRecord = selT724NewRecord
    Left = 24
    Top = 16
    object selT724PROGRESSIVO: TIntegerField
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selT724ID: TIntegerField
      DisplayWidth = 5
      FieldName = 'ID'
    end
    object selT724D_CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldKind = fkLookup
      FieldName = 'D_CODICE'
      LookupDataSet = selT722
      LookupKeyFields = 'ID'
      LookupResultField = 'CODICE'
      KeyFields = 'ID'
      Size = 10
      Lookup = True
    end
    object selT724D_DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_DESCRIZIONE'
      LookupDataSet = selT722
      LookupKeyFields = 'ID'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ID'
      Size = 80
      Lookup = True
    end
    object selT724DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
      EditMask = '!00/00/0000;1;_'
    end
    object selT724AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
      EditMask = '!00/00/0000;1;_'
    end
    object selT724SERVIZI: TStringField
      DisplayLabel = 'Servizi'
      DisplayWidth = 20
      FieldName = 'SERVIZI'
      Required = True
      Size = 200
    end
    object selT724DELEGATO: TStringField
      DisplayLabel = 'Delegato'
      FieldName = 'DELEGATO'
      OnValidate = selT724DELEGATOValidate
      Size = 1
    end
    object selT724TIPO_LAVORO: TStringField
      DisplayLabel = 'Tipo lavoro'
      FieldName = 'TIPO_LAVORO'
      Visible = False
      Size = 5
    end
    object selT724D_TIPO_LAVORO: TStringField
      DisplayLabel = 'Tipo lavoro'
      FieldKind = fkLookup
      FieldName = 'D_TIPO_LAVORO'
      LookupDataSet = cdsTipoLavoro
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'TIPO_LAVORO'
      Lookup = True
    end
    object selT724D_DECORRENZA: TDateTimeField
      FieldKind = fkLookup
      FieldName = 'D_DECORRENZA'
      LookupDataSet = selT722
      LookupKeyFields = 'ID'
      LookupResultField = 'DECORRENZA'
      KeyFields = 'ID'
      Visible = False
      Lookup = True
    end
    object selT724D_DECORRENZA_FINE: TDateTimeField
      FieldKind = fkLookup
      FieldName = 'D_DECORRENZA_FINE'
      LookupDataSet = selT722
      LookupKeyFields = 'ID'
      LookupResultField = 'DECORRENZA_FINE'
      KeyFields = 'ID'
      Visible = False
      Lookup = True
    end
  end
  object selT722: TOracleDataSet
    SQL.Strings = (
      'select * from T722_PERIODI_EVENTI_STR '
      'order by CODICE,DECORRENZA desc')
    Optimize = False
    Left = 88
    Top = 16
    object selT722ID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selT722CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selT722DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT722DECORRENZA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
    end
    object selT722DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
    end
  end
  object selServizi: TOracleDataSet
    Optimize = False
    Left = 152
    Top = 16
  end
  object cdsTipoLavoro: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 24
    Top = 64
    Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020014000B4445534352495A49
      4F4E4501004900000001000557494454480200020014000000}
  end
end
