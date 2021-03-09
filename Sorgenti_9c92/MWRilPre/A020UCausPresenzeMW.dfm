inherited A020FCausPresenzeMW: TA020FCausPresenzeMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 643
  object chkT276: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(DISTINCT DALLE),COUNT(DISTINCT ALLE) '
      'FROM T276_VOCIPAGHEPRESENZA'
      'WHERE CODICE = :CODICE'
      'GROUP BY TIPOGIORNO'
      'HAVING COUNT(DISTINCT DALLE) <> COUNT(DISTINCT ALLE)')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 230
    Top = 9
  end
  object selT275lkp: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE'
      'ORDER BY CODICE')
    Optimize = False
    AfterOpen = selT275lkpAfterOpen
    OnFilterRecord = selT275lkpOreNormFilterRecord
    Left = 484
    Top = 6
  end
  object dsrT275lkp: TDataSource
    AutoEdit = False
    DataSet = selT275lkp
    Left = 484
    Top = 52
  end
  object selT162: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE FROM T162_INDENNITA WHERE '
      '  TIPO = '#39'Z'#39' AND '
      '  CODICE NOT IN '
      
        '    (SELECT CODICE FROM T164_ASSOCIAZIONIINDENNITA WHERE TIPO_AS' +
        'SOCIAZIONE = '#39'A'#39' UNION SELECT INDENNITA FROM T160_PROFILIINDENNI' +
        'TA)'
      'ORDER BY CODICE')
    Optimize = False
    Left = 432
    Top = 6
  end
  object dsrT162: TDataSource
    DataSet = selT162
    Left = 432
    Top = 52
  end
  object updT277: TOracleQuery
    SQL.Strings = (
      'UPDATE T277_CAUFASCEABILITATE'
      'SET CODICE = :CODICE'
      'WHERE CODICE = :CODICE_OLD'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A0043004F0044004900430045005F004F004C004400
      050000000000000000000000}
    Left = 380
    Top = 7
  end
  object updT276: TOracleQuery
    SQL.Strings = (
      'UPDATE T276_VOCIPAGHEPRESENZA '
      'SET CODICE = :CODICE'
      'WHERE CODICE = :CODICE_OLD')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A0043004F0044004900430045005F004F004C004400
      050000000000000000000000}
    Left = 329
    Top = 7
  end
  object selT305: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice FROM T305_CauGiustif'
      '  WHERE Codice = :Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 139
    Top = 8
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice,Descrizione FROM T265_CauAssenze '
      'ORDER BY Codice')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E004500010000000000}
    Left = 97
    Top = 8
    object selT265CODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT265DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object dsrT265: TDataSource
    DataSet = selT265
    Left = 98
    Top = 52
  end
  object dsrT270: TDataSource
    DataSet = selT270
    Left = 51
    Top = 52
  end
  object selT270: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T270_RaggrPresenze ORDER BY Codice')
    Optimize = False
    Filtered = True
    OnFilterRecord = selT270FilterRecord
    Left = 52
    Top = 8
  end
  object selT277: TOracleDataSet
    SQL.Strings = (
      'select T277.*, T277.ROWID '
      'from T277_CAUFASCEABILITATE T277'
      'where CODICE = :CODICE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000040000000C00000043004F0044004900430045000100000000001600
      00005400490050004F005F00470049004F0052004E004F000100000000000A00
      0000440041004C004C0045000100000000000800000041004C004C0045000100
      00000000}
    BeforePost = selT277BeforePost
    AfterPost = selT277AfterPost
    BeforeDelete = selT277BeforeDelete
    AfterDelete = selT277AfterPost
    OnCalcFields = selT277CalcFields
    OnNewRecord = selT277NewRecord
    Left = 279
    Top = 8
    object selT277CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT277TIPO_GIORNO: TStringField
      DisplayLabel = 'Tipo Giorno'
      FieldName = 'TIPO_GIORNO'
      Required = True
      OnValidate = selT277TIPO_GIORNOValidate
      Size = 1
    end
    object selT277DESC_GIORNO: TStringField
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'DESC_GIORNO'
      Calculated = True
    end
    object selT277DALLE: TStringField
      DisplayLabel = 'Dalle ore'
      FieldName = 'DALLE'
      Required = True
      OnValidate = selT277DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT277ALLE: TStringField
      DisplayLabel = 'Alle ore'
      FieldName = 'ALLE'
      OnValidate = selT277DALLEValidate
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object selT277FASCE_PN: TStringField
      DisplayLabel = 'Punti nom.'
      FieldName = 'FASCE_PN'
      OnValidate = selT277FASCE_PNValidate
      Size = 1
    end
  end
  object dsrT277: TDataSource
    DataSet = selT277
    Left = 279
    Top = 53
  end
  object dsrT276: TDataSource
    DataSet = selT276
    Left = 184
    Top = 54
  end
  object selT276: TOracleDataSet
    SQL.Strings = (
      'SELECT T276.*,ROWID '
      'FROM T276_VOCIPAGHEPRESENZA T276'
      'WHERE CODICE = :CODICE'
      'ORDER BY TIPOGIORNO,DALLE,LIMITE')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    BeforePost = selT276BeforePost
    AfterPost = selT276AfterPost
    BeforeDelete = selT276BeforeDelete
    AfterDelete = selT276AfterPost
    OnNewRecord = selT276NewRecord
    Left = 184
    Top = 10
    object selT276CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Visible = False
      Size = 5
    end
    object selT276TIPOGIORNO: TStringField
      DisplayLabel = 'Tipo giorno'
      FieldName = 'TIPOGIORNO'
      Required = True
      OnValidate = selT276TIPOGIORNOValidate
      Size = 2
    end
    object selT276DALLE: TStringField
      DisplayLabel = 'Dalle'
      FieldName = 'DALLE'
      Required = True
      OnValidate = selT276DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selT276ALLE: TStringField
      DisplayLabel = 'Alle'
      FieldName = 'ALLE'
      Required = True
      OnValidate = selT276DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selT276LIMITE: TStringField
      DisplayLabel = 'Fino a'
      FieldName = 'LIMITE'
      Required = True
      OnValidate = selT276DALLEValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selT276VOCEPAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCEPAGHE'
      Required = True
      Size = 6
    end
  end
  object selT275lkpOreNorm: TOracleDataSet
    SQL.Strings = (
      
        'SELECT 1 ORDINE, '#39'* L'#39' CODICE, '#39'NON CAUSALIZZATO'#39' DESCRIZIONE FR' +
        'OM DUAL'
      'UNION'
      'SELECT 2 ORDINE,CODICE,DESCRIZIONE FROM T275_CAUPRESENZE'
      'WHERE ORENORMALI <> '#39'A'#39
      'ORDER BY ORDINE,CODICE')
    Optimize = False
    AfterOpen = selT275lkpAfterOpen
    OnFilterRecord = selT275lkpOreNormFilterRecord
    Left = 563
    Top = 6
  end
  object dsrT275lkpOreNorm: TDataSource
    AutoEdit = False
    DataSet = selT275lkpOreNorm
    Left = 563
    Top = 52
  end
end
