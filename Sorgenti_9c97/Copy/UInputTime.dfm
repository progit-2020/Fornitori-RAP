object FInputTime: TFInputTime
  Left = 179
  Top = 142
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 77
  ClientWidth = 294
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblOre: TLabel
    Left = 13
    Top = 17
    Width = 21
    Height = 13
    Caption = 'Ore'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblMin: TLabel
    Left = 95
    Top = 17
    Width = 35
    Height = 13
    Caption = 'Minuti'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblSec: TLabel
    Left = 192
    Top = 17
    Width = 47
    Height = 13
    Caption = 'Secondi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpOre: TSpinEdit
    Left = 37
    Top = 12
    Width = 40
    Height = 22
    MaxLength = 2
    MaxValue = 23
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object BtnOk: TBitBtn
    Left = 67
    Top = 45
    Width = 75
    Height = 25
    Caption = '&OK'
    TabOrder = 3
    OnClick = BtnOkClick
    Kind = bkOK
  end
  object BtnCancel: TBitBtn
    Left = 152
    Top = 45
    Width = 75
    Height = 25
    Caption = '&Annulla'
    TabOrder = 4
    Kind = bkCancel
  end
  object SpMin: TSpinEdit
    Left = 133
    Top = 12
    Width = 40
    Height = 22
    MaxLength = 2
    MaxValue = 59
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object SpSec: TSpinEdit
    Left = 241
    Top = 12
    Width = 40
    Height = 22
    MaxLength = 2
    MaxValue = 59
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
end
