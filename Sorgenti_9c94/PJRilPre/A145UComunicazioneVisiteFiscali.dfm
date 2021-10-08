object A145FComunicazioneVisiteFiscali: TA145FComunicazioneVisiteFiscali
  Left = 353
  Top = 233
  HelpContext = 145000
  Caption = '<A145> Comunicazione visite fiscali'
  ClientHeight = 496
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlElenco: TPanel
    Left = 0
    Top = 189
    Width = 483
    Height = 142
    TabOrder = 5
    object Splitter1: TSplitter
      Left = 290
      Top = 1
      Width = 7
      Height = 140
      Visible = False
      ExplicitLeft = 309
      ExplicitTop = 177
      ExplicitHeight = 244
    end
    object grpCausali: TGroupBox
      Left = 1
      Top = 1
      Width = 289
      Height = 140
      Align = alLeft
      Caption = 'Causali di assenza'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Padding.Left = 3
      Padding.Right = 3
      ParentFont = False
      TabOrder = 0
      Visible = False
      object chkLCausali: TCheckListBox
        Left = 5
        Top = 15
        Width = 279
        Height = 123
        Hint = 
          'Selezionare le causali da considerare nel calcolo dei giorni di ' +
          'malattia dell'#39'ultimo anno'
        Margins.Right = 6
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ItemHeight = 14
        ParentFont = False
        ParentShowHint = False
        PopupMenu = pmnuCausaliAssenza
        ShowHint = False
        TabOrder = 0
      end
    end
    object grpDettaglio: TGroupBox
      Left = 297
      Top = 1
      Width = 185
      Height = 140
      Align = alClient
      Caption = 'Dati anagrafici di dettaglio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Padding.Left = 3
      Padding.Right = 3
      ParentFont = False
      TabOrder = 1
      object chkLDettaglio: TCheckListBox
        Left = 5
        Top = 15
        Width = 175
        Height = 123
        Margins.Right = 6
        Align = alClient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnMouseDown = chkLDettaglioMouseDown
        OnMouseUp = chkLDettaglioMouseUp
      end
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 600
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 600
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 600
      Height = 24
      ExplicitWidth = 600
      ExplicitHeight = 24
      inherited lblDipendente: TLabel
        Height = 15
        Font.Height = -12
        ExplicitHeight = 15
      end
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      Left = 264
      Top = 6
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 477
    Width = 600
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 461
    Width = 600
    Height = 16
    Align = alBottom
    TabOrder = 2
  end
  object pnlPulsantiStampa: TPanel
    Left = 0
    Top = 422
    Width = 600
    Height = 39
    Align = alBottom
    TabOrder = 1
    object BtnPrinterSetUp: TBitBtn
      Left = 5
      Top = 8
      Width = 85
      Height = 25
      Caption = 'S&tampante'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
      TabOrder = 0
      OnClick = BtnPrinterSetUpClick
    end
    object btnAnteprima: TBitBtn
      Left = 105
      Top = 8
      Width = 85
      Height = 25
      Caption = '&Anteprima'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      ParentFont = False
      TabOrder = 1
      OnClick = btnStampaClick
    end
    object btnStampa: TBitBtn
      Left = 205
      Top = 8
      Width = 85
      Height = 25
      Caption = '&Stampa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
        8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
        8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
        8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = btnStampaClick
    end
    object BtnClose: TBitBtn
      Left = 507
      Top = 8
      Width = 85
      Height = 25
      Caption = '&Chiudi'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Kind = bkClose
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 5
    end
    object btnEsegui: TBitBtn
      Left = 406
      Top = 8
      Width = 85
      Height = 25
      Caption = '&Esegui'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
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
      TabOrder = 3
      OnClick = btnEseguiClick
    end
    object btnEsenzioni: TBitBtn
      Left = 306
      Top = 8
      Width = 85
      Height = 25
      Caption = 'Esenzioni'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFF90FFFFFFFFFFFFF9990FFFFFFFFFFFF9990FFFFFFFFFFF999990FF
        FFFFFFF9999990FFFFFFFF8990F9990FFFFFF890FFFF990FFFFFFFFFFFFF9990
        FFFFFFFFFFFFF990FFFFFFFFFFFFFF990FFFFFFFFFFFFFF890FFFFFFFFFFFFFF
        890FFFFFFFFFFFFFFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 4
      OnClick = btnEsenzioniClick
    end
  end
  object pnlIndividuale: TPanel
    Left = 54
    Top = 189
    Width = 519
    Height = 234
    TabOrder = 3
    Visible = False
    DesignSize = (
      519
      234)
    object Label4: TLabel
      Left = 11
      Top = 84
      Width = 63
      Height = 13
      Caption = 'Dato libero 1:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 11
      Top = 139
      Width = 63
      Height = 13
      Caption = 'Dato libero 2:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 11
      Top = 194
      Width = 28
      Height = 13
      Caption = 'Firma:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object memDato1: TMemo
      Left = 86
      Top = 81
      Width = 428
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
      WordWrap = False
    end
    object memDato2: TMemo
      Left = 86
      Top = 136
      Width = 428
      Height = 49
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 2
      WordWrap = False
    end
    object memFirma: TMemo
      Left = 86
      Top = 191
      Width = 428
      Height = 39
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 3
      WordWrap = False
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 517
      Height = 64
      Align = alTop
      Caption = 'Opzioni'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        517
        64)
      object chkLogo: TCheckBox
        Left = 9
        Top = 17
        Width = 130
        Height = 17
        Caption = 'Larghezza logo (pixel):'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkLogoClick
      end
      object chkNumProt: TCheckBox
        Left = 9
        Top = 41
        Width = 99
        Height = 17
        Caption = 'Num. protocollo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = chkNumProtClick
      end
      object edtNumProt: TEdit
        Left = 140
        Top = 39
        Width = 64
        Height = 21
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object chkLuogo: TCheckBox
        Left = 235
        Top = 41
        Width = 99
        Height = 17
        Caption = 'Luogo di stampa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = chkLuogoClick
      end
      object edtLuogo: TEdit
        Left = 341
        Top = 39
        Width = 169
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edtLogoLarg: TEdit
        Left = 140
        Top = 15
        Width = 37
        Height = 21
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 24
    Width = 600
    Height = 159
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 6
    object lblDataDa: TLabel
      Left = 4
      Top = 1
      Width = 89
      Height = 13
      Caption = 'Data elaborazione:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 101
      Top = 1
      Width = 77
      Height = 13
      Caption = 'Medicina legale:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object dtxtMedicinaLegale: TDBText
      Left = 238
      Top = 18
      Width = 354
      Height = 19
      DataField = 'DESCRIZIONE'
      DataSource = A145FComunicazioneVisiteFiscaliDtm.dscT485
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object grpOpzioni: TGroupBox
      Left = 367
      Top = 39
      Width = 227
      Height = 120
      Caption = 'Opzioni di stampa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      object Label2: TLabel
        Left = 7
        Top = 82
        Width = 14
        Height = 13
        Caption = 'dal'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 117
        Top = 82
        Width = 8
        Height = 13
        Caption = 'al'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object chkNote: TCheckBox
        Left = 136
        Top = 101
        Width = 83
        Height = 17
        Caption = 'Stampa note'
        TabOrder = 7
      end
      object edtDataDa: TMaskEdit
        Left = 26
        Top = 79
        Width = 71
        Height = 21
        EditMask = '!00/00/0000;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        Text = '  /  /    '
        OnChange = edtDataDaChange
      end
      object btnDataDa: TBitBtn
        Left = 96
        Top = 79
        Width = 17
        Height = 21
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 3
        OnClick = btnDataDaClick
      end
      object edtDataA: TMaskEdit
        Left = 128
        Top = 79
        Width = 73
        Height = 21
        EditMask = '!00/00/0000;1;_'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        Text = '  /  /    '
      end
      object btnDataA: TBitBtn
        Left = 201
        Top = 79
        Width = 17
        Height = 21
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnDataAClick
      end
      object chkPeriodiComunicati: TCheckBox
        Left = 7
        Top = 46
        Width = 213
        Height = 17
        Hint = 
          'Selezionare per includere in stampa i periodi di assenza gi'#224' com' +
          'unicati'
        Caption = 'Includi periodi di assenza gi'#224' comunicati'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnClick = opzioniClick
      end
      object rgpTipoStampa: TRadioGroup
        Left = 5
        Top = 12
        Width = 215
        Height = 30
        Caption = 'Tipo'
        Columns = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Elenco'
          'Individuale')
        ParentFont = False
        TabOrder = 0
        OnClick = rgpTipoStampaClick
      end
      object chkStampaAssMal: TCheckBox
        Left = 7
        Top = 101
        Width = 116
        Height = 17
        Caption = 'Stampa Ass.Malattia'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object chkFiltroDataComun: TCheckBox
        Left = 7
        Top = 61
        Width = 211
        Height = 17
        Caption = 'Filtra per data comunicazione'
        TabOrder = 8
        OnClick = opzioniClick
      end
    end
    object grpOperazioni: TGroupBox
      Left = 6
      Top = 39
      Width = 192
      Height = 81
      Caption = 'Registrazioni da elaborare'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object chkIns: TCheckBox
        Left = 6
        Top = 14
        Width = 87
        Height = 17
        Caption = 'Inserimento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object chkCanc: TCheckBox
        Left = 6
        Top = 61
        Width = 90
        Height = 17
        Caption = 'Cancellazione'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object chkProl: TCheckBox
        Left = 6
        Top = 30
        Width = 90
        Height = 17
        Caption = 'Prolungamento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = chkProlClick
        OnExit = chkProlClick
      end
      object chkSoloCont: TCheckBox
        Left = 6
        Top = 45
        Width = 181
        Height = 17
        Caption = 'Solo tipo certificato continuazione'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
    end
    object chkAnnulla: TCheckBox
      Left = 15
      Top = 141
      Width = 160
      Height = 17
      Hint = 'Selezionare per annullare una comunicazione'
      Caption = 'Annulla ultima comunicazione'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 5
      OnClick = opzioniClick
    end
    object btnDataElaborazione: TBitBtn
      Left = 79
      Top = 15
      Width = 17
      Height = 21
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnDataElaborazioneClick
    end
    object edtDataElaborazione: TMaskEdit
      Left = 5
      Top = 16
      Width = 73
      Height = 21
      Hint = 'Data di elaborazione'
      EditMask = '!00/00/0000;1;_'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      Text = '  /  /    '
    end
    object dcmbMedicineLegali: TDBLookupComboBox
      Left = 101
      Top = 16
      Width = 128
      Height = 21
      DropDownWidth = 300
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'CODICE'
      ListField = 'CODICE;DESCRIZIONE'
      ListSource = A145FComunicazioneVisiteFiscaliDtm.dscT485
      ParentFont = False
      TabOrder = 2
    end
    object chkAggiorna: TCheckBox
      Left = 15
      Top = 122
      Width = 160
      Height = 18
      Hint = 
        'Selezionare per rendere effettiva la comunicazione delle assenze' +
        ' nella data indicata'
      Caption = 'Aggiorna data comunicazione'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      OnClick = opzioniClick
    end
    object grpEsenzioni: TGroupBox
      Left = 202
      Top = 39
      Width = 160
      Height = 120
      Caption = 'Opzioni di esenzione'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      object lblMesiVerificaEventi: TLabel
        Left = 5
        Top = 93
        Width = 91
        Height = 13
        Caption = 'Mesi verifica eventi'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblMaxGiorniContinuativi: TLabel
        Left = 5
        Top = 65
        Width = 108
        Height = 13
        Caption = 'Max giorni continuativi '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblNumeroMinimoEventi: TLabel
        Left = 5
        Top = 41
        Width = 115
        Height = 13
        Caption = 'Numero minimo di eventi'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object chkEsenzioneAutomatica: TCheckBox
        Left = 5
        Top = 16
        Width = 146
        Height = 17
        Hint = 
          'Selezionare per includere in stampa i periodi di assenza gi'#224' com' +
          'unicati'
        Caption = 'Esenzione automatica '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
      end
      object edtMaxGiorniContinuativi: TEdit
        Left = 126
        Top = 63
        Width = 21
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtMesiVerificaEventi: TEdit
        Left = 126
        Top = 90
        Width = 21
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object edtNumeroMinimoEventi: TEdit
        Left = 126
        Top = 38
        Width = 21
        Height = 21
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 360
    Top = 208
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Selezionatutto1Click
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 12
    Top = 462
  end
  object pmnuCausaliAssenza: TPopupMenu
    Left = 172
    Top = 208
    object SelezionaTuttoCau: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = SelezionaTuttoCauClick
    end
    object AnnullaTuttoCau: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = SelezionaTuttoCauClick
    end
  end
end
