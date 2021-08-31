inherited A094FSkLimitiStraordMW: TA094FSkLimitiStraordMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 208
  Width = 394
  object dsrT825: TDataSource
    DataSet = selT825
    Left = 244
    Top = 56
  end
  object selT825: TOracleDataSet
    SQL.Strings = (
      'SELECT T825.*,T825.ROWID FROM T825_LIQUIDINDANNUO T825'
      'WHERE PROGRESSIVO = :PROGRESSIVO'
      ':ORDERBY')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000100000003A004F005200440045005200
      42005900010000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000400000016000000500052004F004700520045005300530049005600
      4F000100000000000800000041004E004E004F00010000000000160000004C00
      490051005500490044004100420049004C004500010000000000160000005200
      450053004900440055004100420049004C004500010000000000}
    BeforeEdit = selT825BeforeEdit
    BeforePost = selT825BeforePost
    AfterPost = selT825AfterPost
    BeforeDelete = selT825BeforeDelete
    AfterDelete = selT825AfterPost
    OnNewRecord = selT825NewRecord
    Left = 200
    Top = 56
    object FloatField1: TFloatField
      FieldName = 'PROGRESSIVO'
      Origin = 'T825_LIQUIDINDANNUO.PROGRESSIVO'
      Visible = False
    end
    object IntegerField1: TIntegerField
      DisplayLabel = 'Anno'
      DisplayWidth = 5
      FieldName = 'ANNO'
      Required = True
    end
    object StringField1: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Liquidabile'
      FieldName = 'LIQUIDABILE'
      Origin = 'T825_LIQUIDINDANNUO.LIQUIDABILE'
      OnValidate = ValidateOreMinuti
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object selT825RESIDUABILE: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Residuabile'
      FieldName = 'RESIDUABILE'
      OnValidate = ValidateOreMinuti
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object selT825LIQUIDABILE_TEORICO: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Liq. teorico'
      FieldName = 'LIQUIDABILE_TEORICO'
      OnValidate = ValidateOreMinuti
      EditMask = '!9900:00;1;_'
      Size = 7
    end
    object selT825RESIDUABILE_TEORICO: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Res. teorico'
      FieldName = 'RESIDUABILE_TEORICO'
      OnValidate = ValidateOreMinuti
      EditMask = '!9900:00;1;_'
      Size = 7
    end
  end
  object selT275: TOracleDataSet
    SQL.Strings = (
      
        'SELECT CODICE,DESCRIZIONE FROM T275_CAUPRESENZE --WHERE ORENORMA' +
        'LI = '#39'A'#39
      'ORDER BY CODICE')
    Optimize = False
    Left = 320
    Top = 56
  end
  object QCols: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME FROM COLS '
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39
      'ORDER BY COLUMN_NAME')
    Optimize = False
    Left = 196
    Top = 148
  end
  object selT810: TOracleDataSet
    SQL.Strings = (
      'select T810.*,T810.ROWID'
      'from T810_Liquidabile T810'
      'where anno=:anno and'
      '           campo1=:campo1 and'
      '           (campo2=:campo2 and :campo2 is not null or'
      '            campo2 is null and :campo2 is null)'
      'order by mese')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00430041004D0050004F003100050000000000000000000000
      0E0000003A00430041004D0050004F003200050000000000000000000000}
    CachedUpdates = True
    BeforeInsert = AbortOperation
    BeforePost = registraBeforePost
    AfterPost = selT810AfterPost
    AfterCancel = CancelUpdates
    BeforeDelete = AbortOperation
    AfterDelete = selT810AfterPost
    Left = 20
    Top = 56
    object selT810CAMPO1: TStringField
      FieldName = 'CAMPO1'
      Origin = 'T810_LIQUIDABILE.CAMPO1'
      Visible = False
      Size = 50
    end
    object selT810CAMPO2: TStringField
      FieldName = 'CAMPO2'
      Origin = 'T810_LIQUIDABILE.CAMPO2'
      Visible = False
      Size = 50
    end
    object selT810ANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selT810MESE: TIntegerField
      DisplayLabel = 'Mese'
      FieldName = 'MESE'
      ReadOnly = True
      Required = True
      MaxValue = 12
      MinValue = 1
    end
    object selT810VALORE: TStringField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
      Origin = 'T810_LIQUIDABILE.VALORE'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!900:00;1;_'
      Size = 7
    end
  end
  object dsrT810: TDataSource
    DataSet = selT810
    Left = 61
    Top = 56
  end
  object selT800_Data: TOracleDataSet
    SQL.Strings = (
      'select NomeCampo1,Nomecampo2'
      'from T800_campilimiti'
      'where datadecorr=(Select Max(DataDecorr) '
      '                               from T800_campilimiti '
      '                              where datadecorr <= :data'
      '                              and TipoLimite=:Tipo)'
      ' and Tipolimite=:Tipo'
      '')
    Optimize = False
    Variables.Data = {
      04000000020000000A0000003A0044004100540041000C000000000000000000
      00000A0000003A005400490050004F00050000000000000000000000}
    Left = 60
    Top = 8
    object selT800_DataNOMECAMPO1: TStringField
      FieldName = 'NOMECAMPO1'
    end
    object selT800_DataNOMECAMPO2: TStringField
      FieldName = 'NOMECAMPO2'
    end
  end
  object QLook1: TOracleDataSet
    Optimize = False
    Left = 20
    Top = 149
  end
  object dsrLook1: TDataSource
    DataSet = QLook1
    Left = 65
    Top = 149
  end
  object QLook2: TOracleDataSet
    Optimize = False
    Left = 108
    Top = 149
  end
  object dsrLook2: TDataSource
    DataSet = QLook2
    Left = 152
    Top = 148
  end
  object dsrT811: TDataSource
    DataSet = selT811
    Left = 143
    Top = 56
  end
  object selT811: TOracleDataSet
    SQL.Strings = (
      'select T811.*,T811.ROWID'
      'from T811_Residuabile T811'
      'where anno=:anno and'
      '           campo1=:campo1 and'
      '           campo2=:campo2'
      'order by mese')
    Optimize = False
    Variables.Data = {
      04000000030000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00430041004D0050004F003100050000000000000000000000
      0E0000003A00430041004D0050004F003200050000000000000000000000}
    CachedUpdates = True
    BeforeInsert = AbortOperation
    BeforePost = registraBeforePost
    AfterPost = selT811AfterPost
    AfterCancel = CancelUpdates
    BeforeDelete = AbortOperation
    AfterDelete = selT811AfterPost
    Left = 102
    Top = 56
    object selT811CAMPO1: TStringField
      FieldName = 'CAMPO1'
      Origin = 'T811_RESIDUABILE.CAMPO1'
      Visible = False
      Size = 50
    end
    object selT811CAMPO2: TStringField
      FieldName = 'CAMPO2'
      Origin = 'T811_RESIDUABILE.CAMPO2'
      Visible = False
      Size = 50
    end
    object selT811ANNO: TIntegerField
      FieldName = 'ANNO'
      Required = True
      Visible = False
    end
    object selT811MESE: TIntegerField
      FieldName = 'Mese'
      ReadOnly = True
      Required = True
      MaxValue = 12
      MinValue = 1
    end
    object selT811VALORE: TStringField
      DisplayLabel = 'Valore'
      FieldName = 'VALORE'
      Origin = 'T811_RESIDUABILE.VALORE'
      Required = True
      OnValidate = ValidateOreMinuti
      EditMask = '!900:00;1;_'
      Size = 7
    end
  end
  object Ins810: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T810_LIQUIDABILE'
      '(CAMPO1,CAMPO2,ANNO,MESE,VALORE)'
      'VALUES'
      '(:CAMPO1,:CAMPO2,:ANNO,:MESE,:VALORE)')
    Optimize = False
    Variables.Data = {
      04000000050000000E0000003A00430041004D0050004F003100050000000000
      0000000000000E0000003A00430041004D0050004F0032000500000000000000
      000000000A0000003A0041004E004E004F000300000000000000000000000A00
      00003A004D004500530045000300000000000000000000000E0000003A005600
      41004C004F0052004500050000000000000000000000}
    Left = 72
    Top = 104
  end
  object Upd810: TOracleQuery
    SQL.Strings = (
      'update T810_Liquidabile'
      'set'
      '  ANNO = :ANNO,'
      '  CAMPO1 = :CAMPO1,'
      '  CAMPO2 = :CAMPO2'
      'where'
      '  ANNO = :OLD_ANNO and'
      '  CAMPO1 = :OLD_CAMPO1 and'
      '  CAMPO2 = :OLD_CAMPO2')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00430041004D0050004F003100050000000000000000000000
      0E0000003A00430041004D0050004F0032000500000000000000000000001200
      00003A004F004C0044005F0041004E004E004F00030000000000000000000000
      160000003A004F004C0044005F00430041004D0050004F003100050000000000
      000000000000160000003A004F004C0044005F00430041004D0050004F003200
      050000000000000000000000}
    Left = 112
    Top = 104
  end
  object Del810: TOracleQuery
    SQL.Strings = (
      'delete from T810_Liquidabile'
      'where'
      '  ANNO = :OLD_ANNO and'
      '  CAMPO1 = :OLD_CAMPO1 and'
      '  CAMPO2 = :OLD_CAMPO2')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A004F004C0044005F0041004E004E004F000300
      00000000000000000000160000003A004F004C0044005F00430041004D005000
      4F003100050000000000000000000000160000003A004F004C0044005F004300
      41004D0050004F003200050000000000000000000000}
    Left = 152
    Top = 104
  end
  object SetAnno811: TOracleQuery
    SQL.Strings = (
      'update T811_Residuabile'
      'set'
      '  VALORE=:VALORE'
      'where'
      '  ANNO = :ANNO and'
      '  CAMPO1=:CAMPO1 and'
      '  CAMPO2=:CAMPO2')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A00560041004C004F0052004500050000000000
      0000000000000A0000003A0041004E004E004F00030000000000000000000000
      0E0000003A00430041004D0050004F0031000500000000000000000000000E00
      00003A00430041004D0050004F003200050000000000000000000000}
    Left = 127
    Top = 8
  end
  object SetAnno810: TOracleQuery
    SQL.Strings = (
      'update T810_Liquidabile'
      'set'
      '  VALORE=:VALORE'
      'where'
      '  ANNO = :ANNO and'
      '  CAMPO1=:CAMPO1 and'
      '  CAMPO2=:CAMPO2')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A00560041004C004F0052004500050000000000
      0000000000000A0000003A0041004E004E004F00030000000000000000000000
      0E0000003A00430041004D0050004F0031000500000000000000000000000E00
      00003A00430041004D0050004F003200050000000000000000000000}
    Left = 187
    Top = 8
  end
  object Ins811: TOracleQuery
    SQL.Strings = (
      'insert into T811_Residuabile'
      '  (ANNO, CAMPO1, CAMPO2, MESE,VALORE)'
      'values'
      '  (:ANNO, :CAMPO1, :CAMPO2, :MESE, :VALORE)')
    Optimize = False
    Variables.Data = {
      04000000050000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00430041004D0050004F003100050000000000000000000000
      0E0000003A00430041004D0050004F0032000500000000000000000000000A00
      00003A004D004500530045000300000000000000000000000E0000003A005600
      41004C004F0052004500050000000000000000000000}
    Left = 260
    Top = 104
  end
  object Upd811: TOracleQuery
    SQL.Strings = (
      'update T811_Residuabile'
      'set'
      '  ANNO = :ANNO,'
      '  CAMPO1 = :CAMPO1,'
      '  CAMPO2 = :CAMPO2'
      'where'
      '  ANNO = :OLD_ANNO and'
      '  CAMPO1 = :OLD_CAMPO1 and'
      '  CAMPO2 = :OLD_CAMPO2')
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A0041004E004E004F0003000000000000000000
      00000E0000003A00430041004D0050004F003100050000000000000000000000
      0E0000003A00430041004D0050004F0032000500000000000000000000001200
      00003A004F004C0044005F0041004E004E004F00030000000000000000000000
      160000003A004F004C0044005F00430041004D0050004F003100050000000000
      000000000000160000003A004F004C0044005F00430041004D0050004F003200
      050000000000000000000000}
    Left = 300
    Top = 104
  end
  object Del811: TOracleQuery
    SQL.Strings = (
      'delete from T811_Residuabile'
      'where'
      '  ANNO = :OLD_ANNO and'
      '  CAMPO1 = :OLD_CAMPO1 and'
      '  CAMPO2 = :OLD_CAMPO2')
    Optimize = False
    Variables.Data = {
      0400000003000000120000003A004F004C0044005F0041004E004E004F000300
      00000000000000000000160000003A004F004C0044005F00430041004D005000
      4F003100050000000000000000000000160000003A004F004C0044005F004300
      41004D0050004F003200050000000000000000000000}
    Left = 340
    Top = 104
  end
end
