object A050FOrologiDtM1: TA050FOrologiDtM1
  OldCreateOrder = True
  OnCreate = A050FOrologiDtM1Create
  OnDestroy = A050FOrologiDtM1Destroy
  Height = 373
  Width = 379
  object D305: TDataSource
    AutoEdit = False
    DataSet = Q305
    Left = 80
    Top = 8
  end
  object Q361: TOracleDataSet
    SQL.Strings = (
      'SELECT T361.*,T361.ROWID FROM T361_OROLOGI T361'
      'ORDER BY CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000F0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001000
      0000460055004E005A0049004F004E0045000100000000001200000043004100
      550053004D0045004E00530041000100000000000A0000005600450052005300
      4F000100000000001400000050004F005300540041005A0049004F004E004500
      0100000000002600000049004E0044004900520049005A005A004F005F005400
      450052004D0049004E0041004C0045000100000000001800000049004E004400
      4900520049005A005A004F005F00490050000100000000002000000052004900
      430045005A0049004F004E0045005F004D004500530053004100470001000000
      00002C0000004100500050004C004900430041005F0050004500520043004F00
      5200520045004E005A0041005F0050004D000100000000001A00000054004900
      50004F005F004C004F00430041004C0049005400410001000000000018000000
      43004F0044005F004C004F00430041004C004900540041000100000000001200
      000049004E0044004900520049005A005A004F000100000000000E0000005300
      430041005200490043004F0001000000000014000000520049004C0045005600
      410054004F0052004500010000000000}
    CachedUpdates = True
    BeforePost = Q361BeforePost
    AfterPost = Q361AfterPost
    AfterCancel = Q361AfterCancel
    BeforeDelete = Q361BeforeDelete
    AfterDelete = Q361AfterDelete
    AfterScroll = Q361AfterScroll
    OnNewRecord = Q361NewRecord
    Left = 12
    Top = 8
    object Q361CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T361_OROLOGI.CODICE'
      Size = 2
    end
    object Q361DESCRIZIONE: TStringField
      DisplayWidth = 100
      FieldName = 'DESCRIZIONE'
      Origin = 'T361_OROLOGI.DESCRIZIONE'
      Size = 100
    end
    object Q361FUNZIONE: TStringField
      FieldName = 'FUNZIONE'
      Origin = 'T361_OROLOGI.FUNZIONE'
      Size = 1
    end
    object Q361CAUSMENSA: TStringField
      FieldName = 'CAUSMENSA'
      Origin = 'T361_OROLOGI.CAUSMENSA'
      Size = 5
    end
    object Q361VERSO: TStringField
      FieldName = 'VERSO'
      Size = 1
    end
    object Q361POSTAZIONE: TStringField
      FieldName = 'POSTAZIONE'
      Size = 5
    end
    object Q361INDIRIZZO_TERMINALE: TStringField
      FieldName = 'INDIRIZZO_TERMINALE'
      Size = 5
    end
    object Q361INDIRIZZO_IP: TStringField
      FieldName = 'INDIRIZZO_IP'
      EditMask = '999.999.999.999;1;_'
      Size = 15
    end
    object Q361RICEZIONE_MESSAG: TStringField
      FieldName = 'RICEZIONE_MESSAG'
      Required = True
      Size = 1
    end
    object Q361APPLICA_PERCORRENZA_PM: TStringField
      FieldName = 'APPLICA_PERCORRENZA_PM'
      Size = 1
    end
    object Q361TIPO_LOCALITA: TStringField
      FieldName = 'TIPO_LOCALITA'
      Size = 1
    end
    object Q361COD_LOCALITA: TStringField
      FieldName = 'COD_LOCALITA'
      Size = 6
    end
    object Q361INDIRIZZO: TStringField
      FieldName = 'INDIRIZZO'
      Size = 60
    end
    object Q361D_LOCALITA: TStringField
      FieldKind = fkLookup
      FieldName = 'D_LOCALITA'
      LookupDataSet = SelLocalita
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_LOCALITA'
      Size = 40
      Lookup = True
    end
    object Q361SCARICO: TStringField
      FieldName = 'SCARICO'
    end
    object Q361RILEVATORE: TStringField
      FieldName = 'RILEVATORE'
      Size = 10
    end
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T305_CAUGIUSTIF'
      'ORDER BY CODICE')
    Optimize = False
    Left = 52
    Top = 8
  end
  object SelLocalita: TOracleDataSet
    SQL.Strings = (
      'select CODICE, CITTA DESCRIZIONE from t480_comuni t'
      'order by citta')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    Left = 16
    Top = 64
  end
  object DSelLocalita: TDataSource
    DataSet = SelLocalita
    Left = 72
    Top = 64
  end
  object dsrI100: TDataSource
    AutoEdit = False
    DataSet = selI100
    Left = 176
    Top = 8
  end
  object selI100: TOracleDataSet
    SQL.Strings = (
      'SELECT SCARICO FROM MONDOEDP.I100_PARSCARICO'
      'ORDER BY SCARICO')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000010000000E0000005300430041005200490043004F00010000000000}
    Left = 136
    Top = 8
  end
  object ControlloRilev: TOracleQuery
    SQL.Strings = (
      'select scarico, codice from T361_orologi'
      'where codice <> :CODICE'
      '  and rilevatore = :RILEV')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000000C0000003A00520049004C004500560005000000000000000000
      0000}
    Left = 32
    Top = 136
  end
end
