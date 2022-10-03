inherited A111FParMessaggi: TA111FParMessaggi
  Left = 314
  Top = 159
  HelpContext = 111000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A111> Parametrizzazione interfacce messaggi'
  ClientHeight = 464
  ClientWidth = 632
  ExplicitWidth = 648
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 446
    Width = 632
    ExplicitTop = 446
    ExplicitWidth = 632
  end
  inherited Panel1: TToolBar
    Width = 632
    TabOrder = 3
    ExplicitWidth = 632
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 196
    Height = 417
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object sbtNomeFile: TSpeedButton
      Left = 179
      Top = 100
      Width = 14
      Height = 22
      Caption = '...'
      OnClick = sbtNomeFileClick
    end
    object Label1: TLabel
      Left = 2
      Top = 0
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
    object Label2: TLabel
      Left = 60
      Top = 0
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
      Left = 2
      Top = 88
      Width = 80
      Height = 13
      Caption = 'Nome file/tabella'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 2
      Top = 125
      Width = 174
      Height = 13
      Caption = 'Formato della data per il nome del file'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblProva: TLabel
      Left = 117
      Top = 141
      Width = 3
      Height = 13
    end
    object lblNumeroRipetiz: TLabel
      Left = 2
      Top = 233
      Width = 94
      Height = 13
      Caption = 'Numero di ripetizioni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblNumeroGiorniValid: TLabel
      Left = 2
      Top = 255
      Width = 116
      Height = 13
      Caption = 'Num.giorni validit'#224' mess.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMesiIndietro: TLabel
      Left = 2
      Top = 279
      Width = 112
      Height = 13
      Caption = 'Num.mesi indietro cons.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblFiltroAnagr: TLabel
      Left = 2
      Top = 358
      Width = 22
      Height = 13
      Caption = 'Filtro'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblValiditaDati: TLabel
      Left = 2
      Top = 302
      Width = 119
      Height = 13
      Caption = 'Num.mesi validit'#224' dei dati'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dEdtCodice: TDBEdit
      Left = 2
      Top = 13
      Width = 57
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object dEdtDescrizione: TDBEdit
      Left = 60
      Top = 13
      Width = 133
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
    object dRgpTipoSupporto: TDBRadioGroup
      Left = 2
      Top = 52
      Width = 191
      Height = 32
      Caption = 'Tipo di supporto'
      Columns = 2
      DataField = 'TIPO_FILE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'File ASCII'
        'Tab.ORACLE')
      ParentFont = False
      TabOrder = 3
      TabStop = True
      Values.Strings = (
        'A'
        'O')
      OnChange = dRgpTipoSupportoChange
    end
    object dEdtNome: TDBEdit
      Left = 2
      Top = 101
      Width = 177
      Height = 21
      DataField = 'NOME_FILE'
      DataSource = DButton
      TabOrder = 4
    end
    object dCmbFormatoData: TDBComboBox
      Left = 2
      Top = 138
      Width = 103
      Height = 21
      DataField = 'DATA_FILE'
      DataSource = DButton
      Items.Strings = (
        'mmyy'
        'mmmyy'
        'mmmmyy'
        'mmyyyy'
        'mmmyyyy'
        'mmmmyyyy'
        'yymm'
        'yymmm'
        'yymmmm'
        'yyyymm'
        'yyyymmm'
        'yyyymmmm')
      TabOrder = 5
      OnChange = dCmbFormatoDataChange
    end
    object dChkDefault: TDBCheckBox
      Left = 2
      Top = 35
      Width = 151
      Height = 17
      Caption = 'Usato nella funzione batch'
      DataField = 'DEFAULT_FILE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object edtNumeroRipetiz: TSpinEdit
      Left = 129
      Top = 228
      Width = 63
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 8
      Value = 0
    end
    object edtNumeroGiorniValid: TSpinEdit
      Left = 129
      Top = 251
      Width = 63
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 9
      Value = 0
    end
    object edtMesiIndietro: TSpinEdit
      Left = 129
      Top = 274
      Width = 63
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 10
      Value = 0
    end
    object dCmbFiltroAnagr: TDBLookupComboBox
      Left = 30
      Top = 353
      Width = 163
      Height = 21
      DataField = 'FILTRO_ANAGR'
      DataSource = DButton
      KeyField = 'NOME'
      ListField = 'NOME'
      PopupMenu = PopupMenu1
      TabOrder = 13
      OnKeyDown = dCmbFiltroAnagrKeyDown
    end
    inline frmSelAnagrafe: TfrmSelAnagrafe
      Left = 0
      Top = 0
      Width = 196
      Height = 24
      Align = alTop
      TabOrder = 14
      TabStop = True
      ExplicitWidth = 196
      ExplicitHeight = 24
      inherited pnlSelAnagrafe: TPanel
        Width = 196
        Height = 24
        ExplicitWidth = 196
        ExplicitHeight = 24
        inherited btnSelezione: TBitBtn
          Left = 2
          Width = 22
          Height = 23
          OnClick = frmSelAnagrafebtnSelezioneClick
          ExplicitLeft = 2
          ExplicitWidth = 22
          ExplicitHeight = 23
        end
      end
    end
    object dgrpTipoFiltro: TDBRadioGroup
      Left = 2
      Top = 318
      Width = 191
      Height = 33
      Caption = 'Tipo filtro'
      Columns = 2
      DataField = 'TIPO_FILTRO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Anagrafico'
        'Libero')
      ParentFont = False
      TabOrder = 12
      Values.Strings = (
        '0'
        '1')
      OnChange = dgrpTipoFiltroChange
    end
    object drgpTipoRegistrazione: TDBRadioGroup
      Left = 2
      Top = 160
      Width = 191
      Height = 33
      Caption = 'Tipo registrazione'
      Columns = 2
      DataField = 'TIPO_REGISTRAZIONE'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Ricrea'
        'Accoda')
      ParentFont = False
      TabOrder = 6
      Values.Strings = (
        'R'
        'A')
      OnChange = dgrpTipoFiltroChange
    end
    object drgpRegistraMessaggi: TDBRadioGroup
      Left = 2
      Top = 193
      Width = 191
      Height = 33
      Caption = 'Registra messaggi'
      Columns = 3
      DataField = 'REGISTRA_MSG'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Si'
        'No'
        'Pulisci')
      ParentFont = False
      TabOrder = 7
      Values.Strings = (
        'S'
        'N'
        'P')
      OnChange = dgrpTipoFiltroChange
    end
    object edtValiditaDati: TSpinEdit
      Left = 129
      Top = 297
      Width = 63
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 11
      Value = 0
    end
  end
  object GpbTracciato: TGroupBox [3]
    Left = 196
    Top = 29
    Width = 436
    Height = 417
    Align = alClient
    Caption = 'Mappatura dei dati sul file di output'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object dGrdTracciato: TDBGrid
      Left = 2
      Top = 15
      Width = 432
      Height = 400
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CODICE'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TIPO_RECORD'
          PickList.Strings = (
            'IN'
            'DF'
            'DV')
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NUMERO_RECORD'
          Width = 40
          Visible = True
        end
        item
          DropDownRows = 12
          Expanded = False
          FieldName = 'TIPO'
          PickList.Strings = (
            'AN DATO ANAGRAFICO'
            'BA BADGE'
            'DE DESCRIZIONE'
            'DC DATA CONSUNTIVO'
            'DT DATA MESSAGGIO'
            'DS DATA SCADENZA'
            'FI FILLER'
            'IN INDIRIZZO OROLOGIO'
            'NR NUMERO RIPETIZIONI'
            'PT POSTAZIONE OROLOGIO'
            'VL VALORE')
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'POSIZIONE'
          Width = 40
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOME_COLONNA'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'LUNGHEZZA'
          Width = 40
          Visible = True
        end
        item
          DropDownRows = 15
          Expanded = False
          FieldName = 'VALORE_DEFAULT'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FORMATO'
          Width = 90
          Visible = True
        end
        item
          DropDownRows = 15
          Expanded = False
          FieldName = 'CODICE_DATO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CHIAVE'
          PickList.Strings = (
            'S'
            'N')
          Visible = True
        end>
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 448
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 476
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 504
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 532
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 560
    Top = 2
  end
  object SaveDialog1: TSaveDialog
    Left = 416
    Top = 2
  end
  object PopupMenu1: TPopupMenu
    Left = 158
    Top = 353
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
