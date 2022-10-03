inherited A016FCausAssenzeMW: TA016FCausAssenzeMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 135
  Width = 580
  object selAssDaValidare: TOracleDataSet
    SQL.Strings = (
      'select cognome,nome,matricola,data,causale'
      
        'from t040_giustificativi t040, t265_cauassenze t265, t030_anagra' +
        'fico t030'
      'where t265.codice = :CODICE'
      'and t040.causale = t265.codice'
      'and t265.validazione = '#39'S'#39
      'and nvl(t040.scheda,'#39'*'#39') <> '#39'V'#39
      'and t040.progressivo = t030.progressivo'
      'order by cognome,nome,matricola,data,causale')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 400
    Top = 64
  end
  object selT265T275: TOracleDataSet
    SQL.Strings = (
      'SELECT '#39'A'#39' TIPO,CODICE,DESCRIZIONE FROM T265_CAUASSENZE UNION'
      'SELECT '#39'P'#39',CODICE,DESCRIZIONE FROM T275_CAUPRESENZE'
      '')
    Optimize = False
    Left = 400
    Top = 12
  end
  object Q305: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice FROM T305_CauGiustif'
      '  WHERE Codice = :Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 348
    Top = 12
  end
  object Q275: TOracleDataSet
    SQL.Strings = (
      'SELECT Codice FROM T275_CauPresenze '
      '  WHERE Codice = :Codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 316
    Top = 12
  end
  object selP200: TOracleDataSet
    SQL.Strings = (
      
        'select distinct COD_VOCE, DESCRIZIONE from p200_voci t where TIP' +
        'O='#39'AS'#39)
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000020000001000000043004F0044005F0056004F004300450001000000
      0000160000004400450053004300520049005A0049004F004E00450001000000
      0000}
    Left = 16
    Top = 64
  end
  object dsrP200: TDataSource
    DataSet = selP200
    Left = 56
    Top = 64
  end
  object QCols: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME FROM COLS '
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39
      'ORDER BY COLUMN_NAME')
    Optimize = False
    Left = 132
    Top = 12
  end
  object DCols: TDataSource
    AutoEdit = False
    DataSet = QCols
    Left = 160
    Top = 12
  end
  object Q265A: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione from T265_CauAssenze '
      'ORDER BY CODICE')
    Optimize = False
    AfterOpen = QCollegamentiAfterOpen
    Left = 200
    Top = 12
  end
  object D265A: TDataSource
    DataSet = Q265A
    Left = 232
    Top = 12
  end
  object Q265B: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione,CodRaggr from T265_CauAssenze '
      'ORDER BY CODICE')
    Optimize = False
    Filtered = True
    AfterOpen = QCollegamentiAfterOpen
    OnFilterRecord = Q265BFilterRecord
    Left = 276
    Top = 12
    object Q265BCODICE: TStringField
      DisplayWidth = 6
      FieldName = 'CODICE'
      Size = 5
    end
    object Q265BDESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object Q265BCODRAGGR: TStringField
      FieldName = 'CODRAGGR'
      Size = 5
    end
  end
  object selT266: TOracleDataSet
    SQL.Strings = (
      'select T266.*,ROWID from T266_DETTAGLIOCUMULO T266 '
      'where CODICE = :CODICE'
      'order by ID')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    AutoCalcFields = False
    CachedUpdates = True
    Left = 200
    Top = 64
    object selT266CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selT266ID: TStringField
      FieldName = 'ID'
      Visible = False
      Size = 5
    end
    object selT266NUMGG: TFloatField
      DisplayLabel = 'Massimale(GG)'
      FieldName = 'NUMGG'
    end
    object selT266CAUSALI: TStringField
      DisplayLabel = 'Causali'
      DisplayWidth = 50
      FieldName = 'CAUSALI'
      Required = True
      Size = 500
    end
  end
  object dsrT266: TDataSource
    DataSet = selT266
    Left = 240
    Top = 64
  end
  object Q260: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM T260_RaggrAssenze ORDER BY Codice')
    Optimize = False
    Filtered = True
    OnFilterRecord = FiltroDizionario
    Left = 56
    Top = 12
  end
  object D260: TDataSource
    DataSet = Q260
    Left = 84
    Top = 12
  end
  object selVSource: TOracleDataSet
    SQL.Strings = (
      'select V.TEXT'
      '  from USER_SOURCE V'
      ' where V.NAME = :SNAME'
      ' order by V.LINE')
    Optimize = False
    Variables.Data = {
      04000000010000000C0000003A0053004E0041004D0045000500000000000000
      00000000}
    Left = 296
    Top = 64
  end
  object selT259: TOracleDataSet
    SQL.Strings = (
      'select T259.*,ROWID from T259_CONTROLLI_CAUASSENZE T259 '
      'where CODICE = :CODICE'
      
        'order by CAU_INCOMPATIBILE, TIPO_CONTROLLO, SEX_FRUITORE, SEX_CA' +
        'U_INCOMP, INCLUDI_FAM')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    AutoCalcFields = False
    CachedUpdates = True
    BeforePost = selT259BeforePost
    OnNewRecord = selT259NewRecord
    Left = 104
    Top = 64
    object selT259CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 5
    end
    object selT259TIPO_CONTROLLO: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_CONTROLLO'
      Size = 1
    end
    object selT259SEX_FRUITORE: TStringField
      DisplayLabel = 'Genere'
      FieldName = 'SEX_FRUITORE'
      Size = 1
    end
    object selT259CAU_INCOMPATIBILE: TStringField
      DisplayLabel = 'Caus. incomp.'
      FieldName = 'CAU_INCOMPATIBILE'
      Size = 5
    end
    object selT259SEX_CAU_INCOMP: TStringField
      DisplayLabel = 'Genere incomp.'
      FieldName = 'SEX_CAU_INCOMP'
      Size = 1
    end
    object selT259INCLUDI_FAM: TStringField
      DisplayLabel = 'Incl. fam.'
      FieldName = 'INCLUDI_FAM'
      Size = 1
    end
  end
  object dsrT259: TDataSource
    DataSet = selT259
    Left = 144
    Top = 64
  end
end
