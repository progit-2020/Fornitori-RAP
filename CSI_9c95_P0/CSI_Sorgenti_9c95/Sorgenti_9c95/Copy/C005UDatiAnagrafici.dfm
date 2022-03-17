object C005FDatiAnagrafici: TC005FDatiAnagrafici
  Left = 76
  Top = 32
  BorderIcons = [biSystemMenu, biMaximize]
  ClientHeight = 397
  ClientWidth = 445
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 445
    Height = 397
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object QAnagra: TOracleDataSet
    SQL.Strings = (
      'SELECT T030.*,V430.*,CITTA,PROVINCIA'
      'FROM T030_ANAGRAFICO T030,V430_STORICO V430, T480_COMUNI T480'
      'WHERE '
      'PROGRESSIVO = T430PROGRESSIVO AND'
      'COMUNENAS = T480.CODICE(+) AND'
      'PROGRESSIVO = :PROGRESSIVO AND'
      ':DATA BETWEEN T430DATADECORRENZA AND T430DATAFINE'
      '')
    Optimize = False
    Variables.Data = {
      0400000002000000180000003A00500052004F00470052004500530053004900
      56004F000300000000000000000000000A0000003A0044004100540041000C00
      00000000000000000000}
    Left = 12
    Top = 8
  end
  object QI010_: TOracleDataSet
    SQL.Strings = (
      'SELECT * FROM I010_CAMPIANAGRAFICI'
      'WHERE POSIZIONE IS NOT NULL'
      'ORDER BY POSIZIONE,NOME_LOGICO')
    Optimize = False
    Left = 52
    Top = 8
  end
end
