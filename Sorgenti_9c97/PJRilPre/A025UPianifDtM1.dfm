object A025FPianifDtM1: TA025FPianifDtM1
  OldCreateOrder = True
  OnCreate = A025FPianifDtM1Create
  OnDestroy = A025FPianifDtM1Destroy
  Height = 80
  Width = 67
  object Q080: TOracleDataSet
    SQL.Strings = (
      'select T080.*, T080.ROWID '
      '  from T080_PIANIFORARI T080'
      ' where T080.PROGRESSIVO = :PROGRESSIVO '
      '   and T080.DATA between :DATA1 and :DATA2'
      ' order by T080.DATA')
    ReadBuffer = 1000
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000C0000003A0044004100540041003100
      0C00000000000000000000000C0000003A00440041005400410032000C000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F000100000000000800000044004100540041000100000000000C0000004F00
      52004100520049004F000100000000000C0000005400550052004E004F003100
      0100000000000C0000005400550052004E004F0032000100000000000E000000
      46004C00410047004100470047000100000000001600000049004E0044005000
      52004500530045004E005A004100010000000000100000005400550052004E00
      4F00310045005500010000000000100000005400550052004E004F0032004500
      5500010000000000140000004400410054004F004C0049004200450052004F00
      010000000000}
    BeforePost = Q080BeforePost
    AfterPost = Q080AfterPost
    BeforeDelete = Q080BeforeDelete
    AfterDelete = Q080AfterPost
    OnNewRecord = Q080NewRecord
    Left = 15
    Top = 12
    object Q080PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Origin = 'T080_PIANIFORARI.PROGRESSIVO'
      Visible = False
    end
    object Q080DATA: TDateTimeField
      DisplayLabel = 'Data'
      DisplayWidth = 10
      FieldName = 'DATA'
      Origin = 'T080_PIANIFORARI.DATA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object Q080ORARIO: TStringField
      DisplayLabel = 'Orario'
      FieldName = 'ORARIO'
      Origin = 'T080_PIANIFORARI.ORARIO'
      OnSetText = Q080ORARIOSetText
      OnValidate = Q080ORARIOValidate
      Size = 5
    end
    object Q080D_ORARIO: TStringField
      DisplayLabel = ' '
      FieldKind = fkLookup
      FieldName = 'D_ORARIO'
      LookupDataSet = A025FPianifMW.Q020
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'ORARIO'
      ReadOnly = True
      Lookup = True
    end
    object Q080TURNO1: TStringField
      DisplayLabel = '1'#176' Turno'
      FieldName = 'TURNO1'
      Origin = 'T080_PIANIFORARI.TURNO1'
      OnValidate = Q080TURNO1Validate
      Size = 2
    end
    object Q080TURNO1EU: TStringField
      DisplayLabel = 'E/U'
      FieldName = 'TURNO1EU'
      Origin = 'T080_PIANIFORARI.TURNO1EU'
      OnValidate = Q080TURNO1EUValidate
      Size = 1
    end
    object Q080TURNO2: TStringField
      DisplayLabel = '2'#176' Turno'
      FieldName = 'TURNO2'
      Origin = 'T080_PIANIFORARI.TURNO2'
      OnValidate = Q080TURNO2Validate
      Size = 2
    end
    object Q080TURNO2EU: TStringField
      DisplayLabel = 'E/U'
      FieldName = 'TURNO2EU'
      Origin = 'T080_PIANIFORARI.TURNO2EU'
      OnValidate = Q080TURNO2EUValidate
      Size = 1
    end
    object Q080VALORGIOR: TStringField
      DisplayLabel = 'Val.giorn.'
      FieldName = 'VALORGIOR'
      Visible = False
      Size = 1
    end
    object Q080FLAGAGG: TStringField
      FieldName = 'FLAGAGG'
      Origin = 'T080_PIANIFORARI.FLAGAGG'
      Visible = False
      Size = 1
    end
    object Q080INDPRESENZA: TStringField
      DisplayLabel = 'Indennit'#224
      FieldName = 'INDPRESENZA'
      Origin = 'T080_PIANIFORARI.INDPRESENZA'
      OnSetText = Q080INDPRESENZASetText
      OnValidate = Q080INDPRESENZAValidate
      Size = 5
    end
    object Q080D_INDENNITA: TStringField
      DisplayLabel = ' '
      FieldKind = fkLookup
      FieldName = 'D_INDENNITA'
      LookupDataSet = A025FPianifMW.Q163
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'INDPRESENZA'
      ReadOnly = True
      Lookup = True
    end
    object Q080DATOLIBERO: TStringField
      FieldName = 'DATOLIBERO'
      OnSetText = Q080DATOLIBEROSetText
      OnValidate = Q080DATOLIBEROValidate
    end
    object Q080D_DATOLIBERO: TStringField
      DisplayLabel = ' '
      DisplayWidth = 40
      FieldKind = fkLookup
      FieldName = 'D_DATOLIBERO'
      LookupDataSet = A025FPianifMW.selDatoLibero
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'DATOLIBERO'
      ReadOnly = True
      Size = 80
      Lookup = True
    end
    object Q080MOTIVAZIONE: TStringField
      FieldName = 'MOTIVAZIONE'
      Visible = False
      Size = 2
    end
    object Q080D_MOTIVAZIONE: TStringField
      DisplayLabel = 'Motivazione'
      FieldKind = fkLookup
      FieldName = 'D_MOTIVAZIONE'
      LookupDataSet = A025FPianifMW.cdsMotivazione
      LookupKeyFields = 'CODICE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'MOTIVAZIONE'
      Lookup = True
    end
  end
end
