object A062FQueryServizio: TA062FQueryServizio
  Left = 274
  Top = 240
  HelpContext = 62000
  Caption = '<A062> Interrogazioni di servizio'
  ClientHeight = 453
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 141
    Width = 785
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 8
    ExplicitTop = 88
    ExplicitWidth = 700
  end
  object Panel1: TPanel
    Left = 0
    Top = 341
    Width = 785
    Height = 77
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 673
      Top = 37
      Width = 75
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object grpRis: TGroupBox
      Left = 1
      Top = 1
      Width = 560
      Height = 75
      Align = alLeft
      Caption = 'Salvataggio risultato'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lblNomeTab: TLabel
        Left = 150
        Top = 51
        Width = 93
        Height = 13
        Caption = 'Nome tabella: T921'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object BStampa: TBitBtn
        Left = 100
        Top = 17
        Width = 75
        Height = 25
        Caption = 'Stampa'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
          0000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000
          C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6000000C6C6
          C6000000FFFFFFFFFFFF00000000000000000000000000000000000000000000
          0000000000000000000000000000000000C6C6C6000000FFFFFF000000C6C6C6
          C6C6C6C6C6C6C6C6C6C6C6C6C6C6C600FFFF00FFFF00FFFFC6C6C6C6C6C60000
          00000000000000FFFFFF000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C684
          8484848484848484C6C6C6C6C6C6000000C6C6C6000000FFFFFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00C6C6C6C6C6C6000000000000C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6C6
          C6C6C6C6C6C6C6C6C6C6C6000000C6C6C6000000C6C6C6000000FFFFFF000000
          000000000000000000000000000000000000000000000000000000C6C6C60000
          00C6C6C6000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFF000000C6C6C6000000C6C6C6000000FFFFFFFFFFFF
          FFFFFF000000FFFFFF000000000000000000000000000000FFFFFF0000000000
          00000000000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF000000FFFFFF000000000000000000000000000000FFFFFF0000
          00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000
          00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        ParentFont = False
        TabOrder = 0
        OnClick = BStampaClick
      end
      object BStampante: TBitBtn
        Left = 6
        Top = 17
        Width = 90
        Height = 25
        Caption = 'Stampante'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
          0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
          070F00000000000007700778888778807070F000000000070700FF0777777770
          7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
          6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
        ParentFont = False
        TabOrder = 1
        OnClick = BStampanteClick
      end
      object BSalva: TBitBtn
        Left = 181
        Top = 17
        Width = 100
        Height = 25
        Caption = 'Salva su file'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          42020000424D4202000000000000420000002800000010000000100000000100
          1000030000000002000000000000000000000000000000000000007C0000E003
          00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
          1F7C1F7C1F7C0000000000000000000000000000000000000000000000000000
          00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
          00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
          00001F7C1F7C0000E03DE03D000000000000000000000000F75EF75E0000E03D
          00001F7C1F7C0000E03DE03D000000000000000000000000000000000000E03D
          00001F7C1F7C0000E03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03DE03D
          00001F7C1F7C0000E03DE03D00000000000000000000000000000000E03DE03D
          00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
          00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
          00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
          00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000E03D
          00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E00000000
          00001F7C1F7C0000E03D0000F75EF75EF75EF75EF75EF75EF75EF75E0000F75E
          00001F7C1F7C0000000000000000000000000000000000000000000000000000
          00001F7C1F7C}
        ParentFont = False
        TabOrder = 2
        OnClick = BSalvaClick
      end
      object btnCreaTab: TBitBtn
        Left = 6
        Top = 46
        Width = 90
        Height = 25
        Caption = 'Crea Tabella'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnEseguiClick
      end
      object edtNomeTab: TEdit
        Left = 246
        Top = 48
        Width = 307
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = edtNomeTabChange
        OnEnter = edtNomeTabEnter
      end
      object chkIntestazione: TCheckBox
        Left = 287
        Top = 21
        Width = 144
        Height = 17
        Caption = 'Con intestazione colonne'
        TabOrder = 5
      end
      object chkNoRitornoACapo: TCheckBox
        Left = 433
        Top = 21
        Width = 120
        Height = 17
        Caption = 'Senza ritorno a capo'
        TabOrder = 6
      end
    end
    object BCartellino: TBitBtn
      Left = 592
      Top = 37
      Width = 75
      Height = 25
      Caption = 'Cartellino'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFF0000FFFFFFFF0000FFFFFFFF0000FFFFFFFF0000FFFFFFFF0000
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFF0000FFFFFFFF0000FFFF
        FFFF0000FFFFFFFF0000FFFFFFFF0000FFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFF0000FFFFFFFF0000FFFFFFFF0000FFFFFFFF0000FFFFFFFF0000
        FFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000000000FFFFFFFF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFF000000000000FFFFFF
        FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF00
        00FF0000FFFFFF000000000000FFFFFFFF0000FF0000FF0000FF0000FF0000FF
        0000FF0000FF0000FF0000FF0000FF0000FF0000FFFFFF000000000000FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentFont = False
      TabOrder = 2
      Visible = False
      OnClick = BCartellinoClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 434
    Width = 785
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 350
      end
      item
        Width = 40
      end>
    SimpleText = '0 Records'
  end
  object pnlGriglia: TPanel
    Left = 0
    Top = 144
    Width = 785
    Height = 197
    Align = alClient
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 1
      Top = 57
      Width = 783
      Height = 139
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      PopupMenu = PopupMenu3
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clRed
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 783
      Height = 56
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 209
        Height = 56
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        object btnEsegui: TBitBtn
          Left = 70
          Top = 3
          Width = 64
          Height = 25
          Caption = '&Esegui'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
            8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
            3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
            FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
            FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
          ParentFont = False
          TabOrder = 0
          OnClick = btnEseguiClick
        end
        object btnCarica: TBitBtn
          Left = 3
          Top = 3
          Width = 64
          Height = 25
          Caption = 'Carica'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C000000000000000000000000000000000000000000001F7C1F7C
            1F7C1F7C1F7C00000000E03DE03DE03DE03DE03DE03DE03DE03DE03D00001F7C
            1F7C1F7C1F7C0000E07F0000E03DE03DE03DE03DE03DE03DE03DE03DE03D0000
            1F7C1F7C1F7C00001F7CE07F0000E03DE03DE03DE03DE03DE03DE03DE03DE03D
            00001F7C1F7C0000E07F1F7CE07F0000E03DE03DE03DE03DE03DE03DE03DE03D
            E03D00001F7C00001F7CE07F1F7CE07F00000000000000000000000000000000
            000000001F7C0000E07F1F7CE07F1F7CE07F1F7CE07F1F7CE07F00001F7C1F7C
            1F7C1F7C1F7C00001F7CE07F1F7CE07F1F7CE07F1F7CE07F1F7C00001F7C1F7C
            1F7C1F7C1F7C0000E07F1F7CE07F00000000000000000000000000001F7C1F7C
            1F7C1F7C1F7C1F7C0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
            000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C0000
            1F7C00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000000000001F7C
            1F7C1F7C1F7C}
          ParentFont = False
          TabOrder = 1
          OnClick = btnCaricaClick
        end
        object btnSalva: TBitBtn
          Left = 3
          Top = 30
          Width = 64
          Height = 24
          Caption = 'Salva'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFF00000000000000FF03300000077030FF033000000770
            30FF03300000077030FF03300000000030FF03333333333330FF033000000003
            30FF03077777777030FF03077777777030FF03077777777030FF030777777770
            30FF03077777777000FF03077777777070FF00000000000000FF}
          ParentFont = False
          TabOrder = 2
          OnClick = btnSalvaClick
        end
        object btnElimina: TBitBtn
          Left = 137
          Top = 30
          Width = 64
          Height = 24
          Caption = 'Elimina'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF188FFFFF88FF1FFF1188FF
            FF10FF11FF8118FFF81FFF111FF1188F118FFF1111F8118811FFFF11111F1111
            1FFFFF1111FF81118FFFFF111F88111188FFFF11F811FF81188FFF1FFFFFFFF8
            1180FFFFFFFFFFFFF01FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentFont = False
          TabOrder = 3
          OnClick = btnEliminaClick
        end
        object btnPulisci: TBitBtn
          Left = 70
          Top = 30
          Width = 64
          Height = 24
          Caption = 'Pulisci'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
            555557777F777555F55500000000555055557777777755F75555005500055055
            555577F5777F57555555005550055555555577FF577F5FF55555500550050055
            5555577FF77577FF555555005050110555555577F757777FF555555505099910
            555555FF75777777FF555005550999910555577F5F77777775F5500505509990
            3055577F75F77777575F55005055090B030555775755777575755555555550B0
            B03055555F555757575755550555550B0B335555755555757555555555555550
            BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
            50BB555555555555575F555555555555550B5555555555555575}
          NumGlyphs = 2
          ParentFont = False
          TabOrder = 4
          OnClick = btnPulisciClick
        end
        object pnlSelAnagrafe: TPanel
          Left = 137
          Top = 2
          Width = 47
          Height = 26
          BevelOuter = bvNone
          TabOrder = 5
          inline frmSelAnagrafe: TfrmSelAnagrafe
            Left = 0
            Top = 0
            Width = 47
            Height = 26
            Align = alTop
            TabOrder = 0
            TabStop = True
            ExplicitWidth = 47
            ExplicitHeight = 26
            inherited pnlSelAnagrafe: TPanel
              Width = 47
              Height = 26
              ExplicitWidth = 47
              ExplicitHeight = 26
              inherited btnSelezione: TBitBtn
                Left = 1
                Top = 2
                ExplicitLeft = 1
                ExplicitTop = 2
              end
              inherited btnEreditaSelezione: TBitBtn
                Top = 2
                ExplicitTop = 2
              end
            end
          end
        end
      end
      object Panel5: TPanel
        Left = 209
        Top = 0
        Width = 574
        Height = 56
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Label7: TLabel
          Left = 57
          Top = 33
          Width = 31
          Height = 13
          Caption = 'Nome:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblRaggruppamento: TLabel
          Left = 4
          Top = 8
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
        object cmbQuery: TComboBox
          Left = 90
          Top = 31
          Width = 295
          Height = 21
          TabOrder = 0
          OnDblClick = cmbQueryDblClick
        end
        object chkProtetta: TCheckBox
          Left = 391
          Top = 33
          Width = 57
          Height = 17
          Caption = 'Protetta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object cmbRaggruppamenti: TComboBox
          Left = 90
          Top = 5
          Width = 295
          Height = 21
          Style = csDropDownList
          PopupMenu = ppMnuAccediA101
          TabOrder = 2
          OnChange = cmbRaggruppamentiChange
        end
      end
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 785
    Height = 141
    Align = alTop
    Caption = 'PanelTop'
    TabOrder = 3
    object Splitter2: TSplitter
      Left = 483
      Top = 1
      Height = 139
      Align = alRight
      ExplicitLeft = 616
      ExplicitHeight = 141
    end
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 482
      Height = 139
      Align = alClient
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      PopupMenu = PopupMenu1
      ScrollBars = ssVertical
      TabOrder = 0
      WordWrap = False
    end
    object dGrdVariabili: TDBGrid
      Left = 486
      Top = 1
      Width = 298
      Height = 139
      Align = alRight
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'VARIABILE'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TIPO'
          PickList.Strings = (
            'Stringa'
            'Data'
            'Numero'
            'Sostituzione')
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORE'
          Width = 87
          Visible = True
        end>
    end
  end
  object prgBar: TProgressBar
    Left = 0
    Top = 418
    Width = 785
    Height = 16
    Align = alBottom
    TabOrder = 4
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 156
    Top = 276
  end
  object PopupMenu3: TPopupMenu
    OnPopup = PopupMenu3Popup
    Left = 120
    Top = 277
    object Datianagrafici1: TMenuItem
      Caption = 'Dati anagrafici'
      OnClick = Datianagrafici1Click
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
      OnClick = CopiaInExcelClick
    end
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'File testo|*.txt|File excel|*.xls'
    Left = 188
    Top = 276
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 24
    Top = 32
    object Incollatesto1: TMenuItem
      Caption = 'Incolla testo'
      OnClick = Incollatesto1Click
    end
    object Inseriscisubquerydallaselezioneanagrafica1: TMenuItem
      Caption = 'Inserisci subquery '#39'PROGRESSIVO IN'#39' sulla selezione anagrafica'
      OnClick = Inseriscisubquerydallaselezioneanagrafica1Click
    end
    object Inseriscijoinconlaselezioneanagrafica1: TMenuItem
      Caption = 'Inserisci join con la selezione anagrafica'
      OnClick = Inseriscijoinconlaselezioneanagrafica1Click
    end
    object InseriscisubqueryEXISTSsullaselezioneanagrafica1: TMenuItem
      Caption = 'Inserisci subquery '#39'EXISTS'#39' sulla selezione anagrafica'
      OnClick = InseriscisubqueryEXISTSsullaselezioneanagrafica1Click
    end
  end
  object ppMnuAccediA101: TPopupMenu
    Left = 664
    Top = 144
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
end
