object B022FUtilityGestDocumentale: TB022FUtilityGestDocumentale
  Left = 322
  Top = 109
  HelpContext = 9022000
  Caption = '<B022> Utility gestione documentale'
  ClientHeight = 664
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 645
    Width = 644
    Height = 19
    Panels = <
      item
        Width = 100
      end>
  end
  object PageControl: TPageControl
    Left = 0
    Top = 24
    Width = 644
    Height = 621
    ActivePage = tsConfigurazione
    Align = alClient
    TabOrder = 1
    OnChange = PageControlChange
    OnChanging = PageControlChanging
    object tsConfigurazione: TTabSheet
      Caption = 'Configurazione servizio'
      object pnlConfStato: TPanel
        Left = 0
        Top = 0
        Width = 636
        Height = 97
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblConfLabelStato: TLabel
          Left = 8
          Top = 8
          Width = 83
          Height = 13
          Caption = 'Stato del servizio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblConfStatoServ: TLabel
          Left = 97
          Top = 8
          Width = 388
          Height = 17
          AutoSize = False
          Caption = 'Click su "Aggiorna" per verificare lo stato'
          WordWrap = True
        end
        object lblConfStatoRisp: TLabel
          Left = 97
          Top = 24
          Width = 388
          Height = 17
          AutoSize = False
          WordWrap = True
        end
        object lblConfStatoHelp: TLabel
          Left = 8
          Top = 41
          Width = 601
          Height = 39
          Caption = 
            'Cliccando su "Aggiorna" viene verificato lo stato del servizio W' +
            'indows sulla macchina locale e viene inviata una richiesta HTTP ' +
            'specifica all'#39'URL indicato. Se il servizio '#232' installato su un al' +
            'tro computer raggiungibile in rete e/o il servizio '#232' in esecuzio' +
            'ne sotto IIS '#232' normale che il test del ping abbia esito positivo' +
            ' mentre quello sullo stato del servizio no.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object btnConfAggiorna: TBitBtn
          Left = 339
          Top = 3
          Width = 25
          Height = 25
          Hint = 'Aggiorna'
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
            33333333333F8888883F33330000324334222222443333388F3833333388F333
            000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
            F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
            223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
            3338888300003AAAAAAA33333333333888888833333333330000333333333333
            333333333333333333FFFFFF000033333333333344444433FFFF333333888888
            00003A444333333A22222438888F333338F3333800003A2243333333A2222438
            F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
            22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
            33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
            3333333333338888883333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnConfAggiornaClick
        end
      end
      object grpConfAzioni: TGroupBox
        Left = 3
        Top = 93
        Width = 622
        Height = 108
        Caption = 'Azioni servizio B021'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblConfInfoAzioniPerm: TLabel
          Left = 13
          Top = 85
          Width = 375
          Height = 13
          Caption = 
            'Avviare questo programma come amministratore per eseguire queste' +
            ' operazioni.'
        end
        object btnConfAvvia: TBitBtn
          Left = 314
          Top = 23
          Width = 299
          Height = 25
          Caption = 'Avvia servizio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
            0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000000000BFBFBFBFBFBF7F7F7F7F7F7F7F7F7F000000000000FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBF7F7F7F00000000
            00000000007F7F7F7F7F7F7F7F7F000000FFFFFFFFFFFFFFFFFFFFFFFF000000
            BFBFBFBFBFBF000000FFFFFF00FF00FFFFFF00FF00FFFFFF0000007F7F7F7F7F
            7F000000FFFFFFFFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
            0000000000000000FFFFFF0000007F7F7F000000FFFFFFFFFFFF000000BFBFBF
            7F7F7FFFFFFF00000000000000FF00007F00007F00000000000000FFFFFF7F7F
            7F7F7F7F000000FFFFFF000000BFBFBF00000000FF0000000000FF00007F0000
            FF00007F00007F0000000000FF000000007F7F7F000000FFFFFF000000FFFFFF
            000000FFFFFF00000000FF0000FF0000FF0000FF00007F00000000FFFFFF0000
            007F7F7F000000FFFFFF000000FFFFFF00000000FF00000000FFFFFF00FF0000
            FF00007F0000FF0000000000FF00000000BFBFBF000000FFFFFF000000FFFFFF
            7F7F7FFFFFFF000000000000FFFFFFFFFFFF00FF00000000000000FFFFFF7F7F
            7FBFBFBF000000FFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
            0000000000000000FFFFFF000000BFBFBF000000FFFFFFFFFFFFFFFFFF000000
            FFFFFFBFBFBF000000FFFFFF00FF00FFFFFF00FF00FFFFFF000000BFBFBFBFBF
            BF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFBFBFBF7F7F7F00000000
            00000000007F7F7FBFBFBFBFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000000000FFFFFFFFFFFFFFFFFFBFBFBFBFBFBF000000000000FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
            0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentFont = False
          TabOrder = 0
          OnClick = btnConfAvviaClick
        end
        object btnConfArresta: TBitBtn
          Left = 313
          Top = 51
          Width = 300
          Height = 25
          Caption = 'Arresta servizio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
            0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000000000BFBFBFBFBFBF7F7F7F7F7F7F7F7F7F000000000000FFFF
            FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000BFBFBFBFBFBF7F7F7F00000000
            00000000007F7F7F7F7F7F7F7F7F000000FFFFFFFFFFFFFFFFFFFFFFFF000000
            BFBFBFBFBFBF000000FFFFFF0000FFFFFFFF0000FFFFFFFF0000007F7F7F7F7F
            7F000000FFFFFFFFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
            0000000000000000FFFFFF0000007F7F7F000000FFFFFFFFFFFF000000BFBFBF
            7F7F7FFFFFFF0000000000000000FF00007F00007F000000000000FFFFFF7F7F
            7F7F7F7F000000FFFFFF000000BFBFBF0000000000FF0000000000FF00007F00
            00FF00007F00007F0000000000FF0000007F7F7F000000FFFFFF000000FFFFFF
            000000FFFFFF0000000000FF0000FF0000FF0000FF00007F000000FFFFFF0000
            007F7F7F000000FFFFFF000000FFFFFF0000000000FF000000FFFFFF0000FF00
            00FF00007F0000FF0000000000FF000000BFBFBF000000FFFFFF000000FFFFFF
            7F7F7FFFFFFF000000000000FFFFFFFFFFFF0000FF000000000000FFFFFF7F7F
            7FBFBFBF000000FFFFFFFFFFFF000000BFBFBF000000FFFFFF00000000000000
            0000000000000000FFFFFF000000BFBFBF000000FFFFFFFFFFFFFFFFFF000000
            FFFFFFBFBFBF000000FFFFFF0000FFFFFFFF0000FFFFFFFF000000BFBFBFBFBF
            BF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFBFBFBF7F7F7F00000000
            00000000007F7F7FBFBFBFBFBFBF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000000000FFFFFFFFFFFFFFFFFFBFBFBFBFBFBF000000000000FFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000
            0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          ParentFont = False
          TabOrder = 1
          OnClick = btnConfArrestaClick
        end
        object btnConfDisinstalla: TBitBtn
          Left = 7
          Top = 51
          Width = 300
          Height = 25
          Caption = 'Disinstalla servizio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFF88FFFFFFF
            FFFFFF9118FFFFF98FFFFF91118FFF9118FFFF911118F911118FFFF911118111
            118FFFFF9111111118FFFFFFF91111118FFFFFFFFF111118FFFFFFFFFF911118
            FFFFFFFFF9111118FFFFFFFF911181118FFFFFF91118F91118FFFFF9118FFF91
            118FFFFF91FFFFF9111FFFFFFFFFFFFF919FFFFFFFFFFFFFFFFF}
          ParentFont = False
          TabOrder = 2
          OnClick = btnConfDisinstallaClick
        end
        object btnConfInstalla: TBitBtn
          Left = 8
          Top = 23
          Width = 299
          Height = 25
          Caption = 'Installa servizio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFF00000FF
            FFFFFFFF0BF3330FFFFF00000FB3000000FFBFF00BF0BF33330FFBBFBFBBFB33
            330F0FFB330BB03000FF0BB3B330F000000FBFF30B30BFB33330FBB30F30FBF3
            33303FF3F330B000000F3BBF330BF03000FFBFFBFBFBBF33330FFBB00FB0FB33
            330F33303BF3000000FFFFFF3FB3330FFFFFFFFFF33000FFFFFF}
          ParentFont = False
          TabOrder = 3
          OnClick = btnConfInstallaClick
        end
      end
      object grpConfConfAziendale: TGroupBox
        Left = 3
        Top = 207
        Width = 622
        Height = 162
        Caption = 'Configurazione aziendale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object lblConfURL: TLabel
          Left = 10
          Top = 55
          Width = 77
          Height = 13
          Caption = 'URL del servizio'
        end
        object lblConfPath: TLabel
          Left = 9
          Top = 83
          Width = 188
          Height = 31
          AutoSize = False
          Caption = 'Path dello storage dove registrare gli allegati'
          WordWrap = True
        end
        object lblConfInfoAz: TLabel
          Left = 7
          Top = 20
          Width = 600
          Height = 34
          AutoSize = False
          Caption = 
            'Parametri utilizzati dai client (IrisWin, IrisWeb e IrisCloud) p' +
            'er l'#39'accesso al servizio e per la posizione di salvataggio dei d' +
            'ocumenti'
          WordWrap = True
        end
        object lblConfInfoParamAzPerm: TLabel
          Left = 56
          Top = 131
          Width = 477
          Height = 18
          Alignment = taRightJustify
          AutoSize = False
          Caption = 
            'Effettuare l'#39'accesso come utente abilitato alla modifica su A008' +
            ' per modificare queste impostazioni.'
          WordWrap = True
        end
        object edtConfURL: TEdit
          Left = 203
          Top = 52
          Width = 404
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = 'edtConfURL'
        end
        object rgpConfPathDB: TRadioButton
          Left = 203
          Top = 77
          Width = 49
          Height = 17
          Caption = 'DB'
          TabOrder = 1
          OnClick = OnRgpConfPathClick
        end
        object rgpConfPathFS: TRadioButton
          Left = 203
          Top = 100
          Width = 79
          Height = 17
          Caption = 'File system'
          TabOrder = 2
          OnClick = OnRgpConfPathClick
        end
        object edtConfPathFS: TEdit
          Left = 288
          Top = 97
          Width = 318
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = 'edtConfPathFS'
        end
        object btnConfSalva: TButton
          Left = 540
          Top = 126
          Width = 73
          Height = 25
          Caption = 'Salva'
          TabOrder = 4
          OnClick = btnConfSalvaClick
        end
      end
      object grpConfConfServizio: TGroupBox
        Left = 3
        Top = 375
        Width = 622
        Height = 114
        Caption = 'Configurazione servizio B021'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object lblConfServPorta: TLabel
          Left = 8
          Top = 54
          Width = 73
          Height = 13
          Caption = 'Porta di ascolto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblConfInfoServ: TLabel
          Left = 7
          Top = 16
          Width = 599
          Height = 30
          AutoSize = False
          Caption = 
            'Porta di ascolto del servizio B021 per richieste HTTP in ingress' +
            'o. Questa impostazione '#232' salvata sul registro di sistema e viene' +
            ' utilizzata solo dal servizio di Windows B021 (se B021 '#232' in esec' +
            'uzione come ISAPI la porta di ascolto va impostata su IIS)'
          WordWrap = True
        end
        object lblConfInfoConfServPerm: TLabel
          Left = 147
          Top = 83
          Width = 383
          Height = 13
          Alignment = taRightJustify
          Caption = 
            'Avviare questo programma come amministratore per modificare la p' +
            'orta di ascolto.'
        end
        object btnConfServSalva: TButton
          Left = 539
          Top = 78
          Width = 74
          Height = 25
          Caption = 'Salva'
          TabOrder = 0
          OnClick = btnConfServSalvaClick
        end
        object edtConfServPorta: TMaskEdit
          Left = 87
          Top = 51
          Width = 78
          Height = 21
          EditMask = '!99999;1; '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 1
          Text = '     '
        end
      end
    end
    object tsSpostaDocumenti: TTabSheet
      Caption = 'Sposta documenti'
      ImageIndex = 1
      object pnlFiltri: TPanel
        Left = 0
        Top = 0
        Width = 636
        Height = 99
        Align = alTop
        TabOrder = 0
        object chkPathStorage: TCheckListBox
          Left = 1
          Top = 1
          Width = 518
          Height = 97
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
        object pnlPeriodo: TPanel
          Left = 519
          Top = 1
          Width = 116
          Height = 97
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object lblPeriodoDal: TLabel
            Left = 8
            Top = 10
            Width = 19
            Height = 13
            Caption = 'Dal:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object lblPeriodoAl: TLabel
            Left = 15
            Top = 37
            Width = 12
            Height = 13
            Caption = 'Al:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object btnApplicaFiltri: TButton
            Left = 35
            Top = 61
            Width = 67
            Height = 25
            Action = actApplicaFiltri
            TabOrder = 2
          end
          object edtPeriodoDal: TMaskEdit
            Left = 35
            Top = 7
            Width = 67
            Height = 21
            EditMask = '!00/00/0000;1;_'
            MaxLength = 10
            TabOrder = 0
            Text = '01/01/2017'
          end
          object edtPeriodoAl: TMaskEdit
            Left = 35
            Top = 34
            Width = 67
            Height = 21
            EditMask = '!00/00/0000;1;_'
            MaxLength = 10
            TabOrder = 1
            Text = '31/12/2017'
          end
        end
      end
      object dbgT960: TDBGrid
        Left = 0
        Top = 99
        Width = 636
        Height = 353
        Align = alClient
        DataSource = B022FUtilityGestDocumentaleDM.dsrT960
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
      object pnlElaborazione: TPanel
        Left = 0
        Top = 452
        Width = 636
        Height = 125
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object lblPathAllegati: TLabel
          Left = 190
          Top = 45
          Width = 196
          Height = 13
          Caption = 'Area di storage dove registrare gli allegati:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblNuovoPathStorage: TLabel
          Left = 190
          Top = 82
          Width = 108
          Height = 13
          Caption = 'Nuova area di storage:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblURLServizio: TLabel
          Left = 190
          Top = 6
          Width = 63
          Height = 13
          Caption = 'URL servizio:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblFilesSelezionati: TLabel
          Left = 528
          Top = 16
          Width = 82
          Height = 13
          Caption = 'Files selezionati: -'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblDimensioneTotale: TLabel
          Left = 528
          Top = 35
          Width = 93
          Height = 13
          Caption = 'Dimensione totale: -'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnEsegui: TBitBtn
          Left = 4
          Top = 94
          Width = 75
          Height = 25
          Action = actEsegui
          Caption = 'Esegui'
          Default = True
          Enabled = False
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
            8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
            3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
            FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
            FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
          TabOrder = 7
        end
        object btnAnomalie: TBitBtn
          Left = 97
          Top = 94
          Width = 75
          Height = 25
          Action = actAnomalie
          Caption = 'Anomalie'
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            04000000000068010000120B0000120B00001000000010000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333330000333333333333333333333333333333333333
            0000333333333933333333333333333833333333000033333BFB999BFB333333
            333F3F080F3F333300003333BFBF393FBFB33333337F7F383F7F73330000333B
            FBFBFBFBFBFB33333FFFFFF7FFF7FF3300003333BFBFB9BFBFB33333337F7F78
            7F7FF3330000333BFBFBF98BFBFB333337FFF7F887FFF733000033BFBFBFB99F
            BFBFB333FF7FFFF08FFF7FF3000033FBFBFBFB99FBFB3333F7FFF7F780F7FF33
            000033BFBF88BF899FBFB333FFFF88FF808F7F730000333BFB99FB899BFB3333
            37F7087F8887FF3300003333BF998F899FB3333333FF888F880F73330000333B
            FBF99999FBFB33333FF7F08080FFFF3300003333BFBF999FBFB33333337FFF80
            8F7F7333000033333B3BFBFB3B333333333F37FFF73F3333000033333333BFB3
            33333333333333FF733333330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
          TabOrder = 8
        end
        object edtNuovoPath: TEdit
          Left = 190
          Top = 98
          Width = 240
          Height = 21
          TabOrder = 5
        end
        object edtPathAzienda: TEdit
          Left = 190
          Top = 60
          Width = 240
          Height = 21
          Color = clSilver
          ReadOnly = True
          TabOrder = 3
        end
        object edtURLServizio: TEdit
          Left = 190
          Top = 22
          Width = 240
          Height = 21
          Color = clSilver
          ReadOnly = True
          TabOrder = 1
        end
        object btnTestServizio: TButton
          Left = 436
          Top = 20
          Width = 75
          Height = 25
          Action = actTestServizio
          TabOrder = 2
        end
        object rgpElaborazione: TRadioGroup
          Left = 4
          Top = 4
          Width = 168
          Height = 84
          Caption = 'Tipo di elaborazione:'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Items.Strings = (
            'Database   -> File system'
            'File system -> Database'
            'File system -> File system')
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          TabOrder = 0
          OnClick = rgpElaborazioneClick
        end
        object btnTestAccessoNuovoPath: TButton
          Left = 436
          Top = 96
          Width = 75
          Height = 25
          Action = actTestAccessoNuovoPath
          TabOrder = 6
        end
        object btnAccessoPathAzienda: TButton
          Left = 436
          Top = 58
          Width = 75
          Height = 25
          Action = actTestAccessoPathAzienda
          TabOrder = 4
        end
      end
      object ProgressBar: TProgressBar
        Left = 0
        Top = 577
        Width = 636
        Height = 16
        Align = alBottom
        Step = 1
        TabOrder = 3
      end
    end
    object tsImportaDaFS: TTabSheet
      Caption = 'Importa documenti da file system'
      ImageIndex = 2
      object pnlImpImposta: TPanel
        Left = 0
        Top = 0
        Width = 636
        Height = 473
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lblmpPath: TLabel
          Left = 8
          Top = 8
          Width = 135
          Height = 13
          Alignment = taRightJustify
          Caption = 'Path documenti da importare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpFiltro: TLabel
          Left = 8
          Top = 32
          Width = 22
          Height = 13
          Caption = 'Filtro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpFormato: TLabel
          Left = 8
          Top = 56
          Width = 136
          Height = 13
          Caption = 'Formato nome file in ingresso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpTipologia: TLabel
          Left = 8
          Top = 199
          Width = 43
          Height = 13
          Caption = 'Tipologia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpRiferitiAl: TLabel
          Left = 257
          Top = 308
          Width = 8
          Height = 13
          Caption = 'al'
        end
        object lblImpRiferiti: TLabel
          Left = 8
          Top = 309
          Width = 95
          Height = 13
          Caption = 'Riferiti al periodo dal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpNote: TLabel
          Left = 8
          Top = 333
          Width = 23
          Height = 13
          Caption = 'Note'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpStato: TLabel
          Left = 149
          Top = 440
          Width = 476
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          Caption = '{STATO}'
        end
        object lblImpUfficio: TLabel
          Left = 8
          Top = 282
          Width = 30
          Height = 13
          Caption = 'Ufficio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpSeparatore: TLabel
          Left = 184
          Top = 56
          Width = 83
          Height = 13
          Caption = 'Separatore campi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpNomeFile: TLabel
          Left = 184
          Top = 79
          Width = 61
          Height = 13
          Caption = 'Nome dei file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 184
          Top = 103
          Width = 246
          Height = 13
          Caption = 'Per informazioni sul formato consultare l'#39'help in linea.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpNomeFileOut: TLabel
          Left = 8
          Top = 125
          Width = 139
          Height = 13
          Caption = 'Nome dei file su documentale'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edtImpPath: TEdit
          Left = 184
          Top = 5
          Width = 415
          Height = 21
          TabOrder = 0
          OnChange = edtImpPathChange
        end
        object btnImpPathBrowse: TButton
          Left = 605
          Top = 5
          Width = 20
          Height = 21
          Caption = '...'
          TabOrder = 1
          OnClick = btnImpPathBrowseClick
        end
        object edtImpFiltro: TEdit
          Left = 184
          Top = 29
          Width = 76
          Height = 21
          TabOrder = 2
          Text = '*.*'
          OnChange = edtImpFiltroChange
        end
        object memNote: TMemo
          Left = 184
          Top = 330
          Width = 441
          Height = 76
          ScrollBars = ssBoth
          TabOrder = 3
        end
        object chkImpVisualIrisWeb: TCheckBox
          Left = 8
          Top = 410
          Width = 188
          Height = 17
          Alignment = taLeftJustify
          Caption = 'Visualizzabile dal portale IrisWeb'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object btnImpAnalizza: TButton
          Left = 8
          Top = 435
          Width = 135
          Height = 25
          Caption = 'Analizza documenti'
          TabOrder = 5
          OnClick = btnImpAnalizzaClick
        end
        object dcmbImpTipologia: TDBLookupComboBox
          Left = 184
          Top = 194
          Width = 233
          Height = 21
          KeyField = 'CODICE'
          ListField = 'DESCRIZIONE'
          ListSource = B022FUtilityGestDocumentaleDM.dsrT962
          TabOrder = 6
        end
        object edtImpPeriodoDal: TMaskEdit
          Left = 184
          Top = 305
          Width = 65
          Height = 21
          EditMask = '!99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 7
          Text = '  /  /    '
          OnExit = OnEdtImpPeriodoExit
        end
        object edtImpPeriodoAl: TMaskEdit
          Left = 271
          Top = 305
          Width = 64
          Height = 21
          EditMask = '!99/99/9999;1;_'
          MaxLength = 10
          TabOrder = 8
          Text = '  /  /    '
          OnExit = OnEdtImpPeriodoExit
        end
        object dcmbImpUfficio: TDBLookupComboBox
          Left = 184
          Top = 278
          Width = 233
          Height = 21
          KeyField = 'CODICE'
          ListField = 'DESCRIZIONE'
          ListSource = B022FUtilityGestDocumentaleDM.dsrT963
          TabOrder = 9
        end
        object edtImpSeparatore: TEdit
          Left = 273
          Top = 53
          Width = 32
          Height = 21
          MaxLength = 1
          TabOrder = 10
          Text = '_'
          OnChange = OnEdtImpFormatiChange
        end
        object edtImpNomeFile: TEdit
          Left = 273
          Top = 76
          Width = 352
          Height = 21
          TabOrder = 11
          Text = '<MATRICOLA>_<NOME_DEL_FILE>'
          OnChange = OnEdtImpFormatiChange
        end
        object Panel1: TPanel
          Left = 178
          Top = 122
          Width = 463
          Height = 71
          BevelOuter = bvNone
          TabOrder = 12
          object lblImpNomeFileExt: TLabel
            Left = 430
            Top = 28
            Width = 17
            Height = 13
            Caption = '.ext'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object rgpImpNomeFileOutOrig: TRadioButton
            Left = 6
            Top = 1
            Width = 241
            Height = 17
            Caption = 'Stesso nome del file originale su file system'
            Checked = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TabStop = True
            OnClick = OnRgpImpNomeFileOutClick
          end
          object rgpImpNomeFileOutPred: TRadioButton
            Left = 6
            Top = 24
            Width = 113
            Height = 17
            Caption = 'Predefinito:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = OnRgpImpNomeFileOutClick
          end
          object rgpImpNomeFileOutTag: TRadioButton
            Left = 6
            Top = 47
            Width = 241
            Height = 17
            Caption = '<NOME_DEL_FILE> da file originale'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = OnRgpImpNomeFileOutClick
          end
          object edtImpNomeFileOutPred: TEdit
            Left = 82
            Top = 23
            Width = 346
            Height = 21
            TabOrder = 3
            OnChange = OnEdtImpFormatiChange
          end
        end
        object rgpImpAzioneDocTip: TRadioGroup
          Left = 184
          Top = 221
          Width = 441
          Height = 52
          Caption = 'Se esiste gi'#224' un documento di questa tipologia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            'Aggiungi il nuovo documento mantenendo quello esistente'
            'Sovrascrivi il documento esistente')
          ParentFont = False
          TabOrder = 13
        end
      end
      object pnlImpComandi: TPanel
        Left = 0
        Top = 539
        Width = 636
        Height = 37
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object lblImpFilesSelezionati: TLabel
          Left = 335
          Top = 12
          Width = 82
          Height = 13
          Caption = 'Files selezionati: -'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object lblImpDimensTotale: TLabel
          Left = 472
          Top = 12
          Width = 93
          Height = 13
          Caption = 'Dimensione totale: -'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object btnImpAnomalie: TBitBtn
          Left = 111
          Top = 6
          Width = 154
          Height = 25
          Action = actAnomalie
          Caption = 'Messaggi elaborazione'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F7F7F00
            00FF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF00FFFFFFFFFF00FFFF0000FF0000FF0000FF00FFFFFFFFFF00FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF7F7F7F00
            00FF7F7F7FFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00
            00FF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFF00FFFFFFFFFF00FFFFFFFFFF0000FF7F7F7F00FFFFFFFFFF00FFFFFFFF
            FF00FFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF00
            00FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFF00FFFF
            FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFF0000FF0000FFFFFFFF00FFFFFFFF
            FF00FFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF7F7F7F7F7F7F00FFFFFF
            FFFF7F7F7F0000FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFF00FFFF
            FFFFFF00FFFF0000FF0000FFFFFFFF00FFFF7F7F7F0000FF0000FF00FFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF0000FF0000FF7F7F7FFF
            FFFF7F7F7F0000FF0000FFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
            FFFFFF00FFFFFFFFFF0000FF0000FF0000FF0000FF0000FFFFFFFF00FFFFFFFF
            FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF0000FF00
            00FF0000FFFFFFFF00FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFFFF00FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFF
            FFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          TabOrder = 0
        end
        object btnImpEsegui: TBitBtn
          Left = 3
          Top = 6
          Width = 106
          Height = 25
          Caption = 'Esegui'
          Enabled = False
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
          OnClick = btnImpEseguiClick
        end
      end
      object prgImp: TProgressBar
        Left = 0
        Top = 576
        Width = 636
        Height = 17
        Align = alBottom
        Step = 1
        TabOrder = 2
      end
      object pnlImpDocDaImportare: TPanel
        Left = 0
        Top = 473
        Width = 636
        Height = 66
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 3
        object Splitter1: TSplitter
          Left = 315
          Top = 0
          Height = 66
          Align = alRight
          ExplicitLeft = 328
          ExplicitTop = 64
          ExplicitHeight = 100
        end
        object grpImpDocDaImportare: TGroupBox
          Left = 0
          Top = 0
          Width = 315
          Height = 66
          Align = alClient
          Caption = 'Documenti da importare'
          TabOrder = 0
          object chkImpDocDaImportare: TCheckListBox
            Left = 2
            Top = 15
            Width = 311
            Height = 49
            OnClickCheck = chkImpDocDaImportareClickCheck
            Align = alClient
            ItemHeight = 13
            PopupMenu = pmnImpDocDaImportare
            TabOrder = 0
          end
        end
        object grpImpDocIgnorati: TGroupBox
          Left = 318
          Top = 0
          Width = 318
          Height = 66
          Align = alRight
          Caption = 'File ignorati'
          TabOrder = 1
          object lstImpDocIgnorati: TListBox
            Left = 2
            Top = 15
            Width = 314
            Height = 49
            Align = alClient
            ItemHeight = 13
            PopupMenu = pmnImpFileIgnorati
            TabOrder = 0
          end
        end
      end
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 644
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 644
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 644
      Height = 24
      ExplicitWidth = 644
      ExplicitHeight = 24
      inherited lblDipendente: TLabel
        Left = 182
        Top = 6
        ExplicitLeft = 182
        ExplicitTop = 6
      end
    end
  end
  object chkFiltroAnagrafe: TCheckBox
    Left = 27
    Top = 4
    Width = 213
    Height = 17
    Caption = 'Filtra sulla selezione anagrafica corrente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = chkFiltroAnagrafeClick
  end
  object actlst: TActionList
    Left = 448
    object actApplicaFiltri: TAction
      Caption = 'Applica filtri'
      OnExecute = actApplicaFiltriExecute
    end
    object actTestServizio: TAction
      Caption = 'Test servizio'
      OnExecute = actTestServizioExecute
    end
    object actTestAccessoNuovoPath: TAction
      Caption = 'Test accesso'
      OnExecute = actTestAccessoNuovoPathExecute
    end
    object actEsegui: TAction
      Caption = 'Esegui'
      OnExecute = actEseguiExecute
    end
    object actAnomalie: TAction
      Caption = 'Anomalie'
      OnExecute = actAnomalieExecute
    end
    object actTestAccessoPathAzienda: TAction
      Caption = 'Test accesso'
      OnExecute = actTestAccessoPathAziendaExecute
    end
    object Action1: TAction
      Caption = 'Action1'
    end
    object Action2: TAction
      Caption = 'Action2'
    end
  end
  object ImageList: TImageList
    Left = 488
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF0000000000008080000080800000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BFBFBF00BFBFBF007F7F7F007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00008080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F0000000000000000000000000000000000000000000000000000000000BFBF
      BF00BFBFBF007F7F7F000000000000000000000000007F7F7F007F7F7F007F7F
      7F00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      00000000000000FFFF00000000000000000000FFFF0000000000008080000080
      8000008080000080800000000000000000000000000000000000BFBFBF00BFBF
      BF00000000000000000000FF00000000000000FF000000000000000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000BFBFBF00BFBF
      BF0000000000000000000000FF00000000000000FF0000000000000000007F7F
      7F007F7F7F000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      000000FFFF000000000000FFFF0000FFFF000000000000FFFF00008080000080
      8000008080000080800000000000000000000000000000000000BFBFBF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000BFBFBF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000808000008080000000000000FFFF0000FFFF0000000000008080000000
      00000000000000000000000000000000000000000000BFBFBF007F7F7F000000
      0000000000000000000000FF0000007F0000007F000000000000000000000000
      00007F7F7F007F7F7F00000000000000000000000000BFBFBF007F7F7F000000
      000000000000000000000000FF0000007F0000007F0000000000000000000000
      00007F7F7F007F7F7F0000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000080
      800000FFFF000080800000808000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BFBFBF000000000000FF
      00000000000000FF0000007F000000FF0000007F0000007F00000000000000FF
      0000000000007F7F7F00000000000000000000000000BFBFBF00000000000000
      FF00000000000000FF0000007F000000FF0000007F0000007F00000000000000
      FF00000000007F7F7F0000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      00000000000000000000000000000000000000FFFF0000000000000000000080
      80000000000000FFFF00008080000000000000FFFF000000000000FFFF000080
      8000008080000080800000808000000000000000000000000000000000000000
      00000000000000FF000000FF000000FF000000FF0000007F0000000000000000
      0000000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000007F00000000000000
      0000000000007F7F7F0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000080
      8000000000000000000000808000000000000000000000FFFF00000000000080
      80000080800000808000008080000000000000000000000000000000000000FF
      0000000000000000000000FF000000FF0000007F000000FF00000000000000FF
      000000000000BFBFBF0000000000000000000000000000000000000000000000
      FF0000000000000000000000FF000000FF0000007F000000FF00000000000000
      FF0000000000BFBFBF0000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000080800000000000000000000080
      80000000000000808000008080000000000000FFFF0000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      00000000000000000000000000000000000000FF000000000000000000000000
      00007F7F7F00BFBFBF00000000000000000000000000000000007F7F7F000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00007F7F7F00BFBFBF0000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000080800000FFFF0000FFFF000000
      000000808000008080000000000000FFFF000000000000000000008080000000
      0000000000000000000000000000000000000000000000000000BFBFBF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBF000000000000000000000000000000000000000000BFBFBF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBF000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      00000000000000000000000000000000000000FFFF00000000000000000000FF
      FF000000000000FFFF000000000000FFFF0000FFFF0000000000008080000080
      800000808000008080000000000000000000000000000000000000000000BFBF
      BF00000000000000000000FF00000000000000FF00000000000000000000BFBF
      BF00BFBFBF00000000000000000000000000000000000000000000000000BFBF
      BF0000000000000000000000FF00000000000000FF000000000000000000BFBF
      BF00BFBFBF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF000000
      0000000000000000000000FFFF00000000000000000000FFFF00008080000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      0000BFBFBF007F7F7F000000000000000000000000007F7F7F00BFBFBF00BFBF
      BF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000080800000808000008080000000
      00000080800000FFFF0000000000008080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFBFBF00BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFBFBF00BFBFBF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000008080000000000000FFFF00008080000080800000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000808000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFC7FF83FF83FF83FFC7FF21F
      E00FE00BFC7F0403C007C007FC7F624185438543FC7F948188238823FC7F6003
      10111011E00F008100010001E00F604050115011F01F84A044014401F01F6801
      53115311F83F108388238823F83F6A41A543A543FC7F8481D007D007FC7F0203
      E70FE70FFEFFF41FF83FF83FFEFFF83F00000000000000000000000000000000
      000000000000}
  end
  object pmnImpDocDaImportare: TPopupMenu
    Left = 532
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
  end
  object pmnImpFileIgnorati: TPopupMenu
    Left = 576
    object Copianegliappunti1: TMenuItem
      Caption = 'Copia contenuto negli appunti'
      OnClick = Copianegliappunti1Click
    end
  end
end
