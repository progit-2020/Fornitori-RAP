object A136FStampaRelazioni: TA136FStampaRelazioni
  Left = 0
  Top = 0
  HelpContext = 136200
  Caption = '<A136> Stampa relazioni'
  ClientHeight = 566
  ClientWidth = 792
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
  object Splitter1: TSplitter
    Left = 0
    Top = 142
    Width = 792
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 209
    ExplicitWidth = 703
  end
  object dgrdStampaRelazioni: TDBGrid
    Left = 0
    Top = 163
    Width = 792
    Height = 403
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    PopupMenu = PopupMenu3
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlImpostazioni: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 142
    Align = alTop
    TabOrder = 1
    object lblDataStampa: TLabel
      Left = 24
      Top = 27
      Width = 60
      Height = 13
      Caption = 'Data stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object medtDataStampa: TMaskEdit
      Left = 24
      Top = 41
      Width = 67
      Height = 21
      EditMask = '!99/99/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
    end
    object btnDataStampa: TButton
      Left = 91
      Top = 41
      Width = 15
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDataStampaClick
    end
    object grpTipoRelazione: TGroupBox
      Left = 419
      Top = 9
      Width = 214
      Height = 127
      Caption = 'Tipo relazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object chkTipoRelS: TCheckBox
        Left = 19
        Top = 34
        Width = 192
        Height = 17
        Caption = 'Assegnazione automatica vincolata'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object chkTipoRelL: TCheckBox
        Left = 15
        Top = 86
        Width = 192
        Height = 17
        Caption = 'Assegnazione automatica libera'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object btnEsegui: TBitBtn
      Left = 24
      Top = 91
      Width = 82
      Height = 25
      Caption = '&Esegui'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777808
        87770777777700300077B0777770B33330078B077770BB88308878B0770BB0F8
        330078BB0770B0003088888BB070BB3BB007BBBBBB0700B000778BBB00887700
        777778BBB07777777777778BBB07777777778888BBB07777777778BBBBBB0777
        7777778BBB00007777777778BBB07777777777778BBB07777777}
      ParentFont = False
      TabOrder = 5
      OnClick = btnEseguiClick
    end
    object grpColonneVisibili: TGroupBox
      Left = 657
      Top = 9
      Width = 113
      Height = 127
      Caption = 'Colonne visualizzate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object chkDecorrenza: TCheckBox
        Left = 15
        Top = 21
        Width = 90
        Height = 17
        Caption = 'Decorrenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object chkNomeCampo: TCheckBox
        Left = 15
        Top = 48
        Width = 90
        Height = 17
        Caption = 'Campo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object chkCodice: TCheckBox
        Left = 15
        Top = 75
        Width = 90
        Height = 17
        Caption = 'Codice'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object chkDescrizione: TCheckBox
        Left = 15
        Top = 102
        Width = 90
        Height = 17
        Caption = 'Descrizione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object grpParametriPartenza: TGroupBox
      Left = 136
      Top = 9
      Width = 258
      Height = 127
      Caption = 'Struttura relazionale da stampare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object lblTabPartenza: TLabel
        Left = 12
        Top = 22
        Width = 35
        Height = 13
        Caption = 'Tabella'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblColPartenza: TLabel
        Left = 12
        Top = 49
        Width = 62
        Height = 13
        Caption = 'Col. partenza'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblColArrivo: TLabel
        Left = 12
        Top = 76
        Width = 47
        Height = 13
        Caption = 'Col. arrivo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 12
        Top = 103
        Width = 37
        Height = 13
        Caption = 'N'#176' livelli'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object cbxTabPartenza: TComboBox
        Left = 81
        Top = 19
        Width = 162
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Sorted = True
        TabOrder = 0
        OnExit = cbxTabPartenzaExit
      end
      object cbxColPartenza: TComboBox
        Left = 81
        Top = 46
        Width = 162
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Sorted = True
        TabOrder = 1
        OnExit = cbxColPartenzaExit
      end
      object cbxColArrivo: TComboBox
        Left = 81
        Top = 73
        Width = 162
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Sorted = True
        TabOrder = 2
        OnExit = cbxColArrivoExit
      end
      object edtLivelliDaEstrarre: TEdit
        Left = 81
        Top = 100
        Width = 28
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '0'
        OnChange = edtLivelliDaEstrarreChange
        OnExit = edtLivelliDaEstrarreExit
      end
      object udLivelliDaEstrarre: TUpDown
        Left = 109
        Top = 100
        Width = 16
        Height = 21
        Associate = edtLivelliDaEstrarre
        TabOrder = 4
      end
    end
  end
  object pnlTitoloStampa: TPanel
    Left = 0
    Top = 145
    Width = 792
    Height = 18
    Align = alTop
    Caption = 'Estrazione relazioni'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object PopupMenu3: TPopupMenu
    Left = 208
    Top = 153
    object Ricercatestocontenuto1: TMenuItem
      Action = actRicercaTestoContenuto
    end
    object Successivo1: TMenuItem
      Action = actSuccessivo
    end
    object N1: TMenuItem
      Caption = '-'
    end
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
    object N2: TMenuItem
      Caption = '-'
    end
    object Copia2: TMenuItem
      Caption = 'Copia'
      OnClick = Copia2Click
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
  object ActionList1: TActionList
    Left = 244
    Top = 152
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
