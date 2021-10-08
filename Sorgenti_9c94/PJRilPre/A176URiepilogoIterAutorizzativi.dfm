inherited A176FRiepilogoIterAutorizzativi: TA176FRiepilogoIterAutorizzativi
  Tag = 214
  HelpContext = 176000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A176> Riepilogo iter autorizzativi'
  ClientHeight = 438
  ClientWidth = 909
  ExplicitWidth = 925
  ExplicitHeight = 497
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 420
    Width = 909
    ExplicitTop = 420
    ExplicitWidth = 909
  end
  inherited Panel1: TToolBar
    Top = 29
    Width = 909
    ExplicitTop = 29
    ExplicitWidth = 909
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 909
    Height = 29
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 909
    inherited pnlSelAnagrafe: TPanel
      Width = 909
      ExplicitWidth = 909
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
  end
  object pnlFiltri: TPanel [3]
    Left = 0
    Top = 58
    Width = 909
    Height = 81
    Align = alTop
    TabOrder = 3
    object lblTipoIter: TLabel
      Left = 3
      Top = 12
      Width = 80
      Height = 13
      Caption = 'Iter autorizzativo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object rgpAllegato: TRadioGroup
      Left = 3
      Top = 35
      Width = 290
      Height = 40
      Caption = 'Allegato'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Tutti'
        'Con allegato'
        'Senza allegato')
      ParentFont = False
      TabOrder = 1
      OnClick = rgpAllegatoClick
    end
    object rgpCondizAllegato: TRadioGroup
      Left = 299
      Top = 35
      Width = 506
      Height = 40
      Caption = 'Condizione allegato'
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Tutti'
        'Allegati non previsti'
        'Allegati facoltativi'
        'Allegati obbligatori')
      ParentFont = False
      TabOrder = 2
      OnClick = rgpCondizAllegatoClick
    end
    inline frmInputPeriodo: TfrmInputPeriodo
      Left = 300
      Top = 2
      Width = 345
      Height = 29
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 300
      ExplicitTop = 2
      ExplicitWidth = 345
      ExplicitHeight = 29
      inherited lblInizio: TLabel
        Top = 10
        ExplicitTop = 10
      end
      inherited lblFine: TLabel
        Top = 10
        ExplicitTop = 10
      end
      inherited edtInizio: TMaskEdit
        Top = 7
        OnExit = frmInputPeriodoedtInizioExit
        ExplicitTop = 7
      end
      inherited edtFine: TMaskEdit
        Top = 7
        OnExit = frmInputPeriodoedtFineExit
        ExplicitTop = 7
      end
      inherited btnIndietro: TBitBtn
        Top = 6
        OnClick = frmInputPeriodobtnIndietroClick
        ExplicitTop = 6
      end
      inherited btnAvanti: TBitBtn
        Top = 6
        OnClick = frmInputPeriodobtnAvantiClick
        ExplicitTop = 6
      end
      inherited btnDataInizio: TBitBtn
        Top = 6
        OnClick = frmInputPeriodobtnDataInizioClick
        ExplicitTop = 6
      end
      inherited btnDataFine: TBitBtn
        Top = 6
        OnClick = frmInputPeriodobtnDataFineClick
        ExplicitTop = 6
      end
    end
  end
  object dGrdIterAutorizzativi: TDBGrid [4]
    Left = 0
    Top = 139
    Width = 909
    Height = 281
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = ppInfoIter
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dGrdIterAutorizzativiEditButtonClick
  end
  object cmbTipoIter: TComboBox [5]
    Left = 89
    Top = 62
    Width = 181
    Height = 21
    Style = csDropDownList
    DropDownCount = 10
    TabOrder = 2
    OnChange = cmbTipoIterChange
  end
  inherited MainMenu1: TMainMenu [6]
  end
  inherited DButton: TDataSource [7]
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [8]
  end
  inherited ImageList1: TImageList [9]
  end
  inherited ActionList1: TActionList
    inherited actInserisci: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    inherited actCancella: TAction
      Visible = False
    end
    inherited actConferma: TAction
      Visible = False
    end
    inherited actAnnulla: TAction
      Visible = False
    end
    inherited actCopiaSu: TAction
      Visible = False
    end
    inherited actGomma: TAction
      Visible = False
    end
  end
  object ppInfoIter: TPopupMenu
    Left = 408
    Top = 168
    object Inforichiesta1: TMenuItem
      Caption = 'Info richiesta'
      OnClick = Inforichiesta1Click
    end
    object Gestionerichiesta1: TMenuItem
      Caption = 'Gestione richiesta'
      OnClick = Gestionerichiesta1Click
    end
  end
end
