inherited Ac09FIndFunzioneMW: TAc09FIndFunzioneMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 197
  Width = 288
  object selCSI007: TOracleDataSet
    SQL.Strings = (
      'select CSI007.*, CSI007.ROWID'
      '  from CSI007_CART_INDFUNZIONE_DETT CSI007'
      ' where CSI007.ID = :ID'
      '   and (CSI007.TIPO_RECORD = :TIPO_RECORD or :TIPO_RECORD = '#39'E'#39')'
      '   and CSI007.FASCIA = :FASCIA'
      ' order by CSI007.INDFUNZIONE, ORE')
    Optimize = False
    Variables.Data = {
      0400000003000000060000003A00490044000300000000000000000000001800
      00003A005400490050004F005F005200450043004F0052004400050000000000
      0000000000000E0000003A004600410053004300490041000500000000000000
      00000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C000000560041004C004F00520045000100000000001600
      0000500052004F0047005200450053005300490056004F000100000000001600
      0000490044005F0043004F004E0054004F0041004E004E000100000000000800
      000052004900470041000100000000000E00000043004F004C004F004E004E00
      4100010000000000}
    ReadOnly = True
    OnTranslateMessage = selCSI007TranslateMessage
    OnApplyRecord = selCSI007ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforeInsert = selCSI007BeforeInsert
    BeforeEdit = selCSI007BeforeEdit
    BeforePost = selCSI007BeforePost
    AfterPost = selCSI007AfterPost
    BeforeDelete = selCSI007BeforeDelete
    AfterDelete = selCSI007AfterPost
    OnNewRecord = selCSI007NewRecord
    Left = 80
    Top = 24
    object selCSI007ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selCSI007FASCIA: TStringField
      DisplayLabel = 'Fascia'
      FieldName = 'FASCIA'
      Visible = False
      Size = 5
    end
    object selCSI007TIPO_RECORD: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RECORD'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object selCSI007INDFUNZIONE: TStringField
      DisplayLabel = 'Indennit'#224' di funzione'
      DisplayWidth = 15
      FieldName = 'INDFUNZIONE'
      OnValidate = selCSI007INDFUNZIONEValidate
    end
    object selCSI007D_INDFUNZIONE: TStringField
      DisplayLabel = 'Descrizione'
      DisplayWidth = 40
      FieldKind = fkCalculated
      FieldName = 'D_INDFUNZIONE'
      Size = 100
      Calculated = True
    end
    object selCSI007ORE: TStringField
      DisplayLabel = 'HH ind.'
      FieldName = 'ORE'
      OnValidate = selCSI007OREValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
    object selCSI007DISAGIO_SERALE: TStringField
      DisplayLabel = 'HH dis. serale'
      FieldName = 'DISAGIO_SERALE'
      OnValidate = selCSI007OREValidate
      EditMask = '!00:00;1;_'
      Size = 5
    end
  end
  object dsrCSI007: TDataSource
    DataSet = selCSI007
    Left = 80
    Top = 80
  end
  object selCSI004: TOracleDataSet
    SQL.Strings = (
      'select CODICE, ID'
      '  from CSI004_INDFUNZIONE'
      ' where CONTRATTO = :Contratto'
      '   and :Data between DECORRENZA and DECORRENZA_FINE'
      ' order by CODICE')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A0043004F004E00540052004100540054004F00
      0500000000000000000000000A0000003A0044004100540041000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      05000000050000000C000000560041004C004F00520045000100000000001600
      0000500052004F0047005200450053005300490056004F000100000000001600
      0000490044005F0043004F004E0054004F0041004E004E000100000000000800
      000052004900470041000100000000000E00000043004F004C004F004E004E00
      4100010000000000}
    CommitOnPost = False
    Left = 192
    Top = 24
  end
  object selbCSI007: TOracleDataSet
    SQL.Strings = (
      
        'select LPAD(minutiore(sum(oreminuti(CSI007.ORE))),5,'#39'0'#39') SUM_ORE' +
        ', LPAD(minutiore(sum(oreminuti(CSI007.DISAGIO_SERALE))),5,'#39'0'#39') S' +
        'UM_DISAGIO_SERALE'
      '  from CSI007_CART_INDFUNZIONE_DETT CSI007'
      ' where CSI007.ID = :ID'
      '   and CSI007.TIPO_RECORD = '#39'A'#39
      '   and CSI007.FASCIA = :FASCIA')
    Optimize = False
    Variables.Data = {
      04000000020000000E0000003A00460041005300430049004100050000000000
      000000000000060000003A0049004400040000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      05000000030000001000000043004F0044005F0056004F004300450001000000
      00002200000043004F0044005F0056004F00430045005F005300500045004300
      490041004C004500010000000000160000004400450053004300520049005A00
      49004F004E004500010000000000}
    Left = 80
    Top = 136
  end
  object dsrCodice: TDataSource
    DataSet = selCodice
    Left = 136
    Top = 80
  end
  object selCodice: TOracleDataSet
    Optimize = False
    Filtered = True
    OnFilterRecord = selCodiceFilterRecord
    Left = 136
    Top = 24
    object selCodiceCODICE: TStringField
      DisplayWidth = 7
      FieldName = 'CODICE'
    end
    object selCodiceDESCRIZIONE: TStringField
      DisplayWidth = 150
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
  end
  object selbCSI006: TOracleDataSet
    SQL.Strings = (
      
        'select CSI006.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME, T030.NO' +
        'ME,'
      
        '       T430.CONTRATTO, CSI007.FASCIA, CSI007.INDFUNZIONE, CSI007' +
        '.TIPO_RECORD,'
      '       minutiore(sum(oreminuti(CSI007.ORE))) SUM_ORE, '
      
        '       minutiore(sum(oreminuti(CSI007.DISAGIO_SERALE))) SUM_DISA' +
        'GIO_SERALE'
      '  from CSI006_CART_INDFUNZIONE CSI006,'
      '       CSI007_CART_INDFUNZIONE_DETT CSI007,'
      '       T030_ANAGRAFICO T030,'
      '       T430_STORICO T430'
      ' where CSI006.ID = CSI007.ID (+)'
      '   and CSI006.PROGRESSIVO = :PROGRESSIVO'
      '   and CSI006.DATA between :PeriodoDa and :PeriodoA'
      
        '   and (nvl(CSI007.TIPO_RECORD,:TipoRecord) = :TipoRecord or :Ti' +
        'poRecord = '#39'E'#39')'
      '   and T030.PROGRESSIVO = CSI006.PROGRESSIVO'
      '   and T430.PROGRESSIVO = CSI006.PROGRESSIVO'
      '   and CSI006.DATA between T430.DATADECORRENZA and T430.DATAFINE'
      
        ' group by CSI006.PROGRESSIVO, T030.MATRICOLA, T030.COGNOME, T030' +
        '.NOME,'
      
        '       T430.CONTRATTO, CSI007.FASCIA, CSI007.INDFUNZIONE, CSI007' +
        '.TIPO_RECORD'
      
        ' order by T430.CONTRATTO, CSI007.FASCIA, CSI007.INDFUNZIONE, CSI' +
        '007.TIPO_RECORD')
    ReadBuffer = 9000
    Optimize = False
    Variables.Data = {
      0400000004000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000140000003A0050004500520049004F00
      44004F00440041000C0000000000000000000000120000003A00500045005200
      49004F0044004F0041000C0000000000000000000000160000003A0054004900
      50004F005200450043004F0052004400050000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000E00000016000000500052004F004700520045005300530049005600
      4F000100000000000C00000052004F0057004E0055004D000100000000003C00
      000054004F005F00430048004100520028003900390039003900390039003900
      39002D0054004F005F004E0055004D00420045005200280054004F005F000100
      000000001A00000043004F0044005F0043004F004E0054005200410054005400
      4F000100000000001000000043004F0044005F0056004F004300450001000000
      00002200000043004F0044005F0056004F00430045005F005300500045004300
      490041004C0045000100000000001E0000004400450043004F00520052004500
      4E005A0041005F00460049004E0045000100000000000E00000049004D005000
      4F00520054004F000100000000001C00000049004D0050004F00520054004F00
      5F0049004E005400450052004F000100000000000E0000004F00520049004700
      49004E0045000100000000000A00000053005400410054004F00010000000000
      220000004400450043004F005200520045004E005A0041005F0049004E004900
      5A0049004F0001000000000026000000490044005F0056004F00430045005F00
      500052004F004700520041004D004D0041005400410001000000000012000000
      5400490050004F005F0056004F0043004500010000000000}
    ReadOnly = True
    Left = 24
    Top = 136
    object selbCSI006PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Visible = False
    end
    object selbCSI006MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selbCSI006COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      Size = 30
    end
    object selbCSI006NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 30
    end
    object selbCSI006CONTRATTO: TStringField
      DisplayLabel = 'Contratto'
      DisplayWidth = 7
      FieldName = 'CONTRATTO'
      Size = 5
    end
    object selbCSI006FASCIA: TStringField
      DisplayLabel = 'Fascia'
      DisplayWidth = 7
      FieldName = 'FASCIA'
      Size = 5
    end
    object selbCSI006INDFUNZIONE: TStringField
      DisplayLabel = 'Indennit'#224' di funzione'
      DisplayWidth = 20
      FieldName = 'INDFUNZIONE'
    end
    object selbCSI006D_INDFUNZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldKind = fkCalculated
      FieldName = 'D_INDFUNZIONE'
      Size = 100
      Calculated = True
    end
    object selbCSI006TIPO_RECORD: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'TIPO_RECORD'
      Size = 1
    end
    object selbCSI006SUM_ORE: TStringField
      DisplayLabel = 'HH ind.'
      FieldName = 'SUM_ORE'
      EditMask = '!9900:00;1;_'
      Size = 10
    end
    object selbCSI006SUM_DISAGIO_SERALE: TStringField
      DisplayLabel = 'HH dis. serale'
      FieldName = 'SUM_DISAGIO_SERALE'
      EditMask = '!9900:00;1;_'
      Size = 7
    end
  end
  object dsrbCSI006: TDataSource
    DataSet = selbCSI006
    Left = 24
    Top = 80
  end
end
