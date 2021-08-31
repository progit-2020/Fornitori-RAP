object B014FCopiaSchedulazione: TB014FCopiaSchedulazione
  Left = 354
  Top = 283
  Width = 265
  Height = 144
  Caption = '<B014> Copia schedulazione'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 80
    Height = 13
    Caption = 'Ripeti ogni minuti'
  end
  object Label2: TLabel
    Left = 40
    Top = 48
    Width = 39
    Height = 13
    Caption = 'Fino alle'
  end
  object edtIntervallo: TEdit
    Left = 152
    Top = 14
    Width = 37
    Height = 21
    TabOrder = 0
    Text = '60'
  end
  object edtTermine: TEdit
    Left = 152
    Top = 46
    Width = 37
    Height = 21
    TabOrder = 1
    Text = '23.59'
  end
  object BitBtn1: TBitBtn
    Left = 36
    Top = 78
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 132
    Top = 78
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
end
