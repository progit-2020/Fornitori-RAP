object A001FPassWordDtM1: TA001FPassWordDtM1
  OldCreateOrder = True
  OnCreate = A001FPassWordDtM1Create
  OnDestroy = A001FPassWordDtM1Destroy
  Height = 228
  Width = 465
  object QI090: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM I090_ENTI '
      ' WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 13
    Top = 24
  end
  object QI091: TOracleDataSet
    SQL.Strings = (
      'SELECT TIPO,DATO '
      '  FROM I091_DATIENTE '
      ' WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 150
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      05000000415A494E0000000000}
    Left = 53
    Top = 24
  end
  object QI092: TOracleDataSet
    SQL.Strings = (
      'SELECT SCHEDA FROM I092_LOGTABELLE'
      'WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 100
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 93
    Top = 24
  end
  object QI070: TOracleDataSet
    SQL.Strings = (
      
        'SELECT * FROM I070_UTENTI WHERE AZIENDA = :AZIENDA AND UTENTE = ' +
        ':UTENTE')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 141
    Top = 24
  end
  object QI071: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM I071_PERMESSI '
      ' WHERE PROFILO = :PROFILO'
      '   AND AZIENDA = :AZIENDA')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 185
    Top = 24
  end
  object QI072: TOracleDataSet
    SQL.Strings = (
      'SELECT FILTRO '
      '  FROM I072_FILTROANAGRAFE '
      ' WHERE PROFILO = :PROFILO'
      '   AND AZIENDA = :AZIENDA'
      ' ORDER BY PROGRESSIVO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 233
    Top = 24
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 13
    Top = 72
  end
  object I070Count: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) FROM I070_UTENTI,I071_PERMESSI WHERE'
      'PERMESSI = PROFILO AND ABILITA_SCHEDE_CHIUSE <> '#39'S'#39)
    ReadBuffer = 2
    Optimize = False
    Left = 73
    Top = 72
  end
  object QI073: TOracleDataSet
    SQL.Strings = (
      
        'SELECT GRUPPO,TAG,FUNZIONE,DESCRIZIONE,INIBIZIONE,ACCESSO_BROWSE' +
        ',RIGHE_PAGINA'
      '  FROM I073_FILTROFUNZIONI'
      ' WHERE PROFILO = :PROFILO '
      '   AND (APPLICAZIONE = :APPLICAZIONE OR GRUPPO = '#39'Funzioni WEB'#39')'
      '   AND AZIENDA = :AZIENDA')
    ReadBuffer = 300
    Optimize = False
    Variables.Data = {
      0400000003000000100000003A00500052004F00460049004C004F0005000000
      00000000000000001A0000003A004100500050004C004900430041005A004900
      4F004E004500050000000000000000000000100000003A0041005A0049004500
      4E0044004100050000000000000000000000}
    AfterOpen = QI073AfterOpen
    Left = 284
    Top = 24
  end
  object QI074: TOracleDataSet
    SQL.Strings = (
      'SELECT TABELLA,CODICE,ABILITATO '
      '  FROM I074_FILTRODIZIONARIO'
      ' WHERE PROFILO = :PROFILO'
      '   AND AZIENDA = :AZIENDA'
      ' ORDER BY TABELLA,CODICE')
    ReadBuffer = 200
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A00500052004F00460049004C004F0005000000
      0000000000000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    AfterOpen = QI074AfterOpen
    Left = 332
    Top = 24
  end
  object selI070Utenti: TOracleDataSet
    SQL.Strings = (
      'SELECT COUNT(*) NUM FROM TABS WHERE TABLE_NAME = '#39'I070_UTENTI'#39)
    Optimize = False
    Left = 387
    Top = 24
  end
  object scrAllineamentoVersione: TOracleScript
    AutoCommit = True
    OutputOptions = []
    Left = 160
    Top = 72
  end
  object selI080: TOracleDataSet
    SQL.Strings = (
      'SELECT * '
      '  FROM I080_MODULI'
      ' WHERE AZIENDA = :AZIENDA')
    ReadBuffer = 40
    Optimize = False
    Variables.Data = {
      0400000001000000100000003A0041005A00490045004E004400410005000000
      0000000000000000}
    Left = 240
    Top = 72
  end
  object selT033: TOracleDataSet
    SQL.Strings = (
      'SELECT DISTINCT NOME FROM T033_LAYOUT')
    Optimize = False
    Left = 301
    Top = 71
  end
  object QI060: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM I060_LOGIN_DIPENDENTE '
      'WHERE  AZIENDA = :AZIENDA '
      '--AND    NOME_UTENTE = :UTENTE'
      'AND    UPPER(NOME_UTENTE ) = UPPER(:UTENTE)')
    ReadBuffer = 2
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      00000000000000000E0000003A005500540045004E0054004500050000000000
      000000000000}
    Left = 389
    Top = 72
  end
  object selI061: TOracleDataSet
    SQL.Strings = (
      'SELECT I061.*'
      '  FROM I061_PROFILI_DIPENDENTE I061'
      ' WHERE I061.AZIENDA = :AZIENDA'
      '   AND I061.NOME_UTENTE = :NOME_UTENTE'
      '   AND TRUNC(SYSDATE) BETWEEN INIZIO_VALIDITA AND FINE_VALIDITA'
      ' ORDER BY I061.NOME_PROFILO')
    Optimize = False
    Variables.Data = {
      0400000002000000100000003A0041005A00490045004E004400410005000000
      0000000000000000180000003A004E004F004D0045005F005500540045004E00
      54004500050000000000000000000000}
    Left = 13
    Top = 120
  end
  object selTablespace: TOracleDataSet
    SQL.Strings = (
      'select /*+ ALL_ROWS*/ s.tablespace_name Tablespace,'
      '       sum(s.bytes) / 1024 / 1024 Spazio_libero,'
      
        '       to_char(sum(s.bytes) / 1024 / 1024,'#39'fm999g999g999g999g990' +
        'd00'#39') Spazio_libero_stringa'
      'from dba_free_space s'
      'where tablespace_name in (:TABLESPACE)'
      'group by s.tablespace_name'
      'order by s.tablespace_name')
    Optimize = False
    Variables.Data = {
      0400000001000000160000003A005400410042004C0045005300500041004300
      4500010000000000000000000000}
    Left = 72
    Top = 120
  end
  object selDistAzienda: TOracleDataSet
    SQL.Strings = (
      'SELECT I090.AZIENDA '
      'FROM   I090_ENTI I090, '
      '       I060_LOGIN_DIPENDENTE I060'
      'WHERE  I090.AZIENDA = I060.AZIENDA '
      'AND    I090.LOGIN_DIP_ABILITATO = '#39'S'#39
      ':FILTRO_DOMINIO_DIP'
      'AND    UPPER(I060.NOME_UTENTE) = UPPER(:UTENTE)'
      'UNION'
      'SELECT I090.AZIENDA'
      'FROM   I090_ENTI I090, '
      '       I070_UTENTI I070'
      'WHERE  I090.AZIENDA = I070.AZIENDA '
      'AND    I090.LOGIN_USR_ABILITATO = '#39'S'#39
      ':FILTRO_DOMINIO_USR'
      'AND    I070.UTENTE = :UTENTE'
      'ORDER BY 1')
    ReadBuffer = 5
    Optimize = False
    Variables.Data = {
      04000000030000000E0000003A005500540045004E0054004500050000000000
      000000000000260000003A00460049004C00540052004F005F0044004F004D00
      49004E0049004F005F0044004900500001000000000000000000000026000000
      3A00460049004C00540052004F005F0044004F004D0049004E0049004F005F00
      550053005200010000000000000000000000}
    Left = 29
    Top = 176
  end
  object selP210: TOracleDataSet
    SQL.Strings = (
      'select distinct COD_CONTRATTO from :SCHEMA.P210_CONTRATTI')
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0053004300480045004D004100010000000000
      000000000000}
    Left = 160
    Top = 120
  end
end
