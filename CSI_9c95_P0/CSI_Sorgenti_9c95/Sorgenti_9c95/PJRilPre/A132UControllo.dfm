object A132FControllo: TA132FControllo
  Left = 0
  Top = 0
  Caption = '<A132> Riepilogo magazzino buoni pasto/ticket'
  ClientHeight = 248
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 14
    Width = 122
    Height = 13
    Caption = 'Riepilogo complessivo dal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 8
    Top = 45
    Width = 127
    Height = 13
    Caption = 'Riepilogo della fornitura del'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 240
    Top = 14
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
    Left = 147
    Top = 9
    Width = 68
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 0
    Text = '  /  /    '
  end
  object btnDal: TButton
    Left = 216
    Top = 8
    Width = 15
    Height = 23
    Caption = '...'
    TabOrder = 1
    OnClick = btnDalClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 69
    Width = 193
    Height = 129
    Caption = 'Buoni pasto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    object Label3: TLabel
      Left = 8
      Top = 20
      Width = 49
      Height = 13
      Caption = 'Acquistati:'
    end
    object Label4: TLabel
      Left = 8
      Top = 76
      Width = 38
      Height = 13
      Caption = 'Residui:'
    end
    object Label1: TLabel
      Left = 8
      Top = 104
      Width = 39
      Height = 13
      Caption = 'Scaduti:'
    end
    object Label9: TLabel
      Left = 8
      Top = 49
      Width = 49
      Height = 13
      Caption = 'Assegnati:'
    end
    object edtBuoniAcq: TEdit
      Left = 76
      Top = 16
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object edtBuoniRes: TEdit
      Left = 76
      Top = 72
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
    object edtBuoniScad: TEdit
      Left = 76
      Top = 100
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 2
      Text = '0'
    end
    object edtBuoniAss: TEdit
      Left = 76
      Top = 45
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 3
      Text = '0'
    end
  end
  object GroupBox2: TGroupBox
    Left = 238
    Top = 69
    Width = 193
    Height = 129
    Caption = 'Ticket'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    object Label5: TLabel
      Left = 8
      Top = 20
      Width = 49
      Height = 13
      Caption = 'Acquistati:'
    end
    object Label6: TLabel
      Left = 8
      Top = 76
      Width = 38
      Height = 13
      Caption = 'Residui:'
    end
    object Label7: TLabel
      Left = 8
      Top = 104
      Width = 39
      Height = 13
      Caption = 'Scaduti:'
    end
    object Label8: TLabel
      Left = 8
      Top = 47
      Width = 49
      Height = 13
      Caption = 'Assegnati:'
    end
    object edtTicketAcq: TEdit
      Left = 76
      Top = 16
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object edtTicketRes: TEdit
      Left = 76
      Top = 72
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 1
      Text = '0'
    end
    object edtTicketScad: TEdit
      Left = 76
      Top = 100
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 2
      Text = '0'
    end
    object edtTicketAss: TEdit
      Left = 76
      Top = 43
      Width = 80
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 3
      Text = '0'
    end
  end
  object btnRiepilogoComplessivo: TBitBtn
    Left = 356
    Top = 8
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
    TabOrder = 4
    OnClick = btnRiepilogoComplessivoClick
  end
  object BitBtn2: TBitBtn
    Left = 356
    Top = 204
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 9
  end
  object btnRiepilogoFornitura: TBitBtn
    Left = 356
    Top = 39
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
    TabOrder = 6
    OnClick = btnRiepilogoComplessivoClick
  end
  object dcmbDataAcquisto: TDBLookupComboBox
    Left = 147
    Top = 40
    Width = 90
    Height = 21
    DropDownRows = 15
    KeyField = 'DATA_ACQUISTO'
    ListField = 'DATA_ACQUISTO'
    ListSource = A132FMagazzinoBuoniPastoDtM.dsrT691
    TabOrder = 5
  end
  object EAdata: TMaskEdit
    Left = 259
    Top = 9
    Width = 68
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
  end
  object btnAl: TButton
    Left = 328
    Top = 8
    Width = 15
    Height = 23
    Caption = '...'
    TabOrder = 3
    OnClick = btnAlClick
  end
end
