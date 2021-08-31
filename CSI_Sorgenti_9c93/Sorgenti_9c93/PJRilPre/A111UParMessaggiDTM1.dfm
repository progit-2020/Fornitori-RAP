object A111FParMessaggiDTM1: TA111FParMessaggiDTM1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 82
  Width = 77
  object selT291: TOracleDataSet
    SQL.Strings = (
      'select T291.*, T291.rowid from T291_PARMESSAGGI T291'
      'order by CODICE')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F005F00460049004C004500010000000000120000004E00
      4F004D0045005F00460049004C00450001000000000012000000440041005400
      41005F00460049004C0045000100000000001800000044004500460041005500
      4C0054005F00460049004C0045000100000000001A0000004E0055004D005F00
      520049005000450054005F004D00530047000100000000001A0000004E005500
      4D005F0047004700560041004C005F004D00530047000100000000001C000000
      4E0055004D005F004D004D0049004E0044005F0043004F004E00530001000000
      000018000000460049004C00540052004F005F0041004E004100470052000100
      00000000160000005400490050004F005F00460049004C00540052004F000100
      0000000018000000520045004700490053005400520041005F004D0053004700
      010000000000240000005400490050004F005F00520045004700490053005400
      520041005A0049004F004E004500010000000000}
    CachedUpdates = True
    AfterInsert = selT291AfterInsert
    AfterEdit = selT291AfterEdit
    BeforePost = selT291BeforePost
    AfterPost = selT291AfterPost
    BeforeCancel = selT291BeforeCancel
    AfterCancel = selT291AfterCancel
    BeforeDelete = selT291BeforeDelete
    AfterDelete = selT291AfterDelete
    AfterScroll = selT291AfterScroll
    OnNewRecord = selT291NewRecord
    Left = 24
    Top = 16
    object selT291CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Required = True
      OnChange = selT291CODICEChange
      Size = 5
    end
    object selT291DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT291DEFAULT_FILE: TStringField
      DisplayLabel = 'Funzione batch'
      FieldName = 'DEFAULT_FILE'
      Size = 1
    end
    object selT291TIPO_FILE: TStringField
      DisplayLabel = 'Tipo supporto'
      FieldName = 'TIPO_FILE'
      Size = 1
    end
    object selT291NOME_FILE: TStringField
      DisplayLabel = 'Nome file/tabella'
      FieldName = 'NOME_FILE'
      Size = 80
    end
    object selT291DATA_FILE: TStringField
      DisplayLabel = 'Formato data'
      FieldName = 'DATA_FILE'
      Size = 10
    end
    object selT291TIPO_REGISTRAZIONE: TStringField
      DisplayLabel = 'Tipo reg.'
      FieldName = 'TIPO_REGISTRAZIONE'
      Size = 1
    end
    object selT291REGISTRA_MSG: TStringField
      DisplayLabel = 'Registra'
      FieldName = 'REGISTRA_MSG'
      Size = 1
    end
    object selT291NUM_RIPET_MSG: TFloatField
      DisplayLabel = 'Ripetizioni'
      FieldName = 'NUM_RIPET_MSG'
    end
    object selT291NUM_GGVAL_MSG: TFloatField
      DisplayLabel = 'GG validit'#224
      FieldName = 'NUM_GGVAL_MSG'
    end
    object selT291NUM_MMIND_CONS: TFloatField
      DisplayLabel = 'Mesi consuntivo'
      FieldName = 'NUM_MMIND_CONS'
    end
    object selT291NUM_MMIND_VALID: TIntegerField
      DisplayLabel = 'Mesi validit'#224
      FieldName = 'NUM_MMIND_VALID'
    end
    object selT291TIPO_FILTRO: TStringField
      DisplayLabel = 'Tipo filtro'
      FieldName = 'TIPO_FILTRO'
      Size = 1
    end
    object selT291FILTRO_ANAGR: TStringField
      DisplayLabel = 'Filtro'
      FieldName = 'FILTRO_ANAGR'
    end
  end
end
