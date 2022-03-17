object P684FDataRif: TP684FDataRif
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = '<P684> Data riferimento'
  ClientHeight = 102
  ClientWidth = 220
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblDataRif: TLabel
    Left = 20
    Top = 22
    Width = 74
    Height = 13
    Caption = 'Data riferimento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 61
    Width = 220
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = -4
    ExplicitTop = 63
    object btnOK: TBitBtn
      Left = 20
      Top = 9
      Width = 75
      Height = 25
      DoubleBuffered = True
      Kind = bkOK
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = btnOKClick
    end
    object BitBtn2: TBitBtn
      Left = 119
      Top = 9
      Width = 75
      Height = 25
      DoubleBuffered = True
      Kind = bkCancel
      ParentDoubleBuffered = False
      TabOrder = 1
    end
  end
  object btnDataRif: TBitBtn
    Left = 177
    Top = 17
    Width = 15
    Height = 25
    Caption = '...'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnDataRifClick
  end
  object edtDataRif: TMaskEdit
    Left = 104
    Top = 19
    Width = 73
    Height = 21
    EditMask = '!00/00/0000;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
  end
end
