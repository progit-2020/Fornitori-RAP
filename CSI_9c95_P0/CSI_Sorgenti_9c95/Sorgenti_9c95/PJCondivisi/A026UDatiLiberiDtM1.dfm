object A026FDatiLIberiDtM1: TA026FDatiLIberiDtM1
  OldCreateOrder = True
  OnCreate = A026FDatiLIberiDtM1Create
  OnDestroy = A026FDatiLIberiDtM1Destroy
  Height = 107
  Width = 404
  object D500: TDataSource
    AutoEdit = False
    DataSet = Q500
    Left = 76
    Top = 4
  end
  object I500: TOracleDataSet
    SQL.Strings = (
      
        'SELECT I500.*,I500.ROWID FROM I500_DATILIBERI I500 ORDER BY NOME' +
        'CAMPO')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000A000000120000004E004F004D004500430041004D0050004F000100
      0000000016000000500052004F0047005200450053005300490056004F000100
      000000000E00000054004100420045004C004C00410001000000000012000000
      4C0055004E004700480045005A005A0041000100000000001600000052004900
      46004500520049004D0045004E0054004F00010000000000100000004E004F00
      4D0045004C0049004E004B00010000000000080000005400490050004F000100
      000000000E00000046004F0052004D00410054004F000100000000000E000000
      530054004F005200490043004F00010000000000120000004C0055004E004700
      5F004400450053004300010000000000}
    BeforePost = I500BeforePost
    AfterPost = I500AfterPost
    BeforeDelete = I500BeforeDelete
    AfterDelete = I500AfterDelete
    OnNewRecord = I500NewRecord
    Left = 8
    Top = 4
    object I500NomeCampo: TStringField
      FieldName = 'NomeCampo'
      Required = True
      OnValidate = BDEI500NomeCampoValidate
      Size = 15
    end
    object I500Progressivo: TFloatField
      FieldName = 'Progressivo'
    end
    object I500TABELLA: TStringField
      FieldName = 'TABELLA'
      Size = 1
    end
    object I500LUNGHEZZA: TFloatField
      FieldName = 'LUNGHEZZA'
      Required = True
      MaxValue = 100.000000000000000000
      MinValue = 1.000000000000000000
    end
    object I500FORMATO: TStringField
      FieldName = 'FORMATO'
      Size = 1
    end
    object I500STORICO: TStringField
      FieldName = 'STORICO'
      Size = 1
    end
    object I500LUNG_DESC: TFloatField
      FieldName = 'LUNG_DESC'
    end
    object I500SCADENZA: TStringField
      FieldName = 'SCADENZA'
      Size = 1
    end
  end
  object Q500: TOracleDataSet
    SQL.Strings = (
      'SELECT NOMECAMPO,LUNGHEZZA,FORMATO FROM I500_DatiLiberi'
      'WHERE NOMECAMPO <> :NOMECAMPO'
      'ORDER BY NomeCampo ')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004E004F004D004500430041004D0050004F00
      050000000000000000000000}
    Left = 48
    Top = 4
  end
  object Q500Tipo: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM I500_DatiLiberi'
      '  WHERE TIPO = :TIPO AND'
      '  ROWID <> :NumRiga'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A005400490050004F0005000000020000003100
      00000000100000003A004E0055004D0052004900470041000500000000000000
      00000000}
    Left = 128
    Top = 4
  end
  object selT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOMEPAGINA FROM T033_LAYOUT'
      '  ORDER BY NOMEPAGINA')
    Optimize = False
    Left = 195
    Top = 4
  end
end
