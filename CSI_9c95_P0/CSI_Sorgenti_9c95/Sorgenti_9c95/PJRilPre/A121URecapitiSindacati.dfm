inherited A121FRecapitiSindacati: TA121FRecapitiSindacati
  Left = 13
  Top = 201
  HelpContext = 121100
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A121> Recapiti sindacati'
  ClientHeight = 372
  ClientWidth = 599
  ExplicitWidth = 615
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 354
    Width = 599
    ExplicitTop = 354
    ExplicitWidth = 599
  end
  inherited grbDecorrenza: TGroupBox
    Width = 599
    ExplicitWidth = 599
    inherited dedtDecorrenza: TDBEdit
      DataField = 'DECORRENZA'
    end
  end
  inherited ToolBar1: TToolBar
    Width = 599
    TabOrder = 0
    ExplicitWidth = 599
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 63
    Width = 599
    Height = 291
    Align = alClient
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 4
      Width = 33
      Height = 13
      Caption = 'Codice'
      FocusControl = dEdtCodice
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 189
      Top = 4
      Width = 62
      Height = 13
      Caption = 'Tipo recapito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 273
      Top = 4
      Width = 25
      Height = 13
      Caption = 'Prog.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label16: TLabel
      Left = 328
      Top = 4
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
    object dEdtCodice: TDBEdit
      Left = 8
      Top = 18
      Width = 134
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 159
      Width = 597
      Height = 131
      Align = alBottom
      TabOrder = 5
      object Label10: TLabel
        Left = 8
        Top = 11
        Width = 45
        Height = 13
        Caption = 'Cognome'
        FocusControl = dEdtCognome
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 8
        Top = 50
        Width = 28
        Height = 13
        Caption = 'Nome'
        FocusControl = dEdtNome
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 7
        Top = 89
        Width = 29
        Height = 13
        Caption = 'E-Mail'
        FocusControl = dEdtEMail
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 388
        Top = 90
        Width = 40
        Height = 13
        Caption = 'Cellulare'
        FocusControl = dEdtCellulare
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 388
        Top = 50
        Width = 73
        Height = 13
        Caption = 'Telefono ufficio'
        FocusControl = dEdtTelUfficio
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 388
        Top = 11
        Width = 79
        Height = 13
        Caption = 'Telefono di casa'
        FocusControl = dEdtTelCasa
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dEdtCognome: TDBEdit
        Left = 8
        Top = 25
        Width = 360
        Height = 21
        DataField = 'COGNOME'
        DataSource = DButton
        TabOrder = 0
      end
      object dEdtNome: TDBEdit
        Left = 8
        Top = 64
        Width = 360
        Height = 21
        DataField = 'NOME'
        DataSource = DButton
        TabOrder = 1
      end
      object dEdtEMail: TDBEdit
        Left = 7
        Top = 103
        Width = 360
        Height = 21
        DataField = 'EMAIL'
        DataSource = DButton
        TabOrder = 2
      end
      object dEdtCellulare: TDBEdit
        Left = 388
        Top = 104
        Width = 199
        Height = 21
        DataField = 'CELLULARE'
        DataSource = DButton
        TabOrder = 5
      end
      object dEdtTelUfficio: TDBEdit
        Left = 388
        Top = 64
        Width = 199
        Height = 21
        DataField = 'TELEFONO_UFFICIO'
        DataSource = DButton
        TabOrder = 4
      end
      object dEdtTelCasa: TDBEdit
        Left = 388
        Top = 25
        Width = 199
        Height = 21
        DataField = 'TELEFONO_CASA'
        DataSource = DButton
        TabOrder = 3
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 68
      Width = 597
      Height = 91
      Align = alBottom
      TabOrder = 4
      object Label5: TLabel
        Left = 8
        Top = 12
        Width = 38
        Height = 13
        Caption = 'Indirizzo'
        FocusControl = dEdtIndirizzo
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 273
        Top = 50
        Width = 21
        Height = 13
        Caption = 'CAP'
        FocusControl = dEdtCap
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 9
        Top = 50
        Width = 39
        Height = 13
        Caption = 'Comune'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 388
        Top = 12
        Width = 42
        Height = 13
        Caption = 'Telefono'
        FocusControl = dEdtTelefono
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 388
        Top = 50
        Width = 17
        Height = 13
        Caption = 'Fax'
        FocusControl = dEdtFax
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 329
        Top = 50
        Width = 25
        Height = 13
        Caption = 'Prov.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dEdtIndirizzo: TDBEdit
        Left = 8
        Top = 26
        Width = 360
        Height = 21
        DataField = 'INDIRIZZO'
        DataSource = DButton
        TabOrder = 0
      end
      object dEdtCap: TDBEdit
        Left = 273
        Top = 64
        Width = 49
        Height = 21
        DataField = 'CAP'
        DataSource = DButton
        TabOrder = 3
      end
      object dEdtTelefono: TDBEdit
        Left = 388
        Top = 26
        Width = 199
        Height = 21
        DataField = 'TELEFONO'
        DataSource = DButton
        TabOrder = 5
      end
      object dEdtFax: TDBEdit
        Left = 388
        Top = 64
        Width = 199
        Height = 21
        DataField = 'FAX'
        DataSource = DButton
        TabOrder = 6
      end
      object dEdtIstat: TDBEdit
        Left = 222
        Top = 64
        Width = 46
        Height = 21
        DataField = 'COMUNE'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 2
      end
      object dEdtProvincia: TDBEdit
        Left = 329
        Top = 64
        Width = 39
        Height = 21
        DataField = 'Provincia'
        DataSource = DButton
        ReadOnly = True
        TabOrder = 4
      end
      object dCmbComune: TDBLookupComboBox
        Left = 8
        Top = 64
        Width = 209
        Height = 21
        DataField = 'COMUNE'
        DataSource = DButton
        DropDownWidth = 300
        KeyField = 'CODICE'
        ListField = 'CITTA; PROVINCIA'
        PopupMenu = pmnNew
        TabOrder = 1
        OnKeyDown = dCmbComuneKeyDown
      end
    end
    object edtProgressivo: TSpinEdit
      Left = 273
      Top = 18
      Width = 39
      Height = 22
      MaxValue = 10
      MinValue = 1
      TabOrder = 2
      Value = 1
    end
    object dCmbTipo: TDBComboBox
      Left = 189
      Top = 18
      Width = 80
      Height = 21
      Style = csOwnerDrawFixed
      DataField = 'TIPO_RECAPITO'
      DataSource = DButton
      ItemHeight = 15
      Items.Strings = (
        'A'
        'P'
        'R'
        'N'
        'G')
      TabOrder = 1
      OnChange = dCmbTipoChange
      OnDrawItem = dCmbTipoDrawItem
    end
    object dEdtDescrizione: TDBEdit
      Left = 328
      Top = 18
      Width = 259
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 3
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 424
    Top = 34
  end
  inherited DButton: TDataSource
    Left = 452
    Top = 34
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 480
    Top = 34
  end
  inherited ImageList1: TImageList
    Left = 368
    Top = 34
  end
  inherited ActionList1: TActionList
    Left = 396
    Top = 34
  end
  object pmnNew: TPopupMenu
    Left = 507
    Top = 34
    object NuovoElemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = NuovoElemento1Click
    end
  end
end
