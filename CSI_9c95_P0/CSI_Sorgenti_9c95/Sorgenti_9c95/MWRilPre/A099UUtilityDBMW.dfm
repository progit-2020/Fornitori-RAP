inherited A099FUtilityDBMW: TA099FUtilityDBMW
  OldCreateOrder = True
  Height = 157
  Width = 476
  object selTablespace: TOracleDataSet
    SQL.Strings = (
      'select'
      '  a.name TABLESPACE,'
      '  to_char(a.allocato,'#39'fm999g999g999g999g990'#39') ALLOCATO,'
      
        '  to_char(a.allocato - b.disponibile,'#39'fm999g999g999g999g990'#39') US' +
        'ATO,'
      '  to_char(b.disponibile,'#39'fm999g999g999g999g990'#39') DISPONIBILE,'
      
        '  to_char(100 - (b.disponibile*100/a.allocato),'#39'fm990d99'#39') "USAT' +
        'O%",'
      
        '  to_char(b.disponibile*100/a.allocato,'#39'fm990d99'#39') "DISPONIBILE%' +
        '"'
      'from'
      
        '  (select vts.name,sum(vdf.bytes) allocato from v$datafile vdf, ' +
        'v$tablespace vts'
      '   where 1=1'
      '   and vts.ts# = vdf.ts#'
      '   group by vts.name) a,'
      '  (select tablespace_name,sum(bytes) disponibile '
      '   from dba_free_space dfs'
      '   where 1=1'
      '   group by tablespace_name) b'
      'where a.name = b.tablespace_name'
      
        'and a.name in (select distinct tablespace_name from user_segment' +
        's)')
    ReadBuffer = 5
    Optimize = False
    Left = 248
    Top = 8
    object selTablespaceTABLESPACE: TStringField
      DisplayLabel = 'Tablespace'
      FieldName = 'TABLESPACE'
      Size = 30
    end
    object selTablespaceALLOCATO: TStringField
      DisplayLabel = 'Allocato (bytes)'
      FieldName = 'ALLOCATO'
      Size = 30
    end
    object selTablespaceUSATO: TStringField
      DisplayLabel = 'Usato (bytes)'
      FieldName = 'USATO'
      Size = 30
    end
    object selTablespaceDISPONIBILE: TStringField
      DisplayLabel = 'Disponibile (bytes)'
      FieldName = 'DISPONIBILE'
      Size = 30
    end
    object selTablespaceUSATO2: TStringField
      DisplayLabel = '% Usato'
      FieldName = 'USATO%'
      Size = 10
    end
    object selTablespaceDISPONIBILE2: TStringField
      DisplayLabel = '% Disp.'
      FieldName = 'DISPONIBILE%'
      Size = 10
    end
  end
  object selUserObjects: TOracleDataSet
    SQL.Strings = (
      'SELECT OBJECT_NAME,OBJECT_TYPE,STATUS FROM USER_OBJECTS '
      
        'WHERE OBJECT_TYPE IN ('#39'FUNCTION'#39','#39'PROCEDURE'#39','#39'PACKAGE'#39','#39'SYNONYM'#39 +
        ','#39'TRIGGER'#39','#39'VIEW'#39')'
      'ORDER BY OBJECT_TYPE,OBJECT_NAME')
    Optimize = False
    Left = 172
    Top = 8
  end
  object Script: TOracleScript
    Left = 108
    Top = 8
  end
  object selInd: TOracleDataSet
    SQL.Strings = (
      'SELECT INDEX_NAME FROM IND WHERE TABLE_NAME = :TABLE_NAME')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400410042004C0045005F004E0041004D00
      4500050000000000000000000000}
    Left = 60
    Top = 8
  end
  object selTabs: TOracleDataSet
    ReadBuffer = 200
    Optimize = False
    Left = 12
    Top = 8
  end
  object selSortSegment: TOracleDataSet
    SQL.Strings = (
      
        'select tablespace_name,sum(free_blocks) free_blocks from gv$sort' +
        '_segment '
      
        'where tablespace_name = (select temporary_tablespace from user_u' +
        'sers)'
      'group by tablespace_name')
    ReadBuffer = 5
    Optimize = False
    Left = 328
    Top = 8
  end
  object selLogMsg: TOracleDataSet
    SQL.Strings = (
      'select '#39'I000_LOGINFO'#39' tabella,count(*) from i000_loginfo'
      'union '
      'select '#39'I005_MSGINFO'#39',count(*) from i005_msginfo')
    ReadBuffer = 5
    Optimize = False
    Left = 400
    Top = 8
  end
  object selIndV430: TOracleDataSet
    SQL.Strings = (
      'SELECT T1.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS'
      'FROM USER_IND_COLUMNS T1,USER_INDEXES T2'
      'WHERE T1.TABLE_NAME = '#39'V430_STORICO'#39' AND'
      'T2.INDEX_NAME = T1.INDEX_NAME '
      'ORDER BY T1.INDEX_NAME,COLUMN_POSITION')
    Optimize = False
    Left = 22
    Top = 64
  end
  object scrIndV430: TOracleScript
    Left = 80
    Top = 63
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 278
    Top = 62
  end
  object selColsP430: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      
        '  C1.COLUMN_NAME,TABELLA,COLONNA_TABELLA,DECODE(C2.COLUMN_NAME,'#39 +
        'DECORRENZA'#39','#39'S'#39',NULL) DECORRENZA'
      'FROM '
      '  COLS C1, P001_TABP430 P001, COLS C2'
      'WHERE '
      '  P001.TABELLA(+) <> '#39'T030_ANAGRAFICO'#39' AND'
      '  C1.TABLE_NAME = '#39'P430_ANAGRAFICO'#39' AND'
      '  C1.COLUMN_NAME = COLONNA_P430(+) AND'
      '  C2.TABLE_NAME(+) = TABELLA AND'
      '  C2.COLUMN_NAME(+) = '#39'DECORRENZA'#39
      'ORDER BY C1.COLUMN_ID')
    ReadBuffer = 80
    Optimize = False
    Left = 218
    Top = 62
  end
  object selCOlsT430: TOracleDataSet
    SQL.Strings = (
      'SELECT '
      '  COLUMN_NAME'
      'FROM '
      '  COLS'
      'WHERE '
      '  TABLE_NAME = '#39'T430_STORICO'#39
      'ORDER BY COLUMN_ID')
    ReadBuffer = 80
    Optimize = False
    Left = 154
    Top = 62
  end
end
