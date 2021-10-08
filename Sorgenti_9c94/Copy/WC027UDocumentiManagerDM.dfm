object WC027FDocumentiManagerDM: TWC027FDocumentiManagerDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 213
  Width = 278
  object selT960: TOracleDataSet
    SQL.Strings = (
      
        'select ID, DATA_CREAZIONE, NOME_UTENTE, UTENTE, PROGRESSIVO, TIP' +
        'OLOGIA, UFFICIO, NOME_FILE, EXT_FILE, DIMENSIONE, PERIODO_DAL, P' +
        'ERIODO_AL, NOTE, ROWID'
      'from   T960_DOCUMENTI_INFO'
      'where  ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    AutoCalcFields = False
    CommitOnPost = False
    Left = 40
    Top = 72
  end
  object selT961: TOracleQuery
    SQL.Strings = (
      'select DOCUMENTO'
      'from   T961_DOCUMENTI_FILE'
      'where  ID = :ID')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 104
    Top = 16
  end
  object insT961: TOracleQuery
    SQL.Strings = (
      'insert into T961_DOCUMENTI_FILE (ID, DOCUMENTO)'
      'values (:ID, :DOCUMENTO)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000060000003A00490044000300000000000000000000001400
      00003A0044004F00430055004D0045004E0054004F0071000000000000000000
      0000}
    Left = 104
    Top = 72
  end
  object selT960Count: TOracleQuery
    SQL.Strings = (
      'select count(ID)'
      'from   T960_DOCUMENTI_INFO'
      'where  ID = :ID'
      '')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 40
    Top = 16
  end
  object delT960: TOracleQuery
    SQL.Strings = (
      'delete from T960_DOCUMENTI_INFO'
      'where  ID = :ID ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 40
    Top = 136
  end
  object delT961: TOracleQuery
    SQL.Strings = (
      'delete from T961_DOCUMENTI_FILE'
      'where  ID = :ID ')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {0400000001000000060000003A0049004400030000000000000000000000}
    Left = 104
    Top = 136
  end
end
