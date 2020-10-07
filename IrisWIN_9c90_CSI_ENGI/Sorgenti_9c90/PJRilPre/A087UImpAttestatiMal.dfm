object A087FImpAttestatiMal: TA087FImpAttestatiMal
  Left = 0
  Top = 0
  Caption = '<A087> Importazione certificati di malattia'
  ClientHeight = 525
  ClientWidth = 878
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 878
    Height = 29
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 878
    inherited pnlSelAnagrafe: TPanel
      Width = 878
      ExplicitWidth = 878
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
      inherited btnEreditaSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnEreditaSelezioneClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 506
    Width = 878
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object dGrdProfili: TDBGrid
    Left = 0
    Top = 53
    Width = 878
    Height = 92
    Align = alTop
    DataSource = A087FImpAttestatiMalMW.dtsT269
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = ppMnuAccedi
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlRegoleInserimento: TPanel
    Left = 0
    Top = 29
    Width = 878
    Height = 24
    Align = alTop
    Caption = 'Profili di importazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object pgcINPS: TPageControl
    Left = 0
    Top = 145
    Width = 878
    Height = 361
    ActivePage = TabCertificatiXML
    Align = alClient
    TabOrder = 4
    OnChange = pgcINPSChange
    OnChanging = pgcINPSChanging
    object TabCertificatiXML: TTabSheet
      Caption = 'Importazione certificati INPS'
      object PrgBar1: TProgressBar
        Left = 0
        Top = 316
        Width = 870
        Height = 17
        Align = alBottom
        Step = 1
        TabOrder = 0
      end
      object pnlButton: TPanel
        Left = 0
        Top = 283
        Width = 870
        Height = 33
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          870
          33)
        object btnEsegui: TBitBtn
          Left = 0
          Top = 3
          Width = 90
          Height = 25
          Caption = 'Esegui'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
            8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
            3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
            FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
            FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
          TabOrder = 0
          OnClick = btnEseguiClick
        end
        object btnVisFile: TBitBtn
          Left = 109
          Top = 3
          Width = 90
          Height = 25
          Caption = 'Visualizza file'
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
          OnClick = btnVisFileClick
        end
        object btnAnomalie: TBitBtn
          Left = 217
          Top = 3
          Width = 90
          Height = 25
          Caption = 'Anomalie'
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
          TabOrder = 2
          OnClick = btnAnomalieClick
        end
        object btnChiudi: TBitBtn
          Left = 777
          Top = 3
          Width = 90
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Chiudi'
          Glyph.Data = {
            06010000424D0601000000000000760000002800000010000000120000000100
            04000000000090000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFF77
            F7F74444400FFFFFF444FFFF4D5007FFF4FFFFFF45D50FFFF4FFFFFF4D5D0FFF
            F4FFFFFF45D50FEFE4FFFFFF4D5D0FFFF4FFFFFF45D50FEFE4FFFFFF4D5D0FFF
            F4FFFFFF45D50FEFE4FFFFFF4D5D0EFEF4FFFFFF45D50FEFE4FFFFFF4D5D0EFE
            F4FFFFFF4444444444FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF0AAAA0
            FFFFFFFFFF000000FFFF}
          TabOrder = 3
          OnClick = btnChiudiClick
        end
      end
      object DBGrdPreview: TDBGrid
        Left = 0
        Top = 118
        Width = 870
        Height = 165
        Align = alClient
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        PopupMenu = ppMnu
        ReadOnly = True
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrdPreviewDrawColumnCell
      end
      object pnlLabel: TPanel
        Left = 0
        Top = 94
        Width = 870
        Height = 24
        Align = alTop
        Caption = 'Certificati'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        object TabControl1: TTabControl
          Left = 448
          Top = 24
          Width = 289
          Height = 193
          TabOrder = 0
        end
      end
      object pnlDatiIn: TPanel
        Left = 0
        Top = 0
        Width = 870
        Height = 94
        HelpContext = 87000
        Align = alTop
        TabOrder = 4
        object lblPercorsoFile: TLabel
          Left = 7
          Top = 28
          Width = 119
          Height = 13
          Caption = 'Nome file di importazione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtPathFile: TEdit
          Left = 7
          Top = 43
          Width = 841
          Height = 21
          TabOrder = 1
        end
        object btnPathFile: TButton
          Left = 849
          Top = 43
          Width = 15
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = btnPathFileClick
        end
        object chkAnomalie: TCheckBox
          Left = 7
          Top = 72
          Width = 117
          Height = 17
          Caption = 'Controllo anomalie'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = chkAnomalieClick
        end
        object chkInserimento: TCheckBox
          Left = 755
          Top = 72
          Width = 109
          Height = 17
          Caption = 'Importazione  dati'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = chkAnomalieClick
        end
        object chkEsenzione: TCheckBox
          Left = 7
          Top = 6
          Width = 108
          Height = 17
          Caption = 'Mantieni esenzione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object btnDipEsclusi: TBitBtn
          Left = 765
          Top = 4
          Width = 99
          Height = 25
          Caption = 'Dipendenti Esclusi'
          Enabled = False
          TabOrder = 5
          OnClick = btnDipEsclusiClick
        end
      end
    end
    object TabInsManuale: TTabSheet
      Caption = 'Inserisci periodo'
      ImageIndex = 1
      OnShow = TabInsManualeShow
      DesignSize = (
        870
        333)
      object lblIDPeriodo: TLabel
        Left = 3
        Top = 7
        Width = 113
        Height = 13
        Caption = 'Numero protocollo INPS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblDataInizioMal: TLabel
        Left = 142
        Top = 7
        Width = 90
        Height = 13
        Caption = 'Data inizio malattia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblDataFineMal: TLabel
        Left = 251
        Top = 7
        Width = 85
        Height = 13
        Caption = 'Data fine malattia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblDataRilascio: TLabel
        Left = 356
        Top = 7
        Width = 109
        Height = 13
        Caption = 'Data rilascio certificato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblDataConsegna: TLabel
        Left = 471
        Top = 7
        Width = 162
        Height = 13
        Caption = 'Data consegna al datore di lavoro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblNote: TLabel
        Left = 3
        Top = 206
        Width = 23
        Height = 13
        Caption = 'Note'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 689
        Top = 7
        Width = 178
        Height = 13
        Caption = 'Numero protocollo INPS da rettificare'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtIDPeriodo: TEdit
        Left = 3
        Top = 22
        Width = 121
        Height = 21
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object rdgTipoCertificato: TRadioGroup
        Left = 220
        Top = 49
        Width = 107
        Height = 91
        Caption = 'Tipo certificato'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Inserimento'
          'Continuazione'
          'Ricaduta')
        ParentFont = False
        TabOrder = 10
      end
      object rgpTipoRicovero: TRadioGroup
        Left = 338
        Top = 49
        Width = 183
        Height = 91
        Caption = 'Ricovero \ Post-ricovero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Nessuno'
          'Ricovero'
          'Day hospital'
          'Convalescenza post-ricovero')
        ParentFont = False
        TabOrder = 11
      end
      object rgpAgevolazioni: TRadioGroup
        Left = 718
        Top = 49
        Width = 148
        Height = 91
        Caption = 'Agevolazioni'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Nessuna'
          'Terapia salvavita'
          'Causa di servizio'
          'Invalidit'#224' riconosciuta')
        ParentFont = False
        TabOrder = 13
      end
      object rgpTipoComunicazione: TRadioGroup
        Left = 3
        Top = 49
        Width = 204
        Height = 91
        Caption = 'Tipo comunicazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Certificato Medico'
          'E-mail'
          'Telefonata'
          'Acquisita da APP')
        ParentFont = False
        TabOrder = 9
      end
      object btnDataInizioMal: TButton
        Left = 214
        Top = 22
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 2
        OnClick = btnDataInizioMalClick
      end
      object btnDataFineMal: TButton
        Left = 323
        Top = 22
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 4
        OnClick = btnDataInizioMalClick
      end
      object btnDataRilascio: TButton
        Left = 428
        Top = 22
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 6
        OnClick = btnDataInizioMalClick
      end
      object btnDataConsegna: TButton
        Left = 543
        Top = 22
        Width = 17
        Height = 21
        Caption = '...'
        TabOrder = 8
        OnClick = btnDataInizioMalClick
      end
      object edtDataInizioMal: TMaskEdit
        Left = 142
        Top = 22
        Width = 68
        Height = 21
        EditMask = '!99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        OnDblClick = edtDataInizioMalDblClick
      end
      object edtDataFineMal: TMaskEdit
        Left = 251
        Top = 22
        Width = 68
        Height = 21
        EditMask = '!99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
        OnDblClick = edtDataInizioMalDblClick
        OnEnter = edtDataFineMalEnter
      end
      object edtDataRilascio: TMaskEdit
        Left = 356
        Top = 22
        Width = 68
        Height = 21
        EditMask = '!99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 5
        Text = '  /  /    '
        OnDblClick = edtDataInizioMalDblClick
      end
      object edtDataConsegna: TMaskEdit
        Left = 471
        Top = 22
        Width = 68
        Height = 21
        EditMask = '!99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 7
        Text = '  /  /    '
        OnDblClick = edtDataInizioMalDblClick
      end
      object rgpCauseMalattia: TRadioGroup
        Left = 532
        Top = 49
        Width = 178
        Height = 91
        Caption = 'Particolari cause malattia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Nessuna'
          'Gravidanza'
          'Sclerosi e patologie docum.')
        ParentFont = False
        TabOrder = 12
      end
      object grpReperibilita: TGroupBox
        Left = 3
        Top = 141
        Width = 863
        Height = 59
        Caption = 'Reperibilit'#224
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        object lblCognome: TLabel
          Left = 7
          Top = 15
          Width = 45
          Height = 13
          Caption = 'Cognome'
        end
        object lblVia: TLabel
          Left = 179
          Top = 15
          Width = 14
          Height = 13
          Caption = 'Via'
        end
        object lblCodCatastale: TLabel
          Left = 351
          Top = 15
          Width = 72
          Height = 13
          Caption = 'Cod. Catastale'
        end
        object lblProv: TLabel
          Left = 442
          Top = 15
          Width = 43
          Height = 13
          Caption = 'Provincia'
        end
        object lblCAP: TLabel
          Left = 495
          Top = 15
          Width = 32
          Height = 13
          Caption = 'C.A.P.'
        end
        object lblDescComune: TLabel
          Left = 554
          Top = 33
          Width = 3
          Height = 13
          Caption = ' '
        end
        object edtCognome: TEdit
          Left = 7
          Top = 30
          Width = 160
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 24
          ParentFont = False
          TabOrder = 0
        end
        object edtVia: TEdit
          Left = 179
          Top = 30
          Width = 160
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 80
          ParentFont = False
          TabOrder = 1
        end
        object edtCodCatastale: TEdit
          Left = 351
          Top = 30
          Width = 63
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 4
          ParentFont = False
          TabOrder = 2
        end
        object edtCAP: TEdit
          Left = 495
          Top = 30
          Width = 49
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 5
          ParentFont = False
          TabOrder = 5
        end
        object edtProv: TEdit
          Left = 442
          Top = 30
          Width = 43
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 4
        end
        object btnComune: TBitBtn
          Left = 417
          Top = 30
          Width = 17
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnComuneClick
        end
      end
      object mmNote: TMemo
        Left = 3
        Top = 221
        Width = 864
        Height = 80
        MaxLength = 2000
        TabOrder = 15
      end
      object btnChiudiInsMan: TBitBtn
        Left = 776
        Top = 307
        Width = 90
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Chiudi'
        Glyph.Data = {
          06010000424D0601000000000000760000002800000010000000120000000100
          04000000000090000000C40E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFF77
          F7F74444400FFFFFF444FFFF4D5007FFF4FFFFFF45D50FFFF4FFFFFF4D5D0FFF
          F4FFFFFF45D50FEFE4FFFFFF4D5D0FFFF4FFFFFF45D50FEFE4FFFFFF4D5D0FFF
          F4FFFFFF45D50FEFE4FFFFFF4D5D0EFEF4FFFFFF45D50FEFE4FFFFFF4D5D0EFE
          F4FFFFFF4444444444FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF0AAAA0
          FFFFFFFFFF000000FFFF}
        TabOrder = 17
        OnClick = btnChiudiClick
      end
      object btnInserisci: TBitBtn
        Left = 3
        Top = 307
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Conferma'
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000C40E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFF44FFFFFFFFFFFFF4224FFFFFFFFFFF422224FFFFFFFFF42222224FFF
          FFFF4222A22224FFFFFF222AFA2224FFFFFFA2AFFFA2224FFFFFFAFFFFFA2224
          FFFFFFFFFFFFA2224FFFFFFFFFFFFA2224FFFFFFFFFFFFA2224FFFFFFFFFFFFA
          2224FFFFFFFFFFFFA224FFFFFFFFFFFFFA22FFFFFFFFFFFFFFA7}
        TabOrder = 16
        OnClick = btnInserisciClick
      end
      object btnAnnulla: TBitBtn
        Left = 84
        Top = 307
        Width = 75
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Annulla'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF0000FF0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF000084FFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF0000840000FF0000FFFFFFFFFFFFFFFFFFFFFFFFFF0000FF0000
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
          0084FFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
          00FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF0000FF0000840000FF000084000084FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF00
          0084FFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFF0000FF0000840000FF000084FFFFFFFFFFFFFFFFFFFFFFFF0000840000
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FF0000840000FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FF000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF0000840000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        TabOrder = 18
        OnClick = btnAnnullaClick
      end
      object edtIDPeriodoRettifica: TEdit
        Left = 689
        Top = 22
        Width = 121
        Height = 21
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 19
      end
    end
    object TabCancManuale: TTabSheet
      Caption = 'Modifica\Cancella periodo'
      ImageIndex = 3
      object dGridCanc: TDBGrid
        Left = 0
        Top = 0
        Width = 870
        Height = 303
        Align = alClient
        DataSource = dsrCancManuale
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dGridCancCellClick
        OnDrawColumnCell = dGridCancDrawColumnCell
        OnKeyUp = dGridCancKeyUp
      end
      object pnlCancManuale: TPanel
        Left = 0
        Top = 303
        Width = 870
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          870
          30)
        object btnCancella: TBitBtn
          Left = 0
          Top = 3
          Width = 90
          Height = 25
          Caption = 'Cancella'
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0040104210421F7C1F7C1F7C1F7C1F7C
            104210421F7C1F7C00401F7C1F7C1F7C00400040104210421F7C1F7C1F7C1F7C
            004000001F7C1F7C004000401F7C1F7C10420040004010421F7C1F7C1F7C1042
            00401F7C1F7C1F7C0040004000401F7C1F7C00400040104210421F7C00400040
            10421F7C1F7C1F7C00400040004000401F7C1042004000401042104200400040
            1F7C1F7C1F7C1F7C004000400040004000401F7C004000400040004000401F7C
            1F7C1F7C1F7C1F7C00400040004000401F7C1F7C104200400040004010421F7C
            1F7C1F7C1F7C1F7C0040004000401F7C10421042004000400040004010421042
            1F7C1F7C1F7C1F7C004000401F7C1042004000401F7C1F7C1042004000401042
            10421F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C104200400040
            104200001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
            00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C}
          TabOrder = 0
          OnClick = btnCancellaClick
        end
        object btnChiudiCanc: TBitBtn
          Left = 776
          Top = 3
          Width = 90
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Chiudi'
          Glyph.Data = {
            06010000424D0601000000000000760000002800000010000000120000000100
            04000000000090000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFF77
            F7F74444400FFFFFF444FFFF4D5007FFF4FFFFFF45D50FFFF4FFFFFF4D5D0FFF
            F4FFFFFF45D50FEFE4FFFFFF4D5D0FFFF4FFFFFF45D50FEFE4FFFFFF4D5D0FFF
            F4FFFFFF45D50FEFE4FFFFFF4D5D0EFEF4FFFFFF45D50FEFE4FFFFFF4D5D0EFE
            F4FFFFFF4444444444FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF0AAAA0
            FFFFFFFFFF000000FFFF}
          TabOrder = 1
          OnClick = btnChiudiClick
        end
        object btnModificaPeriodo: TBitBtn
          Left = 97
          Top = 3
          Width = 90
          Height = 25
          Caption = 'Modifica'
          Glyph.Data = {
            42020000424D4202000000000000420000002800000010000000100000000100
            1000030000000002000000000000000000000000000000000000007C0000E003
            00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C000000001F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C004000401F7C1F7C1F7C1F7C000000001F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C0040004000401F7C1F7C1F7C0000E07F10421F7C1F7C
            1F7C1F7C1F7C1F7C1F7C00400040004000401F7C1F7C0000E07F104200001F7C
            1F7C1F7C1F7C1F7C1F7C00400040004000401F7C1F7C1F7C1863E07F10421F7C
            1F7C1F7C1F7C1F7C1F7C00400040004000401F7C1F7C1F7C1F7C1863E07F1042
            1F7C1F7C1F7C1F7C1F7C0040004000401F7C1F7C1F7C1F7C1F7C0000E07F1042
            00001F7C1F7C1F7C1F7C004000401F7C1F7C1F7C1F7C1F7C1F7C1F7C1863E07F
            10421F7C1F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1863
            E07F00001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C0000
            0000004000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            004000401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
            1F7C1F7C1F7C}
          TabOrder = 2
          OnClick = btnModificaPeriodoClick
        end
      end
    end
    object tabFile: TTabSheet
      Caption = 'Importazione da File'
      ImageIndex = 2
      object dGrdElenco: TDBGrid
        Left = 0
        Top = 81
        Width = 870
        Height = 205
        Align = alClient
        DataSource = dsrFTXT
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object pnlPathFile: TPanel
        Left = 0
        Top = 0
        Width = 870
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblNomeFile: TLabel
          Left = 7
          Top = 8
          Width = 119
          Height = 13
          Caption = 'Nome file di importazione'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtFileTxt: TEdit
          Left = 7
          Top = 23
          Width = 841
          Height = 21
          TabOrder = 0
        end
        object btnPathTxt: TButton
          Left = 851
          Top = 23
          Width = 15
          Height = 21
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -9
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnPathTxtClick
        end
      end
      object pnlCaption: TPanel
        Left = 0
        Top = 57
        Width = 870
        Height = 24
        Align = alTop
        Caption = 'Elenco periodi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object pnlInserisci: TPanel
        Left = 0
        Top = 286
        Width = 870
        Height = 30
        Align = alBottom
        TabOrder = 3
        DesignSize = (
          870
          30)
        object btnInsFileTxt: TBitBtn
          Left = 0
          Top = 2
          Width = 90
          Height = 25
          Caption = 'Esegui'
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFF808
            8FFF0FFFFFFF003000FFB0FFFFF0B333300F8B0FFFF0BB883088F8B0FF0BB0F8
            3300F8BB0FF0B0003088888BB0F0BB3BB00FBBBBBB0F00B000FF8BBB0088FF00
            FFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFFFF8888BBB0FFFFFFFFF8BBBBBB0FFF
            FFFFFF8BBB0000FFFFFFFFF8BBB0FFFFFFFFFFFF8BBB0FFFFFFF}
          TabOrder = 0
          OnClick = btnInsFileTxtClick
        end
        object btnAnomalieTxt: TBitBtn
          Left = 96
          Top = 2
          Width = 90
          Height = 25
          Caption = 'Anomalie'
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
          TabOrder = 1
          OnClick = btnAnomalieClick
        end
        object btnChiudiImpTXT: TBitBtn
          Left = 776
          Top = 2
          Width = 90
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Chiudi'
          Glyph.Data = {
            06010000424D0601000000000000760000002800000010000000120000000100
            04000000000090000000C40E0000C40E00001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003FFFFFFFFF77
            F7F74444400FFFFFF444FFFF4D5007FFF4FFFFFF45D50FFFF4FFFFFF4D5D0FFF
            F4FFFFFF45D50FEFE4FFFFFF4D5D0FFFF4FFFFFF45D50FEFE4FFFFFF4D5D0FFF
            F4FFFFFF45D50FEFE4FFFFFF4D5D0EFEF4FFFFFF45D50FEFE4FFFFFF4D5D0EFE
            F4FFFFFF4444444444FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF0AAAA0
            FFFFFFFFFF000000FFFF}
          TabOrder = 2
          OnClick = btnChiudiClick
        end
      end
      object prgBarFileTxt: TProgressBar
        Left = 0
        Top = 316
        Width = 870
        Height = 17
        Align = alBottom
        Step = 1
        TabOrder = 4
      end
    end
  end
  object DataSource1: TDataSource
    Left = 751
    Top = 15
  end
  object OpenDlg: TOpenDialog
    Filter = 'XML|*.XML'
    Left = 712
    Top = 14
  end
  object ppMnuAccedi: TPopupMenu
    Left = 840
    Top = 64
    object Accedi1: TMenuItem
      Caption = 'Accedi'
      OnClick = Accedi1Click
    end
  end
  object ppMnu: TPopupMenu
    Left = 689
    Top = 231
    object CopiainExcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiainExcel1Click
    end
  end
  object dsrCancManuale: TDataSource
    DataSet = A087FImpAttestatiMalMW.selT048CancMan
    Left = 747
    Top = 231
  end
  object dsrFTXT: TDataSource
    DataSet = A087FImpAttestatiMalMW.CDtsTXTFile
    Left = 809
    Top = 231
  end
end
