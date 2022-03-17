object A063FBudgetGenerazione: TA063FBudgetGenerazione
  Left = 321
  Top = 176
  HelpContext = 63000
  Caption = '<A063> Allineamento del budget'
  ClientHeight = 445
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 410
    Width = 575
    Height = 16
    Align = alBottom
    TabOrder = 4
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 426
    Width = 575
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 575
    Height = 70
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 9
      Width = 25
      Height = 13
      Caption = 'Anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblGruppi: TLabel
      Left = 8
      Top = 55
      Width = 34
      Height = 13
      Caption = 'Gruppi:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblTipo: TLabel
      Left = 314
      Top = 9
      Width = 21
      Height = 13
      Caption = 'Tipo'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblDescTipo: TLabel
      Left = 385
      Top = 28
      Width = 56
      Height = 13
      Caption = 'lblDescTipo'
    end
    object sedtAnno: TSpinEdit
      Left = 8
      Top = 24
      Width = 53
      Height = 22
      MaxLength = 4
      MaxValue = 9999
      MinValue = 0
      TabOrder = 0
      Value = 1900
      OnChange = sedtAnnoChange
      OnExit = sedtAnnoChange
    end
    object rgpOreImporti: TRadioGroup
      Left = 77
      Top = 10
      Width = 223
      Height = 36
      Caption = 'Intervento su'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 2
      Items.Strings = (
        'Ore'
        'Importi'
        'Entrambi')
      ParentFont = False
      TabOrder = 1
    end
    object dcmbTipo: TDBLookupComboBox
      Left = 314
      Top = 24
      Width = 65
      Height = 21
      DataField = 'CODICE'
      DataSource = dsrApp
      DropDownWidth = 500
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = dsrT275
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 367
    Width = 575
    Height = 43
    Align = alBottom
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 468
      Top = 9
      Width = 94
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnEsegui: TBitBtn
      Left = 8
      Top = 9
      Width = 94
      Height = 25
      Caption = '&Esegui'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 0
      OnClick = btnEseguiClick
    end
    object btnAnomalie: TBitBtn
      Left = 238
      Top = 9
      Width = 94
      Height = 25
      Caption = '&Anomalie'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnAnomalieClick
    end
  end
  object clbGruppi: TCheckListBox
    Left = 0
    Top = 70
    Width = 575
    Height = 141
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    PopupMenu = pmnFiltroDati
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 0
    Top = 211
    Width = 575
    Height = 156
    Align = alBottom
    TabOrder = 2
    object lblAlMeseBudget: TLabel
      Left = 169
      Top = 12
      Width = 56
      Height = 13
      Caption = 'fino al mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDuplicaSuAnno: TLabel
      Left = 103
      Top = 128
      Width = 41
      Height = 13
      Caption = 'sull'#39'anno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDalMeseFruito: TLabel
      Left = 107
      Top = 41
      Width = 42
      Height = 13
      Caption = 'dal mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAlMeseFruito: TLabel
      Left = 240
      Top = 41
      Width = 36
      Height = 13
      Caption = 'al mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblDalMeseResiduo: TLabel
      Left = 118
      Top = 70
      Width = 42
      Height = 13
      Caption = 'dal mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAlMeseResiduo: TLabel
      Left = 251
      Top = 70
      Width = 36
      Height = 13
      Caption = 'al mese'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblMesiSuccResiduo: TLabel
      Left = 380
      Top = 70
      Width = 97
      Height = 13
      Caption = 'sul mese successivo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object chkAssegnaBudget: TCheckBox
      Left = 8
      Top = 11
      Width = 160
      Height = 17
      Caption = 'Assegnazione budget mensile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkAssegnaBudgetClick
    end
    object chkCalcolaFruito: TCheckBox
      Left = 8
      Top = 40
      Width = 100
      Height = 17
      Caption = 'Calcolo del fruito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkAssegnaBudgetClick
    end
    object chkRiportaResiduo: TCheckBox
      Left = 8
      Top = 69
      Width = 110
      Height = 17
      Caption = 'Riporto del residuo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkAssegnaBudgetClick
    end
    object chkControlloFiltriAnagrafe: TCheckBox
      Left = 8
      Top = 98
      Width = 211
      Height = 17
      Caption = 'Controllo sovrapposizione filtri anagrafe'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = chkAssegnaBudgetClick
    end
    object chkDuplicaGruppi: TCheckBox
      Left = 8
      Top = 127
      Width = 93
      Height = 17
      Caption = 'Duplica i gruppi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = chkAssegnaBudgetClick
    end
    object sedtDuplicaSuAnno: TSpinEdit
      Left = 151
      Top = 125
      Width = 53
      Height = 22
      MaxLength = 4
      MaxValue = 9999
      MinValue = 0
      TabOrder = 9
      Value = 1900
    end
    object cmbDaMeseResiduo: TComboBox
      Left = 167
      Top = 67
      Width = 78
      Height = 21
      Style = csDropDownList
      TabOrder = 5
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object cmbAMeseResiduo: TComboBox
      Left = 295
      Top = 67
      Width = 78
      Height = 21
      Style = csDropDownList
      TabOrder = 6
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object cmbDaMeseFruito: TComboBox
      Left = 156
      Top = 38
      Width = 78
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object cmbAMeseFruito: TComboBox
      Left = 283
      Top = 38
      Width = 78
      Height = 21
      Style = csDropDownList
      TabOrder = 3
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
    object cmbAMeseBudget: TComboBox
      Left = 232
      Top = 9
      Width = 78
      Height = 21
      Style = csDropDownList
      TabOrder = 10
      Items.Strings = (
        'Gennaio'
        'Febbraio'
        'Marzo'
        'Aprile'
        'Maggio'
        'Giugno'
        'Luglio'
        'Agosto'
        'Settembre'
        'Ottobre'
        'Novembre'
        'Dicembre')
    end
  end
  object pmnFiltroDati: TPopupMenu
    Left = 510
    Top = 82
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
  end
  object dsrT275: TDataSource
    Left = 456
  end
  object dsrApp: TDataSource
    DataSet = cdsApp
    OnDataChange = dsrAppDataChange
    Left = 536
  end
  object cdsApp: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODICE'
        DataType = ftString
        Size = 5
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 496
  end
end
