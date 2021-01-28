object A099FUtilityDB: TA099FUtilityDB
  Left = 203
  Top = 177
  HelpContext = 99000
  Caption = '<A099> Utility del Database'
  ClientHeight = 566
  ClientWidth = 660
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 427
    Width = 660
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 321
    ExplicitWidth = 652
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 660
    Height = 427
    ActivePage = tabTabelle
    Align = alClient
    TabOrder = 0
    object tabTabelle: TTabSheet
      Caption = 'Tabelle/Indici'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel1: TPanel
        Left = 510
        Top = 0
        Width = 142
        Height = 399
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object btnDeleteStatistics: TBitBtn
          Left = 4
          Top = 286
          Width = 137
          Height = 25
          Caption = 'Delete Statistics'
          TabOrder = 7
          OnClick = btnDeleteStatisticsClick
        end
        object btnAnalyzeTable: TBitBtn
          Left = 4
          Top = 312
          Width = 137
          Height = 25
          Caption = 'Analyze Table'
          TabOrder = 8
          OnClick = btnDeleteStatisticsClick
        end
        object btnAnalyzeColumns: TBitBtn
          Left = 4
          Top = 339
          Width = 137
          Height = 25
          Caption = 'Analyze Columns'
          TabOrder = 9
          OnClick = btnDeleteStatisticsClick
        end
        object btnAnalyzeIndexes: TBitBtn
          Left = 4
          Top = 366
          Width = 137
          Height = 25
          Caption = 'Analyze Indexes'
          TabOrder = 10
          OnClick = btnDeleteStatisticsClick
        end
        object btnRebuildIndexes: TBitBtn
          Left = 4
          Top = 218
          Width = 137
          Height = 25
          Caption = 'Rebuild Indexes'
          TabOrder = 6
          OnClick = btnDeleteStatisticsClick
        end
        object btnTableNoParallel: TBitBtn
          Left = 4
          Top = 34
          Width = 137
          Height = 25
          Caption = 'Alter Table NoParallel'
          TabOrder = 0
          OnClick = btnDeleteStatisticsClick
        end
        object btnIndexNoParallel: TBitBtn
          Left = 4
          Top = 61
          Width = 137
          Height = 25
          Caption = 'Alter Index NoParallel'
          TabOrder = 1
          OnClick = btnDeleteStatisticsClick
        end
        object btnDeleteSchemaStats: TBitBtn
          Left = 4
          Top = 98
          Width = 137
          Height = 25
          Caption = 'Cancella statistiche schema'
          TabOrder = 2
          OnClick = btnDeleteSchemaStatsClick
        end
        object btnGatherSchemaStats: TBitBtn
          Left = 4
          Top = 125
          Width = 137
          Height = 25
          Caption = 'Genera statistiche schema'
          TabOrder = 3
          OnClick = btnDeleteSchemaStatsClick
        end
        object btnGatherTableStats: TBitBtn
          Left = 4
          Top = 152
          Width = 137
          Height = 25
          Caption = 'Genera statistiche tabelle'
          TabOrder = 4
          OnClick = btnDeleteStatisticsClick
        end
        object btnMoveTablespace: TBitBtn
          Left = 4
          Top = 191
          Width = 137
          Height = 25
          Caption = 'Move Tablespace'
          TabOrder = 5
          OnClick = btnDeleteStatisticsClick
        end
        object btnShrink: TBitBtn
          Left = 4
          Top = 259
          Width = 137
          Height = 25
          Caption = 'Shrink Table'
          TabOrder = 11
          OnClick = btnDeleteStatisticsClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 510
        Height = 399
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object lstTabelle: TCheckListBox
          Left = 0
          Top = 65
          Width = 510
          Height = 334
          Align = alClient
          Columns = 2
          ItemHeight = 13
          PopupMenu = PopupMenu1
          TabOrder = 1
        end
        object rgpSelezioneTabelle: TRadioGroup
          Left = 0
          Top = 0
          Width = 510
          Height = 65
          Align = alTop
          Caption = 'Selezione tabelle'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Tabelle di'
            'Tabelle senza indici'
            'Tabelle senza chiave primaria'
            'Tabelle esterne al tablespace'
            'Tabelle con indici esterni al tablespace')
          ParentFont = False
          TabOrder = 0
          OnClick = rgpSelezioneTabelleClick
        end
      end
    end
    object tabOggetti: TTabSheet
      Caption = 'Oggetti del DB'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object treeOggettiDB: TTreeView
        Left = 0
        Top = 0
        Width = 493
        Height = 399
        Align = alClient
        Indent = 19
        PopupMenu = mnuCompilaOggetti
        ReadOnly = True
        TabOrder = 0
        OnAdvancedCustomDrawItem = treeOggettiDBAdvancedCustomDrawItem
        OnChange = treeOggettiDBChange
        OnMouseDown = treeOggettiDBMouseDown
      end
      object Panel6: TPanel
        Left = 493
        Top = 0
        Width = 159
        Height = 399
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object btnRicompilaTutto: TBitBtn
          Left = 12
          Top = 64
          Width = 139
          Height = 25
          Caption = 'Ricompila tutti gli oggetti'
          TabOrder = 0
          OnClick = btnRicompilaTuttoClick
        end
        object btnRicompilaInvalidi: TBitBtn
          Left = 12
          Top = 95
          Width = 139
          Height = 25
          Caption = 'Ricompila oggetti invalidi'
          TabOrder = 1
          OnClick = btnRicompilaTuttoClick
        end
        object GroupBox1: TGroupBox
          Left = 4
          Top = 126
          Width = 153
          Height = 105
          Caption = 'Parametri di compilazione'
          TabOrder = 2
          object chkCompileDebug: TCheckBox
            Left = 11
            Top = 17
            Width = 124
            Height = 17
            Alignment = taLeftJustify
            Caption = 'Debug'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = chkCompileParametersClick
          end
          object chkCompileNative: TCheckBox
            Left = 11
            Top = 57
            Width = 124
            Height = 17
            HelpType = htKeyword
            Alignment = taLeftJustify
            Caption = 'Code type Native'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = chkCompileParametersClick
          end
          object chkCompileInterpreted: TCheckBox
            Left = 11
            Top = 40
            Width = 124
            Height = 17
            HelpType = htKeyword
            Alignment = taLeftJustify
            Caption = 'Code type Interpreted'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = chkCompileParametersClick
          end
          object chkCompileReuse: TCheckBox
            Left = 11
            Top = 80
            Width = 124
            Height = 17
            HelpType = htKeyword
            Alignment = taLeftJustify
            Caption = 'Reuse settings'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = chkCompileParametersClick
          end
        end
        object btnV430Storico: TBitBtn
          Left = 12
          Top = 16
          Width = 139
          Height = 25
          Caption = 'Creazione V430_STORICO'
          TabOrder = 3
          OnClick = btnV430StoricoClick
        end
      end
    end
    object tabQuerySupporto: TTabSheet
      Caption = 'Query di supporto'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel7: TPanel
        Left = 510
        Top = 0
        Width = 142
        Height = 399
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object btnEsegui: TBitBtn
          Left = 4
          Top = 64
          Width = 137
          Height = 25
          Caption = 'Esegui'
          TabOrder = 0
          OnClick = btnEseguiClick
        end
        object btnCopiaTestoQuery: TBitBtn
          Left = 4
          Top = 95
          Width = 137
          Height = 25
          Hint = 'Copia il testo della query selezionata negli appunti'
          Caption = 'Copia testo query'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnCopiaTestoQueryClick
        end
      end
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 510
        Height = 399
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object rgpQuerySupporto: TRadioGroup
          Left = 0
          Top = 0
          Width = 510
          Height = 65
          Align = alTop
          Caption = 'Query di supporto'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Situazione tablespace dati'
            'Situazione tablespace temporaneo'
            'Situazione tabelle di log')
          ParentFont = False
          TabOrder = 0
          OnClick = rgpSelezioneTabelleClick
        end
        object dgrdQuerySupporto: TDBGrid
          Left = 0
          Top = 65
          Width = 510
          Height = 334
          Align = alClient
          DataSource = dsrQuerySupporto
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clBlue
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 429
    Width = 660
    Height = 116
    Align = alBottom
    BevelOuter = bvNone
    BevelWidth = 2
    TabOrder = 1
    object memoResult: TMemo
      Left = 0
      Top = 0
      Width = 536
      Height = 116
      Align = alClient
      Color = clInactiveBorder
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 536
      Top = 0
      Width = 124
      Height = 116
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object BitBtn7: TBitBtn
        Left = 5
        Top = 88
        Width = 115
        Height = 25
        Caption = '&Chiudi'
        Kind = bkClose
        TabOrder = 0
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 545
    Width = 660
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 0
      Width = 381
      Height = 21
      Align = alLeft
      TabOrder = 0
    end
    object StatusBar: TStatusBar
      Left = 381
      Top = 0
      Width = 279
      Height = 21
      Align = alClient
      Panels = <>
      SimplePanel = True
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 444
    Top = 8
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Annullatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Annullatutto1Click
    end
  end
  object mnuCompilaOggetti: TPopupMenu
    Left = 480
    Top = 8
    object Ricompila1: TMenuItem
      Caption = 'Ricompila'
      OnClick = Ricompila1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Refresh1: TMenuItem
      Caption = 'Refresh'
      OnClick = Refresh1Click
    end
  end
  object dsrQuerySupporto: TDataSource
    DataSet = A099FUtilityDBMW.selTablespace
    Left = 520
    Top = 120
  end
end
