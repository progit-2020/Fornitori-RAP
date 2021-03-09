object A035FParScaricoDTM1: TA035FParScaricoDTM1
  OldCreateOrder = True
  OnCreate = A035FParScaricoDTM1Create
  OnDestroy = A035FParScaricoDTM1Destroy
  Height = 95
  Width = 155
  object D192: TDataSource
    DataSet = Q192
    Left = 88
    Top = 12
  end
  object Q191: TOracleDataSet
    SQL.Strings = (
      'SELECT T191.*,T191.ROWID FROM T191_PARPAGHE T191'
      'WHERE T191.TIPO_PARAMETRIZZAZIONE = :TIPOPAR'
      'ORDER BY CODICE')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A005400490050004F0050004100520005000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000110000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001000
      00005400490050004F00460049004C0045000100000000001600000044004500
      4600410055004C00540045004E00540045000100000000001600000054004100
      420045004C004C00410045004E00540045000100000000001200000043004100
      4D0050004F0045004E0054004500010000000000100000004E004F004D004500
      460049004C004500010000000000100000004400410054004100460049004C00
      4500010000000000100000004D0045005300450041004E004E004F0001000000
      00001400000046004F0052004D00410054004F004F0052004500010000000000
      1400000050005200450043004900530049004F004E0045000100000000001200
      00005500530045005200500041004700480045000100000000002C0000005300
      41004C0056004100540041004700470049004F005F004100550054004F004D00
      41005400490043004F0001000000000024000000530045005000410052004100
      54004F005200450044004500430049004D0041004C0049000100000000001A00
      00005400490050004F0044004100540041005F00460049004C00450001000000
      00002C0000005200490043005200450041005A0049004F004E0045005F004100
      550054004F004D00410054004900430041000100000000002C00000054004900
      50004F005F0050004100520041004D0045005400520049005A005A0041005A00
      49004F004E004500010000000000}
    CachedUpdates = True
    AfterInsert = Q191AfterInsert
    AfterEdit = Q191AfterEdit
    BeforePost = Q191BeforePost
    AfterPost = Q191AfterPost
    AfterCancel = Q191AfterCancel
    BeforeDelete = Q191BeforeDelete
    AfterDelete = Q191AfterDelete
    AfterScroll = Q191AfterScroll
    OnNewRecord = Q191NewRecord
    Left = 16
    Top = 12
    object Q191CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T191_PARPAGHE.CODICE'
      Size = 5
    end
    object Q191DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T191_PARPAGHE.DESCRIZIONE'
      Size = 40
    end
    object Q191TIPOFILE: TStringField
      FieldName = 'TIPOFILE'
      Origin = 'T191_PARPAGHE.TIPOFILE'
      Size = 1
    end
    object Q191DEFAULTENTE: TStringField
      FieldName = 'DEFAULTENTE'
      Origin = 'T191_PARPAGHE.DEFAULTENTE'
    end
    object Q191TABELLAENTE: TStringField
      FieldName = 'TABELLAENTE'
      Origin = 'T191_PARPAGHE.TABELLAENTE'
      Size = 50
    end
    object Q191CAMPOENTE: TStringField
      FieldName = 'CAMPOENTE'
      Origin = 'T191_PARPAGHE.CAMPOENTE'
      Size = 30
    end
    object Q191NOMEFILE: TStringField
      FieldName = 'NOMEFILE'
      Origin = 'T191_PARPAGHE.NOMEFILE'
      Size = 80
    end
    object Q191DATAFILE: TStringField
      FieldName = 'DATAFILE'
      Origin = 'T191_PARPAGHE.DATAFILE'
      Size = 10
    end
    object Q191MESEANNO: TStringField
      FieldName = 'MESEANNO'
      Origin = 'T191_PARPAGHE.MESEANNO'
      Size = 10
    end
    object Q191FORMATOORE: TStringField
      FieldName = 'FORMATOORE'
      Origin = 'T191_PARPAGHE.FORMATOORE'
      Size = 1
    end
    object Q191PRECISIONE: TStringField
      FieldName = 'PRECISIONE'
      Origin = 'T191_PARPAGHE.PRECISIONE'
      Size = 1
    end
    object Q191USERPAGHE: TStringField
      FieldName = 'USERPAGHE'
      Origin = 'T191_PARPAGHE.USERPAGHE'
    end
    object Q191SALVATAGGIO_AUTOMATICO: TStringField
      FieldName = 'SALVATAGGIO_AUTOMATICO'
      Size = 1
    end
    object Q191SEPARATOREDECIMALI: TStringField
      FieldName = 'SEPARATOREDECIMALI'
      Size = 1
    end
    object Q191TIPODATA_FILE: TStringField
      FieldName = 'TIPODATA_FILE'
      Size = 1
    end
    object Q191RICREAZIONE_AUTOMATICA: TStringField
      FieldName = 'RICREAZIONE_AUTOMATICA'
      Size = 1
    end
    object Q191TIPO_PARAMETRIZZAZIONE: TStringField
      FieldName = 'TIPO_PARAMETRIZZAZIONE'
      Required = True
      Size = 10
    end
  end
  object Q192: TOracleDataSet
    SQL.Strings = (
      'SELECT T192.*,T192.ROWID FROM T192_PARPAGHEDATI T192'
      'WHERE CODICE = :CODICE '
      'AND   TIPO_PARAMETRIZZAZIONE = :TIPOPAR'
      'ORDER BY POS')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000100000003A005400490050004F00500041005200050000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000000C00000043004F0044004900430045000100000000000600
      000050004F005300010000000000080000004C0055004E004700010000000000
      06000000440045004600010000000000080000005400490050004F0001000000
      0000080000004E004F004D0045000100000000002C0000005400490050004F00
      5F0050004100520041004D0045005400520049005A005A0041005A0049004F00
      4E004500010000000000}
    ReadOnly = True
    CachedUpdates = True
    BeforePost = Q192BeforePost
    AfterScroll = Q192AfterScroll
    OnCalcFields = Q192CalcFields
    OnNewRecord = Q192NewRecord
    Left = 52
    Top = 12
    object Q192CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T192_PARPAGHEDATI.CODICE'
      Visible = False
      Size = 5
    end
    object Q192TIPO: TStringField
      DisplayLabel = 'Tipo'
      DisplayWidth = 5
      FieldName = 'TIPO'
      Origin = 'T192_PARPAGHEDATI.TIPO'
      OnValidate = BDEQ192TIPOValidate
      Size = 1
    end
    object Q192D_TIPO: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 25
      FieldKind = fkCalculated
      FieldName = 'D_TIPO'
      Size = 40
      Calculated = True
    end
    object Q192NOME: TStringField
      DisplayLabel = 'Nome colonna'
      DisplayWidth = 10
      FieldName = 'NOME'
      Origin = 'T192_PARPAGHEDATI.CODICE'
    end
    object Q192POS: TIntegerField
      DisplayLabel = 'Pos.'
      DisplayWidth = 4
      FieldName = 'POS'
      Required = True
    end
    object Q192LUNG: TIntegerField
      DisplayLabel = 'Lung.'
      DisplayWidth = 5
      FieldName = 'LUNG'
    end
    object Q192DEF: TStringField
      DisplayLabel = 'Default'
      DisplayWidth = 30
      FieldName = 'DEF'
      Origin = 'T192_PARPAGHEDATI.DEF'
      Size = 80
    end
    object Q192TIPO_PARAMETRIZZAZIONE: TStringField
      FieldName = 'TIPO_PARAMETRIZZAZIONE'
      Required = True
      Size = 10
    end
  end
end
