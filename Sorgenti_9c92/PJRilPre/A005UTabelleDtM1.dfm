object A005FTabelleDtM1: TA005FTabelleDtM1
  OldCreateOrder = True
  OnCreate = A005FTabelleDtM1Create
  OnDestroy = A005FTabelleDtM1Destroy
  Height = 89
  Width = 238
  object Q500: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T033.CAPTION,I500.NOMECAMPO,I500.TABELLA,T033.ACCESSO FRO' +
        'M I500_DATILIBERI I500, T033_LAYOUT T033 WHERE I500.TABELLA = '#39'S' +
        #39' AND '
      
        'I500.STORICO='#39'N'#39' AND I500.NOMECAMPO = T033.CAMPODB AND T033.NOME' +
        ' = :Nome AND T033.ACCESSO <> '#39'N'#39
      'ORDER BY T033.CAPTION,I500.NOMECAMPO'
      '--ORDER BY T033.NOMEPAGINA, T033.LFT, T033.TOP'
      '')
    Optimize = False
    Variables.Data = {
      04000000010000000A0000003A004E004F004D00450005000000000000000000
      0000}
    Left = 12
    Top = 12
  end
  object Tabella: TOracleDataSet
    ReadBuffer = 10000
    Optimize = False
    AfterOpen = TabellaAfterOpen
    BeforePost = BDETabellaBeforePost
    AfterPost = BDETabellaAfterPost
    BeforeDelete = BDETabellaBeforeDelete
    AfterDelete = BDETabellaAfterDelete
    Left = 52
    Top = 12
  end
end
