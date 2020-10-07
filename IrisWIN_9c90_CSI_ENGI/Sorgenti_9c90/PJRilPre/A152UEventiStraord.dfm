inherited A152FEventiStraord: TA152FEventiStraord
  HelpContext = 152000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A152> Eventi straordinari'
  ClientHeight = 496
  ClientWidth = 873
  ExplicitWidth = 889
  ExplicitHeight = 554
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 478
    Width = 873
    ExplicitTop = 478
    ExplicitWidth = 873
  end
  inherited grbDecorrenza: TGroupBox
    Width = 873
    ExplicitWidth = 873
  end
  inherited ToolBar1: TToolBar
    Width = 873
    ExplicitWidth = 873
  end
  inline frmToolbarFiglio: TfrmToolbarFiglio [3]
    Left = 0
    Top = 307
    Width = 873
    Height = 22
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitTop = 307
    ExplicitWidth = 873
    ExplicitHeight = 22
    inherited tlbarFiglio: TToolBar
      Width = 873
      ExplicitWidth = 873
    end
  end
  object dgrdT722: TDBGrid [4]
    Left = 0
    Top = 63
    Width = 873
    Height = 244
    Align = alTop
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object dgrdT723: TDBGrid [5]
    Left = 0
    Top = 329
    Width = 873
    Height = 149
    Align = alClient
    DataSource = A152FEventiStraordDtM.dsrT723
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dgrdT723EditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODGRUPPO'
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
        FieldName = 'FILTRO_ANAGRAFE'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ORE'
        Width = 64
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu [6]
  end
  inherited DButton: TDataSource [7]
    AutoEdit = True
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [8]
  end
  inherited ImageList1: TImageList [9]
  end
end
