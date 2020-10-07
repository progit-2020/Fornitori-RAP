object A039FREGREPERIBDTM1: TA039FREGREPERIBDTM1
  OldCreateOrder = True
  OnCreate = A034FINTPAGHEDTM1Create
  OnDestroy = A034FINTPAGHEDTM1Destroy
  Height = 63
  Width = 83
  object selT350: TOracleDataSet
    SQL.Strings = (
      'SELECT T350.*,T350.ROWID '
      '  FROM T350_REGREPERIB T350'
      ' ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000110000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00004F005200410049004E0049005A0049004F000100000000000E0000004F00
      52004100460049004E0045000100000000000E0000005400490050004F004F00
      52004500010000000000140000004F00520045004E004F0052004D0041004C00
      49000100000000001C0000004F005200450043004F004D005000520045005300
      45004E005A004100010000000000120000005400490050004F00540055005200
      4E004F000100000000001C000000520041004700470052005500500050004100
      4D0045004E0054004F00010000000000140000004F00520045004E004F004E00
      43004100550053000100000000001400000054004F004C004C00450052004100
      4E005A00410001000000000010000000560050005F005400550052004E004F00
      0100000000000C000000560050005F004F00520045000100000000001A000000
      560050005F004D0041004700470049004F005200410054004500010000000000
      20000000560050005F004E004F004E004D0041004700470049004F0052004100
      54004500010000000000180000005400550052004E004F005F0049004E005400
      450052004F0001000000000018000000440045005400520041005A005F004D00
      45004E0053004100010000000000}
    CachedUpdates = True
    Filtered = True
    BeforePost = selT350BeforePost
    AfterPost = selT350AfterPost
    AfterCancel = selT350AfterCancel
    BeforeDelete = selT350BeforeDelete
    AfterDelete = selT350AfterDelete
    OnFilterRecord = FiltroDizionario
    OnNewRecord = selT350NewRecord
    Left = 20
    Top = 4
    object selT350CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T350_REGREPERIB.CODICE'
      Required = True
      Size = 5
    end
    object selT350DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      Required = True
      Size = 40
    end
    object selT350ORAINIZIO: TDateTimeField
      FieldName = 'ORAINIZIO'
      Origin = 'T350_REGREPERIB.ORAINIZIO'
      Required = True
      OnGetText = selT350ORAINIZIOGetText
      OnSetText = SetTextOre
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selT350ORAFINE: TDateTimeField
      FieldName = 'ORAFINE'
      Origin = 'T350_REGREPERIB.ORAFINE'
      Required = True
      OnGetText = selT350ORAINIZIOGetText
      OnSetText = SetTextOre
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selT350TIPOORE: TStringField
      FieldName = 'TIPOORE'
      Origin = 'T350_REGREPERIB.TIPOORE'
      Size = 1
    end
    object selT350ORENORMALI: TDateTimeField
      FieldName = 'ORENORMALI'
      Origin = 'T350_REGREPERIB.ORENORMALI'
      OnGetText = selT350ORAINIZIOGetText
      OnSetText = SetTextOre
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selT350ORECOMPRESENZA: TDateTimeField
      FieldName = 'ORECOMPRESENZA'
      Origin = 'T350_REGREPERIB.ORECOMPRESENZA'
      OnGetText = selT350ORAINIZIOGetText
      DisplayFormat = 'hh.mm'
      EditMask = '!90:00;1;_'
    end
    object selT350TIPOTURNO: TStringField
      FieldName = 'TIPOTURNO'
      Origin = 'T350_REGREPERIB.TIPOTURNO'
      OnValidate = selT350TURNO_INTEROValidate
      Size = 1
    end
    object selT350RAGGRUPPAMENTO: TStringField
      FieldName = 'RAGGRUPPAMENTO'
      Origin = 'T350_REGREPERIB.RAGGRUPPAMENTO'
    end
    object selT350ORENONCAUS: TStringField
      FieldName = 'ORENONCAUS'
      Origin = 'T350_REGREPERIB.CODICE'
      Size = 1
    end
    object selT350TOLLERANZA: TFloatField
      FieldName = 'TOLLERANZA'
      Origin = 'T350_REGREPERIB.DESCRIZIONE'
      MaxValue = 99.000000000000000000
    end
    object selT350VP_TURNO: TStringField
      FieldName = 'VP_TURNO'
      Size = 6
    end
    object selT350VP_ORE: TStringField
      FieldName = 'VP_ORE'
      Size = 6
    end
    object selT350VP_MAGGIORATE: TStringField
      FieldName = 'VP_MAGGIORATE'
      Size = 6
    end
    object selT350VP_NONMAGGIORATE: TStringField
      FieldName = 'VP_NONMAGGIORATE'
      Size = 6
    end
    object selT350VP_GETTONE_CHIAMATA: TStringField
      FieldName = 'VP_GETTONE_CHIAMATA'
      Size = 6
    end
    object selT350VP_TURNI_OLTREMAX: TStringField
      FieldName = 'VP_TURNI_OLTREMAX'
      Size = 6
    end
    object selT350TURNO_INTERO: TStringField
      FieldName = 'TURNO_INTERO'
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object selT350DETRAZ_MENSA: TStringField
      FieldName = 'DETRAZ_MENSA'
      Size = 1
    end
    object selT350TIPOLOGIA: TStringField
      FieldName = 'TIPOLOGIA'
      Size = 1
    end
    object selT350PIANIF_MAX_MESE: TIntegerField
      FieldName = 'PIANIF_MAX_MESE'
      MaxValue = 99
      MinValue = 1
    end
    object selT350PIANIF_MAX_MESE_TURNI_INTERI: TStringField
      FieldName = 'PIANIF_MAX_MESE_TURNI_INTERI'
      Size = 1
    end
    object selT350ORE_MIN_INDENNITA: TStringField
      FieldName = 'ORE_MIN_INDENNITA'
      OnValidate = selT350ORE_MIN_INDENNITAValidate
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object selT350BLOCCA_MAX_MESE: TStringField
      FieldName = 'BLOCCA_MAX_MESE'
      Size = 1
    end
    object selT350TOLL_CHIAMATA_INIZIO: TStringField
      FieldName = 'TOLL_CHIAMATA_INIZIO'
      OnValidate = selT350TOLL_CHIAMATA_INIZIOValidate
      EditMask = '!99:99;1;_'
      Size = 5
    end
    object selT350TOLL_CHIAMATA_FINE: TStringField
      FieldName = 'TOLL_CHIAMATA_FINE'
      OnValidate = selT350TOLL_CHIAMATA_FINEValidate
      EditMask = '!99:99;1;_'
      Size = 5
    end
  end
end
