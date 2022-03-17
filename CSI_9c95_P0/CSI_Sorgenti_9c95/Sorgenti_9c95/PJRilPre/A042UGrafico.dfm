object A042FGrafico: TA042FGrafico
  Left = -4
  Top = -4
  HelpContext = 42000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A042> Grafico dei presenti/assenti'
  ClientHeight = 581
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 513
    Width = 800
    Height = 68
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Shape1: TShape
      Left = -1
      Top = 0
      Width = 802
      Height = 2
    end
    object Label6: TLabel
      Left = 352
      Top = 12
      Width = 112
      Height = 13
      Caption = 'Intestazione del grafico:'
    end
    object BtnEsci: TBitBtn
      Left = 116
      Top = 35
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 10
      Top = 34
      Width = 100
      Height = 25
      Caption = '&Stampa'
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
      TabOrder = 1
      OnClick = BtnStampaClick
    end
    object ChkLineeVerticali: TCheckBox
      Left = 32
      Top = 11
      Width = 137
      Height = 17
      Caption = 'Visualizza linee verticali'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = ChkLineeVerticaliClick
    end
    object ChkLineeOrizzontali: TCheckBox
      Left = 188
      Top = 11
      Width = 139
      Height = 17
      Caption = 'Visualizza linee orizzontali'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = ChkLineeOrizzontaliClick
    end
    object edtIntestazione: TEdit
      Left = 467
      Top = 9
      Width = 302
      Height = 21
      MaxLength = 100
      TabOrder = 4
      OnChange = edtIntestazioneChange
    end
  end
  object Chart1: TChart
    Left = 0
    Top = 79
    Width = 728
    Height = 434
    AllowPanning = pmVertical
    BackWall.Brush.Color = clWhite
    Legend.LegendStyle = lsValues
    Legend.Shadow.Color = 4194368
    Legend.Shadow.HorizSize = 0
    Legend.Shadow.VertSize = 0
    Legend.TextStyle = ltsPlain
    Legend.Visible = False
    MarginBottom = 2
    MarginTop = 2
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Maximum = 37299.000000000000000000
    BottomAxis.Minimum = 37210.000000000000000000
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.ExactDateTime = False
    LeftAxis.Maximum = 24.000000000000000000
    LeftAxis.MinorTickCount = 0
    LeftAxis.MinorTickLength = 0
    LeftAxis.Title.Caption = 'DIPENDENTI(cognome - nome - matricola)'
    View3D = False
    View3DOptions.Elevation = 315
    View3DOptions.Orthogonal = False
    View3DOptions.Perspective = 0
    View3DOptions.Rotation = 360
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    ColorPaletteIndex = 13
    object Series1: TGanttSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      ShowInLegend = False
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 8
      Pointer.Visible = True
      XValues.Name = 'Start'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      ConnectingPen.Visible = False
      StartValues.Name = 'Start'
      StartValues.Order = loAscending
      EndValues.Name = 'End'
      EndValues.Order = loNone
      NextTask.Name = 'NextTask'
      NextTask.Order = loNone
    end
    object Series2: TGanttSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      SeriesColor = clYellow
      ShowInLegend = False
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 5
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'Start'
      XValues.Order = loNone
      YValues.DateTime = True
      YValues.Name = 'Y'
      YValues.Order = loAscending
      ConnectingPen.Visible = False
      StartValues.DateTime = False
      StartValues.Name = 'Start'
      StartValues.Order = loNone
      EndValues.Name = 'End'
      EndValues.Order = loNone
      NextTask.Name = 'NextTask'
      NextTask.Order = loNone
    end
    object Series3: TGanttSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.ShapeStyle = fosRoundRectangle
      Marks.Visible = False
      ShowInLegend = False
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.Name = 'Start'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      ConnectingPen.Visible = False
      StartValues.Name = 'Start'
      StartValues.Order = loAscending
      EndValues.Name = 'End'
      EndValues.Order = loNone
      NextTask.Name = 'NextTask'
      NextTask.Order = loNone
    end
  end
  object Panel2: TPanel
    Left = 728
    Top = 79
    Width = 72
    Height = 434
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 72
      Height = 434
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 61
        Height = 26
        Align = alTop
        Caption = 'Legenda causali-colori'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object ChartLegenda: TChart
        Left = 0
        Top = 26
        Width = 72
        Height = 408
        AllowPanning = pmVertical
        BackWall.Brush.Color = clWhite
        Legend.LegendStyle = lsValues
        Legend.Shadow.Color = 4194368
        Legend.Shadow.HorizSize = 0
        Legend.Shadow.VertSize = 0
        Legend.TextStyle = ltsPlain
        Legend.Visible = False
        MarginBottom = 10
        MarginLeft = 0
        MarginRight = 18
        MarginTop = 0
        Title.Text.Strings = (
          'TChart')
        Title.Visible = False
        BottomAxis.Automatic = False
        BottomAxis.AutomaticMaximum = False
        BottomAxis.AutomaticMinimum = False
        BottomAxis.Axis.Visible = False
        BottomAxis.Grid.Visible = False
        BottomAxis.Maximum = 37299.000000000000000000
        BottomAxis.Minimum = 37210.000000000000000000
        BottomAxis.Visible = False
        LeftAxis.Automatic = False
        LeftAxis.AutomaticMaximum = False
        LeftAxis.Axis.Visible = False
        LeftAxis.Grid.Visible = False
        LeftAxis.Maximum = 20.000000000000000000
        LeftAxis.MinorTickCount = 0
        LeftAxis.MinorTickLength = 0
        LeftAxis.TickLength = 0
        LeftAxis.Ticks.Visible = False
        LeftAxis.TicksInner.Visible = False
        View3D = False
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        ColorPaletteIndex = 13
        object Series4: TGanttSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.ShapeStyle = fosRoundRectangle
          Marks.Visible = False
          SeriesColor = clGreen
          ClickableLine = False
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = True
          XValues.Name = 'Start'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          ConnectingPen.Visible = False
          StartValues.Name = 'Start'
          StartValues.Order = loAscending
          EndValues.Name = 'End'
          EndValues.Order = loNone
          NextTask.Name = 'NextTask'
          NextTask.Order = loNone
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 79
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 3
    object Label2: TLabel
      Left = 107
      Top = 39
      Width = 232
      Height = 13
      Caption = 'Legenda dimensioni - tipologia presenze/assenze'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Image1: TImage
      Left = 106
      Top = 57
      Width = 18
      Height = 18
      Picture.Data = {
        07544269746D617026040000424D260400000000000036000000280000001200
        0000120000000100180000000000F0030000120B0000120B0000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000}
    end
    object Label3: TLabel
      Left = 126
      Top = 60
      Width = 89
      Height = 13
      Caption = '--> Giust. gg. intera'
    end
    object Image2: TImage
      Left = 227
      Top = 61
      Width = 18
      Height = 11
      Picture.Data = {
        07544269746D61709E020000424D9E0200000000000036000000280000001200
        00000B000000010018000000000068020000120B0000120B0000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000}
    end
    object Label4: TLabel
      Left = 248
      Top = 60
      Width = 142
      Height = 13
      Caption = '--> Giust. mg. + Giust. num.ore'
    end
    object Image3: TImage
      Left = 403
      Top = 64
      Width = 18
      Height = 6
      Picture.Data = {
        07544269746D617086010000424D860100000000000036000000280000001200
        000006000000010018000000000050010000120B0000120B0000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000
        0000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000}
      Stretch = True
    end
    object Label5: TLabel
      Left = 423
      Top = 60
      Width = 197
      Height = 13
      Caption = '--> Giust. da ore a ore/Ore n.c.(timbrature)'
    end
    object LblTitolo: TLabel
      Left = 0
      Top = 16
      Width = 800
      Height = 12
      Alignment = taCenter
      AutoSize = False
      Caption = 'GRAFICO PRESENTI/ASSENTI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblAzienda: TLabel
      Left = 0
      Top = 4
      Width = 800
      Height = 12
      Alignment = taCenter
      AutoSize = False
      Caption = 'MONDO EDP'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblIntestazione: TLabel
      Left = 0
      Top = 28
      Width = 800
      Height = 12
      Alignment = taCenter
      AutoSize = False
      Caption = 'LblIntestazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
