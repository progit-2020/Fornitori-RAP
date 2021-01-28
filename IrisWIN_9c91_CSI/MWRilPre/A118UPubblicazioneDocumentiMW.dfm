inherited A118FPubblicazioneDocumentiMW: TA118FPubblicazioneDocumentiMW
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 80
  Width = 289
  object selFiltro: TOracleQuery
    ReadBuffer = 2
    Optimize = False
    Left = 216
    Top = 16
  end
  object selI200: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   I200_PUBBL_DOC'
      'order by CODICE')
    ReadBuffer = 10
    Optimize = False
    Left = 24
    Top = 16
  end
  object selI201: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   I201_PUBBL_DOC_PATH'
      'where  CODICE = :CODICE'
      'order by LIVELLO')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 88
    Top = 16
  end
  object selI202: TOracleDataSet
    SQL.Strings = (
      'select *'
      'from   I202_PUBBL_DOC_DESC'
      'where  CODICE = :CODICE'
      'order by LIVELLO, DAL')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      04000000010000000E0000003A0043004F004400490043004500050000000000
      000000000000}
    Left = 152
    Top = 16
  end
end
