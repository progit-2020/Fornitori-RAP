object C015FElencoValori: TC015FElencoValori
  Left = 212
  Top = 224
  HelpContext = 3201100
  Caption = 'Elenco valori'
  ClientHeight = 242
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 191
    Width = 434
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 9
      Top = 3
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 93
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Annulla'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object dgrdElencoValori: TDBGrid
    Left = 0
    Top = 0
    Width = 434
    Height = 191
    Align = alClient
    DataSource = DSelTab
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    PopupMenu = pmnRicerca
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = dgrdElencoValoriDblClick
    OnTitleClick = dgrdElencoValoriTitleClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 223
    Width = 434
    Height = 19
    Panels = <>
    SimplePanel = True
    SimpleText = 'Records'
  end
  object DSelTab: TDataSource
    DataSet = SelTab
    OnDataChange = DSelTabDataChange
    Left = 36
    Top = 136
  end
  object pmnRicerca: TPopupMenu
    Left = 148
    Top = 136
    object Testocontenuto1: TMenuItem
      Action = actRicercaTestoContenuto
    end
    object Successivo1: TMenuItem
      Action = actSuccessivo
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Selezionatutto: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = SelezionatuttoClick
    end
    object Deselezionatutto: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = DeselezionatuttoClick
    end
    object Invertiselezione: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = InvertiselezioneClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Copia: TMenuItem
      Caption = 'Copia'
      OnClick = CopiaClick
    end
    object CopiainExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaClick
    end
  end
  object SelTab: TOracleDataSet
    Optimize = False
    QBEDefinition.QBEFieldDefs = {
      0500000002000000160000004400450053004300520049005A0049004F004E00
      45000100000000000C00000043004F004400490043004500010000000000}
    OnTranslateMessage = SelTabTranslateMessage
    AfterOpen = SelTabAfterOpen
    BeforePost = SelTabBeforePost
    AfterPost = SelTabAfterPost
    BeforeDelete = SelTabBeforeDelete
    AfterDelete = SelTabAfterDelete
    AfterScroll = SelTabAfterScroll
    Left = 7
    Top = 136
  end
  object ActionList1: TActionList
    Left = 180
    Top = 136
    object actRicercaTestoContenuto: TAction
      Caption = 'Ricerca testo contenuto'
      Hint = 'Ricerca testo contenuto'
      ShortCut = 16454
      OnExecute = actRicercaTestoContenutoExecute
    end
    object actSuccessivo: TAction
      Caption = 'Successivo'
      Hint = 'Elemento successivo'
      ShortCut = 114
      OnExecute = actRicercaTestoContenutoExecute
    end
  end
end
