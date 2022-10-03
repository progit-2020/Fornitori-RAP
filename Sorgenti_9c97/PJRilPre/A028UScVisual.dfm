object A028FSCVisual: TA028FSCVisual
  Left = 291
  Top = 181
  HelpContext = 28000
  Caption = 'A028FSCVisual'
  ClientHeight = 464
  ClientWidth = 637
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 637
    Height = 464
    ActivePage = TabSheet5
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Dati riassuntivi'
      object LAnomalia1: TLabel
        Left = 8
        Top = 3
        Width = 66
        Height = 13
        Caption = 'LAnomalia1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object LNumTimb: TLabel
        Left = 8
        Top = 20
        Width = 77
        Height = 13
        Caption = 'Num. timbrature:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LNumGiusDaA: TLabel
        Left = 8
        Top = 206
        Width = 85
        Height = 13
        Caption = 'Num. giustif. da a:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LNumGiusOre: TLabel
        Left = 192
        Top = 206
        Width = 105
        Height = 13
        Caption = 'Num. giustif. num. ore:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LMezzaAss: TLabel
        Left = 387
        Top = 218
        Width = 82
        Height = 13
        Caption = 'Mezza giorn. ass.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LGiorniAss: TLabel
        Left = 387
        Top = 247
        Width = 76
        Height = 13
        Caption = 'Gion. intere ass.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LValGiornoAss: TLabel
        Left = 387
        Top = 276
        Width = 73
        Height = 13
        Caption = 'Giorno assenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LNumTimbNom: TLabel
        Left = 8
        Top = 104
        Width = 118
        Height = 13
        Caption = 'Num. timbrature nominali:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LMGCaus: TLabel
        Left = 387
        Top = 232
        Width = 82
        Height = 13
        Caption = 'Mezza giorn. ass.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LGGCaus: TLabel
        Left = 387
        Top = 261
        Width = 76
        Height = 13
        Caption = 'Gion. intere ass.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object LFasce: TLabel
        Left = 8
        Top = 292
        Width = 29
        Height = 13
        Caption = 'Fasce'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 318
        Top = 20
        Width = 77
        Height = 13
        Caption = 'Timbrature cont.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object GNumTimb: TStringGrid
        Left = 8
        Top = 34
        Width = 303
        Height = 69
        ColCount = 4
        DefaultColWidth = 40
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 3
        FixedRows = 0
        TabOrder = 0
      end
      object GGiusDaA: TStringGrid
        Left = 8
        Top = 220
        Width = 178
        Height = 70
        ColCount = 4
        DefaultColWidth = 40
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 3
        FixedRows = 0
        TabOrder = 1
      end
      object GGiusNumOre: TStringGrid
        Left = 192
        Top = 220
        Width = 177
        Height = 70
        ColCount = 4
        DefaultColWidth = 40
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        TabOrder = 2
      end
      object GTimbNom: TStringGrid
        Left = 8
        Top = 118
        Width = 613
        Height = 85
        ColCount = 4
        DefaultColWidth = 40
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 3
      end
      object GFasce: TStringGrid
        Left = 8
        Top = 306
        Width = 613
        Height = 128
        ColCount = 7
        DefaultColWidth = 60
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 4
      end
      object grdTimbratureCon: TStringGrid
        Left = 318
        Top = 34
        Width = 303
        Height = 69
        ColCount = 4
        DefaultColWidth = 40
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 3
        FixedRows = 0
        TabOrder = 5
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Anomalie  - Riepilogo presenze/assenze'
      object splAnomalie2: TSplitter
        Left = 0
        Top = 105
        Width = 629
        Height = 4
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 86
      end
      object splAnomalie3: TSplitter
        Left = 0
        Top = 214
        Width = 629
        Height = 4
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 182
      end
      object splPresenze: TSplitter
        Left = 0
        Top = 323
        Width = 629
        Height = 4
        Cursor = crVSplit
        Align = alTop
        ExplicitTop = 301
      end
      object GAnomalie2: TStringGrid
        Left = 0
        Top = 18
        Width = 629
        Height = 87
        Align = alTop
        ColCount = 2
        DefaultColWidth = 290
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 0
      end
      object GAnomalie3: TStringGrid
        Left = 0
        Top = 127
        Width = 629
        Height = 87
        Align = alTop
        ColCount = 2
        DefaultColWidth = 290
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 1
      end
      object GAssenze: TStringGrid
        Left = 0
        Top = 345
        Width = 629
        Height = 91
        Align = alClient
        ColCount = 9
        DefaultColWidth = 70
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 2
        ExplicitHeight = 87
      end
      object GPresenze: TStringGrid
        Left = 0
        Top = 236
        Width = 629
        Height = 87
        Align = alTop
        ColCount = 6
        DefaultColWidth = 70
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 4
        FixedRows = 0
        TabOrder = 3
      end
      object pnlHeadAnomalie3: TPanel
        Left = 0
        Top = 109
        Width = 629
        Height = 18
        Align = alTop
        Caption = 'Anomalie 3'#176' livello'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        ExplicitLeft = -3
        ExplicitTop = 130
      end
      object pnlHeadAnomalie2: TPanel
        Left = 0
        Top = 0
        Width = 629
        Height = 18
        Align = alTop
        Caption = 'Anomalie 2'#176' livello'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        ExplicitTop = 8
      end
      object pnlHeadPresenze: TPanel
        Left = 0
        Top = 218
        Width = 629
        Height = 18
        Align = alTop
        Caption = 'Presenze'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        ExplicitLeft = 3
        ExplicitTop = 242
      end
      object pnlHeadAssenze: TPanel
        Left = 0
        Top = 327
        Width = 629
        Height = 18
        Align = alTop
        Caption = 'Assenze'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        ExplicitLeft = 3
        ExplicitTop = 378
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Dettaglio dati'
      ImageIndex = 4
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 629
        Height = 313
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        PopupMenu = ppMnu
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        OnKeyDown = DBGrid1KeyDown
      end
      object Panel1: TPanel
        Left = 0
        Top = 313
        Width = 629
        Height = 123
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 119
          Top = 1
          Width = 95
          Height = 13
          Caption = 'Timbrature di mensa'
          WordWrap = True
        end
        object Label2: TLabel
          Left = 221
          Top = 1
          Width = 122
          Height = 26
          Caption = 'Ore causalizzate divise in fasce a blocchi'
          WordWrap = True
        end
        object Label3: TLabel
          Left = 361
          Top = 1
          Width = 81
          Height = 13
          Caption = 'Ore per rilevatore'
          WordWrap = True
        end
        object Label5: TLabel
          Left = 502
          Top = 1
          Width = 34
          Height = 13
          Caption = 'Gettoni'
          WordWrap = True
        end
        object Label6: TLabel
          Left = 0
          Top = 1
          Width = 68
          Height = 13
          Caption = 'Stacco mensa'
        end
        object GTimbMensa: TStringGrid
          Left = 119
          Top = 29
          Width = 91
          Height = 90
          ColCount = 1
          DefaultColWidth = 40
          DefaultRowHeight = 16
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          TabOrder = 0
        end
        object GFascePaghe: TStringGrid
          Left = 221
          Top = 29
          Width = 130
          Height = 90
          ColCount = 2
          DefaultColWidth = 50
          DefaultRowHeight = 16
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          TabOrder = 1
        end
        object grdRilevatori: TStringGrid
          Left = 361
          Top = 29
          Width = 132
          Height = 90
          ColCount = 2
          DefaultColWidth = 50
          DefaultRowHeight = 16
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          TabOrder = 2
        end
        object grdGettoni: TStringGrid
          Left = 502
          Top = 29
          Width = 121
          Height = 90
          ColCount = 2
          DefaultColWidth = 50
          DefaultRowHeight = 16
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          TabOrder = 3
        end
        object grdStaccoMensa: TStringGrid
          Left = 0
          Top = 29
          Width = 108
          Height = 90
          ColCount = 2
          DefaultColWidth = 40
          DefaultRowHeight = 16
          FixedCols = 0
          RowCount = 1
          FixedRows = 0
          TabOrder = 4
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Dettaglio timbrature'
      DesignSize = (
        629
        436)
      object LEntrate: TLabel
        Left = 6
        Top = -2
        Width = 34
        Height = 13
        Caption = 'Entrate'
      end
      object LUscite: TLabel
        Left = 6
        Top = 194
        Width = 30
        Height = 13
        Caption = 'Uscite'
      end
      object GEntrate: TStringGrid
        Left = 4
        Top = 12
        Width = 616
        Height = 179
        Anchors = [akLeft, akTop, akRight]
        ColCount = 4
        DefaultColWidth = 100
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 10
        FixedRows = 0
        TabOrder = 0
      end
      object GUscite: TStringGrid
        Left = 4
        Top = 208
        Width = 616
        Height = 179
        Anchors = [akLeft, akTop, akRight]
        ColCount = 4
        DefaultColWidth = 100
        DefaultRowHeight = 16
        FixedCols = 0
        RowCount = 10
        FixedRows = 0
        TabOrder = 1
      end
    end
  end
  object ppMnu: TPopupMenu
    Left = 588
    Top = 29
    object Cerca1: TMenuItem
      Caption = 'Cerca'
      ShortCut = 16454
      OnClick = Cerca1Click
    end
  end
end
