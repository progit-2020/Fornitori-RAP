inherited A070FProfiliTurniDtM1: TA070FProfiliTurniDtM1
  OldCreateOrder = True
  object D602: TOracleDataSet
    SQL.Strings = (
      'select t.*, t.rowid from t602_profiliturni t')
    ReadBuffer = 25
    Optimize = False
    Debug = False
    StringFieldsOnly = False
    SequenceField.ApplyMoment = amOnPost
    OracleDictionary.EnforceConstraints = False
    OracleDictionary.UseMessageTable = False
    OracleDictionary.DefaultValues = False
    OracleDictionary.DynamicDefaults = False
    OracleDictionary.FieldKinds = False
    OracleDictionary.DisplayFormats = False
    OracleDictionary.RangeValues = False
    OracleDictionary.RequiredFields = True
    QBEDefinition.SaveQBEValues = True
    QBEDefinition.AllowFileWildCards = True
    QBEDefinition.QBEFontColor = clNone
    QBEDefinition.QBEBackgroundColor = clNone
    QBEDefinition.QBEFieldDefs = {
      030000000900000006000000434F4449434501000000000B0000004445534352
      495A494F4E4501000000001B0000004E554D4D41584747434F4E534543555449
      564944494C41564F524F01000000001B0000004E554D4D494E4E4F5454495045
      5247525550504F44494E4F54544901000000001B0000004E554D4D41584E4F54
      544950455247525550504F44494E4F5454490100000000190000004E554D5249
      504F5349444F504F5455524E4F44494E4F5454450100000000170000004E554D
      47475452414455455455524E4944494E4F5454450100000000190000004E554D
      4F4B4E4F5454495045524349434C4F46455249414C450100000000190000004E
      554D4F4B4E4F5454495045524349434C4F4645535449564F0100000000}
    Cursor = crDefault
    ReadOnly = False
    LockingMode = lmCheckImmediate
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = []
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    DesignActivation = False
    Active = False
    Left = 40
    Top = 24
    object D602CODICE: TStringField
      FieldName = 'CODICE'
      Required = True
      Size = 5
    end
    object D602DESCRIZIONE: TStringField
      FieldName = 'DESCRIZIONE'
      Size = 40
    end
    object D602NUMMAXGGCONSECUTIVIDILAVORO: TFloatField
      FieldName = 'NUMMAXGGCONSECUTIVIDILAVORO'
      Required = True
    end
    object D602NUMMINNOTTIPERGRUPPODINOTTI: TFloatField
      FieldName = 'NUMMINNOTTIPERGRUPPODINOTTI'
      Required = True
    end
    object D602NUMMAXNOTTIPERGRUPPODINOTTI: TFloatField
      FieldName = 'NUMMAXNOTTIPERGRUPPODINOTTI'
      Required = True
    end
    object D602NUMRIPOSIDOPOTURNODINOTTE: TFloatField
      FieldName = 'NUMRIPOSIDOPOTURNODINOTTE'
      Required = True
    end
    object D602NUMGGTRADUETURNIDINOTTE: TFloatField
      FieldName = 'NUMGGTRADUETURNIDINOTTE'
      Required = True
    end
    object D602NUMOKNOTTIPERCICLOFERIALE: TFloatField
      FieldName = 'NUMOKNOTTIPERCICLOFERIALE'
      Required = True
    end
    object D602NUMOKNOTTIPERCICLOFESTIVO: TFloatField
      FieldName = 'NUMOKNOTTIPERCICLOFESTIVO'
      Required = True
    end
  end
end
