inherited A141FRegoleRiposiDtM: TA141FRegoleRiposiDtM
  OldCreateOrder = True
  Width = 530
  object selT267: TOracleDataSet
    SQL.Strings = (
      'select t267.*,t267.rowid from t267_regoleriposi t267'
      'order by codice')
    Optimize = False
    OracleDictionary.DefaultValues = True
    BeforePost = BeforePostNoStorico
    AfterScroll = selT267AfterScroll
    Left = 32
    Top = 16
  end
  object selT265: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T265.CODICE,T265.DESCRIZIONE,GSIGNIFIC, UMCUMULO, CQ_PROG' +
        'RESSIVO, CQ_FESTIVI, CQ_GGNONLAV, UM_INSERIMENTO, CODINTERNO'
      'FROM T265_CAUASSENZE T265, T260_RAGGRASSENZE T260'
      'WHERE T265.CODRAGGR = T260.CODICE'
      'ORDER BY CODICE')
    Optimize = False
    Filtered = True
    OnFilterRecord = selT265FilterRecord
    Left = 104
    Top = 14
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      'SELECT CODICE,DESCRIZIONE,ORENORMALI '
      'FROM T275_CAUPRESENZE '
      'ORDER BY CODICE')
    Optimize = False
    Filtered = True
    OnFilterRecord = selT275FilterRecord
    Left = 176
    Top = 14
    object selT275CODICE: TStringField
      FieldName = 'CODICE'
      Origin = 'T275_CAUPRESENZE.CODICE'
      Size = 5
    end
    object selT275DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'T275_CAUPRESENZE.DESCRIZIONE'
      Size = 40
    end
    object selT275ORENORMALI: TStringField
      FieldName = 'ORENORMALI'
      Origin = 'T275_CAUPRESENZE.ORENORMALI'
      Size = 1
    end
  end
  object DCausale1: TDataSource
    DataSet = QCausale1
    Left = 17
    Top = 78
  end
  object DCausale2: TDataSource
    DataSet = QCausale2
    Left = 16
    Top = 124
  end
  object QCausale1: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE,'
      '       T265.CODRAGGR T265CODRAGGR'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    Filtered = True
    OnFilterRecord = QCausale1FilterRecord
    Left = 72
    Top = 77
    object QCausale1T265CODICE: TStringField
      DisplayWidth = 8
      FieldName = 'T265CODICE'
      Origin = 'T265_CAUASSENZE.CODICE'
      Size = 5
    end
    object QCausale1T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Origin = 'T265_CAUASSENZE.DESCRIZIONE'
      Size = 40
    end
    object QCausale1T265CODRAGGR: TStringField
      FieldName = 'T265CODRAGGR'
      Origin = 'T265_CAUASSENZE.CODRAGGR'
      Size = 5
    end
  end
  object QCausale2: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE,'
      '       T265.CODRAGGR T265CODRAGGR'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    Filtered = True
    OnFilterRecord = QCausale1FilterRecord
    Left = 72
    Top = 125
    object QCausale2T265CODICE: TStringField
      DisplayWidth = 8
      FieldName = 'T265CODICE'
      Origin = 'T265_CAUASSENZE.CODICE'
      Size = 5
    end
    object QCausale2T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Origin = 'T265_CAUASSENZE.DESCRIZIONE'
      Size = 40
    end
    object QCausale2T265CODRAGGR: TStringField
      FieldName = 'T265CODRAGGR'
      Origin = 'T265_CAUASSENZE.CODRAGGR'
      Size = 5
    end
  end
  object QCausale3: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE,'
      '       T265.CODRAGGR T265CODRAGGR'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000300000014000000540032003600350043004F004400490043004500
      0100000000001E00000054003200360035004400450053004300520049005A00
      49004F004E00450001000000000018000000540032003600350043004F004400
      52004100470047005200010000000000}
    Filtered = True
    OnFilterRecord = QCausale1FilterRecord
    Left = 72
    Top = 177
    object QCausale3T265CODICE: TStringField
      DisplayWidth = 8
      FieldName = 'T265CODICE'
      Required = True
      Size = 5
    end
    object QCausale3T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Size = 40
    end
    object QCausale3T265CODRAGGR: TStringField
      FieldName = 'T265CODRAGGR'
      Size = 5
    end
  end
  object DCausale3: TDataSource
    DataSet = QCausale3
    Left = 16
    Top = 177
  end
  object selInterfaccia: TOracleDataSet
    Optimize = False
    Left = 272
    Top = 16
  end
  object dsrInterfaccia: TDataSource
    DataSet = selInterfaccia
    Left = 272
    Top = 72
  end
  object DCausale4: TDataSource
    DataSet = QCausale4
    Left = 16
    Top = 225
  end
  object QCausale4: TOracleDataSet
    SQL.Strings = (
      'SELECT T265.CODICE T265CODICE, '
      '       T265.DESCRIZIONE T265DESCRIZIONE'
      'FROM T265_CAUASSENZE T265'
      'ORDER BY T265.CODICE')
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000300000014000000540032003600350043004F004400490043004500
      0100000000001E00000054003200360035004400450053004300520049005A00
      49004F004E00450001000000000018000000540032003600350043004F004400
      52004100470047005200010000000000}
    Filtered = True
    OnFilterRecord = QCausale1FilterRecord
    Left = 72
    Top = 225
    object QCausale4T265CODICE: TStringField
      FieldName = 'T265CODICE'
      Size = 5
    end
    object QCausale4T265DESCRIZIONE: TStringField
      FieldName = 'T265DESCRIZIONE'
      Size = 40
    end
  end
end
