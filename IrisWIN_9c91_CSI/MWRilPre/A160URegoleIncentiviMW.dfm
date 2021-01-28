inherited A160FRegoleIncentiviMW: TA160FRegoleIncentiviMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 343
  Width = 657
  object dsrInterfaccia: TDataSource
    DataSet = selInterfaccia
    Left = 224
    Top = 80
  end
  object selInterfaccia: TOracleDataSet
    Optimize = False
    Left = 224
    Top = 24
  end
  object selP150: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM P150_SETUP T1 WHERE '
      'DECORRENZA = '
      '  (SELECT MAX(DECORRENZA) FROM P150_SETUP'
      '   WHERE DECORRENZA <= :Decorrenza)')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000}
    Left = 170
    Top = 24
  end
  object selP030: TOracleDataSet
    SQL.Strings = (
      'SELECT NUM_DEC_IMP_VOCE, ABBREVIAZIONE FROM P030_VALUTE T1 WHERE'
      'COD_VALUTA = :Cod_Valuta AND'
      'DECORRENZA = '
      '  (SELECT MAX(DECORRENZA) FROM P030_VALUTE'
      '   WHERE DECORRENZA <= :Decorrenza '
      '   AND COD_VALUTA = T1.COD_VALUTA)')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0043004F0044005F00560041004C0055005400
      4100050000000000000000000000160000003A004400450043004F0052005200
      45004E005A0041000C0000000000000000000000}
    CommitOnPost = False
    Left = 122
    Top = 24
  end
  object QLiv: TOracleDataSet
    Optimize = False
    Left = 72
    Top = 24
  end
  object insT765: TOracleQuery
    SQL.Strings = (
      
        'insert into T765_tipoquote (codice,descrizione,tipoquota,decorre' +
        'nza,vp_netta)'
      
        'values ('#39'A#D'#39','#39'Acconto giorni utili'#39','#39'A'#39',to_Date('#39'01011900'#39','#39'ddm' +
        'myyyy'#39'),'#39'A#I'#39')')
    Optimize = False
    Left = 24
    Top = 24
  end
end
