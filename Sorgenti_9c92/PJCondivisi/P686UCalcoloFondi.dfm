object P686FCalcoloFondi: TP686FCalcoloFondi
  Tag = 610
  Left = 0
  Top = 0
  HelpContext = 3686000
  Caption = '<P686> Calcolo consumi mensili fondi'
  ClientHeight = 451
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 87
    Align = alTop
    TabOrder = 0
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
    object Label3: TLabel
      Left = 6
      Top = 53
      Width = 86
      Height = 13
      Caption = 'Data monitoraggio'
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
    object rgpStatoCedolini: TRadioGroup
      Left = 322
      Top = 42
      Width = 287
      Height = 31
      Caption = 'Stato cedolini da considerare'
      Columns = 3
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Solo chiusi'
        'Chiusi e aperti'
        'Solo aperti')
      ParentFont = False
      TabOrder = 6
    end
    object edtDataMonit: TMaskEdit
      Left = 120
      Top = 50
      Width = 70
      Height = 21
      EditMask = '!00/00/0000;1;_'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
    end
    object btnDataMonit: TBitBtn
      Left = 191
      Top = 48
      Width = 15
      Height = 25
      Caption = '...'
      TabOrder = 5
      OnClick = btnDataMonitClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 375
    Width = 784
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitWidth = 792
    object btnEsegui: TBitBtn
      Left = 245
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Esegui'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
        87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
        330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
        777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
        7777778BBB00007777777778BBB07777777777778BBB07777777}
      TabOrder = 0
      OnClick = btnEseguiClick
    end
    object btnChiudi: TBitBtn
      Left = 386
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 87
    Width = 62
    Height = 288
    Align = alLeft
    TabOrder = 2
    object lblTabelle: TLabel
      Left = 6
      Top = 6
      Width = 43
      Height = 26
      Caption = 'Fondi da calcolare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
  end
  object clbFondi: TCheckListBox
    Left = 62
    Top = 87
    Width = 722
    Height = 288
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 3
    ExplicitWidth = 730
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 435
    Width = 784
    Height = 16
    Align = alBottom
    TabOrder = 4
    ExplicitWidth = 792
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 416
    Width = 784
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ExplicitWidth = 792
  end
  object PopupMenu1: TPopupMenu
    Left = 256
    Top = 208
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
end
