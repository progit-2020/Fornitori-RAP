object A164FAggGlobale: TA164FAggGlobale
  Left = 0
  Top = 0
  HelpContext = 164100
  Caption = '<A164> Aggiornamento massivo quote'
  ClientHeight = 236
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 487
    Height = 179
    Align = alClient
    TabOrder = 0
    object dTxtDescQuota: TDBText
      Left = 178
      Top = 48
      Width = 275
      Height = 13
      DataField = 'DESCRIZIONE'
      DataSource = A164FQuoteIncentiviDtM.dsrT765
    end
    object Label6: TLabel
      Left = 21
      Top = 48
      Width = 51
      Height = 13
      Caption = 'Tipo quota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object btnDecorrenza: TSpeedButton
      Left = 157
      Top = 13
      Width = 15
      Height = 21
      Caption = '...'
      NumGlyphs = 2
      OnClick = btnDecorrenzaClick
    end
    object Label3: TLabel
      Left = 21
      Top = 16
      Width = 55
      Height = 13
      Caption = 'Decorrenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblPercentuale: TLabel
      Left = 21
      Top = 127
      Width = 136
      Height = 13
      Caption = 'Percentuale di variazione (%)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblImporto: TLabel
      Left = 180
      Top = 127
      Width = 112
      Height = 13
      Caption = 'Importo di variazione ('#8364')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dcmbTipoQuota: TDBLookupComboBox
      Left = 81
      Top = 45
      Width = 91
      Height = 21
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE;TIPOQUOTA'
      ListSource = A164FQuoteIncentiviDtM.dsrT765
      TabOrder = 1
    end
    object edtPercentuale: TEdit
      Left = 21
      Top = 142
      Width = 76
      Height = 21
      TabOrder = 3
      OnChange = edtPercentualeChange
      OnExit = edtPercentualeExit
    end
    object edtDecorrenza: TMaskEdit
      Left = 81
      Top = 12
      Width = 75
      Height = 21
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnExit = edtDecorrenzaExit
    end
    object rgpVariazione: TRadioGroup
      Left = 21
      Top = 77
      Width = 256
      Height = 38
      Caption = 'Variazione'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Aumento (+)'
        'Diminuzione (-)')
      ParentFont = False
      TabOrder = 2
    end
    object edtImporto: TEdit
      Left = 180
      Top = 142
      Width = 76
      Height = 21
      TabOrder = 4
      OnChange = edtImportoChange
      OnExit = edtImportoExit
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 179
    Width = 487
    Height = 41
    Align = alBottom
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 348
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object btnEsegui: TBitBtn
      Left = 164
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Esegui'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
        8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
        3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
        FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
        FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
      TabOrder = 1
      OnClick = btnEseguiClick
    end
    object btnAnomalie: TBitBtn
      Left = 261
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Anomalie'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        04000000000068010000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333333333333333
        0000333333333933333333333333333833333333000033333BFB999BFB333333
        333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
        FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
        7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
        BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
        000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
        37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
        FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
        8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
        33333333333333FF733333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnAnomalieClick
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 220
    Width = 487
    Height = 16
    Align = alBottom
    TabOrder = 2
  end
end
