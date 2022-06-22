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
    Height = 119
    Align = alTop
    TabOrder = 2
    object lblTipoIter: TLabel
      Left = 5
      Top = 29
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
    object lblCausale: TLabel
      Left = 5
      Top = 83
      Width = 41
      Height = 13
      Caption = 'Causale:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object rgpAllegato: TRadioGroup
      Left = 605
      Top = 6
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
      TabOrder = 0
      OnClick = rgpAllegatoClick
    end
    object rgpCondizAllegato: TRadioGroup
      Left = 605
      Top = 52
      Width = 290
      Height = 56
      Caption = 'Condizione allegato'
      Columns = 2
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
    object grpDataRichiesta: TGroupBox
      Left = 279
      Top = 6
      Width = 320
      Height = 48
      Caption = 'Data di inserimento della richiesta'
      TabOrder = 1
      inline frmInputDataRichiesta: TfrmInputPeriodo
        Left = 3
        Top = 13
        Width = 312
        Height = 28
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
        ExplicitLeft = 3
        ExplicitTop = 13
        ExplicitWidth = 312
        ExplicitHeight = 28
        inherited lblInizio: TLabel
          Top = 10
          ExplicitTop = 10
        end
        inherited lblFine: TLabel
          Left = 140
          Top = 10
          ExplicitLeft = 140
          ExplicitTop = 10
        end
        inherited edtInizio: TMaskEdit
          Top = 7
          OnExit = frmInputPeriodoedtInizioExit
          ExplicitTop = 7
        end
        inherited edtFine: TMaskEdit
          Left = 155
          Top = 7
          OnExit = frmInputPeriodoedtFineExit
          ExplicitLeft = 155
          ExplicitTop = 7
        end
        inherited btnIndietro: TBitBtn
          Left = 263
          Top = 6
          OnClick = frmInputPeriodobtnIndietroClick
          ExplicitLeft = 263
          ExplicitTop = 6
        end
        inherited btnAvanti: TBitBtn
          Left = 285
          Top = 6
          OnClick = frmInputPeriodobtnAvantiClick
          ExplicitLeft = 285
          ExplicitTop = 6
        end
        inherited btnDataInizio: TBitBtn
          Top = 6
          OnClick = frmInputPeriodobtnDataInizioClick
          ExplicitTop = 6
        end
        inherited btnDataFine: TBitBtn
          Left = 226
          Top = 6
          OnClick = frmInputPeriodobtnDataFineClick
          ExplicitLeft = 226
          ExplicitTop = 6
        end
      end
    end
    object grpPeriodo: TGroupBox
      Left = 279
      Top = 60
      Width = 320
      Height = 48
      Caption = 'Data dell'#39'elemento richiesto'
      TabOrder = 3
      inline frmInputPeriodoRichiesto: TfrmInputPeriodo
        AlignWithMargins = True
        Left = 3
        Top = 13
        Width = 312
        Height = 28
        Margins.Top = 0
        Margins.Bottom = 0
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
        ExplicitLeft = 3
        ExplicitTop = 13
        ExplicitWidth = 312
        ExplicitHeight = 28
        inherited lblInizio: TLabel
          Top = 10
          ExplicitTop = 10
        end
        inherited lblFine: TLabel
          Left = 140
          Top = 10
          ExplicitLeft = 140
          ExplicitTop = 10
        end
        inherited edtInizio: TMaskEdit
          Top = 7
          OnExit = frmInputPeriodoRichiestaedtInizioExit
          ExplicitTop = 7
        end
        inherited edtFine: TMaskEdit
          Left = 155
          Top = 7
          OnExit = frmInputPeriodoRichiestaedtFineExit
          ExplicitLeft = 155
          ExplicitTop = 7
        end
        inherited btnIndietro: TBitBtn
          Left = 263
          Top = 6
          OnClick = frmInputPeriodoRichiestobtnIndietroClick
          ExplicitLeft = 263
          ExplicitTop = 6
        end
        inherited btnAvanti: TBitBtn
          Left = 285
          Top = 6
          OnClick = frmInputPeriodoRichiestobtnAvantiClick
          ExplicitLeft = 285
          ExplicitTop = 6
        end
        inherited btnDataInizio: TBitBtn
          Top = 6
          OnClick = frmInputPeriodoRichiestobtnDataInizioClick
          ExplicitTop = 6
        end
        inherited btnDataFine: TBitBtn
          Left = 226
          Top = 6
          OnClick = frmInputPeriodoRichiestobtnDataFineClick
          ExplicitLeft = 226
          ExplicitTop = 6
        end
      end
    end
    object cmbTipoIter: TComboBox
      Left = 92
      Top = 26
      Width = 181
      Height = 21
      Style = csDropDownList
      DropDownCount = 10
      TabOrder = 4
      OnChange = cmbTipoIterChange
    end
    object dCmbFiltroCausale: TDBLookupComboBox
      Left = 90
      Top = 78
      Width = 183
      Height = 21
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListFieldIndex = 1
      NullValueKey = 46
      TabOrder = 5
      OnCloseUp = dCmbFiltroCausaleCloseUp
      OnKeyDown = dCmbFiltroCausaleKeyDown
    end
  end
  object dGrdIterAutorizzativi: TDBGrid [4]
    Left = 0
    Top = 177
    Width = 909
    Height = 243
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = ppInfoIter
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dGrdIterAutorizzativiEditButtonClick
  end
  inherited MainMenu1: TMainMenu [5]
  end
  inherited DButton: TDataSource [6]
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [7]
  end
  inherited ImageList1: TImageList [8]
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
    Left = 400
    Top = 184
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
