object A012FSviluppo: TA012FSviluppo
  Left = 23
  Top = 81
  Width = 603
  Height = 318
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = Calendario
  Caption = '<A012> Calendario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 264
    Width = 595
    Height = 27
    Align = alBottom
    TabOrder = 0
    object Label6: TLabel
      Left = 112
      Top = 12
      Width = 68
      Height = 13
      Alignment = taRightJustify
      Caption = 'Data corrente:'
    end
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 0
      Glyph.Data = {
        CE070000424DCE07000000000000360000002800000024000000120000000100
        1800000000009807000000000000000000000000000000000000008080008080
        0080800080800080800080800080800080800080800080800080800080800080
        8000808000808000808000808000808000808000808000808000808000808000
        8080008080008080008080008080008080008080008080008080008080008080
        0080800080800080800080800080800080800080800080800080800080800080
        8000808000808000808000808000808000808000808000808000808000808000
        8080008080008080008080008080FFFFFF008080008080008080008080008080
        0080800080800080800080800080800080800080800080800080800080800080
        8080000080000000808000808000808000808000808000808000808000808000
        8080008080008080008080008080008080008080008080808080808080FFFFFF
        0080800080800080800080800080800080800080800080800080800080800080
        8000808000808000808080000000800000800080000000808000808000808000
        8080008080008080008080008080008080008080008080008080008080008080
        808080008080008080808080FFFFFF0080800080800080800080800080800080
        8000808000808000808000808000808000808080000000800000800000800000
        8000800000008080008080008080008080008080008080008080008080008080
        008080008080008080808080008080008080008080008080808080FFFFFF0080
        8000808000808000808000808000808000808000808000808000808080000000
        8000008000008000008000008000008000800000008080008080008080008080
        0080800080800080800080800080800080808080800080800080800080800080
        80008080008080808080FFFFFF00808000808000808000808000808000808000
        808000808080000000800000800000800000FF00008000008000008000008000
        800000008080008080008080008080008080008080008080008080808080FFFF
        FF008080008080808080FFFFFF008080008080008080808080FFFFFF00808000
        808000808000808000808000808000808000800000800000800000FF00008080
        00FF000080000080000080008000000080800080800080800080800080800080
        80008080008080808080FFFFFF008080808080008080808080FFFFFF00808000
        8080808080FFFFFF00808000808000808000808000808000808000808000FF00
        00800000FF0000808000808000808000FF000080000080000080008000000080
        80008080008080008080008080008080008080808080FFFFFF80808000808000
        8080008080808080FFFFFF008080008080808080FFFFFF008080008080008080
        00808000808000808000808000FF0000808000808000808000808000808000FF
        0000800000800000800080000000808000808000808000808000808000808000
        8080808080008080008080008080008080008080808080FFFFFF008080008080
        808080FFFFFF0080800080800080800080800080800080800080800080800080
        8000808000808000808000808000FF0000800000800000800080000000808000
        8080008080008080008080008080008080008080008080008080008080008080
        008080808080FFFFFF008080008080808080FFFFFF0080800080800080800080
        8000808000808000808000808000808000808000808000808000808000FF0000
        8000008000008000800000008080008080008080008080008080008080008080
        008080008080008080008080008080008080808080FFFFFF0080800080808080
        80FFFFFF00808000808000808000808000808000808000808000808000808000
        808000808000808000808000FF00008000008000008000800000008080008080
        0080800080800080800080800080800080800080800080800080800080800080
        80808080FFFFFF008080008080808080FFFFFF00808000808000808000808000
        808000808000808000808000808000808000808000808000808000FF00008000
        0080000080008000000080800080800080800080800080800080800080800080
        80008080008080008080008080008080808080FFFFFF008080008080808080FF
        FFFF008080008080008080008080008080008080008080008080008080008080
        00808000808000808000FF000080000080008000000080800080800080800080
        8000808000808000808000808000808000808000808000808000808000808080
        8080FFFFFF008080808080FFFFFF008080008080008080008080008080008080
        00808000808000808000808000808000808000808000808000FF000080000080
        0000808000808000808000808000808000808000808000808000808000808000
        8080008080008080008080008080808080FFFFFF808080008080008080008080
        0080800080800080800080800080800080800080800080800080800080800080
        8000808000808000FF0000808000808000808000808000808000808000808000
        8080008080008080008080008080008080008080008080008080008080808080
        0080800080800080800080800080800080800080800080800080800080800080
        8000808000808000808000808000808000808000808000808000808000808000
        8080008080008080008080008080008080008080008080008080008080008080
        008080008080008080008080008080008080}
      NumGlyphs = 2
    end
    object DataCor: TMaskEdit
      Left = 184
      Top = 4
      Width = 69
      Height = 21
      EditMask = '!99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      OnKeyPress = DataCorKeyPress
    end
  end
  object Calendario: TStringGrid
    Left = 0
    Top = 37
    Width = 595
    Height = 227
    HelpContext = 12000
    Align = alClient
    ColCount = 32
    DefaultColWidth = 15
    DefaultRowHeight = 15
    RowCount = 12
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
    TabOrder = 1
    OnDragDrop = CalendarioDragDrop
    OnDragOver = CalendarioDragOver
    OnDrawCell = CalendarioDrawCell
    OnSelectCell = CalendarioSelectCell
    RowHeights = (
      15
      15
      15
      15
      15
      15
      15
      15
      15
      15
      15
      15)
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 595
    Height = 37
    Align = alTop
    Caption = 'Legenda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object SLavora: TShape
      Left = 8
      Top = 16
      Width = 17
      Height = 17
      DragMode = dmAutomatic
      OnMouseDown = SLavoraMouseDown
    end
    object Label1: TLabel
      Left = 28
      Top = 20
      Width = 50
      Height = 13
      Caption = 'Lavorativo'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object SDomenica: TShape
      Left = 188
      Top = 16
      Width = 17
      Height = 17
      Brush.Style = bsClear
      Pen.Color = clRed
      OnMouseDown = SLavoraMouseDown
    end
    object Label2: TLabel
      Left = 108
      Top = 20
      Width = 69
      Height = 13
      Caption = 'Non lavorativo'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object SNonLavora: TShape
      Left = 88
      Top = 16
      Width = 17
      Height = 17
      Brush.Color = clLime
      DragMode = dmAutomatic
      OnMouseDown = SLavoraMouseDown
    end
    object Label3: TLabel
      Left = 208
      Top = 20
      Width = 48
      Height = 13
      Caption = 'Domenica'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object SFesta: TShape
      Left = 268
      Top = 16
      Width = 17
      Height = 17
      Brush.Color = clYellow
      DragMode = dmAutomatic
      OnMouseDown = SLavoraMouseDown
    end
    object Label4: TLabel
      Left = 288
      Top = 20
      Width = 34
      Height = 13
      Caption = 'Festivo'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
end
