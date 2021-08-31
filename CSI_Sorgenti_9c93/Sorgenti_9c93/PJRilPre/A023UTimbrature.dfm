inherited A023FTimbrature: TA023FTimbrature
  Left = 252
  Top = 186
  HelpContext = 23000
  ActiveControl = EMese
  Caption = '<A023> Cartellino interattivo'
  ClientHeight = 448
  ClientWidth = 632
  Constraints.MaxHeight = 506
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  ExplicitWidth = 640
  ExplicitHeight = 494
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 429
    Width = 632
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Width = 140
      end
      item
        Width = 50
      end>
    ExplicitTop = 429
    ExplicitWidth = 632
  end
  object pnlTop: TPanel [1]
    Left = 0
    Top = 24
    Width = 632
    Height = 46
    Align = alTop
    TabOrder = 1
    object Label3: TLabel
      Left = 4
      Top = 8
      Width = 29
      Height = 13
      Caption = 'Mese:'
    end
    object Label4: TLabel
      Left = 76
      Top = 8
      Width = 28
      Height = 13
      Caption = 'Anno:'
    end
    object lblTimbrature: TLabel
      Left = 54
      Top = 32
      Width = 53
      Height = 13
      Caption = 'Timbrature:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object SBConteggi: TSpeedButton
      Left = 304
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Conteggi off'
      AllowAllUp = True
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SBConteggiClick
    end
    object SpeedButton2: TSpeedButton
      Left = 328
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Visualizzazione anomalie'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300130000031
        00333773F77777FF7733331000909000133333377737F777FF33330098F0F890
        0333337733F733F77F33370980FFF08907333373373F373373F33099FFFFFFF9
        903337F3F373F33FF7F33090F000FF00903337F73337F37737F3B099FFF0FFF9
        90B3373F33F7F3F33733070980F0F0890703337FF737F7337F33BB0098F0F890
        0BB33F77FF3733377FFF000009999900000377777FFFFF77777F088700000008
        77037F3377777773337F088887707888870373F3337773F33373B078800B0088
        70B3373FF733373FF73303700BBBBB007303337773F3F3777F33330BB0B0B0BB
        033333733737F73F73F330BB03B0B30BB0333733733733733733}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton2Click
    end
    object btnConteggiDiServizio: TSpeedButton
      Left = 354
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Conteggi di servizio'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
        8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
        F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
        F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
        0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
        3333333777333777333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = ConteggiDiServizioClick
    end
    object SpeedButton4: TSpeedButton
      Left = 380
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Stampa cartellino'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777770000077
        777777770BF33307777700000FB300000077BFF00BF0BF333307FBBFBFBBFB33
        33070FFB330BB03000770BB3B330F0000007BFF30B30BFB33330FBB30F30FBF3
        33303FF3F330B00000073BBF330BF0300077BFFBFBFBBF333307FBB00FB0FB33
        330733303BF30000007777773FB3330777777777733000777777}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton4Click
    end
    object SpMese: TSpeedButton
      Left = 410
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Timbrature mese corrente'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F3FF3FFF7F333330F00F000F07333337F77377737F333330FFFFFFFF
        07333FF7F3FFFF3F7FFFBBB0F0000F0F0BB37777F7777373777F3BB0FFFFFFFF
        0BBB3777F3FF3FFF77773330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F37F3333330F08F0F0B33333337F7737F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpMeseClick
    end
    object SpCorrezione: TSpeedButton
      Left = 439
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Correzione anomalie'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555905555555555555999055555555555599905555
        5555555999990555555555999999055555555799059990555555790555599055
        5555555555599905555555555555990555555555555559905555555555555579
        0555555555555557905555555555555559905555555555555555}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpCorrezioneClick
    end
    object lblGiustificativi: TLabel
      Left = 360
      Top = 32
      Width = 59
      Height = 13
      Caption = 'Giustificativi:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object grpLegenda: TGroupBox
      Left = 470
      Top = 0
      Width = 161
      Height = 44
      Caption = 'Legenda'
      TabOrder = 4
      object Label5: TLabel
        Left = 110
        Top = 14
        Width = 22
        Height = 13
        Caption = 'Entr.'
        Color = clLime
        ParentColor = False
      end
      object Label8: TLabel
        Left = 132
        Top = 14
        Width = 22
        Height = 13
        Caption = 'Usc.'
        Color = clAqua
        ParentColor = False
      end
      object Label10: TLabel
        Left = 66
        Top = 28
        Width = 20
        Height = 13
        Caption = 'Ass.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 88
        Top = 28
        Width = 24
        Height = 13
        Caption = 'Pres.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 114
        Top = 28
        Width = 27
        Height = 13
        Caption = 'Giust.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 30
        Top = 14
        Width = 22
        Height = 13
        Caption = 'Entr.'
        Color = clLime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label15: TLabel
        Left = 52
        Top = 14
        Width = 22
        Height = 13
        Caption = 'Usc.'
        Color = clAqua
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object Label16: TLabel
        Left = 4
        Top = 14
        Width = 25
        Height = 13
        Caption = 'Orig.:'
      end
      object Label20: TLabel
        Left = 82
        Top = 14
        Width = 27
        Height = 13
        Caption = 'Man.:'
      end
      object Label21: TLabel
        Left = 4
        Top = 28
        Width = 59
        Height = 13
        Caption = 'Giustificativi:'
      end
    end
    object EMese: TSpinEdit
      Left = 36
      Top = 4
      Width = 37
      Height = 22
      MaxValue = 12
      MinValue = 1
      TabOrder = 0
      Value = 1
      OnChange = EMeseChange
    end
    object EAnno: TSpinEdit
      Left = 106
      Top = 4
      Width = 51
      Height = 22
      MaxValue = 3000
      MinValue = 1900
      TabOrder = 1
      Value = 1997
      OnChange = EMeseChange
    end
    object BPrec: TBitBtn
      Left = 160
      Top = 4
      Width = 70
      Height = 22
      Caption = 'gg prec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FF000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FF00
        00FF0000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000000000000000FF0000FF0000FF0000FF0000FF0000000000000000000000
        000000000000000000000000000000000000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF000000FFFFFFFFFFFF
        0000000000000000FF0000FF0000FF0000FF0000FF0000000000000000000000
        00000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FF00
        00FF0000FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FF000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 2
      OnClick = BPrecClick
    end
    object BSucc: TBitBtn
      Left = 230
      Top = 4
      Width = 70
      Height = 22
      Caption = 'gg succ.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000000000FF000000000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        00FF0000FF0000FF000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000
        0000000000000000000000000000000000FF0000FF0000FF0000FF0000FF0000
        00000000FFFFFFFFFFFF0000000000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FF0000FF0000FF0000FF0000FF0000FF000000000000000000000000
        0000000000000000000000000000000000FF0000FF0000FF0000FF0000FF0000
        00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        00FF0000FF0000FF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0000000000FF000000000000FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphRight
      ParentFont = False
      TabOrder = 3
      OnClick = BPrecClick
    end
  end
  object ScrollBox3: TScrollBox [2]
    Left = 0
    Top = 70
    Width = 632
    Height = 359
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 355
      Top = 0
      Width = 5
      Height = 359
      Align = alRight
      MinSize = 272
      OnCanResize = Splitter1CanResize
      OnMoved = Splitter1Moved
      ExplicitLeft = 357
      ExplicitHeight = 343
    end
    object pnlGiorniTimb: TPanel
      Left = 0
      Top = 0
      Width = 355
      Height = 359
      Align = alClient
      BevelOuter = bvNone
      Constraints.MinWidth = 200
      TabOrder = 0
      DesignSize = (
        355
        359)
      object LGiorno1: TLabel
        Left = 1
        Top = 6
        Width = 43
        Height = 13
        Caption = 'LGiorno1'
      end
      object LTurni1: TLabel
        Left = 1
        Top = 21
        Width = 36
        Height = 13
        Caption = 'LTurni1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LGiorno2: TLabel
        Left = 1
        Top = 64
        Width = 43
        Height = 13
        Caption = 'LGiorno2'
      end
      object LTurni2: TLabel
        Left = 1
        Top = 80
        Width = 36
        Height = 13
        Caption = 'LTurni2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LGiorno3: TLabel
        Left = 1
        Top = 122
        Width = 43
        Height = 13
        Caption = 'LGiorno3'
      end
      object LTurni3: TLabel
        Left = 1
        Top = 137
        Width = 36
        Height = 13
        Caption = 'LTurni3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LGiorno4: TLabel
        Left = 1
        Top = 180
        Width = 43
        Height = 13
        Caption = 'LGiorno4'
      end
      object LTurni4: TLabel
        Left = 1
        Top = 196
        Width = 36
        Height = 13
        Caption = 'LTurni4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LGiorno5: TLabel
        Left = 1
        Top = 238
        Width = 43
        Height = 13
        Caption = 'LGiorno5'
      end
      object LTurni5: TLabel
        Left = 1
        Top = 254
        Width = 36
        Height = 13
        Caption = 'LTurni5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LGiorno6: TLabel
        Left = 1
        Top = 296
        Width = 43
        Height = 13
        Caption = 'LGiorno6'
      end
      object LTurni6: TLabel
        Left = 1
        Top = 312
        Width = 36
        Height = 13
        Caption = 'LTurni6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LCP1: TLabel
        Left = 41
        Top = 3
        Width = 10
        Height = 12
        Caption = 'CP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object LCP2: TLabel
        Left = 41
        Top = 62
        Width = 10
        Height = 12
        Caption = 'CP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object LCP3: TLabel
        Left = 41
        Top = 120
        Width = 10
        Height = 12
        Caption = 'CP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object LCP4: TLabel
        Left = 41
        Top = 178
        Width = 10
        Height = 12
        Caption = 'CP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object LCP5: TLabel
        Left = 41
        Top = 236
        Width = 10
        Height = 12
        Caption = 'CP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object LCP6: TLabel
        Left = 41
        Top = 294
        Width = 10
        Height = 12
        Caption = 'CP'
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
      end
      object GTimbrat1: TStringGrid
        Tag = 1
        Left = 53
        Top = 3
        Width = 302
        Height = 52
        Anchors = [akLeft, akTop, akRight]
        ColCount = 20
        DefaultColWidth = 50
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
        ParentFont = False
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 0
        OnDblClick = DoppioClickTimb
        OnDrawCell = GTimbrat1DrawCell
        OnEnter = GTimbrat1Enter
        OnExit = GTimbrat1Exit
        OnKeyDown = GestisciKeyDownTimb
        OnMouseDown = GestisciMouseDown
        OnMouseMove = GTimbrat1MouseMove
        OnSelectCell = GTimbrat2SelectCell
      end
      object GTimbrat2: TStringGrid
        Tag = 2
        Left = 53
        Top = 62
        Width = 302
        Height = 52
        Anchors = [akLeft, akTop, akRight]
        ColCount = 20
        DefaultColWidth = 50
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 1
        OnDblClick = DoppioClickTimb
        OnDrawCell = GTimbrat1DrawCell
        OnEnter = GTimbrat1Enter
        OnExit = GTimbrat1Exit
        OnKeyDown = GestisciKeyDownTimb
        OnMouseDown = GestisciMouseDown
        OnMouseMove = GTimbrat1MouseMove
        OnSelectCell = GTimbrat2SelectCell
        RowHeights = (
          15
          15)
      end
      object GTimbrat3: TStringGrid
        Tag = 3
        Left = 53
        Top = 120
        Width = 302
        Height = 52
        Anchors = [akLeft, akTop, akRight]
        ColCount = 20
        DefaultColWidth = 50
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 2
        OnDblClick = DoppioClickTimb
        OnDrawCell = GTimbrat1DrawCell
        OnEnter = GTimbrat1Enter
        OnExit = GTimbrat1Exit
        OnKeyDown = GestisciKeyDownTimb
        OnMouseDown = GestisciMouseDown
        OnMouseMove = GTimbrat1MouseMove
        OnSelectCell = GTimbrat2SelectCell
      end
      object GTimbrat4: TStringGrid
        Tag = 4
        Left = 53
        Top = 178
        Width = 302
        Height = 52
        Anchors = [akLeft, akTop, akRight]
        ColCount = 20
        DefaultColWidth = 50
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 3
        OnDblClick = DoppioClickTimb
        OnDrawCell = GTimbrat1DrawCell
        OnEnter = GTimbrat1Enter
        OnExit = GTimbrat1Exit
        OnKeyDown = GestisciKeyDownTimb
        OnMouseDown = GestisciMouseDown
        OnMouseMove = GTimbrat1MouseMove
        OnSelectCell = GTimbrat2SelectCell
      end
      object GTimbrat5: TStringGrid
        Tag = 5
        Left = 53
        Top = 236
        Width = 302
        Height = 52
        Anchors = [akLeft, akTop, akRight]
        ColCount = 20
        DefaultColWidth = 50
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 4
        OnDblClick = DoppioClickTimb
        OnDrawCell = GTimbrat1DrawCell
        OnEnter = GTimbrat1Enter
        OnExit = GTimbrat1Exit
        OnKeyDown = GestisciKeyDownTimb
        OnMouseDown = GestisciMouseDown
        OnMouseMove = GTimbrat1MouseMove
        OnSelectCell = GTimbrat2SelectCell
      end
      object GTimbrat6: TStringGrid
        Tag = 6
        Left = 53
        Top = 294
        Width = 302
        Height = 52
        Anchors = [akLeft, akTop, akRight]
        ColCount = 20
        DefaultColWidth = 50
        DefaultRowHeight = 15
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
        ParentShowHint = False
        PopupMenu = PopupMenu1
        ShowHint = True
        TabOrder = 5
        OnDblClick = DoppioClickTimb
        OnDrawCell = GTimbrat1DrawCell
        OnEnter = GTimbrat1Enter
        OnExit = GTimbrat1Exit
        OnKeyDown = GestisciKeyDownTimb
        OnMouseDown = GestisciMouseDown
        OnMouseMove = GTimbrat1MouseMove
        OnSelectCell = GTimbrat2SelectCell
      end
      object EOrario1: TEdit
        Tag = 1
        Left = 1
        Top = 34
        Width = 50
        Height = 21
        PopupMenu = PopupMenu3
        ReadOnly = True
        TabOrder = 6
        OnDblClick = EOrario1DblClick
      end
      object EOrario2: TEdit
        Tag = 2
        Left = 1
        Top = 93
        Width = 50
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        PopupMenu = PopupMenu3
        ReadOnly = True
        TabOrder = 7
        OnDblClick = EOrario1DblClick
      end
      object EOrario3: TEdit
        Tag = 3
        Left = 1
        Top = 151
        Width = 50
        Height = 21
        PopupMenu = PopupMenu3
        ReadOnly = True
        TabOrder = 8
        OnDblClick = EOrario1DblClick
      end
      object EOrario4: TEdit
        Tag = 4
        Left = 1
        Top = 209
        Width = 50
        Height = 21
        PopupMenu = PopupMenu3
        ReadOnly = True
        TabOrder = 9
        OnDblClick = EOrario1DblClick
      end
      object EOrario5: TEdit
        Tag = 5
        Left = 1
        Top = 267
        Width = 50
        Height = 21
        PopupMenu = PopupMenu3
        ReadOnly = True
        TabOrder = 10
        OnDblClick = EOrario1DblClick
      end
      object EOrario6: TEdit
        Tag = 6
        Left = 1
        Top = 325
        Width = 50
        Height = 21
        PopupMenu = PopupMenu3
        ReadOnly = True
        TabOrder = 11
        OnDblClick = EOrario1DblClick
      end
    end
    object pnlGiustCont: TPanel
      Left = 360
      Top = 0
      Width = 272
      Height = 359
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object pnlGiust: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 359
        Align = alLeft
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          193
          359)
        object GGiustif1: TStringGrid
          Tag = 11
          Left = 0
          Top = 3
          Width = 186
          Height = 52
          Anchors = [akLeft, akTop, akRight]
          ColCount = 20
          DefaultColWidth = 90
          DefaultRowHeight = 15
          FixedCols = 0
          RowCount = 2
          FixedRows = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
          ParentFont = False
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 0
          OnDblClick = DoppioClickGiust
          OnDrawCell = GTimbrat1DrawCell
          OnEnter = GTimbrat1Enter
          OnExit = GTimbrat1Exit
          OnKeyDown = GestisciKeyDownGiust
          OnMouseDown = GestisciMouseDown
          OnMouseMove = GTimbrat1MouseMove
        end
        object GGiustif2: TStringGrid
          Tag = 12
          Left = 0
          Top = 62
          Width = 186
          Height = 52
          Anchors = [akLeft, akTop, akRight]
          ColCount = 20
          DefaultColWidth = 90
          DefaultRowHeight = 15
          FixedCols = 0
          RowCount = 2
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 1
          OnDblClick = DoppioClickGiust
          OnDrawCell = GTimbrat1DrawCell
          OnEnter = GTimbrat1Enter
          OnExit = GTimbrat1Exit
          OnKeyDown = GestisciKeyDownGiust
          OnMouseDown = GestisciMouseDown
          OnMouseMove = GTimbrat1MouseMove
        end
        object GGiustif3: TStringGrid
          Tag = 13
          Left = 0
          Top = 120
          Width = 186
          Height = 52
          Anchors = [akLeft, akTop, akRight]
          ColCount = 20
          DefaultColWidth = 90
          DefaultRowHeight = 15
          FixedCols = 0
          RowCount = 2
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 2
          OnDblClick = DoppioClickGiust
          OnDrawCell = GTimbrat1DrawCell
          OnEnter = GTimbrat1Enter
          OnExit = GTimbrat1Exit
          OnKeyDown = GestisciKeyDownGiust
          OnMouseDown = GestisciMouseDown
          OnMouseMove = GTimbrat1MouseMove
        end
        object GGiustif4: TStringGrid
          Tag = 14
          Left = 0
          Top = 178
          Width = 186
          Height = 52
          Anchors = [akLeft, akTop, akRight]
          ColCount = 20
          DefaultColWidth = 90
          DefaultRowHeight = 15
          FixedCols = 0
          RowCount = 2
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 3
          OnDblClick = DoppioClickGiust
          OnDrawCell = GTimbrat1DrawCell
          OnEnter = GTimbrat1Enter
          OnExit = GTimbrat1Exit
          OnKeyDown = GestisciKeyDownGiust
          OnMouseDown = GestisciMouseDown
          OnMouseMove = GTimbrat1MouseMove
        end
        object GGiustif5: TStringGrid
          Tag = 15
          Left = 0
          Top = 236
          Width = 186
          Height = 52
          Anchors = [akLeft, akTop, akRight]
          ColCount = 20
          DefaultColWidth = 90
          DefaultRowHeight = 15
          FixedCols = 0
          RowCount = 2
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 4
          OnDblClick = DoppioClickGiust
          OnDrawCell = GTimbrat1DrawCell
          OnEnter = GTimbrat1Enter
          OnExit = GTimbrat1Exit
          OnKeyDown = GestisciKeyDownGiust
          OnMouseDown = GestisciMouseDown
          OnMouseMove = GTimbrat1MouseMove
        end
        object GGiustif6: TStringGrid
          Tag = 16
          Left = 0
          Top = 294
          Width = 186
          Height = 52
          Anchors = [akLeft, akTop, akRight]
          ColCount = 20
          DefaultColWidth = 90
          DefaultRowHeight = 15
          FixedCols = 0
          RowCount = 2
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
          ParentShowHint = False
          PopupMenu = PopupMenu2
          ShowHint = True
          TabOrder = 5
          OnDblClick = DoppioClickGiust
          OnDrawCell = GTimbrat1DrawCell
          OnEnter = GTimbrat1Enter
          OnExit = GTimbrat1Exit
          OnKeyDown = GestisciKeyDownGiust
          OnMouseDown = GestisciMouseDown
          OnMouseMove = GTimbrat1MouseMove
        end
      end
      object PConteggi: TPanel
        Left = 195
        Top = 0
        Width = 77
        Height = 359
        Align = alRight
        BevelOuter = bvNone
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 1
        Visible = False
        object LOreLavorate1: TLabel
          Left = 32
          Top = 4
          Width = 32
          Height = 13
          Hint = 'Ore lavorate'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'HLav.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LScostamento1: TLabel
          Left = 32
          Top = 30
          Width = 32
          Height = 13
          Hint = 'Scostamento'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Scost.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LOreLavorate2: TLabel
          Left = 32
          Top = 62
          Width = 32
          Height = 13
          Hint = 'Ore lavorate'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'HLav.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LScostamento2: TLabel
          Left = 32
          Top = 88
          Width = 32
          Height = 13
          Hint = 'Scostamento'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Scost.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LOreLavorate3: TLabel
          Left = 32
          Top = 120
          Width = 32
          Height = 13
          Hint = 'Ore lavorate'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'HLav.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LScostamento3: TLabel
          Left = 32
          Top = 146
          Width = 32
          Height = 13
          Hint = 'Scostamento'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Scost.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LOreLavorate4: TLabel
          Left = 32
          Top = 178
          Width = 32
          Height = 13
          Hint = 'Ore lavorate'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'HLav.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LScostamento4: TLabel
          Left = 32
          Top = 204
          Width = 32
          Height = 13
          Hint = 'Scostamento'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Scost.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LOreLavorate5: TLabel
          Left = 32
          Top = 236
          Width = 32
          Height = 13
          Hint = 'Ore lavorate'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'HLav.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LScostamento5: TLabel
          Left = 32
          Top = 262
          Width = 32
          Height = 13
          Hint = 'Scostamento'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Scost.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LOreLavorate6: TLabel
          Left = 32
          Top = 294
          Width = 32
          Height = 13
          Hint = 'Ore lavorate'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'HLav.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LScostamento6: TLabel
          Left = 32
          Top = 320
          Width = 32
          Height = 13
          Hint = 'Scostamento'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Scost.'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LDebito1: TLabel
          Left = 32
          Top = 17
          Width = 32
          Height = 13
          Hint = 'Debito giornaliero'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Debito'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LDebito2: TLabel
          Left = 32
          Top = 75
          Width = 32
          Height = 13
          Hint = 'Debito giornaliero'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Debito'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LDebito3: TLabel
          Left = 32
          Top = 133
          Width = 32
          Height = 13
          Hint = 'Debito giornaliero'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Debito'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LDebito4: TLabel
          Left = 32
          Top = 191
          Width = 32
          Height = 13
          Hint = 'Debito giornaliero'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Debito'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LDebito5: TLabel
          Left = 32
          Top = 249
          Width = 32
          Height = 13
          Hint = 'Debito giornaliero'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Debito'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object LDebito6: TLabel
          Left = 32
          Top = 307
          Width = 32
          Height = 13
          Hint = 'Debito giornaliero'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Debito'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object lblEscluseDaNorm1: TLabel
          Left = 32
          Top = 43
          Width = 32
          Height = 13
          Hint = 'Ore escluse dalle normali'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Esclus'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object lblEscluseDaNorm2: TLabel
          Left = 32
          Top = 101
          Width = 32
          Height = 13
          Hint = 'Ore escluse dalle normali'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Esclus'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object lblEscluseDaNorm3: TLabel
          Left = 32
          Top = 159
          Width = 32
          Height = 13
          Hint = 'Ore escluse dalle normali'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Esclus'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object lblEscluseDaNorm4: TLabel
          Left = 32
          Top = 217
          Width = 32
          Height = 13
          Hint = 'Ore escluse dalle normali'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Esclus'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object lblEscluseDaNorm5: TLabel
          Left = 32
          Top = 275
          Width = 32
          Height = 13
          Hint = 'Ore escluse dalle normali'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Esclus'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
        object lblEscluseDaNorm6: TLabel
          Left = 32
          Top = 333
          Width = 32
          Height = 13
          Hint = 'Ore escluse dalle normali'
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Esclus'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
        end
      end
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 632
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    inline frmSelAnagrafe: TfrmSelAnagrafe
      Left = 0
      Top = 0
      Width = 477
      Height = 24
      Align = alClient
      TabOrder = 0
      TabStop = True
      ExplicitWidth = 477
      ExplicitHeight = 24
      inherited pnlSelAnagrafe: TPanel
        Width = 477
        Height = 24
        ExplicitWidth = 477
        ExplicitHeight = 24
        inherited btnSelezione: TBitBtn
          OnClick = frmSelAnagrafebtnSelezioneClick
        end
      end
      inherited pmnuDatiAnagrafici: TPopupMenu
        Left = 221
        Top = 65520
        inherited R003Datianagrafici: TMenuItem
          OnClick = frmSelAnagrafeR003DatianagraficiClick
        end
      end
    end
    object Panel3: TPanel
      Left = 477
      Top = 0
      Width = 155
      Height = 24
      Align = alRight
      BevelOuter = bvLowered
      TabOrder = 1
      object LData: TLabel
        Left = 93
        Top = 5
        Width = 58
        Height = 13
        Alignment = taRightJustify
        Caption = '01/08/2999'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 3
        Top = 5
        Width = 86
        Height = 13
        Caption = 'Data Controllo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 438
    Top = 65523
    inherited File1: TMenuItem
      inherited Stampa1: TMenuItem
        Caption = 'Riepilogo &mensile'
        ShortCut = 16466
        OnClick = SpMeseClick
      end
      object Gestionemensile1: TMenuItem [2]
        Caption = 'Gestione mensile'
        OnClick = Gestionemensile1Click
      end
      object Pianiforari1: TMenuItem [4]
        Caption = 'Pianificazione orari'
        OnClick = EOrario1DblClick
      end
      object Pianificazioneliberaprofessione1: TMenuItem [5]
        Caption = 'Pianificazione libera professione'
        OnClick = Pianificazioneliberaprofessione1Click
      end
      object N3: TMenuItem [6]
        Caption = '-'
      end
      object Ripristinotimbratureoriginali1: TMenuItem [7]
        Caption = 'Ripristino timbrature originali'
        OnClick = Ripristinotimbratureoriginali1Click
      end
      object Eliminazionetimbratureriscaricate1: TMenuItem [8]
        Caption = 'Eliminazione timbrature riscaricate'
        OnClick = Ripristinotimbratureoriginali1Click
      end
      object N4: TMenuItem [9]
        Caption = '-'
      end
      object Allineamentotimbratureuguali1: TMenuItem [10]
        Caption = 'Allineamento timbrature uguali'
        OnClick = Ripristinotimbratureoriginali1Click
      end
      object Correzionetimbrature1: TMenuItem [11]
        Caption = 'Correzione anomalie'
        OnClick = Correzionetimbrature1Click
      end
      object ValidazioneTimbrature1: TMenuItem [12]
        Caption = 'Elaborazione omesse timbrature'
        OnClick = ValidazioneTimbrature1Click
      end
      object N2: TMenuItem [13]
        Caption = '-'
      end
    end
    object Timbrature1: TMenuItem
      Caption = 'Timbrature'
      Enabled = False
      object Inserisci1: TMenuItem
        Tag = 1
        Caption = 'Inserisci'
        OnClick = GestioneTimb
      end
      object Cancella1: TMenuItem
        Tag = 2
        Caption = 'Cancella'
        OnClick = GestioneTimb
      end
      object Modifica1: TMenuItem
        Tag = 3
        Caption = 'Modifica'
        OnClick = GestioneTimb
      end
    end
    object Giustificativi1: TMenuItem
      Caption = 'Giustificativi'
      Enabled = False
      object Inserisci2: TMenuItem
        Tag = 4
        Caption = 'Inser./Canc.'
        OnClick = GestioneTimb
      end
      object Modifica2: TMenuItem
        Tag = 5
        Caption = 'Modifica'
        OnClick = GestioneTimb
      end
    end
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 326
    Top = 65523
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 354
    Top = 65523
    object Inserisci3: TMenuItem
      Tag = 1
      Caption = 'Inserisci'
      ShortCut = 16457
      OnClick = GestioneTimb
    end
    object Cancella2: TMenuItem
      Tag = 2
      Caption = 'Cancella'
      ShortCut = 16452
      OnClick = GestioneTimb
    end
    object Modifica3: TMenuItem
      Tag = 3
      Caption = 'Modifica'
      ShortCut = 16461
      OnClick = GestioneTimb
    end
    object Accediamodificacausale1: TMenuItem
      Tag = 12
      Caption = 'Accedi a regole causale'
      OnClick = GestioneTimb
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object AggiornaControllo1: TMenuItem
      Tag = 7
      Caption = 'Aggiorna Data Controllo'
      ShortCut = 16449
      OnClick = GestioneTimb
    end
    object Conteggidiservizio1: TMenuItem
      Caption = 'Conteggi di servizio'
      OnClick = ConteggiDiServizioClick
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 382
    Top = 65523
    object MenuItem1: TMenuItem
      Tag = 4
      Caption = 'Inser./Canc.'
      ShortCut = 16457
      OnClick = GestioneTimb
    end
    object MenuItem3: TMenuItem
      Tag = 5
      Caption = 'Modifica'
      ShortCut = 16461
      OnClick = GestioneTimb
    end
    object Accediamodificacausale2: TMenuItem
      Tag = 12
      Caption = 'Accedi a regole causale'
      OnClick = GestioneTimb
    end
    object CompetenzeResidui1: TMenuItem
      Tag = 6
      Caption = 'Competenze/Residui'
      ShortCut = 16466
      OnClick = GestioneTimb
    end
    object Validaassenze1: TMenuItem
      Tag = 8
      Caption = 'Valida assenze'
      OnClick = GestioneTimb
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object AggiornaDataControllo1: TMenuItem
      Tag = 7
      Caption = 'Aggiorna Data Controllo'
      ShortCut = 16449
      OnClick = GestioneTimb
    end
    object ConteggiDiServizio2: TMenuItem
      Caption = 'Conteggi di servizio'
      OnClick = ConteggiDiServizioClick
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 410
    Top = 65523
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
