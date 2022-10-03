inherited A069FBudgetEsterno: TA069FBudgetEsterno
  HelpContext = 69001
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A069> Budget esterno annuo'
  ClientHeight = 509
  ClientWidth = 825
  ExplicitWidth = 833
  ExplicitHeight = 555
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 491
    Width = 825
    ExplicitTop = 491
    ExplicitWidth = 825
  end
  inherited Panel1: TToolBar
    Width = 825
    ExplicitWidth = 825
  end
  object pnlTop: TPanel [2]
    Left = 0
    Top = 29
    Width = 825
    Height = 27
    Align = alTop
    TabOrder = 2
    object lblAnno: TLabel
      Left = 55
      Top = 6
      Width = 118
      Height = 13
      Caption = 'Mese/Anno di riferimento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnAcquisisci: TSpeedButton
      Left = 256
      Top = 2
      Width = 137
      Height = 22
      Action = actAcquisisciDati
    end
    object btnVerifica: TSpeedButton
      Left = 400
      Top = 2
      Width = 104
      Height = 22
      Caption = 'Verifica disponibilit'#224
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = btnVerificaClick
    end
    object SpeedButton1: TSpeedButton
      Left = 512
      Top = 2
      Width = 104
      Height = 22
      Action = actRegistraLiquidazioni
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object pnlAnagrafe: TPanel
      Left = 0
      Top = 2
      Width = 48
      Height = 23
      BevelOuter = bvNone
      TabOrder = 0
      inline frmSelAnagrafe: TfrmSelAnagrafe
        Left = 0
        Top = 0
        Width = 48
        Height = 29
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 48
        inherited pnlSelAnagrafe: TPanel
          Width = 48
          ExplicitWidth = 48
          inherited btnSelezione: TBitBtn
            OnClick = frmSelAnagrafebtnSelezioneClick
          end
          inherited btnRicerca: TBitBtn
            Width = 16
            ExplicitWidth = 16
          end
        end
      end
    end
    object edtData: TMaskEdit
      Left = 176
      Top = 3
      Width = 53
      Height = 21
      EditMask = '!00/0000;1;_'
      MaxLength = 7
      TabOrder = 1
      Text = '  /    '
      OnChange = edtDataChange
    end
  end
  object dGrdT710: TDBGrid [3]
    Left = 0
    Top = 56
    Width = 825
    Height = 435
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs]
    ParentFont = False
    PopupMenu = popMnu1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = dGrdT710DrawColumnCell
  end
  inherited MainMenu1: TMainMenu
    Left = 245
    Top = 90
  end
  inherited DButton: TDataSource
    AutoEdit = True
    Left = 273
    Top = 90
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 301
    Top = 90
  end
  inherited ImageList1: TImageList
    Left = 329
    Top = 90
  end
  inherited ActionList1: TActionList
    Left = 357
    Top = 90
    inherited actCancella: TAction
      Visible = False
    end
    object actRegistraLiquidazioni: TAction
      Caption = 'Registra liquidazioni'
      Hint = 'Registra liquidazioni'
      OnExecute = actRegistraLiquidazioniExecute
    end
    object actAcquisisciDati: TAction
      Caption = 'Acquisisci dati dal bilancio'
      Hint = 'Acquisisci dati dal bilancio'
      OnExecute = actAcquisisciDatiExecute
    end
  end
  object popMnu1: TPopupMenu
    Left = 175
    Top = 84
    object Copia1: TMenuItem
      Caption = 'Copia'
      OnClick = CopiainExcel1Click
    end
    object CopiainExcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiainExcel1Click
    end
  end
end
