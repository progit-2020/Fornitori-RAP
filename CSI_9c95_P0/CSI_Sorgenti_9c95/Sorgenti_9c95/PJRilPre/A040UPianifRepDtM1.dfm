object A040FPianifRepDtM1: TA040FPianifRepDtM1
  OldCreateOrder = True
  OnCreate = A040FPianifRepDtM1Create
  OnDestroy = A040FPianifRepDtM1Destroy
  Height = 78
  Width = 327
  object D010: TDataSource
    Left = 69
    Top = 12
  end
  object Q380St: TOracleDataSet
    ReadBuffer = 2000
    Optimize = False
    Left = 164
    Top = 12
  end
  object selT380: TOracleDataSet
    SQL.Strings = (
      'SELECT T380.DATA,T380.PROGRESSIVO,'
      
        '       T380.TURNO1,T380.PRIORITA1,T380F_SUPERO_MAXMESE(T380.PROG' +
        'RESSIVO,T380.DATA,T380.TURNO1) SUPERO_MAXMESE1,'
      
        '       T380.TURNO2,T380.PRIORITA2,T380F_SUPERO_MAXMESE(T380.PROG' +
        'RESSIVO,T380.DATA,T380.TURNO2) SUPERO_MAXMESE2,'
      
        '       T380.TURNO3,T380.PRIORITA3,T380F_SUPERO_MAXMESE(T380.PROG' +
        'RESSIVO,T380.DATA,T380.TURNO3) SUPERO_MAXMESE3,'
      '       T380.DATOLIBERO,T380.TIPOLOGIA,T380.ROWID'
      'FROM   T380_PIANIFREPERIB T380,'
      '       T030_ANAGRAFICO T030,'
      '       T480_COMUNI T480,'
      '       V430_STORICO V430'
      'WHERE  T030.PROGRESSIVO = T380.PROGRESSIVO AND'
      '       T380.DATA BETWEEN :DATADA AND :DATAA AND'
      '       T380.TIPOLOGIA = :TIPOLOGIA'
      '      :FILTRO'
      'ORDER BY T380.DATA,T030.COGNOME,T030.NOME,MATRICOLA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000
      140000003A005400490050004F004C004F004700490041000500000000000000
      00000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000006000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000140000004400410054004F004C0049004200450052004F000100
      000000000C0000005400550052004E004F003300010000000000}
    BeforeInsert = selT380BeforeInsert
    BeforePost = selT380BeforePost
    AfterPost = selT380AfterPost
    BeforeDelete = selT380BeforeDelete
    AfterDelete = selT380AfterPost
    OnNewRecord = selT380NewRecord
    Left = 17
    Top = 11
    object selT380PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT380DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Required = True
      OnValidate = selT380DATAValidate
      EditMask = '!99/99/0000;1;_'
    end
    object selT380TURNO1: TStringField
      DisplayLabel = '1'#176' Turno'
      FieldName = 'TURNO1'
      Required = True
      OnSetText = TURNOSetText
      OnValidate = TURNOValidate
      Size = 5
    end
    object selT380PRIORITA1: TIntegerField
      DisplayLabel = 'Priorit'#224' 1'
      DisplayWidth = 2
      FieldName = 'PRIORITA1'
      MaxValue = 9
      MinValue = 1
    end
    object selT380SUPERO_MAXMESE1: TStringField
      FieldName = 'SUPERO_MAXMESE1'
      Visible = False
      Size = 1
    end
    object selT380TURNO2: TStringField
      DisplayLabel = '2'#176' Turno'
      FieldName = 'TURNO2'
      OnSetText = TURNOSetText
      OnValidate = TURNOValidate
      Size = 5
    end
    object selT380PRIORITA2: TIntegerField
      DisplayLabel = 'Priorit'#224' 2'
      DisplayWidth = 2
      FieldName = 'PRIORITA2'
      MaxValue = 9
      MinValue = 1
    end
    object selT380SUPERO_MAXMESE2: TStringField
      FieldName = 'SUPERO_MAXMESE2'
      Visible = False
      Size = 1
    end
    object selT380TURNO3: TStringField
      DisplayLabel = '3'#176' Turno'
      FieldName = 'TURNO3'
      OnSetText = TURNOSetText
      OnValidate = TURNOValidate
      Size = 5
    end
    object selT380PRIORITA3: TIntegerField
      DisplayLabel = 'Priorit'#224' 3'
      DisplayWidth = 2
      FieldName = 'PRIORITA3'
      MaxValue = 9
      MinValue = 1
    end
    object selT380SUPERO_MAXMESE3: TStringField
      FieldName = 'SUPERO_MAXMESE3'
      Visible = False
      Size = 1
    end
    object selT380DATOLIBERO: TStringField
      FieldName = 'DATOLIBERO'
      OnSetText = selT380DATOLIBEROSetText
      OnValidate = selT380DATOLIBEROValidate
    end
    object selT380D_BADGE: TFloatField
      DisplayLabel = 'Badge'
      FieldKind = fkCalculated
      FieldName = 'D_BADGE'
      Calculated = True
    end
    object selT380D_MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldKind = fkCalculated
      FieldName = 'D_MATRICOLA'
      KeyFields = 'DATA'
      Visible = False
      Size = 8
      Calculated = True
    end
    object selT380D_NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      FieldKind = fkCalculated
      FieldName = 'D_NOMINATIVO'
      Size = 50
      Calculated = True
    end
    object selT380TIPOLOGIA: TStringField
      FieldName = 'TIPOLOGIA'
      Visible = False
      Size = 1
    end
  end
  object D010B: TDataSource
    Left = 109
    Top = 12
  end
  object selT350Cod: TOracleDataSet
    ReadBuffer = 20
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A005400490050004F004C004F00470049004100
      050000000000000000000000}
    Filtered = True
    Left = 216
    Top = 12
  end
  object selTurni: TOracleDataSet
    SQL.Strings = (
      'SELECT :HINTT030V430'
      '       T380.TURNO1 TURNO'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO1 IS NOT NULL'
      'UNION'
      'SELECT :HINTT030V430'
      '       T380.TURNO2'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO2 IS NOT NULL'
      'UNION'
      'SELECT :HINTT030V430'
      '       T380.TURNO3'
      'FROM   T380_PIANIFREPERIB T380,'
      '       :C700SelAnagrafe'
      'AND    T380.PROGRESSIVO = T030.PROGRESSIVO'
      'AND    T380.DATA BETWEEN :DATA1 AND :DATA2'
      'AND    T380.TIPOLOGIA = :TIPOLOGIA'
      'AND    T380.TURNO3 IS NOT NULL'
      '')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000005000000200000003A004300370030003000530045004C0041004E00
      4100470052004100460045000100000000000000000000001A0000003A004800
      49004E0054005400300033003000560034003300300001000000000000000000
      00000C0000003A00440041005400410031000C00000000000000000000000C00
      00003A00440041005400410032000C0000000000000000000000140000003A00
      5400490050004F004C004F00470049004100050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000C00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      120000005400490050004F004700490055005300540001000000000006000000
      440041004C000100000000000400000041004C00010000000000120000004E00
      55004D00450052004F004F00520045000100000000000E000000440041005400
      41004E00410053000100000000001C0000004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000180000005200450053005000
      4F004E0053004100420049004C004500010000000000140000004E004F004D00
      49004E0041005400490056004F00010000000000120000004D00410054005200
      490043004F004C00410001000000000016000000440045005300430052004900
      5A0049004F004E004500010000000000}
    Left = 274
    Top = 12
  end
end
