inherited A153FPartecipEventiStraord: TA153FPartecipEventiStraord
  HelpContext = 153000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A153> Partecipazione eventi straordinari'
  ClientWidth = 667
  ExplicitWidth = 683
  ExplicitHeight = 491
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Width = 667
    ExplicitWidth = 667
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 667
    Height = 24
    ExplicitTop = 24
    ExplicitWidth = 667
    ExplicitHeight = 24
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [2]
    Left = 0
    Top = 0
    Width = 667
    Height = 24
    Align = alTop
    TabOrder = 2
    TabStop = True
    ExplicitWidth = 667
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 667
      Height = 24
      ExplicitWidth = 667
      ExplicitHeight = 24
    end
  end
  object dgrdPartEvStr: TDBGrid [3]
    Left = 0
    Top = 48
    Width = 667
    Height = 367
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dgrdPartEvStrEditButtonClick
    Columns = <
      item
        Color = cl3DLight
        Expanded = False
        FieldName = 'ID'
        ReadOnly = True
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'D_CODICE'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'D_DESCRIZIONE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DAL'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AL'
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'SERVIZI'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DELEGATO'
        PickList.Strings = (
          'S'
          'N')
        Visible = True
      end
      item
        DropDownRows = 3
        Expanded = False
        FieldName = 'D_TIPO_LAVORO'
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu [4]
  end
  inherited DButton: TDataSource [5]
    AutoEdit = True
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [6]
  end
  inherited ImageList1: TImageList [7]
  end
end
