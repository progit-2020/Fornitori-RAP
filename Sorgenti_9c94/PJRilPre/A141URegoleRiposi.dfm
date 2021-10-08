inherited A141FRegoleRiposi: TA141FRegoleRiposi
  HelpContext = 141000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A141> Regole inserimento riposi'
  ClientHeight = 467
  ClientWidth = 609
  OnShow = FormShow
  ExplicitWidth = 617
  ExplicitHeight = 521
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 341
    Top = 29
    Height = 420
    ExplicitHeight = 373
  end
  inherited StatusBar: TStatusBar
    Top = 449
    Width = 609
    ExplicitTop = 449
    ExplicitWidth = 609
  end
  inherited Panel1: TToolBar
    Width = 609
    ExplicitWidth = 609
  end
  object Panel2: TPanel [3]
    Left = 344
    Top = 29
    Width = 265
    Height = 420
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 206
      Width = 263
      Height = 213
      Align = alClient
      TabOrder = 2
      object lstAssenze: TCheckListBox
        Left = 1
        Top = 1
        Width = 261
        Height = 211
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        PopupMenu = PopupMenu2
        TabOrder = 0
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 23
      Width = 263
      Height = 161
      Align = alTop
      TabOrder = 0
      object lstPresenze: TCheckListBox
        Left = 1
        Top = 1
        Width = 261
        Height = 159
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        PopupMenu = PopupMenu2
        TabOrder = 0
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 263
      Height = 22
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 2
        Width = 204
        Height = 13
        Caption = 'Ins. su gg. con timbrature causalizzate con:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 184
      Width = 263
      Height = 22
      Align = alTop
      TabOrder = 3
      object Label2: TLabel
        Left = 7
        Top = 5
        Width = 138
        Height = 13
        Caption = 'No ins. su gg. giustificati con:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object Panel5: TPanel [4]
    Left = 0
    Top = 29
    Width = 341
    Height = 420
    Align = alLeft
    TabOrder = 3
    object lblRiposo: TLabel
      Left = 10
      Top = 131
      Width = 33
      Height = 13
      Caption = 'Riposo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRipComp: TLabel
      Left = 10
      Top = 153
      Width = 65
      Height = 13
      Caption = 'Riposo comp.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSel1: TLabel
      Left = 178
      Top = 131
      Width = 153
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object LblSel2: TLabel
      Left = 178
      Top = 153
      Width = 153
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRipMesePrec: TLabel
      Left = 10
      Top = 176
      Width = 88
      Height = 13
      Caption = 'Riposo mese prec.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSel3: TLabel
      Left = 178
      Top = 176
      Width = 153
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCodice: TLabel
      Left = 10
      Top = 3
      Width = 33
      Height = 13
      Caption = 'Codice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 10
      Top = 39
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
    object lblInterfaccia: TLabel
      Left = 109
      Top = 21
      Width = 221
      Height = 13
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dCmbCodice: TDBLookupComboBox
      Left = 10
      Top = 16
      Width = 95
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE; DESCRIZIONE'
      ListSource = A141FRegoleRiposiDtM.dsrInterfaccia
      TabOrder = 0
      OnCloseUp = dCmbCodiceCloseUp
      OnKeyDown = dCmbCodiceKeyDown
      OnKeyUp = dCmbCodiceKeyUp
    end
    object DBEdit1: TDBEdit
      Left = 10
      Top = 52
      Width = 321
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
    object dCmbCausale1: TDBLookupComboBox
      Left = 103
      Top = 126
      Width = 70
      Height = 21
      DataField = 'RIPOSO_ORDINARIO'
      DataSource = DButton
      DropDownWidth = 400
      KeyField = 'T265CODICE'
      ListField = 'T265CODICE;T265DESCRIZIONE'
      ListSource = A141FRegoleRiposiDtM.DCausale1
      PopupMenu = PopupMenu1
      TabOrder = 4
      OnCloseUp = dCmbCausale1CloseUp
      OnKeyDown = dCmbCodiceKeyDown
      OnKeyUp = dCmbCausale1KeyUp
    end
    object dCmbCausale2: TDBLookupComboBox
      Left = 103
      Top = 149
      Width = 70
      Height = 21
      DataField = 'RIPOSO_COMPENSATIVO'
      DataSource = DButton
      DropDownWidth = 400
      KeyField = 'T265CODICE'
      ListField = 'T265CODICE;T265DESCRIZIONE'
      ListSource = A141FRegoleRiposiDtM.DCausale2
      PopupMenu = PopupMenu1
      TabOrder = 5
      OnCloseUp = dCmbCausale2CloseUp
      OnKeyDown = dCmbCodiceKeyDown
      OnKeyUp = dCmbCausale2KeyUp
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 330
      Width = 321
      Height = 53
      Caption = 'Parametri di inserimento per giorni gi'#224' giustificati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      object dChkDomenica: TDBCheckBox
        Left = 8
        Top = 16
        Width = 73
        Height = 17
        Caption = 'Domenica'
        DataField = 'DOMENICA_GIUSTIFICATA'
        DataSource = DButton
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dChkGGNonLav: TDBCheckBox
        Left = 85
        Top = 16
        Width = 118
        Height = 17
        Caption = 'Giorni non lavorativi'
        DataField = 'GGNONLAV_GIUSTIFICATO'
        DataSource = DButton
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dChkGGFest: TDBCheckBox
        Left = 209
        Top = 16
        Width = 108
        Height = 17
        Caption = 'Giorni festivi'
        DataField = 'GGFEST_GIUSTIFICATO'
        DataSource = DButton
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dChkGGCalend: TDBCheckBox
        Left = 8
        Top = 33
        Width = 273
        Height = 17
        Caption = 'Solo se significativo su tutti i giorni di calendario'
        DataField = 'GGCALEND_GIUSTIFICATO'
        DataSource = DButton
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
    end
    object GroupBox3: TGroupBox
      Left = 10
      Top = 229
      Width = 321
      Height = 98
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      object lblRiposoLavorato: TLabel
        Left = 10
        Top = 75
        Width = 74
        Height = 13
        Caption = 'Riposo lavorato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblSelRiposoLavorato: TLabel
        Left = 164
        Top = 75
        Width = 152
        Height = 13
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dChkPersNonTurnista: TDBCheckBox
        Left = 9
        Top = 8
        Width = 196
        Height = 17
        Caption = 'Ins. su personale non turnista'
        DataField = 'PERSONALE_NON_TURNISTA'
        DataSource = DButton
        TabOrder = 0
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dChkPersNonTurnistaClick
      end
      object dChkGGNonLavTimbr: TDBCheckBox
        Left = 9
        Top = 23
        Width = 308
        Height = 17
        Caption = 'Ins. su gg. non lav.con timbr.non caus. (pers.non turnista)'
        DataField = 'GGNONLAV_CON_TIMBRATURE'
        DataSource = DButton
        TabOrder = 1
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dChkPersNonTurnistaClick
      end
      object dChkNoReperibilita: TDBCheckBox
        Left = 9
        Top = 38
        Width = 216
        Height = 17
        Caption = 'Ins. su gg. vuoti senza pianif. reperibilit'#224
        DataField = 'SOLO_SE_NON_REPERIBILE'
        DataSource = DButton
        TabOrder = 2
        ValueChecked = 'S'
        ValueUnchecked = 'N'
      end
      object dChkLimiteSaldo: TDBCheckBox
        Left = 9
        Top = 53
        Width = 224
        Height = 17
        Caption = 'Ins. rip.comp. limitato dal saldo negativo'
        DataField = 'LIMITE_SALDO'
        DataSource = DButton
        TabOrder = 3
        ValueChecked = 'S'
        ValueUnchecked = 'N'
        OnClick = dChkLimiteSaldoClick
      end
      object dcmbRiposoLavorato: TDBLookupComboBox
        Left = 93
        Top = 71
        Width = 70
        Height = 21
        DataField = 'RIPOSO_LAVORATO'
        DataSource = DButton
        DropDownWidth = 400
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        KeyField = 'T265CODICE'
        ListField = 'T265CODICE;T265DESCRIZIONE'
        ListSource = A141FRegoleRiposiDtM.DCausale4
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 4
        OnCloseUp = dcmbRiposoLavoratoCloseUp
        OnKeyDown = dCmbCodiceKeyDown
        OnKeyUp = dcmbRiposoLavoratoKeyUp
      end
    end
    object dCmbCausale3: TDBLookupComboBox
      Left = 103
      Top = 172
      Width = 70
      Height = 21
      DataField = 'RIPOSO_MESEPREC'
      DataSource = DButton
      DropDownWidth = 400
      KeyField = 'T265CODICE'
      ListField = 'T265CODICE;T265DESCRIZIONE'
      ListSource = A141FRegoleRiposiDtM.DCausale3
      PopupMenu = PopupMenu1
      TabOrder = 6
      OnCloseUp = dCmbCausale3CloseUp
      OnKeyDown = dCmbCodiceKeyDown
      OnKeyUp = dCmbCausale3KeyUp
    end
    object drdgTipo: TDBRadioGroup
      Left = 10
      Top = 75
      Width = 321
      Height = 31
      Caption = 'Tipo'
      Columns = 3
      DataField = 'TIPO_CAUSALE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Riposi'
        'Festivit'#224
        'Festivi infrasett.')
      ParentBackground = True
      ParentFont = False
      TabOrder = 2
      Values.Strings = (
        'R'
        'F'
        'I')
      OnClick = drdgTipoClick
    end
    object dChkPulizia: TDBCheckBox
      Left = 10
      Top = 109
      Width = 132
      Height = 17
      Caption = 'Pulisci giustif. esistenti'
      DataField = 'CANCELLAZIONE_CAUSALE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object drdgSmontoNotte: TDBRadioGroup
      Left = 10
      Top = 197
      Width = 321
      Height = 31
      Caption = 'Ins. su smonto notte'
      Columns = 3
      DataField = 'SMONTO_NOTTE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'No'
        'Si'
        'Esclusivo')
      ParentBackground = True
      ParentFont = False
      TabOrder = 7
      Values.Strings = (
        'N'
        'S'
        'E')
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 392
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 420
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 476
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 2
  end
  object PopupMenu2: TPopupMenu
    Left = 316
    Top = 50
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Selezionatutto1Click
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 46
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
