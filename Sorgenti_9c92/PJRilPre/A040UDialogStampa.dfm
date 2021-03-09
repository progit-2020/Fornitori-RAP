object A040FDialogStampa: TA040FDialogStampa
  Left = 343
  Top = 287
  HelpContext = 40200
  Margins.Top = 0
  Margins.Bottom = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A040> Stampa reperibilit'#224' mensile'
  ClientHeight = 422
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpDettaglioTabellone: TGroupBox
    AlignWithMargins = True
    Left = 5
    Top = 249
    Width = 417
    Height = 106
    Margins.Left = 5
    Margins.Top = 0
    Margins.Right = 5
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Dettaglio tabellone'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object rgpDatiAssenza: TRadioGroup
      Left = 218
      Top = 17
      Width = 190
      Height = 83
      Caption = 'Dati assenza'
      ItemIndex = 0
      Items.Strings = (
        'No'
        'Codice causale'
        'Sigla definita')
      TabOrder = 1
      OnClick = rgpDatiAssenzaClick
    end
    object edtSiglaAssenza: TEdit
      Left = 326
      Top = 73
      Width = 58
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
    end
    object grpDatiPianif: TGroupBox
      Left = 9
      Top = 17
      Width = 203
      Height = 83
      Caption = 'Dati pianificazione'
      TabOrder = 0
      DesignSize = (
        203
        83)
      object chkCodice: TCheckBox
        Left = 7
        Top = 17
        Width = 190
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Codice'
        TabOrder = 0
      end
      object chkOrario: TCheckBox
        Left = 7
        Top = 37
        Width = 190
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Orario'
        TabOrder = 1
      end
      object chkDatoLibero: TCheckBox
        Left = 7
        Top = 58
        Width = 190
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Dato libero pianif.'
        TabOrder = 2
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 427
    Height = 110
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 5
      Top = 91
      Width = 66
      Height = 13
      Caption = 'Titolo stampa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object rgpTipoStampa: TRadioGroup
      Left = 4
      Top = 2
      Width = 158
      Height = 82
      Caption = 'Tipo stampa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Tabellone mensile'
        'Tabellone personalizzato'
        'Prospetto per dipendente'
        'Prospetto per raggr.')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpTipoStampaClick
    end
    object grpPeriodo: TGroupBox
      Left = 166
      Top = 2
      Width = 254
      Height = 82
      Caption = 'Periodo elaborazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lblDataDa: TLabel
        Left = 7
        Top = 38
        Width = 19
        Height = 13
        Caption = 'Dal:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lblDataA: TLabel
        Left = 133
        Top = 38
        Width = 11
        Height = 13
        Caption = 'al:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edtDataDa: TMaskEdit
        Left = 32
        Top = 35
        Width = 70
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
        TabOrder = 0
        Text = '  /  /    '
      end
      object btnDataDa: TBitBtn
        Left = 104
        Top = 35
        Width = 17
        Height = 21
        Hint = 'Data inizio periodo'
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnDataDaClick
      end
      object edtDataA: TMaskEdit
        Left = 150
        Top = 35
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
        TabOrder = 2
        Text = '  /  /    '
        OnDblClick = edtDataADblClick
      end
      object btnDataA: TBitBtn
        Left = 225
        Top = 35
        Width = 17
        Height = 21
        Hint = 'Data fine periodo'
        Caption = '...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = btnDataDaClick
      end
    end
    object edtTitolo: TEdit
      Left = 76
      Top = 88
      Width = 344
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object pnlRaggruppamento: TPanel
    Left = 0
    Top = 110
    Width = 427
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label3: TLabel
      Left = 5
      Top = 4
      Width = 177
      Height = 13
      Caption = 'Campo anagrafico di raggruppamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBLookUpCampo: TDBLookupComboBox
      Left = 5
      Top = 23
      Width = 282
      Height = 21
      DropDownRows = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_LOGICO'
      ListSource = A040FPianifRepDtM1.D010
      ParentFont = False
      TabOrder = 0
      OnClick = DBLookUpCampoClick
      OnKeyDown = DBLookUpCampoKeyDown
    end
    object chkSaltoPagina: TCheckBox
      Left = 5
      Top = 49
      Width = 89
      Height = 17
      Caption = 'Salto pagina'
      TabOrder = 1
    end
  end
  object pnlOpzioniTabellone: TPanel
    Left = 0
    Top = 207
    Width = 427
    Height = 42
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object chkIncludiNonPianif: TCheckBox
      Left = 5
      Top = 3
      Width = 177
      Height = 17
      Caption = 'Includi dipendenti non pianificati'
      TabOrder = 0
    end
    object chkLegenda: TCheckBox
      Left = 5
      Top = 24
      Width = 177
      Height = 17
      Caption = 'Visualizza legenda'
      TabOrder = 1
    end
    object chkTotali: TCheckBox
      Left = 231
      Top = 24
      Width = 177
      Height = 17
      Caption = 'Visualizza totali'
      TabOrder = 2
    end
  end
  object pnlCampoDettaglio: TPanel
    Left = 0
    Top = 355
    Width = 427
    Height = 48
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object Label4: TLabel
      Left = 5
      Top = 4
      Width = 140
      Height = 13
      Caption = 'Campo anagrafico di dettaglio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DBLookupDett: TDBLookupComboBox
      Left = 4
      Top = 22
      Width = 277
      Height = 21
      DropDownRows = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      KeyField = 'NOME_CAMPO'
      ListField = 'NOME_LOGICO'
      ListSource = A040FPianifRepDtM1.D010B
      ParentFont = False
      TabOrder = 0
      OnKeyDown = DBLookUpCampoKeyDown
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 389
    Width = 427
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    object btnPrinterSetUp: TBitBtn
      Left = 5
      Top = 4
      Width = 80
      Height = 25
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
      TabOrder = 0
      OnClick = btnPrinterSetUpClick
    end
    object btnAnteprima: TBitBtn
      Left = 173
      Top = 4
      Width = 80
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
      TabOrder = 2
      OnClick = btnStampaClick
    end
    object btnStampa: TBitBtn
      Left = 257
      Top = 4
      Width = 80
      Height = 25
      Caption = '&Stampa'
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
      TabOrder = 3
      OnClick = btnStampaClick
    end
    object btnClose: TBitBtn
      Left = 340
      Top = 4
      Width = 80
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 4
    end
    object btnFont: TBitBtn
      Left = 90
      Top = 4
      Width = 80
      Height = 25
      Caption = '&Font...'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333FFF33FFFFF33333300033000
        00333337773377777333333330333300033333337FF33777F333333330733300
        0333333377FFF777F33333333700000073333333777777773333333333033000
        3333333337FF777F333333333307300033333333377F777F3333333333703007
        33333333377F7773333333333330000333333333337777F33333333333300003
        33333333337777F3333333333337007333333333337777333333333333330033
        3333333333377333333333333333033333333333333733333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnFontClick
    end
  end
  object pnlSceltaTurni: TPanel
    Left = 0
    Top = 176
    Width = 427
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 5
      Top = 9
      Width = 97
      Height = 13
      Caption = 'Turni da considerare'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtTurni: TEdit
      Left = 108
      Top = 6
      Width = 160
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object btnScegliTurni: TButton
      Left = 270
      Top = 4
      Width = 17
      Height = 21
      Hint = 'Scelta turni'
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnScegliTurniClick
    end
    object rgpSelTurni: TRadioGroup
      Left = 293
      Top = -2
      Width = 127
      Height = 32
      Caption = 'Seleziona per'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Codice'
        'Orario')
      TabOrder = 2
      OnClick = rgpSelTurniClick
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 373
    Width = 427
    Height = 16
    Align = alBottom
    TabOrder = 6
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 316
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Left = 352
  end
end
