object A075FFineAnno: TA075FFineAnno
  Left = 235
  Top = 200
  HelpContext = 75000
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '<A075> Passaggio di anno'
  ClientHeight = 455
  ClientWidth = 539
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
  object LDaData: TLabel
    Left = 12
    Top = 30
    Width = 134
    Height = 13
    Caption = 'Nuovo anno da gestire:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grpResiduiAssenza: TGroupBox
    Left = 255
    Top = 221
    Width = 275
    Height = 161
    TabOrder = 18
    object memResiduiAssenza: TMemo
      AlignWithMargins = True
      Left = 5
      Top = 38
      Width = 265
      Height = 118
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
      WordWrap = False
    end
    object chkResiduiAsseOvr: TCheckBox
      AlignWithMargins = True
      Left = 25
      Top = 15
      Width = 245
      Height = 17
      Margins.Left = 23
      Margins.Top = 0
      Align = alTop
      Caption = 'Sovrascrivi dati esistenti'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 420
    Width = 539
    Height = 16
    Align = alBottom
    TabOrder = 20
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 436
    Width = 539
    Height = 19
    Panels = <
      item
        Text = '0 Records'
        Width = 300
      end
      item
        Width = 50
      end>
    SimpleText = '0 Records'
  end
  object chkCalendari: TCheckBox
    Left = 13
    Top = 102
    Width = 215
    Height = 17
    Caption = 'Generazione calendari'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object chkProfiliAsse: TCheckBox
    Left = 13
    Top = 123
    Width = 215
    Height = 17
    Caption = 'Generazione profili assenza'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object EAnno: TMaskEdit
    Left = 151
    Top = 27
    Width = 37
    Height = 21
    EditMask = '0000;1;_'
    MaxLength = 4
    TabOrder = 1
    Text = '    '
    OnChange = EAnnoChange
  end
  object chkResiduiBuoniTicket: TCheckBox
    Left = 262
    Top = 102
    Width = 171
    Height = 17
    Caption = 'Residui buoni pasto/ticket'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnClick = chkResiduiBuoniTicketClick
  end
  object chkProfiliIndividuali: TCheckBox
    Left = 13
    Top = 145
    Width = 215
    Height = 17
    Caption = 'Generazione profili assenza individuali'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 539
    Height = 24
    Align = alTop
    TabOrder = 0
    TabStop = True
    ExplicitWidth = 539
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 539
      Height = 24
      ExplicitWidth = 539
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = TfrmSelAnagrafe1R003DatianagraficiClick
      end
    end
  end
  object grpLimitiEccedenze: TGroupBox
    Left = 8
    Top = 221
    Width = 241
    Height = 161
    Caption = 'Limiti alle eccedenze'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    object chkLimitiIndividualiMensili: TCheckBox
      Left = 5
      Top = 59
      Width = 215
      Height = 18
      Caption = 'Generazione limiti ecc. indiv. mensili'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = chkLimitiIndividualiMensiliClick
    end
    object chkLimitiMensili: TCheckBox
      Left = 5
      Top = 100
      Width = 215
      Height = 17
      Caption = 'Generazione limiti eccedenze mensili'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = chkLimitiMensiliClick
    end
    object rgpLimiti: TRadioGroup
      AlignWithMargins = True
      Left = 5
      Top = 125
      Width = 231
      Height = 31
      Align = alBottom
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Mese per mese'
        'Solo dicembre')
      TabOrder = 5
    end
    object chkLimitiIndividualiAnnuali: TCheckBox
      Left = 5
      Top = 18
      Width = 215
      Height = 17
      Caption = 'Generazione limiti ecc. indiv. annuali'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = chkLimitiIndividualiAnnualiClick
    end
    object chkLimitiIndividualiAnnualiOvr: TCheckBox
      Left = 21
      Top = 38
      Width = 199
      Height = 17
      Caption = 'Sovrascrivi dati esistenti'
      Enabled = False
      TabOrder = 1
    end
    object chkLimitiIndividualiMensiliOvr: TCheckBox
      Left = 21
      Top = 80
      Width = 199
      Height = 17
      Caption = 'Sovrascrivi dati esistenti'
      Enabled = False
      TabOrder = 3
    end
  end
  object chkResiduiCrediti: TCheckBox
    Left = 262
    Top = 145
    Width = 171
    Height = 17
    Caption = 'Residui crediti formativi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object chkDebitiAggiuntivi: TCheckBox
    Left = 13
    Top = 167
    Width = 215
    Height = 17
    Caption = 'Generazione debiti aggiuntivi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object chkDebitiAggiuntiviIndiv: TCheckBox
    Left = 13
    Top = 189
    Width = 215
    Height = 17
    Caption = 'Generazione debiti aggiuntivi individuali'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object chkTriggerBefore: TCheckBox
    Left = 13
    Top = 53
    Width = 215
    Height = 17
    Caption = 'Procedura Oracle prima dell'#39'elaborazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object chkTriggerAfter: TCheckBox
    Left = 13
    Top = 78
    Width = 215
    Height = 17
    Caption = 'Procedura Oracle dopo l'#39'elaborazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object chkResiduiOre: TCheckBox
    Left = 262
    Top = 167
    Width = 171
    Height = 17
    Caption = 'Residui saldo ore annuo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    OnClick = chkResiduiOreClick
  end
  object chkResiduiAsse: TCheckBox
    Left = 262
    Top = 218
    Width = 101
    Height = 17
    Caption = 'Residui assenze'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 17
    OnClick = chkResiduiAsseClick
  end
  object btnSrcResiduiTriggerBefore: TBitBtn
    Left = 231
    Top = 50
    Width = 23
    Height = 23
    Hint = 'Sorgente pl/sql'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btnSrcResiduiTriggerBeforeClick
  end
  object btnSrcResiduiTriggerAfter: TBitBtn
    Left = 231
    Top = 75
    Width = 23
    Height = 23
    Hint = 'Sorgente pl/sql'
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      0400000000008000000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
      FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
      08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
      80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
      FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = btnSrcResiduiTriggerBeforeClick
  end
  object chkResiduiBuoniTicketOvr: TCheckBox
    Left = 279
    Top = 123
    Width = 154
    Height = 17
    Caption = 'Sovrascrivi dati esistenti'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object chkResiduiOreOvr: TCheckBox
    Left = 281
    Top = 189
    Width = 152
    Height = 17
    Caption = 'Sovrascrivi dati esistenti'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
  end
  object pnlAzioni: TPanel
    Left = 0
    Top = 388
    Width = 539
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 19
    object BtnStampa: TBitBtn
      Left = 8
      Top = 4
      Width = 80
      Height = 25
      Caption = '&Esegui'
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
      OnClick = BtnStampaClick
    end
    object btnAnomalie: TBitBtn
      Left = 97
      Top = 4
      Width = 80
      Height = 25
      Caption = '&Anomalie'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnAnomalieClick
    end
    object BtnClose: TBitBtn
      Left = 185
      Top = 4
      Width = 80
      Height = 25
      Caption = '&Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
  end
end
