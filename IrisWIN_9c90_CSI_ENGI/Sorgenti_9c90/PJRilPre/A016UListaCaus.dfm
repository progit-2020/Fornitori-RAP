object A016FListaCaus: TA016FListaCaus
  Left = 337
  Top = 21
  BorderStyle = bsDialog
  Caption = 'Causali disponibili'
  ClientHeight = 359
  ClientWidth = 179
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Lista: TCheckListBox
    Left = 0
    Top = 0
    Width = 179
    Height = 334
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 334
    Width = 179
    Height = 25
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 80
      Top = 0
      Width = 75
      Height = 25
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
