object A128FPianPrestazioniAggiuntiveDtm: TA128FPianPrestazioniAggiuntiveDtm
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 68
  Width = 193
  object D010: TDataSource
    Left = 144
    Top = 8
  end
  object Q332St: TOracleDataSet
    ReadBuffer = 2000
    Optimize = False
    Left = 80
    Top = 8
  end
  object selT332: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T332.DATA,T332.PROGRESSIVO,T332.TURNO1,T332.TURNO2,T332.R' +
        'OWID'
      'FROM   T332_PIAN_ATT_AGGIUNTIVE T332,'
      '       T030_ANAGRAFICO T030,'
      '       T480_COMUNI T480,'
      '       V430_STORICO V430  '
      'WHERE  T030.PROGRESSIVO = T332.PROGRESSIVO AND'
      '       T332.DATA BETWEEN :DATADA AND :DATAA '
      '      :FILTRO'
      'ORDER BY T332.DATA,T030.COGNOME,T030.NOME,MATRICOLA')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A004400410054004100440041000C0000000000
      0000000000000C0000003A00440041005400410041000C000000000000000000
      00000E0000003A00460049004C00540052004F00010000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      0500000004000000080000004400410054004100010000000000160000005000
      52004F0047005200450053005300490056004F000100000000000C0000005400
      550052004E004F0031000100000000000C0000005400550052004E004F003200
      010000000000}
    UpdatingTable = 'T332_PIAN_ATT_AGGIUNTIVE'
    BeforeInsert = selT332BeforeInsert
    BeforePost = selT332BeforePost
    AfterPost = selT332AfterPost
    BeforeDelete = selT332BeforeDelete
    AfterDelete = selT332AfterPost
    OnNewRecord = selT332NewRecord
    Left = 16
    Top = 8
    object selT332PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      Required = True
      Visible = False
    end
    object selT332DATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Required = True
      OnValidate = selT332DATAValidate
      DisplayFormat = 'dd/mm/yyyy'
    end
    object selT332TURNO1: TStringField
      DisplayLabel = '1'#176' Turno'
      FieldName = 'TURNO1'
      OnSetText = selT332TURNO1SetText
      OnValidate = selT332TURNO1Validate
      Size = 5
    end
    object selT332TURNO2: TStringField
      DisplayLabel = '2'#176' Turno'
      FieldName = 'TURNO2'
      OnSetText = selT332TURNO1SetText
      OnValidate = selT332TURNO1Validate
      Size = 5
    end
    object selT332D_MATRICOLA: TStringField
      DisplayLabel = 'Matricola'
      FieldKind = fkCalculated
      FieldName = 'D_MATRICOLA'
      Size = 8
      Calculated = True
    end
    object selT332D_BADGE: TFloatField
      DisplayLabel = 'Badge'
      FieldKind = fkCalculated
      FieldName = 'D_BADGE'
      Calculated = True
    end
    object selT332D_NOMINATIVO: TStringField
      DisplayLabel = 'Nominativo'
      FieldKind = fkCalculated
      FieldName = 'D_NOMINATIVO'
      Size = 50
      Calculated = True
    end
  end
end
