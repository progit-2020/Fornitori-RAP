inherited A038FVociVariabiliMW: TA038FVociVariabiliMW
  OldCreateOrder = True
  Width = 285
  object VociPaghe: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT VOCEPAGHE'
      '  FROM T195_VOCIVARIABILI'
      ' ORDER BY VOCEPAGHE')
    ReadBuffer = 50
    Optimize = False
    Left = 144
    Top = 12
  end
  object selT195Cassa: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT DATA_CASSA FROM T195_VOCIVARIABILI'
      'ORDER BY DATA_CASSA DESC')
    Optimize = False
    Left = 208
    Top = 12
  end
  object selT195: TOracleDataSet
    SQL.Strings = (
      'SELECT MATRICOLA,COGNOME || '#39' '#39' || NOME NOMINATIVO,'
      '       T195.* :T195_ROWID'
      'FROM :T195,'
      '     :QVISTAORACLE'
      '     :FILTRO_ANAGRAFE'
      'AND'
      'T030.PROGRESSIVO = T195.PROGRESSIVO AND  '
      '(T030.PROGRESSIVO = :PROGRESSIVO OR '#39'T'#39' = :T) AND'
      'T195.DATARIF BETWEEN :DATA1 AND :DATA2'
      ':ORDERBY ')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000040000003A0054000500000000000000
      000000000C0000003A00440041005400410031000C0000000000000000000000
      0C0000003A00440041005400410032000C00000000000000000000000A000000
      3A005400310039003500010000000000000000000000160000003A0054003100
      390035005F0052004F0057004900440001000000000000000000000020000000
      3A00460049004C00540052004F005F0041004E00410047005200410046004500
      0100000000000000000000001A0000003A005100560049005300540041004F00
      5200410043004C004500010000000000000000000000100000003A004F005200
      44004500520042005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C000000120000004D00410054005200490043004F004C0041000100
      00000000140000004E004F004D0049004E0041005400490056004F0001000000
      000016000000500052004F0047005200450053005300490056004F0001000000
      00000E0000004400410054004100520049004600010000000000120000005600
      4F0043004500500041004700480045000100000000000C000000560041004C00
      4F00520045000100000000000400000055004D00010000000000060000004400
      41004C000100000000000400000041004C00010000000000140000004F005000
      4500520041005A0049004F004E0045000100000000001600000043004F004400
      5F0049004E005400450052004E004F0001000000000014000000440041005400
      41005F0043004100530053004100010000000000}
    BeforeInsert = selT195BeforeInsert
    BeforePost = selT195BeforePost
    AfterPost = selT195AfterPost
    BeforeDelete = selT195BeforeDelete
    AfterDelete = selT195AfterDelete
    OnCalcFields = selT195CalcFields
    OnFilterRecord = selT195FilterRecord
    Left = 24
    Top = 12
    object selT195MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      DisplayWidth = 7
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
    end
    object selT195NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      DisplayWidth = 30
      FieldName = 'NOMINATIVO'
      ReadOnly = True
      Size = 61
    end
    object selT195PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selT195DATARIF: TDateTimeField
      DisplayLabel = 'Mese'
      DisplayWidth = 7
      FieldName = 'DATARIF'
      ReadOnly = True
      DisplayFormat = 'mm-yyyy'
    end
    object selT195VOCEPAGHE: TStringField
      DisplayLabel = 'Voce paghe'
      FieldName = 'VOCEPAGHE'
      Required = True
      Size = 10
    end
    object selT195VALORE: TFloatField
      DisplayLabel = 'Valore'
      DisplayWidth = 8
      FieldName = 'VALORE'
      Required = True
      OnGetText = selT195VALOREGetText
    end
    object selT195IMPORTO: TFloatField
      DisplayLabel = 'Importo'
      FieldName = 'IMPORTO'
    end
    object selT195UM: TStringField
      FieldName = 'UM'
      Size = 1
    end
    object selT195COD_INTERNO: TStringField
      DisplayLabel = 'Cod.Interno'
      FieldName = 'COD_INTERNO'
      ReadOnly = True
      Size = 5
    end
    object selT195D_CODICE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 15
      FieldKind = fkCalculated
      FieldName = 'D_CODICE'
      Size = 50
      Calculated = True
    end
    object selT195DATA_CASSA: TDateTimeField
      DisplayLabel = 'Data cassa'
      DisplayWidth = 10
      FieldName = 'DATA_CASSA'
      ReadOnly = True
      Required = True
      DisplayFormat = 'mm-yyyy'
    end
    object selT195DAL: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DAL'
      ReadOnly = True
      Required = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT195AL: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'AL'
      ReadOnly = True
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT195OPERAZIONE: TStringField
      DisplayLabel = 'Oper.'
      FieldName = 'OPERAZIONE'
      ReadOnly = True
      Required = True
      Size = 1
    end
  end
  object dsrT195: TDataSource
    DataSet = selT195
    OnStateChange = dsrT195StateChange
    Left = 76
    Top = 12
  end
end
