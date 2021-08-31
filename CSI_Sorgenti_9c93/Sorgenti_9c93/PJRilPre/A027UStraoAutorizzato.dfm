object A027FStraoAutorizzato: TA027FStraoAutorizzato
  Left = 0
  Top = 0
  HelpContext = 27200
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A027> Straordinari Autorizzati'
  ClientHeight = 423
  ClientWidth = 1130
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dgrdT065: TDBGrid
    Left = 0
    Top = 106
    Width = 1130
    Height = 298
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1130
    Height = 106
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblMeseStrao: TLabel
      Left = 8
      Top = 4
      Width = 135
      Height = 13
      Caption = 'Straordinari del mese di'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rgpDestinazione: TRadioGroup
      Left = 8
      Top = 22
      Width = 1081
      Height = 39
      Caption = 'Filtro Destinazione ore'
      Columns = 8
      ItemIndex = 0
      Items.Strings = (
        'effettuate'
        'non effettuate'
        'entrambe'
        'gi'#224' liquidate'
        'destinaz. ritardata'
        'solo ore notturne'
        'ANOM_AUTST_MESE'
        'VERIFICA_STESC_AUTST')
      TabOrder = 0
      OnClick = rgpDestinazioneClick
    end
    object rgpTipoElaborazione: TRadioGroup
      Left = 8
      Top = 61
      Width = 185
      Height = 39
      Caption = 'Elaborazione'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Singola'
        'Collettiva')
      TabOrder = 1
      OnClick = rgpTipoElaborazioneClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 404
    Width = 1130
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 104
    Top = 184
    object Annullaliquidazione1: TMenuItem
      Caption = 'Annulla liquidazione'
      OnClick = Annullaliquidazione1Click
    end
    object Annulladestinazione1: TMenuItem
      Caption = 'Annulla destinazione'
      OnClick = Annulladestinazione1Click
    end
    object Annullatagliobancaore1: TMenuItem
      Caption = 'Annulla taglio banca ore'
      OnClick = Annullatagliobancaore1Click
    end
    object Tagliobancaore1: TMenuItem
      Caption = 'Taglio banca ore'
      OnClick = Tagliobancaore1Click
    end
    object Eseguiliquidazione1: TMenuItem
      Caption = 'Esegui liquidazione'
      OnClick = Eseguiliquidazione1Click
    end
    object Eseguitagliobancaoreliquidazione1: TMenuItem
      Caption = 'Esegui taglio banca ore + liquidazione'
      OnClick = Eseguitagliobancaoreliquidazione1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Anteprima1: TMenuItem
      Caption = 'Anteprima'
      OnClick = Anteprima1Click
    end
    object CopiainExcel1: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiainExcel1Click
    end
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 184
    Top = 184
    object Liquidaorenotturne1: TMenuItem
      Caption = 'Liquida ore notturne'
      OnClick = Liquidaorenotturne1Click
    end
    object Annullaliquidazioneorenotturne1: TMenuItem
      Caption = 'Annulla liquidazione ore notturne'
      OnClick = Annullaliquidazioneorenotturne1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Anteprima2: TMenuItem
      Caption = 'Anteprima'
      OnClick = Anteprima2Click
    end
    object Copiainexcel2: TMenuItem
      Caption = 'Copia in excel'
      OnClick = Copiainexcel2Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 264
    Top = 184
    object MenuItem5: TMenuItem
      Caption = 'Copia in excel'
      OnClick = Copiainexcel2Click
    end
  end
end
