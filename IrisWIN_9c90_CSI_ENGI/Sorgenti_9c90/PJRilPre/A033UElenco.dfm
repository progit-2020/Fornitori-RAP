object A033FElenco: TA033FElenco
  Left = 376
  Top = 257
  Caption = '<A033> Anomalie di 1'#176' livello'
  ClientHeight = 262
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 236
    Width = 231
    Height = 26
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      Kind = bkOK
      TabOrder = 0
    end
  end
  object Anomalie1: TCheckListBox
    Left = 0
    Top = 0
    Width = 239
    Height = 57
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object Anomalie2: TCheckListBox
    Left = 0
    Top = 64
    Width = 239
    Height = 57
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 2
  end
  object Anomalie3: TCheckListBox
    Left = 0
    Top = 128
    Width = 239
    Height = 57
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 3
  end
  object PopupMenu1: TPopupMenu
    Top = 188
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
  end
end
