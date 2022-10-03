object A032FScarico: TA032FScarico
  Left = 483
  Top = 136
  HelpContext = 32000
  BorderStyle = bsSingle
  Caption = '<A032> Acquisizione timbrature'
  ClientHeight = 336
  ClientWidth = 354
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 354
    Height = 336
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 6
      Width = 39
      Height = 13
      Caption = 'Scarico:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 7
      Top = 101
      Width = 41
      Height = 13
      Caption = 'Azienda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblAzienda: TLabel
      Left = 95
      Top = 101
      Width = 3
      Height = 13
    end
    object lblBadgeChiave: TLabel
      Left = 7
      Top = 117
      Width = 78
      Height = 13
      Caption = 'Badge / Chiave:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblBadge: TLabel
      Left = 95
      Top = 117
      Width = 3
      Height = 13
    end
    object Label4: TLabel
      Left = 7
      Top = 85
      Width = 25
      Height = 13
      Caption = 'Riga:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblRiga: TLabel
      Left = 95
      Top = 85
      Width = 3
      Height = 13
    end
    object Label5: TLabel
      Left = 7
      Top = 68
      Width = 39
      Height = 13
      Caption = 'Scarico:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblScarico: TLabel
      Left = 95
      Top = 68
      Width = 3
      Height = 13
    end
    object EScarico: TDBLookupComboBox
      Left = 7
      Top = 20
      Width = 145
      Height = 21
      KeyField = 'SCARICO'
      ListField = 'SCARICO'
      ListSource = R200FScaricoTimbratureDtM.DI100
      PopupMenu = PopupMenu1
      TabOrder = 0
      OnKeyDown = EScaricoKeyDown
    end
    object BitBtn1: TBitBtn
      Left = 3
      Top = 137
      Width = 77
      Height = 25
      Caption = 'Inizia scarico'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 273
      Top = 137
      Width = 77
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 3
    end
    object chkScarichiAuto: TCheckBox
      Left = 7
      Top = 44
      Width = 145
      Height = 17
      Caption = 'Tutti gli scarichi automatici'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkScarichiAutoClick
    end
    object memoMessaggi: TMemo
      Left = 0
      Top = 168
      Width = 354
      Height = 168
      Align = alBottom
      Color = clMenu
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 4
      WordWrap = False
    end
    object btnScarichiOld: TBitBtn
      Left = 93
      Top = 137
      Width = 166
      Height = 25
      Caption = 'Recupero scarichi precedenti'
      TabOrder = 5
      OnClick = btnScarichiOldClick
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 194
    Top = 4
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
