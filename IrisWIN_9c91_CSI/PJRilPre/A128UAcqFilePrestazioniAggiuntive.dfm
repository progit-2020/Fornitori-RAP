object A128FAcqFilePrestazioniAggiuntive: TA128FAcqFilePrestazioniAggiuntive
  Left = 268
  Top = 125
  HelpContext = 103000
  Caption = '<A128> Acquisizione file prestazioni aggiuntive'
  ClientHeight = 300
  ClientWidth = 408
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 408
    Height = 300
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    object LblRiga: TLabel
      Left = 11
      Top = 283
      Width = 42
      Height = 13
      Caption = 'Riga: 0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblMatricola: TLabel
      Left = 11
      Top = 267
      Width = 57
      Height = 13
      Caption = 'Matricola:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblFineAcquisizione: TLabel
      Left = 6
      Top = 47
      Width = 81
      Height = 13
      Caption = 'Fine acquisizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtFineAcquisizione: TSpeedButton
      Left = 170
      Top = 43
      Width = 15
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = sbtFineAcquisizioneClick
    end
    object lblInizioAcquisizione: TLabel
      Left = 6
      Top = 19
      Width = 85
      Height = 13
      Caption = 'Inizio acquisizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object sbtInizioAcquisizione: TSpeedButton
      Left = 170
      Top = 15
      Width = 15
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      NumGlyphs = 2
      ParentFont = False
      OnClick = sbtInizioAcquisizioneClick
    end
    object btnAcquisizione: TBitBtn
      Left = 106
      Top = 228
      Width = 90
      Height = 25
      HelpContext = 103000
      Caption = 'Acquisizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF00000000FFFFFFFF0FFFFFF0FFFFFFFF0FFFFFF0FFFFFFFF0F00F0
        00FFFFF0FF0FFFFFF0FFFFF90F0F0800F0FFFFF9900FFFFFF0FFF999990F00F0
        00FFF9999990FFF0F0FFF999999908F0F0FFF9999990FFF00FFFF99999000000
        FFFFFFF990FFFFFFFFFFFFF90FFFFFFFFFFFFFF0FFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 0
      OnClick = btnAcquisizioneClick
    end
    object BitBtn2: TBitBtn
      Left = 306
      Top = 228
      Width = 90
      Height = 25
      Caption = 'Chiudi'
      Kind = bkClose
      TabOrder = 1
    end
    object BtnVisAnomalie: TBitBtn
      Left = 206
      Top = 228
      Width = 90
      Height = 25
      Caption = 'Anomalie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = BtnVisAnomalieClick
    end
    object btnVisualizzaFile: TBitBtn
      Left = 6
      Top = 228
      Width = 90
      Height = 25
      Caption = 'Visualizza file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
      ParentFont = False
      TabOrder = 3
      OnClick = btnVisualizzaFileClick
    end
    object edtFineAcquisizione: TMaskEdit
      Left = 100
      Top = 43
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 4
      Text = '  /  /    '
    end
    object edtInizioAcquisizione: TMaskEdit
      Left = 100
      Top = 15
      Width = 71
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 5
      Text = '  /  /    '
    end
    object gpbParametriAcquisizione: TGroupBox
      Left = 0
      Top = 74
      Width = 403
      Height = 143
      Caption = 'Parametri acquisizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object lblNomeFileInput: TLabel
        Left = 7
        Top = 22
        Width = 89
        Height = 13
        Caption = 'File di importazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object sbtNomeFileInput: TSpeedButton
        Left = 381
        Top = 18
        Width = 15
        Height = 21
        Caption = '...'
        OnClick = sbtNomeFileInputClick
      end
      object lblGrigliaTracciato: TLabel
        Left = 7
        Top = 51
        Width = 193
        Height = 13
        Caption = 'Mappatura dei dati sul file di importazione'
      end
      object edtNomeFileInput: TEdit
        Left = 100
        Top = 18
        Width = 281
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object grdParametrizzazioneFile: TStringGrid
        Left = 7
        Top = 68
        Width = 393
        Height = 60
        ColCount = 6
        DefaultRowHeight = 18
        RowCount = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 336
  end
end
