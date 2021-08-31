object C023FInfoDati: TC023FInfoDati
  Left = 0
  Top = 0
  Caption = '<C023> Informazioni'
  ClientHeight = 562
  ClientWidth = 643
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object tabMain: TPageControl
    Left = 0
    Top = 0
    Width = 643
    Height = 562
    ActivePage = tabInfoRichiesta
    Align = alClient
    TabOrder = 0
    OnChange = tabMainChange
    object tabInfoRichiesta: TTabSheet
      Caption = 'Info richiesta'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object grpInfoRichiedente: TGroupBox
        Left = 0
        Top = 0
        Width = 635
        Height = 150
        Align = alTop
        Caption = 'Informazioni della richiesta'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object lblIDRichiesta: TLabel
          Left = 16
          Top = 16
          Width = 58
          Height = 13
          Caption = 'ID richiesta:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblDataRichiesta: TLabel
          Left = 16
          Top = 35
          Width = 70
          Height = 13
          Caption = 'Data richiesta:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblCodiceIter: TLabel
          Left = 16
          Top = 54
          Width = 55
          Height = 13
          Caption = 'Codice iter:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblRichiedente: TLabel
          Left = 16
          Top = 73
          Width = 60
          Height = 13
          Caption = 'Richiedente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblNoteRichiedente: TLabel
          Left = 16
          Top = 92
          Width = 27
          Height = 13
          Caption = 'Note:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object lblIDRichiestaValue: TLabel
          Left = 160
          Top = 16
          Width = 90
          Height = 13
          Caption = 'lblIDRichiestaValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblDataRichiestaValue: TLabel
          Left = 160
          Top = 35
          Width = 102
          Height = 13
          Caption = 'lblDataRichiestaValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblCodiceIterValue: TLabel
          Left = 160
          Top = 54
          Width = 86
          Height = 13
          Caption = 'lblCodiceIterValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblRichiedenteValue: TLabel
          Left = 160
          Top = 73
          Width = 92
          Height = 13
          Caption = 'lblRichiedenteValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblNoteRichiedenteValue: TLabel
          Left = 160
          Top = 92
          Width = 470
          Height = 52
          AutoSize = False
          Caption = 'lblNoteRichiedenteValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
      end
      object grpInfoAutorizzatore: TGroupBox
        Left = 0
        Top = 150
        Width = 635
        Height = 150
        Align = alTop
        Caption = 'Informazioni dell'#39'autorizzazione'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblDataAutorizzazione: TLabel
          Left = 16
          Top = 20
          Width = 99
          Height = 13
          Caption = 'Data autorizzazione:'
        end
        object lblAutorizzatore: TLabel
          Left = 16
          Top = 39
          Width = 69
          Height = 13
          Caption = 'Autorizzatore:'
        end
        object lblNoteAutorizzatore: TLabel
          Left = 16
          Top = 58
          Width = 27
          Height = 13
          Caption = 'Note:'
        end
        object lblDataAutorizzazioneValue: TLabel
          Left = 160
          Top = 20
          Width = 129
          Height = 13
          Caption = 'lblDataAutorizzazioneValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblAutorizzatoreValue: TLabel
          Left = 160
          Top = 39
          Width = 101
          Height = 13
          Caption = 'lblAutorizzatoreValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblNoteAutorizzatoreValue: TLabel
          Left = 160
          Top = 58
          Width = 124
          Height = 13
          Caption = 'lblNoteAutorizzatoreValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
      end
      object grpInfoRevoca: TGroupBox
        Left = 0
        Top = 300
        Width = 635
        Height = 150
        Align = alTop
        Caption = 'Informazioni della revoca'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        object lblIDRevoca: TLabel
          Left = 16
          Top = 20
          Width = 51
          Height = 13
          Caption = 'ID revoca:'
        end
        object lblDataRevoca: TLabel
          Left = 16
          Top = 39
          Width = 63
          Height = 13
          Caption = 'Data revoca:'
        end
        object lblNoteRevoca: TLabel
          Left = 16
          Top = 58
          Width = 27
          Height = 13
          Caption = 'Note:'
        end
        object lblIDRevocaValue: TLabel
          Left = 160
          Top = 20
          Width = 83
          Height = 13
          Caption = 'lblIDRevocaValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblDataRevocaValue: TLabel
          Left = 160
          Top = 39
          Width = 69
          Height = 13
          Caption = 'lblDataRevoca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblNoteRevocaValue: TLabel
          Left = 160
          Top = 58
          Width = 470
          Height = 86
          AutoSize = False
          Caption = 'lblNoteRevocaValue'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
      end
      object dgrdDocumenti: TDBGrid
        Left = 0
        Top = 450
        Width = 635
        Height = 84
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        PopupMenu = pMnuDocumenti
        ReadOnly = True
        TabOrder = 3
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object tabInfoCertificatoINPS: TTabSheet
      Caption = 'Info certificato INPS'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblInfoCertINPS: TLabel
        Left = 0
        Top = 0
        Width = 66
        Height = 13
        Align = alTop
        Caption = 'ID certificato:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object grdCertINPS: TStringGrid
        Left = 0
        Top = 13
        Width = 635
        Height = 521
        Align = alClient
        ColCount = 2
        DoubleBuffered = True
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing]
        ParentDoubleBuffered = False
        TabOrder = 0
        RowHeights = (
          27
          24
          24
          24
          24)
      end
    end
    object tabLog: TTabSheet
      Caption = 'Log operazioni'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblInfoLog: TLabel
        Left = 0
        Top = 0
        Width = 37
        Height = 13
        Align = alTop
        Caption = 'Info log'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object dgrdLogOperazioni: TDBGrid
        Left = 0
        Top = 13
        Width = 635
        Height = 521
        Align = alClient
        DataSource = dsrI000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object pMnuDocumenti: TPopupMenu
    OnPopup = pMnuDocumentiPopup
    Left = 576
    Top = 472
    object Apri1: TMenuItem
      Caption = 'Apri'
      OnClick = Apri1Click
    end
    object Salva1: TMenuItem
      Caption = 'Salva'
      OnClick = Salva1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Carica1: TMenuItem
      Caption = 'Carica'
      OnClick = Carica1Click
    end
    object Elimina1: TMenuItem
      Caption = 'Elimina'
      OnClick = Elimina1Click
    end
  end
  object dlgFileSave: TSaveDialog
    Left = 487
    Top = 40
  end
  object dsrDocumentiInfo: TDataSource
    Left = 488
    Top = 104
  end
  object dsrI000: TDataSource
    Left = 488
    Top = 232
  end
  object dsrT048: TDataSource
    Left = 488
    Top = 176
  end
  object OpenDlg: TOpenDialog
    Left = 492
    Top = 404
  end
end
