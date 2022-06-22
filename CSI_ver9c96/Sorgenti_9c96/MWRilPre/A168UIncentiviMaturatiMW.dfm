inherited A168FIncentiviMaturatiMW: TA168FIncentiviMaturatiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 265
  Width = 471
  object selT765: TOracleDataSet
    SQL.Strings = (
      'select CODICE,DESCRIZIONE,TIPOQUOTA '
      '  from t765_tipoquote T765'
      'WHERE DECORRENZA = (SELECT MAX(DECORRENZA) FROM T765_TIPOQUOTE'
      '                     WHERE CODICE = T765.CODICE'
      '                       AND DECORRENZA <= :DATA)'
      'UNION'
      'SELECT '#39'_'#39', '#39'RATEIZZAZIONE'#39','#39#39' FROM DUAL'
      'UNION'
      'SELECT '#39'A'#39', '#39'GG. ACCONTO'#39','#39#39' FROM DUAL'
      ''
      ''
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A0044004100540041000C000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000001200
      00005400490050004F00510055004F0054004100010000000000}
    Left = 80
    Top = 16
    object selT765CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object selT765DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT765TIPOQUOTA: TStringField
      FieldName = 'TIPOQUOTA'
      Size = 1
    end
  end
  object selT766: TOracleDataSet
    SQL.Strings = (
      'select * from t766_incentivitipoabbat')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      05000000030000000C00000043004F0044004900430045000100000000001600
      00004400450053004300520049005A0049004F004E0045000100000000002400
      00005200490053005000410052004D0049004F005F00420049004C0041004E00
      430049004F00010000000000}
    Left = 128
    Top = 16
    object StringField1: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object StringField2: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object selT766RISPARMIO_BILANCIO: TStringField
      FieldName = 'RISPARMIO_BILANCIO'
      Size = 1
    end
  end
  object selT763: TOracleDataSet
    SQL.Strings = (
      'select t763.*,t763.rowid '
      'from t763_incentiviabbattimenti t763'
      'where progressivo = :PROG'
      '  and anno = :ANNO'
      '  and mese = :MESE'
      '  AND TIPOQUOTA = :QUOTA'
      'order by tipoabbattimento'
      '')
    Optimize = False
    Variables.Data = {
      04000000040000000A0000003A00500052004F00470003000000000000000000
      00000A0000003A0041004E004E004F000300000000000000000000000A000000
      3A004D004500530045000300000000000000000000000C0000003A0051005500
      4F0054004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000700000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000080000004D00
      450053004500010000000000120000005400490050004F00510055004F005400
      4100010000000000200000005400490050004F00410042004200410054005400
      49004D0045004E0054004F00010000000000380000004D004500530045004100
      500050004C004900430041005A0049004F004E00450041004200420041005400
      540049004D0045004E0054004F0001000000000022000000510055004F005400
      410041004200420041005400540049004D0045004E0054004F00010000000000}
    OnCalcFields = selT763CalcFields
    OnNewRecord = selT763NewRecord
    Left = 24
    Top = 16
    object selT763PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT763ANNO: TFloatField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selT763MESE: TFloatField
      FieldName = 'MESE'
      Required = True
      Visible = False
    end
    object selT763TIPOQUOTA: TStringField
      FieldName = 'TIPOQUOTA'
      Required = True
      Visible = False
      Size = 5
    end
    object selT763TIPOABBATTIMENTO: TStringField
      Alignment = taCenter
      DisplayLabel = 'Abbattimento'
      DisplayWidth = 2
      FieldName = 'TIPOABBATTIMENTO'
      Required = True
      Size = 40
    end
    object selT763Desc_Abbattimento: TStringField
      Alignment = taCenter
      DisplayLabel = ' '
      FieldKind = fkCalculated
      FieldName = 'Desc_Abbattimento'
      Size = 50
      Calculated = True
    end
    object selT763QUOTAABBATTIMENTO: TFloatField
      Alignment = taCenter
      DisplayLabel = 'Quota Abb.'
      FieldName = 'QUOTAABBATTIMENTO'
    end
    object selT763MESEAPPLICAZIONEABBATTIMENTO: TDateTimeField
      Alignment = taCenter
      DisplayLabel = 'Mese applicaz. abb.'
      DisplayWidth = 10
      FieldName = 'MESEAPPLICAZIONEABBATTIMENTO'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
  end
end
