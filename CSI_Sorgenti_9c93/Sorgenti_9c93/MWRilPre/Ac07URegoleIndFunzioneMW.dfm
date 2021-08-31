inherited Ac07FRegoleIndFunzioneMW: TAc07FRegoleIndFunzioneMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 184
  Width = 408
  object selCSI005: TOracleDataSet
    SQL.Strings = (
      'select CSI005.*, CSI005.ROWID '
      'from CSI005_INDFUNZIONE_FASCE CSI005'
      'where CSI005.ID = :ID'
      'order by CSI005.FASCIA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selCSI005BeforePost
    AfterPost = selCSI005AfterPost
    BeforeDelete = selCSI005BeforeDelete
    AfterDelete = selCSI005AfterDelete
    OnNewRecord = selCSI005NewRecord
    Left = 88
    Top = 16
    object selCSI005ID: TIntegerField
      FieldName = 'ID'
      Visible = False
    end
    object selCSI005FASCIA: TStringField
      DisplayLabel = 'Fascia'
      FieldName = 'FASCIA'
      Size = 5
    end
    object selCSI005D_FASCIA: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkLookup
      FieldName = 'D_FASCIA'
      LookupDataSet = selT210
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'FASCIA'
      Size = 40
      Lookup = True
    end
    object selCSI005IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
    end
    object selCSI005MAGG_DISAGIO_SERALE: TFloatField
      DisplayLabel = 'Magg. disagio serale'
      FieldName = 'MAGG_DISAGIO_SERALE'
    end
  end
  object dsrCSI005: TDataSource
    DataSet = selCSI005
    Left = 88
    Top = 72
  end
  object selCodice: TOracleDataSet
    Optimize = False
    Left = 152
    Top = 16
    object selCodiceCODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
    end
    object selCodiceDESCRIZIONE: TStringField
      DisplayWidth = 150
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
  end
  object selT200: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from T200_CONTRATTI'
      'order by CODICE')
    Optimize = False
    Left = 208
    Top = 16
    object selT200CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT200DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object selID_CSI004: TOracleQuery
    SQL.Strings = (
      'select CSI004_ID.NEXTVAL from DUAL')
    Optimize = False
    Left = 24
    Top = 72
  end
  object selT210: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE'
      'from T210_MAGGIORAZIONI'
      'order by CODICE')
    Optimize = False
    Left = 264
    Top = 16
    object selT210CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Size = 5
    end
    object selT210DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object insCSI005: TOracleQuery
    SQL.Strings = (
      'insert into CSI005_INDFUNZIONE_FASCE'
      'select :ID_NEW ID, FASCIA, IMPORTO, MAGG_DISAGIO_SERALE'
      'from CSI005_INDFUNZIONE_FASCE'
      'where ID = :ID_OLD')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00490044005F004E0045005700030000000000
      0000000000000E0000003A00490044005F004F004C0044000300000000000000
      00000000}
    Left = 88
    Top = 128
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T265_CAUASSENZE '
      'ORDER BY CODICE')
    Optimize = False
    Left = 318
    Top = 16
  end
end
