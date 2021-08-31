object A045FDialogStampa: TA045FDialogStampa
  Left = 203
  Top = 126
  HelpContext = 45000
  Caption = '<A045> Statistica ministeriale assenze'
  ClientHeight = 573
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 538
    Width = 642
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object ProgressBar1: TProgressBar
      Left = 0
      Top = 0
      Width = 642
      Height = 16
      Align = alClient
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 354
    Width = 642
    Height = 146
    Align = alBottom
    TabOrder = 1
    object lblFile: TLabel
      Left = 157
      Top = 80
      Width = 90
      Height = 13
      Caption = 'File di esportazione'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object chkElabora: TCheckBox
      Left = 15
      Top = 10
      Width = 97
      Height = 17
      Caption = 'Elaborazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkElaboraClick
    end
    object chkEsportaFile: TCheckBox
      Left = 15
      Top = 79
      Width = 112
      Height = 17
      Caption = 'Esportazione su file'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnClick = chkEsportaFileClick
    end
    object GroupBox1: TGroupBox
      Left = 485
      Top = 6
      Width = 134
      Height = 62
      Caption = 'Dati aziendali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      Visible = False
      object lblCodRegione: TLabel
        Left = 8
        Top = 17
        Width = 71
        Height = 13
        Caption = 'Codice regione'
        Enabled = False
      end
      object lblCodAzienda: TLabel
        Left = 9
        Top = 40
        Width = 73
        Height = 13
        Caption = 'Codice azienda'
        Enabled = False
      end
      object EdtCodRegione: TEdit
        Left = 88
        Top = 13
        Width = 37
        Height = 21
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
      end
      object EdtCodAzienda: TEdit
        Left = 88
        Top = 36
        Width = 37
        Height = 21
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 1
      end
    end
    object edtFile: TEdit
      Left = 252
      Top = 77
      Width = 349
      Height = 21
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 7
      Visible = False
    end
    object btnFile: TBitBtn
      Left = 602
      Top = 76
      Width = 17
      Height = 23
      Caption = '...'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      Visible = False
      OnClick = btnFileClick
    end
    object chkStampa: TCheckBox
      Left = 15
      Top = 56
      Width = 103
      Height = 17
      Caption = 'Stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkStampaClick
    end
    object chkAnteprima: TCheckBox
      Left = 15
      Top = 33
      Width = 88
      Height = 17
      Caption = 'Anteprima'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = chkAnteprimaClick
    end
    object rgpComparto: TRadioGroup
      Left = 365
      Top = 6
      Width = 106
      Height = 62
      Caption = 'Comparto contratt.'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Sanit'#224
        'Enti Locali')
      ParentFont = False
      TabOrder = 5
      Visible = False
    end
    object rgpTipoOperaz: TRadioGroup
      Left = 252
      Top = 6
      Width = 107
      Height = 62
      Caption = 'Tipo di operazione'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 1
      Items.Strings = (
        'Acquisizione'
        'Aggiornamento'
        'Cancellazione')
      ParentFont = False
      TabOrder = 4
      Visible = False
    end
    object btnDisattivaElaborazioni: TBitBtn
      Left = 252
      Top = 111
      Width = 147
      Height = 25
      Caption = 'Te&rmina elaborazione'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        77777FFFFFFFFFFFFFF777777777777777F77999FFFFFFFF9997799999FFFF99
        999778999999999999F7780F99999999F7F7780FF999999FF7F7780999999999
        97F77999999FF999999779999FFFFFF99997799FFFFFFFFFF997780FFFFFFFFF
        F7F7780000000000F7F778888888888887F77777777777777777}
      TabOrder = 9
      OnClick = btnDisattivaElaborazioniClick
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 642
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 642
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 642
      Height = 24
      ExplicitWidth = 642
      ExplicitHeight = 24
      inherited btnPrimo: TSpeedButton
        OnClick = frmSelAnagrafebtnPrimoClick
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
      inherited btnRicerca: TBitBtn
        OnClick = frmSelAnagrafebtnRicercaClick
      end
      inherited btnEreditaSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnEreditaSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      Left = 296
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 554
    Width = 642
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object Panel3: TPanel
    Left = 0
    Top = 500
    Width = 642
    Height = 38
    Align = alBottom
    TabOrder = 4
    object BitBtn7: TBitBtn
      Left = 519
      Top = 5
      Width = 100
      Height = 26
      Caption = '&Chiudi'
      Kind = bkClose
      TabOrder = 0
    end
    object btnVisualizzaFile: TBitBtn
      Left = 252
      Top = 5
      Width = 100
      Height = 26
      Caption = 'Visualizza file'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
      TabOrder = 1
      OnClick = btnVisualizzaFileClick
    end
    object btnEsegui: TBitBtn
      Left = 134
      Top = 5
      Width = 100
      Height = 26
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
      TabOrder = 2
      OnClick = btnEseguiClick
    end
    object BtnPrinterSetUp: TBitBtn
      Left = 15
      Top = 5
      Width = 100
      Height = 26
      Caption = 'S&tampante'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FF0000000000
        0FFFF0777777777070FF000000000000070F0778777BBB87000F077887788887
        070F00000000000007700778888778807070F000000000070700FF0777777770
        7070FFF077777776EEE0F8000000000E6008F0E6EEEEEEEE0FFFF8000000000E
        6008FFFF07777786EEE0FFFFF00000080008FFFFFFFFFFFFFFFF}
      TabOrder = 3
      OnClick = BtnPrinterSetUpClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 24
    Width = 642
    Height = 33
    Align = alTop
    TabOrder = 5
    object Label2: TLabel
      Left = 271
      Top = 10
      Width = 41
      Height = 13
      Caption = 'Alla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 109
      Top = 10
      Width = 48
      Height = 13
      Caption = 'Dalla data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object BitBtn2: TBitBtn
      Left = 388
      Top = 5
      Width = 15
      Height = 23
      Caption = '...'
      TabOrder = 0
      OnClick = BtnADataClick
    end
    object edtAData: TMaskEdit
      Left = 319
      Top = 6
      Width = 68
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      OnExit = edtDaDataExit
    end
    object BitBtn1: TBitBtn
      Left = 234
      Top = 5
      Width = 15
      Height = 23
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BtnDaDataClick
    end
    object edtDaData: TMaskEdit
      Left = 166
      Top = 6
      Width = 68
      Height = 21
      EditMask = '!00/00/0000;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
      OnExit = edtDaDataExit
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 57
    Width = 642
    Height = 297
    ActivePage = TabSheet3
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    object TabSheet3: TTabSheet
      Caption = 'Parametri da applicare'
      ImageIndex = 2
      object Label3: TLabel
        Left = 11
        Top = 78
        Width = 120
        Height = 13
        Caption = 'Causali per la Formazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object chkGGLavorativi: TCheckBox
        Left = 11
        Top = 13
        Width = 183
        Height = 13
        Caption = 'Contabilizza solo giorni lavorativi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object ChkAssTutte: TCheckBox
        Left = 11
        Top = 31
        Width = 265
        Height = 17
        Caption = 'Rapporta gg.ass.al dovuto teorico giornaliero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = ChkAssTutteClick
      end
      object chkSantoPatrono: TCheckBox
        Left = 11
        Top = 52
        Width = 265
        Height = 17
        Caption = 'Includi Santo patrono nel raggruppamento Ferie'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = ChkAssTutteClick
      end
      object ChkPartOr: TCheckBox
        Left = 278
        Top = 31
        Width = 288
        Height = 17
        Caption = 'Rapporta gg.ass. alla % part-time per tipo part-time orizz.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = ChkPartOrClick
      end
      object ChkContNumDip: TCheckBox
        Left = 278
        Top = 13
        Width = 167
        Height = 13
        Caption = 'Contabilizza numero dipendenti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtCausali: TEdit
        Left = 140
        Top = 75
        Width = 457
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 3
        ParentFont = False
        TabOrder = 5
      end
      object PgcArrotondamenti: TPageControl
        Left = 0
        Top = 166
        Width = 634
        Height = 103
        ActivePage = TabTotaleAssenzeQualifica
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        object TabAssenzeRilevate: TTabSheet
          Caption = 'ad ogni assenza'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          object rgpArrotondamentoAssenza: TRadioGroup
            Left = 7
            Top = 0
            Width = 344
            Height = 75
            Caption = 'Arrotondamento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Nessun arrotondamento'
              'Arrotondamento alla giornata'
              'Arrotondamento alla mezza giornata'
              'Arrotondamento all'#39'ora')
            ParentFont = False
            TabOrder = 0
            OnClick = rgpArrotondamentoAssenzaClick
          end
          object rgpTipoArrotondamentoAssenza: TRadioGroup
            Left = 361
            Top = 0
            Width = 120
            Height = 75
            Caption = 'Tipo arrotondamento '
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 2
            Items.Strings = (
              'Per eccesso'
              'Per difetto'
              'Puro')
            ParentFont = False
            TabOrder = 1
          end
        end
        object TabTotaleAssenzeDipendente: TTabSheet
          Caption = 'al tot.ass. per dip. (Tabella)'
          ImageIndex = 1
          object RgpArrotondamentoTotale: TRadioGroup
            Left = 7
            Top = 0
            Width = 344
            Height = 75
            Caption = 'Arrotondamento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              'Nessun arrotondamento'
              'Arrotondamento alla giornata'
              'Arrotondamento alla mezza giornata'
              'Arrotondamento all'#39'ora')
            ParentFont = False
            TabOrder = 0
            OnClick = RgpArrotondamentoTotaleClick
          end
          object RgpTipoArrotondamentoTotale: TRadioGroup
            Left = 361
            Top = 0
            Width = 120
            Height = 75
            Caption = 'Tipo arrotondamento '
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 2
            Items.Strings = (
              'Per eccesso'
              'Per difetto'
              'Puro')
            ParentFont = False
            TabOrder = 1
          end
        end
        object TabTotaleAssenzeQualifica: TTabSheet
          Caption = 'al tot.ass. per qual. (Stampa/File)'
          ImageIndex = 2
          object RgpArrotondamentoQualifica: TRadioGroup
            Left = 7
            Top = 0
            Width = 344
            Height = 75
            Caption = 'Arrotondamento'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 1
            Items.Strings = (
              'Nessun arrotondamento'
              'Arrotondamento alla giornata'
              'Arrotondamento alla mezza giornata')
            ParentFont = False
            TabOrder = 0
            OnClick = RgpArrotondamentoQualificaClick
          end
          object RgpTipoArrotondamentoQualifica: TRadioGroup
            Left = 361
            Top = 0
            Width = 120
            Height = 75
            Caption = 'Tipo arrotondamento '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ItemIndex = 2
            Items.Strings = (
              'Per eccesso'
              'Per difetto'
              'Puro')
            ParentFont = False
            TabOrder = 1
          end
        end
      end
      object btnCausali: TBitBtn
        Left = 598
        Top = 74
        Width = 17
        Height = 23
        Caption = '...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnCausaliClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Qualifiche ministeriali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      object LstListaCausali: TCheckListBox
        Left = 0
        Top = 0
        Width = 634
        Height = 269
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tipi rapporto'
      ImageIndex = 1
      object LstListaTipiRapporto: TCheckListBox
        Left = 0
        Top = 0
        Width = 634
        Height = 269
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 508
    Top = 91
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Invertiselezione1Click
    end
    object Deselezionatutto1: TMenuItem
      Caption = 'Deseleziona tutto'
      OnClick = Invertiselezione1Click
    end
    object Invertiselezione1: TMenuItem
      Caption = 'Inverti selezione'
      OnClick = Invertiselezione1Click
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 578
    Top = 280
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Text files (*.txt)|*.TXT'
    Left = 556
    Top = 272
  end
end
