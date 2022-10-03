inherited A115FDatiLiberiStoricizzatiDtM: TA115FDatiLiberiStoricizzatiDtM
  OldCreateOrder = True
  Height = 246
  Width = 451
  object selI500: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T033.CAPTION, I500.NOMECAMPO, I500.TABELLA, T033.NOMEPAGI' +
        'NA, T033.ACCESSO, I500.SCADENZA, I500.STORICO'
      'FROM   I500_DATILIBERI I500, T033_LAYOUT T033'
      'WHERE  I500.TABELLA = '#39'S'#39
      'AND    I500.NOMECAMPO = T033.CAMPODB'
      'AND    T033.NOME = :Nome'
      'AND    T033.ACCESSO <> '#39'N'#39
      'ORDER BY T033.CAPTION,I500.NOMECAMPO')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 12
    Top = 12
  end
  object selI501: TOracleDataSet
    ReadBuffer = 10000
    Optimize = False
    AfterOpen = selI501AfterOpen
    AfterClose = selI501AfterClose
    BeforePost = BeforePost
    AfterPost = AfterPost
    BeforeDelete = BeforeDelete
    AfterScroll = selI501AfterScroll
    Left = 68
    Top = 12
  end
  object selaI500: TOracleDataSet
    SQL.Strings = (
      
        'SELECT '#39'I501'#39'||I500.NOMECAMPO NOME_TABELLA FROM I500_DATILIBERI ' +
        'I500, T033_LAYOUT T033 WHERE I500.TABELLA = '#39'S'#39' AND '
      
        'I500.STORICO='#39'S'#39' AND I500.NOMECAMPO = T033.CAMPODB AND T033.NOME' +
        ' = :Nome AND T033.ACCESSO <> '#39'N'#39
      'AND ROWNUM <=1')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 140
    Top = 12
  end
  object scrT430: TOracleQuery
    SQL.Strings = (
      'BEGIN'
      '  Allinea_Periodi_Storici(:Progressivo,1,:Errore,'#39#39');'
      'END;')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000E0000003A004500520052004F005200
      4500050000000000000000000000}
    Left = 12
    Top = 71
  end
  object OperSQL: TOracleQuery
    Optimize = False
    Left = 92
    Top = 71
  end
  object selT430: TOracleDataSet
    SQL.Strings = (
      
        'SELECT MIN(DATADECORRENZA) DATA_MIN FROM T430_STORICO WHERE :Nom' +
        'eCampo = :Codice AND :Decorrenza ='
      
        '  (SELECT MAX(DECORRENZA) FROM :NomeTabella WHERE CODICE = :Codi' +
        'ce AND DECORRENZA <=DATADECORRENZA)')
    Optimize = False
    Variables.Data = {
      0400000004000000140000003A004E004F004D004500430041004D0050004F00
      0100000000000000000000000E0000003A0043004F0044004900430045000500
      00000000000000000000160000003A004400450043004F005200520045004E00
      5A0041000C0000000000000000000000180000003A004E004F004D0045005400
      4100420045004C004C004100010000000000000000000000}
    Left = 220
    Top = 12
  end
  object tabT430: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 216
    Top = 72
  end
  object selaT430: TOracleDataSet
    SQL.Strings = (
      
        'SELECT DISTINCT PROGRESSIVO FROM T430_STORICO WHERE :NomeCampo =' +
        ' :Codice')
    Optimize = False
    Variables.Data = {
      0400000002000000140000003A004E004F004D004500430041004D0050004F00
      0100000000000000000000000E0000003A0043004F0044004900430045000500
      00000000000000000000}
    Left = 292
    Top = 12
  end
  object insSG310: TOracleQuery
    SQL.Strings = (
      'insert into sg310_incallineamenti'
      
        '  (operatore, data_variazione, cod_unitaorg, decorrenza, flag_mo' +
        'difica, stato)'
      'values'
      
        '  (:operatore, :data_variazione, :cod_unitaorg, :decorrenza, :fl' +
        'ag_modifica, :stato)')
    Optimize = False
    Variables.Data = {
      0400000006000000140000003A004F00500045005200410054004F0052004500
      050000000000000000000000200000003A0044004100540041005F0056004100
      5200490041005A0049004F004E0045000C00000000000000000000001A000000
      3A0043004F0044005F0055004E004900540041004F0052004700050000000000
      000000000000160000003A004400450043004F005200520045004E005A004100
      0C00000000000000000000001C0000003A0046004C00410047005F004D004F00
      4400490046004900430041000500000000000000000000000C0000003A005300
      5400410054004F00050000000000000000000000}
    Left = 296
    Top = 72
  end
end
