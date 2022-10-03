object Ac01FPropIndRendiProj: TAc01FPropIndRendiProj
  Left = 0
  Top = 0
  Caption = '<Ac01> Propriet'#224' individuali'
  ClientHeight = 281
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dlblDipendente: TDBText
    Left = 31
    Top = 90
    Width = 71
    Height = 13
    AutoSize = True
    DataField = 'DIPENDENTE'
  end
  object lblDipendente: TLabel
    Left = 31
    Top = 71
    Width = 55
    Height = 13
    Caption = 'Dipendente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblProgetto: TLabel
    Left = 31
    Top = 21
    Width = 42
    Height = 13
    Caption = 'Progetto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblServizio: TLabel
    Left = 32
    Top = 121
    Width = 37
    Height = 13
    Caption = 'Servizio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblFunzione: TLabel
    Left = 31
    Top = 171
    Width = 43
    Height = 13
    Caption = 'Funzione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dlblProgetto: TDBText
    Left = 32
    Top = 40
    Width = 58
    Height = 13
    AutoSize = True
    DataField = 'PROGETTO'
  end
  object dedtServizio: TDBEdit
    Left = 32
    Top = 140
    Width = 481
    Height = 21
    DataField = 'SERVIZIO'
    TabOrder = 0
  end
  object dedtFunzione: TDBEdit
    Left = 31
    Top = 190
    Width = 481
    Height = 21
    DataField = 'FUNZIONE'
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 181
    Top = 233
    Width = 75
    Height = 25
    HelpContext = 200
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 289
    Top = 233
    Width = 75
    Height = 25
    HelpContext = 200
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 3
    OnClick = BitBtn2Click
  end
end
