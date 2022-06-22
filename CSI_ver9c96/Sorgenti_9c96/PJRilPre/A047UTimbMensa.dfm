inherited A047FTimbMensa: TA047FTimbMensa
  Left = 253
  Top = 166
  HelpContext = 47000
  Caption = '<A047> Timbrature di mensa'
  ClientHeight = 444
  ClientWidth = 622
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 630
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 425
    Width = 622
    Panels = <
      item
        Text = 'Data'
        Width = 130
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
    ExplicitTop = 425
    ExplicitWidth = 622
  end
  object Panel2: TPanel [1]
    Left = 0
    Top = 24
    Width = 622
    Height = 46
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
    object Label3: TLabel
      Left = 4
      Top = 8
      Width = 29
      Height = 13
      Caption = 'Mese:'
    end
    object Label4: TLabel
      Left = 78
      Top = 8
      Width = 28
      Height = 13
      Caption = 'Anno:'
    end
    object SBConteggi: TSpeedButton
      Left = 326
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
    object SpAnomalie: TSpeedButton
      Left = 350
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
      OnClick = SpAnomalieClick
    end
    object SpStampa: TSpeedButton
      Left = 378
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Stampa timbrature'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpStampaClick
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
      Left = 108
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
      Left = 166
      Top = 4
      Width = 70
      Height = 22
      Caption = '<-Giorni prec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BPrecClick
    end
    object BSucc: TBitBtn
      Left = 236
      Top = 4
      Width = 70
      Height = 22
      Caption = 'GiorniSucc.->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BPrecClick
    end
    object GroupBox1: TGroupBox
      Left = 460
      Top = 1
      Width = 161
      Height = 44
      Align = alRight
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
  end
  object ScrollBox3: TScrollBox [2]
    Left = 0
    Top = 70
    Width = 622
    Height = 355
    VertScrollBar.Visible = False
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 2
    object LGiorno1: TLabel
      Left = 1
      Top = 21
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LGiorno'
    end
    object LGiorno2: TLabel
      Left = 1
      Top = 73
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LGiorno'
    end
    object LGiorno3: TLabel
      Left = 1
      Top = 127
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LGiorno'
    end
    object LGiorno4: TLabel
      Left = 1
      Top = 181
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LGiorno'
    end
    object LGiorno5: TLabel
      Left = 1
      Top = 235
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LGiorno'
    end
    object LGiorno6: TLabel
      Left = 1
      Top = 289
      Width = 38
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = 'LGiorno'
    end
    object GTimbrat1: TStringGrid
      Tag = 1
      Left = 42
      Top = 17
      Width = 210
      Height = 51
      ColCount = 20
      DefaultColWidth = 50
      DefaultRowHeight = 15
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
      OnDblClick = DoppioClick
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnKeyDown = GestisciKeyDown
      OnMouseDown = GestisciMouseDown
      OnMouseMove = GTimbrat1MouseMove
    end
    object GGiustif1: TStringGrid
      Tag = 11
      Left = 387
      Top = 17
      Width = 186
      Height = 51
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
      ShowHint = True
      TabOrder = 1
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnMouseMove = GTimbrat1MouseMove
    end
    object GTimbrat2: TStringGrid
      Tag = 2
      Left = 42
      Top = 71
      Width = 210
      Height = 51
      ColCount = 20
      DefaultColWidth = 50
      DefaultRowHeight = 15
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      TabOrder = 2
      OnDblClick = DoppioClick
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnKeyDown = GestisciKeyDown
      OnMouseDown = GestisciMouseDown
      OnMouseMove = GTimbrat1MouseMove
    end
    object GGiustif2: TStringGrid
      Tag = 12
      Left = 387
      Top = 71
      Width = 186
      Height = 51
      ColCount = 20
      DefaultColWidth = 90
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnMouseMove = GTimbrat1MouseMove
    end
    object GTimbrat3: TStringGrid
      Tag = 3
      Left = 45
      Top = 124
      Width = 210
      Height = 51
      ColCount = 20
      DefaultColWidth = 50
      DefaultRowHeight = 15
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      TabOrder = 4
      OnDblClick = DoppioClick
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnKeyDown = GestisciKeyDown
      OnMouseDown = GestisciMouseDown
      OnMouseMove = GTimbrat1MouseMove
    end
    object GGiustif3: TStringGrid
      Tag = 13
      Left = 387
      Top = 125
      Width = 186
      Height = 51
      ColCount = 20
      DefaultColWidth = 90
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnMouseMove = GTimbrat1MouseMove
    end
    object GTimbrat4: TStringGrid
      Tag = 4
      Left = 42
      Top = 179
      Width = 210
      Height = 51
      ColCount = 20
      DefaultColWidth = 50
      DefaultRowHeight = 15
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      TabOrder = 6
      OnDblClick = DoppioClick
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnKeyDown = GestisciKeyDown
      OnMouseDown = GestisciMouseDown
      OnMouseMove = GTimbrat1MouseMove
    end
    object GGiustif4: TStringGrid
      Tag = 14
      Left = 387
      Top = 179
      Width = 186
      Height = 51
      ColCount = 20
      DefaultColWidth = 90
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnMouseMove = GTimbrat1MouseMove
    end
    object GTimbrat5: TStringGrid
      Tag = 5
      Left = 42
      Top = 233
      Width = 210
      Height = 51
      ColCount = 20
      DefaultColWidth = 50
      DefaultRowHeight = 15
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      TabOrder = 8
      OnDblClick = DoppioClick
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnKeyDown = GestisciKeyDown
      OnMouseDown = GestisciMouseDown
      OnMouseMove = GTimbrat1MouseMove
    end
    object GGiustif5: TStringGrid
      Tag = 15
      Left = 387
      Top = 233
      Width = 186
      Height = 51
      ColCount = 20
      DefaultColWidth = 90
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnMouseMove = GTimbrat1MouseMove
    end
    object GTimbrat6: TStringGrid
      Tag = 6
      Left = 42
      Top = 287
      Width = 210
      Height = 51
      ColCount = 20
      DefaultColWidth = 50
      DefaultRowHeight = 15
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowHint = True
      TabOrder = 10
      OnDblClick = DoppioClick
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnKeyDown = GestisciKeyDown
      OnMouseDown = GestisciMouseDown
      OnMouseMove = GTimbrat1MouseMove
    end
    object GGiustif6: TStringGrid
      Tag = 16
      Left = 387
      Top = 287
      Width = 186
      Height = 51
      ColCount = 20
      DefaultColWidth = 90
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnDrawCell = GTimbrat1DrawCell
      OnEnter = GTimbrat1Enter
      OnExit = GTimbrat1Exit
      OnMouseMove = GTimbrat1MouseMove
    end
    object PConteggi: TPanel
      Left = 582
      Top = 15
      Width = 40
      Height = 340
      Align = alRight
      BevelOuter = bvNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 12
      Visible = False
      object LPasti1: TLabel
        Tag = 11
        Left = 3
        Top = 2
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'NPast.'
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object LPasti2: TLabel
        Left = 3
        Top = 56
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'NPast.'
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object LPasti3: TLabel
        Left = 3
        Top = 110
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'NPast.'
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object LPasti4: TLabel
        Left = 3
        Top = 164
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'NPast.'
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object LPasti5: TLabel
        Left = 3
        Top = 218
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'NPast.'
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object LPasti6: TLabel
        Left = 3
        Top = 272
        Width = 32
        Height = 13
        Alignment = taRightJustify
        Caption = 'NPast.'
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 622
      Height = 15
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 13
      object Label19: TLabel
        Left = 387
        Top = 1
        Width = 56
        Height = 13
        Caption = 'Giustificativi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label18: TLabel
        Left = 43
        Top = 1
        Width = 50
        Height = 13
        Caption = 'Timbrature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LblNumPasti: TLabel
        Left = 569
        Top = 1
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Num.pasti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Visible = False
      end
      object Label6: TLabel
        Left = 254
        Top = 1
        Width = 76
        Height = 13
        Caption = 'Accessi manuali'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
    object GAccessi1: TStringGrid
      Tag = 1
      Left = 254
      Top = 17
      Width = 131
      Height = 51
      DefaultColWidth = 50
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      PopupMenu = PopupMenu3
      TabOrder = 14
      OnEnter = GAccessi1Enter
      OnKeyDown = GAccessi1KeyDown
    end
    object GAccessi2: TStringGrid
      Tag = 2
      Left = 254
      Top = 71
      Width = 131
      Height = 51
      DefaultColWidth = 50
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      PopupMenu = PopupMenu3
      TabOrder = 15
      OnEnter = GAccessi1Enter
      OnKeyDown = GAccessi1KeyDown
    end
    object GAccessi3: TStringGrid
      Tag = 3
      Left = 254
      Top = 125
      Width = 131
      Height = 51
      DefaultColWidth = 50
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      PopupMenu = PopupMenu3
      TabOrder = 16
      OnEnter = GAccessi1Enter
      OnKeyDown = GAccessi1KeyDown
    end
    object GAccessi4: TStringGrid
      Tag = 4
      Left = 254
      Top = 179
      Width = 131
      Height = 51
      DefaultColWidth = 50
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      PopupMenu = PopupMenu3
      TabOrder = 17
      OnEnter = GAccessi1Enter
      OnKeyDown = GAccessi1KeyDown
    end
    object GAccessi5: TStringGrid
      Tag = 5
      Left = 254
      Top = 233
      Width = 131
      Height = 51
      DefaultColWidth = 50
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      PopupMenu = PopupMenu3
      TabOrder = 18
      OnEnter = GAccessi1Enter
      OnKeyDown = GAccessi1KeyDown
    end
    object GAccessi6: TStringGrid
      Tag = 6
      Left = 254
      Top = 287
      Width = 131
      Height = 51
      DefaultColWidth = 50
      DefaultRowHeight = 15
      FixedCols = 0
      RowCount = 2
      FixedRows = 0
      PopupMenu = PopupMenu3
      TabOrder = 19
      OnEnter = GAccessi1Enter
      OnKeyDown = GAccessi1KeyDown
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [3]
    Left = 0
    Top = 0
    Width = 622
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 622
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 622
      Height = 24
      ExplicitWidth = 622
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      Left = 156
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [4]
    Left = 184
    Top = 65534
    inherited File1: TMenuItem
      object Regolediconteggio1: TMenuItem [0]
        Caption = 'Regole di conteggio'
        OnClick = Regolediconteggio1Click
      end
      inherited ImpostaStampante1: TMenuItem
        Visible = False
      end
      inherited Stampa1: TMenuItem
        OnClick = SpStampaClick
      end
      object N2: TMenuItem [3]
        Caption = '-'
      end
      object Ripristinotimbratureoriginali1: TMenuItem [4]
        Caption = 'Ripristino timbrature originali'
        OnClick = Ripristinotimbratureoriginali1Click
      end
      inherited Exit1: TMenuItem
        ShortCut = 24689
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
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 212
    Top = 65534
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    Top = 65534
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
  end
  object PopupMenu3: TPopupMenu
    Left = 268
    Top = 65534
    object Aggiungi1: TMenuItem
      Caption = 'Aggiungi'
      OnClick = Aggiungi1Click
    end
    object Elimina1: TMenuItem
      Caption = 'Elimina'
      OnClick = Elimina1Click
    end
  end
end
