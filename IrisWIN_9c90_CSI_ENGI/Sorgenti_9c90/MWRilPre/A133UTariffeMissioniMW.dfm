inherited A133FTariffeMissioniMW: TA133FTariffeMissioniMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Width = 314
  object QSource: TOracleDataSet
    Optimize = False
    Left = 12
    Top = 57
  end
  object DSource: TDataSource
    DataSet = QSource
    Left = 60
    Top = 57
  end
  object dsrM066: TDataSource
    DataSet = selM066
    Left = 60
    Top = 9
  end
  object selM066: TOracleDataSet
    SQL.Strings = (
      'select T.*,T.rowid '
      '  from M066_RIDUZIONI T'
      ' where T.Codice=:codice '
      '   and T.Cod_Tariffa=:codtariffa '
      '   and T.Decorrenza=:decorrenza')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      000000000000160000003A0043004F0044005400410052004900460046004100
      050000000000000000000000160000003A004400450043004F00520052004500
      4E005A0041000C0000000000000000000000}
    CommitOnPost = False
    CachedUpdates = True
    OnNewRecord = selM066NewRecord
    Left = 12
    Top = 9
    object selM066COD_RIDUZIONE: TStringField
      DisplayLabel = 'Cod. riduzione'
      FieldName = 'COD_RIDUZIONE'
      Size = 10
    end
    object selM066DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selM066PERC_RIDUZIONE: TFloatField
      DisplayLabel = '% riduzione'
      FieldName = 'PERC_RIDUZIONE'
    end
    object selM066QUOTA_ESENTE: TFloatField
      DisplayLabel = 'Quota esente'
      FieldName = 'QUOTA_ESENTE'
    end
    object selM066COEFF_MAGGIORAZIONE: TFloatField
      DisplayLabel = 'Coeff. maggiorazione'
      FieldName = 'COEFF_MAGGIORAZIONE'
    end
    object selM066CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 80
    end
    object selM066COD_TARIFFA: TStringField
      FieldName = 'COD_TARIFFA'
      Visible = False
      Size = 10
    end
    object selM066DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Visible = False
    end
  end
  object InsM066: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO M066_RIDUZIONI (CODICE, COD_TARIFFA, DECORRENZA,COD_' +
        'RIDUZIONE, DESCRIZIONE, PERC_RIDUZIONE, QUOTA_ESENTE, COEFF_MAGG' +
        'IORAZIONE)'
      
        'SELECT CODICE, COD_TARIFFA, :DECORRENZA_NEW,COD_RIDUZIONE, DESCR' +
        'IZIONE, PERC_RIDUZIONE, QUOTA_ESENTE, COEFF_MAGGIORAZIONE'
      'FROM  M066_RIDUZIONI'
      'WHERE CODICE = :CODICE'
      'AND COD_TARIFFA = :COD_TARIFFA'
      'AND DECORRENZA = :DECORRENZA_OLD')
    Optimize = False
    Variables.Data = {
      04000000040000001E0000003A004400450043004F005200520045004E005A00
      41005F004E00450057000C00000000000000000000000E0000003A0043004F00
      4400490043004500050000000000000000000000180000003A0043004F004400
      5F0054004100520049004600460041000500000000000000000000001E000000
      3A004400450043004F005200520045004E005A0041005F004F004C0044000C00
      00000000000000000000}
    Left = 168
    Top = 8
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      'SELECT T430.:DATOLIB'
      '  FROM T430_STORICO T430'
      ' WHERE T430.PROGRESSIVO = :PROGRESSIVO'
      '   AND T430.DATADECORRENZA = (SELECT MAX(T430.DATADECORRENZA)'
      '                                FROM T430_STORICO T430'
      
        '                               WHERE T430.DATADECORRENZA < :DATA' +
        'LAV'
      
        '                                 AND T430.PROGRESSIVO = :PROGRES' +
        'SIVO)')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A004400410054004F004C004900420001000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004C00
      410056000C0000000000000000000000}
    Left = 112
    Top = 8
  end
end
