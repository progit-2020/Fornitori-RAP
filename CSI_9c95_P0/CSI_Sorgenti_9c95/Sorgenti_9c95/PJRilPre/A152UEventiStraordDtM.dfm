inherited A152FEventiStraordDtM: TA152FEventiStraordDtM
  OldCreateOrder = True
  Height = 206
  Width = 267
  object selT722: TOracleDataSet
    SQL.Strings = (
      'select T722.*,rowid from T722_PERIODI_EVENTI_STR T722'
      'order by CODICE,DECORRENZA,DECORRENZA_FINE')
    Optimize = False
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T722_ID'
    QBEDefinition.QBEFieldDefs = {
      05000000090000000C00000043004F0044004900430045000100000000001400
      00004400450043004F005200520045004E005A0041000100000000001E000000
      4400450043004F005200520045004E005A0041005F00460049004E0045000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      000000000400000049004400010000000000140000004F00520045005F005400
      4F00540041004C004900010000000000120000004F00520045005F0049004E00
      44004900560001000000000016000000430041005500530041004C0045005F00
      5300540052000100000000001E000000430041005500530041004C0045005F00
      5300540052005F0044004F004D00010000000000}
    BeforeInsert = BeforeInsert
    BeforeEdit = BeforeEdit
    BeforePost = BeforePost
    AfterScroll = selT722AfterScroll
    OnNewRecord = OnNewRecord
    Left = 32
    Top = 24
    object selT722ID: TIntegerField
      DisplayWidth = 5
      FieldName = 'ID'
      ReadOnly = True
    end
    object selT722CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 10
    end
    object selT722DECORRENZA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      EditMask = '!00/00/0000;1;_'
    end
    object selT722DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      EditMask = '!00/00/0000;1;_'
    end
    object selT722DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 30
      FieldName = 'DESCRIZIONE'
      Size = 80
    end
    object selT722STATO: TStringField
      DisplayLabel = 'Stato'
      FieldName = 'STATO'
      Visible = False
      Size = 1
    end
    object selT722D_STATO: TStringField
      DisplayLabel = 'Stato'
      DisplayWidth = 8
      FieldKind = fkLookup
      FieldName = 'D_STATO'
      LookupDataSet = cdsStato
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'STATO'
      Size = 10
      Lookup = True
    end
    object selT722ORE_TOTALI: TStringField
      FieldName = 'ORE_TOTALI'
      Visible = False
      Size = 7
    end
    object selT722ORE_INDIV: TStringField
      DisplayLabel = 'Ore individuali'
      FieldName = 'ORE_INDIV'
      OnValidate = selT722ORE_INDIVValidate
      EditMask = '!9990:00;1;_'
      Size = 7
    end
    object selT722CAUSALE_STR: TStringField
      DisplayLabel = 'Causale'
      FieldName = 'CAUSALE_STR'
      OnSetText = CausaleSetText
      OnValidate = ValidaCausale
      Size = 5
    end
    object selT722D_CAUSALE_STR: TStringField
      DisplayLabel = 'Desc. causale'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_STR'
      LookupDataSet = selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE_STR'
      Size = 40
      Lookup = True
    end
    object selT722CAUSALE_STR_DOM: TStringField
      DisplayLabel = 'Caus. Domenica'
      FieldName = 'CAUSALE_STR_DOM'
      OnSetText = CausaleSetText
      OnValidate = ValidaCausale
      Size = 5
    end
    object selT722D_CAUSALE_STR_DOM: TStringField
      DisplayLabel = 'Desc. caus. Domenica'
      DisplayWidth = 20
      FieldKind = fkLookup
      FieldName = 'D_CAUSALE_STR_DOM'
      LookupDataSet = selT275
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'CAUSALE_STR_DOM'
      Size = 40
      Lookup = True
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE, DESCRIZIONE'
      'FROM T275_CAUPRESENZE'
      'ORDER BY CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 104
    Top = 24
  end
  object selT723: TOracleDataSet
    SQL.Strings = (
      'select T723.*,rowid from T723_BUDGET_EVENTI_STR T723'
      'where ID = :ID'
      'order by CODGRUPPO,TIPO')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    SequenceField.Field = 'ID'
    SequenceField.Sequence = 'T722_ID'
    BeforePost = selT723BeforePost
    OnNewRecord = selT723NewRecord
    Left = 32
    Top = 80
    object selT723ID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selT723CODGRUPPO: TStringField
      DisplayLabel = 'Codice budget'
      FieldName = 'CODGRUPPO'
      Size = 10
    end
    object selT723DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT723FILTRO_ANAGRAFE: TStringField
      DisplayLabel = 'Servizi'
      DisplayWidth = 30
      FieldName = 'FILTRO_ANAGRAFE'
      Size = 4000
    end
    object selT723TIPO: TStringField
      FieldName = 'TIPO'
      Visible = False
      Size = 5
    end
    object selT723ORE: TStringField
      DisplayLabel = 'Ore disponibili'
      FieldName = 'ORE'
      OnValidate = selT722ORE_INDIVValidate
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT723IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
      Visible = False
    end
  end
  object dsrT723: TDataSource
    DataSet = selT723
    Left = 32
    Top = 128
  end
  object cdsStato: TClientDataSet
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
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 104
    Top = 128
    Data = {
      550000009619E0BD010000001800000002000000000003000000550006434F44
      49434501004900000001000557494454480200020014000B4445534352495A49
      4F4E450100490000000100055749445448020002000A000000}
  end
  object selServizi: TOracleDataSet
    Optimize = False
    Left = 176
    Top = 22
  end
  object scrT723BeforePost: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :result := usr_t723f_beforepost(p_id => :p_id,'
      '                                  p_rowid => :p_rowid,'
      '                                  p_lista => :p_lista);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0052004500530055004C005400050000000000
      000000000000100000003A0050005F0052004F00570049004400050000000000
      000000000000100000003A0050005F004C004900530054004100050000000000
      0000000000000A0000003A0050005F0049004400030000000000000000000000}
    Left = 176
    Top = 80
  end
end
