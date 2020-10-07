object A093FOperazioniDtM1: TA093FOperazioniDtM1
  OldCreateOrder = True
  OnCreate = A093FOperazioniDtM1Create
  OnDestroy = A093FOperazioniDtM1Destroy
  Height = 109
  Width = 425
  object Q000_Tabelle: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT TABELLA'
      'FROM I000_LOGINFO'
      'ORDER BY TABELLA')
    ReadBuffer = 200
    Optimize = False
    Left = 28
    Top = 8
    object Q000_TabelleTABELLA: TStringField
      FieldName = 'TABELLA'
      Origin = 'I000_LOG.TABELLA'
      Size = 80
    end
  end
  object Q000: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM I000_LOGINFO'
      'WHERE DATA >= :DADATA AND DATA < :ADATA + 1'
      '')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A004400410044004100540041000C0000000000
      0000000000000C0000003A00410044004100540041000C000000000000000000
      0000}
    AfterOpen = Q000AfterOpen
    AfterScroll = Q000AfterScroll
    OnCalcFields = Q000CalcFields
    OnFilterRecord = Q000FilterRecord
    Left = 172
    Top = 8
  end
  object Q000_Operatori: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT OPERATORE'
      'FROM I000_LOGINFO'
      'ORDER BY OPERATORE')
    ReadBuffer = 50
    Optimize = False
    Left = 104
    Top = 8
    object Q000_OperatoriOPERATORE: TStringField
      FieldName = 'OPERATORE'
      Origin = 'I000_LOG.OPERATORE'
    end
  end
  object D000: TDataSource
    AutoEdit = False
    DataSet = Q000
    Left = 200
    Top = 8
  end
  object Q001: TOracleDataSet
    SQL.Strings = (
      'SELECT COLONNA,VALORE_OLD,VALORE_NEW '
      '  FROM I001_LOGDATI WHERE ID = :ID ORDER BY COLONNA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000030000000E00000043004F004C004F004E004E004100010000000000
      14000000560041004C004F00520045005F004F004C0044000100000000001400
      0000560041004C004F00520045005F004E0045005700010000000000}
    Left = 240
    Top = 8
    object Q001COLONNA: TStringField
      DisplayLabel = 'Colonna'
      DisplayWidth = 15
      FieldName = 'COLONNA'
      Required = True
      Size = 40
    end
    object Q001VALORE_OLD: TStringField
      DisplayLabel = 'Valore_Old'
      DisplayWidth = 10
      FieldName = 'VALORE_OLD'
      Size = 60
    end
    object Q001VALORE_NEW: TStringField
      DisplayLabel = 'Valore_New'
      DisplayWidth = 10
      FieldName = 'VALORE_NEW'
      Size = 60
    end
  end
  object D001: TDataSource
    AutoEdit = False
    DataSet = Q001
    Left = 268
    Top = 8
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT UPPER(COLONNA) COLONNA FROM I001_LOGDATI')
    ReadBuffer = 1000
    Optimize = False
    Left = 316
    Top = 8
  end
  object delI000: TOracleQuery
    SQL.Strings = (
      
        'delete from i000_loginfo where data between :dal and to_date(to_' +
        'char(:al,'#39'ddmmyyyy'#39')||'#39'235959'#39','#39'ddmmyyyyhh24miss'#39') ')
    Optimize = False
    Variables.Data = {
      0400000002000000080000003A00440041004C000C0000000000000000000000
      060000003A0041004C000C0000000000000000000000}
    Left = 356
    Top = 8
  end
end
