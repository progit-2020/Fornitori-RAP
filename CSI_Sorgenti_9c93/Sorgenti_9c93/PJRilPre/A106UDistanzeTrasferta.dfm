inherited A106FDistanzeTrasferta: TA106FDistanzeTrasferta
  HelpContext = 106000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A106> Distanze chilometriche'
  ClientHeight = 455
  ClientWidth = 657
  ExplicitWidth = 673
  ExplicitHeight = 513
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 437
    Width = 657
    ExplicitTop = 437
    ExplicitWidth = 657
  end
  inherited Panel1: TToolBar
    Width = 657
    TabOrder = 2
    ExplicitWidth = 657
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 657
    Height = 156
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 139
      Top = 16
      Width = 135
      Height = 13
      Caption = 'Descrizione localit'#224' partenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 139
      Top = 72
      Width = 120
      Height = 13
      Caption = 'Descrizione localit'#224' arrivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodice1: TLabel
      Left = 371
      Top = 16
      Width = 56
      Height = 13
      Caption = 'Codice Istat'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCap1: TLabel
      Left = 451
      Top = 16
      Width = 19
      Height = 13
      Caption = 'Cap'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblProv1: TLabel
      Left = 531
      Top = 16
      Width = 44
      Height = 13
      Caption = 'Provincia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lBlCodice2: TLabel
      Left = 371
      Top = 72
      Width = 56
      Height = 13
      Caption = 'Codice Istat'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCap2: TLabel
      Left = 451
      Top = 72
      Width = 19
      Height = 13
      Caption = 'Cap'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblProv2: TLabel
      Left = 531
      Top = 72
      Width = 44
      Height = 13
      Caption = 'Provincia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 481
      Top = 128
      Width = 45
      Height = 13
      Caption = 'Chilometri'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dCmbLocalita1: TDBLookupComboBox
      Left = 139
      Top = 32
      Width = 225
      Height = 21
      DataField = 'desc_localita1'
      DataSource = DButton
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      PopupMenu = PopupMenu1
      TabOrder = 1
    end
    object dCmbLocalita2: TDBLookupComboBox
      Left = 139
      Top = 88
      Width = 225
      Height = 21
      DataField = 'desc_localita2'
      DataSource = DButton
      KeyField = 'CODICE'
      ListField = 'DESCRIZIONE'
      PopupMenu = PopupMenu1
      TabOrder = 7
    end
    object dEdtCodice1: TDBEdit
      Left = 371
      Top = 32
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'LOCALITA1'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 3
    end
    object dEdtCap1: TDBEdit
      Left = 451
      Top = 32
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'desc_capcom1'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 4
    end
    object dEdtProv1: TDBEdit
      Left = 531
      Top = 32
      Width = 49
      Height = 21
      TabStop = False
      DataField = 'desc_prov1'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 5
    end
    object dEdtCodice2: TDBEdit
      Left = 371
      Top = 88
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'LOCALITA2'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 9
    end
    object dEdtCap2: TDBEdit
      Left = 451
      Top = 88
      Width = 73
      Height = 21
      TabStop = False
      DataField = 'desc_capcom2'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 10
    end
    object dEdtProv2: TDBEdit
      Left = 531
      Top = 88
      Width = 49
      Height = 21
      TabStop = False
      DataField = 'desc_prov2'
      DataSource = DButton
      ReadOnly = True
      TabOrder = 11
    end
    object dRgpTipo1: TDBRadioGroup
      Left = 9
      Top = 7
      Width = 123
      Height = 47
      Caption = 'Tipologia localit'#224
      DataField = 'TIPO1'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Comune (C)'
        'Personalizzata (P)')
      ParentFont = False
      TabOrder = 0
      Values.Strings = (
        'C'
        'P')
      OnChange = dRgpTipo1Change
    end
    object dRgpTipo2: TDBRadioGroup
      Left = 9
      Top = 63
      Width = 123
      Height = 47
      Caption = 'Tipologia localit'#224
      DataField = 'TIPO2'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Comune (C)'
        'Personalizzata (P)')
      ParentFont = False
      TabOrder = 6
      Values.Strings = (
        'C'
        'P')
      OnChange = dRgpTipo2Change
    end
    object dCmbComune1: TDBLookupComboBox
      Left = 139
      Top = 40
      Width = 225
      Height = 21
      DataField = 'desc_comune1'
      DataSource = DButton
      KeyField = 'CODICE'
      ListField = 'CITTA;PROVINCIA'
      TabOrder = 2
    end
    object dCmbComune2: TDBLookupComboBox
      Left = 139
      Top = 96
      Width = 225
      Height = 21
      DataField = 'desc_comune2'
      DataSource = DButton
      KeyField = 'CODICE'
      ListField = 'CITTA;PROVINCIA'
      TabOrder = 8
    end
    object DBEdit1: TDBEdit
      Left = 531
      Top = 125
      Width = 49
      Height = 21
      DataField = 'CHILOMETRI'
      DataSource = DButton
      TabOrder = 12
    end
    object btnCalcolaDistanze: TButton
      Left = 9
      Top = 125
      Width = 151
      Height = 25
      Action = actCalcolaDistanze
      TabOrder = 13
    end
    object btnConfermaKMAuto: TBitBtn
      Left = 169
      Top = 125
      Width = 89
      Height = 25
      Action = actConfermaCalcolaDistanze
      Caption = 'Conferma'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 14
    end
    object btnAnnullaKMAuto: TBitBtn
      Left = 267
      Top = 125
      Width = 89
      Height = 25
      Action = actAnnullaCalcolaDistanze
      Cancel = True
      Caption = 'Annulla'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 15
    end
  end
  object PnlDistanze: TPanel [3]
    Left = 0
    Top = 185
    Width = 657
    Height = 252
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object dGrdDistanze: TDBGrid
      Left = 0
      Top = 0
      Width = 657
      Height = 252
      TabStop = False
      Align = alClient
      DataSource = A106FDistanzeTrasfertaDTM.DSelM041B
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
      PopupMenu = pmnSelezione
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = dGrdDistanzeTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'TIPO1'
          Title.Caption = 'Tipo Part.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESC_PARTENZA'
          Title.Caption = 'Descrizione localit'#224' partenza'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 143
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOCALITA1'
          Title.Caption = 'Cod.Part.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO2'
          Title.Caption = 'Tipo Arr.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 48
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESC_DESTINAZIONE'
          Title.Caption = 'Descrizione localit'#224' arrivo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 127
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LOCALITA2'
          Title.Caption = 'Cod.Arr.'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHILOMETRI'
          Title.Caption = 'Chilometri'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KM_PROPOSTI'
          Title.Caption = 'Chilometri proposti'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 91
          Visible = True
        end>
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 384
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 412
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 440
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 468
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 496
    Top = 2
    object actCalcolaDistanze: TAction
      Caption = 'Calcolo automatico distanze'
      Hint = 'Calcola distanze'
      OnExecute = actCalcolaDistanzeExecute
    end
    object actConfermaCalcolaDistanze: TAction
      Caption = 'Conferma'
      OnExecute = actConfermaCalcolaDistanzeExecute
    end
    object actAnnullaCalcolaDistanze: TAction
      Caption = 'Annulla'
      OnExecute = actAnnullaCalcolaDistanzeExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 528
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
  object pmnSelezione: TPopupMenu
    Left = 150
    Top = 266
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Selezionatutto1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object mnuCopiaExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = mnuCopiaExcelClick
    end
  end
end
