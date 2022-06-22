object A056FGrigliaCicli: TA056FGrigliaCicli
  Left = 163
  Top = 84
  Caption = '<A056> Sviluppo turnazione'
  ClientHeight = 293
  ClientWidth = 363
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 363
    Height = 265
    Align = alClient
    DefaultRowHeight = 18
    TabOrder = 0
    OnDblClick = StringGrid1DblClick
    ExplicitWidth = 371
    ExplicitHeight = 276
  end
  object Panel1: TPanel
    Left = 0
    Top = 265
    Width = 363
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 276
    ExplicitWidth = 371
    object BitBtn1: TBitBtn
      Left = 2
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 82
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
