inherited A136FRelazioniAnagrafe: TA136FRelazioniAnagrafe
  HelpContext = 136000
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = '<A136> Relazioni tra dati anagrafici'
  ClientHeight = 531
  ClientWidth = 788
  ExplicitWidth = 804
  ExplicitHeight = 589
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 275
    Width = 788
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 183
    ExplicitWidth = 259
  end
  inherited StatusBar: TStatusBar
    Top = 513
    Width = 788
    ExplicitTop = 513
    ExplicitWidth = 788
  end
  inherited grbDecorrenza: TGroupBox
    Width = 788
    TabOrder = 0
    ExplicitWidth = 788
    object lblCampo1NonEsistente: TLabel [2]
      Left = 373
      Top = 6
      Width = 112
      Height = 13
      Caption = 'lblCampo1NonEsistente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblCampo2NonEsistente: TLabel [3]
      Left = 373
      Top = 20
      Width = 112
      Height = 13
      Caption = 'lblCampo2NonEsistente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    inherited dedtDecorrenza: TDBEdit
      DataField = 'DECORRENZA'
    end
  end
  inherited ToolBar1: TToolBar
    Width = 788
    TabOrder = 6
    ExplicitWidth = 788
  end
  object dgrdRelazioni: TDBGrid [4]
    Left = 0
    Top = 63
    Width = 788
    Height = 212
    Align = alTop
    DataSource = DButton
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dgrdRelazioniEditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'TABELLA'
        PickList.Strings = (
          'T430_STORICO'
          'P430_ANAGRAFICO')
        Title.Caption = 'Tabella'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 122
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'COLONNA'
        Title.Caption = 'Colonna'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DECORRENZA'
        Title.Caption = 'Decorrenza'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORDINE'
        Title.Caption = 'Ordine'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 35
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TIPO'
        PickList.Strings = (
          'S - Assegnazione automatica vincolata'
          'L - Assegnazione automatica libera'
          'F - Assegnazione filtrata')
        Title.Caption = 'Tipo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'D_TIPO'
        Title.Caption = 'Desc. tipo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TAB_ORIGINE'
        PickList.Strings = (
          'T430_STORICO'
          'P430_ANAGRAFICO')
        Title.Caption = 'Tabella origine'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 122
        Visible = True
      end
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'COL_ORIGINE'
        Title.Caption = 'Colonna origine'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 100
        Visible = True
      end>
  end
  object memRelazione: TMemo [5]
    Left = 0
    Top = 294
    Width = 788
    Height = 184
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 3
    WordWrap = False
  end
  object pnlBottom: TPanel [6]
    Left = 0
    Top = 478
    Width = 788
    Height = 35
    Align = alBottom
    TabOrder = 4
    object btnComponiRelazione: TButton
      Left = 281
      Top = 4
      Width = 97
      Height = 25
      Caption = 'Componi relazione'
      TabOrder = 1
      OnClick = btnComponiRelazioneClick
    end
    object btnVerificaSQL: TButton
      Left = 152
      Top = 4
      Width = 97
      Height = 25
      Caption = 'Verifica SQL'
      TabOrder = 0
      OnClick = btnVerificaSQLClick
    end
    object btnInserisciTag: TButton
      Left = 410
      Top = 4
      Width = 97
      Height = 25
      Caption = 'Inserisci <#>'
      TabOrder = 2
      OnClick = btnInserisciTagClick
    end
    object btnStampaRelazioni: TButton
      Left = 539
      Top = 4
      Width = 97
      Height = 25
      Caption = 'Stampa relazioni'
      TabOrder = 3
      OnClick = btnStampaRelazioniClick
    end
  end
  object pnlTitoloRelazione: TPanel [7]
    Left = 0
    Top = 278
    Width = 788
    Height = 16
    Align = alTop
    Caption = 'Relazione'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  inherited MainMenu1: TMainMenu
    Left = 560
    Top = 65528
  end
  inherited DButton: TDataSource
    Left = 588
    Top = 65528
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 616
    Top = 65528
  end
  inherited ImageList1: TImageList
    Left = 644
    Top = 65528
  end
  inherited ActionList1: TActionList
    Left = 672
    Top = 65528
  end
end
