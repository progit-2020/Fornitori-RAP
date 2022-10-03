inherited A055FTurnazioni: TA055FTurnazioni
  Left = 56
  Top = 7
  HelpContext = 55000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A055> Turnazioni dei cicli'
  ClientHeight = 434
  ClientWidth = 540
  ExplicitWidth = 556
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 416
    Width = 540
    ExplicitTop = 416
    ExplicitWidth = 540
  end
  inherited Panel1: TToolBar
    Width = 540
    ExplicitWidth = 540
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 540
    Height = 64
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 4
      Top = 4
      Width = 33
      Height = 13
      Caption = 'Codice'
      Color = clBtnFace
      FocusControl = DBEdit1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Label2: TLabel
      Left = 52
      Top = 4
      Width = 55
      Height = 13
      Caption = 'Descrizione'
      Color = clBtnFace
      FocusControl = DBEdit2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 4
      Top = 18
      Width = 45
      Height = 21
      DataField = 'CODICE'
      DataSource = DButton
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 52
      Top = 18
      Width = 244
      Height = 21
      DataField = 'DESCRIZIONE'
      DataSource = DButton
      TabOrder = 1
    end
    object BModifica: TBitBtn
      Left = 4
      Top = 41
      Width = 113
      Height = 21
      Caption = 'Modifica cicli'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = BModificaClick
    end
    object BConferma: TBitBtn
      Left = 118
      Top = 41
      Width = 75
      Height = 21
      Caption = 'Conferma'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BConfermaClick
    end
    object BAnnulla: TBitBtn
      Left = 194
      Top = 41
      Width = 75
      Height = 21
      Caption = 'Annulla'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BAnnullaClick
    end
  end
  object DBGrid1: TDBGrid [3]
    Left = 0
    Top = 93
    Width = 540
    Height = 323
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clRed
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = DBGrid1EditButtonClick
    Columns = <
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'ORDINE'
        ReadOnly = True
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'CICLO1'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'CICLO2'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'CICLO3'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'CICLO4'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'CICLO5'
        PopupMenu = PopupMenu1
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MULTIPLO'
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu
    Left = 392
  end
  inherited DButton: TDataSource
    OnDataChange = DButtonDataChange
    Left = 420
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 448
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 112
    object Nuovoelemento1: TMenuItem
      Caption = 'Accedi'
      OnClick = Nuovoelemento1Click
    end
  end
end
