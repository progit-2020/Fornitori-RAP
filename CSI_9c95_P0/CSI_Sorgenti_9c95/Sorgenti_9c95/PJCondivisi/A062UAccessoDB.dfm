object A062FAccessoDB: TA062FAccessoDB
  Left = 0
  Top = 0
  Caption = 'Accesso al DB'
  ClientHeight = 161
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblUserName: TLabel
    Left = 24
    Top = 30
    Width = 62
    Height = 13
    Caption = 'Nome utente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblPassWord: TLabel
    Left = 24
    Top = 73
    Width = 46
    Height = 13
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtUserName: TEdit
    Left = 96
    Top = 27
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object edtPassWord: TEdit
    Left = 96
    Top = 70
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnOk: TBitBtn
    Left = 24
    Top = 118
    Width = 75
    Height = 25
    Kind = bkOK
    TabOrder = 2
  end
  object btnAbort: TBitBtn
    Left = 142
    Top = 118
    Width = 75
    Height = 25
    Kind = bkAbort
    TabOrder = 3
  end
end
