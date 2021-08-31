object A044FAllineaStorici: TA044FAllineaStorici
  Left = 176
  Top = 188
  HelpContext = 44000
  BorderStyle = bsSingle
  Caption = '<A044> Allineamento dati storici'
  ClientHeight = 380
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object EnBBUpDate: TBitBtn
    Left = 27
    Top = 306
    Width = 92
    Height = 25
    Caption = '&Esegui'
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
    TabOrder = 0
    OnClick = EnBBUpDateClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 361
    Width = 460
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimpleText = '1 Record'
    SizeGrip = False
  end
  object Progress: TProgressBar
    Left = 0
    Top = 345
    Width = 460
    Height = 16
    Align = alBottom
    TabOrder = 2
  end
  object BtnClose: TBitBtn
    Left = 341
    Top = 306
    Width = 92
    Height = 25
    Caption = '&Chiudi'
    Kind = bkClose
    TabOrder = 3
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe
    Left = 0
    Top = 0
    Width = 460
    Height = 24
    Align = alTop
    TabOrder = 4
    TabStop = True
    ExplicitWidth = 460
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 460
      Height = 24
      ExplicitWidth = 460
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
  object cbxAllineaMovSucc: TCheckBox
    Left = 66
    Top = 36
    Width = 190
    Height = 17
    Align = alCustom
    Caption = 'Allineamento movimenti successivi'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = cbxAllineaMovSuccClick
  end
  object gbxOttimizzaPeriodiStorici: TGroupBox
    Left = 27
    Top = 108
    Width = 406
    Height = 192
    Caption = 'Ottimizzazione periodi storici uguali'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    object gbxEsecuzioneImmediata: TGroupBox
      Left = 20
      Top = 21
      Width = 365
      Height = 57
      Caption = 'Esecuzione immediata'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object cbxPresenze: TCheckBox
        Left = 19
        Top = 16
        Width = 64
        Height = 17
        Align = alCustom
        Caption = 'Presenze'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = cbxPresenzeClick
      end
      object cbxStipendi: TCheckBox
        Left = 19
        Top = 37
        Width = 64
        Height = 17
        Align = alCustom
        Caption = 'Stipendi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = cbxStipendiClick
      end
      object cbxAssLiberaPresenze: TCheckBox
        Left = 100
        Top = 16
        Width = 254
        Height = 17
        Align = alCustom
        Caption = 'Sovrascrivi assegnazioni per relazioni di tipo libero'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = cbxPresenzeClick
      end
      object cbxAssLiberaStipendi: TCheckBox
        Left = 100
        Top = 37
        Width = 253
        Height = 17
        Align = alCustom
        Caption = 'Sovrascrivi assegnazioni per relazioni di tipo libero'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = cbxPresenzeClick
      end
    end
    object gbxSchedulazioneJob: TGroupBox
      Left = 20
      Top = 84
      Width = 365
      Height = 93
      Caption = 'Schedulazione giornaliera job'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lblOrarioJob: TLabel
        Left = 105
        Top = 48
        Width = 45
        Height = 13
        Caption = 'Orario job'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object sbtnRicreazioneJob: TSpeedButton
        Left = 102
        Top = 20
        Width = 161
        Height = 22
        Caption = 'Ricreazione job'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = sbtnRicreazioneJobClick
      end
      object sbtnApplicaOrario: TSpeedButton
        Left = 207
        Top = 43
        Width = 56
        Height = 22
        Caption = 'Applica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        OnClick = sbtnApplicaOrarioJobClick
      end
      object lblIdJob: TLabel
        Left = 102
        Top = 71
        Width = 161
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'Id job:'
      end
      object medtOrarioJob: TMaskEdit
        Left = 165
        Top = 44
        Width = 36
        Height = 21
        EditMask = '!90:00;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 5
        ParentFont = False
        TabOrder = 0
        Text = '  .  '
      end
    end
  end
  object btnAnomalie: TBitBtn
    Left = 136
    Top = 306
    Width = 92
    Height = 25
    Caption = '&Anomalie'
    Enabled = False
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
    TabOrder = 7
    OnClick = btnAnomalieClick
  end
  object cbxAllineaPrimoStorico: TCheckBox
    Left = 66
    Top = 67
    Width = 257
    Height = 17
    Align = alCustom
    Caption = 'Allinea la prima decorrenza alla prima assunzione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = cbxAllineaPrimoStoricoClick
  end
end
