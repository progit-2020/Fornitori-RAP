object A058FGrigliaPianif: TA058FGrigliaPianif
  Left = 183
  Top = 144
  HelpContext = 58000
  ActiveControl = GVista
  Caption = '<A058> Visualizzazione turni pianificati'
  ClientHeight = 527
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 463
    Width = 806
    Height = 64
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 510
      Top = 2
      Width = 25
      Height = 25
      Hint = 'Modifica rapida'
      AllowAllUp = True
      GroupIndex = 1
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333000003333333333F777773FF333333008877700
        33333337733FFF773F33330887000777033333733F777FFF73F330880F9F9F07
        703337F37733377FF7F33080F00000F07033373733777337F73F087F0091100F
        77037F3737333737FF7F08090919110907037F737F3333737F7F0F0F0999910F
        07037F737F3333737F7F0F090F99190908037F737FF33373737F0F7F00FF900F
        780373F737FFF737F3733080F00000F0803337F73377733737F330F80F9F9F08
        8033373F773337733733330F8700078803333373FF77733F733333300FFF8800
        3333333773FFFF77333333333000003333333333377777333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object LblOPerazioni: TLabel
      Left = 2
      Top = 29
      Width = 3
      Height = 13
    end
    object BRegistrazione: TBitBtn
      Left = 2
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Registrazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      OnClick = BRegistrazioneClick
    end
    object BitBtn3: TBitBtn
      Left = 579
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Chiudi'
      Kind = bkClose
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
    end
    object PGVista: TProgressBar
      Left = 0
      Top = 48
      Width = 806
      Height = 16
      Align = alBottom
      TabOrder = 5
    end
    object BCancellazione: TBitBtn
      Left = 79
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Cancellazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      OnClick = BCancellazioneClick
    end
    object btnAnteprima: TBitBtn
      Left = 401
      Top = 2
      Width = 92
      Height = 25
      Caption = 'Anteprima'
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
        FFFF000000000000FF000FFFFFFFFFF0F0000FFFFFFF0000800F0FFFFFF08778
        08FF0FFFFF0877E880FF0FFFFF07777870FF0FFFFF07E77870FF0FFFFF08EE78
        80FF0FFFFFF087780FFF0FFFFFFF0000FFFF0FFFFFFFFFF0FFFF0FFFFFFF0000
        FFFF0FFFFFFF070FFFFF0FFFFFFF00FFFFFF000000000FFFFFFF}
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      OnClick = btnAnteprimaClick
    end
    object btnAnomalie: TBitBtn
      Left = 323
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Anomalie'
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
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = btnAnomalieClick
    end
    object BOperativa: TBitBtn
      Left = 157
      Top = 2
      Width = 85
      Height = 25
      Caption = 'Rendi operativa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 6
      Visible = False
      OnClick = BOperativaClick
    end
    object BtnVerificaTurni: TBitBtn
      Left = 245
      Top = 2
      Width = 75
      Height = 25
      Caption = 'Verifica Turni'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Visible = False
      OnClick = BtnVerificaTurniClick
    end
  end
  object GVista: TStringGrid
    Left = 0
    Top = 27
    Width = 806
    Height = 436
    Align = alClient
    ColCount = 8
    DefaultColWidth = 100
    DefaultRowHeight = 45
    FixedCols = 6
    FixedRows = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing]
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnClick = GVistaClick
    OnDblClick = GVistaDblClick
    OnDrawCell = GVistaDrawCell
    OnKeyDown = GVistaKeyDown
    OnKeyPress = GVistaKeyPress
    OnKeyUp = GVistaKeyUp
    OnMouseDown = GVistaMouseDown
    OnSelectCell = GVistaSelectCell
    RowHeights = (
      45
      45
      45
      45
      45)
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 806
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Shape1: TShape
      Left = 2
      Top = 12
      Width = 73
      Height = 13
    end
    object Label1: TLabel
      Left = 2
      Top = -1
      Width = 71
      Height = 13
      Caption = 'Non pianificato'
    end
    object Shape2: TShape
      Left = 78
      Top = 12
      Width = 73
      Height = 13
      Brush.Color = 8454143
    end
    object Label2: TLabel
      Left = 78
      Top = -1
      Width = 49
      Height = 13
      Caption = 'Pianificato'
    end
    object Shape3: TShape
      Left = 154
      Top = 12
      Width = 73
      Height = 13
      Brush.Color = 6939763
    end
    object Label3: TLabel
      Left = 154
      Top = -1
      Width = 64
      Height = 13
      Caption = 'Sviluppo turni'
    end
    object Shape4: TShape
      Left = 230
      Top = 12
      Width = 73
      Height = 13
      Brush.Color = clAqua
    end
    object Label4: TLabel
      Left = 230
      Top = -1
      Width = 76
      Height = 13
      Caption = 'Cambio squadra'
    end
    object LblModificaRapida: TLabel
      Left = 422
      Top = 12
      Width = 81
      Height = 13
      Caption = 'Modifica rapida...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 11
    Top = 152
    object Modifica1: TMenuItem
      Caption = 'Modifica'
      OnClick = Modifica1Click
    end
    object Copiapianificazione1: TMenuItem
      Caption = 'Copia pianificazione'
      OnClick = Copiapianificazione1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object InsCancGiust1: TMenuItem
      Caption = 'Ins/Canc Giustificativi'
      OnClick = InsCancGiust1Click
    end
    object Reperibilit1: TMenuItem
      Caption = 'Pianificazione Reperibilit'#224
      OnClick = Reperibilit1Click
    end
    object Indennitdifunzione1: TMenuItem
      Caption = 'Indennit'#224' di funzione'
      OnClick = Indennitdifunzione1Click
    end
    object ValidaCausale1: TMenuItem
      Caption = 'Valida Causale'
      OnClick = ValidaCausale1Click
    end
    object VisualizzaAssenze1: TMenuItem
      Caption = 'Visualizza assenze da validare nel periodo'
      OnClick = VisualizzaAssenze1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Visualizzacopertura1: TMenuItem
      Caption = 'Visualizza riga copertura turni squadra'
      OnClick = Visualizzacopertura1Click
    end
    object Visualizzaturni: TMenuItem
      Caption = 'Visualizza colonna totale turni per dipendente'
      OnClick = VisualizzaturniClick
    end
    object Visualizzadebito1: TMenuItem
      Caption = 'Visualizza colonna saldi ore (debito/pianif./residuo)'
      OnClick = Visualizzadebito1Click
    end
    object Visualizzaassenze: TMenuItem
      Caption = 'Visualizza colonna situazione assenze'
      Visible = False
      OnClick = VisualizzaassenzeClick
    end
    object VisualizzaRiposiFestivi: TMenuItem
      Caption = 'Visualizza colonna riposi/fest.lav. al mese precedente'
      OnClick = VisualizzaRiposiFestiviClick
    end
    object Visualizzacolonnabadge1: TMenuItem
      Caption = 'Visualizza colonna badge'
      OnClick = Visualizzacolonnabadge1Click
    end
    object Visualizzazionesintetica1: TMenuItem
      Caption = 'Visualizza tabellone sintetico'
      OnClick = Visualizzazionesintetica1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Visualizzadettaglioorariogiornaliero1: TMenuItem
      Caption = 'Visualizza dettaglio orario giornaliero'
      OnClick = Visualizzadettaglioorariogiornaliero1Click
    end
    object Visualizzalimititipologieprofessionali1: TMenuItem
      Caption = 'Visualizza limiti tipologie operatori'
      OnClick = Visualizzalimititipologieprofessionali1Click
    end
    object CompetenzeResiduiassenza1: TMenuItem
      Caption = 'Visualizza competenze/residui assenza'
      OnClick = CompetenzeResiduiassenza1Click
    end
    object VisualizzaCoperturaSquadre1: TMenuItem
      Caption = 'Visualizza copertura squadre'
      OnClick = VisualizzaCoperturaSquadre1Click
    end
  end
end
