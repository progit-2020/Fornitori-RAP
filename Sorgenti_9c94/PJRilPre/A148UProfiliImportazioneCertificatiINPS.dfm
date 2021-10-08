inherited A148FProfiliImportazioneCertificatiINPS: TA148FProfiliImportazioneCertificatiINPS
  HelpContext = 148000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A148> Profili importazione certificati INPS'
  ClientWidth = 1229
  ExplicitWidth = 1245
  ExplicitHeight = 492
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Width = 1229
    ExplicitWidth = 1229
  end
  inherited Panel1: TToolBar
    Width = 1229
    ExplicitWidth = 1229
  end
  object dGridProfili: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 1229
    Height = 386
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnEditButtonClick = dGridProfiliEditButtonClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CODICE'
        Width = 64
        Visible = True
      end
      item
        ButtonStyle = cbsEllipsis
        Expanded = False
        FieldName = 'FILTRO'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCProvvisoria'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCInserimento'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCRicovero'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCPostRicovero'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCSalvaVita'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCGravidanza'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCPatGravi'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dCServizio'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'POSTRICOVERO_AUTO'
        PickList.Strings = (
          'S'
          'N')
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SCausaMalattia'
        Width = 64
        Visible = True
      end>
  end
  inherited DButton: TDataSource
    DataSet = A148FProfiliImportazioneCertificatiINPSDtm.selT269
  end
end
