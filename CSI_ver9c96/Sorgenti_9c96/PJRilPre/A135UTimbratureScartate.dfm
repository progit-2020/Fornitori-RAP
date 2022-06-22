inherited A135FTimbratureScartate: TA135FTimbratureScartate
  Height = 546
  HelpContext = 135000
  Caption = '<A135> Timbrature scartate'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 276
    Width = 544
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  inherited StatusBar: TStatusBar
    Top = 474
  end
  inherited Panel1: TToolBar
    Top = 24
  end
  object gpbTimbratureScartate: TGroupBox [3]
    Left = 0
    Top = 81
    Width = 544
    Height = 195
    Align = alTop
    Caption = 'Timbrature Scartate'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object dgrdTimbratureScartate: TDBGrid
      Left = 2
      Top = 15
      Width = 540
      Height = 178
      Align = alClient
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object gpbTimbraturePresenza: TGroupBox [4]
    Left = 0
    Top = 279
    Width = 544
    Height = 195
    Align = alClient
    Caption = 'Timbrature di Presenza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object dgrdTimbraturePresenza: TDBGrid
      Left = 2
      Top = 15
      Width = 540
      Height = 178
      Align = alClient
      DataSource = A135FTimbratureScartateDtM.D100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object pnlIntestazione: TPanel [5]
    Left = 0
    Top = 53
    Width = 544
    Height = 28
    Align = alTop
    TabOrder = 4
    object lblMese: TLabel
      Left = 32
      Top = 5
      Width = 29
      Height = 13
      Caption = 'Mese:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblAnno: TLabel
      Left = 112
      Top = 5
      Width = 28
      Height = 13
      Caption = 'Anno:'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object sedtMese: TSpinEdit
      Left = 64
      Top = 0
      Width = 41
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 0
      OnChange = MeseAnnoChange
    end
    object sedtAnno: TSpinEdit
      Left = 144
      Top = 0
      Width = 49
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = MeseAnnoChange
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [6]
    Left = 0
    Top = 0
    Width = 544
    Height = 24
    Align = alTop
    TabOrder = 5
    TabStop = True
    inherited pnlSelAnagrafe: TPanel
      Width = 544
    end
  end
  inherited MainMenu1: TMainMenu [7]
    Left = 400
    Top = 2
  end
  inherited DButton: TDataSource [8]
    Left = 428
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [9]
    Left = 456
    Top = 2
  end
  inherited ImageList1: TImageList [10]
    Left = 484
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 512
    Top = 2
  end
end
