object W037FRichiestaScioperiDM: TW037FRichiestaScioperiDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 76
  Width = 221
  object selT251: TOracleDataSet
    SQL.Strings = (
      '-- v. C018UIterAutDM')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000009000000180000003A00460049004C00540052004F005F0041004E00
      41004700010000000000000000000000160000003A0044004100540041004C00
      410056004F0052004F000C00000000000000000000001A0000003A0051005600
      49005300540041004F005200410043004C004500010000000000000000000000
      1E0000003A00460049004C00540052004F005F0050004500520049004F004400
      4F000100000000000000000000002E0000003A00460049004C00540052004F00
      5F00560049005300550041004C0049005A005A0041005A0049004F004E004500
      0100000000000000000000000A0000003A004900540045005200050000000000
      000000000000260000003A004C004900560045004C004C004F005F0049004E00
      5400450052004D004500440049004F0001000000000000000000000010000000
      3A0041005A00490045004E00440041000500000000000000000000002E000000
      3A004C004900560045004C004C004F005F004100550054004F00520049005A00
      5A0041005A0049004F004E004500010000000000000000000000}
    SequenceField.ApplyMoment = amOnNewRecord
    OracleDictionary.DefaultValues = True
    QBEDefinition.QBEFieldDefs = {
      050000000D00000016000000500052004F004700520045005300530049005600
      4F000100000000000E000000430041005500530041004C004500010000000000
      06000000440041004C000100000000000400000041004C000100000000001200
      00005400490050004F00470049005500530054000100000000001C0000004100
      550054004F00520049005A005A0041005A0049004F004E004500010000000000
      1800000052004500530050004F004E0053004100420049004C00450001000000
      00000E00000044004100540041004E0041005300010000000000120000004E00
      55004D00450052004F004F005200450001000000000004000000520049000100
      0000000010000000500055004C00530041004E00540045000100000000001200
      00004D00410054005200490043004F004C004100010000000000140000004E00
      4F004D0049004E0041005400490056004F00010000000000}
    UpdatingTable = 'T251_SCIOPERI_STRUTTURA'
    CommitOnPost = False
    Filtered = True
    OnCalcFields = selT251CalcFields
    Left = 21
    Top = 16
    object selT251ID: TFloatField
      FieldName = 'ID'
    end
    object selT251ID_REVOCA: TFloatField
      FieldName = 'ID_REVOCA'
    end
    object selT251ID_REVOCATO: TFloatField
      FieldName = 'ID_REVOCATO'
    end
    object selT251PROGRESSIVO: TFloatField
      FieldName = 'PROGRESSIVO'
    end
    object selT251NOMINATIVO: TStringField
      FieldName = 'NOMINATIVO'
      Size = 61
    end
    object selT251MATRICOLA: TStringField
      FieldName = 'MATRICOLA'
      Size = 8
    end
    object selT251SESSO: TStringField
      FieldName = 'SESSO'
      Size = 1
    end
    object selT251COD_ITER: TStringField
      FieldName = 'COD_ITER'
    end
    object selT251TIPO_RICHIESTA: TStringField
      FieldName = 'TIPO_RICHIESTA'
      Size = 1
    end
    object selT251AUTORIZZ_AUTOMATICA: TStringField
      FieldName = 'AUTORIZZ_AUTOMATICA'
      Size = 1
    end
    object selT251REVOCABILE: TStringField
      FieldName = 'REVOCABILE'
      Size = 10
    end
    object selT251DATA_RICHIESTA: TDateTimeField
      Alignment = taCenter
      FieldName = 'DATA_RICHIESTA'
      DisplayFormat = 'dd/mm/yyyy hhhh.nn'
    end
    object selT251LIVELLO_AUTORIZZAZIONE: TFloatField
      FieldName = 'LIVELLO_AUTORIZZAZIONE'
    end
    object selT251DATA_AUTORIZZAZIONE: TDateTimeField
      FieldName = 'DATA_AUTORIZZAZIONE'
    end
    object selT251AUTORIZZAZIONE: TStringField
      DisplayLabel = ' '
      FieldName = 'AUTORIZZAZIONE'
      Visible = False
      Size = 1
    end
    object selT251NOMINATIVO_RESP: TStringField
      FieldName = 'NOMINATIVO_RESP'
      Size = 61
    end
    object selT251AUTORIZZ_AUTOM_PREV: TStringField
      FieldName = 'AUTORIZZ_AUTOM_PREV'
      Size = 1
    end
    object selT251AUTORIZZ_PREV: TStringField
      FieldName = 'AUTORIZZ_PREV'
      Size = 1
    end
    object selT251RESPONSABILE_PREV: TStringField
      FieldName = 'RESPONSABILE_PREV'
      Size = 30
    end
    object selT251AUTORIZZ_UTILE: TStringField
      FieldName = 'AUTORIZZ_UTILE'
      Size = 1
    end
    object selT251AUTORIZZ_REVOCA: TStringField
      FieldName = 'AUTORIZZ_REVOCA'
      Size = 1
    end
    object selT251D_TIPO_RICHIESTA: TStringField
      Alignment = taCenter
      FieldKind = fkCalculated
      FieldName = 'D_TIPO_RICHIESTA'
      Size = 100
      Calculated = True
    end
    object selT251D_RESPONSABILE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_RESPONSABILE'
      Size = 84
      Calculated = True
    end
    object selT251D_AUTORIZZAZIONE: TStringField
      FieldKind = fkCalculated
      FieldName = 'D_AUTORIZZAZIONE'
      Size = 2
      Calculated = True
    end
    object selT251ID_T250: TFloatField
      FieldName = 'ID_T250'
    end
    object selT251DATA: TDateTimeField
      Alignment = taCenter
      FieldName = 'DATA'
    end
    object selT251CAUSALE: TStringField
      FieldName = 'CAUSALE'
      Size = 5
    end
    object selT251D_CAUSALE: TStringField
      FieldName = 'D_CAUSALE'
      Size = 40
    end
    object selT251TIPOGIUST: TStringField
      FieldName = 'TIPOGIUST'
      Size = 1
    end
    object selT251DAORE: TStringField
      FieldName = 'DAORE'
      Size = 5
    end
    object selT251AORE: TStringField
      FieldName = 'AORE'
      Size = 5
    end
    object selT251SELEZIONE_ANAGRAFICA: TStringField
      FieldName = 'SELEZIONE_ANAGRAFICA'
      Size = 2000
    end
    object selT251MINIMO: TIntegerField
      FieldName = 'MINIMO'
    end
  end
  object selT252: TOracleDataSet
    SQL.Strings = (
      'select T252.ID, T252.PROGRESSIVO, T252.SCIOPERA, T252.ROWID,'
      '       T030.COGNOME, T030.NOME, T030.MATRICOLA,'
      
        '       T040F_GGASSENZA(T030.PROGRESSIVO,T250.DATA,'#39'CAUSALE'#39') CAU' +
        'SALE,'
      
        '       T040F_GGASSENZA(T030.PROGRESSIVO,T250.DATA,'#39'STATO'#39') STATO' +
        ','
      
        '       T100F_TIMBESISTENTI(T030.PROGRESSIVO,T250.DATA) TIMBRATUR' +
        'E,'
      
        '       T380F_REPERIBILE_DALLE_ALLE(T030.PROGRESSIVO,T250.DATA) R' +
        'EPERIBILITA'
      'from   T250_SCIOPERI T250,'
      '       T251_SCIOPERI_STRUTTURA T251,'
      '       T252_SCIOPERI_INDIVIDUALI T252,'
      '       T030_ANAGRAFICO T030'
      'where  T250.ID = T251.ID_T250'
      'and    T251.ID = :ID'
      'and    T251.PROGRESSIVO = :PROGRESSIVO'
      'and    T252.ID = T251.ID'
      'and    T030.PROGRESSIVO = T252.PROGRESSIVO'
      'order by T030.COGNOME, T030.NOME, T030.MATRICOLA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F00040000000000000000000000060000003A0049004400040000000000
      000000000000}
    UpdatingTable = 'T252_SCIOPERI_INDIVIDUALI'
    CachedUpdates = True
    Left = 152
    Top = 16
    object selT252ID: TFloatField
      FieldName = 'ID'
      Visible = False
    end
    object selT252SCIOPERA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Sciopero'
      FieldName = 'SCIOPERA'
      Size = 1
    end
    object selT252COGNOME: TStringField
      DisplayLabel = 'Cognome'
      FieldName = 'COGNOME'
      ReadOnly = True
      Size = 30
    end
    object selT252NOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      ReadOnly = True
      Size = 30
    end
    object selT252MATRICOLA: TStringField
      Alignment = taCenter
      DisplayLabel = 'Matricola'
      FieldName = 'MATRICOLA'
      ReadOnly = True
      Size = 8
    end
    object selT252PROGRESSIVO: TFloatField
      DisplayLabel = 'Progressivo'
      FieldName = 'PROGRESSIVO'
      ReadOnly = True
      Visible = False
    end
    object selT252CAUSALE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Assenza'
      FieldName = 'CAUSALE'
      ReadOnly = True
      Size = 5
    end
    object selT252STATO: TStringField
      DisplayLabel = 'Stato (*)'
      FieldName = 'STATO'
      ReadOnly = True
      Visible = False
      Size = 1
    end
    object selT252TIMBRATURE: TStringField
      Alignment = taCenter
      DisplayLabel = 'Timbrature'
      FieldName = 'TIMBRATURE'
      Size = 1
    end
    object selT252REPERIBILITA: TStringField
      DisplayLabel = 'Reperibilit'#224
      FieldName = 'REPERIBILITA'
      Size = 200
    end
  end
  object selT250: TOracleDataSet
    SQL.Strings = (
      'select T250.ID, T250.DATA, T250.SELEZIONE_ANAGRAFICA'
      'from   T250_SCIOPERI T250,'
      '       T251_SCIOPERI_STRUTTURA T251'
      'where  T250.ID = T251.ID_T250 (+)'
      'and    T251.PROGRESSIVO(+) = :PROGRESSIVO'
      'and    T251.ID_T250 is null'
      'order by DATA desc')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000}
    Left = 88
    Top = 16
  end
end
