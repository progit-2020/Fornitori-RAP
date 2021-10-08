object B014FIntegrazioneAnagrafica: TB014FIntegrazioneAnagrafica
  Left = 345
  Top = 126
  HelpContext = 9014000
  Caption = '<B014> IrisWIN - Integrazione Anagrafica'
  ClientHeight = 386
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 592
    Height = 367
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 0
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Impostazioni'
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 584
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ToolBar1: TToolBar
          Left = 0
          Top = 0
          Width = 584
          Height = 41
          ButtonHeight = 36
          ButtonWidth = 44
          Caption = 'ToolBar1'
          Flat = False
          Images = ImageList1
          ParentShowHint = False
          ShowCaptions = True
          ShowHint = False
          TabOrder = 0
          object ToolButton5: TToolButton
            Left = 0
            Top = 0
            Width = 17
            Caption = 'ToolButton5'
            ImageIndex = 2
            Style = tbsSeparator
          end
          object chkAvvioAutomatico: TCheckBox
            Left = 17
            Top = 0
            Width = 106
            Height = 36
            Caption = 'Avvio automatico'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
          object ToolButton9: TToolButton
            Left = 123
            Top = 0
            Width = 17
            Caption = 'ToolButton9'
            ImageIndex = 0
            Style = tbsSeparator
          end
          object ToolButton6: TToolButton
            Left = 140
            Top = 0
            Action = actAvvio
          end
          object ToolButton2: TToolButton
            Left = 184
            Top = 0
            Width = 17
            Caption = 'ToolButton2'
            ImageIndex = 1
            Style = tbsSeparator
          end
          object ToolButton7: TToolButton
            Left = 201
            Top = 0
            Action = actStop
          end
          object ToolButton3: TToolButton
            Left = 245
            Top = 0
            Width = 17
            Caption = 'ToolButton3'
            ImageIndex = 2
            Style = tbsSeparator
          end
          object ToolButton1: TToolButton
            Left = 262
            Top = 0
            Action = actServizio
            DropdownMenu = popmnuServizio
          end
          object ToolButton4: TToolButton
            Left = 306
            Top = 0
            Width = 17
            Caption = 'ToolButton4'
            ImageIndex = 1
            Style = tbsSeparator
          end
          object ToolButton8: TToolButton
            Left = 323
            Top = 0
            Action = actEsci
          end
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 89
        Width = 584
        Height = 250
        Align = alClient
        Caption = 'Schedulazioni'
        TabOrder = 1
        object dgrdIA190: TDBGrid
          Left = 2
          Top = 15
          Width = 580
          Height = 233
          Align = alClient
          DataSource = B014FMonitorIntegrazioneDtM.dsrIA190
          PopupMenu = mnuSchedulazione
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnEditButtonClick = dgrdIA190EditButtonClick
          Columns = <
            item
              Expanded = False
              FieldName = 'ORA'
              Visible = True
            end
            item
              ButtonStyle = cbsEllipsis
              DropDownRows = 10
              Expanded = False
              FieldName = 'STRUTTURE'
              Visible = True
            end>
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 41
        Width = 584
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object lblDatabase: TLabel
          Left = 17
          Top = 7
          Width = 91
          Height = 13
          Caption = 'Database corrente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDatabaseList: TLabel
          Left = 17
          Top = 31
          Width = 74
          Height = 13
          Caption = 'Database usati:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtDataBase: TEdit
          Left = 111
          Top = 3
          Width = 316
          Height = 21
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 0
        end
        object btnDataBase: TButton
          Left = 427
          Top = 3
          Width = 57
          Height = 21
          Caption = 'Cambia...'
          TabOrder = 1
          OnClick = btnDataBaseClick
        end
        object edtDatabaseList: TEdit
          Left = 111
          Top = 27
          Width = 316
          Height = 21
          ParentShowHint = False
          ReadOnly = True
          ShowHint = True
          TabOrder = 2
        end
        object btnDatabaseList: TButton
          Left = 427
          Top = 27
          Width = 57
          Height = 21
          Caption = 'Cambia...'
          TabOrder = 3
          OnClick = btnDatabaseListClick
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Log elaborazione'
      ImageIndex = 1
      object memoLog: TMemo
        Left = 0
        Top = 41
        Width = 584
        Height = 298
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 584
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 359
          Top = 14
          Width = 52
          Height = 13
          Caption = 'Righe Log:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnLog: TBitBtn
          Left = 95
          Top = 8
          Width = 120
          Height = 25
          Caption = 'Visualizza Log'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btnLogClick
        end
        object btnPulisciLog: TBitBtn
          Left = 226
          Top = 8
          Width = 120
          Height = 25
          Caption = 'Pulisci Log'
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C00000000000000001F7C0000000000001F7C1F7C1F7C1F7C
            1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C00001F7C
            1F7C1F7C1F7C000000001F7C1F7C0000000000001F7C1F7C00001F7C1F7C1F7C
            1F7C1F7C1F7C000000001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C000000001F7C1F7C000000001F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C000000001F7C00001F7C00000040004000001F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C0000007C007C007C004000001F7C
            1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C0000007C007C007C007C00400000
            1F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C007C007C00000042
            00001F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C0000E07F0000
            004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F0000E07F
            0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C0000E07F0000
            E07F004200421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F
            E07FE07F00421F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
            E07FE07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            0000E07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C0000E07F}
          TabOrder = 1
          Visible = False
        end
        object edtRigheLog: TSpinEdit
          Left = 419
          Top = 11
          Width = 58
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Log registrazioni'
      ImageIndex = 2
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 584
        Height = 58
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Left = 0
          Top = 4
          Width = 25
          Height = 13
          Caption = 'Filtro:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtFiltroIA000: TEdit
          Left = 28
          Top = 2
          Width = 541
          Height = 21
          TabOrder = 0
        end
        object btnEseguiIA000: TBitBtn
          Left = 28
          Top = 28
          Width = 90
          Height = 25
          Caption = 'Esegui'
          Default = True
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
          OnClick = btnEseguiIA000Click
        end
        object btnEliminaIA000: TBitBtn
          Left = 130
          Top = 28
          Width = 135
          Height = 25
          Caption = 'Elimina righe filtrate'
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C00000000000000001F7C0000000000001F7C1F7C1F7C1F7C
            1F7C1F7C1F7C000000000000000000000000000000001F7C1F7C1F7C00001F7C
            1F7C1F7C1F7C000000001F7C1F7C0000000000001F7C1F7C00001F7C1F7C1F7C
            1F7C1F7C1F7C000000001F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C000000001F7C1F7C000000001F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C000000001F7C00001F7C00000040004000001F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C0000007C007C007C004000001F7C
            1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C0000007C007C007C007C00400000
            1F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C007C007C00000042
            00001F7C1F7C1F7C1F7C000000001F7C00001F7C1F7C0000007C0000E07F0000
            004200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F0000E07F
            0000004200001F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C0000E07F0000
            E07F004200421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000E07F
            E07FE07F00421F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
            E07FE07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            0000E07FE07F1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C0000E07F}
          TabOrder = 2
          OnClick = btnEliminaIA000Click
        end
        object BitBtn1: TBitBtn
          Left = 280
          Top = 28
          Width = 159
          Height = 25
          Caption = 'Elimina tutte le registrazioni'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF8400008400008400008400008400008400008400008400
            00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFF
            FFFFFFFFFFFFFFFF848484840000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFFFFFFFF8484848400008484848400
            00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFF
            FFFFFFFFFFFFFFFF848484840000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFFFFFFFF8484848400008484848400
            00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFF
            FFFFFFFFFFFFFFFF848484848484840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF8400008400008400008400008400008400008400008400
            00848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000840000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8400
            00000000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000840000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000840000848484FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFF840000FFFFFF000000840000FFFFFFFFFFFFFFFFFFFFFFFF8400
            00848484840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFF00
            0000FFFFFFFFFFFFFFFFFFFFFFFF848484840000840000FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF840000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF840000FFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF840000840000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8400
            00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 3
          OnClick = BitBtn1Click
        end
      end
      object dgrdIA000: TDBGrid
        Left = 0
        Top = 58
        Width = 584
        Height = 262
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnEditButtonClick = dgrdIA000EditButtonClick
      end
      object StatusBar1: TStatusBar
        Left = 0
        Top = 320
        Width = 584
        Height = 19
        Panels = <>
        SimplePanel = True
      end
    end
    object tabModificaLog: TTabSheet
      Caption = 'Modifica log'
      ImageIndex = 5
      object pnlModificaLog: TPanel
        Left = 0
        Top = 0
        Width = 584
        Height = 58
        Align = alTop
        TabOrder = 0
        object Label7: TLabel
          Left = 7
          Top = 9
          Width = 40
          Height = 13
          Caption = 'Struttura'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object rgpStato: TRadioGroup
          Left = 415
          Top = 5
          Width = 158
          Height = 49
          Caption = 'Stato'
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 3
          Items.Strings = (
            'Errati'
            'Rimossi'
            'Ins./Mod.'
            'Tutti ')
          ParentFont = False
          TabOrder = 2
          OnClick = rgpStatoClick
        end
        object gpbDataElab: TGroupBox
          Left = 164
          Top = 5
          Width = 228
          Height = 49
          Caption = 'Data elaborazione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object sbtDaData: TSpeedButton
            Left = 97
            Top = 19
            Width = 15
            Height = 21
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            OnClick = sbtDaDataClick
          end
          object sbtAData: TSpeedButton
            Left = 205
            Top = 19
            Width = 15
            Height = 21
            Caption = '...'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            NumGlyphs = 2
            ParentFont = False
            OnClick = sbtADataClick
          end
          object Label5: TLabel
            Left = 7
            Top = 22
            Width = 16
            Height = 13
            Caption = 'Dal'
          end
          object Label6: TLabel
            Left = 122
            Top = 22
            Width = 9
            Height = 13
            Caption = 'Al'
          end
          object edtDaData: TMaskEdit
            Left = 26
            Top = 19
            Width = 70
            Height = 21
            EditMask = '!99/99/0000;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 0
            Text = '  /  /    '
            OnExit = edtDaDataExit
          end
          object edtAData: TMaskEdit
            Left = 134
            Top = 19
            Width = 70
            Height = 21
            EditMask = '!99/99/0000;1;_'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            MaxLength = 10
            ParentFont = False
            TabOrder = 1
            Text = '  /  /    '
            OnExit = edtDaDataExit
          end
        end
        object dcmbStruttura: TDBLookupComboBox
          Left = 7
          Top = 24
          Width = 140
          Height = 21
          KeyField = 'NOME_STRUTTURA'
          ListField = 'NOME_STRUTTURA'
          ListSource = B014FMonitorIntegrazioneDtM.dsrIA100
          TabOrder = 0
          OnCloseUp = dcmbStrutturaCloseUp
          OnKeyUp = dcmbStrutturaKeyUp
        end
      end
      inline frmToolbarFiglio: TfrmToolbarFiglio
        Left = 0
        Top = 58
        Width = 584
        Height = 23
        Align = alTop
        TabOrder = 1
        TabStop = True
        ExplicitTop = 58
        ExplicitWidth = 584
        inherited tlbarFiglio: TToolBar
          Width = 584
          ExplicitWidth = 584
        end
        inherited actlstToolbarFiglio: TActionList
          inherited actTFInserisci: TAction
            Enabled = False
            Visible = False
          end
          inherited actTFCancella: TAction
            Enabled = False
            Visible = False
          end
        end
      end
      object dgrdModificaLog: TDBGrid
        Left = 0
        Top = 81
        Width = 584
        Height = 239
        Align = alClient
        DataSource = DButton
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
        PopupMenu = popmnuInizializzaStrutture
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnEditButtonClick = dgrdModificaLogEditButtonClick
        OnTitleClick = dgrdModificaLogTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'DATA_ELABORAZIONE'
            ReadOnly = True
            Width = 125
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AZIENDA'
            ReadOnly = True
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENTE'
            ReadOnly = True
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATA_REGISTRAZIONE'
            ReadOnly = True
            Width = 125
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CHIAVE'
            ReadOnly = True
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATO'
            PickList.Strings = (
              'E'
              'R')
            Title.Font.Charset = DEFAULT_CHARSET
            Title.Font.Color = clBlue
            Title.Font.Height = -11
            Title.Font.Name = 'MS Sans Serif'
            Title.Font.Style = []
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DECORRENZA'
            ReadOnly = True
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SCADENZA'
            ReadOnly = True
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DATO'
            ReadOnly = True
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALORE'
            ReadOnly = True
            Width = 60
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'MESSAGGIO'
            ReadOnly = True
            Visible = True
          end
          item
            ButtonStyle = cbsEllipsis
            Expanded = False
            FieldName = 'TESTO_SQL'
            ReadOnly = True
            Visible = True
          end>
      end
      object StatusBar2: TStatusBar
        Left = 0
        Top = 320
        Width = 584
        Height = 19
        Panels = <>
        SimplePanel = True
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Definizione strutture'
      ImageIndex = 3
      object Splitter1: TSplitter
        Left = 0
        Top = 167
        Width = 584
        Height = 3
        Cursor = crVSplit
        Align = alTop
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 584
        Height = 167
        Align = alTop
        Caption = 'Strutture'
        TabOrder = 0
        object dgrdIA100: TDBGrid
          Left = 2
          Top = 15
          Width = 580
          Height = 150
          Align = alClient
          DataSource = B014FMonitorIntegrazioneDtM.dsrIA100
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          PopupMenu = popmnuBrowse
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = dgrdIA100DblClick
          OnEditButtonClick = dgrdIA100EditButtonClick
          Columns = <
            item
              Expanded = False
              FieldName = 'NOME_STRUTTURA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TIPO_STRUTTURA'
              PickList.Strings = (
                'F'
                'T')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DIREZIONE_DATI'
              PickList.Strings = (
                'I'
                'O')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME_FILE'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FTP_HOST'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FTP_USER'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FTP_PASSWORD'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FTP_PORT'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOG_ERRORE'
              PickList.Strings = (
                'S'
                'N')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOG_ESEGUITO'
              PickList.Strings = (
                'S'
                'N')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LOG_MODIFICA'
              PickList.Strings = (
                'S'
                'N')
              Title.Caption = 'LOG Modificabile'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'RESET_DATI'
              PickList.Strings = (
                'S'
                'N')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CANCELLAZIONE'
              PickList.Strings = (
                'S'
                'N')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'B014PERSONALIZZATA'
              PickList.Strings = (
                'S'
                'N')
              Visible = True
            end
            item
              ButtonStyle = cbsEllipsis
              Expanded = False
              FieldName = 'SCRIPT_BEFORE'
              Visible = True
            end
            item
              ButtonStyle = cbsEllipsis
              Expanded = False
              FieldName = 'SCRIPT_AFTER'
              Visible = True
            end>
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 170
        Width = 584
        Height = 169
        Align = alClient
        Caption = 'Dati associati'
        TabOrder = 1
        object dgrdIA110: TDBGrid
          Left = 2
          Top = 15
          Width = 580
          Height = 152
          Align = alClient
          DataSource = B014FMonitorIntegrazioneDtM.dsrIA110
          PopupMenu = popmnuInizializzaStrutture
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'AZIENDA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'INTESTAZIONE'
              PickList.Strings = (
                'ENTE'
                'SEQUENZA'
                'DATA'
                'UTENTE'
                'CHIAVE'
                'DECORRENZA'
                'SCADENZA'
                'DATO'
                'VALORE')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TABELLA'
              Width = 110
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CAMPO'
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'POS_DATO'
              Title.Caption = 'Posiz.'
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'LUNG_DATO'
              Title.Caption = 'Lung.'
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NOME_DATO'
              Width = 120
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TIPO_DATO'
              PickList.Strings = (
                'A'
                'N'
                'D')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'FMT_DATA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'STORICO'
              PickList.Strings = (
                'S'
                'N')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VIRTUALE'
              PickList.Strings = (
                'N'
                'S')
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PROPRIETA'
              Width = 200
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TABELLA_DESC'
              Title.Caption = 'Tabella descrittiva'
              Width = 120
              Visible = True
            end>
        end
      end
    end
    object tabTriggerOutput: TTabSheet
      Caption = 'Flusso Output'
      ImageIndex = 4
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 584
        Height = 281
        Align = alClient
        Caption = 'Definizione trigger'
        TabOrder = 0
        object Splitter2: TSplitter
          Left = 2
          Top = 130
          Width = 580
          Height = 2
          Cursor = crVSplit
          Align = alTop
        end
        object ToolBar2: TToolBar
          Left = 2
          Top = 15
          Width = 580
          Height = 25
          ButtonHeight = 23
          ButtonWidth = 52
          Caption = 'ToolBar1'
          Images = ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object TInserGriglia: TToolButton
            Left = 0
            Top = 0
            Hint = 'Inserisci'
            ImageIndex = 11
            OnClick = TAzioniGrigliaClick
          end
          object TModifGriglia: TToolButton
            Left = 52
            Top = 0
            Hint = 'Modifica'
            ImageIndex = 12
            OnClick = TAzioniGrigliaClick
          end
          object TCancGriglia: TToolButton
            Left = 104
            Top = 0
            Hint = 'Cancella'
            ImageIndex = 13
            OnClick = TAzioniGrigliaClick
          end
          object ToolButton11: TToolButton
            Left = 156
            Top = 0
            Width = 36
            ImageIndex = 16
            Style = tbsSeparator
          end
          object TAnnullaGriglia: TToolButton
            Left = 192
            Top = 0
            Hint = 'Annulla'
            Enabled = False
            ImageIndex = 9
            OnClick = TAzioniGrigliaClick
          end
          object TRegisGriglia: TToolButton
            Left = 244
            Top = 0
            Hint = 'Conferma'
            Enabled = False
            ImageIndex = 14
            OnClick = TAzioniGrigliaClick
          end
          object ToolButton10: TToolButton
            Left = 296
            Top = 0
            Width = 36
            Caption = 'ToolButton10'
            ImageIndex = 17
            Style = tbsSeparator
          end
          object TCreaTrigger: TToolButton
            Left = 332
            Top = 0
            Hint = 'Crea trigger'
            Caption = 'TCreaTrigger'
            ImageIndex = 2
            OnClick = TAzioniGrigliaClick
          end
          object TEliminaTrigger: TToolButton
            Left = 384
            Top = 0
            Hint = 'Elimina trigger'
            Caption = 'TEliminaTrigger'
            ImageIndex = 8
            OnClick = TAzioniGrigliaClick
          end
        end
        object dgrdIA130: TDBGrid
          Left = 2
          Top = 40
          Width = 580
          Height = 90
          Align = alTop
          DataSource = B014FMonitorIntegrazioneDtM.dsrIA130
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'AZIENDA'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'TABELLA'
              Visible = True
            end>
        end
        object DBMemo1: TDBMemo
          Left = 2
          Top = 132
          Width = 580
          Height = 147
          Align = alClient
          DataField = 'TRIGGER_TEXT'
          DataSource = B014FMonitorIntegrazioneDtM.dsrIA130
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          PopupMenu = popmnuTriggerOutput
          TabOrder = 2
        end
      end
      object GroupBox5: TGroupBox
        Left = 0
        Top = 281
        Width = 584
        Height = 58
        Align = alBottom
        Caption = 'Estrazione dati'
        TabOrder = 1
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 38
          Height = 13
          Caption = 'Azienda'
        end
        object Label4: TLabel
          Left = 160
          Top = 16
          Width = 40
          Height = 13
          Caption = 'Struttura'
        end
        object btnEstrazioneDati: TBitBtn
          Left = 312
          Top = 26
          Width = 145
          Height = 25
          Caption = 'Estrazione dati'
          TabOrder = 0
          OnClick = btnEstrazioneDatiClick
        end
        object dcmbAzienda: TDBLookupComboBox
          Left = 8
          Top = 30
          Width = 145
          Height = 21
          KeyField = 'AZIENDA'
          ListField = 'AZIENDA'
          ListSource = B014FMonitorIntegrazioneDtM.dsrI090
          TabOrder = 1
          OnKeyDown = dcmbAziendaKeyDown
        end
        object cmbStrutture: TComboBox
          Left = 160
          Top = 30
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 2
        end
        inline frmSelAnagrafe: TfrmSelAnagrafe
          Left = 2
          Top = 15
          Width = 580
          Height = 24
          Align = alTop
          TabOrder = 3
          TabStop = True
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 580
          ExplicitHeight = 24
          inherited pnlSelAnagrafe: TPanel
            Width = 580
            Height = 24
            ExplicitWidth = 580
            ExplicitHeight = 24
          end
        end
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 367
    Width = 592
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Width = 400
      end>
  end
  object mnuSchedulazione: TPopupMenu
    OnPopup = mnuSchedulazionePopup
    Left = 40
    Top = 260
    object Copiaschedulazione1: TMenuItem
      Caption = 'Copia schedulazione...'
      OnClick = Copiaschedulazione1Click
    end
    object Eliminaschedulazione1: TMenuItem
      Caption = 'Elimina tutte le schedulazioni'
      OnClick = Eliminaschedulazione1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Eseguiora1: TMenuItem
      Caption = 'Esegui ora'
      OnClick = Eseguiora1Click
    end
  end
  object popmnuServizio2: TPopupMenu
    Left = 76
    Top = 188
    object Installa2: TMenuItem
      Caption = 'Installa'
      OnClick = Installa1Click
    end
    object Avvia2: TMenuItem
      Caption = 'Avvia'
      OnClick = Avvia1Click
    end
    object Arresta2: TMenuItem
      Caption = 'Arresta'
      OnClick = Arresta1Click
    end
    object Disinstalla2: TMenuItem
      Caption = 'Disinstalla'
      OnClick = Disinstalla1Click
    end
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 152
    Top = 260
    object actAvvio: TAction
      Caption = 'Avvio'
      ImageIndex = 0
      OnExecute = avtAvvioExecute
    end
    object actStop: TAction
      Caption = 'Stop'
      ImageIndex = 1
      OnExecute = actStopExecute
    end
    object actEsci: TAction
      Caption = 'Chiudi'
      ImageIndex = 3
      OnExecute = actEsciExecute
    end
    object actServizio: TAction
      Caption = 'Servizio'
      ImageIndex = 2
      OnExecute = actServizioExecute
    end
  end
  object ImageList1: TImageList
    Left = 180
    Top = 260
    Bitmap = {
      494C01010F001100040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840084848400848484000000000000000000000000000000
      0000000000008484840084848400000000000000000000000000000000000000
      0000000000000000000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000000000000
      0000000000000000840000008400848484008484840000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000008400000084000000
      0000000000008484840000008400000084008484840000000000000000000000
      0000848484000000840000000000000000000000000000000000000000000000
      0000008400000084000000FF000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000FFFF00848484000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000008400000084008484840084848400000000000000
      8400000084008484840000000000000000000000000000000000000000000084
      000000FF000000FF00000000000000FF00000084000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      84000000840000008400000000000000000000000000C6C6C60000FFFF008484
      8400000000000000000000000000000000000000000000008400000084000000
      8400000084000000000084848400000084000000840084848400848484000000
      84000000840000000000000000000000000000000000000000000000000000FF
      000000FF0000000000000000000000FF000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000C6C6C60000FF
      FF00848484000000000000000000000000000000000000008400000084000000
      8400000084000000840000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FF000000840000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      84000000840000000000000000000000000000000000000000000000000000FF
      FF00848484000000000000000000000000000000000000008400000084000000
      8400000084000000000000000000848484000000840000008400000084008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FF0000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000000000000000000000000000000000000000000000000000000000C6C6
      C60000FFFF008484840000000000000000000000000000008400000084000000
      8400000000008484840084848400000084000000840000008400000084008484
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C60000FFFF0000000000000000000000000000008400000084000000
      0000848484000000840000008400000000000000000084848400000084000000
      8400848484008484840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF00000084
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000008400000000000000000000008400000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      8400000084008484840000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      0000008400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF00000084000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000008400000000000000000000000000000000000000
      000000000000000000000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000084000000FF0000008400000000000000000000000000000000000000
      0000000000000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF0084848400840000008484
      8400840000000000000000000000000000000000000000000000000000000000
      000000000000000084000000FF000000FF000000000000000000000000000000
      00000000FF000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484008484
      8400840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      84000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000840000008400
      0000840000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000FF00000084000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF00000084000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      8400000000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000084000000000000000000000000000000000000000000
      00000000000000000000000000000000FF00000084000000FF00000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      0000008484000000000000000000000000000000000000000000000084000000
      8400000084000000840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000084848400000000000000000000000000000000000000
      00000000000000000000000084000000FF000000840000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000000000FF
      FF00000000000084840000000000000000000000000000000000000084000000
      8400000084000000000000000000000000000000000000000000840000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF0000000000840000000000000000000000000000000000
      0000840000008484840084000000000000000000000000000000000000000000
      00000000FF00000084000000FF00000084000000000000000000000000000000
      0000000084000000FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000848400000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      000084000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000848484008400000084000000000000000000000000000000000000000000
      84000000FF00000084000000FF00000000000000000000000000000000000000
      000000000000000084000000FF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000848400008484000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000000000000000000084000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000084000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000000000000000000000000000000000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C60000000000C6C6C60000000000C6C6C6000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000008484000084840000848400000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF00840084000000000000000000C6C6C600000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF0000000000000000007B7B7B00000000007B7B7B00000000000000FF000000
      FF000000FF0000000000000000000000000000FFFF0000000000000000000000
      00000000000000FFFF00000000000000000000FFFF0000000000008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF000000
      000000FFFF000000000000FFFF0000FFFF000000000000FFFF00008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF00000000000000000000000000000000000000FF00000000000000
      FF000000FF000000FF007B7B7B00000000007B7B7B0000000000000000000000
      00000000FF000000FF00000000000000000000000000000000000000000000FF
      FF0000848400008484000000000000FFFF0000FFFF0000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000FF000000FF00000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000FFFF0000FFFF000084
      840000FFFF000084840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000FF000000FF000000000000FFFF0000000000000000000084
      84000000000000FFFF00008484000000000000FFFF000000000000FFFF000084
      8400008484000084840000848400000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000007B7B7B00000000007B7B7B0000000000000000000000
      0000000000000000FF000000FF00000000000000000000FFFF0000FFFF000084
      8400000000000000000000848400000000000000000000FFFF00000000000084
      8400008484000084840000848400000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF00000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000840000000000000084000000FF00000000000000
      0000000000000000FF000000FF00000000000084840000000000000000000084
      84000000000000848400008484000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF0000000000FFFF000000000000FFFF
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000FF000000FF00000000000084840000FFFF0000FFFF000000
      000000848400008484000000000000FFFF000000000000000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000084008400FF00FF00840084000000000000000000FFFF00000000
      0000FFFF00008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00000000000000FF00000000000000000000FFFF00000000000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000000000008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      000084000000FF00FF0084008400FF00FF0000000000FFFF000000000000FFFF
      000000000000840000000000000000000000000000000000000000000000BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF0000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000FFFF00000000000000000000FFFF00008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF00000000007B7B7B00000000007B7B7B0000000000000000000000
      FF000000FF000000000000000000000000000084840000848400008484000000
      00000084840000FFFF0000000000008484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000008484000000000000FFFF00008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FCFFFFFFFFFF0000DF7FF8F9FCFF0000CF3FB879F8FF0000C71F9873F07F0000
      C30F8C23E27F0000C38F8407E63F0000C3C7820FFF3F0000C7C3860FFF9F0000
      CFE38807FFCF0000DFF19183FFCF0000FFF0BFC1FFE70000FFF9FFF3FFF30000
      FFFFFFFFFFFF0000FFFFFFFFFFFF0000F807FFFE847FFFFFF807FBFF00EFFFFF
      F807F1FD31BFFFFFF807F1FB39FFDFFFF807F8F3993FCFF7F807FC67CA1FC7D5
      F803FE0FF40FC3E3FFF3FF1F9C07C181FFF1FE0F9603C3E3F9F1FC6FCB01C7D5
      F0F1F0F3FF80CFF7F0F1E1F9F7C0DFFFF9FBE7FCFFE0FFFFEFF3FFFFEFF0FFFF
      FFF7FFFFFFF8FFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFF3EFFFEFF7FFF7CFF3CFFFCFF3FFF3CFF38FFF8FF1FFF1CF
      F30FFF0FF0FFF0CFF20FFE0FF07FF04FF30FFF0FF0FFF0CFF38FFF8FF1FFF1CF
      F3CFFFCFF3FFF3CFF3EFFFEFF7FFF7CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFFF83F7FCAFF9FF83FF21F01F8
      FF8FE00F0403F03B000FCC476241F07B700784639481F0537003A0736003F07B
      400731F90081F053700F38F96040F07B4F0F3C7984A0F0537F1F3C396801F02B
      403F3C191083F05376FF9C0B6A41F02B45FF8C438481FFFF73FFC4670203FC0F
      07FFE00FF41FFC0FFFFFF83FF83FFC0F00000000000000000000000000000000
      000000000000}
  end
  object popmnuBrowse: TPopupMenu
    OnPopup = popmnuBrowsePopup
    Left = 96
    Top = 260
    object Browse1: TMenuItem
      Caption = 'Browse...'
      OnClick = Browse1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Eliminatabella1: TMenuItem
      Caption = 'Elimina tabella'
      OnClick = Eliminatabella1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object B014Personalizzata1: TMenuItem
      Caption = 'B014Personalizzata'
      object Visualizzaquellaesistente1: TMenuItem
        Caption = 'Visualizza quella esistente'
        OnClick = Visualizzaquellaesistente1Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Strutturabase1: TMenuItem
        Caption = 'Struttura base'
        OnClick = Engisanit1Click
      end
      object Engisanit1: TMenuItem
        Caption = 'Struttura EngiSanit'#224
        OnClick = Engisanit1Click
      end
    end
  end
  object popmnuInizializzaStrutture: TPopupMenu
    OnPopup = popmnuInizializzaStrutturePopup
    Left = 124
    Top = 260
    object CreaEngisanit1: TMenuItem
      Caption = 'Crea EngiSanit'#224
      OnClick = CreaEngisanit1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object CopiainExcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiainExcel1Click
    end
  end
  object popmnuTriggerOutput: TPopupMenu
    OnPopup = popmnuTriggerOutputPopup
    Left = 12
    Top = 260
    object Creatrigger1: TMenuItem
      Caption = 'Crea struttura del trigger'
      OnClick = Creatrigger1Click
    end
  end
  object popmnuServizio: TPopupMenu
    Left = 68
    Top = 260
    object Installa1: TMenuItem
      Caption = 'Installa'
      OnClick = Installa1Click
    end
    object Disinstalla1: TMenuItem
      Caption = 'Disinstalla'
      OnClick = Disinstalla1Click
    end
    object MenuItem1: TMenuItem
      Caption = '-'
    end
    object Avvia1: TMenuItem
      Caption = 'Avvia'
      OnClick = Avvia1Click
    end
    object Arresta1: TMenuItem
      Caption = 'Arresta'
      OnClick = Arresta1Click
    end
    object MenuItem2: TMenuItem
      Caption = '-'
    end
    object mnuPriority: TMenuItem
      Caption = 'Priorit'#224
      object mnuLowest: TMenuItem
        Tag = 1
        Caption = 'Lowest'
        OnClick = mnuHighestClick
      end
      object mnuLower: TMenuItem
        Tag = 2
        Caption = 'Lower'
        OnClick = mnuHighestClick
      end
      object mnuNormal: TMenuItem
        Tag = 3
        Caption = 'Normal'
        OnClick = mnuHighestClick
      end
      object mnuHigher: TMenuItem
        Tag = 4
        Caption = 'Higher'
        OnClick = mnuHighestClick
      end
      object mnuHighest: TMenuItem
        Tag = 5
        Caption = 'Highest'
        OnClick = mnuHighestClick
      end
    end
  end
  object DButton: TDataSource
    AutoEdit = False
    OnStateChange = DButtonStateChange
    Left = 500
    Top = 180
  end
end
