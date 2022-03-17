inherited A026FDatiLiberiMW: TA026FDatiLiberiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 259
  Width = 590
  object T430: TOracleDataSet
    SQL.Strings = (
      'SELECT COLUMN_NAME,DATA_TYPE,DATA_LENGTH,NULLABLE '
      'FROM COLS '
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39
      
        'AND COLUMN_NAME NOT IN ('#39'ABCAUSALE2'#39','#39'ABCAUSALE3'#39','#39'ABCAUSALE4'#39','#39 +
        'ABCAUSALE5'#39','#39'ABCAUSALE6'#39','
      
        '                        '#39'ABPRESENZA2'#39','#39'ABPRESENZA3'#39','#39'ABPRESENZA4' +
        #39','#39'ABPRESENZA5'#39','#39'ABPRESENZA6'#39','#39'ABPRESENZA7'#39','#39'ABPRESENZA8'#39')'
      'ORDER BY COLUMN_ID')
    ReadBuffer = 100
    Optimize = False
    Left = 345
    Top = 20
  end
  object Q430: TOracleQuery
    Optimize = False
    Left = 287
    Top = 76
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 184
    Top = 132
  end
  object QIndx: TOracleDataSet
    SQL.Strings = (
      'SELECT T1.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS'
      'FROM USER_IND_COLUMNS T1,USER_INDEXES T2'
      'WHERE T1.TABLE_NAME = '#39'T430_STORICO'#39' AND'
      'T2.INDEX_NAME = T1.INDEX_NAME '
      'ORDER BY T1.INDEX_NAME,COLUMN_POSITION')
    Optimize = False
    Left = 248
    Top = 132
  end
  object DropQ430_Appoggio: TOracleQuery
    SQL.Strings = (
      'DROP TABLE T430_APPOGGIO')
    Optimize = False
    Left = 376
    Top = 76
  end
  object selT033B: TOracleDataSet
    SQL.Strings = (
      'SELECT NOMEPAGINA FROM T033_LAYOUT WHERE '
      'NOME = '#39'DEFAULT'#39' AND'
      'CAMPODB = :CampoDb')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A00430041004D0050004F004400420005000000
      090000004C4F43414C4954410000000000}
    Left = 185
    Top = 20
  end
  object updT033: TOracleQuery
    SQL.Strings = (
      'UPDATE T033_LAYOUT SET '
      'NOMEPAGINA = :NOMEPAGINA WHERE '
      'CAMPODB = :CAMPODB')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A004E004F004D00450050004100470049004E00
      4100050000000000000000000000100000003A00430041004D0050004F004400
      4200050000000000000000000000}
    Left = 182
    Top = 76
  end
  object insT033: TOracleQuery
    SQL.Strings = (
      'INSERT INTO T033_LAYOUT'
      '  (Nome,Top,Lft,Caption,Accesso,NomePagina,CampoDB)'
      'VALUES'
      '  (:Nome,:Top,:Lft,:Caption,:Accesso,:NomePagina,:CampoDB)')
    Optimize = False
    Variables.Data = {
      04000000070000000A0000003A004E004F004D00450005000000000000000000
      0000080000003A0054004F005000030000000000000000000000080000003A00
      4C0046005400030000000000000000000000100000003A004300410050005400
      49004F004E00050000000000000000000000100000003A004100430043004500
      530053004F00050000000000000000000000160000003A004E004F004D004500
      50004100470049004E004100050000000000000000000000100000003A004300
      41004D0050004F0044004200050000000000000000000000}
    Left = 234
    Top = 76
  end
  object selT033C: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NDATILIBERI FROM T033_LAYOUT WHERE '
      'NOME = '#39'DEFAULT'#39' AND'
      'NOMEPAGINA = :NomePagina')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A004E004F004D00450050004100470049004E00
      4100050000000000000000000000}
    Left = 238
    Top = 20
  end
  object selT033D: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME FROM T033_LAYOUT')
    Optimize = False
    Left = 292
    Top = 20
  end
  object T030: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*)'
      'FROM '
      '(SELECT COLUMN_NAME FROM COLS '
      'WHERE TABLE_NAME = '#39'T030_ANAGRAFICO'#39
      'AND COLUMN_NAME = :COLUMN_NAME'
      'UNION'
      'SELECT COLUMN_NAME FROM COLS '
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39
      'AND COLUMN_NAME = :COLUMN_NAME)')
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A0043004F004C0055004D004E005F004E004100
      4D004500050000000A0000004D41545249434F4C410000000000}
    Left = 78
    Top = 20
  end
  object scrI501: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  INSERT INTO :TabDest (:Col) SELECT :Col FROM :TabSorg T1 WHERE' +
        ' CODICE <> '#39'*'#39' AND DECORRENZA ='
      
        '    (SELECT MAX(DECORRENZA) FROM :TabSorg WHERE CODICE = T1.CODI' +
        'CE);'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0054004100420053004F005200470001000000
      0000000000000000080000003A0043004F004C00010000000000000000000000
      100000003A005400410042004400450053005400010000000000000000000000}
    Left = 24
    Top = 132
  end
  object scraI501: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      
        '  INSERT INTO :TabDest (:Col) SELECT :Col FROM :TabSorg WHERE CO' +
        'DICE <> '#39'*'#39';'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A0054004100420053004F005200470001000000
      0000000000000000080000003A0043004F004C00010000000000000000000000
      100000003A005400410042004400450053005400010000000000000000000000}
    Left = 72
    Top = 132
  end
  object selCols: TOracleDataSet
    SQL.Strings = (
      
        'SELECT '#39'S'#39' FROM COLS WHERE TABLE_NAME = :TabSorg AND COLUMN_NAME' +
        ' = '#39'DECORRENZA'#39)
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0054004100420053004F005200470005000000
      0000000000000000}
    Left = 388
    Top = 20
  end
  object insI010: TOracleQuery
    SQL.Strings = (
      'INSERT INTO I010_CAMPIANAGRAFICI '
      '  (APPLICAZIONE, NOME_CAMPO, NOME_LOGICO, VAL_DEFAULT)'
      
        'SELECT DISTINCT APPLICAZIONE, :NomeCampo,:NomeLogico,:ValDefault' +
        ' '
      '  FROM I010_CAMPIANAGRAFICI '
      '')
    Optimize = False
    Variables.Data = {
      0400000003000000140000003A004E004F004D004500430041004D0050004F00
      050000000000000000000000160000003A004E004F004D0045004C004F004700
      490043004F00050000000000000000000000160000003A00560041004C004400
      45004600410055004C005400050000000000000000000000}
    Left = 24
    Top = 76
  end
  object updI010: TOracleQuery
    SQL.Strings = (
      
        'UPDATE I010_CAMPIANAGRAFICI SET VAL_DEFAULT = :ValDefault WHERE ' +
        'NOME_CAMPO = :NomeCampo')
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A00560041004C00440045004600410055004C00
      5400050000000000000000000000140000003A004E004F004D00450043004100
      4D0050004F00050000000000000000000000}
    Left = 77
    Top = 76
  end
  object delI010: TOracleQuery
    SQL.Strings = (
      'DELETE I010_CAMPIANAGRAFICI WHERE NOME_CAMPO = :NomeCampo')
    Optimize = False
    Variables.Data = {
      0400000001000000140000003A004E004F004D004500430041004D0050004F00
      050000000000000000000000}
    Left = 129
    Top = 76
  end
  object selaCols: TOracleDataSet
    SQL.Strings = (
      
        'SELECT COLUMN_NAME FROM COLS, I500_DATILIBERI WHERE TABLE_NAME =' +
        ' :NomeTabella AND'
      'COLUMN_NAME NOT IN ('#39'CODICE'#39','#39'DECORRENZA'#39','#39'DESCRIZIONE'#39')'
      'AND COLUMN_NAME = NOMECAMPO AND STORICO = '#39'S'#39)
    Optimize = False
    Variables.Data = {
      0400000001000000180000003A004E004F004D00450054004100420045004C00
      4C004100050000000000000000000000}
    Left = 436
    Top = 20
  end
  object insI501: TOracleQuery
    SQL.Strings = (
      
        'INSERT INTO :NomeTabella (CODICE,DECORRENZA) SELECT CODICE, TO_D' +
        'ATE('#39'01011900'#39','#39'DDMMYYYY'#39') FROM'
      '  (SELECT DISTINCT :NomeDato AS CODICE '
      '     FROM T430_STORICO '
      '    WHERE :NomeDato IS NOT NULL'
      '    MINUS'
      '   SELECT DISTINCT CODICE '
      '     FROM :NomeTabella'
      '    WHERE CODICE IS NOT NULL)')
    Optimize = False
    Variables.Data = {
      0400000002000000120000003A004E004F004D0045004400410054004F000100
      00000000000000000000180000003A004E004F004D0045005400410042004500
      4C004C004100010000000000000000000000}
    Left = 120
    Top = 132
  end
  object selUserTriggers: TOracleDataSet
    SQL.Strings = (
      'SELECT TRIGGER_NAME,DESCRIPTION,WHEN_CLAUSE,TRIGGER_BODY,STATUS'
      'FROM USER_TRIGGERS WHERE TABLE_NAME = '#39'T430_STORICO'#39)
    Optimize = False
    Left = 312
    Top = 132
  end
  object selUserTabPrivs: TOracleDataSet
    SQL.Strings = (
      
        'SELECT '#39'GRANT '#39' || PRIVILEGE || '#39' ON '#39' || TABLE_NAME || '#39' TO '#39' |' +
        '| GRANTEE PRIVILEGI'
      'FROM USER_TAB_PRIVS '
      'WHERE TABLE_NAME = '#39'T430_STORICO'#39)
    Optimize = False
    Left = 392
    Top = 132
  end
  object selColsI501: TOracleDataSet
    Optimize = False
    Left = 496
    Top = 20
  end
  object selColsDef: TOracleDataSet
    SQL.Strings = (
      
        'SELECT COLUMN_NAME,DATA_DEFAULT FROM COLS WHERE TABLE_NAME = '#39'T4' +
        '30_STORICO'#39' AND DATA_DEFAULT IS NOT NULL')
    Optimize = False
    Left = 464
    Top = 132
  end
  object CreateQ430_Appoggio: TOracleScript
    Lines.Strings = (
      
        'CREATE GLOBAL TEMPORARY TABLE T430_APPOGGIO ON COMMIT DELETE ROW' +
        'S'
      '  AS SELECT * FROM T430_STORICO WHERE PROGRESSIVO < 0;'
      ''
      
        'CREATE TABLE T430_APPOGGIO STORAGE (INITIAL 16K NEXT 16K PCTINCR' +
        'EASE 0)'
      '  AS SELECT * FROM T430_STORICO WHERE PROGRESSIVO < 0;'
      ''
      'ALTER PROCEDURE CREAZIONE_STORICO COMPILE;'
      'ALTER PROCEDURE ALLINEA_PERIODI_STORICI COMPILE;'
      'ALTER PROCEDURE ALLINEAPERIODIRAPPORTO COMPILE;'
      'ALTER PROCEDURE ALLINEA_PERIODI_STIPENDI COMPILE;'
      '/')
    Left = 496
    Top = 72
  end
  object CreaTriggerI501: TOracleQuery
    SQL.Strings = (
      'CREATE OR REPLACE TRIGGER :NOME_TRIGGER'
      '  AFTER DELETE OR INSERT ON :NOME_TABELLA'
      '  FOR EACH ROW'
      'DECLARE'
      '  W_CODICE VARCHAR2(100) :='#39#39';'
      '  N_TROV NUMBER :=0;'
      'BEGIN'
      '  IF DELETING THEN'
      '    W_CODICE:=:OLD_CODICE;'
      '  ELSIF INSERTING THEN'
      '    W_CODICE:=:NEW_CODICE;'
      '  END IF;'
      '  SELECT COUNT(*)'
      '  INTO  N_TROV'
      '  FROM  I020_DATI_ALLINEAMENTO'
      '  WHERE TIPO = '#39'D'#39
      '  AND   TABELLA = '#39'T430_STORICO'#39
      '  AND   COLONNA = :NOME_CAMPO'
      '  AND   NVL(VALORE,'#39'#NULL#'#39') = NVL(W_CODICE,'#39'#NULL#'#39');'
      '  IF N_TROV = 0 THEN'
      '    INSERT INTO I020_DATI_ALLINEAMENTO'
      '    (TIPO,'
      '     TABELLA,'
      '     COLONNA,'
      '     VALORE)'
      '    VALUES'
      '    ('#39'D'#39','
      '     '#39'T430_STORICO'#39','
      '     :NOME_CAMPO,'
      '     W_CODICE);'
      '   END IF;'
      'END :NOME_TRIGGER;')
    Optimize = False
    Variables.Data = {
      04000000050000001A0000003A004E004F004D0045005F005400520049004700
      4700450052000100000000000000000000001A0000003A004E004F004D004500
      5F0054004100420045004C004C00410001000000000000000000000016000000
      3A004E004F004D0045005F00430041004D0050004F0001000000000000000000
      0000160000003A004F004C0044005F0043004F00440049004300450001000000
      0000000000000000160000003A004E00450057005F0043004F00440049004300
      4500010000000000000000000000}
    Left = 184
    Top = 192
  end
  object selI091: TOracleDataSet
    SQL.Strings = (
      
        'select '#39'Aziende\Gestione moduli\'#39'||tipo tipo,dato from mondoedp.' +
        'i091_datiente where azienda = :azienda and dato is not null'
      'union'
      
        'select '#39'Limiti mensili'#39',nomecampo1 from t800_campilimiti where n' +
        'omecampo1 is not null'
      'union'
      
        'select '#39'Limiti mensili'#39',nomecampo2 from t800_campilimiti where n' +
        'omecampo2 is not null'
      '--union'
      
        '--select '#39'Budget straordinario'#39',campo from t700_gerarchiabudget ' +
        'where campo is not null')
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 28
    Top = 20
  end
end
