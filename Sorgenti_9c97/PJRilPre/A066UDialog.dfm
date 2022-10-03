object A066FDialog: TA066FDialog
  Left = 218
  Top = 129
  HelpContext = 66000
  BorderStyle = bsDialog
  Caption = '<A066> Stampa monetizzazione ore'
  ClientHeight = 136
  ClientWidth = 273
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 4
    Width = 43
    Height = 13
    Caption = 'Da livello'
  end
  object Label2: TLabel
    Left = 136
    Top = 4
    Width = 36
    Height = 13
    Caption = 'A livello'
  end
  object Label3: TLabel
    Left = 12
    Top = 48
    Width = 38
    Height = 13
    Caption = 'Da data'
  end
  object Label4: TLabel
    Left = 136
    Top = 48
    Width = 31
    Height = 13
    Caption = 'A data'
  end
  object DaLiv: TComboBox
    Left = 12
    Top = 20
    Width = 117
    Height = 21
    TabOrder = 0
  end
  object ALiv: TComboBox
    Left = 136
    Top = 20
    Width = 117
    Height = 21
    TabOrder = 1
  end
  object DaData: TMaskEdit
    Left = 12
    Top = 64
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
  end
  object AData: TMaskEdit
    Left = 136
    Top = 64
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 3
    Text = '  /  /    '
  end
  object BitBtn1: TBitBtn
    Left = 12
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Stampante...'
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 96
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Stampa'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 180
    Top = 96
    Width = 75
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 6
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 88
    Top = 68
  end
end
