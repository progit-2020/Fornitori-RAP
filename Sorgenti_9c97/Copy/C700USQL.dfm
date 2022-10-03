object C700FSQL: TC700FSQL
  Left = 479
  Top = 289
  Caption = 'SQL Generato'
  ClientHeight = 208
  ClientWidth = 370
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
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 370
    Height = 183
    Align = alClient
    Color = clAqua
    Lines.Strings = (
      '')
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 183
    Width = 370
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
