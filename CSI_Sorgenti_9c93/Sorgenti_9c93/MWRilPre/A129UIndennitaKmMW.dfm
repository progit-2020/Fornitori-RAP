inherited A129FIndennitaKmMW: TA129FIndennitaKmMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  object dsrP030: TDataSource
    DataSet = selP030
    Left = 124
    Top = 70
  end
  object selP030: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from p030_valute t'
      'WHERE T.cod_valuta = '
      
        '       (select cod_valuta_base from p150_setup where decorrenza ' +
        '= '
      
        '               (select max(decorrenza) from p150_setup where dec' +
        'orrenza <= :DECORRENZA))'
      
        'and T.DECORRENZA = (select max(A.decorrenza) from p030_valute A ' +
        'where A.decorrenza <= :DECORRENZA AND A.COD_VALUTA = T.COD_VALUT' +
        'A)'
      '')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000060000001400000043004F0044005F00560041004C00550054004100
      010000000000140000004400450043004F005200520045004E005A0041000100
      00000000160000004400450053004300520049005A0049004F004E0045000100
      000000001A000000410042004200520045005600490041005A0049004F004E00
      4500010000000000200000004E0055004D005F004400450043005F0049004D00
      50005F0056004F0043004500010000000000200000004E0055004D005F004400
      450043005F0049004D0050005F0055004E0049005400010000000000}
    Left = 166
    Top = 69
    object selP030COD_VALUTA: TStringField
      FieldName = 'COD_VALUTA'
      Required = True
      Size = 10
    end
    object selP030DECORRENZA: TDateTimeField
      FieldName = 'DECORRENZA'
      Required = True
    end
    object selP030DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
    end
    object selP030ABBREVIAZIONE: TStringField
      FieldName = 'ABBREVIAZIONE'
      Size = 3
    end
    object selP030NUM_DEC_IMP_VOCE: TIntegerField
      FieldName = 'NUM_DEC_IMP_VOCE'
    end
    object selP030NUM_DEC_IMP_UNIT: TIntegerField
      FieldName = 'NUM_DEC_IMP_UNIT'
    end
  end
  object dsrP050: TDataSource
    DataSet = selP050
    Left = 34
    Top = 69
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
      05000000070000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000140000004400
      450053004300560041004C00550054004100010000000000}
    Left = 77
    Top = 69
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
    object selP050descvaluta: TStringField
      FieldKind = fkLookup
      FieldName = 'descvaluta'
      LookupKeyFields = 'COD_VALUTA'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'COD_VALUTA'
      Size = 40
      Lookup = True
    end
  end
end
