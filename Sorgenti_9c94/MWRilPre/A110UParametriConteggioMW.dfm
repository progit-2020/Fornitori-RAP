inherited A110FParametriConteggioMW: TA110FParametriConteggioMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 233
  Width = 634
  object QSource: TOracleDataSet
    Optimize = False
    Left = 49
    Top = 7
  end
  object DSource: TDataSource
    DataSet = QSource
    Left = 8
    Top = 9
  end
  object DsrM011: TDataSource
    DataSet = selM011
    Left = 174
    Top = 8
  end
  object dsrP050: TDataSource
    DataSet = selP050
    Left = 92
    Top = 8
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
    Left = 132
    Top = 8
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
  object DsrP030: TDataSource
    DataSet = selP030
    Left = 260
    Top = 8
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
    Left = 304
    Top = 8
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
  object selT265: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione'
      'from  T265_CauAssenze'
      'where CUMULO_FAMILIARI = '#39'N'#39' '
      'and FRUIZIONE_FAMILIARI = '#39'N'#39' '
      'and VISITA_FISCALE = '#39'N'#39' '
      'and PERIODO_LUNGO = '#39'N'#39' '
      'and MATERNITA_OBBL = '#39'N'#39' '
      'and TIPOCUMULO not in ('#39'F'#39','#39'G'#39')'
      'order by Codice')
    ReadBuffer = 200
    Optimize = False
    Filtered = True
    OnFilterRecord = selT265FilterRecord
    Left = 50
    Top = 55
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'Select Codice,Descrizione'
      'from T275_CauPresenze'
      'order by codice'
      '')
    Optimize = False
    Filtered = True
    OnFilterRecord = selT275FilterRecord
    Left = 134
    Top = 56
  end
  object DsrT265: TDataSource
    AutoEdit = False
    DataSet = selT265
    Left = 8
    Top = 56
  end
  object DsrT275: TDataSource
    AutoEdit = False
    DataSet = selT275
    Left = 91
    Top = 56
  end
  object selM013: TOracleDataSet
    SQL.Strings = (
      'SELECT M013.*'
      '  FROM M013_SOGLIE_RIMBORSIPASTO M013'
      ' WHERE M013.CODICE = :CODICE'
      '   AND M013.TIPO_MISSIONE = :TIPO_MISSIONE'
      
        '   AND :DECORRENZA BETWEEN M013.DECORRENZA AND M013.DECORRENZA_F' +
        'INE'
      ' ORDER BY M013.DECORRENZA, M013.SOGLIA_GG')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      0000000000001C0000003A005400490050004F005F004D004900530053004900
      4F004E004500050000000000000000000000160000003A004400450043004F00
      5200520045004E005A0041000C0000000000000000000000}
    Left = 324
    Top = 56
    object selM013CODICE: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 80
    end
    object selM013TIPO_MISSIONE: TStringField
      FieldName = 'TIPO_MISSIONE'
      Visible = False
      Size = 5
    end
    object selM013DECORRENZA: TDateTimeField
      DisplayLabel = 'Decorrenza'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      Visible = False
    end
    object selM013DECORRENZA_FINE: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object selM013SOGLIA_GG: TStringField
      DisplayLabel = 'Ore minime'
      FieldName = 'SOGLIA_GG'
      Size = 5
    end
    object selM013RIMBORSO_MAX: TFloatField
      DisplayLabel = 'Rimborso max'
      FieldName = 'RIMBORSO_MAX'
    end
  end
  object dsrM013: TDataSource
    DataSet = selM013
    Left = 276
    Top = 56
  end
  object DsrM020: TDataSource
    DataSet = SelM020
    Left = 181
    Top = 56
  end
  object SelM020: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      '  from m020_tipirimborsi t'
      ' order by codice')
    Optimize = False
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A0000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001E00
      000043004F00440049004300450056004F004300450050004100470048004500
      010000000000180000005300430041005200490043004F005000410047004800
      45000100000000002E0000004500530049005300540045004E005A0041004900
      4E00440045004E004E0049005400410053005500500050004C00010000000000
      3A00000043004F00440049004300450056004F00430045005000410047004800
      450049004E00440045004E004E0049005400410053005500500050004C000100
      00000000340000005300430041005200490043004F0050004100470048004500
      49004E00440045004E004E0049005400410053005500500050004C0001000000
      000024000000500045005200430049004E00440045004E004E00490054004100
      53005500500050004C00010000000000260000004100520052004F0054004900
      4E00440045004E004E0049005400410053005500500050004C00010000000000
      1000000041004E00540049004300490050004F00010000000000}
    Left = 223
    Top = 56
    object SelM020CODICE: TStringField
      DisplayWidth = 6
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object SelM020DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object SelM020CODICEVOCEPAGHE: TStringField
      FieldName = 'CODICEVOCEPAGHE'
      Size = 6
    end
    object SelM020SCARICOPAGHE: TStringField
      FieldName = 'SCARICOPAGHE'
      Size = 1
    end
    object SelM020ESISTENZAINDENNITASUPPL: TStringField
      FieldName = 'ESISTENZAINDENNITASUPPL'
      Size = 1
    end
    object SelM020CODICEVOCEPAGHEINDENNITASUPPL: TStringField
      FieldName = 'CODICEVOCEPAGHEINDENNITASUPPL'
      Size = 6
    end
    object SelM020SCARICOPAGHEINDENNITASUPPL: TStringField
      FieldName = 'SCARICOPAGHEINDENNITASUPPL'
      Size = 1
    end
    object SelM020PERCINDENNITASUPPL: TFloatField
      FieldName = 'PERCINDENNITASUPPL'
      MaxValue = 100.000000000000000000
    end
    object SelM020ARROTINDENNITASUPPL: TStringField
      FieldName = 'ARROTINDENNITASUPPL'
      Size = 5
    end
    object SelM020CalcArrotIndennitaSuppl: TStringField
      FieldKind = fkCalculated
      FieldName = 'CalcArrotIndennitaSuppl'
      Size = 40
      Calculated = True
    end
  end
  object DsrM021: TDataSource
    DataSet = selM021
    Left = 347
    Top = 8
  end
  object selM021: TOracleDataSet
    SQL.Strings = (
      'select distinct codice, descrizione '
      '  from m021_tipiindennitakm'
      ' order by codice')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000070000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000140000004400
      450053004300560041004C00550054004100010000000000}
    Left = 394
    Top = 8
  end
  object UpDM010: TOracleQuery
    SQL.Strings = (
      '')
    Optimize = False
    Left = 11
    Top = 105
  end
  object selM013_2: TOracleDataSet
    SQL.Strings = (
      'SELECT M013.*, M013.ROWID'
      '  FROM M013_SOGLIE_RIMBORSIPASTO M013'
      ' WHERE M013.CODICE = :CODICE'
      '   AND M013.TIPO_MISSIONE = :TIPO_MISSIONE'
      '   AND M013.DECORRENZA = :DECORRENZA'
      '   :ORDERBY')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0043004F004400490043004500050000000000
      0000000000001C0000003A005400490050004F005F004D004900530053004900
      4F004E004500050000000000000000000000160000003A004400450043004F00
      5200520045004E005A0041000C0000000000000000000000100000003A004F00
      520044004500520042005900010000000000000000000000}
    ReadOnly = True
    OnApplyRecord = selM013_2ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selM013_2BeforePost
    OnNewRecord = selM013_2NewRecord
    Left = 251
    Top = 128
    object StringField1: TStringField
      FieldName = 'CODICE'
      Visible = False
      Size = 80
    end
    object StringField2: TStringField
      FieldName = 'TIPO_MISSIONE'
      Visible = False
      Size = 5
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Data decorrenza'
      FieldName = 'DECORRENZA'
      Visible = False
      EditMask = '!99/99/0000;1;_'
    end
    object DateTimeField2: TDateTimeField
      FieldName = 'DECORRENZA_FINE'
      Visible = False
    end
    object StringField3: TStringField
      DisplayLabel = 'Ore minime'
      FieldName = 'SOGLIA_GG'
      EditMask = '!90:00;1;_'
      Size = 5
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Rimborso max'
      FieldName = 'RIMBORSO_MAX'
    end
  end
  object dsrM013_2: TDataSource
    DataSet = selM013_2
    Left = 195
    Top = 128
  end
  object selDistM013: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT M013.CODICE, M013.TIPO_MISSIONE, M013.DECORRENZA' +
        ', '
      
        '       M013.CODICE||M013.TIPO_MISSIONE||TO_CHAR(M013.DECORRENZA,' +
        #39'DDMMYYYY'#39') AS M013_CHIAVE'
      '  FROM M013_SOGLIE_RIMBORSIPASTO M013'
      ' WHERE M013.CODICE = :CODICE'
      '   AND M013.TIPO_MISSIONE = :TIPO_MISSIONE'
      ' ORDER BY M013.CODICE, M013.TIPO_MISSIONE, M013.DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A0043004F004400490043004500050000000000
      0000000000001C0000003A005400490050004F005F004D004900530053004900
      4F004E004500050000000000000000000000}
    AfterOpen = selDistM013AfterOpen
    AfterScroll = selDistM013AfterScroll
    Left = 314
    Top = 128
  end
  object delM013: TOracleQuery
    SQL.Strings = (
      'DELETE '
      '  FROM M013_SOGLIE_RIMBORSIPASTO M013'
      ' WHERE M013.CODICE = :CODICE'
      '   AND M013.TIPO_MISSIONE = :TIPO_MISSIONE'
      '   AND M013.DECORRENZA = :DECORRENZA')
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A0043004F004400490043004500050000000000
      0000000000001C0000003A005400490050004F005F004D004900530053004900
      4F004E004500050000000000000000000000160000003A004400450043004F00
      5200520045004E005A0041000C0000000000000000000000}
    Left = 194
    Top = 184
  end
  object UpdM013Decorrenza: TOracleQuery
    SQL.Strings = (
      'DECLARE'
      'BEGIN'
      '  UPDATE M013_SOGLIE_RIMBORSIPASTO M013'
      '     SET M013.DECORRENZA_FINE  = (SELECT MIN(DECORRENZA) - 1 '
      
        '                                    FROM M013_SOGLIE_RIMBORSIPAS' +
        'TO '
      '                                   WHERE CODICE = M013.CODICE '
      
        '                                     AND TIPO_MISSIONE = M013.TI' +
        'PO_MISSIONE '
      
        '                                     AND DECORRENZA > M013.DECOR' +
        'RENZA)'
      '   WHERE EXISTS (SELECT '#39'X'#39' '
      '                   FROM M013_SOGLIE_RIMBORSIPASTO '
      '                  WHERE CODICE = M013.CODICE '
      '                    AND TIPO_MISSIONE = M013.TIPO_MISSIONE '
      '                    AND DECORRENZA > M013.DECORRENZA);'
      ''
      '  UPDATE M013_SOGLIE_RIMBORSIPASTO M013'
      '     SET M013.DECORRENZA_FINE  = TO_DATE('#39'31123999'#39','#39'DDMMYYYY'#39')'
      
        '   WHERE (M013.CODICE, M013.TIPO_MISSIONE, M013.DECORRENZA) IN (' +
        'SELECT DISTINCT CODICE,TIPO_MISSIONE,MAX(DECORRENZA)'
      
        '                                                                ' +
        '  FROM M013_SOGLIE_RIMBORSIPASTO '
      
        '                                                                ' +
        ' GROUP BY CODICE,TIPO_MISSIONE); '
      'END;')
    Optimize = False
    Left = 274
    Top = 184
  end
  object UpdM013Decorrenza_2: TOracleQuery
    SQL.Strings = (
      'UPDATE M013_SOGLIE_RIMBORSIPASTO M013'
      '   SET M013.DECORRENZA = :DECORRENZA_NEW'
      ' WHERE M013.CODICE = :CODICE'
      '   AND M013.TIPO_MISSIONE = :TIPO_MISSIONE'
      '   AND M013.DECORRENZA = :DECORRENZA_OLD')
    Optimize = False
    Variables.Data = {
      04000000040000001E0000003A004400450043004F005200520045004E005A00
      41005F004E00450057000C00000000000000000000000E0000003A0043004F00
      44004900430045000500000000000000000000001C0000003A00540049005000
      4F005F004D0049005300530049004F004E004500050000000000000000000000
      1E0000003A004400450043004F005200520045004E005A0041005F004F004C00
      44000C0000000000000000000000}
    Left = 381
    Top = 185
  end
  object selM011: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid '
      'from m011_tipomissione t'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A004F0052004400450052004200590001000000
      0000000000000000}
    OracleDictionary.DefaultValues = True
    Filtered = True
    BeforePost = SelM011BeforePost
    AfterPost = SelM011AfterPost
    BeforeDelete = SelM011BeforeDelete
    AfterDelete = SelM011AfterDelete
    OnFilterRecord = FiltroDizionarioM011
    Left = 218
    Top = 8
    object selM011CODICE: TStringField
      DisplayLabel = 'Codice'
      FieldName = 'CODICE'
      Size = 5
    end
    object selM011DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selM011SELEZIONATO: TStringField
      DisplayLabel = 'Selezionato'
      FieldName = 'SELEZIONATO'
      Size = 1
    end
  end
  object selM021RimbAuto: TOracleDataSet
    SQL.Strings = (
      'select distinct codice, descrizione '
      '  from m021_tipiindennitakm'
      ':FILTRO'
      ' order by codice')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A00460049004C00540052004F00010000000000
      000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000070000002400000043004F0044005F004100520052004F0054004F00
      4E00440041004D0045004E0054004F000100000000001400000043004F004400
      5F00560041004C00550054004100010000000000140000004400450043004F00
      5200520045004E005A0041000100000000001600000044004500530043005200
      49005A0049004F004E0045000100000000000C000000560041004C004F005200
      4500010000000000080000005400490050004F00010000000000140000004400
      450053004300560041004C00550054004100010000000000}
    Left = 562
    Top = 8
  end
  object dsrM021RimbAuto: TDataSource
    DataSet = selM021RimbAuto
    Left = 467
    Top = 8
  end
end
