object A029FRecuperiMobili: TA029FRecuperiMobili
  Left = 428
  Top = 229
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A029> Riepilogo saldi mobili'
  ClientHeight = 216
  ClientWidth = 335
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
  object GroupBox2: TGroupBox
    Left = 0
    Top = 53
    Width = 335
    Height = 163
    Align = alClient
    Caption = 'Eccedenze non recuperate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object grdRecuperiMobili: TStringGrid
      Left = 2
      Top = 15
      Width = 331
      Height = 146
      Align = alClient
      ColCount = 2
      DefaultColWidth = 100
      DefaultRowHeight = 18
      FixedCols = 0
      RowCount = 2
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 335
    Height = 53
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblCarenze: TLabel
      Left = 6
      Top = 36
      Width = 161
      Height = 14
      Caption = 'Carenze non recuperate '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object lblSaldo: TLabel
      Left = 6
      Top = 4
      Width = 140
      Height = 14
      Caption = 'Saldo di riferimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
    object lblSaldoAttuale: TLabel
      Left = 6
      Top = 20
      Width = 140
      Height = 14
      Caption = 'Saldo di riferimento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
    end
  end
end
