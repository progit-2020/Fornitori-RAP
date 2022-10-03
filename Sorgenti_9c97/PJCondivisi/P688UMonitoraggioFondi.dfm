object P688FMonitoraggioFondi: TP688FMonitoraggioFondi
  Left = 0
  Top = 0
  HelpContext = 3688000
  Caption = '<P688> Monitoraggio fondi'
  ClientHeight = 560
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 106
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 784
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Elenco fondi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 792
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 792
    object Label1: TLabel
      Left = 6
      Top = 14
      Width = 110
      Height = 13
      Caption = 'Dalla decorrenza fondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 223
      Top = 14
      Width = 96
      Height = 13
      Caption = 'Alla scadenza fondo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDecorrenzaDa: TMaskEdit
      Left = 120
      Top = 11
      Width = 70
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      OnExit = edtDecorrenzaDaExit
    end
    object edtDecorrenzaA: TMaskEdit
      Left = 322
      Top = 11
      Width = 70
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      OnExit = edtDecorrenzaAExit
    end
    object btnDecorrenzaDa: TBitBtn
      Left = 191
      Top = 9
      Width = 15
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnDecorrenzaDaClick
    end
    object btnDecorrenzaA: TBitBtn
      Left = 393
      Top = 9
      Width = 15
      Height = 25
      Caption = '...'
      TabOrder = 3
      OnClick = btnDecorrenzaAClick
    end
  end
  object dgrdDettaglio: TDBGrid
    Left = 0
    Top = 61
    Width = 784
    Height = 458
    Align = alClient
    DataSource = P688FMonitoraggioFondiDtM.dsrP688
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgMultiSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_MACROCATEG'
        Title.Caption = 'Cod.macrocateg.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_MACROCATEG'
        Title.Caption = 'Descrizione macrocategoria'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_RAGGR'
        Title.Caption = 'Cod.raggr.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_RAGGR'
        Title.Caption = 'Descrizione raggruppamento'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COD_FONDO'
        Title.Caption = 'Cod.fondo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESC_FONDO'
        Title.Caption = 'Descrizione fondo'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA_DA'
        Title.Caption = 'Decorrenza'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA_A'
        Title.Caption = 'Scadenza'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA_ULTIMO_MONIT'
        Title.Caption = 'Ultimo monit.'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOT_RISORSE'
        Title.Caption = 'Tot.risorse'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOT_SPESO'
        Title.Caption = 'Tot.speso'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOT_RESIDUO'
        Title.Caption = 'Tot.residuo'
        Width = 80
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 519
    Width = 784
    Height = 41
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 532
    ExplicitWidth = 792
    object rgpRaggruppamento: TRadioGroup
      Left = 6
      Top = 4
      Width = 427
      Height = 33
      Caption = 'Tipo totalizzazione'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Fondo'
        'Raggruppamento'
        'Macrocategoria')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpRaggruppamentoClick
    end
    object BitBtn1: TBitBtn
      Left = 686
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 1
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 264
    Top = 185
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
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object Copia2: TMenuItem
      Caption = 'Copia'
      OnClick = Copia2Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = Copia2Click
    end
  end
end
