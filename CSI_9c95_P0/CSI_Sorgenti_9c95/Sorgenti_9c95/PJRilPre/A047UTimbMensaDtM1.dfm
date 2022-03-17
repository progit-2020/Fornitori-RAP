object A047FTimbMensaDtM1: TA047FTimbMensaDtM1
  OldCreateOrder = True
  OnCreate = A047FTimbMensaDtM1Create
  OnDestroy = A047FTimbMensaDtM1Destroy
  Height = 262
  Width = 710
  object QAnagraSt: TOracleDataSet
    SQL.Strings = (
      
        'SELECT T030.Progressivo,V430.T430Badge,T030.Cognome,T030.Nome,T0' +
        '30.Matricola,V430.T430Inizio,V430.T430Fine '
      'FROM'
      'T030_Anagrafico T030, V430_Storico V430, T480_Comuni T480'
      'WHERE T030.Progressivo = V430.T430Progressivo AND'
      'T030.ComuneNas = T480.Codice(+) AND'
      'V430.T430DataDecorrenza <= :DataLavoro AND '
      'V430.T430DataFine >= :DataLavoro'
      'AND PROGRESSIVO = :PROGRESSIVO')
    ReadBuffer = 5000
    Optimize = False
    Variables.Data = {
      0400000002000000160000003A0044004100540041004C00410056004F005200
      4F000C0000000000000000000000180000003A00500052004F00470052004500
      53005300490056004F00030000000000000000000000}
    Left = 204
    Top = 112
  end
  object sel370Stampa: TOracleDataSet
    SQL.Strings = (
      
        '--SELECT T370.*,T361.DESCRIZIONE FROM T370_TIMBMENSA T370,T361_O' +
        'ROLOGI T361 WHERE T370.DATA BETWEEN :DATA1 AND :DATA2 AND T370.F' +
        'LAG IN ('#39'O'#39','#39'I'#39') AND T361.CODICE(+) = T370.RILEVATORE')
    Optimize = False
    Variables.Data = {
      04000000020000000C0000003A00440041005400410031000C00000007000000
      77BE0101010101000000000C0000003A00440041005400410032000C00000007
      00000078640C1F01010100000000}
    Left = 216
    Top = 16
  end
  object TabellaStampa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 112
  end
  object selT040Stampa: TOracleDataSet
    SQL.Strings = (
      'SELECT /*+ INDEX(T040_GIUSTIFICATIVI T040_PK)*/'
      
        'DATA,'#39'('#39' || CAUSALE || '#39')'#39' || DESCRIZIONE CAUSALE FROM T040_GIUS' +
        'TIFICATIVI, T265_CAUASSENZE'
      'WHERE PROGRESSIVO = :Progressivo AND'
      '      DATA BETWEEN :DataInizio and :DataFine AND'
      '--      TIPOGIUST = '#39'I'#39' AND'
      '      CAUSALE = CODICE'
      'ORDER BY DATA, CAUSALE, PROGRCAUSALE')
    ReadBuffer = 50
    Optimize = False
    Variables.Data = {
      0400000003000000180000003A00500052004F00470052004500530053004900
      56004F00030000000000000000000000160000003A0044004100540041004900
      4E0049005A0049004F000C0000000000000000000000120000003A0044004100
      54004100460049004E0045000C0000000000000000000000}
    Left = 272
    Top = 112
  end
  object dsrI010: TDataSource
    Left = 336
    Top = 16
  end
end
