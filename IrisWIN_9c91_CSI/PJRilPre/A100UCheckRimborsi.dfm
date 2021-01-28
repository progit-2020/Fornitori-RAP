inherited A100FCheckRimborsi: TA100FCheckRimborsi
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A100> Controllo rimborsi'
  ClientHeight = 481
  ClientWidth = 659
  ExplicitWidth = 669
  ExplicitHeight = 531
  PixelsPerInch = 96
  TextHeight = 13
  object splMasterDetail: TSplitter [0]
    Left = 0
    Top = 257
    Width = 659
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -8
    ExplicitTop = 226
    ExplicitWidth = 633
  end
  inherited StatusBar: TStatusBar
    Top = 463
    Width = 659
    ExplicitTop = 463
    ExplicitWidth = 659
  end
  inherited Panel1: TToolBar
    Width = 659
    ExplicitWidth = 659
    inherited TInser: TToolButton
      Visible = False
    end
    inherited TModif: TToolButton
      Visible = False
    end
    inherited TCanc: TToolButton
      Visible = False
    end
    inherited TAnnulla: TToolButton
      Visible = False
    end
    inherited TRegis: TToolButton
      Visible = False
    end
    inherited TGomma: TToolButton
      Visible = False
    end
  end
  object tabPrincipale: TPageControl [3]
    Left = 0
    Top = 260
    Width = 659
    Height = 203
    ActivePage = tbsRimborsi
    Align = alClient
    TabOrder = 2
    object tbsRimborsi: TTabSheet
      Caption = 'Rimborsi'
      ImageIndex = 2
      object dgrdRimborsi: TDBGrid
        Left = 0
        Top = 23
        Width = 651
        Height = 152
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'PROGRESSIVO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'MESESCARICO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'MESECOMPETENZA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DATADA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ORADA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'CODICERIMBORSOSPESE'
            Title.Caption = 'Voce rimborso'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DESCRIZIONE'
            Title.Caption = 'Voce rimborso'
            Width = 146
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PROGRIMBORSO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DATARIMBORSO'
            Title.Caption = 'Data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMPORTO'
            Title.Caption = 'Importo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TIPORIMBORSO'
            Title.Caption = 'Tipo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMPORTO_VALEST'
            Title.Caption = 'Importo val. est.'
            Width = 79
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'D_STATO'
            Title.Caption = 'Stato'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATO'
            PickList.Strings = (
              'N'
              'V')
            Title.Caption = 'Stato'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            Title.Caption = 'Note'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMPORTO_ORIGINALE'
            Title.Caption = 'Importo orig.'
            Visible = True
          end>
      end
      inline frmToolbarFiglioRimborsi: TfrmToolbarFiglio
        Left = 0
        Top = 0
        Width = 651
        Height = 23
        Align = alTop
        TabOrder = 1
        TabStop = True
        ExplicitWidth = 651
        inherited tlbarFiglio: TToolBar
          Width = 651
          ExplicitWidth = 651
        end
      end
    end
    object tbsIndKm: TTabSheet
      Caption = 'Indennit'#224' km'
      ImageIndex = 3
      object dgrdIndKm: TDBGrid
        Left = 0
        Top = 23
        Width = 651
        Height = 152
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'PROGRESSIVO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'MESESCARICO'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'MESECOMPETENZA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DATADA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'ORADA'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'CODICEINDENNITAKM'
            Title.Caption = 'Cod. ind. km'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'DESCRIZIONE'
            ReadOnly = True
            Title.Caption = 'Indennit'#224
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'KMPERCORSI'
            Title.Caption = 'Km percorsi'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'IMPORTOINDENNITA'
            Title.Caption = 'Importo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID_MISSIONE'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'D_STATO'
            Title.Caption = 'Stato'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'STATO'
            PickList.Strings = (
              'N'
              'V')
            Title.Caption = 'Stato'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'NOTE'
            Title.Caption = 'Note'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'KMPERCORSI_ORIGINALI'
            Title.Caption = 'Km percorsi orig.'
            Width = 85
            Visible = True
          end>
      end
      inline frmToolbarFiglioIndKm: TfrmToolbarFiglio
        Left = 0
        Top = 0
        Width = 651
        Height = 23
        Align = alTop
        TabOrder = 1
        TabStop = True
        ExplicitWidth = 651
        inherited tlbarFiglio: TToolBar
          Width = 651
          ExplicitWidth = 651
        end
      end
    end
    object tbsDatiLiberi: TTabSheet
      Caption = 'Dati liberi'
      inline frmToolbarFiglioDatiLiberi: TfrmToolbarFiglio
        Left = 0
        Top = 0
        Width = 651
        Height = 23
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 651
        inherited tlbarFiglio: TToolBar
          Width = 651
          ExplicitWidth = 651
          inherited btnTFInserisci: TToolButton
            Visible = False
          end
          inherited btnTFModifica: TToolButton
            Visible = False
          end
          inherited btnTFCancella: TToolButton
            Visible = False
          end
          inherited btnTFAnnulla: TToolButton
            Visible = False
          end
          inherited btnTFConferma: TToolButton
            Visible = False
          end
          inherited btnTFGomma: TToolButton
            Visible = False
          end
        end
      end
      object dgrdDatiLiberi: TDBGrid
        Left = 0
        Top = 23
        Width = 651
        Height = 152
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
    object tbsMezzi: TTabSheet
      Caption = 'Mezzi di trasporto'
      ImageIndex = 1
      inline frmToolbarFiglioMezzi: TfrmToolbarFiglio
        Left = 0
        Top = 0
        Width = 651
        Height = 23
        Align = alTop
        TabOrder = 0
        TabStop = True
        ExplicitWidth = 651
        inherited tlbarFiglio: TToolBar
          Width = 651
          ExplicitWidth = 651
          inherited btnTFInserisci: TToolButton
            Visible = False
          end
          inherited btnTFModifica: TToolButton
            Visible = False
          end
          inherited btnTFCancella: TToolButton
            Visible = False
          end
          inherited btnTFAnnulla: TToolButton
            Visible = False
          end
          inherited btnTFConferma: TToolButton
            Visible = False
          end
          inherited btnTFGomma: TToolButton
            Visible = False
          end
        end
      end
      object dgrdMezzi: TDBGrid
        Left = 0
        Top = 23
        Width = 651
        Height = 152
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlue
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object pnlTop: TPanel [4]
    Left = 0
    Top = 29
    Width = 659
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object grpPeriodo: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 208
      Height = 44
      Align = alLeft
      Caption = 'Periodo'
      TabOrder = 0
      object lblPeriodoDal: TLabel
        Left = 6
        Top = 20
        Width = 16
        Height = 13
        Caption = 'Dal'
      end
      object lblPeriodoAl: TLabel
        Left = 107
        Top = 20
        Width = 8
        Height = 13
        Caption = 'al'
      end
      object edtPeriodoDal: TMaskEdit
        Left = 30
        Top = 17
        Width = 69
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
      end
      object edtPeriodoAl: TMaskEdit
        Left = 122
        Top = 17
        Width = 69
        Height = 21
        EditMask = '!99/99/0000;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
      end
    end
    object rgpRimborsi: TRadioGroup
      AlignWithMargins = True
      Left = 217
      Top = 3
      Width = 154
      Height = 44
      Align = alLeft
      Caption = 'Rimborsi'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'S'#236
        'No'
        'Tutti')
      TabOrder = 1
      OnClick = rgpRimborsiClick
    end
    object rgpStato: TRadioGroup
      AlignWithMargins = True
      Left = 377
      Top = 3
      Width = 278
      Height = 44
      Align = alLeft
      Caption = 'Stato'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Tutti'
        'Verificati'
        'Da verificare')
      TabOrder = 2
      OnClick = rgpStatoClick
    end
  end
  object pnlMaster: TPanel [5]
    Left = 0
    Top = 79
    Width = 659
    Height = 178
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    object dgrdDatiMissione: TDBGrid
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 653
      Height = 172
      Align = alClient
      DataSource = DButton
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 432
    Top = 65522
  end
  inherited DButton: TDataSource
    Left = 460
    Top = 65522
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 488
    Top = 65522
  end
  inherited ImageList1: TImageList
    Left = 524
    Top = 65522
  end
  inherited ActionList1: TActionList
    Left = 560
    Top = 65522
    inherited actStampa: TAction
      Visible = False
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 104
    Top = 93
    object CopiaInExcel: TMenuItem
      Caption = 'Copia in Excel'
      OnClick = CopiaInExcelClick
    end
  end
end
