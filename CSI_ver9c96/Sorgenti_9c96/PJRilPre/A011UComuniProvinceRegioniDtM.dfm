inherited A011FComuniProvinceRegioniDtM: TA011FComuniProvinceRegioniDtM
  OldCreateOrder = True
  Height = 230
  Width = 287
  object T480: TOracleDataSet
    SQL.Strings = (
      'SELECT T480.*,ROWID FROM T480_COMUNI T480 WHERE CODICE IN '
      
        '   (SELECT CODICE FROM T480_COMUNI T480 WHERE :TipoSelezione = '#39 +
        'T'#39
      '   UNION'
      
        '   SELECT CODICE FROM T480_COMUNI T480 WHERE :TipoSelezione = '#39'R' +
        #39' AND '
      
        '     CODICE IN (SELECT COMUNENAS FROM T030_ANAGRAFICO UNION SELE' +
        'CT COMUNE FROM T430_STORICO)'
      '   )'
      'ORDER BY CITTA')
    ReadBuffer = 8000
    Optimize = False
    Variables.Data = {
      04000000010000001C0000003A005400490050004F00530045004C0045005A00
      49004F004E004500050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C00000043004F0044004900430045000100000000000A00
      0000430049005400540041000100000000000600000043004100500001000000
      000012000000500052004F00560049004E004300490041000100000000001800
      000043004F00440043004100540041005300540041004C004500010000000000}
    BeforePost = BeforePostNoStorico
    Left = 8
    Top = 12
    object T480CODICE: TStringField
      DisplayLabel = 'Codice ISTAT'
      FieldName = 'CODICE'
      Required = True
      Size = 6
    end
    object T480CITTA: TStringField
      DisplayLabel = 'Comune'
      FieldName = 'CITTA'
      Size = 40
    end
    object T480CAP: TStringField
      FieldName = 'CAP'
      Size = 5
    end
    object T480PROVINCIA: TStringField
      DisplayLabel = 'Provincia'
      FieldName = 'PROVINCIA'
      Size = 2
    end
    object T480D_PROVINCIA: TStringField
      DisplayLabel = 'Descr. Provincia'
      FieldKind = fkLookup
      FieldName = 'D_PROVINCIA'
      LookupKeyFields = 'COD_PROVINCIA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'PROVINCIA'
      Size = 40
      Lookup = True
    end
    object T480CODCATASTALE: TStringField
      DisplayLabel = 'Codice Catastale'
      FieldName = 'CODCATASTALE'
      OnValidate = T480CODCATASTALEValidate
      Size = 4
    end
    object T480COD_REGIONE: TStringField
      DisplayLabel = 'Regione'
      FieldKind = fkLookup
      FieldName = 'COD_REGIONE'
      LookupKeyFields = 'COD_PROVINCIA'
      LookupResultField = 'COD_REGIONE'
      KeyFields = 'PROVINCIA'
      Size = 5
      Lookup = True
    end
    object T480D_REGIONE: TStringField
      DisplayLabel = 'Descr. Regione'
      FieldKind = fkLookup
      FieldName = 'D_REGIONE'
      LookupKeyFields = 'COD_REGIONE'
      LookupResultField = 'DESCRIZIONE_1'
      KeyFields = 'COD_REGIONE'
      Size = 40
      Lookup = True
    end
  end
  object T481: TOracleDataSet
    SQL.Strings = (
      'SELECT T481.*, T481.ROWID '
      '  FROM T481_PROVINCE T481'
      ' ORDER BY COD_PROVINCIA')
    ReadBuffer = 200
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000030000001600000043004F0044005F0052004500470049004F004E00
      45000100000000001A00000043004F0044005F00500052004F00560049004E00
      430049004100010000000000160000004400450053004300520049005A004900
      4F004E004500010000000000}
    Left = 9
    Top = 76
    object T481COD_PROVINCIA: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_PROVINCIA'
      Required = True
      Size = 2
    end
    object T481DESCRIZIONE: TStringField
      DisplayLabel = 'Provincia'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 40
    end
    object T481COD_REGIONE: TStringField
      DisplayLabel = 'Regione'
      FieldName = 'COD_REGIONE'
      Required = True
      Size = 5
    end
    object T481D_REGIONE: TStringField
      DisplayLabel = 'Descr. Regione'
      FieldKind = fkLookup
      FieldName = 'D_REGIONE'
      LookupKeyFields = 'COD_REGIONE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_REGIONE'
      Size = 40
      Lookup = True
    end
  end
  object D480: TDataSource
    AutoEdit = False
    DataSet = T480
    Left = 41
    Top = 12
  end
  object D481: TDataSource
    AutoEdit = False
    DataSet = T481
    Left = 41
    Top = 76
  end
  object T482: TOracleDataSet
    SQL.Strings = (
      'SELECT T482.*, T482.ROWID '
      '  FROM T482_REGIONI T482'
      ' ORDER BY COD_REGIONE')
    ReadBuffer = 50
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000040000001600000043004F0044005F0052004500470049004F004E00
      4500010000000000160000004400450053004300520049005A0049004F004E00
      45000100000000001200000043004F0044005F00490052005000450046000100
      000000000E000000460049005300430041004C004500010000000000}
    BeforePost = BeforePostNoStorico
    Left = 9
    Top = 144
    object T482COD_REGIONE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'COD_REGIONE'
      Required = True
      Size = 5
    end
    object T482DESCRIZIONE: TStringField
      DisplayLabel = 'Regione'
      FieldName = 'DESCRIZIONE'
      Required = True
      Size = 40
    end
    object T482COD_IRPEF: TStringField
      DisplayLabel = 'Codice IRPEF'
      FieldName = 'COD_IRPEF'
      Required = True
      Size = 2
    end
    object T482FISCALE: TStringField
      DisplayLabel = 'Solo addizionale IRPEF'
      FieldName = 'FISCALE'
      Required = True
      Size = 1
    end
  end
  object D482: TDataSource
    AutoEdit = False
    DataSet = T482
    Left = 41
    Top = 144
  end
end
