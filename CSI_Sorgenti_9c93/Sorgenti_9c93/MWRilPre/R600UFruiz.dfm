object R600FFruiz: TR600FFruiz
  Left = 226
  Top = 175
  BorderStyle = bsDialog
  Caption = '<R600> Inizio del periodo di fruizione'
  ClientHeight = 204
  ClientWidth = 291
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
  object Panel1: TPanel
    Left = 0
    Top = 180
    Width = 291
    Height = 24
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkOK
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 61
    Width = 291
    Height = 119
    Align = alClient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 291
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object LNome: TLabel
      Left = 4
      Top = 4
      Width = 34
      Height = 13
      Caption = 'LNome'
    end
    object Causale: TLabel
      Left = 4
      Top = 24
      Width = 92
      Height = 13
      Caption = 'Causale da inserire:'
    end
    object Riferimento: TLabel
      Left = 4
      Top = 44
      Width = 103
      Height = 13
      Caption = 'Causale di riferimento:'
    end
  end
end
