inherited P552FEsportazioneFile: TP552FEsportazioneFile
  HelpContext = 3552300
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<P552> Esportazione su file'
  ClientHeight = 303
  ClientWidth = 632
  OnShow = FormShow
  ExplicitWidth = 640
  ExplicitHeight = 349
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 285
    Width = 632
    ExplicitTop = 285
    ExplicitWidth = 632
  end
  inherited Panel1: TToolBar
    Width = 632
    ExplicitWidth = 632
  end
  object Panel3: TPanel [2]
    Left = 0
    Top = 29
    Width = 632
    Height = 41
    Align = alTop
    TabOrder = 2
    object lblAnno: TLabel
      Left = 5
      Top = 11
      Width = 31
      Height = 13
      Caption = 'Anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object lblTabella: TLabel
      Left = 188
      Top = 8
      Width = 433
      Height = 26
      AutoSize = False
      Caption = 'lblTabella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
    end
    object lblCodTabella: TLabel
      Left = 83
      Top = 11
      Width = 41
      Height = 13
      Caption = 'Tabella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object edtTabella: TEdit
      Left = 125
      Top = 8
      Width = 57
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 'edtTabella'
    end
    object edtAnno: TEdit
      Left = 36
      Top = 8
      Width = 42
      Height = 21
      TabStop = False
      Color = clInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsItalic]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = 'edtAnno'
    end
  end
  object Panel2: TPanel [3]
    Left = 0
    Top = 70
    Width = 632
    Height = 215
    Align = alClient
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 14
      Width = 57
      Height = 13
      Caption = 'Num.campo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 11
      Top = 64
      Width = 55
      Height = 13
      Caption = 'Descrizione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 88
      Top = 14
      Width = 56
      Height = 13
      Caption = 'Tipo campo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 11
      Top = 110
      Width = 38
      Height = 13
      Caption = 'Formato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 242
      Top = 110
      Width = 52
      Height = 13
      Caption = 'Lunghezza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 11
      Top = 153
      Width = 37
      Height = 13
      Caption = 'Formula'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dtxtLungProg: TDBText
      Left = 311
      Top = 128
      Width = 81
      Height = 17
      Alignment = taCenter
      DataField = 'LungProg'
      DataSource = DButton
    end
    object lblLungProg: TLabel
      Left = 310
      Top = 110
      Width = 81
      Height = 13
      Caption = 'Lung.progressiva'
    end
    object edtNumCampo: TSpinEdit
      Left = 11
      Top = 29
      Width = 57
      Height = 22
      MaxValue = 999
      MinValue = 1
      TabOrder = 6
      Value = 1
    end
    object dedtDescrizione: TDBEdit
      Left = 11
      Top = 80
      Width = 608
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
    object dedtLunghezza: TDBEdit
      Left = 242
      Top = 124
      Width = 53
      Height = 21
      DataField = 'LUNGHEZZA'
      DataSource = DButton
      TabOrder = 3
    end
    object dedtFormula: TDBEdit
      Left = 11
      Top = 167
      Width = 591
      Height = 21
      DataField = 'FORMULA'
      DataSource = DButton
      TabOrder = 4
    end
    object cmbFormato: TComboBox
      Left = 11
      Top = 124
      Width = 214
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        'N     - Numerico intero'
        'NV2 - Numerico con 2 cifre decimali'
        'NV3 - Numerico con 3 cifre decimali'
        'X     - Alfanumerico')
    end
    object cmbTipoCampo: TComboBox
      Left = 88
      Top = 29
      Width = 531
      Height = 22
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
      OnChange = cmbTipoCampoChange
      Items.Strings = (
        'N - Numerico'
        'X - Alfanumerico')
    end
    object btnFormula: TBitBtn
      Left = 602
      Top = 165
      Width = 17
      Height = 25
      Hint = 'Somma colonne'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnFormulaClick
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 408
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 436
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 464
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 492
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 520
    Top = 2
  end
end
