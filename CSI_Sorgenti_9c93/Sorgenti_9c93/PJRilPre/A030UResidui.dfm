inherited A030FResidui: TA030FResidui
  Left = 252
  Top = 129
  HelpContext = 30000
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '<A030> Residui anno precedente'
  ClientHeight = 284
  ClientWidth = 569
  ExplicitWidth = 585
  ExplicitHeight = 342
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 266
    Width = 569
    ExplicitTop = 266
    ExplicitWidth = 569
  end
  inherited Panel1: TToolBar
    Top = 24
    Width = 569
    ExplicitTop = 24
    ExplicitWidth = 569
  end
  object TabControl1: TTabControl [2]
    Left = 0
    Top = 53
    Width = 569
    Height = 213
    Align = alClient
    MultiLine = True
    TabOrder = 2
    Tabs.Strings = (
      'Residui orari'
      'Residui presenze'
      'Residui assenze'
      'Residui buoni/ticket'
      'Residuo crediti formativi')
    TabIndex = 0
    OnChange = PageControl1Change
    OnChanging = PageControl1Changing
    object DBGrid2: TDBGrid
      Left = 4
      Top = 24
      Width = 561
      Height = 185
      Align = alClient
      DataSource = DButton
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  inline frmSelAnagrafe: TfrmSelAnagrafe [3]
    Left = 0
    Top = 0
    Width = 569
    Height = 24
    Align = alTop
    TabOrder = 3
    TabStop = True
    ExplicitWidth = 569
    ExplicitHeight = 24
    inherited pnlSelAnagrafe: TPanel
      Width = 569
      Height = 24
      ExplicitWidth = 569
      ExplicitHeight = 24
      inherited btnSelezione: TBitBtn
        OnClick = frmSelAnagrafebtnSelezioneClick
      end
    end
    inherited pmnuDatiAnagrafici: TPopupMenu
      inherited R003Datianagrafici: TMenuItem
        OnClick = frmSelAnagrafeR003DatianagraficiClick
      end
    end
  end
  inherited MainMenu1: TMainMenu [4]
    Left = 390
    Top = 36
  end
  inherited DButton: TDataSource [5]
    Left = 418
    Top = 36
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog [6]
    Left = 446
    Top = 36
  end
  inherited ImageList1: TImageList [7]
  end
end
