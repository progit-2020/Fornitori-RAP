inherited A021FCausGiustif: TA021FCausGiustif
  Left = 267
  Top = 242
  HelpContext = 21000
  Caption = '<A021> Causali di giustificazione'
  ClientHeight = 296
  ClientWidth = 480
  OnShow = FormShow
  ExplicitWidth = 488
  ExplicitHeight = 350
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 278
    Width = 480
    ExplicitTop = 278
    ExplicitWidth = 480
  end
  inherited Panel1: TToolBar
    Width = 480
    ExplicitWidth = 480
  end
  object ScrollBox1: TScrollBox [2]
    Left = 0
    Top = 29
    Width = 480
    Height = 249
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label9: TLabel
      Left = 95
      Top = 78
      Width = 61
      Height = 13
      Caption = 'Voce paghe:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 159
      Top = 60
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fascia 1:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 213
      Top = 60
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fascia 2:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 267
      Top = 60
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fascia 3:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 321
      Top = 60
      Width = 43
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fascia 4:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 6
      Width = 36
      Height = 13
      Caption = 'Codice:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 98
      Top = 6
      Width = 58
      Height = 13
      Caption = 'Descrizione:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 70
      Top = 34
      Width = 85
      Height = 13
      Caption = 'Raggruppamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBText1: TDBText
      Left = 230
      Top = 34
      Width = 227
      Height = 17
      DataField = 'D_CodRaggr'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 95
      Top = 105
      Width = 87
      Height = 13
      Alignment = taRightJustify
      Caption = 'Sigla sul cartellino:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 95
      Top = 133
      Width = 102
      Height = 13
      Alignment = taRightJustify
      Caption = 'Assestamento annuo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 95
      Top = 160
      Width = 216
      Height = 13
      Caption = 'Considera sulla scheda riepilogativa dal mese:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit8: TDBEdit
      Left = 159
      Top = 76
      Width = 49
      Height = 21
      DataField = 'VocePaghe1'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnChange = EHMaxUnitarioChange
    end
    object DBEdit10: TDBEdit
      Left = 213
      Top = 76
      Width = 49
      Height = 21
      DataField = 'VocePaghe2'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = EHMaxUnitarioChange
    end
    object DBEdit12: TDBEdit
      Left = 267
      Top = 76
      Width = 49
      Height = 21
      DataField = 'VocePaghe3'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = EHMaxUnitarioChange
    end
    object DBEdit14: TDBEdit
      Left = 321
      Top = 76
      Width = 49
      Height = 21
      DataField = 'VocePaghe4'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnChange = EHMaxUnitarioChange
    end
    object DBEdit1: TDBEdit
      Left = 44
      Top = 4
      Width = 43
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 158
      Top = 4
      Width = 311
      Height = 21
      DataField = 'Descrizione'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 158
      Top = 30
      Width = 67
      Height = 21
      DataField = 'CodRaggr'
      DataSource = DButton
      DropDownWidth = 200
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'Codice'
      ListField = 'Codice;Descrizione'
      ListSource = A021FCausGiustifDtM1.D300
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 2
      OnKeyDown = DBLookupComboBox1KeyDown
    end
    object ESigla: TDBEdit
      Left = 348
      Top = 102
      Width = 23
      Height = 21
      DataField = 'SIGLA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object DBEdit3: TDBEdit
      Left = 268
      Top = 131
      Width = 103
      Height = 21
      Color = cl3DLight
      DataField = 'ASSEST_ANNUO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object btnAssestAnnuo: TButton
      Left = 371
      Top = 131
      Width = 17
      Height = 22
      Caption = '...'
      TabOrder = 9
      OnClick = btnAssestAnnuoClick
    end
    object DBCheckBox1: TDBCheckBox
      Left = 95
      Top = 183
      Width = 276
      Height = 17
      Alignment = taLeftJustify
      Caption = 'L'#39'assestamento negativo abbatte il liquidabile'
      DataField = 'ABBATTE_ECC_GIORN'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 12
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dcbxInclusioneLimiteLiq: TDBCheckBox
      Left = 95
      Top = 199
      Width = 276
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Inclusione nei limiti del liquidabile'
      DataField = 'LIMITE_LIQ'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object dChkBancaNegativa: TDBCheckBox
      Left = 95
      Top = 215
      Width = 276
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Consente di rendere negativa la banca ore'
      DataField = 'BANCAORE_NEGATIVA'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 14
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
    object DBEdit4: TDBEdit
      Left = 322
      Top = 157
      Width = 49
      Height = 21
      DataField = 'DATA_MIN_ASSEST'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 10
      OnChange = EHMaxUnitarioChange
    end
    object btnDataMinAssest: TButton
      Left = 371
      Top = 157
      Width = 17
      Height = 22
      Caption = '...'
      TabOrder = 11
      OnClick = btnDataMinAssestClick
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 358
    Top = 52
  end
  inherited DButton: TDataSource
    Left = 414
    Top = 52
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 386
    Top = 52
  end
  object PopupMenu1: TPopupMenu
    Left = 442
    Top = 52
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
