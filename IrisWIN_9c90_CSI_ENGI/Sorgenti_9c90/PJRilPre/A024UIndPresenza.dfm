inherited A024FIndPresenza: TA024FIndPresenza
  Left = 408
  Top = 270
  HelpContext = 24000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A024> Indennit'#224' di presenza'
  ClientHeight = 302
  ClientWidth = 437
  ExplicitWidth = 453
  ExplicitHeight = 360
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 284
    Width = 437
    ExplicitTop = 284
    ExplicitWidth = 437
  end
  inherited Panel1: TToolBar
    Width = 437
    ExplicitWidth = 437
  end
  object ScrollBox1: TScrollBox [2]
    Left = 0
    Top = 29
    Width = 437
    Height = 48
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Align = alTop
    BorderStyle = bsNone
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 36
      Height = 13
      Caption = 'Codice:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 76
      Top = 6
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 6
      Top = 20
      Width = 60
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 76
      Top = 20
      Width = 357
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      TabOrder = 1
    end
  end
  object DBGrid1: TDBGrid [3]
    Left = 0
    Top = 77
    Width = 437
    Height = 207
    Align = alClient
    DataSource = A024FIndPresenzaDtM1.D160
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  inherited MainMenu1: TMainMenu
    Left = 310
    Top = 68
    inherited File1: TMenuItem
      object Regoleindennit1: TMenuItem [2]
        Caption = 'Regole indennit'#224
        OnClick = Nuovoelemento1Click
      end
    end
  end
  inherited DButton: TDataSource
    Left = 366
    Top = 68
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 338
    Top = 68
  end
  object PopupMenu1: TPopupMenu
    Left = 156
    Top = 136
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
