inherited A115FIterAutorizzativi: TA115FIterAutorizzativi
  HelpContext = 115000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A115> Iter autorizzativi'
  ClientHeight = 582
  ClientWidth = 752
  ExplicitWidth = 762
  ExplicitHeight = 632
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 307
    Width = 752
    Height = 2
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -105
    ExplicitTop = 273
    ExplicitWidth = 647
  end
  object Splitter2: TSplitter [1]
    Left = 0
    Top = 433
    Width = 752
    Height = 2
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 312
  end
  inherited StatusBar: TStatusBar
    Top = 564
    Width = 752
    ExplicitTop = 564
    ExplicitWidth = 752
  end
  inherited Panel1: TToolBar
    Width = 752
    ExplicitWidth = 752
  end
  object Panel5: TPanel [4]
    Left = 0
    Top = 29
    Width = 752
    Height = 21
    Align = alTop
    Caption = 'Iter autorizzativi disponibili per l'#39'azienda "%s"'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object dgrdselI093: TDBGrid [5]
    Left = 0
    Top = 50
    Width = 752
    Height = 257
    Align = alTop
    DataSource = A115FIterAutorizzativiDM.dsrI093
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -12
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dgrdselI093EditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'D_iter'
        Width = 149
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REVOCABILE'
        PickList.Strings = (
          'S'
          'N')
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'MAIL_OGGETTO_DIP'
        Width = 64
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'MAIL_CORPO_DIP'
        Width = 64
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'MAIL_OGGETTO_RESP'
        Width = 64
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'MAIL_CORPO_RESP'
        Width = 64
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'EXPR_PERIODO_VISUAL'
        Width = 64
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'C_CHKDATI_ITER_AUT'
        Width = 64
        Visible = True
      end>
  end
  object Panel2: TPanel [6]
    Left = 0
    Top = 309
    Width = 752
    Height = 124
    Align = alClient
    TabOrder = 4
    object dgrdselI095: TDBGrid
      Left = 1
      Top = 24
      Width = 750
      Height = 99
      Align = alClient
      DataSource = A115FIterAutorizzativiDM.dsrI095
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dgrdselI095EditButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'COD_ITER'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRIZIONE'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'FILTRO_RICHIESTA'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'CONDIZ_AUTORIZZ_AUTOMATICA'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MAX_LIV_AUTORIZZ_AUTOMATICA'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'C_VALIDITA_ITER_AUT'
          Width = 93
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FILTRO_INTERFACCIA'
          PickList.Strings = (
            'S'
            'N')
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MAX_LIV_NOTE_MODIFICABILI'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'CONDIZIONE_ALLEGATI'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'ALLEGATI_MODIFICABILI'
          PickList.Strings = (
            'S'
            'N')
          Width = 64
          Visible = True
        end>
    end
    inline frmToolbarSelI095: TfrmToolbarFiglio
      Left = 1
      Top = 1
      Width = 750
      Height = 23
      Align = alTop
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 750
      inherited tlbarFiglio: TToolBar
        Width = 750
        ExplicitWidth = 750
      end
    end
  end
  object Panel3: TPanel [7]
    Left = 0
    Top = 435
    Width = 752
    Height = 129
    Align = alBottom
    TabOrder = 5
    object dgrdselI096: TDBGrid
      Left = 1
      Top = 24
      Width = 750
      Height = 104
      Align = alClient
      DataSource = A115FIterAutorizzativiDM.dsrI096
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      PopupMenu = pmnLivelli
      ShowHint = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnColEnter = dgrdselI096ColEnter
      OnEditButtonClick = dgrdselI096EditButtonClick
      Columns = <
        item
          Color = clSilver
          Expanded = False
          FieldName = 'LIVELLO'
          PickList.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9')
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESC_LIVELLO'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FASE'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'OBBLIGATORIO'
          PickList.Strings = (
            'S'
            'N')
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AVVISO'
          PickList.Strings = (
            'S'
            'N')
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORI_POSSIBILI'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DATI_MODIFICABILI'
          PickList.Strings = (
            'S'
            'N')
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'AUTORIZZ_INTERMEDIA'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'INVIO_EMAIL'
          PickList.Strings = (
            'N'
            'A'
            'R'
            'E')
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'CONDIZ_AUTORIZZ_AUTOMATICA'
          Width = 64
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'SCRIPT_AUTORIZZ'
          Width = 64
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ALLEGATI_OBBLIGATORI'
          PickList.Strings = (
            'S'
            'N')
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ALLEGATI_VISIBILI'
          PickList.Strings = (
            'S'
            'N')
          Width = 64
          Visible = True
        end>
    end
    inline frmToolbarSelI096: TfrmToolbarFiglio
      Left = 1
      Top = 1
      Width = 750
      Height = 23
      Align = alTop
      TabOrder = 1
      TabStop = True
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 750
      inherited tlbarFiglio: TToolBar
        Width = 750
        ExplicitWidth = 750
      end
    end
  end
  inherited MainMenu1: TMainMenu
    Left = 536
    Top = 65530
  end
  inherited DButton: TDataSource
    Left = 500
    Top = 65530
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 576
    Top = 65530
  end
  inherited ImageList1: TImageList
    Left = 644
    Top = 65530
  end
  inherited ActionList1: TActionList
    Left = 608
    Top = 65530
    object actImpostaScriptDefault: TAction
      Caption = 'Script di default'
      OnExecute = actImpostaScriptDefaultExecute
    end
  end
  object pmnLivelli: TPopupMenu
    OnPopup = pmnLivelliPopup
    Left = 360
    Top = 368
    object mnuImpostaScriptDefault: TMenuItem
      Action = actImpostaScriptDefault
    end
  end
end
