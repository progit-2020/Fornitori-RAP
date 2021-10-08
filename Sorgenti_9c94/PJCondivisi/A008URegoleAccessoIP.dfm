inherited A008FRegoleAccessoIP: TA008FRegoleAccessoIP
  Caption = '<A008> Regole accesso IP'
  ClientHeight = 242
  ClientWidth = 394
  ExplicitWidth = 410
  ExplicitHeight = 301
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 224
    Width = 394
    ExplicitTop = 224
    ExplicitWidth = 394
  end
  inherited Panel1: TToolBar
    Width = 394
    ExplicitWidth = 394
  end
  object dgrdRegole: TDBGrid [2]
    Left = 0
    Top = 29
    Width = 394
    Height = 195
    Align = alClient
    DataSource = DButton
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'IP'
        PickList.Strings = (
          'unknown')
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 130
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CONSENTITO'
        PickList.Strings = (
          'S'
          'N')
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 70
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IP_ESTERNO'
        PickList.Strings = (
          'S'
          'N')
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = []
        Width = 70
        Visible = True
      end>
  end
  inherited MainMenu1: TMainMenu
    Left = 384
    Top = 34
  end
  inherited DButton: TDataSource
    Left = 412
    Top = 34
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 440
    Top = 34
  end
  inherited ImageList1: TImageList
    Left = 468
    Top = 34
  end
  inherited ActionList1: TActionList
    Left = 496
    Top = 34
  end
end
