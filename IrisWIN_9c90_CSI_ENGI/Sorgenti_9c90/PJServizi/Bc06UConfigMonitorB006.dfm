inherited Bc06FConfigMonitorB006: TBc06FConfigMonitorB006
  HelpContext = 9906100
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<Bc06> Configurazione'
  ClientHeight = 399
  ClientWidth = 825
  ExplicitWidth = 841
  ExplicitHeight = 458
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 129
    Width = 825
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 86
  end
  inherited StatusBar: TStatusBar
    Top = 381
    Width = 825
    ExplicitTop = 381
    ExplicitWidth = 825
  end
  inherited Panel1: TToolBar
    Width = 825
    ExplicitWidth = 825
  end
  object pnlTabPadre: TPanel [3]
    Left = 0
    Top = 29
    Width = 825
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 825
      Height = 100
      Align = alClient
      DataSource = DButton
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
      OnEditButtonClick = DBGrid1EditButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'SERVIZIO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'INTERVALLO_MONITOR'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL_SMTP_HOST'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL_SMTP_PORT'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL_SMTP_USERNAME'
          Width = 120
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'D_EMAIL_SMTP_PASSWORD'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL_AUTH_TYPE'
          Visible = True
        end>
    end
  end
  inline frmToolbarFiglio: TfrmToolbarFiglio [4]
    Left = 0
    Top = 132
    Width = 825
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitTop = 132
    ExplicitWidth = 825
    ExplicitHeight = 24
    inherited tlbarFiglio: TToolBar
      Width = 825
      Height = 24
      Align = alClient
      ExplicitWidth = 825
      ExplicitHeight = 24
      inherited btnTFCancella: TToolButton
        OnClick = frmToolbarFigliobtnTFCancellaClick
      end
    end
    inherited actlstToolbarFiglio: TActionList
      inherited actTFCopiaSu: TAction
        Visible = True
        OnExecute = frmToolbarFiglioactTFCopiaSuExecute
      end
      inherited actTFConferma: TAction
        OnExecute = frmToolbarFiglioactTFConfermaExecute
      end
    end
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 156
    Width = 825
    Height = 225
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 4
    object dgrdImpostazioni: TDBGrid
      Left = 1
      Top = 1
      Width = 823
      Height = 223
      Align = alClient
      DataSource = Bc06FMonitorB006DtM.dsrI191
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dgrdImpostazioniEditButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'DATABASE_NAME'
          Title.Caption = 'Database'
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
          FieldName = 'NO_MONITOR_DALLE'
          Title.Caption = 'Monitor spento dalle'
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
          FieldName = 'NO_MONITOR_ALLE'
          Title.Caption = 'Monitor spento alle'
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
          FieldName = 'MSG_ELABORAZIONI_GG'
          Title.Caption = 'Num gg dei msg elaborazione'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MSG_ELABORAZIONI_RIGHE'
          Title.Caption = 'Num righe dei msg elaborazioni'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL_MITTENTE'
          Title.Caption = 'Email mittente'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL_DESTINATARI'
          Title.Caption = 'Email destinatari'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EMAIL_DESTINATARI_CC'
          Title.Caption = 'Email destinatari CC'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 150
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'QUERY_SERVIZIO_CONNESSO'
          Title.Caption = 'Query connessione'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 250
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'QUERY_MSG1'
          Title.Caption = 'Query 1 messaggi delle elaborazioni'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 250
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'QUERY_MSG2'
          Title.Caption = 'Query 2 messaggi delle elaborazioni'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Width = 250
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'D_CONNESSIONE_PWD'
          Title.Caption = 'Password'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = []
          Visible = False
        end>
    end
  end
  inherited MainMenu1: TMainMenu [6]
    Left = 392
    Top = 65530
  end
  inherited DButton: TDataSource [7]
    DataSet = Bc06FMonitorB006DtM.selI190
    Left = 420
    Top = 65530
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [8]
    Left = 448
    Top = 65530
  end
  inherited ImageList1: TImageList [9]
    Left = 476
    Top = 65530
  end
  inherited ActionList1: TActionList
    Left = 504
    Top = 65530
    inherited actInserisci: TAction
      Enabled = False
      Visible = False
    end
    inherited actCancella: TAction
      Enabled = False
      Visible = False
    end
  end
end
