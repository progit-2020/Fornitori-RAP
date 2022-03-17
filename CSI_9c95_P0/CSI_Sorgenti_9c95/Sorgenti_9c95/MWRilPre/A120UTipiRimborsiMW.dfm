inherited A120FTipiRimborsiMW: TA120FTipiRimborsiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 141
  Width = 185
  object DsrP050: TDataSource
    DataSet = selP050
    Left = 8
    Top = 7
  end
  object selP050: TOracleDataSet
    SQL.Strings = (
      
        'select T.COD_ARROTONDAMENTO, T.COD_VALUTA, T.DECORRENZA, T.DESCR' +
        'IZIONE,T.VALORE,T.TIPO, t.rowid from p050_arrotondamenti t where' +
        ' T.cod_valuta = '
      
        '       (select cod_valuta_base from p150_setup where decorrenza ' +
        '= '
      
        '               (select max(decorrenza) from p150_setup where dec' +
        'orrenza <= :DECORRENZA))'
      
        'and T.DECORRENZA = (select max(A.decorrenza) from p050_arrotonda' +
        'menti A where A.decorrenza <= :DECORRENZA AND A.COD_ARROTONDAMEN' +
        'TO = T.COD_ARROTONDAMENTO)')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000}
    Left = 52
    Top = 7
    object selP050COD_ARROTONDAMENTO: TStringField
      FieldName = 'COD_ARROTONDAMENTO'
      Required = True
      Size = 5
    end
    object selP050COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selP050DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selP050DESCRIZIONE: TStringField
      DisplayWidth = 20
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selP050VALORE: TFloatField
      FieldName = 'VALORE'
    end
    object selP050TIPO: TStringField
      FieldName = 'TIPO'
      Size = 1
    end
  end
  object dsrCSI003: TDataSource
    DataSet = selCSI003
    Left = 137
    Top = 8
  end
  object selCSI003: TOracleDataSet
    SQL.Strings = (
      'select CSI003.*, CSI003.ROWID'
      'from CSI003_COD_RIMB_VIAGGIO CSI003'
      'where CSI003.COD_RIMBORSO = :COD_RIMBORSO'
      'order by CSI003.RIMBORSO_AGENZIA')
    Optimize = False
    Variables.Data = {
      04000000010000001A0000003A0043004F0044005F00520049004D0042004F00
      520053004F00050000000000000000000000}
    OracleDictionary.DefaultValues = True
    ReadOnly = True
    BeforePost = selCSI003BeforePost
    BeforeDelete = selCSI003BeforeDelete
    OnNewRecord = selCSI003NewRecord
    Left = 95
    Top = 8
    object selCSI003COD_RIMBORSO: TStringField
      FieldName = 'COD_RIMBORSO'
      Visible = False
      Size = 5
    end
    object selCSI003RIMBORSO_AGENZIA: TStringField
      DisplayLabel = 'Tipologia'
      FieldName = 'RIMBORSO_AGENZIA'
      Size = 100
    end
  end
  object selTipoExcelImp: TOracleQuery
    SQL.Strings = (
      'select max(COD_RIMBORSO) COD_RIMBORSO'
      'from CSI003_COD_RIMB_VIAGGIO'
      'where trim(RIMBORSO_AGENZIA) = trim(:RIMBORSO_AGENZIA)')
    Optimize = False
    Variables.Data = {
      0400000001000000220000003A00520049004D0042004F00520053004F005F00
      4100470045004E005A0049004100050000000000000000000000}
    Left = 96
    Top = 64
  end
end
