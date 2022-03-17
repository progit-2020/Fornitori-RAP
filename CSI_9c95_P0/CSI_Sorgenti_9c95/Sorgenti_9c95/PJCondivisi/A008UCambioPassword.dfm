object A008FCambioPassword: TA008FCambioPassword
  Left = 218
  Top = 233
  BorderStyle = bsDialog
  Caption = '<A008> Gestione sicurezza'
  ClientHeight = 160
  ClientWidth = 268
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
    Left = 8
    Top = 16
    Width = 84
    Height = 13
    Caption = 'Password attuale:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 52
    Width = 83
    Height = 13
    Caption = 'Nuova password:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 80
    Width = 96
    Height = 13
    Caption = 'Conferma password:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lblScadenza: TLabel
    Left = 198
    Top = 104
    Width = 58
    Height = 13
    Alignment = taRightJustify
    Caption = 'lblScadenza'
  end
  object edtPasswordOld: TEdit
    Left = 138
    Top = 12
    Width = 120
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object edtPasswordNew: TEdit
    Left = 138
    Top = 48
    Width = 120
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object edtPasswordConferma: TEdit
    Left = 138
    Top = 76
    Width = 120
    Height = 21
    PasswordChar = '*'
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 92
    Top = 129
    Width = 75
    Height = 25
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Left = 185
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Kind = bkAbort
    NumGlyphs = 2
    TabOrder = 4
  end
end
