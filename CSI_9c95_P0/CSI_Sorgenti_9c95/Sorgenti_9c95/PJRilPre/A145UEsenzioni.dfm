inherited A145FEsenzioni: TA145FEsenzioni
  HelpContext = 145100
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A145> Gestione esenzioni'
  ClientHeight = 554
  ClientWidth = 792
  ExplicitWidth = 808
  ExplicitHeight = 612
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 536
    Width = 792
    ExplicitTop = 536
    ExplicitWidth = 792
  end
  inherited Panel1: TToolBar
    Width = 792
    ExplicitWidth = 792
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 477
    Width = 792
    Height = 59
    Align = alBottom
    TabOrder = 2
    object rgpFiltro: TRadioGroup
      Left = 10
      Top = 0
      Width = 575
      Height = 52
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Dipendenti non esentati o esentati nel giorno'
        'Entrambi'
        'Dipendenti esentati nei giorni precedenti'
        'Cancellazioni non esentate o esentate nel giorno')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpFiltroClick
    end
    object BitBtn1: TBitBtn
      Left = 688
      Top = 18
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object dGrdEsenzioni: TDBGrid [3]
    Left = 0
    Top = 29
    Width = 792
    Height = 448
    Align = alClient
    DataSource = DButton
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu3
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'MATRICOLA'
        ReadOnly = True
        Title.Caption = 'Matr.'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COGNOME'
        ReadOnly = True
        Title.Caption = 'Cognome'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        ReadOnly = True
        Title.Caption = 'Nome'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAINIZIOASSENZA'
        ReadOnly = True
        Title.Caption = 'Inizio'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAFINEASSENZA'
        ReadOnly = True
        Title.Caption = 'Fine'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUOVADATAFINE'
        ReadOnly = True
        Title.Caption = 'Nuova fine'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMUNE'
        ReadOnly = True
        Title.Caption = 'Comune'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPOESENZIONE'
        PickList.Strings = (
          'Generica'
          'Terapia salvavita')
        Title.Caption = 'Tipo esenzione'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAESENZIONE'
        ReadOnly = True
        Title.Caption = 'Data esen.'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OPERATORE'
        ReadOnly = True
        Title.Caption = 'Operatore'
        Width = 80
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu
    Left = 392
    Top = 65534
  end
  inherited DButton: TDataSource
    Left = 420
    Top = 65534
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
    Top = 65534
  end
  inherited ImageList1: TImageList
    Left = 476
    Top = 65534
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 65534
    inherited actInserisci: TAction
      Enabled = False
      Visible = False
    end
    inherited actCancella: TAction
      Enabled = False
      Visible = False
    end
    inherited actStampa: TAction
      Enabled = False
      Visible = False
    end
    inherited actGomma: TAction
      Enabled = False
      Visible = False
    end
    inherited actRefresh: TAction
      Enabled = False
      Visible = False
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 120
    Top = 277
    object Visualizzadettagliodipendente1: TMenuItem
      Caption = 'Visualizza dettaglio dipendente'
      OnClick = Visualizzadettagliodipendente1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Deselezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
    object MenuItem2: TMenuItem
      Caption = '-'
    end
    object Copia2: TMenuItem
      Caption = 'Copia'
      OnClick = Copia2Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
end
