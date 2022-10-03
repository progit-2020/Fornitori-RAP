inherited Ac01FProgettiRendiProjMW: TAc01FProgettiRendiProjMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 356
  Width = 604
  object selT751: TOracleDataSet
    SQL.Strings = (
      'select T751.*, T751.ROWID '
      'from T751_ATTIVITA_RENDICONTO T751'
      'where T751.ID_T750 = :ID'
      'order by T751.CODICE')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    OnApplyRecord = selT751ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selT751BeforePost
    AfterPost = selT751AfterPost
    BeforeDelete = selT751BeforeDelete
    AfterDelete = selT751AfterDelete
    AfterScroll = selT751AfterScroll
    OnCalcFields = selT751CalcFields
    OnNewRecord = selT751NewRecord
    Left = 88
    Top = 16
    object selT751ID_T750: TFloatField
      DisplayLabel = 'ID Progetto'
      FieldName = 'ID_T750'
      Visible = False
    end
    object selT751ID: TFloatField
      DisplayLabel = 'ID Attivit'#224
      FieldName = 'ID'
      ReadOnly = True
    end
    object selT751CODICE: TStringField
      DisplayLabel = 'Attivit'#224
      FieldName = 'CODICE'
      Size = 10
    end
    object selT751DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT751ORE_MAX: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE_MAX'
      OnValidate = ORE_MAXValidate
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT751TOT_ORE_MAX: TStringField
      DisplayLabel = 'Ore asseg.'
      FieldKind = fkCalculated
      FieldName = 'TOT_ORE_MAX'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT751TOT_ORE_FRUITO: TStringField
      DisplayLabel = 'Ore fruite'
      FieldKind = fkCalculated
      FieldName = 'TOT_ORE_FRUITO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
  end
  object dsrT751: TDataSource
    DataSet = selT751
    Left = 88
    Top = 128
  end
  object selID_T750: TOracleQuery
    SQL.Strings = (
      'select T750_ID.NEXTVAL from DUAL')
    Optimize = False
    Left = 24
    Top = 72
  end
  object selT752: TOracleDataSet
    SQL.Strings = (
      'select T752.*, T752.ROWID'
      'from T752_TASK_RENDICONTO T752'
      'where T752.ID_T751 = :ID'
      'order by T752.CODICE')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    OnApplyRecord = selT752ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selT752BeforePost
    AfterPost = selT752AfterPost
    BeforeDelete = selT752BeforeDelete
    AfterDelete = selT752AfterDelete
    AfterScroll = selT752AfterScroll
    OnCalcFields = selT752CalcFields
    OnNewRecord = selT752NewRecord
    Left = 152
    Top = 16
    object selT752ID_T751: TFloatField
      DisplayLabel = 'ID Attivit'#224
      FieldName = 'ID_T751'
      Visible = False
    end
    object selT752ID: TFloatField
      DisplayLabel = 'ID Task'
      FieldName = 'ID'
      ReadOnly = True
    end
    object selT752CODICE: TStringField
      DisplayLabel = 'Task'
      FieldName = 'CODICE'
      Size = 10
    end
    object selT752DESCRIZIONE: TStringField
      DisplayLabel = 'Descrizione'
      FieldName = 'DESCRIZIONE'
      Size = 100
    end
    object selT752ORE_MAX: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE_MAX'
      OnValidate = ORE_MAXValidate
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT752TOT_ORE_MAX: TStringField
      DisplayLabel = 'Ore asseg.'
      FieldKind = fkCalculated
      FieldName = 'TOT_ORE_MAX'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
    object selT752TOT_ORE_FRUITO: TStringField
      DisplayLabel = 'Ore fruite'
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'TOT_ORE_FRUITO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
      Calculated = True
    end
  end
  object dsrV430: TDataSource
    DataSet = selbV430
    Left = 456
    Top = 128
  end
  object selbV430: TOracleDataSet
    SQL.Strings = (
      
        'select distinct T030.MATRICOLA, T030.COGNOME, T030.NOME, T030.PR' +
        'OGRESSIVO'
      'from :QVistaOracle'
      'order by 2,3,1')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000030000001A0000003A005100560049005300540041004F0052004100
      43004C004500010000000000000000000000160000003A004400410054004100
      4C00410056004F0052004F000C0000000000000000000000180000003A004300
      3700300030004400410054004100440041004C000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 456
    Top = 16
    object selbV430MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selbV430COGNOME: TStringField
      FieldName = 'COGNOME'
      Size = 30
    end
    object selbV430NOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
    object selbV430PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
  end
  object dsrT752: TDataSource
    DataSet = selT752
    Left = 152
    Top = 128
  end
  object selT755: TOracleDataSet
    SQL.Strings = (
      'select min(T755.DATA) D_MIN, max(T755.DATA) D_MAX'
      'from T755_RICHIESTE_RENDICONTO T755,'
      '     T850_ITER_RICHIESTE T850'
      'where T850.ITER = '#39'T755'#39
      'and T850.ID = T755.ID'
      'and (   ID_T752 = :ID_T752 --task'
      '     or ID_T752 in (select ID'
      '                    from T752_TASK_RENDICONTO'
      '                    where ID_T751 = :ID_T751 --attivit'#224
      '                    or    ID_T751 in (select ID'
      
        '                                      from T751_ATTIVITA_RENDICO' +
        'NTO'
      
        '                                      where ID_T750 = :ID_T750))' +
        ') --progetto'
      'and T755.PROGRESSIVO = decode(:PROG,0,T755.PROGRESSIVO,:PROG)'
      'and T755.DATA between :DINI and :DFIN'
      'and nvl(T850.STATO,'#39'S'#39') = '#39'S'#39)
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      04000000060000000A0000003A00500052004F00470003000000000000000000
      0000100000003A00490044005F00540037003500320003000000000000000000
      0000100000003A00490044005F00540037003500310003000000000000000000
      0000100000003A00490044005F00540037003500300003000000000000000000
      00000A0000003A00440049004E0049000C00000000000000000000000A000000
      3A004400460049004E000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 344
    Top = 16
  end
  object scrT753: TOracleQuery
    SQL.Strings = (
      'begin'
      '  :N_ERR:=0;'
      '  update T753_LIMITI_IND_RENDICONTO'
      '  set DECORRENZA = :DECORRENZA'
      
        '  where ID_T752 in (select ID from T752_TASK_RENDICONTO where ID' +
        '_T751 in (select ID from T751_ATTIVITA_RENDICONTO where ID_T750 ' +
        '= :ID_T750))'
      '  and DECORRENZA = :DECORRENZA_OLD;'
      '  update T753_LIMITI_IND_RENDICONTO'
      '  set DECORRENZA_FINE = :DECORRENZA_FINE'
      
        '  where ID_T752 in (select ID from T752_TASK_RENDICONTO where ID' +
        '_T751 in (select ID from T751_ATTIVITA_RENDICONTO where ID_T750 ' +
        '= :ID_T750))'
      '  and DECORRENZA_FINE = :DECORRENZA_FINE_OLD;'
      '  select count(*) '
      '  into :N_ERR'
      '  from T753_LIMITI_IND_RENDICONTO'
      
        '  where ID_T752 in (select ID from T752_TASK_RENDICONTO where ID' +
        '_T751 in (select ID from T751_ATTIVITA_RENDICONTO where ID_T750 ' +
        '= :ID_T750))'
      
        '  and greatest(DECORRENZA,:DECORRENZA) > least(DECORRENZA_FINE,:' +
        'DECORRENZA_FINE);'
      '  if :N_ERR = 0 then'
      '    update T753_LIMITI_IND_RENDICONTO'
      '    set DECORRENZA = greatest(DECORRENZA,:DECORRENZA),'
      
        '        DECORRENZA_FINE = least(DECORRENZA_FINE,:DECORRENZA_FINE' +
        ')'
      
        '    where ID_T752 in (select ID from T752_TASK_RENDICONTO where ' +
        'ID_T751 in (select ID from T751_ATTIVITA_RENDICONTO where ID_T75' +
        '0 = :ID_T750));'
      '  else'
      '    rollback;'
      '  end if;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000006000000160000003A004400450043004F005200520045004E005A00
      41000C0000000000000000000000200000003A004400450043004F0052005200
      45004E005A0041005F00460049004E0045000C00000000000000000000001E00
      00003A004400450043004F005200520045004E005A0041005F004F004C004400
      0C0000000000000000000000280000003A004400450043004F00520052004500
      4E005A0041005F00460049004E0045005F004F004C0044000C00000000000000
      000000000C0000003A004E005F00450052005200030000000000000000000000
      100000003A00490044005F005400370035003000030000000000000000000000}
    Left = 216
    Top = 296
  end
  object cdsT753: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ROWID'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'PROGRESSIVO'
        DataType = ftInteger
      end
      item
        Name = 'DECORRENZA'
        DataType = ftDateTime
      end
      item
        Name = 'DECORRENZA_FINE'
        DataType = ftDateTime
      end>
    IndexDefs = <
      item
        Name = 'PRIMARIO'
        Fields = 'PROGRESSIVO;DECORRENZA'
      end>
    IndexName = 'PRIMARIO'
    Params = <>
    StoreDefs = True
    Left = 216
    Top = 72
  end
  object selT753: TOracleDataSet
    SQL.Strings = (
      'select T753.*, T753.ROWID'
      'from T753_LIMITI_IND_RENDICONTO T753'
      'where T753.ID_T752 = :ID'
      'order by T753.PROGRESSIVO, T753.DECORRENZA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    OnApplyRecord = selT753ApplyRecord
    CommitOnPost = False
    CachedUpdates = True
    BeforePost = selT753BeforePost
    AfterPost = selT753AfterPost
    BeforeDelete = selT753BeforeDelete
    AfterDelete = selT753AfterDelete
    OnCalcFields = selT753CalcFields
    OnNewRecord = selT753NewRecord
    Left = 216
    Top = 16
    object selT753ID_T752: TFloatField
      DisplayLabel = 'ID Task'
      FieldName = 'ID_T752'
      Visible = False
    end
    object IntegerField1: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
    end
    object StringField1: TStringField
      DisplayLabel = 'Matricola'
      FieldKind = fkLookup
      FieldName = 'MATRICOLA'
      LookupDataSet = selbV430
      LookupKeyFields = 'PROGRESSIVO'
      LookupResultField = 'MATRICOLA'
      KeyFields = 'PROGRESSIVO'
      Size = 8
      Lookup = True
    end
    object StringField2: TStringField
      DisplayLabel = 'Cognome'
      FieldKind = fkLookup
      FieldName = 'COGNOME'
      LookupDataSet = selbV430
      LookupKeyFields = 'PROGRESSIVO'
      LookupResultField = 'COGNOME'
      KeyFields = 'PROGRESSIVO'
      Size = 30
      Lookup = True
    end
    object StringField3: TStringField
      DisplayLabel = 'Nome'
      FieldKind = fkLookup
      FieldName = 'NOME'
      LookupDataSet = selbV430
      LookupKeyFields = 'PROGRESSIVO'
      LookupResultField = 'NOME'
      KeyFields = 'PROGRESSIVO'
      Size = 30
      Lookup = True
    end
    object DateTimeField1: TDateTimeField
      DisplayLabel = 'Dal'
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object DateTimeField2: TDateTimeField
      DisplayLabel = 'Al'
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object StringField4: TStringField
      DisplayLabel = 'Ore'
      FieldName = 'ORE_MAX'
      OnValidate = ORE_MAXValidate
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object StringField5: TStringField
      DisplayLabel = 'Fruito'
      FieldName = 'ORE_FRUITO'
      ReadOnly = True
      EditMask = '!9999990:00;1;_'
      Size = 10
    end
    object selT753SERVIZIO: TStringField
      DisplayLabel = 'Servizio'
      FieldKind = fkCalculated
      FieldName = 'SERVIZIO'
      Size = 50
      Calculated = True
    end
    object selT753FUNZIONE: TStringField
      DisplayLabel = 'Funzione'
      FieldKind = fkCalculated
      FieldName = 'FUNZIONE'
      Size = 50
      Calculated = True
    end
  end
  object dsrT753: TDataSource
    DataSet = selT753
    Left = 216
    Top = 128
  end
  object selID_T751: TOracleQuery
    SQL.Strings = (
      'select T751_ID.NEXTVAL from DUAL')
    Optimize = False
    Left = 88
    Top = 72
  end
  object selID_T752: TOracleQuery
    SQL.Strings = (
      'select T752_ID.NEXTVAL from DUAL')
    Optimize = False
    Left = 152
    Top = 72
  end
  object selFruitoDip: TOracleDataSet
    SQL.Strings = (
      
        'select MINUTIORE(nvl(sum(OREMINUTI(T753.ORE_FRUITO)),0)) ORE_FRU' +
        'ITO_DIP'
      'from T753_LIMITI_IND_RENDICONTO T753'
      'where ID_T752 = :ID_T752 --task'
      'or    ID_T752 in (select ID'
      '                  from T752_TASK_RENDICONTO'
      '                  where ID_T751 = :ID_T751 --attivit'#224
      '                  or    ID_T751 in (select ID'
      
        '                                    from T751_ATTIVITA_RENDICONT' +
        'O'
      
        '                                    where ID_T750 = :ID_T750)) -' +
        '-progetto')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A00490044005F00540037003500320003000000
      0000000000000000100000003A00490044005F00540037003500310003000000
      0000000000000000100000003A00490044005F00540037003500300003000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 216
    Top = 240
  end
  object selAssegTas: TOracleDataSet
    SQL.Strings = (
      'select MINUTIORE(nvl(sum(OREMINUTI(T753.ORE_MAX)),0)) ORE_ASSEG'
      'from T753_LIMITI_IND_RENDICONTO T753'
      'where ID_T752 = :ID_T752 --task')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00490044005F00540037003500320003000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 152
    Top = 240
  end
  object selAssegAtt: TOracleDataSet
    SQL.Strings = (
      'select MINUTIORE(nvl(sum(OREMINUTI(T752.ORE_MAX)),0)) ORE_ASSEG'
      'from T752_TASK_RENDICONTO T752'
      'where ID_T751 = :ID_T751 --attivit'#224)
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00490044005F00540037003500310003000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 88
    Top = 240
  end
  object selAssegPro: TOracleDataSet
    SQL.Strings = (
      'select MINUTIORE(nvl(sum(OREMINUTI(T751.ORE_MAX)),0)) ORE_ASSEG'
      'from T751_ATTIVITA_RENDICONTO T751'
      'where ID_T750 = :ID_T750 --progetto')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00490044005F00540037003500300003000000
      0000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 24
    Top = 240
  end
  object cdsRiep: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'DESCRIZIONE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'ORE_MAX'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'TOT_ORE_MAX'
        DataType = ftString
        Size = 10
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 344
    Top = 72
  end
  object insT752: TOracleQuery
    SQL.Strings = (
      
        'insert into T752_TASK_RENDICONTO (ID_T751, CODICE, DESCRIZIONE, ' +
        'ID, ORE_MAX)'
      
        'values (:ID_T751, :CODICE, :DESCRIZIONE, T752_ID.NEXTVAL, :ORE_M' +
        'AX)')
    Optimize = False
    Variables.Data = {
      04000000040000000E0000003A0043004F004400490043004500050000000000
      000000000000180000003A004400450053004300520049005A0049004F004E00
      4500050000000000000000000000100000003A004F00520045005F004D004100
      5800050000000000000000000000100000003A00490044005F00540037003500
      3100030000000000000000000000}
    Left = 152
    Top = 184
  end
  object insT751: TOracleQuery
    SQL.Strings = (
      
        'insert into T751_ATTIVITA_RENDICONTO (ID_T750, CODICE, DESCRIZIO' +
        'NE, ID, ORE_MAX)'
      'values (:ID_T750, :CODICE, :DESCRIZIONE, :ID_T751, :ORE_MAX)')
    Optimize = False
    Variables.Data = {
      0400000005000000100000003A00490044005F00540037003500300003000000
      00000000000000000E0000003A0043004F004400490043004500050000000000
      000000000000180000003A004400450053004300520049005A0049004F004E00
      4500050000000000000000000000100000003A004F00520045005F004D004100
      5800050000000000000000000000100000003A00490044005F00540037003500
      3100030000000000000000000000}
    Left = 88
    Top = 184
  end
  object selbT751: TOracleDataSet
    SQL.Strings = (
      'select T751.CODICE, T751.DESCRIZIONE, T751.ID,'
      '       /*T751.*, MINUTIORE(nvl(T_ASSEG.ORE_ASSEG,0)) ORE_ASSEG,'
      
        '       MINUTIORE(OREMINUTI(T751.ORE_MAX) - nvl(T_ASSEG.ORE_ASSEG' +
        ',0)) ORE_RESIDUE,*/ '
      
        '       MINUTIORE(least(OREMINUTI(T751.ORE_MAX) - nvl(T_ASSEG.ORE' +
        '_ASSEG,0),OREMINUTI(:ORE_MAX))) ORE_INSERIBILI'
      'from T751_ATTIVITA_RENDICONTO T751,'
      
        '     (select T752.ID_T751, nvl(sum(OREMINUTI(T752.ORE_MAX)),0) O' +
        'RE_ASSEG'
      '      from T752_TASK_RENDICONTO T752'
      '      group by T752.ID_T751) T_ASSEG'
      'where T751.ID_T750 = (select T751A.ID_T750 '
      '                      from T751_ATTIVITA_RENDICONTO T751A '
      '                      where T751A.ID = :ID_T751)'
      'and T751.ID <> :ID_T751'
      'and T_ASSEG.ID_T751 (+) = T751.ID'
      'and not exists (select 1 '
      '                from T752_TASK_RENDICONTO '
      '                where ID_T751 = T751.ID'
      '                and CODICE = :CODICE)'
      'order by T751.CODICE')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A004F00520045005F004D004100580005000000
      0000000000000000100000003A00490044005F00540037003500310003000000
      00000000000000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    Left = 88
    Top = 296
  end
  object selbT752: TOracleDataSet
    SQL.Strings = (
      
        'select T751.CODICE C_ATT, T751.DESCRIZIONE D_ATT, T751.ID ID_ATT' +
        ','
      
        '       T752.CODICE C_TAS, T752.DESCRIZIONE D_TAS, T752.ID ID_TAS' +
        ','
      '       /*T751.*, MINUTIORE(nvl(T_ASSEG.ORE_ASSEG,0)) ORE_ASSEG,'
      
        '       MINUTIORE(OREMINUTI(T751.ORE_MAX) - nvl(T_ASSEG.ORE_ASSEG' +
        ',0)) ORE_RESIDUE,*/ '
      
        '       MINUTIORE(least(OREMINUTI(T752.ORE_MAX) - nvl(T_ASSEG.ORE' +
        '_ASSEG,0),OREMINUTI(:ORE_MAX))) ORE_INSERIBILI'
      'from T751_ATTIVITA_RENDICONTO T751,'
      '     T752_TASK_RENDICONTO T752,'
      
        '     (select T753.ID_T752, nvl(sum(OREMINUTI(T753.ORE_MAX)),0) O' +
        'RE_ASSEG'
      '      from T753_LIMITI_IND_RENDICONTO T753'
      '      group by T753.ID_T752) T_ASSEG'
      'where T751.ID_T750 = (select T751A.ID_T750 '
      '                      from T751_ATTIVITA_RENDICONTO T751A '
      '                      where T751A.ID = (select T752A.ID_T751 '
      
        '                                        from T752_TASK_RENDICONT' +
        'O T752A '
      
        '                                        where T752A.ID = :ID_T75' +
        '2))'
      'and T752.ID_T751 = T751.ID'
      'and T752.ID <> :ID_T752'
      'and T_ASSEG.ID_T752 (+) = T752.ID'
      'and not exists (select 1 '
      '                from T753_LIMITI_IND_RENDICONTO'
      '                where ID_T752 = T752.ID'
      '                and PROGRESSIVO = :PROGRESSIVO'
      '                and :DECORRENZA <= DECORRENZA_FINE'
      '                and :DECORRENZA_FINE >= DECORRENZA)'
      'order by T751.CODICE, T752.CODICE')
    Optimize = False
    Variables.Data = {
      0400000005000000100000003A004F00520045005F004D004100580005000000
      0000000000000000100000003A00490044005F00540037003500320003000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004400450043004F005200
      520045004E005A0041000C0000000000000000000000200000003A0044004500
      43004F005200520045004E005A0041005F00460049004E0045000C0000000000
      000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    Left = 152
    Top = 296
  end
  object insT753: TOracleQuery
    SQL.Strings = (
      
        'insert into T753_LIMITI_IND_RENDICONTO (ID_T752, PROGRESSIVO, DE' +
        'CORRENZA, DECORRENZA_FINE, ORE_MAX, ORE_FRUITO)'
      
        'values (:ID_T752, :PROGRESSIVO, :DECORRENZA, :DECORRENZA_FINE, :' +
        'ORE_MAX, :ORE_FRUITO)')
    Optimize = False
    Variables.Data = {
      0400000006000000100000003A004F00520045005F004D004100580005000000
      0000000000000000100000003A00490044005F00540037003500320003000000
      0000000000000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A004400450043004F005200
      520045004E005A0041000C0000000000000000000000200000003A0044004500
      43004F005200520045004E005A0041005F00460049004E0045000C0000000000
      000000000000160000003A004F00520045005F00460052005500490054004F00
      050000000000000000000000}
    Left = 216
    Top = 184
  end
  object selCauIncluse: TOracleDataSet
    SQL.Strings = (
      'select '#39'Assenza'#39' TIPO, CODICE, DESCRIZIONE, '
      '       (select '#39'S'#39
      '        from dual '
      '        where exists (select 1 '
      '                      from T230_CAUASSENZE_PARSTO T230 '
      '                      where T230.ID = T265.ID '
      '                      and T230.RENDICONTA_PROGETTI = '#39'S'#39
      '                      and T230.DECORRENZA <= :DECORRENZA_FINE'
      
        '                      and T230.DECORRENZA_FINE >= :DECORRENZA)) ' +
        'RENDICONTA_PROGETTI'
      'from T265_CAUASSENZE T265'
      'union'
      'select '#39'Presenza'#39' TIPO, CODICE, DESCRIZIONE,'
      '       (select '#39'S'#39' '
      '        from dual '
      '        where exists (select 1 '
      '                      from T235_CAUPRESENZE_PARSTO T235 '
      '                      where T235.ID = T275.ID '
      '                      and T235.RENDICONTA_PROGETTI = '#39'S'#39
      '                      and T235.DECORRENZA <= :DECORRENZA_FINE'
      
        '                      and T235.DECORRENZA_FINE >= :DECORRENZA)) ' +
        'RENDICONTA_PROGETTI'
      'from T275_CAUPRESENZE T275'
      'order by CODICE')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000002000000200000003A004400450043004F005200520045004E005A00
      41005F00460049004E0045000C0000000000000000000000160000003A004400
      450043004F005200520045004E005A0041000C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 24
    Top = 128
  end
  object selT754: TOracleDataSet
    SQL.Strings = (
      'select T754.*, T754.ROWID'
      'from T754_PROPRIETA_IND_RENDICONTO T754'
      'where T754.ID_T750 = :ID'
      'order by T754.PROGRESSIVO')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    CommitOnPost = False
    CachedUpdates = True
    OnCalcFields = selT754CalcFields
    Left = 280
    Top = 16
    object selT754ID_T750: TFloatField
      DisplayLabel = 'ID Progetto'
      FieldName = 'ID_T750'
    end
    object selT754PROGETTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'PROGETTO'
      Size = 121
      Calculated = True
    end
    object selT754PROGRESSIVO: TIntegerField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
    end
    object selT754DIPENDENTE: TStringField
      FieldKind = fkCalculated
      FieldName = 'DIPENDENTE'
      Size = 70
      Calculated = True
    end
    object selT754SERVIZIO: TStringField
      DisplayLabel = 'Servizio'
      FieldName = 'SERVIZIO'
      Size = 50
    end
    object selT754FUNZIONE: TStringField
      DisplayLabel = 'Funzione'
      FieldName = 'FUNZIONE'
      Size = 50
    end
  end
  object dsrT754: TDataSource
    DataSet = selT754
    Left = 280
    Top = 128
  end
  object selT756: TOracleDataSet
    SQL.Strings = (
      'select T756.*, T756.ROWID'
      'from T756_REPORTING_RENDICONTO T756'
      'where T756.ID_T750 = :ID'
      'order by T756.DECORRENZA')
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000A00000016000000500052004F004700520045005300530049005600
      4F00010000000000180000005400490050004F005F0052004900530043004800
      49004F000100000000001600000044004100540041005F0049004E0049005A00
      49004F000100000000001600000044004100540041005F005600490053004900
      540041000100000000001800000045005300490054004F005F00560049005300
      4900540041000100000000002000000044004100540041005F00500052004F00
      58005F00560049005300490054004100010000000000080000004E004F005400
      45000100000000000E0000004F00470047004500540054004F00010000000000
      1800000050005200450053004300520049005A0049004F004E00450001000000
      00001400000044004100540041005F0045005300490054004F00010000000000}
    CommitOnPost = False
    CachedUpdates = True
    OnCalcFields = selT756CalcFields
    OnNewRecord = selT756NewRecord
    Left = 400
    Top = 16
    object selT756ID_T750: TFloatField
      DisplayLabel = 'ID Progetto'
      FieldName = 'ID_T750'
      Visible = False
    end
    object selT756PROGETTO: TStringField
      FieldKind = fkCalculated
      FieldName = 'PROGETTO'
      Visible = False
      Size = 121
      Calculated = True
    end
    object selT756CODICE: TStringField
      DisplayLabel = 'Codice'
      DisplayWidth = 10
      FieldName = 'CODICE'
      Size = 5
    end
    object selT756DECORRENZA: TDateTimeField
      DisplayLabel = 'Dal'
      DisplayWidth = 10
      FieldName = 'DECORRENZA'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
    object selT756DECORRENZA_FINE: TDateTimeField
      DisplayLabel = 'Al'
      DisplayWidth = 10
      FieldName = 'DECORRENZA_FINE'
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '!00/00/0000;1;_'
    end
  end
  object dsrT756: TDataSource
    DataSet = selT756
    Left = 400
    Top = 128
  end
  object selT750Copia: TOracleDataSet
    SQL.Strings = (
      'select CODICE, DESCRIZIONE, DECORRENZA, DECORRENZA_FINE, ID'
      'from T750_PROGETTI_RENDICONTO T750'
      
        'where DECORRENZA = (select MAX(DECORRENZA) from T750_PROGETTI_RE' +
        'NDICONTO T750A where T750A.CODICE = T750.CODICE)'
      
        'and exists (select 1 from T751_ATTIVITA_RENDICONTO T751 where T7' +
        '51.ID_T750 = T750.ID)'
      'order by CODICE')
    ReadBuffer = 5000
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      050000000500000016000000500052004F004700520045005300530049005600
      4F00010000000000120000004D00410054005200490043004F004C0041000100
      000000000E00000043004F0047004E004F004D00450001000000000008000000
      4E004F004D004500010000000000140000004700470053004500520056004900
      5A0049004F00010000000000}
    Left = 24
    Top = 16
  end
  object scrCopiaDettaglio: TOracleQuery
    SQL.Strings = (
      'declare'
      
        '  CURSOR C1 IS --Sommo delle ore assegnate ai dipendenti su peri' +
        'odi spezzati'
      
        '    select ID_T752, PROGRESSIVO, min(DECORRENZA) DECORRENZA, LPA' +
        'D(MINUTIORE(nvl(sum(OREMINUTI(ORE_MAX)),0)),5,'#39'0'#39') ORE_MAX'
      '    from T753_LIMITI_IND_RENDICONTO'
      
        '    where ID_T752 in (select ID from T752_TASK_RENDICONTO where ' +
        'ID_T751 in (select ID from T751_ATTIVITA_RENDICONTO where ID_T75' +
        '0 = :ID_T750_A))'
      '    group by ID_T752, PROGRESSIVO'
      '    having count(*) > 1;  '
      '  DECORRENZA_A DATE;'
      '  DECORRENZA_FINE_A DATE;'
      '  ORE_MAX_ATT VARCHAR2(10);'
      'begin'
      '  :ERR:='#39#39';'
      ''
      '  --Recupero le date del progetto di arrivo'
      '  select DECORRENZA, DECORRENZA_FINE '
      '  into DECORRENZA_A, DECORRENZA_FINE_A '
      '  from T750_PROGETTI_RENDICONTO'
      '  where ID = :ID_T750_A;'
      '  '
      
        '  --Copio le attivit'#224' del progetto di partenza sul progetto di a' +
        'rrivo'
      
        '  insert into T751_ATTIVITA_RENDICONTO (ID_T750, CODICE, DESCRIZ' +
        'IONE, ID, ORE_MAX)'
      
        '  select :ID_T750_A, T751DA.CODICE, T751DA.DESCRIZIONE, T751_ID.' +
        'NEXTVAL, T751DA.ORE_MAX'
      '  from T751_ATTIVITA_RENDICONTO T751DA'
      '  where T751DA.ID_T750 = :ID_T750_DA;'
      ''
      
        '  --Copio i task delle attivit'#224' del progetto di partenza sul pro' +
        'getto di arrivo'
      
        '  insert into T752_TASK_RENDICONTO (ID_T751, CODICE, DESCRIZIONE' +
        ', ID, ORE_MAX)'
      '  select (select T751A.ID '
      '          from T751_ATTIVITA_RENDICONTO T751A '
      '          where T751A.ID_T750 = :ID_T750_A'
      '          and T751A.CODICE = T751DA.CODICE), '
      
        '          T752DA.CODICE, T752DA.DESCRIZIONE, T752_ID.NEXTVAL, T7' +
        '52DA.ORE_MAX'
      '  from T751_ATTIVITA_RENDICONTO T751DA,'
      '       T752_TASK_RENDICONTO T752DA'
      '  where T751DA.ID_T750 = :ID_T750_DA'
      '  and T752DA.ID_T751 = T751DA.ID;'
      ''
      
        '  --Copio i dipendenti assegnati ai task delle attivit'#224' del prog' +
        'etto di partenza sul progetto di arrivo'
      
        '  insert into T753_LIMITI_IND_RENDICONTO (ID_T752, PROGRESSIVO, ' +
        'DECORRENZA, DECORRENZA_FINE, ORE_MAX, ORE_FRUITO)'
      '  select (select T752A.ID '
      '          from T751_ATTIVITA_RENDICONTO T751A,'
      '               T752_TASK_RENDICONTO T752A'
      '          where T751A.ID_T750 = :ID_T750_A'
      '          and T751A.CODICE = T751DA.CODICE'
      '          and T752A.ID_T751 = T751A.ID'
      '          and T752A.CODICE = T752DA.CODICE), '
      
        '          T753DA.PROGRESSIVO, T753DA.DECORRENZA, T753DA.DECORREN' +
        'ZA_FINE, T753DA.ORE_MAX, '#39'00.00'#39
      '  from T751_ATTIVITA_RENDICONTO T751DA,'
      '       T752_TASK_RENDICONTO T752DA,'
      '       T753_LIMITI_IND_RENDICONTO T753DA'
      '  where T751DA.ID_T750 = :ID_T750_DA'
      '  and T752DA.ID_T751 = T751DA.ID'
      '  and T753DA.ID_T752 = T752DA.ID;'
      '  '
      '  for T1 in C1 loop'
      '  begin  '
      
        '    --Sommo su un unico periodo le ore del task assegnate al dip' +
        'endente su periodi spezzati'
      '    update T753_LIMITI_IND_RENDICONTO'
      '    set ORE_MAX = T1.ORE_MAX'
      '    where ID_T752 = T1.ID_T752'
      '    and PROGRESSIVO = T1.PROGRESSIVO'
      '    and DECORRENZA = T1.DECORRENZA;'
      
        '    --Elimino i periodi diversi da quello che contiene il totale' +
        ' delle ore del task assegnate al dipendente'
      '    delete T753_LIMITI_IND_RENDICONTO'
      '    where ID_T752 = T1.ID_T752'
      '    and PROGRESSIVO = T1.PROGRESSIVO'
      '    and DECORRENZA <> T1.DECORRENZA;'
      '  end;  '
      '  end loop;'
      '  '
      
        '  --Inizializzo le date dell'#39'unico periodo rimasto ai dipendenti' +
        ' assegnati ai task delle attivit'#224' del progetto di arrivo'
      '  update T753_LIMITI_IND_RENDICONTO'
      '  set DECORRENZA = DECORRENZA_A,'
      '      DECORRENZA_FINE = DECORRENZA_FINE_A'
      
        '  where ID_T752 in (select ID from T752_TASK_RENDICONTO where ID' +
        '_T751 in (select ID from T751_ATTIVITA_RENDICONTO where ID_T750 ' +
        '= :ID_T750_A));'
      ''
      '  --Cancello le propriet'#224' dei dipendenti del progetto di arrivo'
      '  delete T754_PROPRIETA_IND_RENDICONTO T754A'
      '  where T754A.ID_T750 = :ID_T750_A;'
      ''
      
        '  --Copio le propriet'#224' dei dipendenti del progetto di partenza s' +
        'ul progetto di arrivo'
      
        '  insert into T754_PROPRIETA_IND_RENDICONTO (ID_T750, PROGRESSIV' +
        'O, SERVIZIO, FUNZIONE)'
      
        '  select :ID_T750_A, T754DA.PROGRESSIVO, T754DA.SERVIZIO, T754DA' +
        '.FUNZIONE'
      '  from T754_PROPRIETA_IND_RENDICONTO T754DA'
      '  where T754DA.ID_T750 = :ID_T750_DA;'
      '  '
      
        '  --Recupero le ore assegnate alle attivit'#224' del progetto di arri' +
        'vo'
      '  select MINUTIORE(nvl(sum(OREMINUTI(T751.ORE_MAX)),0))'
      '  into ORE_MAX_ATT'
      '  from T751_ATTIVITA_RENDICONTO T751'
      '  where T751.ID_T750 = :ID_T750_A;'
      ''
      
        '  --Incremento le ore assegnate del progetto di arrivo se inferi' +
        'ori a quelle assegnate alle sue attivit'#224
      '  update T750_PROGETTI_RENDICONTO'
      
        '  set ORE_MAX = MINUTIORE(GREATEST(OREMINUTI(ORE_MAX),OREMINUTI(' +
        'ORE_MAX_ATT)))'
      '  where ID = :ID_T750_A;'
      ''
      '  COMMIT;'
      '  '
      'exception'
      '  when others then'
      '  begin'
      '    :ERR:='#39'Error code '#39' || SQLCODE || '#39': '#39' || SQLERRM;'
      '    ROLLBACK;'
      '  end;'
      'end;')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A00490044005F0054003700350030005F004100
      030000000000000000000000080000003A004500520052000500000000000000
      00000000160000003A00490044005F0054003700350030005F00440041000300
      00000000000000000000}
    Left = 280
    Top = 296
  end
end
