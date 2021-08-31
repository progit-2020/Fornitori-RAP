inherited A023FCaricaTimbRich: TA023FCaricaTimbRich
  Left = 304
  Top = 307
  HelpContext = 4200
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = '<A023> Elaborazione omesse timbrature'
  ClientHeight = 576
  ClientWidth = 634
  ExplicitWidth = 650
  ExplicitHeight = 635
  PixelsPerInch = 96
  TextHeight = 13
  inherited StatusBar: TStatusBar
    Top = 558
    Width = 634
    ExplicitTop = 558
    ExplicitWidth = 634
  end
  inherited Panel1: TToolBar
    Width = 634
    ExplicitWidth = 634
  end
  object Panel2: TPanel [2]
    Left = 0
    Top = 29
    Width = 634
    Height = 76
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnImporta: TBitBtn
      Left = 449
      Top = 45
      Width = 157
      Height = 25
      Caption = 'Elabora tutte le richieste'
      Glyph.Data = {
        36010000424D3601000000000000760000002800000012000000100000000100
        040000000000C0000000130B0000130B00001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFF0F
        FFFFFFFFEFFFFFFFFFFFFF90FFFFFFFFFFFFFFFFFFFFFF990FFFFFFFEFFF0000
        0099999990FFFFFFFFFF0FFFF0999999990FFFFFEFFF0FFFF09999999990FFFF
        FFFF0F00F0999999990FFFFFEFFF0FFFF099999990FFFFFFFFFF0F00FFFFF099
        0FFFFFFFEFFF0FFFFFFFF090FFFFFFFFFFFF0F00F000000FFFFFFFFFEFFF0FFF
        F0FF0FFFFFFFFFFFFFFF0F08F0F0FFFFFFFFFFFFEFFF0FFFF00FFFFFFFFFFFFF
        FFFF000000FFFFFFFFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 3
      OnClick = btnImportaClick
    end
    object btnVisualizzaLog: TBitBtn
      Left = 449
      Top = 11
      Width = 157
      Height = 25
      Caption = 'Visualizza log'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000C0C0C0C0C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0
        C0C0C0C0C0C0C000FFFFC0C0C000FFFF00FFFFC0C0C07F7F7F7F7F7F7F7F7F00
        FFFF00FFFF7F7F7F7F7F7F7F7F7F7F7F7F00FFFF00FFFFC0C0C0C0C0C0C0C0C0
        00FFFF0000000000000000000000000000000000000000000000000000000000
        0000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000FFFFFF0000007F7F7FC0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        007F7F7FC0C0C0C0C0C000FFFF00FFFF00FFFF000000FFFFFF00000000000000
        0000000000FFFFFF000000FFFFFF00000000FFFF00FFFFC0C0C0C0C0C000FFFF
        00FFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        0000FFFF00FFFF00FFFFC0C0C0C0C0C0C0C0C0000000FFFFFF000000000000FF
        FFFF000000000000000000000000000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF000000C0C0
        C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0000000FFFFFF000000BFBFBFFF
        FFFF000000FFFFFF00000000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
        C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFF000000000000C0C0C000FFFF00FF
        FFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF00000000000000000000000000
        0000000000C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C000FFFF
        00FFFFC0C0C0C0C0C0C0C0C0C0C0C000FFFF00FFFFC0C0C0C0C0C0C0C0C0C0C0
        C000FFFF00FFFFC0C0C000FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000
        FFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000FFFF}
      TabOrder = 2
      OnClick = btnVisualizzaLogClick
    end
    object rgpModalita: TRadioGroup
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 195
      Height = 70
      Align = alLeft
      Caption = 'Modalit'#224' elaborazione'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'nuove richieste'
        'richieste elaborate con anomalie')
      ParentFont = False
      TabOrder = 0
      OnClick = rgpModalitaClick
    end
    object grpPeriodo: TGroupBox
      AlignWithMargins = True
      Left = 204
      Top = 3
      Width = 222
      Height = 70
      Align = alLeft
      Caption = 'Periodo richieste'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lblPeriodoDal: TLabel
        Left = 10
        Top = 32
        Width = 16
        Height = 13
        Caption = 'Dal'
      end
      object lblPeriodoAl: TLabel
        Left = 118
        Top = 32
        Width = 8
        Height = 13
        Caption = 'al'
        Transparent = False
      end
      object edtPeriodoDal: TMaskEdit
        Left = 40
        Top = 29
        Width = 67
        Height = 21
        EditMask = '!99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        Text = '  /  /    '
      end
      object edtPeriodoAl: TMaskEdit
        Left = 136
        Top = 29
        Width = 68
        Height = 21
        EditMask = '!99/99/9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 1
        Text = '  /  /    '
      end
    end
  end
  object dGrdAssenze: TDBGrid [3]
    Left = 0
    Top = 105
    Width = 634
    Height = 437
    Align = alClient
    DataSource = DButton
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlue
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ProgressBar1: TProgressBar [4]
    Left = 0
    Top = 542
    Width = 634
    Height = 16
    Align = alBottom
    TabOrder = 4
  end
  inherited MainMenu1: TMainMenu
    Left = 456
    Top = 2
  end
  inherited DButton: TDataSource
    Left = 484
    Top = 2
  end
  inherited PrinterSetupDialog1: TPrinterSetupDialog
    Left = 512
    Top = 2
  end
  inherited ImageList1: TImageList
    Left = 540
    Top = 2
  end
  inherited ActionList1: TActionList
    Left = 568
    Top = 2
    inherited actInserisci: TAction
      Visible = False
    end
    inherited actModifica: TAction
      Visible = False
    end
    inherited actCancella: TAction
      Visible = False
    end
    inherited actConferma: TAction
      Visible = False
    end
    inherited actAnnulla: TAction
      Visible = False
    end
    inherited actStampa: TAction
      Visible = False
    end
    inherited actGomma: TAction
      Visible = False
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    Top = 184
    object Importatimbraturacorrente: TMenuItem
      Caption = 'Elabora richiesta selezionata'
      OnClick = btnImportaClick
    end
  end
end
