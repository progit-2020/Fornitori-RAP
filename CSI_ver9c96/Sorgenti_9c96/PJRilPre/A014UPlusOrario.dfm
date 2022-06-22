inherited A014FPlusOrario: TA014FPlusOrario
  Left = 244
  Top = 291
  HelpContext = 14000
  Caption = '<A014> Debiti aggiuntivi'
  ClientHeight = 262
  ClientWidth = 462
  ExplicitWidth = 470
  ExplicitHeight = 308
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 244
    Width = 462
    ExplicitTop = 244
    ExplicitWidth = 462
  end
  inherited Panel1: TToolBar
    Width = 462
    ExplicitWidth = 462
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 462
    Height = 73
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 10
      Width = 28
      Height = 13
      Caption = 'Anno:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 98
      Top = 10
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
    object DBText1: TDBText
      Left = 213
      Top = 10
      Width = 243
      Height = 17
      DataField = 'D_Codice'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 42
      Top = 7
      Width = 49
      Height = 21
      DataField = 'Anno'
      DataSource = DButton
      TabOrder = 0
    end
    object DBRadioGroup2: TDBRadioGroup
      Left = 12
      Top = 30
      Width = 173
      Height = 35
      Caption = 'Debito '
      Columns = 2
      DataField = 'TipoDebito'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Items.Strings = (
        'Mensile'
        'Settimanale')
      ParentFont = False
      TabOrder = 1
      Values.Strings = (
        'M'
        'S')
    end
    object DBCheckBox1: TDBCheckBox
      Left = 194
      Top = 42
      Width = 215
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Utilizza differenza dal debito contrattuale'
      DataField = 'TipoPO'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ValueChecked = '2'
      ValueUnchecked = '0'
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 136
      Top = 7
      Width = 73
      Height = 21
      DataField = 'Codice'
      DataSource = DButton
      DropDownWidth = 300
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A014FPlusOrarioDtM1.D060
      PopupMenu = PopupMenu1
      TabOrder = 3
      OnKeyDown = DBLookupComboBox1KeyDown
    end
  end
  object Panel3: TPanel [3]
    Left = 0
    Top = 102
    Width = 462
    Height = 142
    Align = alClient
    TabOrder = 3
    object Label4: TLabel
      Left = 104
      Top = 8
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Gennaio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 162
      Top = 8
      Width = 41
      Height = 13
      Alignment = taRightJustify
      Caption = 'Febbraio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 220
      Top = 8
      Width = 29
      Height = 13
      Alignment = taRightJustify
      Caption = 'Marzo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 278
      Top = 8
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = 'Aprile'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label8: TLabel
      Left = 336
      Top = 8
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Maggio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 394
      Top = 8
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'Giugno'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 104
      Top = 60
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Luglio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 162
      Top = 60
      Width = 33
      Height = 13
      Alignment = taRightJustify
      Caption = 'Agosto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 220
      Top = 60
      Width = 48
      Height = 13
      Alignment = taRightJustify
      Caption = 'Settembre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 278
      Top = 60
      Width = 35
      Height = 13
      Alignment = taRightJustify
      Caption = 'Ottobre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 336
      Top = 60
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Novembre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 394
      Top = 60
      Width = 45
      Height = 13
      Alignment = taRightJustify
      Caption = 'Dicembre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 14
      Top = 26
      Width = 86
      Height = 13
      Alignment = taRightJustify
      Caption = 'Debito aggiuntivo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label17: TLabel
      Left = 14
      Top = 78
      Width = 86
      Height = 13
      Alignment = taRightJustify
      Caption = 'Debito aggiuntivo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 15
      Top = 48
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Caption = 'Gestione anticipo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label19: TLabel
      Left = 15
      Top = 100
      Width = 85
      Height = 13
      Alignment = taRightJustify
      Caption = 'Gestione anticipo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object DBEdit4: TDBEdit
      Left = 104
      Top = 22
      Width = 45
      Height = 21
      DataField = 'Ore1'
      DataSource = DButton
      TabOrder = 0
    end
    object DBEdit5: TDBEdit
      Left = 162
      Top = 22
      Width = 45
      Height = 21
      DataField = 'Ore2'
      DataSource = DButton
      TabOrder = 2
    end
    object DBEdit6: TDBEdit
      Left = 220
      Top = 22
      Width = 45
      Height = 21
      DataField = 'Ore3'
      DataSource = DButton
      TabOrder = 4
    end
    object DBEdit7: TDBEdit
      Left = 278
      Top = 22
      Width = 45
      Height = 21
      DataField = 'Ore4'
      DataSource = DButton
      TabOrder = 6
    end
    object DBEdit8: TDBEdit
      Left = 336
      Top = 22
      Width = 45
      Height = 21
      DataField = 'Ore5'
      DataSource = DButton
      TabOrder = 8
    end
    object DBEdit9: TDBEdit
      Left = 394
      Top = 22
      Width = 45
      Height = 21
      DataField = 'Ore6'
      DataSource = DButton
      TabOrder = 10
    end
    object DBEdit10: TDBEdit
      Left = 104
      Top = 74
      Width = 45
      Height = 21
      DataField = 'Ore7'
      DataSource = DButton
      TabOrder = 12
    end
    object DBEdit11: TDBEdit
      Left = 162
      Top = 74
      Width = 45
      Height = 21
      DataField = 'Ore8'
      DataSource = DButton
      TabOrder = 14
    end
    object DBEdit12: TDBEdit
      Left = 220
      Top = 74
      Width = 45
      Height = 21
      DataField = 'Ore9'
      DataSource = DButton
      TabOrder = 16
    end
    object DBEdit13: TDBEdit
      Left = 278
      Top = 74
      Width = 45
      Height = 21
      DataField = 'Ore10'
      DataSource = DButton
      TabOrder = 18
    end
    object DBEdit14: TDBEdit
      Left = 336
      Top = 74
      Width = 45
      Height = 21
      DataField = 'Ore11'
      DataSource = DButton
      TabOrder = 20
    end
    object DBEdit15: TDBEdit
      Left = 394
      Top = 74
      Width = 45
      Height = 21
      DataField = 'Ore12'
      DataSource = DButton
      TabOrder = 22
    end
    object DBCheckBox2: TDBCheckBox
      Left = 134
      Top = 46
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '          '
      DataField = 'TipoGest1'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox3: TDBCheckBox
      Left = 192
      Top = 46
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest2'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox4: TDBCheckBox
      Left = 250
      Top = 46
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest3'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox5: TDBCheckBox
      Left = 308
      Top = 46
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest4'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox6: TDBCheckBox
      Left = 366
      Top = 46
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest5'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox7: TDBCheckBox
      Left = 424
      Top = 46
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest6'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 11
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox8: TDBCheckBox
      Left = 134
      Top = 98
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest7'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox9: TDBCheckBox
      Left = 192
      Top = 98
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest8'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 15
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox10: TDBCheckBox
      Left = 250
      Top = 98
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest9'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox11: TDBCheckBox
      Left = 308
      Top = 98
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest10'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox12: TDBCheckBox
      Left = 366
      Top = 98
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest11'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 21
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
    object DBCheckBox13: TDBCheckBox
      Left = 424
      Top = 98
      Width = 15
      Height = 17
      Alignment = taLeftJustify
      Caption = '           '
      DataField = 'TipoGest12'
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 23
      ValueChecked = '1'
      ValueUnchecked = '0'
      Visible = False
    end
  end
  inherited MainMenu1: TMainMenu
    Top = 96
  end
  inherited DButton: TDataSource
    Top = 96
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Top = 96
  end
  inherited ImageList1: TImageList
    Left = 316
  end
  inherited ActionList1: TActionList
    Left = 344
  end
  object PopupMenu1: TPopupMenu
    Left = 380
    Top = 24
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
