object A073FControllo: TA073FControllo
  Left = 341
  Top = 220
  HelpContext = 73000
  BorderStyle = bsDialog
  Caption = '<A073> Riepilogo acquisti/maturazione buoni pasto/ticket'
  ClientHeight = 226
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 28
    Width = 16
    Height = 13
    Caption = 'Dal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 108
    Top = 28
    Width = 8
    Height = 13
    Caption = 'al'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object EDaData: TMaskEdit
    Left = 8
    Top = 44
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object EAData: TMaskEdit
    Left = 108
    Top = 44
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 185
    Width = 75
    Height = 25
    Caption = 'Calcola'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000C40E0000C40E00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
      8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
      3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
      FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
      FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
    ParentFont = False
    TabOrder = 7
    OnClick = BitBtn1Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 72
    Width = 193
    Height = 105
    Caption = 'Acquistati'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label3: TLabel
      Left = 8
      Top = 20
      Width = 59
      Height = 13
      Caption = 'Buoni pasto:'
    end
    object Label4: TLabel
      Left = 8
      Top = 48
      Width = 33
      Height = 13
      Caption = 'Ticket:'
    end
    object Edit1: TEdit
      Left = 76
      Top = 16
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object Edit2: TEdit
      Left = 76
      Top = 44
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
  end
  object GroupBox2: TGroupBox
    Left = 216
    Top = 72
    Width = 193
    Height = 105
    Caption = 'Maturati'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object Label5: TLabel
      Left = 8
      Top = 20
      Width = 59
      Height = 13
      Caption = 'Buoni pasto:'
    end
    object Label6: TLabel
      Left = 8
      Top = 48
      Width = 33
      Height = 13
      Caption = 'Ticket:'
    end
    object LAnom: TLabel
      Left = 10
      Top = 76
      Width = 110
      Height = 13
      Caption = 'Sono presenti anomalie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Edit3: TEdit
      Left = 76
      Top = 16
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object Edit4: TEdit
      Left = 76
      Top = 44
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    object lblDipendente: TLabel
      Left = 8
      Top = 4
      Width = 55
      Height = 13
      Caption = 'Dipendente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object BitBtn2: TBitBtn
    Left = 336
    Top = 185
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 10
  end
  object btnAnteprima: TBitBtn
    Left = 184
    Top = 185
    Width = 81
    Height = 25
    Caption = 'Anteprima'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    ParentFont = False
    TabOrder = 9
    OnClick = btnAnteprimaClick
  end
  object btnDal: TButton
    Left = 80
    Top = 43
    Width = 15
    Height = 23
    Caption = '...'
    TabOrder = 1
    OnClick = btnDalClick
  end
  object btnAl: TButton
    Left = 183
    Top = 43
    Width = 15
    Height = 23
    Caption = '...'
    TabOrder = 3
    OnClick = btnAlClick
  end
  object btnStampante: TBitBtn
    Left = 94
    Top = 185
    Width = 81
    Height = 25
    Caption = 'S&tampante'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
      0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
      070F00000000000007700778888778807070F000000000070700FF0777777770
      7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
      6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
    TabOrder = 8
    OnClick = btnStampanteClick
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 372
    Top = 26
  end
end
