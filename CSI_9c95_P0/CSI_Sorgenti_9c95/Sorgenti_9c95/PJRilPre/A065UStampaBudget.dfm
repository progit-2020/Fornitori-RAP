object A065FStampaBudget: TA065FStampaBudget
  Left = 0
  Top = 0
  HelpContext = 65000
  BorderStyle = bsSingle
  Caption = '<A065> Stampa situazione del budget'
  ClientHeight = 394
  ClientWidth = 577
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 577
    Height = 70
    Align = alTop
    TabOrder = 0
    object lblAnno: TLabel
      Left = 8
      Top = 9
      Width = 25
      Height = 13
      Caption = 'Anno'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblDaMese: TLabel
      Left = 72
      Top = 9
      Width = 42
      Height = 13
      Caption = 'Da mese'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblAMese: TLabel
      Left = 161
      Top = 9
      Width = 35
      Height = 13
      Caption = 'A mese'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblTipo: TLabel
      Left = 250
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
      Left = 321
      Top = 28
      Width = 56
      Height = 13
      Caption = 'lblDescTipo'
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
    object cmbDaMese: TComboBox
      Left = 72
      Top = 24
      Width = 78
      Height = 21
      Style = csDropDownList
      TabOrder = 1
      OnChange = cmbAMeseChange
      OnExit = cmbDaMeseExit
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
    object cmbAMese: TComboBox
      Left = 161
      Top = 24
      Width = 78
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = cmbAMeseChange
      OnExit = cmbDaMeseExit
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
    object dcmbTipo: TDBLookupComboBox
      Left = 250
      Top = 24
      Width = 65
      Height = 21
      DataField = 'CODICE'
      DataSource = A065FStampaBudgetDtM.dsrApp
      DropDownWidth = 500
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A065FStampaBudgetDtM.dsrT275
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 213
    Width = 577
    Height = 122
    Align = alBottom
    TabOrder = 2
    object chkDettaglioDipendenti: TCheckBox
      Left = 8
      Top = 70
      Width = 157
      Height = 17
      Caption = 'Dettaglio dipendenti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = chkDettaglioDipendentiClick
    end
    object chkSaltoPagina: TCheckBox
      Left = 8
      Top = 47
      Width = 157
      Height = 17
      Caption = 'Salto pagina'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chkTotMese: TCheckBox
      Left = 210
      Top = 70
      Width = 157
      Height = 17
      Caption = 'Totali mensili'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chkTotGruppo: TCheckBox
      Left = 8
      Top = 93
      Width = 157
      Height = 17
      Caption = 'Totali per gruppo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object chkCostoInMoneta: TCheckBox
      Left = 411
      Top = 70
      Width = 157
      Height = 17
      Caption = 'Calcolo del costo in moneta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object rgpTipoBudget: TRadioGroup
      Left = 8
      Top = 2
      Width = 398
      Height = 30
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Usa Budget manuale'
        'Usa Budget automatico')
      ParentFont = False
      TabOrder = 0
    end
    object chkTotGenerale: TCheckBox
      Left = 210
      Top = 93
      Width = 157
      Height = 17
      Caption = 'Totali generali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object chkAggiornaFruito: TCheckBox
      Left = 210
      Top = 47
      Width = 358
      Height = 17
      Caption = 'Aggiornamento del fruito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 70
    Width = 577
    Height = 143
    Align = alClient
    TabOrder = 1
    object clbGruppi: TCheckListBox
      Left = 1
      Top = 1
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
      PopupMenu = PopupMenu1
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 335
    Width = 577
    Height = 43
    Align = alBottom
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 100
      Height = 25
      Caption = 'Stampante...'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object btnAnteprima: TBitBtn
      Left = 161
      Top = 8
      Width = 100
      Height = 25
      Caption = '&Anteprima'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      TabOrder = 1
      OnClick = BStampaClick
    end
    object BStampa: TBitBtn
      Left = 314
      Top = 8
      Width = 100
      Height = 25
      Caption = 'Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00030777777777777770077777777777777000000000000000000F7F7F7F7F7F
        7F7007F7F7F7F7F7F9F00F7F7F7F7F7F7F700000000000000000FFF0FFFFFFFF
        0FFFFFF0F0000F0F0FFFFFF0FFFFFFFF0FFFFFF0F00F00000FFFFFF0FFFF0FF0
        FFFFFFF0F07F0F0FFFFFFFF0FFFF00FFFFFFFFF000000FFFFFFF}
      ParentFont = False
      TabOrder = 2
      OnClick = BStampaClick
    end
    object BitBtn3: TBitBtn
      Left = 468
      Top = 8
      Width = 100
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 3
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 378
    Width = 577
    Height = 16
    Align = alBottom
    TabOrder = 4
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 532
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 24
    Top = 82
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
  end
end
