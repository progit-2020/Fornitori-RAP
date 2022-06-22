inherited A061FDettAssenzaMW: TA061FDettAssenzaMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 242
  Width = 304
  object selT256: TOracleDataSet
    SQL.Strings = (
      'select cod_codiciaccorpcausali, descrizione'
      'from t256_codiciaccorpcausali'
      'where :tipo_acc is null or cod_tipoaccorpcausali = :tipo_acc'
      'order by cod_codiciaccorpcausali')
    Optimize = False
    Variables.Data = {
      0400000001000000120000003A005400490050004F005F004100430043000500
      00000000000000000000}
    Left = 120
    Top = 176
  end
  object GetCalendario: TOracleQuery
    SQL.Strings = (
      'begin'
      '  GETCALENDARIO(:PROG,:DATA,:FEST,:LAV,:GG,:MONTEORE);'
      'end;')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0044004100540041000C00000000000000000000000A000000
      3A004600450053005400050000000000000000000000080000003A004C004100
      5600050000000000000000000000060000003A00470047000300000000000000
      00000000120000003A004D004F004E00540045004F0052004500050000000000
      000000000000}
    Left = 120
    Top = 64
  end
  object Q265: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,GSIGNIFIC,VALIDAZIONE '
      'FROM T265_CAUASSENZE '
      'WHERE :TIPO_ACC IS NULL '
      'OR EXISTS (SELECT 1 '
      '           FROM T257_ACCORPCAUSALI'
      '           WHERE CODICE = COD_CAUSALE'
      '           AND COD_TIPOACCORPCAUSALI = :TIPO_ACC'
      '           AND COD_CODICIACCORPCAUSALI IN (:COD_ACC))'
      'ORDER BY CODICE')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A005400490050004F005F004100430043000500
      00000000000000000000100000003A0043004F0044005F004100430043000100
      00000000000000000000}
    Filtered = True
    Left = 116
    Top = 8
  end
  object D010: TDataSource
    Left = 180
    Top = 8
  end
  object QGiustificativiAssenza: TOracleDataSet
    ReadBuffer = 1000
    Optimize = False
    Left = 44
    Top = 8
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforePost = TabellaStampaBeforePost
    Left = 244
    Top = 8
  end
  object selT255: TOracleDataSet
    SQL.Strings = (
      'select cod_tipoaccorpcausali, descrizione'
      'from t255_tipoaccorpcausali'
      'order by cod_tipoaccorpcausali')
    Optimize = False
    Left = 120
    Top = 120
    object selT255COD_TIPOACCORPCAUSALI: TStringField
      DisplayWidth = 7
      FieldName = 'COD_TIPOACCORPCAUSALI'
      Size = 5
    end
    object selT255DESCRIZIONE: TStringField
      DisplayWidth = 50
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
  end
  object D255: TDataSource
    DataSet = selT255
    Left = 168
    Top = 120
  end
  object selSG101DataFam: TOracleQuery
    SQL.Strings = (
      'select nvl(DATAADOZ,DATANAS) DATA_FAM'
      'from   SG101_FAMILIARI'
      'where  PROGRESSIVO = :PROGRESSIVO'
      'and    DATANAS = :DATANAS')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A0044004100540041004E00
      410053000C0000000000000000000000}
    Left = 40
    Top = 64
  end
end
