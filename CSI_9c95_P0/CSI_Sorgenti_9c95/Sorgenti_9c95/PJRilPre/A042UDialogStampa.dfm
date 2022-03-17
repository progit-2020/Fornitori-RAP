object A042FDialogStampa: TA042FDialogStampa
  Left = 194
  Top = 103
  HelpContext = 42000
  Caption = '<A042> Stampe analitiche presenze/assenze'
  ClientHeight = 438
  ClientWidth = 594
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
  object StatusBar: TStatusBar
    Left = 0
    Top = 419
    Width = 594
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
    Top = 403
    Width = 594
    Height = 16
    Align = alBottom
    TabOrder = 6
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 594
    Height = 24
    Align = alTop
    TabOrder = 7
    TabStop = True
    ExplicitWidth = 594
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 594
      Height = 24
      ExplicitWidth = 594
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 366
    Width = 594
    Height = 37
    Align = alBottom
    TabOrder = 4
    object BtnClose: TBitBtn
      Left = 460
      Top = 7
      Width = 84
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 4
    end
    object BtnStampa: TBitBtn
      Left = 350
      Top = 7
      Width = 84
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
      OnClick = BtnStampaClick
    end
    object BtnPrinterSetUp: TBitBtn
      Left = 45
      Top = 7
      Width = 84
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
      OnClick = BtnPrinterSetUpClick
    end
    object btnAnteprima: TBitBtn
      Left = 255
      Top = 7
      Width = 84
      Height = 25
      Caption = '&Anteprima'
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      TabOrder = 2
      OnClick = BtnStampaClick
    end
    object btnTabella: TBitBtn
      Left = 159
      Top = 7
      Width = 84
      Height = 25
      Caption = '&Tabella'
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C0000000000000000000000000000000000000000000000000000
        0000000000000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F00000000FF7F00000000FF7F00000000FF7F00000000FF7F00000000
        0000FF7F00000000FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F
        FF7FFF7F000000001F001F001F001F001F001F001F001F001F001F001F001F00
        1F001F0000000000F75EF75E1F001F001F001F001F001F001F001F001F001F00
        F75EF75E00000000000000000000000000000000000000000000000000000000
        0000000000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      TabOrder = 1
      OnClick = BtnStampaClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 24
    Width = 594
    Height = 63
    Align = alTop
    TabOrder = 0
    object Label4: TLabel
      Left = 245
      Top = 14
      Width = 42
      Height = 13
      Caption = 'Dalle ore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 308
      Top = 14
      Width = 35
      Height = 13
      Caption = 'Alle ore'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtDaOra: TMaskEdit
      Left = 245
      Top = 29
      Width = 39
      Height = 21
      EditMask = '!00:00;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  .  '
      OnExit = edtDaOraExit
    end
    object edtAOra: TMaskEdit
      Left = 308
      Top = 29
      Width = 39
      Height = 21
      EditMask = '!00:00;1;_'
      MaxLength = 5
      TabOrder = 2
      Text = '  .  '
      OnExit = edtDaOraExit
    end
    object GroupBox1: TGroupBox
      Left = 9
      Top = 1
      Width = 221
      Height = 57
      TabOrder = 0
      object Label1: TLabel
        Left = 16
        Top = 13
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
      object Label2: TLabel
        Left = 125
        Top = 13
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
      object edtDaData: TMaskEdit
        Left = 14
        Top = 28
        Width = 68
        Height = 21
        EditMask = '!00/00/0000;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
      end
      object edtAData: TMaskEdit
        Left = 125
        Top = 28
        Width = 69
        Height = 21
        EditMask = '!00/00/0000;1;_'
        MaxLength = 10
        TabOrder = 3
        Text = '  /  /    '
        OnDblClick = edtADataDblClick
      end
      object btnDaData: TBitBtn
        Left = 83
        Top = 25
        Width = 17
        Height = 25
        Caption = '...'
        TabOrder = 2
        OnClick = BtnDaDataClick
      end
      object btnAData: TBitBtn
        Left = 194
        Top = 25
        Width = 17
        Height = 25
        Caption = '...'
        TabOrder = 4
        OnClick = BtnADataClick
      end
      object chkGiornoCorrente: TCheckBox
        Left = 4
        Top = -2
        Width = 93
        Height = 17
        Caption = 'Giorno corrente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = chkGiornoCorrenteClick
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 224
    Width = 594
    Height = 142
    Align = alClient
    TabOrder = 3
    object gpbIntestazione: TGroupBox
      Left = 1
      Top = 1
      Width = 297
      Height = 140
      Align = alLeft
      Caption = 'Intestazione/Raggruppamento'
      TabOrder = 0
      object chkLIntestazione: TCheckListBox
        Left = 2
        Top = 15
        Width = 293
        Height = 123
        Align = alClient
        ItemHeight = 13
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnClick = chkLIntestazioneClick
        OnMouseDown = chkLIntestazioneMouseDown
        OnMouseUp = chkLIntestazioneMouseUp
      end
    end
    object gpbDettaglio: TGroupBox
      Left = 298
      Top = 1
      Width = 295
      Height = 140
      Align = alClient
      Caption = 'Dettaglio'
      TabOrder = 1
      object chkLDettaglio: TCheckListBox
        Left = 2
        Top = 15
        Width = 291
        Height = 123
        Align = alClient
        ItemHeight = 13
        PopupMenu = PopupMenu1
        TabOrder = 0
        OnClick = chkLDettaglioClick
        OnMouseDown = chkLDettaglioMouseDown
        OnMouseUp = chkLDettaglioMouseUp
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 166
    Width = 594
    Height = 58
    Align = alTop
    TabOrder = 2
    object chkSaltoPagina: TCheckBox
      Left = 409
      Top = 38
      Width = 180
      Height = 17
      Caption = 'Salto pagina per raggruppamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
    end
    object chkTabellare: TCheckBox
      Left = 12
      Top = 36
      Width = 117
      Height = 17
      Caption = 'Stampa Tabellare'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkTabellareClick
    end
    object chkTurnista: TCheckBox
      Left = 12
      Top = 21
      Width = 197
      Height = 17
      Caption = 'Considera anche personale turnista'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object chkRaggData: TCheckBox
      Left = 220
      Top = 4
      Width = 165
      Height = 17
      Caption = 'Raggruppamento per data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = chkRaggDataClick
    end
    object chkTotali: TCheckBox
      Left = 409
      Top = 4
      Width = 156
      Height = 17
      Caption = 'Totale dip. generale'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object chkTotaliGruppo: TCheckBox
      Left = 409
      Top = 21
      Width = 172
      Height = 17
      Caption = 'Totale dip. per raggruppamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
    object chkTotaliData: TCheckBox
      Left = 220
      Top = 21
      Width = 172
      Height = 17
      Caption = 'Totale dip. per data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object chkSaltoPaginaData: TCheckBox
      Left = 220
      Top = 38
      Width = 180
      Height = 17
      Caption = 'Salto pagina per data'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object chkDescrizioneAssenze: TCheckBox
      Left = 12
      Top = 4
      Width = 203
      Height = 17
      Caption = 'Stampa descrizione causali di assenza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 87
    Width = 594
    Height = 79
    Align = alTop
    TabOrder = 1
    object rgpTipoStampa: TRadioGroup
      Left = 1
      Top = 1
      Width = 392
      Height = 75
      Caption = 'Tipo stampa'
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Presenti'
        'Assenti'
        'Assenti senza giust.'
        'Grafico presenze/assenze'
        'Prospetto ore lavorate'
        'Entrate/uscite causalizzate')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpTipoStampaClick
    end
    object BtnAvanzati: TBitBtn
      Left = 413
      Top = 26
      Width = 145
      Height = 30
      Caption = 'Impostazioni avanzate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00F808880FFFFF
        FFF07808000FFFF808F000880FFFFFF08000778008FFFFF80088800080FFFFFF
        088080F808FFFF00070800FFFFFFFF088707FFF000FFFF00070808F080F808FF
        08708000800080F800870088888008F08000088000880FF808F007088808000F
        FFF087070808880FFFFF07087808000FFFFF087000880FFFFFFF}
      ParentFont = False
      TabOrder = 1
      OnClick = BtnAvanzatiClick
    end
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 376
    Top = 8
  end
  object QRExcelFilter1: TQRExcelFilter
    TextEncoding = DefaultEncoding
    UseXLColumns = False
    Left = 456
    Top = 1
  end
  object QRRTFFilter1: TQRRTFFilter
    TextEncoding = DefaultEncoding
    Left = 484
    Top = 1
  end
  object QRTextFilter1: TQRTextFilter
    TextEncoding = DefaultEncoding
    Left = 428
    Top = 1
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 240
    object Selezionatutto1: TMenuItem
      Caption = 'Seleziona tutto'
      OnClick = Selezionatutto1Click
    end
    object Annullatutto1: TMenuItem
      Caption = 'Annulla tutto'
      OnClick = Selezionatutto1Click
    end
  end
end
